<!-- header start -->	
	<?php 
		$entity_category_name = 'images';
		$key = 'product';
		$val = $data['entity'][$entity_category_name][$key];
		include 'template/header.tpl';
		
	?>
<!-- header end -->		
	<tr>
		<td class="TDKT-td">
			<fieldset>
				<div class="control-group" style="margin-bottom: 2px;">
					<label style="width:160px!important;text-align: left;" class="control-label" for="">
						<?php echo $text_common_in_national_language; ?>
					</label>
					<div class="controls">
						<?php $national_lang = isset($data['entity']['images']['product']['national_lang'])? $data['entity']['images']['product']['national_lang'] : false; ?>
					
						<input type="hidden" name="data[entity][images][product][national_lang]" value="">
						<input data-action="save" data-scope=".closest('.controls').find('input')" type="checkbox" value="true" <?php if($national_lang) echo 'checked="checked"'; ?> name="data[entity][images][product][national_lang]" class="on_off noAlert">
					</div>
				</div>
				<div id="TDKT_images-product" class="control-group one_control_group">
					<div class="pattern_line_label_hide">
						<button type="button" class="close close-popup">x</button>
						<H4><?php echo $text_common_click_for_insert; ?></H4>
						<div class="btn-group pattern_line_label">
						<?php foreach (array('pn', 'cn', 'bn', 'pm', 'pu','ps') as $parameter) { 
							$settingInfo_status = false;
							if(isset($patterns[$parameter]['settingInfo'])){
								$settingInfo_text = isset($patterns[$parameter]['settingInfo'][$key]) ? $patterns[$parameter]['settingInfo'][$key] : $patterns[$parameter]['settingInfo']['all'];
								if($settingInfo_text != ''){
									$settingInfo_status = true;
								}
							}
						?>	
							<a data-toggle="tooltip" title="<?php echo $patterns[$parameter]['name']; if($settingInfo_status) { ?> </br>Possible additional setting: <?php echo $settingInfo_text;} ?>" class="seo_button_pattern btn btn-small"> !<?php echo $parameter; ?> </a>
						<?php } ?>
						</div>
					</div>
					<div class="one_entity">
						<!-- edit area -->
						<div class="controls active">
							<div style="" class="input-prepend input-append">
								<span class="add-on"><?php echo $text_common_image_template; ?></span>
								<span class="add-on status <?php if($val['status'] ==1){echo "status-on";}else{echo "status-off";}?>" data-toggle="tooltip" title="<?php if($val['status'] ==1){echo $text_status_on;}else{echo $text_status_off;}?>" data-placement="bottom"></span>
								<input data-toggle="popover" data-placement="top" data-content="<p>/<p><p>/<p>" data-original-title="Parameters for template" type="text" name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][data]" class="seo_input_pattern" value="<?php echo $val['data']; ?>">
								
								<div class="btn-group">
									<a data-action="prepareGenerate" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $key;?>" data-scope=".closest('.one_entity').find('input')" class="btn btn-success ajax_action" type="button"><?php echo $text_common_generate; ?>!</a>
									
									<a class="btn dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
									<ul class="dropdown-menu">
										<li>
											<?php 
											$additional_data = 'additionData[function]=setReplacingData&additionData[data][0]='. $entity_category_name .'&additionData[data][1]='. $key;
											$exclusion_url = $oc_data->url->link('module/superseobox/ajax', 'token=' . $oc_data->session->data['token'] . '&metaData[action]=getModal&data[m_name]=seo_generator/modal/replacing&'.$additional_data, 'SSL');
											?>
											
											<a href="<?php echo $exclusion_url; ?>" class="btn-nonstyle" type="button" data-toggle="modal"><?php echo $text_common_replacing; ?></a>
										</li>
									</ul>
								</div>
							</div>
						</div>
						<!-- edit area -->
					</div>
				</div>
			</fieldset>
		</td>
		<td class="info_text">
			<dl>
				<dt>
				<?php echo ${'text_entity_name_'.$key} . $text_suffix_s .' '. ${'text_category_name_'.$entity_category_name} ?>:</dt>
				<dd class="info-area">
					<?php echo $text_common_images_info; ?> <p class="colorFC580B">(<?php echo $text_common_click_caret; ?>)</p>
				</dd>
			</dl>
		</td>
	</tr>
	</tbody>
</table>
<!-- header start -->	
	<?php include 'template/footer.tpl';?>
<!-- header end -->	