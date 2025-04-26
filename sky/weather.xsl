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
		<xsl:text>insert into weather (condition,temperature,humidity,wind,precipitation,pressure,minuteOfDay) values ('</xsl:text>
		<xsl:value-of select="weather/@value"/>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="temperature/@value"/><xsl:text>°</xsl:text>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="humidity/@value"/><xsl:value-of select="humidity/@unit"/>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="wind/speed/@name"/><xsl:text> from the </xsl:text><xsl:value-of select="wind/direction/@name"/>
		<xsl:text>','</xsl:text>
		<xsl:if test="precipitation[@mode = 'no']">0 mm/hr</xsl:if>
		<xsl:if test="precipitation[@mode != 'no']"><xsl:value-of select="precipitation/@mode"/>ing at <xsl:value-of select="precipitation/@value"/> mm/hr</xsl:if>
		<xsl:text>','</xsl:text>
		<xsl:value-of select="pressure/@value"/><xsl:value-of select="pressure/@unit"/>
		<xsl:text>',datetime('now','localtime'));
</xsl:text>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>


