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
select '</extract>';
