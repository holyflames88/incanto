<!-- MODAL PARAMETERS DESCRIPTION !-->
  <div class="modal-header clearfix">
  <h4><?php echo $text_common_reviewtext_1; ?></h4>
    <div>
		<label><?php echo $text_common_reviewtext_2; ?></label>
		<div class="btn-group pattern_line_label" style="white-space:normal; position:relative;">
			<?php $key = "product"; foreach (array('pn', 'pm', 'pd','cn', 'cd') as $parameter) { 
				$settingInfo_status = false;
				if(isset($patterns[$parameter]['settingInfo'])){
					$settingInfo_text = isset($patterns[$parameter]['settingInfo'][$key]) ? $patterns[$parameter]['settingInfo'][$key] : $patterns[$parameter]['settingInfo']['all'];
					if($settingInfo_text != ''){
						$settingInfo_status = true;
					}
				}
				/* set additional value before insert START*/
				$addValDefault = '';
				if(isset($patterns_setting[$parameter]['additional'])){

					$additional_default = isset($patterns_setting[$parameter]['additional'][$key]) ? $patterns_setting[$parameter]['additional'][$key] : $patterns_setting[$parameter]['additional']['default'];
					
					$add_metaData = isset($patterns_setting[$parameter]['add_metaData'][$key]) ? $patterns_setting[$parameter]['add_metaData'][$key] : $patterns_setting[$parameter]['add_metaData']['default'];
					
		
					$addValDefault = str_replace('"','\'',json_encode(array('name' => $add_metaData, 'value' => $additional_default)));
				}
				/* set additional value before insert END*/
			?>
			
				<a data-paramName="<?php echo $patterns[$parameter]['name']; ?>" data-addValPattern="<?php if($settingInfo_status){echo $settingInfo_text;} ?>" data-addValue ="<?php echo $addValDefault; ?>" data-toggle="tooltip" title="<?php echo $patterns[$parameter]['name']; if($settingInfo_status) { ?> </br>Possible additional setting: <?php echo $settingInfo_text;} ?>" class="seo_button_pattern btn btn-small"> !<?php echo $parameter; ?> </a>
			<?php } ?>
		</div>
		<div id="popup-setAdditionPatternValue" style="display:none;height: 300px!important;" class="modal">
			<div class="modal-header">
			<h4><?php echo $text_common_reviewtext_3; ?>: </br><span class="colorFC580B"></span></h4>
			</div>
			<div class="modal-body" style="height: 140px!important;"></div>
			<div class="modal-footer">
				<button class="insert-param-with-addValue btn btn-success" aria-hidden="true"><?php echo $text_common_insert; ?></button>
				<button class="popup-close btn" aria-hidden="true"><?php echo $text_common_close; ?></button>
			</div>
		</div>
	</div>
	<button style="float: right; margin-top: -48px;" type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    
	<div style="margin-left: 20px; margin-top: -50px;" class="btn-group pull-left">
		<a class="btn dropdown-toggle" data-toggle="dropdown"><?php echo $text_common_setting_low; ?></a>
		<button class="btn dropdown-toggle" data-toggle="dropdown">
			<span class="caret"></span>
		</button>
		<ul class="dropdown-menu">
			<li><a class="btn btn-nonstyle bg_red" data-action="deleteAllRewievItem" data-data="review_template" data-afteraction="refreshReviewTable"><?php echo $text_common_reviewtext_4; ?></a></li>
			<li><a class="btn btn-nonstyle" data-action="restoreAllRewievItem" data-data="review_template" data-afteraction="refreshReviewTable"><?php echo $text_common_reviewtext_5; ?></a></li>
		</ul>
	</div>
	<div style="margin-right: 20px; margin-top: -50px;" class="btn-group pull-right">
		<a class="add-header btn btn-success"><?php echo $text_common_add_row; ?></a>
		<a data-entity="reviews-product" data-jsbeforeaction="prepareRecive();" data-afteraction="afterAction" data-action="saveReviewTemplate" data-scope=".closest('.ajax_modal').find('input[type=text]').not('.stamp')" class="btn  ajax_action" type="button"><?php echo $text_common_save; ?><?php echo $text_common_save; ?></a>
		<a data-entity="reviews-product" data-jsbeforeaction="prepareDelete();" data-afteraction="afterAction" data-action="deleteReviewText" data-scope=".closest('.ajax_modal').find('input[type=checkbox]:checked').closest('tr').find('input[type=text]')" class="btn btn-danger ajax_action" type="button"><?php echo $text_common_delete; ?></a>
	</div>
	<form class="form-horizontal">
		<div style="float: right;margin-right: 60px;">
			<div class="control-group" style="margin-bottom: -15px;">
				<label class="control-label" style="padding-top: 3px;"><?php echo $text_common_select_all; ?></label>
				<div class="controls">
					<input class="review-element-select" type="checkbox">
				</div>
			</div>
		</div>
	</form>
  </div>

  <div class="modal-body review-tables">
	<div class="accordion-group info-area">
		<div class="accordion-heading">
		  <a class="accordion-toggle example-review-template" data-toggle="collapse" href="#example-review-template">
			<span class="lead"><?php echo $text_common_reviewtext_6; ?></span>
		  </a>
		</div>
		<div id="example-review-template" class="accordion-body collapse out">
			<div class="accordion-inner">
				<?php echo $text_common_reviewtext_7; ?>
			</div>
		</div>
	</div>
  	<div class="tabbable"> 
		<ul class="nav nav-tabs">
			<?php $i_nav_param_descrip = 1; foreach ($review_text as $l_code => $l_data) {  if(!isset($languages[$l_code]['image'])) continue; ?>
				<li <?php if($i_nav_param_descrip ==1) echo  "class=\"active\"";?> ><a href="#review_text-<?php echo $l_code; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $languages[$l_code]['image']; ?>" title="<?php echo $languages[$l_code]['name']; ?>" /> <?php echo $languages[$l_code]['name']; ?></a></li>
			<?php $i_nav_param_descrip++; } ?>
		</ul>
		
		<div class="tab-content">
			<?php $i_nav_param_descrip = 1; foreach ($review_text as $l_code => $l_data) {  if(!isset($languages[$l_code]['image'])) continue;?>
				<div class="tab-pane <?php if($i_nav_param_descrip ==1) echo  "active";?>" id="review_text-<?php echo $l_code; ?>">
					<input type="hidden" class="parameter_empty" name="" value=""/>
					<table class="table table-hover grider">
						<thead>
							<tr class="top_table">
								<th>Id</th>
								<th><?php echo $text_common_reviewtext_8; ?></th>
								<th></th>
							</tr>
						 </thead>
						 <tbody>
						<?php if(count($l_data)){?>
							<?php foreach ($l_data as $data) { ?>
							<tr>
								<td class="review-id">
									<?php echo $data['id'];?>
								</td>
								<td> 
									<input dgp-onlyfornew="1" data-gride-pattern="data[<?php echo $l_code; ?>][new_row][text][%s1]" class="span8" type="text" name="data[<?php echo $l_code; ?>][<?php echo $data['id'];?>][text]"  value="<?php echo $data['text'];?>">
								</td>
								<td>
									<input type="checkbox" value="true">
								</td>
							</tr>
							<?php } ?>
						<?php }else{ ?>
							<tr>
								<td>
									
								</td>
								<td> 
									<input dgp-onlyfornew="1" data-gride-pattern="data[<?php echo $l_code; ?>][new_row][text][%s1]" class="span6" type="text" name="data[<?php echo $l_code; ?>][new_row][text][0]"  value="">
								</td>
								<td>
									<input type="checkbox" value="true">
								</td>
							</tr>
						<?php } ?>
						</tbody>
					</table>
				</div>
			<?php $i_nav_param_descrip++; } ?>
		</div>	
	</div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_close; ?></button>
  </div>
  
<script>
  
function prepareRecive(){
	var $input = $('.review-tables').find('.grider tbody td input[type=text]');
	$input.each(function(){
		var val = $(this).val();
		if(val == ''){
			$sibling_inputs = $(this).closest('tbody').find('td input[type=text]');
			if($sibling_inputs.length > 1){
				$(this).closest('tr').remove();
			}
		}
	});
	
	var $panels = $('.review-tables').find('.tab-pane');
	$panels.each(function(){
		$input = $(this).find('.grider tbody td input[type=text]');
		if($input.length){
			$(this).find('.parameter_empty').remove();
		}
	});
	
}
function prepareDelete(){
	setTimeout(
	function(){
		$('.review-tables .active').find('input[type=checkbox]:checked').closest('tr').find('a.delete').click();
		var $after_del_check = $('.review-tables .active').find('input[type=checkbox]:checked');
		if($after_del_check.length == 1){
			$after_del_check.attr('checked', false).closest('tr').find('input').val('');
			$('.modal .close').click();
			setTimeout(function(){
				$('.review_template_open').click();
			},200);
		}
	},800);
}

/*add additional value to parameters*/

var patternAddValue = {
		data : {
			actInput		: '',
			active_param 	: '',
			MD_PatternAddVal: <?php echo json_encode($MD_PatternAddVal); ?>
			
		},
		init : function(){
			
			$('.add-header').click(function(){
			var $self = $(this);
			setTimeout(function(){
					$self.closest('.modal').find('.review-id:first').html('');
				}, 300);
			});
			
			$('.collapse').on('hidden', function(e){ 
			  e.stopPropagation(); 
			});
			
			$('.review-element-select').click(function(){
				$(this).closest('.modal').find('.modal-body input[type=checkbox]').attr('checked', this.checked);
			});
			
			var $modal = $('.review-tables').closest('.modal');
			
			$modal.find('table input').focus(function(){
				patternAddValue.data.actInput = $(this);
			});
			$modal.find('table input, #popup-setAdditionPatternValue .btn').click(function(e){
				e.stopPropagation();
			});

			$(document).click(function() {
				if($modal.find('#popup-setAdditionPatternValue').css('display') != 'block'){
					patternAddValue.data.actInput = '';
				}
			});
			
			//$modal.find('.seo_button_pattern').tooltip();
			
			$modal.find('.seo_button_pattern').click(function(e){
				if(!patternAddValue.data.actInput.length){alert('Choose field!'); return;}

				if(!$(this).attr('data-addValPattern')){
					patternAddValue.data.actInput.insertAtCaret($(this).text());
				}else{
					$self = $(this);
					var body_html = patternAddValue.getHtmlForModal($self);
					
					$popup = $('#popup-setAdditionPatternValue');
					$popup.find('H4 span').html('"' + $self.attr('data-paramName') + '"');
					$popup.find('.modal-body').html(body_html);
					$popup.show();
					
					//$modal.find('*[data-toggle=tooltip]').tooltip({html:true});
					
					patternAddValue.data.active_param = $self;
				}
				e.stopPropagation();
			});
			
			$modal.find('.popup-close').click(function(){
				$popup.hide();
			});
			$modal.find('.insert-param-with-addValue').click(function(){
				patternAddValue.writeToTemplate($(this));
				$popup.hide();
			});

		},
		writeToTemplate : function($button){
			var $parameter = patternAddValue.data.active_param;
			var $inputs = $button.closest('#popup-setAdditionPatternValue').find('input');
					
			var changed = false;
			var addValPattern = $parameter.attr('data-addValPattern');
			
			var addValue = patternAddValue.getAddValFromParam($parameter);
			var av_names = addValue.name;
			var av_values= addValue.value;
			
			$inputs.each(function(){
				//search default value
				var name = $(this).attr('name');
				var def_val = av_values[$.inArray(name, av_names)];
				
				var input_val = $(this).val();
				
				addValPattern = addValPattern.replace(name, input_val);
				
				if(input_val != def_val){
					changed = true;
				}
			});
			setTimeout(function(){
				if(changed){
					var param_addVavue = ' ' + $.trim($parameter.text()) + addValPattern +' ';
					patternAddValue.data.actInput.insertAtCaret(param_addVavue);
				}else{
					patternAddValue.data.actInput.insertAtCaret($parameter.text());
				}
			},500);
			
		},
		getAddValFromParam : function($parameter){
			var addValue = eval("("+$self.attr('data-addValue')+")");
			return addValue;
		},
		getHtmlForModal : function($parameter){
			var form_element = {
				'int' : '<input name="%s" class="span2" value="%s" min="%s" max="%s" type="number" data-toggle="tooltip" data-original-title="Must be between %s to %s" data-placement="right">',
				'str' : '<input name="%s" class="span2" value="%s" minlength="%s" maxlength="%s" type="text" data-toggle="tooltip" data-temp-min="%s" data-original-title="Can be max %s character" data-placement="right">' 
			}
			
			var form_fieldset  = '<tr><td><fieldset><div class="control-group"><label class="control-label">%s</label><div class="controls">%s</div></div></fieldset></td></tr>';
			
			var form_container_start 	= '<form class="form-horizontal"><table class="table table-condensed no-border"><tbody>';
			var form_container_end 		= '</tbody></table></form>';
			
			var addValue = patternAddValue.getAddValFromParam($parameter);
			var av_names = addValue.name;
			var av_values= addValue.value;
			var paramName= $parameter.attr('data-paramName').toLowerCase();
			
			//FIX
			paramName = paramName == "category name" ? "categories" : paramName;
			
			
			$.each(av_values, function(i, value){
				//FIX
				if(PSBdat.MD_PatternAddVal[av_names[i]]['text'] == 'Text before every '){
					paramName = paramName == "example products" ? "product" : paramName;
				}
				
				var text = patternAddValue.data.MD_PatternAddVal[av_names[i]]['text'] + paramName;
				var type = patternAddValue.data.MD_PatternAddVal[av_names[i]]['type'];
				var range= patternAddValue.data.MD_PatternAddVal[av_names[i]]['range'];

				var html_element = sprintf( form_element[type], av_names[i], value, range[0], range[1],  range[0], range[1]);
				
				var html_fieldset = sprintf(form_fieldset, text, html_element);
				
				form_container_start = form_container_start + html_fieldset;

			});
			
			var form_container = form_container_start + form_container_end;
			
			return form_container;
		}
	}
setTimeout(function(){
	$('.review-tables').parent().find('.add-header').click(function(){
		$('.review-tables').find('.tab-pane.active .add').click();
	});
	patternAddValue.init();
},500);
</script>
<style>
.modal-absolute.ajax_modal{
	width: 80%!important;
	margin-left: -40%!important;
}
.modal-absolute .review-tables{
	height: 500px!important;
	min-height: 500px!important;
}
.review-tables .delete, .review-tables caption{
	display:none;
}
.pagination {
	border-top: 0px!important;
	margin: 0px!important;
}
</style>
