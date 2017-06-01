<?php
class ControllerModuleRecaptcha extends Controller {
	private $error = array(); 

	public function index() {   
		$this->language->load('module/recaptcha');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('recaptcha', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['text_module'] = $this->language->get('text_module');
		$this->data['text_help'] = $this->language->get('text_help');

		$this->data['entry_private_key'] = $this->language->get('entry_private_key');
		$this->data['entry_public_key'] = $this->language->get('entry_public_key');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');

		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');

 		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->error['private_key'])) {
			$this->data['error_private_key'] = $this->error['private_key'];
		} else {
			$this->data['error_private_key'] = '';
		}

		if (isset($this->error['public_key'])) {
			$this->data['error_public_key'] = $this->error['public_key'];
		} else {
			$this->data['error_public_key'] = '';
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
			'href'      => $this->url->link('module/recaptcha', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['action'] = $this->url->link('module/recaptcha', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		if (isset($this->request->post['private_key'])) {
			$this->data['private_key'] = $this->request->post['recaptcha_private_key'];
		} else {
			$this->data['private_key'] = $this->config->get('recaptcha_private_key');
		}

		if (isset($this->request->post['public_key'])) {
			$this->data['public_key'] = $this->request->post['recaptcha_public_key'];
		} else {
			$this->data['public_key'] = $this->config->get('recaptcha_public_key');
		}

		$this->template = 'module/recaptcha.tpl';
		$this->children = array(
			'common/header',
			'common/footer',
		);

		$this->response->setOutput($this->render());
	}

	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/recaptcha')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['recaptcha_private_key']) {
			$this->error['private_key'] = $this->language->get('error_private_key');
		}

		if (!$this->request->post['recaptcha_public_key']) {
			$this->error['public_key'] = $this->language->get('error_public_key');
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}
}
?>