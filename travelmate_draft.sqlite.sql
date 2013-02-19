CREATE TABLE 'countries' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' TEXT)

INSERT INTO 'countries' ('id','title') VALUES (NULL,'Ukraine')
INSERT INTO 'countries' ('id','title') VALUES (NULL,' USA')
INSERT INTO 'countries' ('id','title') VALUES (NULL,'Canada')
INSERT INTO 'countries' ('id','title') VALUES (NULL,'France')

CREATE TABLE 'steps' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' TEXT)

INSERT INTO 'steps' ('id','title') VALUES (NULL,'Plan')
INSERT INTO 'steps' ('id','title') VALUES (NULL,'Pack')
INSERT INTO 'steps' ('id','title') VALUES (NULL,'GO!')
INSERT INTO 'steps' ('id','title') VALUES (NULL,'Keep')

CREATE TABLE 'todos' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' TEXT, 'id_travel' INTEGER, ' id_parent' INTEGER)

CREATE TABLE 'travels' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' TEXT, 'subtitle' TEXT, 'country_from' INTEGER, 'country_to' INTEGER, 'date_from' TEXT, 'date_to' TEXT, 'id_user' INTEGER, 'id_step' INTEGER)

INSERT INTO 'travels' ('id','title','subtitle','country_from','country_to','date_from','date_to','id_user','id_step') VALUES (NULL,'Travel from DB 1','This was retreived from sqlite','1','2','2013-01-07','2013-01-14','0','1')
