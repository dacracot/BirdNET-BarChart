<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
<!-- =========================================================================================== -->
	<xsl:template match="/">
		<xsl:copy-of select="document('base.svg')/*"/>
	</xsl:template>
<!-- =========================================================================================== -->
<!-- =========================================================================================== -->
</xsl:stylesheet>