select '<dial>';
-- sun
select
	'<sun dawn="'||
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
	sun
order by
	minuteOfDay desc
limit
	1;
-- moon
select
	'<moon phase="'||
	phase||
	'" up="'||
	((24-(substr(up,1,2)+(substr(up,4,2)/60.0)))*-15)||
	'" peak="'||
	((24-(substr(peak,1,2)+(substr(peak,4,2)/60.0)))*-15)||
	'" down="'||
	((24-(substr(down,1,2)+(substr(down,4,2)/60.0)))*-15)||
	'" />' as moonXML
from
	moon
order by
	minuteOfDay desc
limit
	1;
-- weather
select
	'<weather condition="'||
	condition||
	'" temperature="'||
	temperature||
	'" humidity="'||
	humidity||
	'" wind="'||
	wind||
	'" precipitation="'||
	precipitation||
	'" pressure="'||
	pressure||
	'" dial="'||
	strftime('%H',minuteOfDay)||
	'" />' as weatherXML
from
	weather
where
	strftime('%H',minuteOfDay) in ('00','03','06','09','12','15','18','21')
order by
	minuteOfDay desc
limit
	8;
select '</dial>';

select '<dial>';
-- sun
select
	'<sun dawn="'||
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
	sun
order by
	minuteOfDay desc
limit
	1;
-- moon
select
	'<moon phase="'||
	phase||
	'" up="'||
	((24-(substr(up,1,2)+(substr(up,4,2)/60.0)))*-15)||
	'" peak="'||
	((24-(substr(peak,1,2)+(substr(peak,4,2)/60.0)))*-15)||
	'" down="'||
	((24-(substr(down,1,2)+(substr(down,4,2)/60.0)))*-15)||
	'" />' as moonXML
from
	moon
order by
	minuteOfDay desc
limit
	1;
-- weather
select
	'<weather condition="'||
	weather.condition||
	'" svg="'||
	ifnull(grfx.svg,'unknown.svg')||
	'" temperature="'||
	weather.temperature||
	'" humidity="'||
	weather.humidity||
	'" wind="'||
	weather.wind||
	'" precipitation="'||
	weather.precipitation||
	'" pressure="'||
	weather.pressure||
	'" dial="'||
	strftime('%H',weather.minuteOfDay)||
	'" />' as weatherXML
from
	weather
LEFT OUTER JOIN grfx 
    ON weather.condition = grfx.phrase
where
	strftime('%H',weather.minuteOfDay) in ('00','03','06','09','12','15','18','21')
order by
	weather.minuteOfDay desc
limit
	8;
select '</dial>';
