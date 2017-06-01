<?php echo $header; ?>
<div id="content">
<div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
</div>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?><span class="close" style="float:right;cursor: pointer;">( x )</span></div>
<?php } ?>
<div class="box">
<div class="heading">
    <h1><img src="view/image/backup.png" alt="" /> <?php echo $heading_title; ?></h1>
</div>
<div class="content">
<div id="tabs" class="htabs">
    <a href="#tab-import"><?php echo $tab_import; ?></a>
    <a href="#tab-settings"><?php echo $tab_settings; ?></a>
    <a href="#tab-all-colors"><?php echo $tab_all_colors; ?></a>
</div>
<div id="tab-import">
    <form action="<?php echo $import; ?>" method="post" enctype="multipart/form-data" id="import">
        <table class="form">
            <tr>
                <td><?php echo $description_file;?><br /><br /><input type="file" name="upload" id="upload" /></td>
            </tr>
            <tr>
                <td class="buttons"><a onclick="uploadData();" class="button"><span><?php echo $button_import; ?></span></a></td>
            </tr>
        </table>
    </form>
    <div id="ajax" style="display: none;">
        <span id="information"></span>
        <div></div>
    </div>
</div>
<div id="tab-settings">
    <form action="<?php echo $settings; ?>" method="post" enctype="multipart/form-data" id="settings">
        <table class="form">
            <tr>
                <td>
                    <label><?php echo $label_color;?></label>
                    <br /><br />
                    <select name="import_settings_color">
                        <?php
                        foreach($option_description as $key=>$val){ ?>
                        <option value="<?php echo $key?>" <?php if($import_settings_color==$key) echo "selected";?>><?php echo $val?></option>
                        <?php } ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <label><?php echo $label_size;?></label>
                    <br /><br />
                    <select name="import_settings_size">
                        <?php
                        foreach($option_description as $key=>$val){ ?>
                        <option value="<?php echo $key?>"  <?php if($import_settings_size==$key) echo "selected";?>><?php echo $val?></option>
                        <?php } ?>
                    </select>
                </td>
            </tr>
            <tr>
                <td>
                    <label>Separate brands by symbol ","</label>
                    <br /><br />
                    <textarea name="import_settings_brands">
<?php if($import_settings_brands!='') echo $import_settings_brands; else { ?>
Alles,
Ava,
Babell,
Babella,
Cornette,
Donna,
Eldar,
Enny,
Esotiq,
Ewana,
Gabriella,
Gaia,
Gatta,
Gatta bodywear,
Gorsenia,
Gorteks,
Hanna Style,
Henderson,
Henderson ladies,
Julimex,
Kamea,
Key,
Kinga,
L&L,
Lama,
Luna,
Lupoline,
Mat,
Milavitsa,
Mitex,
Nipplex,
Obsessive,
Self,
Taro,
Vena,
Veneziana
                        <?php } ?>
                    </textarea>
                </td>
            </tr>
            <tr>
                <td class="buttons"><a onclick="updateSettings();" class="button"><span><?php echo $button_settings; ?></span></a></td>
            </tr>
            <tr>

            </tr>
        </table>
    </form>
</div>
    <div id="tab-all-colors">
        <form action="<?php echo $import; ?>" method="post" enctype="multipart/form-data" id="import">
            <table class="form">
                <tr>
                    <td><?php echo $description_all_colors;?><br /><br /></td>
                </tr>
                <tr>
                    <td class="buttons"><a onclick="jQuery('#tab-all-colors form').submit();" class="button"><span><?php echo $button_settings; ?></span></a></td>
                </tr>
            </table>
            <table>
                <?php foreach($option_all_color_description as $key=>$val){ ?>
                    <tr>
                        <td class="pl_color" main_id="<?php echo $key;?>"><?php echo $val;?></td>
                        <td class="ru_color" ru_id="<?php echo $key;?>"><span><?php if(isset($option_color_description[$key])) echo $option_color_description[$key]; else echo "Не указан!"; ?></span><td>
                    </tr>
                <?php } ?>
                <div class="hidden_select" style="display: none;">
                    <?php echo $option_color_select_description;?>
                </div>
            </table>
        </form>
        <div id="ajax" style="display: none;">
            <span id="information"></span>
            <div></div>
        </div>
    </div>
</div>
</div>
</div>
<style>
   #ajax {
       width: 350px;
   }
   #ajax span{
       text-align: center;
       display: block;
   }
   #ajax div{width:300px;
        height:20px;
        border:1px solid #303030;
        border-radius:11px;
        background:linear-gradient(to bottom, #323232 0%, #979797 100%);
        margin:20px;
        position:relative;
        overflow:hidden;
    }

    #ajax div::before {content:'';
        width:0%;
        height:100%;
        display:block;
        position:absolute;
        background:linear-gradient(to bottom, #55BDFD 0%, #0690F2 50%, #55BDFD 100%);
        border-radius:10px 0px 0px 10px;
        border:1px solid #008DF2;
        top:0px;
        left:0px;
        box-shadow:3px 0px 3px 0px #47494D;
     }
</style>

<script type="text/javascript">
    $( document ).ready(function() {
        $(document).on('click','.ru_color',function(){
            if(!$(this).hasClass('active_row')){
                $(this).addClass('active_row');
                $(this).find('span').hide();
                var att = $(this).attr('ru_id');
                $('.hidden_select').children().clone().appendTo(this);
                $(this).find('select').find('option[value="'+att+'"]').prop('selected',true);
            }

        });
        $(document).on('change','.colors',function(){
            var new_id = $(this).val();
            var new_text = $(this).find('option:selected').text();
            var old_id = $(this).parent('td').parent('tr').find('.pl_color').attr('main_id');

            var th = this;
            $.ajax({
                url: 'index.php?route=tool/import2/updatecolors&token=<?php echo $this->session->data['token']?>',
                data: { old_id : old_id, new_id:new_id },
                dataType: 'html',
                success: function(data) {
                    $(th).parent('td').attr('ru_id',new_id);
                    $(th).parent('td').parent('tr').find('.pl_color').attr('main_id',new_id);
                    $(th).parent('td').find('span').text(new_text);
                    $(th).parent('td').find('span').show();
                    $(th).remove();
                },
                error: function(xhr, ajaxOptions, thrownError) {
                    alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                }
            });

        });
    });
</script>
<script type="text/javascript"><!--
    $('#tabs a').tabs();

    function sec(){

        $.ajax({
            url: 'index.php?route=tool/import2/ajax&token=<?php echo $this->session->data['token']?>',
            dataType: 'html',
            success: function(json) {
                $('#ajax').find('span').html(json);
                if(json=='Division of the main file into smaller parts finished')
                    $('#ajax div::before').css('width','10%');
                if(json=='Parsing completed')
                    clearInterval(set);
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    }

    //--></script>

<script type="text/javascript"><!--

    function checkFileSize(id) {
        // See also http://stackoverflow.com/questions/3717793/javascript-file-upload-size-validation for details
        var input, file, file_size;

        if (!window.FileReader) {
            // The file API isn't yet supported on user's browser
            return true;
        }

        input = document.getElementById(id);
        if (!input) {
            // couldn't find the file input element
            return true;
        }
        else if (!input.files) {
            // browser doesn't seem to support the `files` property of file inputs
            return true;
        }
        else if (!input.files[0]) {
            // no file has been selected for the upload
            alert( "<?php echo $error_select_file; ?>" );
            return false;
        }
        else {
            file = input.files[0];
            file_size = file.size;
        <?php if (!empty($post_max_size)) { ?>
                // check against PHP's post_max_size
                post_max_size = <?php echo $post_max_size; ?>;
                if (file_size > post_max_size) {
                    alert( "<?php echo $error_post_max_size; ?>" );
                    return false;
                }
            <?php } ?>
        <?php if (!empty($upload_max_filesize)) { ?>
                // check against PHP's upload_max_filesize
                upload_max_filesize = <?php echo $upload_max_filesize; ?>;
                if (file_size > upload_max_filesize) {
                    alert( "<?php echo $error_upload_max_filesize; ?>" );
                    return false;
                }
            <?php } ?>
            return true;
        }
    }

    function uploadData() {
        if (checkFileSize('upload')) {
            $('#import').submit();
        }
    }

    $('span.close').click(function() {
        $(this).parent().remove();
    });
    function isNumber(txt){
        var regExp=/^[\d]{1,}$/;
        return regExp.test(txt);
    }

    function downloadData() {
        if (validateExportForm('export')) {
            $('#export').submit();
        }
    }

    function updateSettings() {
        $('#settings').submit();
    }
    //--></script>

<?php echo $footer; ?>