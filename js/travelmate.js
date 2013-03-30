	var model = {};
	model.travels = [];
	model.travelsLoaded = false;
	model.countries = [];
	model.travelID_selected = 0;

//--------------------------------------------------------------------

		function AddTravel(newTravelObj){
		//##TODO make real fuction of travel adding
		// current function will manipulate the travels global var 
		

		if(!newTravelObj){ console.log('AddTravel: no travel object passed'); return;}

		console.log(newTravelObj);
		if(!newTravelObj.date)
			newTravelObj.date = $.now().toString();
		if (!newTravelObj.brief)
			newTravelObj.brief = "it will be a great travel";
		

		model.travels.push(newTravelObj);
		//##TODO add the travel to DB

		RenderTravels();
	}

	function RenderTravels(){
		//render in the travels list
		//$.mobile.loading('hide');
		$('ul#travels-list').render(model.travels);
	}

	function DeleteTravel(travelToDelete){
		db.travelToDeleteID = model.travels[travelToDelete].id;
		db.transaction(DB_DeleteTravel,errorDB);
		//#TODO add the check of failed DB delete query and delete the travel from UI only after successful query

		model.travels.splice(travelToDelete,1);
		RenderTravels();
	}

	function RenderTravelPage(pageID){
		//##TODO integrate itenaries

		/*todos_total:"40",
			itenaries: [
				{intenary_title:"Itenary 1"},
				{intenary_title:"Itenary 2"},
				{intenary_title:"Itenary 44"},
				{intenary_title:"Itenary 50"},
				{intenary_title:"Itenary 60"}
			]
		};*/
		//#TODO add itenaries processing
		console.log("selected ID "+pageID+". travel selected:");
		console.log(model.travels[pageID]);
		$('#travelPage').render(model.travels[pageID]);
	}

	$('#main-page').live('pagebeforeshow', function(event){
		
		// add new travel on form submit
		$('#addTravelForm').submit(function(event){
			event.preventDefault();
			AddTravel($(this).toObject());
			$('#addTravelPopup').popup('close');
			return false;
		});

   		// set the travelID_selected for corresponding travel page rendering
   		$('a.openTravelPageLink').click(function(event){
			console.log('travel click catched');
			model.travelID_selected = parseInt($('> .link_travelID', this).text());

			//##TODO start corresponding travel info loading from DB
   		});

   		// link long touch event for deleting the travel from the list
   		$('a.openTravelPageLink').bind('taphold', function(){
   			if(confirm('Are you sure you want to deete the travel with all the details?')){
   				var travelToDelete = parseInt($('> .link_travelID', this).text());
   				DeleteTravel(travelToDelete);
   			}
   		});

	});
 	
	$('#travelPage').live('pagebeforeshow', function(event){
		console.log('travelDetailsPage init')
		if(!model.travelID_selected)model.travelID_selected = 0;
		RenderTravelPage(model.travelID_selected);
	});