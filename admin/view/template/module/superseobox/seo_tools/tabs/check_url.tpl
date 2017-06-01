<div>
	<div class="control-group form-horizontal">
		<form class="form-horizontal">
			<div class="control-group">
				<label class="control-label" style="width: 138px;"><?php echo $text_common_use_check_url; ?> </label>
				<div class="controls" style="margin-left: 155px;">
					<input type="hidden" name="data[tools][check_url][status]" value="">
					<input data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['check_url']['status']) echo 'checked="checked"'; ?> name="data[tools][check_url][status]" class="on_off">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" style="width: 138px;"><?php echo $text_common_use_check_0; ?></label>
				<?php $mode = $data['tools']['check_url']['data']['mode']['wrong_path']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="redirect" class="btn btn-success <?php if($mode == 'redirect') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set redirect mode" >
						<?php echo $text_common_use_check_1; ?></a>
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="page404" class="btn btn-success <?php if($mode == 'page404') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set page 404 mode" >
						<?php echo $text_common_use_check_2; ?></a>
					</div>
					<input type="hidden" name="data[tools][check_url][data][mode][wrong_path]" value="<?php echo $mode; ?>">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" style="width: 138px;"><?php echo $text_common_use_check_5; ?></label>
				<?php $mode = $data['tools']['check_url']['data']['mode']['wrong_url']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="redirect" class="btn btn-success <?php if($mode == 'redirect') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set redirect mode" >
						<?php echo $text_common_use_check_1; ?></a>
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="page404" class="btn btn-success <?php if($mode == 'page404') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set page 404 mode" >
						<?php echo $text_common_use_check_2; ?></a>
					</div>
					<input type="hidden" name="data[tools][check_url][data][mode][wrong_url]" value="<?php echo $mode; ?>">
				</div>
			</div>
		</form>
	</div>
</div>

<h3><?php echo $text_common_use_check_4; ?></h3>
<p><?php echo $text_common_use_check_6; ?></p>
<pre>
<?php echo htmlspecialchars(
	'site.com/categoryA/productName.html');?></pre></br>
<p>
<?php echo $text_common_use_check_7; ?>
</p>
<p>
<pre>
<?php echo htmlspecialchars(
'site.com/categoryA/categoryB/productName.html
site.com/categoryB/categoryA/productName.html
site.com/any_text/productName.html
site.com/any_text/any_text/any_text/productName.html
site.com/manufacturerA/productName.html');?>
</pre>
</p>
<p>
<?php echo $text_common_use_check_9; ?>
</p>