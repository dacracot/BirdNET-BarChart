<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
	<xsl:output method="html" indent="yes"/>
	<xsl:include href="dial.xsl"/>
	<xsl:include href="chart.xsl"/>
<!-- =========================================================================================== -->
<!-- transform XML to HTML -->
	<xsl:template match="extract">
		<div id="tabs">
			<ul>
				<li><a href="#tab-dial">dial</a></li>
				<li><a href="#tab-chart">barchart</a></li>
				<li><a href="#tab-table">table</a></li>
			</ul>
			<div id="tab-dial">
				<ul>
					<li><a href="#tab-dial-solar">solar cycle</a></li>
					<li><a href="#tab-dial-lunar">lunar cycle</a></li>
					<li><a href="#tab-dial-seasonal">seasonal cycle</a></li>
				</ul>
				<div id="tab-dial-solar">
					<xsl:apply-templates select="dial"/>
				</div>
				<div id="tab-dial-lunar">
					<video width="111" height="" autoplay="autoplay" loop="loop" muted="muted">
						<source src="grfx/lunar/dial.mp4" type="video/mp4"/>
						<source src="dial.ogg" type="video/ogg"/>
						No video support.
					</video>
				</div>
				<div id="tab-dial-seasonal">
					<h4>seasonal dial coming soon</h4>
				</div>
			</div>
			<div id="tab-chart">
				<ul>
					<li><a href="#tab-chart-solar">solar cycle</a></li>
					<li><a href="#tab-chart-lunar">lunar cycle</a></li>
					<li><a href="#tab-chart-seasonal">seasonal cycle</a></li>
				</ul>
				<div id="tab-chart-solar">
					<ul>
						<li><a href="#tab-chart-solar-hi">high confidence (>0.75)</a></li>
						<li><a href="#tab-chart-solar-mid">mid confidence (>0.5)</a></li>
						<li><a href="#tab-chart-solar-low">low confidence (>0.1)</a></li>
					</ul>
					<div id="tab-chart-solar-hi">
						<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='solar cycle']" mode="chart"/>
					</div>
					<div id="tab-chart-solar-mid">
						<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='solar cycle']" mode="chart"/>
					</div>
					<div id="tab-chart-solar-low">
						<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='solar cycle']" mode="chart"/>
					</div>
				</div>
				<div id="tab-chart-lunar">
					<ul>
						<li><a href="#tab-chart-lunar-hi">high confidence (>0.75)</a></li>
						<li><a href="#tab-chart-lunar-mid">mid confidence (>0.5)</a></li>
						<li><a href="#tab-chart-lunar-low">low confidence (>0.1)</a></li>
					</ul>
					<div id="tab-chart-lunar-hi">
						<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='lunar cycle']" mode="chart"/>
					</div>
					<div id="tab-chart-lunar-mid">
						<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='lunar cycle']" mode="chart"/>
					</div>
					<div id="tab-chart-lunar-low">
						<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='lunar cycle']" mode="chart"/>
					</div>
				</div>
				<div id="tab-chart-seasonal">
					<ul>
						<li><a href="#tab-chart-seasonal-hi">high confidence (>0.75)</a></li>
						<li><a href="#tab-chart-seasonal-mid">mid confidence (>0.5)</a></li>
						<li><a href="#tab-chart-seasonal-low">low confidence (>0.1)</a></li>
					</ul>
					<div id="tab-chart-seasonal-hi">
						<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='seasonal cycle']" mode="chart"/>
					</div>
					<div id="tab-chart-seasonal-mid">
						<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='seasonal cycle']" mode="chart"/>
					</div>
					<div id="tab-chart-seasonal-low">
						<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='seasonal cycle']" mode="chart"/>
					</div>
				</div>
			</div>
			<div id="tab-table">
				<ul>
					<li><a href="#tab-table-solar">solar cycle</a></li>
					<li><a href="#tab-table-lunar">lunar cycle</a></li>
					<li><a href="#tab-table-seasonal">seasonal cycle</a></li>
				</ul>
				<div id="tab-table-solar">
					<ul>
						<li><a href="#tab-table-solar-hi">high confidence (>0.75)</a></li>
						<li><a href="#tab-table-solar-mid">mid confidence (>0.5)</a></li>
						<li><a href="#tab-table-solar-low">low confidence (>0.1)</a></li>
					</ul>
					<div id="tab-table-solar-hi">
						<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='solar cycle']" mode="table"/>
					</div>
					<div id="tab-table-solar-mid">
						<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='solar cycle']" mode="table"/>
					</div>
					<div id="tab-table-solar-low">
						<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='solar cycle']" mode="table"/>
					</div>
				</div>
				<div id="tab-table-lunar">
					<ul>
						<li><a href="#tab-table-lunar-hi">high confidence (>0.75)</a></li>
						<li><a href="#tab-table-lunar-mid">mid confidence (>0.5)</a></li>
						<li><a href="#tab-table-lunar-low">low confidence (>0.1)</a></li>
					</ul>
					<div id="tab-table-lunar-hi">
						<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='lunar cycle']" mode="table"/>
					</div>
					<div id="tab-table-lunar-mid">
						<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='lunar cycle']" mode="table"/>
					</div>
					<div id="tab-table-lunar-low">
						<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='lunar cycle']" mode="table"/>
					</div>
				</div>
				<div id="tab-table-seasonal">
					<ul>
						<li><a href="#tab-table-seasonal-hi">high confidence (>0.75)</a></li>
						<li><a href="#tab-table-seasonal-mid">mid confidence (>0.5)</a></li>
						<li><a href="#tab-table-seasonal-low">low confidence (>0.1)</a></li>
					</ul>
					<div id="tab-table-seasonal-hi">
						<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='seasonal cycle']" mode="table"/>
					</div>
					<div id="tab-table-seasonal-mid">
						<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='seasonal cycle']" mode="table"/>
					</div>
					<div id="tab-table-seasonal-low">
						<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='seasonal cycle']" mode="table"/>
					</div>
				</div>
			</div>
		</div>
	</xsl:template>
<!-- =========================================================================================== -->
</xsl:stylesheet>
