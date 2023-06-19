<%--
  Class Name : SelectApproval.jsp
  Description : 결재요청상세조회
  Modification Information
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.05.11  천세훈              최초 생성
    author   : 영남사업부 천세훈
    since    : 2023.05.11
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
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
<link rel="stylesheet" href="<c:url value='/'/>css/csh.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>
<script src="<c:url value='/'/>js/jquery.js"></script>
<script src="<c:url value='/'/>js/jqueryui.js"></script>
<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">
<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovCalPopup.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false"
	xhtml="true" cdata="false" />
<c:if test="${anonymous == 'true'}">
	<c:set var="prefix" value="/anonymous" />
</c:if>
<script type="text/javascript">
<!--
var loginAuthor= "";
function fnListPage(){
	document.frm.action = "<c:url value='/aprv/ApprovalManage.do'/>";
	document.frm.submit();
}

function fnCheck(){
	let loginId = '${approvalSearchVO.uniqId}';
	var lastUserName = $("#lastUserName").val();
	console.log(loginId + '==' + lastUserName);
}

/* ********************************************************
 * 승인확인 팝업창
 ******************************************************** */
function fnAgree(){
	var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/ApprovalConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
		.dialog({
		    autoOpen: false,
		    modal: true,
		    width: 400,
		    height: 300
		});
		$(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}

/* ********************************************************
 * 승인확인 결과 처리
 ******************************************************** */
 function returnConfirm(val){
	fn_egov_modal_remove();
	 if(val){
		 AprvIng();
		 fnUpdate();
	 }
}
 /* ********************************************************
  * 결재진행 팝업창
  ******************************************************** */
  function AprvIng(){
 	
 	 var $dialog = $('<div id="modalPan"></div>')
 		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/AprvIng.do'/>" +'" width="100%" height="100%"></iframe>')
 		.dialog({
 	    	autoOpen: false,
 	        modal: true,
 	        width: 400,
 	        height: 300
 		});
 	    $(".ui-dialog-titlebar").hide();
 		$dialog.dialog('open');
 }
 /* ********************************************************
  * 승인처리
  ******************************************************** */
function fnUpdate(){
	var reqId = document.getElementById("reqId").value;
	let formdata = new FormData();
	formdata.append('reqId', reqId);
	$.ajax({
	 	url: '${pageContext.request.contextPath}/aprv/ApprovalUpdate.do',
		method: 'POST',
		processData: false,
		contentType: false,
		data : formdata,
		success: function (result) {
			fn_egov_modal_remove();
			fnInsertHist();
		}
	})
 }
/* ********************************************************
 * 승인처리 후 자산 내역 입력
 ******************************************************** */
function fnInsertHist(){
	var reqId = document.getElementById("reqId").value;
	let loginId = "${approvalSearchVO.uniqId}";
	var lastUserName = $("#lastUserName").val();
	if(lastUserName == loginId){
		var assetIds = new Array();
		assetIds = document.querySelectorAll("#assetDList tr");
		for(let i=0; i<assetIds.length; i++){
			let formdata = new FormData();
			var assetId = assetIds[i].querySelector(".assetId").value;
			var useId = assetIds[i].querySelector(".useId").value;
			var reqQty = assetIds[i].querySelector(".reqQty").innerHTML;
			var prjId = "${approvalVO.prjCode}";
			
			formdata.append('assetId', assetId);
			formdata.append('reqQty', reqQty);
			formdata.append('prjId', prjId);
			formdata.append('histUser', loginId);
			formdata.append('useId', useId);
			if(${approvalVO.reqGroup == '반출신청'}){
				formdata.append('histGroup', 'C1');
			}else{
				formdata.append('histGroup', 'C0');
			}
			
			$.ajax({
				url:'${pageContext.request.contextPath}/aprv/ApprovalInsertHist.do',
				method: 'POST',
				enctype: "multipart/form-data",
				processData: false,
				contentType: false,
				data : formdata,
				success: function (result) {
					fn_egov_modal_remove();
					AprvSuccess();
				},
				error: function (error) {
					fn_egov_modal_remove();
					AprvFail();
				}
			})
		}
	}else{
		fn_egov_modal_remove();
		AprvSuccess();
	}
}
/* ********************************************************
 * 승인완료 팝업창
 ******************************************************** */
 function AprvSuccess(){
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/AprvSuccess.do'/>" +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}
 /* ********************************************************
  * 승인완료 결과 처리
  ******************************************************** */
function returnSuccess(val){
	var reqId = document.getElementById("reqId").value;
	if(val){
		fn_egov_modal_remove();
 	} 	
 	location.href="${pageContext.request.contextPath}/aprv/selectApproval.do?reqId="+reqId;
 }
 
/* ********************************************************
 * 승인실패 팝업창
 ******************************************************** */
 function AprvFail(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/AprvFail.do'/>" +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}
/* ********************************************************
 * 반려확인 팝업창
 ******************************************************** */
function fnDisAgree(){
	var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/ApprovalDisConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
		.dialog({
		    autoOpen: false,
		    modal: true,
		    width: 400,
		    height: 300
		});
		$(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}
/* ********************************************************
 * 반려확인 결과 처리
 ******************************************************** */
 function returnDisConfirm(val){
	fn_egov_modal_remove();
	 if(val){
		 fnDisUpdate();
	 }
}
 /* ********************************************************
  * 반려처리
  ******************************************************** */
function fnDisUpdate(){
	 var reqId = document.getElementById("reqId").value;
	 $.ajax({
		 	url: '${pageContext.request.contextPath}/aprv/ApprovalDisUpdate.do?reqId='+reqId,
			method: 'POST',
			success: function (result) {
				fn_egov_modal_remove();
				AprvSuccess();
			}
	 });
 }
 
/* ********************************************************
 * onload 함수
 ******************************************************** */
 window.onload = function(){
	 var i = document.querySelectorAll('.aprv_item').length;
	 var p = `<div class="aprv_item">
					<table class="aprv_table" style="margin:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">
						<colgroup>
							<col style="width: 39px;">
						</colgroup>
						<tbody>
							<tr style="border-bottom:1px solid black; ">
								<td>/</td>
							</tr>
							<tr class="aprv_col" style="border-bottom:1px solid black;">
								<td class="aprv_nm">/</td>
							</tr>
							<tr>
								<td class="aprv_td">/
								</td>
							</tr>
						</tbody>
					</table>
				</div>`;
	 for(var j=0;j<4-i;j++){
		 $(".aprv_item:last-child").before(p);
	 }
	 
 }
//-->
</script>


<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>

</head>
<style type="text/css">
.ui-datepicker-trigger {
	margin-left: 10px;
	vertical-align: middle;
}

.board_view_bot {
	overflow: hidden;
}

.right_btn {
	float: right;
}

.board_view2 thead .lb {
	text-align: center;
}
</style>

<body >
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>
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
										<li><a class="home" href="">Home</a></li>
										<li><a href="">결재요청</a></li>
										<li>결재요청정보</li>
									</ul>
								</div>
								<!--// Location -->
								<form id="frm" name="frm">
								<input name="pageIndex" type="hidden" value="<c:out value='${approvalSearchVO.pageIndex}'/>"/>
								<input name="pageUnit" type="hidden" value="<c:out value='${approvalSearchVO.pageUnit}'/>"/>
								<input name="searchGroup" type="hidden" value="<c:out value='${approvalSearchVO.searchGroup}'/>"/>
								<input name="searchStatus" type="hidden" value="<c:out value='${approvalSearchVO.searchStatus}'/>"/>
								<input name="searchKeyword" type="hidden" value="<c:out value='${approvalSearchVO.searchKeyword}'/>"/>
									<div class="aprv_top">
										<h2 class="tit_2">결재요청정보 (
										<c:if test="${approvalVO.reqGroup == '반출신청'}"><span>반출신청</span></c:if>
										<c:if test="${approvalVO.reqGroup == '반입신청'}"><span>반입신청</span></c:if> )</h2>
										<div class="aprv_view">
											<table class="aprv_table" style ="margin-right:7px;border:1px solid black;text-align: center;">
												<tbody>
													<tr style="border-bottom:1px solid black;">
														<td>신청자</td>
													</tr>
													<tr class="aprv_col" style="border-bottom:1px solid black;">
														<td class="aprv_nm">${approvalVO.userNm}</td>
													</tr>
													<tr>
														<td class="aprv_td">${approvalVO.reqDate}</td>
													</tr>
												</tbody>
											</table>
											<div id="aprv_list" style="display:flex;border-right:1px solid black;">
												<c:forEach var="aprvItem" items="${aprvList_result }" varStatus="status">
													<div class="aprv_item">
														<table class="aprv_table" style="margin:0;border-top:1px solid black;border-left:1px solid black;border-bottom:1px solid black;">
															<tbody>
																<tr style="border-bottom:1px solid black;">
																	<td>결재자</td>
																</tr>
																<tr class="aprv_col" style="border-bottom:1px solid black;">
																	<td class="aprv_nm">${aprvItem.userNm }</td>
																	<c:if test="${status.last}"><input type="hidden" id="lastUserName" name="lastUserName" value="<c:out value="${aprvItem.esntlId}"/>"/></c:if>
																</tr>
																<tr>
																	<td class="aprv_td">
																		<c:choose>
																			<c:when test="${aprvItem.reqStatus eq 'A0' }"> 
																			</c:when>
																			<c:when test="${aprvItem.reqStatus eq 'A2' }">반려 
																			</c:when>
																			<c:otherwise> ${aprvItem.aprvDate }
																			</c:otherwise>
																		</c:choose>
																	</td>
																</tr>
															</tbody>
														</table>
													</div>
												</c:forEach>
											</div>
										</div>
									</div>
									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 20%;">
												<col style="width: 34%;">
												<col style="width: 24%;">
												<col style="width: 30%;">
											</colgroup>
											<tr>
												<td class="lb">
													<!-- 성명 --> 
													<label for="">신청자</label> 
												</td>
												<td colspan="3">
													<c:out value="${approvalVO.userNm} ${approvalVO.grade }"></c:out>
													<input type="hidden" id="reqId" value="<c:out value="${approvalVO.reqId}"/>">
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for="">프로젝트</label>
												</td>
												<td>
													<c:out value="${approvalVO.prjId}"></c:out>
												</td>
												<td class="lb">
													<!-- PM(관리자) --> 
													<label for="">PM(관리자)</label>
												</td>
												<td>
													<c:out value="${approvalVO.pmName} ${approvalVO.pmGrade}"></c:out>
												</td>
											</tr>
											<c:if test="${approvalVO.reqGroup == '반출신청'}">
											<tr>
												<td class="lb">
													<!-- 사용장소 --> 
													<label for="">사용장소</label> 
												</td>
												<td  colspan="3">
													<c:out value="${approvalVO.place}"></c:out>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용기간 --> 
													<label for="">사용기간</label> 
												</td>
												<td colspan="3">
													<c:out value="${approvalVO.startDate}"></c:out> — <c:out value="${approvalVO.endDate}"></c:out>
												</td>
											</tr>
											</c:if>
										</table>
									</div>
									</form>
									<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">
										<script type="text/javascript">
											var maxFileNum = document.board.posblAtchFileNumber.value;
											if (maxFileNum == null || maxFileNum == "") {
												maxFileNum = 3;
											}
											var multi_selector = new MultiSelector(document.getElementById('egovComFileList'),maxFileNum);
											multi_selector.addElement(document.getElementById('egovComFileUploader'));
										</script>
									</c:if>
								<br>
								<div class="board_list assetlist pty_board_list">
									<table>
										<colgroup>
											<col style="width: 20%;">
											<col style="width: 15%;">
											<col style="width: 35%;">
											<col style="width: 15%;">
											<col style="width: 15%;">
										</colgroup>
										<thead>
											<tr>
												<td class="lb"><label for="">분류</label></td>
												<td class="lb"><label for="">수량</label></td>
												<td class="lb"><label for="">시리얼넘버 | 제조사</label></td>
												<td class="lb"><label for="">수령자</label></td>
												<td class="lb"><label for="">실사용자</label></td>
											</tr>
										</thead>
										<tbody id="assetDList">
											<c:forEach var="result" items="${approvalDetailList}"
												varStatus="status" >
												<tr>
													<input type="hidden" name="assetId" class="assetId" value="<c:out value="${result.assetId}"/>"/>
													<input type="hidden" name="useId" class="useId" value="<c:out value="${result.useId}"/>"/>
													<td><c:out value="${result.middleCategory}"></c:out></td>
													<td class="reqQty"><c:out value="${result.reqQty}"></c:out></td>
													<td><c:out value="${result.assetSn} | ${result.maker}"></c:out></td>
													<td><c:out value="${result.rcptId}"></c:out></td>
													<td><c:out value="${result.user}"></c:out></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								 <!-- 지급확인버튼  -->
								<div class="board_view_bot btn_bot">
									<div class="right_btn btn1">
										<c:if test="${approvalVO.rreqStatus eq 'A0' and ( approvalVO.reqStatus eq 'A1' or approvalVO.reqStatus eq null )}">
											<a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:fnAgree(); return false;">
												<spring:message code="button.agree" />
											</a>
											<a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:fnDisAgree(); return false;">
												<spring:message code="button.disagree" />
											</a>
											
										</c:if>
										<!-- 지급확인 -->
										<a class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;">
											<spring:message code="button.list" />
										</a>
										<!-- 목록 -->
									</div>
								</div>
								<!-- // 등록버튼 끝  --> 
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