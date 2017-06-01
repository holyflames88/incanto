<form class="form-horizontal">
			<table class="table table-condensed no-border">
			<tbody>
			<tr>
			<td colspan="2">
				<h3><?php echo $text_sitemap_header; ?></h3>
					<div class="accordion-group info-area">
						<div class="accordion-heading">
						  <a class="accordion-toggle collapsed" data-toggle="collapse" href="#example-sitemap">
							<span class="lead"><?php echo $text_common_click_here_info . ' ' . $text_sitemap_sitemap_generator; ?></span>
						  </a>
						</div>
						<div id="example-sitemap" class="accordion-body out collapse" style="height: 0px;">
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
					<ul class="nav nav-tabs" style="margin-top: -10px;">
					<?php $i_nav_seostore = 1; foreach ($stores as $store) { ?>
					<li <?php if($i_nav_seostore ==1) echo  "class=\"active\"";?> >
						<a class="store-button" href="#sitemap_store-<?php echo $store['store_id']; ?>" data-toggle="tab">
							<?php echo $store['name']; ?>
						</a>
					</li>
					<?php $i_nav_seostore++; } ?>
					</ul>
					<div class="tab-content" style="margin-top: 20px;">
					<?php $i_tab_seostore = 1; foreach ($stores as $store) { ?>
						<div class="tab-pane <?php if($i_tab_seostore ==1) echo  "active";?>" id="sitemap_store-<?php echo $store['store_id']; ?>" >
							<!-- store area -->
						<!-- store area -->
						
						<fieldset class="main_settings" style="position:absolute;margin-top:-50px;">
	<div class="control-group">
		<div class="controls btn-group" style="margin-left:0px;">
			<a class="btn" type="button"><?php echo $text_generate_sitemap . ' ' . $text_common_for; ?> <?php echo $store['name']; ?>!</a>
			<a class="btn btn-danger" type="button"><?php echo $text_delete_sitemaps; ?></a>
		</div>
	</div>
</fieldset>
<?php 
$entity_category_name = 'sitemap'; $i=0;
foreach ($data['entity']['titles'] as $entity_name => $entity_val) { ?>
<!-- ********** -->	
<fieldset <?php if($i == 0){ ?> style="margin-top:50px;" <?php } ?>>
<div class="accordion" id="accordion-setting-<?php echo $store['store_id']; ?>">
<div class="accordion-group" id="TDKT_<?php echo $entity_category_name.'-'.$entity_name;?>">
	<div class="accordion-heading">
		<div class="control-group one_control_group" style=" margin: 3px;">
			<div class="controls">
				<div style="" class="input-prepend input-append">
					<span class="add-on item_name"><?php echo ${'text_entity_name_'.$entity_name}; ?></span>
					
					<span class="add-on status status-off" data-toggle="tooltip" title="<?php echo $text_status_off; ?>" data-placement="bottom"></span>
					<div class="btn-group">
						<a class="btn btn-success" type="button"><?php echo $text_common_generate; ?>!</a>
						<a class="btn btn-danger" type="button"><?php echo $text_common_delete; ?></a>
						<input type="hidden" name="store_id" value="<?php echo $store['store_id']; ?>">
					</div>
				</div>
			</div>
		</div>
		<a data-parent="#accordion-setting-<?php echo $store['store_id']; ?>" class="accordion-toggle setting-button" data-toggle="collapse" href="#<?php echo $entity_category_name;?>-<?php echo $entity_name;?>-<?php echo $store['store_id']; ?>-setting">
			<?php echo $text_common_setting; ?> <span class="icon-wrench"></span>
		</a>
	</div>
	<div id="<?php echo $entity_category_name;?>-<?php echo $entity_name;?>-<?php echo $store['store_id']; ?>-setting" class="accordion-body collapse">
		<div class="accordion-inner">
			<button type="button" class="close">x</button>
			<div class="setting-area" data-setting="<?php echo $entity_name;?>">
			<div class="set_con">
			<?php if($store['store_id'] == 0) { ?>	
			<!-- setting-->	
			<div class="control-group">
				<label class="control-label" style="width: 138px;"><?php echo $text_common_links_mode;?>&nbsp;</label>
				<?php if($entity_name == 'product') { ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-condition="direct" class="btn" data-toggle="tooltip" data-placement="bottom" data-original-title="Set Canonical path" >
						<?php echo $text_common_canonical;?></a>
						<a type="button" data-condition="shortest" class="btn" data-toggle="tooltip" data-placement="bottom" data-original-title="Set shortest path" >
						<?php echo $text_common_shortest;?></a>
						<a type="button" data-condition="longest" class="btn" data-toggle="tooltip" data-placement="bottom" data-original-title="Set largest path" >
						<?php echo $text_common_longest;?></a>
						<a type="button" data-condition="default" class="btn active" data-toggle="tooltip" data-placement="bottom" data-original-title="Set defaul path for breadcrumbs" >
						<?php echo $text_common_default;?></a>
					</div>
				</div>	
				<?php }elseif($entity_name == 'category') { ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button"  data-condition="direct" class="btn" data-toggle="tooltip" data-placement="bottom" data-original-title="Set Canonical path" >
						<?php echo $text_common_canonical;?></a>
						<a type="button" data-condition="full" class="btn" data-toggle="tooltip" data-placement="bottom" data-original-title="Set Full path" >
						<?php echo $text_common_full;?></a>
						<a type="button" data-condition="default" class="btn active" data-toggle="tooltip" data-placement="bottom" data-original-title="Set defaul path" >
						<?php echo $text_common_default;?></a>
					</div>
				</div>	
				<?php } ?>
			</div>
			<div class="control-group">
				<label class="control-label"><?php echo $text_links_in_the_all_languages;?>&nbsp;</label>
				<div class="controls">
					<input type="checkbox" value="true" name="" class="on_off noAlert">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="">
					<?php echo $text_common_priority;?>&nbsp;
				</label>
				<div class="controls">
					<input name="" class="span1" value="5" min="0" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 0 to 10">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="">
					<?php echo $text_change_frequency;?>&nbsp;
				</label>
				<div class="controls">
					<?php $freqs = array('always', 'hourly', 'daily' , 'weekly', 'monthly', 'yearly', 'never'); ?>
					<select name="">
						<?php foreach ($freqs as $freq) { ?>
						<option value="<?php echo $freq; ?>"><?php echo ucwords($freq); ?></option>
						<?php } ?>
					</select>
				</div>
			</div>
			<?php if($entity_name != 'standard'){ ?>
			<div class="control-group" style="margin-bottom: 5px;">
				<label class="control-label"><?php echo $text_common_auto_generate;?>&nbsp;</label>
				<div class="controls">
					<input type="checkbox" value="true" name="" class="on_off noAlert">
				</div>
			</div>
			<?php } ?>
			<a style="float:right;margin-top: -38px;" class="btn btn-success" type="button"><?php echo $text_common_save;?></a>
			<!-- setting-->	
			<?php } ?>
			</div>
			</div>
		</div>
	</div>
</div>
</div>
</fieldset>
<!-- **********-->	
<?php $i++; } ?>
						
						<!-- store area -->
							<!-- store area -->	
						</div>
					<?php $i_tab_seostore++; } ?>
					</div>
				</div>	
				</td>
				<td class="info_text" rowspan="5">
					<dl style="margin-top: 55px;">
						<dt>
						<?php echo $text_generate_sitemap; ?>:
						</dt>
						<dd class="info-area">
						<?php echo $text_common_sitemap_info; ?></dd>
					</dl>
				</td>
			</tr>
				</tbody>
			</table>

			</form>

<div>
<!-- info area !-->
<h4><?php echo $text_common_sitemap_10; ?></h4>
<div class="accordion" id="accordion2">
<div class="accordion-group">
	<div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseCommon">
	 <?php echo $text_common_sitemap_11; ?>
	</a>
	</div>
	<div id="collapseCommon" class="accordion-body collapse" >
	<div class="accordion-inner">
		<?php echo $text_common_sitemap_12; ?>       
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
		<?php echo $text_common_sitemap_13; ?>
    
		<ul>
		<li><a href="https://support.google.com/webmasters/answer/156184?hl=en&ref_topic=4581190" target="_self"><?php echo $text_common_sitemap_14; ?></a></li>

		<li><a href="http://support.google.com/webmasters/bin/answer.py?hl=en&amp;answer=71453" target="_self"><?php echo $text_common_sitemap_16; ?></a></li>
		</ul>

            
	</div>
    </div>
</div>

<div class="accordion-group">
	<div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseOne">
	  <?php echo $text_common_sitemap_17; ?>
	</a>
	</div>
	<div id="collapseOne" class="accordion-body collapse" >
	<div class="accordion-inner">
	<p class="colorFC580B">
		<?php echo $text_common_sitemap_18; ?>
	</p>
	<h5><?php echo $text_common_sitemap_19; ?></h5>
	
	<p style="clear: both;"><?php echo $text_common_sitemap_20; ?><br> 

	<h4><?php echo $text_common_sitemap_21; ?>:</h4>
	<dl>
		<?php echo $text_common_sitemap_22; ?>
	</dl>
		</div>
	  </div>
	</div>

<div class="accordion-group">
	  <div class="accordion-heading">
		<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo">
		  <?php echo $text_common_sitemap_23; ?>
		</a>
	  </div>
	  <div id="collapseTwo" class="accordion-body collapse">
		<div class="accordion-inner">
		<p class="colorFC580B">
		<?php echo $text_common_sitemap_24; ?>
		<pre>sitemap-product-en-1.xml
sitemap-product-fr-1.xml</pre>
		</div>
		
	  </div>
	</div>
	
<div class="accordion-group">
  <div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapseThree">
	 <?php echo $text_common_sitemap_25; ?>
	</a>
  </div>
  <div id="collapseThree" class="accordion-body collapse">
	<div class="accordion-inner">
	<?php echo $text_common_sitemap_26; ?>
	</div>
  </div>
</div>

<div class="accordion-group">
  <div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse4">
	 <?php echo $text_common_sitemap_27; ?>
	</a>
  </div>
  <div id="collapse4" class="accordion-body collapse">
	<div class="accordion-inner">
	 <?php echo $text_common_sitemap_28; ?>
	</div>
  </div>
</div>

<div class="accordion-group">
  <div class="accordion-heading">
	<a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion2" href="#collapse5">
	  <?php echo $text_common_sitemap_29; ?>
	</a>
  </div>
  <div id="collapse5" class="accordion-body collapse">
	<div class="accordion-inner">
	  <?php echo $text_common_sitemap_30; ?>
	</div>
  </div>
</div>
</div>
<h4><?php echo $text_common_sitemap_31; ?></h4>

<pre style="font-size: 17px;">[<?php echo $text_common_sitemap_32; ?>]
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
			
		
<!-- buy addons !-->
<div id="modal-buySitemap" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-buySitemap" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3 id="modal-buySitemap">Presentation of Sitemap generator</h3>
  </div>
  <div class="modal-body">
	<p class="text-warning">This is only presentation interface of Sitemap Generator.</p>
	<p class="text-info">Sitemap Generator - is speciall addon for Paladin SEO Manager, which  can give you possibility full controll on your sitemap.</p>
	The main features is:</br>
	* Generating Sitemaps for Products, Categories, Brands and Informations pages</br>
	* Generating Sitemaps for all stores</br>
	* Generating Sitemaps for all languages</br>
	* Auto update sitemap, if you do edit/add/remove products/categories/brands/informations pages</br>
	* Unlimited number of products/categories/brands/informations pages</br>
	* Generating files of sitemap and saves its in folder sitemaps</br>
	* Generating main sitemap file, which contain all other sitemap and saves it to root folder</br>
	<h4 style="text-align: center;"><a target="_blank" class="btn btn-info" href="http://smartshopbox.com/oc-smg/admin/index.php?route=module/psmsitemapgenerator">For more info, you can look on demo site of </br> Sitemap Generator</a></h4>
	<h4 style="text-align: center;"><a target="_blank" class="btn btn-success" href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=17285">Also, you can buy this module here</a></h4>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
  </div>
</div>
		
<script>
jQuery(document).ready(function() {
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
	
	$('.addons-sitemapgenerator .btn').click(function(){
		$('#modal-buySitemap').modal('show');
	});
});
</script>			
<style>
	.addons-sitemapgenerator .accordion-group  a:hover{text-decoration: none!important;}
	.addons-sitemapgenerator .TDKT-td .accordion-group .accordion-toggle{
		margin-left: 360px;
		margin-top: -36px;
		color:#777!important;
	}

	.addons-sitemapgenerator .TDKT-td .accordion-heading a {
		color: #FFFFFF;
	}
	
	.addons-sitemapgenerator .TDKT-td .accordion-group .accordion-heading a.accordion-toggle {
		float: right;
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
	.addons-sitemapgenerator .btn.active, .btn.disabled, .btn[disabled] {
		background-color: #CFCFCF!important;
	}
</style>