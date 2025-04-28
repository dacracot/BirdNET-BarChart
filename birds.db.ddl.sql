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
CREATE TABLE symbol (
	unicode TEXT NOT NULL,
	unicodeDecimal INTEGER NOT NULL,
	description TEXT NOT NULL
	);
INSERT INTO symbol VALUES('🌑︎',127761,'New Moon');
INSERT INTO symbol VALUES('🌒︎',127762,'Waxing Crescent');
INSERT INTO symbol VALUES('🌓︎',127763,'First Quarter');
INSERT INTO symbol VALUES('🌔︎',127764,'Waxing Gibbous');
INSERT INTO symbol VALUES('🌕︎',127765,'Full Moon');
INSERT INTO symbol VALUES('🌖︎',127766,'Waning Gibbous');
INSERT INTO symbol VALUES('🌗︎',127767,'Last Quarter');
INSERT INTO symbol VALUES('🌘︎',127768,'Waning Crescent');
INSERT INTO symbol VALUES('🌞',127774,'Sunny');
INSERT INTO symbol VALUES('🌤',127780,'Mostly Sunny');
INSERT INTO symbol VALUES('🌥',127781,'Mostly Cloudy');
INSERT INTO symbol VALUES('🌦',127782,'Showers');
INSERT INTO symbol VALUES('🌧',127783,'Showers');
INSERT INTO symbol VALUES('🌨',127784,'Snow');
INSERT INTO symbol VALUES('🌩',127785,'Thunderstorm');
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
