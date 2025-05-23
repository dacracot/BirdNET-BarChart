<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="text"/>
<!-- =========================================================================================== -->
	<xsl:template match="/">
		<xsl:apply-templates select="day/properties/data"/>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="data">
		<xsl:text>insert into moon (phase,up,peak,down,minuteOfDay) values ('</xsl:text>
		<xsl:value-of select="closestphase/phase"/> 
		<xsl:text>','</xsl:text>
		<xsl:apply-templates select="moondata/phen[.='Rise']/../time"/> 
		<xsl:text>','</xsl:text>
		<xsl:apply-templates select="moondata/phen[.='Upper Transit']/../time"/> 
		<xsl:text>','</xsl:text>
		<xsl:apply-templates select="moondata/phen[.='Set']/../time"/> 
		<xsl:text>',datetime('now','localtime'));
</xsl:text>
		<xsl:text>insert into sun (dawn,up,peak,down,dusk,minuteOfDay) values ('</xsl:text>
		<xsl:apply-templates select="sundata/phen[.='Begin Civil Twilight']/../time"/> 
		<xsl:text>','</xsl:text>
		<xsl:apply-templates select="sundata/phen[.='Rise']/../time"/> 
		<xsl:text>','</xsl:text>
		<xsl:apply-templates select="sundata/phen[.='Upper Transit']/../time"/> 
		<xsl:text>','</xsl:text>
		<xsl:apply-templates select="sundata/phen[.='Set']/../time"/> 
		<xsl:text>','</xsl:text>
		<xsl:apply-templates select="sundata/phen[.='End Civil Twilight']/../time"/> 
		<xsl:text>',datetime('now','localtime'));
</xsl:text>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="time">
		<xsl:value-of select="substring(.,1,(string-length(.)-4))"/>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>


