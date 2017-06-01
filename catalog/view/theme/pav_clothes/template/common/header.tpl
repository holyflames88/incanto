<?php 
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Augus 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

 
	$themeConfig = $this->config->get( 'themecontrol' );
	$themeName =  $this->config->get('config_template');
	require_once( DIR_TEMPLATE.$this->config->get('config_template')."/development/libs/framework.php" );
	$helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
	$helper->setDirection( $direction );
	/* Add scripts files */
	$helper->addScript( 'catalog/view/javascript/jquery/jquery-1.7.1.min.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/ui/jquery-ui-1.8.16.custom.min.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/ui/external/jquery.cookie.js' );
	$helper->addScript( 'catalog/view/javascript/common.js' );
	$helper->addScript( 'catalog/view/theme/'.$themeName.'/javascript/common.js' );
	$helper->addScript( 'catalog/view/javascript/jquery/bootstrap/bootstrap.min.js' );
	
	$helper->addScriptList( $scripts );
	
	$helper->addCss( 'catalog/view/javascript/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css' );	
	if( isset($themeConfig['customize_theme']) 
		&& file_exists(DIR_TEMPLATE.$themeName.'/stylesheet/customize/'.$themeConfig['customize_theme'].'.css') ) {  
		$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/customize/'.$themeConfig['customize_theme'].'.css'  );
	}

	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/animation.css' );	
	$helper->addCss( 'catalog/view/theme/'.$themeName.'/stylesheet/font-awesome.min.css' );	
	$helper->addCssList( $styles );
 	$keepHeader = isset($themeConfig['header'])?$themeConfig['header']:"";
 	$layoutMode = $helper->getParam( 'layout' );
 
//
if(isset($_COOKIE["customer_id_cookie"]) && $_COOKIE["customer_id_cookie"]!=''){
	$_SESSION['default']['customer_id']=$_COOKIE["customer_id_cookie"];
?>
<script>
if (sessionStorage.reloadHeader) {
} else {
    sessionStorage.reloadHeader = 1;
	location.reload();
}
</script>
<?php
}
?>
<!DOCTYPE html>
<html dir="<?php echo $helper->getDirection(); ?>" class="<?php echo $helper->getDirection(); ?>" lang="<?php echo $lang; ?>">
<head>
<!-- Mobile viewport optimized: h5bp.com/viewport -->
<meta name="viewport" content="width=device-width">
<meta charset="UTF-8" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>?<?php echo rand(1,999999); ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<?php foreach ($helper->getCssLinks() as $link) { ?>
<link href="<?php echo $link['href']; ?>?<?php echo rand(1,999999); ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
	<?php if( $themeConfig['theme_width'] &&  $themeConfig['theme_width'] != 'auto' ) { ?>
			<style> #page-container .container{max-width:<?php echo $themeConfig['theme_width'];?>; width:auto}</style>
	<?php } ?>
	
	<?php if( isset($themeConfig['use_custombg']) && $themeConfig['use_custombg'] ) {	?>
	<style> 
		body{
			background:url( "image/<?php echo $themeConfig['bg_image'];?>") <?php echo $themeConfig['bg_repeat'];?>  <?php echo $themeConfig['bg_position'];?> !important;
		}</style>
	<?php } ?>
<?php 
	if( isset($themeConfig['enable_customfont']) && $themeConfig['enable_customfont'] ){
	$css=array();
	$link = array();
	for( $i=1; $i<=3; $i++ ){
		if( trim($themeConfig['google_url'.$i]) && $themeConfig['type_fonts'.$i] == 'google' ){
			$link[] = '<link rel="stylesheet" type="text/css" href="'.trim($themeConfig['google_url'.$i]) .'"/>';
			$themeConfig['normal_fonts'.$i] = $themeConfig['google_family'.$i];
		}
		if( trim($themeConfig['body_selector'.$i]) && trim($themeConfig['normal_fonts'.$i]) ){
			$css[]= trim($themeConfig['body_selector'.$i])." {font-family:".str_replace("'",'"',htmlspecialchars_decode(trim($themeConfig['normal_fonts'.$i])))."}\r\n"	;
		}
	}
	echo implode( "\r\n",$link );
?>
<style>
	<?php echo implode("\r\n",$css);?>
</style>
<?php } else { ?>

<?php if (isset($_SERVER['HTTPS']) && (($_SERVER['HTTPS'] == 'on') || ($_SERVER['HTTPS'] == '1'))) { ?>
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,700,300,500,300italic,400italic,500italic&subset=latin,cyrillic-ext' rel='stylesheet' type='text/css'>
	<link href='https://fonts.googleapis.com/css?family=Bad+Script&subset=cyrillic,latin' rel='stylesheet' type='text/css'>
<?php } else { ?>
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300,500,300italic,400italic,500italic&subset=latin,cyrillic-ext' rel='stylesheet' type='text/css'>
	<link href='http://fonts.googleapis.com/css?family=Bad+Script&subset=cyrillic,latin' rel='stylesheet' type='text/css'>
<?php } ?>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/dbassa_intelligent_product_labels.css" />
<?php } ?>
<?php foreach( $helper->getScriptFiles() as $script )  { ?>
<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>
<?php if( isset($themeConfig['enable_paneltool']) && $themeConfig['enable_paneltool'] ){  ?>
<link  href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/paneltool.css" rel="stylesheet"/>
<script type="text/javascript" src="catalog/view/javascript/jquery/colorpicker/js/colorpicker.js"></script>
<link  href="catalog/view/javascript/jquery/colorpicker/css/colorpicker.css" rel="stylesheet" />
<?php } ?>
<?php if( isset($themeConfig['custom_javascript'])  && !empty($themeConfig['custom_javascript']) ){ ?>
	<script type="text/javascript"><!--
		$(document).ready(function() {
			<?php echo html_entity_decode(trim( $themeConfig['custom_javascript']) ); ?>
		});
//--></script>
<?php }	?>

<!--[if lt IE 9]>
<?php if( isset($themeConfig['load_live_html5'])  && $themeConfig['load_live_html5'] ) { ?>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<?php } else { ?>
<script src="catalog/view/javascript/html5.js"></script>
<?php } ?>
<script src="catalog/view/javascript/respond.min.js"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/theme/<?php echo $themeName;?>/stylesheet/ie8.css" />
<![endif]-->

<?php if ( isset($stores) && $stores ) { ?>
<script type="text/javascript"><!--
$(document).ready(function() {
<?php foreach ($stores as $store) { ?>
$('body').prepend('<iframe src="<?php echo $store; ?>" style="display: none;"></iframe>');
<?php } ?>
});
//--></script>
<?php } ?>
<?php echo $google_analytics; ?>
</head>
<body id="offcanvas-container" class="offcanvas-container layout-<?php echo $layoutMode; ?> <?php echo $keepHeader; ?> fs<?php echo $themeConfig['fontsize'];?> <?php echo $helper->getPageClass();?> <?php echo $helper->getParam('body_pattern','');?> lang-<?php echo $lang; ?>">
<div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/uk_UA/sdk.js#xfbml=1&version=v2.6";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<section id="page" class="offcanvas-pusher" role="main">
<section id="header">
		<section id="topbar" class="topbar clearfix">
			<div class="container">
					<div class="pull-left hidden-sm hidden-xs">
						<ul class="links">
							<!-- <li><a class="first" href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li> -->
							<li  class="login"><?php if (!$logged) { ?>
								<?php echo $text_welcome; ?>
								<?php } else { ?>
								<?php echo $text_logged; ?>
								<?php } ?>
							</li>
							<li><a class="account" href="<?php echo $account; ?>"><span class="icon fa fa-user"></span><span class="text-link hidden-xs hidden-sm"><?php echo $text_account; ?></span></a></li>
							
							<li><a class="wishlist" href="<?php echo $wishlist; ?>" id="wishlist-total"><span class="icon fa fa-heart"></span><span class="text-link hidden-xs hidden-sm"><?php echo $text_wishlist; ?></span></a></li>
							

							<!--<li><a class="shoppingcart" href="<?php echo $shopping_cart; ?>"><span class="icon fa fa-dollar"></span><span class="text-link hidden-xs hidden-sm"><?php echo $text_shopping_cart; ?></span></a></li>-->
							<!--<li><a class="last checkout" href="<?php echo $checkout; ?>"><span class="icon fa fa-file"></span><span class="text-link hidden-xs hidden-sm"><?php echo $text_checkout; ?></span></a></li> -->


						</ul>
					</div>
					<div class="pull-right">

					
<div id="languages" class="language pull-left hidden-sm hidden-xs">
	<form  method="post" enctype="multipart/form-data">
		<ul>
			<li class="btn-group">
				<button class="btn btn-theme-normal dropdown-toggle" data-toggle="dropdown">
					<span class="text-label">Информация</span> <span class="fa fa-sort-asc"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="/index.php?route=information/information&amp;information_id=6">Доставка и оплата</a></li>
					<li><a href="index.php?route=information/information&amp;information_id=5">Обмен и возврат</a></li>
					<li><a href="index.php?route=information/information&amp;information_id=9">Как сделать заказ</a></li>
					<li><a href="index.php?route=information/information&amp;information_id=3">Как узнать свой размер</a></li>
					<li><a href="index.php?route=information/information&amp;information_id=8">Всё про бюстгальтер</a></li>
					<li><a href="/index.php?route=information/information&amp;information_id=11">Выбираем купальник</a></li>
					<li><a href="index.php?route=information/information&amp;information_id=10">Виды тканей в белье</a></li>
				</ul>
			</li>
		</ul>    
	</form>
</div>
					
					
						<div id="language" class="language pull-left hidden-sm hidden-xs">
							<?php //echo $language; ?>
						</div>
						
						<div id="currency" class="currency pull-left hidden-sm hidden-xs">
							<?php //echo $currency; ?>
						</div> 													
					</div>
				
				<div class="show-mobile hidden-lg hidden-md pull-right">
					<div class="quick-user pull-left">
						<div class="quickaccess-toggle">
							<i class="fa fa-user"></i>															
						</div>	
						<div class="inner-toggle">
							<div class="login links">
								<?php if (!$logged) { ?>
								<?php echo $text_welcome; ?>
								<?php } else { ?>
								<?php echo $text_logged; ?>
								<?php } ?> 
							</div>
						</div>						
					</div>
					<div class="quick-access pull-left">
						<div class="quickaccess-toggle">
							<i class="fa fa-list"></i>															
						</div>	
						<div class="inner-toggle">
							<ul class="links pull-left">
								<!-- <li><a class="first" href="<?php echo $home; ?>"><?php echo $text_home; ?></a></li> -->
								
								<li><a class="wishlist" href="<?php echo $wishlist; ?>" id="mobile-wishlist-total"><span class="fa fa-heart"></span><?php echo $text_wishlist; ?></a></li>
								
								<li><a class="shoppingcart" href="<?php echo $shopping_cart; ?>"><span class="fa fa-shopping-cart"></span><?php echo $text_shopping_cart; ?></a></li>
								<li><a class="last checkout" href="<?php echo $checkout; ?>"><span class="fa fa-file"></span><?php echo $text_checkout; ?></a></li>
								<li><a class="account" href="<?php echo $account; ?>"><span class="fa fa-user"></span><?php echo $text_account; ?></a></li>						 		
							</ul>
						</div>						
					</div>
					<div id="search_mobile" class="search pull-left">				
						<div class="quickaccess-toggle">
							<i class="fa fa-search"></i>								
						</div>																								
						<div class="inner-toggle">						
							<div id="search-mobile" class="btn">
								<input type="text" name="search1" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
								<span class="button-search"></span>
							</div>
						</div>
					</div>
					<div class="support pull-left">
						<div class="quickaccess-toggle">
							<i class="fa fa-sun-o"></i>								
						</div>						
						<div class="inner-toggle">
							<div id="mobile-currency" class="currency pull-left">
								<?php echo $currency; ?>
							</div> 
							<div id="mobile-language" class="language pull-left">
								<?php echo $language; ?>
							</div>
						</div>														
					</div>			
				</div>

			</div>
		</section>
		<section id="header-main">
			<div class="container">
				<div class="header-wrap">
					<div class="pull-left inner">
						<div class="pull-left inner">
							<?php if ($logo) { ?>
							<div id="logo"><a href="<?php echo $home; ?>"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" /></a></div>
							<?php } ?>

						</div>						
						<div class="pull-left inner" id="phones">
							(067) 603-00-08<br>(050) 603-05-03<br>(063) 200-03-05
						</div>						
						<div class="pull-left inner" id="chat">
						  <a href="https://siteheart.com/webconsultation/664226?" target="siteheart_sitewindow_664226" onclick="o=window.open;o('https://siteheart.com/webconsultation/664226?', 'siteheart_sitewindow_664226', 'width=550,height=400,top=30,left=30,resizable=yes'); return false;"><span class="online-chat-header"><?php echo $text_online_chat; ?></span></a>
						</div>
						
						
						<div class="pull-right inner">
							<div id="search" class="btn pull-left hidden-sm hidden-xs">
								<input type="text" name="search" placeholder="<?php echo $text_search; ?>" value="<?php echo $search; ?>" />
								<span class="button-search"></span>
							</div>
						</div>	


						
					</div>
					<div class="pull-right inner">
						<?php echo $cart; ?>
					</div>
				</div>
				
			</div>
									<div class="main_menu">
						<section id="pav-mainnav">
								<div class="container">
							 		<div class="navbar navbar-inverse "> 
											<?php 
											/**
											 * Main Menu modules: as default if do not put megamenu, the theme will use categories menu for main menu
											 */
											$modules = $helper->getModulesByPosition( 'mainmenu' ); 
											if( count($modules) && !empty($modules) ){ 

											?>

												<?php foreach ($modules as $module) { ?>
													<?php echo $module; ?>
												<?php } ?>

											<?php } elseif ($categories) {  ?>
													<div class="navbar-header">
														<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
														<span class="sr-only">Toggle navigation</span>
														<span class="icon-bar"></span>
														<span class="icon-bar"></span>
														<span class="icon-bar"></span>
														</button>
													</div>

											  <div class="collapse navbar-collapse navbar-ex1-collapse">
														  <ul class="nav navbar-nav">
													  	<li><a href="<?php echo $home; ?>" title="<?php echo $this->language->get('text_home');?>"><?php echo $this->language->get('text_home');?></a></li>
														<?php foreach ($categories as $category) { ?>
														
														<?php if ($category['children']) { ?>			
														<li class="parent dropdown deeper "><a href="<?php echo $category['href'];?>" class="dropdown-toggle" data-toggle="dropdown"><?php echo $category['name']; ?>
														<b class="caret"></b>
														</a>
														<?php } else { ?>
														<li ><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
														<?php } ?>
														<?php if ($category['children']) { ?>
														  <ul class="dropdown-menu">
															<?php for ($i = 0; $i < count($category['children']);) { ?>
															
															  <?php $j = $i + ceil(count($category['children']) / $category['column']); ?>
															  <?php for (; $i < $j; $i++) { ?>
															  <?php if (isset($category['children'][$i])) { ?>
															  <li><a href="<?php echo $category['children'][$i]['href']; ?>"><?php echo $category['children'][$i]['name']; ?></a></li>
															  <?php } ?>
															  <?php } ?>
															
															<?php } ?>
														</ul>
														  <?php } ?>
														</li>
														<?php } ?>
													  </ul>
												</div>	   
											
											<?php } ?>
									</div>
								</div>		
							</section>	
						</div>	
		</section>
</section>


<?php
/**
 * Slideshow modules
 */
$modules = $helper->getModulesByPosition( 'slideshow' ); 
if( $modules ){
?>
<section id="pav-slideshow" class="pav-slideshow hidden-xs">
		<?php foreach ($modules as $module) { ?>
			<?php echo $module; ?>
		<?php } ?>
</section>
<?php } ?>


<section id="sys-notification">
	<div class="container">
		<?php if ($error) { ?>    
    		<div class="warning"><?php echo $error ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
    	<?php } ?>
		<div id="notification"></div>
	</div>
</section>

<?php if( isset($themeConfig['enable_offsidebars']) && $themeConfig['enable_offsidebars'] ) { ?>
<section id="columns" class="offcanvas-siderbars"><div class="container">
<div class="row visible-xs">
	<div class="container"> 
		<div class="offcanvas-sidebars-buttons">
			<button type="button" data-for="column-left" class="pull-left btn btn-danger"><i class="glyphicon glyphicon-indent-left"></i> <?php echo $this->language->get('text_sidebar_left'); ?></button>
			
			<button type="button" data-for="column-right" class="pull-right btn btn-danger"><?php echo $this->language->get('text_sidebar_right'); ?> <i class="glyphicon glyphicon-indent-right"></i></button>
		</div>
	</div>
</div>
<?php }else { ?>
<section id="columns"><div class="container">
<?php } ?>
<div class="row">