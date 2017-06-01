<div class="accordion-group info-area">
	<div class="accordion-heading">
	  <a class="accordion-toggle collapsed" data-toggle="collapse" href="#example-open_graph">
		<span class="lead"><?php echo $text_common_click_here_info . ' ' . $text_common_open_graph; ?> </span>
	  </a>
	</div>
	<div id="example-open_graph" class="accordion-body collapse" style="height: 0px;">
		<div class="accordion-inner">
			<button type="button" class="close">x</button>
			<div class="">
		<p><?php echo $text_common_use_this_feature_start . ' ' . $text_common_open_graph . ' ' . $text_common_use_this_feature_end; ?></p>
		<p class="colorFC580B"><?php echo $text_common_example_start . ' ' . $text_common_open_graph . ' ' . $text_common_example_end; ?> (product name: Apple Cinema 30)</p>
		<pre>
<?php echo htmlspecialchars(
'<meta property="og:type" content="og:product" />
<meta property="og:title" content="Apple Cinema 30" />
<meta property="og:url" content="http://site.com/desktops/apple-cinema-30.html" />
<meta property="product:price:amount" content="$107.75"/>
<meta property="product:price:currency" content="USD"/>
<meta property="og:image" content="http://site.com/image/cache/data/demo/apple-cinema-30-42-228x228.jpg" />
<meta property="og:description" content="Apple Cinema 30 is a premium product from Apple(Apple - developer products such, as iPod Shuffle, iPhone, iPod Touch). Apple Cinema 30 you find in Desktops." />'); 
?>
		</pre>	
		</div>
		</div>
	</div>
</div>

<div class="pull-left clearfix" >
	<form class="form-horizontal">
		<div class="control-group">
			<label class="control-label"><?php echo $text_common_open_graph; ?></label>
			<div class="controls">
				<input type="hidden" name="data[tools][open_graph][status]" value="">
				<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['open_graph']['status']) echo 'checked="checked"'; ?> name="data[tools][open_graph][status]" class="on_off noAlert">
			</div>
			<hr style="width: 500px;">
			<h4><?php echo $text_common_setting; ?></h4>
			<div class="control-group">
				<label class="control-label"><?php echo $text_common_insert_product_description; ?></label>
				<div class="controls">
					<input type="hidden" name="data[tools][open_graph][data][description]" value="">
					<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['open_graph']['data']['description']) echo 'checked="checked"'; ?> name="data[tools][open_graph][data][description]" class="on_off">
				</div>
			</div>
			<div class="control-group">
			<label class="control-label"><?php echo $text_common_number_sentence; ?></label>
			<div class="input-prepend input-append">
				<input name="data[tools][open_graph][data][total_num_sentence]" class="span1" value="<?php echo $data['tools']['open_graph']['data']['total_num_sentence']; ?>" min="1" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 1 to 9">
				<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn ajax_action" type="button"><?php echo $text_common_save; ?></a>
				
			</div><span class="help-inline text-warning"><?php echo $text_common_for; ?> <xmp style="display: inline;"><meta property="og:description"...</xmp></span>
		</div>
		</div>
	</form>
</div>

<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/1BiZP_5HtHc?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3><?php echo $text_common_open_graph_1; ?></h3>

<?php echo $text_common_open_graph_2; ?>
<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:{tagName}<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>{tagValue}<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>
<?php echo $text_common_open_graph_3; ?>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:image<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>http://site.com/image/data/product.png<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<?php echo $text_common_open_graph_4; ?>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:title<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>Product name<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<?php echo $text_common_open_graph_5; ?>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:url<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>http://site.com/canonical_product_link<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<?php echo $text_common_open_graph_6; ?>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:site_name<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>Site name<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<?php echo $text_common_open_graph_7; ?>

<pre class="html  language-html" prism="true"><code class="  language-html"><span class="token tag"><span class="token tag"><span class="token punctuation">&lt;</span>meta</span> <span class="token attr-name">property</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>og:type<span class="token punctuation">"</span></span> <span class="token attr-name">content</span><span class="token attr-value"><span class="token punctuation">=</span><span class="token punctuation">"</span>product<span class="token punctuation">"</span></span><span class="token punctuation">/&gt;</span></span></code></pre>

<?php echo $text_common_open_graph_8; ?>

