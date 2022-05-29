<?xml version="1.0"?> 
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
<!-- =========================================================================================== -->
	<xsl:template match="/result">
		<select name="birds" id="birds" multiple="true">
			<option value="ALL">All Birds</option>
			<xsl:apply-templates select="row"/>
		</select>
	</xsl:template>
	<!-- ======================================================================================= -->
	<xsl:template match="row">
		<xsl:element name="option">
			<xsl:attribute name="value" select="commonName"/>
			<xsl:value-of select="commonName"/>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>