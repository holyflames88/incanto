<!-- Category list for writing product's templates MODAL-->
<div class="modal-header modal-categoryTemlate-header">
	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	<div class="clearfix">
	<div style="" class="pull-left btn-group">
		<a data-jsbeforeaction="categoryTemplate.clearAll()" data-entity="<?php echo $category_entity; ?>-product" data-data="all" data-afteraction="afterAction" data-action="clearCategoryTemplate" class="btn btn-danger ajax_action" type="button"><?php echo $text_common_clear_all; ?></a>
		<a data-jsbeforeaction="categoryTemplate.clearSelected()" data-entity="<?php echo $category_entity; ?>-product" data-afteraction="afterAction" data-action="clearCategoryTemplate" data-scope=".closest('.ajax_modal').find('tbody input[type=checkbox]:checked')" class="btn btn-danger ajax_action" type="button"><?php echo $text_common_clear_selected; ?></a>
	</div>
	<h4 id="modal-categoryTemlateLabel"><?php echo $text_common_templates_products_categories; ?></h4>
	</div>
	<div class="clearfix" style="margin-top: 10px;">
		<!-- multilanguage for standard urls !-->
		<div class="pull-left">
		<label><?php echo $text_common_choose_language; ?></label>
		<ul class="nav nav-pills" style="margin-bottom: -20px;">
		<?php foreach ($languages as $l_code => $language){ if(!$language['status'])continue; ?>
			<li <?php if($active_lang_code == $l_code) echo  "class=\"active\"";?>>
				<a data-code-class="lang-<?php echo $l_code; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> - <?php echo $language['name']; ?></a>
			</li>
		<?php } ?>
		</ul>
		</div>
		<!-- multilanguage for standard urls !-->
		<div class="">
			<label><?php echo $text_common_available_following_parameters; ?></label>
			<div class="btn-group pattern_line_label" style="white-space:normal; position:relative;">
				<?php $key = 'product'; foreach ($CPBI_parameters[$key] as $parameter) {
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
			<div style="display:none;" class="modal popup-setAdditionPatternValue">
				<div class="modal-header">
				<h4><?php echo $text_common_set_additional_values_parameter; ?>: </br><span class="colorFC580B"></span></h4>
				</div>
				<div class="modal-body" style="height: 140px!important;"></div>
				<div class="modal-footer">
					<button class="insert-param-with-addValue btn btn-success" aria-hidden="true"><?php echo $text_common_insert; ?></button>
					<button class="popup-close btn" aria-hidden="true"><?php echo $text_common_close; ?></button>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal-body modal-categoryTemlate">
	<div class="accordion-group info-area">
		<div class="accordion-heading">
		  <a class="accordion-toggle info-category_template" data-toggle="collapse" href="#info-category_template">
			<span class="lead"><?php echo $text_common_click_here_help_feature; ?></span>
		  </a>
		</div>
		<div id="info-category_template" class="accordion-body collapse out">
			<div class="accordion-inner">
				<?php echo $text_common_aed_category_template_info; ?>
				<span><?php echo $text_common_the_result; ?>:</span>
				<dl class="dl-horizontal">
					<dt><span class="label label-info">!cn - !pn</span></dt>
					<dd><span class="span3"><?php echo $text_common_for_all_products; ?></span>"category name - product name"</dd>
					<dt><span class="label label-info">!cn - !pn - !pm - !bn</span></dt>
					<dd><span class="span3"><?php echo $text_common_category_template_products_children; ?></dd>
				</dl>
				<p class="colorFC580B"><?php echo $text_common_also_write_diffrent_template; ?></p>
				<p class="colorFC580B"><?php echo $text_common_category_template_dont_use; ?></p>
			</div>
		</div>
	</div>
	<?php include 'category_template_list.tpl';?>
</div>
<div class="modal-footer">
	<button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_close; ?></button>
</div>
<!-- multilanguage for standard urls !--> 
<script>
jQuery(document).ready(function() {

});

var categoryTemplate = {
	init: function(){
		$('.modal-categoryTemlate-header .nav-pills a').click(function(){
			$(this).closest('.nav-pills').find('li').removeClass('active');
			$(this).parent().addClass('active');

			var activ_code_class = $(this).attr('data-code-class');
			
			$('.modal-categoryTemlate tr, .modal-categoryTemlate .label').not('.tr-static').removeClass('show-tr').animate({'opacity':'hide'},400);
			setTimeout(function(){$('.modal-categoryTemlate .' + activ_code_class).addClass('show-tr').animate({'opacity':'show'},400);},400);
			
			return false;
		});
	
		$('.collapse').on('hidden', function(e){ 
			e.stopPropagation(); 
		});
	
		categoryTemplate.setPagin();
		categoryTemplate.editableInit();
		categoryTemplate.patternAddValue.init();
	},
	
	setPagin : function(){
		var $links = $('.modal-categoryTemlate').find('.links, .pagination');
		
		$links.removeClass('pagination');
		$links.parent().addClass('pagination');

		$links.find('a').each(function(){
			var href = $(this).attr('href');
			$(this).attr('data-href', href);
			$(this).removeAttr('href');
		});

		$links.find('a').click(function(){
			categoryTemplate.getnewPage($(this).attr('data-href'));
		});
	},
	
	getnewPage : function(url){
		$('.modal-categoryTemlate').html('Please wait ...').data('');
		$('.modal-categoryTemlate').load(url, function(data) {
			//alert($(this).html());
			categoryTemplate.init();
		});
	},
	editableInit : function(){
		$('.editable').on('shown', function(e, editable) {
			editable.input.$input.addClass('seo_input_pattern');
			categoryTemplate.patternAddValue.data.actInput = editable.input.$input;
		});
		
		$('.editable').on('hidden', function(e, editable) {
			categoryTemplate.patternAddValue.data.actInput = '';
		});
		
		$('.editable').editable({
			url: '<?php echo htmlspecialchars_decode($url_save); ?>',
			mode: 'inline',
			emptytext: 'Add template',
			emptyclass:'customEmptyClass',
			inputclass:'span6',
			onblur: 'ignore'
			//showbuttons: false
		});
	},
	clearAll  : function(){
		//var $template = $('.editable');
		$('.editable').editable('setValue', '', true);
		categoryTemplate.clearCheck();
	},
	clearSelected  : function(){
		setTimeout(function(){
			var $input = $('.modal-categoryTemlate').find('tbody input[type=checkbox]:checked');
			$input.each(function(){
				$(this).closest('tr').find('.editable').editable('setValue', '', true);
			});
			categoryTemplate.clearCheck();
		}, 900);
	},
	clearCheck  : function(){
		$('.modal-categoryTemlate').find('table input[type=checkbox]').attr('checked', false);
	},
	patternAddValue : {
		data : {
			init			: false,
			actInput		: '',
			active_param 	: '',
			MD_PatternAddVal: <?php echo json_encode($MD_PatternAddVal); ?>
			
		},
		init : function(){
			if(categoryTemplate.patternAddValue.data.init){
				return;
			}
			
			categoryTemplate.patternAddValue.data.init = true;
			
			$modal = $('.modal-categoryTemlate').closest('.modal');

			$modal.find('.popup-setAdditionPatternValue .btn').click(function(e){
				e.stopPropagation();
			});
			
			//$modal.find('.seo_button_pattern').tooltip();
			
			$modal.find('.seo_button_pattern').click(function(e){
				if(!categoryTemplate.patternAddValue.data.actInput.length){alert('Choose field!'); return;}
			
				if(!$(this).attr('data-addValPattern')){
					categoryTemplate.patternAddValue.data.actInput.insertAtCaret($(this).text());
				}else{
					$self = $(this);
					var body_html = categoryTemplate.patternAddValue.getHtmlForModal($self);
					
					$popup = $('.popup-setAdditionPatternValue');
					$popup.find('H4 span').html('"' + $self.attr('data-paramName') + '"');
					$popup.find('.modal-body').html(body_html);
					$popup.show();
					
					//$modal.find('*[data-toggle=tooltip]').tooltip({html:true});
					
					categoryTemplate.patternAddValue.data.active_param = $self;
				}
				e.stopPropagation();
			});
			
			$modal.find('.popup-close').click(function(){
				$popup.hide();
			});
			$modal.find('.insert-param-with-addValue').click(function(){
				categoryTemplate.patternAddValue.writeToTemplate($(this));
				$popup.hide();
			});

		},
		writeToTemplate : function($button){
			var $parameter = categoryTemplate.patternAddValue.data.active_param;
			var $inputs = $button.closest('.popup-setAdditionPatternValue').find('input');
					
			var changed = false;
			var addValPattern = $parameter.attr('data-addValPattern');
			
			var addValue = categoryTemplate.patternAddValue.getAddValFromParam($parameter);
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
					categoryTemplate.patternAddValue.data.actInput.insertAtCaret(param_addVavue);
				}else{
					categoryTemplate.patternAddValue.data.actInput.insertAtCaret($parameter.text());
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
			
			var addValue = categoryTemplate.patternAddValue.getAddValFromParam($parameter);
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
				
				var text = categoryTemplate.patternAddValue.data.MD_PatternAddVal[av_names[i]]['text'] + paramName;
				var type = categoryTemplate.patternAddValue.data.MD_PatternAddVal[av_names[i]]['type'];
				var range= categoryTemplate.patternAddValue.data.MD_PatternAddVal[av_names[i]]['range'];

				var html_element = sprintf( form_element[type], av_names[i], value, range[0], range[1],  range[0], range[1]);
				
				var html_fieldset = sprintf(form_fieldset, text, html_element);
				
				form_container_start = form_container_start + html_fieldset;

			});
			
			var form_container = form_container_start + form_container_end;
			
			return form_container;
		}
	}
};

setTimeout(function(){
	categoryTemplate.init();
},500);

</script>
<!-- multilanguage for standard urls !-->  

<style>
.editable{
	text-decoration:none!important;
}
.customEmptyClass{
	color: #BEBEBE;
	border-bottom: dashed 1px #BEBEBE!important;
}
.modal-absolute.ajax_modal{
	width: 80%!important;
	margin-left: -40%!important;
}
.modal-absolute .modal-categoryTemlate{
	height: 700px!important;
	min-height: 700px!important;
}

.modal-categoryTemlate .pagination{
	border-top: 0px solid #DDDDDD;
	margin: -10px 0;
}
</style>
