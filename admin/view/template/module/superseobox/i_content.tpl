<?php if ($success) { ?>
	<div class="success"><?php echo $success; ?></div>
<?php } ?>
<?php if ($error_warning) { ?>
	<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<div class="box-block header-seo-box">
	<div class="seo-power-box" data-position="right" data-intro="<?php echo $text_this_is_the_index; ?>" data-step="1">
		<div class="seo-power-box-gauge">
		<input id="seo-gauge" data-linecap="round" class="knob" data-thickness=".2" data-fgColor="#FE9D00" data-bgColor="#EDEBEC" data-angleOffset=-125 data-angleArc=250 readOnly="true" class="knob" data-width="154" value="0%">
		</div>
		<span style="text-align:center;z-index: 1000;"><?php echo $text_seo_power; ?><br>
			<a class="turn-status">
			<input class="input-power-status hide" type="hidden" name="data[powerStatus]" value="<?php if($data['powerStatus']) echo 1; ?>">
			<img data-toggle="tooltip" data-original-title="Here you  can quickly turn ON/OFF this module, for testing your website with/without Paladin. All your setting and templates will be saving." data-placement="bottom" class="turn-on <?php if(!$data['powerStatus']) echo 'hide'; ?>" src="view/stylesheet/superseobox/images/turn-on.png" alt=""/>
			<img data-toggle="tooltip" data-original-title="Here you  can quickly turn ON/OFF this module, for testing your website with/without Paladin. All your setting and templates will be saving." data-placement="bottom" class="turn-off <?php if($data['powerStatus']) echo 'hide'; ?>" src="view/stylesheet/superseobox/images/turn-off.png" alt=""/>
			<span data-afteraction="afterAction" data-action="save" data-scope=".parent().find('.input-power-status')" class="button-power-status hide"></span>
			</a>
		</span>
	</div>
	<div class="header-seo">
		<div class="auto-create-box">
			
		</div>
	</div>
</div>

<!--  -->

<div class="box-block" id="global_box">
	<div class="tabbable"> 
		<ul id="main_menu" class="main-menu nav nav-tabs" data-intro-action="$('a[href=#seo_generator]').click();" data-intro="This is main menu. Click here to navigate on another SEO tool." data-step="2">
			<li class="active">
				<a href="#seo_generator" data-toggle="tab">
					<i class="icon-fire"></i> <?php echo $text_generators; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tools" data-toggle="tab">
					<i class="icon-magnet"></i> <?php echo $text_SEO_tools; ?>
				</a>
			</li>
			<li>
				<a href="#seo_edit" data-toggle="tab">
					<i class="icon-edit"></i> <?php echo $text_SEO_editor; ?>
				</a>
			</li>
			<li>
				<a href="#seo_social" data-toggle="tab">
					<i class="icon-share"></i> <?php echo $text_social_share; ?>
				</a>
			</li>
			<li>
				<a href="#rich_snipets" data-toggle="tab">
					<i class="icon-th"></i> <?php echo $text_rich_snippets; ?>
				</a>
			</li>
			<li>
				<a href="#imp_exp" data-toggle="tab">
					<i class="icon-retweet"></i> <?php echo $text_imp_exp; ?>
				</a>
			</li>
		</ul>
		<div class="main-content tab-content">
			<div class="tab-pane active" id="seo_generator">
				<div class="tab_title_info">
					<i class="icon-fire"></i>
					<?php echo $text_generators_info; ?>
					<span class="colorFC580B"><?php echo $text_before_use_generator; ?></span>  
				</div>
				<?php require_once 'seo_generator/seo_generator_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="seo_tools">
				<div class="tab_title_info">
					<i class="icon-magnet"></i>
					<?php echo $text_SEO_tools_info; ?>
				</div>
				<?php require_once 'seo_tools/seo_tools_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="seo_edit">
				<div class="tab_title_info">
					<i class="icon-edit"></i>
					<?php echo $text_SEO_editor_info; ?></br>
					<span class="colorFC580B"><?php echo $text_for_edit_any_texts; ?></span>
				</div>
				<?php require_once 'seo_edit/seo_edit.tpl';?>
			</div>
			
			<div class="tab-pane" id="seo_social">
				<div class="tab_title_info">
					<i class="icon-th"></i>
					<?php echo $text_social_share_info; ?>
				</div>
				<?php require_once 'seo_social/seo_social_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="rich_snipets">
				<div class="tab_title_info">
					<i class="icon-th"></i>
					<?php echo $text_rich_snippets_info; ?>
				</div>
				<?php require_once 'rich_snipets/rich_snipets_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="imp_exp">
				<div class="tab_title_info">
					<i class="icon-retweet"></i>
					<?php echo $text_imp_exp_info; ?>
				</div>
				<?php require_once 'imp_exp/imp_exp_index.tpl';?>
			</div>

			<div class="tab-pane" id="seo_support">
				<div class="tab_title_info">
					<i class="icon-bell"></i>
					<?php echo $text_get_support_info; ?>
				</div>
				<?php require_once 'support/support_index.tpl';?>
			</div>
			
			<div class="tab-pane" id="question">
				<div class="tab_title_info">
					<i class="icon-bell"></i>
					<?php echo $text_question_info; ?>
				</div>
				<?php require_once 'support/support_question.tpl';?>
			</div>
			
			<div class="tab-pane" id="improve_mod">
				<div class="tab_title_info">
					<i class="icon-bell"></i>
					<?php echo $text_improving_info; ?>
				</div>
				<?php require_once 'support/support_improve.tpl';?>
			</div>
		</div>
			
	</div>
</div>