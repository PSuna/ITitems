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
<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
<link rel="stylesheet" href="<c:url value='/'/>css/pty_m.css">
<link rel="stylesheet" href="<c:url value='/'/>css/pty.css">
<link rel="stylesheet" href="<c:url value='/'/>css/jsh.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>


<script type="text/javaScript" language="JavaScript">
<!--
	function fn_egov_cancel_popup() {
		parent.fn_egov_modal_remove();
	}

	function reset_reset() {
		var val = new Object();
		val.userId = "";
		val.userNm = "";
		val.address = "";
		parent.parent.returnUser(val);
	}
	
	function fn_egov_return(userId, userNm, address) {
		var val = new Object();
		val.userId = userId;
		val.userNm = userNm;
		val.address = address
		parent.parent.returnUser(val);
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
	    document.listForm.pageIndex.value = pageNo;
	    document.listForm.action = "<c:url value='/uss/umt/user/SearchUserList.do'/>";
	    document.listForm.submit();
	}
	function fnSearch(){
	    document.listForm.pageIndex.value = 1;
	    document.listForm.action = "<c:url value='/uss/umt/user/SearchUserList.do'/>";
	    document.listForm.submit();
	}//-->
</script>
</head>

<body>
	<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

	<form name="listForm"
		action="<c:url value='/uss/umt/user/SearchUserList.do'/>"
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
					<h1>회원 찾기</h1>
					<button type="button" class="close"
						onclick="fn_egov_cancel_popup(); return false;">닫기</button>
				</div>

				<div class="pop_container">
					<!-- 검색조건 -->
					<div class="condition" style="justify-content: center;">
						<%-- <label class="item f_select" for="searchOrgnzt"> <select
							id="searchOrgnzt" name="searchOrgnzt" title="검색조건-부서"
							onchange="javascript:fnSearch(); return false;">
								<option value="" label="부서" />
								<c:forEach var="orgnztId" items="${orgnztId_result}">
									<option value="<c:out value="${orgnztId.code}"/>"
										<c:if test="${userSearchVO.searchOrgnzt == orgnztId.code}">selected="selected"</c:if>>${orgnztId.codeNm}</option>
								</c:forEach>
						</select>
						</label> <label class="item f_select" for="searchGrade"> <select
							id="searchGrade" name="searchGrade" title="검색조건-직급"
							onchange="javascript:fnSearch(); return false;">
								<option value="" label="직급" />
								<c:forEach var="grade" items="${grd_result}">
									<option value="<c:out value="${grade.code}"/>"
										<c:if test="${userSearchVO.searchGrade == grade.code}">selected="selected"</c:if>>${grade.codeNm}</option>
								</c:forEach>
						</select> --%>
						<%-- </label> <label class="item f_select" for="searchCondition"> <select
							name="searchCondition" id="searchCondition" title="검색조건-검색어구분">
								<option value="0"
									<c:if test="${userSearchVO.searchCondition == '0'}">selected="selected"</c:if>>사용자ID</option>
								<option value="1"
									<c:if test="${empty userSearchVO.searchCondition || userSearchVO.searchCondition == '1'}">selected="selected"</c:if>>사용자명</option>
						</select>
						</label> --%> 
						<div class="pty_search">
							<span class="item f_search">
								<input class="f_input w_250 pty_f_input" style="margin-right:8px;" type="text" name="searchKeyword" placeholder="검색어를 입력해주세요" title="검색어" value="<c:out value="${userSearchVO.searchKeyword}"/>">
							</span>
							<button class="btn pty_btn" onclick="javascript:fnSearch(); return false;">검색</button>
						</div>
						<div class="btn_area"style="margin-top:0px !important;">
		                   	<a href="#LINK" style="margin-left:8px;" class="item btn btn_blue_46" onclick="reset_reset(); return false;">
		                   	<spring:message code="button.reset" /></a><!-- 등록 -->
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
									<tr onclick="fn_egov_return('${result.uniqId}', '${result.userNm}', '${result.userId}');">
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