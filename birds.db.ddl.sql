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
CREATE TABLE moon (
	unicode TEXT NOT NULL,
	unicodeDecimal INTEGER NOT NULL,
	description TEXT NOT NULL
	);
INSERT INTO moon VALUES ('🌑︎', 127761, 'new');
INSERT INTO moon VALUES ('🌒︎', 127762, 'waxing crescent');
INSERT INTO moon VALUES ('🌓︎', 127763, 'first-quarter');
INSERT INTO moon VALUES ('🌔︎', 127764, 'waxing gibbous');
INSERT INTO moon VALUES ('🌕︎', 127765, 'full');
INSERT INTO moon VALUES ('🌖︎', 127766, 'waning gibbous');
INSERT INTO moon VALUES ('🌗︎', 127767, 'last-quarter');
INSERT INTO moon VALUES ('🌘︎', 127768, 'waning crescent');
-- --------------------------------------
CREATE TABLE sun (
	dawn DATETIME NOT NULL,
	up DATETIME NOT NULL,
	down DATETIME NOT NULL,
	dusk DATETIME NOT NULL,
	minuteOfDay DATETIME NOT NULL
	);
-- --------------------------------------
CREATE TABLE moon (
	phase TEXT NOT NULL,
	up DATETIME,
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
