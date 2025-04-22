select '<?xml version="1.0" encoding="UTF-8"?>';
-- select '<?xml-stylesheet type="text/xsl" href="chart.xsl"?>';
select '<extract>';
-- --------------------------------------------------------------------------------------
-- hourly high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '-24 hour' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last day">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- hourly mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '-24 hour' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last day">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- hourly low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '-24 hour' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last day">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- day high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '-7 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last week">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- day mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '-7 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last week">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- day low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '-7 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last week">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- week high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '-30 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last month">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- week mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '-30 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last month">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- week low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '-30 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last month">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- month high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '-12 month' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last year">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- month mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '-12 month' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last year">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
-- month low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '-12 month' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last year">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'count="'||count(*)||'" '||
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
