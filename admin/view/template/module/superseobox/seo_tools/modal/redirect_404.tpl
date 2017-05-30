<!-- MODAL PARAMETERS DESCRIPTION !-->
  <div class="modal-header clearfix">
   <h4><?php echo $text_common_tool_modal_redirect_404_1; ?></h4>
   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
	
	<div style="margin-left: 20px;" class="btn-group pull-left">
		<a class="btn dropdown-toggle" data-toggle="dropdown"><?php echo $text_common_setting_low; ?></a>
		<button class="btn dropdown-toggle" data-toggle="dropdown">
			<span class="caret"></span>
		</button>
		<ul class="dropdown-menu">
			<li><a class="btn btn-nonstyle bg_red" data-action="deleteAllUrl404" data-data="redirect_404" data-afteraction="refreshReviewTable"><?php echo $text_common_tool_modal_redirect_404_2; ?></a></li>
		</ul>
	</div>
	
	<div style="margin-right: 20px;" class="btn-group pull-right">
		<a class="add-header btn btn-success"><?php echo $text_common_add_row; ?></a>
		<a data-jsbeforeaction="prepareRecive();" data-afteraction="afterAction" data-action="saveUrl404" data-scope=".closest('.ajax_modal').find('input[type=text]').not('.stamp')" class="btn  ajax_action" type="button"><?php echo $text_common_save; ?></a>
		<a data-jsbeforeaction="prepareDelete();" data-afteraction="afterAction" data-action="deleteUrl404" data-scope=".closest('.ajax_modal').find('input[type=checkbox]:checked').closest('tr').find('.broken_url')" class="btn btn-danger ajax_action" type="button"><?php echo $text_common_delete; ?></a>
	</div>

	<form class="form-horizontal" style="float: right;margin: 5px 44px 5px 0;clear: both;">
		<div class="control-group" style="margin-bottom: -15px;">
			<label class="control-label" style="padding-top: 3px;"><?php echo $text_common_select_all; ?></label>
			<div class="controls">
				<input class="redirect_404-element-select" type="checkbox">
			</div>
		</div>
	</form>
	
  </div>

  <div class="modal-body redirect404-table">
		<?php include 'redirect_404_list.tpl';?>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_close; ?></button>
  </div>
  
<script>
redirect_404_table = {
	init: function(){
		$('.add-header').click(function(){
			var $self = $(this);
			setTimeout(function(){
				$self.closest('.modal').find('.hits_404:first').html('0');
			}, 300);
		});
	
		$('.redirect_404-element-select').click(function(){
			$(this).closest('.modal').find('.modal-body input[type=checkbox]').attr('checked', this.checked);
		});
		redirect_404_table.setPagin();
		
		$('.redirect404-table input[type=text]').live('focus', function(){
			var $input = $(this);
			var $inputs = $input.closest('.redirect404-table').find('input[type=text]');
			$inputs.removeClass('span6').addClass('span2');
			
			$inputs = $input.closest('.redirect404-table').find('input[data-header-class='+ $input.attr('data-header-class') +']');
			$inputs.removeClass('span2').addClass('span6');
			
			$('.redirect404-table th span.with-change').removeClass('span6').addClass('span2');
			$('.redirect404-table th span.' + $input.attr('data-header-class')).removeClass('span2').addClass('span6');
		});
	},
	
	setPagin : function(){
		var $links = $('.redirect404-table').find('.links, .pagination');

		if($links.length == 0){
			return false;
		}
		
		var l_passive = $links.find('b').html();

		$links.html($links.html().replace(/\.\.\.\./g,""));
		
		$links.addClass('pagination').html('<ul>' + $links.html() + '</ul>').find('a, b').wrap('<li>');

		$links.find('b').parent().addClass('active').html('<a>' + l_passive + '</a>');

		$links.find('a').each(function(){
			var href = $(this).attr('href');
			$(this).attr('data-href', href);
			$(this).removeAttr('href');
		});

		$links.find('a').click(function(){
			var $container = $(this).closest('.redirect404-table');
			redirect_404_table.getnewPage($container, $(this).attr('data-href'));
		});
	},
	
	getnewPage : function($container, url){
		$container.html('Please wait ...').data('');
		$container.load(url, function(data) {
			//alert($(this).html());
			redirect_404_table.init();
			
			setTimeout(function(){
				$modal_grider = $('.redirect404-table .grider');
				$modal_grider.grider({countRow: true, countRowAdd: true});
			}, 500);

		});
	}
}

setTimeout(function(){
	redirect_404_table.init();
},500);

setTimeout(function(){
	$('.redirect404-table').parent().find('.add-header').click(function(){
		$('.redirect404-table').find('.add').click();
	});
},500);

function prepareRecive(){
	var $input = $('.redirect404-table').find('.grider tbody td input.broken_url');
	$input.each(function(){
		var val = $(this).val();
		if(val == ''){
			$sibling_inputs = $(this).closest('tbody').find('td input[type=text]');
			if($sibling_inputs.length > 1){
				$(this).closest('tr').remove();
			}
		}
	});
	$input = $('.redirect404-table').find('.grider tbody td input.broken_url');
	if($input.length){
		$(this).find('.parameter_empty').remove();
	}
}

function prepareDelete(){
	setTimeout(
	function(){
		$('.redirect404-table').find('input[type=checkbox]:checked').closest('tr').find('a.delete').click();
		var $after_del_check = $('.redirect404-table').find('input[type=checkbox]:checked');
		if($after_del_check.length == 1){
			$after_del_check.attr('checked', false).closest('tr').find('input').val('');
			$after_del_check.attr('checked', false).closest('tr').find('.hits_404').html('0');
			//
		}
		setTimeout(function(){
			//$('.modal .close').click();
			//$('.redirect_404_open').click();
		},200);
	},400);
}
</script>
<style>
.modal-absolute.ajax_modal{
	width: 80%!important;
	margin-left: -40%!important;
}
.modal-absolute .redirect404-table{
	height: 500px!important;
	min-height: 500px!important;
}
.redirect404-table .delete, .redirect404-table caption{
	display:none;
}
.pagination {
	border-top: 0px!important;
	margin: 0px!important;
}
.redirect404-table th span{
margin-left: 2px;
}
</style>
