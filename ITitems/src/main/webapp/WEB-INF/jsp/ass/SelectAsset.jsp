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
 * 자산관리번호 수정칸 생성
 ******************************************************** */
 function MngNumUpdtInput(){
	$(".viewMngNum").css("display","none");
	$(".editMngNum").css("display","block");
}

/* ********************************************************
 * 자산관리번호 수정 취소
 ******************************************************** */
 function MngNumCancel(){
	$(".viewMngNum").css("display","none");
	$(".editMngNum").css("display","block");
}

/* ********************************************************
 * 자산관리번호 수정
 ******************************************************** */
 function MngNumUpdt(){
	 let formData = new FormData(document.getElementById('subFrm'));
	 console.log($("#newMngNum").val());
	 formData.append('newMngNum', $("#newMngNum").val());
	   $.ajax({
		url: '${pageContext.request.contextPath}/ass/MngNumUpdt.do',
		method: 'POST',
		enctype: "multipart/form-data",
		processData: false,
		contentType: false,
		data: formData,
		success: function (result) {
			if(result.res == -1){
				alertResult(result.res);
			}else if(result.res == 1){
				$(".viewMngNum").eq(0).text(result.mngNum);
				MngNumCancel();
			}else{
				alertResult(result.res);
			}
		},
		error: function (error) {
			alertResult(0);
		}
	}) 
}

function removeP() {
	let td = $(".editMngNum").closest("td").next();
	if($(td).children().last().prop('tagName') == 'P'){
		$(td).children().last().remove();
	}
}

function alertResult(result) {
	removeP();
	let td = $(".editMngNum").eq(0).closest("td").next();
	if(result == -1){
		$(td).append($('<p/>').addClass('alertV').text("이미 존재하는 자산관리번호입니다"));
	}else{
		$(td).append($('<p/>').addClass('alertV').text("<spring:message code="fail.common.update" />\n<spring:message code="fail.common.msg" />"));
	}
}

/* ********************************************************
 * 수정페이지로 이동
 ******************************************************** */
function AssetUpdt() {
	document.subFrm.action = "<c:url value='/ass/AssetUpdt.do'/>";
    document.subFrm.submit();
}

/* ********************************************************
 * 자산 삭제
 ******************************************************** */
function AssetDel() {
	let formData = new FormData(document.getElementById('subFrm'));
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
 function returnDelConfirm(val){
 
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
 function returnDelSuccess(){
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
		document.subFrm.action = "<c:url value='/ass/AssetManagement.do'/>";
	    document.subFrm.submit();
	}else if (code == "MYAM"){
		document.subFrm.action = "<c:url value='/ass/MyAssetManagement.do'/>";
	    document.subFrm.submit();
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
	
	<%
		LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
	%>
	<c:set var="login" value="<%= loginVO.getUniqId()%>"/>
	<c:set var="auth" value="<%= loginVO.getAuthorCode()%>"/>
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
										<li><a href="#LINK">${masterVO.assNm}관리</a></li>
										<li>${masterVO.assNm}정보</li>
									</ul>
								</div>
								<!--// Location -->
								<form id="frm" name="frm" autocomplete="off" method="post">
									
									<h1 class="tit_1">${masterVO.assNm}관리</h1>

									<h2 class="tit_2">${masterVO.assNm}정보</h2>

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
													<!-- 자산관리번호 --> 
													<label for="">자산관리번호</label> 
												</td>
												<c:choose>
													<c:when test="${auth == 'ROLE_ADMIN' || auth == 'ROLE_HIGH_ADMIN'}">
														<td>
															<div class="viewMngNum">
																${resultVO.mngNum}
															</div>
															<div class="editMngNum">
																<input class="f_txt w_full" id="NewMngNum" name="NewMngNum" maxlength="30" type="text" value="${resultVO.mngNum}"/>
															</div>
														</td>
														<td>
														</td>
														<td>
															<div class="viewMngNum">
																<div class="right_btn btn1">
																	<!-- 자산관리번호 수정 -->
																	<a href="#LINK" class="btn btn_skyblue_h46 w_180"
																		onclick="MngNumUpdtInput();return false;"> 자산관리번호 수정
																	</a>
																</div>
															</div>
															<div class="editMngNum">
																<div class="right_btn btn1">
																	<c:if test="${auth == 'ROLE_ADMIN' || auth == 'ROLE_HIGH_ADMIN'}">
																		<!-- 수정 -->
																		<a href="#LINK" class="btn btn_skyblue_h46 w_88"
																			onclick="MngNumUpdt();return false;"><spring:message code="button.update" />
																		</a>
																		<!-- 취소 -->
																		<a href="#LINK" class="btn btn_skyblue_h46 w_88"
																			onclick="MngNumCancel();return false;"><spring:message code="button.cancel" />
																		</a>
																	</c:if>
																</div>
															</div>
														</td>
													</c:when>
													<c:otherwise>
													<td colspan="3" >
														${resultVO.mngNum}
													</td>
													</c:otherwise>
												</c:choose>
											</tr>
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
													<!-- 수령일자 --> 
													<label for="">수령일자</label> 
												</td>
												<td>
													${resultVO.rcptDate}
												</td>
												<%-- <td class="lb">
													<!-- 수량 --> <label for="">총 수량</label>
												</td>
												<td> ${resultVO.assetQty}</td> --%>
											</tr>
											<c:if test="${masterVO.assId eq 'ASSMSTR_000000000002'}">
												<tr>
													<td class="lb">
														<!-- 렌탈업체 --> 
														<label for="">렌탈업체</label>
													</td>
													<td colspan="3">
														${resultVO.assetCompany}
													</td>
												</tr>
											</c:if>
											<tr>
												<td class="lb">
													<!-- 수령자 --> 
													<label for="">수령자</label> 
												</td>
												<td>
													${resultVO.rcptNm}
												</td>
												<td class="lb">
													<!-- 실사용자 --> 
													<label for="">실사용자</label> 
												</td>
												<td>
													${resultVO.useNm}
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 부서 --> 
													<label for="orgnztId">본부/부서</label>
												</td>
												<td>
													${resultVO.orgnztNm}
												</td>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for="">프로젝트</label>
												</td>
												<td>
													${resultVO.prjNm}
												</td>
											</tr>
											<c:choose>
											<c:when test="${masterVO.assId eq 'ASSMSTR_000000000001'}">
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
											</c:when>
											<c:when test="${masterVO.assId eq 'ASSMSTR_000000000002'}">
												<tr>
													<td class="lb">
														<!-- 렌탈기간 --> 
														<label for="">렌탈기간</label> 
													</td>
													<td colspan="3">
													<c:if test="${not empty resultVO.assetStart}">
													${resultVO.assetStart}&nbsp;&nbsp;―&nbsp;&nbsp;${resultVO.assetEnd}
													</c:if>
													</td>
												</tr>
												<tr>
													<td class="lb">
														<!-- 렌탈비용 --> 
														<label for="">렌탈비용</label> 
													</td>
													<td colspan="3">
													<c:if test="${not empty resultVO.acquiredPrice}">
													${resultVO.rentalPrice} 원
													</c:if>
													</td>
												</tr>
											</c:when>
											</c:choose>
											<tr>
												<td class="lb">
													<label for="egovComFileUploader">지급확인서</label>
												</td>
												<td colspan="3">
													<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				                                        <c:param name="param_atchFileId" value="${FileVO.atchFileId}" />
				                                    </c:import>
												</td>
											</tr>
											<tr>
												<td class="lb"><label for="egovComFileUploader">제품사진</label>
												</td>
												<td colspan="3">
													<c:if test="${not empty PhotoList}">
														<div class="photoList">
															<c:forEach var="photo" items="${PhotoList}" varStatus="status">
						                                       <img alt="" src="/uploadFile/${photo.streFileNm}">
						                                   	</c:forEach>
					                                   	</div>
				                                   	</c:if>
												</td>
											</tr>
											<% pageContext.setAttribute("newLineChar", "\n"); %>
											<tr>
												<td class="lb">
													<!-- 비고 --> <label for="note">비고</label>
												</td>
												<td colspan="3">${fn:replace(resultVO.note, newLineChar, "<br/>")}</td>
											</tr>
											<%-- <tr>
												<td class="lb">
													<!-- 등록일자 --> 
													<label for="">등록일자</label> 
												</td>
												<td>
													${resultVO.creatDt}
												</td>
												<td class="lb">
													<!-- 등록자 --> 
													<label for="">등록자</label> 
												</td>
												<td>
													${resultVO.creatNm}
												</td>
											</tr> --%>
										</table>
									</div>
									<br>
									<!-- 게시판 -->
								<div class="board_list">
									<div class="non_scrollList">
										<table>
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 30%;">
												<col style="width: 30%;">
												<col style="width: 30%;">
											</colgroup>
											<thead>
												<tr>
													<th scope="col">번호</th>
													<th scope="col">내역</th>
													<th scope="col">회원</th>
													<th scope="col">일자</th>
												</tr>
											</thead>
										</table>
									</div>
									<div class="scrollList">
										<table>
											<colgroup>
												<col style="width: 10%;">
												<col style="width: 30%;">
												<col style="width: 30%;">
												<col style="width: 30%;">
											</colgroup>
											<tbody>
												<c:forEach var="result" items="${resultList}"
													varStatus="status">
													<tr>
														<td><c:out value="${resultCnt - status.index}" /></td>
														<td><c:out value="${result.assetStauts}" /></td>
														<td><c:out value="${result.creatId}" /></td>
														<td><c:out value="${result.creatDt}" /></td>
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
								</div>
									<!-- 버튼  -->
									<div class="board_view_bot btn_bot">
										<div class="right_btn btn1">
										<c:if test="${auth == 'ROLE_ADMIN' || auth == 'ROLE_HIGH_ADMIN' || resultVO.rcptId == login}">
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
<form id="subFrm" name="subFrm" method="post" >
<input name="mngNum" type="hidden" value="${resultVO.mngNum}">
<input name="assetId" type="hidden" value="${resultVO.assetId}">
<input name="assId" type="hidden" value="${masterVO.assId}">
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
	<input name="userNm" id="userNm" type="hidden"  value="<c:out value="${searchVO.userNm}"/>" />
	<input name="userId" id="userId" type="hidden"  value="<c:out value="${searchVO.userId}"/>" />
	<input name="pageIndex" id="pageIndex" type="hidden"  value="<c:out value="${searchVO.pageIndex}"/>" />
	<input type="hidden" name="pageUnit" value="<c:out value='${searchVO.pageUnit}'/>"/>
</form>
</body>
</html>