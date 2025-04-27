select
	((24-(substr(dawn,1,2)+(substr(dawn,4,2)/60.0)))*-15) as dawnAngle,
	((24-(substr(up,1,2)+(substr(up,4,2)/60.0)))*-15) as upAngle,
	((24-(substr(peak,1,2)+(substr(peak,4,2)/60.0)))*-15) as peakAngle,
	((24-(substr(down,1,2)+(substr(down,4,2)/60.0)))*-15) as downAngle,
	((24-(substr(dusk,1,2)+(substr(dusk,4,2)/60.0)))*-15) as duskAngle
from
	sun
order by
	minuteOfDay desc
limit
	1;

select
	unicode,
	((24-(substr(up,1,2)+(substr(up,4,2)/60.0)))*-15) as upAngle,
	((24-(substr(peak,1,2)+(substr(peak,4,2)/60.0)))*-15) as peakAngle,
	((24-(substr(down,1,2)+(substr(down,4,2)/60.0)))*-15) as downAngle
from
	moon,
	phase
where
	moon.phase = phase.description
order by
	minuteOfDay desc
limit
	1;
