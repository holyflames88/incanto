<div>
	<div  class="pull-right">
		<div class="control-group" style="float: right; margin-top: -35px; margin-bottom:0px;">
			<div class="controls" style="display: inline-block;">
				<input type="hidden" name="data[tools][ld_json][status]" value="">
				<input data-afteraction="afterSnipetToolsCahnge" data-action="save" data-scope=".closest('.tab-pane').find('input')" type="checkbox" value="true" <?php if($data['tools']['ld_json']['status']) echo 'checked="checked"'; ?> name="data[tools][ld_json][status]" class="on_off">
				<a data-afteraction="afterSnipetToolsCahnge" data-action="save" data-scope=".closest('.tab-pane').find('input')" class="btn ajax_action btn-success" type="button"><?php echo $text_common_save; ?></a>
			</div>
		</div>
	</div>
	
	<div class="form-horizontal tabbable">
		<ul class="nav nav-tabs">
			<li class="active"><a href="#ld_json-common" data-toggle="tab">Common</a></li>
			<li><a href="#ld_json-search_box" data-toggle="tab">Search BOX</a></li>
			<li><a href="#ld_json-geo" data-toggle="tab">Geo Location</a></li>
			<li><a href="#ld_json-contact_point" data-toggle="tab">Contacts</a></li>
			<li><a href="#ld_json-same_as" data-toggle="tab">Social Pages</a></li>
		</ul>
		 
		<div class="tab-content">
			<div class="tab-pane active" id="ld_json-common">
				<div class="span5">
					<ul class="nav nav-tabs">
						<?php $i_nav_seostore = 1; foreach ($stores as $store) { ?>
						<li <?php if($i_nav_seostore ==1) echo  "class=\"active\"";?> >
							<a href="#ld_json_store-<?php echo $store['store_id']; ?>" data-toggle="tab" style="padding: 2px;">
								<?php echo $store['name']; ?>
							</a>
						</li>
						<?php $i_nav_seostore++; } ?>
					</ul>
					 <div class="tab-content">
						<?php $i_tab_seostore = 1; foreach ($stores as $store) { ?>
						<div class="tab-pane <?php if($i_tab_seostore ==1) echo  "active";?>" id="ld_json_store-<?php echo $store['store_id']; ?>" >
							
							<div class="control-group mini">
								<label class="control-label"><?php echo $text_common_ld_json_name; ?></label>
								<div class="controls">
									<?php $ss_data = (isset($data['tools']['ld_json']['data']['stores'][$store['store_id']]['name']) && $data['tools']['ld_json']['data']['stores'][$store['store_id']]['name']) ? $data['tools']['ld_json']['data']['stores'][$store['store_id']]['name'] : $siteSetting['stores'][$store['store_id']]['name']; ?>
									<input type="text" name="data[tools][ld_json][data][stores][<?php echo $store['store_id']; ?>][name]" value="<?php echo $ss_data; ?>">
								</div>
							</div>
							<div class="control-group mini">
								<label class="control-label"><?php echo $text_common_ld_json_email; ?></label>
								<div class="controls">
									<?php $ss_data = (isset($data['tools']['ld_json']['data']['stores'][$store['store_id']]['email']) && $data['tools']['ld_json']['data']['stores'][$store['store_id']]['email']) ? $data['tools']['ld_json']['data']['stores'][$store['store_id']]['email'] : $siteSetting['stores'][$store['store_id']]['email']; ?>
									<input type="text" name="data[tools][ld_json][data][stores][<?php echo $store['store_id']; ?>][email]" value="<?php echo $ss_data; ?>">
								</div>
							</div>
							<div class="control-group mini">
								<label class="control-label"><?php echo $text_common_ld_json_telephone; ?></label>
								<div class="controls">
									<?php $ss_data = (isset($data['tools']['ld_json']['data']['stores'][$store['store_id']]['telephone']) && $data['tools']['ld_json']['data']['stores'][$store['store_id']]['telephone']) ? $data['tools']['ld_json']['data']['stores'][$store['store_id']]['telephone'] : $siteSetting['stores'][$store['store_id']]['telephone']; ?>
									<input type="text" name="data[tools][ld_json][data][stores][<?php echo $store['store_id']; ?>][telephone]" value="<?php echo $ss_data; ?>">
								</div>
							</div>
							<div class="control-group mini">
								<label class="control-label"><?php echo $text_common_ld_json_url; ?></label>
								<div class="controls">
									<?php $ss_data = (isset($data['tools']['ld_json']['data']['stores'][$store['store_id']]['url']) && $data['tools']['ld_json']['data']['stores'][$store['store_id']]['url']) ? $data['tools']['ld_json']['data']['stores'][$store['store_id']]['url'] : $siteSetting['stores'][$store['store_id']]['url']; ?>
									<input type="text" name="data[tools][ld_json][data][stores][<?php echo $store['store_id']; ?>][url]" value="<?php echo $ss_data; ?>">
								</div>
							</div>
							<div class="control-group mini">
								<label class="control-label"><?php echo $text_common_ld_json_logo; ?></label>
								<div class="controls">
									<?php $ss_data = (isset($data['tools']['ld_json']['data']['stores'][$store['store_id']]['logo']) && $data['tools']['ld_json']['data']['stores'][$store['store_id']]['logo']) ? $data['tools']['ld_json']['data']['stores'][$store['store_id']]['logo'] : $siteSetting['stores'][$store['store_id']]['logo']; ?>
									<input type="text" name="data[tools][ld_json][data][stores][<?php echo $store['store_id']; ?>][logo]" value="<?php echo $ss_data; ?>">
								</div>
							</div>
						</div>
						<?php $i_tab_seostore++; } ?>
					</div>
				</div>
				
				<div class="pull-right" style="margin-right:20px;">
					<h4>Address:</h4>
					<div class="control-group mini">
						<label class="control-label"><?php echo $text_common_ld_json_addressLocality; ?></label>
						<div class="controls">
							<?php $addressLocality = $data['tools']['ld_json']['data']['address']['addressLocality'] ? $data['tools']['ld_json']['data']['address']['addressLocality'] : $siteSetting['address']['addressLocality']; ?>
							<input type="text" name="data[tools][ld_json][data][address][addressLocality]" value="<?php echo $addressLocality; ?>">
						</div>
					</div>
					<div class="control-group mini">
						<label class="control-label"><?php echo $text_common_ld_json_addressRegion; ?></label>
						<div class="controls">
							<?php $addressRegion = $data['tools']['ld_json']['data']['address']['addressRegion'] ? $data['tools']['ld_json']['data']['address']['addressRegion'] : $siteSetting['address']['addressRegion']; ?>
							<input type="text" name="data[tools][ld_json][data][address][addressRegion]" value="<?php echo $addressRegion; ?>">
						</div>
					</div>
					<div class="control-group mini">
						<label class="control-label"><?php echo $text_common_ld_json_postalCode; ?></label>
						<div class="controls">
							<?php $postalCode = $data['tools']['ld_json']['data']['address']['postalCode'] ? $data['tools']['ld_json']['data']['address']['postalCode'] : $siteSetting['address']['postalCode']; ?>
							<input type="text" name="data[tools][ld_json][data][address][postalCode]" value="<?php echo $postalCode; ?>">
						</div>
					</div>
					<div class="control-group mini">
						<label class="control-label"><?php echo $text_common_ld_json_streetAddress; ?></label>
						<div class="controls">
							<?php $streetAddress = $data['tools']['ld_json']['data']['address']['streetAddress'] ? $data['tools']['ld_json']['data']['address']['streetAddress'] : $siteSetting['address']['streetAddress']; ?>
							<input type="text" name="data[tools][ld_json][data][address][streetAddress]" value="<?php echo $streetAddress; ?>">
						</div>
					</div>
				</div>

				<div class="clearfix"></div>
				
				<div class="info_text">
					<dl>
						<dt></dt>
						<dd class="info-area">
							When you activate this tools, than Paladin inserts the next code in your page:
							<pre>
<?php echo htmlspecialchars(
'<script type="application/ld+json">
{
  "@context": "http://schema.org",
  "@type": "Store",
  "address": {
		"@type": "PostalAddress",
		"addressLocality": "__City__",
		"addressRegion": "__Region__",
		"postalCode": "__Code__",
		"streetAddress": "__Street__"
	},
  "email": "__Mail__",
  "name": "__PIP__",
  "telephone": "__PhoneNumber__",
  "url" : "__Website URL (support all your stores)__",
  "logo" : "__Link to Logo image__"
}
</script>'); ?>
							</pre>
						</dd>
					</dl>
				</div>						
				
			</div>
			
			<div class="tab-pane" id="ld_json-search_box">
				<div class="control-group">
					<label class="control-label"><?php echo $text_common_ld_json_search_box; ?></label>
					<div class="controls">
						<input type="hidden" name="data[tools][ld_json][data][search_box][status]" value="">
						<input data-action="save" data-scope=".closest('.tab-pane').find('input')" type="checkbox" value="true" <?php if($data['tools']['ld_json']['data']['search_box']['status']) echo 'checked="checked"'; ?> name="data[tools][ld_json][data][search_box][status]" class="on_off noAlert">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><?php echo $text_common_ld_json_search_url; ?></label>
					<div class="controls">
						<?php $search_url = $data['tools']['ld_json']['data']['search_box']['search_url'] ? $data['tools']['ld_json']['data']['search_box']['search_url'] : $siteSetting['search_box']['search_url']; ?>
						<input type="text" name="data[tools][ld_json][data][search_box][search_url]" value="<?php echo $search_url; ?>" class="input-block-level">
					</div>
				</div>

				<div class="info_text">
					<dl>
						<dt></dt>
						<dd class="info-area">
							<p>
							With Google Sitelinks search box, people can reach your content more quickly from search results. Search users sometimes use navigational queries—typing in the brand name or URL of a known site—only to do a more detailed query once on that site. For example, suppose someone wants to find that video about the guilty dog on YouTube. They type YouTube, or you-tube, or youtube.com into Google Search, follow the link to YouTube, and then actually search for the dog video.
							</p>
							<img style="width:60%" src="view/stylesheet/superseobox/images/guiltyDogVideo.jpg">
							<p>Leave the field empty, if you don't want use it. In another case if the field is not empty, than Paladin inserts the next code in your page:</p>
							<pre>
<?php echo htmlspecialchars(
'<script type="application/ld+json">
    {
      "@context": "http://schema.org",
   "@type": "WebSite",
   "url": "__URL of Website__",
   "potentialAction": {
		 "@type": "SearchAction",
		 "target": "'. $search_url .'"
	   }
    }
</script>'); ?>
							</pre>
						</dd>
					</dl>
				</div>					
				
			</div>
			
			<div class="tab-pane" id="ld_json-geo">
				<div class="control-group">
					<label class="control-label"><?php echo $text_common_ld_json_latitude; ?></label>
					<div class="controls">
						<input type="text" name="data[tools][ld_json][data][geo][latitude]" value="<?php echo $data['tools']['ld_json']['data']['geo']['latitude']; ?>">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label"><?php echo $text_common_ld_json_longitude; ?></label>
					<div class="controls">
						<input type="text" name="data[tools][ld_json][data][geo][longitude]" value="<?php echo $data['tools']['ld_json']['data']['geo']['longitude']; ?>">
					</div>
				</div>
				
				<div class="info_text">
					<dl>
						<dt></dt>
						<dd class="info-area">
							Leave the field empty, if you don't want use it. In another case if the field is not empty, than Paladin inserts the next code in your page:
							<pre>
<?php echo htmlspecialchars(
'<script type="application/ld+json">
    {
      "@context": "http://schema.org",
      "@type": "Place",
      "geo": {
        "@type": "GeoCoordinates",
        "latitude": "__Your latitude__",
        "longitude": "__Your longitude__"
      },
      "name": "__Name of website__"
    }
</script>'); ?>
							</pre>
						</dd>
					</dl>
				</div>					
				
			</div>
			
			<div class="tab-pane" id="ld_json-contact_point">
				<h4>Support Phones:</h4>
				<div class="row">
					<div class="span5">
						<div class="control-group">
							<label class="control-label"><?php echo $text_common_ld_json_customer_support; ?></label>
							<div class="controls">
								<?php $ss_data = (isset($data['tools']['ld_json']['data']['contact_point']['customer_support']) && $data['tools']['ld_json']['data']['contact_point']['customer_support']) ? $data['tools']['ld_json']['data']['contact_point']['customer_support'] : $siteSetting['stores'][0]['telephone']; ?>
								<input type="text" name="data[tools][ld_json][data][contact_point][customer_support]" value="<?php echo $ss_data; ?>">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label"><?php echo $text_common_ld_json_technical_support; ?></label>
							<div class="controls">
								<?php $ss_data = (isset($data['tools']['ld_json']['data']['contact_point']['technical_support']) && $data['tools']['ld_json']['data']['contact_point']['technical_support']) ? $data['tools']['ld_json']['data']['contact_point']['technical_support'] : $siteSetting['stores'][0]['telephone']; ?>
								<input type="text" name="data[tools][ld_json][data][contact_point][technical_support]" value="<?php echo $ss_data; ?>">
							</div>
						</div>
					</div>	
					<div class="span5">
						<div class="control-group">
							<label class="control-label"><?php echo $text_common_ld_json_billing_support; ?></label>
							<div class="controls">
								<?php $ss_data = (isset($data['tools']['ld_json']['data']['contact_point']['billing_support']) && $data['tools']['ld_json']['data']['contact_point']['billing_support']) ? $data['tools']['ld_json']['data']['contact_point']['billing_support'] : $siteSetting['stores'][0]['telephone']; ?>
								<input type="text" name="data[tools][ld_json][data][contact_point][billing_support]" value="<?php echo $ss_data; ?>">
							</div>
						</div>
						<div class="control-group">
							<label class="control-label"><?php echo $text_common_ld_json_sales; ?></label>
							<div class="controls">
								<?php $ss_data = (isset($data['tools']['ld_json']['data']['contact_point']['sales']) && $data['tools']['ld_json']['data']['contact_point']['sales']) ? $data['tools']['ld_json']['data']['contact_point']['sales'] : $siteSetting['stores'][0]['telephone']; ?>
								<input type="text" name="data[tools][ld_json][data][contact_point][sales]" value="<?php echo $ss_data; ?>">
							</div>
						</div>
					</div>
				</div>
				
				<div class="clearfix"></div>
					
				<div class="info_text">
					<dl>
						<dt></dt>
						<dd class="info-area">
							Leave the field empty, if you don't want use it. In another case if the field is not empty, than Paladin inserts the next code in your page:
							<pre>
<?php echo htmlspecialchars(
'<script type="application/ld+json">
{
  "contactPoint" : [
    { "@type" : "ContactPoint",
      "telephone" : "__PhoneNumber__",
      "contactType" : "customer service",
      "availableLanguage" : ["Default_Language","Additional_Language", ...],
      "areaServed" : ["US","CA", ...]
    },
	{ "@type" : "ContactPoint",
      "telephone" : "__PhoneNumber__",
      "contactType" : "technical support",
      "availableLanguage" : ["Default_Language","Additional_Language", ...],
      "areaServed" : ["US","CA", ...]
    },
	...
	] 
}
</script>'); ?>
							</pre>
						</dd>
					</dl>
				</div>
			</div>
			
			<div class="tab-pane" id="ld_json-same_as">
			<?php foreach($data['tools']['ld_json']['data']['same_as'] as $key => $val){ ?>
				<div class="control-group">
					<label class="control-label"><?php echo ${'text_common_ld_json_' . $key}; ?></label>
					<div class="controls">
						<input class="input-block-level" type="text" name="data[tools][ld_json][data][same_as][<?php echo $key; ?>]" value="<?php echo $val; ?>">
					</div>
				</div>
			<?php } ?>
			
				<div class="info_text">
					<dl>
						<dt></dt>
						<dd class="info-area">
							Leave the field empty, if you don't want use it. In another case if the field is not empty, than Paladin inserts the next code in your page:
							<pre>
<?php echo htmlspecialchars(
'<script type="application/ld+json">
{ "sameAs" : [ "https://plus.google.com/__yourPage__",
               "https://twitter.com/__yourPage__",
               "https://www.facebook.com/__yourPage__",
               "https://www.linkedin.com/company/__yourPage__",
               "https://www.youtube.com/user/__yourPage__",
               "https://plus.google.com/communities/__yourPage__" ] 
}
</script>'); ?>
							</pre>
						</dd>
					</dl>
				</div>			
			
			</div>
		</div>
	</div>
</div>

<div class="clearfix"></div>
<h3>About <?php echo $text_common_ld_json; ?></h3>
<iframe class="pull-right" width="350" height="197" src="//www.youtube.com/embed/4x_xzT5eF5Q?rel=0" frameborder="0" allowfullscreen></iframe>
<p><?php echo $text_common_ld_json; ?> - empowers people that publish and use information on the Web. It is a way to create a network of standards-based, machine-readable data across Web sites. It allows an application to start at one piece of Linked Data, and follow embedded links to other pieces of Linked Data that are hosted on different sites across the Web.</p>
<p>Although schema.org has recommended the use of JSON-LD since 2013, Google finally jumped onboard with their endorsement in January. Google’s support comes from the role JSON-LD plays in the search world by delivering more easily indexable content. JSON-LD (JavaScript Object Notation for Linked Data) offers a simpler means to create machine-readable data from websites to promote search results.</p>

<h4>WHY IS JSON-LD IMPORTANT?</h4>
<p>JSON-LD harnesses more power for people who publish and access information on the internet. It’s simpler for people to read and write by creating a network of standards for machine-readable data from websites to promote the indexing process.</p>

<p>Think of it as a spider web of sorts. An application begins at one piece of Linked Data and then is followed to other pieces of Linked Data from embedded links that are hosted on different websites to promote search results.</p>

<p>With the foundation of the existing JSON format, developers are able to easily transform their current JSON to JSON-LD to better describe the content of their website to search engines. Search engines are then able to more effectively understand your webpages to feature your content more relevantly through simplified web development.</p>

<h4>HOW DOES JSON-LD WORK?</h4>
<p>The data from your webpage is used in a structured means with schema.org vocabulary that has been imbedded into your webpages with a JSON-LD snippet. When combined with custom Web Components to define a distinctive aspect of the user interface and a Custom Element to define the behavior of your Web Component, you’re able to share and reuse across other webpages to simplify website development.</p>
<p>However, Google offers a word of warning, saying, “In general, Google won’t display any content in rich snippets that is not visible to human users. Google will ignore content that isn’t visible to human users, so you should mark up the text that visitors will see on your webpages.”</p>
<p>Since Web Components and JSON-LD compliment one another, the Custom Element functions work as the presentation layer while the JSON-LD functions work as the data layer. So, human visitors will easily view your information while Googlebots are better able to retrieve information for indexing.</p>

<h4>WHAT CHANGES WILL I SEE?</h4>
<p>Google supports JSON-LD syntax for company logos, contacts, social profile links, events in Knowledge Graph, event rich snippets, and site link search boxes. The compatibility of Knowledge Graph is one of the most anticipated results of Google’s endorsement.</p>
<p>With the new structured markup, you’re able to alert Google to the types of content on your site, then direct Google where to take the internet user when they perform a search. This is very beneficial for featuring events in the knowledge graph because you can promote ticket sales and location-based events easier and more effectively.</p>
<p>In addition, businesses can use the structured data to markup and modify how social networks are displayed in the knowledge box. Google will now recognize other social profiles other than Google+ when you publish a markup on a page within your website that’s unblocked by Googlebots. However, be sue to include a person or organization in the markup by specifying your website’s URL or the URLs of your social media profiles. Then, insert the script anywhere on your page for Google to start indexing and displaying your profiles in the search results.</p>