/* ********************************************************
 * 등록확인 팝업창
 ******************************************************** */
 function RegistConfirm(){
	 var $dialog = $('<div id="modalPan" class=""></div>')
		.html('<iframe style="border: 0px; " src="' + "/res/com/RegistConfirm.do" +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open'); 
}

/* ********************************************************
 * 등록진행 팝업창 
 ******************************************************** */
 function RegistIng(){
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "/res/com/RegistIng.do" +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}


/* ********************************************************
 * 등록완료 팝업창
 ******************************************************** */
 function RegistSuccess(){
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "/res/com/RegistSuccess.do" +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}

/* ********************************************************
 * 삭제요청확인 팝업창
 ******************************************************** */
 function DelReqConfirm(val){
	 var $dialog = $('<div id="modalPan" class=""></div>')
		.html('<iframe style="border: 0px; " src="' + "/res/com/DelReqConfirm.do?val="+ val +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open'); 
}

/* ********************************************************
 * 삭제요청진행 팝업창 
 ******************************************************** */
 function DelReqIng(val){
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "/res/com/DelReqIng.do?val="+ val +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}


/* ********************************************************
 * 삭제요청완료 팝업창
 ******************************************************** */
 function DelReqSuccess(val){

	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "/res/com/DelReqSuccess.do?val="+ val +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}

/* ********************************************************
 * 삭제실패 팝업창
 ******************************************************** */
 function DelReqFail(val){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "/res/com/DelReqFail.do?val="+ val +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}
