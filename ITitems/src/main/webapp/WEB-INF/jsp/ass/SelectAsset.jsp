<%--
  Class Name : AssetInsert.jsp
  Description : 자산등록 화면
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
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ page import ="egovframework.com.cmm.LoginVO" %>
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
<script src="<c:url value='/'/>js/jquery.js"></script>
<script src="<c:url value='/'/>js/jqueryui.js"></script>
<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet"
	type="text/css">
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


<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>


<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* ********************************************************
 * 수정페이지로 이동
 ******************************************************** */
function AssetUpdt() {
	document.frm.action = "<c:url value='/ass/AssetUpdt.do'/>";
    document.frm.submit();
}

/* ********************************************************
 * 자산 삭제
 ******************************************************** */
function AssetDel() {
	let formData = new FormData(document.getElementById('frm'));
	   $.ajax({
		url: '${pageContext.request.contextPath}/ass/AssetDel.do',
		method: 'POST',
		enctype: "multipart/form-data",
		processData: false,
		contentType: false,
		data: formData,
		success: function (result) {
			fn_egov_modal_remove();
			DelSuccess();
		},
		error: function (error) {
			fn_egov_modal_remove();
			DelFail();
		}
	}) 
}


/* ********************************************************
 * 삭제확인 팝업창
 ******************************************************** */
 function DelConfirm(){
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/DelConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 삭제확인 결과 처리
 ******************************************************** */
 function returnConfirm(val){
 
	fn_egov_modal_remove();
	 if(val){
		 DelIng();
		 AssetDel(); 
	 }	  
}

/* ********************************************************
* 삭제진행 팝업창
******************************************************** */
function DelIng(){

 var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/DelIng.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 삭제완료 팝업창
 ******************************************************** */
 function DelSuccess(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/DelSuccess.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 삭제완료 결과 처리
 ******************************************************** */
 function returnSuccess(){
	 fn_egov_modal_remove();
	 AssetList();
}

/* ********************************************************
 * 수정실패 팝업창
 ******************************************************** */
 function DelFail(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/DelFail.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 목록 이동
 ******************************************************** */
function AssetList(){
	let code = $('#listCode').val();
	if(code == "AM"){
		document.frm.action = "<c:url value='/ass/AssetManagement.do'/>";
	    document.frm.submit();
	}else if (code == "MYAM"){
		document.frm.action = "<c:url value='/ass/MyAssetManagement.do'/>";
	    document.frm.submit();
	}
}
//-->
</script>
<script type="text/javascript">

</script>
</head>

<body>
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
										<li><a class="home" href="#LINK">Home</a></li>
										<li><a href="#LINK">자산관리</a></li>
										<li>자산정보</li>
									</ul>
								</div>
								<!--// Location -->
								<form id="frm" name="frm" autocomplete="off" method="post">
									<input name="assetId" type="hidden" value="${resultVO.assetId}">
									<h1 class="tit_1">자산관리</h1>

									<h2 class="tit_2">자산정보</h2>

									<br>
									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 20%;">
												<col style="width: 30%;">
												<col style="width: 20%;">
												<col style="width: 30%;">
											</colgroup>
											<tr>
												<td class="lb">
													<!-- 대분류 --> <label for="">대분류</label>
												</td>
												<td>${resultVO.largeCategory}</td>
												<td class="lb">
													<!-- 중분류 --> <label for="">중분류</label>
												</td>
												<td>${resultVO.mcatNm}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 제조사 --> <label for="">제조사</label>
												</td>
												<td>${resultVO.maker}</td>
												<td class="lb">
													<!-- 품명 --> <label for="">제품명(모델명)</label>
												</td>
												<td>${resultVO.assetName}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 시리얼넘버 --> 
													<label for="">시리얼넘버</label>
												</td>
												<td>${resultVO.assetSn}</td>
												<td class="lb">
													<!-- 수량 --> <label for="">수량</label>
												</td>
												<td> ${resultVO.assetQty}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령자 --> 
													<label for="">수령자</label> 
												</td>
												<td>
													${resultVO.rcptNm}
												</td>
												<%-- <td class="lb">
													<!-- 실사용자 --> 
													<label for="">실사용자</label> 
												</td>
												<td>
													${resultVO.useNm}
												</td> --%>
											</tr>
											<%-- <tr>
												<td class="lb">
													<!-- 부서 --> 
													<label for="orgnztId">본부/부서</label>
												</td>
												<td>
													${resultVO.orgnztId}
												</td>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for="">프로젝트</label>
												</td>
												<td>
													${resultVO.prjNm}
												</td>
											</tr> --%>
											<tr>
												<td class="lb">
													<!-- 수령일자 --> 
													<label for="">수령일자</label> 
												</td>
												<td>
													${resultVO.rcptDate}
												</td>
												<td class="lb">
													<!-- 자산관리번호 --> 
													<label for="">자산관리번호</label> 
												</td>
												<td >
													${resultVO.mngNum}
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 취득일자 --> <label for="">취득일자</label>
												</td>
												<td>${resultVO.acquiredDate}</td>
												<td class="lb">
													<!-- 취득가액 --> <label for="">취득가액</label>
												</td>
												<td>${resultVO.acquiredPrice}
													<c:if test="${not empty resultVO.acquiredPrice}">
														원
													</c:if>
												</td>											
											</tr>
											<tr>
												<td class="lb">
													<label for="egovComFileUploader">지급확인서</label>
												</td>
												<td colspan="4">
													<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				                                        <c:param name="param_atchFileId" value="${FileVO.atchFileId}" />
				                                    </c:import>
												</td>
											</tr>
											<tr>
												<td class="lb"><label for="egovComFileUploader">제품사진</label>
												</td>
												<td colspan="4">
													<div class="photoList">
														<c:forEach var="photo" items="${PhotoList}" varStatus="status">
					                                       <img alt="" src="/uploadFile/${photo.streFileNm}">
					                                   	</c:forEach>
				                                   	</div>
												</td>
											</tr>
											<% pageContext.setAttribute("newLineChar", "\n"); %>
											<tr>
												<td class="lb">
													<!-- 비고 --> <label for="note">비고</label>
												</td>
												<td colspan="4">${fn:replace(resultVO.note, newLineChar, "<br/>")}</td>
											</tr>
											<%-- <tr>
												<td class="lb">
													<!-- 반출사유 --> 
													<label for="carryReason">반출사유</label>
												</td>
												<td colspan="4">
													${fn:replace(resultVO.carryReason, newLineChar, "<br/>")}
												</td>
											</tr> --%>
											<tr>
												<td class="lb">
													<!-- 등록일자 --> 
													<label for="">등록일자</label> 
												</td>
												<td>
													${resultVO.regDate}
												</td>
												<td class="lb">
													<!-- 등록자 --> 
													<label for="">등록자</label> 
												</td>
												<td>
													${resultVO.regId}
												</td>
											</tr>
										</table>
									</div>
									<br>
									<!-- 게시판 -->
								<div class="board_list selete_table">
									<table>
										<colgroup>
											<col style="width: 10%;">
											<col style="width: 15%;">
											<col style="width: 15%;">
											<col style="width: 15%;">
											<col style="width: 15%;">
											<col style="width: 15%;">
											<col style="width: 15%;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">본부</th>
												<th scope="col">부서</th>
												<th scope="col">프로젝트</th>
												<th scope="col">수량</th>
												<th scope="col">실사용자</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="result" items="${resultList}"
												varStatus="status">
												<tr>
													<td><c:out value="${resultCnt - status.index}" /></td>
													<td><c:out value="${result.orgnztNm}" /></td>
													<td><c:out value="${result.lowerOrgnztNm}" /></td>
													<td class="pty_text-align_left pty_padding-left_24"><c:out value="${result.prjNm}" /></td>
													<td><c:out value="${result.assetQty}" /></td>
													<td><c:out value="${result.useNm}" /></td>
													<td><c:out value="${result.histGroup}" /></td>
												</tr>
											</c:forEach>
											<c:if test="${empty resultList}">
												<tr>
                               						<td colspan="8" id="noData"><spring:message code="ass.null" /></td>
                               					</tr>
											</c:if>
										</tbody>
									</table>
								</div>
										<%
											LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
										%>
										<c:set var="login" value="<%= loginVO.getUniqId()%>"/>
										<c:set var="auth" value="<%= loginVO.getAuthorCode()%>"/>
									<!-- 버튼  -->
									<div class="board_view_bot btn_bot">
										<div class="right_btn btn1">
										<c:if test="${auth == 'ROLE_ADMIN' || auth == 'ROLE_HIGH_ADMIN' || resultVO.useId == login || resultVO.rcptId == login}">
												<!-- 수정 -->
												<a href="#LINK" class="btn btn_skyblue_h46 w_100"
													onclick="AssetUpdt();return false;"> <spring:message
														code="button.update" />
												</a>
										</c:if>
										<c:if test="${auth == 'ROLE_ADMIN' || auth == 'ROLE_HIGH_ADMIN'}">
												<!-- 삭제 -->
												<a href="#LINK" class="btn btn_skyblue_h46 w_100"
													onclick="DelConfirm();return false;"> <spring:message
														code="button.delete" />
												</a>
										</c:if>
											<!-- 목록 -->
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="AssetList();return false;"> <spring:message
													code="button.list" />
											</a>
										</div>
									</div>
									<!-- // 버튼 끝  -->
									<c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_ADMIN\")%>">
										<c:set var="orgnztId" value="<%= loginVO.getOrgnztId()%>"/>
										<input type="hidden" id="menuOrgnzt" name="menuOrgnzt" value="<c:out value="${orgnztId}"/>" />
										<c:set var="lowerOrgnztId" value="<%= loginVO.getLowerOrgnztId()%>"/>
										<input type="hidden" id="menuLowerOrgnzt" name="menuLowerOrgnzt" value="<c:out value="${lowerOrgnztId}"/>" />
									</c:if>
									<c:set var="start" value="<%=new java.util.Date(new java.util.Date().getTime() - 60*60*24*1000*90L)%>" />
									<input type="hidden" id="menuStartDate" name="menuStartDate" value="<fmt:formatDate value="${start}" pattern="yyyy-MM-dd" />" />
									<c:set var="end" value="<%=new java.util.Date()%>" />
									<input type="hidden" id="menuEndDate" name="menuEndDate" value="<fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />" />
									<input type="hidden" id="listCode" name="listCode" value="<c:out value="${searchVO.listCode}"/>" />
									<input name="prjNm" id="prjNm" type="hidden"  value="<c:out value="${searchVO.prjNm}"/>" />
									<input name="searchPrj" id="searchPrj" type="hidden"  value="<c:out value="${searchVO.searchPrj}"/>" />
									<input name="searchLCat" id="searchLCat" type="hidden"  value="<c:out value="${searchVO.searchLCat}"/>" />
									<input name="searchdMCat" id="searchdMCat" type="hidden"  value="<c:out value="${searchVO.searchdMCat}"/>" />
									<input name="startDate" id="startDate" type="hidden"  value="<c:out value="${searchVO.startDate}"/>" />
									<input name="endDate" id="endDate" type="hidden"  value="<c:out value="${searchVO.endDate}"/>" />
									<input name="searchWord" id="searchWord" type="hidden"  value="<c:out value="${searchVO.searchWord}"/>" />
									<input name="searchOrgnzt" id="searchOrgnzt" type="hidden"  value="<c:out value="${searchVO.searchOrgnzt}"/>" />
									<input name="lowerOrgnzt" id="lowerOrgnzt" type="hidden"  value="<c:out value="${searchVO.lowerOrgnzt}"/>" />
									<input name=userNm id="userNm" type="hidden"  value="<c:out value="${searchVO.userNm}"/>" />
									<input name="userId" id="userId" type="hidden"  value="<c:out value="${searchVO.userId}"/>" />
									<input name="pageIndex" id="pageIndex" type="hidden"  value="<c:out value="${searchVO.pageIndex}"/>" />
									<input type="hidden" name="pageUnit" value="<c:out value='${searchVO.pageUnit}'/>"/>
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