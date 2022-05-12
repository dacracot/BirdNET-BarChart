.mode csv
-- refresh the list of heard birds
DELETE FROM seen;
INSERT INTO seen (name) SELECT DISTINCT name FROM found;
-- birds from yesterday across time, include all birds for each timeframe even if zero
SELECT e.tick, count(f.name) "count"
FROM (select c.hour||' '||s.name "tick" from clock c, seen s) e
LEFT JOIN found f ON strftime('%H:00',f.heard)||' '||f.name = e.tick
AND strftime('%Y-%m-%d',f.heard) = DATE('now','-1 day') 
GROUP BY e.tick
ORDER BY 1,2;
.exit
