<?php
class ControllerCatalogCategoryMgr extends Controller
{
    private $error = array();
    
    public function __construct($params)
    {
        parent::__construct($params);
        if (!$this->config->get('category_mgr_add_subcategories')) {
            $this->redirect($this->url->link('module/category_mgr', 'token=' . $this->session->data['token'], 'SSL'));
        }
    }
    
    public function delete_product()
    {
        $json        = array();
        $json['ret'] = 'fail';
        if (isset($this->request->post['ids'])) {
            $ids = $this->request->post['ids'];
            $this->load->model('catalog/product');
            foreach ($ids as $id) {
                $product_id = ctype_digit($id) ? $id : 0;
                if ($product_id) {
                    $this->model_catalog_product->deleteProduct($product_id);
                }
            }
            $json['ret'] = 'ok';
        }
        $this->response->addHeader('Content-Type: application/json; charset=utf-8');
        $this->response->setOutput(json_encode($json));
    }
    
    public function state_product()
    {
        $json        = array();
        $json['ret'] = 'fail';
        if (isset($this->request->post['ids']) && isset($this->request->post['state'])) {
            $ids   = $this->request->post['ids'];
            $state = ($this->request->post['state'] == '1') ? 1 : 0;
            $this->load->model('catalog/category_mgr');
            foreach ($ids as $id) {
                $product_id = ctype_digit($id) ? $id : 0;
                if ($product_id) {
                    $this->model_catalog_category_mgr->setProductState($product_id, $state);
                }
            }
            $json['ret'] = 'ok';
            
        }
        $this->response->addHeader('Content-Type: application/json; charset=utf-8');
        $this->response->setOutput(json_encode($json));
    }
    
    public function move_product()
    {
        $json        = array();
        $json['ret'] = 'fail';
        if (isset($this->request->post['ids']) && isset($this->request->post['source']) && isset($this->request->post['target']) && isset($this->request->post['copy'])) {
            $ids    = $this->request->post['ids'];
            $copy   = ($this->request->post['copy'] == 'true');
            $source = ctype_digit($this->request->post['source']) ? $this->request->post['source'] : 0;
            $target = ctype_digit($this->request->post['target']) ? $this->request->post['target'] : 0;
            if ($target) {
                $json['ret'] = 'ok';
                $this->load->model('catalog/category_mgr');
                $main_category = $this->model_catalog_category_mgr->isMainCategoryPresent();
                foreach ($ids as $id) {
                    $product_id = ctype_digit($id) ? $id : 0;
                    if ($product_id) {
                        $this->model_catalog_category_mgr->deleteProductCategory($product_id, $target);
                        $this->model_catalog_category_mgr->createProductCategory($product_id, $target);
                        
                        if (!$copy) {
                            if ($source) {
                                $this->model_catalog_category_mgr->deleteProductCategory($product_id, $source);
                            }
                        }
                        
                        if ($main_category)
                            $this->model_catalog_category_mgr->setMainProductCategory($product_id);
                    }
                }
            }
        }
        $this->response->addHeader('Content-Type: application/json; charset=utf-8');
        $this->response->setOutput(json_encode($json));
    }
    
    public function products()
    {
        $json          = array();
        $products      = array();
        $product_total = 0;
        if (isset($this->request->get['id']) && isset($this->request->get['limit']) && isset($this->request->get['offset'])) {
            $id     = $this->request->get['id'];
            $limit  = $this->request->get['limit'];
            $offset = $this->request->get['offset'];
            $sort   = isset($this->request->get['sort']) ? $this->request->get['sort'] : 'name';
            $order  = isset($this->request->get['order']) ? $this->request->get['order'] : 'desc';
            $text   = isset($this->request->get['txt']) ? $this->request->get['txt'] : '';
            if ($id >= 0) {
                
                $this->load->model('catalog/category_mgr');
                $this->load->model('catalog/product');
                $this->load->model('tool/image');
                
                $data          = array(
                    'filter_category_id' => $id,
                    'filter_name' => $text,
                    'sort' => $sort,
                    'order' => $order,
                    'start' => $offset,
                    'limit' => $limit
                    
                );
                $product_total = $this->model_catalog_category_mgr->getTotalProducts($data);
                $results       = $this->model_catalog_category_mgr->getProducts($data);
                foreach ($results as $result) {
                    
                    if ($result['image'] && file_exists(DIR_IMAGE . $result['image'])) {
                        $image = $this->model_tool_image->resize($result['image'], 40, 40);
                    } else {
                        $image = $this->model_tool_image->resize('no_image.jpg', 40, 40);
                    }
                    
                    $special = false;
                    
                    $product_specials = $this->model_catalog_product->getProductSpecials($result['product_id']);
                    
                    foreach ($product_specials as $product_special) {
                        if (($product_special['date_start'] == '0000-00-00' || $product_special['date_start'] > date('Y-m-d')) && ($product_special['date_end'] == '0000-00-00' || $product_special['date_end'] < date('Y-m-d'))) {
                            $special = $product_special['price'];
                            
                            break;
                        }
                    }
                    
                    $products[] = array(
                        'product_id' => $result['product_id'],
                        'name' => $result['name'],
                        'model' => $result['model'],
                        'price' => $result['price'],
                        'special' => $special,
                        'image' => $image,
                        'quantity' => $result['quantity'],
                        'sort_order' => $result['sort_order'],
                        'status' => $result['status'],
                        'status_text' => ($result['status'] ? $this->language->get('text_enabled') : $this->language->get('text_disabled'))
                    );
                }
            }
        }
        
        $json['total'] = $product_total;
        $json['rows']  = $products;
        $this->response->addHeader('Content-Type: application/json; charset=utf-8');
        $this->response->setOutput(json_encode($json));
    }
    
    public function tree()
    {
        $json        = array();
        $need_repair = false;
        $operation   = isset($this->request->get['operation']) ? $this->request->get['operation'] : '';
        $root        = (isset($this->request->get['id']) && $this->request->get['id'] == '#');
        $node        = isset($this->request->get['id']) && ctype_digit($this->request->get['id']) ? $this->request->get['id'] : 0;
        $this->load->model('catalog/category_mgr');
        if ($operation == 'get_node') {
            if ($root) {
                $json[] = array(
                    'data' => array(
                        'status' => 1
                    ),
                    'text' => '',
                    'children' => true,
                    'id' => "0",
                    'icon' => 'jstree-folder'
                );
            } else {
                $cats = $this->model_catalog_category_mgr->getChildren($node);
                foreach ($cats as $cat) {
                    $json[] = array(
                        'data' => array(
                            'status' => $cat['status']
                        ),
                        'text' => $cat['name'],
                        'children' => $cat['children'] > 0,
                        'id' => $cat['category_id'],
                        'icon' => 'jstree-folder',
                        'a_attr' => array(
                            'ico-disabled' => !(bool) $cat['status']
                        )
                    );
                }
            }
        }
        
        if ($operation == 'create_node') {
            if (isset($this->request->get['name'])) {
                $parent = isset($this->request->get['parent']) && $this->request->get['parent'] !== '#' && ctype_digit($this->request->get['parent']) ? $this->request->get['parent'] : 0;
                
                $this->load->model('catalog/category');
                $parent_category_stores = $this->model_catalog_category->getCategoryStores($parent);
                
                $newCategory = array(
                    'parent_id' => $parent,
                    'column' => 1,
                    'sort_order' => 0,
                    'status' => $this->config->get('default_status') ? $this->config->get('default_status') : 0,
                    'category_description' => array(
                        $this->config->get('config_language_id') => array(
                            'name' => $this->request->get['name'],
                            'meta_keyword' => '',
                            'meta_description' => '',
                            'description' => ''
                        )
                    ),
                    'category_store' => $parent_category_stores,
                    'keyword' => false
                );
                
                $this->model_catalog_category->addCategory($newCategory);
                $json['ret'] = 'ok';
            }
        }
        
        if ($operation == 'rename_node') {
            if (isset($this->request->get['name'])) {
                $this->model_catalog_category_mgr->setCategoryName($node, $this->request->get['name']);
                $json['ret'] = 'ok';
            }
        }
        
        if ($operation == 'move_node') {
            $parent   = isset($this->request->get['parent']) && $this->request->get['parent'] !== '#' && ctype_digit($this->request->get['parent']) ? $this->request->get['parent'] : 0;
            $position = isset($this->request->get['position']) && ctype_digit($this->request->get['position']) ? $this->request->get['position'] : 0;
            
            $item = $this->model_catalog_category_mgr->getCategory($node);
            $cats = $this->model_catalog_category_mgr->getChildren($parent);
            if ($item['parent_id'] != $parent) {
                if (isset($cats[$position])) {
                    $moved      = $cats[$position];
                    $sort_order = $moved['sort_order'];
                } else
                    $sort_order = 0;
                $need_repair = true;
                
                $this->model_catalog_category_mgr->moveCategory($node, $parent, $sort_order);
                
            } else {
                $old_indx = 0;
                foreach ($cats as $cat) {
                    if ($cat['category_id'] == $node) {
                        //
                        break;
                    }
                    $old_indx++;
                }
                
                if ($old_indx < $position) {
                    if ($position < count($cats) - 1) {
                        $moved      = $cats[$position + 1];
                        $sort_order = $moved['sort_order'];
                    } else {
                        $moved      = $cats[$position];
                        $sort_order = $moved['sort_order'] + 1;
                    }
                } else {
                    $moved      = $cats[$position];
                    $sort_order = $moved['sort_order'];
                }
                $this->model_catalog_category_mgr->setOrder($node, $sort_order);
            }
            
            $this->model_catalog_category_mgr->resortCategories($parent, $node, $sort_order);
            
            if ($need_repair) {
                $this->model_catalog_category_mgr->repairCategories($parent);
                $this->model_catalog_category_mgr->repairCategories($item['parent_id']);
            }
            
            $json['id']         = $node;
            $json['sort_order'] = $sort_order;
            $json['parent']     = $parent;
            $json['repair']     = $need_repair;
        }
        
        $this->response->addHeader('Content-Type: application/json; charset=utf-8');
        $this->response->setOutput(json_encode($json));
    }
    
    public function remove_product_category()
    {
        $json        = array();
        $json['ret'] = 'fail';
        if (isset($this->request->post['ids']) && isset($this->request->post['categories'])) {
            $ids  = $this->request->post['ids'];
            $cats = $this->request->post['categories'];
            
            $this->load->model('catalog/category_mgr');
            foreach ($cats as $cat) {
                $category_id = ($cat !== '#' && ctype_digit($cat)) ? $cat : 0;
                if ($category_id) {
                    foreach ($ids as $id) {
                        $product_id = ($id !== '#' && ctype_digit($id)) ? $id : 0;
                        if ($product_id) {
                            $this->model_catalog_category_mgr->deleteProductCategory($product_id, $category_id);
                        }
                    }
                }
            }
            $json['ret'] = 'ok';
            
        }
        $this->response->addHeader('Content-Type: application/json; charset=utf-8');
        $this->response->setOutput(json_encode($json));
    }
    
    public function delete()
    {
        $json        = array();
        $json['ret'] = 'fail';
        if (isset($this->request->post['ids'])) {
            $ids = $this->request->post['ids'];
            $this->load->model('catalog/category');
            foreach ($ids as $id) {
                $node = ($id !== '#' && ctype_digit($id)) ? $id : 0;
                if ($node) {
                    $this->model_catalog_category->deleteCategory($node);
                }
            }
            $json['ret'] = 'ok';
            
        }
        $this->response->addHeader('Content-Type: application/json; charset=utf-8');
        $this->response->setOutput(json_encode($json));
    }
    
    public function state()
    {
        $json        = array();
        $json['ret'] = 'fail';
        if (isset($this->request->post['ids']) && isset($this->request->post['state'])) {
            $ids   = $this->request->post['ids'];
            $state = ($this->request->post['state'] == '1') ? 1 : 0;
            $this->load->model('catalog/category_mgr');
            foreach ($ids as $id) {
                $node = ($id !== '#' && ctype_digit($id)) ? $id : 0;
                if ($node) {
                    $this->model_catalog_category_mgr->setCategoryState($node, $state);
                }
            }
            $json['ret'] = 'ok';
            
        }
        $this->response->addHeader('Content-Type: application/json; charset=utf-8');
        $this->response->setOutput(json_encode($json));
    }
    
    public function index()
    {
        
        $this->load->language('catalog/category_mgr');
        $this->load->model('setting/setting');
        $set       = $this->model_setting_setting->getSetting('category_mgr');
        $installed = isset($set['category_mgr_license_info']);
        
        $this->data['add_subcategories'] = false;
        
        $this->data['add_subcategories'] = $set['category_mgr_add_subcategories'];
        
        $this->document->setTitle($this->language->get('category_mgr_heading_title'));
        
        $this->document->addScript('view/javascript/category_mgr/libs/jquery-1.11.2.min.js');
        
        $this->document->addLink('view/javascript/category_mgr/libs/jstree/themes/default/style.min.css', 'stylesheet');
        $this->document->addLink('view/javascript/category_mgr/libs/bootstrap/css/bootstrap.min.css', 'stylesheet');
        $this->document->addLink('view/javascript/category_mgr/libs/bootstrap-table/bootstrap-table.min.css', 'stylesheet');
        $this->document->addLink('view/javascript/category_mgr/libs/font-awesome/css/font-awesome.min.css', 'stylesheet');
        $this->document->addLink('view/javascript/category_mgr/category_mgr.css', 'stylesheet');
        
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        
        $base = 'view/javascript/category_mgr/libs/';
        $i    = "dnd";
        $this->document->addScript($base . 'bootstrap/js/bootstrap.js');
        $this->document->addScript($base . 'jstree/jstree.js');
        $this->document->addScript($base . 'bootstrap-table/bootstrap-table.min.js');
        
        
        $interface_lang = $this->config->get('config_admin_language');
        if ($interface_lang == 'ru')
            $this->document->addScript('view/javascript/category_mgr/libs/bootstrap-table/locale/bootstrap-table-ru-RU.min.js');
        else
            $this->document->addScript('view/javascript/category_mgr/libs/bootstrap-table/locale/bootstrap-table-en-US.min.js');
        
        $this->data['breadcrumbs'] = array();
        
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );
        
        if (isset($i)) {
            $this->data['category_mgr_script'] = $i;
        }
        
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('category_mgr_heading_title'),
            'href' => $this->url->link('catalog/category_mgr', 'token=' . $this->session->data['token'] . '', 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['category_mgr_heading_title'] = $this->language->get('category_mgr_heading_title');
        $this->data['heading_title']              = $this->data['category_mgr_heading_title'];
        
        $this->data['action'] = $this->url->link('module/category_mgr', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['token']  = $this->session->data['token'];
        
        $this->data['button_category_create']   = $this->language->get('button_category_create');
        $this->data['button_category_rename']   = $this->language->get('button_category_rename');
        $this->data['button_category_add']      = $this->language->get('button_category_add');
        $this->data['button_category_insert']   = $this->language->get('button_category_insert');
        $this->data['button_category_edit']     = $this->language->get('button_category_edit');
        $this->data['button_category_expand']   = $this->language->get('button_category_expand');
        $this->data['button_category_collapse'] = $this->language->get('button_category_collapse');
        $this->data['button_category_enable']   = $this->language->get('button_category_enable');
        $this->data['button_category_disable']  = $this->language->get('button_category_disable');
        $this->data['button_category_delete']   = $this->language->get('button_category_delete');
        $this->data['button_view_home']         = $this->language->get('button_view_home');
        
        $this->data['button_product_edit']            = $this->language->get('button_product_edit');
        $this->data['button_product_add']             = $this->language->get('button_product_add');
        $this->data['button_product_copy']            = $this->language->get('button_product_copy');
        $this->data['button_product_clone']           = $this->language->get('button_product_clone');
        $this->data['button_product_remove_category'] = $this->language->get('button_product_remove_category');
        $this->data['button_product_delete']          = $this->language->get('button_product_delete');
        $this->data['button_product_enable']          = $this->language->get('button_product_enable');
        $this->data['button_product_disable']         = $this->language->get('button_product_disable');
        
        $this->data['text_confirm_delete_category'] = $this->language->get('text_confirm_delete_category');
        $this->data['text_confirm_delete_product']  = $this->language->get('text_confirm_delete_product');
        $this->data['text_confirm_delete_products'] = $this->language->get('text_confirm_delete_products');
        
        $this->data['text_enabled']  = $this->language->get('text_enabled');
        $this->data['text_disabled'] = $this->language->get('text_disabled');
        
        $this->data['text_category']          = $this->language->get('text_category');
        $this->data['text_new_category']      = $this->language->get('text_new_category');
        $this->data['text_selected_products'] = $this->language->get('text_selected_products');
        $this->data['text_operation_move']    = $this->language->get('text_operation_move');
        $this->data['text_operation_copy']    = $this->language->get('text_operation_copy');
        
        $this->data['column_image']    = $this->language->get('column_image');
        $this->data['column_name']     = $this->language->get('column_name');
        $this->data['column_model']    = $this->language->get('column_model');
        $this->data['column_price']    = $this->language->get('column_price');
        $this->data['column_quantity'] = $this->language->get('column_quantity');
        $this->data['column_sort']     = $this->language->get('column_sort');
        $this->data['column_status']   = $this->language->get('column_status');
        $this->data['column_action']   = $this->language->get('column_action');
        
        $this->data['token'] = $this->session->data['token'];
        
        $this->template = 'catalog/category_mgr.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
        
        $this->response->setOutput($this->render());
    }
}
?>