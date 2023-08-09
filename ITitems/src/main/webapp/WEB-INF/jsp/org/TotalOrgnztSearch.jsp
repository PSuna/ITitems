<%--
  Class Name : EgovMenuCreat.jsp
  Description : 메뉴생성 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/jsh.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>



<script type="text/javaScript">
<!--
var imgpath = "<c:url value='/'/>images/";
//-->
</script>
<script language="javascript1.2" type="text/javaScript" src="<c:url value='/js/EgovMenuCreat.js'/>"></script>
<script language="javascript1.2" type="text/javaScript">
// 값 보내기
function return_val(Id, Nm){
	var val   = new Object();
	val.Id  = Id;
	val.Nm  = Nm;
	val.Group  = "ORG";
	parent.parent.returnTotal(val);
}

// 초기화
function reset_val(){
	var val   = new Object();
	val.Id  = "";
	val.Nm  = "";
	val.Group  = "";
	parent.parent.returnTotal(val);
}
/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}

function TotalPrjSearch(){
    document.listForm.action = "<c:url value='/prj/TotalProjectSearchList.do'/>";
    document.listForm.submit();
}

function TotalUserSearch(){
    document.listForm.action = "<c:url value='/uss/umt/user/TotalSearchUserList.do'/>";
    document.listForm.submit();
}

</script>

</head>

<body>
<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

	<form name="listForm"
		action="<c:url value='/uss/umt/user/TotalSearchUserList.do'/>"
		method="post">
	
	<!-- 프로젝트 찾기 팝업 -->
    <div class="popup POP_POST_SEARCH">
        <div class="pop_inner">
            <div class="pop_header">
                <h1><span class="clickH1" onclick="TotalUserSearch()">회원</span> 부서 <span class="clickH1" onclick="TotalPrjSearch()">프로젝트</span></h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
            	<!-- Tree -->
                <div class="tree_ui tree-ui">
	                <c:forEach var="org" items="${resultList}" varStatus="status" >
	                	<div class="tree_box">
	                		<c:if test="${status.first }">
	                			<img class="action_folder" src="/images/delete-folder.png">
	                			<p onclick=""><c:out value="${org.orgnztNm}" /></p>
	                		</c:if>
		                	<div class="tree_box">
		                		<c:choose>
		                			<c:when test="${status.last}">
		                				<img class="tree_line" src="/images/line2.png">
		                			</c:when>
		                			<c:when test="${!status.first}">
		                				<img class="tree_line" src="/images/line1.png">
		                			</c:when>
		                		</c:choose>
		                		<c:choose>
		                			<c:when test="${!status.first && org.lowCnt == 0}">
		                				<img src="/images/empty-folder.png">
		                			</c:when>
		                			<c:when test="${!status.first}">
		                				<img class="action_folder" src="/images/add-folder.png">
		                			</c:when>
		                		</c:choose>
	                			<c:if test="${!status.first }">
		                			<p><c:out value="${org.orgnztNm}" /></p>
		                		</c:if>
		                	</div>
		                </div>
	                </c:forEach>
                </div>
                <!--// Tree -->
            </div>
        </div>
    </div>
   
	
	
	
    <!-- 그룹 조회 팝업 -->
    <%-- <div class="popup POP_MENU_CREATE">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>메뉴 생성</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <!-- 검색조건 -->
                <div class="condition2">
                    <label for="authorCode" class="lb mr10">권한코드 : </label>
                    <input id="authorCode" class="f_txt item" name="authorCode" type="text" maxlength="30" title="권한코드" value="${resultVO.authorCode}" readonly="readonly">
                    <a href="#LINK" class="item btn btn_blue_46 w_100" onclick="fInsertMenuCreat(); return false;">메뉴생성</a>
                </div>
                <!--// 검색조건 -->

                <!-- Tree -->
                <div class="tree_ui tree-ui">
                
                	<c:forEach var="result1" items="${list_menulist}" varStatus="status" >
                		<input type="hidden" name="tmp_menuNmVal" value="${result1.menuNo}|${result1.upperMenuId}|${result1.menuNm}|${result1.progrmFileNm}|${result1.chkYeoBu}|">
                	</c:forEach>
                	
                 
                    
                </div>
                <!--// Tree -->
            </div>
        </div>
    </div> --%>
    <!--// 그룹 조회 팝업 -->
    
    <input type="hidden" name="req_menuNo">
    
    </form>
    
</body>
</html>