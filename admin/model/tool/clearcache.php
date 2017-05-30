<?php
class ModelToolClearcache extends Model {
	public function getClearcache() {

		$query = $this->db->query("DELETE FROM `" . DB_PREFIX . "cache`");
		
	}
}
?>