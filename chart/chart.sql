CREATE TABLE chart (
	name TEXT NOT NULL,
	xml TEXT NOT NULL,
	seq INTEGER NOT NULL
	);

.mode table
delete from chart;
select * from chart order by seq;

with param as (select 0.75 as confidence, '-24 hour' as timeframe)

insert into chart (name,xml,seq) values ('NIL','<hourly confidence="0.25">',0);
insert into chart (name,xml,seq)
select
	commonname,
	'<bird '||
	'commonName="'||commonname||'" '||
	'total="'||count(*)||'">',
	((ROW_NUMBER() OVER()) * 1000)
from
	heard
where
	confidence > 0.25
		and
	minuteofday > datetime('now','localtime','-24 hour')
group by
	commonname
;
insert into chart (name,xml,seq)
with parent as (select name, seq from chart)
select
	commonname,
	'<when '||
	'hour="'||strftime('%H',minuteofday)||'" '||
	'total="'||count(*)||'"/>' as xml,
	(cast(strftime('%H',minuteofday) as integer) + parent.seq) as hour
from
	heard,
	parent
where
	commonname = parent.name
		and
	confidence > 0.25
		and
	minuteofday > datetime('now','localtime','-24 hour')
group by
	commonname,
	hour
;
insert into chart (name,xml,seq)
select
	commonname,
	'</bird>',
	((ROW_NUMBER() OVER()) * 1000)+999
from
	heard
where
	confidence > 0.25
		and
	minuteofday > datetime('now','localtime','-24 hour')
group by
	commonname
;
insert into chart (name,xml,seq) values ('NIL','</hourly>',999999);



sqlite3 birds.db ".param set :confidence 0.75" ".param set :timeframe '-48 hours'" ".param set :index 1000" ".read chart.sql"