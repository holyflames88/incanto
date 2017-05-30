

<div class="box-block work-seo-box">
	<h2><?php echo $text_common_rich_snippets; ?></h2>
	<div class="tabbable tabs-left">
		<ul id="rich_snippets_menu" class="seo-item-menu nav nav-tabs" data-position="right" data-intro="Now, we are in tab 'Rich Snipets' and this is it's menu. Here we can easily insert Google, Facebook and Twitter code on your page for improve display on SERP(Search Engine Results Page) on Google and correct displaying  yours pages on the Facebook and Twitte." data-intro-action="$('a[href=#seo_tools]').click();" data-step="9">
			<span><?php echo $text_common_snippets; ?></span>
			<li class="active">
				<a href="#rich_snippets_micro_data" data-toggle="tab">
					<i class="icon-play"></i> 
					<?php echo $text_common_google_microdata; ?>
				</a>
			</li>
			<li>
				<a href="#rich_snippets_google_publisher" data-toggle="tab">
					<i class="icon-play"></i> 
					<?php echo $text_common_google_publisher; ?>
				</a>
			</li>
			<li>
				<a href="#rich_snippets_open_graph" data-toggle="tab">
					<i class="icon-fast-backward"></i> 
					<?php echo $text_common_open_graph; ?>
				</a>
			</li>
			<li>
				<a href="#rich_snippets_twitter_card" data-toggle="tab">
					<i class="icon-backward"></i> 
					<?php echo $text_common_twitter_card; ?>
				</a>
			</li>
			<li>
				<a href="#rich_snippets_ld_json" data-toggle="tab">
					<i class="icon-adjust"></i> 
					<?php echo $text_common_ld_json; ?>
				</a>
			</li>
		</ul>
		
		<!-- using cache !-->	
		<div class="control-group" style="float: right; margin-top: -35px; margin-bottom:0px;">
			<label class="control-label" style="display: inline-block;"><?php echo $text_common_using_cache_snippets; ?> </label>
			<div class="controls" style="display: inline-block;">
				<input type="hidden" name="data[ssb_cache][snippet]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['ssb_cache']['snippet']) echo 'checked="checked"'; ?> name="data[ssb_cache][snippet]" class="on_off">
			</div>
		</div>
		<!-- using cache !-->
		<hr style="margin: 0;">
		<div class="tab-content">
			<div class="tab-pane active" id="rich_snippets_micro_data">
				<h3><?php echo $text_common_header_GOOGLE_MICRODATA; ?></h3>
				<?php require_once 'tabs/micro_data.tpl';?>
			</div>
			<div class="tab-pane" id="rich_snippets_google_publisher">
				<h3><?php echo $text_common_header_GOOGLE_PUBLISHER; ?></h3>
				<?php require_once 'tabs/google_publisher.tpl';?>
			</div>
			<div class="tab-pane" id="rich_snippets_open_graph">
				<h3><?php echo $text_common_header_OPEN_GRAPH; ?></h3>
				<?php require_once 'tabs/open_graph.tpl';?>
			</div>
			<div class="tab-pane" id="rich_snippets_twitter_card">
				<h3><?php echo $text_common_header_TWITTER_CARD; ?></h3>
				<?php require_once 'tabs/twitter_card.tpl';?>
			</div>
			<div class="tab-pane" id="rich_snippets_ld_json">
				<h3><?php echo $text_common_header_LD_JSON; ?></h3>
				<?php require_once 'tabs/ld_json.tpl';?>
			</div>
		</div>
	</div>
</div>