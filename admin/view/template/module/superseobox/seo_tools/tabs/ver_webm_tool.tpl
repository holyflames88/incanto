<p><?php echo $text_common_tool_ver_webm_tool_0; ?>:</p>
<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<label class="control-label">
		<a target="_blank" href="https://www.google.com/webmasters/tools/dashboard?hl=en&amp;siteUrl=<?php  echo urlencode(HTTP_CATALOG); ?>%2F"><?php echo $text_common_tool_ver_webm_tool_1; ?></a>
		</label>
		<div class="controls">
			<input type="text" name="data[tools][webm_tool][data][google]" value="<?php echo $data['tools']['webm_tool']['data']['google']; ?>">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">
		<a target="_blank" href="http://www.bing.com/webmaster/?rfp=1#/Dashboard/?url=<?php echo str_replace( 'http://', '', HTTP_CATALOG ) ?>"><?php echo $text_common_tool_ver_webm_tool_01; ?></a>
		</label>
		<div class="controls">
			<input type="text" name="data[tools][webm_tool][data][bing]" value="<?php echo $data['tools']['webm_tool']['data']['bing']; ?>">
		</div>
	</div>
	<div class="control-group">
		<label class="control-label">
		<a target="_blank" href="http://www.alexa.com/pro/subscription"><?php echo $text_common_tool_ver_webm_tool_02; ?></a>
		</label>
		<div class="controls">
			<input type="text" name="data[tools][webm_tool][data][alexa]" value="<?php echo $data['tools']['webm_tool']['data']['alexa']; ?>">
		</div>
	</div>
<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn btn-success ajax_action span2" type="button"><?php echo $text_common_save; ?></a>
</div>

<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/COcl6ax38IY?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<p>
<?php echo $text_common_tool_ver_webm_tool_03; ?>
</p>
<h3><?php echo $text_common_tool_ver_webm_tool_2; ?></h3>

<p><?php echo $text_common_tool_ver_webm_tool_3; ?></p>

<p><?php echo $text_common_tool_ver_webm_tool_4; ?>:</p>

<ul>
	<?php echo $text_common_tool_ver_webm_tool_4; ?>
</ul>