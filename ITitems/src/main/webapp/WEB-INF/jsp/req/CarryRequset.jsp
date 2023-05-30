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
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>

<title>ITitems</title>

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

function SearchCarryList() {
	event.preventDefault();

	document.frm.pageIndex.value = '1';
    document.frm.action = "<c:url value='/req/CarryRequset.do'/>";
    document.frm.submit(); 
}


function fn_egov_select_noticeList(pageNo) {
	event.preventDefault()
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


window.onload = function(){
	make_date();
	  }

function CarryRegist() {
	 document.regist.submit();
}
function fntrsfExcel(){
	if(document.getElementById('noData')){
		alert("엑셀로 다운로드할 목록이 없습니다.")
	}else{
	    document.frm.action = "<c:url value='/com/xlsxTrsfReqList.do'/>";
	    document.frm.submit();
	}
}
function setPageUnit(){
	document.frm.pageIndex.value = 1;
    document.frm.action = "<c:url value='/req/CarryRequset.do'/>";
    document.frm.submit();
}
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
										<li>반출관리</li>
									</ul>
								</div>
								<!--// Location -->
								<h2 class="tit_2">반출관리</h2>
								<form name="regist" method="post"
									action="<c:url value='/req/CarryRegist.do'/>" autocomplete="off">
									
								</form>
								<!-- 검색조건 -->
								<form id="searchVO" name="frm" action="<c:url value='/req/CarryRequest.do'/>" autocomplete="off">
									<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" >
									<input type="hidden" name="reqGroup" value="<c:out value='${searchVO.reqGroup}'/>">
									<div class="condition2" style="display: flex;justify-content: center;">
										<div class="j_box03" style="margin-bottom:0;">

											<div style="margin-bottom:10px;">

												<div>
													<!-- <span class="lb">프로젝트</span> -->
													<span class="f_search2 w_full">
														<input id="prjNm" type="text" title="프로젝트" maxlength="100" placeholder="프로젝트" readonly="true" />
														<button type="button" class="btn" onclick="ProjectSearch();">조회</button>
													</span>
													<input name="searchPrj" id="searchPrj" type="hidden" title="프로젝트" value="" maxlength="8" placeholder="프로젝트"readonly="readonly" />
												</div>
												<div>
													<!-- <span class="lb">신청상태</span> -->
													<label class="item f_select w_full" for="sel1">
													<select id="searchStatus" name="searchStatus" title="상태">
														<option value='' label="신청상태" selected="selected" />
														<c:forEach var="stat" items="${status_result}" varStatus="status">
															<option value="${stat.code}"><c:out value="${stat.codeNm}" /></option>
														</c:forEach>
													</select>
													</label>
												</div>
											</div>
											<div>
												<div class="date_box">
													<!-- <span class="lb">신청일자</span>  -->
													<div style="margin-left:2px;">
														<span class="search_date ">
															<input class="f_date pty_f_date w_full" type="text" name="startDate" id="startDate" value="<c:out value="${searchVO.startDate}"/>" readonly="readonly" onchange="checkStartDate()">
														</span>
														<span>―</span>
														<span class="search_date">
															<input class="f_date pty_f_date w_full" type="text" name="endDate" id="endDate" value="<c:out value="${searchVO.endDate}"/>" readonly="readonly" onchange="checkEndDate()">
														</span>
													</div>
												</div>
												<div class="btn_box" style="width:auto !important; align-items: baseline;">
													<button class="btn pty_btn" type="submit" onclick="SearchCarryList();" style="margin-left:5px;">검색</button>
												</div>
											</div>
										</div>
									</div>

								<!--// 검색 조건 -->

								<!-- 게시판 -->
								
								
								<div class="board_list_top">
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
								</form>
								
								
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 5%;">
											<col style="width: 10%;">
											<col style="width: 40%;">
											<col style="width: 20%;">
											<col style="width: 15%;">
											<col style="width: 10%;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">분류</th>
												<th scope="col">프로젝트명</th>
												<th scope="col">사용장소</th>
												<th scope="col">신청일자</th>
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
												<tr onclick="childNodes[1].childNodes[1].submit();">
													<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}" />
														<form name="subForm" method="post"
															action="<c:url value='/req/SelectCarry.do'/>">
															<input type="hidden" name="reqId"
																value="<c:out value='${result.reqId}'/>" />
														</form></td>
													<td><c:out value="${result.reqGroup}" /></td>
													<td><c:out value="${result.prjId}" /></td>
													<td><c:out value="${result.place}" /></td>
													<td><c:out value="${result.reqDate}" /></td>
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