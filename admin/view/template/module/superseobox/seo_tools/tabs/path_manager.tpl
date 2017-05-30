<div class="pull-left form-horizontal" style="margin-right:25px;">
	<div class="control-group">
		<form>
				<label class="control-label" style="width: 138px;"><?php echo $text_common_path_manager_1; ?> &nbsp;</label>
				<?php $mode = $data['tools']['path_manager']['data']['product']['mode']; ?>
				<div class="input-prepend input-append">
					<select style="margin-bottom:5px;" name="data[tools][path_manager][data][product][mode]">
					<?php $mode_list = array("direct","shortest","longest","last_category","first_category","default");
					foreach($mode_list as $mode_type){?>
						<option value="<?php echo $mode_type; ?>" <?php if($mode == $mode_type) echo 'selected="selected"'; ?> ><?php echo ${'text_common_'.$mode_type}; ?></option>
					<?php }	?>
					</select>
					<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('select')" class="btn ajax_action btn-success" type="button">Save</a>
				</div>				
		</form>
	</div>
	
	<div class="control-group">
		<form>
				<label class="control-label" style="width: 138px;"><?php echo $text_common_path_manager_2; ?> &nbsp;</label>
				<?php $mode = $data['tools']['path_manager']['data']['category']['mode']; ?>
				<div class="input-prepend input-append">
					<select style="margin-bottom:5px;" name="data[tools][path_manager][data][category][mode]">
					<?php $mode_list = array("direct","full","default");
					foreach($mode_list as $mode_type){?>
						<option value="<?php echo $mode_type; ?>" <?php if($mode == $mode_type) echo 'selected="selected"'; ?> ><?php echo ${'text_common_'.$mode_type}; ?></option>
					<?php }	?>
					</select>
					<a data-afteraction="afterAction" data-action="save" data-scope=".parent().find('select')" class="btn ajax_action btn-success" type="button">Save</a>
				</div>	
		</form>
	</div>
</div>
<p class="colorFC580B">
	<?php echo $text_common_seo_must_turn_on; ?>
</p>
<h5><?php echo $text_common_path_manager_3; ?>:
<ul class="pull-right" style="margin-right: 400px;">
	<?php echo $text_common_path_manager_4; ?>
</ul>

<p style="clear: both;"><?php echo $text_common_path_manager_5; ?><br> 
<span style="font-weight:bold;"><?php echo $text_common_path_manager_6; ?></span></p>

<h4><?php echo $text_common_path_manager_7; ?>:</h4>
<dl>
	<dt><?php echo $text_common_direct; ?></dt>
	<dd>
		<?php echo $text_common_path_manager_8; ?>:
		<pre>www.site.com/product_name.html</pre>
	</dd>
	<dt><?php echo $text_common_shortest; ?></dt>
	<dd>
		<?php echo $text_common_path_manager_9; ?>:
		<pre>www.site.com/category_X/subcategory_Y/product_name.html
www.site.com/category_Z/product_name.html</pre>
		<?php echo $text_common_path_manager_10; ?>  <pre>www.site.com/category_Z/product_name.html</pre>
	</dd>
	<dt><?php echo $text_common_longest; ?></dt>
	<dd>
		<?php echo $text_common_path_manager_11; ?>:
		<pre>www.site.com/category_X/subcategory_Y/product_name.html
www.site.com/category_Z/product_name.html</pre>
		<?php echo $text_common_path_manager_12; ?>  <pre>www.site.com/category_X/subcategory_Y/product_name.html</pre>
	</dd>
	<dt><?php echo $text_common_last_category; ?> (only for products)</dt>
	<dd>
		<?php echo $text_common_path_manager_121; ?>
		<pre>category_X/categoty_Y/category_Z/product_name.html</pre>
		<?php echo $text_common_path_manager_122; ?>
		<pre>www.site.com/category_Z/product_name.html</pre>
	</dd>
	<dt><?php echo $text_common_first_category; ?> (only for products)</dt>
	<dd>
		<?php echo $text_common_path_manager_123; ?>
		<pre>category_X/categoty_Y/category_Z/product_name.html</pre>
		<?php echo $text_common_path_manager_122; ?>
		<pre>www.site.com/category_X/product_name.html</pre>
	</dd>
	<dt><?php echo $text_common_full; ?> (only for categories)</dt>
	<dd>
		<?php echo $text_common_path_manager_13; ?>:
		<pre>www.site.com/category_X/subcategory_Y/subcategory_Z
www.site.com/category_Z</pre>
		,<?php echo $text_common_path_manager_14; ?>  <pre>www.site.com/category_X/subcategory_Y/subcategory_Z</pre>
	</dd>
	<dt><?php echo $text_common_default; ?></dt>
	<dd>
		<?php echo $text_common_path_manager_15; ?>
	</dd>
</dl>