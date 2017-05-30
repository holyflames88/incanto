<?php
define('PRODUCT_LAYOUT', 'ControllerProductProduct');

class Label {
	private $data = array();
	
	private $config; // opencart config
	private $request; // opencart request
	private $language; // opencart language
	private $currency; // opencart currency
	private $tax; // opencart tax
	private $db; // opencart db queries

	private $labels; // config labels
	private $product_info; // product info

	public function __construct($registry) {
		$this->config = $registry->get('config');
		$this->request = $registry->get('request');
		$this->language = $registry->get('language');
		$this->currency = $registry->get('currency'); // we use it to calculate tax
		$this->tax = $registry->get('tax'); // we use it to calculate tax
		$this->db = $registry->get('db');

		$this->labels = array();
		$this->product_info = array();
	}

	public function __set($property, $value)
	{
		if ( $property == 'labels' ) 
		{
			$this->labels = $value;
		} 
		else if ( $property == 'product_info') 
		{
			$this->product_info = $value;
		} 
		else 
		{
			$this->data[$property] = $value;
		}
	}

	public function __get($property) {
		if (array_key_exists($property, $this->data)) {
		    return $this->data[$property];
		}

		$trace = debug_backtrace();
		trigger_error(
		    'Undefined property via __get(): ' . $property .
		    ' in ' . $trace[0]['file'] .
		    ' on line ' . $trace[0]['line'],
		    E_USER_NOTICE);
		return null;
	}
	
	public function RenderLabels() { // for each product

		$output = '';
		$ayLabels = array();
		$is_product_layout = $this->data['current_layout']==PRODUCT_LAYOUT;
		$is_home = $this->isHome();
		$ayAvailablePositions = array('top_left','top_right','bottom_right','bottom_left');

		foreach( $this->labels as $label ) {

			$add_label = false;
			$text = '';
			$extra_class = '';
			$css = '';
			if ( !isset($label['show_in']) ) { $label['show_in'] = array(); }
			
			$layout_position_ok = true;

			if ( isset($this->data['current_layout_position']) && isset($label['layout_position']) ) {
				if ( $label['layout_position']!='all' ) {
					$layout_position_ok = $this->data['current_layout_position'] == $label['layout_position'];
				}
			}

			$show_on_this_category = true;

			if ( isset($label['limitcategories']) ) {

				if ( !empty($label['limitcategories']) ) {
					
					$show_on_this_category = false;

					$cats = explode(',', $label['limitcategories']);
					$product_in_category = false;
					
					foreach ( $cats as $category_id ) {
						$product_in_category = $this->ProductInCategory( $this->product_info['product_id'], $category_id );
						if ( $product_in_category ) { break; }
					}

					if ( $product_in_category ) { 
						$show_on_this_category = true; 
					}
				}
			}

			if ( $label['status'] && $this->ShowOnthisLayout($label,$is_product_layout,$is_home) && $layout_position_ok && !$this->ExpiredLabel($label) && $show_on_this_category) {

				// we set defaults and collect some product info

				if ( !isset($label['subtitle']) ) { $label['subtitle']=''; }
				if ( !isset($label['subtitle']['status']) ) { $label['subtitle']['status']='0'; }
				if ( !isset($label['priority']) ) { $label['priority']=''; }
				if ( !isset($label['hide_when_lower_priority']) ) { $label['hide_when_lower_priority']='0'; }
				if ( !isset($label['show_in']) ) { $label['show_in'] = array(); }
				if ( !isset($label['custom_css']) ) { $label['custom_css'] = ''; }

				$class_small_big = $is_product_layout ? 'big-db' : 'small-db';
				$doNotResize = !$is_product_layout || empty($label['show_in']);

				$title = $label['title'][$this->config->get('config_language_id')];

				$subtitle = '';
				if ( $label['subtitle']['status'] ) {
					if ( isset($label['subtitle'][$this->config->get('config_language_id')]) ) {
						$subtitle = $label['subtitle'][$this->config->get('config_language_id')];
					}
				}

				// css label style changes

				if ( $label['background'] ) {
					$css = 'background-color:'.$label['background'].';';
				}
				if ( $label['image'] ) {
					if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
						if (defined('HTTPS_IMAGE')) {
							$pic = HTTPS_IMAGE . $label['image'];	
						} else {
							$pic = $this->config->get('config_ssl') . 'image/' . $label['image'];
						}
					} else {
						if (defined('HTTP_IMAGE')) {
							$pic = HTTP_IMAGE . $label['image'];
						} else {
							$pic = $this->config->get('config_url') . 'image/' . $label['image'];
						}
					}
					$css .= 'background-image:url('.str_replace(" ","%20",$pic).');';
					$css .= 'background-repeat:no-repeat;';
					$css .= 'background-position:center center;';
					if (!isset($label['image_autoresize'])) {
						$css .= 'background-size:auto;';
					}
				}
				if ( $label['foreground'] && $label['type']!='stock' ) {
					$css .= 'color:'.$label['foreground'].';';
				}
				if ( empty($label['shadow']) ) {
					$css .= 'box-shadow:none;';
				}
				if ( !empty($label['offsetx']) || $label['offsetx'] == '0' ) {
					$css .= 'left:'.$label['offsetx'].'%;right: none;';
				}
				if ( !empty($label['offsety']) || $label['offsety'] == '0' ) {
					$css .= 'top:'.$label['offsety'].'%;bottom: none;';
				}
				if ( !empty($label['border']) ) {
					$css .= 'border:1px solid '.$label['border'].';';
				}
				if ( !empty($label['opacity']) ) {
					$css .= 'opacity:'.$label['opacity'].';';
				}
				if ( !empty($label['font_size']) ) {
					$css .= $doNotResize ? 'font-size:'.$label['font_size'].';' : 'font-size:'.$this->AddSize($label['font_size']).';';
				}
				if ( !empty($label['bold']) ) {
					$css .= 'font-weight:'.$label['bold'].';';
				}
				if ( !empty($label['width']) ) {
					$css .= $doNotResize ? 'width:'.$label['width'].'px;' : 'width:'.$label['width']*1.25.'px;';
				}
				if ( !empty($label['height']) ) {
					$css .= $doNotResize ? 'height:'.$label['height'].'px;' : 'height:'.$label['height']*1.25.'px;';
				}
				if ( !empty($label['style_round_size']) && $label['style'] == 'round' ) {
					$css .= $doNotResize ? 'line-height:'.$label['style_round_size'].';' : 'line-height:'.$this->AddSize($label['style_round_size']).';';
					$css .= $doNotResize ? 'min-width:'.$label['style_round_size'].';' : 'min-width:'.$this->AddSize($label['style_round_size']).';';
				}
				if ( !empty($label['custom_css']) ) {
					$css .= $label['custom_css'];
				}

				switch ( $label['type'] ) {

					case 'featured':

						$is_featured = false;

						if ( in_array($this->product_info['product_id'],$this->data['products_featured']) ) {
							$is_featured = true;
						}
						
						if ( $is_featured ) { 
							$text = $title;
							$extra_class = '';
							$add_label = true;
						}

						break;


					case 'latest':

						$data_entrada = strtotime($this->product_info['date_added']);
						$days_old = round((time()-$data_entrada) / 60 / 60 / 24); // days /30 months

						if ( $days_old <= $label['period'] ) {
							$text = $title;
							$extra_class = '';
							$add_label = true;
						}

						break;


					case 'special':

						$percentage = 0;
						$pricenotax = (float)$this->product_info['price'];
						$specialnotax = (float)$this->product_info['special'];

						if ( $specialnotax ) {

							$diff = $pricenotax - $specialnotax;
							$difftax = $this->CalculateTax($diff, $this->product_info);

							if ($diff > 0) {
								$percentage = ($diff * 100) / $pricenotax;
							}
						}

						if ( $percentage ) {

							if ( empty($title) ) {
								$title = '-' . number_format((float)$percentage) . '%';
							} else {
								if ( strpos($title,'[%]')!==false ) {
									$title = $this->AddKey('[%]',number_format((float)$percentage) . '%', $title);
								}
								if ( strpos($title,'[amount]')!==false ) {
									$title = $this->AddKey('[amount]', $difftax, $title);
								}
							}

							if ( !empty($subtitle) ) {
								if ( strpos($subtitle,'[%]')!==false ) {
									$subtitle = $this->AddKey('[%]', number_format((float)$percentage) . '%', $subtitle);
								}
								if ( strpos($subtitle,'[amount]')!==false ) {
									$subtitle = $this->AddKey('[amount]', $difftax, $subtitle); 

								}
							}

							$text = $title;
							$extra_class = '';
							$add_label = true;
						}

						break;


					case 'bestseller':

						if ( isset($this->data['bestsellers']) ) {

							$is_bestseller = false;
							
							$bestseller_index = array_search($this->product_info['product_id'],$this->data['bestsellers']);
							
							if ( $bestseller_index !== false ) {
								$bestseller_product_ranking = $bestseller_index + 1;

								if ( $bestseller_product_ranking <= $label['limit_bestseller'] ) {
									$is_bestseller = true;
								}
							}

							if ( $is_bestseller ) {

								if ( empty($title) ) {
									$title = 'Nº' . $bestseller_product_ranking;
								} else {
									if ( stripos($title,'[ranking]')!==false ) {
										$title = str_ireplace('[ranking]', $bestseller_product_ranking , $title);  
									}
								}

								if ( !empty($subtitle) ) {
									if ( stripos($subtitle,'[ranking]')!==false ) {
										$subtitle = str_ireplace('[ranking]', $bestseller_product_ranking , $subtitle);  
									}
								}
								
								$text = $title;
								$extra_class = '';
								$add_label = true;
							}
						}
						
						break;


					case 'stock':

						if ( $this->product_info['quantity'] <= 0 ) {
						    $colorstyle ='outofstock';
							$stock = $this->product_info['stock_status'];

						} elseif ( $this->config->get('config_stock_display') ) {
							$colorstyle ='instock';
							$stock = $this->product_info['quantity'];

						} else {
							$colorstyle ='instock';
							$this->language->load('product/product');
							$stock = $this->language->get('text_instock');
						}

						if ( ($colorstyle=='outofstock' && $label['only_out_of_stock']=="1") || $label['only_out_of_stock']=="0" ) {

							$title_tmp = $label['title'][$this->config->get('config_language_id')];
							
							if ( stripos($title_tmp,'[quantity]')!==false ) {

								if ( is_numeric($stock) ) {
									$title = str_ireplace('[quantity]', $stock , $title_tmp);
								} else {
									$title = $stock;
								}
							} else {
								$title = $stock;
							}

							if ( stripos($subtitle,'[quantity]')!==false ) {
								$subtitle = str_ireplace('[quantity]', $stock , $subtitle);
							}

							if ( stripos($title_tmp,'[notext]')!==false ) {
								$title = '';
							}

							if ( stripos($subtitle,'[notext]')!==false ) {
								$subtitle = '';
							}

							$text = $title;
							$extra_class = ' '.$colorstyle;
							$add_label = true;
						}

						break;


					case 'manual': // products

						$is_manual_product = in_array($this->product_info['product_id'],explode(',', $label['manual_products']));

						if ( $is_manual_product ) { 

							$text = $title;
							$extra_class = '';
							$add_label = true;
						}

						break;


					case 'all_products':

						$text = $title;
						$extra_class = '';
						$add_label = true;

						break;


					case 'category':

						$product_in_category = false;
						$cats = explode(',', $label['manual_categories']);

						foreach ( $cats as $category_id ) {
							$product_in_category = $this->ProductInCategory( $this->product_info['product_id'], $category_id );
							if ( $product_in_category ) { break; }
						}


						if ( $product_in_category ) { 

							$text = $title;
							$extra_class = '';
							$add_label = true;
						}

						break;


					case 'free_shipping':
							
							$free_shipping_status = $this->config->get('free_status');
							$amount_free_shipping = $this->config->get('free_total');
							$pricenotax = (float)$this->product_info['price'];
							$specialnotax = (float)$this->product_info['special'];
							$current_price = !empty($specialnotax) ? $specialnotax : $pricenotax;

							if ( $free_shipping_status && $this->product_info['shipping'] &&  $current_price >= $amount_free_shipping ) {
						
								$text = $title;
								$extra_class = '';
								$add_label = true;
							}

							break;


					case 'regex':

						$product_property = $label['regex']['product_property'];
						$regex_pattern = $label['regex']['value'];
						$property_value = substr($this->product_info[$product_property], 0, 255);

						if ( $regex_pattern ) {

							// if ( !preg_match("/^\/.*\/.?$/", $regex_pattern) ) { $regex_pattern = '/'.$regex_pattern.'/'; }
							if (substr($regex_pattern, 0,1) != "/") { $regex_pattern = '/'.$regex_pattern.'/'; }

							if ( preg_match($regex_pattern, $property_value, $matched) ) {
								
								if ( stripos($title,'[matched]')!==false ) {
									$title = str_ireplace('[matched]', $matched[1] , $title);  
								}

								if ( !empty($subtitle) ) {
									$subtitle = str_ireplace('[matched]', $matched[1] , $subtitle);  
								}

								$text = $title;
								$extra_class = '';
								$add_label = true;
							}
						}

						break;

				}

				if ( !empty($subtitle) ) {

						$subtitlex = is_numeric($label['subtitlex']) ? $label['subtitlex'] : 0;
						$subtitley = is_numeric($label['subtitley']) ? $label['subtitley'] : 0;
						$subtitlesize = $doNotResize ? $label['subtitle_size'] : $this->AddSize($label['subtitle_size'],2,'px');
						$subtitlecolor = !empty($label['subtitle_color']) ? ';color:'.$label['subtitle_color'] : '';

						$subtitle = $this->AddDefaultKeys($subtitle,$this->product_info);

						$subtitle = '<span style="position:absolute;left:'.$subtitlex.'%;top:'.$subtitley.'%;padding:0;margin:0;width:100%;font-size:'.$subtitlesize.$subtitlecolor.';">'.$subtitle.'</span>';
				} 

				// should we add the label?

				if ( $add_label ) {

					$label_str = '';

					$label_str .= $label['style']=='rotated' ? '<div class="cut_rotated">' : ''; // comment if any issue with mouseover on images
					$label_str .= '<span class="'.$label['style'].' '.$label['position'].' '.$class_small_big . $extra_class.'" style="'.$css.'">';
					$label_str .= $this->AddDefaultKeys(html_entity_decode($text),$this->product_info);
					$label_str .= html_entity_decode($subtitle);
					$label_str .= '</span>';
					$label_str .= $label['style']=='rotated' ? '</div>' : ''; // comment if any issue with mouseover on images

					$ayLabels[] = array(
						'span'                    =>(string)$label_str,
						'position'                =>$label['position'],
						'priority'                =>$label['priority'],
						'hide_when_lower_priority'=>$label['hide_when_lower_priority']
					);

					$this->deleteFromArray($ayAvailablePositions,$label['position']); // we delete this label position because this position isn't going to be available anymore
				}
			}
		}

		// we include labels to the output

		foreach ($ayLabels as $lbl) {

			if ( !$this->ThereIsHigherPriority($ayLabels, $lbl) ) {

				$output .= $lbl['span'];

			} else {

				// we try to reallocate this label to another available position

				if ( $lbl['hide_when_lower_priority'] ) { continue; }

				if ( !empty($ayAvailablePositions) ) {
					
					$position_available = array_shift($ayAvailablePositions);
					
					if ( !empty($position_available) ) {
						$output .= str_replace($lbl['position'], $position_available, $lbl['span']) ;
					}
				}
			}
		}

		return $output;
	}


	private function AddSize ($currentSize, $increment = 0.2, $measurement = 'em' ) {
		
		if (stripos($currentSize, $measurement)!==false) {
			$number_size = (float)str_ireplace($measurement, '', $currentSize);
			return ($number_size + $increment) . $measurement;
		} else {
			$number_size = (float)$currentSize; 
			return ($number_size + $increment);
		}
	}

	private function ProductInCategory ($product_id,$category_id = 0) {
		
		if ($category_id) {
			$consulta = "SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id='".$product_id."' AND category_id='".$category_id."'";
		} else {
			$consulta = "SELECT * FROM " . DB_PREFIX . "product_to_category WHERE product_id='".$product_id."'";
		}
		$result = $this->db->query($consulta);
		if ($result) {
			if ($result->num_rows) {
				return true;
			} else {
				return false;
			}		
		} else {
			return false;
		}
	}

	private function ThereIsHigherPriority ($ayLabels, $current_label) {
		
		$return = false;

		foreach ( $ayLabels as $label ) {
			if ( !empty($label['priority'])) {
				if ( $label['position']==$current_label['position'] && $label['priority']>$current_label['priority'] ) {
					$return = true;
					break;
				}
			}
		}

		return $return;
	}

	private function ExpiredLabel ($label) {

		$expired = true;

		if ( isset($label['date-start']) || isset($label['date-end'])) {
			if (($label['date-start'] == '' || $label['date-start'] < date('Y-m-d')) && ($label['date-end'] == '' || $label['date-end'] > date('Y-m-d'))) { 
				$expired = false;
			}
		}

		return $expired;
	}

	private function ShowOnthisLayout ($label, $is_product_layout, $is_home) {

		$layouts2replace = array('ControllerModule','ControllerProduct');
		$current_layout = str_ireplace($layouts2replace,'',$this->data['current_layout']);
		$current_layout = strtolower($current_layout);
		// echo '<pre>'.print_r($label['show_in'],true).'</pre>';
		
		$show_on_this_layout = true;
		
		if (!$is_product_layout) {
			
			if ( (!in_array($current_layout, $label['show_in']) || ($is_home && !in_array('home', $label['show_in']))) && !in_array('all', $label['show_in']) ) {
				
				$show_on_this_layout = false;				
			}
		
		} else {
			
			$show_on_this_layout = $label['show_in_product'] == "1";
		
		}

		return $show_on_this_layout;
	}

	/*
	* This function deletes the given element from a one-dimension array
	* Parameters: $array:    the array (in/out)
	*             $deleteIt: the value which we would like to delete
	*             $useOldKeys: if it is false then the function will re-index the array (from 0, 1, ...)
	*                          if it is true: the function will keep the old keys
	* Returns true, if this value was in the array, otherwise false (in this case the array is same as before)
	*/
	private function deleteFromArray(&$array, $deleteIt, $useOldKeys = FALSE)
	{
	    $tmpArray = array();
	    $found = FALSE;

	    foreach($array as $key => $value) {
	        
	        if($value !== $deleteIt) {

	            if(FALSE === $useOldKeys) {
	                $tmpArray[] = $value;
	            } else {
	                $tmpArray[$key] = $value;
	            }

	        } else {
	            $found = TRUE;
	        }
	    }
	  
	    $array = $tmpArray;
	  
	    return $found;
	}

	private function AddKey ($key, $replace, $text)
	{
		return str_replace($key, $replace, $text);
	}

	private function AddDefaultKeys ($text, $product_info)
	{
		$new_text = '';
		
		$price = $product_info['price'];
		$pricetax = $this->CalculateTax($price, $this->product_info);
		$special = (float)$this->product_info['special'];

		if ( $special ) {
			$pricetax = $this->CalculateTax($special, $this->product_info);
		}

		$keys = array(
			'[price]' => $pricetax,
		);

		foreach ( $keys as $key => $value ) {
			$new_text = str_replace($key, $value, $text);
		}

		return $new_text;
	}

	private function CalculateTax ( $amount_without_tax, $product_info )
	{
		return $this->currency->format($this->tax->calculate($amount_without_tax, $product_info['tax_class_id'], $this->config->get('config_tax')));
	}

	private function isHome () {
		if ( !isset($this->request->get['route']) || $this->request->get['route'] == 'common/home' ) { 
			return true;
		} else {
			return false;
		}
	}
}
?>