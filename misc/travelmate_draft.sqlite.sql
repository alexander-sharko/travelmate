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

CREATE TABLE 'todos' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' TEXT, 'id_travel' INTEGER, 'id_parent' INTEGER, 'done' INTEGER DEFAULT 0)

INSERT INTO 'todos' ('id','title','id_travel',' id_parent','done') VALUES (NULL,'todo 2','1',NULL,'0')

CREATE TABLE 'travels' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' TEXT, 'subtitle' TEXT, 'country_from' INTEGER, 'country_to' INTEGER, 'date_from' TEXT, 'date_to' TEXT, 'id_user' INTEGER, 'id_step' INTEGER)

INSERT INTO 'travels' ('id','title','subtitle','country_from','country_to','date_from','date_to','id_user','id_step') VALUES (NULL,'Travel from DB 1','This was retreived from sqlite','1','2','2013-01-07','2013-01-14','0','1')

UPDATE 'travels' SET 'id'='2', 'title'='New Travel', 'subtitle'='This also was retreived from DB', 'country_from'='1', 'country_to'='2', 'date_from'='01.02.12', 'date_to'='05.02.13', 'id_user'=NULL, 'id_step'=NULL WHERE ROWID = 2

DELETE FROM 'travels' WHERE ROWID = 1

SELECT 'id','title','subtitle','date_from','date_to' FROM 'travels' 

SELECT t.title, c1.title as cfrom, c2.title as cto
from travels t
left join countries c1
on c1.id = t.country_from
left join countries c2
on c2.id = t.country_to


SELECT 
t.title, t.subtitle, t.date_from, t.date_to, 
c1.title as cfrom, c2.title as cto, 
COUNT(distinct td1.id) as td_all,
COUNT(distinct td2.id) as td_undone

FROM travels t

LEFT JOIN countries c1
ON c1.id = t.country_from
LEFT JOIN countries c2
ON c2.id = t.country_to

LEFT JOIN todos td1
ON t.id = td1.id_travel

LEFT JOIN todos td2
on td2.id_travel = t.id AND td2.done = 0


-------------------
SELECT t.id, t.title, t.subtitle, t.date_from, t.date_to, 
count(*) as td_all, 
count(
case when td.done=1
then 1 
else NULL
end) as td_done,
c1.title as cfrom, c2.title as cto

from travels t

LEFT JOIN todos td
on td.id_travel = t.id

LEFT JOIN countries c1
ON c1.id = t.country_from
LEFT JOIN countries c2
ON c2.id = t.country_to

GROUP by t.id

-------- minified -----
SELECT t.id, t.title, t.subtitle, t.date_from, t.date_to, count(*) as td_all, count(case when td.done=1 then 1 else NULL end) as td_done, c1.title as cfrom, c2.title as cto from travels t LEFT JOIN todos td on td.id_travel = t.id LEFT JOIN countries c1 ON c1.id = t.country_from LEFT JOIN countries c2 ON c2.id = t.country_to GROUP by t.id