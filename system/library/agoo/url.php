<?php
class agooUrl extends Controller
{
	protected $Url;
	public function __call($name, array $params)
	{
		/*
		if (isset($stacktrace[1]) && isset($stacktrace[1]['file']) && isset($stacktrace[1]['line'])) {
			$node = $stacktrace[1];
		} elseif (isset($stacktrace[0]) && isset($stacktrace[0]['file']) && isset($stacktrace[0]['line'])) {
			$node = $stacktrace[0];
		}
		if ($node) {
			echo $val = $node['file'] . "(" . $node['line'] . ")<br>";
		}
        */

		$this->registry->set('url_work', true);
		$slash     = false;
		$this->Url = $this->registry->get('url_old');
		$modules   = call_user_func_array(array(
			$this->Url,
			$name
		), $params);
		unset($this->Url);
		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$config_url = substr($this->config->get('config_ssl'), 0, $this->strpos_offset('/', $this->config->get('config_ssl'), 3) + 1);
		} else {
			$config_url = substr($this->config->get('config_url'), 0, $this->strpos_offset('/', $this->config->get('config_url'), 3) + 1);
		}
		$url = str_replace($config_url, '', $modules);
		if (isset($this->session->data['language'])) {
			$code_cookie = $this->session->data['language'];
		} else {
			$code_cookie = '';
		}
		$parts       = explode('/', trim(utf8_strtolower($url), '/'));
		$parts_first = $parts[0];
		$code_array  = $this->config->get('general_set');
		foreach ($code_array['prefix'] as $lang_code => $prefix) {
			if ($code_cookie == trim(utf8_strtolower($lang_code), '/')) {
				$code_parefix = $code_array['prefix'][$lang_code];
				$code_flag    = true;
				if (isset($prefix[utf8_strlen($prefix) - 1]) && $prefix[utf8_strlen($prefix) - 1] == '/') {
					$slash = true;
				}
				break;
			}
		}
		if (trim(utf8_strtolower($parts_first), '/') == trim(utf8_strtolower($code_cookie), '/')) {
		} else {
			if (trim(utf8_strtolower($code_parefix), '/') == '') {
				$del = '';
			} else {
				$del = '/';
			}
			if ($url == '' && !$slash)
				$del = '';
			$modules = $config_url . trim(utf8_strtolower($code_parefix), '/') . $del . $url;
		}

		if (isset($code_array['pagination']) && $code_array['pagination']) {
			       /* for pagination */
					/*
					if ($this->registry->get('langmark_page')!='') {
			   				$title = $this->document->getTitle();
			   				$description = $this->document->getDescription();
			                if (utf8_strpos($title, ' '.$code_array['pagination_title'][$this->config->get('config_language')].' '. $this->registry->get('langmark_page')) === false) {
								$this->document->setTitle($title .  ' '.$code_array['pagination_title'][$this->config->get('config_language')].' ' . $this->registry->get('langmark_page'));
								$this->document->setDescription($description .  ' '.$code_array['pagination_title'][$this->config->get('config_language')].' ' . $this->registry->get('langmark_page'));
							}
					}
					*/
					if ($this->registry->get('langmark_page')!='') {
			   				$title = $this->document->getTitle();
			   				$description = $this->document->getDescription();
			                if (utf8_strpos($title, ' '. $this->registry->get('langmark_page')) === false) {
								$this->document->setTitle($title .  ' '.$code_array['pagination_title'][$this->config->get('config_language')].' ' . $this->registry->get('langmark_page'));
								$this->document->setDescription($description .  ' '.$code_array['pagination_title'][$this->config->get('config_language')].' ' . $this->registry->get('langmark_page'));
							}
					}

                      //echo  $params[1]."<br>";
			         if (isset($params[1]) && (strpos($params[1], $code_array['pagination_prefix'].'=') !== false || strpos($params[1], 'page=') !== false)) {

					       		$component = parse_url(str_replace('&amp;', '&', $modules));
			                    $component['path'] = str_replace('/index.php', '', $component['path']);

							   $data = array();
							   if (isset($component['query']))
							   parse_str($component['query'], $data);


					        if (count($data)) {
								 /*** added code seo paging http://opencartadmin.com ***/
					  			$seo_url='';
					  			$paging = '';
					            $devider = '/'; // :)
					            foreach ($data as $key => $value) {

											if ($key == $code_array['pagination_prefix'] || $key=="page") {
												$key = $code_array['pagination_prefix'];
												if ($devider != '/') {
													$paging = "/" . $key . "-" . $value;
												} else  {
													$paging = $key . "-" . $value;
												}

												unset($data[$key]);
												if (isset($data['page'])) {
												 unset($data['page']);
												}
											}
								}
								/*** end of added code seo paging http://opencartadmin.com ***/
								/*** changed code for seo paging http://opencartadmin.com ***/
                                //echo $paging."<br>";

                                if (isset($params[1]) && strpos($params[1], 'page={page}') !== false) {
	                              //  $paging = '';
                                }

					            if (trim($paging,'/') == $code_array['pagination_prefix'].'-1') {
					            	$paging = '';
					            }

								if (count($data)) {
									$seo_url .= $paging.'?' . urldecode(http_build_query($data, '', '&amp;'));
								} else {
								  	$seo_url .= $paging;
								}
			                    if (trim($component['path']) == '') $mydel =""; else $mydel = "/";
					             $modules = $config_url .trim($component['path'],'/').$mydel.$seo_url;

							}

			         }
			         /* for pagination */
        }


         $modules = str_replace('&amp;', '&',$modules);

/*
		if ($this->registry->get('langmark_url_work')==NULL) {

	        $languages = array();
			$query     = $this->db->query("SELECT * FROM " . DB_PREFIX . "language WHERE status = '1'");
			foreach ($query->rows as $result) {
				$languages[$result['code']] = $result;
			}

	        $code_array  = $this->config->get('general_set');
	        $seo_url = $this->registry->get('langmark_url');

			foreach ($code_array['prefix'] as $lang_code => $prefix) {
				if (isset($prefix[utf8_strlen($prefix) - 1]) && $prefix[utf8_strlen($prefix) - 1] != '/' && $seo_url != '')
					$del = "/";
				else
					$del = '';
				if ($seo_url == '' || $seo_url == '/') {
					$del     = '';
					$seo_url = '';
				}

				$seourl[$lang_code] = $prefix . $del . $seo_url;
			}
			foreach ($languages as $result) {
				$languages[$result['code']]['url'] = $config_url . $seourl[$result['code']];
			}
			$this->registry->set('langmarkdata', $languages);

			$this->registry->set('langmark_url_work',true);
		}
        */

		return $modules;
	}

	private function strpos_offset($needle, $haystack, $occurrence)
	{
		// explode the haystack
		$arr = explode($needle, $haystack);
		// check the needle is not out of bounds
		switch ($occurrence) {
			case $occurrence == 0:
				return false;
			case $occurrence > max(array_keys($arr)):
				return false;
			default:
				return strlen(implode($needle, array_slice($arr, 0, $occurrence)));
		}
	}
}
?>