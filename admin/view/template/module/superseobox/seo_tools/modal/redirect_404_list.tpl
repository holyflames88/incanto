<div style="margin-bottom: 20px;">
	<?php echo $redirect_404_url['pagination']; ?>
</div>

<input type="hidden" class="parameter_empty" name="" value=""/>
<table class="table table-hover grider">
	<thead>
		<tr class="top_table">
			<th><?php echo $text_common_tool_modal_redirect_404_3; ?></th>
			<th colspan="2">
				<span class="broken_url with-change span6"><?php echo $text_common_tool_modal_redirect_404_4; ?></span> 
				<span class="redirect_url with-change span2"><?php echo $text_common_tool_modal_redirect_404_5; ?></span>
			</th>
			<th></th>
		</tr>
	 </thead>
	 <tbody>
	<?php if(count($redirect_404_url['data'])){?>
	
		<?php foreach ($redirect_404_url['data'] as $data_404) { ?>
		<tr>
			<td class="hits_404">
				<?php echo $data_404['hit'];?>
			</td>
			<td colspan="2"> 
				<input data-header-class="broken_url" dgp-onlyfornew="1" data-gride-pattern="data[new_row][%s1][url_404]" class="broken_url span6" type="text" name="data[<?php echo $data_404['custom_url_404_id'];?>][url_404]"  value="<?php echo $data_404['url_404'];?>">

				<input data-header-class="redirect_url" dgp-onlyfornew="1" data-gride-pattern="data[new_row][%s1][url_redirect]" class="span2" type="text" name="data[<?php echo $data_404['custom_url_404_id'];?>][url_redirect]"  value="<?php echo $data_404['url_redirect'];?>">
			</td>
			<td>
				<input type="checkbox" value="true">
			</td>
		</tr>
		<?php } ?>
	<?php }else{ ?>
		<tr>
			<td class="hits_404">0</td>
			<td colspan="2"> 
				<input data-header-class="broken_url" dgp-onlyfornew="1" data-gride-pattern="data[new_row][%s1][url_404]" class="broken_url span6" type="text" name="data[new_row][0][url_404]"  value="">

				<input data-header-class="redirect_url" dgp-onlyfornew="1" data-gride-pattern="data[new_row][%s1][url_redirect]" class="span2" type="text" name="data[new_row][0][url_redirect]"  value="">
			</td>
			<td>
				<input type="checkbox" value="true">
			</td>
		</tr>
	<?php } ?>
	</tbody>
</table>