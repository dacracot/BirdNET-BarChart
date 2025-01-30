						<ul>
							<li><a href="#tab-table-day">last day</a></li>
							<li><a href="#tab-table-week">last week</a></li>
							<li><a href="#tab-table-month">last month</a></li>
							<li><a href="#tab-table-year">last year</a></li>
						</ul>
						<div id="tabs-table-day">
							<ul>
								<li><a href="#tab-table-day-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-table-day-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-table-day-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-table-day-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last day']" mode="table"/>
							</div>
							<div id="tab-table-day-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last day']" mode="table"/>
							</div>
							<div id="tab-table-day-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last day']" mode="table"/>
							</div>
						</div>
						<div id="tabs-table-week">
							<ul>
								<li><a href="#tab-table-week-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-table-week-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-table-week-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-table-week-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last week']" mode="table"/>
							</div>
							<div id="tab-table-week-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last week']" mode="table"/>
							</div>
							<div id="tab-table-week-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last week']" mode="table"/>
							</div>
						</div>
						<div id="tabs-table-month">
							<ul>
								<li><a href="#tab-table-month-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-table-month-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-table-month-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-table-month-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last month']" mode="table"/>
							</div>
							<div id="tab-table-month-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last month']" mode="table"/>
							</div>
							<div id="tab-table-month-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last month']" mode="table"/>
							</div>
						</div>
						<div id="tabs-table-year">
							<ul>
								<li><a href="#tab-table-year-hi">high confidence (0.75)</a></li>
								<li><a href="#tab-table-year-mid">mid confidence (0.5)</a></li>
								<li><a href="#tab-table-year-low">low confidence (0.1)</a></li>
							</ul>
							<div id="tab-table-year-hi">
								<xsl:apply-templates select="set[@confidence='0.75' and @timeframe='last year']" mode="table"/>
							</div>
							<div id="tab-table-year-mid">
								<xsl:apply-templates select="set[@confidence='0.5' and @timeframe='last year']" mode="table"/>
							</div>
							<div id="tab-table-year-low">
								<xsl:apply-templates select="set[@confidence='0.1' and @timeframe='last year']" mode="table"/>
							</div>
						</div>
					</div>
