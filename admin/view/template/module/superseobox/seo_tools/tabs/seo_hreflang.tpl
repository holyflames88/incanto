<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<div class="controls">
			<input type="hidden" name="data[tools][href_lang][status]" value="">
			<input data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['href_lang']['status']) echo 'checked="checked"'; ?> name="data[tools][href_lang][status]" class="on_off">
		</div>
	</div>
</div>

<iframe class="pull-right" width="350" height="225" src="//www.youtube.com/embed/8ce9jv91beQ?rel=0" frameborder="0" allowfullscreen></iframe>
<p class="colorFC580B">
<?php echo $text_common_seo_must_turn_on; ?>
</p>
<div class="clearfix"></div>
<h3><?php echo $text_common_seo_hreflang_1; ?></h3>

<p><?php echo $text_common_seo_hreflang_2; ?></p>

<h3><?php echo $text_common_seo_hreflang_3; ?></h3>
<p><?php echo $text_common_seo_hreflang_4; ?>:</p>
<pre>&lt;rel="alternate" hreflang="es" href="http://site.com/es"/&gt;</pre>

<p><?php echo $text_common_seo_hreflang_5; ?></p>