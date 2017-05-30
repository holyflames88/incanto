<?php
// Heading
$_['heading_title']         = 'Related options_feofan.net';
$_['related_options']       = 'Related options'; 

// Text
$_['text_module']           = 'Modules';
$_['text_success']          = 'Settings is modified!';
$_['text_content_top']      = 'Content Top';
$_['text_content_bottom']   = 'Content Bottom';
$_['text_column_left']      = 'Column Left';
$_['text_column_right']     = 'Column Right';
$_['text_ro_updated_to']    = 'Module updated to version ';
$_['text_ro_all_options']   = 'All available options';
$_['text_ro_support']       = "Developer: <a href='http://liveopencart.com' target='_blank'>liveopencart.com</a> | Support, questions and suggestions: <a href=\"mailto:support@liveopencart.com\">support@liveopencart.com</a>";
$_['text_ro_clear_options'] = 'Clear options';



// Entry
$_['entry_settings']                  = 'Module settings';

$_['entry_PHPExcel_not_found']        = 'PHPExcel library not installed. File not found: ';
$_['entry_export']                    = 'Export';
$_['entry_export_description']        = 'Export file format: XLS.<br>First line for fields names, next lines for data.';
$_['entry_export_get_file']           = 'Export file';
$_['entry_export_fields']             = 'Export fields:';
$_['entry_import']                    = 'Import';
$_['entry_import_description']        = '
Import file format: XLS. Import uses only first sheet for getting data.
<br>First table line must contain fields names (head): product_id, relatedoptions_model, quantity, price, option_id1, option_value_id1, option_id2, option_value_id2, ... (not product_option_id or product_option_value_id).
<br>Next table lines must contain related options data in accordance with fields names in first table line.
<br><br>Products related options combinations will be replaced if the same will be found in file.';
$_['entry_import_delete_before']      = 'Delete all related options data before import';
$_['button_upload']		                = 'Import file';
$_['button_upload_help']              = 'import starts immediately after selecting the file';
$_['entry_server_response']           = 'Server answer:';
$_['entry_import_result']             = 'Processed products / related options';

$_['entry_update_quantity']           = 'Recalc quantity';
$_['entry_update_quantity_help']      = 'automatic calculation of product stocks based on related options data';
$_['entry_stock_control']             = 'Quantity control';
$_['entry_stock_control_help']        = 'disable adding to cart goods with quantity greater than quantity in related options';
$_['entry_update_options']            = 'Update options';
$_['entry_update_options_help']    	  = 'automatic update of product information based on related options information';
$_['entry_options_values']            = 'Options values';
$_['entry_add_related_options']       = 'Add related options';
$_['entry_related_options_quantity']  = 'Quantity';
$_['entry_ro_version']                = 'Related options, version';

$_['entry_ro_use_variants']           = 'Use different related options variants';
$_['entry_ro_variant']                = 'Related options variant';
$_['entry_ro_variant_name']           = 'Variant name';
$_['entry_ro_options']                = 'Variant options';
$_['entry_ro_add_variant']            = 'Add variant';
$_['entry_ro_delete_variant']         = 'Delete variant';
$_['entry_ro_add_option']             = 'Add option';
$_['entry_ro_delete_option']          = 'Delete option';
$_['entry_ro_use']                    = 'Use related options';
$_['entry_show_clear_options']        = 'Function "Clear options"';
$_['entry_show_clear_options_help']   = 'show button "Clear options" for customer to clear selected options values';
$_['option_show_clear_options_not']   = 'do not use';
$_['option_show_clear_options_top']   = 'above options';
$_['option_show_clear_options_bot']   = 'below options';
$_['entry_hide_inaccessible']         = 'Hide unavailable values';
$_['entry_hide_inaccessible_help']    = 'hide unselectable option values from the customers';
$_['entry_spec_model']                = 'Models in related options';
$_['entry_spec_model_help']           = 'set different models for related options combinations (this models will be shown on the product page and ont the cart page, and will be saved in order )';
$_['entry_spec_price']                = 'Prices in related options';
$_['entry_spec_price_help']           = 'set different prices for related options combinations, if price for related options is not set - standard product price will be used';
$_['entry_spec_weight']               = 'Weight for related options';
$_['entry_spec_weight_help']          = 'set different weights for related options combinations';
$_['entry_spec_price_discount']       = 'Discounts in related options';
$_['entry_spec_price_discount_help']  = 'set different discounts for related options (works if "'.$_['entry_spec_price'].'" turned on, if discounts for related options is not set - standard product discounts will be used)';
$_['entry_add_discount']              = 'Add discount';
$_['entry_del_discount_title']        = 'Delete discount';
$_['entry_spec_price_special']        = 'Specials in related options';
$_['entry_spec_price_special_help']   = 'set different specials for related options (works if "'.$_['entry_spec_price'].'" turned on, if specials for related options is not set - standard product specials will be used)';
$_['entry_add_special']               = 'Add special';
$_['entry_del_special_title']         = 'Delete special';
$_['entry_prices']                    = 'Price';
$_['entry_select_first_short']        = 'Auto-select';
$_['entry_select_first_priority']     = 'Priority';
$_['entry_select_first']              = 'Options auto selection';
$_['entry_select_first_help']         = 'automatic selection for options values for customers at product page';
$_['option_select_first_not']         = 'off';
$_['option_select_first']             = 'first available combination';
$_['option_select_first_last']        = 'last remaining value';
$_['entry_step_by_step']              = 'Step-by-step options selection';
$_['entry_step_by_step_help']         = 'customer selects first option, then second, then third, and next, and next etc. (customer can change value of selected options anytime - all next options with unsuitable values will be cleared)';
$_['entry_allow_zero_select']         = 'Allow select zero quantity';
$_['entry_allow_zero_select_help']    = 'allow customer to select related options sets with zero quantity';
$_['entry_edit_columns']              = 'Related Options editing';
$_['entry_edit_columns_0']            = '1 column';
$_['entry_edit_columns_2']            = '2 columns';
$_['entry_edit_columns_3']            = '3 columns';
$_['entry_edit_columns_4']            = '4 columns';
$_['entry_edit_columns_5']            = '5 columns';
$_['entry_edit_columns_100']          = 'by width';
$_['entry_edit_columns_help']         = 'set position select fields for editing related options (Related Option tab on product editing page';
$_['entry_add_all_variants']          = 'Add all possible option combinations';

//warning
$_['warning_equal_options']           = 'matching set of options';

// Error
$_['error_equal_options']             = 'matching set of options';
$_['error_not_enough_options']        = 'not all related options are set';
$_['error_permission']                = 'Warning: You do not have permission to modify module!';
?>