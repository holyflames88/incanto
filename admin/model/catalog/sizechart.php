<?php
class ModelCatalogSizechart extends Model {
	public function addSizechart($data) {
		$this->db->query("INSERT INTO " . DB_PREFIX . "sizechart SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "'");

		$sizechart_id = $this->db->getLastId(); 

		foreach ($data['sizechart_description'] as $language_id => $value) {

			$this->db->query("INSERT INTO " . DB_PREFIX . "sizechart_description SET sizechart_id = '" . (int)$sizechart_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}		

		$this->cache->delete('sizechart');
	}

	public function editSizechart($sizechart_id, $data) {
		$this->db->query("UPDATE " . DB_PREFIX . "sizechart SET sort_order = '" . (int)$data['sort_order'] . "', status = '" . (int)$data['status'] . "' WHERE sizechart_id = '" . (int)$sizechart_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "sizechart_description WHERE sizechart_id = '" . (int)$sizechart_id . "'");

		foreach ($data['sizechart_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "sizechart_description SET sizechart_id = '" . (int)$sizechart_id . "', language_id = '" . (int)$language_id . "', title = '" . $this->db->escape($value['title']) . "', description = '" . $this->db->escape($value['description']) . "'");
		}		

		$this->cache->delete('sizechart');
	}

	public function deleteSizechart($sizechart_id) {
		$this->db->query("DELETE FROM " . DB_PREFIX . "sizechart WHERE sizechart_id = '" . (int)$sizechart_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "sizechart_description WHERE sizechart_id = '" . (int)$sizechart_id . "'");		

		$this->cache->delete('sizechart');
	}	

	public function getSizechart($sizechart_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "sizechart WHERE sizechart_id = '" . (int)$sizechart_id . "'");

		return $query->row;
	}

	public function getSizecharts($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . DB_PREFIX . "sizechart i LEFT JOIN " . DB_PREFIX . "sizechart_description id ON (i.sizechart_id = id.sizechart_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "'";

			$sort_data = array(
				'id.title',
				'i.sort_order'
			);		

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY id.title";	
			}

			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}

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
		} else {
			$sizechart_data = $this->cache->get('sizechart.' . (int)$this->config->get('config_language_id'));

			if (!$sizechart_data) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "sizechart i LEFT JOIN " . DB_PREFIX . "sizechart_description id ON (i.sizechart_id = id.sizechart_id) WHERE id.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY id.title");

				$sizechart_data = $query->rows;

				$this->cache->set('sizechart.' . (int)$this->config->get('config_language_id'), $sizechart_data);
			}	

			return $sizechart_data;			
		}
	}

	public function getSizechartDescriptions($sizechart_id) {
		$sizechart_description_data = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "sizechart_description WHERE sizechart_id = '" . (int)$sizechart_id . "'");

		foreach ($query->rows as $result) {
			$sizechart_description_data[$result['language_id']] = array(
				'title'       => $result['title'],
				'description' => $result['description'],
                'manufacturer' => $result['manufacturer']
			);
		}

		return $sizechart_description_data;
	}

	public function getTotalSizecharts() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "sizechart");

		return $query->row['total'];
	}
        
        public function getAllSizecharts() {
		$sizechart_data = array();

		$query = $this->db->query("SELECT i.sizechart_id as id, id.title,id.language_id FROM " . DB_PREFIX . "sizechart i LEFT JOIN " . DB_PREFIX . "sizechart_description id ON (i.sizechart_id = id.sizechart_id) WHERE i.status = 1 ORDER BY i.sort_order");

		foreach ($query->rows as $result) {
			$sizechart_data[$result['language_id']][] = array(
                                'id'          => $result['id'],
				'title'       => $result['title'],				
			);
		}

		return $sizechart_data;
	}
    public function getManufacturers($data = array()) {
        $sql = "SELECT * FROM " . DB_PREFIX . "manufacturer";

        if (!empty($data['filter_name'])) {
            $sql .= " WHERE name LIKE '" . $this->db->escape($data['filter_name']) . "%'";
        }

        $sort_data = array(
            'name',
            'sort_order'
        );

        if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
            $sql .= " ORDER BY " . $data['sort'];
        } else {
            $sql .= " ORDER BY name";
        }

        if (isset($data['order']) && ($data['order'] == 'DESC')) {
            $sql .= " DESC";
        } else {
            $sql .= " ASC";
        }

        $query = $this->db->query($sql);

        return $query->rows;
    }
}
?>