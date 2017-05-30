<?php if(isset($url_module)){ ?>
		<?php echo $header; ?><?php echo $column_left; ?>
		<div id="content" >
			<div class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
				<?php } ?>
			</div>
			<style>
			iframe {margin:0;padding-top:10px;height:100%;display:block;width:97%;border:none; left:50px; position:absolute;margin-top: -27px;}
			</style>
			<script>
				function iframeResize(){
					//$('iframe#conector').iframeAutoHeight({heightOffset: 40}).css('position', 'inherit'); 
					var i_height = $("#conector").contents().find("html").height();
					var $modal = $("#conector").contents().find('body>.modal');
					if($modal && $modal.height() > i_height){
						i_height = $modal.height() + 60;
					}
					$("#content").height(i_height + 60);
					$("iframe#conector").height(i_height + 40).css('position', 'inherit').css('width', '100%');
				}
				
				jQuery(document).ready(function() {
					$('iframe#conector').load(function(){
						iframeResize();
						$( 'iframe#conector' ).contents().find("body *").click(function() {
							setTimeout(function(){
								//alert($("#conector").contents().find("html").height());
								iframeResize();
							}, 700);
						});
					});

				});
			</script>
			<iframe id="conector" src="<?php echo $url_module; ?>">
				¬аш браузер не поддерживает плавающие фреймы!
			</iframe>
		</div>
<?php }else{ ?>	
		<?php include 'i_header.tpl';?>

		<script type="text/javascript">
			window.addEventListener('DOMContentLoaded', function() {
				new QueryLoader2(document.querySelector(".content"), {
					barColor: "rgb(150, 150, 150)",
					backgroundColor: "rgba(256, 256, 256,0.7)",
					percentage: true,
					barHeight: 1,
					minimumTime: 3500,
					fadeOutTime: 200
				});
			});
		</script>

		<?php include 'i_content.tpl';?>

		<?php include 'i_footer.tpl';?>

<?php } ?>