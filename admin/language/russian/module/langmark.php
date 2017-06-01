<?php
$_['langmark_version']          = '5.5.1';

$_['url_module_text']           = 'SEO мультиязык';
$_['url_create_text']           = '<div style="text-align: center; text-decoration: none;">Создание и обновление<br>данных для модуля<br><ins style="text-align: center; text-decoration: none; font-size: 13px;">(при установке и обновлении модуля)</ins></div>';
$_['url_delete_text']           = '<div style="text-align: center; text-decoration: none;">Удаление всех<br>настроек модуля<br><ins style="text-align: center; text-decoration: none; font-size: 13px;">(все настройки, схемы, виджеты будут удалены)</ins></div>';
$_['url_back_text']             = 'В настройки модуля';
$_['url_modules_text']          = 'В список модулей';


$_['url_opencartadmin']         = 'http://opencartadmin.com';

$_['heading_title']             = ' <div style="height: 21px; margin-top:5px; text-decoration:none;">SEO мультиязык</div>';
$_['heading_dev']               = '&copy; 2013-' . date('Y') . ' All Rights Reserved.';

$_['text_pagination_title']     = 'page';
$_['text_pagination_title_russian'] = 'страница';
$_['text_pagination_title_ukraine'] = 'сторінка';

$_['text_widget_html']          = 'Языковый HTML, HTML вставка';
$_['text_loading']              = "<div style=\'padding-left: 30%; padding-top: 10%; font-size: 21px; color: #008000;\'>Загружается...<img src=\'view/image/langmark-ajax.gif\' style=\'height: 16px;\'><\/div>";
$_['text_loading_small'] 		= "<div style=\'font-size: 19px; padding: 5px; color: #008000;\'>Загружается...<img src=\'view/image/langmark-ajax.gif\' style=\'height: 16px;\'></div>";
$_['text_update']               = 'Нажмите на кнопку.<br>Вы обновили модуль';
$_['text_module']               = 'Модули';
$_['text_add']                  = 'Добавить';
$_['text_action']               = 'Действие:';
$_['text_success']              = 'Модуль успешно обновлен!';
$_['text_content_top']          = 'Содержание шапки';
$_['text_content_bottom']       = 'Содержание подвала';
$_['text_column_left']          = 'Левая колонка';
$_['text_column_right']         = 'Правая колонка';
$_['text_what_lastest']         = 'Последние записи';
$_['text_select_all']           = 'Выделить всё';
$_['text_unselect_all']         = 'Снять выделение';
$_['text_sort_order']           = 'Порядок';
$_['text_further']              = '...';

$_['text_layout_all']           = 'Все';
$_['text_enabled']              = 'Включено';
$_['text_disabled']             = 'Отключено';


$_['entry_pagination']          = 'Пагинация';
$_['entry_pagination_prefix']   = 'Название переменной пагинации';
$_['entry_title_pagination']    = 'Заголовок пагинации';


$_['entry_title_list_latest']   = '<b>Заголовок</b>';
$_['entry_editor']              = 'Графический редактор';
$_['entry_switch'] 			    = 'Включить мультиязычность';
$_['entry_title_prefix'] 	    = 'Языковый префикс<span class="help">Поставьте языковый префикс,<br>например для английского языка <b>en</b><br>(url будет иметь вид: http://site.com/en )<br>Если вы хотите чтобы url с префиксом<br>заканчивался слешем<br>(пример: http://site.com/en/),<br>то поставьте префикс <b>en<ins style="color:green; text-decoration: none;">/</ins></b><br>или оставьте поле <b>пустым</b><br>если у вас этот язык стоит <b>по умолчанию</b></span>';
$_['entry_about'] 			    = 'О модуле';
$_['entry_category_status']     = 'Показывать категорию';
$_['entry_cache_widgets']       = 'Полное кеширование виджетов<br/><span class="help">При полном кешировании виджетов <br>скорость обработки и вывода быстрее в 2-5 раз <br>в зависимости от количества виджетов <br>используемых на странице</span>';
$_['entry_reserved']            = 'Зарезервировано';
$_['entry_service']             = 'Сервис';
$_['entry_langfile']			= 'Языковый пользовательский файл<br><span class="help">формат: <b>папка/файл</b> без расширения</span>';
$_['entry_widget_cached']  		= 'Кешировать виджет<br><span class="help">Имеет больший приоритет, чем полное кеширование <br>всех виджетов в общих настройках, <br>иногда кешировать виджет не надо, <br>если у вас в шаблонах есть логика добавления <br>JS скриптов и CSS стилей в документ</span>';

$_['entry_anchor']			 	= '<b>Привязка</b><br><span class="help" style="line-height: 13px;">привязка к блоку через jquery<br>пример для default темы opencart:<br>$(\'<b>#language</b>\').html(langmarkdata);<br>где langmarkdata (переменная javascript)<br>результат выполнения html блока</span>';


$_['entry_layout']              = 'Схемы:';

$_['entry_html']                = <<<EOF
<b>HTML, PHP, JS код</b><br><span class="help" style="line-height: 13px;">Понимает выполнение PHP кода<br>
Переменные:<br>
\$languages - массив, имеющий структуру:<br>
 [код языка] => Array<br>
        (<br>
&nbsp;&nbsp;            [language_id] => id языка<br>
&nbsp;&nbsp;             [name] => имя языка<br>
&nbsp;&nbsp;             [code] => код языка<br>
&nbsp;&nbsp;             [locale] => locale языка<br>
&nbsp;&nbsp;             [image] => изображение языка<br>
&nbsp;&nbsp;             [directory] => папка<br>
&nbsp;&nbsp;             [filename] => имя языкового файла<br>
&nbsp;&nbsp;             [sort_order] => порядок<br>
&nbsp;&nbsp;             [status] => статус<br>
&nbsp;&nbsp;             [url] => url текущей страницы для языка<br>
        )<br>
<br>
\$text_language - заголовок<br>
для языкового блока
<br>
<br>
\$language_code - текущий код языка
<br>
\$language_prefix - текущий префикс языка
</span>
EOF;

$_['entry_position']            = 'Расположение:';
$_['entry_status']              = 'Статус:';
$_['entry_sort_order']          = 'Порядок:';

$_['entry_template']            = '<b>Шаблон</b>';
$_['entry_what']                = 'what';
$_['entry_install_update']      = 'Установка и обновление';


$_['tab_general']               = 'Схемы';
$_['tab_list']                  = 'Виджеты';
$_['tab_options']               = 'Настройки';
$_['tab_pagination']            = 'Пагинация';

$_['button_add_list']           = 'Добавить виджет';
$_['button_update']           	= 'Изменить';
$_['button_clone_widget']       = 'Клонировать виджет';
$_['button_continue']           = "Далее";

$_['error_delete_old_settings'] = '<div style="color: red; text-align: left; text-decoration: none;">Пока нельзя удалять настройки старых версий<br><ins style="text-align: left; text-decoration: none; font-size: 13px; color: red;">(пересохраните "настройки", "схемы" и "виджеты", <br>только после этого нажмите эту кнопку)</ins></div>';
$_['error_permission']          = 'У Вас нет прав для изменения модуля!';
$_['error_addfields_name']      = 'Не правильное имя дополнительного поля';

$_['access_777']                = 'Не установлены права на файл<br>Установите права 777 на этот файл вручную.';
$_['ok_create_tables']          = 'Данные успешно обновлены';
$_['hook_not_delete']           = 'Данную схему нельзя удалять, она нужна для сервисных функций модуля (seo)<br>В случае, если вы случайно удалили, добавьте такую же схему с такими же параметрами<br>';
$_['type_list']                 = 'Виджет:';
$_['text_about']              	= <<<EOF
<a href="#" onclick="$('#about_license').toggle(); return false;" class="hrefajax">Лицензия</a>
<div id="about_license" style="display: none;">
Все права на модуль принадлежат разработчикам <a href="http://opencartadmin.com">http://opencartadmin.com</a><br>
Данная лицензия распространяется на один домен.<br>
Запрещена передача данного ПО третьим лицам, распространение от своего имени без получения разрешения автора модуля.<br>
Запрещается публикация, распространение модуля без согласия автора в любых целях, будь то ознакомительных или любых других.<br>
Модуль имеет принцип распространения "as is".
</div>
<br>
<a href="#" onclick="$('#about_1551').toggle(); return false;" class="hrefajax">Всем у кого версия opencart 1.5.5.1 или сборки на базе неё</a>
<div id="about_1551" style="display: none;">
Внимание!<br>
В версии 1.5.5.1 opencart и всех сборках на ней есть досадный баг разработчика!<br>
<a href="http://forum.opencart.com/viewtopic.php?f=19&t=94250">http://forum.opencart.com/viewtopic.php?f=19&t=94250</a><br><br>
А именно в <b>index.php</b><br>
со строки 211<br>
Стоит такой порядок<br>
<br>
// SEO URL's<br>
\$controller->addPreAction(new Action('common/seo_url'));<br>
<br>
// Maintenance Mode<br>
\$controller->addPreAction(new Action('common/maintenance'));<br>
<br>
Этот порядок не правильный - баг разработчика opencart, во всех других версиях до него и в версии 1.5.6 исправлено - порядок восстановлен<br>
<br>
Правильный порядок вызова<br>
<br>
// Maintenance Mode<br>
\$controller->addPreAction(new Action('common/maintenance'));<br>
<br>
// SEO URL's<br>
\$controller->addPreAction(new Action('common/seo_url'));<br>
<br>
<br>
Т.е. строка <b>\$controller->addPreAction(new Action('common/maintenance'));</b><br>
должна находиться <b>сразу после \$controller = new Front(\$registry);</b><br>
и перед вызовом seo.<br>
<br>
<br>
Сделайте изменения согласно правильного порядка в файле index.php
</div>
<br>
<a href="#" onclick="$('#about_install').toggle(); return false;" class="hrefajax">Установка</a><br>
<div id="about_install" style="display: none;"><br>
Распакуйте архив и перепишите файлы в корневую папку сайта<br>
Зайдите в меню Дополнения -> Модули (url: /admin/index.php?route=extension/module )<br>
и напротив модуля нажмите ссылку [Установить]<br>
Зайдите в административную часть модуля (ссылка [Изменить])<br>
(url: /admin/index.php?route=module/langmark ) ,<br>
таб: Установка и обновление - нажмите на левую оранжевую кнопку<br>
"Создание и обновление данных для модуля<br>
(при установке и обновлении модуля)"<br>
На этом установка закончена.<br>
</div>
<br>
EOF;
?>