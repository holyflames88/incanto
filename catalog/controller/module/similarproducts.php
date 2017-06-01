<?php  
class ControllerModuleSimilarproducts extends Controller {
	protected function index() {
		$this->language->load('module/similarproducts');
      	$this->data['heading_title'] = $this->language->get('heading_title');
      	$this->data['button_cart'] = $this->language->get('button_cart');
		$this->data['tab_SimilarProducts'] = $this->language->get('tab_SimilarProducts');

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$this->data['data']['SimilarProducts'] = str_replace('http', 'https', $this->config->get('SimilarProducts'));
		} else {
			$this->data['data']['SimilarProducts'] = $this->config->get('SimilarProducts');
		}
		
		$this->data['data']['SimilarProductsConfig'] = $this->config->get('similarproducts_module');
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/similarproducts.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/similarproducts.tpl';
		} else {
			$this->template = 'default/template/module/similarproducts.tpl';
		}

		$this->load->model('tool/image');
		
		$limit = $this->data['data']['SimilarProducts']['NumberOfProducts'];
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
			$product_info = $this->model_catalog_product->getProduct($product_id);
			if ($product_info['tag']) {	
	
				$tags = explode(',', $product_info['tag']);
				$tag_query = "";
				foreach ($tags as $tag) {
					$tag_query .= " OR pr.tag LIKE '%".trim(strtolower($tag))."%'";
				}
					$tag_query = "(".substr($tag_query, 4).") AND";
				$this->data['SimilarProductsRun'] = "yes";

			$this->data['products'] = array();

		if (empty($this->data['data']['SimilarProducts']['PictureWidth'])) $picture_width=80; else $picture_width=$this->data['data']['SimilarProducts']['PictureWidth'];
		if (empty($this->data['data']['SimilarProducts']['PictureHeight'])) $picture_height=80; else $picture_height=$this->data['data']['SimilarProducts']['PictureHeight'];
		
						$results = $this->model_catalog_product->getProductSimilarProducts($product_id, $tag_query);
						$i = 0;
						foreach ($results as $result) {
							if ($result['image']) {
							$image = $this->model_tool_image->resize($result['image'], $picture_width, $picture_height);
							} else {
								$image = false;
							}
							
							if (($this->config->get('config_customer_price') && $this->customer->isLogged()) || !$this->config->get('config_customer_price')) {
								$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
							} else {
								$price = false;
							}
									
							if ((float)$result['special']) {
								$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')));
							} else {
								$special = false;
							}
							
							if ($this->config->get('config_review_status')) {
								$rating = (int)$result['rating'];
							} else {
								$rating = false;
							}
										
							$this->data['products'][] = array(
								'product_id' => $result['product_id'],
								'thumb'   	 => $image,
								'name'    	 => $result['name'],
								'price'   	 => $price,
								'special' 	 => $special,
								'rating'     => $rating,
								'reviews'    => sprintf($this->language->get('text_reviews'), (int)$result['reviews']),
								'href'    	 => $this->url->link('product/product', 'product_id=' . $result['product_id']),
							);
								if (++$i == $limit) break;
			
						}	

			} else {
				$tag_query = "";
		$this->data['SimilarProductsRun'] = "no";

			}
		} else {
			$product_id = 0;
			$tag_query = "";
					$this->data['SimilarProductsRun'] = "no";

		}

		

		$this->render();
	}
	
}
?>