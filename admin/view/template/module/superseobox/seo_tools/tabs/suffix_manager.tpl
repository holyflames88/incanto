
<form class="form-horizontal">
	<div class="control-group" style="margin-bottom: -5px;">
		<label class="control-label"><?php echo $text_common_suffix_manager_1; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][suffix_manager][status]" value="">
			<input data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['suffix_manager']['status']) echo 'checked="checked"'; ?> name="data[tools][suffix_manager][status]" class="on_off">
		</div>
	</div>
</form>


<h3><?php echo $text_common_suffix_manager_2; ?></h3>

<p><?php echo $text_common_suffix_manager_3; ?></p>