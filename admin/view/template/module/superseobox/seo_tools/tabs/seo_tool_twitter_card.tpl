<div class="accordion-group info-area">
	<div class="accordion-heading">
	  <a class="accordion-toggle collapsed" data-toggle="collapse" href="#example-tools_twiter_card">
		<span class="lead">Click here to see help and example of Twitter card on your page</span>
	  </a>
	</div>
	<div id="example-tools_twiter_card" class="accordion-body collapse" style="height: 0px;">
		<div class="accordion-inner">
			<button type="button" class="close">x</button>
			<div class="">
		<p>Use this feature to insert Twitter card in Products and Categories pages.</p>
		<p class="colorFC580B">
		For example, when you turn ON Twitter card, this module will be generate next text for product page and inserts it on header of page (product name: Apple Cinema 30)</p>
		<xmp>
<meta name="twitter:card" content="product">
<meta name="twitter:site" content="http://localhost/opencart_ssb/desktops/apple-cinema-30.html">
<meta name="twitter:title" content="Apple Cinema 30">
<meta name="twitter:image" content="http://localhost/opencart_ssb/image/cache/data/demo/apple-cinema-30-42-228x228.jpg">
<meta name="twitter:data1" content="$107.75">
<meta name="twitter:label1" content="Price">
<meta name="twitter:data2" content="USD">
<meta name="twitter:label2" content="Currency">
<meta name="twitter:description" content="Apple Cinema 30 is a premium product from Apple(Apple - developer products such, as iPod Shuffle, iPhone, iPod Touch). Apple Cinema 30 you find in Desktops.">
<meta name="twitter:creator" content="@youNickName">
		</xmp>
		</div>
		</div>
	</div>
</div>

<div class="pull-left clearfix" >
	<form class="form-horizontal">
		<div class="control-group">
			<label class="control-label">Twitter card</label>
			<div class="controls">
				<input type="hidden" name="data[tools][twiter_card][status]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['twiter_card']['status']) echo 'checked="checked"'; ?> name="data[tools][twiter_card][status]" class="on_off">
			</div>
		</div>
		<hr style="width: 500px;">
		<h4>Setting</h4>
		<div class="control-group">
			<label class="control-label">Insert description of product in microdata</label>
			<div class="controls">
				<input type="hidden" name="data[tools][twiter_card][data][description]" value="">
				<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['twiter_card']['data']['description']) echo 'checked="checked"'; ?> name="data[tools][twiter_card][data][description]" class="on_off">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">Enter your twitter nick (not necessarily)</label>
			<div class="controls">
				<div class="input-prepend input-append">
				<input type="text" name="data[tools][twiter_card][data][nick]" value="<?php echo $data['tools']['twiter_card']['data']['nick']; ?>">
				<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn btn-success ajax_action" type="button">Save</a>
				</div>
			</div>
		</div>
	</form>
</div>

<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/EVr6TpGxZgo?rel=0" frameborder="0" allowfullscreen></iframe>

<div class="clearfix"></div>
<h3>What is a Twitter card?</h3>

<p>Twitter cards make it possible for you to attach media experiences to Tweets that link to your content. Simply add a few lines of HTML to your site, and users who Tweet links to your content will have a "card" added to the Tweet that's visible to all of their followers.</p>

<p>
The Product Card is a great way to represent retail items on Twitter, and to drive sales. This Card type is designed to showcase your products via an image, a description, and allow you to highlight two other key details about your product.
</p>

<p>
These fields are strings and can be used to show the price, list availability, list sizes, etc. This will require adding some new markup tags to your pages, which we will cover below. 
</p>

<p>
<strong>Note:</strong> The product card requires an image of size 160 x 160 or greater. It prefers a square image but we can crop/resize oddly shaped images to fit as long as both dimensions are greater than or equal to 160 pixels.
</p>
<p>

  </p><table>
    <thead>
      <tr>
        <th>Web</th>
        <th>Mobile</th>
      </tr>
    </thead>
    <tbody>
      <tr>
<td><img src="https://dev.twitter.com/sites/default/files/images_documentation/web_product.jpg" width="422" height="429" alt="" title=""></td>
<td><img src="https://dev.twitter.com/sites/default/files/images_documentation/ios_product.png" width="260" height="499" alt="" title=""></td>
</tr>
    </tbody>
  </table>
  