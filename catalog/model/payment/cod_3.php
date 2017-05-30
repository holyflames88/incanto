<?php 
class ModelPaymentCod3 extends Model {
  	public function getMethod($address, $total) {
		$this->load->language('payment/cod_3');
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "zone_to_geo_zone WHERE geo_zone_id = '" . (int)$this->config->get('cod_3_geo_zone_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
	
		if ($this->config->get('cod_3_total') > $total) {
			$status = false;
		} elseif (!$this->config->get('cod_3_geo_zone_id')) {
			$status = true;
		} elseif ($query->num_rows) {
			$status = true;
		} else {
			$status = false;
		}
		
		$method_data = array();
	
		if ($status) {  
      		$method_data = array( 
        		'code'       => 'cod_3',
        		'title'      => $this->language->get('text_title'),
				'sort_order' => $this->config->get('cod_3_sort_order')
      		);
    	}
   
    	return $method_data;
  	}
}
?>