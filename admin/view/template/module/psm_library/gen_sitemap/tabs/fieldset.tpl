<fieldset class="main_settings">
	<div class="control-group">
		<div class="controls btn-group" style="margin-left:0px;">
			<a class="btn btn-success gen_all_items" type="button">Generate <?php echo ${'text_category_name_'.$entity_category_name}; ?>s for <?php echo $store['name']; ?>!</a>
			<a data-action="prepareClearGenerate" data-scope=".closest('.tab-pane').find('input, select')" data-entity="<?php echo  $entity_category_name;?>-all" class="btn btn-danger ajax_action" type="button">Delete Sitemaps</a>
		</div>
	</div>
</fieldset>
<?php foreach ($val as $entity_name => $entity_val) { ?>
<!-- ********** -->	
<fieldset>
<div class="accordion" id="accordion-setting-<?php echo $store['store_id']; ?>">
<div class="accordion-group" id="TDKT_<?php echo $entity_category_name.'-'.$entity_name;?>">
	<div class="accordion-heading">
		<div class="control-group one_control_group" style=" margin: 3px;">
			<div class="controls">
				<div style="" class="input-prepend input-append">
					<span class="add-on item_name"><?php echo ${'text_entity_name_'.$entity_name}; ?></span>
					
					<?php 
					$status = 0;
					foreach($entity_val['status'] as $ss){
						if($ss['store_id'] == $store['store_id'] AND $ss['status'] == 1)$status = 1;
					} 
					?>
					
					<span class="add-on status <?php if($status){echo "status-on";}else{echo "status-off";}?>" data-toggle="tooltip" title="<?php if($status){echo $text_status_on;}else{echo $text_status_off;}?>" data-placement="bottom"></span>
					<div class="btn-group">
						<a data-action="prepareGenerate" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $entity_name;?>" data-scope=".closest('fieldset').find('input, select')" class="btn btn-success ajax_action <?php echo  $entity_name;?>-preparegenerate" type="button">Generate!</a>
						<a data-action="prepareClearGenerate" data-scope=".closest('fieldset').find('input, select')" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $entity_name;?>" class="btn btn-danger ajax_action" type="button">Delete</a>
						<input type="hidden" name="store_id" value="<?php echo $store['store_id']; ?>">
					</div>
				</div>
			</div>
		</div>
		<div style="display:none;">
		<a data-jsbeforeaction="PSBeng.data.ajaxBlock = false;PSBeng.progress.show();" data-afteraction="processGenerate" data-action="startGenerate" class="btn ajax_action <?php echo  $entity_name;?>-generate" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $entity_name;?>" data-scope=".closest('fieldset').find('input, select')"></a>
		</div>
		<a data-parent="#accordion-setting-<?php echo $store['store_id']; ?>" class="accordion-toggle setting-button" data-toggle="collapse" href="#<?php echo $entity_name;?>-<?php echo $store['store_id']; ?>-setting">
			SETTING <span class="icon-wrench"></span>
		</a>
	</div>
	<div id="<?php echo $entity_name;?>-<?php echo $store['store_id']; ?>-setting" class="accordion-body collapse">
		<div class="accordion-inner">
			<button type="button" class="close">x</button>
			<div class="setting-area" data-setting="<?php echo $entity_name;?>">
			<div class="set_con">
			<?php if($store['store_id'] == 0) { ?>	
			<!-- setting-->	
			<?php if(isset($entity_val['setting']['mode'])) { ?>
			<div class="control-group">
				<label class="control-label" style="width: 138px;">Links mode&nbsp;</label>
				<?php if($entity_name == 'product') { ?>
				<?php $mode = $entity_val['setting']['mode']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button" data-condition="direct" class="btn <?php if($mode == 'direct') echo "active"; ?>" data-toggle="tooltip" data-placement="bottom" data-original-title="Set Canonical path" >
						Canonical</a>
						<a type="button" data-condition="shortest" class="btn <?php if($mode == 'shortest') echo "active"; ?>" data-toggle="tooltip" data-placement="bottom" data-original-title="Set shortest path" >
						Shortest</a>
						<a type="button" data-condition="longest" class="btn <?php if($mode == 'longest') echo "active"; ?>" data-toggle="tooltip" data-placement="bottom" data-original-title="Set largest path" >
						Longest</a>
						<a type="button" data-condition="default" class="btn <?php if($mode == 'default') echo "active"; ?>" data-toggle="tooltip" data-placement="bottom" data-original-title="Set defaul path for breadcrumbs" >
						Default</a>
					</div>
					<input type="hidden" name="data[entity][sitemap][<?php echo $entity_name;?>][setting][mode]" value="<?php echo $mode; ?>">
				</div>	
				<?php }elseif($entity_name == 'category') { ?>
				<?php $mode = $entity_val['setting']['mode']; ?>
				<div class="controls radioControllValue" style="margin-left: 155px;">
					<div class="btn-group" data-toggle="buttons-radio">
						<a type="button"  data-condition="direct" class="btn <?php if($mode == 'direct') echo "active"; ?>" data-toggle="tooltip" data-placement="bottom" data-original-title="Set Canonical path" >
						Canonical</a>
						<a type="button" data-condition="full" class="btn <?php if($mode == 'full') echo "active"; ?>" data-toggle="tooltip" data-placement="bottom" data-original-title="Set Full path" >
						Full</a>
						<a type="button" data-condition="default" class="btn <?php if($mode == 'default') echo "active"; ?>" data-toggle="tooltip" data-placement="bottom" data-original-title="Set defaul path" >
						Default</a>
					</div>
					<input type="hidden" name="data[entity][sitemap][<?php echo $entity_name;?>][setting][mode]" value="<?php echo $mode; ?>">
				</div>	
				<?php } ?>
			</div>
			<?php } ?>
			<div class="control-group">
				<label class="control-label">Links in the all languages&nbsp;</label>
				<div class="controls">
					<input type="hidden" name="data[entity][sitemap][<?php echo $entity_name;?>][setting][all_language]" value="">
					<input type="checkbox" value="true" <?php if($entity_val['setting']['all_language']) echo 'checked="checked"'; ?> name="data[entity][sitemap][<?php echo $entity_name;?>][setting][all_language]" class="on_off noAlert">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="">
					Priority&nbsp;
				</label>
				<div class="controls">
					<input name="data[entity][sitemap][<?php echo $entity_name;?>][setting][prioritet]" class="span1" value="<?php echo $entity_val['setting']['prioritet'];?>" min="0" max="10" type="number" data-toggle="tooltip" data-original-title="Must be between 0 to 10">
				</div>
			</div>
			<div class="control-group">
				<label class="control-label" for="">
					Change frequency&nbsp;
				</label>
				<div class="controls">
					<?php $freqs = array('always', 'hourly', 'daily' , 'weekly', 'monthly', 'yearly', 'never'); ?>
					<select name="data[entity][sitemap][<?php echo $entity_name;?>][setting][freq]">
						<?php foreach ($freqs as $freq) { ?>
						<option value="<?php echo $freq; ?>" <?php if($freq == $entity_val['setting']['freq']) echo 'selected="selected"' ?> ><?php echo ucwords($freq); ?></option>
						<?php } ?>
					</select>
				</div>
			</div>
			<?php if($entity_name != 'standard'){ ?>
			<div class="control-group" style="margin-bottom: 5px;">
				<label class="control-label">Auto generate&nbsp;</label>
				<div class="controls">
					<input type="hidden" name="data[entity][sitemap][<?php echo $entity_name;?>][auto]" value="">
					<input type="checkbox" value="true" <?php if($entity_val['auto']) echo 'checked="checked"'; ?> name="data[entity][sitemap][<?php echo $entity_name;?>][auto]" class="on_off noAlert">
				</div>
			</div>
			<?php } ?>
			<a style="float:right;margin-top: -38px;" data-afteraction="afterAction" data-action="save" data-scope=".closest('.set_con').find('input, select')" class="btn ajax_action btn-success" type="button">Save</a>
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
<?php } ?>