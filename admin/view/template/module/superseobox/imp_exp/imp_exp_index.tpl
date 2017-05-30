<div id="imp_exp_forms">
	<form method="post" class="ls-box ls-import-box">
		<h2 class="header"><?php echo $text_import_ss; ?></h2>
		<div class="inner">
			<textarea class="span10 import_area" name="data[import]" rows="10" class="span10" ></textarea>
			<a data-afterAction="afterImport" data-action="newImport" data-scope=".closest('form').find('textarea')" class="btn ajax_action btn-success" type="button"><?php echo $text_import; ?></a>
		</div>
	</form>

	<div class="ls-box ls-import-box">
		<h4 class="header"><?php echo $text_export_ss; ?></h4>
		<div class="inner">
			<textarea class="span10 export_area" rows="10" class="span10" readonly="readonly"></textarea>
			<a data-afterAction="afterExport" data-action="newExport" data-scope=".closest('form').find('textarea')" class="btn ajax_action btn-success" type="button"><?php echo $text_get_setting; ?></a>
			<p><?php echo $text_export_import_info; ?></p>
		</div>
	</div>
</div>