<?php
class agooLangmarkLoader extends Controller {

	public function install() {
	  	 $this->load->library('agoo/url');
	  	 $this->load->library('agoo/multilang');
	  	 $this->load->library('agoo/response');
	  	 $this->load->model('design/layout');
	  	 $this->load->model('tool/image');

	}

}
$agooController = new agooLangmarkLoader($this->registry);
$options = $agooController->config->get('general_set');

if ($options['switch']) {

$agooController->install();

$multilang = new agooMultilang($this->registry);
if (!$this->registry->get('loader_loading')) {

	$loader_old = $this->registry->get('load');
	$this->registry->set('load_old', $loader_old);

	$agooController->load->library('agoo/loader');
	$agooloader = new agooLoader($this->registry);
	$this->registry->set('load', $agooloader);

	$agooController->load->library('agoo/config');
	$Config = $this->registry->get('config');
	$this->registry->set('config_old', $Config);
	$agooConfig = new agooConfig($this->registry);
	$this->registry->set('config', $agooConfig);

	$agooController->load->library('agoo/response');
	$Response = $this->registry->get('response');
	$this->registry->set('response_old', $Response);
	$agooResponse = new agooResponse($this->registry);
	$this->registry->set('response', $agooResponse);

}

$agooController->load->library('agoo/url');
$Url = $this->registry->get('url');
$this->registry->set('url_old', $Url);
$agooUrl = new agooUrl($this->registry);
$this->registry->set('url', $agooUrl);

$this->registry->set('loader_loading', true);
}

?>