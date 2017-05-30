<?php
class ControllerModuleLangmark extends Controller
{
	protected function index($arg)
	{

		$options = $this->config->get('general_set');


		if (!$options['switch']) {
         return;
		}

		$this->config->set("langmark_work", true);
		$html = "";
		if ($this->config->get('general_set') != '') {
			$this->data['settings_general'] = $this->config->get('general_set');
		} else {
			$this->data['settings_general'] = Array();
		}
		$position_block = $arg['position'];
		//$this->language->load('module/langmark');
		//$this->data['button_continue'] = $this->language->get('button_continue');
		$template = '/template/agoodonut/langmark/langmark.tpl';
		if (isset($this->request->get['route'])) {
			$route = $this->request->get['route'];
		} else {
			$route = 'common/home';
		}
		$this->load->model('design/layout');
		$layout_id = false;

		if ($route == 'product/category' && isset($this->request->get['path'])) {
			$path      = explode('_', (string) $this->request->get['path']);
			$layout_id = $this->model_catalog_category->getCategoryLayoutId(end($path));
		}
		if ($route == 'product/product' && isset($this->request->get['product_id'])) {
			$layout_id = $this->model_catalog_product->getProductLayoutId($this->request->get['product_id']);
		}
		if ($route == 'information/information' && isset($this->request->get['information_id'])) {
			$layout_id = $this->model_catalog_information->getInformationLayoutId($this->request->get['information_id']);
		}
		if ($route == 'record/blog' && isset($this->request->get['blog_id'])) {
			$path      = explode('_', (string) $this->request->get['blog_id']);
			$layout_id = $this->model_design_bloglayout->getBlogLayoutId(end($path));
		}
		if ($route == 'record/record' && isset($this->request->get['record_id'])) {
			$layout_id = $this->model_design_bloglayout->getRecordLayoutId($this->request->get['record_id']);
		}
		if (!$layout_id) {
			$layout_id = $this->model_design_layout->getLayout($route);
		}
		if (!$layout_id) {
			$layout_id = $this->config->get('config_layout_id');
		}



		$this->data['lang_code'] = $this->config->get('config_language');
		if (!$this->registry->has('langmark_position_' . $position_block)) {
			$this->registry->set('langmark_position_' . $position_block, 0);
		} else {
			$pos = $this->registry->get('langmark_position_' . $position_block);
			$this->registry->set('langmark_position_' . $position_block, $pos + 1);
		}
		$position = $this->registry->get('langmark_position_' . $position_block);
		$this->data['position'] = $position;
		$this->data['layout_id'] = $layout_id;
		$module_data = array();
		$this->load->model('setting/extension');
		$extensions = $this->model_setting_extension->getExtensions('module');
		foreach ($extensions as $extension) {
			$modules = $this->config->get($extension['code'] . '_module');
			if ($modules) {
				foreach ($modules as $num => $module) {
					if ($module['layout_id'] == $layout_id && $extension['code'] == 'langmark' && $module['position'] == $position_block && $module['status']) {
						if ($extension['code'] != '') {
							$module_data[] = array(
								'code' => $extension['code'],
								'setting' => $module,
								'sort_order' => $module['sort_order']
							);
						}
					}
				}
			}
		}
		if (!function_exists('commd')) {
			function commd($a, $b)
			{
				if ($a['sort_order'] == '')
					$a['sort_order'] = 10000;
				if ($b['sort_order'] == '')
					$b['sort_order'] = 10000;
				if ($a['sort_order'] > $b['sort_order'])
					return 1;
				else
					return -1;
			}
		}
		if (isset($module_data) && is_array($module_data)) {
			usort($module_data, 'commd');
		}
		$type = "none";
		$this->data['heading_title'] = '';

		$this->data['general_list'] = $this->config->get('general_list');
		if (!isset($module_data[$position])) {
			$this->registry->set('langmark_position_' . $position_block, 0);
			$position = 0;
		}
		if (isset($module_data[$position]['setting']['what']) && $module_data[$position]['setting']['what'] != 'what_hook') {
			$type = $this->data['general_list'][$module_data[$position]['setting']['what']]['type'];
		}
		if (isset($module_data[$position]['setting']['what']) && isset($this->data['general_list'][$module_data[$position]['setting']['what']]))
			$langmark_thislist = $this->data['general_list'][$module_data[$position]['setting']['what']];
		else
			$langmark_thislist = null;
		$this->data['langmark_thislist'] = $langmark_thislist;
		$this->data['settings_widget'] = $this->data['langmark_thislist'];
		$this->registry->set('langmark_thislist', serialize($langmark_thislist));

		if (isset($module_data[$position])) {
			$this->registry->set('general_list_position', $module_data[$position]['setting']['what']);
		}

		if (isset($this->data['settings_general']['cache_widgets']) && $this->data['settings_general']['cache_widgets']) {
			$hash_cache = md5(serialize($this->data['langmark_thislist']) . serialize($arg) . serialize($this->data['general_list']) . serialize($layout_id) . serialize($this->data['userLogged']) . serialize($this->data['settings_general']) . serialize($this->config->get('config_language_id')) . serialize($this->config->get('config_store_id')) . serialize($this->request->get) . serialize($this->request->post));
			$cache_name = 'langmark.module.view.' . (int) $this->config->get('config_store_id') . '.' . (int) $this->config->get('config_language_id') . $this->data['customer_id'];
			$module_view_cache = $this->cache->get($cache_name);
		} else {
			$hash_cache = 0;
		}

		$this->data['prefix'] = false;
		$prefix_str = str_replace("_", "", md5(serialize($this->data['langmark_thislist'])));
		$prefix_array = preg_split('//', $prefix_str, -1, PREG_SPLIT_NO_EMPTY);
		shuffle($prefix_array);
		$this->data['prefix'] = substr(implode($prefix_array), 0, 7);

		if (!isset($module_view_cache[$hash_cache]) || (isset($langmark_thislist['cached']) && $langmark_thislist['cached'] == 0)) {
			$this->data['type'] = false;

			if (!empty($module_data) && $type == 'html') {
				$this->data['type'] = $type;

				$this->data['html'] = html_entity_decode($this->data['general_list'][$module_data[$position]['setting']['what']]['html'][$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8');
				$this->data['languages'] = $this->registry->get('langmarkdata');

				if (isset($this->data['languages']) && is_array($this->data['languages'])) {
					usort($this->data['languages'], 'commd');
				}


				$this->language->load('module/language');

				$this->data['text_language'] = $this->language->get('text_language');
                $this->data['redirect'] = '';
				$this->data['action'] = '';

				$this->data['language_code'] = $this->session->data['language'];
                $this->data['language_prefix'] = $this->registry->get('langmark_prefix');


				$html_name = "langmark." . md5(serialize($this->data['general_list'][$module_data[$position]['setting']['what']])) . "." . $this->config->get('config_language_id') . ".php";
				$file = DIR_CACHE . $html_name;
				if (!file_exists($file)) {
					$handle = fopen($file, 'w');
					fwrite($handle, $this->data['html']);
					fclose($handle);
				}
				if (file_exists($file)) {
					extract($this->data);
					ob_start();
					require($file);
					$this->output = ob_get_contents();
					ob_end_clean();
				}
				$this->data['html'] = $this->output;




				if (isset($module_data[$position]) && isset($this->data['general_list'][$module_data[$position]['setting']['what']]['title_list_latest'][$this->config->get('config_language_id')]))
					$this->data['heading_title'] = $this->data['general_list'][$module_data[$position]['setting']['what']]['title_list_latest'][$this->config->get('config_language_id')];
				else
					$this->data['heading_title'] = '';
				if (isset($langmark_thislist['template']) && $langmark_thislist['template'] != '') {
					$template = '/template/agoodonut/langmark/' . $langmark_thislist['template'];
				} else {
					$template = '/template/agoodonut/langmark/langmark.tpl';
				}
			}
			if (!empty($module_data) && $type != '') {
				if ($this->data['type']) {
					if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . $template)) {
						$this->template = $this->config->get('config_template') . $template;
					} else {
						$this->template = 'default' . $template;
					}
					$this->data['theme'] = $this->config->get('config_template');
					$html = $this->render();
					if (isset($this->data['settings_general']['cache_widgets']) && $this->data['settings_general']['cache_widgets']) {
						$module_view_cache[$hash_cache] = base64_encode($html);
						$this->cache->set($cache_name, $module_view_cache);
					}
				}
			}
		} else {
			$html = base64_decode($module_view_cache[$hash_cache]);
		}
		$this->output = $html;
		$this->config->set("langmark_work", false);
		return $this->response->setOutput($html);
	}
	protected function fixed()
	{
		if (isset($_SERVER["HTTP_HOST"]) && $_SERVER["HTTP_HOST"] != "") {
			$host = $_SERVER["HTTP_HOST"];
			if (substr($host, -1) != '/')
				$host .= "/";
			if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
				if (HTTPS_SERVER != $host) {
					if (substr($host, 0, 5) != 'https')
						$host = "https://" . $host;
					$this->config->set('config_ssl', $host);
				}
			} else {
				if (substr($host, 0, 4) != 'http')
					$host = "http://" . $host;
				if (HTTP_SERVER != $host) {
					$this->config->set('config_url', $host);
				}
			}
		}
	}
}
?>