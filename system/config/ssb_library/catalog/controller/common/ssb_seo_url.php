<?php
class ssb_seo_url extends Controller {

	private $seoController, $ssb_helper, $ssb_data, $ssb_setting;
	private $def_lang_code, $totalLanguages, $l_code_session, $l_id_session, $seo_pagination = false, $query_data = array();

	function __construct(){ 
		global $registry;
		parent::__construct($registry);
		
		require_once(DIR_CONFIG .'ssb_library/ssb_seo_controller.php');
		$this->seoController = seoController::getInstance();	
		require_once DIR_CONFIG .'ssb_library/ssb_helper.php';
		$this->ssb_helper = ssb_helper::getInstance();
		require_once DIR_CONFIG .'ssb_library/ssb_data.php';
		$this->ssb_data = ssb_data::getInstance();
		
		$this->ssb_setting = $this->ssb_data->getSetting();
		list ($this->totalLanguages, $this->def_lang_code) = $this->seoController->getDefaultLanguageData();
		list ($this->l_code_session, $this->l_id_session) = $this->seoController->setLanguageData();
	
	}

	static private $Instance   = NULL;
	
	static public function getInstance() {
	if(self::$Instance==NULL){
		$class = __CLASS__;
		self::$Instance = new $class;
	}
	return self::$Instance;
	}

	public function index() {
		$this->curPageURL = $this->seoController->curPageURL();
		$setting = $this->ssb_setting;
		$tools = $setting['tools'];
		if(substr($this->curPageURL,-1) == '/' AND $tools['trailing_slash']['status'] == true) {
			$new_url = rtrim($this->curPageURL,"/");  
			$this->ssb_helper->redirect($new_url, 301); 
		}
		
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}
		
		if (isset($this->request->get['_route_']) AND trim($this->request->get['_route_'], '/') != $this->l_code_session){
			
			$parts = explode('/', $this->request->get['_route_']);
			$parts_length = count($parts);

			$CPBI_urls_ext	= $setting['entity']['urls']['CPBI_urls']['ext'];
			
			$CPBI_urls_ext	= $CPBI_urls_ext == '' ? '##empty##' : $CPBI_urls_ext  ;
			
			$pagin_part = false;
			if($tools['seo_pagination']['status']){	
				foreach($parts as $part){
					if(strpos($part, 'page-') !== false){
						$pagin_part	= true;
					}
				}
			}
			
			$arrayLangCode = array();
			if($this->totalLanguages > 1){
				$arrayLangCode = $this->ssb_helper->getArrayLangCode();
			}
			
			$no_exist_one_of_url_part = false;

			$i = 1;
			foreach ($parts as $part) {
				
				$part = trim($part);
				if (empty($part) ) continue;
				
				if (in_array($part, $arrayLangCode)) {$i++; continue;}
				if(strpos($part, 'page-') !== false) {
					if($tools['seo_pagination']['status']){
						$this->seo_pagination = (int)str_replace('page-', '', $part);
					}
					$this->query_data['page'] = $this->request->get['page'] = $this->seo_pagination;
					continue;
				}
				
				if(strpos($part, 'change-') !== false){
					$chage_lang = explode('-', $part);
					if(isset($chage_lang[1]) AND in_array($chage_lang[1], $arrayLangCode)){
						
						$chage_lang_code = $chage_lang[1];
						if(isset($_SESSION['last_request_' . $chage_lang_code])){
							
							$this->request->post['redirect'] = $_SESSION['last_request_' . $chage_lang_code];
							$this->request->post['language_code'] = $chage_lang_code;
							return $this->forward('module/language');
						}else{
							continue;
						}
					}
				}
				
				$pre_last_part = $parts_length - 1;
				if($pagin_part && strpos($part, $CPBI_urls_ext) === false && $pre_last_part == $i){
					$keyword_condition = "(keyword = '" . $this->db->escape($part) . "' OR keyword = '" . $this->db->escape($part . $CPBI_urls_ext) . "')";
				}elseif(strpos($part, $CPBI_urls_ext) !== false && $parts_length == $i && $setting['tools']['suffix_manager']['status']){
					$keyword_condition = "(keyword = '" . $this->db->escape($part) . "' OR keyword = '" . $this->db->escape(str_replace($CPBI_urls_ext, '', $part)) . "')";
				}else{
					$keyword_condition = "keyword = '" . $this->db->escape($part) . "'";
				}

				$sql = "SELECT auto_gen, language_id, query FROM " . DB_PREFIX . "url_alias WHERE ". $keyword_condition ." AND language_id = '". (int)$this->l_id_session ."';";
				$query = $this->db->query($sql);
				
				if ($query->num_rows) {
					$result = $query->rows[0];
					$this->parseQuery($result);
				}else{
					$sql = "SELECT auto_gen, language_id, query FROM " . DB_PREFIX . "url_alias WHERE ". $keyword_condition .";";
					$query = $this->db->query($sql);
					if ($query->num_rows) {
						$result = $query->rows[0];
						$this->parseQuery($result);

						if($result['language_id'] !== $this->l_id_session ){
							$query_count = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "url_alias WHERE query = '" . $result['query'] . "'");
							if($query_count->row['total'] > 1){
								$urlWasCange = true;
							}
						}
					}else{
						$no_exist_one_of_url_part = true;
						$this->request->get['route'] = 'error/not_found';	
						$this->query_data['path'] = 'error/not_found';
					}
				}
				$i++;
			}

			$this->setRouteType();
			
			$no_exist_one_of_url_part = isset($no_exist_one_of_url_part) ? $no_exist_one_of_url_part : false;
			$this->seoController->checkPathController($no_exist_one_of_url_part);

			if(isset($urlWasCange) AND $urlWasCange){
				$this->seoController->redirectPermanently();
			}
		}

		$this->seoController->alternetHref();
		
		
		if (isset($this->request->get['route'])) {
			$this->seoController->errorNotFound();
			return $this->forward($this->request->get['route']);
		}else{
			return $this->forward('common/home');
		}
	}
	
	function parseQuery($query){
		$url = explode('=', $query['query']);

		if ($url[0] == 'product_id') {
			$this->query_data['product_id'] = $this->request->get['product_id'] = $url[1];
			
		}
		
		if ($url[0] == 'category_id') {
			if (!isset($this->request->get['path'])) {
				$this->query_data['path'] = $this->request->get['path'] = $url[1];
			} else {
				$this->request->get['path'] .= '_' . $url[1];
				$this->query_data['path'] .= '_' . $url[1];
			}
		}	
		
		if ($url[0] == 'manufacturer_id') {
			$this->query_data['manufacturer_id'] = $this->request->get['manufacturer_id'] = $url[1];
		}
		
		if ($url[0] == 'information_id') {
			$this->query_data['information_id'] = $this->request->get['information_id'] = $url[1];
		}
		if (isset($url[0]) AND !isset($url[1])) { 
			$this->query_data['route'] = $this->request->get['route'] = $url[0];
		}
		
		if (isset($this->request->get['filter'])) {
			$this->query_data['filter'] = $this->request->get['filter'];
		}
				
		if (isset($this->request->get['sort'])) {
			$this->query_data['sort'] = $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$this->query_data['order'] = $this->request->get['order'];
		}
		
		if (isset($this->request->get['page'])) {
			$this->query_data['page'] = $this->request->get['page'];
		}	
									
		if (isset($this->request->get['limit'])) {
			$this->query_data['limit'] = $this->request->get['limit'];
		}
	}
	
	private function setRouteType() {

		if (isset($this->request->get['product_id'])) {
			$this->request->get['route'] = 'product/product';
		} elseif (isset($this->request->get['path'])) {
			$this->request->get['route'] = 'product/category';
		} elseif (isset($this->request->get['manufacturer_id'])) {
			$this->request->get['route'] = 'product/manufacturer/info';
		
		} elseif (isset($this->request->get['information_id'])) {
			$this->request->get['route'] = 'information/information';
		}
	}
	
	public function rewrite($link, $query_filter = '', $l_code = '') {
		$url_info = parse_url(str_replace('&amp;', '&', $link));

		list ($this->l_code_session, $this->l_id_session) = $this->seoController->setLanguageData();
		
		$url = ''; 
		$data = array();
		parse_str($url_info['query'], $data);
		
		$CPBI_urls_ext	= $this->ssb_setting['entity']['urls']['CPBI_urls']['ext'];
		
		list ($data, $this->path_mode) = $this->seoController->startPathManager($data);

		$page_part = false;

		foreach ($data as $key => $value) {
			if (isset($data['route'])) {
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id')) {
					
					if($data['route'] == 'product/product' && $key == 'manufacturer_id' && $this->path_mode != 'default'){
						unset($data[$key]);
						continue;
					}
					
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "' AND language_id = '". $this->l_id_session ."'");

					if ($query->num_rows) {
							if(strpos($query->rows[0]['query'], 'manufacturer_id') !== false && !isset($data['product_id'])){
								if($this->ssb_setting['tools']['suffix_manager']['status'] && strpos($link, 'page=') === false)$query->rows[0]['keyword'] .= $CPBI_urls_ext;
								if(!isset($data['product_id']))$page_part = true;
							}
							$url .= '/' . $query->rows[0]['keyword'];
						
						unset($data[$key]);
					}

				} elseif ($key == 'route' AND $value != 'product/product' AND $value != 'product/category') { 
					$sql = "SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($value) . "'";
					$query = $this->db->query($sql);

					if ($query->num_rows) {
						foreach($query->rows as $row){
							if($row['language_id'] == (int)$this->l_id_session){
								$url .= '/' . $row['keyword'];
								break;
							}
						}
					}
					
				} elseif ($key == 'path') {
					$categories = explode('_', $value);
					$found_category = false;
					foreach ($categories as $category) {

						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "' AND language_id = '". (int)$this->l_id_session ."'");
					
						if ($query->num_rows) {
							$url .= '/' . $query->rows[0]['keyword'];
							unset($data[$key]); 
							$found_category = true;
						}
					}

					if($found_category && !isset($data['product_id']) && $this->ssb_setting['tools']['suffix_manager']['status'] && strpos($link, 'page=') === false)$url .= $CPBI_urls_ext;
					
					if(!isset($data['product_id']))$page_part = true;

				}
			}
		}
		
		
		if ($url) {
			unset($data['route']);
		
			$query = '';
		
			if ($data) {
				foreach ($data as $key => $value) {
					if($this->ssb_setting['tools']['seo_pagination']['status'] && $key == 'page' && $value != '{page}')continue;
					$query .= '&' . $key . '=' . $value;
				}
				if ($query) {
					$query = '?' . trim($query, '&');
				}
			}
		
			if($this->totalLanguages > 1 AND $this->ssb_setting['tools']['lang_dir_link']['data']['prefix']){
				$host = $this->seoController->getHost($url_info);
				$path = $this->seoController->getPath($this->l_code_session, $host, $url_info);
			}else{
				$host = $url_info['scheme'] . '://' . $url_info['host'];
				$path = str_replace('/index.php', '', $url_info['path']);
			}

			if($page_part){
				list($page_part, $url_info) = $this->seoController->getPagePart($url_info);
			}else{
				$page_part = '';
			}

			$link = $host . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . $path . $url . $page_part .$query;
			
		}elseif (strpos($link,"index.php") !== false) {
			$link = str_replace('index.php', '', $link);
		}
		
		$link = rtrim($link,"/");
		
		return $link; 
	}	
}
?>