<!-- MODAL PARAMETERS DESCRIPTION !-->
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3><?php echo $text_common_town_list_1; ?></h3>
  </div>
  <div class="modal-body">
	<table class="table table-hover grider-wt">
		<thead>
			<tr class="top_table">
			<?php foreach ($languages as $l_key) { ?>
				<th><?php echo $text_common_town_list_2; ?>(<?php echo $l_key; ?>)</th>
			<?php } ?>
			</tr>
		 </thead>
		<tbody>	
			<?php foreach ($wt as $i => $towns) { ?>
				<tr><?php var_dump($towns); ?>
				<?php foreach ($towns as $ii => $town) { ?>
					
					<td> <input type="text" name="data[patternsSettings][wt][data][<?php echo $languages[$ii]; ?>][<?php echo $i; ?>]"  value="<?php echo $town; ?>"></td>
				<?php } ?>
				</tr>
			<?php } ?>
		</tbody>
	</table>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
	<a data-afteraction="afterAction" data-action="save" data-scope=".parents('#modal-parameterWT').find('input')" class="btn ajax_action" data-dismiss="modal" type="button"><?php echo $text_common_save; ?></a>
  </div>
