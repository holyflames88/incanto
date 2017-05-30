<form class="form-horizontal">
<div class="pull-left">
	<div class="control-group" style="margin: 0px 40px 0 0;"><span class="pull-right"><?php echo $text_common_sort_panel_box; ?></span></div>
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_qr_code; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][qr_code][status]" value="">
			<input type="checkbox" value="true" <?php if($data['tools']['qr_code']['status']) echo 'checked="checked"'; ?> name="data[tools][qr_code][status]" class="on_off noAlert">
			<input type="number" name="data[tools][qr_code][data][sort]" class="span1" min="1" max="10" value="<?php echo $data['tools']['qr_code']['data']['sort']; ?>" >
			<a data-afteraction="afterSnipetToolsCahnge" data-action="save" data-scope=".parents('.controls').find('input')" class="btn btn-success ajax_action" type="button"><?php echo $text_common_save; ?></a>
		</div>
	</div>
</div>
</form>
<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/vnjP7Q66x-I?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3><?php echo $text_about . ' ' . $text_common_qr_code; ?></h3>
<?php echo $text_common_qr_code_info_about; ?>