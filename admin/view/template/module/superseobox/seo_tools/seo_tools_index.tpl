<div class="box-block work-seo-box">
	<h2><?php echo $text_SEO_tools; ?></h2>
	<div class="tabbable tabs-left">
		<ul id="seo_tools_menu" class="seo-item-menu nav nav-tabs" data-position="right" data-intro="Now, we are in tab 'SEO tools' and this is it's menu. Here we can add many useful SEO features, such as Canonical Links, Social Buttons, QR-code and other." data-intro-action="$('a[href=#question]').click();" data-step="10" >
			<span><?php echo $text_common_tools; ?></span>
			<li class="active">
				<a href="#seo_tool_store" data-toggle="tab">
					<i class="icon-flag"></i> 
					<?php echo $text_common_seo_store; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_site_map" data-toggle="tab">
					<i class="icon-globe"></i> 
					<?php echo $text_sitemap_name; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_if_modified" data-toggle="tab">
					<i class="icon-repeat"></i> 
					<?php echo $text_common_if_modified; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_404_manager" data-toggle="tab">
					<i class="icon-plane"></i> 
					<?php echo $text_common_404_manager; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_seo_pagination" data-toggle="tab">
					<i class="icon-random"></i> 
					<?php echo $text_common_seo_pagination; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_seo_breadcrumbs" data-toggle="tab">
					<i class="icon-circle-arrow-right"></i> 
					<?php echo $text_common_seo_breadcrumbs; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_path_manager" data-toggle="tab">
					<i class="icon-road"></i> 
					<?php echo $text_common_path_manager; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_suffix_manager" data-toggle="tab">
					<i class="icon-chevron-left"></i> 
					<?php echo $text_common_suffix_manager; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_check_url" data-toggle="tab">
					<i class="icon-warning-sign"></i> 
					<?php echo $text_common_check_url; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_seo_hreflang" data-toggle="tab">
					<i class="icon-refresh"></i> 
					<?php echo $text_common_hreflang_link; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_canonical" data-toggle="tab">
					<i class="icon-arrow-up"></i> 
					<?php echo $text_common_canonical_link; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_lan_dir_link" data-toggle="tab">
					<i class="icon-upload"></i> 
					<?php echo $text_common_languag_mode; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_traling_slash" data-toggle="tab">
					<i class="icon-resize-horizontal"></i> 
					<?php echo $text_common_trailing_slash; ?>
				</a>
			</li>
			<li>
				<a href="#seo_tool_ver_webm_tool" data-toggle="tab">
					<i class="icon-briefcase"></i> 
					<?php echo $text_common_webmaster_tools; ?>
				</a>
			</li>
			<?php if($addons['prmod']['install']){ ?>
			<li class="no-tab-direction">
				<a href="<?php echo $addons['prmod']['url']; ?>">
					<i class="icon-share-alt"></i> 
					Redirection <span class="text-success">(<?php echo $text_common_addon; ?>)</span> 
				</a>
			</li>
			<?php }else{ ?>
			<li>
				<a href="#seo_tool_prm_manager" data-toggle="tab">
					<i class="icon-share-alt"></i> 
					Redirection <span class="text-success">(<?php echo $text_common_addon; ?>)</span> 
				</a>
			</li>
			<?php } ?>
		</ul>

		<div class="tab-content">
			<div class="tab-pane active" id="seo_tool_store">
				<h3><?php echo strtoupper($text_common_seo_store); ?></h3>
				<?php require_once 'tabs/seo_store.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_site_map">
				<h3><?php echo strtoupper($text_sitemap_name); ?></h3>
				<?php require_once 'tabs/site_map.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_if_modified">
				<h3><?php echo strtoupper($text_common_if_modified); ?></h3>
				<?php require_once 'tabs/if_modified.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_404_manager">
				<h3><?php echo strtoupper($text_common_404_manager); ?></h3>
				<?php require_once 'tabs/404_manager.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_seo_pagination">
				<h3><?php echo strtoupper($text_common_seo_pagination); ?></h3>
				<?php require_once 'tabs/seo_pagination.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_seo_breadcrumbs">
				<h3><?php echo strtoupper($text_common_seo_breadcrumbs); ?></h3>
				<?php require_once 'tabs/seo_breadcrumb.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_path_manager">
				<h3><?php echo strtoupper($text_common_path_manager); ?></h3> 
				<?php require_once 'tabs/path_manager.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_suffix_manager">
				<h3><?php echo strtoupper($text_common_suffix_manager); ?></h3> 
				<?php require_once 'tabs/suffix_manager.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_check_url">
				<h3><?php echo strtoupper($text_common_check_url); ?></h3> 
				<?php require_once 'tabs/check_url.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_seo_hreflang">
				<h3><?php echo strtoupper($text_common_hreflang_link); ?></h3>
				<?php require_once 'tabs/seo_hreflang.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_canonical">
				<h3><?php echo strtoupper($text_common_canonical_link); ?></h3>
				<?php require_once 'tabs/canonical.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_lan_dir_link">
				<h3><?php echo strtoupper($text_common_languag_mode); ?></h3>
				<?php require_once 'tabs/lan_dir_link.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_traling_slash">
				<h3><?php echo strtoupper($text_common_trailing_slash); ?></h3>
				<?php require_once 'tabs/trailing_slash.tpl';?>
			</div>
			<div class="tab-pane" id="seo_tool_ver_webm_tool">
				<h3><?php echo strtoupper($text_common_webmaster_tools); ?></h3>
				<?php require_once 'tabs/ver_webm_tool.tpl';?>
			</div>
		<?php if(!$addons['prmod']['install']){ ?>
			<div class="tab-pane" id="seo_tool_prm_manager">
				<h3><?php echo strtoupper('Redirect Manager'); ?></h3>
				<?php require_once 'tabs/addon_PRM.tpl';?>
			</div>
		<?php }  ?>
		</div>
	</div>
</div>