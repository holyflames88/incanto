<?php echo $header; ?>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script>

  <div style="border-bottom: 1px solid #DDD; background-color: #EFEFEF; height: 40px; min-width: 900px; overflow: hidden;">
    <div style="float:left; margin-top: 10px;" >
    <img src="view/image/langmark-icon.png" style="height: 21px; margin-left: 10px; " >
    </div>

<div style="margin-left: 10px; float:left; font-size: 16px; margin-top: 10px;">
<ins style="color: green; padding-top: 17px; text-shadow: 0 2px 1px #FFFFFF; padding-left: 3px; font-size: 17px; font-weight: bold;  text-decoration: none; ">
<?php echo strip_tags($heading_title); ?>
</ins> ver.: <?php echo $langmark_version; ?>
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

<div style="margin-left:0px;">
<div style="margin-right:5px;  float:left;">
<a href="<?php echo $url_options; ?>" class="markbutton-active"><div style="float: left;"><img src="view/image/agoodonut-options-m.png"  style="" ></div>
<div style="float: left; margin-left: 7px; margin-top: 4px; "><?php echo $this->language->get('tab_options'); ?></div></a>
</div>


<div style="margin-right:5px; float:left;">
<a href="<?php echo $url_schemes; ?>" class="markbutton"><div style="float: left;"><img src="view/image/agoodonut-schemes-m.png"  style="" ></div>
<div style="float: left; margin-left: 7px; margin-top: 4px; "><?php echo $tab_general; ?></div></a>
</div>

<div style="margin-right:5px;  float:left;">
<a href="<?php echo $url_widgets; ?>" class="markbutton"><div style="float: left;"><img src="view/image/agoodonut-widgets-m.png"  style="" ></div>
<div style="float: left; margin-left: 7px; margin-top: 4px; "><?php echo $tab_list; ?></div></a>
</div>

<div style="margin-right:5px;  float:left;">
<a href="<?php echo $url_modules; ?>" class="markbutton"><div style="float: left;"><img src="view/image/agoodonut-back-m.png"  style="" ></div>
<div style="float: left; margin-left: 7px; margin-top: 4px; "><?php echo $url_modules_text; ?></div></a>
</div>

</div>


<div style="margin:5px; float:right;">
   <a href="#" class="mbutton langmark_save"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="mbutton"><?php echo $button_cancel; ?></a>
</div>

<div style="clear: both; line-height: 1px; font-size: 1px;"></div>

<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">

<script type="text/javascript">
function delayer(){
    window.location = 'index.php?route=module/langmark&token=<?php echo $token; ?>';
}
</script>

 <div id="tabs" class="htabs"><a href="#tab-options"><?php echo $this->language->get('tab_options'); ?></a><a href="#tab-pagination"><?php echo $this->language->get('tab_pagination'); ?></a><a href="#tab-install"><?php echo $this->language->get('entry_install_update'); ?></a><a href="#tab-about"><?php echo $this->language->get('entry_about'); ?></a></div>

<div id="tab-about">

<?php echo $this->language->get('text_about'); ?>

</div>


  <div id="tab-options">

   <table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

          <tr>
              <td><?php echo $this->language->get('entry_switch'); ?></td>
              <td><select name="general_set[switch]">
                  <?php if (isset($general_set['switch']) && $general_set['switch']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>


          <!--
          <tr>
              <td><?php echo $this->language->get('entry_cache_widgets'); ?></td>
              <td><select name="general_set[cache_widgets]">
                  <?php if (isset($general_set['cache_widgets']) && $general_set['cache_widgets']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            -->


	 <?php foreach ($languages as $language) { ?>
	<tr>
		<td class="left">
			<?php echo $this->language->get('entry_title_prefix'); ?> (<?php echo $language['name']; ?>)
		</td>
			<td>
				<div style="float: left;">
				<input type="text" class="template" name="general_set[prefix][<?php echo $language['code']; ?>]" value="<?php if (isset($general_set['prefix'][$language['code']])) { echo $general_set['prefix'][$language['code']]; } else { echo ''; } ?>">
				</div>
				<div style="float: left; margin-left: 3px;">
				<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" ><br>
               </div>
			</td>

	</tr>
   <?php } ?>



    <tr>
     <td></td>
     <td></td>
    </tr>
   </table>
  </div>

  <div id="tab-pagination">

   <table class="mynotable" style="margin-bottom:20px; background: white; vertical-align: center;">

          <tr>
              <td><?php echo $this->language->get('entry_pagination'); ?></td>
              <td><select name="general_set[pagination]">
                  <?php if (isset($general_set['pagination']) && $general_set['pagination']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>

    <tr>
     <td class="left"><?php echo $this->language->get('entry_pagination_prefix'); ?></td>
     <td class="left">
      <input type="text" class="template" name="general_set[pagination_prefix]" value="<?php  if (isset($general_set['pagination_prefix'])) echo $general_set['pagination_prefix']; ?>" size="20" />
     </td>
    </tr>

          <!--
          <tr>
              <td><?php echo $this->language->get('entry_cache_widgets'); ?></td>
              <td><select name="general_set[cache_widgets]">
                  <?php if (isset($general_set['cache_widgets']) && $general_set['cache_widgets']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            -->


	 <?php foreach ($languages as $language) { ?>
	<tr>
		<td class="left">
			<?php echo $this->language->get('entry_title_pagination'); ?> (<?php echo $language['name']; ?>)
		</td>
			<td>
				<div style="float: left;">
				<input type="text" class="template" name="general_set[pagination_title][<?php echo $language['code']; ?>]" value="<?php if (isset($general_set['pagination_title'][$language['code']])) { echo $general_set['pagination_title'][$language['code']]; } else { echo ''; } ?>">
				</div>
				<div style="float: left; margin-left: 3px;">
				<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" ><br>
               </div>
			</td>

	</tr>
   <?php } ?>



    <tr>
     <td></td>
     <td></td>
    </tr>
   </table>
  </div>


<div id="tab-install">
 <div id="create_tables" style="color: green; font-weight: bold;"></div>
    <a href="#" onclick="
		$.ajax({
			url: '<?php echo $url_create; ?>',
			dataType: 'html',
			beforeSend: function()
				{
                     $('#create_tables').html('<?php echo $this->language->get('text_loading_small'); ?>');
				},

			success: function(json) {
				$('#create_tables').html(json);
				//setTimeout('delayer()', 2000);
			},
			error: function(json) {
			$('#create_tables').html('error');
			}
		}); return false;" class="markbuttono" style=""><?php echo $url_create_text; ?></a>


   <a href="#" onclick="
		$.ajax({
			url: '<?php echo $url_delete; ?>',
			dataType: 'html',
			beforeSend: function()
					{
                     $('#create_tables').html('<?php echo $this->language->get('text_loading_small'); ?>');
					},
			success: function(json) {
				$('#create_tables').html(json);
				//setTimeout('delayer()', 2000);
			},
			error: function(json) {
			$('#create_tables').html('error');
			}
		}); return false;" class="mbuttonr" style=""><?php echo $url_delete_text; ?></a>


<?php if (isset($text_update) && $text_update!='' ) { ?>
<div style="font-size: 18px; color: red;"><?php echo $text_update; ?></div>
<?php } ?>

</div>


 </div>

 </form>
</div>
	<script type="text/javascript">

	 form_submit = function() {
		$('#form').submit();
		return false;
	}
	$('.langmark_save').bind('click', form_submit);
	</script>

	<script type="text/javascript">
$('#tabs a').tabs();
</script>

</div>

<?php echo $footer; ?>