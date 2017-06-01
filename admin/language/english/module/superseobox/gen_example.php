<?php

// 0. DESCRIPTION ======================
$_['gen_tab_content_name_descrip']	= 'GENERATOR OF THE DESCRIPTIONS';
$_['gen_tab_content_exapmle_descrip'] =
	'<div class="">
	<p>
		<span>For example, to generate Description for products from category "Phones" we will choose this category in "Generate description for" and  write the next template:</span>
		<pre>"!pn is a revolutionary new mobile phone from !bn (!bd(1)), that allows you to bee cool every day." </pre>- which will generate the following Description (for example we enter into product page "iPhone 4s"):
		<pre>"iPhone 4s is a revolutionary new mobile phone from Apple (Apple designs and creates iPod and iTunes, Mac laptop and desktop computers, the OS X operating system, and the revolutionary iPhone and iPad.), that allows you to be cool every day."</pre>
	</p>
	<span>The used parameters:</span>
	<dl class="dl-horizontal">
		
		<dt><span class="label label-info">!pn</span></dt>
		<dd><span class="span3">Product\'s name</span>
		<span class="span3">"iPhone 4s"</span></dd>
		
		<dt><span class="label label-info">!bn</span></dt>
		<dd><span class="span3">Brand\'s name</span>
		<span class="span3">"Apple"</span></dd>
		
		<dt><span class="label label-info">!bd(1)</span></dt>
		<dd><span class="span3">Brand\'s description (1 - total number of first sentences)</span> 
		<span class="span3">"Apple designs and creates iPod and iTunes, Mac laptop and desktop computers, the OS X operating system, and the revolutionary iPhone and iPad."</span></dd>
	</dl>
	<p class="colorFC580B">
		1. <img class="pull-right" src="view/stylesheet/superseobox/images/helper/descrip_prod_select.jpg">You can write individual SEO templates for products in every category, just choose category in "Generate description for". Then you can write template only for products in choosen category. After this you can click on "Generate description for Products" and this template will be saved and then will be re-generated SEO description for every products.
		</br><span class="clearfix"></span>
		2. Buttons "Clear All" and "Clear" are used for deleting only descriptions, which was created by SEO generator.</br></br>
		3. If you have a few languages you must write template for every language."
	</p>
	</div>';


// 1. TAGS ======================
$_['gen_tab_content_name_tags']		= 'GENERATOR OF THE TAGS';
$_['gen_tab_content_exapmle_tags'] 	=					
					'<div class="">
					<p>
						<span>For example, to generate Tags for products we will write the next pattern:</span>
						<pre>"!cn, !pn, !pb, !wt(, # buy in)" </pre>- which will generate the following Tags (for example we enter to product page "MacBook Air"):
						<pre>"Laptops, Notebooks, Laptops & Notebooks, MacBook, Air, MacBook Air, Apple, buy in City1, buy in City2, buy in City3, ..."</pre>
					</p>
					<span>The used parameters:</span>
					<dl class="dl-horizontal">
						<dt><span class="label label-info">!cn</span></dt>
						<dd><span class="span3">Category\'s name</span>"Laptops, Notebooks, Laptops & Notebooks"</dd>
						<dt><span class="label label-info">!pn</span></dt>
						<dd><span class="span3">Product\'s name</span>"MacBook, Air, MacBook Air"</dd>
						<dt><span class="label label-info">!pb</span></dt>
						<dd><span class="span3">Product\'s brand</span>"Apple"</dd>
						<dt><span class="label label-info">!wt</span></dt>
						<dd><span class="span3">Towns from your country</span>"buy in City1, buy in City2, buy in City3, buy in CityN"</dd>
					</dl>
					<p class="colorFC580B">
					1. In the field for template you can write your own template for generate SEO-text. For this you can simply click on this field and after this choose parameter in the popup window or write any text. After this you can click on "Generate" and this template will be saved and will be generated SEO-tags.</br></br>
					2. Buttons "Clear All" and "Clear" are used for deleting tags from pages.</br></br>
					3. If you have a few languages you must write template for every language or click on "Share" and your template will be shared for all languages.</br></br>
					4. Attention: in tags templates you can use only punctuation of comma.  One tag - this is word, a few words, parameter or combination of words and parameters, which are between two commas.
					</p>
					</div>';

// 2. META DESCRIPTIONS ======================
$_['gen_tab_content_name_m_descrip']	= 'GENERATOR OF THE META DESCRIPTIONS';
$_['gen_tab_content_exapmle_m_descrip'] =
					'<div class="">
					<p>
						<span>For example, to generate Meta description for categories we will write the next pattern:</span>
						<pre>"The best !cn, like !ep(3). !cd(2) (!sn)" </pre>- which will generate the following Meta description (for example we enter to category page "Desktops"):
						<pre>"The best Desktops, like MacBook, HP LP3065, Apple Cinema 30. The first sentences from  Desktops description. The second sentences from  Desktops description. (www.mysite.com)"</pre>
					</p>
					<span>The used parameters:</span>
					<dl class="dl-horizontal">
						
						<dt><span class="label label-info">!cn</span></dt>
						<dd><span class="span3">Category\'s name</span>
						<span class="span3">"Desktops"</span></dd>
						
						<dt><span class="label label-info">!ep(3)</span></dt>
						<dd><span class="span3">Example products from category "Desktops" (3 - total number of its)</span>
						<span class="span3">"MacBook, HP LP3065, Apple Cinema 30"</span></dd>
						
						<dt><span class="label label-info">!cd(2)</span></dt>
						<dd><span class="span3">Category\'s description (2 - total number of first sentences)</span> 
						<span class="span3">"the first two sentences from  Desktops description"</span></dd>
						<dt><span class="label label-info">!sn</span></dt>
						<dd><span class="span3">Site name</span> 
						<span class="span3">"www.mysite.com"</span></dd>
					</dl>
					<p class="colorFC580B">
					1. In the field for template you can write your own template for generate META Description. For this you can simply click on this field and after this choose parameter in the popup window or write any text. After this you can click on "Generate" and this template will be saved and will be generated META Description.</br></br>
					2. Buttons "Clear All" and "Clear" are used for deleting META Description from pages.</br></br>
					3. If you have a few languages you must write template for every language.</br></br>
					4. You can see Meta description on header section of page code: <pre>&lt;meta name="description" content=" ***SEO META Description here*** " /&gt;</pre>
					</p>
					</div>';

// 3. META KEYWORDS ======================
$_['gen_tab_content_name_m_keywords']		= 'GENERATOR OF THE META KEYWORDS';
$_['gen_tab_content_exapmle_m_keywords'] 	=					
					'<div class="">
					<p>
						<span>For example, to generate Meta keywords for products we will write the next pattern:</span>
						<pre>"buy !pn, !cn, !pb,  !pm, !pu " </pre>- which will generate the following Meta keywords (for example we enter to product page "Samsung Galaxy Tab 10.1"):
						<pre>"buy Samsung Galaxy Tab 10.1, Tablets, Samsung, Tab 10.1 4s, 036000291452"</pre>
					</p>
					<span>The used parameters:</span>
					<dl class="dl-horizontal">
						<dt><span class="label label-info">!pn</span></dt>
						<dd><span class="span3">Product\'s name</span>"Samsung Galaxy Tab 10.1"</dd>
						<dt><span class="label label-info">!cn</span></dt>
						<dd><span class="span3">Category\'s name</span>"Tablets"</dd>
						<dt><span class="label label-info">!pb</span></dt>
						<dd><span class="span3">Product\'s brand</span>"Samsung"</dd>
						<dt><span class="label label-info">!pm</span></dt>
						<dd><span class="span3">Product\'s model</span>"Tab 10.1"</dd>
						<dt><span class="label label-info">!pu</span></dt>
						<dd><span class="span3">Product\'s UPC</span>"036000291452"</dd>
						
					</dl>
					<p class="colorFC580B">
					1. In the field for template you can write your own template for generate META Keywords. For this you can simply click on this field and after this choose parameter in the popup window or write any text. After this you can click on "Generate" and this template will be saved and will be generated META Keywords.</br></br>
					2. Buttons "Clear All" and "Clear" are used for deleting META Keywords from pages.</br></br>
					3. If you have a few languages you must write template for every language.</br></br>
					4. You can see META Keywords on header section of page code: <pre>&lt;meta name="keywords" content=" ***SEO META Keywords here*** " /&gt;</pre>
					</p>
					</div>';

// 4. META TITLES ======================
$_['gen_tab_content_name_titles']		= 'GENERATOR OF THE META TITLES';
$_['gen_tab_content_exapmle_titles'] 	=					
					'<div class="">
					<p>
						<span>For example, to generate Titles for brands we will write the next pattern:</span>
						<pre>"More then !tp products from !bn,  like !ep(5#,) you find on !sn" </pre>- which will generate the following Titles (for example we enter to brand page "HTC"):
						<pre>"More then 50 products from HTC, like HTC One,  HTC Touch HD, HTC BoomBass, HTC Mini+, HTC Desire 200 you find on www.mysite.com"</pre>
					</p>
					<span>The used parameters:</span>
					<dl class="dl-horizontal">
						<dt><span class="label label-info">!tp</span></dt>
						<dd><span class="span3">Total number of products from this Brand </span>
						<span class="span3">"50"</span></dd>
						
						<dt><span class="label label-info">!bn</span></dt>
						<dd><span class="span3">Brand\'s name</span>
						<span class="span3">"HTC"</span></dd>
						
						<dt><span class="label label-info">!ep(5#,)</span></dt>
						<dd><span class="span3">Example products from Brand "HTC" ("5" - total number of its, "," - punctuation)</span>
						<span class="span3">"HTC One,  HTC Touch HD, HTC BoomBass, HTC Mini+, HTC Desire 200"</span></dd>
						<dt><span class="label label-info">!sn</span></dt>
						<dd><span class="span3">Site name</span> 
						<span class="span3">"www.mysite.com"</span></dd>
					</dl>
					<p class="colorFC580B">
					1. In the field for template you can write your own template for generate META Titles. For this you can simply click on this field and after this choose parameter in the popup window or write any text. After this you can click on "Generate" and this template will be saved and will be generated META Titles.</br></br>
					2. Buttons "Clear All" and "Clear" are used for deleting titles from pages.</br></br>
					3. If you have a few languages you must write template for every language.</br></br>
					4. You can see META Titles in the browser toolbar
					</p>
					</div>';

// 5. IMAGES NAME ======================
$_['gen_tab_content_name_images']		= 'GENERATOR OF THE SEO NAMES FOR IMAGES';
$_['gen_tab_content_exapmle_images']	=
					'<div class="">
					<p>
						<span>For example, to generate SEO name for the images of the Products we will write the next template:</span>
						<pre>"!cn-!pn" </pre>- which will generate the following  name of the image (for example give product "Iphone 4s"):
						<pre>".../phones-iphone4s-233.jpg"</pre>
					</p>
					<span>The used parameters:</span>
					<dl class="dl-horizontal">
						<dt><span class="label label-info">!cn</span></dt>
						<dd><span class="span3">Category\'s name</span>"phones"</dd>
						<dt><span class="label label-info">!pn</span></dt>
						<dd><span class="span3">Product\'s name</span>"Iphone 4s"</dd>
						<dt><span class="label label-info"></span></dt>
						<dd><span class="span3">Product\'s ID (inserted automatic)</span>"233"</dd>
					</dl>
					<p class="colorFC580B">
					1. In the field for template you can write your own template for generate SEO-names. For this you can simply click on this field and after this choose parameter in the popup window or write any text. After this you can click on "Generate" and this template will be saved and will be generated SEO-names for images.</br></br>
					2. Carefully: if you have plugins which use images from products, categories or brands on direct, after generating you must re-setting this plugins.</br></br>
					3. Also in modal window that appears after click on "Generate" you can click "Testing generator" and see which name of images will be generated on examples of a few items.
					</p>
					</div>';	

// 5. ALT IMAGES TEXT ======================
$_['gen_tab_content_name_alt_image']		= 'GENERATOR OF THE ALT IMAGE TEXT';
$_['gen_tab_content_exapmle_alt_image']	=
					'<div class="">
					<p>
						<span>For example, to generate text for image alt-tag for products we will write the next pattern:</span>
						<pre>"Buy !cn - !pn" </pre>- which will generate the following Alt text (for example, when you mouse over the picture of products "Samsung Galaxy Tab 10.1", you will see the next text):
						<pre>"Buy Tablets - Samsung Galaxy Tab 10.1"</pre>
					</p>
					<span>The used parameters:</span>
					<dl class="dl-horizontal">
						<dt><span class="label label-info">!pn</span></dt>
						<dd><span class="span3">Product\'s name</span>"Samsung Galaxy Tab 10.1"</dd>
						<dt><span class="label label-info">!cn</span></dt>
						<dd><span class="span3">Category\'s name</span>"Tablets"</dd>
					</dl>
					<p class="colorFC580B">
					1. In the field for template you can write your own template for generate Alt text. For this you can simply click on this field and after this choose parameter in the popup window or write any text. After this you can click on "Generate" and this template will be saved and will be generated Alt text.</br></br>
					2. Buttons "Clear All" and "Clear" are used for deleting Alt text.</br></br>
					3. If you have a few languages you must write template for every language.
					4. You can see Image alt text in the image code: <pre>&lt;img src="http://site.com/image.jpg" alt="Buy Tablets - Samsung Galaxy Tab 10.1" /&gt;</pre>
					</p>
					</div>';	
					
// 5. TITLE IMAGES TEXT ======================
$_['gen_tab_content_name_title_image']		= 'GENERATOR OF THE IMAGE TITLE';
$_['gen_tab_content_exapmle_title_image']	=
					'<div class="">
					<p>
						<span>For example, to generate text for image title of products we will write the next template:</span>
						<pre>"!cn - !pn" </pre>- which will generate the following image title (for example for products "Samsung Galaxy Tab 10.1", you will have the next text):
						<pre>"Tablets - Samsung Galaxy Tab 10.1"</pre>
					</p>
					<span>The used parameters:</span>
					<dl class="dl-horizontal">
						<dt><span class="label label-info">!pn</span></dt>
						<dd><span class="span3">Product\'s name</span>"Samsung Galaxy Tab 10.1"</dd>
						<dt><span class="label label-info">!cn</span></dt>
						<dd><span class="span3">Category\'s name</span>"Tablets"</dd>
					</dl>
					<p class="colorFC580B">
					1. In the field for template you can write your own template for generate image title. For this you can simply click on this field and after this choose parameter in the popup window or write any text. After this you can click on "Generate" and this template will be saved and will be generated images titles.</br></br>
					2. Buttons "Clear All" and "Clear" are used for deleting images titles.</br></br>
					3. If you have a few languages you must write template for every language.</br></br>
					4. You can see Image title in the image code: <pre>&lt;img src="http://site.com/image.jpg" title="Tablets - Samsung Galaxy Tab 10.1" /&gt;</pre>
					</p>
					</div>';	
	
// 6. URLs ======================
$_['gen_tab_content_name_urls']		= 'GENERATOR OF THE SEO URLs';
$_['gen_tab_content_exapmle_urls']	=
	'<div class="">
	
	<p>
		<span>For example, SEO Generator for CPBI(Category, Product, Brand, Info pages) SEO URLs transforms non-SEO friendly links like:</span>
		<pre>www.mysite.com/index.php?route=product/product&path=20&product_id=40</pre> to <pre>www.mysite.com/desctops/iphone</pre>
	</p>
	
	<p class="colorFC580B">
		1. In the field for template you can write your own template for generate SEO URLs. For this you can simply click on this field and after this choose parameter in the popup window or write any text. After this you can click on "Generate" and this template will be saved and will be generated SEO URLs.</br>
		2. For the default, if you leave field for template empty, SEO URLs will be generating from name of Category, Product, Brand or Info items.
	</p>
	
	<p>
		<span>For example, SEO Generator for Standart(home, account, contact, cart, etc pages) SEO URLs transforms non-SEO friendly links like:</span>
		<pre>www.mysite.com/index.php?route=common/home</pre> to <pre>www.mysite.com</pre>
	</p>
	
	<p>
		You can set the extension  for SEO urls (default: .html).</br> If you have shop with multi languages this plugin will be add code of language after domain name of site. For example, if default language is French: <pre>mysite.com/en/about-us.html
mysite.com/propos-de-nous.html</pre> For default language will not adding language code.
	</p>

	<div class="warning">
	If you have and want save old seo urls, you must use generator only in the mode "Only empty"
	</div>
	
	<p class="alert">
		After use generator of SEO URLs, if you not have file .htaccess  in your main folder of website, you must find here file paladin.htaccess and rename it to .htaccess 
	</p>
	
	</div>';
	
// 6. RELATED PRODUCTS ======================
$_['gen_tab_content_name_related_prod']		= 'GENERATOR OF THE RELATED PRODUCTS';
$_['gen_tab_content_exapmle_related_prod']	=
					'<div class="">
					<p>
					1. Here you can generate related products for every product. You can change "Total number of related products" and "Level of relevance", then click "Generate Related products for all products!" and changes will be saving and then will be generating related products.</br></br>
					2. Also in modal window that appears after click on "Generate Related products for all products!" you can click "Testing generator" and see which related products will be generated on examples of a few products.</br></br>
					3. After click on button "Clear all" will be deleted only related products, which was created by this module.
					</p>
					</div>';
	
// 7. REVIEWS ======================
$_['gen_tab_content_name_reviews']			= 'GENERATOR OF THE REVIEWS FOR PRODUCTS';
$_['gen_tab_content_exapmle_reviews']		=
					'<div class="">
					<p>
					Here you can easily generate the reviews for product. This generator has  flexible settings, which can give you possibility to set range for  time of reviews, percent of the products for generate reviews, range for rating and many others, look below:
					</p>
					<dl class="dl-horizontal">
						<dt>Own templates:</dt>
						<dd>You can write your own templates for text of reviews in national language, just click on the button "Add/Edit/Delete the templates of reviews" on the bottom of this page.</br> 
					In the templates you can use the next parameters: </br>
					<span class="label label-info">!pn</span> - product\'s name, </br>
					<span class="label label-info">!pm</span> - product\'s model, </br>
					<span class="label label-info">!pd</span> - product\'s description, </br>
					<span class="label label-info">!cn</span> - category name, </br>
					<span class="label label-info">!cd</span> - category description </br>
					Every of this parameters will be replaced on appropriate value, for example if you will writing template <pre>This !pn is amazing. I have to say it is the best experience I have ever had with any same product</pre> Then will be generated review, for example for product "HTC One", which will be contain the next text:
					<pre>This HTC One is amazing. I have to say it is the best experience I have ever had with any same product</pre>
					</dd>
					</dl>
					<dl class="dl-horizontal">
						<dt>Own names:</dt>
						<dd>You can add national names of user for the reviews, just click on the button "Add/Edit/Delete the usernames of reviews
" on the bottom of this page. And then choose your own language and  add the new rows with names.</dd>
					</dl>
					<p class="colorFC580B">The button "Clear" deletes only reviews, which was created by generator.</p>
					<p>For start in the Database of review you have 20 texts of reviews and 20000 English names of users</p>';	

// 8. SEO H1 tag ======================
$_['gen_tab_content_name_seo_h1']		= 'GENERATOR OF THE H1 tag (header)';
$_['gen_tab_content_name_seo_h2']		= 'GENERATOR OF THE H2 tag (header)';
$_['gen_tab_content_name_seo_h3']		= 'GENERATOR OF THE H3 tag (header)';
$_['gen_tab_content_exapmle_seo_h1'] = $_['gen_tab_content_exapmle_seo_h2'] =	$_['gen_tab_content_exapmle_seo_h3'] =					
					'<div class="">
					<p>
						<span>For example, to generate SEO H1/H2/H3 tag for product we will write the next pattern:</span>
						<pre>"pn! - pm! from !sn" </pre>- which will generate the following H1 tag (for example we enter to product page "Samsung Galaxy Tab 10.1"):
						<pre>"Samsung Galaxy Tab 10.1 - 4s from mysite.com"</pre>
					</p>
					<span>The used parameters:</span>
					<dl class="dl-horizontal">
						<dt><span class="label label-info">!pn</span></dt>
						<dd><span class="span3">Product\'s name</span>"Samsung Galaxy Tab 10.1"</dd>
						<dt><span class="label label-info">!pm</span></dt>
						<dd><span class="span3">Product\'s model</span>"4s"</dd>
						<dt><span class="label label-info">!sn</span></dt>
						<dd><span class="span3">Site name</span>"mysite.com"</dd>
						
					</dl>
					<p class="colorFC580B">
					1. In the field for template you can write your own template for generate SEO H1 tags. For this you can simply click on this field and after this choose parameter in the popup window or write any text. After this you can click on "Generate" and this template will be saved and will be generated SEO H1/H2/H3 tags.</br></br>
					2. Buttons "Clear All" and "Clear" are used for deleting H1 tags from pages.</br></br>
					3. If you have a few languages you must write template for every language.</br></br>
					</p>
					</div>';
?>