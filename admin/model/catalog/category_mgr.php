<?php
class ModelCatalogCategoryMgr extends Model
{
    public function setCategoryState($category_id, $state)
    {
        $this->db->query("UPDATE " . DB_PREFIX . "category SET status = '" . (int) $state . "' WHERE category_id = '" . (int) $category_id . "'");
    }
    
    public function setCategoryName($category_id, $name)
    {
        $this->db->query("UPDATE " . DB_PREFIX . "category_description SET name = '" . $this->db->escape($name) . "' WHERE category_id = '" . (int) $category_id . "' AND language_id = '" . (int) $this->config->get('config_language_id') . "'");
    }
    
    public function setProductState($product_id, $state)
    {
        $this->db->query("UPDATE " . DB_PREFIX . "product SET status = '" . (int) $state . "' WHERE product_id = '" . (int) $product_id . "'");
    }
    
    public function getChildren($category_id)
    {
        $query = $this->db->query("SELECT *, (SELECT COUNT(parent_id) FROM " . DB_PREFIX . "category WHERE parent_id = c.category_id) AS children FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) WHERE c.parent_id = '" . (int) $category_id . "' AND cd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY c.sort_order, cd.name");
        return $query->rows;
    }
    public function getCategory($category_id)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category WHERE category_id = '" . (int) $category_id . "'");
        return $query->row;
    }
    
    public function setOrder($category_id, $sort_order)
    {
        $this->db->query("UPDATE " . DB_PREFIX . "category SET sort_order = '" . (int) $sort_order . "' WHERE category_id = '" . (int) $category_id . "'");
    }
    
    public function resortCategories($parent_id, $id, $start_sort_order)
    {
        $this->db->query("UPDATE " . DB_PREFIX . "category SET sort_order = sort_order + 1, date_modified = NOW() WHERE parent_id = '" . (int) $parent_id . "' AND category_id <> '" . $id . "' AND sort_order >= '" . $start_sort_order . "'");
    }
    
    public function moveCategory($id, $new_parent_id, $sort_order)
    {
        $this->db->query("UPDATE " . DB_PREFIX . "category SET parent_id = '" . $new_parent_id . "', sort_order = '" . $sort_order . "', date_modified = NOW() WHERE category_id = '" . (int) $id . "'");
    }
    
    // Function to repair any erroneous categories that are not in the category path table.
    public function repairCategories($parent_id = 0)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category WHERE parent_id = '" . (int) $parent_id . "'");
        
        foreach ($query->rows as $category) {
            // Delete the path below the current one
            $this->db->query("DELETE FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $category['category_id'] . "'");
            
            // Fix for records with no paths
            $level = 0;
            
            $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "category_path` WHERE category_id = '" . (int) $parent_id . "' ORDER BY level ASC");
            
            foreach ($query->rows as $result) {
                $this->db->query("INSERT INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int) $category['category_id'] . "', `path_id` = '" . (int) $result['path_id'] . "', level = '" . (int) $level . "'");
                
                $level++;
            }
            
            $this->db->query("REPLACE INTO `" . DB_PREFIX . "category_path` SET category_id = '" . (int) $category['category_id'] . "', `path_id` = '" . (int) $category['category_id'] . "', level = '" . (int) $level . "'");
            
            $this->repairCategories($category['category_id']);
        }
    }
    
    public function getTotalProducts($data = array())
    {
        $sql = "SELECT COUNT(DISTINCT p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";
        
        if (!empty($data['filter_category_id'])) {
            $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
        }
        
        $sql .= " WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "'";
        
        if (!empty($data['filter_name'])) {
            $sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
        }
        
        if (!empty($data['filter_model'])) {
            $sql .= " AND LCASE(p.model) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_model'])) . "%'";
        }
        
        if (!empty($data['filter_price'])) {
            $sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
        }
        
        if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
            $sql .= " AND p.quantity = '" . $this->db->escape($data['filter_quantity']) . "'";
        }
        
        if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
            $sql .= " AND p.status = '" . (int) $data['filter_status'] . "'";
        }
        
        if (!empty($data['filter_category_id'])) {
            if ($data['filter_category_id'] == 'null') {
                $sql .= " AND p2c.category_id is null ";
            } else {
                $sql .= " AND p2c.category_id = '" . (int) $data['filter_category_id'] . "'";
            }
        }
        
        $query = $this->db->query($sql);
        
        return $query->row['total'];
    }
    
    public function getProducts($data = array())
    {
        if ($data) {
            $sql = "SELECT p.*, pd.* FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id)";
            
            
            if (!empty($data['filter_category_id'])) {
                $sql .= " LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id)";
            }
            
            $sql .= " WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "'";
            
            if (!empty($data['filter_name'])) {
                $sql .= " AND LCASE(pd.name) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_name'])) . "%'";
            }
            
            if (!empty($data['filter_model'])) {
                $sql .= " AND LCASE(p.model) LIKE '%" . $this->db->escape(utf8_strtolower($data['filter_model'])) . "%'";
            }
            
            if (!empty($data['filter_price'])) {
                $sql .= " AND p.price LIKE '" . $this->db->escape($data['filter_price']) . "%'";
            }
            
            if (isset($data['filter_quantity']) && !is_null($data['filter_quantity'])) {
                $sql .= " AND p.quantity = '" . $this->db->escape($data['filter_quantity']) . "'";
            }
            
            if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
                $sql .= " AND p.status = '" . (int) $data['filter_status'] . "'";
            }
            
            if (!empty($data['filter_category_id'])) {
                
                if ($data['filter_category_id'] == 'null') {
                    $sql .= " AND p2c.category_id is null ";
                } else {
                    $sql .= " AND p2c.category_id = '" . (int) $data['filter_category_id'] . "'";
                }
                
            }
            
            $sql .= " GROUP BY p.product_id";
            
            $sort_data = array(
                'name' => 'pd.name',
                'model' => 'p.model',
                'price' => 'p.price',
                'quantity' => 'p.quantity',
                'status_text' => 'p.status'
            );
            
            if (isset($data['sort']) && array_key_exists($data['sort'], $sort_data)) {
                $sql .= " ORDER BY " . $sort_data[$data['sort']];
            } else {
                $sql .= " ORDER BY pd.name";
            }
            
            if (isset($data['order']) && (strtoupper($data['order']) == 'DESC')) {
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
                
                $sql .= " LIMIT " . (int) $data['start'] . "," . (int) $data['limit'];
            }
            
            $query = $this->db->query($sql);
            
            return $query->rows;
        } else {
            $product_data = $this->cache->get('product.' . (int) $this->config->get('config_language_id'));
            
            if (!$product_data) {
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_description pd ON (p.product_id = pd.product_id) WHERE pd.language_id = '" . (int) $this->config->get('config_language_id') . "' ORDER BY pd.name ASC");
                
                $product_data = $query->rows;
                
                $this->cache->set('product.' . (int) $this->config->get('config_language_id'), $product_data);
            }
            
            return $product_data;
        }
    }
    
    public function isMainCategoryPresent()
    {
        $query = $this->db->query("DESC " . DB_PREFIX . "product_to_category main_category");
        return ($query->num_rows);
    }
    
    public function deleteProductCategory($product_id, $category_id)
    {
        $this->db->query("DELETE FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "' AND category_id = '" . $category_id . "'");
    }
    
    public function createProductCategory($product_id, $category_id)
    {
        $this->db->query("INSERT INTO " . DB_PREFIX . "product_to_category SET product_id = '" . (int) $product_id . "', category_id = '" . $category_id . "'");
    }
    
    public function setMainProductCategory($product_id)
    {
        $query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "product_to_category WHERE product_id = '" . (int) $product_id . "' AND main_category = '1' LIMIT 1");
        if (!$query->num_rows) {
            $this->db->query("UPDATE " . DB_PREFIX . "product_to_category SET main_category = 1 WHERE product_id = '" . (int) $product_id . "' LIMIT 1");
        }
    }
}
?>