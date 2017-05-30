<?php echo $header; ?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>

  <div style="border-bottom: 1px solid #DDD; background-color: #EFEFEF; height: 40px; min-width: 900px; overflow: hidden;">
    <div style="float:left; margin-top: 10px;" >
    <img src="view/image/langmark-icon.png" style="height: 21px; margin-left: 10px; " >
    </div>

<div style="margin-left: 10px; float:left; font-size: 16px; margin-top: 10px;">
<ins style="color: green; padding-top: 17px; text-shadow: 0 2px 1px #FFFFFF; padding-left: 3px; font-size: 17px; font-weight: bold;  text-decoration: none; ">
<?php echo strip_tags($heading_title); ?></ins> ver.: <?php echo $langmark_version; ?>
</div>

    <div style=" height: 40px; float:right; background:#aceead;">
	   <div style="margin-top: 2px; line-height: 18px; margin-left: 9px; margin-right: 9px; font-size: 13px; overflow: hidden;"><?php echo $this->language->get('heading_dev'); ?></div>
    </div>


</div>

<div id="content" style="border: none;">

<div style="clear: both; line-height: 1px; font-size: 1px;"></div>


<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<?php if (isset($this->session->data['success'])) {unset($this->session->data['success']);
?>
<div class="success"><?php echo $this->language->get('text_success'); ?></div>
<?php } ?>


<div class="box1">

<div class="content">

<div style=" margin-left: 0px;">
<div style="margin-right:5px; margin-left: 0px; float:left;">
<a href="<?php echo $url_options; ?>" class="markbutton"><div style="float: left;"><img src="view/image/agoodonut-options-m.png"  style="" ></div>
<div style="float: left; margin-left: 7px; margin-top: 4px; "><?php echo $this->language->get('tab_options'); ?></div></a>
</div>


<div style="margin-right:5px; float:left;">
<a href="<?php echo $url_schemes; ?>" class="markbutton"><div style="float: left;"><img src="view/image/agoodonut-schemes-m.png"  style="" ></div>
<div style="float: left; margin-left: 7px; margin-top: 4px; "><?php echo $tab_general; ?></div></a>
</div>

<div style="margin-right:5px; float:left;">
<a href="<?php echo $url_widgets; ?>" class="markbutton-active"><div style="float: left;"><img src="view/image/agoodonut-widgets-m.png"  style="" ></div>
<div style="float: left; margin-left: 7px; margin-top: 4px; "><?php echo $tab_list; ?></div></a>
</div>

<div style="margin-right:5px;  float:left;">
<a href="<?php echo $url_modules; ?>" class="markbutton"><div style="float: left;"><img src="view/image/agoodonut-back-m.png"  style="" ></div>
<div style="float: left; margin-left: 7px; margin-top: 4px; "><?php echo $url_modules_text; ?></div></a>
</div>


</div>

<div style="margin-right:5px; float:right;">
   <a href="#" class="mbutton langmark_save"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="mbutton"><?php echo $button_cancel; ?></a>
</div>

<div style=" clear: both; line-height: 1px; font-size: 1px;"></div>

<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

<script type="text/javascript">
function delayer(){
    window.location = 'index.php?route=module/langmark/widgets&token=<?php echo $token; ?>';
}
</script>
<?php if (count($general_list)>0) { ?>
<div id="widgets_loading" style="width: 100%; height: 24px; line-height: 24px;  background-color: #EEE; margin-bottom: 5px;">&nbsp;</div>
<?php } ?>

<div id="tab-list">
	<div id="lists">
		<div id="mytabs" class="vtabs" style="margin-top: 3px; padding-top: 0px;"><a href="#mytabs_add" style="color: #FFF; background: green; "><img src="view/image/madd.png" style="height: 16px; margin-right: 7px;" ><?php echo $this->language->get('text_add'); ?></a></div>


<div id="mytabs_add" >
<div style="padding-top: 10%; padding-left: 30%;">
<div style="float: left; ">
<?php   echo $this->language->get('type_list');  ?>

         <select id="general_list-what"  name="general_list-what">
                <option value="html"><?php echo $this->language->get('text_widget_html'); ?></option>
         </select>
</div>

	<div class="buttons" style="margin-left: 10px; float: left;"><a onclick="
      general_list_num++;
      type_what = $('#general_list-what :selected').val();
       this_block_html = $('#mytabs_add').html();
 		$.ajax({
					url: 'index.php?route=module/langmark/ajax_list&token=<?php echo $token; ?>',
					type: 'post',
					data: { type: type_what, num: general_list_num },
					dataType: 'html',
					beforeSend: function()
					{
                     $('#mytabs_add').html('<?php echo $this->language->get('text_loading'); ?>');
					},
					success: function(html) {

					$('#mytabs_add').html(this_block_html);

						if (html) {
							$('#mytabs').append('<a href=\'#mytabs' + general_list_num + '\' id=\'amytabs'+general_list_num+'\'>List-' + general_list_num + '<\/a>');
							$('#lists').append('<div id=\'mytabs'+general_list_num+'\'>'+html+'<\/div>');
							$('#mytabs a').tabs();
							$('#amytabs' + general_list_num).click();
							template_auto();
							fields_auto();
						}
						$('.mbutton').removeClss();


					}
				});


      return false; " class="mbutton"><?php echo $this->language->get('button_add_list'); ?></a>
	</div>

 </div>

</div>

	</div>


	<script type="text/javascript">

	 form_submit = function() {

		$('#form').submit();
		return false;
	}
    $('#mytabs a').tabs();
	$('.langmark_save').bind('click', form_submit);
    </script>


	<?php

	if (count($general_list)>0)
	{
	reset($general_list);
	$first_key = key($general_list);

	$ki=0;
	foreach ($general_list as $num =>$list) {
	$ki++;
	$slist = serialize($list);

	if (isset($list['title_list_latest'][ $this->config->get('config_language_id')]) &&  $list['title_list_latest'][ $this->config->get('config_language_id')]!='')
	{
     $title=$list['title_list_latest'][ $this->config->get('config_language_id')];
	}
	else
	{	 $title="List-".$num;
	}


	?>

   <script>
	var general_list_num=<?php echo $num; ?>;

	$('#mytabs').append('<a href=\"#mytabs<?php echo $num; ?>\" id=\"amytabs<?php echo $num; ?>\"><?php echo $title; ?><\/a>');

    var progress_num = 0;
    var allcount = <?php echo (count($general_list)); ?>;

		$.ajax({
					url: 'index.php?route=module/langmark/ajax_list&token=<?php echo $token; ?>',
					type: 'post',
					async: true,
					data: { list: '<?php echo base64_encode($slist); ?>', num: '<?php echo $num; ?>' },
					dataType: 'html',
					beforeSend: function() {
					 $('a.mbutton').addClass('loader');
					 $('.langmark_save').unbind('click');


					},
					success: function(html) {
						if (html) {							$('#lists').append('<div id=\"mytabs<?php echo $num; ?>\">'+html+'<\/div>');
							$('#mytabs a').tabs();
							$('#amytabs<?php echo $first_key; ?>').click();
							template_auto();

						}
						<?php if (count($general_list)<=$ki) {  ?>
						$('a.mbutton').removeClass('loader');
						$('.langmark_save').bind('click', form_submit);
						$('#widgets_loading').hide();
						<?php } ?>

						<?php
						$loading_recent = round((100*$num)/count($general_list));
						?>
						progress_num++;
						loading_recent = Math.round((100*progress_num)/allcount);

                        $('#widgets_loading').html('<div style=\"height: 24px; line-height: 24px; text-align: center; width:'+loading_recent+'%; color: white;background-color: orange;\">'+loading_recent+'%<\/div>');

					}
				});

		</script>
	<?php

	 }



	}
	else
	{     ?>
     	<script type="text/javascript">
	var general_list_num=0;
        </script>
     <?php
	} ?>

</div>
</div>

    </form>
     <div style="clear: both; line-height: 1px; font-size: 1px;"></div>
      <div class="buttons right" style="margin-top: 20px;float: right;"><a href="#" class="mbutton langmark_save"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="mbutton"><?php echo $button_cancel; ?></a></div>

  </div>

  </div>
</div>

<script>
template_auto = function() {	$('.template').each(function() {

		var e = this;
		var path = $(e).next().attr('value');
		var list = $(e).next().next().attr('value');
		var iname = $(e).attr('name');

		$(e).autocomplete({
			delay: 0,
            autoFocus: true,
            minLength: 0,
			source: function(request, response) {

				$.ajax({
					url: 'index.php?route=module/langmark/autocomplete_template&path='+path+'&token=<?php echo $token; ?>',
					dataType: 'json',
					success: function(json) {
						response($.map(json, function(item) {
							return {
								label: item.name + ' > ' + path + '/' + item.name,
								value: item.name
							}
						}));
					}
				});

			},
			select: function(event, ui) {


			$('input[name=\''+ iname +'\']').val(ui.item.value);
			return false;
			}
		});

	});
}
</script>



</div>

<?php echo $footer; ?>