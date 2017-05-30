<h2><?php echo $text_common_edit_seo_items; ?></h2>

<div class="tabbable seo_edit_global_area">
	<ul class="nav nav-tabs ajax-tabs-content" data-function="seoEditContainer.getData" style="background: white;">
		<?php $i_tab = 1; foreach ($CPBI_keys as $index => $key) { ?>
			<li <?php if($i_tab ==1) echo  "class=\"active\"";?> >
				
				<a data-href="<?php echo $urls['ajax'].'&metaData[action]=getGenEditorContent&data[type]='.$key; ?>" href="#seo_edit_<?php echo $key; ?>" data-toggle="tab" ><?php echo ${'text_entity_name_'.$key}; ?></a>
				
			</li>
		<?php $i_tab++; } ?>
		<!--
		<li>
			<?php $key = 'home'; ?>
			<a data-href="<?php echo $urls['ajax'].'&metaData[action]=getGenEditorContent&data[type]='.$key; ?>" href="#seo_edit_<?php echo $key; ?>" data-toggle="tab" >Home</a>
			
		</li>
		!-->
		<li>
			<?php $key = 'standardPage'; ?>
			<a data-href="<?php echo $urls['ajax'].'&metaData[action]=getGenEditorContent&data[type]='.$key; ?>" href="#seo_edit_<?php echo $key; ?>" data-toggle="tab" ><?php echo $text_common_common_pages; ?></a>
			
		</li>
	</ul>
	
	<div class="tab-content">
		<?php $i_pan = 1; foreach ($CPBI_keys as $index => $key) { $type = $key; ?>
		<div class="tab-pane <?php if($i_pan ==1) echo  "active";?>" id="seo_edit_<?php echo $key; ?>">
			
		</div>
		<?php $i_pan++; } ?>
		<!--
		<?php $key = 'home'; ?>
		<div class="tab-pane" id="seo_edit_<?php echo $key; ?>">
			
		</div>
		!-->
		<?php $key = 'standardPage'; ?>
		<div class="tab-pane" id="seo_edit_<?php echo $key; ?>">
			
		</div>
	</div>
</div>

<script>
jQuery(document).ready(function() {

});

var seoEditContainer = {
	init: function($self, $container){
		seoEditContainer.setPagin($self, $container);

		seoEditContainer.initChangeLang($self);

		seoEditContainer.editableInit($self);
		
		//reload every time when you enter in the seo edit area
		$('a[href=#seo_edit]').click(function(){
			var $active_tab = $('.nav-tabs.ajax-tabs-content li.active a');
			var $container_ = $($active_tab.attr("href"));
			seoEditContainer.getData($container_, $active_tab.attr('data-href'));
			
		});
	},

	getData : function($container, url){
		//$container.html('').data('');
		$container.html('Please wait ...').data('');
		$container.load(url, function(data) {
			$self = $(this);
			
			seoEditContainer.init($self, $container);
				
				
				
			/*	*/
			$self.find('.btn').click(function(){
				PSBeng.action($(this));
			});//=========
			$('#seo_edit .seo-edit-related a').click(function(){
				$(this).parent().remove();
			});//=========
			$('.seo-edit-list-all').click(function(){
				var $container = $(this).closest('.tab-pane.active');
				var url = $(this).attr('data-href');
				seoEditContainer.getData($container, url);
			});//=========
			$('.seo-edit-list-search').click(function(){
				var search_string = $(this).parent().find('input').val();
				var $container = $(this).closest('.tab-pane.active');
				var type = $(this).attr('data-type');
				var url = PSBdat.url.ajax;
				url += '&metaData[action]=getGenEditorContent&data[type]=' + type + '&data[filter_name]=' + search_string;
				seoEditContainer.getData($container, url);
			});//=========
			
			//PSBeng.data.ajaxBlock = true;
		});
	},
	
	setPagin : function($self, $container){
		var $links = $self.find('.links, .pagination');
		console.log($links.html());
		if($links.length){
			$links.removeClass('pagination');
			$links.parent().addClass('pagination');		
			
			$links.find('a').each(function(){
				var href = $(this).attr('href');
				$(this).attr('data-href', href);
				$(this).removeAttr('href');
			});

			$links.find('a').click(function(){
				var $container = $(this).closest('.tab-pane.active');
				var $activ_lang_a = $(this).closest('.seo_edit_global_area').find('.tab-pane.active .change_lang li.active a');
				//alert($activ_lang_a.html())
				var need_language_id = $activ_lang_a.attr('data-language_id');
				//alert(need_language_id);
				var url = $(this).attr('data-href') + '&data[need_language_id]=' + need_language_id;
				seoEditContainer.getData($container, url);
			});
		}
	},
	
	initChangeLang : function($self){
		$self.find('.nav-pills.change_lang a').click(function(){
				
				$(this).closest('.nav-pills').find('li').removeClass('active');
				$(this).parent().addClass('active');
				
				var $activ_tab_a = $(this).closest('.seo_edit_global_area').find('.ajax-tabs-content li.active a');
			
				var need_language_id = $(this).attr('data-language_id');
				
				var $container = $($activ_tab_a.attr('href'));
				
				var url = $activ_tab_a.attr('data-href') + '&data[need_language_id]=' + need_language_id;

				seoEditContainer.getData($container, url);
			});
	},
	
	editableInit : function($self){
				
		$self.find('.editable').on('shown', function(e, editable) {
		});

		$self.find('.editable').editable({
			url: '<?php echo htmlspecialchars_decode($urls['seo_edit_save']); ?>',
			mode: 'popup',
			emptyclass:'customEmptyClass',
			emptytext: 'Add',
			inputclass:'span4',
			display: function(value, sourceData) {
			   var value = String(value)
			   if(typeof value  !== "undefined"){
					var value = value.substr(0, 140);
					$(this).html(value);
			   }else{
				   $(this).empty(); 
			   }
						   
			}
			//showbuttons: false
		});
		
	}
};
</script>

<style>
.seo_edit-id{
	width:50px;
}
.seo_edit-id .input-prepend {
	margin-bottom: 0px;
}
.editable{
	text-decoration:none!important;
}
.seo_edit_global_area tbody td .customEmptyClass{
	color: #57ADD8!important;
	border-bottom: dashed 1px #BEBEBE!important;
}

.seo_edit_global_area thead th{
	text-align: center;
	background: #ECEBEB;
}
.seo_edit_global_area .table td, .seo_edit_global_area .table th{
	vertical-align: middle;
	text-align: center;
}
.seo_edit_global_area tbody tr {
	height: 120px;
}

.seo_edit_global_area tbody td * {
	color: #333;
}
.seo_edit_global_area tbody td a {
	border-bottom: 0px!important;
}

.seo_edit_global_area .normal_height tbody tr {
	height: 40px;
}
.seo_edit_global_area textarea, .seo_edit_global_area iframe{
	height: 300px;
}
</style>
