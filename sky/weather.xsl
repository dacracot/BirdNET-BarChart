<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="text"/>
<!-- =========================================================================================== -->
	<xsl:template match="/">
		<xsl:apply-templates select="current"/>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="current">
		<xsl:text>insert into weather (condition,iconNumber,temperature,humidity,wind,precipitation,pressure,minuteOfDay) values ('</xsl:text>
		<xsl:value-of select="weather/@value"/>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="weather/@number"/>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="temperature/@value"/><xsl:text>°</xsl:text>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="humidity/@value"/><xsl:value-of select="humidity/@unit"/>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="wind/speed/@name"/><xsl:text> from the </xsl:text><xsl:value-of select="wind/direction/@name"/>
		<xsl:text>','</xsl:text>
		<xsl:apply-templates select="precipitation"/>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="pressure/@value"/><xsl:value-of select="pressure/@unit"/>
		<xsl:text>',datetime('now','localtime'));
</xsl:text>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="precipitation">
		<xsl:variable name="whatKind"><xsl:value-of select="@mode"/></xsl:variable>
		<!-- data given in mm/hr only and only if mode is rain or snow -->
		<xsl:choose>
			<xsl:when test="$whatKind = 'rain'"><xsl:variable name="inchPerHour"><xsl:value-of select="format-number(@value div 25.4, '0.00')"/></xsl:variable>raining at <xsl:value-of select="$inchPerHour"/> inches/hour</xsl:when>
			<xsl:when test="$whatKind = 'snow'"><xsl:variable name="inchPerHour"><xsl:value-of select="format-number(@value div 25.4, '0.00')"/></xsl:variable>snowing at <xsl:value-of select="$inchPerHour"/> inches/hour</xsl:when>
			<xsl:otherwise>none</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>