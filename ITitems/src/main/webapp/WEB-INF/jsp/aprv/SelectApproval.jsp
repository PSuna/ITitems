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
    history.back();
}
/* ********************************************************
 * 승인확인 팝업창
 ******************************************************** */
function fnAgree(AuthorCode){
	loginAuthor = AuthorCode;
	console.log(loginAuthor);
	var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/ApprovalConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
		.dialog({
		    autoOpen: false,
		    modal: true,
		    width: 500,
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
	var a = "ROLE_HIGH_ADMIN";
	 if(val){
		 if(loginAuthor==a){
			 fnHighUpdate();
		 }else{
		 	 fnUpdate();
		 }
	 }
}
 /* ********************************************************
  * 승인처리
  ******************************************************** */
function fnUpdate(){
	 var reqId = document.getElementById("reqId").value;
	 console.log(reqId);
	 $.ajax({
		 	url: '${pageContext.request.contextPath}/aprv/ApprovalUpdate.do?reqId='+reqId,
			method: 'POST',
			success: function (result) {
				location.href="${pageContext.request.contextPath}/aprv/ApprovalManage.do"
			}
	 });
 }
/* ********************************************************
 * 최고관리자 승인처리
 ******************************************************** */
function fnHighUpdate(){
	 var reqId = document.getElementById("reqId").value;
	 console.log(reqId);
	 $.ajax({
		 	url: '${pageContext.request.contextPath}/aprv/HighApprovalUpdate.do?reqId='+reqId,
			method: 'POST',
			success: function (result) {
				location.href="${pageContext.request.contextPath}/aprv/ApprovalManage.do"
			}
	 });
}
//-->
</script>
<title>ITitems</title>
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
									<h2 class="tit_2">결재요청정보</h2>
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
												<td colspan="3">
													<c:out value="${approvalVO.prjId}"></c:out>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용장소 --> 
													<label for="">사용장소</label> 
												</td>
												<td>
													<c:out value="${approvalVO.place}"></c:out>
												</td>
												<td class="lb">
													<!-- PM(관리자) --> 
													<label for="">PM(관리자)</label>
												</td>
												<td>
													<c:out value="${approvalVO.pmName} ${approvalVO.pmGrade}"></c:out>
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
											<col style="width: 34%;">
											<col style="width: 24%;">
											<col style="width: 30%;">
										</colgroup>
										<thead>
											<tr>
												<td class="lb"><label for="">구분</label></td>
												<td class="lb"><label for="">수량</label></td>
												<td class="lb"><label for="">S/N(노트북)/제조사</label></td>
												<td class="lb"><label for="">사용자</label></td>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="result" items="${approvalDetailList}" varStatus="status" >
												<tr>
													<td><c:out value="${result.middleCategory}"></c:out></td>
													<td><c:out value="${result.reqQty}"></c:out></td>
													<td><c:out value="${result.maker}"></c:out></td>
													<td><c:out value="${result.user}"></c:out></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>
								<br>
								<br>
								 <!-- 지급확인버튼  -->
								<div class="board_view_bot">
									<div class="right_btn btn1">
										<c:if test="${approvalVO.reqStatus}=='A0'">
											<a href="#LINK" class="btn btn_blue_46 w_150" onclick="JavaScript:fnAgree('${AuthorCode}'); return false;">
												<spring:message code="button.agree" />
											</a>
										</c:if>
										<!-- 지급확인 -->
										<a href="<c:url value='/aprv/ApprovalManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;">
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