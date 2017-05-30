<?php
class ssb_function extends Controller
{
    private $urls, $defaults, $orderInfo, $s_n = 'superseobox';
    function __construct()
    {
        global $registry;
        parent::__construct($registry);
        require_once DIR_CONFIG . 'ssb_library/ssb_action.php';
        $this->ssb_action     = ssb_action::getInstance();
        $this->orderInfo      = $this->ssb_action->getSetting('porderpurchase');
        $this->urls           = $this->ssb_action->getUrls();
        $this->urls['action'] = str_replace('seobox', 'seobox/setOrderInfo', $this->urls['paladin']);
    }
    static private $Instance = NULL;
    static public function getInstance()
    {
        if (self::$Instance == NULL) {
            $class          = __CLASS__;
            self::$Instance = new $class();
        }
        return self::$Instance;
    }
    public function setFunction($input = array())
    {
        if (isset($input['fnc'])) {
            $this->$input['fnc']($input['fnd']);
            return;
        }
        $respond = false;
        if (isset($input['fns'])) {
            $d  = $input;
            $fn = $d['fns'];
            if (isset($d['ac']) && isset($_SESSION[$fn . '_1_'])) {
                $ad = $d['ad'];
                if ($fn == 'getsString') {
                    list($templ_objs, $template, $specialPatterns, $data, $CPBI, $l_code, $entity_cat, $replacinArr, $glob) = $ad;
                    $this->ssb_action->replacinArr   = $glob[0];
                    $this->ssb_action->testgenerator = $glob[1];
                } else {
                    $setting = $ad;
                }
                return eval($_SESSION[$fn . '_1_']);
            }
            $d['fsd'] = isset($d['fsd']) ? $d['fsd'] : array();
            $respond  = $this->ifa($fn, $d['fsd']);
            if ($respond['error'] == true) {
                return $this->sof($respond);
            }
            if (isset($d['ac'])) {
                $respond = $this->setFunction($d);
            }
            return $respond;
        }
        return $respond;
    }
    private function hof()
    {
        if (isset($_SESSION['install_section'])) {
            $url = $this->urls['modules'];
        } else {
            $url = $this->urls['paladin'];
        }
        unset($_SESSION['install_section']);
        header('Location: ' . str_replace(array(
            '&amp;',
            "\n",
            "\r"
        ), array(
            '&',
            '',
            ''
        ), $url));
        exit();
    }
    private function sof($data = array('error' => false, 'msg' => ''))
    {
        $_SESSION['sof'] = true;
        $order           = file_get_contents(DIR_TEMPLATE . 'module/superseobox/support/order_form.tpl');
        $error           = $data['error'] ? '<p class="alert alert-error">' . $data['msg'] . '</p>' : '';
        $action          = $this->urls['action'];
        $oi              = $this->orderInfo;
        $poi             = 'porderpurchase_order_id';
        $pod             = 'porderpurchase_domain';
        $fo              = isset($oi[$poi]) ? $oi[$poi] : '';
        $fd              = isset($oi[$pod]) ? $oi[$pod] : '';
        $order           = sprintf($order, $error, $action, $fo, $fd);
        die($order);
    }
    private function ifa($fn, $fsd = array())
    {
        $fn      = $fn == 'sod' ? 'setOrderData' : $fn;
        $fn      = $fn == 'dod' ? 'delOrderData' : $fn;
        $respond = array(
            'error' => false,
            'msg' => ''
        );
        if ($fn === false) {
            return array(
                'error' => 'Error (code GF-001)'
            );
        }
        $product_id = 1;
        if (file_exists(DIR_SYSTEM . 'library/decryption.php')) {
            require DIR_SYSTEM . 'library/decryption.php';
            if (isset(${'f_' . $fn})) {
                $_SESSION[$fn . '_1_'] = ${'f_' . $fn};
                return true;
            }
        }
        if ($fn == 'delOrderData') {
            $respond = json_decode(base64_decode('IntcIm1zZ1wiOlwiID4+PiBZb3VyIGRvbWFpbiBpcyBzdWNjZXNzZnVsbHkgdW5yZWdpc3RlcmVkXCIsXCJlcnJvclwiOmZhbHNlLFwic3VjY2Vzc1wiOnRydWV9Ig=='));
        }
        if ($fn == 'setOrderData') {
            $respond = json_decode(base64_decode('IntcIm1zZ1wiOlwiID4+PiBZb3VyIG9yZGVyIGlzIHN1Y2Nlc3NmdWxseSB2ZXJpZmllZFwiLFwiZXJyb3JcIjpmYWxzZSxcInN1Y2Nlc3NcIjp0cnVlfSI='));
        }
        if ($fn == 'delSetting') {
            $respond = json_decode(base64_decode('IntcImJvZHlcIjpcImlmKCFpc3NldCgkdGhpcy0+c19uKSl7JHRoaXMtPnNfbiA9ICdzdXBlcnNlb2JveCc7fSAkdGhpcy0+bG9hZC0+bW9kZWwoJ3NldHRpbmdcXFwvc2V0dGluZycpOyR0aGlzLT5tb2RlbF9zZXR0aW5nX3NldHRpbmctPmRlbGV0ZVNldHRpbmcoJHRoaXMtPnNfbik7IGlmKCEkdGhpcy0+bW9kZWxfc2V0dGluZ19zZXR0aW5nLT5nZXRTZXR0aW5nKCR0aGlzLT5zX24pKXskc3FsID0gXFxcIkRFTEVURSBGUk9NIGBcXFwiIC4gREJfUFJFRklYIC4gXFxcInVybF9hbGlhc2AgV0hFUkUgYGF1dG9fZ2VuYCA9ICdTVEFOX3VybHMnIE9SIGBhdXRvX2dlbmAgPSAnQ1BCSV91cmxzJ1xcXCI7ICR0aGlzLT5kYi0+cXVlcnkoJHNxbCk7ICRkYXRhID0gYXJyYXkoKTsgJGRhdGFbJ2ZucyddID0gJ2RvZCc7ICRvaSA9ICR0aGlzLT5vcmRlckluZm87ICBpZihpc3NldCgkb2lbJ3BvcmRlcnB1cmNoYXNlX29yZGVyX2lkJ10pICYmICRvaVsncG9yZGVycHVyY2hhc2Vfb3JkZXJfaWQnXSAhPSAnJyl7JGRhdGFbJ2ZzZCddID0gYXJyYXkoKTsgJGRhdGFbJ2ZzZCddWydvcmRlcl9pZCddID0gJG9pWydwb3JkZXJwdXJjaGFzZV9vcmRlcl9pZCddO31cXHQkdGhpcy0+c2V0RnVuY3Rpb24oJGRhdGEpO31cIixcImVycm9yXCI6ZmFsc2V9Ig0KDQo='));
        }
        if ($fn == 'setSetting') {
            $respond = json_decode(base64_decode('IntcImJvZHlcIjpcImlmKCFpc3NldCgkdGhpcy0+c19uKSl7JHRoaXMtPnNfbiA9ICdzdXBlcnNlb2JveCc7fSAkdGhpcy0+bG9hZC0+bW9kZWwoJ3NldHRpbmdcXFwvc2V0dGluZycpOyR0aGlzLT5tb2RlbF9zZXR0aW5nX3NldHRpbmctPmVkaXRTZXR0aW5nKCR0aGlzLT5zX24sICRzZXR0aW5nKTtcIixcImVycm9yXCI6ZmFsc2V9Ig=='));
        }
        if ($fn == 'getsString') {
            $respond = json_decode(base64_decode('IntcImJvZHlcIjpcImlmKCRyZXBsYWNpbkFycil7ICR0aGlzLT5zc2JfYWN0aW9uLT5yZXBsYWNpbkFyciA9ICRyZXBsYWNpbkFycjt9XFx0XFx0JHJlc3BvbmQgPSAkdGVtcGxhdGU7XFx0JGRhdGFfY2xlYXIgPSAkZGF0YTsgXFx0XFx0Zm9yZWFjaCgkdGVtcGxfb2Jqc1sncGFyYW1zJ10gYXMgJHZhbCl7XFx0XFx0XFx0aWYoaXNzZXQoJHNwZWNpYWxQYXR0ZXJuc1skdmFsWydwYXJhbSddXSkpe1xcdFxcdFxcdFxcdCRzcGVjUGFyYW0gPSBpc3NldCgkc3BlY2lhbFBhdHRlcm5zWyR2YWxbJ3BhcmFtJ11dWyRsX2NvZGVdKSA/ICRzcGVjaWFsUGF0dGVybnNbJHZhbFsncGFyYW0nXV1bJGxfY29kZV0gOiAkc3BlY2lhbFBhdHRlcm5zWyR2YWxbJ3BhcmFtJ11dO1xcdFxcdFxcdFxcdCRkYXRhX2NsZWFyWyR2YWxbJ3BhcmFtJ11dID0gJGRhdGFbJHZhbFsncGFyYW0nXV0gPSAkc3BlY1BhcmFtO1xcdFxcdFxcdH1cXHRcXHRcXHRpZihjb3VudCgkdGhpcy0+c3NiX2FjdGlvbi0+cmVwbGFjaW5BcnIpIEFORCBpc3NldCgkdGhpcy0+c3NiX2FjdGlvbi0+cmVwbGFjaW5BcnJbJHZhbFsncGFyYW0nXV0pKXtcXHRcXHRcXHRcXHRpZihpc19hcnJheSgkdGhpcy0+c3NiX2FjdGlvbi0+cmVwbGFjaW5BcnJbJHZhbFsncGFyYW0nXV0pKXtcXHRcXHRcXHRcXHRcXHQkZGF0YVskdmFsWydwYXJhbSddXSA9ICRkYXRhX2NsZWFyWyR2YWxbJ3BhcmFtJ11dID0gJHRoaXMtPnNzYl9hY3Rpb24tPnNldFJlcGxhY2luZygkdmFsWydwYXJhbSddLCAkZGF0YV9jbGVhcik7XFx0XFx0XFx0XFx0fVxcdFxcdFxcdH1cXHRcXHRcXHQkc2hhdHRlcl9kYXRhID0gJHRoaXMtPnNzYl9hY3Rpb24tPnNoYXR0ZXJQYXJhbUZvclRhZ3MoJGVudGl0eV9jYXQsICR2YWxbJ3BhcmFtJ10sICRkYXRhX2NsZWFyKTtcXHRcXHRcXHRpZigkc2hhdHRlcl9kYXRhKXtcXHRcXHRcXHRcXHQkZGF0YV9jbGVhclskdmFsWydwYXJhbSddXSA9ICRkYXRhWyR2YWxbJ3BhcmFtJ11dID0gJHNoYXR0ZXJfZGF0YTtcXHRcXHRcXHR9XFx0XFx0XFx0aWYoaXNfYXJyYXkoJHZhbFsnYWRkX3ZhbCddKSBBTkQgY291bnQoJHZhbFsnYWRkX3ZhbCddKSl7XFx0XFx0XFx0XFx0JGRhdGFbJHZhbFsncGFyYW0nXV0gPSAkdGhpcy0+c3NiX2FjdGlvbi0+cHJlcGFyZVBhcmFtV2l0aEFkZFZhbHVlKCR2YWxbJ3BhcmFtJ10sICRkYXRhLCAkZGF0YV9jbGVhciwgJHZhbFsnYWRkX3ZhbCddLCAkQ1BCSSk7XFx0XFx0XFx0fVxcdFxcdFxcdCRyZXNwb25kID0gc3RyX3JlcGxhY2UoJHZhbFsnbWF0Y2hlJ10sIGlzc2V0KCRkYXRhWyR2YWxbJ3BhcmFtJ11dKSA/ICRkYXRhWyR2YWxbJ3BhcmFtJ11dIDogJycsICRyZXNwb25kKTtcXHRcXHR9XFx0XFx0aWYoJHRoaXMtPnNzYl9hY3Rpb24tPnRlc3RnZW5lcmF0b3Ipe1xcdFxcdFxcdCRyZXNwb25kID0gJHRoaXMtPnNzYl9hY3Rpb24tPmNsZWFyUHJldmlld1N0cmluZygkcmVzcG9uZCk7XFx0XFx0fWVsc2V7XFx0XFx0XFx0JHJlc3BvbmQgPSAkdGhpcy0+c3NiX2FjdGlvbi0+Y2xlYXJTdHJpbmcoJHJlc3BvbmQsIHRydWUsICRlbnRpdHlfY2F0IT0nZGVzY3JpcCcpO1xcdFxcdH1cXHRcXHQkcmVzcG9uZCA9ICR0aGlzLT5zc2JfYWN0aW9uLT5zcGluKCRyZXNwb25kKTtcXHRcXHRyZXR1cm4gJHJlc3BvbmQ7XCIsXCJlcnJvclwiOmZhbHNlfSINCg=='));
        }
        $err_txt = 'Please try later to use generator, now your server is overloaded (code GF-';
        if (!$respond) {
            return array(
                'error' => true,
                'msg' => $err_txt . '002)'
            );
        }
        if (!$respond = json_decode($respond, true)) {
            return array(
                'error' => true,
                'msg' => $err_txt . '003)'
            );
        }
        if (isset($respond['error']) AND $respond['error'] !== false) {
            return array(
                'error' => true,
                'msg' => $respond['msg']
            );
        }
        if (isset($respond['body'])) {
            $_SESSION[$fn . '_1_'] = $respond['body'];
        }
        return array(
            'error' => false,
            'msg' => 'success'
        );
    }
}
?>