CREATE TABLE chart (
	name TEXT NOT NULL,
	xml TEXT NOT NULL,
	seq INTEGER NOT NULL
	);

.mode table
delete from chart;
select * from chart order by seq;


insert into chart (name,xml,seq) values ('NIL','<hourly confidence="0.25">',0); -- :confidence
insert into chart (name,xml,seq)
select
	commonname,
	'<bird '||
	'commonName="'||commonname||'" '||
	'total="'||count(*)||'">',
	((ROW_NUMBER() OVER()) * 1000) -- :index
from
	heard
where
	confidence > 0.25 -- :confidence
		and
	minuteofday > datetime('now','localtime','-24 hour') -- '-'||:timeRange||' '||:timeUnit
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
	confidence > 0.25 -- :confidence
		and
	minuteofday > datetime('now','localtime','-24 hour') -- '-'||:timeRange||' '||:timeUnit
group by
	commonname,
	hour
;
insert into chart (name,xml,seq)
select
	commonname,
	'</bird>',
	((ROW_NUMBER() OVER()) * 1000)+999 -- :index) + (:index - 1)
from
	heard
where
	confidence > 0.25 -- :confidence
		and
	minuteofday > datetime('now','localtime','-24 hour') -- '-'||:timeRange||' '||:timeUnit
group by
	commonname
;
insert into chart (name,xml,seq) values ('NIL','</hourly>',999999); -- ((:index * 10) - 1)



-- sqlite3 birds.db ".param set :confidence 0.75" ".param set :timeframe '-48 hours'" ".param set :index 1000" ".read chart.sql"
sqlite3 birds.db ".param set :confidence 0.75" ".param set :timeRange '48'" ".param set :timeUnit 'hour'" ".param set :index 1000" ".read chart.sql"

.param clear
select datetime('now','localtime','-16 hour');
.param set :timeRange 16
.param set :timeUnit 'hour'
select datetime('now','localtime','-'||:timeRange||' '||:timeUnit);

