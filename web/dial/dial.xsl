<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:param name="asOf"/>
	<xsl:param name="lat"/>
	<xsl:param name="lon"/>
<!-- =========================================================================================== -->
	<xsl:template match="/dial">
		<xsl:element name="html">
			<head>
				<meta http-equiv="refresh" content="3600" />
				<meta name="viewport" content="width=device-width, initial-scale=1.333" />
				
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="mobile-web-app-capable" content="yes" />
<meta name="application-name" content="BirdNET-BarChart" />
<meta name="apple-mobile-web-app-title" content="BirdNET-BarChart" />
				
				<title>BirdNET-BarChart</title>
				<link rel="stylesheet" href="dial.css"/>
			</head>
			<xsl:element name="body">
				<hr/>
				<xsl:element name="table">
					<xsl:element name="tr">
						<xsl:element name="th">as of:</xsl:element>
						<xsl:element name="td"><xsl:value-of select="$asOf"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">latitude:</xsl:element>
						<xsl:element name="td"><xsl:value-of select="$lat"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">longitude:</xsl:element>
						<xsl:element name="td"><xsl:value-of select="$lon"/></xsl:element>
					</xsl:element>
					<xsl:element name="tr">
						<xsl:element name="th">bird songs:</xsl:element>
						<xsl:element name="td">
<details>
  <summary>Heard last 24 hours:</summary>
  <form>
    <fieldset>
      <legend>Birds</legend>
      <ul>
        <li>
          <label for="xxx">Mourning Dove(164)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>
        
        <li>
          <label for="xxx">Bushtit(112)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">California Scrub-Jay(36)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">American Robin(23)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Green-winged Teal(6)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Black Phoebe(5)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Say's Phoebe(5)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Whimbrel(4)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Cedar Waxwing(3)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Mallard(3)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Hutton's Vireo(2)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Western Tanager(2)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Barn Swallow(1)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">Black-crowned Night-Heron(1)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>

        <li>
          <label for="xxx">House Finch(1)
          <input type="checkbox" id="xxx" name="xxx" value="xxx"/></label>
        </li>
      </ul>
    </fieldset>
  </form>
</details>
						</xsl:element>
					</xsl:element>
				</xsl:element>

				<hr/>
				<svg width="300" height="300" viewBox="-150 -150 300 300">
					<circle cx="0" cy="0" r="90" fill="none" stroke="black" stroke-width="2" onmouseover="rowInit()"/>
					<g stroke="black" stroke-width="1" font-family="Arial" font-size="10" text-anchor="middle">
						<xsl:apply-templates select="moon"/>
						<xsl:apply-templates select="sun"/>
						<xsl:apply-templates select="weather"/>
						<xsl:copy-of select="document('../grfx/svg/base.svg')/base/*"/>
					</g>
				</svg>
				<hr/>
				<xsl:call-template name="show"/>
				<hr/>
			</xsl:element>
		<script src="dial.js"></script><xsl:text>
</xsl:text>
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
			<xsl:element name="g">
				<xsl:choose>
					<xsl:when test="@dial ='00'">
						<xsl:attribute name="transform">translate(-19, 104)</xsl:attribute>
					</xsl:when>
					<xsl:when test="@dial ='03'">
						<xsl:attribute name="transform">translate(-104, 67)</xsl:attribute>
					</xsl:when>
					<xsl:when test="@dial ='06'">
						<xsl:attribute name="transform">translate(-142, -19)</xsl:attribute>
					</xsl:when>
					<xsl:when test="@dial ='09'">
						<xsl:attribute name="transform">translate(-104, -104)</xsl:attribute>
					</xsl:when>
					<xsl:when test="@dial ='12'">
						<xsl:attribute name="transform">translate(-19, -142)</xsl:attribute>
					</xsl:when>
					<xsl:when test="@dial ='15'">
						<xsl:attribute name="transform">translate(67, -104)</xsl:attribute>
					</xsl:when>
					<xsl:when test="@dial ='18'">
						<xsl:attribute name="transform">translate(104, -19)</xsl:attribute>
					</xsl:when>
					<xsl:when test="@dial ='21'">
						<xsl:attribute name="transform">translate(67, 67)</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>miss-matched weather.dial in dial.xsl</xsl:text>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:attribute name="onmouseover">rowShow(<xsl:value-of select="@dial"/>);</xsl:attribute>
				<!-- <xsl:attribute name="onmouseout">$('[id^=row_]').style.display='none'; $('row_sun_moon').style.display='';</xsl:attribute> -->
				<xsl:call-template name="icon">
					<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
					<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
				</xsl:call-template>
			</xsl:element>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template name="show">
		<!-- 
		<table>
		<tr id='row_sun_moon'style='display:table-row;'><td></td></tr>
		<tr id='row_00'style='display:none;'><td></td></tr>
		<tr id='row_03'style='display:none;'><td></td></tr>
		<tr id='row_06'style='display:none;'><td></td></tr>
		<tr id='row_09'style='display:none;'><td></td></tr>
		<tr id='row_12'style='display:none;'><td></td></tr>
		<tr id='row_15'style='display:none;'><td></td></tr>
		<tr id='row_18'style='display:none;'><td></td></tr>
		<tr id='row_21'style='display:none;'><td></td></tr>
		</table>
		 -->
		<xsl:element name="table">
			<xsl:element name="tr">
				<xsl:attribute name="id">row_sun_moon</xsl:attribute>
				<xsl:attribute name="style">display:block;</xsl:attribute>
				<xsl:element name="td">
					<xsl:element name="table">
						<xsl:element name="tr">
							<xsl:element name="th">dawn:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="sun/@dawnTime"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">sunrise:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="sun/@upTime"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">sunset:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="sun/@downTime"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">dusk:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="sun/@duskTime"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">phase:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="moon/@phase"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">moonrise:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="moon/@upTime"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">moonset:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="moon/@downTime"/></xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
			<xsl:call-template name="showMore"/>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template name="showMore">
		<xsl:for-each select="weather">
			<xsl:element name="tr">
				<xsl:attribute name="id">row_<xsl:value-of select="@dial"/></xsl:attribute>
				<xsl:attribute name="style">display:none;</xsl:attribute>
				<xsl:element name="td">
					<xsl:element name="table">
						<xsl:element name="tr">
							<xsl:element name="th">condition:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="@condition"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">temperature:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="@temperature"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">humidity:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="@humidity"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">wind:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="@wind"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">precipitation:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="@precipitation"/></xsl:element>
						</xsl:element>
						<xsl:element name="tr">
							<xsl:element name="th">pressure:</xsl:element>
							<xsl:element name="td"><xsl:value-of select="@pressure"/></xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:element>
		</xsl:for-each>
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
			<xsl:when test="$iconNumber = (300, 310, 500, 520)">
				<xsl:copy-of select="document('../grfx/svg/weather/rainLight.svg')/rainLight/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = (301, 311, 313, 321, 501, 521, 531)">
				<xsl:copy-of select="document('../grfx/svg/weather/rainModerate.svg')/rainModerate/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = (302, 312, 314, 502, 522)">
				<xsl:copy-of select="document('../grfx/svg/weather/rainHeavy.svg')/rainHeavy/*"/>
			</xsl:when>
			<xsl:when test="$iconNumber = (503, 504)">
				<xsl:copy-of select="document('../grfx/svg/weather/rainPouring.svg')/rainPouring/*"/>
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
