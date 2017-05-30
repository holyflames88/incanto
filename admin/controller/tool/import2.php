<?php
set_time_limit( 86400 );
error_reporting(E_ALL);
class ControllerToolImport2 extends Controller { 
	private $error = array();
	
	public function index() {
		$this->load->language('tool/import2');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('tool/import2');
		$this->getForm();
	}


	public function upload() {
		$this->load->language('tool/import2');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('tool/import2');
        if($_REQUEST['final_redirect']!='')
        {

            $this->session->data['success'] = $this->language->get('text_success');
            $this->redirect($this->url->link('tool/import2', 'token=' . $this->session->data['token'], 'SSL'));
            exit();
        }
		if ($this->request->server['REQUEST_METHOD'] == 'POST') {

			if ((isset( $this->request->files['upload'] )) && (is_uploaded_file($this->request->files['upload']['tmp_name']))) {
				$file = $this->request->files['upload']['tmp_name'];
               	if ($this->model_tool_import2->upload($file)===true) {
					$this->session->data['success'] = $this->language->get('text_success');
					$this->redirect($this->url->link('tool/import2', 'token=' . $this->session->data['token'], 'SSL'));
				}
				else {
					$this->error['warning'] = $this->language->get('error_upload');
					$this->error['warning'] .= "<br />\n".$this->language->get( 'text_log_details' );
				}
			}
		}

		$this->getForm();
	}

    public function ajax() {

       $fp = file_get_contents(DIR_LOGS.'ajax_status.log');
       echo $fp;
       exit();

    }

	protected function return_bytes($val)
	{
		$val = trim($val);
	
		switch (strtolower(substr($val, -1)))
		{
			case 'm': $val = (int)substr($val, 0, -1) * 1048576; break;
			case 'k': $val = (int)substr($val, 0, -1) * 1024; break;
			case 'g': $val = (int)substr($val, 0, -1) * 1073741824; break;
			case 'b':
				switch (strtolower(substr($val, -2, 1)))
				{
					case 'm': $val = (int)substr($val, 0, -2) * 1048576; break;
					case 'k': $val = (int)substr($val, 0, -2) * 1024; break;
					case 'g': $val = (int)substr($val, 0, -2) * 1073741824; break;
					default : break;
				} break;
			default: break;
		}
		return $val;
	}

	public function settings() {
       	$this->load->language('tool/import2');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('tool/import2');
		if (($this->request->server['REQUEST_METHOD'] == 'POST')) {
			if (!isset($this->request->post['import_settings_use_import_cache'])) {
				$this->request->post['import_settings_use_import_cache'] = '0';
			}
			$this->load->model('setting/setting');
			$this->model_setting_setting->editSetting('import2', $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_settings');
			$this->redirect($this->url->link('tool/import2', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getForm();
	}

    public function updatecolors(){
        if($_REQUEST['old_id']>0 && $_REQUEST['new_id']>0 && $_REQUEST['old_id']!=$_REQUEST['new_id']){
            $sql = "UPDATE ".DB_PREFIX."parser_temp_color SET id_in_oc = ".$_REQUEST['new_id']." WHERE id_in_oc = ".$_REQUEST['old_id'];
            $this->db->query($sql);
        }

        return;
    }


	protected function getForm() {

		$this->data['heading_title'] = $this->language->get('heading_title');

		$this->data['tab_export'] = $this->language->get( 'tab_export' );
		$this->data['tab_import'] = $this->language->get( 'tab_import' );
		$this->data['tab_settings'] = $this->language->get( 'tab_settings' );
        $this->data['tab_all_colors'] = $this->language->get( 'tab_all_colors' );
        $this->data['tab_missing_colors'] = $this->language->get( 'tab_missing_colors' );

		$this->data['button_export'] = $this->language->get( 'button_export' );
		$this->data['button_import'] = $this->language->get( 'button_import' );
		$this->data['button_settings'] = $this->language->get( 'button_settings' );
		$this->data['button_export_id'] = $this->language->get( 'button_export_id' );
		$this->data['button_export_page'] = $this->language->get( 'button_export_page' );

        $this->data['description_import'] = $this->language->get( 'description_import' );
        $this->data['description_file'] = $this->language->get( 'description_file' );
        $this->data['description_all_colors'] = $this->language->get( 'description_all_colors' );
        $this->data['description_missing_colors'] = $this->language->get( 'description_missing_colors' );

        $this->data['label_new_products'] = $this->language->get( 'label_new_products' );
        $this->data['label_storage'] = $this->language->get( 'label_storage' );
        $this->data['label_color'] = $this->language->get( 'label_color' );
        $this->data['label_size'] = $this->language->get( 'label_size' );
        $this->data['label_relatedoptions'] = $this->language->get( 'label_relatedoptions' );

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
			'text'      => $this->language->get('heading_title'),
			'href'      => $this->url->link('tool/import2', 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);

		$this->data['import'] = $this->url->link('tool/import2/upload', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['settings'] = $this->url->link('tool/import2/settings', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['updatecolors'] = $this->url->link('tool/import2/updatecolors', 'token=' . $this->session->data['token'], 'SSL');
		$this->data['post_max_size'] = $this->return_bytes( ini_get('post_max_size') );
		$this->data['upload_max_filesize'] = $this->return_bytes( ini_get('upload_max_filesize') );

        $code = $this->config->get('config_language');
        $sql = "SELECT language_id FROM `".DB_PREFIX."language` WHERE code = '$code'";
        $result = $this->db->query( $sql );
        $language_id = 1;
        if ($result->rows) {
            foreach ($result->rows as $row) {
                $language_id = $row['language_id'];
                break;
            }
        }
        //////////////
        $sql = "SELECT option_value_id,name FROM ".DB_PREFIX."option_value_description WHERE language_id=".$language_id." AND option_id=".$this->config->get( 'import_settings_color' );

        $query = $this->db->query($sql);
        $option_color_description = array();
        if ($query->num_rows) {
            foreach ($query->rows as $row) {
                $option_color_description[$row['option_value_id']] = $row['name'];
            }
        }
        $this->data['option_color_description'] = $option_color_description;
        $select = '<select class="colors">';
        foreach($option_color_description as $k=>$v){
            $select.= "<option value=\"".$k."\" >".$v."</option>";
        }
        $select .= '</select>';
        $this->data['option_color_select_description'] = $select;

        $sql = "SELECT id_in_oc,name FROM ".DB_PREFIX."parser_temp_color WHERE 1";

        $query = $this->db->query($sql);
        $all_color_option_id = array();
        if ($query->num_rows) {
            foreach ($query->rows as $row) {
                $all_color_option_id[$row['id_in_oc']] = $row['name'];
            }
        }
        $this->data['option_all_color_description'] = $all_color_option_id;
        $this->data['import_settings_brands'] = '';
        $this->data['import_settings_brands'] = $this->config->get( 'import_settings_brands' );

        ////////////////
        $sql = "SELECT option_id,name FROM ".DB_PREFIX."option_description WHERE language_id=".$language_id;

        $query = $this->db->query($sql);
        $option_id = array();
        if ($query->num_rows) {
            foreach ($query->rows as $row) {
                $option_id[$row['option_id']] = $row['name'];
            }
        }
        $this->data['option_description'] = $option_id;

        $sql = "SELECT relatedoptions_variant_id,relatedoptions_variant_name FROM ".DB_PREFIX."relatedoptions_variant";

        $query = $this->db->query($sql);
        $relatedoptions_id = array();
        if ($query->num_rows) {
            foreach ($query->rows as $row) {
                $relatedoptions_id[$row['relatedoptions_variant_id']] = $row['relatedoptions_variant_name'];
            }
        }
        $this->data['relatedoptions_id'] = $relatedoptions_id;

        if ($this->config->get( 'import_settings_color' )) {
            $this->data['import_settings_color'] = $this->config->get( 'import_settings_color' );
        }
        if ($this->config->get( 'import_settings_size' )) {
            $this->data['import_settings_size'] = $this->config->get( 'import_settings_size' );
        }
//        if ($this->config->get( 'import_relatedoptions_id' )) {
//            $this->data['import_relatedoptions_id'] = $this->config->get( 'import_relatedoptions_id' );
//        }

		$this->data['token'] = $this->session->data['token'];

		$this->template = 'tool/import2.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);
		$this->response->setOutput($this->render());
	}
}
?>