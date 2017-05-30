<div class="accordion-group info-area">
	<div class="accordion-heading">
	  <a class="accordion-toggle collapsed" data-toggle="collapse" href="#example-twiter_card">
		<span class="lead"><?php echo $text_common_click_here_info . ' ' . $text_common_google_publisher; ?> </span>
	  </a>
	</div>
	<div id="example-twiter_card" class="accordion-body collapse" style="height: 0px;">
		<div class="accordion-inner">
			<button type="button" class="close">x</button>
			<div class="">
		<p><?php echo $text_common_use_this_feature_start . ' ' . $text_common_google_publisher . ' ' . 'markup to the home page, where XXXXXXXXXXXXXXXXXXXXX - your Google+ business page'; ?></p>
	<pre>
<?php echo htmlspecialchars('<link href="https://plus.google.com/XXXXXXXXXXXXXXXXXXXXX/" rel="publisher"/>'); ?>		
	</pre>
		</div>
		</div>
	</div>
</div>

<div class="pull-left clearfix" >
	<form class="form-horizontal">
		<div class="control-group">
			<label class="control-label"><?php echo $text_common_google_publisher; ?></label>
			<div class="controls">
				<input type="hidden" name="data[tools][google_publisher][status]" value="">
				<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".parents('.form-horizontal').find('input')" type="checkbox" value="true" <?php if($data['tools']['google_publisher']['status']) echo 'checked="checked"'; ?> name="data[tools][google_publisher][status]" class="on_off noAlert">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">Link to your G+ page</label>
			<div class="controls">
				<div class="input-prepend input-append">
				<input type="text" name="data[tools][google_publisher][data][href]" value="<?php echo $data['tools']['google_publisher']['data']['href']; ?>">
				<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn btn-success ajax_action" type="button"><?php echo $text_common_save; ?></a>
				</div>
			</div>
		</div>
	</form>
</div>

<div class="clearfix"></div>
<h3>What is a Google Publisher?</h3>

<p>As you may have guessed from the title of this function, there is a rich snippets schema which can be used to further promote and highlight your company within the SERPs, and it's called "Rel=Publisher".</p>

<p>Internet has everything, you enter one word in a search engine and you encounter millions of relevant pages. But an average user has limited time and attention, so your website search better be different and attractive. That's exactly what rel=publisher tag will do for your brand.</p>

<p>As with all Google authorship mark ups, you will not see instant changes in the SERPs as it takes a little while for Google to pick up the code. No one really knows how long it takes, sometimes it's days, sometimes it's months!</p>  

<p>For turning ON - you need to point your Google+ business page at your site to verify the rel="publisher" mark up. This can be done easily by going to the Google+ page > Edit > About > Add Your Website.</p>

<img src="view/stylesheet/superseobox/images/pointing-you-Google+-page-at-your-website1.jpg"/>
<p>Rel=publisher tag is one of the knowledge graph for business websites and top brands. The tag resides in the <head> element of your website. It was provided by Google, to link your website on search to its social media brand page. </br> For a brand search the rel=publisher tag pulls out a knowledge graph on the right in the form of the brand's Google+ page summary, as shown in the example below:</p>
<img src="view/stylesheet/superseobox/images/Knowledge-Graph-For-Sample-Brand-Search-Because-Of-Rel-Publisher-Tag.jpg"/>