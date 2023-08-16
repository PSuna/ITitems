<%--
  Class Name : ReturnRequest.jsp 
  Description : 반납신청조회 화면
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<link rel="stylesheet" href="<c:url value='/'/>css/csh.css">
<script src="<c:url value='/'/>js/EditDate.js"></script>
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>

<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>

<script type="text/javascript">
window.onload = function(){
	make_date();
}

/* ********************************************************
 * 프로젝트검색
 ******************************************************** */
function ProjectSearch(){
    var $dialog = $('<div id="modalPan" class="SearchList"></div>')
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
 * 프로젝트 반환
 ******************************************************** */
function returnProject(val){
	
	if (val) {
		document.getElementById("searchPrj").value  = val.prjId;
		document.getElementById("prjNm").value  = val.prjNm;
	}
	
	fn_egov_modal_remove();
}

/* ********************************************************
 * 검색
 ******************************************************** */
function SearchCarryList() {
	event.preventDefault();

	document.frm.pageIndex.value = '1';
    document.frm.action = "<c:url value='/req/CarryRequset.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 *  페이지 이동
 ******************************************************** */
function fn_egov_select_noticeList(pageNo) {
	event.preventDefault();
	inputPush();
	document.frm.prjNm.value = '${searchVO.prjNm}';
	document.frm.searchPrj.value = '${searchVO.searchPrj}';
	document.frm.searchStatus.value = '${searchVO.searchStatus}';
	document.frm.startDate.value = '${searchVO.startDate}';
	document.frm.endDate.value = '${searchVO.endDate}';
	document.frm.pageIndex.value = pageNo;
    document.frm.action = "<c:url value='/req/CarryRequset.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * date input 생성
 ******************************************************** */
function make_date(){
	
	$("#startDate,#endDate").datepicker(
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
 *  검색 날짜 체크
 ******************************************************** */
function checkEndDate() {
	let startDate = $('#searchVO #startDate').val();
	let endDate = $('#searchVO #endDate').val();
	if(startDate != null && startDate > endDate){
		$('#searchVO #startDate').val(endDate);
		$('#searchVO #endDate').val("");
	}
}
function checkStartDate(){
	let startDate = $('#searchVO #startDate').val();
	let endDate = $('#searchVO #endDate').val();
	if(startDate != null && startDate > endDate){
		$('#searchVO #endDate').val("");
	}
}

/* ********************************************************
 *  반출신청 폼 이동
 ******************************************************** */
function CarryRegist() {
	document.frm.action = "<c:url value='/req/CarryRegist.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 *  반입신청 폼 이동
 ******************************************************** */
function CarryInRegist() {
	document.frm.action = "<c:url value='/req/CarryInRegist.do'/>";
    document.frm.submit();
}

/* ********************************************************
 *  반출입상세보기 화면 이동
 ******************************************************** */
function SelectCarry(reqId) {
	document.frm.reqId.value = reqId;
    document.frm.action = "<c:url value='/req/SelectCarry.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 *  현재 리스트 엑셀 추출
 ******************************************************** */
function fntrsfExcel(){
	inputPush();
	if(document.getElementById('noData')){
		alert("엑셀로 다운로드할 목록이 없습니다.")
	}else{
	    document.frm.action = "<c:url value='/com/xlsxTrsfReqList.do'/>";
	    document.frm.submit();
	}
}

/* ********************************************************
 *  페이지당 리스트 수 설정
 ******************************************************** */
function setPageUnit(){
	inputPush();
	document.frm.pageIndex.value = 1;
    document.frm.action = "<c:url value='/req/CarryRequset.do'/>";
    document.frm.submit();
}
/* ********************************************************
 *  인풋값 정리
 ******************************************************** */
function inputPush(){
	document.frm.searchGroup.value='${searchVO.searchGroup}';
	document.frm.searchStatus.value='${searchVO.searchStatus}';
	document.frm.searchPrj.value='${searchVO.searchPrj}';
	document.frm.startDate.value='${searchVO.startDate}';
	document.frm.endDate.value='${searchVO.endDate}';
	document.frm.searchWord.value='${searchVO.searchWord}';
}



function resizeDate(width) {
		if(width>425){
			$(".resizeDate").each(function(index, item){
				let str = $(item).text();
				if(str.indexOf('.') != -1){
					$(item).text();
					let newDate = moment(str,'YY.MM.DD').format('YYYY-MM-DD');
					$(item).text(newDate);
				}else{
					return;
				}
			})
		}else{
			$(".resizeDate").each(function(index, item){
				let str = $(item).text();
				if(str.indexOf('-') != -1){
					$(item).text();
					let newDate = moment(str,'YYYY-MM-DD').format('YY.MM.DD');
					$(item).text(newDate);
				}else{
					return;
				}
			})
		}
	
}
$(window).resize(function(){
	const width = window.innerWidth;
	resizeDate(width);
});
window.onload = function(){
	resizeDate(window.innerWidth);
	};

</script>
<style type="text/css">
.board_view_bot {
	overflow: hidden;
}

.right_btn {
	float: right;
}

.board_list tbody tr:hover {
	background: #ccc;
	cursor: pointer;
}
.condition2 .j_box01, .condition2 .j_box02, .condition2 .j_box03{
	align-items: center;
}
.req_box{
	margin-bottom:10px;
	margin-top: 10px;
}
@media screen and (max-width: 1400px){
	.req_box{
		margin-bottom:10px;
		margin-top: 0;
	}
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

						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="#LINK">Home</a></li>
										<li><a href="#LINK">자산관리</a></li>
										<li>반출입</li>
									</ul>
								</div>
								<!--// Location -->
								<h2 class="tit_2">반출입</h2>
								<!-- 검색조건 -->
								<form id="searchVO" name="frm" method="post" action="<c:url value='/req/CarryRequest.do'/>" autocomplete="off">
									<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" >
									<input name="reqId" type="hidden"/>
									<div class="condition2">
											<div class="j_box01">
												<div>

													<label class="item f_select w_full" for="searchGroup">
														<select id="searchGroup" name="searchGroup" title="분류" onchange="SearchCarryList(); return false;">
															<option value="" label="분류" />
															<option value="C0" <c:if test="${searchVO.searchGroup == 'C0'}">selected="selected"</c:if> label="반입신청" />
															<option value="C1" <c:if test="${searchVO.searchGroup == 'C1'}">selected="selected"</c:if>label="반출신청" />
													</select>
													</label>

												</div>
												<div>
													<label class="item f_select w_full" for="sel1"> <select
														id="searchStatus" name="searchStatus" title="상태"
														onchange="SearchCarryList();">
															<option value='' label="신청상태" selected="selected" />
															<c:forEach var="stat" items="${status_result}"
																varStatus="status">
																<option value="${stat.code}"
																	<c:if test="${searchVO.searchStatus == stat.code}">selected="selected"</c:if>><c:out
																		value="${stat.codeNm}" /></option>
															</c:forEach>
													</select>
													</label>
												</div>

												<div>
													<!-- <span class="lb">프로젝트</span> -->
													<span class="f_search2 w_full"> <input id="prjNm"
														name="prjNm" type="text" title="프로젝트"
														value="<c:out value="${searchVO.prjNm}"/>" maxlength="100"
														placeholder="프로젝트" readonly="true" />
														<button type="button" class="btn"
															onclick="ProjectSearch();">조회</button>
													</span> <input name="searchPrj" id="searchPrj" type="hidden"
														value="<c:out value="${searchVO.searchPrj}"/>" />
												</div>
											</div>
											<div class="j_box01">
												<div class="date_box">
													<!-- <span class="lb">신청일자</span>  -->
													<div>
														<span class="search_date ">
															<input class="f_date pty_f_date w_full" type="text" name="startDate" id="startDate" value="<c:out value="${searchVO.startDate}"/>" readonly="readonly" onchange="checkStartDate()">
														</span>
														<span>―</span>
														<span class="search_date">
															<input class="f_date pty_f_date w_full" type="text" name="endDate" id="endDate" value="<c:out value="${searchVO.endDate}"/>" readonly="readonly" onchange="checkEndDate()">
														</span>
													</div>
												</div>
												<div class="search_box">
													<span class="item f_search w_full" >
														<input class="f_input w_full pty_f_input" type="text" name="searchWord" placeholder="사용장소/신청자 검색" title="검색어" value="<c:out value="${searchVO.searchWord}"/>">
													</span>
												</div>
												<div class="btn_box">

													<button class="btn pty_btn" type="submit" onclick="SearchCarryList();" style="margin-left:5px;">검색</button>

												</div>
											</div>
										</div>
								<!--// 검색 조건 -->

								<!-- 게시판 -->
								
								
								<div class="board_list_top" style="margin:0;">
										<div class="left_col">
	                                		<div class="list_count">
													<div style="display: flex; justify-content: space-between; align-items: center;" class="pty_margin-bottom_8">
														
														<div>
															<span style="margin:0;">Total :</span> 
															<strong><c:out value="${paginationInfo.totalRecordCount}" /></strong> 
																	
														</div>
															
														<div style="display: flex; align-items: center;">
															<span style="margin-right: 16px;">페이지당 항목 수</span> 
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
													
													
												</div>
                              			</div>
	                                </div>
								
								
								
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 6%;">
											<col style="width: 12%;">
											<col style="width: 29%;">
											<col style="width: 16%;">
											<col style="width: 12%;">
											<col style="width: 14%;">
											<col style="width: 11%;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">분류</th>
												<th scope="col">프로젝트명</th>
												<th scope="col">사용장소</th>
												<th scope="col">신청자</th>
												<th scope="col">신청일</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${fn:length(resultList) == 0}">
                                					<tr>
                                						<td colspan="8" id="noData"><spring:message code="common.nodata.msg" /></td>
                                					</tr>
                                			</c:if>
											<c:forEach var="result" items="${resultList}"
												varStatus="status">
												<tr onclick="SelectCarry('<c:out value="${result.reqId}" />');">
													<td>
														<c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - status.index}" />
													</td>
													<td><c:out value="${result.reqGroup}" /></td>
													<td class="pty_text-align_left pty_padding-left_24"><c:out value="${result.prjId}" /></td>
													<td class="pty_text-align_left pty_padding-left_24"><c:out value="${result.place}" /></td>
													<td><c:out value="${result.id}" /></td>
													<td class="resizeDate"><c:out value="${result.reqDate}" /></td>
													<td><c:out value="${result.reqStatus}" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
									
									<div class="btn_area">									
											<div class="excel_btn">
												<button class="btn pty_btn" onclick="javascript:fntrsfExcel(); return false;">Excel</button>
											</div>
											
											
											
												<div class="right_btn btn1">
													<a href="#LINK" class="btn btn_blue_46"
														onclick="CarryRegist();">반출신청</a>
													<a href="#LINK" class="btn btn_blue_46"
														onclick="CarryInRegist();">반입신청</a>
												</div>
											
									</div>
									
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
								</form>
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