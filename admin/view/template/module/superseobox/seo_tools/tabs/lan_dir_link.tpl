<div>
	<div class="control-group form-horizontal">
		<form class="form-horizontal">
			<div class="control-group">
				<label class="control-label" style="width: 138px;"><?php echo $text_common_lan_dir_link_1; ?> </label>
				<div class="controls" style="margin-left: 155px;">
					<input type="hidden" name="data[tools][lang_dir_link][data][prefix]" value="">
					<input data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['lang_dir_link']['data']['prefix']) echo 'checked="checked"'; ?> name="data[tools][lang_dir_link][data][prefix]" class="on_off">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" style="width: 138px;"><?php echo $text_common_lan_dir_link_2; ?></label>
				<?php $mode = $data['tools']['lang_dir_link']['data']['mode']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="natural" class="btn btn-success <?php if($mode == 'natural') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set natural mode" >
						<?php echo $text_common_natural; ?></a>
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="special" class="btn btn-success <?php if($mode == 'special') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set special mode" >
						<?php echo $text_common_special; ?></a>
						<a type="button" data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" data-condition="default" class="btn <?php if($mode == 'default') echo "active"; ?>" data-toggle="tooltip" data-original-title="Set defaul mode" >
						<?php echo $text_common_default; ?></a>
					</div>
					<input type="hidden" name="data[tools][lang_dir_link][data][mode]" value="<?php echo $mode; ?>">
				</div>
			</div>
		</form>
	</div>
</div>

<h3><?php echo $text_common_lan_dir_link_6; ?></h3>
<p>
<?php echo $text_common_lan_dir_link_7; ?>:
</p>
<pre>
	<?php echo htmlspecialchars(
	'site.com/category
	site.com/fr/category
	site.com/uk/category');?></pre></br>

<h3><?php echo $text_common_lan_dir_link_8; ?></h3>

<p class="colorFC580B">
<?php echo $text_common_seo_must_turn_on; ?> 
</p>

<p><?php echo $text_common_lan_dir_link_9; ?>:</p>
<pre>
<?php echo htmlspecialchars(
	'<div id="language">
        <img src="image/flags/us.png" alt="English" title="English" onclick="$(\'input[name=\'language_code\']\').attr(\'value\', \'en\'); $(this).parent().parent().submit();">
        <img src="image/flags/fr.png" alt="French" title="French" onclick="$(\'input[name=\'language_code\']\').attr(\'value\', \'fr\'); $(this).parent().parent().submit();">
        <img src="image/flags/ua.png" alt="Ukrainian" title="Ukrainian" onclick="$(\'input[name=\'language_code\']\').attr(\'value\', \'uk\'); $(this).parent().parent().submit();">
        <input type="hidden" name="language_code" value="">
		<input type="hidden" name="redirect" value="http://site.com">
	</div>'); 
  
?>
</pre>
<h3><?php echo $text_common_lan_dir_link_10; ?>:</h3>

<p>
	<h4><?php echo $text_common_lan_dir_link_11; ?></h4>
	<?php echo $text_common_lan_dir_link_12; ?>
	<pre>
	<?php echo htmlspecialchars(
	'<div id="language">Language<br>
		<a href="http://site.com/category"><img src="image/flags/us.png" alt="English" title="English"></a>
		<a href="http://site.com/fr/category"><img src="image/flags/fr.png" alt="French" title="French"></a>
		<a href="http://site.com/uk/category"><img src="image/flags/ua.png" alt="Ukrainian" title="Ukrainian"></a>
	</div>');?></pre></br>
</p>

<p>
	<h4><?php echo $text_common_lan_dir_link_13; ?></h4>
	<?php echo $text_common_lan_dir_link_14; ?>
	<pre>
	<?php echo htmlspecialchars(
	'<div id="language">Language<br>
		<a href="http://site.com"/category><img src="image/flags/us.png" alt="English" title="English"></a>
		<a href="http://site.com/change-fr/category"><img src="image/flags/fr.png" alt="French" title="French"></a>
		<a href="http://site.com/change-uk/category"><img src="image/flags/ua.png" alt="Ukrainian" title="Ukrainian"></a>
	</div>');?></pre></br>
</p>

<p>
	<h4><?php echo $text_common_lan_dir_link_15; ?></h4>
	<?php echo $text_common_lan_dir_link_16; ?>
</p>

<h5>
<?php echo $text_common_lan_dir_link_17; ?>
</h5>