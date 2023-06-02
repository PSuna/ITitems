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
<link rel="stylesheet" href="<c:url value='/'/>css/csh.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>


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
        width: 660,
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
		op.textContent = '중분류';
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
				op.textContent = '중분류';
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
 * 페이지 항목 수 변경
 ******************************************************** */
function setPageUnit(obj) {
	event.preventDefault();
	inputpush();
	document.frm.pageIndex.value = '1';
	document.frm.pageUnit.value = obj.value;
    document.frm.action = "<c:url value='/ass/MyAssetManagement.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * 자산 검색
 ******************************************************** */
function SearchAssetList() {
	event.preventDefault();
	
	document.frm.pageIndex.value = '1';
    document.frm.action = "<c:url value='/ass/MyAssetManagement.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * 페이지 이동
 ******************************************************** */
function fn_egov_select_noticeList(pageNo) {
	event.preventDefault()
	inputpush();
	document.frm.pageIndex.value = pageNo;
    document.frm.action = "<c:url value='/ass/MyAssetManagement.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * input 정리
 ******************************************************** */
 function inputpush() {
	 document.frm.prjNm.value = '${searchVO.prjNm}';
	document.frm.searchPrj.value = '${searchVO.searchPrj}';
	document.frm.searchLCat.value = '${searchVO.searchLCat}';
	document.frm.searchdMCat.value = '${searchVO.searchdMCat}';
	document.frm.startDate.value = '${searchVO.startDate}';
	document.frm.endDate.value = '${searchVO.endDate}';
	document.frm.searchWord.value = '${searchVO.searchWord}';
}
 
 
/* ********************************************************
 * 자산 등록 페이지 이동
 ******************************************************** */
function AssetRegist() {
	event.preventDefault();
    document.frm.action = "<c:url value='/ass/AssetRegist.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * 자산 상세 페이지 이동
 ******************************************************** */
function SelectAsset(assetId) {
	event.preventDefault();
	document.frm.assetId.value = assetId;
    document.frm.action = "<c:url value='/ass/SelectAsset.do'/>";
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
 * Excel
 ******************************************************** */
function fntrsfExcel(){
	if(document.getElementById('noData')){
		alert("엑셀로 다운로드할 목록이 없습니다.")
	}else{
	    document.frm.action = "<c:url value='/com/xlsxTrsfMyAssList.do'/>";
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
										<li>내자산조회</li>
									</ul>
								</div>
								<!--// Location -->
								<h2 class="tit_2">내자산조회</h2>
								<!-- 검색조건 -->
								<form id="frm" name="frm" autocomplete="off" method="post">
									<div class="condition2">
										<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
										<input type="hidden" name="assetId" />
										<input type="hidden" name="listCode" value="MYAM" />
										<div class="j_box01">
											<div>
												<!-- <span class="lb">프로젝트</span> --> 
												<span class="f_search2 w_full"> <input id="prjNm" name="prjNm" type="text" placeholder="프로젝트" maxlength="100" readonly="readonly" value="<c:out value="${searchVO.prjNm}"/>" />
													<button type="button" class="btn" onclick="ProjectSearch();">조회</button>
												</span><input name="searchPrj" id="searchPrj" type="hidden"  value="<c:out value="${searchVO.searchPrj}"/>" maxlength="8" />
											</div>
											<div>
												<!-- <span class="lb">대분류</span> --> 
												<label class="item f_select w_full" for="sel1">
												<select id="largeCategory" name="searchLCat" onchange="getMCatList();">
														<option value='' label="대분류" />
														<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
															<option value="${LCat.catId}" <c:if test="${searchVO.searchLCat == LCat.catId}">selected="selected"</c:if>><c:out value="${LCat.catName}" /></option>
														</c:forEach>
												</select>   
												</label> 
											</div>
																							
											<div>
												<!-- <span class="lb">중분류</span> --> <label class="item f_select w_full" for="sel1"> <select id="middleCategory" name="searchdMCat" >
														<option value='' label="중분류" />
												</select>
												</label> 
											</div>
										</div>	
											
										<div class="j_box01">	
											<%-- <div>							
												<span class="lb">상태</span> 
												<label class="item f_select w_full" for="sel1"> 
													<select id="searchStatus" name="searchStatus" >
															<option value='' label="선택하세요" />
															<c:forEach var="stat" items="${status_result}" varStatus="status">
																<option value="${stat.code}" <c:if test="${searchVO.searchStatus == stat.code}">selected="selected"</c:if>><c:out value="${stat.codeNm}" /></option>
															</c:forEach>
													</select>
												</label> 
											</div> --%>
											<div class="date_box">
												<!-- <span class="lb">등록일자</span>  -->
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
												<!-- <span class="lb">품명/시리얼넘버</span> -->
												<span class="item f_search w_full">
														<!-- <span>검색</span>  -->
													<input class="f_input w_full pty_f_input" type="text" name="searchWord" id="usernm" placeholder="제품명 / 시리얼넘버" value="<c:out value="${searchVO.searchWord}"/>">
												</span>
											</div>
											<div class="btn_box">
												<button class="btn pty_btn" onclick="SearchAssetList();">검색</button>
											</div>  
										</div>
									</div>	
								
								<!--// 검색 조건 -->
								<div class="board_list_top">
									<div class="left_col">
											<div class="list_count">


												<div style="display: flex; justify-content: space-between; align-items: center;" class="pty_margin-bottom_8">
													
													<div>
														<span style="margin:0;">Total : </span> 
														<strong><c:out value="${paginationInfo.totalRecordCount}" /></strong> 
																
													</div>
														
													<div style="display: flex; align-items: center;">
														<span style="margin-right: 16px;">페이지당 항목 수</span> 
														<label class="item f_select" for="pageUnit"> 
																
															<select name="pageUnit" id="pageUnit" onchange="setPageUnit(this); return false;">										
																	<option value="10" <c:if test="${empty searchVO.pageUnit || searchVO.pageUnit == '10'}">selected="selected"</c:if>>10</option>
																	<option value="20" <c:if test="${searchVO.pageUnit == '20'}">selected="selected"</c:if>>20</option>
																	<option value="50" <c:if test="${searchVO.pageUnit == '50'}">selected="selected"</c:if>>50</option>
																	<option value="100" <c:if test="${searchVO.pageUnit == '100'}">selected="selected"</c:if>>100</option>
																	<option value="300" <c:if test="${searchVO.pageUnit == '300'}">selected="selected"</c:if>>300</option>
																	<option value="500" <c:if test="${searchVO.pageUnit == '500'}">selected="selected"</c:if>>500</option>
															</select>
														</label>
													</div>
													
												</div>
												
												
											</div>
										</div>
                                </div>
                                </form>
								<!-- 게시판 -->
								<div class="board_list selete_table">
									<table>
										<colgroup>
											<col style="width: 3%;">
											<col style="width: 8%;">
											<col style="width: 8%;">
											<col style="width: 16%;">
											<col style="width: 16%;">
											<col style="width: 37%;">
											<col style="width: 6%;">
											<col style="width: 6%;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">분류</th>
												<th scope="col">수량</th>
												<th scope="col">제품명</th>
												<th scope="col">시리얼넘버</th>
												<th scope="col">프로젝트</th>
												<th scope="col">수령자</th>
												<th scope="col">실사용자</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="result" items="${resultList}"
												varStatus="status">
												<tr onclick="SelectAsset('${result.assetId}');">
													<td>
														<c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - status.index}" />
													</td>
													<td><c:out value="${result.middleCategory}" /></td>
													<td><c:out value="${result.assetQty}" /></td>
													<td><c:out value="${result.assetName}" /></td>
													<td><c:out value="${result.assetSn}" /></td>
													<td><c:out value="${result.prjId}" /></td>
													<td><c:out value="${result.rcptNm}" /></td>
													<td><c:out value="${result.useNm}" /></td>
													<%-- <td><c:out value="${result.usageStatus}" /></td> --%>
												</tr>
											</c:forEach>
											<c:if test="${empty resultList}">
												<tr>
                               						<td colspan="7" id="noData"><spring:message code="ass.null" /></td>
                               					</tr>
											</c:if>
										</tbody>
									</table>
									<div>
								
								<div class="btn_area">
										<div class="excel_btn pty_margin-left_8">
									<button class="btn pty_btn" onclick="javascript:fntrsfExcel(); return false;">Excel</button>
											<%-- <img src="<c:url value="/" />images/pty_icon_03.png"> --%>								
								</div>
								
                                    	<a href="#LINK" style="margin-left:4px;" class="item btn btn_blue_46" onclick="AssetRegist(); return false;">
                                    	<spring:message code="button.create" /></a><!-- 등록 -->
                                </div>
                                </div>
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