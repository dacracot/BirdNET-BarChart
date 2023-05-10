-- div prefix > prefix
-- low end of range > low
-- high end of range > high
-- year for samples > year
select '<div id="'||:prefix||'Log">';
--
select
        '<h2>From '||
        strftime('%d ',min(hourOfDay))||
        substr('JanFebMarAprMayJunJulAugSepOctNovDec', 1 + 3*strftime('%m', min(hourOfDay)), -3)||
        strftime(' %Y',min(hourOfDay))||
        ' until '||
        strftime('%d ', date('now','-1 day'))||
        substr('JanFebMarAprMayJunJulAugSepOctNovDec', 1 + 3*strftime('%m', date('now','-1 day')), -3)||
        strftime(' %Y', date('now','-1 day'))||
        '</h2>'
from heardSumByHour;
-- 
select '<hr/>';
select '<script>';
select '{';
-- ---------------------------------------------------------------------------------------
select
	'var bird'||((ROW_NUMBER() OVER ()))||' = '||PLOTLY
from
	(
	select
		json_object(
			'name',commonName,
			'x',json_group_array(WEEK),
			'y',json_group_array(0),
			'text',json_group_array(LABEL),
			'mode','markers',
			'marker',json_object(
				'opacity',0.3,
				'size',json_group_array(TOTAL_WEEK))
			) as PLOTLY
	from
		(
		select
			commonName,
			sum(howMany)||' during week '||strftime('%W',hourOfDay) as LABEL,
			CAST(strftime('%W',hourOfDay) AS INTEGER) as WEEK,
 			sum(howMany) as TOTAL_WEEK
		from
			heardSumByHour
		where
			strftime('%Y',hourOfDay) = cast(:year as text)
				and
			commonName in
				(
				select
					commonName
				from
					heardRaw
				group by
					commonName
				having
					count(commonName) between :low and :high
				)
		group by
			WEEK,
			commonName
		order by
			commonName
		)
	group by
		commonName
	);
select
	'var data = [';
select
	'bird'||((ROW_NUMBER() OVER ()))||','
from
	(
	select
		commonName
	from
		heardRaw
	group by
		commonName
	having
		count(commonName) between :low and :high
	);
select
	'];';
select
	'data.forEach(bird=>{var ndx=0;var sum=0;bird.marker.size.forEach(s=>{sum += s;bird.y[ndx]=sum;ndx++;})});';
select
	'var layout = {"title":{"text":"Bird Samples from '||:low||' to '||:high||' in '||:year||'"},"showlegend":true,"height":1600,"width":1600,"yaxis":{"title":{"text":"Samples"},"rangemode":"tozero"},"xaxis":{"title":{"text":"Week"},"tick0":"0","dtick":"1","rangemode":"tozero"}}'
	as LAYOUT;
select
	'function shower(gd){Plotly.restyle(gd,"visible",true)}'
	as SHOWERFUNCTION;
select
	'function hider(gd){Plotly.restyle(gd,"visible","legendonly")}'
	as HIDERFUNCTION;
select
	'var modeBar = {"modeBarButtonsToRemove":["select2d","lasso2d"],"modeBarButtonsToAdd":[{"name":"show","click":shower},{"name":"hide","click":hider}]}'
	as MODEBAR;
select
	'Plotly.newPlot('''||:prefix||'Log'', data, layout, modeBar);'
	as PLOT;
-- ---------------------------------------------------------------------------------------
select '}';
select '</script>';
