<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
		<tr>
								<td><?php echo $register_site; ?></td>
								<td><a target="_blank" href="http://my.smscab.ru/"><?php echo "http://my.smscab.ru/";?></a></td>
							</tr>
							<tr>
								<td><?php echo 'Вкл/выкл отправку смс' ; ?></td>
								<td colspan="8"><?php if ($config_send_sms_on_off_order) { ?>
								<input type="radio" name="config_send_sms_on_off_order" value="1" checked="checked" />
							   <?php echo $text_yes; ?>
								<input type="radio" name="config_send_sms_on_off_order" value="0" />
							   <?php echo $text_no; ?>
								<?php } else { ?>
								<input type="radio" name="config_send_sms_on_off_order" value="1" />
							   <?php echo $text_yes; ?>
								<input type="radio" name="config_send_sms_on_off_order" value="0" checked="checked" />
								<?php echo $text_no; ?>
								<?php } ?></td>
							</tr>
							<tr>
								<td><?php echo $entry_login_send_sms ?></td>
								<td><input type="text" name="config_login_send_sms_order" value="<?php echo $config_login_send_sms_order ?>" size="20" /></td>
							</tr>
							<tr>
								<td><?php echo $entry_pass_send_sms ?></td>
								<td><input type="text" name="config_pass_send_sms_order" value="<?php echo $config_pass_send_sms_order ?>" size="20" /></td>
							</tr>
		<tr>
				<td><?php echo $on_off_product_column ; ?></td>
				<td colspan="8"><?php if ($config_on_off_product_column) { ?>
				<input type="radio" name="config_on_off_product_column" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_product_column" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_product_column" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_product_column" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_comment_manager ; ?></td>
				<td colspan="8"><?php if ($config_on_off_comment_manager) { ?>
				<input type="radio" name="config_on_off_comment_manager" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_comment_manager" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_comment_manager" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_comment_manager" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_send_mail_user ; ?></td>
				<td colspan="8"><?php if ($config_on_off_send_mail_user) { ?>
				<input type="radio" name="config_on_off_send_mail_user" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_send_mail_user" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_send_mail_user" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_send_mail_user" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_podbem ; ?></td>
				<td colspan="8"><?php if ($config_on_off_podbem) { ?>
				<input type="radio" name="config_on_off_podbem" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_podbem" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_podbem" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_podbem" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_sborka ; ?></td>
				<td colspan="8"><?php if ($config_on_off_sborka) { ?>
				<input type="radio" name="config_on_off_sborka" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_sborka" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_sborka" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_sborka" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_manager ; ?></td>
				<td colspan="8"><?php if ($config_on_off_manager) { ?>
				<input type="radio" name="config_on_off_manager" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_manager" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_manager" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_manager" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_dostavka ; ?></td>
				<td colspan="8"><?php if ($config_on_off_dostavka) { ?>
				<input type="radio" name="config_on_off_dostavka" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_dostavka" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_dostavka" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_dostavka" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_tochka ; ?></td>
				<td colspan="8"><?php if ($config_on_off_tochka) { ?>
				<input type="radio" name="config_on_off_tochka" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_tochka" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_tochka" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_tochka" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_postavshik ; ?></td>
				<td colspan="8"><?php if ($config_on_off_postavshik) { ?>
				<input type="radio" name="config_on_off_postavshik" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_postavshik" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_postavshik" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_postavshik" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_zakupka ; ?></td>
				<td colspan="8"><?php if ($config_on_off_zakupka) { ?>
				<input type="radio" name="config_on_off_zakupka" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_zakupka" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_zakupka" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_zakupka" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_cost_delivery ; ?></td>
				<td colspan="8"><?php if ($config_on_off_cost_delivery) { ?>
				<input type="radio" name="config_on_off_cost_delivery" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_cost_delivery" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_cost_delivery" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_cost_delivery" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_profit ; ?></td>
				<td colspan="8"><?php if ($config_on_off_profit) { ?>
				<input type="radio" name="config_on_off_profit" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_profit" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_profit" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_profit" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_sku ; ?></td>
				<td colspan="8"><?php if ($config_on_off_sku) { ?>
				<input type="radio" name="config_on_off_sku" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_sku" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_sku" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_sku" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_product_colorbox ; ?></td>
				<td colspan="8"><?php if ($config_on_off_product_colorbox) { ?>
				<input type="radio" name="config_on_off_product_colorbox" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_product_colorbox" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_product_colorbox" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_product_colorbox" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		
		<tr>
			<td colspan="2" style="text-align:center; font-weight:bold;"><?php echo "Настройка На Главной странице ";?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_product_column ; ?></td>
				<td colspan="8"><?php if ($config_on_off_product_column_home) { ?>
				<input type="radio" name="config_on_off_product_column_home" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_product_column_home" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_product_column_home" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_product_column_home" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_comment_manager ; ?></td>
				<td colspan="8"><?php if ($config_on_off_comment_manager_home) { ?>
				<input type="radio" name="config_on_off_comment_manager_home" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_comment_manager_home" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_comment_manager_home" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_comment_manager_home" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_podbem ; ?></td>
				<td colspan="8"><?php if ($config_on_off_podbem_home) { ?>
				<input type="radio" name="config_on_off_podbem_home" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_podbem_home" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_podbem_home" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_podbem_home" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_sborka ; ?></td>
				<td colspan="8"><?php if ($config_on_off_sborka_home) { ?>
				<input type="radio" name="config_on_off_sborka_home" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_sborka_home" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_sborka_home" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_sborka_home" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_manager ; ?></td>
				<td colspan="8"><?php if ($config_on_off_manager_home) { ?>
				<input type="radio" name="config_on_off_manager_home" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_manager_home" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_manager_home" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_manager_home" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_dostavka ; ?></td>
				<td colspan="8"><?php if ($config_on_off_dostavka_home) { ?>
				<input type="radio" name="config_on_off_dostavka_home" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_dostavka_home" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_dostavka_home" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_dostavka_home" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_tochka ; ?></td>
				<td colspan="8"><?php if ($config_on_off_tochka_home) { ?>
				<input type="radio" name="config_on_off_tochka_home" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_tochka_home" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_tochka_home" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_tochka_home" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_postavshik ; ?></td>
				<td colspan="8"><?php if ($config_on_off_postavshik_home) { ?>
				<input type="radio" name="config_on_off_postavshik_home" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_postavshik_home" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_postavshik_home" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_postavshik_home" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
		<tr>
				<td><?php echo $on_off_sku ; ?></td>
				<td colspan="8"><?php if ($config_on_off_sku_home) { ?>
				<input type="radio" name="config_on_off_sku_home" value="1" checked="checked" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_sku_home" value="0" />
				<?php echo $text_no; ?>
				<?php } else { ?>
				<input type="radio" name="config_on_off_sku_home" value="1" />
				<?php echo $text_yes; ?>
				<input type="radio" name="config_on_off_sku_home" value="0" checked="checked" />
				<?php echo $text_no; ?>
				<?php } ?></td>
		</tr>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>