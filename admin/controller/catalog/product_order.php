<?php 
class ControllerCatalogProductOrder extends Controller {
	private $error = array(); 
     
  	public function index() {
		$this->load->language('catalog/product_order');
    	
		$this->document->setTitle($this->language->get('heading_title')); 
		
		$this->load->model('catalog/category');
		$this->data['categories'] = $this->model_catalog_category->getCategories(0);
		
		if (isset($this->request->get['filter_category'])) {
			$filter_category = $this->request->get['filter_category'];
		} else {
			$filter_category = NULL;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'pd.name';
			$sort = 'p2co.sort_order,p.sort_order';
		}
		
		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}
		
		$url = '';
						
		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
						
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

  		$this->data['breadcrumbs'] = array();

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
      		'separator' => false
   		);

   		$this->data['breadcrumbs'][] = array(
       		'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('catalog/product_order', 'token=' . $this->session->data['token'] . $url, 'SSL'),       		
      		'separator' => ' :: '
   		);
		
		$this->data['save'] = $this->url->link('catalog/product_order/save', 'token=' . $this->session->data['token'] . $url, 'SSL');

		if (isset($this->request->get['filter_category'])) {
			$this->data['products'] = array();

			$data = array(
				'filter_category' => $filter_category,
				'sort'            => $sort,
				'order'           => $order
			);
			
			$this->load->model('catalog/product_order');
			$this->load->model('tool/image');

			$results = $this->model_catalog_product_order->getProducts($data);

			foreach ($results as $result) {
				$action = array();
			
				$action[] = array(
					'text' => $this->language->get('text_edit'),
					'href' => $this->url->link('catalog/product/update', 'token=' . $this->session->data['token'] . '&product_id=' . $result['product_id'] . $url, 'SSL')
				);
				
				$category =  $this->model_catalog_product_order->getProductCategories($result['product_id']);
				
				if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
					$image = $this->model_tool_image->resize($result['image'], 40, 40);
				} else {
					$image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
				}
		
				$special = false;
				
				$product_specials = $this->model_catalog_product_order->getProductSpecials($result['product_id']);
				
				foreach ($product_specials  as $product_special) {
					if (($product_special['date_start'] == '0000-00-00' || $product_special['date_start'] > date('Y-m-d')) && ($product_special['date_end'] == '0000-00-00' || $product_special['date_end'] < date('Y-m-d'))) {
						$special = $product_special['price'];
				
						break;
					}					
				}
		
				$this->data['products'][] = array(
					'product_id' => $result['product_id'],
					'name'       => $result['name'],
					'model'      => $result['model'],
					'price'      => $result['price'],
					'sort_order' => $result['sort_order'],
					'special'    => $special,
					'category'   => $category,
					'image'      => $image,
					'quantity'   => $result['quantity'],
					'status'     => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled')),
					'selected'   => isset($this->request->post['selected']) && in_array($result['product_id'], $this->request->post['selected']),
					'action'     => $action
				);
			}
		} else {
			$this->data['products'] = array();
		}
		
		$this->data['token'] = $this->session->data['token'];
		
 		if (isset($this->error['warning'])) {
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

		$url = '';

		if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
								
		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
        $this->data['sort_category'] = $this->url->link('catalog/product_order', 'token=' . $this->session->data['token'] . '&sort=p2c.category' . $url, 'SSL');
		$this->data['sort_order'] = $this->url->link('catalog/product_order', 'token=' . $this->session->data['token'] . '&sort=p2co.sort_order,p.sort_order' . $url, 'SSL');
		
		$this->data['sort_name'] = $this->url->link('catalog/product_order', 'token=' . $this->session->data['token'] . '&sort=pd.name' . $url, 'SSL');
		$this->data['sort_model'] = $this->url->link('catalog/product_order', 'token=' . $this->session->data['token'] . '&sort=p.model' . $url, 'SSL');
		$this->data['sort_price'] = $this->url->link('catalog/product_order', 'token=' . $this->session->data['token'] . '&sort=p.price' . $url, 'SSL');
		$this->data['sort_quantity'] = $this->url->link('catalog/product_order', 'token=' . $this->session->data['token'] . '&sort=p.quantity' . $url, 'SSL');
		$this->data['sort_status'] = $this->url->link('catalog/product_order', 'token=' . $this->session->data['token'] . '&sort=p.status' . $url, 'SSL');
		
		$url = '';

		// Add
        if (isset($this->request->get['filter_category'])) {
			$url .= '&filter_category=' . $this->request->get['filter_category'];
		}
        // End add
		
		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}
												
		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}
		
		$this->data['heading_title'] = $this->language->get('heading_title');
		
		$this->data['column_image'] = $this->language->get('column_image');
		$this->data['column_sort_order'] = $this->language->get('column_sort_order');
		$this->data['column_name'] = $this->language->get('column_name');	
		$this->data['column_category'] = $this->language->get('column_category');
		$this->data['column_model'] = $this->language->get('column_model');
		$this->data['column_price'] = $this->language->get('column_price');
		$this->data['column_quantity'] = $this->language->get('column_quantity');
		$this->data['column_status'] = $this->language->get('column_status');
		$this->data['column_action'] = $this->language->get('column_action');
		
		$this->data['text_no_results'] = $this->language->get('text_no_results');
		
		$this->data['button_save'] = $this->language->get('button_save');
		$this->data['button_filter'] = $this->language->get('button_filter');
		
		$this->data['filter_category'] = $filter_category;
		
		$this->data['sort'] = $sort;
		$this->data['order'] = $order;

		$this->template = 'catalog/product_order.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
				
		$this->response->setOutput($this->render());
  	}
	
	public function save() {
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			$this->load->model('catalog/product_order');
			$this->model_catalog_product_order->saveSortOrders($this->request->post);
			
			$this->load->language('catalog/product_order');
			$this->session->data['success'] = $this->language->get('text_success');
		}
		$this->index();
  	}
}
?>