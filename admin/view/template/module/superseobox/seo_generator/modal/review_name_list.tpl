<div style="margin-bottom: 20px;">
	<?php echo $pagination[$l_code]; ?>
</div>

<input type="hidden" class="parameter_empty" name="" value=""/>
<table class="table table-hover grider">
	<thead>
		<tr class="top_table">
			<th>Id</th>
			<th><?php echo $text_common_review_name_list_1; ?></th>
			<th></th>
		</tr>
	 </thead>
	 <tbody>
	<?php if(count($l_data)){?>
	
		<?php foreach ($l_data as $data) { ?>
		<tr>
			<td class="review-id">
				<?php echo $data['id'];?>
			</td>
			<td> 
				<input dgp-onlyfornew="1" data-gride-pattern="data[<?php echo $l_code; ?>][new_row][text][%s1]" class="span8" type="text" name="data[<?php echo $l_code; ?>][<?php echo $data['id'];?>][text]"  value="<?php echo $data['text'];?>">
			</td>
			<td>
				<input type="checkbox" value="true">
			</td>
		</tr>
		<?php } ?>
	<?php }else{ ?>
		<tr>
			<td>
				
			</td>
			<td> 
				<input dgp-onlyfornew="1" data-gride-pattern="data[<?php echo $l_code; ?>][new_row][text][%s1]" class="span6" type="text" name="data[<?php echo $l_code; ?>][new_row][text][0]"  value="">
			</td>
			<td>
				<input type="checkbox" value="true">
			</td>
		</tr>
	<?php } ?>
	</tbody>
</table>