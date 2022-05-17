/*------------------------------------------------------------------------*/
.mode csv
-- birds from yesterday across time, include all birds for each timeframe even if zero
SELECT
	e.tick,
	COUNT(hr.commonName) "count"
FROM
	(
	SELECT
		c.hour||' '||ds.commonName "tick"
	FROM
		clock c,
		distinctSeen ds
	) e
LEFT JOIN
	heardRaw hr
	ON strftime('%H:00',hr.minuteOfDay)||' '||hr.commonName = e.tick
	AND strftime('%Y-%m-%d',hr.minuteOfDay) = DATE('now','-1 day') 
GROUP BY
	e.tick
ORDER BY
	1,2;
.exit
/*------------------------------------------------------------------------*/
