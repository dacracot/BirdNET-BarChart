-- 900 = 15 minutes * 60 seconds each
-- 3600 = 1 hour * 60 minutes * 60 seconds each
-- 86,400 = 24 hour2 * 60 minutes * 60 seconds each 
--
-- datetime format must be YYYY-MM-DDTHH:MI:SS
--
SELECT
	DATETIME((STRFTIME('%S', heard) / @@INTERVAL@@) * @@INTERVAL@@, 'UNIXEPOCH') interval,
	name,
	COUNT(name)
FROM
	found
WHERE
	conf >= @@CONFIDENCE@@
AND
	heard BETWEEN @@STARTDATETIME@@ AND @@ENDDATETIME@@
GROUP BY
	interval, name;
