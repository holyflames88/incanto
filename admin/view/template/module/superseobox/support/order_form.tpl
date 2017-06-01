<!DOCTYPE html>
<html dir="ltr" lang="en">
<head>
<meta charset="UTF-8" />
<title>Registration of Module</title>
<link rel="stylesheet" type="text/css" href="view/stylesheet/superseobox/bootstrap/css/bootstrap.min.css" media="screen">
</head>
<body>
    <h3 id="modal-licenseConditionLabel">Before use this module you must register it</h3>
	%s
	<div class="">
	<p class="alert alert-success">One license for the one Opencart installation, where you can use unlimited domains for your stores and one main domain</p>
	<p class="alert alert-info">Here you can enter your Order id and Domain of your website</p>
	<h3>Registration information</h3>
	<div>
			<form class="form-horizontal" action="%s" method="post">
				  <div class="control-group">
					<label class="control-label">Order ID</label>
					<div class="controls">
					  <input type="text" name="order_id" placeholder="Enter your order ID" value="%s">
					</div>
				  </div>
				  <div class="control-group">
					<label class="control-label">Domain</label>
					<div class="controls">
					  <input type="text" name="domain" placeholder="Enter your domain" value="%s">
					</div>
				  </div>
				  <div class="control-group">
					<div class="controls">
					  <button type="submit" class="btn">Register</button>
					</div>
				  </div>
				</form>
	</div>	
	<h3>Additional Information</h3>
	<p style="color:#777">If system can't find your order id, wait a little time, when your order will be uploaded and checked. Usually, this happen every 12-24 hours.</br>If your purchase is already registered for your old / test website and you want move this module on new website you must do:
	</br>1. uninstall this module on your old / test website.
	</br>2. install it on your new website and register it
	</p>
	</div>
<style>body {margin: 30px 70px;)</style>
</body>
