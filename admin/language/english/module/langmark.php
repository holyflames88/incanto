<?php
$_['langmark_version'] = '5.5.1 (Professional)_feofan.net';

$_['url_module_text'] = 'SEO multilanguage PRO';
$_['url_create_text'] = '<div style="text-align: center; text-decoration: none;">Create and update<br>data to the module<br><ins style="text-align: center; text-decoration: none; font-size: 13px;">(to install and upgrade module)</ins></div>';
$_['url_delete_text'] = '<div style="text-align: center; text-decoration: none;">Remove the configuration of older versions<br><ins style="text-align: center; text-decoration: none; font-size: 13px;">(for the installation and updated the module, after <br>re-saving "settings", "layouts" and "widgets")</ins></div>';
$_['url_back_text'] = 'In the module settings';
$_['url_modules_text'] = 'To list of the modules';


$_['url_opencartadmin'] = 'http://opencartadmin.com';

$_['heading_title'] = ' <div style="height: 21px; margin-top:5px; text-decoration:none;"><ins style="height: 24px;"><img src="view/image/langmark-icon.png" style="height: 16px; margin-bottom: -3px; "></ins><ins style="margin-bottom: 0px; text-decoration:none; margin-left: 9px; font-size: 13px; font-weight: 600; color: green;">SEO multilanguage PRO</ins></div>';
$_['heading_dev'] = 'Developer of the module <a href="mailto:admin@opencartadmin.com" target="_blank">opencartadmin.com</a><br>&copy; 2013-' . date('Y') . ' All Rights Reserved.';

$_['text_widget_html'] = 'Language HTML, HTML insert';
$_['text_loading'] = "<div style=\'padding-left: 30%; padding-top: 10%; font-size: 21px; color: #008000;\'>Loading...<\/div>";
$_['text_loading_small'] = "<div style=\'font-size: 19px; color: #008000;\'>Loading...<\/div>";
$_['text_update'] = 'Click the button.<br>You have updated the module';
$_['text_module'] = 'Modules';
$_['text_add'] = 'Add';
$_['text_action'] = 'Action:';
$_['text_success'] = 'Module updated successfully!';
$_['text_content_top'] = 'Content caps';
$_['text_content_bottom'] = 'Content basement';
$_['text_column_left'] = 'Left column';
$_['text_column_right'] = 'Right column';
$_['text_what_lastest'] = 'Last record';
$_['text_select_all'] = 'Select all';
$_['text_unselect_all'] = 'Unmark';
$_['text_sort_order'] = 'Order';
$_['text_further'] = '...';

$_['text_layout_all'] = 'All';
$_['text_enabled'] = 'Enabled';
$_['text_disabled'] = 'Disabled';

$_['entry_title_list_latest'] = 'Title';
$_['entry_editor'] = 'Graphic editor';
$_['entry_switch'] = 'Enable multilanguage support';
$_['entry_title_prefix'] = 'Language prefix<span class="help">Put the language prefix,<br>for example for English <b>en</b><br>(the url will look like: http://site.com/en )<br>If you want the url prefix<br>ended with a slash<br>(example: http://site.com/en/),<br>put prefix <b>en<ins style="color:green; text-decoration: none;">/</ins></b><br>or leave the <b>empty</b><br>if your language is <b>default</b></span>';
$_['entry_about'] = 'module';
$_['entry_category_status'] = 'Show category';
$_['entry_cache_widgets'] = 'The caching widgets<br/><span class="help">With full caching widgets <br>processing speed and output faster in 2-5 times. <br>depending on the number of widgets <br>used on the page</span>';
$_['entry_reserved'] = 'Reserved';
$_['entry_service'] = 'Service';
$_['entry_langfile'] = 'Language of the user file<br><span class="help">format: <b>the folder/file</b> without extension</span>';
$_['entry_widget_cached'] = 'Cache widget<br><span class="help">Has a higher priority than full caching <br>all the widgets in the General settings, <br>sometimes to cache the widget does not have to <br>if your templates is the logic of adding a <br>JS scripts and CSS styles in the document</span>';

$_['entry_anchor'] = 'Binding<br><span class="help">snap to the unit via the jquery<br>$(\'<b>bind</b>\') .html .append .prepend</span>';


$_['entry_layout'] = 'Layout:';




$_['entry_html'] = <<<EOF
<b>HTML, PHP, JS code</b><br><span class="help" style="line-height: 13px;">Understands the executing PHP code<br>
Variables:<br>
\$languages array with the structure:<br>
[language code] => Array<br>
(<br>
&nbsp;&nbsp; [language_id] => the id of the language<br>
&nbsp;&nbsp; [name] => name of the language<br>
&nbsp;&nbsp; [code] => language code<br>
&nbsp;&nbsp; [locale] => locale language<br>
&nbsp;&nbsp; [image] => image language<br>
&nbsp;&nbsp; [directory] => folder<br>
&nbsp;&nbsp; [filename] => the name of the language file<br>
&nbsp;&nbsp; [sort_order] => order<br>
&nbsp;&nbsp; [status] => status<br>
&nbsp;&nbsp; [url] => path of the current page for the language<br>
)<br>
<br>
\$text_language - title<br>
language block
<br>
<br>
\$language_code - current language code
<br>
\$language_prefix - current prefix language
</span>
EOF;
$_['entry_position'] = 'Location:';
$_['entry_status'] = 'Status:';
$_['entry_sort_order'] = 'Order';

$_['entry_template'] = 'Template';
$_['entry_what'] = 'what';
$_['entry_install_update'] = 'Installation and upgrade';


$_['tab_general'] = 'Layouts';
$_['tab_list'] = 'Widgets';
$_['tab_options'] = 'Options';

$_['button_add_list'] = 'Add widget';
$_['button_update'] = 'Edit';
$_['button_clone_widget'] = 'Clone a widget';
$_['button_continue'] = "Next";


$_['error_delete_old_settings'] = '<div style="color: red; text-align: left; text-decoration: none;">While you cannot delete the configuration of older versions<br><ins style="text-align: left; text-decoration: none; font-size: 13px; color: red;">(re-save "settings", "layout" and "widgets", <br>after this press this button)</ins></div>';
$_['error_permission'] = 'You Have no rights to change the module!';
$_['error_addfields_name'] = 'Not the correct name of the additional fields';

$_['access_777'] = 'Do not have the right to file<br>Set 777 permissions on this file manually.';
$_['ok_create_tables'] = 'Data is successfully updated';
$_['hook_not_delete'] = 'This layout cannot be deleted, it is necessary for the service functions of the module (seo)<br>In case you accidentally delete, add the same pattern with the same parameters<br>';
$_['type_list'] = 'Widget:';
$_['text_about'] = 'SEO multilanguage PRO';
?>