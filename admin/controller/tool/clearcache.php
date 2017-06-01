<?php 
class ControllerToolClearcache extends Controller { 
	private $error = array();

	public function index() {		
		$this->language->load('tool/clearcache');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('tool/clearcache');

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['error_yes'] = $this->language->get('error_yes');
		$this->data['error_dont'] = $this->language->get('error_dont');

		if (isset($this->session->data['error'])) {
			$this->data['error_warning'] = $this->session->data['error'];

			unset($this->session->data['error']);
		} elseif (isset($this->error['warning'])) {
			$this->data['error_warning'] = $this->error['warning'];
		} else {
			$this->data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$this->data['success'] = '';
		}
		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),     		
			'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('tool/clearcache', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		$this->data['restore'] = $this->url->link('tool/clearcache', 'token=' . $this->session->data['token'], 'SSL');

		$this->data['clearcache'] = $this->model_tool_clearcache->getClearcache();
		
		$this->template = 'tool/clearcache.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		
		$this->response->setOutput($this->render());
	}
}
?>