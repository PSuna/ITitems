/* ********************************************************
 * 프로젝트 검색
 ******************************************************** */
function ProjectSearch(){
    
    var $dialog = $('<div id="modalPan" class="SearchList"></div>')
	.html('<iframe style="border: 0px; " src="' + "/prj/ProjectSearchList.do" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
} 
   
/* ********************************************************
 * 회원 검색
 ******************************************************** */
function UserSearch(ch){
	userCheck = ch;
    
    var $dialog = $('<div id="modalPan" class="SearchList"></div>')
	.html('<iframe style="border: 0px; " src="' + "/uss/umt/user/SearchUserList.do" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 시리얼넘버 중복
 ******************************************************** */
function AssetSnCnfirm(){
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "/ass/AssetSnCnfirmView.do" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 375,
        height: 420
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 전체검색(회원) 검색
 ******************************************************** */
function TotalUserSearch(ch){
	userCheck = ch;
    var $dialog = $('<div id="modalPan" class="SearchList"></div>')
	.html('<iframe style="border: 0px; " src="' + "/uss/umt/user/TotalSearchUserList.do" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}
