<cfparam name="url.fullPage" default="true">
<cfset ASSETS_DIR = expandPath( "/testbox/system/reports/assets" )>
<cfoutput>
	<cfif url.fullPage>
		<!DOCTYPE html>
		<html>
			<head>
				<meta charset="utf-8">
				<meta name="generator" content="TestBox v#testbox.getVersion()#">
				<title>Pass: #results.getTotalPass()# Fail: #results.getTotalFail()# Errors: #results.getTotalError()#</title>
				<style>#fileRead( "#ASSETS_DIR#/css/bootstrap.min.css" )#</style>
				<script>#fileRead( "#ASSETS_DIR#/js/jquery-3.3.1.min.js" )#</script>
				<script>#fileRead( "#ASSETS_DIR#/js/popper.min.js" )#</script>
				<script>#fileRead( "#ASSETS_DIR#/js/bootstrap.min.js" )#</script>
				<script>#fileRead( "#ASSETS_DIR#/js/stupidtable.min.js" )#</script>
				<script>#fileRead( "#ASSETS_DIR#/js/fontawesome.js" )#</script>
			</head>
			<body>
	</cfif>
				<div class="container-fluid my-3">
					<!--- Filter--->
					<div class="row clearfix">
						<div class="col-5">
							<!--- Header --->
							<p>
								<img src="data:image/png;base64, #toBase64( fileReadBinary( '#ASSETS_DIR#/images/TestBoxLogo125.png' ) )#" height="75">
								<span class="badge badge-info">v#testbox.getVersion()#</span>
							</p>
						</div>
						<div class="col-7">
							<input class="d-inline col-7 ml-2 form-control float-right mb-2 mt-4" type="text" name="bundleFilter" id="bundleFilter" placeholder="Filter Bundles..." size="35">
						</div>
					</div>
					<!--- Stats --->
					<!--- Code Coverage Stats --->
					<cfif results.getCoverageEnabled()>
						#testbox.getCoverageService().renderStats( results.getCoverageData(), false )#
					</cfif>
					<div class="list-group">
						<!--- Test Results Stats --->
						<div class="list-group-item list-group-item-info" id="globalStats">
							<div class="buttonBar">
								<a class="m-1 btn btn-sm btn-primary float-right" href="#variables.baseURL#&directory=#URLEncodedFormat( URL.directory )#&opt_run=true" title="Run all tests">Run All Tests</a>
								<button id="collapse-bundles" class="m-1 btn btn-sm btn-primary float-right" title="Collapse all bundles">Collapse All Bundles</button>
								<button id="expand-bundles" class="m-1 btn btn-sm btn-primary float-right" title="Expand all bundles">Expand All Bundles</button>
							</div>
							<h2>Test Results Stats (#results.getTotalDuration()# ms)</h2>
							<div class="float-right">
								<span class="specStatus m-1 btn btn-sm btn-success passed" data-status="passed"><i class="fas fa-check"></i> Pass: #results.getTotalPass()#</span>
								<span class="specStatus m-1 btn btn-sm btn-warning failed" data-status="failed"><i class="fas fa-exclamation-triangle"></i> Failures: #results.getTotalFail()#</span>
								<span class="specStatus m-1 btn btn-sm btn-danger error" data-status="error"><i class="fas fa-times"></i> Errors: #results.getTotalError()#</span>
								<span class="specStatus m-1 btn btn-sm btn-secondary skipped" data-status="skipped"><i class="fas fa-minus-circle"></i> Skipped: #results.getTotalSkipped()#</span>
								<span class="reset m-1 btn btn-sm btn-dark" title="Clear status filters">Reset</span>
							</div>
							<h5 class="mt-2">
								<span>Bundles:<span class="badge badge-info ml-1">#results.getTotalBundles()#</span></span>
								<span class="ml-3">Suites:<span class="badge badge-info ml-1">#results.getTotalSuites()#</span></span>
								<span class="ml-3">Specs:<span class="badge badge-info ml-1">#results.getTotalSpecs()#</span></span>
							</h5>
							<cfif arrayLen( results.getLabels() )>
								<h5 class="mt-2 mb-0">
									<span>Labels Applied: <span class="badge badge-info ml-1">#arrayToList( results.getLabels() )#</u></span>
								</h5>
							</cfif>
							<cfif arrayLen( results.getExcludes() )>
								<h5 class="mt-2 mb-0">
									<span>Excludes Applied: <span class="badge badge-info ml-1">#arrayToList( results.getExcludes() )#</u></span>
								</h5>
							</cfif>
						</div>
						<div class="list-group-item list-group-item-info accordion" id="bundles">
							<!--- Bundle Info --->
							<cfloop array="#variables.bundleStats#" index="thisBundle">
								<!--- Skip if not in the includes list --->
								<cfif len( url.testBundles ) and !listFindNoCase( url.testBundles, thisBundle.path )>
									<cfcontinue>
								</cfif>
								<!--- Bundle div --->
								<div class="bundle card" id="#thisBundle.path#" data-bundle="#thisBundle.path#">
									<div class="card-header" id="header_#thisBundle.id#">
										<h4 class="mb-0 clearfix">
											<!--- bundle stats --->
											<a class="alert-link" href="#variables.baseURL#&directory=#URLEncodedFormat( URL.directory )#&testBundles=#URLEncodedFormat( thisBundle.path )#&opt_run=true" title="Run only this bundle">
												#thisBundle.path# (#thisBundle.totalDuration# ms)
											</a>
											<button class="btn btn-link float-right py-0" style="text-decoration: none;" type="button" data-toggle="collapse" data-target="##details_#thisBundle.id#" aria-expanded="false" aria-controls="details_#thisBundle.id#">
												<span class="arrow" aria-hidden="true"></span>
											</button>
										</h4>
										<div class="float-right">
											<span class="specStatus m-1 btn btn-sm btn-success passed" data-status="passed" data-bundleid="#thisBundle.id#"><i class="fas fa-check"></i> Pass: #thisBundle.totalPass#</span>
											<span class="specStatus m-1 btn btn-sm btn-warning failed" data-status="failed" data-bundleid="#thisBundle.id#"><i class="fas fa-exclamation-triangle"></i> Failures: #thisBundle.totalFail#</span>
											<span class="specStatus m-1 btn btn-sm btn-danger error" data-status="error" data-bundleid="#thisBundle.id#"><i class="fas fa-times"></i> Errors: #thisBundle.totalError#</span>
											<span class="specStatus m-1 btn btn-sm btn-secondary skipped" data-status="skipped" data-bundleid="#thisBundle.id#"><i class="fas fa-minus-circle"></i> Skipped: #thisBundle.totalSkipped#</span>
											<span class="reset m-1 btn btn-sm btn-dark" title="Clear status filters">Reset</span>
										</div>
										<h5 class="d-inline-block mt-2">
											<span>Suites:<span class="badge badge-info ml-1">#thisBundle.totalSuites#</span></span>
											<span class="ml-3">Specs:<span class="badge badge-info ml-1">#thisBundle.totalSpecs#</span></span>
										</h5>
									</div>
									<div id="details_#thisBundle.id#" class="collapse details-panel show" aria-labelledby="header_#thisBundle.id#" data-bundle="#thisBundle.path#">
										<div class="card-body">
											<ul class="suite list-group">
												<!--- Global Exception --->
												<cfif !isSimpleValue( thisBundle.globalException )>
													<li class="list-group-item list-group-item-danger">
														<span class="h5">
															<strong><i class="fas fa-times"></i> Global Bundle Exception</strong>(#thisBundle.totalDuration# ms)
														</span>
														<button class="btn btn-link float-right py-0 expand-collapse collapsed" style="text-decoration: none;" id="btn_globalException_#thisBundle.id#" onclick="toggleDebug( 'globalException_#thisBundle.id#' )" title="Show more information">
															<span class="arrow" aria-hidden="true"></span>
														</button>
														<div>#thisBundle.globalException.Message#</div>
														<div class="pl-5">
															<cfif structKeyExists( thisBundle.globalException.TagContext[ 1 ], "codePrintHTML" )>
																<code>#thisBundle.globalException.TagContext[ 1 ].codePrintHTML#</code>
															</cfif>
														</div>
														<div class="my-2 debugdata" style="display:none;" data-specid="globalException_#thisBundle.id#">
															<cfdump var="#thisBundle.globalException#" />
														</div>
													</li>
												</cfif>
												<!-- Iterate over bundle suites -->
												<cfloop array="#thisBundle.suiteStats#" index="suiteStats">
													#genSuiteReport( suiteStats, thisBundle )#
												</cfloop>
												<!--- Debug Panel --->
												<cfif arrayLen( thisBundle.debugBuffer )>
													<li class="list-group-item list-group-item-info">
														<span class="alert-link h5">
															<strong><i class="fas fa-bug"></i> Debug Stream</strong>
														</span>
														<button class="btn btn-link float-right py-0 expand-collapse collapsed" style="text-decoration: none;" id="btn_#thisBundle.id#" onclick="toggleDebug( '#thisBundle.id#' )" title="Toggle the test debug stream">
															<span class="arrow" aria-hidden="true"></span>
														</button>
														<div class="my-2 debugdata" style="display:none;" data-specid="#thisBundle.id#">
															<p>The following data was collected in order as your tests ran via the <em>debug()</em> method:</p>
															<cfloop array="#thisBundle.debugBuffer#" index="thisDebug">
																<h6>#thisDebug.label#</h6>
																<cfdump var="#thisDebug.data#" label="#thisDebug.label# - #dateFormat( thisDebug.timestamp, " short" )# at #timeFormat( thisDebug.timestamp, "full" )#" top="#thisDebug.top#" />
															</cfloop>
														</div>
													</li>
												</cfif>
											</ul>
										</div>
									</div>
								</div>
							</cfloop>
						</div>
					</div>
				</div>
</cfoutput>
<script>
$( document ).ready( function() {
	// spec toggler
	$( "span.specStatus" ).click( function() {
		$( this ).parent().children().removeClass( "active" );
		$( this ).addClass( "active" );
		toggleSpecs( $( this ).attr( "data-status" ), $( this ).attr( "data-bundleid" ) );
	});

	// spec reseter
	$( "span.reset" ).click(function() {
		resetSpecs();
	});

	// Filter Bundles
	$( "#bundleFilter" ).keyup( debounce( function() {
		var targetText = $( this ).val().toLowerCase();
		$( ".bundle" ).each( function( index ) {
			var bundle = $( this ).data( "bundle" ).toLowerCase();
			if ( bundle.search( targetText ) < 0 ) {
				// hide it
				$( this ).hide();
			} else {
				$( this ).show();
			}
		});
	}, 100));

	$( "#bundleFilter" ).focus();

	// Bootstrap Collapse
	$( "#collapse-bundles" ).click( function() {
		$( ".details-panel.show" ).collapse( "hide" );
	});

	$( "#expand-bundles" ).click(function() {
		$( ".details-panel:not(.show)" ).collapse( "show" );
	});
});

function debounce( func, wait, immediate ) {
	var timeout;
	return function() {
		var context = this,
			args = arguments;
		var later = function() {
			timeout = null;
			if ( !immediate ) {
				func.apply( context, args );
			}
		};
		var callNow = immediate && !timeout;
		clearTimeout( timeout );
		timeout = setTimeout( later, wait );
		if ( callNow ) {
			func.apply( context, args );
		}
	};
};

function resetSpecs() {
	$( "li.spec" ).each( function() {
		$( this ).show();
	});
	$( "ul.suite" ).each(function() {
		$( this ).show();
	});
}

function toggleSpecs( type, bundleID ) {
	$( "ul.suite" ).each( function() {
		handleToggle( $( this ), bundleID, type );
	});
	$( "li.spec" ).each( function() {
		handleToggle( $( this ), bundleID, type );
	});
}

function handleToggle( target, bundleID, type ) {
	var $this = target;

	// if bundleid passed and not the same bundle, skip
	if ( bundleID != undefined && $this.attr( "data-bundleid" ) != bundleID ) {
		return;
	}
	// toggle the opposite type
	if ( !$this.hasClass( type ) ) {
		$this.hide();
	} else {
		// show the type you sent
		$this.show();
		$this.parents().show();
	}
}

function toggleDebug( specid ) {
	$( `#btn_${specid}` ).toggleClass( "collapsed" );
	$( "div.debugdata" ).each(function() {
		var $this = $( this );

		// if bundleid passed and not the same bundle
		if ( specid != undefined && $this.attr("data-specid") != specid ) {
			return;
		}
		// toggle.
		$this.slideToggle();
	});
}
</script>
<style>
[data-toggle="collapse"] .arrow:before,
.expand-collapse .arrow:before {
	content: "\23EB";
}
[data-toggle="collapse"].collapsed .arrow:before,
.expand-collapse.collapsed .arrow:before {
	content: "\23EC";
}
code {
	color: black !important;
}
</style>
<cfif url.fullPage>
			</body>
		</html>
</cfif>

<cffunction name="statusPlusBootstrapClass" output="false">
	<cfargument name="status">
	<cfset bootstrapClass = "">
	<cfif lcase( arguments.status ) eq "failed">
		<cfset bootstrapClass = "warning failed">
	<cfelseif lcase( arguments.status ) eq "error">
		<cfset bootstrapClass = "danger error">
	<cfelseif lcase( arguments.status ) eq "passed">
		<cfset bootstrapClass = "success passed">
	<cfelseif lcase( arguments.status ) eq "skipped">
		<cfset bootstrapClass = "secondary skipped">
	</cfif>
	<cfreturn bootstrapClass>
</cffunction>

<cffunction name="statusToIcon" output="false">
	<cfargument name="status">
	<cfset icon = "">
	<cfif lcase( arguments.status ) eq "failed">
		<cfset icon = '<i class="fas fa-exclamation-triangle"></i>'>
	<cfelseif lcase( arguments.status ) eq "error">
		<cfset icon = '<i class="fas fa-times"></i>'>
	<cfelseif lcase( arguments.status ) eq "passed">
		<cfset icon = '<i class="fas fa-check"></i>'>
	<cfelseif lcase( arguments.status ) eq "skipped">
		<cfset icon = '<i class="fas fa-minus-circle"></i>'>
	</cfif>
	<cfreturn icon>
</cffunction>

<!--- Recursive Output --->
<cffunction name="genSuiteReport" output="false">
	<cfargument name="suiteStats">
	<cfargument name="bundleStats">
	<cfsavecontent variable="local.report">
		<cfoutput>
			<li class="list-group-item list-group-item-#statusPlusBootstrapClass( suiteStats.status )#" data-bundleid="#suiteStats.bundleID#">
				<!--- Suite Results --->
				<h3>
					<a class="alert-link h5" title="Total: #arguments.suiteStats.totalSpecs# Passed:#arguments.suiteStats.totalPass# Failed:#arguments.suiteStats.totalFail# Errors:#arguments.suiteStats.totalError# Skipped:#arguments.suiteStats.totalSkipped#" href="#variables.baseURL#&directory=#URLEncodedFormat( URL.directory )#&testSuites=#URLEncodedFormat( arguments.suiteStats.name )#&testBundles=#URLEncodedFormat( arguments.bundleStats.path )#&opt_run=true">
						#statusToIcon( arguments.suiteStats.status )# <strong>#arguments.suiteStats.name#</strong>
						(#arguments.suiteStats.totalDuration# ms)
					</a>
				</h3>
				<ul class="list-group">
					<cfloop array="#arguments.suiteStats.specStats#" index="local.thisSpec">
						<!--- Spec Results --->
						<cfset thisSpecStatusClass = statusPlusBootstrapClass( local.thisSpec.status )>

						<li class="spec list-group-item list-group-item-#thisSpecStatusClass#" data-bundleid="#arguments.bundleStats.id#" data-specid="#local.thisSpec.id#">
							<div class="clearfix">
								<a class="alert-link #thisSpecStatusClass#" href="#variables.baseURL#&directory=#URLEncodedFormat( URL.directory )#&testSpecs=#URLEncodedFormat( local.thisSpec.name )#&testBundles=#URLEncodedFormat( arguments.bundleStats.path )#&opt_run=true">
									#statusToIcon( local.thisSpec.status )# #local.thisSpec.name#(#local.thisSpec.totalDuration# ms)
								</a>
								<cfif local.thisSpec.status eq "failed">
									<cfset local.thisSpec.message = local.thisSpec.failMessage>
								</cfif>
								<cfif local.thisSpec.status eq "error">
									<cfset local.thisSpec.message = local.thisSpec.error.message>
								</cfif>
								<cfif structKeyExists( local.thisSpec, "message" )>
									- <strong>#encodeForHTML( local.thisSpec.message )#</strong></a>
									<button class="btn btn-link float-right py-0 expand-collapse collapsed" style="text-decoration: none;" id="btn_#local.thisSpec.id#" onclick="toggleDebug( '#local.thisSpec.id#' )" title="Show more information">
										<span class="arrow" aria-hidden="true"></span>
									</button>
								</cfif>
							</div>
							<cfif structKeyExists( local.thisSpec, "message" )>
								<cfif arrayLen( local.thisSpec.failOrigin )>
									<div>#local.thisSpec.failOrigin[ 1 ].raw_trace#</div>
									<div class="pl-5">
										<cfif structKeyExists( local.thisSpec.failOrigin[ 1 ], "codePrintHTML" )>
											<code>#local.thisSpec.failOrigin[ 1 ].codePrintHTML#</code>
										</cfif>
									</div>
								</cfif>
								<div class="my-2 debugdata" style="display:none;" data-specid="#local.thisSpec.id#">
									<cfdump var="#local.thisSpec.failorigin#" label="Failure Origin">
								</div>
							</cfif>
						</li>
					</cfloop>
					<!--- Do we have nested suites --->
					<cfif arrayLen( arguments.suiteStats.suiteStats )>
						<li class="spec list-group-item list-group-item-#thisSpecStatusClass#" data-bundleid="#arguments.bundleStats.id#">
							<ul class="suite list-group" data-bundleid="#arguments.bundleStats.id#">
								<cfloop array="#arguments.suiteStats.suiteStats#" index="local.nestedSuite">
									#genSuiteReport( local.nestedSuite, arguments.bundleStats )#
								</cfloop>
							</ul>
						</li>
					</cfif>
				</ul>
			</li>
		</cfoutput>
	</cfsavecontent>
	<cfreturn local.report>
</cffunction>