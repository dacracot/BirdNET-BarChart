<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
<!-- =========================================================================================== -->
	<xsl:template match="/dial">
		<xsl:element name="html">
			<xsl:element name="body">
			
<svg width="250" height="250" viewBox="-125 -125 250 250" xmlns="http://www.w3.org/2000/svg">
<circle cx="0" cy="0" r="90" fill="none" stroke="black" stroke-width="2"/>
<g stroke="black" stroke-width="1" font-family="Arial" font-size="10" text-anchor="middle">
			
				<xsl:apply-templates select="sun"/>
				<xsl:apply-templates select="moon"/>
				<xsl:copy-of select="document('base.svg')/base"/>

</g>
</svg>

			</xsl:element>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="sun">
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@dawn"/>)</xsl:attribute>
			<line x1="0" y1="105" x2="0" y2="70"/>
			<text x="0" y="105" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@up"/>)</xsl:attribute>
			<line x1="0" y1="105" x2="0" y2="70"/>
			<text x="0" y="105" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@peak"/>)</xsl:attribute>
			<line x1="0" y1="105" x2="0" y2="70"/>
			<text x="0" y="105" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@down"/>)</xsl:attribute>
			<line x1="0" y1="105" x2="0" y2="70"/>
			<text x="0" y="105" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@dusk"/>)</xsl:attribute>
			<line x1="0" y1="105" x2="0" y2="70"/>
			<text x="0" y="105" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="moon">
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@up"/>)</xsl:attribute>
			<line x1="0" y1="105" x2="0" y2="70"/>
			<text x="0" y="105" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@peak"/>)</xsl:attribute>
			<line x1="0" y1="105" x2="0" y2="70"/>
			<text x="0" y="105" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@down"/>)</xsl:attribute>
			<line x1="0" y1="105" x2="0" y2="70"/>
			<text x="0" y="105" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
