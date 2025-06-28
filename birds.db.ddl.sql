-- --------------------------------------
CREATE TABLE heard (
	startSecond FLOAT NOT NULL,
	endSecond FLOAT NOT NULL,
	scientificName TEXT NOT NULL,
	commonName TEXT NOT NULL,
	confidence FLOAT NOT NULL,
	minuteOfDay DATETIME NOT NULL
	);
-- --------------------------------------
CREATE TABLE chart (
	name TEXT NOT NULL,
	xml TEXT NOT NULL,
	grouper TEXT,
	seq INTEGER PRIMARY KEY
	);
-- --------------------------------------
CREATE TABLE sun (
	dawn DATETIME NOT NULL,
	up DATETIME NOT NULL,
	peak DATETIME NOT NULL,
	down DATETIME NOT NULL,
	dusk DATETIME NOT NULL,
	minuteOfDay DATETIME NOT NULL
	);
-- --------------------------------------
CREATE TABLE moon (
	phase TEXT NOT NULL,
	up DATETIME,
	peak DATETIME NOT NULL,
	down DATETIME,
	minuteOfDay DATETIME NOT NULL
	);
-- --------------------------------------
CREATE TABLE weather (
	condition TEXT NOT NULL,
	iconNumber INTEGER NOT NULL,
	temperature TEXT NOT NULL,
	humidity TEXT NOT NULL,
	wind TEXT NOT NULL,
	precipitation TEXT NOT NULL,
	pressure TEXT NOT NULL,
	minuteOfDay DATETIME NOT NULL
	);
-- --------------------------------------
CREATE TABLE season (
	phase TEXT NOT NULL,
	changeover DATETIME NOT NULL
	);
-- --------------------------------------
CREATE TABLE color (
	name TEXT NOT NULL,
	commonName TEXT NOT NULL
	);
-- --------------------------------------
-- Color Candidates
-- --------------------------------------
-- insert into color values ('Salmon',NULL);
-- insert into color values ('Red',NULL);
-- insert into color values ('FireBrick',NULL);
-- insert into color values ('Pink',NULL);
-- insert into color values ('DeepPink',NULL);
-- insert into color values ('Tomato',NULL);
-- insert into color values ('DarkOrange',NULL);
-- insert into color values ('Orange',NULL);
-- insert into color values ('Gold',NULL);
-- insert into color values ('PeachPuff',NULL);
-- insert into color values ('DarkKhaki',NULL);
-- insert into color values ('Violet',NULL);
-- insert into color values ('MediumPurple',NULL);
-- insert into color values ('DarkViolet',NULL);
-- insert into color values ('Lime',NULL);
-- insert into color values ('SeaGreen',NULL);
-- insert into color values ('Olive',NULL);
-- insert into color values ('MediumAquamarine',NULL);
-- insert into color values ('Teal',NULL);
-- insert into color values ('Cyan',NULL);
-- insert into color values ('Tan',NULL);
-- insert into color values ('Sienna',NULL);
-- insert into color values ('Maroon',NULL);
-- insert into color values ('LawnGreen',NULL);
-- insert into color values ('DarkMagenta',NULL);
-- insert into color values ('YellowGreen',NULL);
-- insert into color values ('PaleVioletRed',NULL);
-- insert into color values ('DarkCyan',NULL);
-- insert into color values ('Fuchsia',NULL);
-- insert into color values ('Moccasin',NULL);
-- insert into color values ('Yellow',NULL);
-- insert into color values ('DarkGoldenrod',NULL);
-- insert into color values ('BlueViolet',NULL);
-- insert into color values ('DarkOliveGreen',NULL);
-- --------------------------------------
