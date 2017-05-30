<div class="btn-group pull-right" data-intro="Click on these buttons to see parameters description for templates. We strongly recommend to read this description for productive use SEO generator tools." data-step="6" data-intro-action="$('a[href=#seo_generator_tags]').click()" data-position="bottom">
	<a href="<?php echo $urls['param_descrip']; ?>" class="info_tab_button btn btn-info" type="button" data-toggle="modal"><i class="icon-info-sign" style="margin-top: 4px;"></i> <?php echo $text_common_parameters_description; ?></a>
	<a href="<?php echo $urls['param_setting_descrip']; ?>" class="info_tab_button btn btn-info" type="button" data-toggle="modal"><i class="icon-info-sign" style="margin-top: 4px;"></i> <?php echo $text_common_addit_set_parameters; ?></a>
</div>
<div class="box-block work-seo-box">
	<h2><?php echo $text_seo . ' ' . $text_generators; ?></h2>
	<div class="tabbable tabs-left"> 
		
		<ul id="seo_item_menu" class="seo-item-menu nav nav-tabs" data-position="right" data-intro="Now, we are in tab 'SEO GENERATORS' and this is it's menu. Here we can easily generate tags, keywords, description, titles and many other for products, category, brands and information pages. Also, here you can generate SEO URLs for all your pages." data-step="3" data-intro-action="$('a[href=#seo_generator_urls]').click();" >
			<span><?php echo $text_generators; ?></span>
			<?php $i_nav_generators = 1; foreach ($MD_CategoryEntites as $key => $val) { 
				if($val['type'] != 'generator')continue;
			?>
			<li <?php if($i_nav_generators ==1) echo  "class=\"active\"";?> >
				
				<a href="#seo_generator_<?php echo  $key;?>" data-toggle="tab">
					<i class="icon-<?php echo  $val['icon'];?>"></i> 
					<?php echo ${'text_category_name_'.$key}; ?>
					<span class="status <?php if($data['categoryEntity'][$key]['status'] ==1){echo "status-on";}else{echo "status-off";}?>" data-toggle="tooltip" title="<?php if($data['categoryEntity'][$key]['status'] ==1){echo $text_status_on;}else{echo $text_status_off;}?>" data-placement="right" <?php if($i_nav_generators ==1) {?> data-position="bottom" data-intro="This is an indicator that shows the status of this item." data-step="4" <?php } ?> ></span>
				</a>
			</li>
			<?php $i_nav_generators++; } ?>
			
			<?php if($addons['paladinSiteMapGenerator']['install']){ ?>
			<li class="no-tab-direction">
				<a href="<?php echo $addons['paladinSiteMapGenerator']['url']; ?>">
					<i class="icon-globe"></i> 
					<?php echo $text_sitemap_name; ?> <span class="text-success">(<?php echo $text_common_addon; ?>)</span> 
				</a>
			</li>
			<?php }else{ ?>
			<li>
				<a href="#seo_generator_addons_sitemap" data-toggle="tab">
					<i class="icon-globe"></i> 
					<?php echo $text_sitemap_name; ?> <span class="text-success">(<?php echo $text_common_addon; ?>)</span> 
				</a>
			</li>
			<?php } ?>
			
			<span style="padding-top:20px;"> <?php echo $text_common_tools; ?> </span>
			<li>
				<a href="#seo_auto_generate" data-toggle="tab">
					<i class="icon-cog"></i> 
					<?php echo $text_auto_generate; ?>
				</a>
			</li>	
			<li>
				<a href="#generate_setting" data-toggle="tab">
					<i class="icon-wrench"></i> 
					<?php echo $text_common_setting_low; ?>
				</a>
			</li>
		</ul>

		<div class="tab-content">
			<?php $i_tab_generators = 1; foreach ($MD_CategoryEntites as $key => $val) { 
				if($val['type'] != 'generator')continue;
			?>
			<div class="tab-pane <?php if($i_tab_generators ==1) echo  "active";?>" id="seo_generator_<?php echo  $key;?>">
				<?php if(isset($val['adm_templ'])){
					$entity_category_name= $key;
					include $val['adm_templ'] .'.tpl';
				}else{
					require_once 'seo_generator_'. $key .'.tpl';
				}
				?>
			</div>
			<?php $i_tab_generators++; } ?>
			
			<?php if($addons['paladinSiteMapGenerator']['install']){ ?>
			
			<?php }else{ ?>
			<div class="tab-pane addons-sitemapgenerator" id="seo_generator_addons_sitemap">
				<?php require_once 'view/template/module/superseobox/addons/sitemap.tpl';?>
			</div>
			<?php } ?>
			
			<div class="tab-pane" id="seo_auto_generate">
				<?php require_once 'tools/seo_auto_generate.tpl';?>
			</div>
			<div class="tab-pane" id="generate_setting">
				<?php require_once 'tools/generate_setting.tpl';?>
			</div>
			
		</div>
	</div>
</div>





<!-- =============================================================================MODALS -->

<!-- set additional value before insert START MODAL-->
<div id="modal-setAdditionPatternValue" class="width_50 modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h4><?php echo $text_common_set_addit_val_parameters; ?>: </br><span class="colorFC580B"></span></h4>
	</div>
	<div class="modal-body">
		
	</div>
	<div class="modal-footer">
		<button class="insert-param-with-addValue btn btn-success" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_insert; ?></button>
		<button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_close; ?></button>
	</div>
</div>
<!-- set additional value before insert END MODAL-->

<!-- Test generator result MODAL-->
<div id="modal-testGenerate" class="width_80 modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-testGenerateLabel" aria-hidden="true">
	<div class="modal-header clearfix">
		<!-- multilanguage for standard urls !-->
		<ul class="nav nav-pills pull-left" style="margin-bottom: -10px; margin-right: -250px;">
		<li style="margin-top: 10px;"><?php echo $text_common_choose_language; ?>:&nbsp;</li>
		<?php foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
			<li <?php if($active_lang_code == $l_code) echo  "class=\"active\"";?>>
				<a data-code-class="lang-<?php echo $l_code; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> - <?php echo $language['name']; ?></a>
			</li>
		<?php } ?>
		</ul>
		<!-- multilanguage for standard urls !-->
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
		<h3 id="modal-testGenerateLabel"><?php echo $text_common_result_test; ?></h3>
	</div>
	<div class="modal-body">
		<p class="seo_text"> </p>
	</div>
	<div class="modal-footer">
		<span><?php echo $text_common_if_all_fine; ?>:</span>
		<button data-jsbeforeaction="PSBeng.data.ajaxBlock = false;PSBeng.progress.show();" data-afteraction="processGenerate" data-action="startGenerate" class="btn btn-success"  data-dismiss="modal" aria-hidden="true"><?php echo $text_common_start_generate; ?></button>
		<button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_cancel; ?></button>
	</div>
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
	
	$('.no-tab-direction').click(function(){
		$(this).removeClass('active');
		$('a[href=#' + $('.tab-pane.active[id^=seo_generator_]').attr('id') + ']').addClass('active');
	});
});
</script>
<!-- multilanguage for standard urls !-->

<!-- PREPARE GENERATE MODAL-->
<div id="modal-prepareGenerate" class="modal hide fade width_80" tabindex="-1" role="dialog" aria-labelledby="modal-prepareGenerateLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="modal-prepareGenerateLabel"><?php echo $text_common_generator_prepared; ?></h3>
  </div>
  <div class="modal-body">
	<p class="total_text"> </p>
    <p class="confirm_text"> </p>
	<p class="alert"><?php echo $text_before_use_generator; ?></p>
	<div class="block_gener_mode">
		<form class="form-horizontal">
			<div class="control-group">
				<label class="control-label" style="width: 135px;"><?php echo $text_common_mode_generator; ?></label>
				<div class="controls" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-condition="gen_append_to_end" class="btn btn-info gen_append_to_end" data-toggle="tooltip" data-original-title="Will be append SEO text to the end of items" >
						<?php echo $text_common_append_end; ?></a>
						<a type="button" data-condition="gen_only_for_empty" class="btn btn-info active gen_only_for_empty" data-toggle="tooltip" data-original-title="Will be write only for empty items" >
						<?php echo $text_common_only_empty; ?></a>
						<a type="button" data-condition="gen_for_all_items" class="btn btn-info gen_for_all_items" data-toggle="tooltip" data-original-title="Will be write for all items" >
						<?php echo $text_common_rewrite_all; ?></a>
					</div>
				</div>
				<!-- generate for one languages -->
				<label class="control-label" style="width: 135px; margin-top: 10px;"><?php echo $text_common_generate; ?></label>
				<div class="controls" style="margin-left: 155px; margin-top: 10px;">
					<select id="block_gener_lang">
						<option value=""><?php echo $text_common_for_all_languages; ?></option>
						<?php foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
						<option value="<?php echo $l_code; ?>"><?php echo $language['name']; ?>
						</option>
						<?php } ?>
					</select>
				</div>
				<!-- generate for one languages -->
			</div>
		</form>
	</div>
  </div>
  
  <div class="modal-footer">
	<button data-jsbeforeaction="PSBeng.setCondition();PSBeng.data.ajaxBlock = true;" data-action="testGenerate" class="btn btn-warning"  data-dismiss="modal" aria-hidden="true"><?php echo $text_common_preview; ?></button>
	<button data-jsbeforeaction="PSBeng.setCondition();PSBeng.progress.show();" data-afteraction="processGenerate" data-action="startGenerate" class="btn btn-success"  data-dismiss="modal" aria-hidden="true"><?php echo $text_common_start_generate; ?></button>
    <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_cancel; ?></button>
  </div>
</div>

<!-- CLEAR GENERATE MODAL-->
<div id="modal-prepareClearGenerate" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-prepareClearGenerateLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="modal-prepareClearGenerateLabel"><?php echo $text_common_clear; ?></h3>
  </div>
  <div class="modal-body alert-error">
	<p class="total_text"> </p>
    <p class="confirm_text"> </p>
  </div>
   <div class="modal-footer">
	<button data-action="startClearGenerate" data-jsbeforeaction = "PSBeng.data.lastDataRequest.data = {area: 'all'};" class="btn btn-block btn-danger"  data-dismiss="modal" aria-hidden="true"><?php  /*echo$text_common_clear;*/ ?>Delete All</button>
	<button data-action="startClearGenerate" data-jsbeforeaction = "PSBeng.data.lastDataRequest.data = {area: 'ag'};" class="btn btn-block btn-danger spec-ag"  data-dismiss="modal" aria-hidden="true">Delete only created by Paladin</button>
	<button data-action="startClearGenerate" data-jsbeforeaction = "PSBeng.data.lastDataRequest.data = {area: 'et'};" class="btn btn-block btn-danger spec-et"  data-dismiss="modal" aria-hidden="true">Delete only created by Paladin and then were edited by the admin</button>
	<button data-action="startClearGenerate" data-jsbeforeaction = "PSBeng.data.lastDataRequest.data = {area: 'nag'};" class="btn btn-block btn-danger spec-nag"  data-dismiss="modal" aria-hidden="true">Delete all except created by Paladin</button>
	</br>
    <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_cancel; ?></button>
  </div>
</div>


<div id="progress_bar_container">
	<div id="progress_bar" class="ui-progress-bar ui-container">
		<div class="ui-progress" style="width: 0%;">
			<span class="ui-label" style="display:none;"><?php echo $text_common_processing; ?> <b class="value">0%</b></span>
		</div><!-- .ui-progress -->
	</div><!-- #progress_bar -->
</div>