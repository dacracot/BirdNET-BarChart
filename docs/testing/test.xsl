<?xml version="1.0"?> 
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" indent="yes"/>
<!-- =========================================================================================== -->
	<xsl:template match="/result">
		<html><body>
		<table border="1">
			<tr>
				<th>A</th>
				<th>B</th>
				<th>C</th>
			</tr>
			<xsl:apply-templates select="row"/>
		</table>
		</body></html>
	</xsl:template>
	<!-- ======================================================================================= -->
	<xsl:template match="row">
		<xsl:element name="tr">
			<td><xsl:value-of select="a"/></td>
			<td><xsl:value-of select="b"/></td>
			<td><xsl:value-of select="c"/></td>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
