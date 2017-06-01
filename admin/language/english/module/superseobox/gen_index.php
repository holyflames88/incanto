<?php

require_once('gen_setting.php');
require_once('gen_example.php');

$_['module_name']     = 'Paladin SEO Manager';

// Mail
$_['mail_success']					= 'You have successfully contacted MarketInSG\'s Support';
$_['mail_error_name']				= 'Name must be between 5 and 32 characters';
$_['mail_error_email']				= 'Email address must be valid!';
$_['mail_error_order_id']			= 'Order ID must be valid!';
$_['mail_error_message']			= 'Message must be between 20 and 2400 characters!';

// import/export
$_['text_export_import_ss']  		= 'Export/Import Paladin SEO Manager';
$_['text_import_ss']    			= 'Import Settings for Paladin SEO Manager';
$_['text_import']    				= 'Import';
$_['text_export_ss']    			= 'Export Settings of Paladin SEO Manager';
$_['text_export_import_info']    	= 'Place this export code into the import text field in your new site and press "Import".';
$_['text_import_success']      		= 'Success: You have imported setting for Paladin SEO Manager!';
$_['text_import_error']        		= 'Your export code has mistake. Please try another code!!!';
$_['text_get_setting']        		= 'Get Settings for export';
$_['text_get_export']        		= 'You has imported setting for Paladin SEO Manager';

// CATEGORY NAME
$_['text_category_name_tags'] 			= 'Tags';
$_['text_category_name_m_descrip'] 		= 'Meta Description';
$_['text_category_name_m_keywords'] 	= 'Meta Keywords';
$_['text_category_name_titles'] 		= 'Seo Titles';
$_['text_category_name_seo_h1'] 		= 'Seo H1';
$_['text_category_name_seo_h2'] 		= 'Seo H2';
$_['text_category_name_seo_h3'] 		= 'Seo H3';
$_['text_category_name_descrip'] 		= 'Description';
$_['text_category_name_urls'] 			= 'SEO URLs';
$_['text_category_name_tools'] 			= 'SEO Tools';
$_['text_category_name_related_prod'] 	= 'Related products';
$_['text_category_name_images'] 		= 'Image names';
$_['text_category_name_alt_image'] 		= 'Image Alt';
$_['text_category_name_title_image'] 	= 'Image Title';
$_['text_category_name_reviews'] 		= 'Reviews';

// ENTITY NAME
$_['text_entity_name_product'] 		= 'Products';
$_['text_entity_name_category'] 	= 'Categories';
$_['text_entity_name_brand'] 		= 'Brands';
$_['text_entity_name_info'] 		= 'Informations';
$_['text_entity_name_STAN_urls'] 	= 'Standart';
$_['text_entity_name_CPBI_urls'] 	= 'CPBI';
$_['text_entity_name_all'] 			= 'all pages';

//status ============================================================
$_['text_status_on'] 			= 'Status ON';
$_['text_status_off'] 			= 'Status OFF';


//SEO GENERATOR TABS ============================================================

$_['text_entity_gener_desc_STAN_urls'] 	= '
	Here you can generate SEO URLs for standart Opencart\'s pages (home, account, contact, cart, etc)';
	
$_['text_entity_gener_desc_CPBI_urls'] 	= '
	Here you can generate SEO URLs for Categories, Products, Brands and Informations pages (CPBI). </br> You can write own template for creating SEO URLs for every CPBI page. If you click on the button "Replacing", before use generator, you can easily add char or string for replacing in SEO URLs. Button "Clear" removes all SEO URLs (keywords).';

	
// Auto generate 
$_['text_auto_generator__tags']        = 'Auto generate tags for new or edited categories, products, brands and informations pages if tags don\'t exist';
$_['text_auto_generator__m_descrip']        = 'Auto generate Meta Description for new categories, products, brands and informations pages if Meta Description don\'t exist';
$_['text_auto_generator__m_keywords']        = 'Auto generate META keywords for new or edited categories, products, brands and informations pages if META keywords don\'t exist';
$_['text_auto_generator__titles']        = 'Auto generate titles for new or edited categories, products, brands and information pages if titles don\'t exist';
$_['text_auto_generator__descrip']        = 'Auto generate description for the new or edited categories, products, brands and informations pages if description don\'t exist';
$_['text_auto_generator__images']        = 'Auto generate "friendly name" of the images for new or edited products';
$_['text_auto_generator__related_prod']        = 'Auto generate Related Products for new or edited products if related products are don\'t exist';
$_['text_auto_generator__urls']        = '1. Auto generate SEO URLs for standard Opencart page (for example if you have links like site.com/index.php?route=account/login, it transforms in site.com/login ) </br> 2. Auto generate SEO URLs for Categories, Products, Brands, Information pages, when you create new or edited the product/category/manufacturer or information pages';
$_['text_auto_generator__reviews']     = 'Auto generate Reviews for new or edited products.';
$_['text_auto_generator__seo_h1']     = 'Auto generate H1 tags for new or edited categories, products and brands pages if H1 tags don\'t exist.';
$_['text_auto_generator__seo_h2']     = 'Auto generate H1 tags for new or edited categories, products and brands pages if H2 tags don\'t exist.';
$_['text_auto_generator__seo_h3']     = 'Auto generate H1 tags for new or edited categories, products and brands pages if H3 tags don\'t exist.';

$_['text_auto_generator__alt_image']     = 'Auto generate Alt tags for new or edited categories and products if Alt tags don\'t exist.';
$_['text_auto_generator__title_image']     = 'Auto generate Title image for new or edited categories and products if Title text don\'t exist.';

// Alert text
$_['alert_endGenerate']			= '<h3>Congratulation!!!</h3><h4>You generated new %s for %s.</h4><p>Has been generated %s items.</p>';
$_['alert_changeAutoGenerate']	= '<h3>Congratulation!!!</h3> <h4>bla-bla.</h4>';
$_['alert_startClearGenerate']		= '<h3>Alert!!!</h3> <h4>You deleted all %s for %s.</h4> <p>Has been cleared %s items.</p>';
$_['alert_save']				= '<h3>Congratulation!!!</h3> <h4>You saved all %s for %s.</h4>';	

?>