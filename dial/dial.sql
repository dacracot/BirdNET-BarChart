select
	'<sun symbol="'||
	unicode||
	'" dawn="'||
	((24-(substr(dawn,1,2)+(substr(dawn,4,2)/60.0)))*-15)||
	'" up="'||
	((24-(substr(up,1,2)+(substr(up,4,2)/60.0)))*-15)||
	'" peak="'||
	((24-(substr(peak,1,2)+(substr(peak,4,2)/60.0)))*-15)||
	'" down="'||
	((24-(substr(down,1,2)+(substr(down,4,2)/60.0)))*-15)||
	'" dusk="'||
	((24-(substr(dusk,1,2)+(substr(dusk,4,2)/60.0)))*-15)||
	'" />' as sunXML
from
	sun,
	symbol
where
	symbol.description = 'Sunny'
order by
	minuteOfDay desc
limit
	1;

select
	'<moon symbol="'||
	unicode||
	'" up="'||
	((24-(substr(up,1,2)+(substr(up,4,2)/60.0)))*-15)||
	'" peak="'||
	((24-(substr(peak,1,2)+(substr(peak,4,2)/60.0)))*-15)||
	'" down="'||
	((24-(substr(down,1,2)+(substr(down,4,2)/60.0)))*-15)||
	'" />' as moonXML
from
	moon,
	symbol
where
	moon.phase = symbol.description
order by
	minuteOfDay desc
limit
	1;
