CREATE TABLE clock (hour text);

CREATE TABLE heardRaw (
	startSecond FLOAT NOT NULL,
	endSecond FLOAT NOT NULL,
	scientificName TEXT NOT NULL,
	commonName TEXT NOT NULL,
	confidence FLOAT NOT NULL,
	minuteOfDay DATETIME NOT NULL
);

CREATE TABLE heardSumByHour (
	hourOfDay DATETIME NOT NULL,
	commonName TEXT NOT NULL,
	howMany INTEGER NOT NULL
);

CREATE VIEW distinctSeen AS
	SELECT
		DISTINCT commonName
	FROM
		heardRaw
