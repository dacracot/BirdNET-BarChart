<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
<!-- =========================================================================================== -->
	<xsl:template match="/dial">
		<xsl:element name="html">
			<head>
				<title>BirdNET-BarChart</title>
<script>
function show(text) {document.getElementById("data").innerHTML=text}
</script>
			</head>
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
				<hr/>
				<div id="data"><xsl:call-template name="show"/></div>
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
					<xsl:element name="g">
						<xsl:attribute name="transform">translate(-19, 104)</xsl:attribute>
						<xsl:attribute name="onmouseover">show('<xsl:call-template name="show"><xsl:with-param name="dial"><xsl:value-of select="@dial"/></xsl:with-param></xsl:call-template>')</xsl:attribute>
						<xsl:attribute name="onmouseout">show('<xsl:call-template name="show"/>')</xsl:attribute>
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
							<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@dial ='03'">
					<xsl:element name="g">
						<xsl:attribute name="transform">translate(-104, 67)</xsl:attribute>
						<xsl:attribute name="onmouseover">show('<xsl:call-template name="show"><xsl:with-param name="dial"><xsl:value-of select="@dial"/></xsl:with-param></xsl:call-template>')</xsl:attribute>
						<xsl:attribute name="onmouseout">show('<xsl:call-template name="show"/>')</xsl:attribute>
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
							<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@dial ='06'">
					<xsl:element name="g">
						<xsl:attribute name="transform">translate(-142, -19)</xsl:attribute>
						<xsl:attribute name="onmouseover">show('<xsl:call-template name="show"><xsl:with-param name="dial"><xsl:value-of select="@dial"/></xsl:with-param></xsl:call-template>')</xsl:attribute>
						<xsl:attribute name="onmouseout">show('<xsl:call-template name="show"/>')</xsl:attribute>
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
							<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@dial ='09'">
					<xsl:element name="g">
						<xsl:attribute name="transform">translate(-104, -104)</xsl:attribute>
						<xsl:attribute name="onmouseover">show('<xsl:call-template name="show"><xsl:with-param name="dial"><xsl:value-of select="@dial"/></xsl:with-param></xsl:call-template>')</xsl:attribute>
						<xsl:attribute name="onmouseout">show('<xsl:call-template name="show"/>')</xsl:attribute>
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
							<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@dial ='12'">
					<xsl:element name="g">
						<xsl:attribute name="transform">translate(-19, -142)</xsl:attribute>
						<xsl:attribute name="onmouseover">show('<xsl:call-template name="show"><xsl:with-param name="dial"><xsl:value-of select="@dial"/></xsl:with-param></xsl:call-template>')</xsl:attribute>
						<xsl:attribute name="onmouseout">show('<xsl:call-template name="show"/>')</xsl:attribute>
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
							<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@dial ='15'">
					<xsl:element name="g">
						<xsl:attribute name="transform">translate(67, -104)</xsl:attribute>
						<xsl:attribute name="onmouseover">show('<xsl:call-template name="show"><xsl:with-param name="dial"><xsl:value-of select="@dial"/></xsl:with-param></xsl:call-template>')</xsl:attribute>
						<xsl:attribute name="onmouseout">show('<xsl:call-template name="show"/>')</xsl:attribute>
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
							<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@dial ='18'">
					<xsl:element name="g">
						<xsl:attribute name="transform">translate(104, -19)</xsl:attribute>
						<xsl:attribute name="onmouseover">show('<xsl:call-template name="show"><xsl:with-param name="dial"><xsl:value-of select="@dial"/></xsl:with-param></xsl:call-template>')</xsl:attribute>
						<xsl:attribute name="onmouseout">show('<xsl:call-template name="show"/>')</xsl:attribute>
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
							<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@dial ='21'">
					<xsl:element name="g">
						<xsl:attribute name="transform">translate(67, 67)</xsl:attribute>
						<xsl:attribute name="onmouseover">show('<xsl:call-template name="show"><xsl:with-param name="dial"><xsl:value-of select="@dial"/></xsl:with-param></xsl:call-template>')</xsl:attribute>
						<xsl:attribute name="onmouseout">show('<xsl:call-template name="show"/>')</xsl:attribute>
						<xsl:call-template name="icon">
							<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
							<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
						</xsl:call-template>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>miss-matched weather.dial in dial.xsl</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template name="show">
		<xsl:param name="dial"/>
		<xsl:choose>
			<xsl:when test="string-length($dial) != 0">
				<xsl:element name="table">
					<xsl:element name="tr">
						<xsl:element name="th">condition</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/weather[@dial = $dial]/@condition"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">temperature</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/weather[@dial = $dial]/@temperature"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">humidity</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/weather[@dial = $dial]/@humidity"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">wind</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/weather[@dial = $dial]/@wind"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">precipitation</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/weather[@dial = $dial]/@precipitation"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">pressure</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/weather[@dial = $dial]/@pressure"/></xsl:element>
						</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="table">
					<xsl:element name="tr">
						<xsl:element name="th">dawn</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/sun/@dawn"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">sunrise</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/sun/@up"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">sunset</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/sun/@down"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">dusk</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/sun/@dusk"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">phase</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/moon/@phase"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">moonrise</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/moon/@up"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">moonset</xsl:element>
						<xsl:element name="td"><xsl:value-of select="/dial/moon/@down"/></xsl:element>
						</xsl:element>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template name="icon">
		<xsl:param name="iconNumber"/>
		<xsl:param name="dayNight"/>
		<xsl:choose>
			<xsl:when test="$iconNumber = 800">
				<xsl:if test="($dayNight = '06') or ($dayNight = '09') or ($dayNight = '12') or ($dayNight = '15') or ($dayNight = '18')">
					<xsl:copy-of select="document('../grfx/svg/weather/clearSun.svg')/clearSun/*"/>
				</xsl:if>
				<xsl:if test="($dayNight = '21') or ($dayNight = '00') or ($dayNight = '03')">
<!-- 
					<xsl:copy-of select="document('../grfx/svg/weather/clearMoon.svg')/clearMoon/*"/>
 -->
					<xsl:choose>
						<xsl:when test="/dial/moon/@phase ='New Moon'">
								<xsl:copy-of select="document('../grfx/svg/moon/new.svg')/new/*"/>
						</xsl:when>
						<xsl:when test="/dial/moon/@phase ='Waxing Crescent'">
								<xsl:copy-of select="document('../grfx/svg/moon/waxingCrescent.svg')/waxingCrescent/*"/>
						</xsl:when>
						<xsl:when test="/dial/moon/@phase ='First Quarter'">
								<xsl:copy-of select="document('../grfx/svg/moon/firstQuarter.svg')/firstQuarter/*"/>
						</xsl:when>
						<xsl:when test="/dial/moon/@phase ='Waxing Gibbous'">
								<xsl:attribute name="transform"><xsl:call-template name="phase"><xsl:with-param name="peak"><xsl:value-of select="round(number(@peak) + 360)"/></xsl:with-param></xsl:call-template></xsl:attribute>
						</xsl:when>
						<xsl:when test="/dial/moon/@phase ='Full Moon'">
								<xsl:copy-of select="document('../grfx/svg/moon/full.svg')/full/*"/>
						</xsl:when>
						<xsl:when test="/dial/moon/@phase ='Waning Gibbous'">
								<xsl:copy-of select="document('../grfx/svg/moon/waningGibbous.svg')/waningGibbous/*"/>
						</xsl:when>
						<xsl:when test="/dial/moon/@phase ='Last Quarter'">
								<xsl:copy-of select="document('../grfx/svg/moon/lastQuarter.svg')/lastQuarter/*"/>
						</xsl:when>
						<xsl:when test="/dial/moon/@phase ='Waning Crescent'">
								<xsl:copy-of select="document('../grfx/svg/moon/waningCrescent.svg')/waningCrescent/*"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>miss-matched moon.phase in dial.xsl</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
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
		<xsl:element name="g">
			<xsl:choose>
				<xsl:when test="@phase ='New Moon'">
					<xsl:element name="g">
						<xsl:attribute name="transform"><xsl:call-template name="phase"><xsl:with-param name="peak"><xsl:value-of select="round(number(@peak) + 360)"/></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:copy-of select="document('../grfx/svg/moon/new.svg')/new/*"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@phase ='Waxing Crescent'">
					<xsl:element name="g">
						<xsl:attribute name="transform"><xsl:call-template name="phase"><xsl:with-param name="peak"><xsl:value-of select="round(number(@peak) + 360)"/></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:copy-of select="document('../grfx/svg/moon/waxingCrescent.svg')/waxingCrescent/*"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@phase ='First Quarter'">
					<xsl:element name="g">
						<xsl:attribute name="transform"><xsl:call-template name="phase"><xsl:with-param name="peak"><xsl:value-of select="round(number(@peak) + 360)"/></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:copy-of select="document('../grfx/svg/moon/firstQuarter.svg')/firstQuarter/*"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@phase ='Waxing Gibbous'">
					<xsl:element name="g">
						<xsl:attribute name="transform"><xsl:call-template name="phase"><xsl:with-param name="peak"><xsl:value-of select="round(number(@peak) + 360)"/></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:copy-of select="document('../grfx/svg/moon/waxingGibbous.svg')/waxingGibbous/*"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@phase ='Full Moon'">
					<xsl:element name="g">
						<xsl:attribute name="transform"><xsl:call-template name="phase"><xsl:with-param name="peak"><xsl:value-of select="round(number(@peak) + 360)"/></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:copy-of select="document('../grfx/svg/moon/full.svg')/full/*"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@phase ='Waning Gibbous'">
					<xsl:element name="g">
						<xsl:attribute name="transform"><xsl:call-template name="phase"><xsl:with-param name="peak"><xsl:value-of select="round(number(@peak) + 360)"/></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:copy-of select="document('../grfx/svg/moon/waningGibbous.svg')/waningGibbous/*"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@phase ='Last Quarter'">
					<xsl:element name="g">
						<xsl:attribute name="transform"><xsl:call-template name="phase"><xsl:with-param name="peak"><xsl:value-of select="round(number(@peak) + 360)"/></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:copy-of select="document('../grfx/svg/moon/lastQuarter.svg')/lastQuarter/*"/>
					</xsl:element>
				</xsl:when>
				<xsl:when test="@phase ='Waning Crescent'">
					<xsl:element name="g">
						<xsl:attribute name="transform"><xsl:call-template name="phase"><xsl:with-param name="peak"><xsl:value-of select="round(number(@peak) + 360)"/></xsl:with-param></xsl:call-template></xsl:attribute>
						<xsl:copy-of select="document('../grfx/svg/moon/waningCrescent.svg')/waningCrescent/*"/>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>miss-matched moon.phase in dial.xsl</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:element>
 -->
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@down"/>)</xsl:attribute>
			<line x1="0" y1="90" x2="0" y2="0"/>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template name="phase">
<!-- 
		01:30		<g transform="translate(-69, 91)">	
		04:30		<g transform="translate(-129, 31)">	
		07:30		<g transform="translate(-129, -69)">
		10:30		<g transform="translate(-69, -129)">
		11:30		<g transform="translate(31, -129)">	
		16:30		<g transform="translate(91, -69)">	
		19:30		<g transform="translate(91, 31)">	
		22:30		<g transform="translate(31, 91)">		
 -->
		<xsl:param name="peak"/>
		<xsl:choose>
			<xsl:when test="$peak = (0 to 45)">
				<xsl:text>translate(-69, 91)</xsl:text>
			</xsl:when>
			<xsl:when test="$peak = (46 to 90)">
				<xsl:text>translate(-129, 31)</xsl:text>
			</xsl:when>
			<xsl:when test="$peak = (91 to 135)">
				<xsl:text>translate(-129, -69)</xsl:text>
			</xsl:when>
			<xsl:when test="$peak = (136 to 180)">
				<xsl:text>translate(-69, -129)</xsl:text>
			</xsl:when>
			<xsl:when test="$peak = (181 to 225)">
				<xsl:text>translate(31, -129)</xsl:text>
			</xsl:when>
			<xsl:when test="$peak = (226 to 270)">
				<xsl:text>translate(91, -69)</xsl:text>
			</xsl:when>
			<xsl:when test="$peak = (271 to 315)">
				<xsl:text>translate(91, 31)</xsl:text>
			</xsl:when>
			<xsl:when test="$peak = (316 to 360)">
				<xsl:text>translate(31, 91)</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>miss-matched moon.peak, found </xsl:text><xsl:value-of select="$peak"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
