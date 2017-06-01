		<?php if ($success) { ?>
			<div class="success"><?php echo $success; ?></div>
		<?php } ?>
		<?php if ($error_warning) { ?>
			<div class="warning"><?php echo $error_warning; ?></div>
		<?php } ?>
			<div class="box-block header-seo-box">
				<div class="on-off-seo">
					<div class="btn-group btn-group-vertical">
						<button class="status_on span2 btn-large btn"><?php echo $text_seo; ?> <?php echo $text_on; ?></button>
						<button class="status_off span2 btn-large btn"><?php echo $text_seo; ?> <?php echo $text_off; ?></button>
					</div>
				</div>
				<div class="header-seo">
					<div class="auto-create-box">
						
					</div>
				</div>
			</div>

			<!--  -->
			
			<div class="box-block" id="global_box">
				<div class="tabbable"> 
					<ul class="main-menu nav nav-tabs">
						<li class="active">
							<a href="#seo_generator" data-toggle="tab">
								<i class="icon-play-circle"></i> <?php echo $text_seo; ?> <?php echo $text_generators; ?>
							</a>
						</li>
						<li>
							<a href="#seo_tools" data-toggle="tab">
								<i class="icon-wrench"></i> <?php echo $text_seo; ?> tools
							</a>
						</li>
						<li>
							<a href="#seo_social" data-toggle="tab">
								<i class="icon-globe"></i> Social
							</a>
						</li>
						<li>
							<a href="#seo_map_robot" data-toggle="tab">
								<i class="icon-pencil"></i> Edit file
							</a>
						</li>
					</ul>
					<div class="main-content tab-content">
						<div class="tab-pane active" id="seo_generator">
								<?php require_once 'seo_generator/seo_generator_index.tpl';?>
						</div>
						
						<div class="tab-pane" id="seo_tools">
								<?php require_once 'seo_tools/seo_tools_index.tpl';?>
						</div>
						
						<div class="tab-pane" id="seo_social">
								<?php require_once 'seo_social/seo_social_index.tpl';?>
						</div>

						<div class="tab-pane" id="seo_map_robot">
								<?php require_once 'seo_map_robot/seo_map_robot_index.tpl';?>
						</div>
					</div>
				</div>
			</div>