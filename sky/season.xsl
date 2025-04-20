<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="text"/>
<!-- =========================================================================================== -->
	<xsl:template match="/seasons">
		<xsl:apply-templates select="apiversion"/>
		<xsl:apply-templates select="data"/>
		<xsl:apply-templates select="dst"/>
		<xsl:apply-templates select="tz"/>
		<xsl:apply-templates select="year"/>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="data">
		<xsl:if test="not(phenom = 'Perihelion' or phenom = 'Aphelion')">
			<xsl:text>insert into season (phase, changeover) values ('</xsl:text>
			<xsl:value-of select="phenom"/> 
			<xsl:text>','</xsl:text>
			<xsl:value-of select="year"/>-<xsl:value-of select="format-number(month,'00')"/>-<xsl:value-of select="format-number(day,'00')"/>T<xsl:value-of select="substring(time,1,(string-length(time)-3))"/>
			<xsl:text>');
</xsl:text>
		</xsl:if>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="apiversion"></xsl:template>
	<xsl:template match="dst"></xsl:template>
	<xsl:template match="tz"></xsl:template>
	<xsl:template match="year"></xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
