<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
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
			<td><xsl:value-of select="@averagePerDay"/></td>
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
			<xsl:attribute name="sortValue"><xsl:value-of select="@averagePerDay"/></xsl:attribute>
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
				<xsl:attribute name="width"><xsl:value-of select="(@averagePerDay*2)" /></xsl:attribute>
				<xsl:attribute name="height">18</xsl:attribute>
				<!-- bars are all fuchsia until post processed with javascript -->
				<xsl:attribute name="style">fill:fuchsia</xsl:attribute>
			</xsl:element>
			<xsl:element name="text">
				<xsl:attribute name="x"><xsl:value-of select="((@averagePerDay*2)+224)" /></xsl:attribute>
				<xsl:attribute name="y"><xsl:value-of select="(20+(10*position()))" /></xsl:attribute>
				<xsl:attribute name="font-size">12</xsl:attribute>
				<xsl:value-of select="@averagePerDay"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
