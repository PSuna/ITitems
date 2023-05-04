<%--
  Class Name : EgovIncHeader.jsp
  Description : 화면상단 Header (include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/pty_m.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/pty.css">
<script type="text/javaScript" language="javascript">

function fn_egov_modal_create(){
	
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/EgovPageLink.do'/>?" + "link=main/sample_menu/Intro" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1250,
        height: 950
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/**********************************************************
 * 모달 종료 버튼
 ******************************************************** */
function fn_egov_modal_remove() {
	$('#modalPan').remove();
}

</script>

<!-- Header -->
<div class="header">
    <div class="inner">
        <div class="left_col" style="display: flex; align-items: flex-end; font-size:20px;">
            <h1 class="logo"><a href="<c:url value='/'/>cmm/main/mainPage.do"><img src="<c:url value='/'/>images/iteyes_logo.png" alt="표준프레임워크 포털 eGovFrame 샘플 포탈" height="40px"></a></h1>
            <h4>자산관리 솔루션</h4>
            <%-- <a class="go" href="#LINK" onclick="fn_egov_modal_create(); return false;"><img src="<c:url value='/'/>images/ico_question.png" alt="메뉴구성 설명"></a> --%>
        </div>

		<%
			LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
			if(loginVO == null){
		%>
			<div class="top_menu">
	            <span class="t"><span>로그인정보 없음</span> &nbsp</span>
	            <span class="d">로그인후 사용하십시오</span>
	            <a href="<c:url value='/uat/uia/egovLoginUsr.do'/>" class="btn btn_blue_15 w_90">로그인</a>
	        </div>
		<% } else { %>
			<c:set var="loginName" value="<%= loginVO.getName()%>"/>
	        <div class="top_menu">
	            <span class="t"><span onclick="" >${loginName} 님</span> 안녕하세요</span>
	            <a href="<c:url value='/uat/uia/actionLogout.do'/>" class="btn btn_blue_15 w_90">로그아웃</a>
	        </div>
        <% } %>

        <!-- gnb -->
        <div class="gnb">
            <ul>
                <c:forEach var="result" items="${list_headmenu}" varStatus="status">
                	<li><a href="#LINK" onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')" class='<c:if test="${result.menuOrdr >= 5}">manager</c:if>'><c:out value="${result.menuNm}"/></a></li>
                </c:forEach>
                <c:if test="${fn:length(list_headmenu) == 0 }">
                	<li>등록된 메뉴가 없습니다.</li>
                </c:if>
            </ul>
        </div>
        <!-- gnb -->

		<!-- util menu -->
		<%
			if(loginVO == null){
		%>
			<div class="util_menu">
	            <ul>
	                <li></li>
	            </ul>
	        </div>
		<% } else { %>
			<div class="util_menu">
	            <ul>
	                <li><a href="" class="allmenu" title="전체메뉴">전체메뉴</a></li>
	            </ul>
	        </div>
        <% } %>
        <!--// util menu -->
        
    </div>
</div>
<!--// Header -->

<!-- 전체메뉴 팝업 -->
<div class="all_menu" id="">
    <div>
        <div class="inner">
        	<div>
                <h2>자산관리</h2>
                <ul>
                    <li><a href="/ebt_webapp/ass/AssetManagement.do">자산조회</a></li>
                    <li><a href="/ebt_webapp/ass/AssetRegist.do">자산등록</a></li>
                    <li><a href="/ebt_webapp/ass/ReturnRequest.do">반납신청조회</a></li>
                    <li><a href="/ebt_webapp/ass/DisposeRequest.do">처분신청조회</a></li>
                    <li><a href="/ebt_webapp/ass/RepairRequest.do">파손내역조회</a></li>
                </ul>
            </div>
            <div>
                <h2>알림정보</h2>
                <ul>
                    <li><a href="/ebt_webapp/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA">공지사항</a></li>
                </ul>
            </div>

            <div class="admin">
                <h2>사이트관리</h2>
                <h3>사용자관리</h3>
                <ul>
                    <li><a href="/ebt_webapp/uss/umt/user/EgovUserManage.do">사용자관리</a></li>
                    <li><a href="/ebt_webapp/sec/rgm/EgovAuthorGroupListView.do">사용자별권한관리</a></li>
                </ul>

                <h3>카테고리관리</h3>
                <ul>
                	<li><a href="/ebt_webapp/cat/CategoryManage.do">카테고리목록관리</a></li>
                </ul>

				<h3>프로젝트관리</h3>
                <ul>
                	<li><a href="/ebt_webapp/prj/ProjectManage.do">프로젝트목록관리</a></li>
                </ul>

            </div>
        </div>
    </div>
</div>
<!--// 전체메뉴 팝업 -->

<!-- Topmenu start -->
<script type="text/javascript">
<!--
function getLastLink(baseMenuNo){
	var tNode = new Array;
    for (var i = 0; i < document.menuListForm.tmp_menuNm.length; i++) {
        tNode[i] = document.menuListForm.tmp_menuNm[i].value;
        var nValue = tNode[i].split("|");
        //선택된 메뉴(baseMenuNo)의 하위 메뉴중 첫번재 메뉴의 링크정보를 리턴한다.
        if (nValue[1]==baseMenuNo) {
            if(nValue[5]!="dir" && nValue[5]!="" && nValue[5]!="/"){
                //링크정보가 있으면 링크정보를 리턴한다.
                return nValue[5];
            }else{
                //링크정보가 없으면 하위 메뉴중 첫번째 메뉴의 링크정보를 리턴한다.
                return getLastLink(nValue[0]);
            }
        }
    }
}
function goMenuPage(baseMenuNo){
	document.getElementById("baseMenuNo").value=baseMenuNo;
	//document.getElementById("link").value=getLastLink(baseMenuNo);
    //document.menuListForm.chkURL.value=url;
    document.menuListForm.action = "<c:url value='/'/>"+getLastLink(baseMenuNo).substring(1);
    document.menuListForm.submit();
}
function actionLogout()
{
    document.selectOne.action = "<c:url value='/uat/uia/actionLogout.do'/>";
    document.selectOne.submit();
    //document.location.href = "<c:url value='/j_spring_security_logout'/>";
}
//-->
</script>
<!-- // Topmenu end -->

<!-- Menu list -->
<form name="menuListForm" action="" method="post">
	<input type="hidden" id="testData" value="꽥" />
    <input type="hidden" id="baseMenuNo" name="baseMenuNo" value="<%=session.getAttribute("baseMenuNo")%>" />
    <input type="hidden" id="link" name="link" value="" />
    <div style="width:0px; height:0px;">
    <c:forEach var="result" items="${list_menulist}" varStatus="status" > 
        <input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|" />
    </c:forEach>
    </div>
</form>