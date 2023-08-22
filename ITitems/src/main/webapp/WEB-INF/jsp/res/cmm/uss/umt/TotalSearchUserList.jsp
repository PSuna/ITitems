<%--
  Class Name : SearchUserList.jsp
  Description : SearchUserList 화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.17   주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.04.17
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="<c:url value='/'/>css/res/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/page.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/jsh.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>


<script type="text/javaScript" language="JavaScript">
	function fn_egov_cancel_popup() {
		parent.fn_egov_modal_remove();
	}

	function reset_reset() {
		var val = new Object();
		val.Id = "";
		val.Nm = "";
		val.Group  = "";
		parent.parent.returnTotal(val);
	}
	
	function fn_egov_return(Id, Nm) {
		var val = new Object();
		val.Id = Id;
		val.Nm = Nm;
		val.Group  = "USER"; 
		parent.parent.returnTotal(val);
	}

	function fn_egov_pageview(page) {
		document.listForm.searchOrgnzt.value = '${searchVO.searchOrgnzt}';
		document.listForm.searchGrade.value = '${searchVO.searchGrade}';
		document.listForm.searchCondition.value = '${searchVO.searchCondition}';
		document.listForm.searchKeyword.value = '${searchVO.searchKeyword}';
		document.listForm.pageIndex.value = page;
		document.listForm.submit();
	}

	function fn_egov_search_Prj() {
		document.listForm.pageIndex.value = 1;
		document.listForm.submit();
	}
	function fnLinkPage(pageNo){
		inputPush();
		document.listForm.searchKeyword.blur();
	    document.listForm.pageIndex.value = pageNo;
	    document.listForm.action = "<c:url value='/res/uss/umt/user/TotalSearchUserList.do'/>";
	    document.listForm.submit();
	}
	function fnSearch(){
	    document.listForm.pageIndex.value = 1;
	    document.listForm.action = "<c:url value='/res/uss/umt/user/TotalSearchUserList.do'/>";
	    document.listForm.submit();
	}
	function inputPush(){
		document.listForm.searchKeyword.value = '${userSearchVO.searchKeyword}';
		
	}
	function TotalPrjSearch(){
	    document.listForm.pageIndex.value = 1;
	    document.listForm.searchKeyword.value = "";
	    document.listForm.action = "<c:url value='/res/prj/TotalProjectSearchList.do'/>";
	    document.listForm.submit();
	}
	function TotalOrgSearch(){
	    document.listForm.pageIndex.value = 1;
	    document.listForm.searchKeyword.value = "";
	    document.listForm.action = "<c:url value='/res/org/TotalOrgnztSearch.do'/>";
	    document.listForm.submit();
	}
	
</script>
</head>

<body>
	<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

	<form name="listForm"
		action="<c:url value='/res/uss/umt/user/TotalSearchUserList.do'/>"
		method="post">
		<input name="selectedId" type="hidden" />
		<input name="checkedIdForDel" type="hidden" />
		<input name="pageIndex" type="hidden" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
		<input name="firstIndex" type="hidden" value="<c:out value='${userSearchVO.firstIndex}'/>"/>
		<input name="recordCountPerPage" type="hidden" value="<c:out value='${userSearchVO.recordCountPerPage}'/>"/>

		<!-- 프로젝트 찾기 팝업 -->
		<div class="popup POP_POST_SEARCH">
			<div class="pop_inner">
				<div class="pop_header">
					<h1>회원 <span class="clickH1" onclick="TotalOrgSearch()">부서</span> <span class="clickH1" onclick="TotalPrjSearch()">프로젝트</span></h1>
					<button type="button" class="close"
						onclick="fn_egov_cancel_popup(); return false;">닫기</button>
				</div>

				<div class="pop_container pop_search">
					<!-- 검색조건 -->
					<div class="condition2" style="justify-content: center;">
						<div class="j_box06">
							<div class="search_box">
								<span class="item f_search w_full">
									<input class="f_input w_full pty_f_input" type="text" name="searchKeyword" placeholder="검색어를 입력해주세요" title="검색어" value="<c:out value="${userSearchVO.searchKeyword}"/>">
								</span>
							</div>
							<div class="btn_box" >
								<button class="btn pty_btn" onclick="javascript:fnSearch(); return false;">검색</button>
			                   	<a href="#LINK" style="margin-left:8px;" class="item btn btn_blue_46" onclick="reset_reset(); return false;">
			                   	<spring:message code="button.reset" /></a>
		               	 	</div>
	               	 	</div>
					</div>
					<!--// 검색조건 -->
					<!-- 게시판 -->
					<div class="board_list selete_table">
						<table summary="사용자 목록을 제공한다.">
							<caption>사용자목록</caption>
							<colgroup>
								<col style="width: 25%;">
								<col style="width: 25%;">
								<col style="width: 25%;">
								<col style="width: 25%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">사용자명</th>
									<th scope="col">전화번호</th>
									<th scope="col">부서</th>
									<th scope="col">직급</th>
								</tr>
							</thead>
							<tbody>

								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="8"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>

								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr onclick="fn_egov_return('${result.uniqId}', '${result.userNm}');">
										<td><c:out value="${result.userNm}" /></td>
										<td><c:out value="${result.moblphonNo}" /></td>
										<td><c:out value="${result.orgnztId}" /></td>
										<td><c:out value="${result.grade}" /></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>

					<!-- 페이지 네비게이션 시작 -->
					<c:if test="${!empty userSearchVO.pageIndex }">
	                    <div class="board_list_bot">
		                    <div class="paging" id="paging_div">
		                    	<ul>
		                        	<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fnLinkPage" />
		                        </ul>
		                    </div>
	                    </div>
                    </c:if>
					<!-- // 페이지 네비게이션 끝 -->
					<!--// 게시판 -->
				</div>
			</div>
		</div>
		<!--// 우편번호 찾기 팝업 -->

	</form>

</body>
</html>