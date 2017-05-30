<script type="text/javascript">
var shPanelBar_data = {
		pan_box			: <?php echo json_encode($panalBarData['panel_box']); ?>,
		panel_box_css	: <?php echo json_encode($panalBarData['panel_box_css']); ?>,
		combination		: '<?php echo $panalBarData['combination']; ?>',
		combination_orig: '<?php echo $panalBarData['combination']; ?>',
		share_button	: <?php echo json_encode($panalBarData['share_button']); ?>, 
		soc_buttons		: <?php echo json_encode($panalBarData['soc_buttons']); ?>,
		qr_code			: <?php echo json_encode($panalBarData['qr_code']); ?>,
		pb_pos			: <?php echo json_encode($panalBarData['panel_box']['position']); ?>,
		page_title		: '<?php echo addslashes($title); ?>',
		share_image		: '<?php echo $logo; ?>',
		opacity_lev		: <?php echo (float)$panalBarData['panel_box_css']['opacity']; ?>,
		pb_orig_pos 	: {},
		url_get_qr 		: '<?php echo htmlspecialchars_decode(json_encode($panalBarData['url_get_qr'])); ?>',
		direction		: '<?php echo $panalBarData['panel_box']['position']['direction']; ?>',
		direction_orig	: '<?php echo $panalBarData['panel_box']['position']['direction']; ?>',
		countReader : '<?php echo htmlspecialchars_decode(json_encode($panalBarData['url_countReader'])); ?>'
	};
</script>

<style type="text/css">
.tipsy { font-size: 10px; position: absolute; padding: 5px; z-index: 100000; }
.tipsy-inner { background-color: #000; color: #FFF; padding: 5px 8px 4px 8px; text-align: center; }
.tipsy-inner { border-radius: 3px; -moz-border-radius: 3px; -webkit-border-radius: 3px; }
.tipsy-arrow { position: absolute; width: 0; height: 0; line-height: 0; border: 5px dashed #000; }
.tipsy-arrow-n { border-bottom-color: #000; }
.tipsy-arrow-s { border-top-color: #000; }
.tipsy-arrow-e { border-left-color: #000; }
.tipsy-arrow-w { border-right-color: #000; }
.tipsy-n .tipsy-arrow { top: 0px; left: 50%; margin-left: -5px; border-bottom-style: solid; border-top: none; border-left-color: transparent; border-right-color: transparent; }
.tipsy-nw .tipsy-arrow { top: 0; left: 10px; border-bottom-style: solid; border-top: none; border-left-color: transparent; border-right-color: transparent;}
.tipsy-ne .tipsy-arrow { top: 0; right: 10px; border-bottom-style: solid; border-top: none;  border-left-color: transparent; border-right-color: transparent;}
.tipsy-s .tipsy-arrow { bottom: 0; left: 50%; margin-left: -5px; border-top-style: solid; border-bottom: none;  border-left-color: transparent; border-right-color: transparent; }
.tipsy-sw .tipsy-arrow { bottom: 0; left: 10px; border-top-style: solid; border-bottom: none;  border-left-color: transparent; border-right-color: transparent; }
.tipsy-se .tipsy-arrow { bottom: 0; right: 10px; border-top-style: solid; border-bottom: none; border-left-color: transparent; border-right-color: transparent; }
.tipsy-e .tipsy-arrow { right: 0; top: 50%; margin-top: -5px; border-left-style: solid; border-right: none; border-top-color: transparent; border-bottom-color: transparent; }
.tipsy-w .tipsy-arrow { left: 0; top: 50%; margin-top: -5px; border-right-style: solid; border-left: none; border-top-color: transparent; border-bottom-color: transparent; }
.ssb-shar-container{
	display:none;
	position: absolute;
	padding:5px;
}
.ssb-shar-button{
	position: absolute;
	width:  50px;
	height: 50px;
	background: #000 url('<?php echo $panalBarData['url_start']; ?>image/ssb_image/share-icon-white.png') center center no-repeat;

}
.sharrre{
	float:left;
  }
  .sharrre .box a:hover{
	text-decoration:none;
  }
  .sharrre .count {
	color:#525b67;
	display:block;
	font-size:18px;
	font-weight:bold;
	line-height:40px;
	height:40px;
	position:relative;
	text-align:center;
	width:50px;
	-webkit-border-radius:4px;
	-moz-border-radius:4px;
	border-radius:4px;
	border:1px solid #b2c6cc;
	background: #fbfbfb; /* Old browsers */
	background: -moz-linear-gradient(top, #fbfbfb 0%, #f6f6f6 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#fbfbfb), color-stop(100%,#f6f6f6)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top, #fbfbfb 0%,#f6f6f6 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top, #fbfbfb 0%,#f6f6f6 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top, #fbfbfb 0%,#f6f6f6 100%); /* IE10+ */
	background: linear-gradient(top, #fbfbfb 0%,#f6f6f6 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fbfbfb', endColorstr='#f6f6f6',GradientType=0 ); /* IE6-9 */
  }
  .sharrre .count:before, .sharrre .count:after {
	content:'';
	display:block;
	position:absolute;
	left:49%;
	width:0;
	height:0;
  }
  .sharrre .count:before {
	border:solid 7px transparent;
	border-top-color:#b2c6cc;
	margin-left:-7px;
	bottom: -14px;
  }
  .sharrre .count:after {
	border:solid 6px transparent;
	margin-left:-6px;
	bottom:-12px;
	border-top-color:#fbfbfb;
  }
  .sharrre .share {
	color:#FFFFFF;
	display:block;
	font-size:12px;
	font-weight:bold;
	height:30px;
	line-height:30px;
	margin-top:8px;
	padding:0;
	text-align:center;
	text-decoration:none;
	width:50px;
	-webkit-border-radius:4px;
	-moz-border-radius:4px;
	border-radius:4px; 
  }  

  
#ssb-share-bar{
	position:absolute;  
    border: 0px;  
    z-index: 10000;
	<?php if($panalBarData['panel_box']['position']['targetRight']) $panalBarData['panel_box_css']['margin'] = -(int)$panalBarData['panel_box_css']['margin']; ?>
	margin: <?php echo (int)$panalBarData['panel_box_css']['margin']; ?>px;
}
	
#ssb-share-bar <?php if($panalBarData['share_button']){ ?>.ssb-shar-container<?php }?>{
	
	padding: 5px 0;
	
	<?php if($panalBarData['panel_box_css']['bg_status']) { ?>
	background:<?php echo $panalBarData['panel_box_css']['background']; ?>;
	<?php } ?>
	-webkit-border-radius: <?php echo (int)$panalBarData['panel_box_css']['border_r']; ?>px;
	-moz-border-radius: <?php echo (int)$panalBarData['panel_box_css']['border_r']; ?>px;
	border-radius: <?php echo (int)$panalBarData['panel_box_css']['border_r']; ?>px;
	<?php $opacity = $panalBarData['panel_box_css']['opacity'] =='' ? 1 : (float)$panalBarData['panel_box_css']['opacity']; ?>;
	-moz-opacity: <?php echo $opacity; ?>;
	opacity: <?php echo $opacity; ?>;
	-ms-filter:"progid:DXImageTransform.Microsoft.Alpha"(Opacity=<?php echo $opacity; ?>);
}
	<?php if($panalBarData['share_button']){ ?>
	.ssb-shar-button{
		background-color:<?php echo $panalBarData['panel_box_css']['background']; ?>;
		-webkit-border-radius: <?php echo (int)$panalBarData['panel_box_css']['border_r']; ?>px;
		-moz-border-radius: <?php echo (int)$panalBarData['panel_box_css']['border_r']; ?>px;
		border-radius: <?php echo (int)$panalBarData['panel_box_css']['border_r']; ?>px;
			<?php if($panalBarData['panel_box']['position']['targetRight']) $panalBarData['panel_box_css']['margin'] = -(int)$panalBarData['panel_box_css']['margin']; ?>
		margin: <?php echo (int)$panalBarData['panel_box_css']['margin']; ?>px;
		<?php $opacity = $panalBarData['panel_box_css']['opacity'] =='' ? 1 : (float)$panalBarData['panel_box_css']['opacity']; ?>;
		-moz-opacity: <?php echo $opacity; ?>;
		opacity: <?php echo $opacity; ?>;
		-ms-filter:"progid:DXImageTransform.Microsoft.Alpha"(Opacity=<?php echo $opacity; ?>);
	}
	<?php } ?>

	<?php if($panalBarData['soc_buttons']['data']['Twitter']['status']){ ?> 
	#ssb-share-bar .twitter .share {
		text-shadow: 1px 0px 0px #0077be;
		filter: dropshadow(color=#0077be, offx=1, offy=0); 
		border:1px solid #0075c5;
		background: #26c3eb;
		background: -moz-linear-gradient(top, #26c3eb 0%, #26b3e6 50%, #00a2e1 51%, #0080d6 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#26c3eb), color-stop(50%,#26b3e6), color-stop(51%,#00a2e1), color-stop(100%,#0080d6)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #26c3eb 0%,#26b3e6 50%,#00a2e1 51%,#0080d6 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #26c3eb 0%,#26b3e6 50%,#00a2e1 51%,#0080d6 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #26c3eb 0%,#26b3e6 50%,#00a2e1 51%,#0080d6 100%); /* IE10+ */
		background: linear-gradient(top, #26c3eb 0%,#26b3e6 50%,#00a2e1 51%,#0080d6 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#26c3eb', endColorstr='#0080d6',GradientType=0 ); /* IE6-9 */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #5cd3f1 inset;
	}<?php }?>
	  
	<?php if($panalBarData['soc_buttons']['data']['Facebook']['status']){ ?>  
	#ssb-share-bar .facebook .share {
		text-shadow: 1px 0px 0px #26427e;
		filter: dropshadow(color=#26427e, offx=1, offy=0); 
		border:1px solid #24417c;
		background: #5582c9; /* Old browsers */
		background: -moz-linear-gradient(top, #5582c9 0%, #33539a 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#5582c9), color-stop(100%,#33539a)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #5582c9 0%,#33539a 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #5582c9 0%,#33539a 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #5582c9 0%,#33539a 100%); /* IE10+ */
		background: linear-gradient(top, #5582c9 0%,#33539a 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#5582c9', endColorstr='#33539a',GradientType=0 ); /* IE6-9 */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #80a1d6 inset;
	}<?php }?>
	 
	<?php if($panalBarData['soc_buttons']['data']['Google']['status']){ ?> 
	#ssb-share-bar .google .share {
		font-size: 130%;
		text-shadow: 1px 0px 0px #222222;
		filter: dropshadow(color=#222222, offx=1, offy=0); 
		border:1px solid #262626;
		background: #6d6d6d; /* Old browsers */
		background: -moz-linear-gradient(top, #6d6d6d 0%, #434343 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#6d6d6d), color-stop(100%,#434343)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #6d6d6d 0%,#434343 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #6d6d6d 0%,#434343 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #6d6d6d 0%,#434343 100%); /* IE10+ */
		background: linear-gradient(top, #6d6d6d 0%,#434343 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#6d6d6d', endColorstr='#434343',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}<?php }?>
	 
	<?php if($panalBarData['soc_buttons']['data']['Pinterest']['status']){ ?> 
	#ssb-share-bar .pinterest .share {
		font-size: 120%;
		text-shadow: 1px 0px 0px #9B171E;
		filter: dropshadow(color=#9B171E, offx=1, offy=0); 
		border:1px solid #9B171E;
		background: #C51E25; /* Old browsers */
		background: -moz-linear-gradient(top, #E45259 0%, #C51E25 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#E45259), color-stop(100%,#C51E25)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #E45259 0%,#C51E25 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #E45259 0%,#C51E25 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #E45259 0%,#C51E25 100%); /* IE10+ */
		background: linear-gradient(top, #E45259 0%,#C51E25 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#E45259', endColorstr='#C51E25',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}<?php }?>
	
	<?php if($panalBarData['soc_buttons']['data']['Linkedin']['status']){ ?>
	#ssb-share-bar .linkedin .share {
		text-shadow: 1px 0px 0px #666666;
		filter: dropshadow(color=#666666, offx=1, offy=0); 
		border:1px solid #666666;
		background: #757575; /* Old browsers */
		background: -moz-linear-gradient(top, #BBBBBB 0%, #757575 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#E45259), color-stop(100%,#757575)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #BBBBBB 0%,#757575 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #BBBBBB 0%,#757575 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #BBBBBB 0%,#757575 100%); /* IE10+ */
		background: linear-gradient(top, #BBBBBB 0%,#757575 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#E45259', endColorstr='#757575',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}<?php }?>
	
	<?php if($panalBarData['soc_buttons']['data']['Odnoklassniki']['status']){ ?>
	#ssb-share-bar .odnoklassniki .share {
		font-size: 130%;
		text-shadow: 1px 0px 0px #B7610B;
		filter: dropshadow(color=#B7610B, offx=1, offy=0); 
		border:1px solid #B7610B;
		background: #DD750D; /* Old browsers */
		background: -moz-linear-gradient(top, #F59B41 0%, #DD750D 100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#E45259), color-stop(100%,#DD750D)); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #F59B41 0%,#DD750D 100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #F59B41 0%,#DD750D 100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #F59B41 0%,#DD750D 100%); /* IE10+ */
		background: linear-gradient(top, #F59B41 0%,#DD750D 100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#E45259', endColorstr='#DD750D',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}
	#ssb-share-bar .odnoklassniki span.non-count{
		border:0px!important;
		-moz-opacity: 0;
		opacity: 0;
		-ms-filter:"progid:DXImageTransform.Microsoft.Alpha"(Opacity=0);
	}
	#ssb-share-bar .odnoklassniki .share span.count{
		display: block;
		margin-top: -80px;
		margin-left: -1px;
		text-shadow: 0px 0px #fff;
	}<?php }?>
	
	<?php if($panalBarData['qr_code']['status']){ ?>
	#ssb-share-bar .ssb_qr-code .count{border: 1px solid #fff;}
	#ssb-share-bar .ssb_qr-code img.count{border: 0px;}
	#ssb-share-bar .ssb_qr-code .share {
		font-size: 120%;
		text-shadow: 1px 0px 0px #2C2C2C;
		filter: dropshadow(color=#2C2C2C, offx=1, offy=0); 
		border:1px solid #4B4B00 ;
		background: #5A5A02 ; /* Old browsers */
		background: -moz-linear-gradient(top, #C2CA04   0%, #5A5A02  100%); /* FF3.6+ */
		background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#E45259), color-stop(100%,#5A5A02 )); /* Chrome,Safari4+ */
		background: -webkit-linear-gradient(top, #C2CA04   0%,#5A5A02  100%); /* Chrome10+,Safari5.1+ */
		background: -o-linear-gradient(top, #C2CA04   0%,#5A5A02  100%); /* Opera 11.10+ */
		background: -ms-linear-gradient(top, #C2CA04   0%,#5A5A02  100%); /* IE10+ */
		background: linear-gradient(top, #C2CA04   0%,#5A5A02  100%); /* W3C */
		filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#E45259', endColorstr='#5A5A02 ',GradientType=0 ); /* IE6-9  */
		box-shadow: 0 1px 4px #DDDDDD, 0 1px 0 #929292 inset;
	}<?php }?>
</style>