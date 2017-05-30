<div class="accordion-group info-area">
	<div class="accordion-heading">
	  <a class="accordion-toggle collapsed" data-toggle="collapse" href="#example-tools_micro_data">
		<span class="lead">Click here to see help and example of Google microdata on your page</span>
	  </a>
	</div>
	<div id="example-tools_micro_data" class="accordion-body collapse" style="height: 0px;">
		<div class="accordion-inner">
			<button type="button" class="close">x</button>
			<div class="">
		<p>Use this feature to insert Google microdata in Products and Categories pages.</p>
		<p class="colorFC580B">
		For example, when you turn ON Microdata, this module will be generate next text for product page (product name: HP LP3065)</p>
		<xmp>
<div itemscope="itemscope" itemtype="http://schema.org/Product">
	<div itemscope="itemscope" itemtype="http://schema.org/WebPage">
		<div itemprop="breadcrumb">
			<a rel="home" href="http://localhost/opencart_ssb/index.php?route=common/home" alt="Home"></a>
			<a href="http://localhost/opencart_ssb/desktops" alt="Desktops"></a>
			<a href="http://localhost/opencart_ssb/desktops/hp-lp3065.html" alt="HP LP3065"></a>
		</div>
	</div>

	<meta itemprop="name" content="HP LP3065">

	<meta itemprop="url" content="http://localhost/opencart_ssb/desktops/hp-lp3065.html">

	<meta itemprop="description" content="HP LP3065 is a premium product from Hewlett-Packard(Hewlett-Packard - developer products such, as  HP LP3065). HP LP3065 you find in  Laptops &amp; Notebooks.">

	<meta itemprop="image" content="http://localhost/opencart_ssb/image/cache/data/demo/hp-lp3065-47-228x228.jpg">

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
</div>
		</xmp>
		</div>
		</div>
	</div>
</div>

<div class="pull-left clearfix" >
	<form class="form-horizontal">
		<div class="control-group">
			<label style="font-weight:bold;" class="control-label">Microdata</label>
			<div class="controls">
				<input type="hidden" name="data[tools][micro_data][status]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['micro_data']['status']) echo 'checked="checked"'; ?> name="data[tools][micro_data][status]" class="on_off">
			</div>
		</div>
		<hr style="width: 500px;">
		<h4>Setting</h4>
		<div class="control-group">
			<label class="control-label">Insert description of product in microdata</label>
			<div class="controls">
				<input type="hidden" name="data[tools][micro_data][data][description]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['micro_data']['data']['description']) echo 'checked="checked"'; ?> name="data[tools][micro_data][data][description]" class="on_off">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">Insert Custom reviews of product in microdata</label>
			<div class="controls">
				<input type="hidden" name="data[tools][micro_data][data][custom_reviews]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['micro_data']['data']['custom_reviews']) echo 'checked="checked"'; ?> name="data[tools][micro_data][data][custom_reviews]" class="on_off">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">Insert average rating of product in microdata</label>
			<div class="controls">
				<input type="hidden" name="data[tools][micro_data][data][aggregateRating]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['micro_data']['data']['aggregateRating']) echo 'checked="checked"'; ?> name="data[tools][micro_data][data][aggregateRating]" class="on_off">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">Total number of sentences</label>
			<div class="input-prepend input-append">
				<input name="data[tools][micro_data][data][total_num_sentence]" class="span1" value="<?php echo $data['tools']['micro_data']['data']['total_num_sentence']; ?>" min="1" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 1 to 9">
				<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn ajax_action" type="button">Save</a>
				
			</div><span class="help-inline text-warning">for <xmp style="display: inline;"><meta itemprop="description"...</xmp></span>
		</div>
	</form>
</div>

<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/_-rRxKSm2ic?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3>About Microdata</h3>

<p>Microdata - the few lines of text that appear under every search result are designed to give users a sense for what's on the page and why it's relevant to their query.</p>
<p>If Google understands the content on your pages, it can create Microdata detailed information intended to help users with specific queries. These Microdata help users recognize when your site is relevant to their search, and may result in more clicks to your pages.</p>


<p>Microdata uses simple attributes in HTML tags (often <code>&lt;span&gt;</code> or <code>&lt;div&gt;</code>) to assign brief and descriptive names to items and properties. Here's an example of a short HTML block showing basic contact information for Bob Smith.</p>

<p>Use Microdata to display name, price, image, review of products right on Google search results pages.</p>

<p>Microdata help you to:</p>
<ul>
	<li>Attract potential buyers while they are searching for items to buy on Google.</li>
	<li>Submit your product listings for free.</li>
	<li>Control your product information. You can maintain the accuracy and freshness of your product information, so your customers find the relevant, current items they're looking for.</li>
</ul>

<p>The goal of a product Microdata is to provide users with additional information about a specific product, such as the product's price, availability (whether product is in stock), and reviewer(s) ratings and commentary.</p>
  