<div id="ssb-share-bar">

		<?php if($soc_buttons['data']['Facebook']['status']){ ?>
			<div class="facebook" data-text="<?php echo $h_title; ?>" data-title="Like"></div><?php }?>
		
		<?php if($soc_buttons['data']['Twitter']['status']){ ?>
			<div class="twitter" data-text="<?php echo $h_title; ?>" data-title="Tweet"></div> <?php }?>
			
		<?php if($soc_buttons['data']['Google']['status']){ ?>
			<div class="google" data-text="<?php echo $h_title; ?>" data-title="g+"></div><?php }?>
		
		<?php if($soc_buttons['data']['Pinterest']['status']){ ?>
			<div class="pinterest" data-text="<?php echo $h_title; ?>" data-title="Pin it"></div><?php }?>
		
		<?php if($soc_buttons['data']['Linkedin']['status']){ ?>
			<div class='linkedin' data-text="<?php echo $h_title; ?>" data-title="Linkedin"></div><?php }?>
		
		<?php if($soc_buttons['data']['Odnoklassniki']['status']){ ?>
			
			<div data-title="odnoklassniki" class="sharrre odnoklassniki">
				<script src="http://stg.odnoklassniki.ru/share/odkl_share.js" type="text/javascript" ></script>
				<div class="box">
					<span class="non-count count"></span>
					<a class="share odkl-klass-stat" href="" onclick="ODKL.Share(this);return false;" >OK<span  class="count">0</span></a>
				</div>
			</div><?php }?>
			
		<?php if($qr_code['status']){ ?>
			<div data-title="qr-code" class="sharrre ssb_qr-code" title="<img alt='<?php echo addslashes($h_title); ?>' class='count' src='<?php echo $qr_image_path; ?>' />" >
				<div class="box">
					<span class="count">
						<img alt="<?php echo $h_title; ?>" width="50" height="40" class="count" src="<?php echo $qr_image_path; ?>" />
					</span>
					<div class="share">QR</div>
				</div>
			</div><?php }?>	
</div>