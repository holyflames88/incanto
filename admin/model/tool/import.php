<?php
error_reporting(0);
ignore_user_abort(true);
class ModelToolImport extends Model {

    protected function getDefaultLanguageId() {
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
        return $language_id;
    }


    protected function getLanguages() {
        $query = $this->db->query( "SELECT * FROM `".DB_PREFIX."language` WHERE `status`=1 ORDER BY `code`" );
        return $query->rows;
    }

    protected function clearCache() {
        $this->cache->delete('*');
    }

    public function write_log($txt)
    {
        //1
        $fp = fopen(DIR_LOGS.'xml_parser.log', 'a+');
        @fwrite($fp, $txt." \n");
        @fclose($fp);
        unset($fp);
    }

    public function ajax_status($txt)
    {
        echo '
        <div id="information" style="width"></div>
            <script language="javascript">
                    document.getElementById("information").innerHTML="'.$txt.'";
              </script>';
        echo str_repeat(' ',1024*64);
        flush();
        return;
    }
    public function ajax_redirect(){
        $url =  $this->url->link('tool/import', 'token=' . $this->session->data['token'], 'SSL');
        $url = str_replace('&amp;', '&', $url);
        echo '<script language="javascript">window.location = "'.$url.'&final_redirect=1"</script>';
        echo str_repeat(' ',1024*64);
        flush();
        return;
    }

    public function remove_u($dir)
    {
        //1
        if(is_file($dir)) return unlink($dir);

        $dh=opendir($dir);
        while(false!==($file=readdir($dh)))
        {
            if($file=='.'||$file=='..') continue;
            $this->remove_u($dir."/".$file);
        }
        closedir($dh);

        return rmdir($dir);
    }

    public function ParseFile($fp){
        //1
        $offer="";
        $count_off = 0;
        $count_file=0;
        $tmp_file= DIR_LOGS."xml_folder/";
        while ($data = fgets($fp)) {
            if(trim($data)=='<KATEGORIE>')
                continue;
            if(trim($data)=='</KATEGORIE>')
                continue;
            if(str_replace('<KATEGORIA kategoria_id', '', $data)!=$data)
                continue;
            if($this->request->post['action']==1){
                if(trim($data)=='</ROOT>')
                    continue;
            }

            if(str_replace('<?xml version="1.0"', '', $data)!=$data){
                $this->ajax_status("Division of the main file into smaller parts: file ".$count_file);
                $fp1 = fopen($tmp_file.$count_file.'.xml', 'w');
                fwrite($fp1, "");
            }
            if((str_replace("<TOWARY>", '', $data)!=$data) && $count_off==0 ){
                $count_file+=1;
                fwrite($fp1, "</ROOT> \n");
                fclose($fp1);
                continue;
            }
            if($this->request->post['action']==1){
                if((str_replace("<PRODUKT>", '', $data)!=$data) && $count_off==0 ){
                    $this->ajax_status("Division of the main file into smaller parts: file ".$count_file);
                    $fp1 = fopen($tmp_file.$count_file.'.xml', 'w');
                    fwrite($fp1, '<?xml version="1.0" encoding="utf-8" ?>'."\n"." <TOWARY> \n".$offer);
                    fclose($fp1);
                    $fp1 = fopen($tmp_file.$count_file.'.xml', 'a+');
                    $count_file++;
                }
            }
            elseif($this->request->post['action']==0){
                if((str_replace("<PRODUKT>", '', $data)!=$data) && $count_off==0 ){
                    $this->ajax_status("Division of the main file into smaller parts: file ".$count_file);
                    $fp1 = fopen($tmp_file.$count_file.'.xml', 'w');
                    fwrite($fp1, '<?xml version="1.0" encoding="utf-8" ?>'."\n"." <ROOT> \n".$offer);
                    fclose($fp1);
                    $fp1 = fopen($tmp_file.$count_file.'.xml', 'a+');
                    $count_file++;
                }
            }

            if("<KOLORY>"==$data)
                @fwrite($fp1,$data);
            if(str_replace('<KOLOR kolor_id=', '', $data)!=$data && str_replace('</KOLOR>', '', $data)==$data){
                $data = trim($data);
            }
            if(str_replace('<ROZMIAR rozmiar_id=', '', $data)!=$data && str_replace('</ROZMIAR>', '', $data)==$data)
                $data = trim($data);
            if(str_replace('<WZOR wzor_id=', '', $data)!=$data && str_replace('</WZOR>', '', $data)==$data)
                $data = trim($data);
            if(str_replace('<PRODUCENT producent_id=', '', $data)!=$data && str_replace('</PRODUCENT>', '', $data)==$data)
                $data = trim($data);

            if(str_replace("</PRODUKT>", '', $data)!=$data)
                $count_off+=1;
            if($data!='' && @isset($fp1))
                @fwrite($fp1,$data);

            if($count_off == 500 && $this->request->post['action']==1 && str_replace("</TOWARY>", '', $data)==$data){
                $count_off=0;
                fwrite($fp1, '</TOWARY>');
                fclose($fp1);
                unset($fp1);
            }
            elseif($count_off == 500 && $this->request->post['action']==0 && str_replace("</ROOT>", '', $data)==$data){
                $count_off=0;
                fwrite($fp1, '</ROOT>');
                fclose($fp1);
                unset($fp1);
            }
        }
        fclose($fp1);
        unset($fp1);
        fclose($fp);
        unset($fp);
    }

    public function webi_xml($file)
    {
        global $webi_depth;
        $webi_depth = 0;
        global $webi_tag_open;
        $webi_tag_open= array();
        global $webi_data_temp;

        $this->write_log("Создаем объект для работы с XML\n");

        $xml_parser = xml_parser_create('UTF-8');
        xml_parser_set_option($xml_parser, XML_OPTION_CASE_FOLDING, true);
        xml_set_element_handler($xml_parser, array($this,"startElement"), array($this,"endElement"));
        xml_set_character_data_handler($xml_parser, array($this,"data"));

        $this->write_log("Объект для работы с XML создан\n");
        $file_arr=file($file);

        foreach($file_arr as $data)
        {
            $data = preg_replace('/[\x00-\x1F\x80-\x9F]/u', '', $data);
            if(!xml_parse($xml_parser,$data)){
                $this->write_log(xml_error_string(xml_get_error_code($xml_parser)));
                die;
            }
        }
        if(xml_error_string(xml_get_error_code($xml_parser))!='No error'){
            $txt = "ERROR! \n";
            $txt .=sprintf("XML error: %s at line %d", xml_error_string(xml_get_error_code($xml_parser)), xml_get_current_line_number($xml_parser));
            $txt .= " \n";
            $txt .= "Время завершения скрипта: ".date('Y-m-d H:i:s')." \n";
            $run_time = (strtotime(date('Y-m-d H:i:s')) - strtotime($GLOBALS['start']));
            $txt .= "Скорость выполнения скрипта: ".((int)($GLOBALS['items']/$run_time))." записей за секунду \n";
            $txt .= 'Время выполнения скрипта: '.((int)($run_time/3600)).":".((int)(($run_time%3600)/60)).":".($run_time%60)." \n\n";
            $this->write_log($txt);
            $txt='';
        }
        $this->write_log("Запускаем xml_parser\n");
        xml_parser_free($xml_parser);
        $this->write_log("xml_parser отработал\n");
        unset($GLOBALS['webi_depth']);
        unset($GLOBALS['webi_tag_open']);
        unset($GLOBALS['webi_data_temp']);
    }

    public function data ($parser, $data='')
    {
        global $webi_depth;
        global $webi_tag_open;
        global $webi_data_temp;
        if(!isset($webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data']))
            $webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'] = '';
        @$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'].=$data;
    }
    public function startElement($parser, $name, $attrs)
    {
        global $webi_depth;
        global $webi_tag_open;
        global $webi_data_temp;

        if($name=='KOLORY')
        {
            $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."parser_option_color` (
                          `parser_op_id` int(11) NOT NULL,
                          `parser_op_name` varchar(255) NOT NULL,
                          `option_value_id` int(11) NOT NULL
                        ) ENGINE=MyISAM DEFAULT CHARSET=utf8");
        }
        if($name=='ROZMIARY')
        {
            $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."parser_option_size` (
                          `parser_op_id` int(11) NOT NULL,
                          `parser_op_name` varchar(255) NOT NULL,
                          `option_value_id` int(11) NOT NULL
                        ) ENGINE=MyISAM DEFAULT CHARSET=utf8");
        }
        if($name=='PRODUCENT')
        {
            $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."parser_option_manufacturer` (
                          `parser_op_id` int(11) NOT NULL,
                          `parser_op_name` varchar(255) NOT NULL,
                          `option_value_id` int(11) NOT NULL
                        ) ENGINE=MyISAM DEFAULT CHARSET=utf8");
        }
        $webi_depth++;
        $webi_tag_open[$webi_depth]=$name;
        $webi_data_temp[$webi_depth][$name]['attrs']=$attrs;
    }
    public function insertColorAttr($attr,$name){
        $name = str_replace('"',"",$name);
        $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."parser_option_color WHERE parser_op_name='".$name."' AND parser_op_id=".$attr['KOLOR_ID']);
        $color_op_count = 0;
        if ($query->num_rows) {
            $color_op_count = $query->row['option_value_id'];
            $query = $this->db->query("SELECT option_value_id as option_value_id  FROM ".DB_PREFIX."option_value WHERE option_value_id=".(int)$color_op_count);
            $option_value_id = 0;
            if ($query->num_rows) {
                $option_value_id = $query->row['option_value_id'];
            }
            if($option_value_id==0){
                $this->db->query("INSERT INTO ".DB_PREFIX."option_value SET option_value_id = '".(int)$color_op_count."', option_id = ".$this->config->get( 'import_settings_color' ));
                $this->db->query("INSERT INTO ".DB_PREFIX."option_value_description SET option_value_id = '".(int)$color_op_count."', option_id = ".$this->config->get( 'import_settings_color' ).", language_id = ".$this->getDefaultLanguageId().", name='".addslashes($name)."'");
            }
        }
        else{
            $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."option_value_description WHERE name='".addslashes($name)."' AND option_id = ".$this->config->get( 'import_settings_size' ));
            if ($query->num_rows) {
                $option_value_id = $query->row['option_value_id'];
            }
            if($option_value_id==0){
                $this->db->query("INSERT INTO ".DB_PREFIX."option_value SET option_id = ".$this->config->get( 'import_settings_color' ));
                $id = $this->db->getLastId();
                $this->db->query("INSERT INTO ".DB_PREFIX."option_value_description SET option_value_id = '".(int)$id."', option_id = ".$this->config->get( 'import_settings_color' ).", language_id = ".$this->getDefaultLanguageId().", name='".addslashes($name)."'");
                $this->db->query("INSERT INTO ".DB_PREFIX."parser_option_color SET option_value_id = '".(int)$id."', parser_op_name='".addslashes($name)."', parser_op_id=".$attr['KOLOR_ID']);
            } else {
                $this->db->query("INSERT INTO ".DB_PREFIX."parser_option_color SET option_value_id = '".(int)$option_value_id."', parser_op_name='".addslashes($name)."', parser_op_id=".$attr['KOLOR_ID']);
            }
        }
    }
    public function insertSizeAttr($attr,$name){
        $name = str_replace('"',"",$name);
        $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."parser_option_size WHERE parser_op_name='".$name."' AND parser_op_id=".$attr['ROZMIAR_ID']);
        $size_op_count = 0;
        if ($query->num_rows) {
            $size_op_count = $query->row['option_value_id'];
            $query = $this->db->query("SELECT option_value_id FROM ".DB_PREFIX."option_value WHERE option_value_id=".(int)$size_op_count);
            $option_value_id = 0;
            if ($query->num_rows) {
                $option_value_id = $query->row['option_value_id'];
            }
//            if($option_value_id==0){
//                if ($query->num_rows) {
//                    $option_value_id = $query->row['option_value_id'];
//                }
            if($option_value_id==0){
                $this->db->query("INSERT INTO ".DB_PREFIX."option_value SET option_value_id = '".(int)$size_op_count."', option_id = ".$this->config->get( 'import_settings_size' ));
                $this->db->query("INSERT INTO ".DB_PREFIX."option_value_description SET option_value_id = '".(int)$size_op_count."', option_id = ".$this->config->get( 'import_settings_size' ).", language_id = ".$this->getDefaultLanguageId().", name='".addslashes($name)."'");
            }
//            }
        }
        else{
            $query = $this->db->query("SELECT option_value_id FROM ".DB_PREFIX."option_value_description WHERE name='".addslashes($name)."' AND option_id = ".$this->config->get( 'import_settings_size' ));
            $option_value_id=0;
            if ($query->num_rows) {
                $option_value_id = $query->row['option_value_id'];
            }
            if($option_value_id==0){
                $this->db->query("INSERT INTO ".DB_PREFIX."option_value SET option_id = ".$this->config->get( 'import_settings_size' ));
                $id = $this->db->getLastId();
                $this->db->query("INSERT INTO ".DB_PREFIX."option_value_description SET option_value_id = '".(int)$id."', option_id = ".$this->config->get( 'import_settings_size' ).", language_id = ".$this->getDefaultLanguageId().", name='".addslashes($name)."'");
                $this->db->query("INSERT INTO ".DB_PREFIX."parser_option_size SET option_value_id = '".(int)$id."', parser_op_name='".addslashes($name)."', parser_op_id=".$attr['ROZMIAR_ID']);
            }
            else
            {
                $this->db->query("INSERT INTO ".DB_PREFIX."parser_option_size SET option_value_id = '".(int)$option_value_id."', parser_op_name='".addslashes($name)."', parser_op_id=".$attr['ROZMIAR_ID']);
            }

        }

    }

    public function insertManufacturer($attr,$name) {
        $name = strtoupper(trim($name));
        $name = str_replace('"',"",$name);
        if(!is_dir(DIR_IMAGE."/data/products/".strtolower(str_replace(' ','-', $name)))){
            $tmp = mkdir(DIR_IMAGE."/data/products/".strtolower(str_replace(' ','-', $name)), 0777, true);
        }
        $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."parser_option_manufacturer WHERE parser_op_name='".$name."' AND parser_op_id=".$attr['PRODUCENT_ID']);
        $manufacturer_op_count = 0;
        if ($query->num_rows) {
            $manufacturer_op_count = $query->row['option_value_id'];
            $query = $this->db->query("SELECT count(manufacturer_id) as manufacturer_id  FROM ".DB_PREFIX."manufacturer WHERE manufacturer_id=".(int)$manufacturer_op_count);
            $manufacturer_count = 0;
            if ($query->num_rows) {
                $manufacturer_count = $query->row['manufacturer_id'];
            }

            if($manufacturer_count==0){
                $this->db->query("INSERT INTO " . DB_PREFIX . "manufacturer SET name = '" . addslashes($name) . "', sort_order = 0");
                $id = $this->db->getLastId();
                $this->db->query("INSERT INTO " . DB_PREFIX . "manufacturer_to_store SET manufacturer_id = '" . (int)$id . "', store_id = 0");
                $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'manufacturer_id=" . (int)$id . "', keyword = '" . $this->db->escape(strtolower(str_replace(' ','-', $name))) . "'");
                $this->db->query("UPDATE `".DB_PREFIX."parser_option_manufacturer` SET option_value_id = ".(int)$id." WHERE parser_op_name='".$name."' AND parser_op_id=".$attr['PRODUCENT_ID']);
            }
        }
        else
        {
            $query = $this->db->query("SELECT manufacturer_id FROM ".DB_PREFIX."manufacturer WHERE name='".addslashes($name)."'");
            $option_value_id = 0;
            if ($query->num_rows) {
                $option_value_id = $query->row['manufacturer_id'];
            }
            if($option_value_id==0){
                $this->db->query("INSERT INTO " . DB_PREFIX . "manufacturer SET name = '" . addslashes($name) . "', sort_order = 0");
                $id = $this->db->getLastId();
                $this->db->query("DELETE FROM " . DB_PREFIX . "manufacturer_to_store WHERE manufacturer_id = '" . (int)$id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "manufacturer_to_store SET manufacturer_id = '" . (int)$id . "', store_id = 0");
                $this->db->query("DELETE FROM " . DB_PREFIX . "url_alias WHERE query = 'manufacturer_id=" . (int)$id . "' AND keyword = '" . $this->db->escape(strtolower(str_replace(' ','-', $name))) . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'manufacturer_id=" . (int)$id . "', keyword = '" . $this->db->escape(strtolower(str_replace(' ','-', $name))) . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "parser_option_manufacturer WHERE option_value_id = " . (int)$id . " AND parser_op_id=".$attr['PRODUCENT_ID']);
                $this->db->query("INSERT INTO ".DB_PREFIX."parser_option_manufacturer SET option_value_id = '".(int)$id."', parser_op_name='".addslashes($name)."', parser_op_id=".$attr['PRODUCENT_ID']);
            }
            else
            {
                $this->db->query("INSERT INTO ".DB_PREFIX."parser_option_manufacturer SET option_value_id = '".(int)$option_value_id."', parser_op_name='".addslashes($name)."', parser_op_id=".$attr['PRODUCENT_ID']);
            }
        }
    }
    public function endElement($parser, $name) {
        global $webi_depth;
        global $webi_tag_open;
        global $webi_data_temp;
        $this->load->model('catalog/product');
        $this->load->model('module/related_options');

        if($webi_tag_open[$webi_depth]=='DATA'){
            $this->write_log("Время создания XML файла: ".@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data']."\n");
        }

        if($webi_tag_open[$webi_depth]=='KOLOR' && count(@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['attrs'])>0){
            $color_name = @$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
            $color_name = strtoupper(trim($color_name));
            $this->insertColorAttr(@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['attrs'],$color_name);
        }

        if($webi_tag_open[$webi_depth]=='ROZMIAR' && count(@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['attrs'])>0){
            $size_name = @$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
            $size_name = strtoupper(trim($size_name));
            $this->insertSizeAttr(@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['attrs'],$size_name);
        }

        if($webi_tag_open[$webi_depth]=='PRODUCENT' && count(@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['attrs'])>0){
            $this->insertManufacturer(@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['attrs'],@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data']);
        }

        if($GLOBALS['isset']>0){
            unset($GLOBALS['webi_data_temp']);
            unset($GLOBALS['webi_tag_open'][$webi_depth]);
            unset($GLOBALS['product_obj']);
            unset($GLOBALS['isset']);
            $webi_depth--;
            return;
        }

        if(@$webi_tag_open[2]=='PRODUKT' && @$webi_tag_open[3]!='WARIANTY'){
            switch (@$webi_tag_open[$webi_depth]) {
                case 'ID':
                    $GLOBALS['product_obj']['product_id']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                    break;
                case 'NAZWA':
                    $GLOBALS['product_obj']['name']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                    break;
                case 'KOD':
                    $GLOBALS['product_obj']['sku']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                    $fp = fopen(DIR_LOGS.'xml_parser_sku.log', 'a+');
                    @fwrite($fp, $webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data']." \n");
                    @fclose($fp);
                    unset($fp);
                    $sql = "SELECT id_in_opencart FROM ".DB_PREFIX."parser_product_id WHERE id_in_xml=".(int)$GLOBALS['product_obj']['product_id'];
                    $query = $this->db->query($sql);
                    $isset = 0;
                    if ($query->num_rows) {
                        $isset = $query->row['id_in_opencart'];
                    }

                    if($isset==0){
                        $sql = "SELECT product_id FROM ".DB_PREFIX."product WHERE sku='".$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data']."'";
                        $query = $this->db->query($sql);
                        if ($query->num_rows) {
                            $isset = $query->row['product_id'];
                        }
                        if($isset!=$GLOBALS['product_obj']['product_id'] && $isset!=0){
                            $this->db->query("UPDATE `".DB_PREFIX."parser_product_id` SET id_in_xml= ".$GLOBALS['product_obj']['product_id']." WHERE id_in_opencart=".$isset);
                        }
                    }
                    $GLOBALS['isset'] = $isset;
                    if($GLOBALS['isset']>0){
                        $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_id SET id = ".$isset);
                    }
                    break;
                case 'EAN':
                    $GLOBALS['product_obj']['ean']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                    break;
                case 'CENA_NETTO':
                    $GLOBALS['product_obj']['price']=(float)(@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'])*2.05;
                    break;
                case 'VAT':
//                $GLOBALS['product_obj']['ean']=(float)(@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'])*1.7;
                    break;
                case 'PRODUCENT':
                    unset($GLOBALS['product_obj']['manufacturer_id']);
                    unset($GLOBALS['product_obj']['manufacturer_name']);
                    $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."parser_option_manufacturer WHERE parser_op_id=".@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data']);
                    $manufacturer_op_count = 0;
                    if ($query->num_rows) {
                        $manufacturer_op_count = $query->row['option_value_id'];
                    }
                    $GLOBALS['product_obj']['manufacturer_id']=$manufacturer_op_count;
                    $query = $this->db->query("SELECT name AS manufacturer FROM ".DB_PREFIX."manufacturer WHERE manufacturer_id=".$manufacturer_op_count);
                    if ($query->num_rows) {
                        $GLOBALS['product_obj']['manufacturer_name'] = $query->row['manufacturer'];
                    }
                    break;
                case 'OPIS':
                    $GLOBALS['product_obj']['description']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                    break;
                case 'IMAGE':
                    if($GLOBALS['image_count']==0){
                        $GLOBALS['product_obj']['image']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                        $GLOBALS['image_count']++;
                    }
                    else
                    {
                        $GLOBALS['product_obj']['additional_image'][$GLOBALS['image_count']]=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                        $GLOBALS['image_count']++;
                    }
                    break;
                default:
                    break;
            }
        }
        else
            if(@$webi_tag_open[2]=='PRODUKT' && @$webi_tag_open[3]=='WARIANTY'){
                if(count($GLOBALS['wariant_count'])==0)
                    $GLOBALS['wariant_count'] = 0;
                switch (@$webi_tag_open[$webi_depth]) {
                    case 'ID':
                        $GLOBALS['wariant_obj'][$GLOBALS['wariant_count']]['product_id']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                        break;
                    case 'KOD':
                        $GLOBALS['wariant_obj'][$GLOBALS['wariant_count']]['sku']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                        break;
                    case 'EAN':
                        $GLOBALS['wariant_obj'][$GLOBALS['wariant_count']]['ean']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                        break;
                    case 'KOLOR':
                        $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."parser_option_color WHERE parser_op_id=".@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data']);
                        $option_value_id = 0;
                        if ($query->num_rows) {
                            $option_value_id = $query->row['option_value_id'];
                        }
                        $GLOBALS['wariant_obj'][$GLOBALS['wariant_count']]['color']=$option_value_id;
                        break;
                    case 'ROZMIAR':
                        $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."parser_option_size WHERE parser_op_id=".@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data']);
                        $option_value_id = 0;
                        if ($query->num_rows) {
                            $option_value_id = $query->row['option_value_id'];
                        }
                        $GLOBALS['wariant_obj'][$GLOBALS['wariant_count']]['size']=$option_value_id;
                        break;
                    case 'WZOR':
                        $GLOBALS['wariant_obj'][$GLOBALS['wariant_count']]['wzor']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                        break;
                    case 'ILOSC':
                        $GLOBALS['wariant_obj'][$GLOBALS['wariant_count']]['quantity']=@$webi_data_temp[$webi_depth][$webi_tag_open[$webi_depth]]['data'];
                        break;
                    default:
                        break;
                }
            }
        if(@$webi_tag_open[$webi_depth]=='WARIANT' && $webi_depth==4)
            $GLOBALS['wariant_count']++;
        if(@$webi_tag_open[$webi_depth]=='PRODUKT'){
//            $start = microtime(true);
//
//            $time = microtime(true) - $start;
//            printf('Скрипт выполнялся %.4F сек.', $time);

            $image_name = end(explode('/',$GLOBALS['product_obj']['image']));
            if($image_name!=''){
                $image_name = "data/products/".strtolower(str_replace(' ','-', $GLOBALS['product_obj']['manufacturer_name']))."/".$image_name;
                $image_folder = DIR_IMAGE."data/products/".strtolower(str_replace(' ','-', $GLOBALS['product_obj']['manufacturer_name']))."/";
                $this->db->query("INSERT INTO `".DB_PREFIX."temp_table_with_imgs` SET url='".$GLOBALS['product_obj']['image']."', local='".$image_folder."'");

            }
            $product_image = array();
            $images = array();
            if(is_array($GLOBALS['product_obj']['additional_image']))
                foreach($GLOBALS['product_obj']['additional_image'] as $val){
                    $name_t = end(explode('/',$val));
                    if($name_t!=''){
                        $name_t = "data/products/".strtolower(str_replace(' ','-', $GLOBALS['product_obj']['manufacturer_name']))."/".$name_t;
                        $images[] = $val;
                        $image_folder = DIR_IMAGE."data/products/".strtolower(str_replace(' ','-', $GLOBALS['product_obj']['manufacturer_name']))."/";
                        $this->db->query("INSERT INTO `".DB_PREFIX."temp_table_with_imgs` SET url='".$val."', local='".$image_folder."'");
                    }
                    $product_image[] = array (
                        'image' => $name_t,
                        'sort_order' => '');
                }

            $arr_color = array();
            $arr_size = array();
            $arr_relatedoptions = array();
            if(is_array($GLOBALS['wariant_obj']))
                foreach($GLOBALS['wariant_obj'] as $variant){
                    if($variant['quantity']==0)
                        continue;
                    if(!isset($arr_color['color'][$variant['color']]))
                        $arr_color['color'][$variant['color']] = 0;
                    if(!isset($arr_size['size'][$variant['size']]))
                        $arr_size['size'][$variant['size']] = 0;
                    $arr_color['color'][$variant['color']] += (int)$variant['quantity'];
                    $arr_size['size'][$variant['size']] += (int)$variant['quantity'];
                    $arr_relatedoptions[] = array(
                        'options' => array (
                            $this->config->get( 'import_settings_color' ) => $variant['color'],
                            $this->config->get( 'import_settings_size' ) => $variant['size']
                        ),
                        'quantity' => $variant['quantity'],
                        'relatedoptions_id' => '',
                        'model' => $variant['sku'],
                        'weight_prefix' => '',
                        'weight' => '0.000',
                        'price' => ''
                    );
                }
            $arr_color_res = array();
            $quantity = 0;
            if(is_array($arr_color['color']))
                foreach($arr_color['color'] as $key=>$val){
                    if($val==0)
                        continue;
                    $arr_color_res[] = array (
                        'option_value_id' => $key,
                        'product_option_value_id' =>  '',
                        'quantity' => $val,
                        'subtract' => '0',
                        'price_prefix' => '+',
                        'price' => '',
                        'points_prefix' => '+',
                        'points' => '',
                        'weight_prefix' => '+',
                        'weight' => '');
                    $quantity+=$val;
                }
            $arr_size_res = array();
            if(is_array($arr_size['size']))
                foreach($arr_size['size'] as $key=>$val){
                    if($val==0)
                        continue;
                    $arr_size_res[] = array (
                        'option_value_id' => $key,
                        'product_option_value_id' =>  '',
                        'quantity' => $val,
                        'subtract' => '0',
                        'price_prefix' => '+',
                        'price' => '',
                        'points_prefix' => '+',
                        'points' => '',
                        'weight_prefix' => '+',
                        'weight' => '');
                }

            $data = array(
                'product_description' => array( $this->getDefaultLanguageId() => array('name' => $GLOBALS['product_obj']['name'],'description'=> $GLOBALS['product_obj']['description'],'meta_description' => '', 'meta_keyword' => '', 'tag' => '',)),
                'seodata' => array ( $this->getDefaultLanguageId() => array ( 'seo_title' => '','seo_h1' => '','seo_h2' => '','seo_h3' => '','alt_image' => '', 'title_image' => '')),
                'model'            => $GLOBALS['product_obj']['name'],
                'sku'              => $GLOBALS['product_obj']['sku'],
                'upc'              => '',
                'ean'              => $GLOBALS['product_obj']['ean'],
                'jan'              => '',
                'isbn'             => '',
                'mpn'              => '',
                'location'         => '',
                'base_price'            => $GLOBALS['product_obj']['price'],
                'extra_charge'     => '',
                'tax_class_id'     => '0',
                'quantity'         => $quantity,
                'minimum'          => 1,
                'subtract'         => 1,
                'stock_status_id'  => $this->config->get( 'config_stock_status_id' ),
                'shipping'         => 1,
                'keyword'          => '',
                'image'            => $image_name,
                'date_available'   => date('Y-m-d',time()),
                'length'           => '',
                'width'            => '',
                'height'           => '',
                'length_class_id' => '1',
                'weight'           => '',
                'weight_class_id'  => 1,
                'status'           => 0,
                'sort_order'       => 1,
                'manufacturer_id'  => $GLOBALS['product_obj']['manufacturer_id'],
                'manufacturer'     => $GLOBALS['product_obj']['manufacturer_name'],
                'category'         => '',
                'filter'           => '',
                'special'          => '',
                'reward'           => '',
                'points'           => '',
                'product_store'    => array(0),
                'download'         => '',
                'related'          => '',
                'option'           => '',
                'product_option' =>
                    array ( 0 => array (
                        'product_option_id' =>  '',
                        'name' => 'Цвет',
                        'option_id' => $this->config->get( 'import_settings_color' ),
                        'type' => 'image',
                        'required' => '1',
                        'product_option_value' => $arr_color_res )
                    ,
                        1 => array (
                            'product_option_id' => '',
                            'name' => 'Размер',
                            'option_id' => $this->config->get( 'import_settings_size' ),
                            'type' => 'select',
                            'required' => '1',
                            'product_option_value' => $arr_size_res
                        )
                    ),

                'related_options_use' =>  '1',
                'related_options_variant' => '0',
                'related_options_discount' => '1',
                'related_options_special' => '1',
                'relatedoptions' => $arr_relatedoptions,
                'points'           => '',
                'product_reward'   => array ( 1 => array ( 'points' => '')),
                'product_layout'   => array ( 0 => array ( 'layout_id' => '')),
                'product_image'    => $product_image
            );
            if($quantity>0){
                $sql = "SELECT id_in_opencart FROM ".DB_PREFIX."parser_product_id WHERE id_in_xml=".(int)$GLOBALS['product_obj']['product_id'];
                $query = $this->db->query($sql);
                $id_in_opencart = 0;
                if ($query->num_rows) {
                    $id_in_opencart = $query->row['id_in_opencart'];
                }
//                $this->write_log($sql);
                $this->write_log(" id_in_opencart=".$id_in_opencart);
                if($id_in_opencart==0){
                    $this->addProduct($data);
                    $sql = "SELECT product_id FROM ".DB_PREFIX."product WHERE sku='".$GLOBALS['product_obj']['sku']."'";
                    $query = $this->db->query($sql);
                    $option_value_id = 0;
                    if ($query->num_rows) {
                        $option_value_id = $query->row['product_id'];
                    }
                    if($option_value_id>0){
                        $this->db->query("INSERT INTO ".DB_PREFIX."parser_product_id SET id_in_xml = ".(int)$GLOBALS['product_obj']['product_id'].", id_in_opencart=".$option_value_id);
                        $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_id SET id = ".$option_value_id);
                    }
                    if (method_exists($this->model_module_related_options,'editRelatedOptions')) {
                        $this->model_module_related_options->editRelatedOptions($option_value_id, $data);
                    }
                }
                else{
                    $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_id SET id = ".$id_in_opencart);
//                    $this->write_log("INSERT INTO ".DB_PREFIX."temp_table_with_id SET id = ".$id_in_opencart);
                }
            }

            unset($GLOBALS['product_obj']);
            unset($GLOBALS['wariant_obj']);
            unset($GLOBALS['wariant_count']);
            unset($GLOBALS['image_count']);
            $GLOBALS['wariant_count'] = 0;
            $GLOBALS['image_count'] = 0;

        }
//        else{
//            $GLOBALS['ch']++;
//        }

        unset($GLOBALS['webi_data_temp']);
        unset($GLOBALS['webi_tag_open'][$webi_depth]);
        $webi_depth--;
    }

    public function SaveImages($urls,$save_to){
        $tmp = array();
        $save_to_t = explode('/data/products/',$save_to);
        $save_to_t = $save_to_t[1];
        foreach ($urls as $url) {
            $url = end(explode('/',$url));
            $tmp[] = "(image='data/products/".$save_to_t.$url."')";
        }
        $urls_c1 = array();
        $urls_c2 = array();
        if(count($tmp)>0){
            $sql = $this->db->query("SELECT image FROM ".DB_PREFIX."product WHERE (".implode(" OR ",$tmp).")");
            $this->write_log("SELECT image FROM ".DB_PREFIX."product WHERE (".implode(" OR ",$tmp).")");
            if ($sql->num_rows) {
                $urls_isset = $sql->rows;
                foreach($urls_isset as $v){
                    $urls_c1[] = end(explode('/',$v['image']));
                }
            }
            $sql = $this->db->query("SELECT image FROM ".DB_PREFIX."product_image WHERE (".implode(" OR ",$tmp).")");
            $this->write_log("SELECT image FROM ".DB_PREFIX."product_image WHERE (".implode(" OR ",$tmp).")");
            if ($sql->num_rows) {
                $urls_isset = $sql->rows;
                foreach($urls_isset as $v){
                    $urls_c2[] = end(explode('/',$v['image']));
                }
            }

            $urls_c = array();
            $urls_c = array_merge($urls_c1, $urls_c2);
            $urls_c = array_unique($urls_c);
            foreach($urls as $key=>$val){
                $f = 0;
                foreach($urls_c as $v){
                    if(str_replace($v,'',$val)!=$val){
                        $f = 1;
                    }
                }
                if($f==0)
                    unset($urls[$key]);
            }

        }
        $conn = array();
        $mh = curl_multi_init();
        foreach ($urls as $i => $url) {
            $g=$save_to.basename($url);
            $this->write_log("Добавление ".$g);
            if(!is_file($g)){
                $conn[$i]=curl_init($url);
                $fp[$i]=fopen ($g, "w");
                curl_setopt ($conn[$i], CURLOPT_FILE, $fp[$i]);
                curl_setopt ($conn[$i], CURLOPT_HEADER ,0);
                curl_setopt($conn[$i],CURLOPT_CONNECTTIMEOUT,60);
                curl_multi_add_handle ($mh,$conn[$i]);
            }
        }
        do {
            $n=curl_multi_exec($mh,$active);
        }

        while ($active);
        foreach ($urls as $i => $url) {
            if(isset($conn[$i])){
                curl_multi_remove_handle($mh,@$conn[$i]);
                curl_close(@$conn[$i]);
            }
            if(isset($fp[$i])){
                fclose ($fp[$i]);
            }
        }
        curl_multi_close($mh);
    }

    public function upload( $filename, $incremental=false ) {
        try {
            $GLOBALS['isset'] = 0;
            $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_id`");
            $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."temp_table_with_id` (
                              `id` int(11) NOT NULL
                            ) ENGINE=MyISAM DEFAULT CHARSET=utf8");

            $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_imgs`");
            $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."temp_table_with_imgs` (
                              `url` varchar(255) NOT NULL DEFAULT '',
                              `local` varchar(255) NOT NULL DEFAULT ''
                            ) ENGINE=MyISAM DEFAULT CHARSET=utf8");

            if($this->request->post['action']==1){
                $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."parser_product_id` (
                              `id_in_xml` int(11) NOT NULL,
                              `id_in_opencart` int(11) NOT NULL
                            ) ENGINE=MyISAM DEFAULT CHARSET=utf8");
                $this->db->query("DELETE FROM ".DB_PREFIX."parser_product_id WHERE id_in_opencart NOT IN (SELECT product_id FROM `".DB_PREFIX."product`)");

                $this->session->data['export_import_nochange'] = 1;
                $tmp_file= DIR_LOGS."xml_folder/";
                // parse uploaded spreadsheet file
                $fp = fopen($filename, "r");

                if(is_dir($tmp_file)!='')
                    $this->remove_u($tmp_file);
                mkdir($tmp_file, 0777, true);

                $this->write_log('#############################'.date('Y-m-d H:i:s').'##################################'." \n\n");
                $this->write_log("Время запуска скрипта: ".date('Y-m-d H:i:s')."\n");

//                $this->ajax_status("Division of the main file into smaller parts");
                $this->ParseFile($fp);
                $_SESSION['ajax_status']=0;

                if ($handle = opendir($tmp_file)) {
                    $res = array();
                    while (false !== ($entry = readdir($handle))) {
                        if ($entry != "." && $entry != "..") {
                            $res[] = $entry;
                        }
                    }
                    closedir($handle);
                }
                $file_id = 0;

                foreach($res as $k => $value){
//                    if($file_id==2)
//                        break;
                    $this->ajax_status("Start processing a temporary file(file = 500 products): ".$file_id." from ".count($res));
                    $this->write_log("\nНачало обработки файла ".$file_id."; время ".date('Y-m-d H:i:s')."\n");
                    $this->webi_xml($tmp_file.$file_id.".xml");
                    $this->write_log("Файл обработан: ".$file_id."; время ".date('Y-m-d H:i:s')."\n");
                    $file_id++;
                }
                $sql = "SELECT name,manufacturer_id FROM ".DB_PREFIX."manufacturer WHERE manufacturer_id NOT IN (SELECT DISTINCT manufacturer_id FROM ".DB_PREFIX."product)";
                $this->write_log($sql);
                $query = $this->db->query($sql);
                if ($query->num_rows) {
                    $manufacturer = $query->rows;
                    $arr = array();
                    foreach($manufacturer as $val){
                        $tmp = DIR_IMAGE."/data/products/".strtolower(str_replace(' ','-', $val['name']));
                        if(is_dir($tmp)!='')
                            $this->remove_u($tmp);
                        $arr[] = $val['manufacturer_id'];

                    }
                    $sql = "DELETE FROM ".DB_PREFIX."manufacturer_description WHERE manufacturer_id IN (".implode(',',$arr).")";
//                    $this->write_log($sql);
                    $this->db->query($sql);
                    $sql = "DELETE FROM ".DB_PREFIX."manufacturer_to_store WHERE manufacturer_id IN (".implode(',',$arr).")";
//                    $this->write_log($sql);
                    $this->db->query($sql);
                    $sql = "DELETE FROM ".DB_PREFIX."parser_option_manufacturer WHERE option_value_id IN (".implode(',',$arr).")";
//                    $this->write_log($sql);
                    $this->db->query($sql);
                    $sql = "DELETE FROM ".DB_PREFIX."manufacturer WHERE manufacturer_id IN (".implode(',',$arr).")";
//                    $this->write_log($sql);
                    $this->db->query($sql);
                }

                $this->write_log("\nНачало загрузки картинок ".date('Y-m-d H:i:s')."\n");
                $urls = array();
                $save_to = '';
                $img_count = 0;
                $sql = "SELECT DISTINCT url,local  FROM ".DB_PREFIX."temp_table_with_imgs ORDER BY local";
                $query = $this->db->query($sql);
                if ($query->num_rows) {
                    $product_id = $query->rows;

                    foreach($product_id as $val){
                        $this->ajax_status("Start downloading images: ".$val['local']);
                        $this->write_log("img folder ".$save_to.": ".count($urls)."\n");
                        if($save_to!='' && $save_to!=$val['local']){
                            $i = 0;
                            $img_count+=count($urls);
                            if(count($urls)>20){
                                while($i<count($urls)){
                                    $this->SaveImages(array_slice($urls, $i, 20),$save_to);
                                    $i+=20;
                                }
                            } else
                            {
                                $this->SaveImages($urls,$save_to);
                            }

                            $urls = array();
                            sleep(2);
                        }
                        $check = explode("/",$val['local']);
                        unset($check[(count($check)-1)]);
                        $folder = implode("/",$check);
                        if(is_dir($folder)){
                            $urls[]=$val['url'];
                            $save_to = $val['local'];
                        }
                    }
                    if(count($urls)){
                        $i = 0;
                        while($i<count($urls)){
                            $this->SaveImages(array_slice($urls, $i, 20),$save_to);
                            $i+=20;
                        }
                    }
                }
                $this->write_log("image load was finished");
                // read the various worksheets and load them to the database


                $this->db->query("CREATE TABLE IF NOT EXISTS tmp LIKE `".DB_PREFIX."temp_table_with_id`");
                $this->db->query("INSERT INTO tmp SELECT DISTINCT * FROM `".DB_PREFIX."temp_table_with_id`");
                $this->db->query("DROP TABLE `".DB_PREFIX."temp_table_with_id`");
                $this->db->query("RENAME TABLE tmp TO `".DB_PREFIX."temp_table_with_id`");
                $this->db->query("UPDATE `".DB_PREFIX."product` SET status = 0 WHERE product_id NOT IN (SELECT DISTINCT id FROM `".DB_PREFIX."temp_table_with_id`)");
                $this->db->query("DROP TABLE `".DB_PREFIX."temp_table_with_id`");
//                $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_imgs`");
                $this->removeNullOptions();
                $this->cache->delete('product');
                $this->ajax_status("Finish");
                $this->write_log("Finish");
                $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_imgs`");
                $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_variant`");
                $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_variants`");
                $this->ajax_redirect();
//                $this->ajax_status("<a href='".$this->url->link('tool/import', 'token=' . $this->session->data['token'], 'SSL')."'>Finish</a>");
                return true;
            }
            else
                if($this->request->post['action']==0){
                    $this->load->model('module/related_options');
                    $this->db->query("DROP TABLE IF EXISTS  `".DB_PREFIX."temp_table_with_variants`");
                    $this->db->query("DROP TABLE IF EXISTS  `".DB_PREFIX."temp_table_with_variant`");
                    $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."temp_table_with_variants` (
                              `id` int(11) NOT NULL,
                              `sku` varchar(255) NOT NULL DEFAULT '',
                              `json` varchar(255) NOT NULL DEFAULT ''
                            ) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
                    $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."temp_table_with_variant` (
                              `id` int(11) NOT NULL
                            ) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
                    $fp = fopen($filename, "r");
                    $tmp_file= DIR_LOGS."xml_folder/";
                    if(is_dir($tmp_file)!='')
                        $this->remove_u($tmp_file);
                    mkdir($tmp_file, 0777, true);
                    $this->write_log('#############################'.date('Y-m-d H:i:s').'##################################'." \n\n");
                    $this->write_log("Время запуска скрипта: ".date('Y-m-d H:i:s')."\n");


                    $this->ParseFile($fp);

                    if ($handle = opendir($tmp_file)) {
                        $res = array();
                        while (false !== ($entry = readdir($handle))) {
                            if ($entry != "." && $entry != "..") {
                                $res[] = $entry;
                            }
                        }
                        closedir($handle);
                    }
                    libxml_use_internal_errors(true);
                    $file_id = 0;
                    foreach($res as $k => $value){
                        if($file_id>=count($res)){
                            break;
                        }
                        $this->write_log("\nНачало обработки файла ".$file_id."\n");
                        $this->ajax_status("Start processing a temporary file(file ~ 500 products): ".($file_id+1)." from ".count($res));
                        $myXMLData = file_get_contents($tmp_file.$file_id.".xml");
                        $xml = simplexml_load_string($myXMLData, null, LIBXML_NOCDATA) or die("Error: Cannot create object");
                        $xml_array=$this->object2array($xml);
                        $xml_array = $xml_array['PRODUKT'];
                        foreach($xml_array as $product){
                            $quantity = $product['ILOSC'];
                            // if($quantity==0)
                            //     continue;
//                            $sku = $product['KOD'];
                            // $sql = "SELECT id_in_opencart FROM ".DB_PREFIX."parser_product_id WHERE id_in_xml=".(int)$product['ID'];
                            // 
                            //                             $query = $this->db->query($sql);
                            //                             $id_in_opencart = 0;
                            //                             if ($query->num_rows) {
                            //                                 $id_in_opencart = $query->row['id_in_opencart'];
                            //                             }
//							$sql = "SELECT product_id FROM ".DB_PREFIX."product WHERE sku='".$product['KOD']."'";
//
//                            $query = $this->db->query($sql);
//                            $id_in_opencart = 0;
//                            if ($query->num_rows) {
//                                $id_in_opencart = $query->row['product_id'];
//                            }
//                            if($id_in_opencart==0)
//                                continue;

                            $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."parser_option_color WHERE parser_op_id=".(int)$product['KOLOR']);
                            $color_in_opencart = 0;
                            if ($query->num_rows) {
                                $color_in_opencart = $query->row['option_value_id'];
                            }

                            $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."parser_option_size WHERE parser_op_id=".(int)$product['ROZMIAR']);
                            $size_in_opencart = 0;
                            if ($query->num_rows) {
                                $size_in_opencart = $query->row['option_value_id'];
                            }


                            $row = array (
                                'options' =>
                                    array (
                                        $this->config->get( 'import_settings_color' ) =>  $color_in_opencart ,
                                        $this->config->get( 'import_settings_size' ) =>  $size_in_opencart
                                    ),
                                'quantity' => $quantity,
                                'relatedoptions_id' => '',
                                'model' =>  $product['KOD'] ,
                                'weight_prefix' =>  '',
                                'weight' =>  '0.00000000',
                                'price' =>  '');

                            $row = json_encode($row);
//                            $data = 0;
//
//                            if (method_exists($this->model_module_related_options,'editRelatedOptions')) {
//                                $this->model_module_related_options->editRelatedOptions($id_in_opencart, $data);
//                            }
                            $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_variants SET id = ".$product['ID'].", sku='".$product['KOD']."', json='".$row."'");
                        }
                        $file_id++;
                    }

                    $sql = "SELECT DISTINCT id  FROM ".DB_PREFIX."temp_table_with_variants";
                    $query = $this->db->query($sql);
                    if ($query->num_rows) {
                        $product_id = $query->rows;
                        $products_count = 0;
                        foreach($product_id as $val){
                            $this->write_log("\nНачало обработки продукта ".$products_count."\n");
                            $this->ajax_status("Start processing a temporary product: ".($products_count+1)." from ".count($product_id));
                            $val = $val['id'];
                            $sql1 = $this->db->query("SELECT sku FROM ".DB_PREFIX."temp_table_with_variants WHERE id=".$val);
                            if ($sql1->num_rows) {
                                $sku_s = $sql1->rows;
                            }
                            $sku_t = array();
                            foreach($sku_s as $val1){
                                $sku_t[] = "'".$val1['sku']."'";
                            }
                            $id_in_opencart = 0;
                            if(count($sku_t)>0){
                                $query = $this->db->query("SELECT product_id  FROM ".DB_PREFIX."product WHERE sku IN (".implode(',',$sku_t).")");
                                if ($query->num_rows) {
                                    $id_in_opencart = $query->row['product_id'];
                                }
                            }
                            $data1 = 0;
                            if (method_exists($this->model_module_related_options,'editRelatedOptions')) {
                                $this->model_module_related_options->editRelatedOptions($id_in_opencart, $data1);
                            }
                            $sql = $this->db->query("SELECT json  FROM ".DB_PREFIX."temp_table_with_variants WHERE id=".$val);
                            if ($sql->num_rows) {
                                $json = $sql->rows;
                                $json_arr = array();
                                $count = 0;
                                foreach($json as $v){
                                    $v = $v['json'];
                                    $tmp = $this->object2array(json_decode($v));
                                    if($tmp['quantity']>0)
                                        $json_arr[]=$tmp;
                                    $count+=(int)$tmp['quantity'];
                                }
                                $data = array(
                                    'related' =>  '',
                                    'related_options_use' =>  '1',
                                    'related_options_variant' =>  0,
                                    'related_options_discount' =>  '1' ,
                                    'related_options_special' =>  '1' ,
                                    'relatedoptions' =>$json_arr
                                );

                                if (method_exists($this->model_module_related_options,'editRelatedOptions')) {
                                    $this->model_module_related_options->editRelatedOptions($id_in_opencart, $data);
                                }
                                $this->db->query("UPDATE " . DB_PREFIX . "product SET quantity = '" .$count. "' WHERE product_id = '" . (int)$id_in_opencart . "'");
                                $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_variant SET id = ".$id_in_opencart);
                            }
                            $products_count++;
                        }
                    }
                    $this->ajax_status("Start removing temporary table");
                    $this->write_log("Start removing temporary table");
                    $this->db->query("DROP TABLE IF EXISTS tmp");
                    $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_id`");
                    $this->db->query("CREATE TABLE tmp ( `id` int(11) NOT NULL) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
                    $this->db->query("INSERT INTO tmp SELECT DISTINCT id FROM `".DB_PREFIX."temp_table_with_variant`");
//                    $this->write_log("INSERT INTO tmp SELECT DISTINCT id FROM `".DB_PREFIX."temp_table_with_variant`");
                    $this->db->query("DROP TABLE `".DB_PREFIX."temp_table_with_variant`");
//                    $this->write_log("DROP TABLE `".DB_PREFIX."temp_table_with_variant`");
                    $this->db->query("RENAME TABLE tmp TO `".DB_PREFIX."temp_table_with_id`");
//                    $this->write_log("RENAME TABLE tmp TO `".DB_PREFIX."temp_table_with_id`");
                    $this->db->query("UPDATE `".DB_PREFIX."product` SET status = 0 WHERE product_id NOT IN (SELECT id FROM `".DB_PREFIX."temp_table_with_id`)");
//                    $this->write_log("UPDATE `".DB_PREFIX."product` SET status = 0 WHERE product_id NOT IN (SELECT id FROM `".DB_PREFIX."temp_table_with_id`)");
                    $this->db->query("DROP TABLE IF EXISTS  `".DB_PREFIX."temp_table_with_variant`");
//                    $this->write_log("DROP TABLE IF EXISTS  `".DB_PREFIX."temp_table_with_variant`");
                    $this->ajax_status("Finish removing temporary table");
                    $this->removeNullOptions();
                    $this->write_log("Finish removing temporary table");
                    $this->cache->delete('product');
                    $this->ajax_status("Parsing completed");
                    $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_id`");
                    $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_imgs`");
                    $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_variant`");
                    $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_variants`");
                    $this->ajax_redirect();
                    return true;
                }
            return true;
        } catch (Exception $e) {
            return false;
        }
    }
    function removeNullOptions(){
        $sql = $this->db->query("SELECT option_value_id FROM ".DB_PREFIX."option_value WHERE option_value_id NOT IN(SELECT DISTINCT option_value_id FROM ".DB_PREFIX."relatedoptions_option)");
        if ($sql->num_rows) {
            $rows= $sql->rows;
            foreach($rows as $v){
                $this->deleteOption($v['option_value_id']);
            }
        }
    }
    public function deleteOption($option_id) {
//        $this->write_log("DELETE FROM " . DB_PREFIX . "option_value WHERE option_value_id = '" . (int)$option_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "option_value WHERE option_value_id = '" . (int)$option_id . "'");
//        $this->write_log("DELETE FROM " . DB_PREFIX . "option_value_description WHERE option_value_id = '" . (int)$option_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "option_value_description WHERE option_value_id = '" . (int)$option_id . "'");
//        $this->write_log("DELETE FROM " . DB_PREFIX . "parser_option_size WHERE option_value_id = '" . (int)$option_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "parser_option_size WHERE option_value_id = '" . (int)$option_id . "'");
//        $this->write_log("DELETE FROM " . DB_PREFIX . "parser_option_color WHERE option_value_id = '" . (int)$option_id . "'");
        $this->db->query("DELETE FROM " . DB_PREFIX . "parser_option_color WHERE option_value_id = '" . (int)$option_id . "'");

        $sql = "SELECT relatedoptions_id  FROM " . DB_PREFIX . "relatedoptions WHERE quantity=0 AND relatedoptions_id IN (SELECT DISTINCT relatedoptions_id FROM " . DB_PREFIX . "relatedoptions_option WHERE option_value_id=".(int)$option_id.")";
//        $this->write_log($sql);
        $sql = $this->db->query($sql);
        if ($sql->num_rows) {
            $rows= $sql->rows;
            foreach($rows as $v){
                $v = $v['relatedoptions_id'];
//                $this->write_log("DELETE FROM " . DB_PREFIX . "relatedoptions_discount WHERE relatedoptions_id IN ( SELECT relatedoptions_id FROM ".DB_PREFIX."relatedoptions WHERE relatedoptions_id = " . (int)$v . ")");
                $this->db->query("DELETE FROM " . DB_PREFIX . "relatedoptions_discount WHERE relatedoptions_id IN ( SELECT relatedoptions_id FROM ".DB_PREFIX."relatedoptions WHERE relatedoptions_id = " . (int)$v . ")");
//                $this->write_log("DELETE FROM " . DB_PREFIX . "relatedoptions_special WHERE relatedoptions_id IN ( SELECT relatedoptions_id FROM ".DB_PREFIX."relatedoptions WHERE relatedoptions_id = " . (int)$v . ")");
                $this->db->query("DELETE FROM " . DB_PREFIX . "relatedoptions_special WHERE relatedoptions_id IN ( SELECT relatedoptions_id FROM ".DB_PREFIX."relatedoptions WHERE relatedoptions_id = " . (int)$v . ")");
//                $this->write_log("DELETE FROM " . DB_PREFIX . "relatedoptions WHERE relatedoptions_id = " . (int)$v);
                $this->db->query("DELETE FROM " . DB_PREFIX . "relatedoptions WHERE relatedoptions_id = " . (int)$v . "");
//                $this->write_log("DELETE FROM " . DB_PREFIX . "relatedoptions_option WHERE relatedoptions_id = " . (int)$v );
                $this->db->query("DELETE FROM " . DB_PREFIX . "relatedoptions_option WHERE relatedoptions_id = " . (int)$v );
//                $this->db->query("DELETE FROM " . DB_PREFIX . "relatedoptions_variant_product WHERE product_id = " . (int)$product_id . "");
            }
        }
    }
    function object2array($object) { return @json_decode(@json_encode($object),1); }

    protected function clearSpreadsheetCache() {
        $files = glob(DIR_CACHE . 'Spreadsheet_Excel_Writer' . '*');

        if ($files) {
            foreach ($files as $file) {
                if (file_exists($file)) {
                    @unlink($file);
                    clearstatcache();
                }
            }
        }
    }

    public function addProduct($data) {


        $this->db->query("INSERT INTO " . DB_PREFIX . "product SET model = '" . $this->db->escape($data['model']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', jan = '" . $this->db->escape($data['jan']) . "', isbn = '" . $this->db->escape($data['isbn']) . "', mpn = '" . $this->db->escape($data['mpn']) . "', location = '" . $this->db->escape($data['location']) . "', quantity = '" . (int)$data['quantity'] . "', minimum = '" . (int)$data['minimum'] . "', subtract = '" . (int)$data['subtract'] . "', stock_status_id = '" . (int)$data['stock_status_id'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int)$data['manufacturer_id'] . "', shipping = '" . (int)$data['shipping'] . "', base_price = '" . (float)$data['base_price'] . "', points = '" . (int)$data['points'] . "', weight = '" . (float)$data['weight'] . "', weight_class_id = '" . (int)$data['weight_class_id'] . "', length = '" . (float)$data['length'] . "', width = '" . (float)$data['width'] . "', height = '" . (float)$data['height'] . "', length_class_id = '" . (int)$data['length_class_id'] . "', status = '" . (int)$data['status'] . "', tax_class_id = '" . $this->db->escape($data['tax_class_id']) . "', sort_order = '" . (int)$data['sort_order'] . "', date_added = NOW()");

        $product_id = $this->db->getLastId();

        if (isset($data['image'])) {
            $this->db->query("UPDATE " . DB_PREFIX . "product SET image = '" . $this->db->escape(html_entity_decode($data['image'], ENT_QUOTES, 'UTF-8')) . "' WHERE product_id = '" . (int)$product_id . "'");
        }

        foreach ($data['product_description'] as $language_id => $value) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "product_description SET product_id = '" . (int)$product_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', description = '" . $this->db->escape($value['description']) . "', tag = '" . $this->db->escape($value['tag']) . "'");
        }

        if (isset($data['product_store'])) {
            foreach ($data['product_store'] as $store_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_store SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "'");
            }
        }

        if (isset($data['product_attribute'])) {
            foreach ($data['product_attribute'] as $product_attribute) {
                if ($product_attribute['attribute_id']) {
                    $this->db->query("DELETE FROM " . DB_PREFIX . "product_attribute WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$product_attribute['attribute_id'] . "'");

                    foreach ($product_attribute['product_attribute_description'] as $language_id => $product_attribute_description) {
                        $this->db->query("INSERT INTO " . DB_PREFIX . "product_attribute SET product_id = '" . (int)$product_id . "', attribute_id = '" . (int)$product_attribute['attribute_id'] . "', language_id = '" . (int)$language_id . "', text = '" .  $this->db->escape($product_attribute_description['text']) . "'");
                    }
                }
            }
        }

        if (isset($data['product_option'])) {
            foreach ($data['product_option'] as $product_option) {
                if ($product_option['type'] == 'select' || $product_option['type'] == 'radio' || $product_option['type'] == 'checkbox' || $product_option['type'] == 'image') {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', required = '" . (int)$product_option['required'] . "'");

                    $product_option_id = $this->db->getLastId();

                    if (isset($product_option['product_option_value']) && count($product_option['product_option_value']) > 0 ) {
                        foreach ($product_option['product_option_value'] as $product_option_value) {
                            $this->db->query("INSERT INTO " . DB_PREFIX . "product_option_value SET product_option_id = '" . (int)$product_option_id . "', product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value_id = '" . (int)$product_option_value['option_value_id'] . "', quantity = '" . (int)$product_option_value['quantity'] . "', subtract = '" . (int)$product_option_value['subtract'] . "', price = '" . (float)$product_option_value['price'] . "', price_prefix = '" . $this->db->escape($product_option_value['price_prefix']) . "', points = '" . (int)$product_option_value['points'] . "', points_prefix = '" . $this->db->escape($product_option_value['points_prefix']) . "', weight = '" . (float)$product_option_value['weight'] . "', weight_prefix = '" . $this->db->escape($product_option_value['weight_prefix']) . "'");
                        }
                    }else{
                        $this->db->query("DELETE FROM " . DB_PREFIX . "product_option WHERE product_option_id = '".$product_option_id."'");
                    }
                } else {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_option SET product_id = '" . (int)$product_id . "', option_id = '" . (int)$product_option['option_id'] . "', option_value = '" . $this->db->escape($product_option['option_value']) . "', required = '" . (int)$product_option['required'] . "'");
                }
            }
        }

        if (isset($data['product_discount'])) {
            foreach ($data['product_discount'] as $product_discount) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_discount SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_discount['customer_group_id'] . "', quantity = '" . (int)$product_discount['quantity'] . "', priority = '" . (int)$product_discount['priority'] . "', price = '" . (float)$product_discount['price'] . "', date_start = '" . $this->db->escape($product_discount['date_start']) . "', date_end = '" . $this->db->escape($product_discount['date_end']) . "'");
            }
        }

        if (isset($data['product_special'])) {
            foreach ($data['product_special'] as $product_special) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_special SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$product_special['customer_group_id'] . "', priority = '" . (int)$product_special['priority'] . "', price = '" . (float)$product_special['price'] . "', date_start = '" . $this->db->escape($product_special['date_start']) . "', date_end = '" . $this->db->escape($product_special['date_end']) . "'");
            }
        }

        if (isset($data['product_image'])) {
            foreach ($data['product_image'] as $product_image) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_image SET product_id = '" . (int)$product_id . "', image = '" . $this->db->escape(html_entity_decode($product_image['image'], ENT_QUOTES, 'UTF-8')) . "', sort_order = '" . (int)$product_image['sort_order'] . "'");
            }
        }

        if (isset($data['product_download'])) {
            foreach ($data['product_download'] as $download_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_download SET product_id = '" . (int)$product_id . "', download_id = '" . (int)$download_id . "'");
            }
        }

        if (isset($data['product_category'])) {
            foreach ($data['product_category'] as $category_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int)$product_id . "', category_id = '" . (int)$category_id . "'");
            }
        }

        if (isset($data['product_filter'])) {
            foreach ($data['product_filter'] as $filter_id) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_filter SET product_id = '" . (int)$product_id . "', filter_id = '" . (int)$filter_id . "'");
            }
        }

        if (isset($data['product_related'])) {
            foreach ($data['product_related'] as $related_id) {
                $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$product_id . "' AND related_id = '" . (int)$related_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$product_id . "', related_id = '" . (int)$related_id . "'");
                $this->db->query("DELETE FROM " . DB_PREFIX . "product_related WHERE product_id = '" . (int)$related_id . "' AND related_id = '" . (int)$product_id . "'");
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_related SET product_id = '" . (int)$related_id . "', related_id = '" . (int)$product_id . "'");
            }
        }

        if (isset($data['product_reward'])) {
            foreach ($data['product_reward'] as $customer_group_id => $product_reward) {
                $this->db->query("INSERT INTO " . DB_PREFIX . "product_reward SET product_id = '" . (int)$product_id . "', customer_group_id = '" . (int)$customer_group_id . "', points = '" . (int)$product_reward['points'] . "'");
            }
        }

        if (isset($data['product_layout'])) {
            foreach ($data['product_layout'] as $store_id => $layout) {
                if ($layout['layout_id']) {
                    $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_layout SET product_id = '" . (int)$product_id . "', store_id = '" . (int)$store_id . "', layout_id = '" . (int)$layout['layout_id'] . "'");
                }
            }
        }

        if ($data['keyword']) {
            $this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'product_id=" . (int)$product_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
        }

        if (isset($data['product_profiles'])) {
            foreach ($data['product_profiles'] as $profile) {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "product_profile` SET `product_id` = " . (int)$product_id . ", customer_group_id = " . (int)$profile['customer_group_id'] . ", `profile_id` = " . (int)$profile['profile_id']);
            }
        }
    }

}
?>