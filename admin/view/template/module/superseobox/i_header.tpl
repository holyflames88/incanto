<!DOCTYPE html>
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" >
<head>
<meta charset="UTF-8" />
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content="<?php echo $keywords; ?>" />
<?php } ?>

<script type="text/javascript" src="view/stylesheet/superseobox/iframe/js/jquery/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="view/stylesheet/superseobox/iframe/js/jquery/ui/jquery-ui-1.8.16.custom.min.js"></script>
<link type="text/css" href="view/stylesheet/superseobox/iframe/js/jquery/ui/themes/ui-lightness/jquery-ui-1.8.16.custom.css" rel="stylesheet" />


<link rel="stylesheet" type="text/css" href="view/stylesheet/superseobox/iframe/css/stylesheet.css" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/superseobox/bootstrap/css/bootstrap.min.css" media="screen" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/superseobox/bootstrap/css/bootstrap-responsive.min.css" media="screen" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/superseobox/bootstrap-editable/css/bootstrap-editable.css" media="screen" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/superseobox/bootstrap-wysihtml5/bootstrap-wysihtml5-0.0.2/bootstrap-wysihtml5-0.0.2.css" media="screen" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/superseobox/bootstrap-editable/inputs/select2/lib/select2.css" media="screen" />
<link rel="stylesheet" type="text/css" href="view/stylesheet/superseobox/style.css" media="screen" />

<script type="text/javascript" src="view/javascript/superseobox/plugin/plugin_bl.js"></script>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="view/stylesheet/superseobox/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="view/stylesheet/superseobox/bootstrap-editable/js/bootstrap-editable.min.js"></script>
<script type="text/javascript" src="view/javascript/superseobox/plugin/prettify/prettify.js"></script>
<script type="text/javascript" src="view/stylesheet/superseobox/bootstrap-wysihtml5/bootstrap-wysihtml5-0.0.2/wysihtml5-0.3.0.min.js"></script>
<script type="text/javascript" src="view/stylesheet/superseobox/bootstrap-wysihtml5/bootstrap-wysihtml5-0.0.2/bootstrap-wysihtml5-0.0.2.min.js"></script>
<script type="text/javascript" src="view/stylesheet/superseobox/bootstrap-wysihtml5/wysihtml5.js"></script>
<script type="text/javascript" src="view/stylesheet/superseobox/bootstrap-editable/inputs/select2/lib/select2.min.js"></script>
<script type="text/javascript" src="view/javascript/superseobox/plugin/jscolor/jscolor.js"></script>
<script type="text/javascript" src="view/javascript/superseobox/index.js"></script>

<script type="text/javascript">
	var PSBdat = {
		data 			: <?php echo json_encode($data); ?>,
		
		patterns		: <?php echo json_encode($patterns); ?>,
		CPBI_parameters	: <?php echo json_encode($CPBI_parameters); ?>,
		MD_PatternAddVal: <?php echo json_encode($MD_PatternAddVal); ?>,
		
		url				: <?php echo htmlspecialchars_decode(json_encode($urls)); ?>,
		
		token 			: '<?php echo $token; ?>',
		VER_status 		: <?php echo $VER_status; ?>,
		seo_power		: <?php echo $seo_power; ?>,
		update_text		: '<?php echo $update_text; ?>',
		HTTP_SERVER		: '<?php echo $HTTP_SERVER; ?>'
	}
	var paladinLanguage = { //paladinLanguage.text_seo_power
		start_process 	: '<?php echo $text_start_process; ?>',
		error 			: '<?php echo $text_error; ?>',
		must_between 	: '<?php echo $must_between; ?>',
		text_done 		: '<?php echo $text_done; ?>',
		text_all_done 	: '<?php echo $text_all_done; ?>',
		text_error 		: '<?php echo $text_error; ?>',
		town_name_in 	: '<?php echo $town_name_in; ?>',
		text_seo_power 	: '<?php echo $text_seo_power; ?>'
	};
	/* set additional value before insert => MD_PatternAddVal */
	
	jQuery(document).ready(function() {
		setTimeout(function(){
			$('.turn-status img').click(function(){
				$( ".turn-status img" ).toggleClass( "hide" );
				var status = $( ".turn-status .input-power-status").val();
				if(status == 1){
					status = 0;
				}else{
					status = 1;
				}
				$( ".turn-status .input-power-status").val(status);
				PSBeng.action($( ".button-power-status"));
			});	
			$('.turn-status img').tooltip();
		}, 6000);
		
	});
	
</script>

</head>
<body>
<?php if($direction == 'rtl'){ /* templ_url */ ?>
<style>
	body *{
		direction: ltr!important;
	}
</style>
<?php } ?>
<h4>
	<img class="loading" src="view/stylesheet/superseobox/images/logo-small.png"> <?php echo $heading_title; ?> (<?php echo $version; ?>)
</h4>
<div id="content">
	<div class="box">
		<div class="heading">
			<div class="dropdown" style="float: left;margin-top: 9px;margin-left: 28px;">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon-bell"></i> <?php echo $text_get_support; ?> <b class="caret"></b></a>
					<ul class="dropdown-menu support_menu">
						<li><a href="#seo_support" data-toggle="tab"><?php echo $text_get_support_updates; ?></a></li>
						<li class="divider"></li>
						<li><a href="#question" data-toggle="tab"><?php echo $text_question; ?></a></li>
						<li class="divider"></li>
						<li><a href="#improve_mod" data-toggle="tab"><?php echo $text_improving; ?></a></li>
						<!--<li><a class="show_license_condition">License Conditions</a></li>!-->
					</ul>
			</div>
			<div class="pull-right" style="margin-top: 5px;">
			<script class="start_here">
			jQuery(document).ready(function() {
				setTimeout(function(){
					ssb_blink('.start_here');
				}, 1000);
				setTimeout(function(){
					$('.start_here').stop().fadeOut('1000').remove();
				}, 6000);
				
				function ssb_blink(selector) {
					$(selector).fadeOut('1000',function() {
						$(this).fadeIn('1000',function() {
							ssb_blink(this);
						});
					});
				}
			});
			</script>
						
			<a class="btn btn-warning" href="http://paladin.openseocart.com/component/com_fss/Itemid,309/view,main/" title="Documentation/forum/ticket/support" target="_blank">Documentation</a>
			
			<a class="btn btn-warning intro-start" data-placement="bottom" data-toggle="tooltip" title="<?php echo $text_common_header_1; ?>" ><?php echo $text_introduction_tour; ?></a>
			
			<a href="https://www.youtube.com/watch?v=bJ5_sdxMhik&hd=1&vq=hd720" target="_blank" class="btn btn-warning videotutorial" data-placement="bottom" data-toggle="tooltip" title="<?php echo $text_common_header_2; ?>" ><?php echo $text_videotutorial; ?></a>
			
			<a href="<?php echo $urls['about_info']; ?>" class="btn btn-small btn-info" type="button" data-toggle="modal"><?php echo $text_about; ?></a>

			</div>
		</div>
		<div class="content">