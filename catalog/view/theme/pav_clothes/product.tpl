<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" );

  $themeConfig = (array)$this->config->get('themecontrol');
  $productConfig = array(
      'product_enablezoom'         => 1,
      'product_zoommode'           => 'basic',
      'product_zoomeasing'         => 1,
      'product_zoomlensshape'      => "round",
      'product_zoomlenssize'       => "150",
      'product_zoomgallery'        => 0,
      'enable_product_customtab'   => 0,
      'product_customtab_name'     => '',
      'product_customtab_content'  => '',
      'product_related_column'     => 0,
	  'category_pzoom'             => 1,
	  'quickview'                  => 0,
	  'show_swap_image'            => 0,
  );
  $languageID = $this->config->get('config_language_id');
  $productConfig = array_merge( $productConfig, $themeConfig ); 
  $categoryPzoom 	    = $productConfig['category_pzoom'];
  $quickview          = $productConfig['quickview'];
  $swapimg            = $productConfig['show_swap_image'];
  $categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0; 
?>
<?php echo $header; ?>
 
<?php //if( $SPAN[0] ): ?>
	<div class="col-lg-<?php //echo $SPAN[0];?> col-md-<?php //echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php //echo $column_left; ?>
	</div> 
<?php //endif; ?> 
<div class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>  
<div id="content"><?php echo $content_top; ?>
  
 
  <div class="product-info">
  <div class="row">
    <?php if ($thumb || $images) { ?>
    <div class="col-lg-5 col-md-6 image-container">
      <?php if ($thumb) { ?>
      <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional">
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
      </div>
      <?php } ?>  
    </div>
    <?php } ?>
    <div class="col-lg-7 col-md-6">
     <h1><?php echo $heading_title; ?></h1>
      <?php if ($review_status) { ?>
      <div class="review">
        <div><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
      </div>
      <?php } ?>


      <?php if ($price) { ?>
        <div class="price"><?php //echo $text_price; ?>
          <?php if (!$special) { ?>
          <?php echo $price; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
          <?php } ?>
          <br />
          <?php if ($tax) { ?>
          <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
          <?php } ?>
          <?php if ($points) { ?>
          <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
          <?php } ?>
          <?php if ($discounts) { ?>
          <div class="discount">
            <?php foreach ($discounts as $discount) { ?>
            <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
            <?php } ?>
          </div>
		  			<?php 
			$adres = "http://".$_SERVER['HTTP_HOST']."".$_SERVER['REQUEST_URI']."";
			?>
			<br>
          <?php } ?>
        </div>
      <?php } ?>
	  
	        <div class="description">
		
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
        <span><?php //echo $text_model; ?></span> <?php //echo $model; ?><br />
        <?php if ($reward) { ?>
        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
        <?php } ?>
		<span><?php echo $text_stock; ?></span> <?php echo $stock; ?>
		
<?php if ($attribute_groups) { ?>
<?php foreach ($attribute_groups as $attribute_group) { ?>
<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
<br /><span><?php echo $attribute['name']; ?>: </span><?php echo $attribute['text']; ?>        
<?php } ?>
<?php } ?>
<?php } ?>
<div class="delivery_time"><b><?php echo $text_manufacturer; ?></b> <?php echo $polska; ?></div>			
<div class="delivery_time"><b><?php echo $delivery_time_header; ?>:</b> <?php echo $delivery_time; ?></div>			
<div class="category-info product"><?php echo $description; ?></div>		
<div class="share42init" data-title="<?php echo $heading_title; ?>" data-image="<?php echo $popup; ?>"></div>
<script type="text/javascript" src="catalog/view/javascript/share42/horizontal/product/share42.js"></script>


</div>

	  

	  <?php if ($options) { ?>
          <div class="options">
            
            <?php foreach ($options as $option) { ?>
            <?php if ($option['type'] == 'select') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <select class="form-control" name="option[<?php echo $option['product_option_id']; ?>]">
                <option value=""><?php echo $text_select; ?></option>
                <?php foreach ($option['option_value'] as $option_value) { ?>
                <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
                </option>
                <?php } ?>
              </select>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'radio') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <?php foreach ($option['option_value'] as $option_value) { ?>
              <div class="radio"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
              <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
              </label>
              </div>
              <?php } ?>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'checkbox') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <?php foreach ($option['option_value'] as $option_value) { ?>
               <div class="checkbox"><input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
              <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                <?php if ($option_value['price']) { ?>
                (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                <?php } ?>
              </label>
              </div>
              <?php } ?>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'image') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <table class="option-image">
                <?php foreach ($option['option_value'] as $option_value) { ?>
                <tr>
                  <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
                  <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
                  <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                      <?php if ($option_value['price']) { ?>
                      (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
                      <?php } ?>
                    </label></td>
                </tr>
                <?php } ?>
              </table>
            </div>			
            <?php } ?>
			
			
			
            <?php if ($option['type'] == 'text') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="form-control" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'textarea') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <textarea class="form-control" name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'file') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="btn btn-primary button" type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>">
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'date') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="form-control date" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>"/>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'datetime') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="form-control datetime" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>"/>
            </div>
            <?php } ?>
            <?php if ($option['type'] == 'time') { ?>
            <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
              <?php if ($option['required']) { ?>
              <span class="required">*</span>
              <?php } ?>
              <label><?php echo $option['name']; ?>:</label>
              <input class="form-control time" type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>"/>
            </div>
            <?php } ?>
            <?php } ?>
          </div>
          <?php } ?>
	  
			<div>
        <?php if($sizechart != ''){ ?>            
                <a href="#sizechart_content" " class="inline-colorbox"><span class="check-size"><?php echo $text_sizechart; ?></span></a>
                <?php } ?>  
			<a href="https://siteheart.com/webconsultation/664226?" target="siteheart_sitewindow_664226" onclick="o=window.open;o('https://siteheart.com/webconsultation/664226?', 'siteheart_sitewindow_664226', 'width=550,height=400,top=30,left=30,resizable=yes'); return false;"><span class="online-chat"><?php echo $text_online_chat; ?></span></a>
							
			</div>
			
				
        <div class="product-extra">
          <div class="quantity-adder">
		  <?php if ($stock == ('Временно нет в наличии')|| $stock == ('Распродано') || $stock == ('Тимчасово немає в наявності') || $stock == ('Немає в наявності') || $stock == ('Нет в наличии') || ($quantity == 0 && ($stock == ('В наличии') || $stock == ('В наявності')))){ ?>
		  <?php } else { ?>
			<span class="text-qty"><?php echo $text_qty; ?></span>
			<input class="form-control" type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
			<?php } ?>
          </div>
          <?php if ($minimum > 1) { ?>
          <div class="minimum"><?php echo $text_minimum; ?></div>
          <?php } ?>
          <div class="group-item">
			<input type="hidden" name="product_id" value="<?php echo $product_id; ?>"/>
            &nbsp;
            <span class="cart">
			<?php if ($quantity == 0 || ($quantity < 0 && !$this->config->get('config_stock_display')) ) { ?>
				<?php if ($stock == ('Временно нет в наличии') || $stock == ('Тимчасово немає в наявності') || $stock == ('Немає в наявності') || $stock == ('Нет в наличии') || $stock == ('Распродано') || $stock == ('В наличии') || $stock == ('В наявності')){ ?>
				<?php }else{ ?>
					<i class="fa fa-shopping-cart"></i>
				<?php } ?>
				<input type="button" value="<?php if($stock == ('В наличии') || $stock == ('В наявності')){ echo 'Нет в наличии';}else{ echo $stock;} ?>" <?php if($stock == ('Временно нет в наличии') || $stock == ('Распродано') || $stock == ('Тимчасово немає в наявності') || $stock == ('Немає в наявності') || $stock == ('Нет в наличии') || $stock == ('В наличии') || $stock == ('В наявності')){ ?> onclick="return(false);" <?php }else{ ?>id="button-cart"<?php } ?> class="button" />
			<?php } elseif ($quantity < 0 && $this->config->get('config_stock_display')) { ?>
				<i class="fa fa-shopping-cart"></i>
				<input type="button" value="<?php echo $stock; ?>" <?php if($stock == ('Временно нет в наличии') || $stock == ('Тимчасово немає в наявності') || $stock == ('Немає в наявності') || $stock == ('Распродано') || $stock == ('Нет в наличии')){ ?> onclick="return(false);" <?php }else{ ?>id="button-cart"<?php } ?> class="button" />
			<?php } else { ?>
				<i class="fa fa-shopping-cart"></i>
				<input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />
			<?php } ?>
			</span>
            <a class="fa fa-heart wishlist" onclick="addToWishList('<?php echo $product_id; ?>');"><span><?php echo $button_wishlist; ?></span></a>
         </div>
		 	  
      </div>

       <?php if ($profiles): ?>
          <div class="option">
              <h2><span class="required">*</span><?php echo $text_payment_profile ?></h2>
              <select class="form-control" name="profile_id">
                  <option value=""><?php echo $text_select; ?></option>
                  <?php foreach ($profiles as $profile): ?>
                  <option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
                  <?php endforeach; ?>
              </select>
              
              <span id="profile-description"></span>
              
          </div>
        <?php endif; ?>
        
      

	  
    </div>
  </div>
  </div>
  
    <div class="tabs-group">
  <div id="tabs" class="htabs">
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $text_write; ?></a>
    <?php } ?>
		<a href="#tab-description"><?php echo $tab_review; ?></a>
  </div>

  <div id="tab-review" class="tab-content"><br><br>
  <div class="form-review">
<br>
<b id="review-title"></b>
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b><?php echo $entry_review; ?></b>
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp;<span><?php echo $entry_good; ?></span><br />
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="" />
    <br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  </div>
    <?php if ($review_status) { ?>
	  <div id="tab-desc" class="tab-content"><br><br>
    <div id="review"></div>
  </div>
   <?php } ?>
     </div>
  
  
  <?php echo $content_bottom; ?></div>
   <?php if ($products) { ?>
  <?php 
  $cols = 10;
  $span = 12/$cols; 
    ?>
  <div class="product-related box highlighted">
   <div class="box-description"><span><?php echo $tab_related; ?></span></div>
   <div id="related" class="slide product-grid box-products" data-interval="0">
    <?php if( count($products) > $cols ) { ?> 
    <div class="carousel-controls">
      <a class="carousel-control left fa fa-angle-left" href="#related" data-slide="prev"></a>
      <a class="carousel-control right fa fa-angle-right" href="#related" data-slide="next"></a>
    </div>
    <?php } ?>

    <div class="box-content products-block carousel-inner">
        <?php foreach ($products as $i => $product) { $i=$i+1; ?>
        <?php if( $i%$cols == 1 && $cols > 1 ) { ?>
        <div class= "item <?php if($i==1) {?>active<?php } ?>">
        <div class="product-row">
        <?php } ?>
        <div class="col-lg-2-5 col-md-3 col-sm-4 col-xs-6">
          <div class="product-block">
			<?php if ($product['thumb']) { ?>
			  <div class="image"><?php if( $product['special'] ) {   ?>
				<?php } ?>
				<a class="img" href="<?php echo $product['href']; ?>"><!-- star ipl --><?php echo $product['labels']; ?><!-- end ipl --><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
				<?php if ($quickview) { ?>
				<!--<a class="pav-colorbox hidden-sm hidden-xs" href="index.php?route=themecontrol/product&amp;product_id=<?php echo $product['product_id']; ?>"><span class='fa fa-eye'></span></a>-->
				<?php } ?>
				<?php 
				if( $swapimg ){
				$product_images = $this->model_catalog_product->getProductImages( $product['product_id'] );
				if(isset($product_images) && !empty($product_images)) {
					$thumb2 = $this->model_tool_image->resize($product_images[0]['image'],  $this->config->get('config_image_product_width'),  $this->config->get('config_image_product_height') );
				?>	
				<a class="hover-image" href="<?php echo $product['href']; ?>"><img src="<?php echo $thumb2; ?>" alt="<?php echo $product['name']; ?>"></a>
				
				<?php } } ?>
			  </div>
			  <?php } ?>
                <div class="product-meta">
                  <div class="warp-info">
                    <h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
                     <?php if ($product['rating']) { ?>
                    <div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
                    <?php } ?>
                    <?php if ($product['price']) { ?>
                    <div class="price">
                      <?php if (!$product['special']) { ?>
                      <?php echo $product['price']; ?>
                      <?php } else { ?>
                      <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
                      <?php } ?>
                    </div>
                      <?php } ?>
					  <?php if ($product['quantity'] == 0 || ($product['quantity'] < 0 && !$this->config->get('config_stock_display')) ) { ?>
				  <div class="status-stock text-center">
					<?php if($product['quantity'] == 0 && ($product['stock_status_text'] == 'В наличии') || ($product['stock_status_text'] == 'В наявності')){echo 'Нет в наличии';}else{echo $product['stock_status_text'];} ?>
				  </div>
				<?php } ?>
                  </div>
              </div>
        </div>
         </div>
        
        <?php if( $cols > 1  && ($i%$cols == 0 || $i==count($products)) ) { ?>
       </div>
        </div>
        <?php } ?>
        
        <?php } ?>
  </div>
  </div>
  </div>
   <script type="text/javascript">
            $('#related .item:first').addClass('active');
            $('#related').carousel({interval:false})
          </script>
  <?php } ?>
  <?php if( $productConfig['product_enablezoom'] ) { ?>


<?php } ?>
<script type="text/javascript"><!--
$(document).ready(function() {
  $('.colorbox').colorbox({
    overlayClose: true,
    opacity: 0.5,
    rel: "colorbox"
  });
});
//--></script> 
 <script type="text/javascript"><!--

$('select[name="profile_id"], input[name="quantity"]').change(function(){
    $.ajax({
    url: 'index.php?route=product/product/getRecurringDescription',
    type: 'post',
    data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
    dataType: 'json',
        beforeSend: function() {
            $('#profile-description').html('');
        },
    success: function(json) {
      $('.success, .warning, .attention, information, .error').remove();
            
      if (json['success']) {
                $('#profile-description').html(json['success']);
      } 
    }
  });
});
    
$('#button-cart').bind('click', function() {
  $.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
    dataType: 'json',
    success: function(json) {
      $('.success, .warning, .attention, information, .error').remove();
      
      if (json['error']) {
        if (json['error']['option']) {
          for (i in json['error']['option']) {
            $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
          }
        }
                
                if (json['error']['profile']) {
                    $('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
                }
      } 
      
      if (json['success']) {
        $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
          
        $('.success').fadeIn('slow');
          
        $('#cart-total').html(json['total']);

        $('#cart-total', window.parent.document ).html(json['total']);

        $('html, body').animate({ scrollTop: 0 }, 'slow'); 
      } 
    }
  });
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
  action: 'index.php?route=product/product/upload',
  name: 'file',
  autoSubmit: true,
  responseType: 'json',
  onSubmit: function(file, extension) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
  },
  onComplete: function(file, json) {
    $('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
    
    $('.error').remove();
    
    if (json['success']) {
      alert(json['success']);
      
      $('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
    }
    
    if (json['error']) {
      $('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
    }
    
    $('.loading').remove(); 
  }
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
  $('#review').fadeOut('slow');
    
  $('#review').load(this.href);
  
  $('#review').fadeIn('slow');
  
  return false;
});     

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
    beforeSend: function() {
      $('.success, .warning').remove();
      $('#button-review').attr('disabled', true);
      $('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
    },
    complete: function() {
      $('#button-review').attr('disabled', false);
      $('.attention').remove();
    },
    success: function(data) {
      if (data['error']) {
        $('#review-title').after('<div class="warning">' + data['error'] + '</div>');
      }
      
      if (data['success']) {
        $('#review-title').after('<div class="success">' + data['success'] + '</div>');
                
        $('input[name=\'name\']').val('');
        $('textarea[name=\'text\']').val('');
        $('input[name=\'rating\']:checked').attr('checked', '');
        $('input[name=\'captcha\']').val('');
      }
    }
  });
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
  if ($.browser.msie && $.browser.version == 6) {
    $('.date, .datetime, .time').bgIframe();
  }

  $('.date').datepicker({dateFormat: 'yy-mm-dd'});
  $('.datetime').datetimepicker({
    dateFormat: 'yy-mm-dd',
    timeFormat: 'h:m'
  });
  $('.time').timepicker({timeFormat: 'h:m'});
});
//--></script> 


<!--Спойлер-->
<script type="text/javascript"><!-- 
$(document).ready(function() {
	if ($('.category-info')[0].scrollHeight > 135)  {

		$(".category-info").after('<div id="obexpand" class="obertka"><button class="expand" type="button" id="expand"><span class="but-prod">Развернуть </span></button></div>');
		$(".category-info").after('<div id="obhide" class="obertka" style="display:none;"><button class="expand" type="button" id="hide"><span class="">Свернуть </span></button></div>');
		$('.category-info').append("<div class='hide'></div>");
		};

});

			$('#expand').live('click',function(){
						$('#obexpand').css("display", "none");
						$('.category-info').animate({height: $('.category-info')[0].scrollHeight}, 600);
						$('#obhide').css("display", "block");
						$('.hide').css("display", "none");

			});

			$('#hide').live('click',function(){
						$('#obhide').css("display", "none");
						$('.category-info').animate({height: 140}, 600);
						$('#obexpand').css("display", "block");
						$('.hide').css("display", "block");

			});
//--></script>
<!--Спойлер-->
<!--однакові блоки-->
<script type="text/javascript"><!-- 
function setEqualHeight(columns)
{
var tallestcolumn = 0;
columns.each(
function()
{
currentHeight = $(this).height();
if(currentHeight > tallestcolumn)
{
tallestcolumn = currentHeight;
}
}
);
columns.height(tallestcolumn);
}
$(document).ready(function() {
setEqualHeight($(".product-row > div > div > div > div"));
});
//--></script>
<!--однакові блоки-->
<?php if ($tags) { ?>
      <div class="tags"><?php echo $text_tags; ?>
        <?php for ($i = 0; $i < count($tags); $i++) { ?>
        <?php if ($i < (count($tags) - 1)) { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
        <?php } else { ?>
        <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
        <?php } ?>
        <?php } ?>
      </div>
      <?php } ?>
</div> 
<?php if( $SPAN[2] ): ?>
<div class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12"> 
  <?php echo $column_right; ?>
</div>
<?php endif; ?>

<?php echo $footer; ?>