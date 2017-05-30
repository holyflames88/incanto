<h3><?php echo $text_common_improve_module; ?></h3>

<div class="idea pull-left" style="margin-right: 12px;"></div>
<h4>
<?php echo $text_common_we_continually_working; ?>
</h4>

<table id="support-idea" class="form">
		<input type="hidden" name="type" value="IMPROVE" />
		<tr>
			<td colspan="2"><?php echo $text_common_do_you_have_idea; ?></td>
		</tr>
		<tr>
			<td><?php echo $text_common_your_name; ?>:<br><span class="help">How do we address you?</span></td>
			<td><input type="text" name="mail_name" value="<?php echo $clientData['name']; ?>" /></td>
		</tr>
		<tr>
			<td><?php echo $text_common_email_address; ?>:<br><span class="help">Which email do you want us to reply to?</span></td>
			<td><input type="text" name="mail_email" value="<?php echo $clientData['e_mail']; ?>" /></td>
		</tr>
		<tr>
			<td><?php echo $text_common_order_ID; ?>:<br><span class="help">Your Order ID when you purchased this extension.</span></td>
			<td><input type="text" name="mail_order_id" value="<?php echo $clientData['id_order']; ?>" /></td>
		</tr>
		<tr>
			<td><?php echo $text_common_idea; ?>:<br><span class="help">What would you like to tell us?<br></span></td>
			<td><textarea name="mail_message" style="width:300px; height:100px;"></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
				<a data-afterAction="afterSupport" data-action="newSupport" data-scope=".closest('.form').find('textarea, input')" class="btn ajax_action btn-success" type="button"><?php echo $text_common_send_idea; ?></a>
			</td>
		</tr>
	</table>