<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
<!-- 
	<xsl:output method="html" indent="yes"/>
 -->
<!-- =========================================================================================== -->
<!-- create table from a set -->
	<xsl:template match="set" mode="table">
		<table border="1">
			<thead>
				<tr>
					<th style="cursor: pointer; text-align: center;">Common Name<xsl:text>&#160;&#160;</xsl:text><img src="grfx/svg/sort.svg" alt="Sort By" width="12" height="12"/></th>
					<th style="cursor: pointer; text-align: center;">Songs per Day<xsl:text>&#160;&#160;</xsl:text><img src="grfx/svg/sort.svg" alt="Sort By" width="12" height="12"/></th>
				</tr>
			</thead>
			<tbody>
				<xsl:apply-templates mode="table"/>
			</tbody>
			<tfoot>
				<tr>
					<th style="text-align: center;">Common Name</th>
					<th style="text-align: center;">Songs per Day</th>
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
			<td>
				<xsl:choose>
					<xsl:when test="@averagePerDay = 0">
						<xsl:text>less than one</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@averagePerDay"/>
					</xsl:otherwise>
				</xsl:choose>
			</td>
		</tr>
	</xsl:template>
<!-- =========================================================================================== -->
<!-- create a bar chart from a set -->
	<xsl:template match="set" mode="chart">
		<table border="1" width="320px">
			<thead>
				<tr>
					<th align="center">Common Name<xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>Songs per Day</th>
				</tr>
			</thead>
			<tbody>
				<td align="left">
					<div style="max-height:600px; max-width:320px; margin: 0; padding: 0; overflow: auto;">
						<svg width="1200" height="1200">
							<xsl:apply-templates mode="chart"/>
						</svg>
					</div>
				</td>
			</tbody>
			<tfoot>
				<tr>
					<th align="center">Common Name<xsl:text>&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;</xsl:text>Songs per Day</th>
				</tr>
			</tfoot>
		</table>
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
<!-- 
This constant seems too far to the right, but I must have chosen it for a reason.
					<xsl:attribute name="x">216</xsl:attribute>
 -->
					<xsl:attribute name="x">160</xsl:attribute>
					<xsl:attribute name="y"><xsl:value-of select="(20+(5*position()))" /></xsl:attribute>
					<xsl:attribute name="text-anchor">end</xsl:attribute>
					<xsl:attribute name="font-size">9</xsl:attribute>
					<xsl:value-of select="@commonName"/>
				</xsl:element>
			</xsl:element>
			<xsl:element name="rect">
<!-- 
This constant seems too far to the right, but I must have chosen it for a reason.
				<xsl:attribute name="x">220</xsl:attribute>
 -->
				<xsl:attribute name="x">164</xsl:attribute>
				<xsl:attribute name="y"><xsl:value-of select="(16+(5*position()))" /></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="(@averagePerDay*2)" /></xsl:attribute>
				<xsl:attribute name="height">5</xsl:attribute>
				<!-- bars are all fuchsia until post processed with javascript -->
				<xsl:attribute name="style">fill:<xsl:value-of select="@assignedColor"/></xsl:attribute>
			</xsl:element>
			<xsl:element name="text">
<!-- 
This constant seems too far to the right, but I must have chosen it for a reason.
				<xsl:attribute name="x"><xsl:value-of select="((@averagePerDay*2)+224)" /></xsl:attribute>
 -->
				<xsl:attribute name="x"><xsl:value-of select="((@averagePerDay*2)+168)" /></xsl:attribute>
				<xsl:attribute name="y"><xsl:value-of select="(20+(5*position()))" /></xsl:attribute>
				<xsl:attribute name="font-size">9</xsl:attribute>
				<xsl:choose>
					<xsl:when test="@averagePerDay = 0">
						<xsl:text>less than one</xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="@averagePerDay"/>
					</xsl:otherwise>
				</xsl:choose>
<!-- 				<xsl:value-of select="@averagePerDay"/> -->
			</xsl:element>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
