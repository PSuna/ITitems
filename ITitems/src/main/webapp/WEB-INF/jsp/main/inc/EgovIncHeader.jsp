<%--
  Class Name : EgovIncHeader.jsp
  Description : 화면상단 Header (include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.10   천세훈       최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.04.10
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
function fnMypage(uniqId){
	var uniqId = uniqId;
	location.href="${pageContext.request.contextPath}/uss/myp/MyManage.do?uniqId="+uniqId;
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
			<c:set var="loginUniqId" value="<%= loginVO.getUniqId()%>"/>
			<c:set var="loginAuthorNm" value="<%= loginVO.getAuthorNm()%>"/>
	        <div class="top_menu">
	            <span class="t"><span style="color:black; cursor:pointer;" onclick="javascript:fnMypage('${loginUniqId}')" >${loginName} 님</span>(${loginAuthorNm})</span>
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
        	<c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_ADMIN\") || loginVO.getAuthorCode().equals(\"ROLE_USER_MEMBER\")%>">
	        	<div>
	                <h2 onclick="location.href='/ebt_webapp/ass/MyAssetManagement.do'" style="cursor:pointer">내자산조회</h2>
	            </div>
            </c:if>
            <c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_ADMIN\") || loginVO.getAuthorCode().equals(\"ROLE_HIGH_ADMIN\")%>">
            <div>
                <h2 onclick="location.href='/ebt_webapp/ass/AssetManagement.do'" style="cursor:pointer">전체자산조회</h2>
            </div>
            </c:if>
            <c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_ADMIN\") || loginVO.getAuthorCode().equals(\"ROLE_USER_MEMBER\")%>">
	            <div>
	                <h2 onclick="location.href='/ebt_webapp/ass/AssetRegist.do'" style="cursor:pointer">신규자산등록</h2>
	            </div>
            </c:if>
            <div>
                <h2 onclick="location.href='/ebt_webapp/ass/ReturnRequest.do'" style="cursor:pointer">반출관리</h2>
            </div>
            <div>
                <h2 onclick="location.href='/ebt_webapp/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA'" style="cursor:pointer">공지사항</h2>
            </div>
            <div>
                <h2 onclick="location.href='/ebt_webapp/aprv/ApprovalManage.do'" style="cursor:pointer">결재요청</h2>
            </div>
            <c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_ADMIN\") || loginVO.getAuthorCode().equals(\"ROLE_HIGH_ADMIN\")%>">
            <div class="admin" style="margin-left: 28px;">
                <h2>사이트관리</h2>
                <h3>사용자관리</h3>
                <ul>
                    <li><a href="/ebt_webapp/uss/umt/user/EgovUserManage.do">사용자목록</a></li>
                    <c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_HIGH_ADMIN\")%>">
                    	<li><a href="/ebt_webapp/sec/rgm/EgovAuthorGroupListView.do">사용자별권한관리</a></li>
                    </c:if>
                </ul>
                <c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_HIGH_ADMIN\")%>">
					<h3>메뉴관리</h3>
	                <ul>
	                	<li><a href="/ebt_webapp/sym/mnu/mcm/EgovMenuCreatManageSelect.do">메뉴생성관리</a></li>
	                </ul>
                </c:if>
                <h3>카테고리관리</h3>
                <ul>
                	<li><a href="/ebt_webapp/cat/CategoryManage.do">카테고리목록관리</a></li>
                </ul>

				<h3>프로젝트관리</h3>
                <ul>
                	<li><a href="/ebt_webapp/prj/ProjectManage.do">프로젝트목록관리</a></li>
                </ul>
            </div>
            </c:if>
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
	<c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_ADMIN\")%>">
		<c:set var="orgnztId" value="<%= loginVO.getOrgnztId()%>"/>
		<input type="hidden" id="menuOrgnzt" name="menuOrgnzt" value="<c:out value="${orgnztId}"/>" />
	</c:if>
	<c:set var="start" value="<%=new java.util.Date(new java.util.Date().getTime() - 60*60*24*1000*90L)%>" />
	<input type="hidden" id="menuStartDate" name="menuStartDate" value="<fmt:formatDate value="${start}" pattern="yyyy-MM-dd" />" />
	<c:set var="end" value="<%=new java.util.Date()%>" />
	<input type="hidden" id="menuEndDate" name="menuEndDate" value="<fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />" />
    <input type="hidden" id="baseMenuNo" name="baseMenuNo" value="<%=session.getAttribute("baseMenuNo")%>" />
    <input type="hidden" id="link" name="link" value="" />
    <div style="width:0px; height:0px;">
    <c:forEach var="result" items="${list_menulist}" varStatus="status" > 
        <input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|" />
    </c:forEach>
    </div>
</form>