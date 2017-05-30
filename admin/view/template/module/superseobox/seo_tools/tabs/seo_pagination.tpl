<div class="pull-left">
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_seo_pagination_1; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][seo_pagination][status]" value="">
			<input data-afteraction="afterAction" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_pagination']['status']) echo 'checked="checked"'; ?> name="data[tools][seo_pagination][status]" class="on_off">
		</div>
	</div></br>
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_seo_pagination_2; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][seo_pagination][data][pag_link_in_header]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_pagination']['data']['pag_link_in_header']) echo 'checked="checked"'; ?> name="data[tools][seo_pagination][data][pag_link_in_header]" class="on_off">
		</div>
	</div></br>
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_seo_pagination_3; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][seo_pagination][data][add_pag_title]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_pagination']['data']['add_pag_title']) echo 'checked="checked"'; ?> name="data[tools][seo_pagination][data][add_pag_title]" class="on_off">
		</div>
	</div>
	
</div>

<iframe class="pull-right" width="350" height="225" src="//www.youtube.com/embed/njn8uXTWiGg" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>

<p class="colorFC580B">
	<?php echo $text_common_seo_must_turn_on; ?>
</p>

<h3><?php echo $text_common_seo_pagination_4; ?></h3>

<p><?php echo $text_common_seo_pagination_5; ?></p>

<ul>
  <?php echo $text_common_seo_pagination_6; ?>
</ul>

<h3><?php echo $text_common_seo_pagination_7; ?></h3>

<p><?php echo $text_common_seo_pagination_8; ?></p>

<p><?php echo $text_common_seo_pagination_9; ?>:</p>

<pre>
http://www.site.com/catalog?page=1
http://www.site.com/catalog?page=2
http://www.site.com/catalog?page=3
http://www.site.com/catalog?page=4
</pre>

<ol>
  <li><?php echo $text_common_seo_pagination_10; ?>:
	<pre>
	http://www.site.com/catalog/page-1
	http://www.site.com/catalog/page-2
	http://www.site.com/catalog/page-3
	http://www.site.com/catalog/page-4</pre>
  </li>	
  <li><?php echo $text_common_seo_pagination_11; ?>:

    <pre>&lt;link rel="next" href="http://www.site.com/catalog/page-2"&gt;</pre>

    <p><?php echo $text_common_seo_pagination_12; ?>.</p>
  </li>
  <li><?php echo $text_common_seo_pagination_13; ?>:
    <pre>&lt;link rel="prev" href="http://www.site.com/catalog/page-1"&gt;
&lt;link rel="next" href="http://www.site.com/catalog1/page-3"&gt;
</pre>
  </li>
  <li><?php echo $text_common_seo_pagination_14; ?>:
    <pre>&lt;link rel="prev" href="http://www.site.com/catalog1/page-3"&gt;</pre>

    <p><?php echo $text_common_seo_pagination_15; ?></p>
  </li>
</ol>