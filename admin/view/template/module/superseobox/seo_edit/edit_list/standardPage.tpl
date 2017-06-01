<?php 
	$type = 'standardPage';
	$seo_edit_metadata = array(
		array('table' => 'url_alias','col' => 'query', 'data_name' => 'query', 'type' => 'text'),
		array('table' => 'url_alias','col' => 'keyword', 'data_name' => 'keyword' , 'type' => 'text')
	);
	$th_name = $text_common_se_stand_page_1;
?>

<div class="control-group">
	<div class="controls btn-group pull-right">
		<a class="btn addNewRow btn-success"><?php echo $text_common_se_add; ?></a>
		<a class="btn delRows btn-danger"><?php echo $text_common_delete; ?></a>
	</div>
</div>

<!-- multilanguage for standard urls !-->
<div>
<ul class="nav nav-pills change_lang">
<li style="margin-top: 10px;"><?php echo $text_common_choose_language; ?>:&nbsp;</li>
<?php foreach ($languages_array as $lang_id => $language){ if(!$language['status'])continue; ?>
	
	<li <?php if($lang_default == $language['code']) echo  "class=\"active\"";?>>
		<a data-language_id = "<?php echo$lang_id; ?>" data-code-id="<?php echo$lang_id; ?>" data-code="<?php echo $language['code'] ?>" data-code-class="lang-<?php echo $language['code'] ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> - <?php echo $language['name']; ?></a>
	</li>
<?php } ?>
</ul>
</div>
<!-- multilanguage for standard urls !-->




<table class="table table-condensed table-hover table-bordered normal_height">
	<thead>
		<tr>
		   <th>#</th>
		  <?php foreach ($th_name as $th) { ?> 
		  <th><?php echo $th; ?></th>
		  <?php } ?>
		</tr>
	</thead>
	<tbody>
	<?php $i_tr = 1; foreach ($content['content'] as $item_id => $cont_data) { ?> 
		<tr>
			<td>
			<input type="checkbox" value="<?php echo $item_id; ?>" name="del_array[]">
			</td>
		  <?php 
			foreach($seo_edit_metadata as $sei) { 
				$data_type = isset($sei['type']) ? $sei['type'] : 'textarea';
				$wysihtml5 = $data_type == 'wysihtml5' ? ' data-inputclass="span8"' : '';
				$placement = isset($sei['placement']) ? $sei['placement'] : 'top';
		  ?>
			<td>
				<?php foreach ($languages_array as $lang_id => $language){ 
					if(!$language['status']){continue;}
					$data = isset($cont_data['data'][$lang_id][$sei['data_name']]) ? $cont_data['data'][$lang_id][$sei['data_name']] : '';
					$l_code = $languages_array[$lang_id]['code'];
				?>
					<div class="<?php if($lang_default != $l_code) echo  "hide"; ?> lang_container lang-<?php echo $l_code; ?>">
						<a <?php echo $wysihtml5; ?> data-placement="<?php echo $placement; ?>" class="editable" data-type="<?php echo $data_type; ?>" data-pk="{id:<?php echo $item_id; ?>, lang_id: '<?php echo $lang_id; ?>', col:'<?php echo $sei['col']; ?>', type:'<?php echo $type; ?>'}" data-html="true" data-name="<?php echo $sei['table']; ?>" data-value="<?php echo $data; ?>"><?php echo $data; ?></a>
					</div>
				<?php } ?>
			</td>
		  <?php } ?>
		</tr>
	<?php $i_tr++; } ?>	
	</tbody>
</table>
<script>
	$('.delRows').click(function(){
		var $checked = $(this).closest('.tab-pane').find('table input[type=checkbox]:checked');
		if($checked){
			$.ajax({
				url: '<?php echo htmlspecialchars_decode($urls['seo_edit_save']); ?>',
				dataType: 'json',
				type : 'POST',
				data : $checked,
				success : function(data) {
					$checked.each(function(){
						$(this).closest('tr').remove();
					});						
				}
			});
		}
	});

	$('.addNewRow').click(function(){
		var lang_code = $(this).closest('.tab-pane.active').find('.change_lang .active a').attr('data-code');
		var lang_id = $(this).closest('.tab-pane.active').find('.change_lang .active a').attr('data-code-id');
		
		var divs_1 = '';
		var divs_2 = '';
		$(this).closest('.tab-pane.active').find('.change_lang a').each(function(){
			if(lang_id != $(this).attr('data-code-id')){
				var temp_code = $(this).attr('data-code');
				var temp_id = $(this).attr('data-code-id');
				
				var a_s1 = '<a data-placement="top" class="editable editable-click" data-type="text" data-pk="{id:\'\', lang_id: '+ temp_id +', col:\'query\', type:\'standardPage\'}" data-html="true" data-name="url_alias" data-value=""></a>';
				
				var a_s2 = '<a data-placement="top" class="editable editable-click" data-type="text" data-pk="{id:\'\', lang_id: '+ temp_id +', col:\'keyword\', type:\'standardPage\'}" data-html="true" data-name="url_alias" data-value=""></a>';
				
				var div_s1 = '<div class="lang_container lang-'+ temp_code +' hide">'+ a_s1 +'</div>';
				var div_s2 = '<div class="lang_container lang-'+ temp_code +' hide">'+ a_s2 +'</div>';
				divs_1 += div_s1;
				divs_2 += div_s2;
			}
			
		});
		
		var a1 = '<a data-placement="top" class="editable editable-click" data-type="text" data-pk="{id:\'\', lang_id: '+ lang_id +', col:\'query\', type:\'standardPage\'}" data-html="true" data-name="url_alias" data-value=""></a>';
		var a2 = '<a data-placement="top" class="editable editable-click" data-type="text" data-pk="{id:\'\', lang_id: '+ lang_id +', col:\'keyword\', type:\'standardPage\'}" data-html="true" data-name="url_alias" data-value=""></a>';
		
		var div1 = '<div class="lang_container lang-'+ lang_code +'">'+ a1 +'</div>';
		var div2 = '<div class="lang_container lang-'+ lang_code +'">'+ a2 +'</div>';
		
		var tr = '<tr><td><input type="checkbox" value="" name="del_array[]"></td><td>'+ div1 + divs_1 +'</td><td>'+ div2 + divs_2 +'</td></tr>';
		
		$(this).closest('.tab-pane').find('table tbody').prepend(tr);
		
		$(this).closest('.tab-pane').find('table tbody tr:first').find('.editable').editable({
			url: '<?php echo htmlspecialchars_decode($urls['seo_edit_save']); ?>',
			mode: 'popup',
			emptyclass:'customEmptyClass',
			emptytext: 'Add',
			inputclass:'span4',
			display: function(value, sourceData) {
			   if(typeof sourceData  !== "undefined"){
					var $a = $(this).closest('tr').find('td a');
					$(this).closest('tr').find('input[type=checkbox]').val(sourceData);
					$a.each(function(){
						var pk = $(this).attr('data-pk');
						pk = pk.replace("id:''", "id:'"+ sourceData +"'");
						$(this).editable('option', 'pk', pk);	
					});
					
					
			   }
			   var value = String(value)
			   if(typeof value  !== "undefined"){
					var value = value.substr(0, 140);
					$(this).html(value);
			   }else{
				   $(this).empty(); 
			   }
						   
			}
		});
	});
</script>