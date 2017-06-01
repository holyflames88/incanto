<?php if ($stores) { ?>
<p>
<?php echo $text_common_seo_store_1; ?>
</p>
<div class="control-group form-horizontal">
	<label class="control-label"><?php echo $text_common_seo_store; ?></label>
	<div class="controls">
		<input type="hidden" name="data[tools][seo_store][status]" value="">
		<input data-afterAction="afterSnipetToolsCahnge" data-action="save" data-scope=".closest('#seo_tool_store').find('input')" type="checkbox" value="true" <?php if($data['tools']['seo_store']['status']) echo 'checked="checked"'; ?> name="data[tools][seo_store][status]" class="on_off noAlert">

		<a data-afteraction="afterAction" data-action="save" data-scope=".closest('#seo_tool_store').find('input')" class="btn ajax_action btn-success" type="button"><?php echo $text_common_save; ?></a>
	</div>
</div>
<h5><?php echo $text_common_seo_store_2; ?>:</h5>
<div class="tabbable">
  <ul class="nav nav-tabs">
    <?php $i_nav_seostore = 1; foreach ($stores as $store) { ?>
	<li <?php if($i_nav_seostore ==1) echo  "class=\"active\"";?> >
		<a href="#seo_store-<?php echo $store['store_id']; ?>" data-toggle="tab">
			<?php echo $store['name']; ?>
		</a>
	</li>
	<?php $i_nav_seostore++; } ?>
  </ul>
  <div class="tab-content">
	<?php $i_tab_seostore = 1; foreach ($stores as $store) { ?>
		<div class="tab-pane <?php if($i_tab_seostore ==1) echo  "active";?>" id="seo_store-<?php echo $store['store_id']; ?>" >
			<div class="tabbable "> 
				<ul class="nav nav-tabs">
					<?php $i_seo_store_lang_nav = 1; foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
						<li <?php if($i_seo_store_lang_nav ==1) echo  "class=\"active\"";?>>
							<a class="flag-in-tabs" href="#seo_store_lang-<?php echo $store['store_id']; ?>-<?php echo $l_code;?>" data-toggle="tab">
								<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
							</a>
						</li>
					<?php $i_seo_store_lang_nav++; } ?>
				</ul>
				
				<div class="tab-content">
					<?php $i_tab_store_lang_nav = 1; foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
						<div class="tab-pane <?php if($i_tab_store_lang_nav ==1) echo  "active";?>" id="seo_store_lang-<?php echo $store['store_id']; ?>-<?php echo $l_code;?>" >
							<div class="form-horizontal">
								<div class="control-group">
									<label class="control-label"><?php echo $text_common_seo_store_3; ?></label>
									<div class="controls">
										<?php
										$name = isset($data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_name']) ? $data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_name'] : '';	
										?>
										<input type="text" name="data[tools][seo_store][data][<?php echo $store['store_id']; ?>][<?php echo $l_code; ?>][config_name]" value="<?php echo $name; ?>">
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $text_common_seo_store_4; ?></label>
									<div class="controls">
										<?php
										$title = isset($data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_title']) ? $data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_title'] : '';	
										?>
										<input type="text" name="data[tools][seo_store][data][<?php echo $store['store_id']; ?>][<?php echo $l_code; ?>][config_title]" value="<?php echo $title; ?>">
										<span class="help-inline"><?php echo $text_common_seo_store_5; ?></span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $text_common_seo_store_6; ?></label>
									<div class="controls">
										<?php
										$m_descrip = isset($data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_meta_description']) ? $data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_meta_description'] : '';	
										?>
										<input type="text" name="data[tools][seo_store][data][<?php echo $store['store_id']; ?>][<?php echo $l_code; ?>][config_meta_description]" value="<?php echo $m_descrip; ?>">
										<span class="help-inline"><?php echo $text_common_seo_store_5; ?></span>
									</div>
								</div>
								<div class="control-group">
									<label class="control-label"><?php echo $text_common_seo_store_7; ?></label>
									<div class="controls">
										<?php
										$m_keyword = isset($data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_meta_keyword']) ? $data['tools']['seo_store']['data'][$store['store_id']][$l_code]['config_meta_keyword'] : '';	
										?>
										<input type="text" name="data[tools][seo_store][data][<?php echo $store['store_id']; ?>][<?php echo $l_code; ?>][config_meta_keyword]" value="<?php echo $m_keyword; ?>">
										<span class="help-inline"><?php echo $text_common_seo_store_5; ?></span>
									</div>
								</div>
							</div>
						</div>
					<?php $i_tab_store_lang_nav++; } ?>
				</div>

			</div>
		  
		</div>
    <?php $i_tab_seostore++; } ?>
  </div>
</div>
<?php } else { ?>
	<?php echo $text_common_seo_store_8; ?>
<?php } ?>

<h4><?php echo $text_common_seo_store_9; ?></h4>
<p><?php echo $text_common_seo_store_10; ?></p>