<?php
class ControllerModuleIntelligentProductLabels extends Controller {
	private $error = array(); 

	public function index() {   
		$this->language->load('module/intelligent_product_labels');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			// echo '<pre>'.print_r($this->request->post,true).'</pre>';exit;
			$this->model_setting_setting->editSetting('intelligent_product_labels', $this->request->post);
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_label'] = $this->language->get('text_label');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_round_label'] = $this->language->get('text_round_label');
		$this->data['text_horizontal_label'] = $this->language->get('text_horizontal_label');
		$this->data['text_rotated_label'] = $this->language->get('text_rotated_label');
		
		$this->data['text_manual'] = $this->language->get('text_manual');
		$this->data['text_stock'] = $this->language->get('text_stock');

		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		
		$this->data['text_number_required'] = $this->language->get('text_number_required');

		$this->data['text_categories'] = $this->language->get('text_categories');
		$this->data['text_category'] = $this->language->get('text_category');

		$this->data['text_product_name'] = $this->language->get('text_product_name');
		$this->data['text_product_model'] = $this->language->get('text_product_model');
		$this->data['text_product_tag'] = $this->language->get('text_product_tag');
		$this->data['text_product_manufacturer'] = $this->language->get('text_product_manufacturer');
		$this->data['text_product_quantity'] = $this->language->get('text_product_quantity');
		$this->data['text_product_description'] = $this->language->get('text_product_description');
		$this->data['text_product_sku'] = $this->language->get('text_product_sku');
		$this->data['text_product_upc'] = $this->language->get('text_product_upc');
		$this->data['text_product_ean'] = $this->language->get('text_product_ean');
		$this->data['text_product_jan'] = $this->language->get('text_product_jan');
		$this->data['text_product_isbn'] = $this->language->get('text_product_isbn');
		$this->data['text_product_mpn'] = $this->language->get('text_product_mpn');
		$this->data['text_all'] = $this->language->get('text_all');

		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_type'] = $this->language->get('entry_type');
		$this->data['entry_style'] = $this->language->get('entry_style');
		$this->data['entry_product'] = $this->language->get('entry_product');
		$this->data['entry_only_out_of_stock'] = $this->language->get('entry_only_out_of_stock');
		$this->data['entry_limit_bestseller'] = $this->language->get('entry_limit_bestseller');
		$this->data['entry_period'] = $this->language->get('entry_period');
		$this->data['entry_category'] = $this->language->get('entry_category');
		$this->data['entry_show_in_product'] = $this->language->get('entry_show_in_product');
		$this->data['entry_show_in'] = $this->language->get('entry_show_in');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_layout_position'] = $this->language->get('entry_layout_position');
		$this->data['entry_limitcategories'] = $this->language->get('entry_limitcategories');
		$this->data['entry_font_size'] = $this->language->get('entry_font_size');
		$this->data['entry_background_color'] = $this->language->get('entry_background_color');
		$this->data['entry_foreground_color'] = $this->language->get('entry_foreground_color');
		$this->data['entry_color'] = $this->language->get('entry_color');
		$this->data['entry_border'] = $this->language->get('entry_border');
		$this->data['entry_title'] = $this->language->get('entry_title');
		$this->data['entry_subtitle'] = $this->language->get('entry_subtitle');
		$this->data['entry_bold'] = $this->language->get('entry_bold');
		$this->data['entry_shadow'] = $this->language->get('entry_shadow');
		$this->data['entry_offsetx'] = $this->language->get('entry_offsetx');
		$this->data['entry_offsety'] = $this->language->get('entry_offsety');
		$this->data['entry_opacity'] = $this->language->get('entry_opacity');
		$this->data['entry_dimension'] = $this->language->get('entry_dimensions');
		$this->data['entry_width'] = $this->language->get('entry_width');
		$this->data['entry_height'] = $this->language->get('entry_height');
		$this->data['entry_image'] = $this->language->get('entry_image');
		$this->data['entry_start_date'] = $this->language->get('entry_start_date');
		$this->data['entry_end_date'] = $this->language->get('entry_end_date');
		$this->data['entry_priority'] = $this->language->get('entry_priority');
		$this->data['entry_hide_when_lower_priority'] = $this->language->get('entry_hide_when_lower_priority');
		$this->data['entry_custom_css'] = $this->language->get('entry_custom_css');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_label'] = $this->language->get('button_add_label');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_update'] = $this->language->get('button_update');
		
		$this->data['tab_label'] = 'Label';

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('module/intelligent_product_labels', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/intelligent_product_labels', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['token'] = $this->session->data['token'];

		$this->data['labels'] = array();
		
		if (isset($this->request->post['intelligent_product_labels_module'])) {
			$this->data['labels'] = $this->request->post['intelligent_product_labels_module'];
			// echo '<pre>'.print_r($this->config->get('intelligent_product_labels_module'),true).'</pre>';
		} else {
			$this->data['labels'] = $this->config->get('intelligent_product_labels_module');
			// echo '<pre>'.print_r($this->config->get('intelligent_product_labels_module'),true).'</pre>';
		}

		if (!isset($this->data['labels'])) { $this->data['labels'] = array(); }

		// we create thumbs

		$thumbs = array();
		$id_label = 1;
		$this->load->model('tool/image');
		foreach ($this->data['labels'] as $label) {
			
			if (!empty($label['image']) && file_exists(DIR_IMAGE . $label['image'])) {
				$thumbs[$id_label] = $this->model_tool_image->resize($label['image'], 100, 100);
			} else {
				$thumbs[$id_label] = $this->model_tool_image->resize('blank.jpg', 100, 20);
			}
			$id_label++;
		}

		$this->data['thumbs'] = $thumbs;

		// we load manual products

		$this->load->model('catalog/product');
		
		$products = array();
		$id_label = 1;
		foreach ($this->data['labels'] as $label) {
			$products[$id_label] = explode(',', isset($label['manual_products']) ? $label['manual_products'] : '');
			$id_label++;
		}

		$this->data['products'] = array();
		
		$id_label = 1;
		foreach ($this->data['labels'] as $value) {
			foreach ($products[$id_label] as $product_id) {
				$product_info = $this->model_catalog_product->getProduct($product_id);
				
				if (isset($product_info['product_id']) && isset($product_info['name']) ) {
					$this->data['products'][$id_label][] = array(
						'product_id' => $product_info['product_id'],
						'name'       => $product_info['name']
					);
				}
			}
			$id_label++;
		}

		// we load manual categories

		$this->load->model('module/intelligent_product_labels');
		
		$products = array();
		$id_label = 1;
		foreach ($this->data['labels'] as $label) {
			$categories[$id_label] = explode(',', isset($label['manual_categories']) ? $label['manual_categories'] : '');
			$id_label++;
		}

		$this->data['categories'] = array();
		
		$id_label = 1;
		foreach ($this->data['labels'] as $value) {
			foreach ($categories[$id_label] as $category_id) {
				$category_info = $this->model_module_intelligent_product_labels->getCategoryAutocomplete($category_id);
				
				if ($category_info) {
					$this->data['categories'][$id_label][] = array(
						'category_id' => $category_info['category_id'],
						'name'       => $category_info['name']
					);
				}
			}
			$id_label++;
		}

		// we load limit categories

		$products = array();
		$id_label = 1;
		foreach ($this->data['labels'] as $label) {
			$categories[$id_label] = explode(',', isset($label['limitcategories']) ? $label['limitcategories'] : '');
			$id_label++;
		}

		$this->data['limitcategories'] = array();
		
		$id_label = 1;
		foreach ($this->data['labels'] as $value) {
			foreach ($categories[$id_label] as $category_id) {
				$category_info = $this->model_module_intelligent_product_labels->getCategoryAutocomplete($category_id);
				
				if ($category_info) {
					$this->data['limitcategories'][$id_label][] = array(
						'category_id' => $category_info['category_id'],
						'name'       => $category_info['name']
					);
				}
			}
			$id_label++;
		}

		// we load languages	

		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		$array_temp = array_values($this->data['languages']);
		$this->data['first_language_id'] = $array_temp[0]['language_id'];

		// we get module names

		$this->language->load('module/featured');
		$this->data['featured_module_name'] = $this->language->get('heading_title');

		$this->language->load('module/latest');
		$this->data['latest_module_name'] = $this->language->get('heading_title');
		
		$this->language->load('module/special');
		$this->data['special_module_name'] = $this->language->get('heading_title');

		$this->language->load('module/bestseller');
		$this->data['bestseller_module_name'] = $this->language->get('heading_title');


		// types / apply to

		$this->data['types'] = array('featured'=>$this->data['featured_module_name'],
									 'latest'=>$this->data['latest_module_name'],
									 'special'=>$this->data['special_module_name'],
									 'bestseller'=>$this->data['bestseller_module_name'],
									 'stock'=>$this->data['text_stock'],
									 'free_shipping'=>$this->language->get('text_free_shipping'),
									 'category'=>$this->data['text_categories'],
									 'manual'=>$this->language->get('text_manual'),
									 'all_products'=>$this->language->get('text_all_products'),
									 'regex'=>$this->language->get('text_regex'));

		// regex product properties

		$this->data['product_properties'] = array('name'=>$this->data['text_product_name'],
												  'model'=>$this->data['text_product_model'],
												  'tag'=>$this->data['text_product_tag'],
												  'description'=>$this->data['text_product_description'],
												  'manufacturer'=>$this->data['text_product_manufacturer'],
												  'quantity'=>$this->data['text_product_quantity'],
												  'sku'=>$this->data['text_product_sku'],
												  'upc'=>$this->data['text_product_upc'],
												  'ean'=>$this->data['text_product_ean'],
												  'jan'=>$this->data['text_product_jan'],
												  'isbn'=>$this->data['text_product_isbn'],
												  'mpn'=>$this->data['text_product_mpn']);

		// styles

		$this->data['styles'] = array('horizontal'=>$this->language->get('text_horizontal_label'),
									  'rotated'=>$this->language->get('text_rotated_label'),
									  'round'=>$this->language->get('text_round_label'));

		// positions

		$this->data['positions'] = array('top_left'=>$this->language->get('text_top_left'),
									  	 'top_right'=>$this->language->get('text_top_right'),
									  	 'bottom_left'=>$this->language->get('text_bottom_left'),
									  	 'bottom_right'=>$this->language->get('text_bottom_right'),
									  	 'position_manual'=>$this->language->get('text_position_manual'));

		// layout positions

		$this->data['layout_positions'] = array('content_top'=>$this->language->get('text_content_top'),
									  	 'content_bottom'=>$this->language->get('text_content_bottom'),
									  	 'column_left'=>$this->language->get('text_column_left'),
									  	 'column_right'=>$this->language->get('text_column_right'));		

		// periods

		$this->data['periods'] = array('1'=>$this->language->get('text_one_day'),
									   '7'=>$this->language->get('text_one_week'),
									   '15'=>$this->language->get('text_two_weeks'),
									   '30'=>$this->language->get('text_one_month'),
									   '90'=>$this->language->get('text_three_months'),
									   '180'=>$this->language->get('text_six_months'),
									   '365'=>$this->language->get('text_one_year'));

		// limit bestsellers

		$this->data['limits_bestseller'] = array('1'=>'1',
												 '2'=>'2',
												 '3'=>'3',
												 '5'=>'5',
												 '10'=>'10',
												 '15'=>'15',
												 '20'=>'20',
												 '25'=>'25');

		// opacity

		$this->data['opacitys'] = array('1'  =>'100%',
										'0.9'=>'90%',
									    '0.8'=>'80%',
									    '0.7'=>'70%',
									    '0.6'=>'60%',
									    '0.5'=>'50%',
									    '0.4'=>'40%',
									    '0.3'=>'30%',
									    '0.2'=>'20%',
									    '0.1'=>'10%');


		// font size

		$this->data['font_sizes'] = array('0.5em'=>'-50%',
										  '0.6em'=>'-40%',
										  '0.7em'=>'-30%',
										  '0.8em'=>'-20%',
										  '0.9em'=>'-10%',
										  '1em'  =>$this->language->get('text_normal_size'),
								 		  '1.1em'=>'+10%',
									      '1.2em'=>'+20%',
										  '1.3em'=>'+30%',
										  '1.4em'=>'+40%',
										  '1.5em'=>'+50%',
										  '1.6em'=>'+60%',
										  '1.7em'=>'+70%',
										  '1.8em'=>'+80%',
										  '1.9em'=>'+90%',
										  '2em'  =>'+100%');

		// subtitle size

		$this->data['subtitle_sizes'] = array('10px' =>'XS',
								 		  	  '11px' =>'S',
								 		  	  '12px' =>'M',
								 		  	  '13px' =>'L',
								 		  	  '14px' =>'XL',
								 		  	  '16px' =>'XXL',
								 		  	  '20px' =>'XXXL',
								 		  	  '25px' =>'4XL');

		// dimensions

		$this->data['dimensions'] = array('auto'=>'Auto',
			                              'manual'=>'Manual');


		// show in module

		$this->data['show_in'] = array(
									'all'              =>$this->data['text_all'],
									'featured'         =>$this->data['featured_module_name'],
									'latest'           =>$this->data['latest_module_name'],
									'special'          =>$this->data['special_module_name'],
									'bestseller'       =>$this->data['bestseller_module_name'],
									'category'         =>$this->language->get('text_categories'),
									'productscategory' =>$this->language->get('text_irp'),
									'home'             =>$this->language->get('text_home')
								);

		// priority

		$this->data['priorities'] = array('0' =>'',
						 		  	      '1' =>'1',
						 		  	      '2' =>'2',
						 		  	      '3' =>'3');

		
		// we want to know url images for background-image

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			if (defined('HTTPS_IMAGE')) {
				$this->data['dirimage'] = HTTPS_IMAGE;
			} else {
				$this->data['dirimage'] = HTTPS_CATALOG . 'image/';
			}
		} else {
			if (defined('HTTP_IMAGE')) {
				$this->data['dirimage'] = HTTP_IMAGE;
			} else {
				$this->data['dirimage'] = HTTP_CATALOG . 'image/';
			}
		}

		// tooltips
		
		$tooltips = array();

		$tooltips['special'] = $this->language->get('text_tooltip_special');
		$tooltips['stock'] = $this->language->get('text_tooltip_stock');
		$tooltips['bestseller'] = $this->language->get('text_tooltip_bestseller');
		$tooltips['regex'] = $this->language->get('text_tooltip_regex');
		$tooltips['dimensions_round'] = $this->language->get('text_tooltip_dimensions_round');
		$tooltips['regex_title'] = $this->language->get('text_tooltip_regex_title');
		$tooltips['general'] = $this->language->get('text_tooltip_general');

		$this->data['tooltips'] = $tooltips;

		$this->template = 'module/intelligent_product_labels.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/intelligent_product_labels')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
?>