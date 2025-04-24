# sky Directory

This is where scripts and support files for celestial data reside.

---

### Files:

* day.js
	* Temporal file holding server response in JSON.
* day.sql
	* Temporal file holding SQL for insertion to database.
* day.xml
	* Temporal file holding XML from jq translation from JSON.
* day.xsl
	* Transform code to convert XML to SQL.
* json2xml.jq
	* Script for jq to convert from JSON to XML.
* season.js
	* Temporal file holding server response in JSON.
* season.sql
	* Temporal file holding SQL for insertion to database.
* season.xsl
	* Transform code to convert XML to SQL.
* weather.sql
	* Temporal file holding SQL for insertion to database.
* weather.xml
	* Temporal file holding server response in XML.
* weather.xsl
	* Transform code to convert XML to SQL.


### Dependencies:

* [jq](https://jqlang.org)