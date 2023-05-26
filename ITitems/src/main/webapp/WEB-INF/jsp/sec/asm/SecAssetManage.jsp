<%--
  Class Name : SecAssetManage.jsp 
  Description : 사이트관리 자산전체현황조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.05.08   천세훈              최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.05.08
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
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
<link rel="stylesheet" href="<c:url value='/'/>css/jsh.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/pty.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>

<title>ITEYES 자산관리솔루션</title>
<script type="text/javascript">
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

function returnProject(val){
	
	if (val) {
		document.getElementById("searchPrj").value  = val.prjId;
		document.getElementById("prjNm").value  = val.prjNm;
	}
	
	fn_egov_modal_remove();
}

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
function getMOrgList(MOval) {
	let val = document.getElementById('orgnztId').value;
	if(val == ""){
		document.getElementById('lowerOrgnzt').replaceChildren();
		let op = document.createElement('option');
		op.textContent = '::부서::';
		op.value = "";
		document.getElementById('lowerOrgnzt').appendChild(op);
	}else{
		$.ajax({
			url: '${pageContext.request.contextPath}/org/GetMOrgnztList.do',
			method: 'POST',
			contentType: 'application/x-www-form-urlencoded',
			data: {'searchUpperOrg' : val},
			success: function (result) {
				document.getElementById('lowerOrgnzt').replaceChildren();
				let op = document.createElement('option');
				op.textContent = '::부서::';
				op.value = "";
				document.getElementById('lowerOrgnzt').appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.orgnztId);
					op.textContent = res.orgnztNm;
					if(MOval == res.orgnztId){
						op.setAttribute('selected', 'selected');
					}
					document.getElementById('lowerOrgnzt').appendChild(op);
				}
			},
			error: function (error) {
				console.log(error);
			}
		})
	}
	
}

function SearchAssetList() {
	event.preventDefault();
	
	document.frm.pageIndex.value = 1;
    document.frm.action = "<c:url value='/sec/asm/SecAssetManage.do'/>";
    document.frm.submit(); 
}
function setPageUnit(){
	document.frm.pageIndex.value = 1;
    document.frm.action = "<c:url value='/sec/asm/SecAssetManage.do'/>";
    document.frm.submit();
}

function fn_egov_select_noticeList(pageNo) {
	event.preventDefault()
	document.frm.searchOrgnzt.value = '${searchVO.searchOrgnzt}';
	document.frm.searchLOrgnzt.value = '${searchVO.searchLOrgnzt}';
	document.frm.prjNm.value = '${searchVO.prjNm}';
	document.frm.searchPrj.value = '${searchVO.searchPrj}';
	document.frm.searchLCat.value = '${searchVO.searchLCat}';
	document.frm.searchdMCat.value = '${searchVO.searchdMCat}';
	document.frm.searchWord.value = '${searchVO.searchWord}';
	document.frm.pageIndex.value = pageNo;
    document.frm.action = "<c:url value='/sec/asm/SecAssetManage.do'/>";
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



window.onload = function(){
	getMCatList('${searchVO.searchdMCat}');
	getMOrgList('${searchVO.searchLOrgnzt}');
	make_date();
}
	  
function selectAsset(id) {
	document.getElementById('subForm'+id).submit;
}

function fntrsfExcel(){
	if(document.getElementById('noData')){
		alert("엑셀로 다운로드할 목록이 없습니다.")
	}else{
	    document.frm.action = "<c:url value='/com/xlsxTrsfAssetList.do'/>";
	    document.frm.submit();
	}
}
</script>
<style type="text/css">
.board_list tbody tr:hover {
	background: #ccc;
	cursor: pointer;
}
.secAssBox{
	display: flex;
    flex-wrap: wrap;
    margin-bottom: 10px;
}
.lb{
	margin-left:10px !important;
}
.condition2+.board_list_top{
	margin-top:0;
	display:flex;
	justify-content: space-between;
    align-items: flex-end;
}
.board_list{
	margin-top:0;
}
</style>
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
						<!-- Left menu -->
						<c:import url="/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->
						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="">Home</a></li>
										<li><a href="">사이트관리</a></li>
										<li>자산전체현황</li>
									</ul>
								</div>
								<!--// Location -->

								<h2 class="tit_2">자산전체현황</h2>
								<br>
								<!-- 검색조건 -->
								<form id="frm" name="frm">
									<div class="condition2">
										<input type="hidden" name="pageIndex" value=1>
										<div class="pty_box01">
											<div>
												<span class="lb">부서</span>
												<label class="item f_select" for="sel1"> 
													<select id="orgnztId" name="searchOrgnzt" title="본부" style=" width: 200px;" onchange="getMOrgList();">
															<option value="" label="::본부::"/>
															<c:forEach var="orgnztId" items="${orgnztId_result}" varStatus="status">
																<option value="${orgnztId.code}" <c:if test="${searchVO.searchOrgnzt == orgnztId.code}">selected="selected"</c:if>><c:out value="${orgnztId.codeNm}" /></option>
															</c:forEach>
													</select>
												</label> 
											</div>
											<div>
												<label class="item f_select" for="sel1">
												<select id="lowerOrgnzt" name="searchLOrgnzt" title="부서">
													<option value='' label="::부서::" />
												</select>
												</label> 
											</div>
											<div>
												<span class="lb">분류</span> 
												<label class="item f_select" for="sel1">
												<select id="largeCategory" name="searchLCat" title="대분류" onchange="getMCatList();">
													<option value='' label="대분류" />
													<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
														<option value="${LCat.catId}" <c:if test="${searchVO.searchLCat == LCat.catId}">selected="selected"</c:if>><c:out value="${LCat.catName}" /></option>
													</c:forEach>
												</select> 
												
												</label> 
											</div>
																							
											<div>
												<label class="item f_select" for="sel1">
												<select id="middleCategory" name="searchdMCat" title="중분류">
													<option value='' label="중분류" />
												</select>
												</label> 
											</div>
										</div>	
											
										<div class="pty_box01">	
											<%-- <div>							
												<span class="lb">상태</span> 
												<label class="item f_select" for="sel1"> 
													<select id="searchStatus" name="searchStatus" title="상태" style=" width: 200px;">
															<option value='' label="선택하세요" />
															<c:forEach var="stat" items="${status_result}" varStatus="status">
																<option value="${stat.code}" <c:if test="${searchVO.searchStatus == stat.code}">selected="selected"</c:if>><c:out value="${stat.codeNm}" /></option>
															</c:forEach>
													</select>
												</label> 
											</div> --%>
											<div style=" width: 355px;">
												<span class="lb">프로젝트</span> 
												<span class="f_search2 w_200"> <input id="prjNm" name="prjNm" type="text" title="주소" maxlength="100" style="width: 283px;" readOnly="true" value="<c:out value="${searchVO.prjNm}"/>" />
													<button type="button" class="btn"style="right: -73px;" onclick="ProjectSearch();">조회</button>
												</span><input name="searchPrj" id="searchPrj" type="hidden" title="프로젝트" value="<c:out value="${searchVO.searchPrj}"/>" maxlength="8" readonly="readonly" />
											</div>
											<%-- <div>
												<span class="lb ml20">취득일자</span> 
												<span class="search_date">
												<input class="f_date pty_f_date w_130" type="text" name="startDate" id="startDate" value="<c:out value="${searchVO.startDate}"/>"  readonly="readonly">
												</span>
												 ― 
												 <span class="search_date">
												 <input class="f_date pty_f_date w_130" type="text" name="endDate" id="endDate" value="<c:out value="${searchVO.endDate}"/>"  readonly="readonly">
												 </span> 
											</div>	 --%>	
											<div class="pty_search">
												<span class="lb" style="margin: 0 8px 0 24px !important;">조회</span>
												<span class="item f_search">
														<!-- <span>검색</span>  -->
													<input class="f_input w_250 pty_f_input" type="text" name="searchWord" id="usernm" placeholder="검색어를 입력해주세요" title="검색어" value="<c:out value="${searchVO.searchWord}"/>">
												</span>
												
												<button class="btn pty_btn" onclick="SearchAssetList();">검색</button>
											</div>
										</div>
									</div>	
								<!--// 검색 조건 -->
								
								<div class="board_list_top">
								<button class="btn pty_btn" id="ExcelBtn" onclick="javascript:fntrsfExcel(); return false;">Excel</button>
									<div style="float: right; display: flex; margin-top:10px; align-items: center;">
										<span>페이지당 항목 수</span> 
										<label class="item f_select" for="pageUnit">
										<select name="pageUnit" id="pageUnit" title="페이지당 항목 수" onchange="setPageUnit(); return false;">
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
								</form>
								<!-- 게시판 -->
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 5%;">
											<col style="width: 11%;">
											<col style="width: 11%;">
											<col style="width: 12%;">
											<col style="width: 8%;">
											<col style="width: 11%;">
											<col style="width: 11%;">
											<col style="width: 11%;">
											<col style="width: 10%;">
											<col style="width: 10%;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col"></th>
												<th scope="col">대분류</th>
												<th scope="col">중분류</th>
												<th scope="col">품명</th>
												<th scope="col">수량</th>
												<th scope="col">취득일자</th>
												<th scope="col">취득가액</th>
												<th scope="col">제조사</th>
												<th scope="col">상태</th>
												<th scope="col">결재</th>
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
													<td><c:out value="${result.maker}" /></td>
													<td><c:out value="${result.usageStatus}" /></td>
													<td><c:out value="${result.approval}" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

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