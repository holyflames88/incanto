<?php
// Heading
$_['heading_title']                  = 'Intelligent Product Labels';

// Text
$_['text_label']                     = 'Label';
$_['text_module']                    = 'Modules';
$_['text_success']                   = 'Success: You have modified Intelligent Product Labels!';
$_['text_round_label']               = 'Round';
$_['text_horizontal_label']          = 'Horizontal';
$_['text_rotated_label']             = 'Rotated';
$_['text_manual']                    = 'Products';
$_['text_stock']                     = 'Stock';
$_['text_top_left']                  = 'Top & Left';
$_['text_top_right']                 = 'Top & Right';
$_['text_bottom_left']               = 'Bottom & Left';
$_['text_bottom_right']              = 'Bottom & Right';
$_['text_one_day']                   = 'One Day';
$_['text_one_week']                  = 'One Week';
$_['text_two_weeks']                 = 'Two Weeks';
$_['text_one_month']                 = 'One Month';
$_['text_three_months']              = 'Three Months';
$_['text_six_months']                = 'Six Months';
$_['text_one_year']                  = 'One Year';
$_['text_position_manual']           = 'Manual';
$_['text_normal_size']               = 'Normal Size';
$_['text_category']                  = 'Category';
$_['text_categories']                = 'Categories';
$_['text_home']                      = 'Home';
$_['text_all']                       = 'All of them';
$_['text_regex']                     = 'Advanced Regex';
$_['text_free_shipping']             = 'Free Shipping';
$_['text_browse']                    = 'Browse';
$_['text_clear']                     = 'Clear';
$_['text_image_manager']             = 'Image Manager';
$_['text_all_products']              = 'All Products';
$_['text_all']		                 = 'All';
$_['text_irp']		                 = 'Intelligent Random Products';
$_['text_tooltip_special']           = '<div><h3>Special Tips</h3><p>What you can do here:<br /><ul><li>You can leave it blank. That way the extension is going to calculate the percentage for the product offer and show its % off</li><li>You can write any word. For example: Offer!</li><li>You can write words and include the percentage with the key: <span class=\"highlight\">[%]</span>. For example: If the product has got a 10% off, you could write: Save [%] and it would show: Save 10%</li><li>You can write words and include the amount with the key: <span class=\"highlight\">[amount]</span>. For example: If you save $100 on a product, you could write: Save [amount] and it would show: Save $100</li><li>You can set: <span class=\"highlight\">[price]</span>. Use this key to include product price in your label.</li></ul></p></div>';

$_['text_tooltip_stock']             = '<div><h3>Stock Tips</h3><p>What you can do here:<br /><ul><li>You can leave it blank. That way the extension is going to show what you have configured in Opencart</li><li>You can write some words and if you have configured to show quantity then you can set the key: <span class=\"highlight\">[quantity]</span> to show the items you have got in stock. For example: If you have got 95 items of a product, you could write: [quantity] items available, and it would show: 95  items available</li><li>You could use the key <span class=\"highlight\">[notext]</span> to avoid showing any text and set an image icon instead</li><li>You can set: <span class=\"highlight\">[price]</span>. Use this key to include product price in your label.</li></ul></p></div>';

$_['text_tooltip_bestseller']        = '<div><h3>Bestseller Tips</h3><p>What you can do here:<br /><ul><li>You can leave it blank. That way the extension is going to show Nº1, Nº2, Nº3, depending on the ranking sales for the product</li><li>You can write any word. For example: Bestseller!</li><li>You can also write some words and use the key: <span class=\"highlight\">[ranking]</span> to show the ranking for the product. For example: If you want to show the most purchased product in your shop, you could write: This is the number [ranking], and it would show: This is the number 1</li><li>You can set: <span class=\"highlight\">[price]</span>. Use this key to include product price in your label.</li></ul></p></div>';

$_['text_tooltip_regex']   		     = '<div><h3>Regular Expression:</h3><ul><li>To make it insensitive case use <span style="font-size: 14px;"><strong>/</strong>your_word<strong>/i</strong></span>.</li><li>In Product Quantity: <span style="font-size: 14px;"><strong>^[1-9]$</strong></span> only shows label between 1 and 9 products in stock</li><li>In Product Quantity: <span style="font-size: 14px;"><strong>^[1-9]+</strong></span> only shows label when products are in stock</li><li>In Product Quantity: <span style="font-size: 14px;"><strong>^0$</strong></span> only shows label when the product is out of stock</li></ul></div>';

$_['text_tooltip_regex_title']           = '<div><h3>Regex Tips</h3><p>Here, you can set the following keys:<br /><br /><span class=\"highlight\">[matched]</span><br /><br />Use this key to include matched regex in your label. Use ( ) within the regex expression to select it.<br /><br /><span class=\"highlight\">[price]</span><br /><br />Use this key to include product price in your label.</li></ul></p></div>';

$_['text_tooltip_dimensions_round']  = '<div><h3>Tip</h3><ul><li>You can set title height through the slide control next to the combo style.</li></ul></div>';

$_['text_tooltip_general']           = '<div><h3>General Tips</h3><p>Here, you can set the following keys:<br /><br /><span class=\"highlight\">[price]</span><br /><br />To include product price in your label.</li></ul></p></div>';


$_['text_number_required']      = 'Please, field must be a number!';
$_['text_product_name']         = 'Product Name';
$_['text_product_model']        = 'Product Model';
$_['text_product_tag']          = 'Product Tag';
$_['text_product_description']  = 'Product Description';
$_['text_product_manufacturer'] = 'Product Manufacturer';
$_['text_product_quantity']     = 'Product Quantity';
$_['text_product_sku']          = 'Product Sku';
$_['text_product_upc']          = 'Product Upc';
$_['text_product_ean']          = 'Product Ean';
$_['text_product_jan']          = 'Product Jan';
$_['text_product_isbn']         = 'Product Isbn';
$_['text_product_mpn']          = 'Product Mpn';

// Entry
$_['entry_status']                   = 'Status:';
$_['entry_type']                     = 'Apply to:';
$_['entry_style']                    = 'Style:';
$_['entry_product']                  = 'Select a Product:';
$_['entry_only_out_of_stock']        = 'Only show out of stock:';
$_['entry_limit_bestseller']         = 'Limit bestsellers:';
$_['entry_period']                   = 'Stop Showing in:';
$_['entry_category']                 = 'Select a Category:';
$_['entry_position']                 = 'Position:';
$_['entry_layout_position']          = 'Layout Position:';
$_['entry_show_in_product']          = 'Show in Product Layout:';
$_['entry_limitcategories']          = 'Limit to Categories:';
$_['entry_show_in']                  = 'Show in:';
$_['entry_font_size']                = 'Size:';
$_['entry_background_color']         = 'Background Color:';
$_['entry_foreground_color']         = 'Foreground Color:';
$_['entry_color']                    = 'Color:';
$_['entry_border']                   = 'Border:';
$_['entry_layout']                   = 'Layout:';
$_['entry_title']                    = 'Title:';
$_['entry_subtitle']                 = 'Subtitle:';
$_['entry_bold']                     = 'Bold:';
$_['entry_shadow']                   = 'Shadow:';
$_['entry_offsetx']                  = 'Offset X:';
$_['entry_offsety']                  = 'Offset Y:';
$_['entry_opacity']                  = 'Opacity:';
$_['entry_dimensions']               = 'Dimensions:';
$_['entry_width']                    = 'Width:';
$_['entry_height']                   = 'Height:';
$_['entry_image']                    = 'Background Image:';
$_['entry_regex']                    = 'Set Label by Regex:';
$_['entry_start_date']               = 'Start Date:';
$_['entry_end_date']                 = 'End Date:';
$_['entry_priority']                 = 'Priority';
$_['entry_hide_when_lower_priority'] = 'Hide when Lower Priority';
$_['entry_custom_css']               = 'Custom CSS';

// Button
$_['button_add_label']               = 'Add Label';
$_['button_update']                  = 'Update';

// Error
$_['error_permission']               = 'Warning: You don\'t have enough rights to modify this module!';
?>
