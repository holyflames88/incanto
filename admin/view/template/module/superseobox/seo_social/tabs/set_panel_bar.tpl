<p><?php echo $text_common_panel_soc_share_setting; ?></p>

<form class="form-horizontal shar-setting-tabs">
<a data-afteraction="afterAction" data-action="save" data-scope=".closest('form').find('.save_all_true input, .save_all_true select')" class="btn btn-success ajax_action span2" type="button"><?php echo $text_common_save_all; ?></a>
<table class"table">
	<tbody>	
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label"><?php echo $text_common_display_mode; ?></label>
						<div class="controls">
							<select style="margin-bottom:5px;" name="data[tools][panel_box][mode]">
								<option value="button" <?php if($data['tools']['panel_box']['mode'] == 'button') { echo 'selected="selected"';} ?> ><?php echo $text_common_button; ?></option>
								<option value="panel" <?php if($data['tools']['panel_box']['mode'] == 'panel') { echo 'selected="selected"';} ?> ><?php echo $text_common_panel; ?></option>
							</select>
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo $text_common_animate; ?>:</dt>
					<dd class="info-area">
						<?php echo $text_common_animate_panel; ?>
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label"><?php echo $text_common_background_color; ?></label>
						<div class="controls">
							<input name="data[tools][panel_box][css][background]" type="text" class="span2 color {hash:true,  pickerFaceColor:'transparent',pickerFace:3,pickerBorder:0,pickerInsetColor:'black'}" value="<?php echo $data['tools']['panel_box']['css']['background']; ?>">
							<?php echo $text_common_status; ?>:
							<input type="hidden" name="data[tools][panel_box][css][bg_status]" value="">
							<input data-afteraction="afterAction" data-action="save" data-scope=".closest('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['panel_box']['css']['bg_status']) echo 'checked="checked"'; ?> name="data[tools][panel_box][css][bg_status]" class="on_off">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo $text_common_background_color; ?>:</dt>
					<dd class="info-area">
						<?php echo $text_common_background_color_info; ?>
					</dd>
				</dl>
			</td>
		</tr>	
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label">Opacity</label>
						<div class="controls">
							<input class="span2" name="data[tools][panel_box][css][opacity]" type="text" placeholder="Add opacity" value="<?php echo $data['tools']['panel_box']['css']['opacity']; ?>">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo $text_common_opacity; ?>:</dt>
					<dd class="info-area">
						<?php echo $text_common_opacity_info; ?>
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label"><?php echo $text_common_border_radius; ?></label>
						<div class="controls">
							<input  class="span2" name="data[tools][panel_box][css][border_r]" type="text" value="<?php echo $data['tools']['panel_box']['css']['border_r']; ?>">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo $text_common_border_radius; ?>:</dt>
					<dd class="info-area">
						<?php echo $text_common_border_radius_info; ?>
					</dd>
				</dl>
			</td>
		</tr>	
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label"><?php echo $text_common_border_margin; ?></label>
						<div class="controls">
							<input  class="span2" name="data[tools][panel_box][css][margin]" type="text" value="<?php echo $data['tools']['panel_box']['css']['margin']; ?>">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo $text_common_border_margin; ?>:</dt>
					<dd class="info-area">
						<?php echo $text_common_border_margin_info; ?>
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label"><?php echo $text_common_direction; ?></label>
						<div class="controls">
							<select name="data[tools][panel_box][position][direction]">
								<option value=""><?php echo $text_common_choose_direction; ?></option>
								<option value="horizontal" <?php if($data['tools']['panel_box']['position']['direction'] == 'horizontal') { echo 'selected="selected"';} ?> ><?php echo $text_common_horizontal; ?></option>
								<option value="vertical" <?php if($data['tools']['panel_box']['position']['direction'] == 'vertical') { echo 'selected="selected"';} ?> ><?php echo $text_common_vertical; ?></option>
							</select>
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo $text_common_direction; ?>:</dt>
					<dd class="info-area">
						<?php echo $text_common_direction_info; ?>
					</dd>
				</dl>
			</td>
		</tr>
		<tr>
			<td>
				<fieldset>
		<div class="control-group shar-bar-position">
			<div class="empty_field">
			<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="">
			<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="">
			<input type="hidden" name="data[tools][panel_box][position][targetRight]" value="">
			<input type="hidden" name="data[tools][panel_box][position][targetBottom]" value="">
			<input type="hidden" name="data[tools][panel_box][position][centerX]" value="">
			<input type="hidden" name="data[tools][panel_box][position][centerY]" value="">
			</div>
			<label style="font-weight:bold;" class="control-label"><?php echo $text_common_position; ?></label>
			<table style="width:auto;" class="table share-box-position">
				<tbody>
					<tr>
						<td class="targetLeft-targetTop">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="lt">
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetTop input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'lt') echo 'btn-success' ?>"><?php echo $text_common_move_to . ' ' . $text_common_upper . ' ' . $text_common_left; ?></a>
						</td>
						<td class="targetLeft-targetTop-centerX">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="ltx">
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][centerX]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetTop-centerX input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'ltx') echo 'btn-success' ?>"><?php echo $text_common_move_to . ' ' . $text_common_upper . ' ' . $text_common_center; ?></a>
						</td>
						<td class="targetRight-targetTop">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="rt">
							<input type="hidden" name="data[tools][panel_box][position][targetRight]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetRight-targetTop input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'rt') echo 'btn-success' ?>"><?php echo $text_common_move_to . ' ' . $text_common_upper . ' ' . $text_common_right; ?></a>
						</td>
					</tr>
					<tr>
						<td class="targetLeft-targetTop-centerY">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="lty">	
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][centerY]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetTop-centerY input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'lty') echo 'btn-success' ?>"><?php echo $text_common_move_to . ' ' . $text_common_center . ' ' . $text_common_left; ?></a>
						</td>
						<td>
						
						</td>
						<td class="targetRight-targetTop-centerY">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="rty">
							<input type="hidden" name="data[tools][panel_box][position][targetRight]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetTop]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][centerY]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetRight-targetTop-centerY input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'rty') echo 'btn-success' ?>"><?php echo $text_common_move_to . ' ' . $text_common_center . ' ' . $text_common_right; ?></a>
						</td>
					</tr>
					<tr>
						<td class="targetLeft-targetBottom">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="lb">	
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetBottom]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetBottom input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'lb') echo 'btn-success' ?>"><?php echo $text_common_move_to . ' ' . $text_common_lower . ' ' . $text_common_left; ?></a>
						</td>
						<td class="targetLeft-targetBottom-centerX ">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="lbx">	
							<input type="hidden" name="data[tools][panel_box][position][targetLeft]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetBottom]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][centerX]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetLeft-targetBottom-centerX input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'lbx') echo 'btn-success' ?>"><?php echo $text_common_move_to . ' ' . $text_common_lower . ' ' . $text_common_center; ?></a>
						</td>
						<td class="targetRight-targetBottom">
		<input type="hidden" name="data[tools][panel_box][position][combination]" value="rb">	
							<input type="hidden" name="data[tools][panel_box][position][targetRight]" value="true">
							<input type="hidden" name="data[tools][panel_box][position][targetBottom]" value="true">
							<a data-action="save" data-afterAction="afterAction" data-scope=".closest('.control-group').find('.empty_field input').add('.targetRight-targetBottom input')" class="btn <?php if($data['tools']['panel_box']['position']['combination'] == 'rb') echo 'btn-success' ?>"><?php echo $text_common_move_to . ' ' . $text_common_lower . ' ' . $text_common_right; ?></a>
						</td>
					</tr>
				</tbody>
			</table>
			
			<div class="controls">
				
			</div>
		</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo $text_common_position; ?>:</dt>
					<dd class="info-area">
						<?php echo $text_common_position_info; ?>
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label"><?php echo $text_common_animate; ?></label>
						<div class="controls">
							<input type="hidden" name="data[tools][panel_box][animate]" value="">
							<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['panel_box']['animate']) echo 'checked="checked"'; ?> name="data[tools][panel_box][animate]" class="on_off">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo $text_common_animate; ?>:</dt>
					<dd class="info-area">
						<?php echo $text_common_animate_panel; ?>
					</dd>
				</dl>
			</td>
		</tr>
		<tr class="save_all_true">
			<td>
				<fieldset>
					<div class="control-group">
						<label style="font-weight:bold;" class="control-label"><?php echo $text_common_behavior; ?></label>
						<div class="controls">
							<?php echo $text_common_if_width_window_less; ?>
							<input style="margin-bottom:5px;"  class="span2" name="data[tools][panel_box][behavior][width_less]" type="text" value="<?php echo $data['tools']['panel_box']['behavior']['width_less']; ?>"></br>
							<?php echo $text_common_move_panel_box_to; ?>
							<select style="margin-bottom:5px;" name="data[tools][panel_box][behavior][move_to]">
								<option value=""><?php echo $text_common_choose_position; ?></option>
								<option value="top" <?php if($data['tools']['panel_box']['behavior']['move_to'] == 'top') { echo 'selected="selected"';} ?> ><?php echo $text_common_top; ?></option>
								<option value="bottom" <?php if($data['tools']['panel_box']['behavior']['move_to'] == 'bottom') { echo 'selected="selected"';} ?> ><?php echo $text_common_bottom; ?></option>
							</select></br>
							<?php echo $text_common_or_hide_this_block; ?>
							<input type="hidden" name="data[tools][panel_box][behavior][hide]" value="">
							<input data-action="save" data-scope=".parents('.controls').find('input')" type="checkbox" value="true" <?php if($data['tools']['panel_box']['behavior']['hide']) echo 'checked="checked"'; ?> name="data[tools][panel_box][behavior][hide]" class="on_off">
						</div>
					</div>
				</fieldset>
			</td>
			<td class="info_text">
				<dl>
					<dt><?php echo $text_common_behavior; ?>:</dt>
					<dd class="info-area">
						<?php echo $text_common_behavior_info; ?>
					</dd>
				</dl>
			</td>
		</tr>		
	</tbody>
</table>
</form>
<h3><?php echo $text_common_examples_panel_bar; ?>:</h3>
<div class="panel-bar-example"></div>

