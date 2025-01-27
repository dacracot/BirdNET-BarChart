select '<?xml version="1.0" encoding="UTF-8"?>';
select '<?xml-stylesheet type="text/xsl" href="chart.xsl"?>';
select '<extract>';
-- --------------------------------------------------------------------------------------
-- hourly high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '%Y-%m-%d-%H' as timeform, '-24 hour' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 24 hours">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- hourly mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '%Y-%m-%d-%H' as timeform, '-24 hour' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 24 hours">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- hourly low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '%Y-%m-%d-%H' as timeform, '-24 hour' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 24 hours">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- day high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '%Y-%m-%d' as timeform, '-30 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 30 days">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- day mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '%Y-%m-%d' as timeform, '-30 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 30 days">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- day low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '%Y-%m-%d' as timeform, '-30 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 30 days">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- week high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '%Y-%W' as timeform, '-182 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 26 weeks">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- week mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '%Y-%W' as timeform, '-182 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 26 weeks">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- week low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '%Y-%W' as timeform, '-182 day' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 26 weeks">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- month high
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.75 as confidence, '%Y-%m' as timeform, '-24 month' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 24 months">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- month mid
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.5 as confidence, '%Y-%m' as timeform, '-24 month' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 24 months">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
-- month low
-- --------------------------------------------------------------------------------------
select xml from (
with param as (select 0.1 as confidence, '%Y-%m' as timeform, '-24 month' as timeframe)
select
	'<set confidence="'||param.confidence||'" timeframe="last 24 months">' as xml,
	1 as rowOrder
from
	param
union select
	'<row '||
	'commonName="'||commonname||'" '||
	'dateTime="'||strftime(param.timeform,minuteofday)||'" '||
	'count="'||count(*)||'" '||
	'/>' as xml,
	2 as rowOrder
from
	heard, param
where
	heard.confidence > param.confidence
		and
	minuteofday > datetime('now',param.timeframe)
group by
	commonname,
	strftime(param.timeform,minuteofday)
union select
	'</set>' as xml,
	3 as rowOrder
order by rowOrder);
-- --------------------------------------------------------------------------------------
select '</extract>';
