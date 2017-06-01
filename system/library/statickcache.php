<?php 
class Staticstore
{
    public static $data = array();
    public static function set($name, $value)
    {
        self::$data[$name] = $value;
    }
    
    public static function get($name, $default = null)
    {
        return isset(self::$data[$name]) ? self::$data[$name] : $default;
    }
}
?>