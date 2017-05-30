<?php $wClass = (!empty($data['SimilarProducts']['WrapInWidget']) && ($data['SimilarProducts']['AdditionalPositioning'] != 'product_tab') && (isset($products)) && $data['SimilarProducts']['WrapInWidget'] == 'yes') ? 'box' : ''; ?>
<?php if ($SimilarProductsRun=="yes") { ?>
<?php if(!empty($data['SimilarProducts']['CustomCSS'])): ?>
<style>
<?php echo htmlspecialchars_decode($data['SimilarProducts']['CustomCSS']); ?>
</style>
<?php endif; ?>
<div class="<?php echo $wClass; ?> similarProductsWrapper" style="display:none;">
  <?php if ($data['SimilarProducts']['AdditionalPositioning'] != 'product_tab' && $products) { ?>
  <div class="box-heading similarproducts-heading"><?php echo $heading_title; ?></div>
  <?php } ?>
  <div class="box-content similarproducts-content">
    <div class="box-product similarproducts-product">
      <?php foreach ($products as $product) { ?>
      <div class="box-similar-product">
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><div class="name-gradient"></div><?php echo $product['name']; ?></a></div>
		
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
       <?php if ($data['SimilarProducts']['AddToCart'] == 'yes') { ?>
        <div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
    	<?php } ?>
      </div>
      <?php } ?>
    </div>
  </div>
</div>

<?php if (isset($data['SimilarProducts']['AdditionalPositioning']) && $data['SimilarProducts']['AdditionalPositioning'] == 'below_product_info') { ?>
<script>
$(document).ready(function() {
$('.product-info').after('<div class="<?php echo $wClass; ?>">'+$('.similarProductsWrapper').html()+'</div>');
});
</script>
<?php } else if (isset($data['SimilarProducts']['AdditionalPositioning']) && $data['SimilarProducts']['AdditionalPositioning'] == 'product_tab') { ?>
<script>
$(document).ready(function() {
$('div.tags').before('<div id="tab-SimilarProducts" class="tab-content" style="display:block;"><div class="<?php echo $wClass; ?>">'+$('.similarProductsWrapper').html()+'</div></div>');
$('div#tabs').append('<a href="#tab-SimilarProducts" style="display:inline;"><?php echo $tab_SimilarProducts; ?></a>');
$('#tabs a').tabs();
});
</script>
<?php } else { ?>
<script>
$( document ).ready(function() {
$('.similarProductsWrapper').show();
});
</script>
<?php } ?>

<?php } ?>