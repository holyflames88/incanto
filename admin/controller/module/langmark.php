<?php
class ControllerModuleLangmark extends Controller
{
	private $error = array();
	public function index()
	{
		$this->data['langmark_version'] = '5.*';
		$this->data['oc_version'] = str_pad(str_replace(".", "", VERSION), 7, "0");


		$this->load->model('setting/setting');
		$settings_admin = $this->model_setting_setting->getSetting('langmarkversion', 'langmark_version');

		foreach ($settings_admin as $key => $value) {
			$this->data['langmark_version'] = $value;
		}

		$this->language->load('module/langmark');

		$langmark_version = $this->language->get('langmark_version');
		if ($this->data['langmark_version'] != $langmark_version) {
			$this->data['text_update'] = $this->language->get('text_update');
		}
		$this->document->setTitle(strip_tags($this->language->get('heading_title')));


		$this->install_front_loader();

		if (file_exists(DIR_APPLICATION . 'view/stylesheet/langmark.css')) {
			$this->document->addStyle('view/stylesheet/langmark.css');
		}
		$this->document->addStyle('http://fonts.googleapis.com/css?family=Open+Sans&subset=latin,cyrillic-ext,latin-ext');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->cache->delete('langmark');
			$this->cache->delete('html');
			$this->model_setting_setting->editSetting('langmark_options', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('module/langmark', 'token=' . $this->session->data['token'], 'SSL'));
		}
		$this->data['token'] = $this->session->data['token'];
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_what_langmark'] = $this->language->get('text_what_langmark');
		$this->data['text_what_list'] = $this->language->get('text_what_list');
		$this->data['text_what_all'] = $this->language->get('text_what_all');
		$this->data['text_what_hook'] = $this->language->get('text_what_hook');
		$this->data['entry_what'] = $this->language->get('entry_what');
		$this->data['entry_small_dim'] = $this->language->get('entry_small_dim');
		$this->data['entry_big_dim'] = $this->language->get('entry_big_dim');
		$this->data['entry_langmark_num_comments'] = $this->language->get('entry_langmark_num_comments');
		$this->data['entry_langmark_num_records'] = $this->language->get('entry_langmark_num_records');
		$this->data['entry_langmark_num_desc'] = $this->language->get('entry_langmark_num_desc');
		$this->data['entry_langmark_num_desc_words'] = $this->language->get('entry_langmark_num_desc_words');
		$this->data['entry_langmark_num_desc_pred'] = $this->language->get('entry_langmark_num_desc_pred');
		$this->data['entry_langmark_template'] = $this->language->get('entry_langmark_template');
		$this->data['entry_langmark_template_record'] = $this->language->get('entry_langmark_template_record');
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_list'] = $this->language->get('tab_list');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['url_langmark'] = $this->url->link('catalog/langmark', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_record'] = $this->url->link('catalog/record', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_fields'] = $this->url->link('catalog/fields', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_comment'] = $this->url->link('catalog/comment', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_create'] = $this->url->link('module/langmark/createtables', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_delete'] = $this->url->link('module/langmark/deletesettings', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_modules'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_modules_text'] = $this->language->get('url_modules_text');
		$this->data['url_langmark_text'] = $this->language->get('url_langmark_text');
		$this->data['url_record_text'] = $this->language->get('url_record_text');
		$this->data['url_fields_text'] = $this->language->get('url_fields_text');
		$this->data['url_comment_text'] = $this->language->get('url_comment_text');
		$this->data['url_create_text'] = $this->language->get('url_create_text');
		$this->data['url_delete_text'] = $this->language->get('url_delete_text');
		$this->data['url_options'] = $this->url->link('module/langmark', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_schemes'] = $this->url->link('module/langmark/schemes', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_widgets'] = $this->url->link('module/langmark/widgets', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['action'] = $this->url->link('module/langmark', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('localisation/language');

		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/langmark', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' / '
		);
		if (isset($this->request->post['general_set'])) {
			$this->data['general_set'] = $this->request->post['general_set'];
		} else {
			$this->data['general_set'] = $this->config->get('general_set');
		}
		if (isset($this->request->post['langmark_num_records'])) {
			$this->data['langmark_num_records'] = $this->request->post['langmark_num_records'];
		} else {
			$this->data['langmark_num_records'] = $this->config->get('langmark_num_records');
		}
		if (isset($this->request->post['langmark_num_comments'])) {
			$this->data['langmark_num_comments'] = $this->request->post['langmark_num_comments'];
		} else {
			$this->data['langmark_num_comments'] = $this->config->get('langmark_num_comments');
		}
		if (isset($this->request->post['langmark_num_desc'])) {
			$this->data['langmark_num_desc'] = $this->request->post['langmark_num_desc'];
		} else {
			$this->data['langmark_num_desc'] = $this->config->get('langmark_num_desc');
		}
		if (isset($this->request->post['langmark_num_desc_words'])) {
			$this->data['langmark_num_desc_words'] = $this->request->post['langmark_num_desc_words'];
		} else {
			$this->data['langmark_num_desc_words'] = $this->config->get('langmark_num_desc_words');
		}
		if (isset($this->request->post['langmark_num_desc_pred'])) {
			$this->data['langmark_num_desc_pred'] = $this->request->post['langmark_num_desc'];
		} else {
			$this->data['langmark_num_desc_pred'] = $this->config->get('langmark_num_desc_pred');
		}
		if (isset($this->request->post['langmark_resize'])) {
			$this->data['langmark_resize'] = $this->request->post['langmark_resize'];
		} else {
			$this->data['langmark_resize'] = $this->config->get('langmark_resize');
		}
		if (isset($this->request->post['general_set']['get_pagination'])) {
			$this->data['general_set']['get_pagination'] = $this->request->post['general_set']['get_pagination'];
		} else {
			if (isset($this->data['general_set']['get_pagination'])) {
				$this->data['general_set']['get_pagination'] = $this->data['general_set']['get_pagination'];
			} else {
				$this->data['general_set']['get_pagination'] = 'tracking';
			}
		}
		if (isset($this->data['general_set']['further'])) {
		} else {
			$this->data['general_set']['further'][$this->config->get('config_language_id')] = '<ins style="font-size: 18px; text-decoration: none;">&rarr;</ins>';
		}
		if (isset($this->request->post['langmark_small'])) {
			$this->data['langmark_small'] = $this->request->post['langmark_small'];
		} else {
			$this->data['langmark_small'] = $this->config->get('langmark_small');
		}
		if (isset($this->request->post['langmark_big'])) {
			$this->data['langmark_big'] = $this->request->post['langmark_big'];
		} else {
			$this->data['langmark_big'] = $this->config->get('langmark_big');
		}
		if (isset($this->request->post['general_list'])) {
			$this->data['general_list'] = $this->request->post['general_list'];
		} else {
			$this->data['general_list'] = $this->config->get('general_list');
		}
		if (count($this->data['general_list']) > 0) {
			ksort($this->data['general_list']);
		}
		$this->data['modules'] = array();
		if (isset($this->request->post['langmark_module'])) {
			$this->data['modules'] = $this->request->post['langmark_module'];
		} elseif ($this->config->get('langmark_module')) {
			$this->data['modules'] = $this->config->get('langmark_module');
		}
		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		$this->template = 'module/langmark.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		$this->response->setOutput($this->render());
	}
/***************************************/
	public function schemes()
	{
		$this->data['langmark_version'] = '5.*';

		$this->load->model('setting/setting');
		$settings_admin = $this->model_setting_setting->getSetting('langmarkversion', 'langmark_version');
		foreach ($settings_admin as $key => $value) {
			$this->data['langmark_version'] = $value;
		}
		$this->language->load('module/langmark');
		$langmark_version = $this->language->get('langmark_version');
		if ($this->data['langmark_version'] != $langmark_version) {
			$this->data['text_update'] = $this->language->get('text_update');
		}
		$this->document->setTitle(strip_tags($this->language->get('heading_title')));

		$this->install_front_loader();
		if (file_exists(DIR_APPLICATION . 'view/stylesheet/langmark.css')) {
			$this->document->addStyle('view/stylesheet/langmark.css');
		}
		$this->document->addStyle('http://fonts.googleapis.com/css?family=Open+Sans&subset=latin,cyrillic-ext,latin-ext');
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->cache->delete('langmark');

			$this->cache->delete('html');

			$this->model_setting_setting->editSetting('langmark_schemes', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('module/langmark/schemes', 'token=' . $this->session->data['token'], 'SSL'));
		}
		$this->data['token'] = $this->session->data['token'];
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_what_langmark'] = $this->language->get('text_what_langmark');
		$this->data['text_what_list'] = $this->language->get('text_what_list');
		$this->data['text_what_all'] = $this->language->get('text_what_all');
		$this->data['text_what_hook'] = $this->language->get('text_what_hook');
		$this->data['entry_what'] = $this->language->get('entry_what');
		$this->data['entry_small_dim'] = $this->language->get('entry_small_dim');
		$this->data['entry_big_dim'] = $this->language->get('entry_big_dim');
		$this->data['entry_langmark_num_comments'] = $this->language->get('entry_langmark_num_comments');
		$this->data['entry_langmark_num_records'] = $this->language->get('entry_langmark_num_records');
		$this->data['entry_langmark_num_desc'] = $this->language->get('entry_langmark_num_desc');
		$this->data['entry_langmark_num_desc_words'] = $this->language->get('entry_langmark_num_desc_words');
		$this->data['entry_langmark_num_desc_pred'] = $this->language->get('entry_langmark_num_desc_pred');
		$this->data['entry_langmark_template'] = $this->language->get('entry_langmark_template');
		$this->data['entry_langmark_template_record'] = $this->language->get('entry_langmark_template_record');
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_list'] = $this->language->get('tab_list');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['url_langmark'] = $this->url->link('catalog/langmark', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_record'] = $this->url->link('catalog/record', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_comment'] = $this->url->link('catalog/comment', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_create'] = $this->url->link('module/langmark/createtables', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_modules'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_modules_text'] = $this->language->get('url_modules_text');
		$this->data['url_langmark_text'] = $this->language->get('url_langmark_text');
		$this->data['url_record_text'] = $this->language->get('url_record_text');
		$this->data['url_comment_text'] = $this->language->get('url_comment_text');
		$this->data['url_create_text'] = $this->language->get('url_create_text');
		$this->data['url_options'] = $this->url->link('module/langmark', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_schemes'] = $this->url->link('module/langmark/schemes', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_widgets'] = $this->url->link('module/langmark/widgets', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['action'] = $this->url->link('module/langmark/schemes', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/langmark', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' / '
		);
		if (isset($this->request->post['general_list'])) {
			$this->data['general_list'] = $this->request->post['general_list'];
		} else {
			$this->data['general_list'] = $this->config->get('general_list');
		}
		if (count($this->data['general_list']) > 0) {
			ksort($this->data['general_list']);
		}
		$this->data['modules'] = array();
		if (isset($this->request->post['langmark_module'])) {
			$this->data['modules'] = $this->request->post['langmark_module'];
		} elseif ($this->config->get('langmark_module')) {
			$this->data['modules'] = $this->config->get('langmark_module');
		}
		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		$this->template = 'module/langmark_schemes.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		$this->response->setOutput($this->render());
	}
/***************************************/
	public function widgets()
	{
		$this->data['langmark_version'] = '5.*';

		$this->load->model('setting/setting');
		$settings_admin = $this->model_setting_setting->getSetting('langmarkversion', 'langmark_version');
		foreach ($settings_admin as $key => $value) {
			$this->data['langmark_version'] = $value;
		}
		$this->language->load('module/langmark');
		$langmark_version = $this->language->get('langmark_version');
		if ($this->data['langmark_version'] != $langmark_version) {
			$this->data['text_update'] = $this->language->get('text_update');
		}
		$this->document->setTitle(strip_tags($this->language->get('heading_title')));

		$this->install_front_loader();
		if (file_exists(DIR_APPLICATION . 'view/stylesheet/langmark.css')) {
			$this->document->addStyle('view/stylesheet/langmark.css');
		}
		$this->document->addStyle('http://fonts.googleapis.com/css?family=Open+Sans&subset=latin,cyrillic-ext,latin-ext');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->cache->delete('langmark');
			$this->cache->delete('html');
			$this->model_setting_setting->editSetting('langmark_widgets', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success');
			$this->redirect($this->url->link('module/langmark/widgets', 'token=' . $this->session->data['token'], 'SSL'));
		}
		$this->data['token'] = $this->session->data['token'];
		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');
		$this->data['text_content_top'] = $this->language->get('text_content_top');
		$this->data['text_content_bottom'] = $this->language->get('text_content_bottom');
		$this->data['text_column_left'] = $this->language->get('text_column_left');
		$this->data['text_column_right'] = $this->language->get('text_column_right');
		$this->data['text_what_langmark'] = $this->language->get('text_what_langmark');
		$this->data['text_what_list'] = $this->language->get('text_what_list');
		$this->data['text_what_all'] = $this->language->get('text_what_all');
		$this->data['text_what_hook'] = $this->language->get('text_what_hook');
		$this->data['entry_what'] = $this->language->get('entry_what');
		$this->data['entry_small_dim'] = $this->language->get('entry_small_dim');
		$this->data['entry_big_dim'] = $this->language->get('entry_big_dim');
		$this->data['entry_langmark_num_comments'] = $this->language->get('entry_langmark_num_comments');
		$this->data['entry_langmark_num_records'] = $this->language->get('entry_langmark_num_records');
		$this->data['entry_langmark_num_desc'] = $this->language->get('entry_langmark_num_desc');
		$this->data['entry_langmark_num_desc_words'] = $this->language->get('entry_langmark_num_desc_words');
		$this->data['entry_langmark_num_desc_pred'] = $this->language->get('entry_langmark_num_desc_pred');
		$this->data['entry_langmark_template'] = $this->language->get('entry_langmark_template');
		$this->data['entry_langmark_template_record'] = $this->language->get('entry_langmark_template_record');
		$this->data['tab_general'] = $this->language->get('tab_general');
		$this->data['tab_list'] = $this->language->get('tab_list');
		$this->data['entry_layout'] = $this->language->get('entry_layout');
		$this->data['entry_position'] = $this->language->get('entry_position');
		$this->data['entry_status'] = $this->language->get('entry_status');
		$this->data['entry_sort_order'] = $this->language->get('entry_sort_order');
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_cancel'] = $this->language->get('button_cancel');
		$this->data['button_add_module'] = $this->language->get('button_add_module');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['url_langmark'] = $this->url->link('catalog/langmark', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_record'] = $this->url->link('catalog/record', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_comment'] = $this->url->link('catalog/comment', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_create'] = $this->url->link('module/langmark/createtables', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_modules'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_modules_text'] = $this->language->get('url_modules_text');
		$this->data['url_langmark_text'] = $this->language->get('url_langmark_text');
		$this->data['url_record_text'] = $this->language->get('url_record_text');
		$this->data['url_comment_text'] = $this->language->get('url_comment_text');
		$this->data['url_create_text'] = $this->language->get('url_create_text');
		$this->data['url_options'] = $this->url->link('module/langmark', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_schemes'] = $this->url->link('module/langmark/schemes', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['url_widgets'] = $this->url->link('module/langmark/widgets', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['action'] = $this->url->link('module/langmark/widgets', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		if (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}
		$this->data['breadcrumbs'] = array();
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_module'),
			'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		$this->data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('module/langmark', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' / '
		);
		if (isset($this->request->post['general_list'])) {
			$this->data['general_list'] = $this->request->post['general_list'];
		} else {
			$this->data['general_list'] = $this->config->get('general_list');
		}
		if (count($this->data['general_list']) > 0) {
			ksort($this->data['general_list']);
		}
		$this->data['modules'] = array();
		if (isset($this->request->post['langmark_module'])) {
			$this->data['modules'] = $this->request->post['langmark_module'];
		} elseif ($this->config->get('langmark_module')) {
			$this->data['modules'] = $this->config->get('langmark_module');
		}
		$this->load->model('design/layout');
		$this->data['layouts'] = $this->model_design_layout->getLayouts();
		$this->template = 'module/langmark_widgets.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		$this->response->setOutput($this->render());
	}
/***************************************/
	public function install_front_loader()
	{
		$html = '';
		$file = DIR_CATALOG . 'controller/common/maintenance.php';
		$agoodonut_version = '5.0';
		$admin_url = $this->http_catalog();
		$text_footer = file_get_contents($file, FILE_USE_INCLUDE_PATH);
		$findme = "langmark_version";
		$pos = strpos($text_footer, $findme);
		if ($pos === false) {
			$text = "<?php \$langmark_version='" . $agoodonut_version . "';
		\$file = DIR_SYSTEM . 'library/langmark_loader.php';
		if (file_exists(\$file)) {include_once(\$file);}
\$langmark_version='" . $agoodonut_version . "'; ?>";
			$this->dir_permissions($file);
			if (file_exists($file)) {
				if (is_writable($file)) {
					$f = @fopen($file, 'a');
					@fwrite($f, $text);
					@fclose($f);
				} else {
					$html .= $this->language->get('access_777') . "<br>";
				}
			}
		}
		return $html;
	}
/***************************************/
	private function remove_front_loader()
	{
		$html = "<br>";
		$file = DIR_CATALOG . 'controller/common/maintenance.php';
		if (file_exists($file)) {
			$text = file_get_contents($file, FILE_USE_INCLUDE_PATH);
			$this->dir_permissions($file);
			$text = preg_replace("!<[\?]php [\$]langmark_version(.*?)[\?]>!s", "", $text);
			if (is_writable($file)) {
				$f = @fopen($file, 'w');
				@fwrite($f, $text);
				@fclose($f);
				$html .= 'Ok<br>';
			} else {
				$html .= $file . "<br>" . $this->language->get('access_777') . "<br>";
			}
		}
		return $html;
	}
/***************************************/
	public function uninstall()
	{
		$this->remove_front_loader();

	}
/***************************************/
	public function install()
	{
		$this->createTables();
		$array_dir_image = str_split(DIR_IMAGE);
		$array_dir_app = str_split(DIR_APPLICATION);
		$i = 0;
		$dir_root = '';
		while ($array_dir_image[$i] == $array_dir_app[$i]) {
			$dir_root .= $array_dir_image[$i];
			$i++;
		}
	}
/***************************************/
	public function ajax_list()
	{
		$this->data['token'] = $this->session->data['token'];
		$this->language->load('module/langmark');
		$this->data['text_enabled'] = $this->language->get('text_enabled');
		$this->data['text_disabled'] = $this->language->get('text_disabled');

		$this->load->model('localisation/language');
		$this->data['languages'] = $this->model_localisation_language->getLanguages();
		if (isset($this->request->post['list'])) {
			$str = base64_decode($this->request->post['list']);
			$list = unserialize($str);
		} else {
			$list = Array();
		}
		if (isset($this->request->post['num'])) {
			$num = $this->request->post['num'];
		}
		$this->data['general_list'][$num] = $list;
		if (isset($this->request->post['type'])) {
			$this->data['general_list'][$num]['type'] = $this->request->post['type'];
		} else {
		}

		if ($this->data['general_list'][$num]['type'] == 'html') {
			$this->template = 'module/langmark_list_html.tpl';
		}

		if (!isset($this->data['general_list'][$num]['anchor']) && $this->data['general_list'][$num]['type'] == 'html') {
			$this->data['general_list'][$num]['anchor'] = "\$('#language').html(langmarkdata);";
		}
		if (count($this->data['general_list']) > 0) {
			reset($this->data['general_list']);
			$first_key = key($this->data['general_list']);
			foreach ($this->data['general_list'] as $num => $list) {
				$this->data['slist'] = serialize($list);
			}
		}
		$this->response->setOutput($this->render());
	}
/***************************************/
	public function autocomplete_template()
	{
		$json = array();
		if (isset($this->request->get['path'])) {
			if (isset($this->request->get['path'])) {
				$path = $this->request->get['path'];
			} else {
				$path = '';
			}

			$this->data['widgets_full_path_default'] = array();
			$this->data['widgets_full_path_theme'] = array();
			$this->data['widgets_full_path_default'] = $this->msearchdir(DIR_CATALOG . "view/theme/default/template/agoodonut/" . $path);
			$this->data['widgets_full_path_theme'] = $this->msearchdir(DIR_CATALOG . "view/theme/" . $this->config->get('config_template') . "/template/agoodonut/" . $path);
			$this->data['widgets_full_path'] = array_replace_recursive($this->data['widgets_full_path_default'], $this->data['widgets_full_path_theme']);
			$i = 0;
			foreach ($this->data['widgets_full_path'] as $widget_full_path) {
				$dname = str_replace(DIR_CATALOG . "view/theme/default/template/agoodonut/" . $path . "/", '', $widget_full_path);
				$ename = str_replace(DIR_CATALOG . "view/theme/" . $this->config->get('config_template') . "/template/agoodonut/" . $path . "/", '', $dname);
				$this->data['widgets'][$i]['name'] = $ename;
				$i++;
			}
			foreach ($this->data['widgets'] as $result) {
				$json[] = array(
					'name' => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8'))
				);
			}
		}
		$this->response->setOutput(json_encode($json));
	}
/***************************************/
	public function msearchdir($path, $mode = "FULL", $myself = false, $maxdepth = -1, $d = 0)
	{
		$dirlist = array();
		if (!file_exists($path)) {
			return $dirlist;
		}
		if (substr($path, strlen($path) - 1) != '/') {
			$path .= '/';
		}
		if ($mode != "FILES") {
			if ($d != 0 || $myself)
				$dirlist[] = $path;
		}
		if ($handle = opendir($path)) {
			while (false !== ($file = readdir($handle))) {
				if ($file != '.' && $file != '..') {
					$file = $path . $file;
					if (!is_dir($file)) {
						if ($mode != "DIRS") {
							$dirlist[] = $file;
						}
					} elseif ($d >= 0 && ($d < $maxdepth || $maxdepth < 0)) {
						$result = $this->msearchdir($file . '/', $mode, $myself, $maxdepth, $d + 1);
						$dirlist = array_merge($dirlist, $result);
					}
				}
			}
			closedir($handle);
		}
		if ($d == 0) {
			natcasesort($dirlist);
		}
		return ($dirlist);
	}
/***************************************/
	private function validate()
	{
		$this->language->load('module/langmark');
		if (!$this->user->hasPermission('modify', 'module/langmark')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (!$this->error) {
			return true;
		} else {
			$this->request->post = array();
			return false;
		}
	}
/***************************************/
	private function http_catalog()
	{
		if (!defined('HTTPS_CATALOG')) {
			$https_catalog = HTTP_CATALOG;
		} else {
			$https_catalog = HTTPS_CATALOG;
		}
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			return $https_catalog;
		} else {
			return HTTP_CATALOG;
		}
	}
/***************************************/
	public function cont($cont)
	{
		$file = DIR_CATALOG . 'controller/' . $cont . '.php';
		$class = 'Controller' . preg_replace('/[^a-zA-Z0-9]/', '', $cont);
		if (file_exists($file)) {
			include_once($file);
			$this->registry->set('controller_' . str_replace('/', '_', $cont), new $class($this->registry));
		} else {
			trigger_error('Error: Could not load controller ' . $cont . '!');
			exit();
		}
	}

/***************************************/
	public function deletesettings()
	{

	    if (($this->request->server['REQUEST_METHOD'] == 'GET') && $this->validate()) {
		    $html = "";
			$this->language->load('module/langmark');
			$html .= $this->remove_front_loader();
			$this->load->model('setting/setting');

			$this->model_setting_setting->deleteSetting('langmarkversion');
			$this->model_setting_setting->deleteSetting('langmark_options');
			$this->model_setting_setting->deleteSetting('langmark_schemes');
			$this->model_setting_setting->deleteSetting('langmark_widgets');
			$html = "Ok";
			$this->response->setOutput($html);
		} else {
			$html = "Error permissions";
			$this->response->setOutput($html);
		}
	}



/***************************************/
	public function createTables()
	{
         if (($this->request->server['REQUEST_METHOD'] == 'GET') && $this->validate()) {
            $html = "";
			$this->language->load('module/langmark');
			$this->data['langmark_version'] = $this->language->get('langmark_version');
			$this->load->model('setting/setting');

			$setting_version = Array(
				'langmark_version' => $this->data['langmark_version']
			);
			$this->model_setting_setting->editSetting('langmarkversion', $setting_version);


			$msql = "SELECT * FROM `" . DB_PREFIX . "layout_route` WHERE `route`='product/search'";
			$query = $this->db->query($msql);
			if (count($query->rows) <= 0) {
				$msql = "INSERT INTO `" . DB_PREFIX . "layout` (`name`) VALUES  ('Search');";
				$query = $this->db->query($msql);
				$msql = "INSERT INTO `" . DB_PREFIX . "layout_route` (`route`, `layout_id`) VALUES  ('product/search'," . $this->db->getLastId() . ");";
				$query = $this->db->query($msql);
			}


		if (!$this->config->get('general_list') && !is_array($this->config->get('general_list')))
		{
            $html .= $this->remove_front_loader();


            $aoptions = Array('switch' => '1', 'cache_widgets' => '0', 'pagination' => '0', 'pagination_prefix' => 'page');


			$aschemes[0] = Array('position' => 'content_top',
            'status' => '1',
            'what' => '1',
            'sort_order' => '0'
            );

            $this->load->model('design/layout');
			$layouts = $this->model_design_layout->getLayouts();

            foreach ($layouts as $layout) {
             $aschemes[0]['layout_id'][] = $layout['layout_id'] ;
            }

			$awidgets[1] = Array('type' => 'html','template' =>'', 'anchor' => "$('#language').html(langmarkdata);");

            $this->load->model('localisation/language');
			$languages = $this->model_localisation_language->getLanguages();
			foreach ($languages as $language) {


				$prefix = $language['code'].'/';
				if ($this->config->get('config_language') == $language['code']) {
					$prefix = '';
				}
				$aoptions['prefix'][$language['code']] = $prefix;

				$pagination_title = $this->language->get('text_pagination_title');

				if ($language['code'] == 'ru') {
					$pagination_title = $this->language->get('text_pagination_title_russian');
				}
				if ($language['code'] == 'ua') {
					$pagination_title = $this->language->get('text_pagination_title_ukraine');
				}


				$aoptions['pagination_title'][$language['code']] = $pagination_title;



				$awidgets[1]['title_list_latest'][$language['language_id']] = 'Language';

				$html_text = <<<EOF
<?php if (count(\$languages) > 1) { ?>
<?php echo \$text_language; ?>&nbsp;
<?php foreach (\$languages as \$language) {
if (\$language['code'] != \$language_code) {
?>
<a href="<?php echo \$language['url']; ?>"><?php } ?><img src="image/flags/<?php echo \$language['image']; ?>" alt="<?php echo \$language['name']; ?>" title="<?php echo \$language['name']; ?>" /><?php if (\$language['code'] != \$language_code) { ?></a>
<?php } } ?>
<?php } ?>
<script>
\$(document).ready(function() {
	var lprefix = '<?php  echo \$language_prefix; ?>';

	\$('form').each(function(index) {
		var laction = \$(this).attr('action');
		if (typeof laction!='undefined') {
		 if (typeof laction.value!='undefined') {
			var llast = laction.value.length - 1;
			if (llast != '/') {
				laction = laction + '/';
			}
			var li = laction.indexOf( lprefix);
			if (li < 0) {
				\$(this).attr('action', laction + lprefix);
			}
		 }
		}
	});
});
</script>
EOF;

$html_text = htmlspecialchars ($html_text, ENT_QUOTES, 'UTF-8');

                $awidgets[1]['html'][$language['language_id']] = $html_text;

			}


			$settings = Array(
				'general_list' => $awidgets
			);
			$this->model_setting_setting->editSetting('langmark_widgets', $settings);

			$settings = Array(
				'langmark_module' => $aschemes
			);
			$this->model_setting_setting->editSetting('langmark_schemes', $settings);

			$settings = Array(
				'general_set' => $aoptions
			);
			$this->model_setting_setting->editSetting('langmark_options', $settings);


			$html .= $this->language->get('ok_create_tables');

            $this->install_front_loader();

		} else {

		}
		$this->response->setOutput($html);
		}  else {
			$html = "Error permissions";
			$this->response->setOutput($html);
		}
	}

/***************************************/
	private function isAvailable($func)
	{
		if (ini_get('safe_mode'))
			return false;
		$disabled = ini_get('disable_functions');
		if ($disabled) {
			$disabled = explode(',', $disabled);
			$disabled = array_map('trim', $disabled);
			return !in_array($func, $disabled);
		}
		return true;
	}
/***************************************/
	private function dir_permissions($file)
	{
		error_reporting(0);
		set_error_handler('agoo_error_handler');
		if ($this->isAvailable('exec')) {
			$files = array(
				$file
			);
			@exec('chmod 7777 ' . implode(' ', $files));
			@exec('chmod 0777 ' . implode(' ', $files));
		}
		@umask(0);
		@chmod($file, 0777);
		restore_error_handler();
		error_reporting(E_ALL);
	}
}
/***************************************/
if (!function_exists('agoo_error_handler')) {
	function agoo_error_handler($errno, $errstr)
	{
	}
}
/***************************************/
if (!function_exists('array_replace_recursive')) {
	function array_replace_recursive($array, $array1)
	{
		function recurse($array, $array1)
		{
			foreach ($array1 as $key => $value) {
				if (!isset($array[$key]) || (isset($array[$key]) && !is_array($array[$key]))) {
					$array[$key] = array();
				}
				if (is_array($value)) {
					$value = recurse($array[$key], $value);
				}
				$array[$key] = $value;
			}
			return $array;
		}
		$args = func_get_args();
		$array = $args[0];
		if (!is_array($array)) {
			return $array;
		}
		for ($i = 1; $i < count($args); $i++) {
			if (is_array($args[$i])) {
				$array = recurse($array, $args[$i]);
			}
		}
		return $array;
	}
}
/***************************************/
?>