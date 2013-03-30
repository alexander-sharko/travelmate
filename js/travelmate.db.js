    //=== integrating DB ==================================================================================

    var deviceReady = false;
    model.dbReady = false;


    //-------------------------------------------------------------------------
    // HTML5 Database and Local Storage
    //-------------------------------------------------------------------------

    var settings;
    var getSettingsFlag;

    function initSettings(){
    	settings = localStorage;

    	if(settings === null){
    		jqmError('Cannot load settings');
			return;    		
    	}

    	getSettingsFlag = function(key){
    		// localStorage for many browsers support only string values type
    		// which makes the flags boolean cheks to be akward
    		// this function stripes this out

    		var item = settings.getItem(key);
    		return typeof item == 'string' ? JSON.parse(item) : item;
    	}

    	// !!!!!!!!!!!!!!!!!!!!! 
    	// leave uncommented to clean up the settings each code run for debug means
    	// settings.clear();

		if(settings.getItem("set")){
			console.log('default settings have been set before');			
			return;
		}
		
		//settings are not set. init...
		console.log('init settings');
		settings.setItem("first_run","true");
		settings.setItem("set","true");
    }

    var db;
    var db_categoryRequested;
    model.dbInfo = {
        name:"travelmatedb",
        version:"1.0",
        title:"Travelmate",
        size:2 * 1024 * 1024
    }

    function callDatabase() {
        db = openDatabase(model.dbInfo.name, model.dbInfo.version, model.dbInfo.title, model.dbInfo.size);
        if (db === null) {
            databaseOutput("Database could not be opened.");
            return;
        }
        databaseOutput("Database opened.");

    	console.log('first_run: '+ getSettingsFlag('first_run'));
    	if (getSettingsFlag('first_run')) {
        	db.transaction(populateDB,errorDB,successDB);
    	} else {
    		// db was prepopulated on the first app run - no need to re-populate it
    		successDB();
    	}

    };

    function executeSqlFromFile(transactionObject, fileURL){
        
        // loading sql script
        $.ajax({
            type:"GET",
            url:fileURL,
            async: false,
            dataType: "text",
            success: function(data){
                // parsing file onto single requests
                var queries = data.split('\n');
                for(var i=0;i<queries.length;i++)
                    if($.trim(queries[i]) != '')
                        //execute requests as separate transactions
                        transactionObject.executeSql(queries[i]);
            }
        });
    }

    function populateDB(tx) {

       console.log('prepopulating DB');

       executeSqlFromFile(tx,"sql/prepopulate.sql");     

       // fake travel and todos are prepopulating to db
       //##TODO remove the fake data pre-population 
       executeSqlFromFile(tx,"sql/fakedata.sql");     

	   settings.setItem('first_run', "false");
	}

	function DB_GetCountries(tx){
		db_categoryRequested = model.countries;
	    tx.executeSql("SELECT * FROM 'countries'", [], countriesQuerySuccess, errorDB);
	}

    // General query success callback/
    //
    function countriesQuerySuccess(tx, results) {
        var len = results.rows.length;
        console.log("countris retreived: " + len);
        model.countries.length = 0;
        for (var i=0; i<len; i++){
            model.countries.push(results.rows.item(i));
        }
        console.log(model.countries);
    }

	function DB_GetTravels(tx){
		tx.executeSql("SELECT t.id, t.title, t.subtitle, t.date_from, t.date_to, count(*) as td_all, count(case when td.done=1 then 1 else NULL end) as td_done, c1.title as cfrom, c2.title as cto from travels t LEFT JOIN todos td on td.id_travel = t.id LEFT JOIN countries c1 ON c1.id = t.country_from LEFT JOIN countries c2 ON c2.id = t.country_to GROUP by t.id", [], travelsQuerySuccess, errorDB);
	}

	// Travels request query success callback
    //
    function travelsQuerySuccess(tx, results){
    	var len = results.rows.length;
        console.log("Travels retreived: " + len);
        model.travels.length = 0;
        for (var i=0; i<len; i++){         
            // the saving the travels array index to the field that will be rendered further to HTML ID tag
            var travelObj = results.rows.item(i);
            travelObj.link_travelID = model.travels.length;
            // adding updated object to the travels list
            model.travels.push(travelObj);
        }
        console.log(model.travels);
        RenderTravels();
    }

	function DB_DeleteTravel(tx){
		tx.executeSql("DELETE FROM 'travels' WHERE ROWID = ?",[db.travelToDeleteID]
		,function(){
			console.log('travel was deleted');
		}
		,errorDB);
	}



	// Transaction error callback
    //
	function errorDB(err) {
	    jqmError("Error processing SQL: "+err.code+" "+err.message, 10000);
	}

	// error message emulating the jquery default one
	function jqmError(text, delay){
		// show error message
		$.mobile.showPageLoadingMsg( $.mobile.pageLoadErrorMessageTheme, text, true );

		// hide after delay
		if(!delay)delay = 1500;
		setTimeout( $.mobile.hidePageLoadingMsg, delay );
	}

	function successDB() {
	    model.dbReady = true;
	    db.transaction(DB_GetTravels,errorDB);
	    db.transaction(DB_GetCountries,errorDB);
	}

    var databaseOutput = function(s) {
        console.log(s);
    };
    
    $(document).bind('deviceready',function(){
    	initSettings();
    	callDatabase();
    });

	//=====================================================================================
