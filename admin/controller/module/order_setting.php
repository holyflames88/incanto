<?php
class ControllerModuleOrdersetting extends Controller {
	private $error = array(); 
	
	public function index() {   
		$this->language->load('module/order_setting');

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('setting/setting');
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {	
			$this->model_setting_setting->editSetting('order_setting', $this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}		
				
		$this->data['heading_title'] = $this->language->get('heading_title');

		
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		
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
			'href'      => $this->url->link('module/order_setting', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => ' :: '
   		);
		
		$this->data['action'] = $this->url->link('module/order_setting', 'token=' . $this->session->data['token'], 'SSL');
		
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['token'] = $this->session->data['token'];	
		
		$this->data['text_yes'] = $this->language->get('text_yes');
		$this->data['text_no'] = $this->language->get('text_no');
		$this->data['on_off_podbem'] = $this->language->get('on_off_podbem');
		$this->data['on_off_sborka'] = $this->language->get('on_off_sborka');
		$this->data['on_off_manager'] = $this->language->get('on_off_manager');
		$this->data['on_off_dostavka'] = $this->language->get('on_off_dostavka');
		$this->data['on_off_tochka'] = $this->language->get('on_off_tochka');
		$this->data['on_off_postavshik'] = $this->language->get('on_off_postavshik');
		$this->data['on_off_send_mail_user'] = $this->language->get('on_off_send_mail_user');
		$this->data['on_off_comment_manager'] = $this->language->get('on_off_comment_manager');
		$this->data['on_off_product_column'] = $this->language->get('on_off_product_column');
		$this->data['on_off_zakupka'] = $this->language->get('on_off_zakupka');
		$this->data['on_off_cost_delivery'] = $this->language->get('on_off_cost_delivery');
		$this->data['on_off_profit'] = $this->language->get('on_off_profit');
		$this->data['entry_login_send_sms'] = $this->language->get('entry_login_send_sms');
		$this->data['entry_pass_send_sms'] = $this->language->get('entry_pass_send_sms');
		$this->data['register_site'] = $this->language->get('register_site');
		$this->data['on_off_sku'] = $this->language->get('on_off_sku');
		$this->data['on_off_product_colorbox'] = $this->language->get('on_off_product_colorbox');
		
		if (isset($this->request->post['config_on_off_product_column'])) {
			$this->data['config_on_off_product_column'] = $this->request->post['config_on_off_product_column'];
		} else {
			$this->data['config_on_off_product_column'] = $this->config->get('config_on_off_product_column');
		}
		if (isset($this->request->post['config_on_off_comment_manager'])) {
			$this->data['config_on_off_comment_manager'] = $this->request->post['config_on_off_comment_manager'];
		} else {
			$this->data['config_on_off_comment_manager'] = $this->config->get('config_on_off_comment_manager');
		}
		if (isset($this->request->post['config_on_off_send_mail_user'])) {
			$this->data['config_on_off_send_mail_user'] = $this->request->post['config_on_off_send_mail_user'];
		} else {
			$this->data['config_on_off_send_mail_user'] = $this->config->get('config_on_off_send_mail_user');
		}
		if (isset($this->request->post['config_on_off_podbem'])) {
			$this->data['config_on_off_podbem'] = $this->request->post['config_on_off_podbem'];
		} else {
			$this->data['config_on_off_podbem'] = $this->config->get('config_on_off_podbem');
		}
		if (isset($this->request->post['config_on_off_sborka'])) {
			$this->data['config_on_off_sborka'] = $this->request->post['config_on_off_sborka'];
		} else {
			$this->data['config_on_off_sborka'] = $this->config->get('config_on_off_sborka');
		}
		if (isset($this->request->post['config_on_off_manager'])) {
			$this->data['config_on_off_manager'] = $this->request->post['config_on_off_manager'];
		} else {
			$this->data['config_on_off_manager'] = $this->config->get('config_on_off_manager');
		}
		if (isset($this->request->post['config_on_off_dostavka'])) {
			$this->data['config_on_off_dostavka'] = $this->request->post['config_on_off_dostavka'];
		} else {
			$this->data['config_on_off_dostavka'] = $this->config->get('config_on_off_dostavka');
		}
		if (isset($this->request->post['config_on_off_tochka'])) {
			$this->data['config_on_off_tochka'] = $this->request->post['config_on_off_tochka'];
		} else {
			$this->data['config_on_off_tochka'] = $this->config->get('config_on_off_tochka');
		}
		if (isset($this->request->post['config_on_off_postavshik'])) {
			$this->data['config_on_off_postavshik'] = $this->request->post['config_on_off_postavshik'];
		} else {
			$this->data['config_on_off_postavshik'] = $this->config->get('config_on_off_postavshik');
		}
		if (isset($this->request->post['config_on_off_zakupka'])) {
			$this->data['config_on_off_zakupka'] = $this->request->post['config_on_off_zakupka'];
		} else {
			$this->data['config_on_off_zakupka'] = $this->config->get('config_on_off_zakupka');
		}
		if (isset($this->request->post['config_on_off_cost_delivery'])) {
			$this->data['config_on_off_cost_delivery'] = $this->request->post['config_on_off_cost_delivery'];
		} else {
			$this->data['config_on_off_cost_delivery'] = $this->config->get('config_on_off_cost_delivery');
		}
		if (isset($this->request->post['config_on_off_profit'])) {
			$this->data['config_on_off_profit'] = $this->request->post['config_on_off_profit'];
		} else {
			$this->data['config_on_off_profit'] = $this->config->get('config_on_off_profit');
		}
		if (isset($this->request->post['config_send_sms_on_off_order'])) {
			$this->data['config_send_sms_on_off_order'] = $this->request->post['config_send_sms_on_off_order'];
		} else {
			$this->data['config_send_sms_on_off_order'] = $this->config->get('config_send_sms_on_off_order');
		}
		if (isset($this->request->post['config_login_send_sms_order'])) {
			$this->data['config_login_send_sms_order'] = $this->request->post['config_login_send_sms_order'];
		} else {
			$this->data['config_login_send_sms_order'] = $this->config->get('config_login_send_sms_order');
		}
		if (isset($this->request->post['config_pass_send_sms_order'])) {
			$this->data['config_pass_send_sms_order'] = $this->request->post['config_pass_send_sms_order'];
		} else {
			$this->data['config_pass_send_sms_order'] = $this->config->get('config_pass_send_sms_order');
		}
		
		if (isset($this->request->post['config_on_off_sku'])) {
			$this->data['config_on_off_sku'] = $this->request->post['config_on_off_sku'];
		} else {
			$this->data['config_on_off_sku'] = $this->config->get('config_on_off_sku');
		}
		if (isset($this->request->post['config_on_off_product_colorbox'])) {
			$this->data['config_on_off_product_colorbox'] = $this->request->post['config_on_off_product_colorbox'];
		} else {
			$this->data['config_on_off_product_colorbox'] = $this->config->get('config_on_off_product_colorbox');
		}
		/*HOME SETTING*/	
		
		

		if (isset($this->request->post['config_on_off_product_column_home'])) {
			$this->data['config_on_off_product_column_home'] = $this->request->post['config_on_off_product_column_home'];
		} else {
			$this->data['config_on_off_product_column_home'] = $this->config->get('config_on_off_product_column_home');
		}

		if (isset($this->request->post['config_on_off_comment_manager_home'])) {
			$this->data['config_on_off_comment_manager_home'] = $this->request->post['config_on_off_comment_manager_home'];
		} else {
			$this->data['config_on_off_comment_manager_home'] = $this->config->get('config_on_off_comment_manager_home');
		}
		if (isset($this->request->post['config_on_off_podbem_home'])) {
			$this->data['config_on_off_podbem_home'] = $this->request->post['config_on_off_podbem_home'];
		} else {
			$this->data['config_on_off_podbem_home'] = $this->config->get('config_on_off_podbem_home');
		}
		if (isset($this->request->post['config_on_off_sborka_home'])) {
			$this->data['config_on_off_sborka_home'] = $this->request->post['config_on_off_sborka_home'];
		} else {
			$this->data['config_on_off_sborka_home'] = $this->config->get('config_on_off_sborka_home');
		}

		if (isset($this->request->post['config_on_off_manager_home'])) {
			$this->data['config_on_off_manager_home'] = $this->request->post['config_on_off_manager_home'];
		} else {
			$this->data['config_on_off_manager_home'] = $this->config->get('config_on_off_manager_home');
		}
		if (isset($this->request->post['config_on_off_dostavka_home'])) {
			$this->data['config_on_off_dostavka_home'] = $this->request->post['config_on_off_dostavka_home'];
		} else {
			$this->data['config_on_off_dostavka_home'] = $this->config->get('config_on_off_dostavka_home');
		}
		if (isset($this->request->post['config_on_off_tochka_home'])) {
			$this->data['config_on_off_tochka_home'] = $this->request->post['config_on_off_tochka_home'];
		} else {
			$this->data['config_on_off_tochka_home'] = $this->config->get('config_on_off_tochka_home');
		}

		if (isset($this->request->post['config_on_off_postavshik_home'])) {
			$this->data['config_on_off_postavshik_home'] = $this->request->post['config_on_off_postavshik_home'];
		} else {
			$this->data['config_on_off_postavshik_home'] = $this->config->get('config_on_off_postavshik_home');
		}
		if (isset($this->request->post['config_on_off_sku_home'])) {
			$this->data['config_on_off_sku_home'] = $this->request->post['config_on_off_sku_home'];
		} else {
			$this->data['config_on_off_sku_home'] = $this->config->get('config_on_off_sku_home');
		}










		
		$this->load->model('design/layout');
		
		$this->data['layouts'] = $this->model_design_layout->getLayouts();

		$this->template = 'module/order_setting.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
	}
	
	protected function validate() {
		if (!$this->user->hasPermission('modify', 'module/order_setting')) {
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