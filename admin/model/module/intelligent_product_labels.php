<?php
class ModelModuleIntelligentProductLabels extends Model {

	public function getCategoriesAutocomplete($data) {
		$sql ="SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
			
		if (!empty($data['filter_name'])) {
			$sql .= " AND LCASE(cd.name) LIKE '" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
		}

		$sql .= " ORDER BY name";
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}				

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
		 
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
						
		$query = $this->db->query($sql);
		
		return $query->rows;
	}

	public function getCategoryAutocomplete($category_id) {

		if ( preg_match( "/1\.5\.[5-9].*/", VERSION ) ) {

			$query = $this->db->query("SELECT DISTINCT *, (SELECT GROUP_CONCAT(cd1.name ORDER BY level SEPARATOR ' &gt; ') FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "category_description cd1 ON (cp.path_id = cd1.category_id AND cp.category_id != cp.path_id) WHERE cp.category_id = c.category_id AND cd1.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY cp.category_id) AS path FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd2 ON (c.category_id = cd2.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd2.language_id = '" . (int)$this->config->get('config_language_id') . "'");

		} else {

			$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category INNER JOIN " . DB_PREFIX . "category_description ON ( " . DB_PREFIX . "category.category_id = " . DB_PREFIX . "category_description.category_id ) WHERE " . DB_PREFIX . "category.category_id = '" . (int)$category_id . "'");

		}
		
		return $query->row;
	} 
}
?>