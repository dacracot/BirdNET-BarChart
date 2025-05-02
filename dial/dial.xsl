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
				<svg width="300" height="300" viewBox="-150 -150 300 300">
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
			<xsl:with-param name="color">black</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="pie">
			<xsl:with-param name="beginLoop">-359</xsl:with-param>
			<xsl:with-param name="endLoop" select="xs:integer(round(@dawn - 1))" />
			<xsl:with-param name="color">black</xsl:with-param>
		</xsl:call-template>
<!-- 
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@up"/>)</xsl:attribute>
			<xsl:copy-of select="document('../grfx/sunrise.svg')/sunrise/*"/>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@peak"/>)</xsl:attribute>
			<text x="0" y="125"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@down"/>)</xsl:attribute>
			<text x="0" y="125"><xsl:value-of select="@symbol"/></text>
		</xsl:element>
 -->
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
				<xsl:attribute name="stroke-opacity">0.3</xsl:attribute>
				<xsl:attribute name="stroke-width">2</xsl:attribute>
				<line x1="0" y1="90" x2="0" y2="0"></line>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="moon">
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@up"/>)</xsl:attribute>
			<line x1="0" y1="90" x2="0" y2="0"/>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@peak"/>)</xsl:attribute>
			<line x1="0" y1="90" x2="0" y2="0"/>
		</xsl:element>
<!-- 
		00		<g transform="translate(-19, 104)">
		03		<g transform="translate(-105, 67)">
		06		<g transform="translate(-142, -19)">
		09		<g transform="translate(-104, -104)">
		12		<g transform="translate(-19, -142)">
		15		<g transform="translate(67, -104)">
		18		<g transform="translate(104, -19)">
		21		<g transform="translate(67, 67)">
 -->
		<xsl:element name="g">
			<xsl:choose>
				<xsl:when test="@phase ='New Moon'">
					<g transform="translate(67, -104)">
						<xsl:copy-of select="document('../grfx/svg/moon/new.svg')/new/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Waxing Crescent'">
					<g transform="translate(104, -19)">
						<xsl:copy-of select="document('../grfx/svg/moon/waxingCrescent.svg')/waxingCrescent/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='First Quarter'">
					<g transform="translate(67, 67)">
						<xsl:copy-of select="document('../grfx/svg/moon/firstQuarter.svg')/firstQuarter/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Waxing Gibbous'">
					<g transform="translate(-19, 104)">
						<xsl:copy-of select="document('../grfx/svg/moon/waxingGibbous.svg')/waxingGibbous/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Full Moon'">
					<g transform="translate(-105, 67)">
						<xsl:copy-of select="document('../grfx/svg/moon/full.svg')/full/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Waning Gibbous'">
					<g transform="translate(-142, -19)">
						<xsl:copy-of select="document('../grfx/svg/moon/waningGibbous.svg')/waningGibbous/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Last Quarter'">
					<g transform="translate(-104, -104)">
						<xsl:copy-of select="document('../grfx/svg/moon/lastQuarter.svg')/lastQuarter/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Waning Crescent'">
					<g transform="translate(-19, -142)">
						<xsl:copy-of select="document('../grfx/svg/moon/waningCrescent.svg')/waningCrescent/*"/>
					</g>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>miss-matched moon.phase in dial.xsl</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@down"/>)</xsl:attribute>
			<line x1="0" y1="90" x2="0" y2="0"/>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
