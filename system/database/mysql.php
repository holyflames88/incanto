<?php
final class DBMySQL {
	private $link;

	public function __construct($hostname, $username, $password, $database) {
		if (!$this->link = mysql_connect($hostname, $username, $password)) {
			trigger_error('Error: Could not make a database link using ' . $username . '@' . $hostname);
		}

		if (!mysql_select_db($database, $this->link)) {
			trigger_error('Error: Could not connect to database ' . $database);
		}

		mysql_query("SET NAMES 'utf8'", $this->link);
		mysql_query("SET CHARACTER SET utf8", $this->link);
		mysql_query("SET CHARACTER_SET_CONNECTION=utf8", $this->link);
		mysql_query("SET SQL_MODE = ''", $this->link);
	}

	public function query($sql) {
		if ($this->link) {
		
		// Кеширование запросов
		if(!defined('IS_ADMIN')){
				//конфигурация
				$limit = 20; // кол-во удаляемых просроченных запросов за один раз
				$expire_default = 3600;
				$expire_main = 3600;
				$expire_product = 3600;
				$tag_cache = array(
					'main' => array(
						'expire' => false, //времы жизни кэша, есил false не кэшируем 
					),
					'Currency::__construct' => array( 
						'expire' => $expire_main, 
						'tag' => 'main',  //группа, эти запросы будут браться из кэша одним разом
					),
					'Weight::__construct' => array( 
						'expire' => $expire_main, 
						'tag' => 'main',
					),
					'Length::__construct'=> array( 
						'expire' => $expire_main, 
						'tag' => 'main',
					),
					'ModelDesignLayout::getLayout' => array( 
						'expire' => $expire_main, 
						'tag' => 'main',
					),
					'ModelSettingExtension::getExtensions' => array( 
						'expire' => $expire_main, 
						'tag' => 'main',
					),
					'ModelDesignBanner::getBanner' => array( 
						'expire' => $expire_main, 
						'tag' => 'main',
					),
					'ModelCatalogProduct::getTotalProducts' => array(
						'expire' => $expire_product, 
						'tag' => 'product', 
					),
					'ControllerCommonSeoUrl::rewrite' => array(
						'expire' => $expire_product, 
						'tag' => 'product', 
					),
					'ControllerCommonSeoUrl::rewrite' => array(
						'expire' => $expire_product, 
						'tag' => 'product', 
					),
					'ModelCatalogCategory::getCategories'=> array(
						'expire' => $expire_product, 
						'tag' => 'product', 
					),
				);
				//инвалидация кэша
				if(!Staticstore::get('expire_cache')){
					mysql_query("DELETE FROM " . DB_PREFIX . "cache WHERE expire < '" . time(true) . "'");
					Staticstore::set('expire_cache', true);
				}
				$caller = debug_backtrace();
				$hash = md5($sql);
				$method = (!empty($caller[2]['class']) ? $caller[2]['class'].'::'.$caller[2]['function'] : 'main');
				$expire = (isset($tag_cache[$method])) ?  (($tag_cache[$method]['expire']) ? time(true) + $tag_cache[$method]['expire'] : false) : time(true) + $expire_default;
				$tag = (isset($tag_cache[$method]['tag'])) ? $tag_cache[$method]['tag'] : $method;
				if($expire){
					//обработка запросов с группами
					if(isset($tag_cache[$method])){
						if($return = Staticstore::get($tag)){
							   if (isset($return[$hash])){
								   return unserialize($return[$hash]);
							   }
						}else{ 
							$resource = mysql_query("SELECT hash, data FROM " . DB_PREFIX . "cache WHERE tag = '" . $tag . "'");
							if($resource){
								$return = array();
								while ($result = mysql_fetch_assoc($resource)) {
									 $return[$result['hash']] = $result['data'];
								}
								Staticstore::set($tag, $return);
								if(($return = Staticstore::get($tag)) && isset($return[$hash]))
									return unserialize($return[$hash]);
							}
						}
					}
					//работаем с запросаме без группы
					$resource = mysql_query("SELECT data FROM " . DB_PREFIX . "cache WHERE hash = '" . $hash . "'");
					if (is_resource($resource)) {
						$result = mysql_fetch_assoc($resource);
						if($result){
							return unserialize($result['data']);
						}
					}
				}
		}

			$resource = mysql_query($sql, $this->link);

			if ($resource) {
				if (is_resource($resource)) {
					$i = 0;

					$data = array();

					while ($result = mysql_fetch_assoc($resource)) {
						$data[$i] = $result;

						$i++;
					}

					mysql_free_result($resource);

					$query = new stdClass();
					$query->row = isset($data[0]) ? $data[0] : array();
					$query->rows = $data;
					$query->num_rows = $i;

					unset($data);

					if(!defined('IS_ADMIN')){
                        $r = mysql_query("INSERT INTO " . DB_PREFIX . "cache SET hash = '{$hash}', data = '" . $this->escape(serialize($query)) . "', tag = '{$tag}',  expire = '{$expire}' ");
					}
					
					return $query;	
				} else {
					return true;
				}
			} else {
				trigger_error('Error: ' . mysql_error($this->link) . '<br />Error No: ' . mysql_errno($this->link) . '<br />' . $sql);
				exit();
			}
		}
	}

	public function escape($value) {
		if ($this->link) {
			return mysql_real_escape_string($value, $this->link);
		}
	}

	public function countAffected() {
		if ($this->link) {
			return mysql_affected_rows($this->link);
		}
	}

	public function getLastId() {
		if ($this->link) {
			return mysql_insert_id($this->link);
		}
	}

	public function __destruct() {
		if ($this->link) {
			mysql_close($this->link);
		}
	}
}
?>