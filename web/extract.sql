select '<?xml version="1.0" encoding="UTF-8"?>';
-- select '<?xml-stylesheet type="text/xsl" href="chart.xsl"?>';
select '<extract>';
-- --------------------------------------------------------------------------------------
-- solar high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '-24 hour' as timeframe, 1 as divisor)
select
	'<set confidence="'||param.confidence||'" timeframe="solar cycle">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'averagePerDay="'||(count(*)/param.divisor)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now','localtime',param.timeframe)
group by
	commonname
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- solar mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '-24 hour' as timeframe, 1 as divisor)
select
	'<set confidence="'||param.confidence||'" timeframe="solar cycle">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'averagePerDay="'||(count(*)/param.divisor)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now','localtime',param.timeframe)
group by
	commonname
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- solar low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '-24 hour' as timeframe, 1 as divisor)
select
	'<set confidence="'||param.confidence||'" timeframe="solar cycle">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'averagePerDay="'||(count(*)/param.divisor)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now','localtime',param.timeframe)
group by
	commonname
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- lunar high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '-30 day' as timeframe, 30 as divisor)
select
	'<set confidence="'||param.confidence||'" timeframe="lunar cycle">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'averagePerDay="'||(count(*)/param.divisor)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now','localtime',param.timeframe)
group by
	commonname
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- lunar mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '-30 day' as timeframe, 30 as divisor)
select
	'<set confidence="'||param.confidence||'" timeframe="lunar cycle">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'averagePerDay="'||(count(*)/param.divisor)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now','localtime',param.timeframe)
group by
	commonname
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- lunar low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '-30 day' as timeframe, 30 as divisor)
select
	'<set confidence="'||param.confidence||'" timeframe="lunar cycle">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'averagePerDay="'||(count(*)/param.divisor)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now','localtime',param.timeframe)
group by
	commonname
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- seasonal high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '-12 month' as timeframe, 30 as divisor)
select
	'<set confidence="'||param.confidence||'" timeframe="seasonal cycle">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'averagePerDay="'||(count(*)/param.divisor)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now','localtime',param.timeframe)
group by
	commonname
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- seasonal mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '-12 month' as timeframe, 30 as divisor)
select
	'<set confidence="'||param.confidence||'" timeframe="seasonal cycle">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'averagePerDay="'||(count(*)/param.divisor)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now','localtime',param.timeframe)
group by
	commonname
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- seasonal low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '-12 month' as timeframe, 365 as divisor)
select
	'<set confidence="'||param.confidence||'" timeframe="seasonal cycle">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'averagePerDay="'||(count(*)/param.divisor)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now','localtime',param.timeframe)
group by
	commonname
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
select '<dial>';
-- sun
select
	'<sun dawn="'||
	((24-(substr(dawn,1,2)+(substr(dawn,4,2)/60.0)))*-15)||
	'" dawnTime="'||dawn||
	'" up="'||
	((24-(substr(up,1,2)+(substr(up,4,2)/60.0)))*-15)||
	'" upTime="'||up||
	'" peak="'||
	((24-(substr(peak,1,2)+(substr(peak,4,2)/60.0)))*-15)||
	'" peakTime="'||peak||
	'" down="'||
	((24-(substr(down,1,2)+(substr(down,4,2)/60.0)))*-15)||
	'" downTime="'||down||
	'" dusk="'||
	((24-(substr(dusk,1,2)+(substr(dusk,4,2)/60.0)))*-15)||
	'" duskTime="'||dusk||
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
	'" upTime="'||up||
	'" peak="'||
	((24-(substr(peak,1,2)+(substr(peak,4,2)/60.0)))*-15)||
	'" peakTime="'||peak||
	'" down="'||
	((24-(substr(down,1,2)+(substr(down,4,2)/60.0)))*-15)||
	'" downTime="'||down||
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
	'" iconNumber="'||
	iconNumber||
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
	'" minuteOfDay="'||
	minuteOfDay||
	'" dial="'||
	strftime('%H',weather.minuteOfDay)||
	'" />' as weatherXML
from
	weather
where
	strftime('%H',weather.minuteOfDay) in ('00','03','06','09','12','15','18','21')
order by
	weather.minuteOfDay desc
limit
	8;
-- menu by confidence
select '<menu>';
select '<confidence above="0.9">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.9 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '<confidence above="0.8">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.8 and 0.9
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	except select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.9 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '<confidence above="0.7">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.7 and 0.8
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	except select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.8 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '<confidence above="0.6">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.6 and 0.7
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	except select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.7 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '<confidence above="0.5">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.5 and 0.6
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	except select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.6 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '<confidence above="0.4">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.4 and 0.5
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	except select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.5 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '<confidence above="0.3">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.3 and 0.4
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	except select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.4 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '<confidence above="0.2">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.2 and 0.3
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	except select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.3 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '<confidence above="0.1">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.1 and 0.2
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	except select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.2 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '<confidence above="0.0">';
select
	'<bird commonName="'||replace(bird,'''','`')||'"/>'
from
	(
	select
		distinct commonName as bird -- can not concat to a distinct value
	from
		heard
	where
		confidence between 0.0 and 0.1
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	except select
		distinct commonName as bird
	from
		heard
	where
		confidence between 0.1 and 1.0
			and
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
	)
order by 1;
select '</confidence>';
select '</menu>';
-- ------------------
select '<data>';
with dialData as (
	select
		cast(round(((24-(substr(minuteOfDay,12,2)+(substr(minuteOfDay,15,2)/60.0)))*-15),0) as integer) as dial,
		commonName,
		round(confidence,1) as confidenceRounded,
		strftime('%H:%M',minuteOfDay) as dialTime
	from
		heard
	where
		unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
			and
		commonName in (
			select
				distinct commonName as bird
			from
				heard
			where
				unixepoch(minuteOfDay) > (unixepoch('now','localtime')-(24*60*60))
			)
	)
	select
		'<heard quantity="'||
		count(dial)||'" dial="'||
		dial||'" commonName="'||
		replace(commonName,'''','`')||'" dialTime="'||
		dialTime||'" confidenceRounded="'||
		confidenceRounded||'" />'
	from
		dialData
	group by
		dial,
		commonName,
		confidenceRounded
	order by
		dial
;
select '</data>';
-- ------------------
select '</dial>';
-- ------------------
select '</extract>';
