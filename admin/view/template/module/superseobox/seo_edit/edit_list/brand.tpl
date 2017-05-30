<?php 
	$type = 'brand';
	$seo_edit_metadata = array(
		array('table' => 'manufacturer_description','col' => 'name', 'data_name' => 'name', 'type' => 'text', 'placement' => 'right'),
		array('table' => 'url_alias','col' => 'url_alias', 'data_name' => 'urls' , 'type' => 'text', 'placement' => 'right'),
		array('table' => 'manufacturer_description','col' => 'tag', 'data_name' => 'tags', 'placement' => 'right'),
		array('table' => 'manufacturer_description','col' => 'description', 'data_name' => 'descrip', 'type' => 'wysihtml5'),
		array('table' => 'manufacturer_description','col' => 'meta_keyword', 'data_name' => 'm_keywords'),
		array('table' => 'manufacturer_description','col' => 'meta_description', 'data_name' => 'm_descrip', 'placement' => 'left'),
		array('table' => 'manufacturer_description','col' => 'seo_title', 'data_name' => 'titles',  'placement' => 'left'),
		array('table' => 'manufacturer_description','col' => 'seo_h1', 'data_name' => 'seo_h1',  'placement' => 'left'),
		array('table' => 'manufacturer_description','col' => 'seo_h2', 'data_name' => 'seo_h2',  'placement' => 'left'),
		array('table' => 'manufacturer_description','col' => 'seo_h3', 'data_name' => 'seo_h3',  'placement' => 'left')
	);
	$th_name = $text_common_se_brand_1;
?>
<?php require_once 'edit_list.tpl';?>

