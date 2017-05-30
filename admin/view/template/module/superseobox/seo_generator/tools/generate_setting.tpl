<h3><?php echo $text_common_setting_generator; ?></h3>
<form class="form-vertical form-generate-settings">
<table class="table table-condensed no-border generate_setting_class">
<tbody>
<tr><h4><?php echo $text_common_def_val_add_set; ?>:</h4></tr>
<tr>
	<td class="info_text">
		<dl>
			<dt><?php echo $text_common_add_set_param; ?>:</dt>
			<dd class="info-area">
				<?php echo $text_common_add_set_param_info; ?>
			</dd>
		</dl>
	</td>
</tr>
<?php $i_param_descrip = 1; foreach ($patterns_setting as $par_key => $val) { 
if(!isset($val['additional']))continue; ?>
	<tr>
		<td>
			<fieldset>
				<?php
					$settingInfo_text = '';
					if(isset($patterns[$par_key]['settingInfo'])){
						$settingInfo_text = $patterns[$par_key]['settingInfo']['all'] !='' ? $patterns[$par_key]['settingInfo']['all'] : $patterns[$par_key]['settingInfo']['product'];
					}
				?>
				<div class="control-group">
				<label class="control-label">!<?php echo $par_key . $settingInfo_text; ?> - <?php echo $patterns[$par_key]['name']; ?></label>
				
	<?php foreach ($val['additional'] as $add_key => $add_val) {?>
		<?php foreach ($add_val as $index => $add_setting) {?>
		
		<div class="input-prepend input-append">
			<span class="add-on"><?php echo ${'gen_setting_param_'.$par_key.'_'.$add_key.'_'.$index}; ?></span>
			<input name="data[patternsSettings][<?php echo $par_key; ?>][additional][<?php echo $add_key; ?>][<?php echo $index; ?>]" class="span1" value="<?php echo $add_setting; ?>" 
			<?php if($val['add_metaData'][$add_key][$index] == 'Nt' OR $val['add_metaData'][$add_key][$index] == 'Ns'){ ?>
			min="1" max="9" type="number" data-toggle="tooltip" data-original-title="Must be between 1 to 9" <?php } ?>
			<?php if($val['add_metaData'][$add_key][$index] == 'Pn'){ ?>
			minlength="0" maxlength="1" type="text" data-toggle="tooltip" data-original-title="Must be one character" <?php } ?>
			<?php if($val['add_metaData'][$add_key][$index] == 'Tb'){ ?>
			maxlength="256" type="text" data-toggle="tooltip" data-original-title="Maximum number of characters 256" <?php } ?> >
			
			<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('input')" class="btn ajax_action" type="button"><?php echo $text_common_save; ?></a>
			
			<?php if($add_key != 'default') {?>
			<span class="help-inline text-warning"><?php echo ${'gen_setting_param_condit_'.$add_key}; ?></span>
			<?php } ?>
		</div>
		
		<?php } ?>
	<?php } ?>

	
	<?php if($par_key == 'wt') {?>
		<div class="input-prepend input-append">
			<span class="add-on"><?php echo $text_common_select_country_towns; ?></span>
			<select name="data[patternsSettings][wt][country]" class="span2">
				<option value=""><?php echo $text_common_select_country; ?></option>
				<?php foreach ($wc_countries as $country) { ?>
				<option value="<?php echo $country['code']; ?>" <?php if($country['code'] == $patterns_setting['wt']['country']) echo 'selected="selected"' ?> ><?php echo $country['name']; ?></option>
				<?php } ?>
			</select>
			<span style="width:auto;" class="add-on"><label style="color: #777!important;"><input name="data[patternsSettings][wt][featureCode]" <?php if($patterns_setting['wt']['featureCode']) { ?> checked="checked" <?php } ?>	type="checkbox" value="PPLA"> <?php echo $text_common_get_only_town_center; ?> &nbsp;</label></span>
			<a data-afterAction="showModalTown" data-action="getTown" data-scope=".parent().find('select, input')" class="btn ajax_action" type="button"><?php echo $text_common_get_towns; ?></a>
		</div>
		<span style="margin-top:-12px;" class="pull-left text-warning">
			<?php echo $text_common_if_you_have_languages_towns; ?>
		</span>
	<?php } ?>

	<?php if($par_key == 'wc') {?>
		<div class="input-prepend input-append">
			<span class="add-on"><?php echo $text_common_select_continent_ountries; ?></span>
			<select name="data[patternsSettings][wc][continent]" class="span2">
				<option value=""><?php echo $text_common_select_continent; ?></option>
				<?php foreach ($wc_continents as $continent) { ?>
				<option value="<?php echo $continent['geonameId']; ?>" <?php if($continent['geonameId'] == $patterns_setting['wc']['continent']) echo 'selected="selected"' ?> ><?php echo $continent['name']; ?></option>
				<?php } ?>
			</select>
			<a data-afterAction="showModalCountry" data-action="getCountry" data-scope=".parent().find('select')" class="btn ajax_action" type="button"><?php echo $text_common_get_countries; ?></a>
		</div>
		<span style="margin-top:-12px;" class="pull-left text-warning">
			<?php echo $text_common_leave_continent_empty; ?>
		</span>
	<?php } ?>
				</div>
			</fieldset>
		</td>
	</tr>
<?php } ?>
</tbody>
</table>
</form>	


<!-- Modal ADD/DELET REFRESH world towns -->
<div id="modal-parameterWT" class="width_80 modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3><?php echo $text_common_edit_list_towns; ?></h3>
  </div>
  <div class="modal-body">
    
  </div>
  <div class="modal-footer">
	<input id="patternsSettings_wt_country" type="hidden" name="data[patternsSettings][wt][country]" value=""></input>
	<input id="patternsSettings_wt_featureCode" type="hidden" name="data[patternsSettings][wt][featureCode]" value=""></input>
    <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_cancel; ?></button>
	<a data-afteraction="afterAction" data-action="save" data-scope=".parents('#modal-parameterWT').find('input')" class="btn ajax_action" data-dismiss="modal" type="button"><?php echo $text_common_save_list_towns; ?></a>
  </div>
</div>

<!-- Modal ADD/DELET REFRESH world countries -->
<div id="modal-parameterWC" class="width_80 modal hide fade" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3><?php echo $text_common_edit_list_countries; ?></h3>
  </div>
  <div class="modal-body">
    
  </div>
  <div class="modal-footer">
	<input id="patternsSettings_wc_continent" type="hidden" name="data[patternsSettings][wc][continent]" value=""></input>
    <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_cancel; ?></button>
	<a data-afteraction="afterAction" data-action="save" data-scope=".parents('#modal-parameterWC').find('input')" class="btn ajax_action" data-dismiss="modal" type="button"><?php echo $text_common_save_list_countries; ?></a>
  </div>
</div>