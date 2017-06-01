<div class="accordion-group info-area">
	<div class="accordion-heading">
	  <a class="accordion-toggle collapsed" data-toggle="collapse" href="#example-tools_open_graph">
		<span class="lead">Click here to see help and example of Facebook Open Graph on your page</span>
	  </a>
	</div>
	<div id="example-tools_open_graph" class="accordion-body collapse" style="height: 0px;">
		<div class="accordion-inner">
			<button type="button" class="close">x</button>
			<div class="">
		<p>Use this feature to insert Facebook Open Graph in Products and Categories pages.</p>
		<p class="colorFC580B">
		For example, when you turn ON Facebook Open Graph, this module will be generate next text for product page and inserts it on header of page (product name: Apple Cinema 30)</p>
		<xmp>
<meta property="og:type" content="og:product" />
<meta property="og:title" content="Apple Cinema 30" />
<meta property="og:url" content="http://localhost/opencart_ssb/desktops/apple-cinema-30.html" />
<meta property="product:price:amount" content="$107.75"/>
<meta property="product:price:currency" content="USD"/>
<meta property="og:image" content="http://localhost/opencart_ssb/image/cache/data/demo/apple-cinema-30-42-228x228.jpg" />
<meta property="og:description" content="Apple Cinema 30 is a premium product from Apple(Apple - developer products such, as iPod Shuffle, iPhone, iPod Touch). Apple Cinema 30 you find in Desktops." />
		</xmp>
		</div>
		</div>
	</div>
</div>

<div class="pull-left clearfix" >
	<form class="form-horizontal">
		<div class="control-group">
			<label class="control-label">Open Graph META Tags</label>
			<div class="controls">
				<input type="hidden" name="data[tools][open_graph][status]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['open_graph']['status']) echo 'checked="checked"'; ?> name="data[tools][open_graph][status]" class="on_off">
			</div>
			<hr style="width: 500px;">
			<h4>Setting</h4>
			<div class="control-group">
				<label class="control-label">Insert description of product in microdata</label>
				<div class="controls">
					<input type="hidden" name="data[tools][open_graph][data][description]" value="">
					<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['open_graph']['data']['description']) echo 'checked="checked"'; ?> name="data[tools][open_graph][data][description]" class="on_off">
				</div>
			</div>
			<div class="control-group">
			<label class="control-label">Total number of sentences</label>
			<div class="input-prepend input-append">
				<input name="data[tools][open_graph][data][total_num_sentence]" class="span1" value="<?php echo $data['tools']['open_graph']['data']['total_num_sentence']; ?>" min="1" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 1 to 9">
				<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn ajax_action" type="button">Save</a>
				
			</div><span class="help-inline text-warning">for <xmp style="display: inline;"><meta property="og:description"...</xmp></span>
		</div>
		</div>
	</form>
</div>

<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/1BiZP_5HtHc?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3>What is a Facebook Open Graph META Tags?</h3>

<p>Facebook's Open Graph META Tags allows for you to turn own website into Facebook "graph" objects, allowing a certain level of customization over how information is carried over from a non-Facebook website to Facebook when a page is "recommended", "liked", or just generally shared.  The information is set via custom META tags on the source page.  Let's take a look at the different META tags Facebook uses to allow you to customize how your website is shared.</p>
<p>All of Facebook's Open Graph META tags are prefixed with <code>og:</code>, then continued with more specific the specific property to be set. &nbsp;The data relative to the property set goes within the <code>content</code> attribute:</p>
<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:{tagName}<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>{tagValue}<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>
<p>Using this simple META tag strategy, you can tell Facebook what images, text, and more to use when sharing your webpage. &nbsp;Let's review a few key META tags!</p>

<h3>image</h3>
<p>The image META tag directs Facebook to use the specified image when the page is shared:</p>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:image<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>http://site.com/image/data/product.png<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<p>It's best to use a square image, as Facebook displays them in that matter. That image should be at least 50x50 in any of the usually supported image forms (JPG, PNG, etc.)</p>
<h3>title</h3>
<p>The title to accompany the URL:</p>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:title<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>Product name<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<p>In most cases, this should be the article or page title.</p>
<h3>url</h3>
<p>The URL should be the canonical address for the given page:</p>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:url<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>http://site.com/canonical_product_link<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<p>Familiarize yourself with the Canonical Link type if you aren't aware of its purpose -- it could help your SEO out greatly!</p>
<h3>site_name</h3>
<p>Provides Facebook the name that you would like your website to be recognized by:</p>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:site_name<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>Site name<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<p>This is very useful as Facebook may have no way of knowing outside of this META tag.</p>




<h3>type</h3>
<p>Provides Facebook the type of website that you would like your website to be categorized by:</p>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:type<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>product<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<p>Read the <a href="http://developers.facebook.com/docs/opengraph/#types" rel="nofollow">complete list of website types</a> to best categorize your website.</p>

