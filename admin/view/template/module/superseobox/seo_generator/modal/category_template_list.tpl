<div style="margin-bottom: 20px;">
	<?php echo $pagination; ?>
</div>

<table class="list">
  <thead>
	<tr class="tr-static">
	  <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('.show-tr input[name*=\'data[category]\']').attr('checked', this.checked);" /></td>
	  <td class="center span4"><?php echo $text_common_category; ?></td>
	  <td class="center span8"><?php echo $text_common_template; ?></td>
	</tr>
  </thead>
  <tbody>
	<?php if ($categories) { ?>
	<?php foreach ($categories as $category) { ?>
			<?php foreach ($languages as $l_code => $language){ 
				if(!$language['status'])continue; 
				$hide = $active_lang_code <> $l_code ? 'style="display:none;"' : ''; 
				$show = $active_lang_code == $l_code ? ' show-tr ' : '';?> 
				<tr <?php echo $hide; ?> class= "lang-<?php echo $l_code . $show; ?>">
					<td style="text-align: center;">
						<input type="checkbox" name="data[category][<?php echo $category['category_id']; ?>]" value="<?php echo $l_code; ?>" />
					</td>
					<td class="left span4">
						<?php echo $category['name']; ?>
					</td>
					<td class="left span8">
						<?php if(isset($category_template[$category['category_id']][$l_code])){
						$template = $category_template[$category['category_id']][$l_code]; ?>
							<a class="editable" data-type="text" data-pk="{id:<?php echo $category['category_id']; ?>, l_code: '<?php echo $l_code; ?>'}" data-name="<?php echo $category_entity; ?>" data-value="<?php echo $template; ?>"><?php echo $template; ?></a>	
						<?php }else{ ?>
							<a class="editable" data-type="text" data-pk="{id:<?php echo $category['category_id']; ?>, l_code: '<?php echo $l_code; ?>'}" data-name="<?php echo $category_entity; ?>" data-value=""></a>	
						<?php } ?>
					</td>
				</tr>
			<?php } ?>
		<?php } ?>
	<?php } else { ?>
	<tr>
	  <td class="center" colspan="4"><?php echo $text_no_results; ?></td>
	</tr>
	<?php } ?>
  </tbody>
</table>