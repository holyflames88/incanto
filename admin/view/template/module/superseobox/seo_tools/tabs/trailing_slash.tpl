<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_trailing_slash_1; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][trailing_slash][status]" value="">
			<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['trailing_slash']['status']) echo 'checked="checked"'; ?> name="data[tools][trailing_slash][status]" class="on_off noAlert">
		</div>
	</div>
</div>

<h3><?php echo $text_common_trailing_slash_2; ?></h3>
<p class="colorFC580B">
<?php echo $text_common_trailing_slash_3; ?>
</p>
<p class="colorFC580B">
<?php echo $text_common_seo_must_turn_on; ?>
</p>
<p><?php echo $text_common_trailing_slash_4; ?>:</p>
<pre>
http://example.com/foo/ (with trailing slash, conventionally a directory)
http://example.com/foo (without trailing slash, conventionally a file)
</pre>
<p><?php echo $text_common_trailing_slash_5; ?></p>
<p><?php echo $text_common_trailing_slash_6; ?>:
http://example.com/parent-directory/child-directory/</p>

<p><?php echo $text_common_trailing_slash_7; ?>:</br></br>
http://your-domain-here/some-directory-here/ 
(<?php echo $text_common_trailing_slash_8; ?>)</br></br>
http://your-domain-here/some-directory-here 
(<?php echo $text_common_trailing_slash_9; ?>)</br></br>
<?php echo $text_common_trailing_slash_10; ?>

<ul>
<?php echo $text_common_trailing_slash_11; ?>
</ul>
</p>
