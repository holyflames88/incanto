<h3>Quick SEO clear</h3>
<form class="form-horizontal">
<table class="table table-condensed no-border">
	<tbody>
	<?php $i_clear=1; foreach ($MD_CategoryEntites as $key => $val){
	if(!isset($val['clear']))continue; ?>
	<!-- 1.   -->		
		<tr>
			<td><span class="badge"><?php echo $i_clear; ?></span></td>
			<td>
				<fieldset>
				<div class="control-group">
				<label class="control-label"><?php echo ${'text_category_name_'.$key}; ?></label>
					<div class="controls">
						
						
						<?php if (count($val['clear'])>1) {?>
							<div style="margin-top:-15px;" class="btn-group btn-group-vertical">
						<?php }else { ?>
							<div class="btn-group">
						<?php } ?>
						<?php $i_clear=1; foreach ($val['clear'] as $clear_val){ ?>
							<a data-action="clearSeo" data-entity="<?php echo $key.'-all';?>" data-scope="" data-data="<?php echo $clear_val;?>"  class="btn btn-warning" type="button"><?php echo ${'button_seo_clear_'.$clear_val}; ?></a>
						<?php } ?>
						</div>
					</div>
				</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo ${'text_category_name_'.$key}; ?>:</dt>
					<dd class="success">
						<?php echo ${'text_seo_clear__'.$key}; ?>
					</dd>
				</dl>
			</td>
		</tr>
	<?php $i_clear++; } ?>	
	</tbody>
</table>
</form>	