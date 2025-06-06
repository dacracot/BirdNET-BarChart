<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:param name="asOf"/>
	<xsl:param name="locale"/>
	<xsl:include href="tabs.xsl"/>
<!-- =========================================================================================== -->
<!-- transform XML to HTML -->
	<xsl:template match="/">
		<html lang="en">
			<head>
				<meta charset="utf-8"/>
				<meta http-equiv="refresh" content="3600" />
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<meta name="apple-mobile-web-app-capable" content="yes" />
				<meta name="mobile-web-app-capable" content="yes" />
				<meta name="application-name" content="BirdNET-BarChart" />
				<meta name="apple-mobile-web-app-title" content="BirdNET-BarChart" />
				<title>BirdNET-BarChart</title>
				<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css"/>
				<link rel="stylesheet" href="birding.css"/>
			</head>
			<body>
				<!-- display timeframe and locale -->
				<table style="width:100%">
					<tr>
						<td style="text-align: left; vertical-align: text-top;"><img src="grfx/svg/bird.svg" alt="Sort By" width="36" height="36"/></td>
						<td style="text-align: left;"><h4>Bird song observations<br/>as of <xsl:value-of select="$asOf"/><br/>from <xsl:value-of select="$locale"/>.</h4></td>
						<td style="text-align: right; vertical-align: text-top;"><img src="grfx/svg/help.svg" alt="Sort By" width="24" height="24"/></td>
					</tr>
				</table>
				<!-- structure lists for conversion to tabs by jQueryUI -->
				<xsl:apply-templates select="extract"/>
    			<div id="popup" style="left: 0; top: 0"></div>
			</body><xsl:text>
</xsl:text>
			<script src="https://code.jquery.com/jquery-3.7.1.js"></script><xsl:text>
</xsl:text>
			<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script><xsl:text>
</xsl:text>
  			<script src="birding.js"></script><xsl:text>
</xsl:text>
		</html>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
