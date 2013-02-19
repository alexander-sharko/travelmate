----
-- phpLiteAdmin database dump (http://phpliteadmin.googlecode.com)
-- phpLiteAdmin version: 1.9.3.3
-- Exported on Feb 19th, 2013, 02:32:02AM
-- Database file: .\travelmate
----
BEGIN TRANSACTION;

----
-- Table structure for countries
----
CREATE TABLE 'countries' ('id' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 'title' TEXT);

----
-- Data dump for countries, a total of 5 rows
----
INSERT INTO "countries" ("id","title") VALUES ('1','Ukraine');
INSERT INTO "countries" ("id","title") VALUES ('2','Ukraine');
INSERT INTO "countries" ("id","title") VALUES ('3',' USA');
INSERT INTO "countries" ("id","title") VALUES ('4','Canada');
INSERT INTO "countries" ("id","title") VALUES ('5','France');
COMMIT;
