<!-- header start -->	
	<?php
		$entity_category_name = 'descrip';
		include 'template/header.tpl';
	?>
<!-- header end -->	
	<tr>
		<td colspan="2">
			<fieldset>
			<div class="control-group">
				
				<div class="btn-group pull-left">
					<a style="" data-action="prepareGenerate" data-entity="<?php echo $entity_category_name; ?>-all" data-scope=".parents('form').find('textarea, select, input[type=checkbox]')" class="btn btn-success ajax_action" type="button"><?php echo $text_common_generate . ' ' . ${'text_category_name_'.$entity_category_name} . ' ' . $text_common_for_all_items; ?>!</a>

					<a data-action="prepareClearGenerate" data-data="emty" data-entity="<?php echo $entity_category_name; ?>-all" data-toggle="tooltip" title="Will be deleted only auto generated descriptions" class="btn btn-danger ajax_action" type="button"><?php echo $text_common_clear_all; ?></a>
					
					<a data-afterAction="afterAction" data-action="save" data-entity="<?php echo $entity_category_name; ?>-all" data-scope=".closest('form').find('textarea, select')" class="btn ajax_action save_ckeditor" type="button"><?php echo $text_common_save_all; ?></a>
				</div>
			</div>
			</fieldset>
		</td>
	</tr>	
	<tr>
		<td colspan="2">
		<div class="tabbable"> 
			<ul id="descrip_items" class="nav nav-tabs">
				<?php $i_seo_descrip_nav = 1; foreach ($data['entity']['descrip'] as $key => $val) { ?>
					<li <?php if($i_seo_descrip_nav ==1) echo  "class=\"active\"";?>>
						<a href="#seo_descrip_<?php echo  $key;?>" data-toggle="tab">
							<?php echo ${'text_entity_name_'.$key}; ?>
							<span class="add-on status <?php if($val['status'] ==1){echo "status-on";}else{echo "status-off";}?>" data-toggle="tooltip" title="<?php if($val['status'] ==1){echo $text_status_on;}else{echo $text_status_off;}?>" data-placement="bottom"></span>
						</a>
					</li>
				<?php $i_seo_descrip_nav++; } ?>
				
			</ul>
			<div class="tab-content">
				<?php $i_seo_descrip_tab = 1; foreach ($data['entity']['descrip'] as $key => $val) {?>
					<div class="single-pane tab-pane <?php if($i_seo_descrip_tab ==1) echo  "active ";?>" id="seo_descrip_<?php echo  $key;?>">
					<!-- content -->
						<div class="pull-right btn-group">
							<a data-action="prepareGenerate" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $key;?>" data-scope=".closest('form').find('input[type=checkbox]').add('.single-pane.active textarea, .single-pane.active select')" class="btn btn-success ajax_action" type="button"><?php echo $text_common_generate . ' ' . $text_category_name_descrip . ' ' . $text_common_for . ' ' . ${'text_entity_name_'.$key}; ?></a>
							<a class="btn dropdown-toggle" data-toggle="dropdown"><span class="caret"></span></a>
							<ul class="dropdown-menu">
								<li>
									<?php 
										$additional_data = 'additionData[function]=setReplacingData&additionData[data][0]='. $entity_category_name .'&additionData[data][1]='. $key;
										$exclusion_url = $oc_data->url->link('module/superseobox/ajax', 'token=' . $oc_data->session->data['token'] . '&metaData[action]=getModal&data[m_name]=seo_generator/modal/replacing&'.$additional_data, 'SSL');
									?>
									<a href="<?php echo $exclusion_url; ?>" class="btn-nonstyle" type="button" data-toggle="modal"><?php echo $text_common_replacing; ?></a>
								</li>
								<li class="divider"></li>
								<li>
									<a data-action="prepareClearGenerate" data-data="emty" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $key;?>" data-gravity="left"  data-toggle="tooltip" title="Will be deleted only auto generated descriptions"  class="bg_red btn-nonstyle ajax_action" type="button"><?php echo $text_common_clear; ?></a>
								</li>
								<li class="divider"></li>
								<li>
									<a data-afterAction="afterAction" data-action="save" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $key;?>" data-scope=".parent().parent().find('textarea, select')" class="btn-nonstyle ajax_action save_ckeditor" type="button"><?php echo $text_common_save; ?></a>
								</li>
							</ul>
						</div>
						<?php if ($i_seo_descrip_tab == 1){ ?>
							<div class="pull-left">
								<label class="control-label" style="width:220px; text-align: left;"><?php echo $text_common_generate_description_for; ?> &nbsp;</label>
								<select class="span2" name="additionData[gener_descrip_prod_for_category]">
									<option value="all" ><?php echo $text_common_all_categories; ?></option>
									<?php foreach ($categories as $category) { ?>	
										<option <?php if(isset($val['category_data']) AND in_array($category['category_id'], array_keys($val['category_data']))){ echo 'style="background-color: yellow;"'; } ?>  value="<?php echo $category['category_id']; ?>" >
										<?php echo $category['name']; ?>
										</option>
									<?php } ?>	
								</select>
							</div>
						<?php } ?>
						<div class="tabbable" style="clear: both;"> 
							<ul class="nav nav-tabs">
								<?php $i_seo_descrip_nav2= 1; foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
									 <li <?php if($i_seo_descrip_nav2 ==1) echo  "class=\"active\"";?>>
										<a href="#<?php echo  $key;?>_<?php echo $l_code;?>" data-toggle="tab">
											<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?>
										</a>
									</li>
								<?php $i_seo_descrip_nav2++; } ?>
								
							</ul>
							<div class="tab-content">
								<?php $i_seo_descrip_tab2 = 1; 
								foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
								<div class="ckeditor tab-pane <?php if($i_seo_descrip_tab2 ==1) echo  "active";?>" id="<?php echo  $key;?>_<?php echo $l_code; ?>">
									<!-- edit redactor -->
									<textarea id="<?php echo  $key;?>_<?php echo $l_code; ?>_text" name="data[entity][descrip][<?php echo  $key;?>][data][<?php echo $l_code; ?>]">
										<?php echo isset($val['data'][$l_code]) ? $val['data'][$l_code] : ''; ?>
									</textarea>
									<!-- edit redactor -->
								</div>
								<?php $i_seo_descrip_tab2++; } ?>
							</div>
						</div>
					<!-- content -->	
					</div>
		<script type="text/javascript"><!--

		<?php foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
		setTimeout(function(){
			CKEDITOR.replace("<?php echo  $key;?>_<?php echo $l_code; ?>_text", {
				filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
				filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
				filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
				filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
				filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
				filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
				customConfig : 'plugins/seo_pattern/config-descrip-<?php echo  $key;?>.js',
				enterMode	 : Number(2),
			});
		}, <?php echo $i_seo_descrip_tab*400; ?>);

		<?php } ?>
		//--></script> 
				<?php $i_seo_descrip_tab++; } ?>
			</div>
		</div>
		</td>
	</tr>	
	</tbody>
</table>
<!-- header start -->	
	<?php include 'template/footer.tpl';?>
<!-- header end -->	