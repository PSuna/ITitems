/* ********************************************************
 * 제품사진 안내
 ******************************************************** */
function PhotoManual(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "/res/ass/PhotoManual.do" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 500
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 시리얼넘버 안내
 ******************************************************** */
function AssetSnManual(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "/res/ass/AssetSnManual.do" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 450
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 지급확인서 안내
 ******************************************************** */
function FileManual(){
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "/res/ass/FileManual.do" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}
