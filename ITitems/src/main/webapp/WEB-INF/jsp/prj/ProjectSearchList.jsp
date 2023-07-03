<%--
  Class Name : ProjectSearchList.jsp
  Description : ProjectSearchList 화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.17   주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.04.17
--%>
<%@ page contentType="text/html; charset=utf-8"%>
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


<script type="text/javaScript" language="JavaScript">
function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}

function fn_egov_return_Prj(prjid, prjNm, pmId, pmNm){
	var val   = new Object();
	val.prjId  = prjid;
	val.prjNm  = prjNm;
	val.pmId  = pmId;
	val.pmNm  = pmNm;
	
	parent.parent.returnProject(val);
}

function reset_Prj(){
	var val   = new Object();
	val.prjId  = "";
	val.prjNm  = "";
	val.pmId  = "";
	val.pmNm  = "";
	
	parent.parent.returnProject(val);
}

function fn_egov_pageview(page){
	inputPush();
	document.listForm.searchWord.blur();
	document.listForm.pageIndex.value = page;
	document.listForm.action = "<c:url value='/prj/ProjectSearchList.do'/>";
   	document.listForm.submit();
}

function fn_egov_search_Prj() {
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}
function inputPush(){
	document.listForm.searchWord.value = '${searchVO.searchWord}'
}

</script>
</head>

<body>
<!-- 자바스크립트 경고 태그  -->
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

	<form name="listForm" action="<c:url value='/prj/ProjectSearchList.do'/>" method="post">
    
    <input name="searchCondition" type="hidden" size="35" value="4" />
    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>

	<!-- 프로젝트 찾기 팝업 -->
    <div class="popup POP_POST_SEARCH">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>프로젝트 찾기</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container pop_search">
                <!-- 검색조건 -->
                <div class="condition2" >
                	<div class="j_box06">
	                	<div class="search_box">
		                    <span class="item f_search w_full">
		                        <input class="f_input w_full pty_f_input" name="searchWord" placeholder="프로젝트명 검색" value="<c:out value="${searchVO.searchWord}"/>" type="text"  maxlength="20"/>
		                    </span>
	                    </div>
	                    <div class="btn_box">
		                    <button class="btn pty_btn" style="margin-left:8px;" onclick="javascript:fn_egov_search_Prj(); return false;">검색</button>
		                   	<a href="#LINK" style="margin-left:8px;" class="item btn btn_blue_46" onclick="reset_Prj(); return false;">
		                   	<spring:message code="button.reset" /></a><!-- 등록 -->
	               	 	</div>
               	 	</div>
                </div>
                <!--// 검색조건 -->
				
                <!-- 게시판 -->
                <div class="board_list selete_table">
                    <table summary="프로젝트 건색 결과를 알려주는 테이블입니다.">
                        <colgroup>
                            <col style="width: 40%;">
                            <%-- <col style="width: 27%;"> --%>
                            <col style="width: 20%;">
                            <col style="width: 30%;">
                            <col style="width: 10%;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">프로젝트명</th>
                                <!-- <th scope="col">기간</th> -->
                                <th scope="col">PM</th>
                                <th scope="col">고객사</th>
                                <th scope="col">상태</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                            <tr onclick="fn_egov_return_Prj( '${resultInfo.prjId}', '${resultInfo.prjName}','${resultInfo.id}','${resultInfo.name}');">
                                <td>${resultInfo.prjName}</td>
                                <%-- <td>${resultInfo.prjStart} ― ${resultInfo.prjEnd}</td> --%>
                                <td>${resultInfo.name} ${resultInfo.position}</td>
                                <td>${resultInfo.client}</td>
                                <td>${resultInfo.prjState}</td>
                            </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

				<!-- 페이지 네비게이션 시작 -->
                <div class="board_list_bot">
                    <div class="paging" id="paging_div">
                        <ul>
                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_pageview" />
                        </ul>
                    </div>
                </div>
                <!-- // 페이지 네비게이션 끝 -->
                <!--// 게시판 -->
            </div>
        </div>
    </div>
    <!--// 우편번호 찾기 팝업 -->
   
	</form>
    
</body>
</html>