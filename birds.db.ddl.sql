-- --------------------------------------
-- bird observations
DROP TABLE IF EXISTS heard;
-- -----
DROP INDEX IF EXISTS heardCommonName;
DROP INDEX IF EXISTS heardMinuteOfDay;
-- -----
CREATE TABLE heard (
	startSecond FLOAT NOT NULL,
	endSecond FLOAT NOT NULL,
	scientificName TEXT NOT NULL,
	commonName TEXT NOT NULL,
	confidence FLOAT NOT NULL,
	minuteOfDay DATETIME NOT NULL
	);
-- -----
CREATE INDEX heardCommonName ON heard (
	commonName
	);
-- -----
CREATE INDEX heardMinuteOfDay ON heard (
	minuteOfDay
	);
-- --------------------------------------
-- solar snapshots
DROP TABLE IF EXISTS sun;
-- -----
CREATE TABLE sun (
	dawn DATETIME NOT NULL,
	up DATETIME NOT NULL,
	peak DATETIME NOT NULL,
	down DATETIME NOT NULL,
	dusk DATETIME NOT NULL,
	minuteOfDay DATETIME NOT NULL
	);
-- --------------------------------------
-- lunar snapshots
DROP TABLE IF EXISTS moon;
-- -----
CREATE TABLE moon (
	phase TEXT NOT NULL,
	up DATETIME,
	peak DATETIME NOT NULL,
	down DATETIME,
	minuteOfDay DATETIME NOT NULL
	);
-- --------------------------------------
-- weather snapshots
DROP TABLE IF EXISTS weather;
-- -----
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
-- seasonal timeframes
DROP TABLE IF EXISTS season;
-- -----
CREATE TABLE season (
	phase TEXT NOT NULL,
	changeover DATETIME NOT NULL
	);
-- --------------------------------------
-- Color Assignments
DROP TABLE IF EXISTS color;
-- -----
CREATE TABLE color (
	name TEXT NOT NULL,
	commonName TEXT NOT NULL
	);
-- --------------------------------------
-- Color Candidates
DROP TABLE IF EXISTS candidate;
-- -----
CREATE TABLE candidate (
	name TEXT NOT NULL
	);
-- --------------------------------------
INSERT INTO candidate VALUES ('Salmon');
INSERT INTO candidate VALUES ('Red');
INSERT INTO candidate VALUES ('FireBrick');
INSERT INTO candidate VALUES ('Pink');
INSERT INTO candidate VALUES ('DeepPink');
INSERT INTO candidate VALUES ('Tomato');
INSERT INTO candidate VALUES ('DarkOrange');
INSERT INTO candidate VALUES ('Orange');
INSERT INTO candidate VALUES ('Gold');
INSERT INTO candidate VALUES ('PeachPuff');
INSERT INTO candidate VALUES ('DarkKhaki');
INSERT INTO candidate VALUES ('Violet');
INSERT INTO candidate VALUES ('MediumPurple');
INSERT INTO candidate VALUES ('DarkViolet');
INSERT INTO candidate VALUES ('Lime');
INSERT INTO candidate VALUES ('SeaGreen');
INSERT INTO candidate VALUES ('Olive');
INSERT INTO candidate VALUES ('MediumAquamarine');
INSERT INTO candidate VALUES ('Teal');
INSERT INTO candidate VALUES ('Cyan');
INSERT INTO candidate VALUES ('Tan');
INSERT INTO candidate VALUES ('Sienna');
INSERT INTO candidate VALUES ('Maroon');
INSERT INTO candidate VALUES ('LawnGreen');
INSERT INTO candidate VALUES ('DarkMagenta');
INSERT INTO candidate VALUES ('YellowGreen');
INSERT INTO candidate VALUES ('PaleVioletRed');
INSERT INTO candidate VALUES ('DarkCyan');
INSERT INTO candidate VALUES ('Fuchsia');
INSERT INTO candidate VALUES ('Moccasin');
INSERT INTO candidate VALUES ('Yellow');
INSERT INTO candidate VALUES ('DarkGoldenrod');
INSERT INTO candidate VALUES ('BlueViolet');
INSERT INTO candidate VALUES ('DarkOliveGreen');
-- --------------------------------------
