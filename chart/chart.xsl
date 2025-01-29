<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
<!-- =========================================================================================== -->
	<xsl:template match="/extract">
		<html lang="en">
			<head>
				<meta charset="utf-8"/>
				<title>BirdNET-Barchart</title>
				<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css"/>
			</head>
			<body style="font-family: Verdana, sans-serif;" bgcolor="LightGray">
				<div id="tabs">
					<ul>
						<li><a href="#tabs-1">last day</a></li>
						<li><a href="#tabs-2">last week</a></li>
						<li><a href="#tabs-3">last month</a></li>
						<li><a href="#tabs-4">last year</a></li>
					</ul>
					<div id="tabs-1">
						<ul>
							<li><a href="#tabs-1-1">high confidence (0.75)</a></li>
							<li><a href="#tabs-1-2">mid confidence (0.5)</a></li>
							<li><a href="#tabs-1-3">low confidence (0.1)</a></li>
						</ul>
						<div id="tabs-1-1">
							<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last 24 hours']"/>
						</div>
						<div id="tabs-1-2">
							<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last 24 hours']"/>
						</div>
						<div id="tabs-1-3">
							<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last 24 hours']"/>
						</div>
					</div>
					<div id="tabs-2">
						<ul>
							<li><a href="#tabs-2-1">high confidence (0.75)</a></li>
							<li><a href="#tabs-2-2">mid confidence (0.5)</a></li>
							<li><a href="#tabs-2-3">low confidence (0.1)</a></li>
						</ul>
						<div id="tabs-2-1">
							<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last 30 days']"/>
						</div>
						<div id="tabs-2-2">
							<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last 30 days']"/>
						</div>
						<div id="tabs-2-3">
							<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last 30 days']"/>
						</div>
					</div>
					<div id="tabs-3">
						<ul>
							<li><a href="#tabs-3-1">high confidence (0.75)</a></li>
							<li><a href="#tabs-3-2">mid confidence (0.5)</a></li>
							<li><a href="#tabs-3-3">low confidence (0.1)</a></li>
						</ul>
						<div id="tabs-3-1">
							<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last 26 weeks']"/>
						</div>
						<div id="tabs-3-2">
							<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last 26 weeks']"/>
						</div>
						<div id="tabs-3-3">
							<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last 26 weeks']"/>
						</div>
					</div>
					<div id="tabs-4">
						<ul>
							<li><a href="#tabs-4-1">high confidence (0.75)</a></li>
							<li><a href="#tabs-4-2">mid confidence (0.5)</a></li>
							<li><a href="#tabs-4-3">low confidence (0.1)</a></li>
						</ul>
						<div id="tabs-4-1">
							<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last 24 months']"/>
						</div>
						<div id="tabs-4-2">
							<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last 24 months']"/>
						</div>
						<div id="tabs-4-3">
							<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last 24 months']"/>
						</div>
					</div>
				</div>
			</body>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
			<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
			<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script>
  			<script src="chart.js">></script>
		</html>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="set">
		<table border="1">
			<xsl:apply-templates/>
		</table>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="row">
		<tr>
			<td>
				<xsl:element name="a">
					<xsl:attribute name="href">https://www.allaboutbirds.org/guide/<xsl:value-of select="translate(@commonName,' ','_')"/></xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					<xsl:value-of select="@commonName"/>
				</xsl:element>
			</td>
			<td><xsl:value-of select="@count"/></td>
		</tr>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
