<?php 
// echo "<pre>";
// var_dump($this->customer->getCustomerGroupId());
// echo "</pre>";
// die();
 $detect = new Mobile_Detect; 
 require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); 
	$themeConfig = (array)$this->config->get('themecontrol');
	$categoryConfig = array(
		'listing_products_columns'           => 0,
		'listing_products_columns_small'     => 2,
		'listing_products_columns_minismall' => 1,
		'cateogry_display_mode'              => 'grid',
		'category_pzoom'                     => 1,
		'quickview'                          => 0,
		'show_swap_image'                    => 0,
	);
	$categoryConfig     = array_merge($categoryConfig, $themeConfig );
	$DISPLAY_MODE 	    = $categoryConfig['cateogry_display_mode'];
	if($detect->isTablet()) {
		// Вывод по 3 товара в строку для мобильных
		$MAX_ITEM_ROW       = 3; 
	}else if($detect->isMobile()){
		// Вывод по 2 товара в строку для планшета
		$MAX_ITEM_ROW       = 2; 
	}else{
		// Дефолтный вывод темы по 4 в строку
		$MAX_ITEM_ROW       = $themeConfig['listing_products_columns']?$themeConfig['listing_products_columns']:2; 
	}
	$MAX_ITEM_ROW_SMALL = $categoryConfig['listing_products_columns_small']?$categoryConfig['listing_products_columns_small']:2;
	$MAX_ITEM_ROW_MINI  = $categoryConfig['listing_products_columns_minismall']?$categoryConfig['listing_products_columns_minismall']:1; 
	$categoryPzoom 	    = $categoryConfig['category_pzoom'];
	$quickview          = $categoryConfig['quickview'];
	$swapimg            = $categoryConfig['show_swap_image'];
?>
<?php echo $header; ?>
 
<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	</aside>	
<?php endif; ?> 
<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>	
<div id="content"><?php echo $content_top; ?>
 
<?php if ($categories) { ?>
  <div class="category-list clearfix">
    <?php if (count($categories) <= 5) { ?>
    <ul>
      <?php foreach ($categories as $category) { ?>
      <li><a href="<?php echo $category['href']; ?>"><i class="fa fa-angle-right"></i><?php echo $category['name']; ?></a></li>
      <?php } ?>
    </ul>
    <?php } else { ?>
    <?php for ($i = 0; $i < count($categories);) { ?>
    <ul>
      <?php $j = $i + ceil(count($categories) / 4); ?>
      <?php for (; $i < $j; $i++) { ?>
      <?php if (isset($categories[$i])) { ?>
      <li><a href="<?php echo $categories[$i]['href']; ?>"><i class="fa fa-angle-right"></i><?php echo $categories[$i]['name']; ?></a></li>
      <?php } ?>
      <?php } ?>
    </ul>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  <div class="pagination"><?php echo $pagination; ?></div>
  <div align="center"><span class="cat_h1"><?php echo $heading_title; ?></span></div>
  <?php if ($products) { ?>
<!-- <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>     -->
  
<div class="product-list"><div class="products-block">
    <?php
	$cols = $MAX_ITEM_ROW ;
	$span = floor(12/$cols);
	$small = floor(12/$MAX_ITEM_ROW_SMALL);
	$mini = floor(12/$MAX_ITEM_ROW_MINI);
	foreach ($products as $i => $product) { ?>
	<?php if( $i++%$cols == 0 ) { ?>
		  <div class="row">
	<?php } ?>
	<?php if($detect->isTablet()) { ?>
		<div class=" col-xs-4 col-lg-4 col-md-4 col-sm-4">	
	<?php }else if($detect->isMobile()){ ?>
		<div class=" col-xs-6 col-lg-6 col-md-6 col-sm-6">	
	<?php }else{ ?>
		<div class=" col-xs-6 col-lg-<?php echo $span;?>  col-md-<?php echo $span;?>  col-sm-<?php echo $small;?>">
	<?php } ?>
    	<div class="product-block">	
	      <?php if ($product['thumb']) { ?>
	      <div class="image">
			<?php if( $product['special'] ) {   ?>
	    	
	    	<?php } ?>
	    	<a class="img" href="<?php echo $product['href']; ?>"><!-- star ipl --><?php echo $product['labels']; ?><!-- end ipl --><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
	      	<?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
	      	<a href="<?php echo $zimage;?>" class="colorbox product-zoom hidden-sm hidden-xs" rel="nofollow" title="<?php echo $product['name']; ?>"><span class="fa fa-search-plus"></span><span class="zoom_text">zoom</span></a>
	      	<?php } ?>

			<?php //#2 Start fix quickview in fw?>
			<?php if (0) { /*if ($quickview) {*/?>
			<a class="pav-colorbox hidden-sm hidden-xs" href="index.php?route=themecontrol/product&amp;product_id=<?php echo $product['product_id']; ?>"><span class='fa fa-eye'></span></a>
			<?php } ?>
			<?php //#2 End fix quickview in fw?>

			<?php
  			if( $swapimg ){
      		$product_images = $this->model_catalog_product->getProductImages( $product['product_id'] );
			if(isset($product_images) && !empty($product_images)) {
				$thumb2 = $this->model_tool_image->resize($product_images[0]['image'],  $this->config->get('config_image_product_width'),  $this->config->get('config_image_product_height') );
			?>	
			<a class="hover-image" href="<?php echo $product['href']; ?>"><img src="<?php echo $thumb2; ?>" alt="<?php echo $product['name']; ?>"></a>
			
			<?php } } ?>
			<?php if ($product['quantity'] == 0 || ($product['quantity'] < 0 && !$this->config->get('config_stock_display')) ) { ?>
			  <div class="status-stock text-center">
			  <div class="ugol"></div>
				<span>
				<?php if($product['quantity'] == 0 && ($product['stock_status_text'] == 'В наличии') || ($product['stock_status_text'] == 'В наявності')){echo 'Нет в наличии';}else{echo $product['stock_status_text'];} ?>
				</span>
			  </div>
			<?php } ?>
	      </div>
	      <?php } ?>
	      <div class="product-meta">
	      	<div class="warp-info">
                <div style="text-align: center;">
                <?php foreach ($product['option_images'] as $option_img) { ?>
                <img src="<?php echo $option_img; ?>" style="border: 1px solid black; height: 11px; width: 27px;" />
                <?php } ?>
                </div>
		      <h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
			  <?php if ($product['rating']) { ?>
		      <div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
		      <?php } ?>
		      <div class="price-cart">
			      <?php if ($product['price']) { ?>
			      <div class="price">
			        <?php if (!$product['special']) { ?>
			        <?php echo $product['price']; ?>
			        <?php } else { ?>
			        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
			        <?php } ?>
			        <?php if ($product['tax']) { ?>
			        <br />
			        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
			        <?php } ?>
			      </div>
			      <?php } ?>
			  </div>
			  </div>
		 </div>
<!-- 		 <div class="group-item">
		      <div class="wishlist-compare">
				  <a class="wishlist fa fa-heart" onclick="addToWishList('<?php echo $product['product_id']; ?>');" title="<?php echo $button_wishlist; ?>" ><span><?php echo $button_wishlist; ?></span></a>
				  <a class="compare fa fa-retweet"  onclick="addToCompare('<?php echo $product['product_id']; ?>');" title="<?php echo $button_compare; ?>" ><span><?php echo $button_compare; ?></span></a>
			 </div>
		 </div>	   -->
		</div>
	</div>
	 <?php if( $i%$cols == 0 || $i==count($products) ) { ?>
	 </div>
	 <?php } ?>
				
    <?php } ?>
  </div>
  </div>

   <div class="pagination"><?php echo $pagination; ?></div><br>
		<div align="center"><h1><?php echo $heading_title_foot; ?></h1></div>
  <?php } ?>
  
    <?php if ($thumb || $description) { ?>
  <div class="category-info clearfix">
    <?php if ($thumb) { ?>
    <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
    <?php } ?>
    <?php if ($description) { ?>
    <?php echo $description; ?>
    <?php } ?>
  </div>
  <?php } ?> 
  
  
  <?php if (!$categories && !$products) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
		
		$('.products-block  .product-block').each(function(index, element) {
 
			 $(element).parent().addClass("col-fullwidth");

            var rating = $(element).find('.rating').html();
		});		
		
		$('.display').html('<span style="float: left;"><?php echo $text_display; ?></span><a class="list active"><em><?php echo $text_list; ?></em></a><a class="grid"  onclick="display(\'grid\');"><em><?php echo $text_grid; ?></em></a>');
	
		$.totalStorage('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.products-block  .product-block').each(function(index, element) {
			 $(element).parent().removeClass("col-fullwidth");

            var rating = $(element).find('.rating').html();
		});	
					
		$('.display').html('<span style="float: left;"><?php echo $text_display; ?></span><a class="list" onclick="display(\'list\');"><em><?php echo $text_list; ?></em></a><a class="grid active"><em><?php echo $text_grid; ?></em></a>');
	
		$.totalStorage('display', 'grid');
	}
}

view = $.totalStorage('display');

if (view) {
	display(view);
} else {
	display('<?php echo $DISPLAY_MODE;?>');
}
//--></script> 
<?php if( $categoryPzoom ) {  ?>

<?php } ?>
</section> 

<?php if( $SPAN[2] ): ?>
	<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?>
 <!--Спойлер-->
<script type="text/javascript"><!--
 
 
$(document).ready(function() {
	if ($('.category-info')[0].scrollHeight > 135)  {
   
		$(".category-info").after('<div id="obexpand" class="obertka"><button class="expand" type="button" id="expand"><span class="">Развернуть </span></button></div>');
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
						$('.category-info').animate({height: 120}, 600);
						$('#obexpand').css("display", "block");
						$('.hide').css("display", "block");		   
								   
			});
 
//--></script>
<!--Спойлер--> 
<?php echo $footer; ?>