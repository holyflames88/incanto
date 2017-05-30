<!-- MODAL PARAMETERS DESCRIPTION !-->
<div id="modal-info_tab-generate" class=" modal-absolute width_95 modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-info_tab-generateLabel" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3 id="modal-info_tab-generateLabel">Parameters description</h3>
  </div>
  <div class="modal-body">
	<p class="lead">
	SEO generator use a parameters which allow you to construct specific phrases (templates) for generate SEO text.
	</p>
    <p class="lead clearfix">
	<img class="img-polaroid img-rounded pull-left" src="view/stylesheet/superseobox/images/param_descrip/param_structura.jpg" style="margin-right:20px;">
	Here you can see common structure of parameter, which you can use in template.
	<a data-dismiss="modal" href="#modal-info_tab-generate-dasp" class="info_tab_button btn btn-info" type="button" data-toggle="modal"><i class="icon-info-sign"></i> Click here to see additional settings description</a>
	</p>
	</br>
	<h3 style="text-align:left;"> Below, you can see description of all parameters, just click on its name </h3>
	<ul class="nav nav-tabs">
		<?php $i_nav_param_descrip = 1; foreach ($patterns as $key => $val) { ?>
			<li <?php if($i_nav_param_descrip ==1) echo  "class=\"active\"";?> ><a href="#descrip-<?php echo $key; ?>" data-toggle="tab">!<?php echo $key; ?></a></li>
		<?php $i_nav_param_descrip++; } ?>
	</ul>
	
	<div class="tab-content">
		<?php $i_nav_param_descrip = 1; foreach ($patterns as $key => $val) { ?>
			<div class="tab-pane <?php if($i_nav_param_descrip ==1) echo  "active";?>" id="descrip-<?php echo $key; ?>">
				<h3 style="text-align:left;"><?php echo $val['name']; ?></h3>
				<?php if(isset($val['descrip'])) {?>
					<p class="lead" ><?php echo $val['descrip']; ?></p>
				<?php } ?>
				<?php if(isset($val['images'])) {
					foreach ($val['images'] as $image) {?>
						<img class="pull-left" src="view/stylesheet/superseobox/images/param_descrip/<?php echo $image['file'] ?>" class="">
						<p class="clearfix lead" ><?php echo $image['text'] ?></p>
				<?php }} ?>
			</div>
		<?php $i_nav_param_descrip++; } ?>
	</div>	
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>


<!-- MODAL DESCRIPTION OF ADDITIONAL SETTINGS FOR PARAMETERS (dasp) !-->
<div id="modal-info_tab-generate-dasp" class=" modal-absolute width_95 modal hide fade" tabindex="-1" role="dialog" aria-labelledby="modal-info_tab-generate-dasp-label" aria-hidden="true">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
    <h3 id="modal-info_tab-generate-dasp-label">Additional settings description</h3>
  </div>
  <div class="modal-body">
	<p class="lead">
	Some of the parameters has additional settings, which give us more flexibility in writing SEO templates.
	</p>
	
	<p class="lead clearfix">
	<img class="img-polaroid img-rounded pull-left" src="view/stylesheet/superseobox/images/param_descrip/param_structura.jpg" style="margin-right:20px;">
	Here you can see common structure of parameter, which you can use in template.
	<a data-dismiss="modal" href="#modal-info_tab-generate" class="info_tab_button btn btn-info" type="button" data-toggle="modal"><i class="icon-info-sign"></i> Click here to see parameters description</a>
	</p>
	</br>
	<h3 style="text-align:left;"> Table of additional settings (here you can see where and what additional settings possible to write) </h3>

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
		<td>Product</td>
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
		<td>Category</td>
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
		<td>Brand</td>
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
		<td>Info</td>
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
	Every additional settings must be put in brackets after name of parameters, without any spaces</br>
	Notations:
	<dl class="dl-horizontal">
		<dt>Nt</dt>
		<dd>- total number of items to writing <span class="colorFC580B">(max: 9)</span></dd>
		<dt>Ns</dt>
		<dd>- total number of sentences to writing <span class="colorFC580B">(max: 9)</span></dd>
		<dt>Pn</dt>
		<dd>- punctuation between items <span class="colorFC580B">(any character except #)</span></dd>
		<dt>Tb</dt>
		<dd>- text before every items <span class="colorFC580B">(any text, which not include char #)</span></dd>
		<dt>#</dt>
		<dd>- delimiter between settings</dd>
		<dt>...</dt>
		<dd>- not using</dd>
	</dl>
	</div>
	
	<div class="lead"><h4>Example: write parameter with additional setting "#ep"(example products)</h4> 
	<span class="label label-info">!ep(3 #; # to buy ) </span>, where </br>
	<dl class="dl-horizontal">
		<dt><span class="label label-info">3</span></dt>
		<dd>- total number of example products</dd>
		<dt><span class="label label-info">;</span></dt>
		<dd>- punctuation between products</dd>
		<dt><span class="label label-info">to buy</span></dt>
		<dd>- text before every products names</dd>
		<dt><span class="label label-info">#</span></dt>
		<dd>- delimiter between settings</dd>
	</dl>
	and this template will generate next text: <span class="color08c">"to buy Product1; to buy Product2; to buy Product3;". </span></br>
	If you will write this parameter for categories template -  examples of products will be get from every category.
	If you will write this parameter for brands template -  examples of products will be get from every brand. 
	</div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
  </div>
</div>
