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
			
				<xsl:apply-templates select="moon"/>
				<xsl:apply-templates select="sun"/>
				<xsl:copy-of select="document('base.svg')/base/*"/>

</g>
</svg>

			</xsl:element>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="sun">
		<xsl:call-template name="pie">
			<xsl:with-param name="beginLoop" select="xs:integer(round(@dawn + 1))" />
			<xsl:with-param name="endLoop" select="xs:integer(round(@up - 1))" />
			<xsl:with-param name="color">blue</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="pie">
			<xsl:with-param name="beginLoop" select="xs:integer(round(@up + 1))" />
			<xsl:with-param name="endLoop" select="xs:integer(round(@peak - 1))" />
			<xsl:with-param name="color">skyblue</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="pie">
			<xsl:with-param name="beginLoop" select="xs:integer(round(@peak + 1))" />
			<xsl:with-param name="endLoop" select="xs:integer(round(@down - 1))" />
			<xsl:with-param name="color">skyblue</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="pie">
			<xsl:with-param name="beginLoop" select="xs:integer(round(@down + 1))" />
			<xsl:with-param name="endLoop" select="xs:integer(round(@dusk - 1))" />
			<xsl:with-param name="color">blue</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="pie">
			<xsl:with-param name="beginLoop" select="xs:integer(round(@dusk + 1))" />
			<xsl:with-param name="endLoop">0</xsl:with-param>
			<xsl:with-param name="color">darkblue</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="pie">
			<xsl:with-param name="beginLoop">-359</xsl:with-param>
			<xsl:with-param name="endLoop" select="xs:integer(round(@dawn - 1))" />
			<xsl:with-param name="color">darkblue</xsl:with-param>
		</xsl:call-template>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@dawn"/>)</xsl:attribute>
			<xsl:attribute name="stroke">white</xsl:attribute>
			<xsl:attribute name="stroke-width">2</xsl:attribute>
			<line x1="0" y1="115" x2="0" y2="0"/>
			<text x="0" y="125" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@up"/>)</xsl:attribute>
			<xsl:attribute name="stroke">white</xsl:attribute>
			<xsl:attribute name="stroke-width">2</xsl:attribute>
			<line x1="0" y1="115" x2="0" y2="0"/>
			<text x="0" y="125" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@peak"/>)</xsl:attribute>
			<xsl:attribute name="stroke">white</xsl:attribute>
			<xsl:attribute name="stroke-width">2</xsl:attribute>
			<line x1="0" y1="115" x2="0" y2="0"/>
			<text x="0" y="125" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@down"/>)</xsl:attribute>
			<xsl:attribute name="stroke">white</xsl:attribute>
			<xsl:attribute name="stroke-width">2</xsl:attribute>
			<line x1="0" y1="115" x2="0" y2="0"/>
			<text x="0" y="125" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@dusk"/>)</xsl:attribute>
			<xsl:attribute name="stroke">white</xsl:attribute>
			<xsl:attribute name="stroke-width">2</xsl:attribute>
			<line x1="0" y1="115" x2="0" y2="0"/>
			<text x="0" y="125" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template name="pie">
		<xsl:param name="beginLoop"/>
		<xsl:param name="endLoop"/>
		<xsl:param name="color"/>
		<xsl:for-each select="$beginLoop to $endLoop">
			<xsl:variable name="tick" select="."/>
			<xsl:element name="g">
				<xsl:attribute name="transform">rotate(<xsl:value-of select="$tick"/>)</xsl:attribute>
				<xsl:attribute name="stroke"><xsl:value-of select="$color"/></xsl:attribute>
				<xsl:attribute name="stroke-width">2</xsl:attribute>
				<line x1="0" y1="90" x2="0" y2="0"></line>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="moon">
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@up"/>)</xsl:attribute>
			<line x1="0" y1="115" x2="0" y2="0"/>
			<text x="0" y="125" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@peak"/>)</xsl:attribute>
			<line x1="0" y1="115" x2="0" y2="0"/>
			<text x="0" y="125" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@down"/>)</xsl:attribute>
			<line x1="0" y1="115" x2="0" y2="0"/>
			<text x="0" y="125" dy="3"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
