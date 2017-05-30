<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_qr_code; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][qr_code][status]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['qr_code']['status']) echo 'checked="checked"'; ?> name="data[tools][qr_code][status]" class="on_off">
		</div>
	</div>
</div>

<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/vnjP7Q66x-I?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3><?php echo $text_about . ' ' . $text_common_qr_code; ?></h3>
<?php echo $text_common_qr_code_info_about; ?>