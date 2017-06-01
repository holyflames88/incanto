<div class="pull-left form-horizontal" style="margin-bottom:20px; margin-right:20px;">
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_if_modified_1; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][if_modified][data][product]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['if_modified']['data']['product']) echo 'checked="checked"'; ?> name="data[tools][if_modified][data][product]" class="on_off">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_if_modified_2; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][if_modified][data][category]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['if_modified']['data']['category']) echo 'checked="checked"'; ?> name="data[tools][if_modified][data][category]" class="on_off">
		</div>
	</div>
</div>

<iframe class="pull-right" width="350" height="225" src="//www.youtube.com/embed/hZX1N7IbdFU" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3><?php echo $text_common_if_modified_3; ?></h3>

<p class="colorFC580B">
<?php echo $text_common_if_modified_4; ?>
</p>
<?php echo $text_common_if_modified_5; ?>