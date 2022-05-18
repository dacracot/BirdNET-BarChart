-- 900 = 15 minutes * 60 seconds each
-- 3600 = 1 hour * 60 minutes * 60 seconds each
-- 86,400 = 24 hour2 * 60 minutes * 60 seconds each 
--
-- datetime format must be YYYY-MM-DDTHH:MI:SS
--
SELECT
	DATETIME((STRFTIME('%S', minuteOfDay) / @@INTERVAL@@) * @@INTERVAL@@, 'UNIXEPOCH') interval,
	commonName,
	COUNT(commonName)
FROM
	heardRaw
WHERE
	conf >= @@CONFIDENCE@@
AND
	minuteOfDay BETWEEN @@STARTDATETIME@@ AND @@ENDDATETIME@@
GROUP BY
	interval, commonName;
