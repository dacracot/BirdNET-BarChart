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
						<xsl:apply-templates select="weather"/>
						<xsl:copy-of select="document('../grfx/svg/base.svg')/base/*"/>
					</g>
				</svg>
			</xsl:element>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="weather">
<!-- 
		00:00		<g transform="translate(-19, 104)">			   0,123
		03:00		<g transform="translate(-104, 67)">			 -85,86
		06:00		<g transform="translate(-142, -19)">		-121,0
		09:00		<g transform="translate(-104, -104)">		 -85,-85
		12:00		<g transform="translate(-19, -142)">		   0,-121
		15:00		<g transform="translate(67, -104)">			  86,-85
		18:00		<g transform="translate(104, -19)">			 123,0
		21:00		<g transform="translate(67, 67)">			  86,86		offset= -19,-19
 -->
		<xsl:element name="g">
			<xsl:choose>
				<xsl:when test="@dial ='00'">
					<g transform="translate(-19, 104)">
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
						</xsl:call-template>
					</g>
				</xsl:when>
				<xsl:when test="@dial ='03'">
					<g transform="translate(-104, 67)">
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
						</xsl:call-template>
					</g>
				</xsl:when>
				<xsl:when test="@dial ='06'">
					<g transform="translate(-142, -19)">
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
						</xsl:call-template>
					</g>
				</xsl:when>
				<xsl:when test="@dial ='09'">
					<g transform="translate(-104, -104)">
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
						</xsl:call-template>
					</g>
				</xsl:when>
				<xsl:when test="@dial ='12'">
					<g transform="translate(-19, -142)">
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
						</xsl:call-template>
					</g>
				</xsl:when>
				<xsl:when test="@dial ='15'">
					<g transform="translate(67, -104)">
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
						</xsl:call-template>
					</g>
				</xsl:when>
				<xsl:when test="@dial ='18'">
					<g transform="translate(104, -19)">
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
						</xsl:call-template>
					</g>
				</xsl:when>
				<xsl:when test="@dial ='21'">
					<g transform="translate(67, 67)">
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
						</xsl:call-template>
					</g>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>miss-matched weather.dial in dial.xsl</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template name="icon">
		<xsl:param name="iconNumber"/>
		<xsl:choose>
			<xsl:when test="$iconNumber = 800">
				<xsl:copy-of select="document('../grfx/svg/weather/clear.svg')/clear/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = (200 to 232)">
				<xsl:copy-of select="document('../grfx/svg/weather/thunderstorm.svg')/thunderstorm/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = (300 to 321, 500 to 504, 520 to 531)">
				<xsl:copy-of select="document('../grfx/svg/weather/rain.svg')/rain/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = (511, 611 to 613)">
				<xsl:copy-of select="document('../grfx/svg/weather/sleet.svg')/sleet/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = (600 to 602, 615 to 622)">
				<xsl:copy-of select="document('../grfx/svg/weather/snow.svg')/snow/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = 701">
				<xsl:copy-of select="document('../grfx/svg/weather/mist.svg')/mist/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = (711 to 762)">
				<xsl:copy-of select="document('../grfx/svg/weather/foggy.svg')/foggy/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = 771">
				<xsl:copy-of select="document('../grfx/svg/weather/wind.svg')/wind/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = 781">
				<xsl:copy-of select="document('../grfx/svg/weather/tornado.svg')/tornado/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = (801 to 804)">
				<xsl:copy-of select="document('../grfx/svg/weather/cloudy.svg')/cloudy/*"/>
			</xsl:when>
			<xsl:otherwise>
<!-- 
				<xsl:text>miss-matched weather.condition in dial.xsl, found <xsl:value-of select="$iconNumber"/></xsl:text>
 -->
				<xsl:text>miss-matched weather.condition in dial.xsl, found </xsl:text><xsl:value-of select="$iconNumber"/>
			</xsl:otherwise>
		</xsl:choose>
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
			<xsl:with-param name="beginLoop" select="xs:integer(round(@dusk))" />
			<xsl:with-param name="endLoop">0</xsl:with-param>
			<xsl:with-param name="color">black</xsl:with-param>
		</xsl:call-template>
		<xsl:call-template name="pie">
			<xsl:with-param name="beginLoop">-359</xsl:with-param>
			<xsl:with-param name="endLoop" select="xs:integer(round(@dawn))" />
			<xsl:with-param name="color">black</xsl:with-param>
		</xsl:call-template>
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
		01:30		<g transform="translate(-69, 91)">			 -50,110
		04:30		<g transform="translate(-129, 31)">			-110,50
		07:30		<g transform="translate(-129, -69)">		-110,-50
		10:30		<g transform="translate(-69, -129)">		 -50,-110
		11:30		<g transform="translate(31, -129)">			  50,-110
		16:30		<g transform="translate(91, -69)">			 110,-50
		19:30		<g transform="translate(91, 31)">			 110,50
		22:30		<g transform="translate(31, 91)">			  50,110		offset= -19,-19	
 -->
 
<!--  THE MOON SHOULD BE PLACED(translate(#,#)) BASED UPON THE @PEAK ATTRIBUTE VALUE -->
 
 
		<xsl:element name="g">
			<xsl:choose>
				<xsl:when test="@phase ='New Moon'">
					<g transform="translate(31, 91)">
						<xsl:copy-of select="document('../grfx/svg/moon/new.svg')/new/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Waxing Crescent'">
					<g transform="translate(-69, 91)">
						<xsl:copy-of select="document('../grfx/svg/moon/waxingCrescent.svg')/waxingCrescent/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='First Quarter'">
					<g transform="translate(-129, 31)">
						<xsl:copy-of select="document('../grfx/svg/moon/firstQuarter.svg')/firstQuarter/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Waxing Gibbous'">
					<g transform="translate(-129, -69)">
						<xsl:copy-of select="document('../grfx/svg/moon/waxingGibbous.svg')/waxingGibbous/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Full Moon'">
					<g transform="translate(-69, -129)">
						<xsl:copy-of select="document('../grfx/svg/moon/full.svg')/full/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Waning Gibbous'">
					<g transform="translate(31, -129)">
						<xsl:copy-of select="document('../grfx/svg/moon/waningGibbous.svg')/waningGibbous/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Last Quarter'">
					<g transform="translate(91, -69)">
						<xsl:copy-of select="document('../grfx/svg/moon/lastQuarter.svg')/lastQuarter/*"/>
					</g>
				</xsl:when>
				<xsl:when test="@phase ='Waning Crescent'">
					<g transform="translate(91, 31)">
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
