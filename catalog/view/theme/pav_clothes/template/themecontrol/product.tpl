<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" );

  $themeConfig = (array)$this->config->get('themecontrol');
  $productConfig = array(
      'product_enablezoom'         => 1,
      'product_zoommode'           => 'basic',
      'product_zoomeasing'         => 1,
      'product_zoomlensshape'      => "round",
      'product_zoomlenssize'       => "150",
      'product_zoomgallery'        => 0,
      'enable_product_customtab'   => 0,
      'product_customtab_name'     => '',
      'product_customtab_content'  => '',
      'product_related_column'     => 0,
	  'quickview'                  => 0,

  );
  $categoryConfig = array(
	'category_pzoom'			   => 1,
  ); 
  $categoryPzoom 	    = $categoryConfig['category_pzoom']; 
  $productConfig = array_merge( $productConfig, $themeConfig );  
  $quickview          = $productConfig['quickview'];
  $languageID = $this->config->get('config_language_id');   
?>

<?php 
/******************************************************
 * @package Pav Opencart Theme Framework for Opencart 1.5.x
 * @version 1.1
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Augus 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/


$themeConfig = $this->config->get( 'themecontrol' );
$LANGUAGE_ID = $this->config->get( 'config_language_id' ); 
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

$layoutMode = $helper->getParam( 'layout' );

$pageClass =  $helper->getPageClass();
?>
<!DOCTYPE html>
<html dir="<?php echo $helper->getDirection(); ?>" class="<?php echo $helper->getDirection(); ?>" lang="<?php echo $lang; ?>">
<head>
	<!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame -->
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
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
	<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
	<?php } ?>
	<?php foreach ($helper->getCssLinks() as $link) { ?>
	<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
	<?php } ?>

	<?php if( $themeConfig['theme_width'] &&  $themeConfig['theme_width'] != 'auto' ) { ?>
	<style> #page-container .container{max-width:<?php echo $themeConfig['theme_width'];?>; width:auto}</style>
	<?php } ?>

	<?php if( isset($themeConfig['use_custombg']) && $themeConfig['use_custombg'] ) {	?>
	<style> 
		body{
			background:url( "image/<?php echo $themeConfig['bg_image'];?>") <?php echo $themeConfig['bg_repeat'];?>  <?php echo $themeConfig['bg_position'];?> !important;
		}
	</style>
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
<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,500,700,900,300italic,400italic,500italic,700italic,900italic,100italic,100' rel='stylesheet' type='text/css'>
			<?php } ?>
			<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/dbassa_intelligent_product_labels.css" />
			
			<?php foreach( $helper->getScriptFiles() as $script )  { ?>
			<script type="text/javascript" src="<?php echo $script; ?>"></script>
			<?php } ?>


			<?php if( isset($themeConfig['custom_javascript'])  && !empty($themeConfig['custom_javascript']) ){ ?>
			<script type="text/javascript"><!--
			$(document).ready(function() {
				<?php echo html_entity_decode(trim( $themeConfig['custom_javascript']) ); ?>
			});
			//--></script>
			<?php }	?>
			<!-- Начало Дополнительные изображения //-->
<script type="text/javascript"><!--
!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):"object"==typeof exports?module.exports=a:a(jQuery)}(function(a){function b(b){var g=b||window.event,h=i.call(arguments,1),j=0,l=0,m=0,n=0,o=0,p=0;if(b=a.event.fix(g),b.type="mousewheel","detail"in g&&(m=-1*g.detail),"wheelDelta"in g&&(m=g.wheelDelta),"wheelDeltaY"in g&&(m=g.wheelDeltaY),"wheelDeltaX"in g&&(l=-1*g.wheelDeltaX),"axis"in g&&g.axis===g.HORIZONTAL_AXIS&&(l=-1*m,m=0),j=0===m?l:m,"deltaY"in g&&(m=-1*g.deltaY,j=m),"deltaX"in g&&(l=g.deltaX,0===m&&(j=-1*l)),0!==m||0!==l){if(1===g.deltaMode){var q=a.data(this,"mousewheel-line-height");j*=q,m*=q,l*=q}else if(2===g.deltaMode){var r=a.data(this,"mousewheel-page-height");j*=r,m*=r,l*=r}if(n=Math.max(Math.abs(m),Math.abs(l)),(!f||f>n)&&(f=n,d(g,n)&&(f/=40)),d(g,n)&&(j/=40,l/=40,m/=40),j=Math[j>=1?"floor":"ceil"](j/f),l=Math[l>=1?"floor":"ceil"](l/f),m=Math[m>=1?"floor":"ceil"](m/f),k.settings.normalizeOffset&&this.getBoundingClientRect){var s=this.getBoundingClientRect();o=b.clientX-s.left,p=b.clientY-s.top}return b.deltaX=l,b.deltaY=m,b.deltaFactor=f,b.offsetX=o,b.offsetY=p,b.deltaMode=0,h.unshift(b,j,l,m),e&&clearTimeout(e),e=setTimeout(c,200),(a.event.dispatch||a.event.handle).apply(this,h)}}function c(){f=null}function d(a,b){return k.settings.adjustOldDeltas&&"mousewheel"===a.type&&b%120===0}var e,f,g=["wheel","mousewheel","DOMMouseScroll","MozMousePixelScroll"],h="onwheel"in document||document.documentMode>=9?["wheel"]:["mousewheel","DomMouseScroll","MozMousePixelScroll"],i=Array.prototype.slice;if(a.event.fixHooks)for(var j=g.length;j;)a.event.fixHooks[g[--j]]=a.event.mouseHooks;var k=a.event.special.mousewheel={version:"3.1.11",setup:function(){if(this.addEventListener)for(var c=h.length;c;)this.addEventListener(h[--c],b,!1);else this.onmousewheel=b;a.data(this,"mousewheel-line-height",k.getLineHeight(this)),a.data(this,"mousewheel-page-height",k.getPageHeight(this))},teardown:function(){if(this.removeEventListener)for(var c=h.length;c;)this.removeEventListener(h[--c],b,!1);else this.onmousewheel=null;a.removeData(this,"mousewheel-line-height"),a.removeData(this,"mousewheel-page-height")},getLineHeight:function(b){var c=a(b)["offsetParent"in a.fn?"offsetParent":"parent"]();return c.length||(c=a("body")),parseInt(c.css("fontSize"),10)},getPageHeight:function(b){return a(b).height()},settings:{adjustOldDeltas:!0,normalizeOffset:!0}};a.fn.extend({mousewheel:function(a){return a?this.bind("mousewheel",a):this.trigger("mousewheel")},unmousewheel:function(a){return this.unbind("mousewheel",a)}})});
(function(h,l,m,d){var e="mCustomScrollbar",a="mCS",k=".mCustomScrollbar",f={setWidth:false,setHeight:false,setTop:0,setLeft:0,axis:"y",scrollbarPosition:"inside",scrollInertia:950,autoDraggerLength:true,autoHideScrollbar:false,autoExpandScrollbar:false,alwaysShowScrollbar:0,snapAmount:null,snapOffset:0,mouseWheel:{enable:true,scrollAmount:"auto",axis:"y",preventDefault:false,deltaFactor:"auto",normalizeDelta:false,invert:false},scrollButtons:{enable:false,scrollType:"stepless",scrollAmount:"auto"},keyboard:{enable:true,scrollType:"stepless",scrollAmount:"auto"},contentTouchScroll:25,advanced:{autoExpandHorizontalScroll:false,autoScrollOnFocus:"input,textarea,select,button,datalist,keygen,a[tabindex],area,object,[contenteditable='true']",updateOnContentResize:true,updateOnImageLoad:true,updateOnSelectorChange:false},theme:"light",callbacks:{onScrollStart:false,onScroll:false,onTotalScroll:false,onTotalScrollBack:false,whileScrolling:false,onTotalScrollOffset:0,onTotalScrollBackOffset:0,alwaysTriggerOffsets:true},live:false},j=0,o={},c=function(p){if(o[p]){clearTimeout(o[p]);g._delete.call(null,o[p])}},i=(l.attachEvent&&!l.addEventListener)?1:0,n=false,b={init:function(q){var q=h.extend(true,{},f,q),p=g._selector.call(this);var s=this.selector||k;if(q.live){var r=h(s);if(q.live==="off"){c(s);return}o[s]=setTimeout(function(){r.mCustomScrollbar(q);if(q.live==="once"&&r.length){c(s)}},500)}else{c(s)}q.setWidth=(q.set_width)?q.set_width:q.setWidth;q.setHeight=(q.set_height)?q.set_height:q.setHeight;q.axis=(q.horizontalScroll)?"x":g._findAxis.call(null,q.axis);q.scrollInertia=q.scrollInertia<17?17:q.scrollInertia;if(typeof q.mouseWheel!=="object"&&q.mouseWheel==true){q.mouseWheel={enable:true,scrollAmount:"auto",axis:"y",preventDefault:false,deltaFactor:"auto",normalizeDelta:false,invert:false}}q.mouseWheel.scrollAmount=!q.mouseWheelPixels?q.mouseWheel.scrollAmount:q.mouseWheelPixels;q.mouseWheel.normalizeDelta=!q.advanced.normalizeMouseWheelDelta?q.mouseWheel.normalizeDelta:q.advanced.normalizeMouseWheelDelta;q.scrollButtons.scrollType=g._findScrollButtonsType.call(null,q.scrollButtons.scrollType);g._theme.call(null,q);return h(p).each(function(){var u=h(this);if(!u.data(a)){u.data(a,{idx:++j,opt:q,scrollRatio:{y:null,x:null},overflowed:null,bindEvents:false,tweenRunning:false,sequential:{},langDir:u.css("direction"),cbOffsets:null,trigger:null});var w=u.data(a).opt,v=u.data("mcs-axis"),t=u.data("mcs-scrollbar-position"),x=u.data("mcs-theme");if(v){w.axis=v}if(t){w.scrollbarPosition=t}if(x){w.theme=x;g._theme.call(null,w)}g._pluginMarkup.call(this);b.update.call(null,u)}})},update:function(q){var p=q||g._selector.call(this);return h(p).each(function(){var t=h(this);if(t.data(a)){var v=t.data(a),u=v.opt,r=h("#mCSB_"+v.idx+"_container"),s=[h("#mCSB_"+v.idx+"_dragger_vertical"),h("#mCSB_"+v.idx+"_dragger_horizontal")];if(v.tweenRunning){g._stop.call(null,t)}if(t.hasClass("mCS_disabled")){t.removeClass("mCS_disabled")}if(t.hasClass("mCS_destroyed")){t.removeClass("mCS_destroyed")}g._maxHeight.call(this);g._expandContentHorizontally.call(this);if(u.axis!=="y"&&!u.advanced.autoExpandHorizontalScroll){r.css("width",g._contentWidth(r.children()))}v.overflowed=g._overflowed.call(this);g._scrollbarVisibility.call(this);if(u.autoDraggerLength){g._setDraggerLength.call(this)}g._scrollRatio.call(this);g._bindEvents.call(this);var w=[Math.abs(r[0].offsetTop),Math.abs(r[0].offsetLeft)];if(u.axis!=="x"){if(!v.overflowed[0]){g._resetContentPosition.call(this);if(u.axis==="y"){g._unbindEvents.call(this)}else{if(u.axis==="yx"&&v.overflowed[1]){g._scrollTo.call(this,t,w[1].toString(),{dir:"x",dur:0,overwrite:"none"})}}}else{if(s[0].height()>s[0].parent().height()){g._resetContentPosition.call(this)}else{g._scrollTo.call(this,t,w[0].toString(),{dir:"y",dur:0,overwrite:"none"})}}}if(u.axis!=="y"){if(!v.overflowed[1]){g._resetContentPosition.call(this);if(u.axis==="x"){g._unbindEvents.call(this)}else{if(u.axis==="yx"&&v.overflowed[0]){g._scrollTo.call(this,t,w[0].toString(),{dir:"y",dur:0,overwrite:"none"})}}}else{if(s[1].width()>s[1].parent().width()){g._resetContentPosition.call(this)}else{g._scrollTo.call(this,t,w[1].toString(),{dir:"x",dur:0,overwrite:"none"})}}}g._autoUpdate.call(this)}})},scrollTo:function(r,q){if(typeof r=="undefined"||r==null){return}var p=g._selector.call(this);return h(p).each(function(){var u=h(this);if(u.data(a)){var x=u.data(a),w=x.opt,v={trigger:"external",scrollInertia:w.scrollInertia,scrollEasing:"mcsEaseInOut",moveDragger:false,callbacks:true,onStart:true,onUpdate:true,onComplete:true},s=h.extend(true,{},v,q),y=g._arr.call(this,r),t=s.scrollInertia<17?17:s.scrollInertia;y[0]=g._to.call(this,y[0],"y");y[1]=g._to.call(this,y[1],"x");if(s.moveDragger){y[0]*=x.scrollRatio.y;y[1]*=x.scrollRatio.x}s.dur=t;setTimeout(function(){if(y[0]!==null&&typeof y[0]!=="undefined"&&w.axis!=="x"&&x.overflowed[0]){s.dir="y";s.overwrite="all";g._scrollTo.call(this,u,y[0].toString(),s)}if(y[1]!==null&&typeof y[1]!=="undefined"&&w.axis!=="y"&&x.overflowed[1]){s.dir="x";s.overwrite="none";g._scrollTo.call(this,u,y[1].toString(),s)}},60)}})},stop:function(){var p=g._selector.call(this);return h(p).each(function(){var q=h(this);if(q.data(a)){g._stop.call(null,q)}})},disable:function(q){var p=g._selector.call(this);return h(p).each(function(){var r=h(this);if(r.data(a)){var t=r.data(a),s=t.opt;g._autoUpdate.call(this,"remove");g._unbindEvents.call(this);if(q){g._resetContentPosition.call(this)}g._scrollbarVisibility.call(this,true);r.addClass("mCS_disabled")}})},destroy:function(){var p=g._selector.call(this);return h(p).each(function(){var s=h(this);if(s.data(a)){var u=s.data(a),t=u.opt,q=h("#mCSB_"+u.idx),r=h("#mCSB_"+u.idx+"_container"),v=h(".mCSB_"+u.idx+"_scrollbar");if(t.live){c(p)}g._autoUpdate.call(this,"remove");g._unbindEvents.call(this);g._resetContentPosition.call(this);s.removeData(a);g._delete.call(null,this.mcs);v.remove();q.replaceWith(r.contents());s.removeClass(e+" _"+a+"_"+u.idx+" mCS-autoHide mCS-dir-rtl mCS_no_scrollbar mCS_disabled").addClass("mCS_destroyed")}})}},g={_selector:function(){return(typeof h(this.selector)!=="object"||h(this.selector).length<1)?k:this.selector},_theme:function(s){var r=["rounded","rounded-dark","rounded-dots","rounded-dots-dark"],q=["rounded-dots","rounded-dots-dark","3d","3d-dark","3d-thick","3d-thick-dark","inset","inset-dark","inset-2","inset-2-dark","inset-3","inset-3-dark"],p=["minimal","minimal-dark"],u=["minimal","minimal-dark"],t=["minimal","minimal-dark"];s.autoDraggerLength=h.inArray(s.theme,r)>-1?false:s.autoDraggerLength;s.autoExpandScrollbar=h.inArray(s.theme,q)>-1?false:s.autoExpandScrollbar;s.scrollButtons.enable=h.inArray(s.theme,p)>-1?false:s.scrollButtons.enable;s.autoHideScrollbar=h.inArray(s.theme,u)>-1?true:s.autoHideScrollbar;s.scrollbarPosition=h.inArray(s.theme,t)>-1?"outside":s.scrollbarPosition},_findAxis:function(p){return(p==="yx"||p==="xy"||p==="auto")?"yx":(p==="x"||p==="horizontal")?"x":"y"},_findScrollButtonsType:function(p){return(p==="stepped"||p==="pixels"||p==="step"||p==="click")?"stepped":"stepless"},_pluginMarkup:function(){var y=h(this),x=y.data(a),r=x.opt,t=r.autoExpandScrollbar?" mCSB_scrollTools_onDrag_expand":"",B=["<div id='mCSB_"+x.idx+"_scrollbar_vertical' class='mCSB_scrollTools mCSB_"+x.idx+"_scrollbar mCS-"+r.theme+" mCSB_scrollTools_vertical"+t+"'><div class='mCSB_draggerContainer'><div id='mCSB_"+x.idx+"_dragger_vertical' class='mCSB_dragger' style='position:absolute;' oncontextmenu='return false;'><div class='mCSB_dragger_bar' /></div><div class='mCSB_draggerRail' /></div></div>","<div id='mCSB_"+x.idx+"_scrollbar_horizontal' class='mCSB_scrollTools mCSB_"+x.idx+"_scrollbar mCS-"+r.theme+" mCSB_scrollTools_horizontal"+t+"'><div class='mCSB_draggerContainer'><div id='mCSB_"+x.idx+"_dragger_horizontal' class='mCSB_dragger' style='position:absolute;' oncontextmenu='return false;'><div class='mCSB_dragger_bar' /></div><div class='mCSB_draggerRail' /></div></div>"],u=r.axis==="yx"?"mCSB_vertical_horizontal":r.axis==="x"?"mCSB_horizontal":"mCSB_vertical",w=r.axis==="yx"?B[0]+B[1]:r.axis==="x"?B[1]:B[0],v=r.axis==="yx"?"<div id='mCSB_"+x.idx+"_container_wrapper' class='mCSB_container_wrapper' />":"",s=r.autoHideScrollbar?" mCS-autoHide":"",p=(r.axis!=="x"&&x.langDir==="rtl")?" mCS-dir-rtl":"";if(r.setWidth){y.css("width",r.setWidth)}if(r.setHeight){y.css("height",r.setHeight)}r.setLeft=(r.axis!=="y"&&x.langDir==="rtl")?"989999px":r.setLeft;y.addClass(e+" _"+a+"_"+x.idx+s+p).wrapInner("<div id='mCSB_"+x.idx+"' class='mCustomScrollBox mCS-"+r.theme+" "+u+"'><div id='mCSB_"+x.idx+"_container' class='mCSB_container' style='position:relative; top:"+r.setTop+"; left:"+r.setLeft+";' dir="+x.langDir+" /></div>");var q=h("#mCSB_"+x.idx),z=h("#mCSB_"+x.idx+"_container");if(r.axis!=="y"&&!r.advanced.autoExpandHorizontalScroll){z.css("width",g._contentWidth(z.children()))}if(r.scrollbarPosition==="outside"){if(y.css("position")==="static"){y.css("position","relative")}y.css("overflow","visible");q.addClass("mCSB_outside").after(w)}else{q.addClass("mCSB_inside").append(w);z.wrap(v)}g._scrollButtons.call(this);var A=[h("#mCSB_"+x.idx+"_dragger_vertical"),h("#mCSB_"+x.idx+"_dragger_horizontal")];A[0].css("min-height",A[0].height());A[1].css("min-width",A[1].width())},_contentWidth:function(p){return Math.max.apply(Math,p.map(function(){return h(this).outerWidth(true)}).get())},_expandContentHorizontally:function(){var q=h(this),s=q.data(a),r=s.opt,p=h("#mCSB_"+s.idx+"_container");if(r.advanced.autoExpandHorizontalScroll&&r.axis!=="y"){p.css({position:"absolute",width:"auto"}).wrap("<div class='mCSB_h_wrapper' style='position:relative; left:0; width:999999px;' />").css({width:(Math.ceil(p[0].getBoundingClientRect().right+0.4)-Math.floor(p[0].getBoundingClientRect().left)),position:"relative"}).unwrap()}},_scrollButtons:function(){var s=h(this),u=s.data(a),t=u.opt,q=h(".mCSB_"+u.idx+"_scrollbar:first"),r=["<a href='#' class='mCSB_buttonUp' oncontextmenu='return false;' />","<a href='#' class='mCSB_buttonDown' oncontextmenu='return false;' />","<a href='#' class='mCSB_buttonLeft' oncontextmenu='return false;' />","<a href='#' class='mCSB_buttonRight' oncontextmenu='return false;' />"],p=[(t.axis==="x"?r[2]:r[0]),(t.axis==="x"?r[3]:r[1]),r[2],r[3]];if(t.scrollButtons.enable){q.prepend(p[0]).append(p[1]).next(".mCSB_scrollTools").prepend(p[2]).append(p[3])}},_maxHeight:function(){var t=h(this),w=t.data(a),v=w.opt,r=h("#mCSB_"+w.idx),q=t.css("max-height"),s=q.indexOf("%")!==-1,p=t.css("box-sizing");if(q!=="none"){var u=s?t.parent().height()*parseInt(q)/100:parseInt(q);if(p==="border-box"){u-=((t.innerHeight()-t.height())+(t.outerHeight()-t.innerHeight()))}r.css("max-height",Math.round(u))}},_setDraggerLength:function(){var u=h(this),s=u.data(a),p=h("#mCSB_"+s.idx),v=h("#mCSB_"+s.idx+"_container"),y=[h("#mCSB_"+s.idx+"_dragger_vertical"),h("#mCSB_"+s.idx+"_dragger_horizontal")],t=[p.height()/v.outerHeight(false),p.width()/v.outerWidth(false)],q=[parseInt(y[0].css("min-height")),Math.round(t[0]*y[0].parent().height()),parseInt(y[1].css("min-width")),Math.round(t[1]*y[1].parent().width())],r=i&&(q[1]<q[0])?q[0]:q[1],x=i&&(q[3]<q[2])?q[2]:q[3];y[0].css({height:r,"max-height":(y[0].parent().height()-10)}).find(".mCSB_dragger_bar").css({"line-height":q[0]+"px"});y[1].css({width:x,"max-width":(y[1].parent().width()-10)})},_scrollRatio:function(){var t=h(this),v=t.data(a),q=h("#mCSB_"+v.idx),r=h("#mCSB_"+v.idx+"_container"),s=[h("#mCSB_"+v.idx+"_dragger_vertical"),h("#mCSB_"+v.idx+"_dragger_horizontal")],u=[r.outerHeight(false)-q.height(),r.outerWidth(false)-q.width()],p=[u[0]/(s[0].parent().height()-s[0].height()),u[1]/(s[1].parent().width()-s[1].width())];v.scrollRatio={y:p[0],x:p[1]}},_onDragClasses:function(r,t,q){var s=q?"mCSB_dragger_onDrag_expanded":"",p=["mCSB_dragger_onDrag","mCSB_scrollTools_onDrag"],u=r.closest(".mCSB_scrollTools");if(t==="active"){r.toggleClass(p[0]+" "+s);u.toggleClass(p[1]);r[0]._draggable=r[0]._draggable?0:1}else{if(!r[0]._draggable){if(t==="hide"){r.removeClass(p[0]);u.removeClass(p[1])}else{r.addClass(p[0]);u.addClass(p[1])}}}},_overflowed:function(){var t=h(this),u=t.data(a),q=h("#mCSB_"+u.idx),s=h("#mCSB_"+u.idx+"_container"),r=u.overflowed==null?s.height():s.outerHeight(false),p=u.overflowed==null?s.width():s.outerWidth(false);return[r>q.height(),p>q.width()]},_resetContentPosition:function(){var t=h(this),v=t.data(a),u=v.opt,q=h("#mCSB_"+v.idx),r=h("#mCSB_"+v.idx+"_container"),s=[h("#mCSB_"+v.idx+"_dragger_vertical"),h("#mCSB_"+v.idx+"_dragger_horizontal")];g._stop(t);if((u.axis!=="x"&&!v.overflowed[0])||(u.axis==="y"&&v.overflowed[0])){s[0].add(r).css("top",0)}if((u.axis!=="y"&&!v.overflowed[1])||(u.axis==="x"&&v.overflowed[1])){var p=dx=0;if(v.langDir==="rtl"){p=q.width()-r.outerWidth(false);dx=Math.abs(p/v.scrollRatio.x)}r.css("left",p);s[1].css("left",dx)}},_bindEvents:function(){var r=h(this),t=r.data(a),s=t.opt;if(!t.bindEvents){g._draggable.call(this);if(s.contentTouchScroll){g._contentDraggable.call(this)}if(s.mouseWheel.enable){function q(){p=setTimeout(function(){if(!h.event.special.mousewheel){q()}else{clearTimeout(p);g._mousewheel.call(r[0])}},1000)}var p;q()}g._draggerRail.call(this);g._wrapperScroll.call(this);if(s.advanced.autoScrollOnFocus){g._focus.call(this)}if(s.scrollButtons.enable){g._buttons.call(this)}if(s.keyboard.enable){g._keyboard.call(this)}t.bindEvents=true}},_unbindEvents:function(){var s=h(this),t=s.data(a),p=a+"_"+t.idx,u=".mCSB_"+t.idx+"_scrollbar",r=h("#mCSB_"+t.idx+",#mCSB_"+t.idx+"_container,#mCSB_"+t.idx+"_container_wrapper,"+u+" .mCSB_draggerContainer,#mCSB_"+t.idx+"_dragger_vertical,#mCSB_"+t.idx+"_dragger_horizontal,"+u+">a"),q=h("#mCSB_"+t.idx+"_container");if(t.bindEvents){h(m).unbind("."+p);r.each(function(){h(this).unbind("."+p)});clearTimeout(s[0]._focusTimeout);g._delete.call(null,s[0]._focusTimeout);clearTimeout(t.sequential.step);g._delete.call(null,t.sequential.step);clearTimeout(q[0].onCompleteTimeout);g._delete.call(null,q[0].onCompleteTimeout);t.bindEvents=false}},_scrollbarVisibility:function(q){var t=h(this),v=t.data(a),u=v.opt,p=h("#mCSB_"+v.idx+"_container_wrapper"),r=p.length?p:h("#mCSB_"+v.idx+"_container"),w=[h("#mCSB_"+v.idx+"_scrollbar_vertical"),h("#mCSB_"+v.idx+"_scrollbar_horizontal")],s=[w[0].find(".mCSB_dragger"),w[1].find(".mCSB_dragger")];if(u.axis!=="x"){if(v.overflowed[0]&&!q){w[0].add(s[0]).add(w[0].children("a")).css("display","block");r.removeClass("mCS_no_scrollbar_y mCS_y_hidden")}else{if(u.alwaysShowScrollbar){if(u.alwaysShowScrollbar!==2){s[0].add(w[0].children("a")).css("display","none")}r.removeClass("mCS_y_hidden")}else{w[0].css("display","none");r.addClass("mCS_y_hidden")}r.addClass("mCS_no_scrollbar_y")}}if(u.axis!=="y"){if(v.overflowed[1]&&!q){w[1].add(s[1]).add(w[1].children("a")).css("display","block");r.removeClass("mCS_no_scrollbar_x mCS_x_hidden")}else{if(u.alwaysShowScrollbar){if(u.alwaysShowScrollbar!==2){s[1].add(w[1].children("a")).css("display","none")}r.removeClass("mCS_x_hidden")}else{w[1].css("display","none");r.addClass("mCS_x_hidden")}r.addClass("mCS_no_scrollbar_x")}}if(!v.overflowed[0]&&!v.overflowed[1]){t.addClass("mCS_no_scrollbar")}else{t.removeClass("mCS_no_scrollbar")}},_coordinates:function(q){var p=q.type;switch(p){case"pointerdown":case"MSPointerDown":case"pointermove":case"MSPointerMove":case"pointerup":case"MSPointerUp":return[q.originalEvent.pageY,q.originalEvent.pageX];break;case"touchstart":case"touchmove":case"touchend":var r=q.originalEvent.touches[0]||q.originalEvent.changedTouches[0];return[r.pageY,r.pageX];break;default:return[q.pageY,q.pageX]}},_draggable:function(){var u=h(this),s=u.data(a),p=s.opt,r=a+"_"+s.idx,t=["mCSB_"+s.idx+"_dragger_vertical","mCSB_"+s.idx+"_dragger_horizontal"],v=h("#mCSB_"+s.idx+"_container"),w=h("#"+t[0]+",#"+t[1]),A,y,z;w.bind("mousedown."+r+" touchstart."+r+" pointerdown."+r+" MSPointerDown."+r,function(E){E.stopImmediatePropagation();E.preventDefault();if(!g._mouseBtnLeft(E)){return}n=true;if(i){m.onselectstart=function(){return false}}x(false);g._stop(u);A=h(this);var F=A.offset(),G=g._coordinates(E)[0]-F.top,B=g._coordinates(E)[1]-F.left,D=A.height()+F.top,C=A.width()+F.left;if(G<D&&G>0&&B<C&&B>0){y=G;z=B}g._onDragClasses(A,"active",p.autoExpandScrollbar)}).bind("touchmove."+r,function(C){C.stopImmediatePropagation();C.preventDefault();var D=A.offset(),E=g._coordinates(C)[0]-D.top,B=g._coordinates(C)[1]-D.left;q(y,z,E,B)});h(m).bind("mousemove."+r+" pointermove."+r+" MSPointerMove."+r,function(C){if(A){var D=A.offset(),E=g._coordinates(C)[0]-D.top,B=g._coordinates(C)[1]-D.left;if(y===E){return}q(y,z,E,B)}}).add(w).bind("mouseup."+r+" touchend."+r+" pointerup."+r+" MSPointerUp."+r,function(B){if(A){g._onDragClasses(A,"active",p.autoExpandScrollbar);A=null}n=false;if(i){m.onselectstart=null}x(true)});function x(B){var C=v.find("iframe");if(!C.length){return}var D=!B?"none":"auto";C.css("pointer-events",D)}function q(D,E,G,B){v[0].idleTimer=p.scrollInertia<233?250:0;if(A.attr("id")===t[1]){var C="x",F=((A[0].offsetLeft-E)+B)*s.scrollRatio.x}else{var C="y",F=((A[0].offsetTop-D)+G)*s.scrollRatio.y}g._scrollTo(u,F.toString(),{dir:C,drag:true})}},_contentDraggable:function(){var y=h(this),K=y.data(a),I=K.opt,F=a+"_"+K.idx,v=h("#mCSB_"+K.idx),z=h("#mCSB_"+K.idx+"_container"),w=[h("#mCSB_"+K.idx+"_dragger_vertical"),h("#mCSB_"+K.idx+"_dragger_horizontal")],E,G,L,M,C=[],D=[],H,A,u,t,J,x,r=0,q,s=I.axis==="yx"?"none":"all";z.bind("touchstart."+F+" pointerdown."+F+" MSPointerDown."+F,function(N){if(!g._pointerTouch(N)||n){return}var O=z.offset();E=g._coordinates(N)[0]-O.top;G=g._coordinates(N)[1]-O.left}).bind("touchmove."+F+" pointermove."+F+" MSPointerMove."+F,function(Q){if(!g._pointerTouch(Q)||n){return}Q.stopImmediatePropagation();A=g._getTime();var P=v.offset(),S=g._coordinates(Q)[0]-P.top,U=g._coordinates(Q)[1]-P.left,R="mcsLinearOut";C.push(S);D.push(U);if(K.overflowed[0]){var O=w[0].parent().height()-w[0].height(),T=((E-S)>0&&(S-E)>-(O*K.scrollRatio.y))}if(K.overflowed[1]){var N=w[1].parent().width()-w[1].width(),V=((G-U)>0&&(U-G)>-(N*K.scrollRatio.x))}if(T||V){Q.preventDefault()}x=I.axis==="yx"?[(E-S),(G-U)]:I.axis==="x"?[null,(G-U)]:[(E-S),null];z[0].idleTimer=250;if(K.overflowed[0]){B(x[0],r,R,"y","all",true)}if(K.overflowed[1]){B(x[1],r,R,"x",s,true)}});v.bind("touchstart."+F+" pointerdown."+F+" MSPointerDown."+F,function(N){if(!g._pointerTouch(N)||n){return}N.stopImmediatePropagation();g._stop(y);H=g._getTime();var O=v.offset();L=g._coordinates(N)[0]-O.top;M=g._coordinates(N)[1]-O.left;C=[];D=[]}).bind("touchend."+F+" pointerup."+F+" MSPointerUp."+F,function(P){if(!g._pointerTouch(P)||n){return}P.stopImmediatePropagation();u=g._getTime();var N=v.offset(),T=g._coordinates(P)[0]-N.top,V=g._coordinates(P)[1]-N.left;if((u-A)>30){return}J=1000/(u-H);var Q="mcsEaseOut",R=J<2.5,W=R?[C[C.length-2],D[D.length-2]]:[0,0];t=R?[(T-W[0]),(V-W[1])]:[T-L,V-M];var O=[Math.abs(t[0]),Math.abs(t[1])];J=R?[Math.abs(t[0]/4),Math.abs(t[1]/4)]:[J,J];var U=[Math.abs(z[0].offsetTop)-(t[0]*p((O[0]/J[0]),J[0])),Math.abs(z[0].offsetLeft)-(t[1]*p((O[1]/J[1]),J[1]))];x=I.axis==="yx"?[U[0],U[1]]:I.axis==="x"?[null,U[1]]:[U[0],null];q=[(O[0]*4)+I.scrollInertia,(O[1]*4)+I.scrollInertia];var S=parseInt(I.contentTouchScroll)||0;x[0]=O[0]>S?x[0]:0;x[1]=O[1]>S?x[1]:0;if(K.overflowed[0]){B(x[0],q[0],Q,"y",s,false)}if(K.overflowed[1]){B(x[1],q[1],Q,"x",s,false)}});function p(P,N){var O=[N*1.5,N*2,N/1.5,N/2];if(P>90){return N>4?O[0]:O[3]}else{if(P>60){return N>3?O[3]:O[2]}else{if(P>30){return N>8?O[1]:N>6?O[0]:N>4?N:O[2]}else{return N>8?N:O[3]}}}}function B(P,R,S,O,N,Q){if(!P){return}g._scrollTo(y,P.toString(),{dur:R,scrollEasing:S,dir:O,overwrite:N,drag:Q})}},_mousewheel:function(){var s=h(this),u=s.data(a),t=u.opt,q=a+"_"+u.idx,p=h("#mCSB_"+u.idx),r=[h("#mCSB_"+u.idx+"_dragger_vertical"),h("#mCSB_"+u.idx+"_dragger_horizontal")];p.bind("mousewheel."+q,function(z,D){g._stop(s);var B=t.mouseWheel.deltaFactor!=="auto"?parseInt(t.mouseWheel.deltaFactor):(i&&z.deltaFactor<100)?100:z.deltaFactor<40?40:z.deltaFactor||100;if(t.axis==="x"||t.mouseWheel.axis==="x"){var w="x",C=[Math.round(B*u.scrollRatio.x),parseInt(t.mouseWheel.scrollAmount)],y=t.mouseWheel.scrollAmount!=="auto"?C[1]:C[0]>=p.width()?p.width()*0.9:C[0],E=Math.abs(h("#mCSB_"+u.idx+"_container")[0].offsetLeft),A=r[1][0].offsetLeft,x=r[1].parent().width()-r[1].width(),v=z.deltaX||z.deltaY||D}else{var w="y",C=[Math.round(B*u.scrollRatio.y),parseInt(t.mouseWheel.scrollAmount)],y=t.mouseWheel.scrollAmount!=="auto"?C[1]:C[0]>=p.height()?p.height()*0.9:C[0],E=Math.abs(h("#mCSB_"+u.idx+"_container")[0].offsetTop),A=r[0][0].offsetTop,x=r[0].parent().height()-r[0].height(),v=z.deltaY||D}if((w==="y"&&!u.overflowed[0])||(w==="x"&&!u.overflowed[1])){return}if(t.mouseWheel.invert){v=-v}if(t.mouseWheel.normalizeDelta){v=v<0?-1:1}if((v>0&&A!==0)||(v<0&&A!==x)||t.mouseWheel.preventDefault){z.stopImmediatePropagation();z.preventDefault()}g._scrollTo(s,(E-(v*y)).toString(),{dir:w})})},_draggerRail:function(){var s=h(this),t=s.data(a),q=a+"_"+t.idx,r=h("#mCSB_"+t.idx+"_container"),u=r.parent(),p=h(".mCSB_"+t.idx+"_scrollbar .mCSB_draggerContainer");p.bind("touchstart."+q+" pointerdown."+q+" MSPointerDown."+q,function(v){n=true}).bind("touchend."+q+" pointerup."+q+" MSPointerUp."+q,function(v){n=false}).bind("click."+q,function(z){if(h(z.target).hasClass("mCSB_draggerContainer")||h(z.target).hasClass("mCSB_draggerRail")){g._stop(s);var w=h(this),y=w.find(".mCSB_dragger");if(w.parent(".mCSB_scrollTools_horizontal").length>0){if(!t.overflowed[1]){return}var v="x",x=z.pageX>y.offset().left?-1:1,A=Math.abs(r[0].offsetLeft)-(x*(u.width()*0.9))}else{if(!t.overflowed[0]){return}var v="y",x=z.pageY>y.offset().top?-1:1,A=Math.abs(r[0].offsetTop)-(x*(u.height()*0.9))}g._scrollTo(s,A.toString(),{dir:v,scrollEasing:"mcsEaseInOut"})}})},_focus:function(){var r=h(this),t=r.data(a),s=t.opt,p=a+"_"+t.idx,q=h("#mCSB_"+t.idx+"_container"),u=q.parent();q.bind("focusin."+p,function(x){var w=h(m.activeElement),y=q.find(".mCustomScrollBox").length,v=0;if(!w.is(s.advanced.autoScrollOnFocus)){return}g._stop(r);clearTimeout(r[0]._focusTimeout);r[0]._focusTimer=y?(v+17)*y:0;r[0]._focusTimeout=setTimeout(function(){var C=[w.offset().top-q.offset().top,w.offset().left-q.offset().left],B=[q[0].offsetTop,q[0].offsetLeft],z=[(B[0]+C[0]>=0&&B[0]+C[0]<u.height()-w.outerHeight(false)),(B[1]+C[1]>=0&&B[0]+C[1]<u.width()-w.outerWidth(false))],A=(s.axis==="yx"&&!z[0]&&!z[1])?"none":"all";if(s.axis!=="x"&&!z[0]){g._scrollTo(r,C[0].toString(),{dir:"y",scrollEasing:"mcsEaseInOut",overwrite:A,dur:v})}if(s.axis!=="y"&&!z[1]){g._scrollTo(r,C[1].toString(),{dir:"x",scrollEasing:"mcsEaseInOut",overwrite:A,dur:v})}},r[0]._focusTimer)})},_wrapperScroll:function(){var q=h(this),r=q.data(a),p=a+"_"+r.idx,s=h("#mCSB_"+r.idx+"_container").parent();s.bind("scroll."+p,function(t){s.scrollTop(0).scrollLeft(0)})},_buttons:function(){var u=h(this),w=u.data(a),v=w.opt,p=w.sequential,r=a+"_"+w.idx,t=h("#mCSB_"+w.idx+"_container"),s=".mCSB_"+w.idx+"_scrollbar",q=h(s+">a");q.bind("mousedown."+r+" touchstart."+r+" pointerdown."+r+" MSPointerDown."+r+" mouseup."+r+" touchend."+r+" pointerup."+r+" MSPointerUp."+r+" mouseout."+r+" pointerout."+r+" MSPointerOut."+r+" click."+r,function(z){z.preventDefault();if(!g._mouseBtnLeft(z)){return}var y=h(this).attr("class");p.type=v.scrollButtons.scrollType;switch(z.type){case"mousedown":case"touchstart":case"pointerdown":case"MSPointerDown":if(p.type==="stepped"){return}n=true;w.tweenRunning=false;x("on",y);break;case"mouseup":case"touchend":case"pointerup":case"MSPointerUp":case"mouseout":case"pointerout":case"MSPointerOut":if(p.type==="stepped"){return}n=false;if(p.dir){x("off",y)}break;case"click":if(p.type!=="stepped"||w.tweenRunning){return}x("on",y);break}function x(A,B){p.scrollAmount=v.snapAmount||v.scrollButtons.scrollAmount;g._sequentialScroll.call(this,u,A,B)}})},_keyboard:function(){var u=h(this),t=u.data(a),q=t.opt,x=t.sequential,s=a+"_"+t.idx,r=h("#mCSB_"+t.idx),w=h("#mCSB_"+t.idx+"_container"),p=w.parent(),v="input,textarea,select,datalist,keygen,[contenteditable='true']";r.attr("tabindex","0").bind("blur."+s+" keydown."+s+" keyup."+s,function(D){switch(D.type){case"blur":if(t.tweenRunning&&x.dir){y("off",null)}break;case"keydown":case"keyup":var A=D.keyCode?D.keyCode:D.which,B="on";if((q.axis!=="x"&&(A===38||A===40))||(q.axis!=="y"&&(A===37||A===39))){if(((A===38||A===40)&&!t.overflowed[0])||((A===37||A===39)&&!t.overflowed[1])){return}if(D.type==="keyup"){B="off"}if(!h(m.activeElement).is(v)){D.preventDefault();D.stopImmediatePropagation();y(B,A)}}else{if(A===33||A===34){if(t.overflowed[0]||t.overflowed[1]){D.preventDefault();D.stopImmediatePropagation()}if(D.type==="keyup"){g._stop(u);var C=A===34?-1:1;if(q.axis==="x"||(q.axis==="yx"&&t.overflowed[1]&&!t.overflowed[0])){var z="x",E=Math.abs(w[0].offsetLeft)-(C*(p.width()*0.9))}else{var z="y",E=Math.abs(w[0].offsetTop)-(C*(p.height()*0.9))}g._scrollTo(u,E.toString(),{dir:z,scrollEasing:"mcsEaseInOut"})}}else{if(A===35||A===36){if(!h(m.activeElement).is(v)){if(t.overflowed[0]||t.overflowed[1]){D.preventDefault();D.stopImmediatePropagation()}if(D.type==="keyup"){if(q.axis==="x"||(q.axis==="yx"&&t.overflowed[1]&&!t.overflowed[0])){var z="x",E=A===35?Math.abs(p.width()-w.outerWidth(false)):0}else{var z="y",E=A===35?Math.abs(p.height()-w.outerHeight(false)):0}g._scrollTo(u,E.toString(),{dir:z,scrollEasing:"mcsEaseInOut"})}}}}}break}function y(F,G){x.type=q.keyboard.scrollType;x.scrollAmount=q.snapAmount||q.keyboard.scrollAmount;if(x.type==="stepped"&&t.tweenRunning){return}g._sequentialScroll.call(this,u,F,G)}})},_sequentialScroll:function(r,u,s){var w=r.data(a),q=w.opt,y=w.sequential,x=h("#mCSB_"+w.idx+"_container"),p=y.type==="stepped"?true:false;switch(u){case"on":y.dir=[(s==="mCSB_buttonRight"||s==="mCSB_buttonLeft"||s===39||s===37?"x":"y"),(s==="mCSB_buttonUp"||s==="mCSB_buttonLeft"||s===38||s===37?-1:1)];g._stop(r);if(g._isNumeric(s)&&y.type==="stepped"){return}t(p);break;case"off":v();if(p||(w.tweenRunning&&y.dir)){t(true)}break}function t(z){var F=y.type!=="stepped",J=!z?1000/60:F?q.scrollInertia/1.5:q.scrollInertia,B=!z?2.5:F?7.5:40,I=[Math.abs(x[0].offsetTop),Math.abs(x[0].offsetLeft)],E=[w.scrollRatio.y>10?10:w.scrollRatio.y,w.scrollRatio.x>10?10:w.scrollRatio.x],C=y.dir[0]==="x"?I[1]+(y.dir[1]*(E[1]*B)):I[0]+(y.dir[1]*(E[0]*B)),H=y.dir[0]==="x"?I[1]+(y.dir[1]*parseInt(y.scrollAmount)):I[0]+(y.dir[1]*parseInt(y.scrollAmount)),G=y.scrollAmount!=="auto"?H:C,D=!z?"mcsLinear":F?"mcsLinearOut":"mcsEaseInOut",A=!z?false:true;if(z&&J<17){G=y.dir[0]==="x"?I[1]:I[0]}g._scrollTo(r,G.toString(),{dir:y.dir[0],scrollEasing:D,dur:J,onComplete:A});if(z){y.dir=false;return}clearTimeout(y.step);y.step=setTimeout(function(){t()},J)}function v(){clearTimeout(y.step);g._stop(r)}},_arr:function(r){var q=h(this).data(a).opt,p=[];if(typeof r==="function"){r=r()}if(!(r instanceof Array)){p[0]=r.y?r.y:r.x||q.axis==="x"?null:r;p[1]=r.x?r.x:r.y||q.axis==="y"?null:r}else{p=r.length>1?[r[0],r[1]]:q.axis==="x"?[null,r[0]]:[r[0],null]}if(typeof p[0]==="function"){p[0]=p[0]()}if(typeof p[1]==="function"){p[1]=p[1]()}return p},_to:function(v,w){if(v==null||typeof v=="undefined"){return}var C=h(this),B=C.data(a),u=B.opt,D=h("#mCSB_"+B.idx+"_container"),r=D.parent(),F=typeof v;if(!w){w=u.axis==="x"?"x":"y"}var q=w==="x"?D.outerWidth(false):D.outerHeight(false),x=w==="x"?D.offset().left:D.offset().top,E=w==="x"?D[0].offsetLeft:D[0].offsetTop,z=w==="x"?"left":"top";switch(F){case"function":return v();break;case"object":if(v.nodeType){var A=w==="x"?h(v).offset().left:h(v).offset().top}else{if(v.jquery){if(!v.length){return}var A=w==="x"?v.offset().left:v.offset().top}}return A-x;break;case"string":case"number":if(g._isNumeric.call(null,v)){return Math.abs(v)}else{if(v.indexOf("%")!==-1){return Math.abs(q*parseInt(v)/100)}else{if(v.indexOf("-=")!==-1){return Math.abs(E-parseInt(v.split("-=")[1]))}else{if(v.indexOf("+=")!==-1){var s=(E+parseInt(v.split("+=")[1]));return s>=0?0:Math.abs(s)}else{if(v.indexOf("px")!==-1&&g._isNumeric.call(null,v.split("px")[0])){return Math.abs(v.split("px")[0])}else{if(v==="top"||v==="left"){return 0}else{if(v==="bottom"){return Math.abs(r.height()-D.outerHeight(false))}else{if(v==="right"){return Math.abs(r.width()-D.outerWidth(false))}else{if(v==="first"||v==="last"){var y=D.find(":"+v),A=w==="x"?h(y).offset().left:h(y).offset().top;return A-x}else{if(h(v).length){var A=w==="x"?h(v).offset().left:h(v).offset().top;return A-x}else{D.css(z,v);b.update.call(null,C[0]);return}}}}}}}}}}break}},_autoUpdate:function(q){var t=h(this),F=t.data(a),z=F.opt,v=h("#mCSB_"+F.idx+"_container");if(q){clearTimeout(v[0].autoUpdate);g._delete.call(null,v[0].autoUpdate);return}var s=v.parent(),p=[h("#mCSB_"+F.idx+"_scrollbar_vertical"),h("#mCSB_"+F.idx+"_scrollbar_horizontal")],D=function(){return[p[0].is(":visible")?p[0].outerHeight(true):0,p[1].is(":visible")?p[1].outerWidth(true):0]},E=y(),x,u=[v.outerHeight(false),v.outerWidth(false),s.height(),s.width(),D()[0],D()[1]],H,B=G(),w;C();function C(){clearTimeout(v[0].autoUpdate);v[0].autoUpdate=setTimeout(function(){if(z.advanced.updateOnSelectorChange){x=y();if(x!==E){r();E=x;return}}if(z.advanced.updateOnContentResize){H=[v.outerHeight(false),v.outerWidth(false),s.height(),s.width(),D()[0],D()[1]];if(H[0]!==u[0]||H[1]!==u[1]||H[2]!==u[2]||H[3]!==u[3]||H[4]!==u[4]||H[5]!==u[5]){r();u=H}}if(z.advanced.updateOnImageLoad){w=G();if(w!==B){v.find("img").each(function(){A(this.src)});B=w}}if(z.advanced.updateOnSelectorChange||z.advanced.updateOnContentResize||z.advanced.updateOnImageLoad){C()}},60)}function G(){var I=0;if(z.advanced.updateOnImageLoad){I=v.find("img").length}return I}function A(L){var I=new Image();function K(M,N){return function(){return N.apply(M,arguments)}}function J(){this.onload=null;r()}I.onload=K(I,J);I.src=L}function y(){if(z.advanced.updateOnSelectorChange===true){z.advanced.updateOnSelectorChange="*"}var I=0,J=v.find(z.advanced.updateOnSelectorChange);if(z.advanced.updateOnSelectorChange&&J.length>0){J.each(function(){I+=h(this).height()+h(this).width()})}return I}function r(){clearTimeout(v[0].autoUpdate);b.update.call(null,t[0])}},_snapAmount:function(r,p,q){return(Math.round(r/p)*p-q)},_stop:function(p){var r=p.data(a),q=h("#mCSB_"+r.idx+"_container,#mCSB_"+r.idx+"_container_wrapper,#mCSB_"+r.idx+"_dragger_vertical,#mCSB_"+r.idx+"_dragger_horizontal");q.each(function(){g._stopTween.call(this)})},_scrollTo:function(q,s,u){var I=q.data(a),E=I.opt,D={trigger:"internal",dir:"y",scrollEasing:"mcsEaseOut",drag:false,dur:E.scrollInertia,overwrite:"all",callbacks:true,onStart:true,onUpdate:true,onComplete:true},u=h.extend(D,u),G=[u.dur,(u.drag?0:u.dur)],v=h("#mCSB_"+I.idx),B=h("#mCSB_"+I.idx+"_container"),K=E.callbacks.onTotalScrollOffset?g._arr.call(q,E.callbacks.onTotalScrollOffset):[0,0],p=E.callbacks.onTotalScrollBackOffset?g._arr.call(q,E.callbacks.onTotalScrollBackOffset):[0,0];I.trigger=u.trigger;if(E.snapAmount){s=g._snapAmount(s,E.snapAmount,E.snapOffset)}switch(u.dir){case"x":var x=h("#mCSB_"+I.idx+"_dragger_horizontal"),z="left",C=B[0].offsetLeft,H=[v.width()-B.outerWidth(false),x.parent().width()-x.width()],r=[s,(s/I.scrollRatio.x)],L=K[1],J=p[1],A=L>0?L/I.scrollRatio.x:0,w=J>0?J/I.scrollRatio.x:0;break;case"y":var x=h("#mCSB_"+I.idx+"_dragger_vertical"),z="top",C=B[0].offsetTop,H=[v.height()-B.outerHeight(false),x.parent().height()-x.height()],r=[s,(s/I.scrollRatio.y)],L=K[0],J=p[0],A=L>0?L/I.scrollRatio.y:0,w=J>0?J/I.scrollRatio.y:0;break}if(r[1]<0){r=[0,0]}else{if(r[1]>=H[1]){r=[H[0],H[1]]}else{r[0]=-r[0]}}clearTimeout(B[0].onCompleteTimeout);if(!I.tweenRunning&&((C===0&&r[0]>=0)||(C===H[0]&&r[0]<=H[0]))){return}g._tweenTo.call(null,x[0],z,Math.round(r[1]),G[1],u.scrollEasing);g._tweenTo.call(null,B[0],z,Math.round(r[0]),G[0],u.scrollEasing,u.overwrite,{onStart:function(){if(u.callbacks&&u.onStart&&!I.tweenRunning){if(t("onScrollStart")){F();E.callbacks.onScrollStart.call(q[0])}I.tweenRunning=true;g._onDragClasses(x);I.cbOffsets=y()}},onUpdate:function(){if(u.callbacks&&u.onUpdate){if(t("whileScrolling")){F();E.callbacks.whileScrolling.call(q[0])}}},onComplete:function(){if(u.callbacks&&u.onComplete){if(E.axis==="yx"){clearTimeout(B[0].onCompleteTimeout)}var M=B[0].idleTimer||0;B[0].onCompleteTimeout=setTimeout(function(){if(t("onScroll")){F();E.callbacks.onScroll.call(q[0])}if(t("onTotalScroll")&&r[1]>=H[1]-A&&I.cbOffsets[0]){F();E.callbacks.onTotalScroll.call(q[0])}if(t("onTotalScrollBack")&&r[1]<=w&&I.cbOffsets[1]){F();E.callbacks.onTotalScrollBack.call(q[0])}I.tweenRunning=false;B[0].idleTimer=0;g._onDragClasses(x,"hide")},M)}}});function t(M){return I&&E.callbacks[M]&&typeof E.callbacks[M]==="function"}function y(){return[E.callbacks.alwaysTriggerOffsets||C>=H[0]+L,E.callbacks.alwaysTriggerOffsets||C<=-J]}function F(){var O=[B[0].offsetTop,B[0].offsetLeft],P=[x[0].offsetTop,x[0].offsetLeft],M=[B.outerHeight(false),B.outerWidth(false)],N=[v.height(),v.width()];q[0].mcs={content:B,top:O[0],left:O[1],draggerTop:P[0],draggerLeft:P[1],topPct:Math.round((100*Math.abs(O[0]))/(Math.abs(M[0])-N[0])),leftPct:Math.round((100*Math.abs(O[1]))/(Math.abs(M[1])-N[1])),direction:u.dir}}},_tweenTo:function(r,u,s,q,A,t,J){var J=J||{},G=J.onStart||function(){},B=J.onUpdate||function(){},H=J.onComplete||function(){},z=g._getTime(),x,v=0,D=r.offsetTop,E=r.style;if(u==="left"){D=r.offsetLeft}var y=s-D;r._mcsstop=0;if(t!=="none"){C()}p();function I(){if(r._mcsstop){return}if(!v){G.call()}v=g._getTime()-z;F();if(v>=r._mcstime){r._mcstime=(v>r._mcstime)?v+x-(v-r._mcstime):v+x-1;if(r._mcstime<v+1){r._mcstime=v+1}}if(r._mcstime<q){r._mcsid=_request(I)}else{H.call()}}function F(){if(q>0){r._mcscurrVal=w(r._mcstime,D,y,q,A);E[u]=Math.round(r._mcscurrVal)+"px"}else{E[u]=s+"px"}B.call()}function p(){x=1000/60;r._mcstime=v+x;_request=(!l.requestAnimationFrame)?function(K){F();return setTimeout(K,0.01)}:l.requestAnimationFrame;r._mcsid=_request(I)}function C(){if(r._mcsid==null){return}if(!l.requestAnimationFrame){clearTimeout(r._mcsid)}else{l.cancelAnimationFrame(r._mcsid)}r._mcsid=null}function w(M,L,Q,P,N){switch(N){case"linear":case"mcsLinear":return Q*M/P+L;break;case"mcsLinearOut":M/=P;M--;return Q*Math.sqrt(1-M*M)+L;break;case"easeInOutSmooth":M/=P/2;if(M<1){return Q/2*M*M+L}M--;return -Q/2*(M*(M-2)-1)+L;break;case"easeInOutStrong":M/=P/2;if(M<1){return Q/2*Math.pow(2,10*(M-1))+L}M--;return Q/2*(-Math.pow(2,-10*M)+2)+L;break;case"easeInOut":case"mcsEaseInOut":M/=P/2;if(M<1){return Q/2*M*M*M+L}M-=2;return Q/2*(M*M*M+2)+L;break;case"easeOutSmooth":M/=P;M--;return -Q*(M*M*M*M-1)+L;break;case"easeOutStrong":return Q*(-Math.pow(2,-10*M/P)+1)+L;break;case"easeOut":case"mcsEaseOut":default:var O=(M/=P)*M,K=O*M;return L+Q*(0.499999999999997*K*O+-2.5*O*O+5.5*K+-6.5*O+4*M)}}},_getTime:function(){if(l.performance&&l.performance.now){return l.performance.now()}else{if(l.performance&&l.performance.webkitNow){return l.performance.webkitNow()}else{if(Date.now){return Date.now()}else{return new Date().getTime()}}}},_stopTween:function(){var p=this;if(p._mcsid==null){return}if(!l.requestAnimationFrame){clearTimeout(p._mcsid)}else{l.cancelAnimationFrame(p._mcsid)}p._mcsid=null;p._mcsstop=1},_delete:function(r){try{delete r}catch(q){r=null}},_mouseBtnLeft:function(p){return !(p.which&&p.which!==1)},_pointerTouch:function(q){var p=q.originalEvent.pointerType;return !(p&&p!=="touch"&&p!==2)},_isNumeric:function(p){return !isNaN(parseFloat(p))&&isFinite(p)}};h.fn[e]=function(p){if(b[p]){return b[p].apply(this,Array.prototype.slice.call(arguments,1))}else{if(typeof p==="object"||!p){return b.init.apply(this,arguments)}else{h.error("Method "+p+" does not exist")}}};h[e]=function(p){if(b[p]){return b[p].apply(this,Array.prototype.slice.call(arguments,1))}else{if(typeof p==="object"||!p){return b.init.apply(this,arguments)}else{h.error("Method "+p+" does not exist")}}};h[e].defaults=f;l[e]=true;h(l).load(function(){h(k)[e]()})})(jQuery,window,document);
//--></script> 
<style type="text/css">
.rotated {z-index:2;}
.product-grid{overflow:visible}
.product-grid .product-block{position:relative;background:none repeat scroll 0 0 #fff;padding:0px;width:auto; border: none; }
.product-grid .product-block:hover{z-index:9;border:0px; }
.product-grid .product-block .additional_img{background:none repeat scroll 0 0 #fff;border-color:#e5e5e5 #e5e5e5 #e5e5e5;border-image:none;border-style:solid none solid solid;border-width:0px;bottom:-1px;display:none;left:-66px;padding:3px 0 3px 5px;position:absolute;top:-1px;width:66px;}
.product-grid .product-block:hover .additional_img{display:block;overflow:hidden}
.product-list{overflow:visible}
.additionals_img img{width:50px;border:0px solid #e7e7e7;padding:2px;margin-top:2px}
.additionals_img img:hover{cursor:pointer}

/* my corect ad new block */

.additional_info .additionals_info {	display: -webkit-box;	display: -moz-box;	display: -ms-flexbox;	display: -webkit-flex;	display: flex;	flex-direction: row;	height: 100%;	align-content: flex-end; align-items: flex-end;	justify-content: flex-end;	}

.additional_info .additionals_info .size_info {	position: absolute;top: 15%;right: 5%;cursor: help;}
.additional_info .additionals_info .size_info img{cursor: help;}
.additional_info .quickview {position: absolute;left: 5%;top: 5%;}

.additional_info .additionals_info .sizechart_content {position: absolute;	width: 150px; font-size: 11px;
background: rgb(255,255,255); background: -moz-linear-gradient(top,  rgba(255,255,255,1) 4%, rgba(229,229,229,1) 100%);	background: -webkit-gradient(linear, left top, left bottom, color-stop(4%,rgba(255,255,255,1)), color-stop(100%,rgba(229,229,229,1))); background: -webkit-linear-gradient(top,  rgba(255,255,255,1) 4%,rgba(229,229,229,1) 100%);	background: -o-linear-gradient(top,  rgba(255,255,255,1) 4%,rgba(229,229,229,1) 100%);	background: -ms-linear-gradient(top,  rgba(255,255,255,1) 4%,rgba(229,229,229,1) 100%); background: linear-gradient(to bottom,  rgba(255,255,255,1) 4%,rgba(229,229,229,1) 100%);	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#e5e5e5',GradientType=0 ); border: 1px solid rgba(0,0,0,.5); padding: 3px 5px;	 display: none;	bottom: 41px;	left: -31px;
	-webkit-box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.2);
-moz-box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.2);
box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.2);}

.product-grid .product-block .additional_info {background: none repeat scroll 0 0 #fff; bottom: -50px; display: none;	left: 0px;	height: 50px;	right: -1px;	padding: 3px 3px 5px;	position: absolute;	border-color: #e5e5e5 #e5e5e5 #e5e5e5;	border-image: none;	border-style: solid none solid solid;		 z-index: 9;  border: none;  }

.product-grid .product-block:hover {
border: 0px; 
-webkit-box-shadow: 0px 0px 10px 0px rgba(40,0,10,0.14);
-moz-box-shadow: 0px 0px 10px 0px rgba(40,0,10,0.14);
box-shadow: 0px 0px 10px 0px rgba(40,0,10,0.14); border-right: 0px; 
}

.product-grid .product-block .additional_img {		bottom: -50px;	top: 0px; -webkit-box-shadow: -3px 0px 5px 0px rgba(0,0,0,0.1);
-moz-box-shadow: -3px 0px 5px 0px rgba(0,0,0,0.1);
box-shadow: -3px 0px 5px 0px rgba(0,0,0,0.1); border-bottom: 1px solid rgba(0,0,0,0.1);	}

.additional_info .size_info {     width: 27px;    height: 100%;	}
.product-grid .product-block:hover .additional_info { 	display:block; 	}
.product-grid .product-block:hover .additional_info .size_info:hover .sizechart_content {	display:block; z-index: 9999; 	}
img.hover:hover {    cursor: pointer; }
/*************************/

.mCustomScrollbar{-ms-touch-action:none;touch-action:none}
.mCustomScrollbar.mCS_no_scrollbar{-ms-touch-action:auto;touch-action:auto}
.mCustomScrollBox{position:relative;overflow:hidden;height:100%;max-width:100%;outline:0;direction:ltr}
.mCSB_container{overflow:hidden;width:auto;height:auto}
.mCSB_container.mCS_no_scrollbar_y.mCS_y_hidden{margin-right:0}
.mCS-dir-rtl>.mCSB_inside>.mCSB_container{margin-right:0;margin-left:30px}
.mCS-dir-rtl>.mCSB_inside>.mCSB_container.mCS_no_scrollbar_y.mCS_y_hidden{margin-left:0}
.mCSB_scrollTools{position:absolute;width:8px;height:auto;left:auto;top:0;right:0;bottom:0}
.mCSB_outside+.mCSB_scrollTools{right:-26px}
.mCS-dir-rtl>.mCSB_inside>.mCSB_scrollTools,.mCS-dir-rtl>.mCSB_outside+.mCSB_scrollTools{right:auto;left:0}
.mCS-dir-rtl>.mCSB_outside+.mCSB_scrollTools{left:-26px}
.mCSB_scrollTools .mCSB_draggerContainer{position:absolute;top:0;left:0;bottom:0;right:0;height:auto}
.mCSB_scrollTools a+.mCSB_draggerContainer{margin:20px 0}
.mCSB_scrollTools .mCSB_draggerRail{width:2px;height:100%;margin:0 auto;-webkit-border-radius:16px;-moz-border-radius:16px;border-radius:16px}
.mCSB_scrollTools .mCSB_dragger{cursor:pointer;width:100%;height:30px;z-index:1}
.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{position:relative;width:4px;height:100%;margin:0 auto;-webkit-border-radius:16px;-moz-border-radius:16px;border-radius:16px;text-align:center}
.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded .mCSB_dragger_bar,.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_dragger .mCSB_dragger_bar{width:12px}
.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail{width:8px}
.mCSB_scrollTools .mCSB_buttonUp,.mCSB_scrollTools .mCSB_buttonDown{display:block;position:absolute;height:20px;width:100%;overflow:hidden;margin:0 auto;cursor:pointer}
.mCSB_scrollTools .mCSB_buttonDown{bottom:0}
.mCSB_horizontal.mCSB_inside>.mCSB_container{margin-right:0;margin-bottom:30px}
.mCSB_horizontal.mCSB_outside>.mCSB_container{min-height:100%}
.mCSB_horizontal>.mCSB_container.mCS_no_scrollbar_x.mCS_x_hidden{margin-bottom:0}
.mCSB_scrollTools.mCSB_scrollTools_horizontal{width:auto;height:16px;top:auto;right:0;bottom:0;left:0}
.mCustomScrollBox+.mCSB_scrollTools.mCSB_scrollTools_horizontal,.mCustomScrollBox+.mCSB_scrollTools+.mCSB_scrollTools.mCSB_scrollTools_horizontal{bottom:-26px}
.mCSB_scrollTools.mCSB_scrollTools_horizontal a+.mCSB_draggerContainer{margin:0 20px}
.mCSB_scrollTools.mCSB_scrollTools_horizontal .mCSB_draggerRail{width:100%;height:2px;margin:7px 0}
.mCSB_scrollTools.mCSB_scrollTools_horizontal .mCSB_dragger{width:30px;height:100%;left:0}
.mCSB_scrollTools.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{width:100%;height:4px;margin:6px auto}
.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded .mCSB_dragger_bar,.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_dragger .mCSB_dragger_bar{height:12px;margin:2px auto}
.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail{height:8px;margin:4px 0}
.mCSB_scrollTools.mCSB_scrollTools_horizontal .mCSB_buttonLeft,.mCSB_scrollTools.mCSB_scrollTools_horizontal .mCSB_buttonRight{display:block;position:absolute;width:20px;height:100%;overflow:hidden;margin:0 auto;cursor:pointer}
.mCSB_scrollTools.mCSB_scrollTools_horizontal .mCSB_buttonLeft{left:0}
.mCSB_scrollTools.mCSB_scrollTools_horizontal .mCSB_buttonRight{right:0}
.mCSB_container_wrapper{position:absolute;height:auto;width:auto;overflow:hidden;top:0;left:0;right:0;bottom:0;margin-right:30px;margin-bottom:30px}
.mCSB_container_wrapper>.mCSB_container{padding-right:30px;padding-bottom:30px}
.mCSB_vertical_horizontal>.mCSB_scrollTools.mCSB_scrollTools_vertical{bottom:20px}
.mCSB_vertical_horizontal>.mCSB_scrollTools.mCSB_scrollTools_horizontal{right:20px}
.mCSB_container_wrapper.mCS_no_scrollbar_x.mCS_x_hidden+.mCSB_scrollTools.mCSB_scrollTools_vertical{bottom:0}
.mCSB_container_wrapper.mCS_no_scrollbar_y.mCS_y_hidden+.mCSB_scrollTools ~ .mCSB_scrollTools.mCSB_scrollTools_horizontal,.mCS-dir-rtl>.mCustomScrollBox.mCSB_vertical_horizontal.mCSB_inside>.mCSB_scrollTools.mCSB_scrollTools_horizontal{right:0}
.mCS-dir-rtl>.mCustomScrollBox.mCSB_vertical_horizontal.mCSB_inside>.mCSB_scrollTools.mCSB_scrollTools_horizontal{left:20px}
.mCS-dir-rtl>.mCustomScrollBox.mCSB_vertical_horizontal.mCSB_inside>.mCSB_container_wrapper.mCS_no_scrollbar_y.mCS_y_hidden+.mCSB_scrollTools ~ .mCSB_scrollTools.mCSB_scrollTools_horizontal{left:0}
.mCS-dir-rtl>.mCSB_inside>.mCSB_container_wrapper{margin-right:0;margin-left:30px}
.mCSB_container_wrapper.mCS_no_scrollbar_y.mCS_y_hidden>.mCSB_container{padding-right:0;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}
.mCSB_container_wrapper.mCS_no_scrollbar_x.mCS_x_hidden>.mCSB_container{padding-bottom:0;-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}
.mCustomScrollBox.mCSB_vertical_horizontal.mCSB_inside>.mCSB_container_wrapper.mCS_no_scrollbar_y.mCS_y_hidden{margin-right:0;margin-left:0}
.mCustomScrollBox.mCSB_vertical_horizontal.mCSB_inside>.mCSB_container_wrapper.mCS_no_scrollbar_x.mCS_x_hidden{margin-bottom:0}
.mCSB_scrollTools,.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCSB_scrollTools .mCSB_buttonUp,.mCSB_scrollTools .mCSB_buttonDown,.mCSB_scrollTools .mCSB_buttonLeft,.mCSB_scrollTools .mCSB_buttonRight{-webkit-transition:opacity .2s ease-in-out,background-color .2s ease-in-out;-moz-transition:opacity .2s ease-in-out,background-color .2s ease-in-out;-o-transition:opacity .2s ease-in-out,background-color .2s ease-in-out;transition:opacity .2s ease-in-out,background-color .2s ease-in-out}
.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_dragger_bar,.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_draggerRail,.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_dragger_bar,.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_draggerRail{-webkit-transition:width .2s ease-out .2s,height .2s ease-out .2s,margin-left .2s ease-out .2s,margin-right .2s ease-out .2s,margin-top .2s ease-out .2s,margin-bottom .2s ease-out .2s,opacity .2s ease-in-out,background-color .2s ease-in-out;-moz-transition:width .2s ease-out .2s,height .2s ease-out .2s,margin-left .2s ease-out .2s,margin-right .2s ease-out .2s,margin-top .2s ease-out .2s,margin-bottom .2s ease-out .2s,opacity .2s ease-in-out,background-color .2s ease-in-out;-o-transition:width .2s ease-out .2s,height .2s ease-out .2s,margin-left .2s ease-out .2s,margin-right .2s ease-out .2s,margin-top .2s ease-out .2s,margin-bottom .2s ease-out .2s,opacity .2s ease-in-out,background-color .2s ease-in-out;transition:width .2s ease-out .2s,height .2s ease-out .2s,margin-left .2s ease-out .2s,margin-right .2s ease-out .2s,margin-top .2s ease-out .2s,margin-bottom .2s ease-out .2s,opacity .2s ease-in-out,background-color .2s ease-in-out}
.mCSB_scrollTools{opacity:.75;filter:"alpha(opacity=75)";-ms-filter:"alpha(opacity=75)"}
.mCS-autoHide>.mCustomScrollBox>.mCSB_scrollTools,.mCS-autoHide>.mCustomScrollBox ~ .mCSB_scrollTools{opacity:0;filter:"alpha(opacity=0)";-ms-filter:"alpha(opacity=0)"}
.mCustomScrollbar>.mCustomScrollBox>.mCSB_scrollTools.mCSB_scrollTools_onDrag,.mCustomScrollbar>.mCustomScrollBox ~ .mCSB_scrollTools.mCSB_scrollTools_onDrag,.mCustomScrollBox:hover>.mCSB_scrollTools,.mCustomScrollBox:hover ~ .mCSB_scrollTools,.mCS-autoHide:hover>.mCustomScrollBox>.mCSB_scrollTools,.mCS-autoHide:hover>.mCustomScrollBox ~ .mCSB_scrollTools{opacity:1;filter:"alpha(opacity=100)";-ms-filter:"alpha(opacity=100)"}
.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.4);filter:"alpha(opacity=40)";-ms-filter:"alpha(opacity=40)"}
.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.75);filter:"alpha(opacity=75)";-ms-filter:"alpha(opacity=75)"}
.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.85);filter:"alpha(opacity=85)";-ms-filter:"alpha(opacity=85)"}
.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.9);filter:"alpha(opacity=90)";-ms-filter:"alpha(opacity=90)"}
.mCSB_scrollTools .mCSB_buttonUp,.mCSB_scrollTools .mCSB_buttonDown,.mCSB_scrollTools .mCSB_buttonLeft,.mCSB_scrollTools .mCSB_buttonRight{background-image: url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAKAAAACQCAYAAACPtWCAAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2hpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNS1jMDE0IDc5LjE1MTQ4MSwgMjAxMy8wMy8xMy0xMjowOToxNSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDoxMURDMzE5NzIzQkNFMTExOTY0QkYwNzFDNzkwNTlDNCIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpDOTMwRUZENEMxMUUxMUUzOUYxQkJGN0E1MDMzNTg1MCIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpDOTMwRUZEM0MxMUUxMUUzOUYxQkJGN0E1MDMzNTg1MCIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1IFdpbmRvd3MiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo1MGJlMjMyZC1hNzgzLTI1NGQtOTI4Yy02NDI0YmQxNTg0YWEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MTFEQzMxOTcyM0JDRTExMTk2NEJGMDcxQzc5MDU5QzQiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz5ZvSKsAAAH5ElEQVR42uyd3Y3jNhRGpZSQ7SJA3lyACtg+psEUoAL2zZjtIgtMBYqcWBsvh5e8/Cel8wECPLZ5JZMHpHj5UTNv2zYh1EozACIARACIUI8AHh/Oja6v9fnTKnee/73+vY7nK54/FUDzg7kRfNOIEB6N//PHVIag9flTAZSonBvBNxSEZuPXhqD1+VMB9N0UzhEgzRngq3X+Io0fA0HMENr6/KkAbkZDb5bX2gaNGUK1M6JS588G36PRXhvQ/KzEEOqDr/T5cwI4K//OPYTmArDJEG72GL6/cw+huQCsOYSXmAXbesotAoLYHiznEF59FmrrKUN7z5QeLOcQ3gJAF2ijDeHVAXSBNtoQ3hrAOUO8ywIofT8k3lUBLJmKGS4Z3TIRPHoeEAABEAABEAARAkAEgAgBIAJAhAAQASBCAIjODyCJ6JTKJRENgAAIgAAIgNUAxI6VACB2rHwA2spgSA0AAENq/BCMJT9hCL66JZ9NSRmBY1NSPIBHY7EtM/LGn22Z8UMwG9Mzzj5TepErbkxvOoR1dP4iEPJojrBJCA8nyggBDyeqNwsuASGPZxvw/DkARAgAEQAiBIAIABECQASACFUDsGQuLkfsrq+vZC4uR+zW16dNRJdo4Byxu76+GBtVzdg9XJ92Ka53+HJfY3LskeDLfY0hsTVmhBHgc9ZHhtjzmeFzVkbgOWyxQwEMnZXMHcOXcn1RMUIaN7SBa8OXcn0ACIDDAsgQzBDcdAhmEsIkpPkkhDQMaZjmaRizIUhEJzQEieh4ABEqJgBEAIgAECEARACIULcAnj5lUvL6zpAyKREjBsCUBrpsYvssiePcMUKH4J4bOcfSXNHHgfQMYY6luagnekXcA7aGsGsjQu8Q9mREkAAsaXfKAeFl7Vg5ILy6HxAAAZAhmCG47yGYSQiTkC4nIaRhSMM0TcOQiM7QwCSi0+8BEcoHPgAiAEQAiBAAIgBEqDWAt/34uh/Lfvz5fO++H+t+/LUf3zwxU8uPXaHz7Pz9e31/K1l+OD0AfDne9uN9k/X+/M4kHKnlhz52ve3H+/RfPtF2PD57K1V+yDoz4PnY/PoQIEotfwb4PhzwHMeHDaLU8qMDeBN6ruNzW092e/n85un5fOVHh+9m67lePrf1ZDdfeU9PeIr6++05Ej/uOf4wb0eE19Pzu19f/raVP8rZlmXM8uIdwhRuv2qhT7//dTnKsjSlqr9HOWFZS1V/j6WxUPtVbR0ALg74pPcW4bUGYKmMCZ/tdY9aJPgc7znrzwOwt/5ewesZwmMW/Pd+/O6AxQbGj/348nz9Wt4V47UiXsu7vjcp4rae+f78/V7/2/8w/Ni/+8Us74phgPSzvOd7ky9uDz1gzh5odgyhmgrYHEP4MEnL2B7oFRJzCFX564zvm/F6BfCuuO8y378Lr7UA3wNA7v3/Bd99912W9531pwD4rgW55/8XfAC4RpRdhddagFcHeHPA+z0oW/0FALxK4En3oD0PwY8Viu8B5b4/y0yZyo8u6i/DSgiJaBLRTVdCWIpjKa76gRkh/+wXM0JEHhAhAEQAiBAAIgBECADRNQEkDZNSoaRhwkQimkQ0e0JYiksuz54Q9oSwJyTznhCXtHtCtOVHF/UXKWlPiEaL8Frr55POqfUT9qRs9Rfg51uESYzWT9jVLNi2J2RzvH5I2hNis9Db3pP2hNgs/CWfrJpj5vtpT8ijsaXXx++37QmxWegFW711T4jNwl/yyaq5esBJ6LFiGj11T0fqnpJesgtRlvjUPR2pe0paAXhXQqLd07B5ytrKTB7QeobvroFEuydEGkK19afcFtoVgGsEQKvw2vZ9W7w1oCfsvedbIwBy1p9iU9JaogduBaBtT4ILIO2eBmnioN3TME9jDLuffr8HIFX9OSYOqvrrdSOStBJCIppENHtCWIpjTwhmhLSUDGaEiDwgQgCIABAhAEQAWGIycanJSe7JxGknJ5XSKZdKz+ROp5w5PTNVSChfKkGdO6F89gS1+UaqM1obT4qZ6pQ2Yw/ljNbGc8RMckqbsWs6og/5npZvyufMdT09Pyae826igzsa59Pyc9WfI2Z0/bUyq5oALg5QpAtcHPEXD3xbYDwNfC0X3xcJFEcDB9WfIuaSAl9t84I5C059Wr4p19PzpQZxxesZvuSn5bviBQAtxusNPlsPiFBTAF3OaPNG2FZmcsTT9lb3wN/Q079xEJ3Rh7fP87R8Z10oe6ug+mv9bxxMANcIYFZH/DViyFxjRr9OIFwjgAmqP0XM4PprCaEJoM8ZbcrnzHU5pWPiaSFsJaczOlf9OWJG118z5zSJaBLRva2EsBTHUlxTR/QhzAhpKRnMCBF5QIQAEAEgQzBDcLNZMJMQJiH4AUnD4Acs5QeUYsX6AZt6AGv7AR2xovyAUwMPYKgf0LXaEOsHlFYuTucH9Kw2RNefsHJxOj+grXFnZRnpM99a8JKwBNcawsXXuBZwgupPsRYcVH+tzQi1/YAacEL9gFqwa8x8i/oBleAE+QEDwK7SAyLUdAg2/YA2/5/Z24T4ATXD5j3id/Tiiv7FDyj4/6ZYP6By2Ayuv5auaJ8fUAPM6oi/RtyzrYPCJ167B5ig+lPcs62jwGcDUPLvScDE+gEl+E7nB/TMNKPrL+XJqQGz6iYrISSiSUTjB2QpDj8gZoS0lAxmhIg8IEJV9Y8AAwCuz3H3j+GlGwAAAABJRU5ErkJggg==');background-repeat:no-repeat;opacity:.4;filter:"alpha(opacity=40)";-ms-filter:"alpha(opacity=40)"}
.mCSB_scrollTools .mCSB_buttonUp{background-position:0 0}
.mCSB_scrollTools .mCSB_buttonDown{background-position:0 -20px}
.mCSB_scrollTools .mCSB_buttonLeft{background-position:0 -40px}
.mCSB_scrollTools .mCSB_buttonRight{background-position:0 -56px}
.mCSB_scrollTools .mCSB_buttonUp:hover,.mCSB_scrollTools .mCSB_buttonDown:hover,.mCSB_scrollTools .mCSB_buttonLeft:hover,.mCSB_scrollTools .mCSB_buttonRight:hover{opacity:.75;filter:"alpha(opacity=75)";-ms-filter:"alpha(opacity=75)"}
.mCSB_scrollTools .mCSB_buttonUp:active,.mCSB_scrollTools .mCSB_buttonDown:active,.mCSB_scrollTools .mCSB_buttonLeft:active,.mCSB_scrollTools .mCSB_buttonRight:active{opacity:.9;filter:"alpha(opacity=90)";-ms-filter:"alpha(opacity=90)"}
.mCS-dark.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.15)}
.mCS-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.75)}
.mCS-dark.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:rgba(0,0,0,0.85)}
.mCS-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:rgba(0,0,0,0.9)}
.mCS-dark.mCSB_scrollTools .mCSB_buttonUp{background-position:-80px 0}
.mCS-dark.mCSB_scrollTools .mCSB_buttonDown{background-position:-80px -20px}
.mCS-dark.mCSB_scrollTools .mCSB_buttonLeft{background-position:-80px -40px}
.mCS-dark.mCSB_scrollTools .mCSB_buttonRight{background-position:-80px -56px}
.mCS-light-2.mCSB_scrollTools .mCSB_draggerRail,.mCS-dark-2.mCSB_scrollTools .mCSB_draggerRail{width:4px;background-color:#fff;background-color:rgba(255,255,255,0.1);-webkit-border-radius:1px;-moz-border-radius:1px;border-radius:1px}
.mCS-light-2.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-dark-2.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{width:4px;background-color:#fff;background-color:rgba(255,255,255,0.75);-webkit-border-radius:1px;-moz-border-radius:1px;border-radius:1px}
.mCS-light-2.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-dark-2.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-light-2.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-dark-2.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{width:100%;height:4px;margin:6px auto}
.mCS-light-2.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.85)}
.mCS-light-2.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-light-2.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.9)}
.mCS-light-2.mCSB_scrollTools .mCSB_buttonUp{background-position:-32px 0}
.mCS-light-2.mCSB_scrollTools .mCSB_buttonDown{background-position:-32px -20px}
.mCS-light-2.mCSB_scrollTools .mCSB_buttonLeft{background-position:-40px -40px}
.mCS-light-2.mCSB_scrollTools .mCSB_buttonRight{background-position:-40px -56px}
.mCS-dark-2.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.1);-webkit-border-radius:1px;-moz-border-radius:1px;border-radius:1px}
.mCS-dark-2.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.75);-webkit-border-radius:1px;-moz-border-radius:1px;border-radius:1px}
.mCS-dark-2.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.85)}
.mCS-dark-2.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-dark-2.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.9)}
.mCS-dark-2.mCSB_scrollTools .mCSB_buttonUp{background-position:-112px 0}
.mCS-dark-2.mCSB_scrollTools .mCSB_buttonDown{background-position:-112px -20px}
.mCS-dark-2.mCSB_scrollTools .mCSB_buttonLeft{background-position:-120px -40px}
.mCS-dark-2.mCSB_scrollTools .mCSB_buttonRight{background-position:-120px -56px}
.mCS-light-thick.mCSB_scrollTools .mCSB_draggerRail,.mCS-dark-thick.mCSB_scrollTools .mCSB_draggerRail{width:4px;background-color:#fff;background-color:rgba(255,255,255,0.1);-webkit-border-radius:2px;-moz-border-radius:2px;border-radius:2px}
.mCS-light-thick.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-dark-thick.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{width:6px;background-color:#fff;background-color:rgba(255,255,255,0.75);-webkit-border-radius:2px;-moz-border-radius:2px;border-radius:2px}
.mCS-light-thick.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-dark-thick.mCSB_scrollTools_horizontal .mCSB_draggerRail{width:100%;height:4px;margin:6px 0}
.mCS-light-thick.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-dark-thick.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{width:100%;height:6px;margin:5px auto}
.mCS-light-thick.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.85)}
.mCS-light-thick.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-light-thick.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.9)}
.mCS-light-thick.mCSB_scrollTools .mCSB_buttonUp{background-position:-16px 0}
.mCS-light-thick.mCSB_scrollTools .mCSB_buttonDown{background-position:-16px -20px}
.mCS-light-thick.mCSB_scrollTools .mCSB_buttonLeft{background-position:-20px -40px}
.mCS-light-thick.mCSB_scrollTools .mCSB_buttonRight{background-position:-20px -56px}
.mCS-dark-thick.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.1);-webkit-border-radius:2px;-moz-border-radius:2px;border-radius:2px}
.mCS-dark-thick.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.75);-webkit-border-radius:2px;-moz-border-radius:2px;border-radius:2px}
.mCS-dark-thick.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.85)}
.mCS-dark-thick.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-dark-thick.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.9)}
.mCS-dark-thick.mCSB_scrollTools .mCSB_buttonUp{background-position:-96px 0}
.mCS-dark-thick.mCSB_scrollTools .mCSB_buttonDown{background-position:-96px -20px}
.mCS-dark-thick.mCSB_scrollTools .mCSB_buttonLeft{background-position:-100px -40px}
.mCS-dark-thick.mCSB_scrollTools .mCSB_buttonRight{background-position:-100px -56px}
.mCS-light-thin.mCSB_scrollTools .mCSB_draggerRail{background-color:#fff;background-color:rgba(255,255,255,0.1)}
.mCS-light-thin.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-dark-thin.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{width:2px}
.mCS-light-thin.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-dark-thin.mCSB_scrollTools_horizontal .mCSB_draggerRail{width:100%}
.mCS-light-thin.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-dark-thin.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{width:100%;height:2px;margin:7px auto}
.mCS-dark-thin.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.15)}
.mCS-dark-thin.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#000;background-color:rgba(48, 48, 48, 0.3)}
.mCS-dark-thin.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.85)}
.mCS-dark-thin.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-dark-thin.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.9)}
.mCS-dark-thin.mCSB_scrollTools .mCSB_buttonUp{background-position:-80px 0}
.mCS-dark-thin.mCSB_scrollTools .mCSB_buttonDown{background-position:-80px -20px}
.mCS-dark-thin.mCSB_scrollTools .mCSB_buttonLeft{background-position:-80px -40px}
.mCS-dark-thin.mCSB_scrollTools .mCSB_buttonRight{background-position:-80px -56px}
.mCS-rounded.mCSB_scrollTools .mCSB_draggerRail{background-color:#fff;background-color:rgba(255,255,255,0.15)}
.mCS-rounded.mCSB_scrollTools .mCSB_dragger,.mCS-rounded-dark.mCSB_scrollTools .mCSB_dragger,.mCS-rounded-dots.mCSB_scrollTools .mCSB_dragger,.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_dragger{height:14px}
.mCS-rounded.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-rounded-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-rounded-dots.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{width:14px;margin:0 1px}
.mCS-rounded.mCSB_scrollTools_horizontal .mCSB_dragger,.mCS-rounded-dark.mCSB_scrollTools_horizontal .mCSB_dragger,.mCS-rounded-dots.mCSB_scrollTools_horizontal .mCSB_dragger,.mCS-rounded-dots-dark.mCSB_scrollTools_horizontal .mCSB_dragger{width:14px}
.mCS-rounded.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-rounded-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-rounded-dots.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-rounded-dots-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{height:14px;margin:1px 0}
.mCS-rounded.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded .mCSB_dragger_bar,.mCS-rounded.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_dragger .mCSB_dragger_bar,.mCS-rounded-dark.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded .mCSB_dragger_bar,.mCS-rounded-dark.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_dragger .mCSB_dragger_bar{width:16px;height:16px;margin:-1px 0}
.mCS-rounded.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCS-rounded.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail,.mCS-rounded-dark.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCS-rounded-dark.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail{width:4px}
.mCS-rounded.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded .mCSB_dragger_bar,.mCS-rounded.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_dragger .mCSB_dragger_bar,.mCS-rounded-dark.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded .mCSB_dragger_bar,.mCS-rounded-dark.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_dragger .mCSB_dragger_bar{height:16px;width:16px;margin:0 -1px}
.mCS-rounded.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCS-rounded.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail,.mCS-rounded-dark.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCS-rounded-dark.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail{height:4px;margin:6px 0}
.mCS-rounded.mCSB_scrollTools .mCSB_buttonUp{background-position:0 -72px}
.mCS-rounded.mCSB_scrollTools .mCSB_buttonDown{background-position:0 -92px}
.mCS-rounded.mCSB_scrollTools .mCSB_buttonLeft{background-position:0 -112px}
.mCS-rounded.mCSB_scrollTools .mCSB_buttonRight{background-position:0 -128px}
.mCS-rounded-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.75)}
.mCS-rounded-dark.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.15)}
.mCS-rounded-dark.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar,.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.85)}
.mCS-rounded-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-rounded-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar,.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.9)}
.mCS-rounded-dark.mCSB_scrollTools .mCSB_buttonUp{background-position:-80px -72px}
.mCS-rounded-dark.mCSB_scrollTools .mCSB_buttonDown{background-position:-80px -92px}
.mCS-rounded-dark.mCSB_scrollTools .mCSB_buttonLeft{background-position:-80px -112px}
.mCS-rounded-dark.mCSB_scrollTools .mCSB_buttonRight{background-position:-80px -128px}
.mCS-rounded-dots.mCSB_scrollTools_vertical .mCSB_draggerRail,.mCS-rounded-dots-dark.mCSB_scrollTools_vertical .mCSB_draggerRail{width:4px}
.mCS-rounded-dots.mCSB_scrollTools .mCSB_draggerRail,.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_draggerRail,.mCS-rounded-dots.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-rounded-dots-dark.mCSB_scrollTools_horizontal .mCSB_draggerRail{background-color:transparent;background-position:center}
.mCS-rounded-dots.mCSB_scrollTools .mCSB_draggerRail,.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_draggerRail{background-image:url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAANElEQVQYV2NkIAAYiVbw//9/Y6DiM1ANJoyMjGdBbLgJQAX/kU0DKgDLkaQAvxW4HEvQFwCRcxIJK1XznAAAAABJRU5ErkJggg==");background-repeat:repeat-y;opacity:.3;filter:"alpha(opacity=30)";-ms-filter:"alpha(opacity=30)"}
.mCS-rounded-dots.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-rounded-dots-dark.mCSB_scrollTools_horizontal .mCSB_draggerRail{height:4px;margin:6px 0;background-repeat:repeat-x}
.mCS-rounded-dots.mCSB_scrollTools .mCSB_buttonUp{background-position:-16px -72px}
.mCS-rounded-dots.mCSB_scrollTools .mCSB_buttonDown{background-position:-16px -92px}
.mCS-rounded-dots.mCSB_scrollTools .mCSB_buttonLeft{background-position:-20px -112px}
.mCS-rounded-dots.mCSB_scrollTools .mCSB_buttonRight{background-position:-20px -128px}
.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_draggerRail{background-image:url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAALElEQVQYV2NkIAAYSVFgDFR8BqrBBEifBbGRTfiPZhpYjiQFBK3A6l6CvgAAE9kGCd1mvgEAAAAASUVORK5CYII=")}
.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_buttonUp{background-position:-96px -72px}
.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_buttonDown{background-position:-96px -92px}
.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_buttonLeft{background-position:-100px -112px}
.mCS-rounded-dots-dark.mCSB_scrollTools .mCSB_buttonRight{background-position:-100px -128px}
.mCS-3d.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-repeat:repeat-y;background-image:-moz-linear-gradient(left,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%);background-image:-webkit-gradient(linear,left top,right top,color-stop(0,rgba(255,255,255,0.5)),color-stop(100%,rgba(255,255,255,0)));background-image:-webkit-linear-gradient(left,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%);background-image:-o-linear-gradient(left,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%);background-image:-ms-linear-gradient(left,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%);background-image:linear-gradient(to right,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%)}
.mCS-3d.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{background-repeat:repeat-x;background-image:-moz-linear-gradient(top,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%);background-image:-webkit-gradient(linear,left top,left bottom,color-stop(0,rgba(255,255,255,0.5)),color-stop(100%,rgba(255,255,255,0)));background-image:-webkit-linear-gradient(top,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%);background-image:-o-linear-gradient(top,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%);background-image:-ms-linear-gradient(top,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%);background-image:linear-gradient(to bottom,rgba(255,255,255,0.5) 0,rgba(255,255,255,0) 100%)}
.mCS-3d.mCSB_scrollTools_vertical .mCSB_dragger,.mCS-3d-dark.mCSB_scrollTools_vertical .mCSB_dragger{height:70px}
.mCS-3d.mCSB_scrollTools_horizontal .mCSB_dragger,.mCS-3d-dark.mCSB_scrollTools_horizontal .mCSB_dragger{width:70px}
.mCS-3d.mCSB_scrollTools,.mCS-3d-dark.mCSB_scrollTools{opacity:1;filter:"alpha(opacity=30)";-ms-filter:"alpha(opacity=30)"}
.mCS-3d.mCSB_scrollTools .mCSB_draggerRail,.mCS-3d.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-dark.mCSB_scrollTools .mCSB_draggerRail,.mCS-3d-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{-webkit-border-radius:16px;-moz-border-radius:16px;border-radius:16px}
.mCS-3d.mCSB_scrollTools .mCSB_draggerRail,.mCS-3d-dark.mCSB_scrollTools .mCSB_draggerRail{width:8px;background-color:#000;background-color:rgba(0,0,0,0.2);box-shadow:inset 1px 0 1px rgba(0,0,0,0.5),inset -1px 0 1px rgba(255,255,255,0.2)}
.mCS-3d.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar,.mCS-3d.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-3d.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar,.mCS-3d-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-dark.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar,.mCS-3d-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-3d-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#555}
.mCS-3d.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{width:8px}
.mCS-3d.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-3d-dark.mCSB_scrollTools_horizontal .mCSB_draggerRail{width:100%;height:8px;margin:4px 0;box-shadow:inset 0 1px 1px rgba(0,0,0,0.5),inset 0 -1px 1px rgba(255,255,255,0.2)}
.mCS-3d.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{width:100%;height:8px;margin:4px auto}
.mCS-3d.mCSB_scrollTools .mCSB_buttonUp{background-position:-32px -72px}
.mCS-3d.mCSB_scrollTools .mCSB_buttonDown{background-position:-32px -92px}
.mCS-3d.mCSB_scrollTools .mCSB_buttonLeft{background-position:-40px -112px}
.mCS-3d.mCSB_scrollTools .mCSB_buttonRight{background-position:-40px -128px}
.mCS-3d-dark.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.1);box-shadow:inset 1px 0 1px rgba(0,0,0,0.1)}
.mCS-3d-dark.mCSB_scrollTools_horizontal .mCSB_draggerRail{box-shadow:inset 0 1px 1px rgba(0,0,0,0.1)}
.mCS-3d-dark.mCSB_scrollTools .mCSB_buttonUp{background-position:-112px -72px}
.mCS-3d-dark.mCSB_scrollTools .mCSB_buttonDown{background-position:-112px -92px}
.mCS-3d-dark.mCSB_scrollTools .mCSB_buttonLeft{background-position:-120px -112px}
.mCS-3d-dark.mCSB_scrollTools .mCSB_buttonRight{background-position:-120px -128px}
.mCS-3d-thick.mCSB_scrollTools,.mCS-3d-thick-dark.mCSB_scrollTools{opacity:1;filter:"alpha(opacity=30)";-ms-filter:"alpha(opacity=30)"}
.mCS-3d-thick.mCSB_scrollTools,.mCS-3d-thick-dark.mCSB_scrollTools,.mCS-3d-thick.mCSB_scrollTools .mCSB_draggerContainer,.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_draggerContainer{-webkit-border-radius:7px;-moz-border-radius:7px;border-radius:7px}
.mCS-3d-thick.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{-webkit-border-radius:5px;-moz-border-radius:5px;border-radius:5px}
.mCSB_inside+.mCS-3d-thick.mCSB_scrollTools_vertical,.mCSB_inside+.mCS-3d-thick-dark.mCSB_scrollTools_vertical{right:1px}
.mCS-3d-thick.mCSB_scrollTools_vertical,.mCS-3d-thick-dark.mCSB_scrollTools_vertical{box-shadow:inset 1px 0 1px rgba(0,0,0,0.1),inset 0 0 14px rgba(0,0,0,0.5)}
.mCS-3d-thick.mCSB_scrollTools_horizontal,.mCS-3d-thick-dark.mCSB_scrollTools_horizontal{bottom:1px;box-shadow:inset 0 1px 1px rgba(0,0,0,0.1),inset 0 0 14px rgba(0,0,0,0.5)}
.mCS-3d-thick.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{box-shadow:inset 1px 0 0 rgba(255,255,255,0.4);width:12px;margin:2px;position:absolute;height:auto;top:0;bottom:0;left:0;right:0}
.mCS-3d-thick.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{box-shadow:inset 0 1px 0 rgba(255,255,255,0.4)}
.mCS-3d-thick.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar,.mCS-3d-thick.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-3d-thick.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#555}
.mCS-3d-thick.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{height:12px;width:auto}
.mCS-3d-thick.mCSB_scrollTools .mCSB_draggerContainer{background-color:#000;background-color:rgba(0,0,0,0.05);box-shadow:inset 1px 1px 16px rgba(0,0,0,0.1)}
.mCS-3d-thick.mCSB_scrollTools .mCSB_draggerRail{background-color:transparent}
.mCS-3d-thick.mCSB_scrollTools .mCSB_buttonUp{background-position:-32px -72px}
.mCS-3d-thick.mCSB_scrollTools .mCSB_buttonDown{background-position:-32px -92px}
.mCS-3d-thick.mCSB_scrollTools .mCSB_buttonLeft{background-position:-40px -112px}
.mCS-3d-thick.mCSB_scrollTools .mCSB_buttonRight{background-position:-40px -128px}
.mCS-3d-thick-dark.mCSB_scrollTools{box-shadow:inset 0 0 14px rgba(0,0,0,0.2)}
.mCS-3d-thick-dark.mCSB_scrollTools_horizontal{box-shadow:inset 0 1px 1px rgba(0,0,0,0.1),inset 0 0 14px rgba(0,0,0,0.2)}
.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{box-shadow:inset 1px 0 0 rgba(255,255,255,0.4),inset -1px 0 0 rgba(0,0,0,0.2)}
.mCS-3d-thick-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{box-shadow:inset 0 1px 0 rgba(255,255,255,0.4),inset 0 -1px 0 rgba(0,0,0,0.2)}
.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar,.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#777}
.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_draggerContainer{background-color:#fff;background-color:rgba(0,0,0,0.05);box-shadow:inset 1px 1px 16px rgba(0,0,0,0.1)}
.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_draggerRail{background-color:transparent}
.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_buttonUp{background-position:-112px -72px}
.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_buttonDown{background-position:-112px -92px}
.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_buttonLeft{background-position:-120px -112px}
.mCS-3d-thick-dark.mCSB_scrollTools .mCSB_buttonRight{background-position:-120px -128px}
.mCSB_outside+.mCS-minimal.mCSB_scrollTools_vertical,.mCSB_outside+.mCS-minimal-dark.mCSB_scrollTools_vertical{right:0;margin:12px 0}
.mCustomScrollBox.mCS-minimal+.mCSB_scrollTools.mCSB_scrollTools_horizontal,.mCustomScrollBox.mCS-minimal+.mCSB_scrollTools+.mCSB_scrollTools.mCSB_scrollTools_horizontal,.mCustomScrollBox.mCS-minimal-dark+.mCSB_scrollTools.mCSB_scrollTools_horizontal,.mCustomScrollBox.mCS-minimal-dark+.mCSB_scrollTools+.mCSB_scrollTools.mCSB_scrollTools_horizontal{bottom:0;margin:0 12px}
.mCS-dir-rtl>.mCSB_outside+.mCS-minimal.mCSB_scrollTools_vertical,.mCS-dir-rtl>.mCSB_outside+.mCS-minimal-dark.mCSB_scrollTools_vertical{left:0;right:auto}
.mCS-minimal.mCSB_scrollTools .mCSB_draggerRail,.mCS-minimal-dark.mCSB_scrollTools .mCSB_draggerRail{background-color:transparent}
.mCS-minimal.mCSB_scrollTools_vertical .mCSB_dragger,.mCS-minimal-dark.mCSB_scrollTools_vertical .mCSB_dragger{height:50px}
.mCS-minimal.mCSB_scrollTools_horizontal .mCSB_dragger,.mCS-minimal-dark.mCSB_scrollTools_horizontal .mCSB_dragger{width:50px}
.mCS-minimal.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.2);filter:"alpha(opacity=20)";-ms-filter:"alpha(opacity=20)"}
.mCS-minimal.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-minimal.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.5);filter:"alpha(opacity=50)";-ms-filter:"alpha(opacity=50)"}
.mCS-minimal-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.2);filter:"alpha(opacity=20)";-ms-filter:"alpha(opacity=20)"}
.mCS-minimal-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-minimal-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.5);filter:"alpha(opacity=50)";-ms-filter:"alpha(opacity=50)"}
.mCS-light-3.mCSB_scrollTools .mCSB_draggerRail,.mCS-dark-3.mCSB_scrollTools .mCSB_draggerRail{width:6px;background-color:#000;background-color:rgba(0,0,0,0.2)}
.mCS-light-3.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-dark-3.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{width:6px}
.mCS-light-3.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-dark-3.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-light-3.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-dark-3.mCSB_scrollTools_horizontal .mCSB_draggerRail{width:100%;height:6px;margin:5px 0}
.mCS-light-3.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCS-light-3.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail,.mCS-dark-3.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCS-dark-3.mCSB_scrollTools_vertical.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail{width:12px}
.mCS-light-3.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCS-light-3.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail,.mCS-dark-3.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_dragger.mCSB_dragger_onDrag_expanded+.mCSB_draggerRail,.mCS-dark-3.mCSB_scrollTools_horizontal.mCSB_scrollTools_onDrag_expand .mCSB_draggerContainer:hover .mCSB_draggerRail{height:12px;margin:2px 0}
.mCS-light-3.mCSB_scrollTools .mCSB_buttonUp{background-position:-32px -72px}
.mCS-light-3.mCSB_scrollTools .mCSB_buttonDown{background-position:-32px -92px}
.mCS-light-3.mCSB_scrollTools .mCSB_buttonLeft{background-position:-40px -112px}
.mCS-light-3.mCSB_scrollTools .mCSB_buttonRight{background-position:-40px -128px}
.mCS-dark-3.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.75)}
.mCS-dark-3.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.85)}
.mCS-dark-3.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-dark-3.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.9)}
.mCS-dark-3.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.1)}
.mCS-dark-3.mCSB_scrollTools .mCSB_buttonUp{background-position:-112px -72px}
.mCS-dark-3.mCSB_scrollTools .mCSB_buttonDown{background-position:-112px -92px}
.mCS-dark-3.mCSB_scrollTools .mCSB_buttonLeft{background-position:-120px -112px}
.mCS-dark-3.mCSB_scrollTools .mCSB_buttonRight{background-position:-120px -128px}
.mCS-inset.mCSB_scrollTools .mCSB_draggerRail,.mCS-inset-dark.mCSB_scrollTools .mCSB_draggerRail,.mCS-inset-2.mCSB_scrollTools .mCSB_draggerRail,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_draggerRail,.mCS-inset-3.mCSB_scrollTools .mCSB_draggerRail,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_draggerRail{width:12px;background-color:#000;background-color:rgba(0,0,0,0.2)}
.mCS-inset.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-2.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-3.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{width:6px;margin:3px 5px;position:absolute;height:auto;top:0;bottom:0;left:0;right:0}
.mCS-inset.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-2.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-2-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-3.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-3-dark.mCSB_scrollTools_horizontal .mCSB_dragger .mCSB_dragger_bar{height:6px;margin:5px 3px;position:absolute;width:auto;top:0;bottom:0;left:0;right:0}
.mCS-inset.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-inset-dark.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-inset-2.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-inset-2-dark.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-inset-3.mCSB_scrollTools_horizontal .mCSB_draggerRail,.mCS-inset-3-dark.mCSB_scrollTools_horizontal .mCSB_draggerRail{width:100%;height:12px;margin:2px 0}
.mCS-inset.mCSB_scrollTools .mCSB_buttonUp,.mCS-inset-2.mCSB_scrollTools .mCSB_buttonUp,.mCS-inset-3.mCSB_scrollTools .mCSB_buttonUp{background-position:-32px -72px}
.mCS-inset.mCSB_scrollTools .mCSB_buttonDown,.mCS-inset-2.mCSB_scrollTools .mCSB_buttonDown,.mCS-inset-3.mCSB_scrollTools .mCSB_buttonDown{background-position:-32px -92px}
.mCS-inset.mCSB_scrollTools .mCSB_buttonLeft,.mCS-inset-2.mCSB_scrollTools .mCSB_buttonLeft,.mCS-inset-3.mCSB_scrollTools .mCSB_buttonLeft{background-position:-40px -112px}
.mCS-inset.mCSB_scrollTools .mCSB_buttonRight,.mCS-inset-2.mCSB_scrollTools .mCSB_buttonRight,.mCS-inset-3.mCSB_scrollTools .mCSB_buttonRight{background-position:-40px -128px}
.mCS-inset-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.75)}
.mCS-inset-dark.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.85)}
.mCS-inset-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-inset-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.9)}
.mCS-inset-dark.mCSB_scrollTools .mCSB_draggerRail,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_draggerRail,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.1)}
.mCS-inset-dark.mCSB_scrollTools .mCSB_buttonUp,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_buttonUp,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_buttonUp{background-position:-112px -72px}
.mCS-inset-dark.mCSB_scrollTools .mCSB_buttonDown,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_buttonDown,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_buttonDown{background-position:-112px -92px}
.mCS-inset-dark.mCSB_scrollTools .mCSB_buttonLeft,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_buttonLeft,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_buttonLeft{background-position:-120px -112px}
.mCS-inset-dark.mCSB_scrollTools .mCSB_buttonRight,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_buttonRight,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_buttonRight{background-position:-120px -128px}
.mCS-inset-2.mCSB_scrollTools .mCSB_draggerRail,.mCS-inset-2-dark.mCSB_scrollTools .mCSB_draggerRail{background-color:transparent;border-width:1px;border-style:solid;border-color:#fff;border-color:rgba(255,255,255,0.2);-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box}
.mCS-inset-2-dark.mCSB_scrollTools .mCSB_draggerRail{border-color:#000;border-color:rgba(0,0,0,0.2)}
.mCS-inset-3.mCSB_scrollTools .mCSB_draggerRail{background-color:#fff;background-color:rgba(255,255,255,0.6)}
.mCS-inset-3-dark.mCSB_scrollTools .mCSB_draggerRail{background-color:#000;background-color:rgba(0,0,0,0.6)}
.mCS-inset-3.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.75)}
.mCS-inset-3.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.85)}
.mCS-inset-3.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-inset-3.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#000;background-color:rgba(0,0,0,0.9)}
.mCS-inset-3-dark.mCSB_scrollTools .mCSB_dragger .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.75)}
.mCS-inset-3-dark.mCSB_scrollTools .mCSB_dragger:hover .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.85)}
.mCS-inset-3-dark.mCSB_scrollTools .mCSB_dragger:active .mCSB_dragger_bar,.mCS-inset-3-dark.mCSB_scrollTools .mCSB_dragger.mCSB_dragger_onDrag .mCSB_dragger_bar{background-color:#fff;background-color:rgba(255,255,255,0.9)}
</style>
<!-- Конец Дополнительные изображения //-->
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->	
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
<body>
	<section id="page-quickview" role="main">
	<section id="sys-notification">
		<div class="container">
			<?php if ($error) { ?>
			<div class="warning"><?php echo $error ?><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/close.png" alt="" class="close" /></div>
			<?php } ?>
			<div id="notification"></div>
			<script type="text/javascript">
				$(document).ready(function() {
					$( "#notification" ).delegate( "a", "click", function() {
						window.parent.location = $(this).attr('href');
						return false;
					});
				});
			</script>
		</div>
	</section>
	<section id="columns">

<div class="container">
<div class="row">

<section class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	<div id="content" class="product-detail">
		<?php echo $content_top; ?>
  <div class="product-info">
  <div class="row">
    <?php if ($thumb || $images) { ?>
    <div class="col-lg-5 col-md-6 col-sm-5 image-container">
      <?php if ($thumb) { ?>
      <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional">
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
      </div>
      <?php } ?>  
    </div>
    <?php } ?>
	<style>
	.product-info .options, .product-info .description{
		width:100%;
	}
	.product-info .description{
		padding-top:20px;
	}
	.product-info {
		padding:10px 0;
	}
	.product-info h1{
		margin-bottom:15px;
	}
	
	</style>
    <div class="col-lg-7 col-md-6 col-sm-7">
     <h1><?php echo $heading_title; ?></h1>
	  <?php if ($options) { ?>
          <div class="options">
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <select class="form-control" name="option[<?php echo $option['product_option_id']; ?>]">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['option_value'] as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <div class="radio"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
              <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
              </label>
              </div>
              <?php } ?>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <?php foreach ($option['option_value'] as $option_value) { ?>
               <div class="checkbox"><input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
              <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
              </label>
              </div>
              <?php } ?>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'image') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <table class="option-image">
                <?php foreach ($option['option_value'] as $option_value) { ?>
                <tr>
                  <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                  <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                  <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </label></td>
                </tr>
                <?php } ?>
              </table>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'text') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="form-control" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <textarea class="form-control" name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="btn btn-primary button" type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>">
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="form-control date" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>"/>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="form-control datetime" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>"/>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="form-control time" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>"/>
            </div>
            <?php } ?>
            <?php } ?>
          </div>
          <?php } ?>
	  
			<div>
			<?php if($sizechart != ''){ ?>            
                <a href="#sizechart_content" data-href="/index.php?route=themecontrol/product&product_id=2727" class="icolorbox"><span class="check-size"><?php echo $text_sizechart; ?></span></a>
            <?php } ?>  
			<a href="https://siteheart.com/webconsultation/664226?" target="siteheart_sitewindow_664226" onclick="o=window.open;o('https://siteheart.com/webconsultation/664226?', 'siteheart_sitewindow_664226', 'width=550,height=400,top=30,left=30,resizable=yes'); return false;"><span class="online-chat"><?php echo $text_online_chat; ?></span></a>
							
			</div>

        <div class="product-extra">
          <div class="quantity-adder">
		  <?php if ($stock == ('Временно нет в наличии') || $stock == ('Тимчасово немає в наявності') || $stock == ('Немає в наявності') || $stock == ('Нет в наличии') || ($quantity == 0 && ($stock == ('В наличии') || $stock == ('В наявності')))){ ?>
		  <?php } else { ?>
			<span class="text-qty"><?php echo $text_qty; ?></span>
			<input class="form-control" type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
			<?php } ?>
          </div>
          <?php if ($minimum > 1) { ?>
          <div class="minimum"><?php echo $text_minimum; ?></div>
          <?php } ?>
          <div class="group-item">
			<input type="hidden" name="product_id" value="<?php echo $product_id; ?>"/>
            &nbsp;
            <span class="cart">
			<?php if ($quantity == 0 || ($quantity < 0 && !$this->config->get('config_stock_display')) ) { ?>
				<?php if ($stock == ('Временно нет в наличии') || $stock == ('Тимчасово немає в наявності') || $stock == ('Немає в наявності') || $stock == ('Нет в наличии') || $stock == ('В наличии') || $stock == ('В наявності')){ ?>
				<?php }else{ ?>
					<i class="fa fa-shopping-cart"></i>
				<?php } ?>
				<input type="button" value="<?php if($stock == ('В наличии') || $stock == ('В наявності')){ echo 'Нет в наличии';}else{ echo $stock;} ?>" <?php if($stock == ('Временно нет в наличии') || $stock == ('Тимчасово немає в наявності') || $stock == ('Немає в наявності') || $stock == ('Нет в наличии') || $stock == ('В наличии') || $stock == ('В наявності')){ ?> onclick="return(false);" <?php }else{ ?>id="button-cart"<?php } ?> class="button" />
			<?php } elseif ($quantity < 0 && $this->config->get('config_stock_display')) { ?>
				<i class="fa fa-shopping-cart"></i>
				<input type="button" value="<?php echo $stock; ?>" <?php if($stock == ('Временно нет в наличии') || $stock == ('Тимчасово немає в наявності') || $stock == ('Немає в наявності') || $stock == ('Нет в наличии')){ ?> onclick="return(false);" <?php }else{ ?>id="button-cart"<?php } ?> class="button" />
			<?php } else { ?>
				<i class="fa fa-shopping-cart"></i>
				<input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />
			<?php } ?>
			</span>
            <a class="fa fa-heart wishlist" onclick="addToWishList('<?php echo $product_id; ?>');"><span><?php echo $button_wishlist; ?></span></a>
         </div>
		 	  
      </div>
			       
				 <div class="description" style="float:none;">
		
				<?php if ($manufacturer) { ?>
				<span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
				<?php } ?>
				<span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
				<?php if ($reward) { ?>
				<span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
				<?php } ?>
				<span><?php echo $text_stock; ?></span> <?php echo $stock; ?>
				
		<?php if ($attribute_groups) { ?>
			<?php foreach ($attribute_groups as $attribute_group) { ?>
				<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
					<br /><span><?php echo $attribute['name']; ?>: </span><?php echo $attribute['text']; ?>        
				<?php } ?>
			<?php } ?>
		<?php } ?>
				
				
				<div class="category-info product"><?php echo $description; ?></div>
				
					  <div class="share42init" data-title="<?php echo $heading_title; ?>" data-image="<?php echo $popup; ?>"></div>
					 <script type="text/javascript" src="catalog/view/javascript/share42/horizontal/product/share42.js"></script>
      </div>
       <?php if ($profiles): ?>
          <div class="option">
              <h2><span class="required">*</span><?php echo $text_payment_profile ?></h2>
              <select class="form-control" name="profile_id">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($profiles as $profile): ?>
                  <option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
                  <?php endforeach; ?>
              </select>
              
              <span id="profile-description"></span>
              
          </div>
        <?php endif; ?>
        
      
     
          
      
      <?php if ($tags) { ?>
      <div class="tags"><b><?php echo $text_tags; ?></b>
        <?php for ($i = 0; $i < count($tags); $i++) { ?>
        <?php if ($i < (count($tags) - 1)) { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
        <?php } else { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
        <?php } ?>
        <?php } ?>
      </div>
      <?php } ?>
	  <div style="display:none;">
		<div id="sizechart_content">
			<?php echo @html_entity_decode($sizechart, ENT_QUOTES, 'UTF-8'); ?>
		</div>
		</div>
    </div>
  </div>
  </div>
</div>

<?php if( $productConfig['product_enablezoom'] ) { ?>
<script type="text/javascript" src=" catalog/view/javascript/jquery/elevatezoom/elevatezoom-min.js"></script>
<script type="text/javascript">
	<?php if( $productConfig['product_zoomgallery'] == 'slider' ) {  ?>		
		$("#image").elevateZoom( {  gallery:'image-additional-carousel', 
									cursor: 'pointer', 
								 	<?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
									zoomType        : "<?php echo $productConfig['product_zoommode'];?>",
									lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
									lensSize    : <?php echo (int)$productConfig['product_zoomlenssize'];?>,
									<?php } ?>
									galleryActiveClass: 'active' } ); 
		<?php } else { ?>
		var zoomCollection = '<?php echo $productConfig["product_zoomgallery"]=="basic"?".product-image-zoom":"#image";?>';
		$( zoomCollection ).elevateZoom({
		<?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
		zoomType        : "<?php echo $productConfig['product_zoommode'];?>",
		<?php } ?>
		lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
		lensSize    : <?php echo (int)$productConfig['product_zoomlenssize'];?>,
	});
	<?php } ?> 
</script>
<?php } ?>

			<style>
			a.block-option,
			a.block-image-option
			{
				cursor: pointer;
				display: inline-block;
				vertical-align: middle;
				text-decoration: none;
				border-style: solid;
				margin: 3px;
			}
			a.block-image-option img
			{				
				vertical-align: middle;
			}
			</style>
 <script type="text/javascript">
 <!--
$('select[name="profile_id"], input[name="quantity"]').change(function(){
    $.ajax({
    url: 'index.php?route=product/product/getRecurringDescription',
    type: 'post',
    data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
    dataType: 'json',
        beforeSend: function() {
            $('#profile-description').html('');
        },
    success: function(json) {
      $('.success, .warning, .attention, information, .error').remove();
      if (json['success']) {
                $('#profile-description').html(json['success']);
      }
    }
  });
});
$('#button-cart').bind('click', function() {
  $.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
    dataType: 'json',
    success: function(json) {
      $('.success, .warning, .attention, information, .error').remove();
      if (json['error']) {
        if (json['error']['option']) {
          for (i in json['error']['option']) {
            $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
          }
        }

                if (json['error']['profile']) {
                    $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
                }
      } 

      if (json['success']) {
        $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/close.png" alt="" class="close" /></div>');

        $('.success').fadeIn('slow');

        $('#cart-total', window.parent.document ).html(json['total']);
        
        $('html, body').animate({ scrollTop: 0 }, 'slow'); 
      } 
    }
  });
});
//-->
</script>

<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
  action: 'index.php?route=product/product/upload',
  name: 'file',
  autoSubmit: true,
  responseType: 'json',
  onSubmit: function(file, extension) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/loading.gif" class="loading" style="padding-left: 5px;" />');
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
  },
  onComplete: function(file, json) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);

    $('.error').remove();

    if (json['success']) {
      alert(json['success']);
      $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
    }

    if (json['error']) {
      $('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
    }

    $('.loading').remove(); 
  }
});
//-->
</script>

<?php } ?>
<?php } ?>
<?php } ?>

<script type="text/javascript">
<!--
$('#review .pagination a').live('click', function() {
  $('#review').fadeOut('slow');

  $('#review').load(this.href);

  $('#review').fadeIn('slow');

  return false;
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-review').attr('disabled', true);
      $('#review-title').after('<div class="attention"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-review').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(data) {
      if (data['error']) {
        $('#review-title').after('<div class="warning">' + data['error'] + '</div>');
      }

      if (data['success']) {
        $('#review-title').after('<div class="success">' + data['success'] + '</div>');

        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').attr('checked', '');
        $('input[name=\'captcha\']').val('');
      }
    }
  });
});
//-->
</script> 

<script type="text/javascript">
<!--
$('#tabs a').tabs();
//-->
</script> 

<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript">
<!--
$(document).ready(function() {
$("a.block-option, a.block-image-option").click(function(event)
				{
					$this = $(this);
					
					$this.parent().find('a.block-option, a.block-image-option').removeClass('block-active');
					$this.addClass('block-active');
				
					$optionText = $('#' + $this.attr('option-text-id'));
					if($optionText.length == 1)
						$optionText.html($this.attr('title'));
					
					$select = $this.parent().find('select');
					if($select.length > 0)
					{
						$select.val($this.attr('option-value'));
						$select.trigger('change');
						
						//option boost
						if(typeof obUpdate == 'function') {
							obUpdate($($this.parent().find('select option:selected')), useSwatch);
						}
					}
					else //image option
					{
						$this.parent().find("input[type='radio']").prop('checked', false);
						$radio = $this.parent().find("input#option-value-" + $this.attr('option-value'));
						
						$radio.prop('checked', true);
						$radio.trigger('change').trigger('click');
						
						//option boost
						if(typeof obUpdate == 'function') {
							obUpdate($radio, useSwatch);
						}
					}
								
					//option redux
					if(typeof updatePx == 'function') {
						updatePx();
					}
					
					//kit options
					if(typeof recalculateprice == 'function') {
						recalculateprice();
					}
					event.preventDefault();
				});
			
				$("a.block-option").parent('.option').find('.hidden select').change(function()
				{
					$this = $(this);
					var optionValueId = $this.val();
					$blockOption = $('a#block-option-' + optionValueId);
					if(!$blockOption.hasClass('block-active'))
						$blockOption.trigger('click');
				});
  if ($.browser.msie && $.browser.version == 6) {
    $('.date, .datetime, .time').bgIframe();
  }

  $('.date').datepicker({dateFormat: 'yy-mm-dd'});
  $('.datetime').datetimepicker({
    dateFormat: 'yy-mm-dd',
    timeFormat: 'h:m'
  });
  
  $('.time').timepicker({timeFormat: 'h:m'});
  	
  $('a.icolorbox').click(function(event){
		$.colorbox({
			href: $(this).attr('href'),
			inline:true, 
			width:"50%"
		});
		 return false;
	});

	
  $('.colorbox').colorbox({
    overlayClose: true,
    opacity: 0.5,
    rel: "colorbox"
  });

});
//-->
</script> 
</section>
 
 

</div></div>

</section> 
</body></html>