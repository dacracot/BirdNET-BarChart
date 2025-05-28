<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:param name="asOf"/>
	<xsl:param name="lat"/>
	<xsl:param name="lon"/>
<!-- =========================================================================================== -->
<!-- transform XML to HTML -->
	<xsl:template match="/extract">
		<html lang="en">
			<head>
				<meta charset="utf-8"/>
				<title>BirdNET-BarChart</title>
				<link rel="stylesheet" href="https://code.jquery.com/ui/1.14.1/themes/base/jquery-ui.css"/>
				<style>
					thead, tfoot {font-weight: bold;}
					th {cursor: pointer;}
					td.clickable {cursor: pointer;}
				</style>
			</head>
			<body style="font-family: Verdana, sans-serif;" bgcolor="LightGray">
				<!-- display timeframe and locale -->
				<h4>Bird song observations as of <xsl:value-of select="$asOf"/> from location <xsl:value-of select="$lat"/>, <xsl:value-of select="$lon"/>.</h4>
				<!-- structure lists for conversion to tabs by jQueryUI -->
				<div id="tabs">
					<ul>
						<li><a href="#tab-dial">dial</a></li>
						<li><a href="#tab-chart">barchart</a></li>
						<li><a href="#tab-table">table</a></li>
					</ul>
					<div id="tab-dial">
						<ul>
							<li><a href="#tab-dial-solar">solar cycle</a></li>
							<li><a href="#tab-dial-lunar">lunar cycle</a></li>
							<li><a href="#tab-dial-seasonal">seasonal cycle</a></li>
						</ul>
						<div id="tab-dial-solar">
							<h4>solar dial coming soon</h4>
						</div>
						<div id="tab-dial-lunar">
							<h4>lunar dial coming soon</h4>
						</div>
						<div id="tab-dial-seasonal">
							<h4>seasonal dial coming soon</h4>
						</div>
					</div>
					<div id="tab-chart">
						<ul>
							<li><a href="#tab-chart-solar">solar cycle</a></li>
<!-- 
							<li><a href="#tab-chart-week">last week</a></li>
 -->
							<li><a href="#tab-chart-lunar">lunar cycle</a></li>
							<li><a href="#tab-chart-seasonal">seasonal cycle</a></li>
						</ul>
						<div id="tab-chart-solar">
							<ul>
								<li><a href="#tab-chart-solar-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-chart-solar-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-chart-solar-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-chart-solar-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='solar cycle']" mode="chart"/>
							</div>
							<div id="tab-chart-solar-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='solar cycle']" mode="chart"/>
							</div>
							<div id="tab-chart-solar-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='solar cycle']" mode="chart"/>
							</div>
						</div>
<!-- 
						<div id="tab-chart-week">
							<ul>
								<li><a href="#tab-chart-week-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-chart-week-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-chart-week-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-chart-week-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last week']" mode="chart"/>
							</div>
							<div id="tab-chart-week-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last week']" mode="chart"/>
							</div>
							<div id="tab-chart-week-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last week']" mode="chart"/>
							</div>
						</div>
 -->
						<div id="tab-chart-lunar">
							<ul>
								<li><a href="#tab-chart-lunar-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-chart-lunar-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-chart-lunar-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-chart-lunar-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='lunar cycle']" mode="chart"/>
							</div>
							<div id="tab-chart-lunar-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='lunar cycle']" mode="chart"/>
							</div>
							<div id="tab-chart-lunar-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='lunar cycle']" mode="chart"/>
							</div>
						</div>
						<div id="tab-chart-seasonal">
							<ul>
								<li><a href="#tab-chart-seasonal-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-chart-seasonal-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-chart-seasonal-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-chart-seasonal-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='seasonal cycle']" mode="chart"/>
							</div>
							<div id="tab-chart-seasonal-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='seasonal cycle']" mode="chart"/>
							</div>
							<div id="tab-chart-seasonal-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='seasonal cycle']" mode="chart"/>
							</div>
						</div>
					</div>
					<div id="tab-table">
						<ul>
							<li><a href="#tab-table-solar">solar cycle</a></li>
<!-- 
							<li><a href="#tab-table-week">last week</a></li>
 -->
							<li><a href="#tab-table-lunar">lunar cycle</a></li>
							<li><a href="#tab-table-seasonal">seasonal cycle</a></li>
						</ul>
						<div id="tab-table-solar">
							<ul>
								<li><a href="#tab-table-solar-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-table-solar-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-table-solar-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-table-solar-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='solar cycle']" mode="table"/>
							</div>
							<div id="tab-table-solar-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='solar cycle']" mode="table"/>
							</div>
							<div id="tab-table-solar-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='solar cycle']" mode="table"/>
							</div>
						</div>
<!-- 
						<div id="tab-table-week">
							<ul>
								<li><a href="#tab-table-week-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-table-week-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-table-week-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-table-week-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last week']" mode="table"/>
							</div>
							<div id="tab-table-week-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last week']" mode="table"/>
							</div>
							<div id="tab-table-week-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last week']" mode="table"/>
							</div>
						</div>
 -->
						<div id="tab-table-lunar">
							<ul>
								<li><a href="#tab-table-lunar-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-table-lunar-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-table-lunar-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-table-lunar-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='lunar cycle']" mode="table"/>
							</div>
							<div id="tab-table-lunar-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='lunar cycle']" mode="table"/>
							</div>
							<div id="tab-table-lunar-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='lunar cycle']" mode="table"/>
							</div>
						</div>
						<div id="tab-table-seasonal">
							<ul>
								<li><a href="#tab-table-seasonal-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-table-seasonal-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-table-seasonal-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-table-seasonal-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='seasonal cycle']" mode="table"/>
							</div>
							<div id="tab-table-seasonal-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='seasonal cycle']" mode="table"/>
							</div>
							<div id="tab-table-seasonal-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='seasonal cycle']" mode="table"/>
							</div>
						</div>
					</div>
				</div>
			</body><xsl:text>
</xsl:text>
			<script src="https://code.jquery.com/jquery-3.7.1.js"></script><xsl:text>
</xsl:text>
			<script src="https://code.jquery.com/ui/1.14.1/jquery-ui.js"></script><xsl:text>
</xsl:text>
  			<script src="chart.js"></script><xsl:text>
</xsl:text>
		</html>
	</xsl:template>
<!-- =========================================================================================== -->
<!-- create table from a set -->
	<xsl:template match="set" mode="table">
		<table border="1">
			<thead>
				<tr>
					<th>Common Name</th>
					<th>Quantity of Songs</th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates mode="table"/>
			</tbody>
			<tfoot>
				<tr>
					<th>Common Name</th>
					<th>Quantity of Songs</th>
				</tr>
			</tfoot>
		</table>
	</xsl:template>
<!-- =========================================================================================== -->
<!-- create each table row from a set -->
	<xsl:template match="row" mode="table">
		<tr>
			<td class="clickable">
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
<!-- create a bar chart from a set -->
	<xsl:template match="set" mode="chart">
		<svg width="2400" height="2400">
			<xsl:apply-templates mode="chart"/>
		</svg>
	</xsl:template>
<!-- =========================================================================================== -->
<!-- create each bar with label and quantity -->
	<xsl:template match="row" mode="chart">
		<xsl:element name="g">
			<xsl:attribute name="id"><xsl:value-of select="@commonName"/></xsl:attribute>
			<xsl:attribute name="sortValue"><xsl:value-of select="@count"/></xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="href">https://www.allaboutbirds.org/guide/<xsl:value-of select="translate(@commonName,' ','_')"/></xsl:attribute>
				<xsl:attribute name="target">_blank</xsl:attribute>
				<xsl:element name="text">
					<xsl:attribute name="x">216</xsl:attribute>
					<xsl:attribute name="y"><xsl:value-of select="(20+(10*position()))" /></xsl:attribute>
					<xsl:attribute name="text-anchor">end</xsl:attribute>
					<xsl:attribute name="font-size">12</xsl:attribute>
					<xsl:value-of select="@commonName"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="rect">
				<xsl:attribute name="x">220</xsl:attribute>
				<xsl:attribute name="y"><xsl:value-of select="(7+(10*position()))" /></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="(@count*2)" /></xsl:attribute>
				<xsl:attribute name="height">18</xsl:attribute>
				<!-- bars are all fuchsia until post processed with javascript -->
				<xsl:attribute name="style">fill:fuchsia</xsl:attribute>
			</xsl:element>
			<xsl:element name="text">
				<xsl:attribute name="x"><xsl:value-of select="((@count*2)+224)" /></xsl:attribute>
				<xsl:attribute name="y"><xsl:value-of select="(20+(10*position()))" /></xsl:attribute>
				<xsl:attribute name="font-size">12</xsl:attribute>
				<xsl:value-of select="@count"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
