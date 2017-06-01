<?php
class ControllerModuleCurrencyPlus extends Controller {
    private $error = array();
    private $type = 'module';
    private $name = 'currency_plus';

    public function install() {
        $this->load->model('localisation/currency');

        $this->model_localisation_currency->create_fields();
    }

    public function index() {
        $this->load->language($this->type . '/' . $this->name);
            
        $this->document->setTitle($this->language->get('heading_title'));

        $this->load->model('setting/setting');
        $this->load->model('localisation/currency');

        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
            $this->model_localisation_currency->create_fields();

            $this->model_setting_setting->editSetting($this->name, $this->request->post);

            $this->session->data['success'] = $this->language->get('text_success');

            $this->redirect($this->url->link('extension/'.$this->type, 'token=' . $this->session->data['token'], 'SSL'));
        }

        $this->data['heading_title'] = $this->language->get('heading_title');

        if (isset($this->session->data['success'])) {
            $this->data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        } else {
            $this->data['success'] = '';
        }
      
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/'.$this->type, 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link($this->type . '/'.$this->name, 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        
        $this->data['entry_show_base_price'] = $this->language->get('entry_show_base_price');
        $this->data['entry_show_base_price_cat'] = $this->language->get('entry_show_base_price_cat');
        $this->data['entry_round'] = $this->language->get('entry_round');
        $this->data['entry_charcode'] = $this->language->get('entry_charcode');

        $this->data['text_digit1'] = $this->language->get('text_digit1');
        $this->data['text_digit9'] = $this->language->get('text_digit9');
        $this->data['text_digit10'] = $this->language->get('text_digit10');
        $this->data['text_digit50'] = $this->language->get('text_digit50');
        $this->data['text_digit100'] = $this->language->get('text_digit100');
        $this->data['text_noround'] = $this->language->get('text_noround');
        $this->data['text_charcode'] = $this->language->get('text_charcode');

        $this->data['text_rub'] = $this->language->get('text_rub');
        $this->data['text_uah'] = $this->language->get('text_uah');
        $this->data['text_byr'] = $this->language->get('text_byr');
        $this->data['text_kzt'] = $this->language->get('text_kzt');

        $this->data['button_save'] = $this->language->get('button_save');
        $this->data['button_cancel'] = $this->language->get('button_cancel');

        $this->data['action'] = $this->url->link($this->type.'/'.$this->name, 'token=' . $this->session->data['token'], 'SSL');
        $this->data['cancel'] = $this->url->link('extension/'.$this->type, 'token=' . $this->session->data['token'], 'SSL');

        $this->data['name'] = $this->name;

        if (isset($this->request->post[$this->name.'_show_base_price'])) {
            $this->data[$this->name.'_show_base_price'] = $this->request->post[$this->name.'_show_base_price'];
        } else {
            $this->data[$this->name.'_show_base_price'] = $this->config->get($this->name.'_show_base_price');
        }

        if (isset($this->request->post[$this->name.'_show_base_price_cat'])) {
            $this->data[$this->name.'_show_base_price_cat'] = $this->request->post[$this->name.'_show_base_price_cat'];
        } else {
            $this->data[$this->name.'_show_base_price_cat'] = $this->config->get($this->name.'_show_base_price_cat');
        }

        if (isset($this->request->post[$this->name.'_round'])) {
            $this->data[$this->name.'_round'] = $this->request->post[$this->name.'_round'];
        } else {
            $this->data[$this->name.'_round'] = $this->config->get($this->name.'_round');
        }

        if (isset($this->request->post[$this->name.'_charcode'])) {
            $this->data[$this->name.'_charcode'] = $this->request->post[$this->name.'_charcode'];
        } else {
            $this->data[$this->name.'_charcode'] = $this->config->get($this->name.'_charcode');
        }

        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } else {
            $this->data['error_warning'] = '';
        }
        
        $this->template = $this->type . '/'.$this->name.'.tpl';
        $this->children = array(
            'common/header',
            'common/footer'
        );

        $this->response->setOutput($this->render());
    }

    private function validate() {
        if (!$this->user->hasPermission('modify', $this->type . '/' . $this->name)) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if ($this->error && !isset($this->error['warning'])) {
            $this->error['warning'] = $this->language->get('error_warning');
        }

        if (!$this->error) {
            return true;
        } else {
            return false;
        }  
    }
}
?>