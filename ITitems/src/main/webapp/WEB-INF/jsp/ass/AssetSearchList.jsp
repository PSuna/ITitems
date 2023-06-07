<%--
  Class Name : ProjectSearchList.jsp
  Description : 프로젝트 검색 화면(include)
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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>


<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
<title>프로젝트 찾기</title>

<script type="text/javaScript" language="JavaScript">
	function fn_egov_cancel_popup() {
		parent.fn_egov_modal_remove();
	}

	function fn_egov_return_Prj(prjid, prjNm) {
		var val = new Object();
		val.prjid = prjid;
		val.prjNm = prjNm;

		parent.parent.fn_egov_returnValue(val);
	}

	function fn_egov_pageview(page) {
		document.listForm.searchWord.value = '${searchVO.searchWord}';
		document.listForm.pageIndex.value = page;
		document.listForm.submit();
	}

	function fn_egov_search_Prj() {
		document.listForm.pageIndex.value = 1;
		document.listForm.submit();
	}
	
	
</script>
</head>

<body>
	<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

	<form name="listForm"
		action="<c:url value='/prj/ProjectSearchList.do'/>" method="post" autocomplete="off">

		<input name="searchCondition" type="hidden" size="35" value="4" />

		<!-- 프로젝트 찾기 팝업 -->
		<div class="popup POP_POST_SEARCH">
			<div class="pop_inner">
				<div class="pop_header">
					<h1>프로젝트 찾기</h1>
					<button type="button" class="close"
						onclick="fn_egov_cancel_popup(); return false;">닫기</button>
				</div>
				<div class="pop_container">
			
					<!-- 검색조건 -->
					<form id="frm" name="frm" autocomplete="off">
						<div class="condition2">
							<span class="lb">본부/부서</span>
							<label class="item f_select" for="sel1">
								<select id="searchOrgnzt" name="searchOrgnzt" title="부서">
									<option value="" label="선택하세요" />
									<c:forEach var="orgnztId" items="${orgnztId_result}" varStatus="status">
										<option value="${orgnztId.code}"
											<c:if test="${searchVO.searchOrgnzt == orgnztId.code}">selected="selected"</c:if>>
											<c:out value="${orgnztId.codeNm}" />
										</option>
									</c:forEach>
								</select> 
							</label> 
							<span class="lb">프로젝트</span> 
							<span class="f_search2 w_200">
								<input id="prjNm" name="prjNm" type="text" title="주소" maxlength="100" readonly="false"
									value="<c:out value="${searchVO.prjNm}"/>" />
								<button type="button" class="btn" onclick="ProjectSearch();">조회</button>
							</span>
							<input name="searchPrj" id="searchPrj" type="hidden" title="프로젝트" 
								value="<c:out value="${searchVO.searchPrj}"/>" maxlength="8" readonly="readonly" />
							<br> 
							<span class="lb">대분류</span> 
							<label class="item f_select" for="sel1">
								<select id="largeCategory" name="searchLCat" title="대분류" onchange="getMCatList();">
									<option value='' label="선택하세요" />
									<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
										<option value="${LCat.catId}" 
											<c:if test="${searchVO.searchLCat == LCat.catId}">selected="selected"</c:if>>
											<c:out value="${LCat.catName}"/>
										</option>
									</c:forEach>
								</select> 
							</label> 
							<span class="lb">중분류</span> 
							<label class="item f_select" for="sel1"> 
								<select id="middleCategory" name="searchdMCat" title="중분류">
									<option value='' label="선택하세요" />
								</select>
							</label> 
							<br> 
							<span class="lb">상태</span> 
							<label class="item f_select" for="sel1"> 
								<select id="searchStatus" name="searchStatus" title="상태">
									<option value='' label="선택하세요" />
									<c:forEach var="stat" items="${status_result}" varStatus="status">
										<option value="${stat.code}"
											<c:if test="${searchVO.searchStatus == stat.code}">selected="selected"</c:if>>
											<c:out value="${stat.codeNm}" />
										</option>
									</c:forEach>
								</select>
							</label> 
							<span class="lb ml20">취득일자</span> 
							<input class="f_date" type="date" name="startDate"
								value="<c:out value="${searchVO.startDate}"/>">
							 ― 
							<input class="f_date" type="date" name="endDate"
								value="<c:out value="${searchVO.endDate}"/>"> 
							<span class="item f_search">
								검색 
								<input class="f_input w_130" type="text" name="searchWord" id="usernm" title="검색어"
									value="<c:out value="${searchVO.searchWord}"/>">
							</span>
							<button class="btn" onclick="SearchAssetList();">검색</button>
						</div>
						<input id="pageIndex" name="pageIndex" type="hidden"
							value="${searchVO.pageIndex}" />
					</form>
					<!--// 검색 조건 -->

					<!-- 게시판 -->
					<div class="board_list">
						<table>
							<colgroup>
								<col style="width: 80px;">
								<col style="width: 80px;">
								<col style="width: 150px;">
								<col style="width: 50px;">
								<col style="width: 150px;">
								<col style="width: 100px;">
								<col style="width: 130px;">
								<col style="width: 80px;">
								<col style="width: 100px;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">대분류</th>
									<th scope="col">중분류</th>
									<th scope="col">제품명(모델명)</th>
									<th scope="col">수량</th>
									<th scope="col">취득일자</th>
									<th scope="col">취득가액</th>
									<th scope="col">제조사</th>
									<th scope="col">상태</th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td><c:out value="${result.largeCategory}" /></td>
										<td><c:out value="${result.middleCategory}" /></td>
										<td><c:out value="${result.assetName}" /></td>
										<td><c:out value="${result.histQty}" /></td>
										<td><c:out value="${result.acquiredDate}" /></td>
										<td><c:out value="${result.acquiredPrice}" /></td>
										<td><c:out value="${result.maker}" /></td>
										<td><c:out value="${result.histStatus}" /></td>
										<td>
											<a href="#LINK" class="btn btn_blue_30 w_80"
												onclick="fn_egov_return_Prj( '${resultInfo.prjId}', '${resultInfo.prjName}');">
												선택 
											</a>
										</td>
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
									jsFunction="fn_egov_select_noticeList" />
							</ul>
						</div>
					</div>
					<!-- //페이지 네비게이션 끝 -->
					<!--// 게시판 -->
				</div>
			</div>
		</div>
		<!--// 우편번호 찾기 팝업 -->

	</form>

</body>
</html>