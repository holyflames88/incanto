<div id="langmark_<?php echo $prefix;?>">
<?php echo($html); ?>
</div>

<script>
	<?php if (isset($settings_widget['anchor']) && $settings_widget['anchor']!='') { ?>
	var prefix = '<?php echo $prefix; ?>';
	var langmarkdata = $('#langmark_<?php echo $prefix;?>').html();
	<?php echo $settings_widget['anchor']; ?>;
	$('#langmark_<?php echo $prefix; ?>').remove();
   <?php  } ?>
</script>

