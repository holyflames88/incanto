<?php echo $header; ?>
<div id="content">
    <div class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
        <?php } ?>
    </div>
    <?php if ($error_warning) { ?>
    <div class="warning"><?php echo $error_warning; ?></div>
    <?php } ?>
    <div class="box">
        <div class="heading">
            <h1><img src="view/image/category.png" alt="" /> <?php echo $category_mgr_heading_title; ?></h1>
        </div>
        <div class="content">
            <div id="left-pane" style="float:left;width:320px;height:100%;margin-right:10px">
                <div id="left-pane-toolbar" style="height:40px;width:100%;padding-right:6px">
                    <button onclick="onCategoryAdd(); return false;" type="button" data-toggle="tooltip" title="<?php echo $button_category_add; ?>" class="btn btn-sm btn-primary"><i class="fa fa-plus"></i></button>
                    <button id="btnCategoryEdit" onclick="onCategoryEdit(); return false;" type="button" data-toggle="tooltip" class="btn btn-sm btn-primary" title="<?php echo $button_category_edit; ?>"><i class="fa fa-pencil"></i></button>
                    <button id="btnCategoryDelete" type="button" data-toggle="tooltip" style="margin-left:10px" title="<?php echo $button_category_delete; ?>" class="btn btn-sm btn-danger" onclick="confirm('<?php echo $text_confirm_delete_category; ?>') ? onCategoryDelete() : false;"><i class="fa fa-trash-o"></i></button>
                    <button id="btnCategoryEnable" onclick="onCategoryEnable(); return false;" type="button" style="margin-left:10px" data-toggle="tooltip" title="<?php echo $button_category_enable; ?>" class="btn btn-sm btn-success"><i class="fa fa-eye"></i></button>
                    <button id="btnCategoryDisable" onclick="onCategoryDisable(); return false;" type="button" data-toggle="tooltip" title="<?php echo $button_category_disable; ?>" class="btn btn-sm btn-success"><i class="fa fa-eye-slash"></i></button>
                    <button onclick="onCollapseTree(); return false;" type="button" style="float:right" data-toggle="tooltip" class="btn btn-sm btn-primary" title="<?php echo $button_category_collapse; ?>"><i class="fa fa-angle-double-up"></i></button>
                    <button onclick="onExpandTree(); return false;" type="button" style="float:right;margin-right:6px" data-toggle="tooltip" class="btn btn-sm btn-primary" title="<?php echo $button_category_expand; ?>"><i class="fa fa-angle-double-down"></i></button>
                </div>
                <div id="jstree"></div>
            </div>
            <div id="products-list" style="overflow:hidden">
                <div id="products-toolbar" style="margin-left:14px;margin-top:-1px">
                    <button onclick="onProductAdd(); return false;" type="button" data-toggle="tooltip" class="btn btn-primary" title="<?php echo $button_product_add; ?>"><i class="fa fa-plus"></i></button>
                    <button id="btnProductCopy" onclick="onProductCopy(); return false;" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_product_copy; ?>"><i class="fa fa-copy"></i></button>
					<button id="btnProductRemoveCategory" style="margin-left:10px;" onclick="onProductRemoveCategory(); return false;" data-toggle="tooltip" class="btn btn-default" title="<?php echo $button_product_remove_category; ?>"><i class="fa fa-external-link"></i></button>
					<button id="btnProductDelete" onclick="onProductDelete(); return false;" type="button" data-toggle="tooltip" class="btn btn-danger" title="<?php echo $button_product_delete; ?>"><i class="fa fa-trash-o"></i></button>
                    <button id="btnProductEnable" onclick="onProductSetState(1); return false;" type="button" data-toggle="tooltip" style="margin-left:10px" class="btn btn-success" title="<?php echo $button_product_enable; ?>"><i class="fa fa-eye"></i></button>
                    <button id="btnProductDisable" onclick="onProductSetState(0); return false;" type="button" data-toggle="tooltip" class="btn btn-success" title="<?php echo $button_product_disable; ?>"><i class="fa fa-eye-slash"></i></button>
                </div>
                <table id="products-table"></table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
<!--
window.shift_down = false;
window.drop_state = false;
window.j = $.noConflict(true);
const MIN_W = 640;
const MIN_H = 480

window.j(function() {
    $(document).bind('keydown', function(event) {
        if (event.keyCode == 17 && window.drop_state) {
            $('tr').draggable("option", "cursor", "crosshair");
            $('body').css("cursor", "crosshair");
            window.shift_down = true;
            setOperationLabel();
        }
    });
    $(document).bind('keyup', function(event) {
        if (event.keyCode == 17 && window.drop_state) {
            $('tr').draggable("option", "cursor", "pointer");
            $('body').css("cursor", "pointer");
            window.shift_down = false;
            setOperationLabel();
        }
    });
    window.j('#jstree')
        .jstree({
            'core': {
                'check_callback': function(operation, node, node_parent, node_position, more) {
                    if (operation === 'move_node') {
                        if (node_parent.parent == null) return false;
                    }
                    return true;
                },
                'multiple': true,
                'data': {
                    'url': 'index.php?route=catalog/category_mgr/tree&token=<?php echo $token; ?>',
                    'data': function(node) {
                        return {
                            'id': node.id,
                            'operation': 'get_node'
                        };
                    }
                }
            },
            'plugins': ['<?php echo $category_mgr_script; ?>', 'search', 'wholerow', 'contextmenu'],
            "contextmenu": {
                "items": function($node) {
                    return {
                        "Add": {
                            "icon": "fa fa-plus",
                            "label": "<?php echo $button_category_add; ?>",
                            "action": function(obj) {
                                onCategoryAdd();
                            }
                        },
                        "Create": {
                            "icon": "fa fa-subscript",
                            "label": "<?php echo $button_category_create; ?>",
                            "action": function(obj) {
                                $node = window.j('#jstree').jstree(true).create_node($node);
                                window.j('#jstree').jstree(true).edit($node);
                            }
                        },
                        "Rename": {
                            "icon": "fa fa-eraser",
                            "label": "<?php echo $button_category_rename; ?>",
                            "action": function(obj) {
                                onCategoryRename();
                            }
                        },
                        "Edit": {
                            "icon": "fa fa-pencil",
                            "label": "<?php echo $button_category_edit; ?>",
                            "action": function(obj) {
                                onCategoryEdit();
                            }
                        },
                        "Delete": {
                            "icon": "fa fa-trash-o",
                            "label": "<?php echo $button_category_delete; ?>",
                            "action": function(obj) {
                                confirm('<?php echo $text_confirm_delete_category; ?>') ? onCategoryDelete() : false;
                            }
                        },
                        "Enable": {
                            "icon": "fa fa-eye",
                            "label": "<?php echo $button_category_enable; ?>",
                            "action": function(obj) {
                                onCategoryEnable();
                            }
                        },
                        "Disable": {
                            "icon": "fa fa-eye-slash",
                            "label": "<?php echo $button_category_disable; ?>",
                            "action": function(obj) {
                                onCategoryDisable();
                            }
                        },
                        "View": {
                            "icon": "fa fa-home",
                            "label": "<?php echo $button_view_home; ?>",
                            "action": function(obj) {
                                onCategoryView();
                            }
                        }
                    };
                }
            },
            'dnd': {
                'inside_pos': 0
            }
        })
        .on("create_node.jstree", function(node, data) {
            $.get('index.php?route=catalog/category_mgr/tree&token=<?php echo $token; ?>', {
                    'operation': 'create_node',
                    'parent': data.parent,
                    'name': '<?php echo $text_new_category; ?>'
                })
                .done(function() {
                    window.j('#jstree').jstree("open_node", data.parent);
                    data.instance.refresh();
                })
                .fail(function() {
                    data.instance.refresh();
                });
        })
        .on("rename_node.jstree", function(node, data) {
            $.get('index.php?route=catalog/category_mgr/tree&token=<?php echo $token; ?>', {
                    'operation': 'rename_node',
                    'id': data.node.id,
                    'name': data.node.text
                })
                .fail(function() {
                    data.instance.refresh();
                });
        })
        .on('move_node.jstree', function(e, data) {
            $.get('index.php?route=catalog/category_mgr/tree&token=<?php echo $token; ?>', {
                    'operation': 'move_node',
                    'id': data.node.id,
                    'parent': data.parent,
                    'position': data.position
                })
                .fail(function() {
                    data.instance.refresh();
                });
        })
        .on('refresh.jstree', function() {
            window.j('#jstree').jstree("rename_node", "0", "<?php echo $text_category; ?>");
            if (window.open_node) {
                window.open_node = false;
                var selectedNode = window.j('#jstree').jstree(true).get_selected(false);
                if (selectedNode.length == 1)
                    window.j('#jstree').jstree("open_node", selectedNode);
            }
            if (window.delete_node) {
                window.delete_node = false;
                window.j('#jstree').jstree("select_node", window.delete_parent);
            }
            initDD();

        })
        .on('open_all.jstree', function(node) {
            initDD();
        })
        .on('ready.jstree', function() {
            window.j('#jstree').jstree("open_node", "0");
            window.j('#jstree').jstree("rename_node", "0", "<?php echo $text_category; ?>");
            window.j('#jstree').jstree("select_node", "0");
        })
        .on("changed.jstree", function(e, data) {
            var obj = null;
            var root = true;
            if (data.node !== undefined) {
                obj = data.node.data;
                root = data.node.id == "0";
            }
            checkUIState(obj, data.selected.length, root);
            if (obj != null && data.selected.length == 1) {
                reloadProductList(true);
            }
        });

    window.j('#products-table').bootstrapTable({
        pagination: true,
        sidePagination: 'server',
        method: 'get',
        url: 'index.php?route=catalog/category_mgr/products&token=<?php echo $token; ?>',
        queryParams: function(p) {
            var selectedNodes = window.j('#jstree').jstree(true).get_selected(false);
            var node = (selectedNodes.length == 1) ? node = selectedNodes[0] : 0;
            window.selected_category = node;
            var real_offset = p.offset;
            if (window.reset_offset) {
                real_offset = 0;
                window.reset_offset = false;
            }
            return {
                id: node,
                order: p.order,
                txt: p.search,
                sort: p.sort,
                limit: p.limit,
                offset: real_offset
            };
        },
        cache: false,
        height: 740,
        rowStyle: rowStyle,
        sortName: 'name',
        sortOrder: 'asc',
        toolbar: '#products-toolbar',
        toolbarAlign: 'right',
        searchAlign: 'left',
        striped: false,
        showToggle: true,
        showRefresh: true,
        showColumns: true,
        minimumCountColumns: 0,
        search: true,
        pageSize: 10,
        pageList: [10, 20, 50, 100],
        columns: [{
            field: 'state',
            checkbox: true
        }, {
            field: 'product_id',
            visible: false
        }, {
            field: 'status',
            visible: false
        }, {
            field: 'image',
            title: '<?php echo $column_image; ?>',
            align: 'center',
            valign: 'middle',
            formatter: imgFormatter
        }, {
            field: 'name',
            title: '<?php echo $column_name; ?>',
            valign: 'middle',
            switchable: false,
            align: 'left',
            sortable: true
        }, {
            field: 'model',
            title: '<?php echo $column_model; ?>',
            valign: 'middle',
            sortable: true,
            align: 'left'
        }, {
            field: 'price',
            title: '<?php echo $column_price; ?>',
            align: 'left',
            valign: 'middle',
            sortable: true,
            formatter: priceFormatter
        }, {
            field: 'quantity',
            title: '<?php echo $column_quantity; ?>',
            sortable: true,
            valign: 'middle',
            formatter: quantityFormatter,
            align: 'right'
        }, {
            field: 'sort_order',
            title: '<?php echo $column_sort; ?>',
            sortable: true,
            visible: false,
            valign: 'left',
            align: 'right'   
        }, {
            field: 'status_text',
            title: '<?php echo $column_status; ?>',
            valign: 'middle',
            sortable: true,
            align: 'left'
        }, {
            field: 'action',
            title: '<?php echo $column_action; ?>',
            valign: 'middle',
            switchable: false,
            align: 'right',
            formatter: actionFormatter
        }]
    }).on('all.bs.table', function(e, name, args) {
        initDD();
        checkProductTableUIState();
    }).on('click-row.bs.table', function(e, row, $element) {
        window.selected_products = [row.product_id];

    });

    var selectedNode = window.j('#jstree').jstree(true).get_selected(false);
    checkUIState(null, selectedNode.length, true);

});

$(window).resize(function() {
    window.j('#products-table').bootstrapTable('resetView');
});

function initTarget() {
    $('.jstree-anchor').droppable({
        tolerance: "pointer",
        accept: "tr",
        out: function(event, ui) {
            var target = $(this);
            target.removeClass("accepted-drop");
        },
        over: function(event, ui) {
            var target = $(this);
            var node = window.j('#jstree').jstree(true).get_node(target);
            if (node === undefined || node.id == "0" || node.id == window.selected_category) return;
            target.addClass("accepted-drop");
        },
        drop: function(event, ui) {
            var target = $(this);
            var source = $(ui.draggable);
            var node = window.j('#jstree').jstree(true).get_node(target);
            window.drop_state = false;
            $('body').css("cursor", "default");
            if (node.id == "0" || window.selected_category == node.id) return;
            doMoveProducts(window.selected_category, node.id);
            window.shift_down = false;
        },
        deactivate: function(event, ui) {
            window.drop_state = false;
            var dropItem = $(this);
            $('body').css("cursor", "default");
            dropItem.removeClass("accepted-drop");
        }
    });
}

function doMoveProducts(source, target) {
    var copy = window.shift_down;
    var product_ids = window.selected_products;
    $.ajax({
        type: 'POST',
        cache: false,
        url: 'index.php?route=catalog/category_mgr/move_product&token=<?php echo $token; ?>',
        data: {
            'ids': product_ids,
            'source': source,
            'target': target,
            'copy': copy
        },
        success: function() {
            if (!copy) reloadProductList(true);
        }
    });

}

function initDD() {
    initTarget();
    $('tr').draggable({
        cursorAt: {
            left: -16,
            top: 5
        },
        helper: function(event) {
            var selProducts = window.j('#products-table').bootstrapTable('getSelections');
            if (selProducts.length > 1) {
                $("tr").draggable("option", "opacity", 0.85);
                return $('<button class="btn btn-primary" type="button"><?php echo $text_selected_products; ?>&nbsp;<span class="badge">' + selProducts.length + '</span>&nbsp;<span class="label label-default" id="operation"></span></button>');
            } else {
                var ret = $(this).children('td').eq(1).clone();
                ret.append('&nbsp;<h5><span class="label label-default" id="operation"></span></button></h5>');
                return ret;
            }
        },
        start: function(event, ui) {
            initTarget();
            var selProducts = window.j('#products-table').bootstrapTable('getSelections');
            if (selProducts.length) {
                window.selected_products = [];
                selProducts.forEach(function(value) {
                    window.selected_products.push(value.product_id);
                });
            } else {
                var data = window.j("#products-table").bootstrapTable('getData');
                var indx = $(this).attr('data-index');
                window.selected_products = [data[indx].product_id];
            }

            window.drop_state = true;
            setOperationLabel();
        },
        stop: function(event, ui) {
            window.drop_state = false;
        },

        opacity: 0.5,
        appendTo: "body",
        cursor: "pointer"
    });


}

function reloadProductList(reset_offset) {
    if (reset_offset) window.reset_offset = true;
    window.j("#products-table").bootstrapTable('refresh', {
        silent: true
    });
}

function rowStyle(row, index) {
    if (row.status == "0")
        return {
            classes: 'active'
        };
    return {
        classes: ''
    };
}

function quantityFormatter(value) {
    var cls;
    if (value <= 0) cls = "label-danger";
    else if (value <= 5) cls = "label-warning";
    else cls = "label-success";
    return '<h5><span class="label ' + cls + '">' + value + '</span></h5>';
}

function imgFormatter(value) {
    return '<img src="' + value + '"/>';
}

function statusFormatter(value) {
    return value ? '<?php echo $text_enabled; ?>' : '<?php echo $text_disabled; ?>';
}

function priceFormatter(value, row) {
    if (row.special) {
        return '<span style="text-decoration:line-through">' + value + '</span><br/><span style="color:#b00">' + row.special + '</span>';
    } else {
        return value;
    }
}

function actionFormatter(value, row) {
    var ico;
    var tooltip;
    if (row.status !== "0") {
        ico = 'fa-eye-slash';
        tooltip = '<?php echo $button_product_disable; ?>';
    } else {
        ico = 'fa-eye';
        tooltip = '<?php echo $button_product_enable; ?>';
    }
    var toggle_state_button = '<button onclick="doProductSetState([' + row.product_id + '], ' + (1 - row.status) + '); return false;" type="button" data-toggle="tooltip" class="btn btn-xs btn-success" title="' + tooltip + '"><i class="fa ' + ico + '"></i></button>';

    return	'<button onclick="doProductCopy(['+row.product_id+']); return false;" data-toggle="tooltip" class="btn btn-xs btn-default" title="<?php echo $button_product_clone; ?>"><i class="fa fa-copy"></i></button>' +
			'&nbsp;<button onclick="onProductEdit(' + row.product_id + '); return false;" type="button" data-toggle="tooltip" class="btn btn-xs btn-primary" title="<?php echo $button_product_edit; ?>"><i class="fa fa-pencil"></i></button>&nbsp;' + toggle_state_button +
			'&nbsp;<button onclick="doProductDelete(true, [' + row.product_id + ']); return false;" type="button" data-toggle="tooltip" class="btn btn-xs btn-danger" title="<?php echo $button_product_delete; ?>"><i class="fa fa-trash-o"></i></button>' +
			'&nbsp;<button onclick="doLaunchModalController(\'<?php echo HTTP_CATALOG; ?>' + 'index.php?route=product/product&product_id=' + row.product_id + '\'); return false;" type="button" data-toggle="tooltip" class="btn btn-xs" title="<?php echo $button_view_home; ?>"><i class="fa fa-home"></i></button>';
}

function onProductAdd() {
    onProductEdit(-1);
}

function onProductDelete() {
    var selProducts = window.j('#products-table').bootstrapTable('getSelections');
    if (selProducts.length) {
        if (confirm('<?php echo $text_confirm_delete_products; ?>')) {
            var arr = [];
            selProducts.forEach(function(value) {
                arr.push(value.product_id);
            });
            doProductDelete(false, arr);
        }
    }
}

function onProductSetState(state) {
    var selProducts = window.j('#products-table').bootstrapTable('getSelections');
    if (selProducts.length) {
        var arr = [];
        selProducts.forEach(function(value) {
            arr.push(value.product_id);
        });
        doProductSetState(arr, state)
    }
}

function doProductDelete(ask_confirmation, product_ids) {
    if (!ask_confirmation || (confirm('<?php echo $text_confirm_delete_product; ?>'))) {
        $.ajax({
            type: 'POST',
            cache: false,
            url: 'index.php?route=catalog/category_mgr/delete_product&token=<?php echo $token; ?>',
            data: {
                'ids': product_ids
            },
            success: function() {
                reloadProductList(true);
            }
        });
    }
}

function doProductSetState(product_ids, state) {
    $.ajax({
        type: 'POST',
        cache: false,
        url: 'index.php?route=catalog/category_mgr/state_product&token=<?php echo $token; ?>',
        data: {
            'state': state,
            'ids': product_ids
        },
        success: function() {
            reloadProductList(true);
        }
    });
}

function onProductEdit(product_id) {
    var window_w = window.j(window).width();
    var window_h = window.j(window).height();
    var h = Math.max(window_h * 3 / 4, MIN_H) | 0;
    var w = Math.max(window_w * 3 / 4, MIN_W) | 0;

    $('#dialog').remove();
    var url;
    if (product_id == -1)
        url = 'index.php?route=catalog/product/insert&token=<?php echo $token; ?>';
    else
        url = 'index.php?route=catalog/product/update&token=<?php echo $token; ?>&product_id=' + product_id;
    $('#content').append('<div id="dialog" style="padding:5px"><iframe id="productFormIframe" src="' + url + '" style="padding:0;margin:0;display:block;width:100%;height:100%" frameborder="no" scrolling="auto"></iframe></div>');
    $('#dialog').dialog({
        title: '',
        width: w,
        height: h,
        resizable: true,
        modal: true
    });
    $(".ui-dialog").css("z-index", "3000");
    $('#productFormIframe').load(function() {
        var cnt = $('#productFormIframe').contents();
        if (product_id == -1) {
            // Setup category
            var selectedNode = window.j('#jstree').jstree(true).get_selected(false);
            if (selectedNode.length == 1) {
                var full = "";
                var ids = window.j('#jstree').jstree(true).get_path(selectedNode, '', true);
                ids.shift();
                cnt.find("select[name='main_category_id']").val(selectedNode);

                cnt.find('#product-category div:odd').attr('class', 'odd');
                cnt.find('#product-category div:even').attr('class', 'even');
                cnt.find('#product-category').empty();

                var i = 0,
                    add_subcat = <?php echo $add_subcategories; ?> ;

                ids.forEach(function(value) {
                    if (add_subcat || i == ids.length - 1)
                        cnt.find("input[name='product_category[]'][value='" + value + "']").prop('checked', true);
                    var part = window.j('#jstree').jstree(true).get_text(value);
                    if (full === "")
                        full = part;
                    else
                        full = full + " > " + part;

                    var elem = '<div id="product-category' + value + '">' + full + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="product_category[]" value="' + value + '" /></div>'
                    if (add_subcat || i == ids.length - 1)
                        cnt.find('#product-category').append(elem);
                    i++;

                });

            }
        }
        var saved = cnt.find('div.success').length;
        if (!saved) {
            cnt.find('.breadcrumb').hide();
            cnt.find('#footer').hide();
            cnt.find('#header').hide();
            cnt.find('div.buttons').children().each(function() {
                if ($(this).attr("href") !== undefined) {
                    $(this).removeAttr("href");
                    $(this).click(function() {
                        parent.closeProductDlg(0);
                    });
                }

            });
        } else {
            parent.closeProductDlg(1);
        }

    })
}

function closeCategoryDlg(ok) {
    $('#dialog').dialog('close');
    if (ok) {
        window.open_node = true;
        window.j('#jstree').jstree("refresh");
    }
}

function closeProductDlg(ok) {
    $('#dialog').dialog('close');
    if (ok) {
        window.j("#products-table").bootstrapTable('refresh');
    }
}

function onExpandTree() {
    window.j('#jstree').jstree("open_all");
}

function onCollapseTree() {
    window.j('#jstree').jstree("close_all");
}

function onCategoryView() {
    var selectedNode = window.j('#jstree').jstree(true).get_selected(false);
    doLaunchModalController('<?php echo HTTP_CATALOG; ?>' + 'index.php?route=product/category&path=' + selectedNode);
}

function onCategoryEdit() {
    var selectedNode = window.j('#jstree').jstree(true).get_selected(false);
    if (selectedNode.length == 1) {
        doCategoryEdit(selectedNode);
    }
}

function onCategoryRename() {
    var ref = window.j('#jstree').jstree(true),
        sel = ref.get_selected();
    if (!sel.length) {
        return false;
    }
    sel = sel[0];
    ref.edit(sel);
};

function onCategoryDelete() {
    var selectedNodes = window.j('#jstree').jstree(true).get_selected(false);
    if (selectedNodes.length) {
        var parent = selectedNodes.length > 1 ? "0" : window.j('#jstree').jstree(true).get_parent(selectedNodes);
        doCategoryDelete(selectedNodes, parent);
    }
}

function onCategoryEnable() {
    var selectedNodes = window.j('#jstree').jstree(true).get_selected(false);
    if (selectedNodes.length) {
        doCategoryChangeState(1, selectedNodes);
    }
}

function onCategoryDisable() {
    var selectedNodes = window.j('#jstree').jstree(true).get_selected(false);
    if (selectedNodes.length) {
        doCategoryChangeState(0, selectedNodes);
    }
}

function setButtonState(selector, state) {
    if (state) {
        $(selector).removeClass('disabled').addClass('active');
    } else {
        $(selector).removeClass('active').addClass('disabled');
    }
}

function checkUIState(data, selectedCount, root) {
    checkProductTableUIState();
    if (root) {
        setButtonState('#btnCategoryEnable', false);
        setButtonState('#btnCategoryDisable', false);
        setButtonState('#btnCategoryEdit', false);
        setButtonState('#btnCategoryDelete', false);
        return;
    }
    var status = 0;
    if (data != null)
        status = parseInt(data.status);
    setButtonState('#btnCategoryEnable', selectedCount > 1 || (selectedCount == 1 && status == 0));
    setButtonState('#btnCategoryDisable', selectedCount > 1 || (selectedCount == 1 && status == 1));
    setButtonState('#btnCategoryEdit', selectedCount == 1);
    setButtonState('#btnCategoryDelete', selectedCount > 0);
}

function checkProductTableUIState() {
    var selProducts = window.j('#products-table').bootstrapTable('getSelections').length;
    setButtonState('#btnProductDelete', selProducts > 0);
	setButtonState('#btnProductCopy', selProducts > 0);
    setButtonState('#btnProductEnable', selProducts > 0);
    setButtonState('#btnProductDisable', selProducts > 0);
	
    var selectedNodes = window.j('#jstree').jstree(true).get_selected(false);
    setButtonState('#btnProductRemoveCategory', selProducts > 0 && selectedNodes.length > 0 && selectedNodes[0] != '0');
}

function htmlDecode(value) {
    if (value) {
        return jQuery('<div/>').html(value).text();
    } else {
        return '';
    }
}

function doLaunchModalController(url, parent_id, parent_path) {
    var window_w = window.j(window).width();
    var window_h = window.j(window).height();
    var h = Math.max(window_h * 3 / 4, MIN_H) | 0;
    var w = Math.max(window_w * 3 / 4, MIN_W) | 0;
    $('#dialog').remove();
    $('#content').append('<div id="dialog" style="padding:5px"><iframe id="categoryFormIframe" src="' + url + '" style="padding:0;margin:0;display:block;width:100%;height:100%" frameborder="no" scrolling="auto"></iframe></div>');
    $('#dialog').dialog({
        title: '',
        width: w,
        height: h,
        resizable: true,
        modal: true
    });
    $(".ui-dialog").css("z-index", "3000");
    $('#categoryFormIframe').load(function() {
        var cnt = $('#categoryFormIframe').contents();
        if (parent_id) {
            cnt.find("select[name='parent_id']").val(parent_id);
            cnt.find("input[name='parent_id']").val(parent_id);
            var path = cnt.find("input[name='path']");
            if (path.length) {
                path.val(htmlDecode(parent_path));
            }
        }
        var saved = cnt.find('div.success').length;
        if (!saved) {
            cnt.find('.breadcrumb').hide();
            cnt.find('#footer').hide();
            cnt.find('#header').hide();
            cnt.find('div.buttons').children().each(function() {
                if ($(this).attr("href") !== undefined) {
                    $(this).removeAttr("href");
                    $(this).click(function() {
                        parent.closeCategoryDlg(0);
                    });
                }

            });
        } else {
            parent.closeCategoryDlg(1);
        }

    })
}

function doCategoryChangeState(state, category_ids) {
    $.ajax({
        type: 'POST',
        cache: false,
        url: 'index.php?route=catalog/category_mgr/state&token=<?php echo $token; ?>',
        data: {
            'state': state,
            'ids': category_ids
        },
        success: function() {
            window.j('#jstree').jstree("refresh");
        }
    });
}

function doCategoryDelete(category_ids, parent) {
    $.ajax({
        type: 'POST',
        cache: false,
        url: 'index.php?route=catalog/category_mgr/delete&token=<?php echo $token; ?>',
        data: {
            'ids': category_ids
        },
        success: function() {
            window.delete_node = true;
            window.delete_parent = parent;
            window.j('#jstree').jstree("refresh");
        }
    });
}

function doCategoryEdit(category_id) {
    doLaunchModalController('index.php?route=catalog/category/update&category_id=' + category_id + '&token=<?php echo $token; ?>', 0, '');
}

function onCategoryAdd() {
    var selectedNode = window.j('#jstree').jstree(true).get_selected(false);
    var id = 0;
    var path = "";
    if (selectedNode.length) {
        id = selectedNode[0];
        path = (id == "0") ? "" : window.j('#jstree').jstree(true).get_path(selectedNode, ' > ', false);
        var indx = path.indexOf('>');
        if (indx > 0) {
            path = path.substring(indx + 2);
        }
    }
    doLaunchModalController('index.php?route=catalog/category/insert&token=<?php echo $token; ?>', id, path);
}

function setOperationLabel() {
        var txt = (window.shift_down) ? "<?php echo $text_operation_copy; ?>" : "<?php echo $text_operation_move; ?>";
        $('#operation').text(txt);
}

function onProductCopy() {
    var selProducts = window.j('#products-table').bootstrapTable('getSelections');
    if (selProducts.length) {
        var arr = [];
        selProducts.forEach(function(value) {
            arr.push(value.product_id);
        });
        doProductCopy(arr);
    }
}

function doProductCopy(product_id) {
    var formData = new FormData();
    product_id.forEach(function(value) {
        formData.append('selected[]', value);
    });
    $.ajax({
        url: 'index.php?route=catalog/product/copy&token=<?php echo $token; ?>',
        data: formData,
        processData: false,
        type: 'POST',
        contentType: false,
        mimeType: 'multipart/form-data',
        success: function (data) {
            reloadProductList(true);
        }
    });
}

function onProductRemoveCategory() {
    var selProducts = window.j('#products-table').bootstrapTable('getSelections');
    var selectedNode= window.j('#jstree').jstree(true).get_selected(false);

    if (selectedNode.length && selProducts.length) {
        var arr = [];
        selProducts.forEach(function(value) {
            arr.push(value.product_id);
        });
        var cats = [];
        selectedNode.forEach(function(value) {
            if (value != '0')
                cats.push(value);
        });
        if (cats.length) {
            $.ajax({
                type:  'POST',
                cache:  false ,
                url:  'index.php?route=catalog/category_mgr/remove_product_category&token=<?php echo $token; ?>',
                data:  { 'ids': arr, 'categories': cats},
                success: function() {
                    if (selectedNode.length > 1) {
                        window.j('#jstree').jstree("deselect_all", true);
                        window.j('#jstree').jstree("select_node", "0");
                    }
                    window.open_node = true;
                    window.j('#jstree').jstree("refresh");
                }
            });
        }
    }
}
//-->
</script>
<?php echo $footer; ?>