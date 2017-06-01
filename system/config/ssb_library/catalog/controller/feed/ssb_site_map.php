<?php
class ssb_site_map extends Controller {
  
	private $ssb_helper;
	private $ssb_data;
	private $ssb_setting;
	private $ssb_table;
	
	function __construct(){ 
		global $registry;
		parent::__construct($registry);
				
		require_once DIR_CONFIG .'ssb_library/ssb_helper.php';
		$this->ssb_helper = ssb_helper::getInstance();
		
		require_once DIR_CONFIG .'ssb_library/ssb_data.php';
		$this->ssb_data = ssb_data::getInstance();
		
		require_once DIR_CONFIG .'ssb_library/ssb_table.php';
		$this->ssb_table = ssb_table::getInstance();
		
		$this->ssb_setting = $this->ssb_data->getSetting();
	
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
	  if ($this->config->get('google_sitemap_status')) {
		 $sitemap = $this->cache->get('sssb.feed.sitemap.' . $this->config->get('config_store_id'));
		 if($sitemap){
			if (ob_get_contents()) ob_end_clean();
			$this->response->addHeader('Content-Type: application/xml');
			$this->response->setOutput($sitemap);
			return;
		 }

		 $output  = '<?xml version="1.0" encoding="UTF-8"?>';
		 $output .= '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">';
		 
		 $this->load->model('catalog/product');
		 
		 $products = $this->model_catalog_product->getProducts();
		 
		 
		 $this->only_canonical= $this->ssb_setting['tools']['sitemap']['data']['only_canonical'];
		 $all_language 	= $this->ssb_setting['tools']['sitemap']['data']['all_language'];
		 
		 $this->freq 			= $this->ssb_setting['tools']['sitemap']['data']['freq'];
		 $this->priorProduct	= $this->ssb_setting['tools']['sitemap']['data']['priorProduct']/10;
		 $this->priorOther		= $this->ssb_setting['tools']['sitemap']['data']['priorOther']/10;

		 $url_status 	= $this->ssb_data->getEntityStatus('urls');
		 $lang_codes 	= $this->ssb_helper->getArrayLangCode();

		 foreach ($products as $product) {
			if($all_language AND $url_status){
				foreach ($lang_codes as $lang_code) {
					$_SESSION['language'] = $lang_code;
					$output .= '<url>';
					$output .= '<loc>' . $this->url->link('product/product', 'product_id=' . $product['product_id']) . '</loc>';
					$output .= '<changefreq>'. $this->freq .'</changefreq>';
					$output .= '<priority>' . $this->priorProduct . '</priority>';
					$output .= '</url>';
				}
			}else{
				$output .= '<url>';
				$output .= '<loc>' . htmlspecialchars($this->url->link('product/product', 'product_id=' . $product['product_id'])) . '</loc>';
				$output .= '<changefreq>'. $this->freq .'</changefreq>';
				$output .= '<priority>' . $this->priorProduct . '</priority>';
				$output .= '</url>';
			}
		 }
		 
		 $this->load->model('catalog/category');
		 
		 $output .= $this->getCategories(0);
		 
		 $this->load->model('catalog/manufacturer');
		 
		 $manufacturers = $this->model_catalog_manufacturer->getManufacturers();
		 
		 foreach ($manufacturers as $manufacturer) {
			if($all_language AND $url_status){
				foreach ($lang_codes as $lang_code) {
					$_SESSION['language'] = $lang_code;
					/* standard part manuf start */
					$output .= '<url>';
					$output .= '<loc>' . $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']) . '</loc>';
					$output .= '<changefreq>'. $this->freq .'</changefreq>';
					$output .= '<priority>'. $this->priorOther .'</priority>';
					$output .= '</url>';   
					
					if(!$this->only_canonical){
						$products = $this->model_catalog_product->getProducts(array('filter_manufacturer_id' => $manufacturer['manufacturer_id']));
						
						foreach ($products as $product) {
						   $output .= '<url>';
						   $output .= '<loc>' . $this->url->link('product/product', 'manufacturer_id=' . $manufacturer['manufacturer_id'] . '&product_id=' . $product['product_id']) . '</loc>';
						   $output .= '<changefreq>'. $this->freq .'</changefreq>';
						   $output .= '<priority>'. $this->priorOther .'</priority>';
						   $output .= '</url>';   
						}
					}  
					/* standard part manuf end */
				}
			}else{
				/* standard part manuf  start */
				$output .= '<url>';
				$output .= '<loc>' . $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $manufacturer['manufacturer_id']) . '</loc>';
				$output .= '<changefreq>'. $this->freq .'</changefreq>';
				$output .= '<priority>'. $this->priorOther .'</priority>';
				$output .= '</url>';   
				
				if(!$this->only_canonical){
					$products = $this->model_catalog_product->getProducts(array('filter_manufacturer_id' => $manufacturer['manufacturer_id']));
					
					foreach ($products as $product) {
					   $output .= '<url>';
					   $output .= '<loc>' . $this->url->link('product/product', 'manufacturer_id=' . $manufacturer['manufacturer_id'] . '&product_id=' . $product['product_id']) . '</loc>';
					   $output .= '<changefreq>'. $this->freq .'</changefreq>';
					   $output .= '<priority>'. $this->priorOther .'</priority>';
					   $output .= '</url>';   
					}
				}  
				/* standard part manuf end */
			}
		 }
		 
		 $this->load->model('catalog/information');
		 
		 $informations = $this->model_catalog_information->getInformations();
		 
		 foreach ($informations as $information) {
			if($all_language AND $url_status){
				foreach ($lang_codes as $lang_code) {
					$_SESSION['language'] = $lang_code;
					$output .= '<url>';
					$output .= '<loc>' . $this->url->link('information/information', 'information_id=' . $information['information_id']) . '</loc>';
					$output .= '<changefreq>'. $this->freq .'</changefreq>';
					$output .= '<priority>'. $this->priorOther .'</priority>';
					$output .= '</url>';   
				}
			}else{
				$output .= '<url>';
				$output .= '<loc>' . $this->url->link('information/information', 'information_id=' . $information['information_id']) . '</loc>';
				$output .= '<changefreq>'. $this->freq .'</changefreq>';
				$output .= '<priority>'. $this->priorOther .'</priority>';
				$output .= '</url>';   
			}
		 }

		 $output .= '</urlset>';
		 
		 $this->cache->set('sssb.feed.sitemap.' . $this->config->get('config_store_id'), $output);
		 if (ob_get_contents()) ob_end_clean();
		 $this->response->addHeader('Content-Type: application/xml');
		 $this->response->setOutput($output);
	  }
   }
   
   protected function getCategories($parent_id, $current_path = '') {
		$all_language 	= $this->ssb_setting['tools']['sitemap']['data']['all_language'];
		$url_status 	= $this->ssb_data->getEntityStatus('urls');
		$lang_codes 	= $this->ssb_helper->getArrayLangCode();
	  
	  $output = '';
	  
	  $results = $this->model_catalog_category->getCategories($parent_id);
	  
	  foreach ($results as $result) {
		 if (!$current_path) {
			$new_path = $result['category_id'];
		 } else {
			$new_path = $current_path . '_' . $result['category_id'];
		 }
		
		if($all_language AND $url_status){
			foreach ($lang_codes as $lang_code) {
				$_SESSION['language'] = $lang_code;
				$output .= '<url>';
				$output .= '<loc>' . htmlspecialchars($this->url->link('product/category', 'path=' . $new_path)) . '</loc>';
				$output .= '<changefreq>'. $this->freq .'</changefreq>';
				$output .= '<priority>'. $this->priorOther .'</priority>';
				$output .= '</url>';
			}
		}else{
			$output .= '<url>';
			$output .= '<loc>' . htmlspecialchars($this->url->link('product/category', 'path=' . $new_path)) . '</loc>';
			$output .= '<changefreq>'. $this->freq .'</changefreq>';
			$output .= '<priority>'. $this->priorOther .'</priority>';
			$output .= '</url>';
		}
		          

		 if(!$this->only_canonical){
			 $products = $this->model_catalog_product->getProducts(array('filter_category_id' => $result['category_id']));
			 
			 foreach ($products as $product) {
				if($all_language AND $url_status){
					foreach ($lang_codes as $lang_code) {
						$_SESSION['language'] = $lang_code;
						$output .= '<url>';
						$output .= '<loc>' . htmlspecialchars($this->url->link('product/product', 'path=' . $new_path . '&product_id=' . $product['product_id'])) . '</loc>';
						$output .= '<changefreq>'. $this->freq .'</changefreq>';
						$output .= '<priority>'. $this->priorOther .'</priority>';
						$output .= '</url>'; 
					}
				}else{
					$output .= '<url>';
					$output .= '<loc>' . htmlspecialchars($this->url->link('product/product', 'path=' . $new_path . '&product_id=' . $product['product_id'])) . '</loc>';
					$output .= '<changefreq>'. $this->freq .'</changefreq>';
					$output .= '<priority>'. $this->priorOther .'</priority>';
					$output .= '</url>';  
				} 
			 }   
		 }
		 $output .= $this->getCategories($result['category_id'], $new_path);
	  }

	  return $output;
   }  

}
?>