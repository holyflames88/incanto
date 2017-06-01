<div class="pull-left" style="width:200px;">
	<div class="control-group">
		<label class="control-label"><?php echo $text_common_seo_tool_canonical_1; ?></label>
		<div class="controls">
			<input type="hidden" name="data[tools][canonical][status]" value="">
			<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['canonical']['status']) echo 'checked="checked"'; ?> name="data[tools][canonical][status]" class="on_off">
		</div>
	</div>
</div>

<iframe class="pull-right" width="350" height="225" src="//www.youtube.com/embed/Cm9onOGTgeM?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3><?php echo $text_common_seo_tool_canonical_2; ?></h3>

<p><?php echo $text_common_seo_tool_canonical_3; ?></p>
<h3><?php echo $text_common_seo_tool_canonical_4; ?></h3>
<p><?php echo $text_common_seo_tool_canonical_5; ?>:</p>
<pre>http://www.site.com/category/product.html?trackingid=1234567&amp;sort=alpha&amp;sessionid=5678asfasdfasfd
http://www.site.com/category/product.html?trackingid=1234567&amp;sort=price&amp;sessionid=5678asfasdfasfd</pre>
<p><?php echo $text_common_seo_tool_canonical_6; ?></p>
<h3><?php echo $text_common_seo_tool_canonical_7; ?></h3>
<p><?php echo $text_common_seo_tool_canonical_8; ?>:</p>
<ul>
	<li><strong>Add a <code>rel="canonical"</code> link to the <code>&lt;head&gt;</code> section of the non-canonical version of each HTML page.</strong>
		<p>To specify a canonical link to the page http://www.site.com/category/product.html?trackingid=1234567&amp;sort=alpha&amp;sessionid=5678asfasdfasfd, create a <code>&lt;link&gt;</code> element as follows:</p>
		<pre>&lt;link rel="canonical" href="http://www.site.com/product.html"&gt;</pre>
	</li>
</ul>
<h3><?php echo $text_common_seo_tool_canonical_9; ?></h3>
<p><?php echo $text_common_seo_tool_canonical_10; ?></p>
<h3>Must the content on a set of pages be similar to the content on the canonical version?</h3>
<p>Yes. The <code>rel="canonical"</code> attribute should be used only to specify the preferred version of many pages with identical content (although minor differences, such as sort order, are okay).</p>
<p>For instance, if a site has a set of pages for the same model of dance shoe, each varying only by the color of the shoe pictured, it may make sense to set the page highlighting the most popular color as the canonical version so that Google may be more likely to show that page in search results. However, <code>rel="canonical"</code> would not be appropriate if that same site simply wanted a gel insole page to rank higher than the shoe page.</p>
