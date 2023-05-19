<%--
  Class Name : AssetManagement.jsp 
  Description : 자산조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.13   주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.04.13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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

<title>ITitems</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* ********************************************************
 * 프로젝트 검색
 ******************************************************** */
function ProjectSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/prj/ProjectSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 검색 프로젝트 입력
 ******************************************************** */
function returnProject(val){
	
	if (val) {
		document.getElementById("searchPrj").value  = val.prjId;
		document.getElementById("prjNm").value  = val.prjNm;
	}
	
	fn_egov_modal_remove();
}

/* ********************************************************
 * 중분류 조회
 ******************************************************** */
function getMCatList(Mval) {
	let val = document.getElementById('largeCategory').value;
	if(val == ""){
		document.getElementById('middleCategory').replaceChildren();
		let op = document.createElement('option');
		op.textContent = '선택하세요';
		op.value = "";
		document.getElementById('middleCategory').appendChild(op);
	}else{
		$.ajax({
			url: '${pageContext.request.contextPath}/cat/GetMCategoryList.do',
			method: 'POST',
			contentType: 'application/x-www-form-urlencoded',
			data: {'searchUpper' : val},
			success: function (result) {
				document.getElementById('middleCategory').replaceChildren();
				let op = document.createElement('option');
				op.textContent = '선택하세요';
				op.value = "";
				document.getElementById('middleCategory').appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.catId);
					op.textContent = res.catName;
					if(Mval == res.catId){
						op.setAttribute('selected', 'selected');
					}
					document.getElementById('middleCategory').appendChild(op);
				}
			},
			error: function (error) {
				console.log(error);
			}
		})
	}
	
}

/* ********************************************************
 * 자산 검색
 ******************************************************** */
function SearchAssetList() {
	event.preventDefault();
	
	document.frm.pageIndex.value = '1';
    document.frm.action = "<c:url value='/ass/AssetManagement.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * 페이지 이동
 ******************************************************** */
function fn_egov_select_noticeList(pageNo) {
	event.preventDefault()
	document.frm.searchOrgnzt.value = '${searchVO.searchOrgnzt}';
	document.frm.prjNm.value = '${searchVO.prjNm}';
	document.frm.searchPrj.value = '${searchVO.searchPrj}';
	document.frm.searchLCat.value = '${searchVO.searchLCat}';
	document.frm.searchdMCat.value = '${searchVO.searchdMCat}';
//	document.frm.searchStatus.value = '${searchVO.searchStatus}';
	document.frm.startDate.value = '${searchVO.startDate}';
	document.frm.endDate.value = '${searchVO.endDate}';
	document.frm.searchWord.value = '${searchVO.searchWord}';
	document.frm.pageIndex.value = pageNo;
    document.frm.action = "<c:url value='/ass/AssetManagement.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * date input 생성
 ******************************************************** */
function make_date(){
	
	$("#startDate").datepicker(
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});

	$("#endDate").datepicker( 
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
}

/* ********************************************************
 * 자산상세보기 이동
 ******************************************************** */
function selectAsset(id) {
	document.getElementById('subForm'+id).submit;
}

/* ********************************************************
 * Excel
 ******************************************************** */
function fntrsfExcel(){
	if(document.getElementById('noData')){
		alert("엑셀로 다운로드할 목록이 없습니다.")
	}else{
	    document.frm.action = "<c:url value='/com/xlsxTrsfAssetList.do'/>";
	    document.frm.submit();
	}
}

/* ********************************************************
 *  검색 날짜 체크
 ******************************************************** */
function checkEndDate() {
	let startDate = $('#frm #startDate').val();
	let endDate = $('#frm #endDate').val();
	if(startDate != null && startDate > endDate){
		$('#frm #startDate').val(endDate);
		$('#frm #endDate').val("");
	}
}

function checkStartDate(){
	let startDate = $('#frm #startDate').val();
	let endDate = $('#frm #endDate').val();
	if(startDate != null && startDate > endDate){
		$('#frm #endDate').val("");
	}
}

/* ********************************************************
 * onload
 ******************************************************** */
window.onload = function(){
	getMCatList('${searchVO.searchdMCat}');
	make_date();
	  }
//-->
</script>
</head>
<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

	<!-- Skip navigation -->
	<a href="#contents" class="skip_navi">본문 바로가기</a>

	<div class="wrap">
		<!-- Header -->
		<c:import url="/sym/mms/EgovHeader.do" />
		<!--// Header -->

		<div class="container">
			<div class="sub_layout">
				<div class="sub_in">
					<div class="layout">
						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="#LINK">Home</a></li>
										<li><a href="#LINK">자산관리</a></li>
										<li>전체자산조회</li>
									</ul>
								</div>
								<!--// Location -->

								<h1 class="tit_1">자산관리</h1>

								<h2 class="tit_2">전체자산조회</h2>
								<br>
								<!-- 검색조건 -->
								<form id="frm" name="frm" autocomplete="off">
								<input name="startPage" type="hidden" value="<c:out value='${searchVO.startPage}'/>"/>
								<input name="totalRecord" type="hidden" value="<c:out value='${searchVO.totalRecord}'/>"/>
									<div class="condition2">
										<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
										<div class="j_box02">
											<div>
												<span class="lb">부서</span>
												<label class="item f_select w_full" for="sel1"> 
													<select id="searchOrgnzt" name="searchOrgnzt" title="부서">
															<option value="" >선택하세요</option>
															<c:forEach var="orgnztId" items="${orgnztId_result}" varStatus="status">
																<option value="${orgnztId.code}" <c:if test="${searchVO.searchOrgnzt == orgnztId.code}">selected="selected"</c:if>><c:out value="${orgnztId.codeNm}" /></option>
															</c:forEach>
													</select>
												</label> 
											</div>
											
											<div>
												<span class="lb">프로젝트</span> 
												<span class="f_search2 w_full"> <input id="prjNm" name="prjNm" type="text" title="주소" maxlength="100" readonly="false" value="<c:out value="${searchVO.prjNm}"/>" />
													<button type="button" class="btn" onclick="ProjectSearch();">조회</button>
												</span><input name="searchPrj" id="searchPrj" type="hidden" title="프로젝트" value="<c:out value="${searchVO.searchPrj}"/>" maxlength="8" readonly="readonly" />
											</div>
											<div>
												<span class="lb">대분류</span> 
												<label class="item f_select w_full" for="sel1">
												<select id="largeCategory" name="searchLCat" title="대분류" onchange="getMCatList();">
														<option value='' label="선택하세요" />
														<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
															<option value="${LCat.catId}" <c:if test="${searchVO.searchLCat == LCat.catId}">selected="selected"</c:if>><c:out value="${LCat.catName}" /></option>
														</c:forEach>
												</select> 
												
												</label> 
											</div>
																							
											<div>
												<span class="lb">중분류</span> <label class="item f_select w_full" for="sel1"> <select id="middleCategory" name="searchdMCat" title="중분류">
														<option value='' label="선택하세요" />
												</select>
												</label> 
											</div>
										</div>	
											
										<div class="j_box02">	
											<%-- <div>							
												<span class="lb">상태</span> 
												<label class="item f_select w_full" for="sel1"> 
													<select id="searchStatus" name="searchStatus" title="상태">
															<option value='' label="선택하세요" />
															<c:forEach var="stat" items="${status_result}" varStatus="status">
																<option value="${stat.code}" <c:if test="${searchVO.searchStatus == stat.code}">selected="selected"</c:if>><c:out value="${stat.codeNm}" /></option>
															</c:forEach>
													</select>
												</label> 
											</div> --%>
											
											<div class="date_box">
												<span class="lb">등록일자</span> 
												<div>
												<span class="search_date">
												<input class="f_date pty_f_date w_full" type="text" name="startDate" id="startDate" value="<c:out value="${searchVO.startDate}"/>"  readonly="readonly" onchange="checkStartDate()">
												</span>
												―
												 <span class="search_date">
												 <input class="f_date pty_f_date w_full" type="text" name="endDate" id="endDate" value="<c:out value="${searchVO.endDate}"/>"  readonly="readonly" onchange="checkEndDate()">
												 </span>
												 </div>
											</div>	
											<div class="search_box">
												<span class="lb">품명</span>
												<span class="item f_search w_full">
														<!-- <span>검색</span>  -->
													<input class="f_input w_full pty_f_input" type="text" name="searchWord" id="usernm" placeholder="검색어를 입력해주세요" title="검색어" value="<c:out value="${searchVO.searchWord}"/>">
												</span>
											</div>
											<div class="btn_box">
												<button class="btn pty_btn" onclick="SearchAssetList();">검색</button>
											</div>
										</div>
									</div>	
								</form>
								<!--// 검색 조건 -->
								
							
								
								<!-- 게시판 -->
								<div class="board_list selete_table">
									<table>
										<colgroup>
											<col style="width: 6%;">
											<col style="width: 12%;">
											<col style="width: 12%;">
											<col style="width: 15%;">
											<col style="width: 10%;">
											<col style="width: 15%;">
											<col style="width: 15%;">
											<col style="width: 15%;">
										</colgroup>
										<%-- <colgroup>
											<col style="width: 5%;">
											<col style="width: 11%;">
											<col style="width: 11%;">
											<col style="width: 14%;">
											<col style="width: 9%;">
											<col style="width: 13%;">
											<col style="width: 13%;">
											<col style="width: 13%;">
											<col style="width: 11%;">
										</colgroup> --%>
										<thead>
											<tr>
												<th scope="col"></th>
												<th scope="col">대분류</th>
												<th scope="col">중분류</th>
												<th scope="col">품명</th>
												<th scope="col">수량</th>
												<th scope="col">취득일자</th>
												<th scope="col">취득가액</th>
												<th scope="col">등록일자</th>
												<!-- <th scope="col">상태</th> -->
											</tr>
										</thead>
										<tbody>
											<c:forEach var="result" items="${resultList}"
												varStatus="status">
												<tr onclick="childNodes[1].childNodes[1].submit();">
													<td>
														<c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}" />
														<form name="subForm" method="post"
															action="<c:url value='/ass/SelectAsset.do'/>">
															<input type="hidden" name="assetId"
																value="<c:out value='${result.assetId}'/>" />
															<input type="hidden" name="listCode"
																value="AM" />
														</form>
													</td>
													<td><c:out value="${result.largeCategory}" /></td>
													<td><c:out value="${result.middleCategory}" /></td>
													<td><c:out value="${result.assetName}" /></td>
													<td><c:out value="${result.assetQty}" /></td>
													<td><c:out value="${result.acquiredDate}" /></td>
													<td>
														<c:if test="${not empty result.acquiredPrice}">
															<c:out value="${result.acquiredPrice}" />원
														</c:if>
													</td>
													<td><c:out value="${result.regDate}" /></td>
													<%-- <td><c:out value="${result.usageStatus}" /></td> --%>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									<div class="excel_btn">
										<button class="btn pty_btn" onclick="javascript:fntrsfExcel(); return false;">Excel</button>
									</div>
									<c:if test="${empty resultList}">
										<div class="empty" id="noData"><h4><spring:message code="ass.null" /></h4></div>
									</c:if>
								</div>
								<c:if test="${not empty resultList}">
									<!-- 페이지 네비게이션 시작 -->
									<div class="board_list_bot">
										<div class="paging" id="paging_div">
											<ul>
												<ui:pagination paginationInfo="${paginationInfo}"
													type="image" jsFunction="fn_egov_select_noticeList" />
											</ul>
										</div>
									</div>
									<!-- //페이지 네비게이션 끝 -->
								</c:if>
								<!--// 게시판 -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Footer -->
		<c:import url="/sym/mms/EgovFooter.do" />
		<!--// Footer -->
	</div>

</body>
</html>