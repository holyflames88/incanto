<?php
class ControllerShippingflatcomslub extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->load->language('shipping/flatcomslub');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('flatcomslub', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'));
		}
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_all_zones'] = $this->language->get('text_all_zones');
		$this->data['text_none'] = $this->language->get('text_none');
		
		$this->data['entry_cost'] = $this->language->get('entry_cost');
		$this->data['entry_tax_class'] = $this->language->get('entry_tax_class');
		$this->data['entry_geo_zone'] = $this->language->get('entry_geo_zone');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

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
       		'text'      => $this->language->get('text_shipping'),
			'href'      => $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('shipping/flatcomslub', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('shipping/flatcomslub', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/shipping', 'token=' . $this->session->data['token'], 'SSL');
		
		if (isset($this->request->post['flatcomslub_cost'])) {
			$this->data['flatcomslub_cost'] = $this->request->post['flatcomslub_cost'];
		} else {
			$this->data['flatcomslub_cost'] = $this->config->get('flatcomslub_cost');
		}

		if (isset($this->request->post['flatcomslub_tax_class_id'])) {
			$this->data['flatcomslub_tax_class_id'] = $this->request->post['flatcomslub_tax_class_id'];
		} else {
			$this->data['flatcomslub_tax_class_id'] = $this->config->get('flatcomslub_tax_class_id');
		}

		if (isset($this->request->post['flatcomslub_geo_zone_id'])) {
			$this->data['flatcomslub_geo_zone_id'] = $this->request->post['flatcomslub_geo_zone_id'];
		} else {
			$this->data['flatcomslub_geo_zone_id'] = $this->config->get('flatcomslub_geo_zone_id');
		}
		
		if (isset($this->request->post['flatcomslub_status'])) {
			$this->data['flatcomslub_status'] = $this->request->post['flatcomslub_status'];
		} else {
			$this->data['flatcomslub_status'] = $this->config->get('flatcomslub_status');
		}
		
		if (isset($this->request->post['flatcomslub_sort_order'])) {
			$this->data['flatcomslub_sort_order'] = $this->request->post['flatcomslub_sort_order'];
		} else {
			$this->data['flatcomslub_sort_order'] = $this->config->get('flatcomslub_sort_order');
		}				

		$this->load->model('localisation/tax_class');
		
		$this->data['tax_classes'] = $this->model_localisation_tax_class->getTaxClasses();
		
		$this->load->model('localisation/geo_zone');
		
		$this->data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();
								
		$this->template = 'shipping/flatcomslub.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'shipping/flatcomslub')) {
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