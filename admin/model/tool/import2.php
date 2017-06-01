<?php
error_reporting(0);
ignore_user_abort(true);
class ModelToolImport2 extends Model {

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
        $url =  $this->url->link('tool/import2', 'token=' . $this->session->data['token'], 'SSL');
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
        $tmp_file= DIR_LOGS."xml_folder2/";
        while ($data = fgets($fp)) {
            if(str_replace('<root', '', $data)!=$data){
               continue;
            }
            if(str_replace('<updated_at>', '', $data)!=$data){
                continue;
            }
            if(str_replace('</articles>', '', $data)!=$data){
                continue;
            }
            if(str_replace('<?xml version="1.0"', '', $data)!=$data){
                $this->ajax_status("Division of the main file into smaller parts: file ".$count_file);
                $fp1 = fopen($tmp_file.$count_file.'.xml', 'w');
                fwrite($fp1, "");
            }

            if((str_replace("<articles>", '', $data)!=$data)){
                $this->ajax_status("Division of the main file into smaller parts: file ".$count_file);
                $fp1 = fopen($tmp_file.$count_file.'.xml', 'w');
                fwrite($fp1, '<?xml version="1.0" encoding="utf-8" ?>'."\n"." <root> \n".$offer);
                fclose($fp1);
                $fp1 = fopen($tmp_file.$count_file.'.xml', 'a+');
                $count_file++;
                $count_off+=1;
                continue;
            } else
            if((str_replace("<article ", '', $data)!=$data) && $count_off==0 ){
                $this->ajax_status("Division of the main file into smaller parts: file ".$count_file);
                $fp1 = fopen($tmp_file.$count_file.'.xml', 'w');
                fwrite($fp1, '<?xml version="1.0" encoding="utf-8" ?>'."\n"." <root> \n".$offer);
                fclose($fp1);
                $fp1 = fopen($tmp_file.$count_file.'.xml', 'a+');
                $count_file++;
            }

            if(str_replace("</article>", '', $data)!=$data)
                $count_off+=1;
            if($data!='' && @isset($fp1))
                @fwrite($fp1,$data);

            if($count_off == 500 && str_replace("</root>", '', $data)==$data){
                $count_off=0;
                fwrite($fp1, '</root>');
                fclose($fp1);
                unset($fp1);
            }
        }
        fclose($fp1);
        unset($fp1);
        fclose($fp);
        unset($fp);
    }

    public function insertColorAttr($name){

        $this->db->query("INSERT INTO ".DB_PREFIX."option_value SET option_id = ".$this->config->get( 'import_settings_color' ));
        $id = $this->db->getLastId();
        $this->db->query("INSERT INTO ".DB_PREFIX."option_value_description SET option_value_id = '".(int)$id."', option_id = ".$this->config->get( 'import_settings_color' ).", language_id = ".$this->getDefaultLanguageId().", name='".addslashes($name)."'");
        $this->db->query("INSERT INTO ".DB_PREFIX."parser_temp_color SET id_in_oc = '".$id."', name = '".$name."'");
        return $id;

    }
    public function insertSizeAttr($name){
        $name = str_replace('"',"",$name);
        $this->db->query("INSERT INTO ".DB_PREFIX."option_value SET option_id = ".$this->config->get( 'import_settings_size' ));
        $id = $this->db->getLastId();
        $this->db->query("INSERT INTO ".DB_PREFIX."option_value_description SET option_value_id = '".(int)$id."', option_id = ".$this->config->get( 'import_settings_size' ).", language_id = ".$this->getDefaultLanguageId().", name='".addslashes($name)."'");
        $id = $this->db->getLastId();
        return $id;
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
            if ($sql->num_rows) {
                $urls_isset = $sql->rows;
                foreach($urls_isset as $v){
                    $urls_c1[] = end(explode('/',$v['image']));
                }
            }
            $sql = $this->db->query("SELECT image FROM ".DB_PREFIX."product_image WHERE (".implode(" OR ",$tmp).")");
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
            $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."parser_temp_color` (
                      `id_in_oc` int(11) NOT NULL,
                      `name` varchar(255) NOT NULL
                    ) ENGINE=MyISAM DEFAULT CHARSET=utf8");
            $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_variants`");
            $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."temp_table_with_variants` (
                          `id` int(11) NOT NULL,
                          `sku` varchar(255) NOT NULL DEFAULT '',
                          `json` varchar(255) NOT NULL DEFAULT ''
                        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;");
            $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_variant`");
            $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."temp_table_with_variant` (
                          `id` int(11) NOT NULL
                        ) ENGINE=MyISAM DEFAULT CHARSET=utf8;");

            $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_imgs`");
            $this->db->query("CREATE TABLE IF NOT EXISTS `".DB_PREFIX."temp_table_with_imgs` (
                              `url` varchar(255) NOT NULL DEFAULT '',
                              `local` varchar(255) NOT NULL DEFAULT ''
                            ) ENGINE=MyISAM DEFAULT CHARSET=utf8");

                $tmp_file= DIR_LOGS."xml_folder2/";
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
//                    if($file_id==3){
//                        break;
//                    }

                    $this->ajax_status("Start processing a temporary file(file = 500 products): ".$file_id." from ".count($res));
                    $this->write_log("\nНачало обработки файла ".$file_id."; время ".date('Y-m-d H:i:s')."\n");
                    $this->webi_xml2($tmp_file.$file_id.".xml");
                    $this->write_log("Файл обработан: ".$file_id."; время ".date('Y-m-d H:i:s')."\n");
                    $file_id++;
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
//                        $this->ajax_status("Start downloading images: ".$val['local']);
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
                            $urls[]= str_replace("https://","http://",$val['url']);
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
                $this->db->query("CREATE TABLE IF NOT EXISTS tmp LIKE `".DB_PREFIX."temp_table_with_id`");
                $this->db->query("INSERT INTO tmp SELECT DISTINCT * FROM `".DB_PREFIX."temp_table_with_id`");
                $this->db->query("DROP TABLE `".DB_PREFIX."temp_table_with_id`");
                $this->db->query("RENAME TABLE tmp TO `".DB_PREFIX."temp_table_with_id`");
                $this->db->query("UPDATE `".DB_PREFIX."product` SET status = 0 WHERE product_id NOT IN (SELECT DISTINCT id FROM `".DB_PREFIX."temp_table_with_id`)");
//                $this->db->query("UPDATE `".DB_PREFIX."product` SET status = 1 WHERE product_id IN (SELECT DISTINCT id FROM `".DB_PREFIX."temp_table_with_id`)");
                $this->db->query("DROP TABLE `".DB_PREFIX."temp_table_with_id`");
                $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_variants`");
                $this->db->query("DROP TABLE IF EXISTS `".DB_PREFIX."temp_table_with_imgs`");
                $this->removeNullOptions();
                $this->cache->delete('product');
                $this->ajax_status("Finish");
                $this->write_log("Finish");
                $this->ajax_redirect();
//                $this->ajax_status("<a href='".$this->url->link('tool/import', 'token=' . $this->session->data['token'], 'SSL')."'>Finish</a>");

            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    function getColor($name)
    {
        if(is_array($name))
            $name = end($name);
        $color = $this->tmpColor($name);
        if($color>0)
            return $color;
        else
        {
            $color = $this->insertColorAttr($name);
            return $color;
        }

    }

    function tmpColor($name)
    {
        $query = $this->db->query("SELECT id_in_oc  FROM ".DB_PREFIX."parser_temp_color WHERE name='".addslashes($name)."'");
        if ($query->num_rows) {
            $id = $query->row['id_in_oc'];
            if($id>0){
                return $id;
            }
        }
        else
        {
            return -1;
        }

    }

    function getSize($name){
        $name = str_replace('"',"",$name);
        $query = $this->db->query("SELECT option_value_id  FROM ".DB_PREFIX."option_value_description WHERE name='".addslashes($name)."' AND option_id = ".$this->config->get( 'import_settings_size' ));
        if ($query->num_rows) {
            return $query->row['option_value_id'];
        }else
        {
            $size = $this->insertSizeAttr($name);
            return $size;
        }
    }

    function getManufacturer($name){
        $query = $this->db->query("SELECT manufacturer_id AS manufacturer FROM ".DB_PREFIX."manufacturer WHERE name='".$name."'");

        $manufacturer_id = 0;
        if ($query->num_rows) {
            $manufacturer_id = $query->row['manufacturer'];
        }
        $name = str_replace('&AMP;', '', $name);
        if(!is_dir(DIR_IMAGE."/data/products/".strtolower(str_replace(' ','-', $name)))){
            mkdir(DIR_IMAGE."/data/products/".strtolower(str_replace(' ','-', $name)), 0777, true);
        }
        return $manufacturer_id;
    }

    function webi_xml2($file_name){
        $xml = file_get_contents($file_name);
        $articles = new SimpleXMLElement($xml, LIBXML_NOCDATA);
        $brands = $this->config->get( 'import_settings_brands' );
        $brands = str_replace('\n','',$brands);
        $brands = explode(',',$brands);
        $brands = array_map('trim',$brands);
        $brands = array_map('strtoupper',$brands);
        $articles = $this->object2array($articles);
        foreach($articles['article'] as $val){
            $val['brand']['name'] = str_replace('&','&AMP;',$val['brand']['name']);
            if(!in_array(strtoupper($val['brand']['name']),$brands))
                continue;

            $sql = "SELECT product_id FROM ".DB_PREFIX."product WHERE sku='".$val['@attributes']['sku']."'";
            $query = $this->db->query($sql);
            $id = 0;
            if ($query->num_rows) {
                $id = $query->row['product_id'];
            }
            if($id==0){
                $this->makeProduct($val);
            }
            else{
                $this->prepareProduct($id,$val);
            }
        }

        $this->updateProduct();
    }

    function prepareProduct($id,$val){
        if(isset($val['units']['unit'][0])){
            foreach($val['units']['unit'] as $variant){
                if($variant['stock']==0)
                    continue;

                $color = $this->getColor($variant['color']);
                $size = $this->getSize($variant['size']);
                $row = array (
                    'options' =>
                        array (
                            $this->config->get( 'import_settings_color' ) =>  $color ,
                            $this->config->get( 'import_settings_size' ) =>  $size
                        ),
                    'quantity' => $variant['stock'],
                    'relatedoptions_id' => '',
                    'model' => $variant['@attributes']['sku'] ,
                    'weight_prefix' =>  '',
                    'weight' =>  '0.00000000',
                    'price' =>  '');

                $row = json_encode($row);
                $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_variants SET id = ".$id.", sku='".$val['@attributes']['sku']."', json='".$row."'");
                $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_id SET id = ".$id);
            }
        }
        else
        {
            $variant = $val['units']['unit'];
                if($variant['stock']==0)
                    return;

                $color = $this->getColor($variant['color']);
                $size = $this->getSize($variant['size']);
                $row = array (
                    'options' =>
                        array (
                            $this->config->get( 'import_settings_color' ) =>  $color ,
                            $this->config->get( 'import_settings_size' ) =>  $size
                        ),
                    'quantity' => $variant['stock'],
                    'relatedoptions_id' => '',
                    'model' => $variant['@attributes']['sku'] ,
                    'weight_prefix' =>  '',
                    'weight' =>  '0.00000000',
                    'price' =>  '');

                $row = json_encode($row);
                $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_variants SET id = ".$id.", sku='".$val['@attributes']['sku']."', json='".$row."'");
                $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_id SET id = ".$id);
        }
    }

    function updateProduct(){
        $this->load->model('catalog/product');
        $this->load->model('module/related_options');
        $sql = "SELECT DISTINCT id  FROM ".DB_PREFIX."temp_table_with_variants";
        $query = $this->db->query($sql);
        if ($query->num_rows) {
            $product_id = $query->rows;
            $products_count = 0;
            foreach($product_id as $val){
                $this->write_log("\nНачало обработки продукта ".$products_count."\n");
//                $this->ajax_status("Start processing a temporary product: ".($products_count+1)." from ".count($product_id));
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
        return;
    }

    function makeProduct($product_data){
        $this->load->model('catalog/product');
        $this->load->model('module/related_options');
        $arr_color = array();
        $arr_size = array();
        $arr_relatedoptions = array();
        if(isset($product_data['units']['unit'][0]))
            foreach($product_data['units']['unit'] as $variant){
                if($variant['stock']==0)
                    continue;
                $color = $this->getColor($variant['color']);
                $size = $this->getSize($variant['size']);
                if(!isset($arr_color['color'][$color]))
                    $arr_color['color'][$color] = 0;
                if(!isset($arr_size['size'][$size]))
                    $arr_size['size'][$size] = 0;
                $arr_color['color'][$color] += (int)$variant['stock'];
                $arr_size['size'][$size] += (int)$variant['stock'];
                $arr_relatedoptions[] = array(
                    'options' => array (
                        $this->config->get( 'import_settings_color' ) => $color,
                        $this->config->get( 'import_settings_size' ) => $size
                    ),
                    'quantity' => $variant['stock'],
                    'relatedoptions_id' => '',
                    'model' => $variant['@attributes']['sku'],
                    'weight_prefix' => '',
                    'weight' => '0.000',
                    'price' => ''
                );
            }
        else
        {
            $variant = $product_data['units']['unit'];
            if($variant['stock']==0)
                return;
            $color = $this->getColor($variant['color']);
            $size = $this->getSize($variant['size']);
            if(!isset($arr_color['color'][$color]))
                $arr_color['color'][$color] = 0;
            if(!isset($arr_size['size'][$size]))
                $arr_size['size'][$size] = 0;
            $arr_color['color'][$color] += (int)$variant['stock'];
            $arr_size['size'][$size] += (int)$variant['stock'];
            $arr_relatedoptions[] = array(
                'options' => array (
                    $this->config->get( 'import_settings_color' ) => $color,
                    $this->config->get( 'import_settings_size' ) => $size
                ),
                'quantity' => $variant['stock'],
                'relatedoptions_id' => '',
                'model' => $variant['@attributes']['sku'],
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
        if($quantity==0)
            return;
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


        $manufacturer_id = $this->getManufacturer($product_data['brand']['name']);

        if(isset($product_data['images']['image'][0]['image_url'])){
            $image_name = end(explode('/',$product_data['images']['image'][0]['image_url']));
            $img = $product_data['images']['image'][0]['image_url'];
        }
        else{
            $image_name = end(explode('/',$product_data['images']['image']['image_url']));
            $img = $product_data['images']['image']['image_url'];
        }

        if($image_name!=''){
            $name = str_replace('&AMP;', '', $product_data['brand']['name']);
            $image_name = "data/products/".strtolower(str_replace(' ','-', $name))."/".$image_name;
            $image_folder = DIR_IMAGE."data/products/".strtolower(str_replace(' ','-', $name))."/";
            $this->db->query("INSERT INTO `".DB_PREFIX."temp_table_with_imgs` SET url='".$img."', local='".$image_folder."'");

        }

        $product_image = array();
        $images = array();

        if(is_array($product_data['images']['image']))
            foreach($product_data['images']['image'] as $key=>$val){
                if($key==0)
                    continue;
                $name_t = end(explode('/',$val['image_url']));

                if($name_t!=''){
                    $name = str_replace('&AMP;', '', $product_data['brand']['name']);
                    $name_t = "data/products/".strtolower(str_replace(' ','-', $name))."/".$name_t;
                    $images[] = $val['image_url'];
                    $name = str_replace('&AMP;', '', $product_data['brand']['name']);
                    $image_folder = DIR_IMAGE."data/products/".strtolower(str_replace(' ','-', $name))."/";
                    $this->db->query("INSERT INTO `".DB_PREFIX."temp_table_with_imgs` SET url='".$val['image_url']."', local='".$image_folder."'");
                }
                $product_image[] = array (
                    'image' => $name_t,
                    'sort_order' => '');
            }


        $data = array(
            'product_description' => array( $this->getDefaultLanguageId() => array('name' => $product_data['name'],'description'=> $product_data['attributes']['opis'],'meta_description' => '', 'meta_keyword' => '', 'tag' => '',)),
            'seodata' => array ( $this->getDefaultLanguageId() => array ( 'seo_title' => '','seo_h1' => '','seo_h2' => '','seo_h3' => '','alt_image' => '', 'title_image' => '')),
            'model'            => $product_data['name'],
            'sku'              => $product_data['@attributes']['sku'],
            'upc'              => '',
            'ean'              => $product_data['@attributes']['ean'],
            'jan'              => '',
            'isbn'             => '',
            'mpn'              => '',
            'location'         => '',
            'cost'             => $product_data['price'],
            'base_price'       => $product_data['price']*2.05,
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
            'manufacturer_id'  => $manufacturer_id,
            'manufacturer'     => $product_data['brand']['name'],
            'category'         => '',
            'filter'           => '',
            'special'          => '',
            'reward'           => '',
            'points'           => '',
            'product_store'    => array(0),
            'download'         => '',
            'related'          => '',
            'option'           => '',
            'base_currency_code' => 'PLN',
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
        $this->addProduct($data);

        $sql = "SELECT product_id FROM ".DB_PREFIX."product WHERE sku='".$product_data['@attributes']['sku']."'";
        $query = $this->db->query($sql);
        $option_value_id = 0;
        if ($query->num_rows) {
            $option_value_id = $query->row['product_id'];
        }
        if($option_value_id>0){
            $this->db->query("INSERT INTO ".DB_PREFIX."temp_table_with_id SET id = ".$option_value_id);
        }
        if (method_exists($this->model_module_related_options,'editRelatedOptions')) {
            $this->model_module_related_options->editRelatedOptions($option_value_id, $data);
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


        $this->db->query("INSERT INTO " . DB_PREFIX . "product SET base_currency_code = '" . $this->db->escape($data['base_currency_code']) . "', model = '" . $this->db->escape($data['model']) . "', sku = '" . $this->db->escape($data['sku']) . "', upc = '" . $this->db->escape($data['upc']) . "', ean = '" . $this->db->escape($data['ean']) . "', jan = '" . $this->db->escape($data['jan']) . "', isbn = '" . $this->db->escape($data['isbn']) . "', mpn = '" . $this->db->escape($data['mpn']) . "', location = '" . $this->db->escape($data['location']) . "', quantity = '" . (int)$data['quantity'] . "', minimum = '" . (int)$data['minimum'] . "', subtract = '" . (int)$data['subtract'] . "', stock_status_id = '" . (int)$data['stock_status_id'] . "', date_available = '" . $this->db->escape($data['date_available']) . "', manufacturer_id = '" . (int)$data['manufacturer_id'] . "', shipping = '" . (int)$data['shipping'] . "', base_price = '" . (float)$data['base_price'] . "', cost = '" . (float)$data['cost'] . "', points = '" . (int)$data['points'] . "', weight = '" . (float)$data['weight'] . "', weight_class_id = '" . (int)$data['weight_class_id'] . "', length = '" . (float)$data['length'] . "', width = '" . (float)$data['width'] . "', height = '" . (float)$data['height'] . "', length_class_id = '" . (int)$data['length_class_id'] . "', status = '" . (int)$data['status'] . "', tax_class_id = '" . $this->db->escape($data['tax_class_id']) . "', sort_order = '" . (int)$data['sort_order'] . "', date_added = NOW()");

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