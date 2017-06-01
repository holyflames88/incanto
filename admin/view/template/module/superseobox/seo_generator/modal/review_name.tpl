<!-- MODAL PARAMETERS DESCRIPTION !-->
  <?php
	$review_name = $content['names'];
	$pagination = $content['pagination'];
  ?>
  
  <div class="modal-header clearfix">
   <h4><?php echo $text_common_reviewname_1; ?></h4>
   <button type="button" class="close" data-dismiss="modal" aria-hidden="true">x</button>
   
    <div style="margin-left: 20px;" class="btn-group pull-left">
		<a class="btn dropdown-toggle" data-toggle="dropdown"><?php echo $text_common_setting_low; ?></a>
		<button class="btn dropdown-toggle" data-toggle="dropdown">
			<span class="caret"></span>
		</button>
		<ul class="dropdown-menu">
			<li><a class="btn btn-nonstyle bg_red" data-action="deleteAllRewievItem" data-data="review_name" data-afteraction="refreshReviewTable"><?php echo $text_common_reviewname_2; ?></a></li>
			<li><a class="btn btn-nonstyle" data-action="restoreAllRewievItem" data-data="review_name" data-afteraction="refreshReviewTable"><?php echo $text_common_reviewname_3; ?></a></li>
		</ul>
	</div>
	
	<div style="margin-right: 20px;" class="btn-group pull-right">
		<a class="add-header btn btn-success"><?php echo $text_common_add_row; ?></a>
		<a data-entity="reviews-product" data-jsbeforeaction="prepareRecive();" data-afteraction="afterAction" data-action="saveReviewName" data-scope=".closest('.ajax_modal').find('input[type=text]').not('.stamp')" class="btn  ajax_action" type="button"><?php echo $text_common_save; ?></a>
		<a data-entity="reviews-product" data-jsbeforeaction="prepareDelete();" data-afteraction="afterAction" data-action="deleteReviewName" data-scope=".closest('.ajax_modal').find('input[type=checkbox]:checked').closest('tr').find('input[type=text]')" class="btn btn-danger ajax_action" type="button"><?php echo $text_common_delete; ?></a>
	</div>

	<form class="form-horizontal" style="float: right;margin: 5px 44px 5px 0;clear: both;">
		<div class="control-group" style="margin-bottom: -15px;">
			<label class="control-label" style="padding-top: 3px;"><?php echo $text_common_select_all; ?></label>
			<div class="controls">
				<input class="review-element-select" type="checkbox">
			</div>
		</div>
	</form>
	
  </div>

  <div class="modal-body review-tables">
	<td class="info_text">
		<dl>
			<dt><?php echo $text_common_reviewname_5; ?>:</dt>
			<dd class="info-area">
				<?php echo $text_common_reviewname_6; ?>
			</dd>
		</dl>
	</td>
  	<div class="tabbable "> 
		<ul class="nav nav-tabs">
			
			<?php $i_nav_param_descrip = 1; foreach ($review_name as $l_code => $l_data) { 
				if(!isset($languages[$l_code]))continue;
			?>
				<li <?php if($i_nav_param_descrip ==1) echo  "class=\"active\"";?> ><a href="#r_name-<?php echo $l_code; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $languages[$l_code]['image']; ?>" title="<?php echo $languages[$l_code]['name']; ?>" /> <?php echo $languages[$l_code]['name']; ?></a></li>
			<?php $i_nav_param_descrip++; } ?>
		</ul>
		
		<div class="tab-content">
			<?php $i_nav_param_descrip = 1; foreach ($review_name as $l_code => $l_data) { 
				if(!isset($languages[$l_code]))continue;
			?>
				<div class="tab-pane <?php if($i_nav_param_descrip ==1) echo  "active";?>" id="r_name-<?php echo $l_code; ?>" data-code="<?php echo $l_code; ?>">
					
					<?php include 'review_name_list.tpl';?>
					
				</div>
			<?php $i_nav_param_descrip++; } ?>
		</div>	
	</div>
  </div>
  <div class="modal-footer">
    <button class="btn" data-dismiss="modal" aria-hidden="true"><?php echo $text_common_close; ?></button>
  </div>
  
<script>
GenReview = {
	init: function(){
		$('.add-header').click(function(){
			var $self = $(this);
			setTimeout(function(){
				$self.closest('.modal').find('.review-id:first').html('');
			}, 300);
		});
	
		$('.review-element-select').click(function(){
			$(this).closest('.modal').find('.modal-body input[type=checkbox]').attr('checked', this.checked);
		});
		GenReview.setPagin();
	},
	
	setPagin : function(){
		var $links = $('.review-tables').find('.links, .pagination');
		
		$links.removeClass('pagination');
		$links.parent().addClass('pagination');

		$links.find('a').each(function(){
			var href = $(this).attr('href');
			$(this).attr('data-href', href);
			$(this).removeAttr('href');
		});

		$links.find('a').click(function(){
			var $container = $(this).closest('.tab-pane.active');
			GenReview.getnewPage($container, $(this).attr('data-href'));
		});
	},
	
	getnewPage : function($container, url){
		$container.html('Please wait ...').data('');
		$container.load(url, function(data) {
			//alert($(this).html());
			GenReview.init();
			
			setTimeout(function(){
				$modal_grider = $('.review-tables .tab-pane.active .grider');
				$modal_grider.grider({countRow: true, countRowAdd: true});
			}, 500);

		});
	}
};

setTimeout(function(){
	GenReview.init();
},500);

setTimeout(function(){
	$('.review-tables').parent().find('.add-header').click(function(){
		$('.review-tables').find('.tab-pane.active .add').click();
	});
},500);

function prepareRecive(){
	var $input = $('.review-tables').find('.grider tbody td input[type=text]');
	$input.each(function(){
		var val = $(this).val();
		if(val == ''){
			$sibling_inputs = $(this).closest('tbody').find('td input[type=text]');
			if($sibling_inputs.length > 1){
				$(this).closest('tr').remove();
			}
		}
	});
	
	var $panels = $('.review-tables').find('.tab-pane');
	$panels.each(function(){
		$input = $(this).find('.grider tbody td input[type=text]');
		if($input.length){
			$(this).find('.parameter_empty').remove();
		}
	});
	
}

function prepareDelete(){
	setTimeout(
	function(){
		$('.review-tables .active').find('input[type=checkbox]:checked').closest('tr').find('a.delete').click();
		var $after_del_check = $('.review-tables .active').find('input[type=checkbox]:checked');
		if($after_del_check.length == 1){
			$after_del_check.attr('checked', false).closest('tr').find('input').val('');
			$('.modal .close').click();
			setTimeout(function(){
				$('.review_name_open').click();
			},200);
		}
	},800);
}
</script>
<style>
.modal-absolute.ajax_modal{
	width: 80%!important;
	margin-left: -40%!important;
}
.modal-absolute .review-tables{
	height: 500px!important;
	min-height: 500px!important;
}
.review-tables .delete, .review-tables caption{
	display:none;
}
.pagination {
	border-top: 0px!important;
	margin: 0px!important;
}

</style>
