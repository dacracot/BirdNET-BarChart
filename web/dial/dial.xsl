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
				<meta name="viewport" content="width=device-width, initial-scale=1.3" />
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
							<xsl:apply-templates select="menu"/>
						</xsl:element>
					</xsl:element>
				</xsl:element>
				<hr/>
				<table>
					<tr>
						<td>
							<svg id="dial" width="300" height="300" viewBox="-150 -150 300 300" xmlns="http://www.w3.org/2000/svg">
								<circle cx="0" cy="0" r="90" fill="none" stroke="black" stroke-width="2" onmouseover="rowInit()"/>
								<g stroke="black" stroke-width="1" font-family="Arial" font-size="10" text-anchor="middle">
									<xsl:apply-templates select="moon"/>
									<xsl:apply-templates select="sun"/>
									<xsl:apply-templates select="weather"/>
									<xsl:copy-of select="document('../grfx/svg/base.svg')/base/*"/>
								</g>
								<xsl:apply-templates select="data"/>
							</svg>
						</td>
						<td>
							<div id="showData"></div>
						</td>
					</tr>
				</table>
				<hr/>
				<xsl:call-template name="showDial"/>
				<hr/>
			</xsl:element>
			<script src="dial.js"></script><xsl:text>
</xsl:text>
    		<div id="popup" style="left: 0; top: 0"></div>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="menu">
		<details>
			<summary>Heard last 24 hours:</summary>
			<form>
				<fieldset>
					<legend>Birds</legend>
					<ul>
						<xsl:element name="li">
							<table>
								<tr>
									<td style="vertical-align: text-top;">All:</td>
									<td style="vertical-align:bottom"><img src="../grfx/svg/selectAll.svg" title="Select all birds." width="12" height="12" class="checker" onclick="checkAll(true);"/></td>
									<td><xsl:text>&#160;&#160;&#160;&#160;</xsl:text></td>
									<td style="vertical-align: text-top;">Clear:</td>
									<td style="vertical-align:bottom"><img src="../grfx/svg/clearAll.svg" title="Clear all birds." width="12" height="12" class="checker" onclick="checkAll(false);"/></td>
								</tr>
							</table>
						</xsl:element>
						<xsl:apply-templates select="confidence"/>
					</ul>
				</fieldset>
			</form>
		</details>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="confidence">
		<xsl:element name="li">
          <strong>Confidence of at least <xsl:value-of select="@above"/>:</strong>
		</xsl:element>
		<xsl:apply-templates select="bird"/>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="bird">
		<xsl:element name="li">
			<xsl:element name="label">
				<xsl:attribute name="for"><xsl:value-of select="@commonName"/></xsl:attribute>
				<xsl:value-of select="@commonName"/>
				<xsl:element name="input">
					<xsl:attribute name="type">checkbox</xsl:attribute>
					<xsl:attribute name="style">height: 7px; width: 7px;</xsl:attribute>
					<xsl:attribute name="onclick">toggleBird('<xsl:value-of select="@commonName"/>');</xsl:attribute>
				</xsl:element>
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
				<xsl:call-template name="icon">
					<xsl:with-param name="iconNumber"><xsl:value-of select="number(@iconNumber)"/></xsl:with-param>
					<xsl:with-param name="dayNight"><xsl:value-of select="@dial"/></xsl:with-param>
				</xsl:call-template>
			</xsl:element>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="data">
		<xsl:variable name="scalar">5</xsl:variable>
		<xsl:variable name="color" as="element()*">
			<item>#556b2f</item>
			<item>#8b0000</item>
			<item>#483d8b</item>
			<item>#008000</item>
			<item>#b8860b</item>
			<item>#008b8b</item>
			<item>#000080</item>
			<item>#9acd32</item>
			<item>#8fbc8f</item>
			<item>#8b008b</item>
			<item>#ff0000</item>
			<item>#ff8c00</item>
			<item>#ffff00</item>
			<item>#7cfc00</item>
			<item>#8a2be2</item>
			<item>#00ff7f</item>
			<item>#00ffff</item>
			<item>#00bfff</item>
			<item>#0000ff</item>
			<item>#ff6347</item>
			<item>#ff00ff</item>
			<item>#1e90ff</item>
			<item>#db7093</item>
			<item>#b0e0e6</item>
			<item>#90ee90</item>
			<item>#ff1493</item>
			<item>#7b68ee</item>
			<item>#ffa07a</item>
			<item>#ee82ee</item>
			<item>#ffe4b5</item>
			<item>#ffc0cb</item>
		</xsl:variable>
		<xsl:for-each-group select="heard" group-by="@commonName">
			<xsl:sort select="@commonName"/>
			<xsl:element name="g">
				<xsl:comment><xsl:value-of select="current-grouping-key()"/></xsl:comment>
				<xsl:variable name="whichBird" select="current-grouping-key()"/>
				<xsl:variable name="whichColor" select="position() mod 31"/>
				<xsl:for-each-group select="../heard[@commonName = $whichBird]" group-by="@dial">
					<xsl:sort select="@dial"/>
					<xsl:variable name="whichDial" select="current-grouping-key()"/>
					<xsl:element name="g">
						<xsl:attribute name="transform">rotate(<xsl:value-of select="$whichDial"/>)</xsl:attribute>
<xsl:attribute name="onmouseover">showData("<xsl:value-of select="$whichBird"/>","<xsl:value-of select="@dialTime"/>");</xsl:attribute>
						<xsl:for-each select="../heard[@commonName = $whichBird and @dial = $whichDial]">
							<xsl:sort select="@confidenceRounded"/>
							<xsl:choose>
								<xsl:when test="position() = last()"> 
									<!-- draw line -->
									<xsl:choose>
										<xsl:when test="last() = 10">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:variable name="one"><xsl:value-of select="(preceding-sibling::*[1]/@quantity+$zero)"/></xsl:variable>
											<xsl:variable name="two"><xsl:value-of select="(preceding-sibling::*[2]/@quantity+$one)"/></xsl:variable>
											<xsl:variable name="three"><xsl:value-of select="(preceding-sibling::*[3]/@quantity+$two)"/></xsl:variable>
											<xsl:variable name="four"><xsl:value-of select="(preceding-sibling::*[4]/@quantity+$three)"/></xsl:variable>
											<xsl:variable name="five"><xsl:value-of select="(preceding-sibling::*[5]/@quantity+$four)"/></xsl:variable>
											<xsl:variable name="six"><xsl:value-of select="(preceding-sibling::*[6]/@quantity+$five)"/></xsl:variable>
											<xsl:variable name="seven"><xsl:value-of select="(preceding-sibling::*[7]/@quantity+$six)"/></xsl:variable>
											<xsl:variable name="eight"><xsl:value-of select="(preceding-sibling::*[8]/@quantity+$seven)"/></xsl:variable>
											<xsl:variable name="nine"><xsl:value-of select="(preceding-sibling::*[9]/@quantity+$eight)"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[1]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[2]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[3]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[4]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[5]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($five*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[6]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($five*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($six*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[7]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($six*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($seven*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[8]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($seven*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($eight*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[9]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($eight*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($nine*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
										<xsl:when test="last() = 9">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:variable name="one"><xsl:value-of select="(preceding-sibling::*[1]/@quantity+$zero)"/></xsl:variable>
											<xsl:variable name="two"><xsl:value-of select="(preceding-sibling::*[2]/@quantity+$one)"/></xsl:variable>
											<xsl:variable name="three"><xsl:value-of select="(preceding-sibling::*[3]/@quantity+$two)"/></xsl:variable>
											<xsl:variable name="four"><xsl:value-of select="(preceding-sibling::*[4]/@quantity+$three)"/></xsl:variable>
											<xsl:variable name="five"><xsl:value-of select="(preceding-sibling::*[5]/@quantity+$four)"/></xsl:variable>
											<xsl:variable name="six"><xsl:value-of select="(preceding-sibling::*[6]/@quantity+$five)"/></xsl:variable>
											<xsl:variable name="seven"><xsl:value-of select="(preceding-sibling::*[7]/@quantity+$six)"/></xsl:variable>
											<xsl:variable name="eight"><xsl:value-of select="(preceding-sibling::*[8]/@quantity+$seven)"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[1]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[2]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[3]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[4]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[5]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($five*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[6]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($five*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($six*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[7]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($six*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($seven*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[8]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($seven*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($eight*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
										<xsl:when test="last() = 8">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:variable name="one"><xsl:value-of select="(preceding-sibling::*[1]/@quantity+$zero)"/></xsl:variable>
											<xsl:variable name="two"><xsl:value-of select="(preceding-sibling::*[2]/@quantity+$one)"/></xsl:variable>
											<xsl:variable name="three"><xsl:value-of select="(preceding-sibling::*[3]/@quantity+$two)"/></xsl:variable>
											<xsl:variable name="four"><xsl:value-of select="(preceding-sibling::*[4]/@quantity+$three)"/></xsl:variable>
											<xsl:variable name="five"><xsl:value-of select="(preceding-sibling::*[5]/@quantity+$four)"/></xsl:variable>
											<xsl:variable name="six"><xsl:value-of select="(preceding-sibling::*[6]/@quantity+$five)"/></xsl:variable>
											<xsl:variable name="seven"><xsl:value-of select="(preceding-sibling::*[7]/@quantity+$six)"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[1]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[2]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[3]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[4]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[5]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($five*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[6]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($five*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($six*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[7]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($six*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($seven*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
										<xsl:when test="last() = 7">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:variable name="one"><xsl:value-of select="(preceding-sibling::*[1]/@quantity+$zero)"/></xsl:variable>
											<xsl:variable name="two"><xsl:value-of select="(preceding-sibling::*[2]/@quantity+$one)"/></xsl:variable>
											<xsl:variable name="three"><xsl:value-of select="(preceding-sibling::*[3]/@quantity+$two)"/></xsl:variable>
											<xsl:variable name="four"><xsl:value-of select="(preceding-sibling::*[4]/@quantity+$three)"/></xsl:variable>
											<xsl:variable name="five"><xsl:value-of select="(preceding-sibling::*[5]/@quantity+$four)"/></xsl:variable>
											<xsl:variable name="six"><xsl:value-of select="(preceding-sibling::*[6]/@quantity+$five)"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[1]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[2]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[3]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[4]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[5]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($five*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[6]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($five*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($six*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
										<xsl:when test="last() = 6">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:variable name="one"><xsl:value-of select="(preceding-sibling::*[1]/@quantity+$zero)"/></xsl:variable>
											<xsl:variable name="two"><xsl:value-of select="(preceding-sibling::*[2]/@quantity+$one)"/></xsl:variable>
											<xsl:variable name="three"><xsl:value-of select="(preceding-sibling::*[3]/@quantity+$two)"/></xsl:variable>
											<xsl:variable name="four"><xsl:value-of select="(preceding-sibling::*[4]/@quantity+$three)"/></xsl:variable>
											<xsl:variable name="five"><xsl:value-of select="(preceding-sibling::*[5]/@quantity+$four)"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[1]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[2]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[3]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[4]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[5]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($five*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
										<xsl:when test="last() = 5">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:variable name="one"><xsl:value-of select="(preceding-sibling::*[1]/@quantity+$zero)"/></xsl:variable>
											<xsl:variable name="two"><xsl:value-of select="(preceding-sibling::*[2]/@quantity+$one)"/></xsl:variable>
											<xsl:variable name="three"><xsl:value-of select="(preceding-sibling::*[3]/@quantity+$two)"/></xsl:variable>
											<xsl:variable name="four"><xsl:value-of select="(preceding-sibling::*[4]/@quantity+$three)"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[1]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[2]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[3]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[4]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($four*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
										<xsl:when test="last() = 4">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:variable name="one"><xsl:value-of select="(preceding-sibling::*[1]/@quantity+$zero)"/></xsl:variable>
											<xsl:variable name="two"><xsl:value-of select="(preceding-sibling::*[2]/@quantity+$one)"/></xsl:variable>
											<xsl:variable name="three"><xsl:value-of select="(preceding-sibling::*[3]/@quantity+$two)"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[1]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[2]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[3]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($three*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
										<xsl:when test="last() = 3">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:variable name="one"><xsl:value-of select="(preceding-sibling::*[1]/@quantity+$zero)"/></xsl:variable>
											<xsl:variable name="two"><xsl:value-of select="(preceding-sibling::*[2]/@quantity+$one)"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[1]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[2]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($two*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
										<xsl:when test="last() = 2">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:variable name="one"><xsl:value-of select="(preceding-sibling::*[1]/@quantity+$zero)"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="preceding-sibling::*[1]/@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($one*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
										<xsl:when test="last() = 1">
											<xsl:variable name="zero"><xsl:value-of select="@quantity"/></xsl:variable>
											<xsl:element name="line">
												<xsl:attribute name="id"><xsl:value-of select="$whichBird"/></xsl:attribute>
												<xsl:attribute name="onmouseenter">doEnter(this)</xsl:attribute>
												<xsl:attribute name="onmouseleave">doLeave(this)</xsl:attribute>
												<xsl:attribute name="visibility">visible</xsl:attribute>
												<xsl:attribute name="class">dataLine</xsl:attribute>
												<xsl:attribute name="style">stroke:<xsl:value-of select="$color[$whichColor]"/>; stroke-opacity:<xsl:value-of select="@confidenceRounded"/>; stroke-width:2; display: block;</xsl:attribute>
												<xsl:attribute name="x1">0</xsl:attribute>
												<xsl:attribute name="x2">0</xsl:attribute>
												<xsl:attribute name="y1">0</xsl:attribute>
												<xsl:attribute name="y2"><xsl:value-of select="($zero*$scalar)"/></xsl:attribute>
											</xsl:element>
										</xsl:when>
									</xsl:choose>
								</xsl:when>
								<xsl:otherwise>
									<!-- do nothing -->
								</xsl:otherwise>
							</xsl:choose>
						</xsl:for-each>
					</xsl:element>
				</xsl:for-each-group>
			</xsl:element>
		</xsl:for-each-group>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="heard">
		<xsl:param name="color"/>
			<xsl:element name="g">
				<xsl:attribute name="transform">rotate(<xsl:value-of select="@dial"/>)</xsl:attribute>
				<xsl:attribute name="stroke"><xsl:value-of select="$color"/></xsl:attribute>
				<xsl:attribute name="stroke-opacity"><xsl:value-of select="@confidenceRounded"/></xsl:attribute>
				<xsl:attribute name="stroke-width">2</xsl:attribute>
				<line x1="0" y1="90" x2="0" y2="0"></line>
			</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template name="showDial">
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
			<xsl:call-template name="showDialMore"/>
		</xsl:element>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template name="showDialMore">
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
			<xsl:when test="$iconNumber = (801 to 802)">
				<xsl:if test="($dayNight = '06') or ($dayNight = '09') or ($dayNight = '12') or ($dayNight = '15') or ($dayNight = '18')">
					<xsl:copy-of select="document('../grfx/svg/weather/cloudyPartialSun.svg')/cloudyPartialSun/*"/>
				</xsl:if>
				<xsl:if test="($dayNight = '21') or ($dayNight = '00') or ($dayNight = '03')">
					<xsl:copy-of select="document('../grfx/svg/weather/cloudyPartialMoon.svg')/cloudyPartialMoon/*"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="$iconNumber = (803 to 804)">
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
				<line id="pie" x1="0" y1="90" x2="0" y2="0"></line>
			</xsl:element>
		</xsl:for-each>
	</xsl:template>
<!-- =========================================================================================== -->
	<xsl:template match="moon">
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@up"/>)</xsl:attribute>
			<line id="pie" x1="0" y1="90" x2="0" y2="0"/>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@peak"/>)</xsl:attribute>
			<line id="pie" x1="0" y1="90" x2="0" y2="0"/>
		</xsl:element>
		<xsl:element name="g">
			<xsl:attribute name="transform">rotate(<xsl:value-of select="@down"/>)</xsl:attribute>
			<line id="pie" x1="0" y1="90" x2="0" y2="0"/>
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
