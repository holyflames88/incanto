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
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_public_key; ?></td>
          <td><input name="recaptcha_public_key" value="<?php echo $public_key; ?>" size="56"><br />
            <?php if ($error_public_key) { ?>
            <span class="error"><?php echo $error_public_key; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_private_key; ?></td>
          <td><input name="recaptcha_private_key" value="<?php echo $private_key; ?>" size="56"><br />
            <?php if ($error_private_key) { ?>
            <span class="error"><?php echo $error_private_key; ?></span>
            <?php } ?></td>
        </tr>
      </table>
    </form>
  <div class="help"><?php echo $text_help; ?></div>
  </div>
</div>
<?php echo $footer; ?>