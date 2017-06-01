<table class="form">
  <tr>
    <td><span class="required">*</span> <?php echo $entry_code; ?></td>
    <td>
        <select name="SimilarProducts[Enabled]" class="SimilarProductsEnabled">
            <option value="yes" <?php echo ($data['SimilarProducts']['Enabled'] == 'yes') ? 'selected=selected' : '' ?>>Enabled</option>
           <option value="no" <?php echo ($data['SimilarProducts']['Enabled'] == 'no') ? 'selected=selected' : '' ?>>Disabled</option>
        </select>
   </td>
  </tr>
	<tr>
    <td>Custom Positioning:</td>
    <td>
        <select name="SimilarProducts[AdditionalPositioning]" class="SimilarProductsAdditionalPositioning">
            <option value="default" <?php echo (isset($data['SimilarProducts']['AdditionalPositioning']) && $data['SimilarProducts']['AdditionalPositioning'] == 'default') ? 'selected=selected' : '' ?>>No custom positioning</option>
           <option value="below_product_info" <?php echo (isset($data['SimilarProducts']['AdditionalPositioning']) && $data['SimilarProducts']['AdditionalPositioning'] == 'below_product_info') ? 'selected=selected' : '' ?>>Below Product Information on Product Page</option>
                      <option value="product_tab" <?php echo (isset($data['SimilarProducts']['AdditionalPositioning']) && $data['SimilarProducts']['AdditionalPositioning'] == 'product_tab') ? 'selected=selected' : '' ?>>Show in a Product Tab</option>

        </select>
   </td>
  </tr>
  <tr>
    <td>Wrap in widget:</td>
    <td>
        <select name="SimilarProducts[WrapInWidget]" class="SimilarProductsWrapInWidget">
            <option value="yes" <?php echo ($data['SimilarProducts']['WrapInWidget'] == 'yes') ? 'selected=selected' : '' ?>>Enabled</option>
           <option value="no" <?php echo ($data['SimilarProducts']['WrapInWidget'] == 'no') ? 'selected=selected' : '' ?>>Disabled</option>
        </select>
   </td>
  </tr>
    <tr>
    <td>Add to Cart button:</td>
    <td>
        <select name="SimilarProducts[AddToCart]" class="SimilarProductsAddToCart">
            <option value="yes" <?php echo ($data['SimilarProducts']['AddToCart'] == 'yes') ? 'selected=selected' : '' ?>>Enabled</option>
           <option value="no" <?php echo ($data['SimilarProducts']['AddToCart'] == 'no') ? 'selected=selected' : '' ?>>Disabled</option>
        </select>
   </td>
  </tr>
   <tr>
    <td>Picture Width & Height:<span class="help">In Pixels</span></td>
    <td>
        Width:&nbsp;&nbsp;&nbsp;<div class="input-append"><input type="text" name="SimilarProducts[PictureWidth]" class="SimilarProductsPictureWidth input-mini" value="<?php echo (isset($data['SimilarProducts']['PictureWidth'])) ? $data['SimilarProducts']['PictureWidth'] : '80' ?>" /></input><span class="add-on">px</span></div><br />Height:&nbsp;<div class="input-append"><input type="text" name="SimilarProducts[PictureHeight]" class="SimilarProductsPictureHeight input-mini" value="<?php echo (isset($data['SimilarProducts']['PictureHeight'])) ? $data['SimilarProducts']['PictureHeight'] : '80' ?>" /></input><span class="add-on">px</span></div>
   </td>
  </tr>
  <tr>
    <td>Number of Products:</td>
    <td>
        <input type="text" name="SimilarProducts[NumberOfProducts]" class="SimilarProductsNumberOfProducts" value="<?php echo (isset($data['SimilarProducts']['NumberOfProducts'])) ? $data['SimilarProducts']['NumberOfProducts'] : '4' ?>" /></input>
   </td>
  </tr>
  <tr>
    <td>Custom CSS:</td>
    <td>
        <textarea name="SimilarProducts[CustomCSS]" placeholder="Paste your Custom CSS here" class="SimilarProductsCustomCSS"><?php echo (isset($data['SimilarProducts']['CustomCSS'])) ? $data['SimilarProducts']['CustomCSS'] : '' ?></textarea>
   </td>
  </tr>
  <tr class="SimilarProductsActiveTR">
     <td colspan="2">
       			<table id="module" class="table table-bordered table-hover" width="100%" >
  <thead>
    <tr class="table-header">
      <td class="left"><strong><?php echo $entry_layout_options; ?></strong></td>
      <td class="left"><strong><?php echo $entry_position_options; ?></strong></td>
      <td class="left"><strong><?php echo $entry_actions; ?></strong></td>
    </tr>
  </thead>
  <?php $module_row = 0; ?>
  <?php foreach ($modules as $module) { ?>
  <tbody id="module-row<?php echo $module_row; ?>">
    <tr>
      <td class="left">
        <label class="module-row-label"><?php echo $entry_status; ?> <select class="span2" name="similarproducts_module[<?php echo $module_row; ?>][status]">
          <?php if ($module['status']) { ?>
          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
          <option value="0"><?php echo $text_disabled; ?></option>
          <?php } else { ?>
          <option value="1"><?php echo $text_enabled; ?></option>
          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
          <?php } ?>
        </select></label><br />
        <label class="module-row-label"><?php echo $entry_layout; ?> <select class="span2" name="similarproducts_module[<?php echo $module_row; ?>][layout_id]">
          <?php foreach ($layouts as $layout) { ?>
          <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
          <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
          <?php } else { ?>
          <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
          <?php } ?>
          <?php } ?>
        </select></label><br />
      	<label class="module-row-label"><?php echo $entry_sort_order; ?> <input class="span1" class="module-row-input-number" type="number" name="similarproducts_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" /></label>
      </td>
      <td class="left">
        <div class="buttonPositionOpenCart" style="float:left; padding-right:10px; text-align:center;">
        <div class="leftBoxInput"><input <?php if ($module['position'] == 'content_top') echo 'checked="checked"'; ?> type="radio" style="width:auto" name="similarproducts_module[<?php echo $module_row; ?>][position]" id="buttonPos<?php echo $module_row; ?>_1" class="buttonPositionOptionBox" data-checkbox="#buttonPosCheckbox_<?php echo $module_row; ?>" value="content_top" /></div><div class="leftBoxTitle posTitleLabel"><label for="buttonPos1"><?php echo $text_content_top; ?></label></div>
        <div class="positionSampleBox"><label for="buttonPos<?php echo $module_row; ?>_1"><img class="img-polaroid" src="view/image/similarproducts/content_top.png" title="<?php echo $text_content_top; ?>" border="0" /></label></div>        
    </div>
        <div class="buttonPositionOpenCart" style="float:left; padding-right:10px; text-align:center;">
        <div class="leftBoxInput"><input <?php if ($module['position'] == 'content_bottom') echo 'checked="checked"'; ?> type="radio" style="width:auto" name="similarproducts_module[<?php echo $module_row; ?>][position]" id="buttonPos<?php echo $module_row; ?>_2" class="buttonPositionOptionBox" data-checkbox="#buttonPosCheckbox_<?php echo $module_row; ?>" value="content_bottom" /></div><div class="leftBoxTitle posTitleLabel"><label for="buttonPos2"><?php echo $text_content_bottom; ?></label></div>
        <div class="positionSampleBox"><label for="buttonPos<?php echo $module_row; ?>_2"><img class="img-polaroid" src="view/image/similarproducts/content_bottom.png" title="<?php echo $text_content_bottom; ?>" border="0" /></label></div>        
    </div>
        <div class="buttonPositionOpenCart" style="float:left; padding-right:10px; text-align:center;">
        <div class="leftBoxInput"><input <?php if ($module['position'] == 'column_left') echo 'checked="checked"'; ?> type="radio" style="width:auto" name="similarproducts_module[<?php echo $module_row; ?>][position]" id="buttonPos<?php echo $module_row; ?>_3" class="buttonPositionOptionBox" data-checkbox="#buttonPosCheckbox_<?php echo $module_row; ?>" value="column_left" /></div><div class="leftBoxTitle posTitleLabel"><label for="buttonPos3"><?php echo $text_column_left; ?></label></div>
        <div class="positionSampleBox"><label for="buttonPos<?php echo $module_row; ?>_3"><img class="img-polaroid" src="view/image/similarproducts/column_left.png" title="<?php echo $text_column_left; ?>" border="0" /></label></div>        
    </div>
        <div class="buttonPositionOpenCart last" style="float:left; padding-right:10px; text-align:center;">
        <div class="leftBoxInput"><input <?php if ($module['position'] == 'column_right') echo 'checked="checked"'; ?> type="radio" style="width:auto" name="similarproducts_module[<?php echo $module_row; ?>][position]" id="buttonPos<?php echo $module_row; ?>_4" class="buttonPositionOptionBox" data-checkbox="#buttonPosCheckbox_<?php echo $module_row; ?>" value="column_right" /></div><div class="leftBoxTitle posTitleLabel"><label for="buttonPos4"><?php echo $text_column_right; ?></label></div>
        <div class="positionSampleBox"><label for="buttonPos<?php echo $module_row; ?>_4"><img class="img-polaroid" src="view/image/similarproducts/column_right.png" title="<?php echo $text_column_right; ?>" border="0" /></label></div>
    </div></td>
      <td class="left" style="vertical-align:middle;"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-small btn-danger" style="text-decoration:none;"><i class="icon-remove"></i> <?php echo $button_remove; ?></a></td>
    </tr>
  </tbody>
  <?php $module_row++; ?>
  <?php } ?>
  <tfoot>
    <tr>
      <td colspan="2"></td>
      <td class="left"><a onclick="addModule();" class="btn btn-small btn-primary"><i class="icon-plus"></i> <?php echo $button_add_module; ?></a></td>
    </tr>
  </tfoot>
</table>
<script type="text/javascript">
var toggleCSScheckbox = function() {
	$('input[type=checkbox][id^=buttonPosCheckbox]').each(function(index, element) {
		if ($(this).is(':checked')) {
			$($(this).attr('data-textinput')).removeAttr('disabled');
		} else {
			$($(this).attr('data-textinput')).attr('disabled','disabled');
		}
	});
}
var createBinds = function() {
	$('input[type=checkbox][id^=buttonPosCheckbox]').unbind('change').bind('change', function() {
		toggleCSScheckbox();
	});
	
	$('.buttonPositionOptionBox').unbind('change').bind('çhange', function() {
		$($(this).attr('data-checkbox')).removeAttr('checked');
		toggleCSScheckbox();
	});
};
toggleCSScheckbox();
createBinds();
</script>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;
function addModule() {
	html  = '<tbody style="display:none;" id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left">';
	html += '    <label class="module-row-label"><?php echo $entry_status; ?> <select class="span2" name="similarproducts_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></label><br />';
	html += '    <label class="module-row-label"><?php echo $entry_layout; ?> <select class="span2" name="similarproducts_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '    </select></label><br />';
	html += '    <label class="module-row-label"><?php echo $entry_sort_order; ?> <input class="span1" class="module-row-input-number" type="number" name="similarproducts_module[' + module_row + '][sort_order]" value="0" /></label>';
	html += '    </td>';
	html += '    <td class="left">';
	html += '<div class="buttonPositionOpenCart" style="float:left; padding-right:10px; text-align:center;"><div class="leftBoxInput"><input checked="checked" type="radio" style="width:auto" name="similarproducts_module[' + module_row + '][position]" id="buttonPos' + module_row + '_1" class="buttonPositionOptionBox" data-checkbox="#buttonPosCheckbox_' + module_row + '" value="content_top" /></div><div class="leftBoxTitle posTitleLabel"><label for="buttonPos1"><?php echo $text_content_top; ?></label></div><div class="positionSampleBox"><label for="buttonPos' + module_row + '_1"><img class="img-polaroid" src="view/image/similarproducts/content_top.png" title="<?php echo $text_content_top; ?>" border="0" /></label></div></div>';
	html += '<div class="buttonPositionOpenCart" style="float:left; padding-right:10px; text-align:center;"><div class="leftBoxInput"><input type="radio" style="width:auto" name="similarproducts_module[' + module_row + '][position]" id="buttonPos' + module_row + '_2" class="buttonPositionOptionBox" data-checkbox="#buttonPosCheckbox_' + module_row + '" value="content_bottom" /></div><div class="leftBoxTitle posTitleLabel"><label for="buttonPos2"><?php echo $text_content_bottom; ?></label></div><div class="positionSampleBox"><label for="buttonPos' + module_row + '_2"><img class="img-polaroid" src="view/image/similarproducts/content_bottom.png" title="<?php echo $text_content_bottom; ?>" border="0" /></label></div></div>';
	html += '<div class="buttonPositionOpenCart" style="float:left; padding-right:10px; text-align:center;"><div class="leftBoxInput"><input type="radio" style="width:auto" name="similarproducts_module[' + module_row + '][position]" id="buttonPos' + module_row + '_3" class="buttonPositionOptionBox" data-checkbox="#buttonPosCheckbox_' + module_row + '" value="column_left" /></div><div class="leftBoxTitle posTitleLabel"><label for="buttonPos3"><?php echo $text_column_left; ?></label></div><div class="positionSampleBox"><label for="buttonPos' + module_row + '_3"><img class="img-polaroid" src="view/image/similarproducts/column_left.png" title="<?php echo $text_column_left; ?>" border="0" /></label></div></div>';
	html += '<div class="buttonPositionOpenCart last" style="float:left; padding-right:10px; text-align:center;"><div class="leftBoxInput"><input type="radio" style="width:auto" name="similarproducts_module[' + module_row + '][position]" id="buttonPos' + module_row + '_4" class="buttonPositionOptionBox" data-checkbox="#buttonPosCheckbox_' + module_row + '" value="column_right" /></div><div class="leftBoxTitle posTitleLabel"><label for="buttonPos4"><?php echo $text_column_right; ?></label></div><div class="positionSampleBox"><label for="buttonPos' + module_row + '_4"><img class="img-polaroid" src="view/image/similarproducts/column_right.png" title="<?php echo $text_column_right; ?>" border="0" /></label></div></div>';
	html += '    </td>';
	html += '    <td class="left" style="vertical-align:middle;"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-small btn-danger" style="text-decoration:none;"><i class="icon-remove"></i> <?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	$('#module-row' + module_row).fadeIn();
	
	createBinds();
	
	module_row++;
}
//--></script>
     </td>
  </tr>
</table>
<script>
$('.SimilarProductsLayout input[type=checkbox]').change(function() {
    if ($(this).is(':checked')) { 
        $('.SimilarProductsItemStatusField', $(this).parent()).val(1);
    } else {
        $('.SimilarProductsItemStatusField', $(this).parent()).val(0);
    }
});
$('.SimilarProductsEnabled').change(function() {
    toggleSimilarProductsActive(true);
});
var toggleSimilarProductsActive = function(animated) {
   if ($('.SimilarProductsEnabled').val() == 'yes') {
        if (animated) 
            $('.SimilarProductsActiveTR').fadeIn();
        else 
            $('.SimilarProductsActiveTR').show();
    } else {
        if (animated) 
            $('.SimilarProductsActiveTR').fadeOut();
        else 
            $('.SimilarProductsActiveTR').hide();
    }
}
toggleSimilarProductsActive(false);
</script>
