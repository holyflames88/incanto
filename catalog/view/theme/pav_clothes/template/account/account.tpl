<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>

<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-sm-<?php echo $SPAN[0];?> col-xs-12">
	<?php echo $column_left; ?>
	</aside>
<?php endif; ?>

		<section class="col-lg-<?php echo $SPAN[1];?> col-sm-<?php echo $SPAN[1];?> col-xs-12">
			<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
		<?php } ?>
		    <?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>  
			<div id="content" ><?php echo $content_top; ?>			  
			  <h1><?php echo $heading_title; ?></h1>			  
			  <div class="content" id="acc_group">
				<h2><?php echo $text_my_account; ?></h2>			  
				  <div class="acc"><a href="<?php echo $edit; ?>"><img src="catalog/view/theme/default/image/account-images/edit.png" alt="Account Details"><p><?php echo $text_edit; ?></p></a></div>
				  <div class="acc"><a href="<?php echo $password; ?>"><img src="catalog/view/theme/default/image/account-images/password.png" alt="Account Details"><p><?php echo $text_password; ?></p></a></div>
				  <div class="acc"><a href="<?php echo $address; ?>"><img src="catalog/view/theme/default/image/account-images/address.png" alt="Account Details"><p><?php echo $text_address; ?></p></a></div>
				  <div class="acc"><a href="<?php echo $wishlist; ?>"><img src="catalog/view/theme/default/image/account-images/wishlist.png" alt="Account Details"><p><?php echo $text_wishlist; ?></p></a></div>
			  </div>			  
			  <div class="content" id="acc_group">
				<h2><?php echo $text_my_orders; ?></h2>
				<div class="acc"><a href="<?php echo $order; ?>"><img src="catalog/view/theme/default/image/account-images/orders.png" alt="Account Details"><p><?php echo $text_order; ?></p></a></div>			  
				<div class="acc"><a href="<?php echo $reviews; ?>"><img src="catalog/view/theme/default/image/account-images/rewiews.png" alt="Account Details"><p><?php echo $text_reviews; ?></p></a></div>
			
			  </div>
		</div>  
  <?php echo $content_bottom; ?></section>
 
	<?php if( $SPAN[2] ): ?>
	<aside class="col-lg-<?php echo $SPAN[2];?> col-sm-<?php echo $SPAN[2];?> col-xs-12">	
		<?php echo $column_right; ?>
	</aside>
	<?php endif; ?>
	
<?php echo $footer; ?> 