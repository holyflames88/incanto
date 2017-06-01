<!-- MODAL DESCRIPTION OF ADDITIONAL SETTINGS FOR PARAMETERS (dasp) !-->
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3 id="modal-info_tab-generate-dasp-label"><?php echo $text_common_param_setting_descrip_1; ?></h3>
  </div>
  <div class="modal-body">
	<p class="lead">
	<?php echo $text_common_param_setting_descrip_2; ?>
	</p>

	<h4 style="text-align:left;"> <?php echo $text_common_param_setting_descrip_3; ?> </h4>

	<table class="table table-bordered">
	<thead>
	<tr>
		<th style="text-align:center;"></th>
		<?php foreach ($patterns_setting as $key => $val) { if(!isset($val['additional']))continue; ?>
			<th style="text-align:center;">!<?php echo $key; ?> </br> <?php echo $patterns[$key]['name']; ?></th>
		<?php } ?>
	</tr>
	</thead>
	<tbody>
	<tr>
		<td><?php echo $text_common_param_setting_descrip_4; ?></td>
		<td>...</td>
		<td>Nt # Ns</td>
		<td>Nt # Pn # Tb</td>
		<td>...</td>
		<td>...</td>
		<td>Ns</td>
		<td>Pn # Tb</td>
		<td>Pn # Tb</td>
	</tr>

	<tr>
		<td><?php echo $text_common_param_setting_descrip_5; ?></td>
		<td>...</td>
		<td>Ns</td>
		<td>...</td>
		<td>Nt # Pn # Tb</td>
		<td>...</td>
		<td>...</td>
		<td>Pn # Tb</td>
		<td>Pn # Tb</td>
	</tr>
	
	<tr>
		<td><?php echo $text_common_param_setting_descrip_6; ?></td>
		<td>Ns</td>
		<td>...</td>
		<td>...</td>
		<td>Nt # Pn # Tb</td>
		<td>...</td>
		<td>...</td>
		<td>Pn # Tb</td>
		<td>Pn # Tb</td>
	</tr>
	
	<tr>
		<td><?php echo $text_common_param_setting_descrip_7; ?></td>
		<td>...</td>
		<td>...</td>
		<td>...</td>
		<td>...</td>
		<td>Ns</td>
		<td>...</td>
		<td>Pn # Tb</td>
		<td>Pn # Tb</td>
	</tr>
	</tbody>
	</table>
	<div class="info-area">
	<?php echo $text_common_param_setting_descrip_8; ?></br>
	Notations:
	<dl class="dl-horizontal">
		<dt>Nt</dt>
		<dd>- <?php echo $text_common_param_setting_descrip_9; ?> <span class="colorFC580B">(max: 9)</span></dd>
		<dt>Ns</dt>
		<dd>- <?php echo $text_common_param_setting_descrip_10; ?> <span class="colorFC580B">(max: 9)</span></dd>
		<dt>Pn</dt>
		<dd>- <?php echo $text_common_param_setting_descrip_11; ?> <span class="colorFC580B">(any character except #)</span></dd>
		<dt>Tb</dt>
		<dd>- <?php echo $text_common_param_setting_descrip_12; ?> <span class="colorFC580B">(any text, which not include char #)</span></dd>
		<dt>#</dt>
		<dd>- <?php echo $text_common_param_setting_descrip_13; ?></dd>
		<dt>...</dt>
		<dd>- <?php echo $text_common_param_setting_descrip_14; ?></dd>
	</dl>
	</div>
	
	<div class="lead"><h4><?php echo $text_common_param_setting_descrip_15; ?></h4> 
	<span class="label label-info">!ep(3 #; # to buy ) </span><?php echo $text_common_param_setting_descrip_16; ?> </br>
	<dl class="dl-horizontal">
		<dt><span class="label label-info">3</span></dt>
		<dd>- <?php echo $text_common_param_setting_descrip_17; ?></dd>
		<dt><span class="label label-info">;</span></dt>
		<dd>- <?php echo $text_common_param_setting_descrip_18; ?></dd>
		<dt><span class="label label-info">to buy</span></dt>
		<dd>- <?php echo $text_common_param_setting_descrip_19; ?></dd>
		<dt><span class="label label-info">#</span></dt>
		<dd>- <?php echo $text_common_param_setting_descrip_20; ?></dd>
	</dl>
	<?php echo $text_common_param_setting_descrip_21; ?>
	</div>
	<p class="lead clearfix">
	<img class="img-polaroid img-rounded pull-left" src="view/stylesheet/superseobox/images/param_descrip/param_structura.jpg" style="margin-right:20px;">
	<?php echo $text_common_param_setting_descrip_22; ?>
	<a data-dismiss="modal" href="<?php echo $urls['param_descrip']; ?>" class="info_tab_button btn btn-info" type="button" data-toggle="modal"><i class="icon-info-sign"></i> <?php echo $text_common_param_setting_descrip_23; ?></a>
	</p>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_close; ?></button>
  </div>