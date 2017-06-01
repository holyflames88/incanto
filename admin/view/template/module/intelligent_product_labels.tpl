<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
     
      <!--/*<?php '<pre>'. print_r($labels, true).'</pre>';?>*/-->
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="vtabs">
          <div id="preview" class="image">Preview</div>
          
          <?php $label_row = 1; ?>
          
          <?php foreach ($labels as $label) { ?>
         
          <a href="#tab-label-<?php echo $label_row; ?>" id="label-<?php echo $label_row; ?>">
            <div id="label-info-<?php echo $label_row;?>" class="label_info">
              <div id="info-type-<?php echo $label_row; ?>"><?php echo $types[$label['type']]; ?></div>
              <div id="info-style-<?php echo $label_row; ?>"><?php echo $styles[$label['style']]; ?></div>
              <div id="info-position-<?php echo $label_row; ?>"><?php echo $positions[$label['position']]; ?></div>
            </div>
            <?php echo $tab_label . ' ' . $label_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#label-<?php echo $label_row; ?>').remove(); $('#tab-label-<?php echo $label_row; ?>').remove(); return false;" />
          </a>
          
          <?php $label_row++; ?>
         
          <?php } ?>
          <span id="label-add"><?php echo $button_add_label; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addLabel();" /></span> </div>
        
        <?php $label_row = 1; ?>
        
        <?php foreach ($labels as $label) { ?>
        <div id="tab-label-<?php echo $label_row; ?>" class="vtabs-content">
          
          <!-- we simulate this is a module, but we don't want this module be a module --> 
          <input type="hidden" name="intelligent_product_labels_module[<?php echo $label_row; ?>][layout_id]" value="9999999">
          <!-- end simulation :) -->
          
          <table class="form">

              <!-- type / apply to -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_type; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][type]" id="select_type_ipl-<?php echo $label_row; ?>">
                    <?php if (!empty($types)){ ?>
                      <?php foreach ($types as $key => $type) { ?>
                          <?php ($key == $label['type']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $type;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- only out of stock -->

              <tr id="row_only_out_of_stock_ipl-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_only_out_of_stock; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][only_out_of_stock]">
                      <?php if ($label['only_out_of_stock']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- limit bestsellers -->

              <tr id="row_limit_bestseller_ipl-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_limit_bestseller; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][limit_bestseller]">
                    <?php if (!empty($limits_bestseller)){ ?>
                      <?php foreach ($limits_bestseller as $key => $limit_bestseller) { ?>
                          <?php ($key == $label['limit_bestseller']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $limit_bestseller;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- period -->

              <tr id="row_period_ipl-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_period; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][period]">
                    <?php if (!empty($periods)){ ?>
                      <?php foreach ($periods as $key => $period) { ?>
                          <?php ($key == $label['period']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $period;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- manual products -->

              <tr class="search-product-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_product; ?></span>
                </td>
                <td>
                  <input type="text" name="product" value="" id="entry_product-<?php echo $label_row; ?>" />
                </td>
              </tr>
              <tr class="search-product-<?php echo $label_row; ?>">
                <td>&nbsp;</td>
                <td><div id="manual-product-<?php echo $label_row; ?>" class="scrollbox">
                    <?php $class = 'odd'; ?>
                    <?php if (isset($products[$label_row])) { ?>
                      <?php foreach ($products[$label_row] as $product) { ?>
                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                        <div id="manual-product-<?php echo $label_row.'-'.$product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $product['name']; ?> <img src="view/image/delete.png" alt="" />
                          <input type="hidden" value="<?php echo $product['product_id']; ?>" />
                        </div>
                      <?php } ?>
                    <?php } ?>
                  </div>

                  <input type="hidden" 
                         name="intelligent_product_labels_module[<?php echo $label_row; ?>][manual_products]" 
                         value="<?php echo isset($label['manual_products']) ? $label['manual_products'] : '' ; ?>" />
                </td>
              </tr>

              <!-- manual categories -->

              <tr class="search-category-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $entry_category; ?></span>
                </td>
                <td>
                  <input type="text" name="category" value="" id="entry_category-<?php echo $label_row; ?>" />
                </td>
              </tr>
              <tr class="search-category-<?php echo $label_row; ?>">
                <td>&nbsp;</td>
                <td><div id="manual-category-<?php echo $label_row; ?>" class="scrollbox">
                    <?php $class = 'odd'; ?>
                    <?php if (isset($categories[$label_row])) { ?>
                      <?php foreach ($categories[$label_row] as $category) { ?>
                        <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                        <div id="manual-category-<?php echo $label_row.'-'.$category['category_id']; ?>" class="<?php echo $class; ?>"><?php echo $category['name']; ?> <img src="view/image/delete.png" alt="" />
                          <input type="hidden" value="<?php echo $category['category_id']; ?>" />
                        </div>
                      <?php } ?>
                    <?php } ?>
                  </div>

                  <input type="hidden" 
                         name="intelligent_product_labels_module[<?php echo $label_row; ?>][manual_categories]" 
                         value="<?php echo isset($label['manual_categories']) ? $label['manual_categories'] : '' ; ?>" />
                </td>
              </tr>

              <!-- regex -->

              <tr class="regex-selection-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo ""; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][regex][product_property]" id="select_regex_ipl-<?php echo $label_row; ?>">
                    <?php if (!empty($product_properties)){ ?>
                      <?php foreach ($product_properties as $key => $product_property) { ?>
                          <?php ($key == $label['regex']['product_property']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $product_property;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                  <span> match </span>
                  <input type="text" 
                         name="intelligent_product_labels_module[<?php echo $label_row; ?>][regex][value]" 
                         onkeydown = "this.style.color = '#000000';" 
                         onclick = "if (this.value == 'Regular Expression') { this.value = ''; }" 
                         class="trigger_regex" 
                         value="<?php echo !empty($label['regex']['value']) ? $label['regex']['value'] : 'Regular Expression' ; ?>" />
                </td>
              </tr>              

              <!-- style -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_style; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][style]" id="select_style_ipl-<?php echo $label_row; ?>">
                    <?php if (!empty($styles)){ ?>
                      <?php foreach ($styles as $key => $style) { ?>
                          <?php ($key == $label['style']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $style;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                  <div id="style_slider-<?php echo $label_row; ?>" title="zoom"></div>
                  <span id="slider_value-<?php echo $label_row; ?>" class="slider_value">
                      <?php echo isset($label['style_round_size']) ? str_replace('em', '', $label['style_round_size']) : '1.6';?>
                  </span>
                  <input 
                  type="hidden" 
                  id="style_round_size-<?php echo $label_row; ?>" 
                  name="intelligent_product_labels_module[<?php echo $label_row; ?>][style_round_size]" 
                  value="<?php echo isset($label['style_round_size']) ? $label['style_round_size'] : '1.6em';?>" />
                </td>
              </tr>

              <!-- position -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_position; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][position]" id="select_position_ipl-<?php echo $label_row; ?>">
                    <?php if (!empty($positions)){ ?>
                      <?php foreach ($positions as $key => $position) { ?>
                          <?php ($key == $label['position']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $position;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- offset -->

              <tr class="offset-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_offsetx; ?></span>
                </td>
                <td>
                  <input type="text" name="intelligent_product_labels_module[<?php echo $label_row; ?>][offsetx]" 
                                     value="<?php echo isset($label['offsetx']) ? $label['offsetx'] : '' ;?>" 
                                     size="5" 
                                     id="entry_offsetx-<?php echo $label_row; ?>" /> %
                </td>
              </tr>
              <tr class="offset-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_offsety; ?></span>
                </td>
                <td>
                  <input type="text" name="intelligent_product_labels_module[<?php echo $label_row; ?>][offsety]" 
                                     value="<?php echo isset($label['offsety']) ? $label['offsety'] : '' ;?>" 
                                     size="5" 
                                     id="entry_offsety-<?php echo $label_row; ?>" /> %
                </td>
              </tr>

              <!-- dimensions -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_dimension; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][dimension]" id="select_dimension_ipl-<?php echo $label_row; ?>">
                    <?php if (!empty($dimensions)){ ?>
                      <?php foreach ($dimensions as $key => $dimension) { ?>
                          <?php ($key == $label['dimension']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $dimension;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- width / height -->

              <tr class="dimensions-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_width; ?></span>
                </td>
                <td>
                  <input type="text" name="intelligent_product_labels_module[<?php echo $label_row; ?>][width]" 
                                     value="<?php echo isset($label['width']) ? $label['width'] : '' ;?>" 
                                     size="3" 
                                     id="entry_width-<?php echo $label_row; ?>" /> px
                </td>
              </tr>
              <tr class="dimensions-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_height; ?></span>
                </td>
                <td>
                  <input type="text" name="intelligent_product_labels_module[<?php echo $label_row; ?>][height]" 
                                     value="<?php echo isset($label['height']) ? $label['height'] : '' ;?>" 
                                     size="3" 
                                     class="trigger_dimensions_round" 
                                     id="entry_height-<?php echo $label_row; ?>" /> px
                </td>
              </tr>

              <!-- font size -->

              <tr id="row_font_size_ipl-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_font_size; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][font_size]" id="select_font_size_ipl-<?php echo $label_row; ?>">
                    <?php if (!empty($font_sizes)){ ?>
                      <?php foreach ($font_sizes as $key => $font_size) { ?>
                          <?php ($key == $label['font_size']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $font_size;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- title -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_title; ?></span>
                </td>
                <td>
                <?php foreach ($languages as $language) { ?>
                <input type="text" name="intelligent_product_labels_module[<?php echo $label_row; ?>][title][<?php echo $language['language_id'];?>]" 
                                   value="<?php echo isset($label['title'][$language['language_id']]) ? $label['title'][$language['language_id']] : '' ;?>" 
                                   size="15" 
                                   class="trigger" />
                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                <?php } ?>
               </td>
              </tr>

              <!-- subtitle -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_subtitle; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][subtitle][status]" id="select_subtitle_ipl-<?php echo $label_row; ?>">
                      <?php if ($label['subtitle']['status']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                  </select>
                </td>
              </tr>
              <tr id="subtitle-<?php echo $label_row; ?>">
                <td>&nbsp;</td>
                <td>
                <?php foreach ($languages as $language) { ?>
                <input type="text" name="intelligent_product_labels_module[<?php echo $label_row; ?>][subtitle][<?php echo $language['language_id'];?>]" 
                                   value="<?php echo isset($label['subtitle'][$language['language_id']]) ? $label['subtitle'][$language['language_id']] : '' ;?>" 
                                   size="15" />
                <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
                <?php } ?>
                <br /><br />
                              <!-- subtitle x -->
                              X <input type="text" 
                                      name="intelligent_product_labels_module[<?php echo $label_row; ?>][subtitlex]" 
                                      value="<?php echo isset($label['subtitlex']) ? $label['subtitlex'] : '0' ;?>" 
                                      size="2" 
                                      id="entry_subtitlex-<?php echo $label_row; ?>" 
                                      title="%" /> %

                              <!-- subtitle y -->
                              &nbsp; Y <input type="text" 
                                              name="intelligent_product_labels_module[<?php echo $label_row; ?>][subtitley]" 
                                              value="<?php echo isset($label['subtitley']) ? $label['subtitley'] : '0' ;?>" 
                                              size="2" 
                                              id="entry_subtitley-<?php echo $label_row; ?>" 
                                              title="%" /> %

                              <!-- subtitle size -->
              
                              &nbsp; <?php echo $entry_font_size; ?>
                              <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][subtitle_size]" id="select_subtitle_size_ipl-<?php echo $label_row; ?>">
                                <?php if (!empty($subtitle_sizes)){ ?>
                                  <?php foreach ($subtitle_sizes as $key => $subtitle_size) { ?>
                                      <?php ($key == $label['subtitle_size']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                                      <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $subtitle_size;?></option>
                                  <?php } ?>
                                <?php } ?>
                              </select>

                              <!-- subtitle color -->

                              &nbsp;<?php echo $entry_color; ?> 
                              <input type="text" 
                                     name="intelligent_product_labels_module[<?php echo $label_row; ?>][subtitle_color]" 
                                     value="<?php echo isset($label['subtitle_color']) ? $label['subtitle_color'] : '' ;?>" 
                                     size="7" 
                                     class="color {pickerPosition:'right', hash:true, required:false}" 
                                     id="input_subtitle_color-<?php echo $label_row; ?>"/>

               </td>
              </tr>

              <!-- bold -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_bold; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][bold]">
                      <?php if ($label['bold'] == 'bold') { ?>
                      <option value="bold" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="normal"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="bold"><?php echo $text_enabled; ?></option>
                      <option value="normal" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- colors -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_background_color; ?></span>
                </td>
                <td>
                  <input type="text" name="intelligent_product_labels_module[<?php echo $label_row; ?>][background]" 
                                     value="<?php echo isset($label['background']) ? $label['background'] : '#10324D' ;?>" 
                                     size="7" 
                                     class="color {pickerPosition:'right', hash:true, required:false}" 
                                     id="color_background-<?php echo $label_row; ?>" />&nbsp;<a onclick="document.getElementById('color_background-<?php echo $label_row; ?>').color.fromString('FFFFFF');$('#color_background-<?php echo $label_row; ?>').attr('value','');$('#label-preview').css('background-color','');"><?php echo $text_clear; ?></a>
                </td>
              </tr>
              <tr id="row_foreground_ipl-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_foreground_color; ?></span>
                </td>
                <td>
                  <input type="text" name="intelligent_product_labels_module[<?php echo $label_row; ?>][foreground]" 
                                     value="<?php echo isset($label['foreground']) ? $label['foreground'] : '#F8F8F8' ;?>" 
                                     size="7"
                                     class="color {pickerPosition:'right', hash:true}" 
                                     id="color_foreground-<?php echo $label_row; ?>"/>
                </td>
              </tr>

              <!-- border -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_border; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][border]" id="select_border_ipl-<?php echo $label_row; ?>">
                      <?php if ($label['border']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                  </select>
                </td>
              </tr>
              <tr id="border-<?php echo $label_row; ?>">
                <td>&nbsp;</td>
                <td>
                    <input type="text" 
                           name="intelligent_product_labels_module[<?php echo $label_row; ?>][border]" 
                           value="<?php echo isset($label['border']) ? $label['border'] : '' ;?>" 
                           size="7" 
                           class="color {pickerPosition:'right', hash:true, required:false}" 
                           id="input_border-<?php echo $label_row; ?>"/>
                </td>
              </tr>

              <!-- opacity -->

              <tr id="row_opacity_ipl-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl"><?php echo $entry_opacity; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][opacity]">
                    <?php if (!empty($opacitys)){ ?>
                      <?php foreach ($opacitys as $key => $opacity) { ?>
                          <?php ($key == $label['opacity']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $opacity;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- shadow -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_shadow; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][shadow]">
                      <?php if ($label['shadow']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                  </select>
                </td>
              </tr>
              
              <!-- Image -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_image; ?></span>
                </td>
                <td>
                  <div class="image"><img src="<?php echo $thumbs[$label_row]; ?>" alt="" id="thumb-<?php echo $label_row; ?>" /><br />
                    <input type="hidden" name="intelligent_product_labels_module[<?php echo $label_row; ?>][image]" value="<?php echo $label['image']; ?>" id="image-<?php echo $label_row; ?>" />
                    <a onclick="image_upload('image-<?php echo $label_row; ?>', 'thumb-<?php echo $label_row; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('#thumb-<?php echo $label_row; ?>').attr('src', ''); $('#image-<?php echo $label_row; ?>').attr('value', '');$('#label-preview').css('background-image','none');"><?php echo $text_clear; ?></a>
                  </div>
                  <br /><br />
                  <?php if (isset($label['image_autoresize'])) { ?>
                        <input type="checkbox" name="intelligent_product_labels_module[<?php echo $label_row; ?>][image_autoresize]" checked="checked" value="on" /> 
                  <?php } else { ?>
                        <input type="checkbox" name="intelligent_product_labels_module[<?php echo $label_row; ?>][image_autoresize]" /> 
                  <?php } ?>
                  Auto resize
                </td>
              </tr>

              <!-- show in product layout -->

               <tr>
                 <td>
                   <span class="property_name_ipl"><?php echo $entry_show_in_product; ?></span>
                 </td>
                 <td>
                   <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][show_in_product]">
                       <?php if ($label['show_in_product']) { ?>
                       <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                       <option value="0"><?php echo $text_disabled; ?></option>
                       <?php } else { ?>
                       <option value="1"><?php echo $text_enabled; ?></option>
                       <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                       <?php } ?>
                   </select>
                 </td>

               </tr>

               <!-- limit categories -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_limitcategories; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][limitcategories]" id="select_limitcategories_ipl-<?php echo $label_row; ?>">
                      <?php if ($label['limitcategories']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                  </select>
                </td>
              </tr>
              <tr class="search-limitcategories-<?php echo $label_row; ?>">
                <td>
                  <span class="property_name_ipl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $entry_category; ?></span>
                </td>
                <td>
                  <input type="text" name="limitcategories" value="" id="entry_limitcategories-<?php echo $label_row; ?>" />
                </td>
              </tr>
              <tr class="search-limitcategories-<?php echo $label_row; ?>">
               <td>&nbsp;</td>
                 <td><div id="limitcategories-<?php echo $label_row; ?>" class="scrollbox">
                   <?php $class = 'odd'; ?>
                   <?php if (isset($limitcategories[$label_row])) { ?>
                     <?php foreach ($limitcategories[$label_row] as $category) { ?>
                       <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                       <div id="limitcategories-<?php echo $label_row.'-'.$category['category_id']; ?>" class="<?php echo $class; ?>"><?php echo $category['name']; ?> <img src="view/image/delete.png" alt="" />
                         <input type="hidden" value="<?php echo $category['category_id']; ?>" />
                       </div>
                     <?php } ?>
                   <?php } ?>
                 </div>

                 <input type="hidden" 
                        name="intelligent_product_labels_module[<?php echo $label_row; ?>][limitcategories]" 
                        value="<?php echo isset($label['limitcategories']) ? $label['limitcategories'] : '' ; ?>" />
                 </td>
               </tr>

               <!-- don't show in module -->

               <tr>
                 <td>
                   <span class="property_name_ipl"><?php echo $entry_show_in; ?></span>
                 </td>
                 <td>
                   <select multiple name="intelligent_product_labels_module[<?php echo $label_row; ?>][show_in][]" id="select_show_in_ipl-<?php echo $label_row; ?>">
                     <?php if (!empty($show_in)){ ?>
                       <?php foreach ($show_in as $key => $layout) { ?>
                           <?php in_array($key, $label['show_in']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                           <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $layout;?></option>
                       <?php } ?>
                     <?php } ?>
                   </select>
                 </td>
               </tr>

               <!-- show in layout position -->

               <tr>
                 <td>
                   <span class="property_name_ipl"><?php echo $entry_layout_position; ?></span>
                 </td>
                 <td>
                   <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][layout_position]">
                       <?php if ( !isset($label['layout_position']) || $label['layout_position']=='all' ) { ?>
                           <option value="all" selected="selected"><?php echo $text_all; ?></option>
                       <?php } else { ?>
                           <option value="all"><?php echo $text_all; ?></option>
                       <?php } ?>
                       <?php foreach ($layout_positions as $key => $layout_position) { ?>
                           <?php ($key == $label['layout_position']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                           <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $layout_position;?></option>
                       <?php } ?>
                   </select>
                 </td>
               </tr>

              <!-- start / end dates -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_start_date; ?></span>
                </td>
                <td>
                  <input type="text" 
                         name="intelligent_product_labels_module[<?php echo $label_row; ?>][date-start]" 
                         value="<?php echo isset($label['date-start']) ? $label['date-start'] : '' ;?>" 
                         id="date-start-<?php echo $label_row; ?>" 
                         size="9" 
                         class="date"/>
                </td>
              </tr>
              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_end_date; ?></span>
                </td>
                <td>
                  <input type="text" 
                         name="intelligent_product_labels_module[<?php echo $label_row; ?>][date-end]" 
                         value="<?php echo isset($label['date-end']) ? $label['date-end'] : '' ;?>" 
                         id="date-end-<?php echo $label_row; ?>" 
                         size="9" 
                         class="date"/>
                </td>
              </tr>

              <!-- priority -->
              
              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_priority; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][priority]" id="priority-<?php echo $label_row; ?>">
                    <?php if (!empty($priorities)){ ?>
                      <?php foreach ($priorities as $key => $priority) { ?>
                          <?php ($key == $label['priority']) ? $selected = " selected=\"selected\"" : $selected="" ;?>
                          <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $priority;?></option>
                      <?php } ?>
                    <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- Hide when Lower Priority -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_hide_when_lower_priority; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][hide_when_lower_priority]">
                      <?php if ($label['hide_when_lower_priority']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                  </select>
                </td>
              </tr>

              <!-- custom css -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_custom_css; ?></span>
                </td>
                <td>
                  <input type="text" 
                         name="intelligent_product_labels_module[<?php echo $label_row; ?>][custom_css]" 
                         value="<?php echo isset($label['custom_css']) ? $label['custom_css'] : '' ;?>" 
                         size="45" />
                  <button id="btn_update_custom_css-<?php echo $label_row; ?>" type="button"><?php echo $button_update; ?></button>
               </td>
              </tr>

              <!-- status -->

              <tr>
                <td>
                  <span class="property_name_ipl"><?php echo $entry_status; ?></span>
                </td>
                <td>
                  <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][status]" id="select_status_ipl-<?php echo $label_row; ?>">
                      <?php if ($label['status']) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                  </select>
                </td>
              </tr>

          </table>
        </div>
        <?php $label_row++; ?>
        <?php } ?>
      </form>
    </div>
  </div>
  <div class="tooltip" id="tooltip"></div>
</div>

<script type="text/javascript"><!--

// functions

function addLabel() 
{
  html  = '<div id="tab-label-' + label_row + '" class="vtabs-content">';
  html += '  <input type="hidden" name="intelligent_product_labels_module[' + label_row + '][layout_id]" value="9999999">';
  html += '  <table class="form">';
  //            Type / Apply to
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_type; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][type]" id="select_type_ipl-' + label_row + '">';
                      <?php if (!empty($types)){ ?>
                        <?php foreach ($types as $key => $type) { ?>
  html += '               <option value="<?php echo $key; ?>"><?php echo $type;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Only out of stock
  html += '     <tr id="row_only_out_of_stock_ipl-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_only_out_of_stock; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][only_out_of_stock]">'
  html += '               <option value="1"><?php echo $text_enabled; ?></option>';
  html += '               <option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';  
  //            Limit Bestseller
  html += '     <tr id="row_limit_bestseller_ipl-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_limit_bestseller; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][limit_bestseller]">';
                      <?php if (!empty($limits_bestseller)){ ?>
                        <?php foreach ($limits_bestseller as $key => $limit_bestseller) { ?>
                           <?php if ($key == '10') { ?>
  html += '                 <option value="<?php echo $key; ?>" selected=\'selected\'><?php echo $limit_bestseller;?></option>';
                           <?php } else { ?>
  html += '                 <option value="<?php echo $key; ?>"><?php echo $limit_bestseller;?></option>';
                           <?php } ?>
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Period
  html += '     <tr id="row_period_ipl-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_period; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][period]">';
                      <?php if (!empty($periods)){ ?>
                        <?php foreach ($periods as $key => $period) { ?>
  html += '               <option value="<?php echo $key; ?>"><?php echo $period;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Manual Products
  html += '     <tr class="search-product-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_product; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <input type="text" name="product" value="" id="entry_product-' + label_row + '" />';
  html += '       </td>';
  html += '     </tr>';
  html += '     <tr class="search-product-' + label_row + '">';
  html += '       <td>&nbsp;</td>';
  html += '       <td>';
  html += '         <div id="manual-product-' + label_row + '" class="scrollbox"></div>';
  html += '         <input type="hidden" name="intelligent_product_labels_module[' + label_row + '][manual_products]" value="" />';
  html += '       </td>';
  html += '     </tr>';
  //            Manual Categories
  html += '     <tr class="search-category-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<?php echo $entry_category; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <input type="text" name="category" value="" id="entry_category-' + label_row + '" />';
  html += '       </td>';
  html += '     </tr>';
  html += '     <tr class="search-category-' + label_row + '">';
  html += '       <td>&nbsp;</td>';
  html += '       <td>';
  html += '         <div id="manual-category-' + label_row + '" class="scrollbox"></div>';
  html += '         <input type="hidden" name="intelligent_product_labels_module[' + label_row + '][manual_categories]" value="" />';
  html += '       </td>';
  html += '     </tr>';
  //            Regex Product Selection
  html += '     <tr class="regex-selection-' + label_row + '">';
  html += '     <td>';
  html += '      <span class="property_name_ipl"></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][regex][product_property]" id="select_regex_ipl-' + label_row + '">';
                        <?php foreach ($product_properties as $key => $product_property) { ?>
  html += '                 <option value="<?php echo $key; ?>"><?php echo $product_property;?></option>';
                        <?php } ?>
  html += '         </select>';
  html += '         <span> match </span>';
  html += '         <input type="text" \
                           name="intelligent_product_labels_module[' + label_row + '][regex][value]" \
                           onkeydown = "this.style.color = \'#000000\';" \
                           onclick = "if (this.value == \'Regular Expression\') { this.value = \'\'; }" \
                           class= "trigger_regex" \
                           value= "Regular Expression" />';
  html += '       </td>';
  html += '     </tr>';
  //            Style
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_style; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][style]" id="select_style_ipl-' + label_row + '">';
                      <?php if (!empty($styles)){ ?>
                        <?php foreach ($styles as $key => $style) { ?>
  html += '               <option value="<?php echo $key; ?>"><?php echo $style;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  
  html += '         <div id="style_slider-' + label_row + '" title="zoom"></div>';
  html += '         <span id="slider_value-' + label_row + '" class="slider_value">1.6</span>';
  html += '         <input \
                     type="hidden" \
                     id="style_round_size-' + label_row + '" \
                     name="intelligent_product_labels_module[' + label_row + '][style_round_size]" \
                     value="1.6em" />';
  html += '       </td>';
  html += '     </tr>';
  //            Position
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_position; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][position]" id="select_position_ipl-' + label_row + '">';
                      <?php if (!empty($positions)){ ?>
                        <?php foreach ($positions as $key => $position) { ?>
  html += '               <option value="<?php echo $key; ?>"><?php echo $position;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Offset
  html += '     <tr class="offset-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_offsetx; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <input type="text" name="intelligent_product_labels_module[' + label_row + '][offsetx]" value="" size="5" id="entry_offsetx-' + label_row + '" /> %';
  html += '       </td>';
  html += '     </tr>';
  html += '     <tr class="offset-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_offsety; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <input type="text" name="intelligent_product_labels_module[' + label_row + '][offsety]" value="" size="5" id="entry_offsety-' + label_row + '" /> %';
  html += '       </td>';
  html += '     </tr>';
  //            Dimensions
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_dimension; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][dimension]" id="select_dimension_ipl-' + label_row + '">';
                      <?php if (!empty($dimensions)){ ?>
                        <?php foreach ($dimensions as $key => $dimension) { ?>
  html += '               <option value="<?php echo $key; ?>"><?php echo $dimension;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Width / Height
  html += '     <tr class="dimensions-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_width; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <input type="text" name="intelligent_product_labels_module[' + label_row + '][width]" value="" size="3" id="entry_width-' + label_row + '" /> px';
  html += '       </td>';
  html += '     </tr>';
  html += '     <tr class="dimensions-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_height; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <input type="text" name="intelligent_product_labels_module[' + label_row + '][height]" value="" size="3" class="trigger_dimensions_round" id="entry_height-' + label_row + '" /> px';
  html += '       </td>';
  html += '     </tr>';
  //            Font Size
  html += '     <tr id="row_font_size_ipl-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_font_size; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][font_size]" id="select_font_size_ipl-' + label_row + '">';
                      <?php if (!empty($font_sizes)){ ?>
                        <?php foreach ($font_sizes as $key => $font_size) { ?>
                          <?php ($key == '1em') ? $selected = " selected=\"selected\"" : $selected="" ;?>
  html += '               <option value="<?php echo $key; ?>" <?php echo $selected;?>><?php echo $font_size;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Title
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_title; ?></span>';
  html += '       </td>';
  html += '       <td>';
                    <?php foreach ($languages as $language) { ?>
  html += '           <input type="text" name="intelligent_product_labels_module[' + label_row + '][title][<?php echo $language["language_id"];?>]" value="" size="15" class="trigger" />';
  html += '           <img src="view/image/flags/<?php echo $language["image"]; ?>" title="<?php echo $language["name"]; ?>" />';
                    <?php } ?>
  html += '       </td>';
  html += '     </tr>';
  //            Subtitle
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_subtitle; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][subtitle][status]" id="select_subtitle_ipl-' + label_row + '">'
  html += '               <option value="1"><?php echo $text_enabled; ?></option>';
  html += '               <option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';  
  html += '     <tr id="subtitle-' + label_row + '">';
  html += '       <td>&nbsp;</td>';
  html += '       <td>';
                    <?php foreach ($languages as $language) { ?>
  html += '           <input type="text" name="intelligent_product_labels_module['+label_row+'][subtitle][<?php echo $language["language_id"];?>]" value="" size="15" />';
  html += '           <img src="view/image/flags/<?php echo $language["image"]; ?>" title="<?php echo $language["name"]; ?>" />';
                    <?php } ?>
  html += '         <br /><br />';
  html += '         X <input type="text" name="intelligent_product_labels_module['+label_row+'][subtitlex]" value="0" size="2" id="entry_subtitlex-' + label_row + '" title="%" /> %';
  html += '         &nbsp; Y <input type="text" name="intelligent_product_labels_module['+label_row+'][subtitley]" value="0" size="2" id="entry_subtitley-' + label_row + '" title="%" /> %';
  html += '         &nbsp; <?php echo $entry_font_size; ?>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][subtitle_size]" id="select_subtitle_size_ipl-' + label_row + '">';
                      <?php if (!empty($subtitle_sizes)){ ?>
                        <?php foreach ($subtitle_sizes as $key => $subtitle_size) { ?>
  html += '               <option value="<?php echo $key; ?>"><?php echo $subtitle_size;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '         &nbsp;<?php echo $entry_color; ?> <input type="text" name="intelligent_product_labels_module[' + label_row + '][subtitle_color]" value="" size="7" class="color {pickerPosition:\'right\', hash:true, required:false}" id="input_subtitle_color-' + label_row + '" />';
  html += '       </td>';
  html += '     </tr>';
  //            Bold
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_bold; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][bold]">'
  html += '               <option value="bold"><?php echo $text_enabled; ?></option>';
  html += '               <option value="normal" selected="selected"><?php echo $text_disabled; ?></option>';
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Colors
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_background_color; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <input type="text" name="intelligent_product_labels_module[' + label_row + '][background]" value="" size="7" class="color {pickerPosition:\'right\', hash:true, required:false}" id="color_background-' + label_row + '" />&nbsp;<a onclick="$(\'#color_background-' + label_row + '\').css(\'background-color\',\'\');$(\'#color_background-' + label_row + '\').attr(\'value\',\'\');$(\'#label-preview\').css(\'background-color\',\'\');"><?php echo $text_clear; ?></a>';
  html += '       </td>';
  html += '     </tr>';
  html += '     <tr id="row_foreground_ipl-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_foreground_color; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <input type="text" name="intelligent_product_labels_module[' + label_row + '][foreground]" value="" size="7" class="color {pickerPosition:\'right\', hash:true}" id="color_foreground-' + label_row + '" />';
  html += '       </td>';
  html += '     </tr>';
  //            Border
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_border; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][border]" id="select_border_ipl-' + label_row + '">'
  html += '               <option value="1"><?php echo $text_enabled; ?></option>';
  html += '               <option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';  
  html += '     <tr id="border-' + label_row + '">';
  html += '       <td>&nbsp;</td>';  
  html += '       <td>';
  html += '         <input type="text" name="intelligent_product_labels_module[' + label_row + '][border]" value="" size="7" class="color {pickerPosition:\'right\', hash:true, required:false}" id="input_border-' + label_row + '" />';
  html += '       </td>';
  html += '     </tr>';
  //            Opacity
  html += '     <tr id="row_opacity_ipl-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_opacity; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][opacity]">';
                      <?php if (!empty($opacitys)){ ?>
                        <?php foreach ($opacitys as $key => $opacity) { ?>
  html += '               <option value="<?php echo $key; ?>"><?php echo $opacity;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';  
  //            Shadow
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_shadow; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][shadow]">'
  html += '               <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
  html += '               <option value="0"><?php echo $text_disabled; ?></option>';
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Image
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_image; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <div class="image"><img src="<?php echo $dirimage; ?>blank.jpg" alt="" id="thumb-' + label_row + '" /><br />';
  html += '           <input type="hidden" name="intelligent_product_labels_module[' + label_row + '][image]" value="" id="image-' + label_row + '" />';
  html += '           <a onclick="image_upload(\'image-' + label_row + '\', \'thumb-' + label_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb-' + label_row + '\').attr(\'src\', \'\'); $(\'#image-' + label_row + '\').attr(\'value\', \'\');$(\'#label-preview\').css(\'background-image\',\'none\');"><?php echo $text_clear; ?></a>';
  html += '         </div>';
  html += '         <br /><br />';
  html += '         <input type="checkbox" name="intelligent_product_labels_module[<?php echo $label_row; ?>][image_autoresize]" value="off" /> Auto resize';
  html += '       </td>';
  html += '     </tr>';
  //            Show in product layout
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_show_in_product; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][show_in_product]">'
  html += '               <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
  html += '               <option value="0"><?php echo $text_disabled; ?></option>';
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            limit categories
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_limitcategories; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[<?php echo $label_row; ?>][limitcategories]" id="select_limitcategories_ipl-' + label_row + '">';
  html += '           <option value="1"><?php echo $text_enabled; ?></option>';
  html += '           <option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  html += '     <tr class="search-limitcategories-' + label_row + '">';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_category; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '          <input type="text" name="limitcategories" value="" id="entry_limitcategories-' + label_row + '" />';
  html += '       </td>';
  html += '     </tr>';
  html += '     <tr class="search-limitcategories-' + label_row + '">';
  html += '       <td>&nbsp;</td>';
  html += '       <td><div id="limitcategories-' + label_row + '" class="scrollbox"></div>';
  html += '         <input type="hidden" name="intelligent_product_labels_module[' + label_row + '][limitcategories]" value="" />';
  html += '       </td>';
  html += '     </tr>';
  //           Show in
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_show_in; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][show_in][]" id="select_show_in_ipl-' + label_row + '" multiple>';
                      <?php if (!empty($show_in)){ ?>
                        <?php foreach ($show_in as $key => $layout) { ?>
  html += '               <option value="<?php echo $key; ?>" selected="selected"><?php echo $layout;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>'; 
  //            Layout position
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_layout_position; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][layout_position]">';
  html += '             <option value="all" selected="selected"><?php echo $text_all; ?></option>';
                        <?php foreach ($layout_positions as $key => $layout_position) { ?>
  html += '               <option value="<?php echo $key; ?>"><?php echo $layout_position;?></option>';
                        <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            start / end date
  html += '     <tr>';
  html += '       <td>';
  html += '          <span class="property_name_ipl"><?php echo $entry_start_date; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '          <input type="text" \
                         name="intelligent_product_labels_module[' + label_row + '][date-start]" \
                         value="" \
                         id="date-start-' + label_row + '" \
                         size="9" \
                         class="date"/>';
  html += '       </td>';
  html += '     </tr>';
  html += '     <tr>';
  html += '       <td>';
  html += '          <span class="property_name_ipl"><?php echo $entry_end_date; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '          <input type="text" \
                         name="intelligent_product_labels_module[' + label_row + '][date-end]" \
                         value="" \
                         id="date-end-' + label_row + '" \
                         size="9" \
                         class="date"/>';
  html += '       </td>';
  html += '     </tr>';
  //            Priority
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_priority; ?></span>';              
  html += '       </td>';                  
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][priority]">';
                      <?php if (!empty($priorities)){ ?>
                        <?php foreach ($priorities as $key => $priority) { ?>
  html += '               <option value="<?php echo $key; ?>"><?php echo $priority;?></option>';
                        <?php } ?>
                      <?php } ?>
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Hide when Lower Priority
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_hide_when_lower_priority; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][hide_when_lower_priority]">'
  html += '               <option value="1"><?php echo $text_enabled; ?></option>';
  html += '               <option value="0" selected="selected"><?php echo $text_disabled; ?></option>';
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  //            Custom CSS
  html += '     <tr>';
  html += '       <td>';
  html += '          <span class="property_name_ipl"><?php echo $entry_custom_css; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '          <input type="text" name="intelligent_product_labels_module[' + label_row + '][custom_css] value="" size="45" />';
  html += '          <button id="btn_update_custom_css"><?php echo $button_update; ?></button>';
  html += '       </td>';
  html += '     </tr>';
  //            Status
  html += '     <tr>';
  html += '       <td>';
  html += '         <span class="property_name_ipl"><?php echo $entry_status; ?></span>';
  html += '       </td>';
  html += '       <td>';
  html += '         <select name="intelligent_product_labels_module[' + label_row + '][status]" id="select_status_ipl-' + label_row + '">'
  html += '               <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
  html += '               <option value="0"><?php echo $text_disabled; ?></option>';
  html += '         </select>';
  html += '       </td>';
  html += '     </tr>';
  html += '  </table>';
  html += '</div>';

  $('#form').append(html);
  
  $('#label-add').before('<a href="#tab-label-' + label_row + '" id="label-' + label_row + '">' +
                            '<div id="label-info-' + label_row + '" class="label_info">' +
                              '<div id="info-type-' + label_row + '"><?php echo $types['featured']; ?></div>' +
                              '<div id="info-style-' + label_row + '"><?php echo $styles['horizontal']; ?></div>' +
                              '<div id="info-position-' + label_row + '"><?php echo $positions['top_left']; ?></div>' +
                            '</div>' +
                            '<?php echo $tab_label; ?> ' + label_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#label-' + label_row + '\').remove(); $(\'#tab-label-' + label_row + '\').remove(); return false;" />' +
                          '</a>');
  
  $('.vtabs a').tabs();

  HideOptionalInputs(label_row);

  $('#label-' + label_row).on('click', function() {
    SetSelectedTab();
    UpdatePreview();
  });

  $('#label-' + label_row).trigger('click');

  // set color pickers
  var myPickerBackground = new jscolor.color(document.getElementById('color_background-' + label_row), {pickerPosition:'right', hash:true});
  myPickerBackground.fromString('10324D');

  var myPickerForeground = new jscolor.color(document.getElementById('color_foreground-' + label_row), {pickerPosition:'right', hash:true});
  myPickerForeground.fromString('F8F8F8');

  var myPickerBorder = new jscolor.color(document.getElementById('input_border-' + label_row), {pickerPosition:'right', hash:true, required:false});
  myPickerBorder.fromString('');

  var myPickerSubtitleColor = new jscolor.color(document.getElementById('input_subtitle_color-' + label_row), {pickerPosition:'right', hash:true, required:false});
  myPickerSubtitleColor.fromString('');

  // title preview change
  $('input[name=\"intelligent_product_labels_module['+ label_row +'][title][<?php echo $first_language_id; ?>]\"]').attr('value','Hello');
  $('input[name=\"intelligent_product_labels_module['+ label_row +'][title][<?php echo $first_language_id; ?>]\"]').change();
  $('input[name=\"intelligent_product_labels_module['+ label_row +'][title][<?php echo $first_language_id; ?>]\"]').on('keyup',function(){
    $('#label-preview').text($(this).val());
  });

  // subtitle preview change
  $('input[name=\"intelligent_product_labels_module['+ label_row +'][subtitle][<?php echo $first_language_id; ?>]\"]').attr('value','');
  $('input[name=\"intelligent_product_labels_module['+ label_row +'][subtitle][<?php echo $first_language_id; ?>]\"]').change();
  $('input[name=\"intelligent_product_labels_module['+ label_row +'][subtitle][<?php echo $first_language_id; ?>]\"]').on('keyup',function(){
    $('#subtitle').text($(this).val());
  });

  // set events for combo changes
  ComboStatusChange(label_row);
  ComboTypeChange(label_row);
  ComboStyleChange(label_row);
  ComboPositionChange(label_row);
  ComboDimensionsChange(label_row);
  ComboBorderChange(label_row);
  ComboLimitCategoriesChange(label_row);
  ComboSubtitleChange(label_row);

  // we change info label color
  ChangeInfoLabelColor('type',label_row);
  ChangeInfoLabelColor('style',label_row);
  ChangeInfoLabelColor('position',label_row);

  // we update new manual_products info after a product deletion
  AfterProductDelete(label_row);
  AfterCategoryDelete(label_row);
  AfterLimitCategoriesDelete(label_row);

  SetAutocompleteProduct();
  SetAutocompleteCategory();
  SetAutocompleteLimitCategories();

  SetInputDates(label_row);
  SetStyleSlider(label_row);

  label_row++;
}

function SetSelectedTab()
{
  //we search for the selected tab
  $('.vtabs a').each(function (index, element) {
    if ($(element).attr('class') == 'selected') {
      selectedTab = index + 1;
      //alert('Normal:'+selectedTab);
      return false;
    }
  });
}

// we get new manual_products info after a product deletion
function AfterProductDelete(tab)
{
    //$('#manual-product-' + tab + ' div img').live('click', function() { // old
    $(document).on('click','#manual-product-' + tab + ' div img',function() {
        $(this).parent().remove();

        $('#manual-product-' + tab + ' div:odd').attr('class', 'odd');
        $('#manual-product-' + tab + ' div:even').attr('class', 'even');

        data = $.map($('#manual-product-' + tab + ' input'), function(element){
          return $(element).attr('value');
        });
                
        $('input[name=\'intelligent_product_labels_module[' + tab + '][manual_products]\']').attr('value', data.join()); 
    });
}

// we get new manual_products info after a product deletion
function AfterCategoryDelete(tab)
{
    //$('#manual-product-' + tab + ' div img').live('click', function() { // old
    $(document).on('click','#manual-category-' + tab + ' div img',function() {
        $(this).parent().remove();

        $('#manual-category-' + tab + ' div:odd').attr('class', 'odd');
        $('#manual-category-' + tab + ' div:even').attr('class', 'even');

        data = $.map($('#manual-category-' + tab + ' input'), function(element){
          return $(element).attr('value');
        });
                
        $('input[name=\'intelligent_product_labels_module[' + tab + '][manual_categories]\']').attr('value', data.join()); 
    });
}

// we get new limit categories info after a product deletion
function AfterLimitCategoriesDelete(tab)
{
    $(document).on('click','#limitcategories-' + tab + ' div img',function() {
        $(this).parent().remove();

        $('#limitcategories-' + tab + ' div:odd').attr('class', 'odd');
        $('#limitcategories-' + tab + ' div:even').attr('class', 'even');

        data = $.map($('#limitcategories-' + tab + ' input'), function(element){
          return $(element).attr('value');
        });
                
        $('input[name=\'intelligent_product_labels_module[' + tab + '][limitcategories]\']').attr('value', data.join()); 
    });
}

function ComboStatusChange(tab)
{
  $('#select_status_ipl-' + tab).on('change',function () {
    // we change info label color
    ChangeInfoLabelColor('type',tab);
    ChangeInfoLabelColor('style',tab);
    ChangeInfoLabelColor('position',tab);
  });
}

// we show or hide content according combo type change
function ComboTypeChange(tab)
{
  $('#select_type_ipl-' + tab).on('change',function () {
    var str = "";
    $('#select_type_ipl-' + tab + ' option:selected').each(function () {
      str += this.value; //ids /- also -/: $(this).text(); $(this).val();
    });

    // we show or hide combo only out of stock according selected item in combo type
    if (str == 'stock') {
      $('#row_only_out_of_stock_ipl-' + tab).fadeIn(250);
    } else {
      $('#row_only_out_of_stock_ipl-' + tab).fadeOut(250);
    }
    
    // we show or hide combo limit_bestseller according selected item in combo type
    if (str == 'bestseller') {
      $('#row_limit_bestseller_ipl-' + tab).fadeIn(250);
    } else {
      $('#row_limit_bestseller_ipl-' + tab).fadeOut(250);
    }

    // we show or hide combo period according selected item in combo type
    if (str == 'latest') {
      $('#row_period_ipl-' + tab).fadeIn(250);
    } else {
      $('#row_period_ipl-' + tab).fadeOut(250);
    }

    // we show or hide search product list according selected item in combo type
    if (str == 'manual') {
      $('.search-product-' + tab).fadeIn(250);
      $('#entry_product-' + tab).focus();
    } else {
      $('.search-product-' + tab).fadeOut(250);
      //$('input[name=\'intelligent_product_labels_module[' + tab + '][manual_products]\']').attr('value','');
      //$('#manual-product-' + tab).empty();
    }

    // we show or hide search category list according selected item in combo type
    if (str == 'category') {
      $('.search-category-' + tab).fadeIn(250);
      $('#entry_category-' + tab).focus();
    } else {
      $('.search-category-' + tab).fadeOut(250);
      //$('input[name=\'intelligent_product_labels_module[' + tab + '][manual_categories]\']').attr('value','');
      //$('#manual-category-' + tab).empty();
    }

    // we show or hide search category list according selected item in combo type
    if (str == 'regex') {
      $('.regex-selection-' + tab).fadeIn(250);
    } else {
      $('.regex-selection-' + tab).fadeOut(250);
    }

    // we show or hide foreground field according selected item in combo type
    if (str == 'stock') {
      $('#row_foreground_ipl-' + tab).fadeOut(250);
    } else {
      $('#row_foreground_ipl-' + tab).fadeIn(250);
    }
    // update info label for combo type
    $('#info-type-' + tab).text($(this).children('option:selected').text());

    ChangeInfoLabelColor('type', tab, str);
  });  
}

function ComboStyleChange(tab) 
{
  $('#select_style_ipl-' + tab).on('change',function () {
    var str = "";
    $('#select_style_ipl-' + tab +' option:selected').each(function () {
      str += this.value;
    });

    // update info label for combo style
    $('#info-style-' + tab).text($(this).children('option:selected').text());

    if ($(this).val() == 'round') {
      $('#style_slider-' + tab).css('visibility','visible');
      $('#slider_value-' + tab).css('visibility','visible');
    } else {
      $('#style_slider-' + tab).css('visibility','hidden');
      $('#slider_value-' + tab).css('visibility','hidden');
    }

    ChangeInfoLabelColor('style', tab, str);
  });
}

function ComboPositionChange(tab) 
{
  $('#select_position_ipl-' + tab).on('change',function () {
    var str = "";
    $('#select_position_ipl-' + tab + ' option:selected').each(function () {
      str += this.value;
    });

    // we show or hide offset combo type
    if (str == 'position_manual') {
      $('.offset-' + tab).fadeIn(500);
      $('#entry_offsetx-' + tab).focus();
    } else {
      $('.offset-' + tab).fadeOut(500);
      $('input[name=\'intelligent_product_labels_module[' + tab + '][offsetx]\']').attr('value','');
      $('input[name=\'intelligent_product_labels_module[' + tab + '][offsety]\']').attr('value','');
    }

    // update info label for combo position
    $('#info-position-' + tab).text($(this).children('option:selected').text());

    ChangeInfoLabelColor('position', tab, str);
  });
}

function ComboDimensionsChange(tab) 
{
  $('#select_dimension_ipl-' + tab).on('change',function () {
    var str = "";
    $('#select_dimension_ipl-' + tab + ' option:selected').each(function () {
      str += this.value;
    });

    // we show or hide dimensions combo type
    if (str == 'manual') {
      $('.dimensions-' + tab).fadeIn(500);
      $('#entry_width-' + tab).focus();
    } else {
      $('.dimensions-' + tab).fadeOut(500);
      $('input[name=\'intelligent_product_labels_module[' + tab + '][width]\']').attr('value','');
      $('input[name=\'intelligent_product_labels_module[' + tab + '][height]\']').attr('value','');
    }
  });
}

function ComboBorderChange(tab) 
{
  $('#select_border_ipl-' + tab).on('change',function () {
    var str = "";
    $('#select_border_ipl-' + tab + ' option:selected').each(function () {
      str += this.value;
    });

    // we show or hide border combo
    if (str == '1'){
      $('#border-' + tab).fadeIn(500);
    } else {
      $('#border-' + tab).fadeOut(500);
      $('input[name=\'intelligent_product_labels_module[' + tab + '][border]\']').attr('value','');
    }
  });
}

function ComboLimitCategoriesChange(tab) 
{
  $('#select_limitcategories_ipl-' + tab).on('change',function () {
    var str = "";
    $('#select_limitcategories_ipl-' + tab + ' option:selected').each(function () {
      str += this.value;
    });

    // we show or hide limit categories combo
    if (str == '1'){
      $('.limitcategories-' + tab).fadeIn(500);
      $('.search-limitcategories-' + tab).fadeIn(500);
    } else {
      $('.limitcategories-' + tab).fadeOut(500);
      $('.search-limitcategories-' + tab).fadeOut(500);
      $('input[name=\'intelligent_product_labels_module[' + tab + '][limitcategories]\']').attr('value','');
    }
  });
}

function ComboSubtitleChange(tab) 
{
  $('#select_subtitle_ipl-' + tab).on('change',function () {
    var str = "";
    $('#select_subtitle_ipl-' + tab + ' option:selected').each(function () {
      str += this.value;
    });

    // we show or hide subtitle combo
    if (str == '1'){
      $('#subtitle-' + tab).fadeIn(500);
    } else {
      $('#subtitle-' + tab).fadeOut(500);
    }
  });
}

function ComboSizeChange(tab) 
{
  // $('#select_font_size_ipl-' + tab).on('change',function () {
  //   $('#style_slider-' + tab).slider('option','value',0);
  // });
}

// autocomplete and selection of manual products
function SetAutocompleteProduct () 
{
  // autocomplete and selection of manual products
  $('input[name=\'product\']').autocomplete({
    delay: 500,
    source: function(request, response) {
      $.ajax({
        url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
        dataType: 'json',
        success: function(json) {   
          response($.map(json, function(item) {
            return {
              label: item.name,
              value: item.product_id
            }
          }));
        }
      });
    }, 
    select: function(event, ui) {
      
      $('#manual-product-' + selectedTab + '-' + ui.item.value).remove();
      
      $('#manual-product-' + selectedTab).append('<div id="manual-product-' + selectedTab + '-' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" value="' + ui.item.value + '" /></div>');

      $('#manual-product-' + selectedTab + ' div:odd').attr('class', 'odd');
      $('#manual-product-' + selectedTab + ' div:even').attr('class', 'even');
      
      data = $.map($('#manual-product-' + selectedTab + ' input'), function(element){
        return $(element).attr('value');
      });

      $('input[name=\'intelligent_product_labels_module[' + selectedTab + '][manual_products]\']').attr('value', data.join());
            
      return false;
    },
    focus: function(event, ui) {
          return false;
      }
  });
}

// autocomplete and selection of manual products
function SetAutocompleteCategory () 
{

  // Category
  $('input[name=\'category\']').autocomplete({
    delay: 500,
    source: function(request, response) {
      $.ajax({
        url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
        dataType: 'json',
        success: function(json) {   
          response($.map(json, function(item) {
            return {
              label: item.name,
              value: item.category_id
            }
          }));
        }
      });
    }, 
    select: function(event, ui) {
      $('#manual-category' + ui.item.value).remove();
      
      $('#manual-category-' + selectedTab).append('<div id="manual-category-' + selectedTab + '-' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="manual_category[]" value="' + ui.item.value + '" /></div>');

      $('#manual-category-' + selectedTab + ' div:odd').attr('class', 'odd');
      $('#manual-category-' + selectedTab + ' div:even').attr('class', 'even');

      data = $.map($('#manual-category-' + selectedTab + ' input'), function(element){
        return $(element).attr('value');
      });

      $('input[name=\'intelligent_product_labels_module[' + selectedTab + '][manual_categories]\']').attr('value', data.join());
          
      return false;
    },
    focus: function(event, ui) {
        return false;
     }
  });

  $('#manual-category-' + selectedTab + ' div img').live('click', function() {
    $(this).parent().remove();
    
    $('#manual-category-' + selectedTab + ' div:odd').attr('class', 'odd');
    $('#manual-category-' + selectedTab + ' div:even').attr('class', 'even');  
  });

}

// autocomplete and selection of limit categories
function SetAutocompleteLimitCategories () 
{
  // limit categories
  $('input[name=\'limitcategories\']').autocomplete({
    delay: 500,
    source: function(request, response) {
      $.ajax({
        url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
        dataType: 'json',
        success: function(json) {   
          response($.map(json, function(item) {
            return {
              label: item.name,
              value: item.category_id
            }
          }));
        }
      });
    }, 
    select: function(event, ui) {
      $('#limitcategories' + ui.item.value).remove();
      
      $('#limitcategories-' + selectedTab).append('<div id="limitcategories-' + selectedTab + '-' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="limitcategories[]" value="' + ui.item.value + '" /></div>');

      $('#limitcategories-' + selectedTab + ' div:odd').attr('class', 'odd');
      $('#limitcategories-' + selectedTab + ' div:even').attr('class', 'even');

      data = $.map($('#limitcategories-' + selectedTab + ' input'), function(element){
        return $(element).attr('value');
      });

      $('input[name=\'intelligent_product_labels_module[' + selectedTab + '][limitcategories]\']').attr('value', data.join());
          
      return false;
    },
    focus: function(event, ui) {
        return false;
     }
  });

  $('#limitcategories-' + selectedTab + ' div img').live('click', function() {
    $(this).parent().remove();
    
    $('#limitcategories-' + selectedTab + ' div:odd').attr('class', 'odd');
    $('#limitcategories-' + selectedTab + ' div:even').attr('class', 'even');  
  });

}

function HideOptionalInputs(tab)
{
  // we hide optional combos
  $('#row_only_out_of_stock_ipl-' + tab).hide();
  $('#row_limit_bestseller_ipl-' + tab).hide();
  $('#row_period_ipl-' + tab).hide();
  $('.search-product-' + tab).hide();
  $('.search-category-' + tab).hide();
  $('.search-limitcategories-' + tab).hide();
  $('.regex-selection-' + tab).hide();
  $('.offset-' + tab).hide();
  $('.dimensions-' + tab).hide();
  $('#border-' + tab).hide();
  $('#subtitle-' + tab).hide();

}

// we change info label color
function ChangeInfoLabelColor(combo_type, tab, css_class)
{
  if (css_class==null) {
    $('#select_' + combo_type + '_ipl-' + tab + ' option:selected').each(function () {
      css_class = this.value;
    });
  }

  $('#info-' + combo_type + '-' + tab).removeClass();
  
  // we only change color if label status is enabled
  if ($('#select_status_ipl-' + tab + ' option:selected').val() == "1") {
    $('#info-' + combo_type + '-' + tab).addClass('info-'+ css_class);
  } else {
    $('#info-' + combo_type + '-' + tab).addClass('disabled');
  }
}

// we update preview
function UpdatePreview()
{
  //fieldName = $(field).attr('name');
  //fieldValue = $(field).attr('value');
  //console.log("preview");
  
  var css = 'text-align: center;';

  // style
  var currentStyle = $('#select_style_ipl-'+selectedTab).attr('value');

  if (currentStyle == 'rotated') {
    var div_rotated_head = '<div class="cut_rotated">';
    var div_rotated_foot = '</div>';
  } else {
    var div_rotated_head = '';
    var div_rotated_foot = '';
  }

  if (currentStyle == 'horizontal') {
    css += 'padding: 3px 5px;';
    css += 'width: auto;';

  } else if (currentStyle == 'round') {
    css += 'padding: 3px;';
    css += 'width: auto;';

    var currentStyleRoundSize = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][style_round_size]\"]').attr('value');
    css += 'line-height:'+currentStyleRoundSize+';';
    css += 'min-width:'+currentStyleRoundSize+';';

  } else if (currentStyle == 'rotated') {
    css += 'width: 300px;';   
  }

  // position
  var currentPosition = $('#select_position_ipl-'+selectedTab).attr('value');

  if (currentPosition == 'position_manual') {
    var currentLeft = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][offsetx]\"]').attr('value');
    css += 'left:'+currentLeft+'%;right:none;';
    var currentTop = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][offsety]\"]').attr('value');
    css += 'top:'+currentTop+'%;bottom:none;';
  }

  // title
  var currentText = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][title][<?php echo $first_language_id; ?>]\"]').attr('value');
  
  // subtitle
  var subtitle = '';
  if ( $('select[name=\"intelligent_product_labels_module['+selectedTab+'][subtitle][status]\"]').attr('value') == "1"  ) {
    var currentSubtitleText = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][subtitle][<?php echo $first_language_id; ?>]\"]').attr('value');
    var currentSubtitleTextX = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][subtitlex]\"]').attr('value');
    var currentSubtitleTextY = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][subtitley]\"]').attr('value');
    var currentSubtitleSize = $('select[name=\"intelligent_product_labels_module['+selectedTab+'][subtitle_size]\"]').attr('value');
    var currentSubtitleColor = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][subtitle_color]\"]').attr('value');
    if ( currentSubtitleColor != '' ) { currentSubtitleColor=';color:'+currentSubtitleColor; }
    subtitle = '<div id="subtitle" style="position:absolute;left:'+currentSubtitleTextX+'%;top:'+currentSubtitleTextY+'%;padding:0;margin:0;width:100%;font-size:'+currentSubtitleSize+currentSubtitleColor+'">'+currentSubtitleText+'</div>';
  }

  // fontsize
  var currentFontSize = $('select[name=\"intelligent_product_labels_module['+selectedTab+'][font_size]\"]').attr('value');
  css += 'font-size:'+currentFontSize+';';

  // bold
  var currentBold = $('select[name=\"intelligent_product_labels_module['+selectedTab+'][bold]\"]').attr('value');
  css += 'font-weight:'+currentBold+';';

  // dimensions
  var currentWidth = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][width]\"]').attr('value');
  css += 'width:'+currentWidth+'px;';

  var currentHeight = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][height]\"]').attr('value');
  css += 'height:'+currentHeight+'px;';

  // colors

  var currentBackground = $('#color_background-'+selectedTab).attr('value');
  css += 'background-color:'+currentBackground+';';
  
  var currentForeground = $('#color_foreground-'+selectedTab).attr('value');
  css += 'color:'+currentForeground+';';
  
  // border

  var borderEnabled = $('#select_border_ipl-'+selectedTab).attr('value') == '1' ? true : false;

  if (borderEnabled) {
    var currentBorder = $('#input_border-'+selectedTab).attr('value');
    css += 'border: 1px solid '+currentBorder+';';
  } else {
    css += 'border: none;';
  }

  // opacity
  var currentOpacity = $('select[name=\"intelligent_product_labels_module['+selectedTab+'][opacity]\"]').attr('value');
  css += 'opacity:'+currentOpacity+';';

  // shadow
  var currentShadow = $('select[name=\"intelligent_product_labels_module['+selectedTab+'][shadow]\"]').attr('value') == '1' ? true : false;
  if (!currentShadow) {
    css += 'box-shadow: none;';
  }

  // background-image
  var currentBackgroundImage = $('#image-'+selectedTab).attr('value');
  if (currentBackgroundImage) {
    css += 'background-image:url(\'<?php echo $dirimage; ?>'+currentBackgroundImage+'\');';
    css += 'background-repeat:no-repeat;';
    css += 'background-position:center center;';

    // background auto resize
    var currentImageResize = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][image_autoresize]\"]').is(':checked')
    if (currentImageResize) {
       css += 'background-size: contain;';
    } else {
       css += 'background-size: auto;';
    }
  }

  // custom css
  var currentCustomCss = $('input[name=\"intelligent_product_labels_module['+selectedTab+'][custom_css]\"]').attr('value');
  if (currentCustomCss) {
    css += currentCustomCss;
  }

  $('#preview').html(div_rotated_head+'<div id="label-preview" class="'+currentStyle+' '+currentPosition+' small-db" style="'+css+'">'+currentText+subtitle+'</div>'+div_rotated_foot);
}

function SetToolTips () {

  var ayTooltips = new Array();

  <?php foreach ($tooltips as $key => $tooltip) { ?>
      ayTooltips['<?php echo $key; ?>'] = '<?php echo $tooltip; ?>';
  <?php } ?>

  <?php $tool_tip_classes = array('.trigger','.trigger_regex','.trigger_dimensions_round'); ?>

  <?php foreach ($tool_tip_classes as $class) { ?>
      $(document).delegate('<?php echo $class; ?>', 'focus', function() {
            var tooltipLeft,
                tooltipTop,
                $this = $(this),
                triggerPos = $this.offset(),
                triggerHeight = $this.outerHeight(),
                triggerWidth = $this.outerWidth(),
                $tooltip = $('#tooltip'),
                tooltipHeight,
                tooltipWidth,
                screenWidth = $(window).width(),
                scrollTop = $(document).scrollTop(),
                type,
                key_tooltip,
                style;

                $('#select_type_ipl-' + selectedTab + ' option:selected').each(function () {
                  type = this.value;
                });

                $('#select_style_ipl-' + selectedTab + ' option:selected').each(function () {
                  style = this.value;
                });

                key_tooltip = 'general';

                <?php if ($class == '.trigger') { ?>
                            
                            if ( type == 'special' || type == 'stock' || type == 'bestseller') {
                              key_tooltip = type;
                            } else if ( type == 'regex' ) {
                              key_tooltip = 'regex_title';  
                            }

                <?php } elseif ($class == '.trigger_regex') { ?>
                            
                            if ( type == 'regex' ) {
                              key_tooltip = type;
                            }

                <?php } elseif ($class == '.trigger_dimensions_round') { ?>
                            
                            if ( style == 'round' ) {
                              key_tooltip = 'dimensions_round';
                            }
                            
                <?php } ?>

                $tooltip.html(ayTooltips[key_tooltip]+'<span class="arrow"></span>');

                tooltipHeight = $tooltip.height();
                tooltipWidth = $tooltip.width();

                if ( triggerPos.top - tooltipHeight - scrollTop > 0 ) {
                    tooltipTop = triggerPos.top - tooltipHeight - 40;
                } else {
                    tooltipTop = triggerPos.top + triggerHeight + 10;
                }

                var overFlowRight = (triggerPos.left +  tooltipWidth) - screenWidth;

                if ( overFlowRight > 0 ) {
                  tooltipLeft = triggerPos.left - overFlowRight - 10;
                } else {
                  tooltipLeft = triggerPos.left + triggerWidth - 10;
                }

                $tooltip.css({
                  left : tooltipLeft,
                  top : tooltipTop,
                  position : 'absolute'
                }).fadeIn(200);
      });

      $(document).delegate('<?php echo $class; ?>','blur', function(){
        $('#tooltip').hide();
      });

  <?php } ?>    
}

function image_upload(field, thumb) {
  css = {};
  $('#dialog').remove();
  
  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
  
  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
    close: function (event, ui) {
        if ($('#' + field).attr('value')) {
          $.ajax({
            url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
            dataType: 'text',
            success: function(text) {
              $('#' + thumb).replaceWith('<img src="' + text + '" alt="" id="' + thumb + '" />');
              
              css = {'background-image': 'url("<?php echo $dirimage; ?>'+ $('#' + field).attr('value') +'")',
                     'background-repeat':'no-repeat',
                     'background-position':'center center'};
              $('#label-preview').css(css);
            }
          });
        }
    },  
    bgiframe: false,
    width: 800,
    height: 400,
    resizable: false,
    modal: false
  });
}

function SetInputDates(tab) {
  $('#date-start-' + tab).datepicker({dateFormat: 'yy-mm-dd'});
  $('#date-end-' + tab).datepicker({dateFormat: 'yy-mm-dd'});
}

function SetStyleSlider(tab){
  var svalue = 0;
  var currentStyleRoundSize = $('input[name=\"intelligent_product_labels_module['+tab+'][style_round_size]\"]').attr('value');

  $('#style_slider-' + tab).slider({
    range: 'min',
    min: 1.6,
    max: 6.6,
    step: 0.1,
    value: currentStyleRoundSize.replace('em',''),
    slide: function( event, ui ) {
      svalue = ui.value;
      $('#label-preview').css({'line-height':svalue.toString()+'em','min-width':svalue.toString()+'em'});
      $('#style_round_size-' + tab).attr('value',svalue.toString()+'em');

      // var atag = $(this).find("a:first");
      // atag.text(svalue);

      $('#slider_value-' + tab).text(svalue.toString());
    }
  });
}

// Execute code

var label_row = <?php echo $label_row; ?>; // global next number row to use
var selectedTab = 1; // global selected tab

$(document).on('ready', function() {

  // tabs init
  $('.vtabs a').tabs();

  // what to do on each tab / label
  $('.vtabs a').each(function (index){
      
      var tab = index + 1;
      
      // we set what will happens on each tab click
      $('#label-' + tab).on('click',function() {
          SetSelectedTab();

          // to show/hide optional inputs
          $('#select_type_ipl-' + selectedTab).change();
          $('#select_style_ipl-' + selectedTab).change();
          $('#select_position_ipl-' + selectedTab).change();
          $('#select_dimension_ipl-' + selectedTab).change();
          $('#select_border_ipl-' + selectedTab).change();
          $('#select_limitcategories_ipl-' + selectedTab).change();
          $('#select_subtitle_ipl-' + selectedTab).change();
      });

      // we set what will happen on combo changes
      ComboStatusChange(tab);
      ComboTypeChange(tab);
      ComboStyleChange(tab);
      ComboPositionChange(tab);
      ComboDimensionsChange(tab);
      ComboBorderChange(tab);
      ComboLimitCategoriesChange(tab);
      ComboSubtitleChange(tab);
      SetInputDates(tab);
      SetStyleSlider(tab);

      // we change info label colors
      ChangeInfoLabelColor('type',tab);
      ChangeInfoLabelColor('style',tab);
      ChangeInfoLabelColor('position',tab);

      // we set keyup event for title field
      $('input[name=\"intelligent_product_labels_module['+ tab +'][title][<?php echo $first_language_id; ?>]\"]').on('keyup',function(){
        $('#label-preview').text($(this).val());
      });

      // we set keyup event for subtitle field
      $('input[name=\"intelligent_product_labels_module['+ tab +'][subtitle][<?php echo $first_language_id; ?>]\"]').on('keyup',function(){
        $('#subtitle').text($(this).val());
      });

      // we update new manual_products (selected products) info after a product deletion
      AfterProductDelete(tab);
      AfterCategoryDelete(tab);
      AfterLimitCategoriesDelete(tab);

      HideOptionalInputs(tab);

      $('#btn_update_custom_css-'+tab).on('click', function(){
        UpdatePreview();
      });
  });

  $('#form').on('change', function(){
    UpdatePreview();
  });

  // we trigger change event for combos
  $('#select_type_ipl-1').change();
  $('#select_position_ipl-1').change();
  $('#select_dimension_ipl-1').change();
  $('#select_border_ipl-1').change();
  $('#select_limitcategories_ipl-1').change();
  $('#select_subtitle_ipl-1').change();
  $('#select_style_ipl-1').change();

  SetAutocompleteProduct();
  SetAutocompleteCategory();
  SetAutocompleteLimitCategories();
  SetToolTips();

  $("#form").validity(function() {

    $('.vtabs a').each(function (index, element) {
      $('#entry_offsetx-'+ (index + 1)).match("number",'<?php echo $text_number_required; ?>' + ' Label '+ (index + 1));
      $('#entry_offsety-'+ (index + 1)).match("number",'<?php echo $text_number_required; ?>' + ' Label '+ (index + 1));
      $('#entry_width-'+ (index + 1)).match("number",'<?php echo $text_number_required; ?>' + ' Label '+ (index + 1));
      $('#entry_height-'+ (index + 1)).match("number",'<?php echo $text_number_required; ?>' + ' Label '+ (index + 1));
      $('#entry_subtitlex-'+ (index + 1)).match("number",'<?php echo $text_number_required; ?>' + ' Label '+ (index + 1));
      $('#entry_subtitley-'+ (index + 1)).match("number",'<?php echo $text_number_required; ?>' + ' Label '+ (index + 1));
    });

  });

  var $preview = $('#preview');
  var eTop = $preview.offset().top; //get the offset top of the preview

  $(window).scroll(function() {
     var position = eTop  - $(window).scrollTop();

     if (position <= 10) {
        $preview.css('position','fixed');
        $preview.css('background-color','#FFFFFF');
        $preview.css('top','10px');
        $preview.css('left','70px');
        $preview.css('box-shadow','10px 10px 5px #888888');
        $preview.css('z-index','100000');
     } else {
        $preview.css('position','relative');
        $preview.css('z-index','0');
        $preview.css('left','30px');
        $preview.css('top','0');
        $preview.css('box-shadow','none');
     }
  });

});

//--></script>

<?php echo $footer; ?>