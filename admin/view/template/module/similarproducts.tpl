<?php echo $header; ?>
<div id="content">
  <ul class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
    <?php } ?>
  </ul>
  <?php echo (empty($data['SimilarProducts']['LicensedOn'])) ? base64_decode('PGRpdiBjbGFzcz0iYWxlcnQgYWxlcnQtZXJyb3IiPjxpIGNsYXNzPSJpY29uLWV4Y2xhbWF0aW9uLXNpZ24iPjwvaT4gWW91IGFyZSBydW5uaW5nIGFuIHVubGljZW5zZWQgdmVyc2lvbiBvZiB0aGlzIG1vZHVsZSEgPGEgaHJlZj0iamF2YXNjcmlwdDp2b2lkKDApIiBvbmNsaWNrPSIkKCdhW2hyZWY9I3N1cHBvcnRdJykudHJpZ2dlcignY2xpY2snKSI+Q2xpY2sgaGVyZSB0byBlbnRlciB5b3VyIGxpY2Vuc2UgY29kZTwvYT4gdG8gZW5zdXJlIHByb3BlciBmdW5jdGlvbmluZywgYWNjZXNzIHRvIHN1cHBvcnQgYW5kIHVwZGF0ZXMuPC9kaXY+') : '' ?>
  <?php if ($error_warning) { ?>
  <div class="alert alert-error"><i class="icon-exclamation-sign"></i> <?php echo $error_warning; ?></div>
  <?php } ?>
    <?php if (!empty($this->session->data['success'])) { ?>
    <div class="alert alert-success autoSlideUp"><i class="icon-ok-sign"></i> <?php echo $this->session->data['success']; ?></div>
    <script> $('.autoSlideUp').delay(3000).fadeOut(600, function(){ $(this).show().css({'visibility':'hidden'}); }).slideUp(600);</script>
    <?php $this->session->data['success'] = null; } ?>
  <div class="box">
    <div class="box-heading">
      <h1><i class="icon-th-large"></i> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content fadeInOnLoad">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div class="tabbable">
		  <div class="tab-navigation">        
          <ul class="nav nav-tabs mainMenuTabs">
            <li><a href="#controlpanel" data-toggle="tab" class="active"><i class="icon-wrench"></i> Control Panel</a></li>
            <li><a href="#support" data-toggle="tab"><i class="icon-share"></i> Support</a></li>        
          </ul>
          <div class="tab-buttons">
            <button type="submit" class="btn btn-primary save-changes"><i class="icon-ok"></i> Save changes</button>        
          </div>
          </div>
         <div class="tab-content">
			<div id="controlpanel" class="tab-pane active">
              <?php require_once(DIR_APPLICATION.'view/template/module/similarproducts/tab_panel.php'); ?>                        
            </div>                
			<div id="support" class="tab-pane">
              <?php require_once(DIR_APPLICATION.'view/template/module/similarproducts/tab_support.php'); ?>                        
            </div>
          </div><!-- /.tab-content -->
        </div><!-- /.tabbable -->
      </form>
    </div>
  </div>
</div>
<script>
if (window.localStorage && window.localStorage['currentTab']) {
	$('.mainMenuTabs a[href='+window.localStorage['currentTab']+']').trigger('click');  
}
if (window.localStorage && window.localStorage['currentSubTab']) {
	$('a[href='+window.localStorage['currentSubTab']+']').trigger('click');  
}
$('.fadeInOnLoad').css('visibility','visible');
$('.mainMenuTabs a[data-toggle="tab"]').click(function() {
	if (window.localStorage) {
		window.localStorage['currentTab'] = $(this).attr('href');
	}
});
$('a[data-toggle="tab"]:not(.mainMenuTabs a[data-toggle="tab"])').click(function() {
	if (window.localStorage) {
		window.localStorage['currentSubTab'] = $(this).attr('href');
	}
});
</script>
<?php echo $footer; ?>