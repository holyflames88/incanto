<div class="pull-left" style="margin-bottom:20px; margin-right:30px;">
<div class="control-group">
	<div class="controls">
		<?php 
		$additional_data = 'additionData[function]=setRedirect404Data';
		$review_url = $oc_data->url->link('module/superseobox/ajax', 'token=' . $oc_data->session->data['token'] . '&metaData[action]=getModal&data[m_name]=seo_tools/modal/redirect_404&'.$additional_data, 'SSL');
		?>
		
		<a style="color: #fff;" data-jsbeforeaction="$('body,html').stop(true,true).animate({'scrollTop':0},'slow');" href="<?php echo $review_url; ?>" class="btn btn-warning redirect_404_open" type="button" data-toggle="modal"><?php echo $text_common_404_manager_1; ?></a>
	</div>
</div>
</div>
<h3><?php echo $text_common_404_manager_2; ?></h3>
<p class="colorFC580B">
	<?php echo $text_common_seo_must_turn_on; ?>
</p>
<p><?php echo $text_common_404_manager_4; ?></p>
<p><?php echo $text_common_404_manager_5; ?>:</p>
<ul>
	<?php echo $text_common_404_manager_6; ?>
</ul>
<?php echo $text_common_404_manager_7; ?>