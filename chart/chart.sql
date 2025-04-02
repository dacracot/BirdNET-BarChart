insert into chart (name,xml) values ('NIL','<'||:timeUnit||' confidence="'||:confidence||'">');
insert into chart (name,xml)
select
	commonname,
	'<bird '||
	'commonName="'||commonname||'" '||
	'timeUnit="'||:timeUnit||'" '||
	'confidence="'||:confidence||'" '||
	'total="'||count(*)||'">'
from
	heard
where
	confidence > :confidence
		and
	minuteofday > datetime('now','localtime','-'||:timeRange||' '||:timeUnit)
group by
	commonname
;
insert into chart (name,xml,grouper)
with parent as (select name from chart)
select
	commonname,
	'<when '||
	:timeUnit||'="'||strftime('%H',minuteofday)||'" '||
	'total="'||count(*)||'"/>' as xml,
	strftime('%H',minuteofday) as grouper
from
	heard,
	parent
where
	commonname = parent.name
		and
	confidence > :confidence
		and
	minuteofday > datetime('now','localtime','-'||:timeRange||' '||:timeUnit)
group by
	commonname,
	grouper
;
insert into chart (name,xml)
select
	commonname,
	'</bird>'
from
	heard
where
	confidence > :confidence
		and
	minuteofday > datetime('now','localtime','-'||:timeRange||' '||:timeUnit)
group by
	commonname
;
insert into chart (name,xml) values ('NIL','</'||:timeUnit||'>');
