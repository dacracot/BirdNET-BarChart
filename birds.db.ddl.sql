-- --------------------------------------
-- bird observations
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
CREATE TABLE moon (
	phase TEXT NOT NULL,
	up DATETIME,
	peak DATETIME NOT NULL,
	down DATETIME,
	minuteOfDay DATETIME NOT NULL
	);
-- --------------------------------------
-- weather snapshots
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
CREATE TABLE season (
	phase TEXT NOT NULL,
	changeover DATETIME NOT NULL
	);
-- --------------------------------------
-- Color Assignments
CREATE TABLE color (
	name TEXT NOT NULL,
	commonName TEXT NOT NULL
	);
-- --------------------------------------
-- Color Candidates
CREATE TABLE candidate (
	name TEXT NOT NULL
	);
-- --------------------------------------
insert into candidate values ('Salmon');
insert into candidate values ('Red');
insert into candidate values ('FireBrick');
insert into candidate values ('Pink');
insert into candidate values ('DeepPink');
insert into candidate values ('Tomato');
insert into candidate values ('DarkOrange');
insert into candidate values ('Orange');
insert into candidate values ('Gold');
insert into candidate values ('PeachPuff');
insert into candidate values ('DarkKhaki');
insert into candidate values ('Violet');
insert into candidate values ('MediumPurple');
insert into candidate values ('DarkViolet');
insert into candidate values ('Lime');
insert into candidate values ('SeaGreen');
insert into candidate values ('Olive');
insert into candidate values ('MediumAquamarine');
insert into candidate values ('Teal');
insert into candidate values ('Cyan');
insert into candidate values ('Tan');
insert into candidate values ('Sienna');
insert into candidate values ('Maroon');
insert into candidate values ('LawnGreen');
insert into candidate values ('DarkMagenta');
insert into candidate values ('YellowGreen');
insert into candidate values ('PaleVioletRed');
insert into candidate values ('DarkCyan');
insert into candidate values ('Fuchsia');
insert into candidate values ('Moccasin');
insert into candidate values ('Yellow');
insert into candidate values ('DarkGoldenrod');
insert into candidate values ('BlueViolet');
insert into candidate values ('DarkOliveGreen');
-- --------------------------------------
