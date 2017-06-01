
 <?php 
 echo $header; 
?>
 
<div id="content">
	<?php if( isset($message) ) { ?> 
	<div class="success"><?php echo $message; ?></div>
	<?php } ?>
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
		<table class="form">
			<input  type="text" value="" placeholder="Поиск товара" name="searchp" ><br/>
			<input value="<?php echo $id;?>" name="widget[id]" type="hidden"/>
			 <?php if( !$disabled ){ ?> 
			<tr>
				<td><?php echo $this->language->get("text_widget_type");?></td>
				<td>
					<select name="widget[type]" id="widget_type">
						<option  value=""><?php echo $this->language->get("text_widget_select_one");?></option>	
						<?php foreach( $types as $widget => $text ) { ?>
						<option value="<?php echo $widget; ?>" <?php if( $widget_selected == $widget ) { ?> selected="selected" <?php } ?>><?php echo $text; ?></option>
						<?php } ?>
					</select>
					<script type="text/javascript">
						$('#widget_type').change( function(){
							location.href = '<?php echo html_entity_decode($action); ?>&wtype='+$(this).val();
						} );
					</script>
				</td>
			</tr>
			<?php }   ?>
			<tr>
				<td><?php echo $this->language->get("text_widget_name");?></td>
				<td>
					<input type="text" name="widget[name]" value="<?php echo $widget_data['name'];?>">
					 <?php if( $disabled ){ ?> 
					 <input type="hidden" name="widget[type]" value="<?php echo $widget_data['type'];?>">
					 <?php } ?>
				</td>
			</tr>
		</table>
		
		<div id="serc">
		
			<?php echo $form; ?>
			
		</div>
		<div>
			<button type="submit" class="btn button">Save</button>
		</div>
	</form>
</div>
<script type="text/javascript">
	 $("#form").submit( function(){ 
	 	var er = false;
	 	$.each( $("#form").serializeArray(), function(i, e){
	 		 if( e.value == '' ){
	 		 	er = true;
	 		 }
	 	} );
	 	if( er ){
	 		alert(  '<?php echo $this->language->get("text_please_fill_data"); ?>' );
	 		return false; 
	 	}
	 	return true;
	 });

$('input[name=\'searchp\']').autocomplete({
	delay: 400,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		var inpu = $('#serc input[name=\'params[product_id]\']');
		inpu.val(inpu.val()+ui.item.value+',');
		//$('#serc input[name=\'params[product_id]\']').val(ui.item.value);
		return false;
	},
	focus: function(event, ui) {
      return false;
   }
});
</script>
<?php echo $footer; ?>

 