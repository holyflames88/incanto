<!-- Modal -->
<div id="modal-info_tab-generate" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-info_tab-generateLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
    <h3 id="modal-info_tab-generateLabel">SEO Generators - INFO</h3>
  </div>
  <div class="modal-body">
	
    <table class="table table-hover grider">
	<caption>Patterns</caption>
		<tbody>	
			<tr class="top_table">
				<th>Abbreviations</th>
				<th> Name </th>
			</tr>		
			<?php foreach ($data['entity']['urls']['STAN_urls']['data'] as $page_urls) { ?>
			<tr>
			<td></td>
			<td></td>
			</tr>
			<?php } ?>
		</tbody>
	</table>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>