<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
	<html lang="en">
		<head>
			<meta charset="utf-8"/>
			<title>BirdNET-Barchart</title>
		</head>
		<body style="font-family: Verdana, sans-serif;" bgcolor="LightGray">
			<div id="chart"></div>
			<table border="1">
				<xsl:for-each select="extract/row">
				<tr>
				<td><xsl:value-of select="@commonName"/></td>
				<td><xsl:value-of select="@confidence"/></td>
				<td><xsl:value-of select="@minuteOfDay"/></td>
				</tr>
				</xsl:for-each>
			</table>
		</body>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
		<script type="text/javascript" src="chart.js">></script>
	</html>
</xsl:template>

</xsl:stylesheet>