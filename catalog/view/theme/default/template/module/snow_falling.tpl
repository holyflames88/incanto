<script type="text/javascript">
$(document).ready( function(){
	$.fn.snow({
		minSize: <?php echo $min_size; ?>, 
		maxSize: <?php echo $max_size; ?>, 
		newOn: 1500, 
		flakeColor: '#<?php echo $flake_color; ?>'
	});
});
</script>
