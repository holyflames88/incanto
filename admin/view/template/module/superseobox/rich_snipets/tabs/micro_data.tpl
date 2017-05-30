<div class="accordion-group info-area">
	<div class="accordion-heading">
	  <a class="accordion-toggle collapsed" data-toggle="collapse" href="#example-micro_data">
		<span class="lead"><?php echo $text_common_click_here_info . ' ' . $text_common_google_microdata; ?> </span>
	  </a>
	</div>
	<div id="example-micro_data" class="accordion-body collapse" style="height: 0px;">
		<div class="accordion-inner">
			<button type="button" class="close">x</button>
			<div class="">
		<p><?php echo $text_common_use_this_feature_start . ' ' . $text_common_google_microdata . ' ' . $text_common_use_this_feature_end; ?></p>
		<p class="colorFC580B"><?php echo $text_common_example_start . ' ' . $text_common_google_microdata . ' ' . $text_common_example_end; ?> (product name: HP LP3065)</p>
		
		<pre>
<?php echo htmlspecialchars(
'<div itemscope="itemscope" itemtype="http://schema.org/Product">
<div itemscope="itemscope" itemtype="http://schema.org/WebPage">
	<div itemprop="breadcrumb">
		<a rel="home" href="http://site.com" alt="Home"></a>
		<a href="http://site.com/desktops" alt="Desktops"></a>
		<a href="http://site.com/desktops/hp-lp3065.html" alt="HP LP3065"></a>
	</div>
</div>

<meta itemprop="name" content="HP LP3065">

<meta itemprop="url" content="http://site.com/desktops/hp-lp3065.html">

<meta itemprop="description" content="HP LP3065 is a premium product from Hewlett-Packard(Hewlett-Packard - developer products such, as  HP LP3065). HP LP3065 you find in  Laptops &amp; Notebooks.">

<meta itemprop="image" content="http://site.com/image/cache/data/demo/hp-lp3065-47-228x228.jpg">

<meta itemprop="model" content="Product 21">

<meta itemprop="manufacturer" content="Hewlett-Packard">

<div itemprop="review" itemscope="itemscope" itemtype="http://schema.org/Review">
	<meta itemprop="name" content="HP LP3065">
	<meta itemprop="author" content="Romario">
	<meta itemprop="datePublished" content="2013-11-15">
	<div itemprop="reviewRating" itemscope="itemscope" itemtype="http://schema.org/Rating">
		<meta itemprop="worstRating" content="1">
		<meta itemprop="ratingValue" content="5">
		<meta itemprop="bestRating" content="5">
	</div>
	<meta itemprop="description" content="EXCELLENT PRODUCT! Thank you!">
</div>

<div itemprop="review" itemscope="itemscope" itemtype="http://schema.org/Review">
	<meta itemprop="name" content="HP LP3065">
	<meta itemprop="author" content="Roman">
	<meta itemprop="datePublished" content="2013-11-15">
	<div itemprop="reviewRating" itemscope="itemscope" itemtype="http://schema.org/Rating">
		<meta itemprop="worstRating" content="1">
		<meta itemprop="ratingValue" content="5">
		<meta itemprop="bestRating" content="5">
	</div>
	<meta itemprop="description" content="All ok...very good quality friends....thanks">
</div>

<div itemprop="aggregateRating" itemscope="itemscope" itemtype="http://schema.org/AggregateRating">
	<meta itemprop="ratingValue" content="5">
	<meta itemprop="reviewCount" content="2">
</div>

<div itemscope="itemscope" itemtype="http://schema.org/Offer">
	<meta itemprop="name" content="HP LP3065">
	<meta itemprop="price" content="$119.50">
	<meta itemprop="priceCurrency" content="USD">
	<link itemprop="availability" href="http://schema.org/InStock">
</div>
</div>'); 
  
?>
		</pre>
		</div>
		</div>
	</div>
</div>

<div class="pull-left clearfix" >
	<form class="form-horizontal">
		<div class="control-group">
			<label style="font-weight:bold;" class="control-label"><?php echo $text_common_google_microdata; ?></label>
			<div class="controls">
				<input type="hidden" name="data[tools][micro_data][status]" value="">
				<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['micro_data']['status']) echo 'checked="checked"'; ?> name="data[tools][micro_data][status]" class="on_off noAlert">
			</div>
		</div>
		<hr style="width: 500px;">
		<h4>Setting</h4>
		<div class="control-group">
			<label class="control-label"><?php echo $text_common_insert_product_description; ?></label>
			<div class="controls">
				<input type="hidden" name="data[tools][micro_data][data][description]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['micro_data']['data']['description']) echo 'checked="checked"'; ?> name="data[tools][micro_data][data][description]" class="on_off">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><?php echo $text_common_insert_product_reviews; ?></label>
			<div class="controls">
				<input type="hidden" name="data[tools][micro_data][data][custom_reviews]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['micro_data']['data']['custom_reviews']) echo 'checked="checked"'; ?> name="data[tools][micro_data][data][custom_reviews]" class="on_off">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><?php echo $text_common_insert_product_arp; ?></label>
			<div class="controls">
				<input type="hidden" name="data[tools][micro_data][data][aggregateRating]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['micro_data']['data']['aggregateRating']) echo 'checked="checked"'; ?> name="data[tools][micro_data][data][aggregateRating]" class="on_off">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><?php echo $text_common_number_sentence; ?></label>
			<div class="input-prepend input-append">
				<input name="data[tools][micro_data][data][total_num_sentence]" class="span1" value="<?php echo $data['tools']['micro_data']['data']['total_num_sentence']; ?>" min="1" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 1 to 9">
				<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn ajax_action" type="button">Save</a>
				
			</div><span class="help-inline text-warning"><?php echo $text_common_for; ?> <xmp style="display: inline;"><meta itemprop="description"...</xmp></span>
		</div>
	</form>
</div>

<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/_-rRxKSm2ic?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3>About <?php echo $text_common_google_microdata; ?></h3>

<p><?php echo $text_common_google_microdata; ?> - the few lines of text that appear under every search result are designed to give users a sense for what's on the page and why it's relevant to their query.</p>
<p>If Google understands the content on your pages, it can create <?php echo $text_common_google_microdata; ?> detailed information intended to help users with specific queries. These Microdata help users recognize when your site is relevant to their search, and may result in more clicks to your pages.</p>


<p><?php echo $text_common_google_microdata; ?> uses simple attributes in HTML tags (often <code>&lt;span&gt;</code> or <code>&lt;div&gt;</code>) to assign brief and descriptive names to items and properties. Here's an example of a short HTML block showing basic contact information for Bob Smith.</p>

<p>Use <?php echo $text_common_google_microdata; ?> to display name, price, image, review of products right on Google search results pages.</p>

<p><?php echo $text_common_google_microdata; ?> help you to:</p>
<ul>
	<li>Attract potential buyers while they are searching for items to buy on Google.</li>
	<li>Submit your product listings for free.</li>
	<li>Control your product information. You can maintain the accuracy and freshness of your product information, so your customers find the relevant, current items they're looking for.</li>
</ul>

<p>The goal of a product Microdata is to provide users with additional information about a specific product, such as the product's price, availability (whether product is in stock), and reviewer(s) ratings and commentary.</p>
  