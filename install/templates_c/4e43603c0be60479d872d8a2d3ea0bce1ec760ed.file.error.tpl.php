<?php /* Smarty version Smarty-3.1.15, created on 2015-05-04 14:18:55
         compiled from "/home/bizlogicdev/public_html/pmgd.info/install/templates/default/html/error/error.tpl" */ ?>
<?php /*%%SmartyHeaderCode:4023736255477fcf65b036-80244225%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '4e43603c0be60479d872d8a2d3ea0bce1ec760ed' => 
    array (
      0 => '/home/bizlogicdev/public_html/pmgd.info/install/templates/default/html/error/error.tpl',
      1 => 1430742642,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '4023736255477fcf65b036-80244225',
  'function' => 
  array (
  ),
  'variables' => 
  array (
    'errors' => 0,
    'errorMessage' => 0,
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_55477fcf7c4815_06361523',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_55477fcf7c4815_06361523')) {function content_55477fcf7c4815_06361523($_smarty_tpl) {?><?php if (!is_callable('smarty_function_math')) include '/home/bizlogicdev/public_html/pmgd.info/install/includes/classes/Smarty/plugins/function.math.php';
?><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="CONTENT-TYPE" content="text/html; charset=utf-8"/>
	<meta http-equiv="CONTENT-LANGUAGE" content="EN"/>				
	<meta http-equiv="Cache-Control" content="no-cache/"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Expires" content="-1"/>
	<meta name="robots" content="noindex, nofollow">
		
	<title><?php echo @constant('APP_NAME');?>
 &mdash; Installer [BizLogic]</title>
			
	<script type="text/javascript">
		var BASEURL					= '<?php echo @constant('BASEURL');?>
';
		var BASEDIR					= '<?php echo @constant('BASEDIR');?>
';
		var DEBUG					= true;
		var DEFAULT_PRELOADER_IMAGE = '<?php echo @constant('DEFAULT_PRELOADER_IMAGE');?>
';
		var CURRENT_THEME 			= '<?php echo $_SESSION['theme'];?>
';
		var GOOD_STEPS				= new Array();
		var TAB_INDEX				= null;
		var DB_ERROR				= true;
		var DATA_WARN				= false;
		var DATA_IMPORTED			= false;
		var INSTALL_SQL				= '<?php echo @constant('INSTALL_SQL');?>
';
		var WIZARD					= null;
		
		<?php if (!strlen($_SESSION['theme'])) {?>
			CURRENT_THEME = '<?php echo @constant('DEFAULT_JQUERY_UI_THEME');?>
';
		<?php }?>		
	</script>	
	    
    <!-- php.js -->
	<script src="<?php echo @constant('BASEURL');?>
/js/phpjs.js?<?php echo smarty_function_math(array('equation'=>'rand()'),$_smarty_tpl);?>
" type="text/javascript"></script>
		
	<link rel="stylesheet" href="<?php echo @constant('BASEURL');?>
/css/bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.19/themes/base/jquery-ui.css">		
	<link rel="stylesheet" href="<?php echo @constant('BASEURL');?>
/css/custom.css?<?php echo smarty_function_math(array('equation'=>'rand()'),$_smarty_tpl);?>
">	
	<link href="../css/font-awesome.min.css" rel="stylesheet">	
	
	<?php switch (mb_strtolower($_SESSION['theme'], 'UTF-8')){?>
<?php case "absolution":?>
		<?php case "aristo":?>
		<?php case "delta":?>
		<?php case "selene":?>
			<link rel="stylesheet" href="<?php echo @constant('BASEURL');?>
/css/jquery-ui/<?php echo $_SESSION['themeString'];?>
/jquery-ui.css">
		<?php break;?>

		<?php default:?>
			<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.19/themes/<?php echo $_SESSION['themeString'];?>
/jquery-ui.css">
	<?php }?>
	
	<script src="<?php echo @constant('BASEURL');?>
/js/jquery-1.7.2.min.js" type="text/javascript"></script>
    <script src="<?php echo @constant('BASEURL');?>
/js/jquery-ui-1.8.19.custom.min.js" type="text/javascript"></script>          
	<script type="text/javascript" src="<?php echo @constant('BASEURL');?>
/js/jquery.imgpreload.min.js"></script>
	<script type="text/javascript" src="<?php echo @constant('BASEURL');?>
/js/imagesloaded.pkgd.min.js"></script>                
    <script src="<?php echo @constant('BASEURL');?>
/js/consolelog.min.js" type="text/javascript"></script>
    
    <!--  blockUI -->
    <script src="<?php echo @constant('BASEURL');?>
/js/jquery.blockUI.js" type="text/javascript"></script>
    <script src="<?php echo @constant('BASEURL');?>
/js/jquery.blockUI.defaults.js" type="text/javascript"></script>
    
    <!--  custom functions -->
    <script src="<?php echo @constant('BASEURL');?>
/js/functions.js?<?php echo smarty_function_math(array('equation'=>'rand()'),$_smarty_tpl);?>
"></script>
    
    <!-- jQuery UI Themeswitcher -->
	<script src="<?php echo @constant('BASEURL');?>
/js/themeswitcher.js?<?php echo smarty_function_math(array('equation'=>'rand()'),$_smarty_tpl);?>
" type="text/javascript"></script>
	
    <script src="<?php echo @constant('BASEURL');?>
/js/bootstrap/bootstrap.min.js" type="text/javascript"></script>
    <script src="<?php echo @constant('BASEURL');?>
/js/bootbox.min.js" type="text/javascript"></script>	
</head>
<body>	
	<div class="center">
		<div id="logo">
			<a href="<?php echo @constant('BASEURL');?>
">
				<?php echo @constant('APP_LOGO_HTML');?>

			</a>
		</div>

		<div class="alert alert-danger">
			<?php  $_smarty_tpl->tpl_vars['errorMessage'] = new Smarty_Variable; $_smarty_tpl->tpl_vars['errorMessage']->_loop = false;
 $_from = $_smarty_tpl->tpl_vars['errors']->value; if (!is_array($_from) && !is_object($_from)) { settype($_from, 'array');}
foreach ($_from as $_smarty_tpl->tpl_vars['errorMessage']->key => $_smarty_tpl->tpl_vars['errorMessage']->value) {
$_smarty_tpl->tpl_vars['errorMessage']->_loop = true;
?>
			    <i class="fa fa-exclamation-triangle"></i> <?php echo $_smarty_tpl->tpl_vars['errorMessage']->value;?>
<br>
			<?php } ?>		
		</div>
		
		<div id="switcher" style="margin-top: 10px; margin-left: 0px; position: fixed;"></div>		
	</div>

	<!--  START:	blockUI on page load -->
	<div style="display: none;" class="blockUI"></div>
	<div style="z-index: 1000; position: fixed;" class="blockUI blockOverlay ui-widget-overlay"></div>
	<div style="z-index: 1011; position: fixed; width: 30%; top: 40%; left: 35%;" class="blockUI blockMsg blockPage ui-dialog ui-widget ui-corner-all ui-widget-content ui-draggable">
		<div class="ui-widget-header ui-dialog-titlebar ui-corner-all blockTitle">Loading</div>
		<div class="ui-widget-content ui-dialog-content">
			<p>Loading, please wait... <img border="0" src="<?php echo @constant('BASEURL');?>
/img/loading.gif"></p>
		</div>
	</div>
	<!--  END:		blockUI on page load -->

		<script type="text/javascript">
			$(document).ready(function() {				
				$.imgpreload([
					BASEURL + '/img/loading.gif' 
				], {
					each: function() {
				        // this = dom image object
				        // check for success with: $(this).data('loaded')
				        // callback executes on every image load
					},
					all: function() {
				        // this = array of dom image objects
				        // check for success with: $(this[i]).data('loaded')
				        // callback executes when all images are loaded
				        $.unblockUI();
					}				
				});								
			});		
		</script>
	</body>
</html><?php }} ?>
