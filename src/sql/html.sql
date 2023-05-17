select '<!DOCTYPE html>';
select '<html lang="en">';
select '<head>';
select '<meta charset="utf-8">';
select '</head>';
select '<body style="font-family: Verdana, sans-serif;" bgcolor="LightGray">';
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
select '<table style="font-size:150%;" border="2">';
select '<tr align="center"><th>Common Name</th><th>Sample Count</th><th>Percentage</th><th>Image</th></tr>';
-- 
PRAGMA temp_store = 2;
create temp table total (num float);
insert into total
	with summary as (
		select
			count(commonName) as perBird,
			commonName
		from
			heardRaw
		group by
			commonName
		having
			count(commonName) > 10
			)
		select
			sum(perBird)
		from
			summary;
-- 
select 
	'<tr><td>'||
	h.commonName||
	'</td><td align="center">'||
	count(h.commonName)||
	'</td><td align="center">'||
	printf("%.2f", (count(h.commonName)/t.num)*100.0 )||
	'%</td><td align="center"><img src="'||
	h.commonName||
	'.png" height="150"/></td></tr>'
from
	heardRaw h,
	total t
group by
	h.commonName
having
	count(h.commonName) > 10
order by
	count(h.commonName) desc;
-- 
select '</table>';
select '</body>';
select '<script type="text/javascript" src="./refresh.js"></script>';
select '</html>';
