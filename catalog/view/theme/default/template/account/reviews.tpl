<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>

<div id="content"><?php echo $content_top; ?>
<style>
.ajax-edit{display:none;}
.ajax-edit textarea{width:97%;cursor:text;}
.ajax-edit +div{cursor:pointer;}
</style>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  
  
<?php if ($purchased_products) { ?>
  <div class="box box_purchased">
  <div class="box-heading"><?php echo $text_purchased_products; ?></div>
  <div class="box-content">
    <div class="box-product">
      <?php foreach ($purchased_products as $product) { ?>
      <div>
        <?php if ($product['image']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['image']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <a href="<?php echo $product['href']; ?>"><?php echo $set_review ?></a>
      </div>
      <?php } ?>
    </div>
  </div>
</div>
<?php } ?>

<?php if ($reviews) { ?>
  <?php foreach ($reviews as $review) { ?>  
  <div class="reviews-list">
	<div class="reviews-main">
		<div class="review-id"># <?php echo $review['review_id']; ?></div>
		<div class="product-image"><a href="<?php echo $review['href']; ?>"><img src="<?php echo $review['product_image'] ?>" /></a></div>
		<div class="product-name"><a href="<?php echo $review['href']; ?>"><?php echo $review['product_name']; ?></a></div>
		<div class="review-status <?php echo $review['class-status']; ?>"><?php echo $review['status']; ?></div>
		<div class="review-date"><?php echo $review['date_added']; ?></div>	
	</div>
	<div class="review-content">
		<div class="review-rating"><img src="catalog/view/theme/default/image/stars-<?php echo $review['rating']; ?>.png" /></div>
		<div class="text-<?php echo $review['review_id']; ?>"><?php echo $review['text'] ?></div>
	<?php if($reviews_edit==1) { ?>
		<div class="edit-form">
			<div class="ajax-edit" id="text-<?php echo $review['review_id']; ?>" value="<?php echo $review['review_id']; ?>">
				<textarea name="text" id="texteditor" rows="5"><?php echo $review['text']; ?></textarea><br>
				<span class="btn-success"  onclick="save_review(<?php echo $review['review_id']; ?>)"><?php echo $button_save; ?></span>&nbsp
				<span class="btn-edit" onclick="close_review(<?php echo $review['review_id']; ?>)"; return false;><?php echo $button_back; ?></span>
			</div>
			<span class="btn-edit"><?php echo $button_edit; ?></span>
		 </div>
	<?php } ?>
    </div>
  </div>
  <?php } ?>
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } else { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <?php } ?>

  <?php echo $content_bottom; ?></div>
  
  <?php if($reviews_edit==1) { ?>
<script type="text/javascript">
$(document).ready(function() {
$('.ajax-edit').each(function(index, wrapper) {
	$(this).siblings().click(function() {
	$(wrapper).show(300);
	$(wrapper).siblings().hide();
})
});
})

function save_review(id) {
									
var textarea_text = $("#text-"+id+" textarea[name=\'text\']");
var text = textarea_text.val();								
$.ajax({
		url: '/index.php?route=account/reviews/updateReview',
		type: 'post',
		dataType: 'json',
		data: 'text=' + encodeURIComponent(text) + '&review_id=' + encodeURIComponent(id),
		success: function(data) {
			$('.success, .warning').remove();
			if (data['error']) {
				$('#notification').html('<div class="warning">' + data['error'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
			}			
			if (data['success']) {
				$('#notification').html('<div class="success">' + data['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
								
				$('.text-'+id).html(text);
				close_review(id);				
			}
		}
});      
}

function close_review(id) {
	$('.ajax-edit textarea').blur();
	$('#text-'+id).siblings().show();
	$('#text-'+id).hide(500);
}
</script>
<?php } ?>
<?php echo $footer; ?>