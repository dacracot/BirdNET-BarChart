select '<?xml version="1.0" encoding="UTF-8"?>';
select '<?xml-stylesheet type="text/xsl" href="chart.xsl"?>';
select '<extract>';
select
	'<row '||
	'commonName="'||commonName||'" '||
	'confidence="'||confidence||'" '||
	'minuteOfDay="'||minuteOfDay||'" '||
	'/>'
from
	heard;
select '</extract>';
