<!-- header start -->		<?php 		$entity_category_name = 'reviews';		$key = 'product';		$val = $data['entity'][$entity_category_name][$key];	?><form class="form-horizontal"><table class="table table-condensed no-border">	<tbody>	<tr>	<td colspan="2">		<h3><?php echo ${'gen_tab_content_name_'.$entity_category_name}; ?></h3>			<div class="accordion-group info-area">				<div class="accordion-heading" <?php if($entity_category_name == 'urls') { ?> data-intro="Click here to see context help and template examples for every tabs" data-step="5" data-position="bottom" <?php } ?> >				  <a class="accordion-toggle" data-toggle="collapse" href="#example-<?php echo $entity_category_name; ?>">					<span class="lead"><?php echo $text_common_click_here_info . ' ' . $text_common_gener_reviews; ?> </span>				  </a>				</div>				<div id="example-<?php echo $entity_category_name; ?>" class="accordion-body collapse out">					<div class="accordion-inner">						<button type="button" class="close">x</button>						<?php echo ${'gen_tab_content_exapmle_'.$entity_category_name}; ?>					</div>				</div>			</div>	</td>	</tr><!-- header end -->			<tr>		<td >			<fieldset>				<div class="control-group">					<div class="controls btn-group pull-right" style="margin-left: 0px;">						<a data-action="prepareGenerate" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $key;?>" data-scope=".closest('tbody').find('input, select')" class="btn btn-success ajax_action" type="button"><?php echo $text_common_gener_reviews_product; ?>!</a>						<a data-afteraction="afterAction" data-action="save" data-scope=".closest('tbody').find('input, select')" class="btn ajax_action" type="button"><?php echo $text_common_save; ?></a>						<a data-action="prepareClearGenerate" data-data="emty" data-entity="<?php echo $entity_category_name; ?>-<?php echo  $key;?>" class="btn btn-danger ajax_action" type="button"><?php echo $text_common_clear; ?></a>					</div>				</div>			</fieldset>		</td>		<td>					</td>	</tr>	<tr>		<td>			<fieldset>				<div class="control-group">					<label class="control-label" for=""><?php echo $text_common_range_days; ?></label>					<div class="controls">						<input name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][setting][interval]" class="span1" value="<?php echo $data['entity'][$entity_category_name][$key]['setting']['interval']; ?>" min="0" max="3600" type="number">					</div>				</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt><?php echo $text_common_range_days; ?>:</dt>				<dd class="info-area">					<?php echo $text_common_range_days_info; ?>				</dd>			</dl>		</td>	</tr>	<tr>		<td>			<fieldset>				<div class="control-group">					<label class="control-label" for=""><?php echo $text_common_percent_products; ?></label>					<div class="controls">						<input name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][setting][per_prod]" class="span1" value="<?php echo $data['entity'][$entity_category_name][$key]['setting']['per_prod']; ?>" min="0" max="100" type="number">					</div>				</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt><?php echo $text_common_percent_products; ?>:</dt>				<dd class="info-area">					<?php echo $text_common_percent_products_info; ?>				</dd>			</dl>		</td>	</tr>	<tr>		<td>			<fieldset>				<div class="control-group">					<label class="control-label" for=""><?php echo $text_common_language_reviews; ?></label>					<div class="controls">						<select name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][setting][l_code_for_text]" class="span2">							<option value="all"><?php echo $text_common_all_languages; ?></option>							<?php foreach ($languages as $language) { ?>							<option value="<?php echo $language['code']; ?>" <?php if($language['code'] == $data['entity'][$entity_category_name][$key]['setting']['l_code_for_text']) echo 'selected="selected"' ?> ><?php echo $language['name']; ?></option>							<?php } ?>						</select>					</div>				</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt><?php echo $text_common_language_reviews; ?>:</dt>				<dd class="info-area">					<?php echo $text_common_language_reviews_info; ?>				</dd>			</dl>		</td>	</tr>		<tr>		<td>			<fieldset>				<div class="control-group">					<label class="control-label" for=""><?php echo $text_common_language_reviews_names; ?> </label>					<div class="controls">						<select name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][setting][l_code_for_name]" class="span2">							<option value="all"><?php echo $text_common_all_languages; ?></option>							<?php foreach ($languages as $language) { ?>							<option value="<?php echo $language['code']; ?>" <?php if($language['code'] == $data['entity'][$entity_category_name][$key]['setting']['l_code_for_name']) echo 'selected="selected"' ?> ><?php echo $language['name']; ?></option>							<?php } ?>						</select>					</div>				</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt><?php echo $text_common_language_reviews_names; ?>:</dt>				<dd class="info-area">					<?php echo $text_common_language_reviews_names_info; ?>				</dd>			</dl>		</td>	</tr>	<tr>		<td>			<fieldset>				<div class="control-group" style="width: 270px;">					<?php 					$min = $data['entity'][$entity_category_name][$key]['setting']['rev_min'];					$max = $data['entity'][$entity_category_name][$key]['setting']['rev_max'];					?>					<label class="control-label" style="float: none;width: 270px;text-align: left;"><?php echo $text_common_min_max_quantity_reviews; ?>: <span class="text_label"><?php echo $min; ?> - <?php echo $max; ?></span></label>					<div class="controls" style="margin-left:3px;">						<input name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][setting][rev_min]" value="<?php echo $min; ?>" type="hidden">						<input name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][setting][rev_max]" value="<?php echo $max; ?>" type="hidden">						<div id="s-reviews_quantity"></div>					</div>				</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt><?php echo $text_common_min_max_quantity_reviews; ?>:</dt>				<dd class="info-area">					<?php echo $text_common_min_max_quantity_reviews_info; ?>				</dd>			</dl>		</td>	</tr>	<tr>		<td>			<fieldset>				<div class="control-group" style="width: 270px;">					<?php 					$min = $data['entity'][$entity_category_name][$key]['setting']['rat_min'];					$max = $data['entity'][$entity_category_name][$key]['setting']['rat_max'];					?>					<label class="control-label" style="float: none;width: 270px;text-align: left;"><?php echo $text_common_min_max_rating_reviews; ?>: <span class="text_label"><?php echo $min; ?> - <?php echo $max; ?></span></label>					<div class="controls" style="margin-left:3px;">						<input name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][setting][rat_min]" value="<?php echo $min; ?>" type="hidden">						<input name="data[entity][<?php echo $entity_category_name; ?>][<?php echo  $key;?>][setting][rat_max]" value="<?php echo $max; ?>" type="hidden">						<div id="s-reviews_rating"></div>					</div>				</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt><?php echo $text_common_min_max_rating_reviews; ?>:</dt>				<dd class="info-area">					<?php echo $text_common_min_max_rating_reviews_info; ?>				</dd>			</dl>		</td>	</tr>		<tr>		<td>			<fieldset>				<div class="control-group">					<label class="control-label" for=""><?php echo $text_common_aed_reviews; ?></label>					<div class="controls">						<?php 						$additional_data = 'additionData[function]=setReviewTemlateData';						$review_url = $oc_data->url->link('module/superseobox/ajax', 'token=' . $oc_data->session->data['token'] . '&metaData[action]=getModal&data[m_name]=seo_generator/modal/review_text&'.$additional_data, 'SSL');						?>												<a style="width:165px; color: #fff;" data-jsbeforeaction="$('body,html').stop(true,true).animate({'scrollTop':0},'slow');" href="<?php echo $review_url; ?>" class="btn btn-warning review_template_open" type="button" data-toggle="modal"><?php echo $text_common_open_table; ?></a>					</div>				</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt><?php echo $text_common_aed_reviews; ?>:</dt>				<dd class="info-area">					<?php echo $text_common_aed_reviews_info; ?>				</dd>			</dl>		</td>	</tr>	<tr>		<td>			<fieldset>				<div class="control-group">					<label class="control-label" for=""><?php echo $text_common_aed_reviews_names; ?></label>					<div class="controls">						<?php 						$additional_data = 'additionData[function]=setReviewNameData';						$review_url = $oc_data->url->link('module/superseobox/ajax', 'token=' . $oc_data->session->data['token'] . '&metaData[action]=getModal&data[m_name]=seo_generator/modal/review_name&'.$additional_data, 'SSL');						?>												<a style="width:165px; color: #fff;" data-jsbeforeaction="$('body,html').stop(true,true).animate({'scrollTop':0},'slow');" href="<?php echo $review_url; ?>" class="btn btn-warning review_name_open" type="button" data-toggle="modal"><?php echo $text_common_open_table; ?></a>					</div>				</div>			</fieldset>		</td>		<td class="info_text">			<dl>				<dt><?php echo $text_common_aed_reviews_names; ?>:</dt>				<dd class="info-area">					<?php echo $text_common_aed_reviews_names_info; ?>				</dd>			</dl>		</td>	</tr>		</tbody></table></form><script>$(function() {	$slider_self = $( "#s-reviews_quantity" );    $slider_self.slider({		range: true,		min: 1,		max: 10,		values: [ getValueForSlider($slider_self, 0), getValueForSlider($slider_self, 1) ],		slide: function( event, ui ) {			$controls = $(this).closest('.control-group');			$inputs = $controls.find('input');			$inputs.first().val(ui.values[0]);			$inputs.last().val(ui.values[1]);			$controls.find('.text_label').html(ui.values[ 0 ] + " - " + ui.values[ 1 ]);		}	});			$slider_self = $( "#s-reviews_rating" );	    $slider_self.slider({		range: true,		min: 0,		max: 5,		values: [ getValueForSlider($slider_self, 0), getValueForSlider($slider_self, 1) ],		slide: function( event, ui ) {			$controls = $(this).closest('.control-group');			$inputs = $controls.find('input');			$inputs.first().val(ui.values[0]);			$inputs.last().val(ui.values[1]);			$controls.find('.text_label').html(ui.values[ 0 ] + " - " + ui.values[ 1 ]);		}	});});		function getValueForSlider ($self, number){	$controls = $self.closest('.control-group');	$inputs = $controls.find('input');	return $inputs.eq(number).val();}  </script><style>.ui-widget-header {	border: 1px solid #969696;	background: #C7C4C4;}.text_label{	font-weight:bold;}</style>