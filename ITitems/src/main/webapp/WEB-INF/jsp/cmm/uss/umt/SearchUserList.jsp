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
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>

<title>회원 찾기</title>
<script type="text/javaScript" language="JavaScript">
<!--
	function fn_egov_cancel_popup() {
		parent.fn_egov_modal_remove();
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
		<input name="pageIndex" type="hidden" value="<c:out value='${userSearchVO.pageIndex}'/>"/>

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
					<div class="condition">
						<label class="item f_select" for="searchOrgnzt"> <select
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
						</select>
						</label> <label class="item f_select" for="searchCondition"> <select
							name="searchCondition" id="searchCondition" title="검색조건-검색어구분">
								<option value="0"
									<c:if test="${userSearchVO.searchCondition == '0'}">selected="selected"</c:if>>ID</option>
								<option value="1"
									<c:if test="${empty userSearchVO.searchCondition || userSearchVO.searchCondition == '1'}">selected="selected"</c:if>>Name</option>
						</select>
						</label> <span class="item f_search"> <input class="f_input w_250"
							name="searchKeyword" title="검색어" type="text"
							value="<c:out value="${userSearchVO.searchKeyword}"/>" />
							<button class="btn" type="submit"
								onclick="javascript:fnSearch(); return false;">
								<spring:message code='button.inquire' />
							</button> <!-- 조회 -->
						</span>
					</div>
					<!--// 검색조건 -->
					<%-- <div class="board_list_top">
						<div class="left_col">
							<div class="list_count">
								<span>사용자수</span> <strong><c:out
										value="${paginationInfo.totalRecordCount}" /></strong>
								<div style="float: right; display: flex; align-items: center;">
									<span>페이지당 항목 수</span> <label class="item f_select"
										for="pageUnit"> <select name="pageUnit" id="pageUnit"
										title="페이지당 항목 수" onchange="fn_egov_pageview(); return false;">
											<option value="10"
												<c:if test="${empty userSearchVO.pageUnit || userSearchVO.pageUnit == '10'}">selected="selected"</c:if>>10</option>
											<option value="20"
												<c:if test="${userSearchVO.pageUnit == '20'}">selected="selected"</c:if>>20</option>
											<option value="50"
												<c:if test="${userSearchVO.pageUnit == '50'}">selected="selected"</c:if>>50</option>
											<option value="100"
												<c:if test="${userSearchVO.pageUnit == '100'}">selected="selected"</c:if>>100</option>
											<option value="300"
												<c:if test="${userSearchVO.pageUnit == '300'}">selected="selected"</c:if>>300</option>
											<option value="500"
												<c:if test="${userSearchVO.pageUnit == '500'}">selected="selected"</c:if>>500</option>
									</select>
									</label>
								</div>
							</div>
						</div>
					</div> --%>

					<!-- 게시판 -->
					<div class="board_list">
						<table summary="사용자 목록을 제공한다.">
							<caption>사용자목록</caption>
							<colgroup>
								<col style="width: 70px;">
								<col style="width: 200px;">
								<col style="width: 220px;">
								<col style="width: 120px;">
								<col style="width: 80px;">
								<col style="width: 80px;">
								<col style="width: 80px;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">이름</th>
									<th scope="col">아이디</th>
									<th scope="col">전화번호</th>
									<th scope="col">부서</th>
									<th scope="col">직급</th>
									<th scope="col">권한</th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tbody>

								<c:if test="${fn:length(resultList) == 0}">
									<tr>
										<td colspan="8"><spring:message code="common.nodata.msg" /></td>
									</tr>
								</c:if>

								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td><c:out value="${result.userNm}" /></td>
										<td><c:out value="${result.userId}" /></td>
										<td><c:out value="${result.moblphonNo}" /></td>
										<td><c:out value="${result.orgnztId}" /></td>
										<td><c:out value="${result.grade}" /></td>
										<td><c:out value="${result.authorCode}" /></td>
										<td><a href="#LINK" class="btn btn_blue_30 w_80"
											onclick="fn_egov_return('${result.uniqId}', '${result.userNm}', '${result.userId}');">
												선택 </a></td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>

					<!-- 페이지 네비게이션 시작 -->
					<div class="board_list_bot">
						<div class="paging" id="paging_div">
							<ul>
								<ui:pagination paginationInfo="${paginationInfo}" type="image"
									jsFunction="fn_egov_pageview" />
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