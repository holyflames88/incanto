<?php
class transliteration
{
	function __construct(){}
	
	static private $Instance   = NULL;
	private $filterTransliteration;

	static public function getInstance() {
	if(self::$Instance==NULL){
		$class = __CLASS__;
		self::$Instance = new $class;
	}
	return self::$Instance;
	}

	/**
	 * Do transliteration for file names
	 * @param unknown $filename
	 * @param string $source_langcode
	 * @return multitype:|Ambigous <mixed, string>
	 */
	private function file($filename, $lowercase = TRUE, $source_langcode = NULL) {
		if (is_array($filename)) {
			foreach ($filename as $key => $value) {
				$filename[$key] = $this->file($value, $source_langcode);
			}
			return $filename;
		}
		$filename = $this->get($filename, '', $source_langcode);
		// Replace whitespace.
		$filename = str_replace(' ', '_', $filename);
		// Remove remaining unsafe characters.
		$filename = preg_replace('![^0-9A-Za-z_.-]!', '', $filename);
		// Remove multiple consecutive non-alphabetical characters.
		$filename = preg_replace('/(_)_+|(\.)\.+|(-)-+/', '\\1\\2\\3', $filename);
		// Force lowercase to prevent issues on case-insensitive file systems.
		if ($lowercase) {
			$filename = strtolower($filename);
		}
		return $filename;
	}

	/**
	 * Transliterates UTF-8 encoded text to US-ASCII.
	 *
	 * Based on Mediawiki's UtfNormal::quickIsNFCVerify().
	 *
	 * @param $string
	 *   UTF-8 encoded text input.
	 * @param $urlStandart
	 *	 if true do full clear for string
	 * @param $unknown
	 *   Replacement string for characters that do not have a suitable ASCII
	 *   equivalent.
	 * @param $source_langcode
	 *   Optional ISO 639 language code that denotes the language of the input and
	 *   is used to apply language-specific variations. If the source language is
	 *   not known at the time of transliteration, it is recommended to set this
	 *   argument to the site default language to produce consistent results.
	 *   Otherwise the current display language will be used.
	 * @return
	 *   Transliterated text.
	 */
	public function get($string, $national_lang = false, $urlStandart=true, $length=700, $unknown = '', $source_langcode = NULL) {
		$string = html_entity_decode($string, ENT_COMPAT, "UTF-8");
		
		// ASCII is always valid NFC! If we're only ever given plain ASCII, we can
		// avoid the overhead of initializing the decomposition tables by skipping
		// out early.

		//echo $string .' => ';
		if (preg_match('/[\x80-\xff]/', $string) AND !$national_lang) {

		static $tail_bytes;

		if (!isset($tail_bytes)) {
			// Each UTF-8 head byte is followed by a certain number of tail bytes.
			$tail_bytes = array();
			for ($n = 0; $n < 256; $n++) {
				if ($n < 0xc0) {
					$remaining = 0;
				}
				elseif ($n < 0xe0) {
					$remaining = 1;
				}
				elseif ($n < 0xf0) {
					$remaining = 2;
				}
				elseif ($n < 0xf8) {
					$remaining = 3;
				}
				elseif ($n < 0xfc) {
					$remaining = 4;
				}
				elseif ($n < 0xfe) {
					$remaining = 5;
				}
				else {
					$remaining = 0;
				}
				$tail_bytes[chr($n)] = $remaining;
			}
		}

		// Chop the text into pure-ASCII and non-ASCII areas; large ASCII parts can
		// be handled much more quickly. Don't chop up Unicode areas for punctuation,
		// though, that wastes energy.
		preg_match_all('/[\x00-\x7f]+|[\x80-\xff][\x00-\x40\x5b-\x5f\x7b-\xff]*/', $string, $matches);
		$result = '';
		foreach ($matches[0] as $str) {
			if ($str[0] < "\x80") {
				// ASCII chunk: guaranteed to be valid UTF-8 and in normal form C, so
				// skip over it.
				$result .= $str;
				continue;
			}

			// We'll have to examine the chunk byte by byte to ensure that it consists
			// of valid UTF-8 sequences, and to see if any of them might not be
			// normalized.
			//
			// Since PHP is not the fastest language on earth, some of this code is a
			// little ugly with inner loop optimizations.

			$head = '';
			$chunk = strlen($str);
			// Counting down is faster. I'm *so* sorry.
			$len = $chunk + 1;

			for ($i = -1; --$len; ) {
				$c = $str[++$i];
				if ($remaining = $tail_bytes[$c]) {
					// UTF-8 head byte!
					$sequence = $head = $c;
					do {
						// Look for the defined number of tail bytes...
						if (--$len && ($c = $str[++$i]) >= "\x80" && $c < "\xc0") {
							// Legal tail bytes are nice.
							$sequence .= $c;
						}
						else {
							if ($len == 0) {
								// Premature end of string! Drop a replacement character into
								// output to represent the invalid UTF-8 sequence.
								$result .= $unknown;
								break 2;
							}
							else {
								// Illegal tail byte; abandon the sequence.
								$result .= $unknown;
								// Back up and reprocess this byte; it may itself be a legal
								// ASCII or UTF-8 sequence head.
								--$i;
								++$len;
								continue 2;
							}
						}
					} while (--$remaining);

					$n = ord($head);
					if ($n <= 0xdf) {
						$ord = ($n - 192) * 64 + (ord($sequence[1]) - 128);
					}
					elseif ($n <= 0xef) {
						$ord = ($n - 224) * 4096 + (ord($sequence[1]) - 128) * 64 + (ord($sequence[2]) - 128);
					}
					elseif ($n <= 0xf7) {
						$ord = ($n - 240) * 262144 + (ord($sequence[1]) - 128) * 4096 + (ord($sequence[2]) - 128) * 64 + (ord($sequence[3]) - 128);
					}
					elseif ($n <= 0xfb) {
						$ord = ($n - 248) * 16777216 + (ord($sequence[1]) - 128) * 262144 + (ord($sequence[2]) - 128) * 4096 + (ord($sequence[3]) - 128) * 64 + (ord($sequence[4]) - 128);
					}
					elseif ($n <= 0xfd) {
						$ord = ($n - 252) * 1073741824 + (ord($sequence[1]) - 128) * 16777216 + (ord($sequence[2]) - 128) * 262144 + (ord($sequence[3]) - 128) * 4096 + (ord($sequence[4]) - 128) * 64 + (ord($sequence[5]) - 128);
					}
					//echo $ord .' '. $unknown .' '. $source_langcode.'; '; 
					$result .= $this->replace($ord, $unknown, $source_langcode);
					$head = '';
				}
				elseif ($c < "\x80") {
					// ASCII byte.
					$result .= $c;
					$head = '';
				}
				elseif ($c < "\xc0") {
					// Illegal tail bytes.
					if ($head == '') {
						$result .= $unknown;
					}
				}
				else {
					// Miscellaneous freaks.
					$result .= $unknown;
					$head = '';
				}
			}
		}
		
		}else{
			$result = $string;
		}
		//echo $result .' => ';
		if($urlStandart){
			$result = $this->urlClear($result, $length, $national_lang);
		}
		
		return $result;
	}

	private function urlClear($result, $length, $national_lang) {

		$result = htmlspecialchars_decode($result);
	
		if(!$national_lang){
			static $strReplace = array (
				'&' => '-and-'
			); 
			
			foreach($strReplace as $key=>$val){
				$result = str_replace($key, $val, $result);
			}
			$result = preg_replace("/[^a-zA-Z0-9-]/", "-", $result);
			$result = preg_replace('{(-)\1+}','$1', $result); 
			$result = preg_replace('{(_)\1+}','$1', $result);
			$result = strtolower($result);
			$result = trim(mb_substr($result, 0, $length));
			$result = trim($result,'-');
		}else{
			
			$result = preg_replace('/[\x00-\x19\x7f]/u', "", $result);
			//echo $result .'; ';
			static $strReplace = array (
				'&' => '-and-',
				' '	=> '-'
			); 
			foreach($strReplace as $key=>$val){
				$result = str_replace($key, $val, $result);
			}
			$result = preg_replace('/[#%<>{}|\/\\\^`;?:@&=+$,"\'\[\]*!.)(№]/u','', $result);
			$result = preg_replace('{(-)\1+}','$1', $result); 
			$result = preg_replace('{(_)\1+}','$1', $result);
			$result = mb_strtolower($result, 'UTF-8');
			$result = trim(mb_substr($result, 0, $length));
			$result = trim($result,'-');
			
		}
		
		return $result;
	}
	
	/**
	 * Replaces a Unicode character using the transliteration database.
	 *
	 * @param $ord
	 *   An ordinal Unicode character code.
	 * @param $unknown
	 *   Replacement string for characters that do not have a suitable ASCII
	 *   equivalent.
	 * @param $langcode
	 *   Optional ISO 639 language code that denotes the language of the input and
	 *   is used to apply language-specific variations.  Defaults to the current
	 *   display language.
	 * @return
	 *   ASCII replacement character.
	 */
	private function replace($ord, $unknown = '', $langcode = NULL) {
		static $map = array();

		$bank = $ord >> 8;

		if (!isset($map[$bank][$langcode])) {
			$file = dirname(__FILE__) . '/trans_lang/' . sprintf('x%02x', $bank) . '.php';
			if (file_exists($file)) {
				include $file;
				if ($langcode != 'en' && isset($variant[$langcode])) {
					// Merge in language specific mappings.
					$map[$bank][$langcode] = $variant[$langcode] + $base;
				}
				else {
					$map[$bank][$langcode] = $base;
				}
			}
			else {
				$map[$bank][$langcode] = array();
			}
		}

		$ord = $ord & 255;

		return isset($map[$bank][$langcode][$ord]) ? $map[$bank][$langcode][$ord] : $unknown;
	}
}


class filterTransliteration 
{
	function __construct(){}
	
	static private $Instance   = NULL;

	static public function getInstance() {
	if(self::$Instance==NULL){
		$class = __CLASS__;
		self::$Instance = new $class;
	}
	return self::$Instance;
	}

    /**
     * Defined by Zend_Filter_Interface
     *
     * Returns $value translitered to ASCII
     *
     * @param  string $value
     * @return string
     */
    public function filter ($value)
    {
        //translitere specific chars
        $value = $this->_transliterateCzech($value);
        $value = $this->_transliterateRussian($value);
        $value = $this->_transliterateGerman($value);
        $value = $this->_transliterateFrench($value);
        $value = $this->_transliterateHungarian($value);
        $value = $this->_transliteratePolish($value);
        $value = $this->_transliterateDanish($value);
        $value = $this->_transliterateCroatian($value);
		$value = $this->_transliterateGreek($value);
		//$value = $this->_transliterateOther($value);
        
        //split string to single characters
        $characters = mb_split("~(.)~", $value);

        $return = '';
        foreach ($characters as $character) {
            /*  maybe should contain also //IGNORE  */
            $converted = $character;
            
            //if character was converted, strip out wrong marks
            if ($character !== $converted) {
                $return .= preg_replace('~["\'^]+~', '', $converted);
            } else {
                $return .= $converted;
            }
        }
        return $return;
    }

    /**
     * Transliterate Russian chars (Cyrillic)
     *
     * @param string $s
     * @return string
     */
    private function _transliterateRussian ($s)
    {
        $table = array (
            "А" => "A",
            "Б" => "B",
            "В" => "V",
            "Г" => "G",
            "Д" => "D",
            "Є" => "E",
            "Е" => "JE",
            "Ё" => "JO",
            "Ж" => "ZH",
            "З" => "Z",
            "И" => "I",
            "Й" => "J",
            "К" => "K",
            "Л" => "L",
            "М" => "M",
            "Н" => "N",
            "О" => "O",
            "П" => "P",
            "Р" => "R",
            "С" => "S",
            "Т" => "T",
            "У" => "U",
            "Ф" => "F",
            "Х" => "KH",
            "Ц" => "TS",
            "Ч" => "CH",
            "Ш" => "SH",
            "Щ" => "SHCH",
            "Ъ" => "",
            "Ы" => "Y",
            "Ь" => "",
            "Э" => "E",
            "Ю" => "JU",
            "Я" => "JA",
            "Ґ" => "G",
            "Ї" => "I",
            "а" => "a",
            "б" => "b",
            "в" => "v",
            "г" => "g",
            "д" => "d",
            "є" => "e",
            "е" => "je",
            "ё" => "jo",
            "ж" => "zh",
            "з" => "z",
            "и" => "i",
            "й" => "j",
            "к" => "k",
            "л" => "l",
            "м" => "m",
            "н" => "n",
            "о" => "o",
            "п" => "p",
            "р" => "r",
            "с" => "s",
            "т" => "t",
            "у" => "u",
            "ф" => "f",
            "х" => "kh",
            "ц" => "ts",
            "ч" => "ch",
            "ш" => "sh",
            "щ" => "shch",
            "ъ" => "",
            "ы" => "y",
            "ь" => "",
            "э" => "e",
            "ю" => "ju",
            "я" => "ja",
            "ґ" => "g",
            "ї" => "i"
        );
        return strtr($s, $table);
    }
    
        /**
     * Transliterate Czech chars
     *
     * @param string $s
     * @return string
     */
    private function _transliterateCzech ($s)
    {
        $table = array (
            'á' => 'a',
            'č' => 'c',
            'ď' => 'd',
            'é' => 'e',
            'ě' => 'e',
            'í' => 'i',
            'ň' => 'n',
            'ó' => 'o',
            'ř' => 'r',
            'š' => 's',
            'ť' => 't',
            'ú' => 'u',
            'ů' => 'u',
            'ý' => 'y',
            'ž' => 'z',
                'Á' => 'A',
            'Č' => 'C',
            'Ď' => 'D',
            'É' => 'E',
            'Ě' => 'E',
            'Í' => 'I',
            'Ň' => 'N',
            'Ó' => 'O',
            'Ř' => 'R',
            'Š' => 'S',
            'Ť' => 'T',
            'Ú' => 'U',
            'Ů' => 'U',
            'Ý' => 'Y',
            'Ž' => 'Z'
        );
        return strtr($s, $table);
    }
    
        /**
     * Transliterate German chars
     *
     * @param string $s
     * @return string
     */
    private function _transliterateGerman ($s)
    {
        $table = array (
            'ä' => 'ae',
            'ë' => 'e',
            'ï' => 'i',
            'ö' => 'oe',
            'ü' => 'ue',
            'Ä' => 'Ae',
            'Ë' => 'E',
            'Ï' => 'I',
            'Ö' => 'Oe',
            'Ü' => 'Ue',
            'ß' => 'ss'
        );
        return strtr($s, $table);
    }
    
        /**
     * Transliterate French chars
     *
     * @param string $s
     * @return string
     */
    private function _transliterateFrench ($s)
    {        
        $table = array (
            'â' => 'a',
            'ê' => 'e',
            'î' => 'i',
            'ô' => 'o',
            'û' => 'u',
            'Â' => 'A',
            'Ê' => 'E',
            'Î' => 'I',
            'Ô' => 'O',
            'Û' => 'U',
            'œ' => 'oe',
            'æ' => 'ae',
            'Ÿ' => 'Y',
            'ç' => 'c',
            'Ç' => 'C'
        );
        return strtr($s, $table);
    }
    
        /**
     * Transliterate Hungarian chars
     *
     * @param string $s
     * @return string
     */
    private function _transliterateHungarian ($s)
    {        
        $table = array (
            'á' => 'a',
            'é' => 'e',
            'í' => 'i',
            'ó' => 'o',
            'ö' => 'o',
            'ő' => 'o',
            'ú' => 'u',
            'ü' => 'u',
            'ű' => 'u'
        );
        return strtr($s, $table);
    }

        /**
     * Transliterate Greek chars
     *
     * @param string $s
     * @return string
     */
    private function _transliterateGreek ($s)
    {        
        $table = array (
            "Β" => "V", "Γ" => "Y", "Δ" => "Th", "Ε" => "E", "Ζ" => "Z", "Η" => "E",
			"Θ" => "Th", "Ι" => "i", "Κ" => "K", "Λ" => "L", "Μ" => "M", "Ν" => "N",
			"Ξ" => "X", "Ο" => "O", "Π" => "P", "Ρ" => "R", "Σ" => "S", "Τ" => "T",
			"Υ" => "E", "Φ" => "F", "Χ" => "Ch", "Ψ" => "Ps", "Ω" => "O", "α" => "a",
			"β" => "v", "γ" => "y", "δ" => "th", "ε" => "e", "ζ" => "z", "η" => "e",
			"θ" => "th", "ι" => "i", "κ" => "k", "λ" => "l", "μ" => "m", "ν" => "n",
			"ξ" => "x", "ο" => "o", "π" => "p", "ρ" => "r", "σ" => "s", "τ" => "t",
			"υ" => "e", "φ" => "f", "χ" => "ch", "ψ" => "ps", "ω" => "o", "ς" => "s",
			"ς" => "s", "ς" => "s", "ς" => "s", "έ" => "e", "ί" => "i", "ά" => "a",
			"ή" => "e", "ώ" => "o", "ό" => "o"
        );
        return strtr($s, $table);
    }	
	
    /**
     * Transliterate Other chars
     *
     * @param string $s
     * @return string
     */
    private function _transliterateOther ($s)
    {
        $table = array(
        'Š'=>'S', 'š'=>'s', 'Ð'=>'Dj','Ž'=>'Z', 'ž'=>'z', 'À'=>'A', 'Á'=>'A', 'Â'=>'A', 'Ã'=>'A', 'Ä'=>'A',
		'Å'=>'A', 'Æ'=>'A', 'Ç'=>'C', 'È'=>'E', 'É'=>'E', 'Ê'=>'E', 'Ë'=>'E', 'Ì'=>'I', 'Í'=>'I', 'Î'=>'I',
		'Ï'=>'I', 'Ñ'=>'N', 'Ò'=>'O', 'Ó'=>'O', 'Ô'=>'O', 'Õ'=>'O', 'Ö'=>'O', 'Ø'=>'O', 'Ù'=>'U', 'Ú'=>'U',
		'Û'=>'U', 'Ü'=>'U', 'Ý'=>'Y', 'Þ'=>'B', 'ß'=>'Ss','à'=>'a', 'á'=>'a', 'â'=>'a', 'ã'=>'a', 'ä'=>'a',
		'å'=>'a', 'æ'=>'a', 'ç'=>'c', 'è'=>'e', 'é'=>'e', 'ê'=>'e', 'ë'=>'e', 'ì'=>'i', 'í'=>'i', 'î'=>'i',
		'ï'=>'i', 'ð'=>'o', 'ñ'=>'n', 'ò'=>'o', 'ó'=>'o', 'ô'=>'o', 'õ'=>'o', 'ö'=>'o', 'ø'=>'o', 'ù'=>'u',
		'ú'=>'u', 'û'=>'u', 'ý'=>'y', 'ý'=>'y', 'þ'=>'b', 'ÿ'=>'y', 'ƒ'=>'f', 'Ğ'=>'G', 'Ş'=>'S', 'Ü'=>'U',
		'ü'=>'u', 'Ẑ'=>'Z', 'ẑ'=>'z', 'Ǹ'=>'N', 'ǹ'=>'n', 'Ò'=>'O', 'ò'=>'o', 'Ù'=>'U', 'ù'=>'u', 'Ẁ'=>'W',
		'ẁ'=>'w', 'Ỳ'=>'Y', 'ỳ'=>'y', 'č'=>'c', 'Č'=>'C', 'á'=>'a', 'Á'=>'A', 'č'=>'c', 'Č'=>'C', 'ď'=>'d', 
		'Ď'=>'D', 'é'=>'e', 'É'=>'E', 'ě'=>'e', 'Ě'=>'E', 'í'=>'i', 'Í'=>'I', 'ň'=>'n', 'Ň'=>'N', 'ó'=>'o', 
		'Ó'=>'O', 'ř'=>'r', 'Ř'=>'R', 'š'=>'s', 'Š'=>'S', 'ť'=>'t', 'Ť'=>'T', 'ú'=>'u', 'Ú'=>'U', 'ů'=>'u', 
		'Ů'=>'U', 'ý'=>'y', 'Ý'=>'Y', 'ž'=>'z', 'Ž'=>'Z', "ą"=>'a', 'Ą'=>'A', 'ć'=>'c', 'Ć'=>'C', 'ę'=>'e',
		'Ę'=>'E', 'ł'=>'l', 'ń'=>'n', 'ó'=>'o', 'ś'=>'s', 'Ś'=>'S', 'ż'=>'z', 'Ż'=>'Z', 'ź'=>'z', 'Ź'=>'Z',
		'İ'=>'i', 'ş'=>'s', 'ğ'=>'g', 'ı'=>'i' 
        );
        return strtr($s, $table);
    }	
	
    /**
     * Transliterate Polish chars
     *
     * @param string $s
     * @return string
     */
    private function _transliteratePolish ($s)
    {
        $table = array(
        'ą' => 'a', 
        'ę' => 'e', 
        'ó' => 'o', 
        'ć' => 'c', 
        'ł' => 'l', 
        'ń' => 'n', 
        'ś' => 's', 
        'ż' => 'z', 
        'ź' => 'z', 
        'Ó' => 'O', 
        'Ć' => 'C', 
        'Ł' => 'L', 
        'Ś' => 'S', 
        'Ż' => 'Z', 
        'Ź' => 'Z' 
        );
        return strtr($s, $table);
    }

        /**
     * Transliterate Danish chars
     *
     * @param string $s
     * @return string
     */
    private function _transliterateDanish ($s)
    {
        $table = array(
        'æ' => 'ae', 
        'ø' => 'oe', 
        'å' => 'aa', 
        'Æ' => 'Ae', 
        'Ø' => 'Oe', 
        'Å' => 'Aa' 
        );
        return strtr($s, $table);
    }
    
        /**
     * Transliterate Croatian chars
     *
     * @param string $s
     * @return string
     */ 
    private function _transliterateCroatian ($s) 
    { 
        $table = array ( 
            'Č' => 'C', 
            'Ć' => 'C', 
            'Ž' => 'Z', 
            'Š' => 'S', 
            'Đ' => 'D', 
            'č' => 'c', 
            'ć' => 'c', 
            'ž' => 'z', 
            'š' => 's', 
            'đ' => 'd'
        ); 
        return strtr($s, $table); 
    }

}