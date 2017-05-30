<div id="langmark_<?php echo $prefix;?>">
<?php $type = $this->journal2->settings->get('cpanel.header_language_currency_language', 'flag'); ?>
<?php if (count($languages) > 1): ?>
<?php
    $current_language = '';
    foreach ($languages as $language) {
        if ($language['code'] == $this->config->get('config_language')) {
            switch ($type) {
                case 'flag':
                    $current_language = "<img src=\"image/flags/{$language['image']}\" alt=\"{$language['name']}\" />";
                    break;
                case 'text':
                    $current_language = "{$language['name']}";
                    break;
                case 'full':
                    $current_language = "<img src=\"image/flags/{$language['image']}\" alt=\"{$language['name']}\" /> {$language['name']}";
                    break;
            }
        }
    }
?>

    <div id="language">
        <div class="btn-group">
            <button class="dropdown-toggle" type="button" data-hover="dropdown">
                <?php echo $current_language; ?> <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <?php foreach ($languages as $language): ?>
                <?php
                  if ($language['code'] != $language_code) {
					$href = ' href="'.$language['url'].'" ';
                  } else {
                  	$href = '';
                  }
                ?>

                    <?php if ($type === 'flag'): ?>
                        <li><a <?php echo $href; ?>><img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /></a></li>
                    <?php endif; ?>
                    <?php if ($type === 'text'): ?>
                        <li><a <?php echo $href; ?>><?php echo $language['name']; ?></a></li>
                    <?php endif; ?>
                    <?php if ($type === 'full'): ?>
                        <li><a <?php echo $href; ?>><img src="image/flags/<?php echo $language['image']; ?>" alt="<?php echo $language['name']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                    <?php endif; ?>
                <?php endforeach; ?>
            </ul>
        </div>
    </div>

<?php endif; ?>
</div>
<script>
	<?php if (isset($settings_widget['anchor']) && $settings_widget['anchor']!='') { ?>
	var prefix = '<?php echo $prefix; ?>';
	var langmarkdata = $('#langmark_<?php echo $prefix;?>').html();
	<?php echo $settings_widget['anchor']; ?>;
	$('#langmark_<?php echo $prefix; ?>').remove();
   <?php  } ?>
</script>

<script>
$(document).ready(function() {
	var lprefix = '<?php  echo $language_prefix; ?>';

	$('form').each(function(index) {
		var laction = $(this).attr('action');
		if (typeof laction.value!='undefined') {
			var llast = laction.value.length - 1;
			if (llast != '/') {
				laction = laction + '/';
			}
			var li = laction.indexOf( lprefix);
			if (li < 0) {
				$(this).attr('action', laction + lprefix);
			}
		}
	});
});
</script>
