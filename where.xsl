<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="text"/>
<!-- =========================================================================================== -->
	<xsl:template match="/where">
		<xsl:value-of select="name"/><xsl:text>, </xsl:text><xsl:value-of select="state"/>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
