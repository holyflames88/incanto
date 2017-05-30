<?php 
	echo $header;
	$entity_category_name = 'sitemap';
	$val = $active_data['entity']['sitemap']; 
?>	

<script type="text/javascript">
	var PSBdat = {
		data 			: <?php echo json_encode($active_data); ?>,
		url				: <?php echo htmlspecialchars_decode(json_encode($urls)); ?>,
		HTTP_SERVER		: '<?php echo $HTTP_SERVER; ?>'
	}
	
</script>

<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>

	<div class="box">
		<div class="heading">
			<h1 style="color: #0088CC; padding: 0px;"><img style="float:none;" src="view/stylesheet/psm_library/images/logo-small.png" alt="" /> <?php echo $heading_title; ?> (<?php echo "1.7.0(a)"; ?>)</h1>
			<div class="pull-right" style="margin-top: -35px;">
			
			<a href="<?php echo $urls['about_info']; ?>" class="btn btn-small btn-info" type="button" data-toggle="modal">About</a>

			<a href="<?php echo $urls['cancel']; ?>" class="btn btn-small" type="button">Exit</a>
			
			</div>
		<div class="clearfix"> </div>
		</div>
		<div class="content">
		<div class="tab-content addons-sitemapgenerator">
		<!-- edit area !-->	
			<form class="form-horizontal">
			<table class="table table-condensed no-border">
			<tbody>
			<tr>
			<td colspan="2">
				<?php if($paladin){ ?>
				<h3 style="margin-top: -10px;"> <a class="btn" href="<?php echo $paladin; ?>"><< Return to Paladin</a> SITEMAP GENERATOR</h3>
				<?php }else{ ?>
				<h3>SITEMAP GENERATOR</h3>
				<?php } ?>
					<div class="accordion-group info-area">
						<div class="accordion-heading" data-intro="Click here to see context help and template examples for every tabs" data-step="5" data-position="bottom">
						  <a class="accordion-toggle collapsed" data-toggle="collapse" href="#example-urls">
							<span class="lead">Click here to get the info about of module and its possibility</span>
						  </a>
						</div>
						<div id="example-urls" class="accordion-body out collapse" style="height: 0px;">
							<div class="accordion-inner">
								<button type="button" class="close">x</button>
								<div class="">
									<div class="alert"><h5>As you know, if you have more then 1500 products, Opencart can't generate sitemap, because your server will overload, and the time for generate can be more 20 sec. Also, Google can't wait so long and your sitemap couldn't upload to Google. This module solves all this issue and gives you much more for the improve your SEO</h5></div>
									<iframe style="margin-bottom: 10px; margin-left:10px;" class="pull-right" width="400" height="225" src="//www.youtube.com/embed/Gl3fyqJ6whY" frameborder="0" allowfullscreen=""></iframe>
									<p>The Sitemap has certain limitations. For example, it cannot contain more than 50 000 URLs and cannot be bigger than 10 MB. This is why if you plan to create a website with multiple subdirectories and Sitemaps, you will have to use Sitemap Index.</p>
									<p>This module allows you to generate and include several Sitemap files under one file called Sitemap index. It uses almost the same syntax but instead of including your pages URLs, this module will adds the URLs to your Sitemaps.</p>
									<p>When you've created your Sitemap index file, submit it to Google. As long as you've generated all your Sitemaps, you don't need to submit each Sitemap individually. Just submit the Sitemap index file and you're good to go. You can submit up to 500 Sitemap index files for each site in your account.</p>
								</div>	

								<div style="clear:both;" class="alert">
								<h4>NOW YOUR SITEMAP CAN INCLUDE UNLIMITED NUMBER OF PRODUCTS AND CATEGORIES!</h4> 
								</div>
							</div>
						</div>
					</div>

			</td>
			</tr>
			<tr>
				<td class="TDKT-td">
				<div class="tabbable">
					<ul class="nav nav-tabs">
					<?php $i_nav_seostore = 1; foreach ($stores as $store) { ?>
					<li <?php if($i_nav_seostore ==1) echo  "class=\"active\"";?> >
						<a class="store-button" href="#sitemap_store-<?php echo $store['store_id']; ?>" data-toggle="tab">
							<?php echo $store['name']; ?>
						</a>
					</li>
					<?php $i_nav_seostore++; } ?>
					</ul>
					<div class="tab-content">
					<?php $i_tab_seostore = 1; foreach ($stores as $store) { ?>
						<div class="tab-pane <?php if($i_tab_seostore ==1) echo  "active";?>" id="sitemap_store-<?php echo $store['store_id']; ?>" >
							<!-- store area -->
							<?php require 'tabs/fieldset.tpl';?>
							<!-- store area -->	
						</div>
					<?php $i_tab_seostore++; } ?>
					</div>
				</div>	
				</td>
				<td class="info_text" rowspan="5">
					<dl>
						<dt>
						Generate Sitemap:
						</dt>
						<dd class="info-area">
							<?php echo ${'text_entity_gener_desc_'.$entity_category_name}; ?>
						</dd>
					</dl>
				</td>
			</tr>
				</tbody>
			</table>

			</form>
<div>
<!-- test area !-->
<div class="test_area <?php if(!$index_files) echo ' hide'; ?>">
<h4>List of Sitemaps for every of your store (click for check).</h4>
<div style="clear:both;" class="alert">
<h4>Also, after generate sitemap you must delete line "RewriteRule ^sitemap.xml$ index.php?route=feed/google_sitemap [L]" in the file .htaccess</h4> 
</div>
<div class="store_link">
	<?php if($index_files) echo $index_files; ?>
</div>
After generate sitemap, you must submit  sitemap(s) (list above) to Google, the linked sitemaps will automatically start to be crawled.
<img src="view/stylesheet/psm_library/images/add_to_google.png" alt="">
</div>
<!-- test area !-->

<!-- info area !-->
<h4>INFORMATION</h4>
<div class="accordion" id="accordion2">
<div class="accordion-group">
	<div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseCommon">
	  Sitemaps for big sites - common info
	</a>
	</div>
	<div id="collapseCommon" class="accordion-body collapse" >
	<div class="accordion-inner">
		<h4>Google Sitemaps for big sites: splitting the sitemap into multiple files</h4>
		<p>Sitemaps are an important element of search engine optimization (SEO), in order to provide search engines an accurate outline of what content exists on your site. One of our client sites recently outgrew Google's sitemap URL limit. Instead of removing content from the sitemap, we implemented a simple solution of&nbsp;using a sitemap index to reference&nbsp;multiple sitemap files.</p>            
		<p>By default, Google allows a single sitemap file to reference up to 50,000 URLs (and be up to 50mb in file size, uncompressed). This limit, however, is only enforced per file.</p><p>The simplest and cleanest way to build your sitemap if you have more than 50,000 URLs to reference is to use a sitemap index, whose only role is to list sitemap files.</p>        
<pre class="eztemplate" style="font-family:monospace;">&lt;?xml <span style="color: #007700;">version</span><span style="color: #66cc66;">=</span><span style="color: #dd0000;">"1.0"</span> <span style="color: #007700;">encoding</span><span style="color: #66cc66;">=</span><span style="color: #dd0000;">"UTF-8"</span>?&gt;
&lt;sitemapindex <span style="color: #007700;">xmlns</span><span style="color: #66cc66;">=</span><span style="color: #dd0000;">"http://www.sitemaps.org/schemas/sitemap/0.9"</span>&gt;
  &lt;sitemap&gt;
&nbsp;   &lt;loc&gt;http:<span style="color: #66cc66;">//</span>www.site.com/sitemaps/sitemap<span style="color: #66cc66;">/</span>sitemap-product-1.xml&lt;<span style="color: #66cc66;">/</span>loc&gt;
    &lt;lastmod&gt;<?php echo date("Y-m-d"); ?>&lt;<span style="color: #66cc66;">/</span>lastmod&gt;
  &lt;<span style="color: #66cc66;">/</span>sitemap&gt;
  &lt;sitemap&gt;
    &lt;loc&gt;http:<span style="color: #66cc66;">//</span>www.site.com/sitemaps/sitemap<span style="color: #66cc66;">/</span>sitemap-category-1.xml&lt;<span style="color: #66cc66;">/</span>loc&gt;
    &lt;lastmod&gt;<?php echo date("Y-m-d"); ?>&lt;<span style="color: #66cc66;">/</span>lastmod&gt;
  &lt;<span style="color: #66cc66;">/</span>sitemap&gt;
&lt;<span style="color: #66cc66;">/</span>sitemapindex&gt;</pre>
		<p>Once your sitemap index is built and submitted to Google, the linked sitemaps will automatically start to be crawled.</p><p>There is a limit of 50,000 sitemaps per index, so the total limit of URLs per sitemap index file is 2,500,000,000. This should be enough for most sites, but if not, you can submit up to 500 index files!</p>        <h2>Helpful resources</h2>
    
		<ul>
		<li><a href="https://support.google.com/webmasters/answer/156184?hl=en&ref_topic=4581190" target="_self">Official Google Sitemaps documentation</a></li>

		<li><a href="http://support.google.com/webmasters/bin/answer.py?hl=en&amp;answer=71453" target="_self">Sitemap index documentation</a></li>
		</ul>

            
	</div>
    </div>
</div>

<div class="accordion-group">
	<div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
	  See info about "Links mode"
	</a>
	</div>
	<div id="collapseOne" class="accordion-body collapse" >
	<div class="accordion-inner">
	<p class="colorFC580B">
		This feature works only if  you use SEO URLs (products and categories has a keywords)
	</p>
	<h5>Get full control on your links in the sitemap files.</h5>
	
	<p style="clear: both;">As you saw many of the urls of products, has direct links without category path, or have urls which contain different categories. </br>After use this setting you will have only one path to a product, that will improve navigation and eliminate duplicates of pages with different links.<br> 

	<h4>You can set the next mode for creating links:</h4>
	<dl>
		<dt>Direct</dt>
		<dd>
			This mode creates links to products without any categories
			Links on the products will be creating by the next scheme:
			<pre>www.site.com/product_name.html</pre>
		</dd>
		<dt>Shortest</dt>
		<dd>
			In this mode will be created more shortest link on products. For example, if your product "product_name" there is in a few categories:
			<pre>A. www.site.com/category_X/subcategory_Y/product_name.html
B. www.site.com/category_Z/product_name.html</pre>
			, then will be shown shortest link  <pre>B. www.site.com/category_Z/product_name.html</pre>
		</dd>
		<dt>Longest</dt>
		<dd>
			In this mode will be created more longest link on products. For example, if your product "product_name" there is in a few categories:
			<pre>A. www.site.com/category_X/subcategory_Y/product_name.html
B. www.site.com/category_Z/product_name.html</pre>
			, then will be shown longest link  <pre>A. www.site.com/category_X/subcategory_Y/product_name.html</pre>
		</dd>
		<dt>Full (only for categories)</dt>
		<dd>
			In this mode will be created full path to category, for examle:
			<pre>A. www.site.com/category_X/subcategory_Y/subcategory_Z
B. www.site.com/category_Z</pre>
			,  then will be shown longest link  <pre>A. www.site.com/category_X/subcategory_Y/subcategory_Z</pre>
		</dd>
		<dt>Default</dt>
		<dd>
			This is standard Opencart logic for create links.
		</dd>
	</dl>
		</div>
	  </div>
	</div>

<div class="accordion-group">
	  <div class="accordion-heading">
		<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
		  See info about "Links in the all languages"
		</a>
	  </div>
	  <div id="collapseTwo" class="accordion-body collapse">
		<div class="accordion-inner">
		<p class="colorFC580B">
		Use this feature only if you have:</br>
		1. a few languages</br>
		2. special SEO module (for example <a style="text-decoration:underline;" href="https://linkonym.appspot.com/?http://www.opencart.com/index.php?route=extension/extension/info&extension_id=14855&filter_search=seo&page=3">Paladin SEO Manager</a>), which made for every language the different keywords
		</p>
		For examle, if you have the shop with the multi languages this plugin will be creates links for every language in the sitemap: 
		<pre>for english >> mysite.com/en/about-us.html
for french  >> mysite.com/propos-de-nous.html</pre>
		For every language will be created own sitemap file with language code prefix, for example:
		<pre>sitemap-product-en-1.xml
sitemap-product-fr-1.xml</pre>
		</div>
		
	  </div>
	</div>
	
<div class="accordion-group">
  <div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">
	  See info about "Priority"
	</a>
  </div>
  <div id="collapseThree" class="accordion-body collapse">
	<div class="accordion-inner">
	<p> The priority of this URL relative to other URLs on your site. Valid values range
		from 0 to 10. This value does not affect how your pages are compared to pages
		on other sites - it only lets the search engines know which pages you deem most
		important for the crawlers.</p>
	<p>	Please note that the priority you assign to a page is not likely to influence the
		position of your URLs in a search engine's result pages. Search engines may use
		this information when selecting between URLs on the same site, so you can use this
		tag to increase the likelihood that your most important pages are present in a search
		index.</p>
	<p>	Also, please note that assigning a high priority to all of the URLs on your site
		is not likely to help you. Since the priority is relative, it is only used to select
		between URLs on your site.</p>
	</div>
  </div>
</div>

<div class="accordion-group">
  <div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse4">
	  See info about "Change frequency"
	</a>
  </div>
  <div id="collapse4" class="accordion-body collapse">
	<div class="accordion-inner">
	 <p>
	 How frequently the page is likely to change. This value provides general information to search engines and may not correlate exactly to how often they crawl the page
	 </p>
	 <p>
	 The value "always" should be used to describe documents that change each time they are accessed. The value "never" should be used to describe archived URLs.
	 </p>
	</div>
  </div>
</div>

<div class="accordion-group">
  <div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse5">
	  See info about "Auto generate"
	</a>
  </div>
  <div id="collapse5" class="accordion-body collapse">
	<div class="accordion-inner">
	  <p>Turn on this function and you can forget about sitemap - when you will be add/edit/delete products, categories, brands or information pages appropriate links in the sitemap will be automaticaly updated.</p>
	</div>
  </div>
</div>
</div>
<h4>STRUCTURE OF FILES</h4>

<pre style="font-size: 17px;">[Root directory]
	- sitemap.xml 					<< index sitemap for main store (for upload to Google)
	- sitemap-1.xml 				<< index sitemap for store with id 1 (for upload to Google)
	...
	[sitemaps] 					<< subdirectory includes all sitemaps
		[sitemap]				<< subdirectory with files of  sitemaps for main store
			- sitemap-product-1.xml		<< every file can contains 1000 urls
			- sitemap-product-2.xml
			- sitemap-category-1.xml
			- sitemap-brand-1.xml
			- sitemap-info-1.xml
			- sitemap-other.xml
		[sitemap-1]				<< subdirectory with files of  sitemaps for store with id 1
			- sitemap-product-1.xml		<< every file can contains 1000 urls
			- sitemap-product-2.xml
			- sitemap-category-1.xml
			- sitemap-brand-1.xml
			- sitemap-info-1.xml
			- sitemap-other.xml
		...</pre>
<!-- info area !-->	
</div>	
			<style>
				.addons-sitemapgenerator .accordion-group  a:hover{text-decoration: none!important;}
				.addons-sitemapgenerator .TDKT-td .accordion-group .accordion-toggle{
					margin-left: 360px;
					margin-top: -36px;
					color:#777!important;
				}

				.addons-sitemapgenerator .TDKT-td .accordion-group .accordion-heading a.accordion-toggle {
					float: right;
				}
				
				.addons-sitemapgenerator .accordion-group .btn-group{
					margin-top: -1px!important; 
				}
				.addons-sitemapgenerator .accordion-group .input-prepend .btn-group a{
					-webkit-border-radius: 0 4px 4px 0!important;
					-moz-border-radius: 0 4px 4px 0!important;
					border-radius: 0 4px 4px 0!important;
				}
				.addons-sitemapgenerator .controls .item_name {
				width: 150px;
				}

				.addons-sitemapgenerator .form-horizontal .controls {
				margin-left: 0px!important;
				}
				.addons-sitemapgenerator .TDKT-td{
				width: 600px;
				}
				.addons-sitemapgenerator .input-append .add-on, .addons-sitemapgenerator .input-append .btn, .addons-sitemapgenerator .input-append .btn-group {
				margin-left: 0px;
				}
				.width_80.modal {
					width: 80%;
					margin-left: -40%;
				}
				.btn.active, .btn.disabled, .btn[disabled] {
					background-color: #CFCFCF!important;
				}
			</style>
			</div>
		</div>
	</div>	
</div>	

<!-- Test generator result MODAL-->
<div id="modal-testGenerate" class="width_80 modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-testGenerateLabel" aria-hidden="true">
	<div class="modal-header clearfix">
		<!-- multilanguage for standard urls !-->
		<ul class="nav nav-pills pull-left" style="margin-bottom: -10px; margin-right: -250px;">
		<li style="margin-top: 10px;">Choose language:&nbsp;</li>
		<?php foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
			<li <?php if($active_lang_code == $l_code) echo  "class=\"active\"";?>>
				<a data-code-class="lang-<?php echo $l_code; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></a>
			</li>
		<?php } ?>
		</ul>
		<!-- multilanguage for standard urls !-->
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">X</button>
		<h3 id="modal-testGenerateLabel">RESULT TESTING GENERATOR</h3>
	</div>
	<div class="modal-body">
		<p class="seo_text"> </p>
	</div>
	<div class="modal-footer">
		<span>If all fine you can click:</span>
		<button data-jsbeforeaction="PSBeng.data.ajaxBlock = false;PSBeng.progress.show();" data-afteraction="processGenerate" data-action="startGenerate" class="btn btn-success"  data-dismiss="modal" aria-hidden="true">Start generate</button>
		<button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
	</div>
</div>



<!-- PREPARE GENERATE MODAL-->
<div id="modal-prepareGenerate" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-prepareGenerateLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3 id="modal-prepareGenerateLabel">Start generator</h3>
  </div>
  <div class="modal-body">
	<p class="total_text"> </p>
    <p class="confirm_text"> </p>
	<p class="alert">Before use generator, necessarily make the backup of Database and the copy of image folder.</p>
  </div>
  
  <div class="modal-footer">
	
	<button data-jsbeforeaction="PSBeng.data.ajaxBlock = true;" data-action="testGenerate" class="btn btn-warning"  data-dismiss="modal" aria-hidden="true">Testing generator</button>
	<button data-jsbeforeaction="PSBeng.data.ajaxBlock = false;PSBeng.progress.show();" data-afteraction="processGenerate" data-action="startGenerate" class="btn btn-success"  data-dismiss="modal" aria-hidden="true">Start generate</button>
    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
  </div>
</div>

<!-- CLEAR GENERATE MODAL-->
<div id="modal-prepareClearGenerate" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-prepareClearGenerateLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3 id="modal-prepareClearGenerateLabel">Delete</h3>
  </div>
  <div class="modal-body alert-error">
	<p class="total_text"> </p>
    <p class="confirm_text"> </p>
  </div>
  <div class="modal-footer">
	<button data-action="startClearGenerate" class="btn btn-danger"  data-dismiss="modal" aria-hidden="true">Delete</button>
    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
  </div>
</div>


<div id="progress_bar_container">
	<div id="progress_bar" class="ui-progress-bar ui-container">
		<div class="ui-progress" style="width: 0%;">
			<span class="ui-label" style="display:none;">Processing <b class="value">0%</b></span>
		</div><!-- .ui-progress -->
	</div><!-- #progress_bar -->
</div>

<!-- multilanguage for standard urls !--> 
<script>
jQuery(document).ready(function() {
	$('#modal-testGenerate .nav-pills a').click(function(){
		$(this).closest('.nav-pills').find('li').removeClass('active');
		$(this).parent().addClass('active');
		
		var activ_code_class = $(this).attr('data-code-class');
		
		$('#modal-testGenerate .seo_text tr, #modal-testGenerate .seo_text .label').not('.tr-static').animate({'opacity':'hide'},400);
		setTimeout(function(){$('#modal-testGenerate .seo_text .' + activ_code_class).animate({'opacity':'show'},400);},400);
		
		return false;
	});
	
	
	$('.store-button').click(function(){
		var $store_area = $($(this).attr('href'));
		
		//alert($store_area.html());
		
		$store_area.find('.setting-area').each(function(){
				
			$curr_area = $(this);
			
			//alert($curr_area.html());
			
			var $set_con = $curr_area.find('.set_con');
			//alert($set_con.html());
			if(!$.trim($set_con.html())){
				var data_setting = $curr_area.attr('data-setting');
				$('.setting-area[data-setting='+ data_setting +']').each(function(){
					var $setting_area = $(this);
					
					if($.trim($setting_area.find('.set_con').html())){
						$curr_area.html('');
						$setting_area.find('.set_con').appendTo($curr_area);
						$setting_area.html('<div class="set_con"></div>')
						return false;
					}
				});
			}
			
		});
		
	});
});
</script>
<!-- multilanguage for standard urls !-->



<?php echo $footer; ?>