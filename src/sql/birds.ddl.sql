/*------------------------------------------------------------------------*/
CREATE TABLE heardRaw (
	startSecond FLOAT NOT NULL,
	endSecond FLOAT NOT NULL,
	scientificName TEXT NOT NULL,
	commonName TEXT NOT NULL,
	confidence FLOAT NOT NULL,
	minuteOfDay DATETIME NOT NULL
);
/*------------------------------------------------------------------------*/
CREATE TABLE heardSumByHour (
	commonName TEXT NOT NULL,
	hourOfDay DATETIME NOT NULL,
	howMany INTEGER NOT NULL
);
/*------------------------------------------------------------------------*/
CREATE VIEW distinctSeen AS
	SELECT
		DISTINCT commonName
	FROM
		heardRaw;
/*------------------------------------------------------------------------*/
CREATE TABLE clock (
	hour TEXT NOT NULL
);
/*-------------------------------------*/
INSERT INTO clock VALUES
	('05:00'),
	('06:00'),
	('07:00'),
	('08:00'),
	('09:00'),
	('10:00'),
	('11:00'),
	('12:00'),
	('13:00'),
	('14:00'),
	('15:00'),
	('16:00'),
	('17:00'),
	('18:00'),
	('19:00'),
	('20:00');
/*------------------------------------------------------------------------*/
