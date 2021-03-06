<?php
class ControllerModuleCategoryMgr extends Controller
{
    private $error = array();
    
    public function index()
    {
        $this->load->language('module/category_mgr');
        
        $this->document->setTitle(strip_tags($this->language->get('heading_title')));
        
        $this->load->model('setting/setting');
        
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            
            $this->model_setting_setting->editSetting('category_mgr', $this->request->post);
            
            $this->session->data['success'] = $this->language->get('text_success');
            
            $this->redirect($this->url->link('catalog/category_mgr', 'token=' . $this->session->data['token'], 'SSL'));
        }
        
        $text_strings = array(
            'heading_title',
            'button_save',
            'button_cancel',
            'button_open',
            'text_yes',
            'text_no',
            'text_add_subcategories'
        );
        
        foreach ($text_strings as $text) {
            $this->data[$text] = $this->language->get($text);
        }
        
        $this->initField('category_mgr_add_subcategories', true);
        $this->data['token'] = $this->session->data['token'];
        
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        
        $this->data['breadcrumbs'] = array();
        
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );
        
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_module'),
            'href' => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/category_mgr', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['action'] = $this->url->link('module/category_mgr', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        
        $this->template = 'module/category_mgr.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );
        
        $this->response->setOutput($this->render());
    }
    
    private function initField($field_name, $default_value = '')
    {
        if (isset($this->request->post[$field_name])) {
            $this->data[$field_name] = $this->request->post[$field_name];
        } elseif (!is_null($this->config->get($field_name))) {
            $this->data[$field_name] = $this->config->get($field_name);
        } else {
            $this->data[$field_name] = $default_value;
        }
    }
    public function install()
    {
        $this->load->model('user/user_group');
        
        $this->model_user_user_group->addPermission($this->user->getId(), 'access', 'catalog/category_mgr');
        $this->model_user_user_group->addPermission($this->user->getId(), 'modify', 'catalog/category_mgr');
    }
    
    public function uninstall()
    {
    }
    
    private function validate()
    {
        if (!$this->user->hasPermission('modify', 'module/category_mgr')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
        
        if (!$this->error) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
    
}
?>