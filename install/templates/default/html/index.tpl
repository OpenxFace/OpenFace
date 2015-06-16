<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"/>
	<meta http-equiv="CONTENT-LANGUAGE" content="EN"/>				
	<meta http-equiv="Cache-Control" content="no-cache/"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Expires" content="-1"/>
	<meta name="robots" content="noindex, nofollow">
		
	<title>{$smarty.const.APP_NAME} &mdash; Installer [BizLogic]</title>
			
	<script type="text/javascript">
		var BASEURL					= '{$smarty.const.BASEURL}';
		var BASEDIR					= '{$smarty.const.BASEDIR}';
		var DEBUG					= true;
		var DEFAULT_PRELOADER_IMAGE = '{$smarty.const.DEFAULT_PRELOADER_IMAGE}';
		var CURRENT_THEME 			= '{$smarty.session.theme}';
		var GOOD_STEPS				= new Array();
		var TAB_INDEX				= null;
		var DB_ERROR				= true;
		var DATA_WARN				= false;
		var DATA_IMPORTED			= false;
		var INSTALL_SQL				= '{$smarty.const.INSTALL_SQL}';
		var WIZARD					= null;
		
		{if !strlen( $smarty.session.theme )}
			CURRENT_THEME = '{$smarty.const.DEFAULT_JQUERY_UI_THEME}';
		{/if}		
	</script>	
	    
    <!-- php.js -->
	<script src="{$smarty.const.BASEURL}/js/phpjs.js?{math equation='rand()'}" type="text/javascript"></script>
		
	<link rel="stylesheet" href="{$smarty.const.BASEURL}/css/bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.19/themes/base/jquery-ui.css">		
	<link rel="stylesheet" href="{$smarty.const.BASEURL}/css/custom.css?{math equation='rand()'}">	
	<link href="../css/font-awesome.min.css" rel="stylesheet">	
	
	{switch $smarty.session.theme|lower}
		{case "absolution"}
		{case "aristo"}
		{case "delta"}
		{case "selene"}
			<link rel="stylesheet" href="{$smarty.const.BASEURL}/css/jquery-ui/{$smarty.session.themeString}/jquery-ui.css">
		{/case}

		{default}
			<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.19/themes/{$smarty.session.themeString}/jquery-ui.css">
	{/switch}
	
	<script src="{$smarty.const.BASEURL}/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="{$smarty.const.BASEURL}/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>
    <script src="{$smarty.const.BASEURL}/js/jquery-validation/jquery.validate.min.js" type="text/javascript"></script>
	<script src="{$smarty.const.BASEURL}/js/jquery-validation/custom-methods.js?{math equation='rand()'}" type="text/javascript"></script>    
      
	<script type="text/javascript" src="{$smarty.const.BASEURL}/js/jquery.imgpreload.min.js"></script>
	<script type="text/javascript" src="{$smarty.const.BASEURL}/js/imagesloaded.pkgd.min.js"></script>    
    
    <script src="{$smarty.const.BASEURL}/js/jquery.observor.js?{math equation='rand()'}" type="text/javascript"></script>        
    <script src="{$smarty.const.BASEURL}/js/consolelog.min.js" type="text/javascript"></script>
    
    <!--  blockUI -->
    <script src="{$smarty.const.BASEURL}/js/jquery.blockUI.js" type="text/javascript"></script>
    <script src="{$smarty.const.BASEURL}/js/jquery.blockUI.defaults.js" type="text/javascript"></script>
    
    <!--  custom functions -->
    <script src="{$smarty.const.BASEURL}/js/functions.js?{math equation='rand()'}"></script>
    
    <!-- jQuery UI Themeswitcher -->
	<script src="{$smarty.const.BASEURL}/js/themeswitcher.js?{math equation='rand()'}" type="text/javascript"></script>
	
    <script src="{$smarty.const.BASEURL}/js/bootstrap/bootstrap.min.js" type="text/javascript"></script>
    <script src="{$smarty.const.BASEURL}/js/bootbox.min.js" type="text/javascript"></script>
	<script src="{$smarty.const.BASEURL}/js/jquery.bootstrap.wizard.js" type="text/javascript"></script>		
</head>
<body>	
	<div class="center">
		<div id="logo">
			<a href="{$smarty.const.BASEURL}">
				{$smarty.const.APP_LOGO_HTML}
			</a>
		</div>
		<div id="installWizard">
			<form name="frmInstaller" id="frmInstaller" action="" method="POST">			
				<ul>
					<li>
						<a href="#permissions" data-toggle="tab">
							<span class="label">1</span> File Permissions
						</a>
					</li>
					<li>
						<a href="#adminCredentials" data-toggle="tab">
							<span class="label">2</span> Admin Credentials
						</a>
					</li>
					<li>
						<a href="#dbConnection" data-toggle="tab">
							<span class="label">3</span> Database Connection
						</a>
					</li>
					<li>
						<a id="linkDataImport" href="#dataImport" data-toggle="tab">
							<span class="label">4</span> Data Import
						</a>
					</li>
				</ul>	
				<div class="progress progress-striped active">
					<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="">
						<span class="sr-only"></span>
					</div>
				</div>							
				<div class="tab-content">
					<div class="tab-pane" id="permissions">	
						{if $permissionErrors|@count gt 0}
							<script type="text/javascript">
								removeFromArray(GOOD_STEPS, 0);						
							</script> 									
							<div class="alert alert-danger">
								<i class="btnPageRefresh fa fa-refresh" style="float: right;"></i>
								<i class="fa fa-warning"></i> Please CHMOD the following files or directories to 0777
							</div>											
							<ol>
							{foreach from=$permissionErrors item=error}
							    <li><i style="color: #A94442;" class="fa fa-warning"></i> {$error}</li>
							{/foreach}
						{else}
							<div class="alert alert-success">
								<i class="fa fa-check"></i> File permissions are OK
								<script type="text/javascript">
									if( !in_array( GOOD_STEPS ) ) {
										GOOD_STEPS.push(0);									
									}					
								</script> 								
							</div>							
						{/if}
						</ol>
					</div>
					<div class="tab-pane" id="adminCredentials">
						<table style="width: 100%;" cellpadding="10">
							<tr>
								<td class="frmLabel">
									Administrator Username:
								</td>
								<td>
									<input type="text" value="" id="adminUsername" name="adminUsername" data-name="Administrator Username" required>								
								</td>								
							</tr>
                            <tr>
                                <td class="frmLabel">
                                    Administrator's e-mail Address:
                                </td>
                                <td>
                                    <input type="text" value="" id="adminEmail" name="adminEmail" data-name="Administrator's e-mail Address" data-type="email" required>                                
                                </td>                               
                            </tr>
                            <tr>
                                <td class="frmLabel">
                                    Confirm Administrator's e-mail Address:
                                </td>
                                <td>
                                    <input type="text" value="" id="adminEmailConfirm" name="adminEmailConfirm" data-name="Confirm the Administrator's e-mail Address" data-type="email" required>                                
                                </td>                               
                            </tr>                            												
							<tr>
								<td class="frmLabel">
									Administrator Password:
								</td>
								<td>
									<input type="password" value="" id="adminPassword" name="adminPassword" required>								
								</td>								
							</tr>
							<tr>
								<td class="frmLabel">
									Confirm Administrator Password:
								</td>
								<td>
									<input type="password" value="" id="adminPasswordConfirm" name="adminPasswordConfirm" required>							
								</td>								
							</tr>													
						</table>					
					</div>
					<div class="tab-pane" id="dbConnection">
						<div class="alert alert-danger" id="dbErrorMessage"></div>
						<div class="alert alert-success" id="dbSuccessMessage"></div>
						
						<table style="width: 100%;" cellpadding="10">
							<tr>
								<td class="frmLabel">
									Database Hostname:
								</td>
								<td>
									<input type="text" value="localhost" id="dbHost" name="dbHost" required>								
								</td>								
							</tr>
							<tr>
								<td class="frmLabel">
									Database Port:
								</td>
								<td>
									<input type="text" value="3306" id="dbPort" name="dbPort" required>								
								</td>								
							</tr>							
							<tr>
								<td class="frmLabel">
									Database Name:
								</td>
								<td>
									<input type="text" value="" id="dbName" name="dbName" required>							
								</td>								
							</tr>
							<tr>
								<td class="frmLabel">
									Database Username:
								</td>
								<td>
									<input type="text" value="" id="dbUsername" name="dbUsername" required>							
								</td>								
							</tr>																					
							<tr>
								<td class="frmLabel">
									Database Password:
								</td>
								<td>
									<input type="password" value="" id="dbPassword" name="dbPassword">								
								</td>								
							</tr>											
						</table>
					</div>
					<div class="tab-pane" id="dataImport">
						<table style="width: 100%;" cellpadding="10">
							<tr>
								<td>				
									<div id="dataImportStatus">
										<iframe src="" id="bigdumpContainer" frameBorder="0"></iframe>									
									</div>
								</td>
							</tr>
							<tr>			
								<td>
									<input type="checkbox" value="0" id="dataLossWarn" name="dataLossWarn" required> I accept all responsibility for any data loss that may occur during this installation								
								</td>								
							</tr>
						</table>					
					</div>					
					<div class="pager">
						<div style="float: right;">
							<input type="button" id="btnWizard-next" class="btnPager btn button-next" name="next" value="Next" data-complete="0" />
							<input type="button" id="btnWizard-prev" class="disabled btnPager btn button-finish" name="finish" value="Finish" />
						</div>
						<div style="float: left;">
							<input type="button" class="btnPager btn button-previous" name="previous" value="Previous" />
						</div>
					</div>
				</div>	
			</form>				
		</div>
		
		<div id="switcher" style="margin-top: 10px; margin-left: 0px; position: fixed;"></div>		
	</div>

	<!--  START:	blockUI on page load -->
	<div style="display: none;" class="blockUI"></div>
	<div style="z-index: 1000; position: fixed;" class="blockUI blockOverlay ui-widget-overlay"></div>
	<div style="z-index: 1011; position: fixed; width: 30%; top: 40%; left: 35%;" class="blockUI blockMsg blockPage ui-dialog ui-widget ui-corner-all ui-widget-content ui-draggable">
		<div class="ui-widget-header ui-dialog-titlebar ui-corner-all blockTitle">Loading</div>
		<div class="ui-widget-content ui-dialog-content">
			<p>Loading, please wait... <img border="0" src="{$smarty.const.BASEURL}/img/loading.gif"></p>
		</div>
	</div>
	<!--  END:		blockUI on page load -->

		<script type="text/javascript">
			$(document).ready(function() {literal}{{/literal}			
				$.imgpreload([
					BASEURL + '/img/loading.gif' 
				], {literal}{{/literal}
					each: function() {literal}{{/literal}
				        // this = dom image object
				        // check for success with: $(this).data('loaded')
				        // callback executes on every image load
					{literal}}{/literal},
					all: function() {literal}{{/literal}
				        // this = array of dom image objects
				        // check for success with: $(this[i]).data('loaded')
				        // callback executes when all images are loaded
					{literal}}{/literal}
				{literal}}{/literal});							
			{literal}}{/literal});		
		</script>
		
	</body>
</html>
