<div class="pull-left form-horizontal" style="margin-bottom:20px; margin-right:20px;">
	<div class="control-group">
		<label class="control-label"><?php echo $text_sitemap_name; ?></label>
		<div class="controls">
			<input type="hidden" name="additionData[changeSitemapStatus]" value="true">
			<input type="hidden" name="data[tools][sitemap][status]" value="">
			<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".closest('.pull-left').find('input, select')" type="checkbox" value="true" <?php if($data['tools']['sitemap']['status']) echo 'checked="checked"'; ?> name="data[tools][sitemap][status]" class="on_off noAlert">
			<a data-afteraction="afterAction" data-action="save" data-scope=".closest('.pull-left').find('input, select')" class="btn ajax_action btn-success" type="button"><?php echo $text_common_save; ?></a>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_site_map_1; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][sitemap][data][only_canonical]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['sitemap']['data']['only_canonical']) echo 'checked="checked"'; ?> name="data[tools][sitemap][data][only_canonical]" class="on_off">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_site_map_2; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][sitemap][data][all_language]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['sitemap']['data']['all_language']) echo 'checked="checked"'; ?> name="data[tools][sitemap][data][all_language]" class="on_off">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="">
			<?php echo $text_common_site_map_3; ?>
		</label>
		<div class="controls">
			<input name="data[tools][sitemap][data][priorProduct]" class="span1" value="<?php echo $data['tools']['sitemap']['data']['priorProduct'];?>" min="0" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 0 to 10">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label" for="">
			<?php echo $text_common_site_map_4; ?>
		</label>
		<div class="controls">
			<input name="data[tools][sitemap][data][priorOther]" class="span1" value="<?php echo $data['tools']['sitemap']['data']['priorOther'];?>" min="0" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 0 to 10">
		</div>
	</div>
	<div class="control-group" style="margin-bottom: 10px;">
		<label class="control-label" for="">
			<?php echo $text_common_site_map_5; ?>
		</label>
		<div class="controls">
			<?php $freqs = array('always', 'hourly', 'daily' , 'weekly', 'monthly', 'yearly', 'never'); ?>
			<select name="data[tools][sitemap][data][freq]">
				<?php foreach ($freqs as $freq) { ?>
				<option value="<?php echo $freq; ?>" <?php if($freq == $data['tools']['sitemap']['data']['freq']) echo 'selected="selected"' ?> ><?php echo ucwords($freq); ?></option>
				<?php } ?>
			</select>
		</div>
	</div>
</div>
<h4><?php echo $text_common_site_map_6; ?></h4>
<p><?php echo $text_common_site_map_7; ?></p>
<p><?php echo $text_common_site_map_8; ?></p>
<p><?php echo $text_common_site_map_9; ?></p>

<h4><?php echo $text_common_site_map_10; ?></h4>
<p><?php echo $text_common_site_map_11; ?></p>
<p>

<h4><?php echo $text_common_site_map_12; ?></h4>
<?php echo $text_common_site_map_13; ?>:</br>
<a href="<?php echo HTTP_CATALOG; ?>sitemap.xml" target="_blank"><?php echo HTTP_CATALOG; ?>sitemap.xml</a>
</p>
<p>
<?php echo $text_common_site_map_14; ?>:</br>
<a href="<?php echo HTTP_CATALOG; ?>index.php?route=feed/google_sitemap" target="_blank"><?php echo HTTP_CATALOG; ?>index.php?route=feed/google_sitemap</a>
</p>