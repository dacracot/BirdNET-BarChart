<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:param name="asOf"/>
	<xsl:param name="lat"/>
	<xsl:param name="lon"/>
	<xsl:include href="tabs.xsl"/>
<!-- =========================================================================================== -->
<!-- transform XML to HTML -->
	<xsl:template match="/">
		<html lang="en">
			<head>
				<meta charset="utf-8"/>
				<meta http-equiv="refresh" content="3600" />
				<meta name="viewport" content="width=device-width, initial-scale=1.3" />
				<meta name="apple-mobile-web-app-capable" content="yes" />
				<meta name="mobile-web-app-capable" content="yes" />
				<meta name="application-name" content="BirdNET-BarChart" />
				<meta name="apple-mobile-web-app-title" content="BirdNET-BarChart" />
				<title>BirdNET-BarChart</title>
				<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css"/>
				<link rel="stylesheet" href="dial.css"/>
				<style>
					body {
						font-family: Arial, Helvetica, sans-serif;
						font-size: 10px;
						}
					thead, tfoot {
						font-weight: bold;
						}
					th {
						cursor: pointer;
						}
					td.clickable {
						cursor: pointer;
						}
				</style>
			</head>
			<body style="font-family: Verdana, sans-serif;" bgcolor="LightGray">
				<!-- display timeframe and locale -->
				<h4>Bird song observations as of <xsl:value-of select="$asOf"/> from location <xsl:value-of select="$lat"/>, <xsl:value-of select="$lon"/>.</h4>
				<!-- structure lists for conversion to tabs by jQueryUI -->
				<xsl:apply-templates select="extract"/>
    			<div id="popup" style="left: 0; top: 0"></div>
			</body><xsl:text>
</xsl:text>
			<script src="https://code.jquery.com/jquery-3.7.1.js"></script><xsl:text>
</xsl:text>
			<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script><xsl:text>
</xsl:text>
  			<script src="chart.js"></script><xsl:text>
</xsl:text>
			<script src="dial.js"></script><xsl:text>
</xsl:text>
    		<div id="popup" style="left: 0; top: 0"></div>
		</html>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
