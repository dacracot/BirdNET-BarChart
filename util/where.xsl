<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="text"/>
<!-- =========================================================================================== -->
<!-- == XML from OpenStreetMaps == -->
<!-- =========================================================================================== -->
	<xsl:template match="/reversegeocode">
		<xsl:apply-templates/>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="result">
		<xsl:text></xsl:text>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="addressparts">
		<xsl:variable name="locale">
			<xsl:value-of select="*[name()='city' or name()='municipality']"/><xsl:text>, </xsl:text><xsl:value-of select="state"/><xsl:text>, </xsl:text><xsl:value-of select="country"/>
		</xsl:variable>
		<xsl:value-of select="normalize-space($locale)"/>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
