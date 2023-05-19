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

<title>ITitems</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function CarryList(){
	document.frm.action = "<c:url value='/req/CarryRequset.do'/>";
    document.frm.submit();
}
//-->
</script>
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
										<li><a class="home" href="#LINK">Home</a></li>
										<li><a href="#LINK">자산관리</a></li>
										<li>반출요청 정보</li>
									</ul>
								</div>
								<!--// Location -->


								<form id="frm" name="frm" >

									<h1 class="tit_1">자산관리</h1>
 
									<h2 class="tit_2">반출요청 정보</h2>
									
									<br>
									
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
													<c:out value="${resultVO.id}"></c:out>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for="">프로젝트</label>
												</td>
												<td colspan="3">
													<c:out value="${resultVO.prjId}"></c:out>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용장소 --> 
													<label for="">사용장소</label> 
												</td>
												<td>
													<c:out value="${resultVO.place}"></c:out>
												</td>
												<td class="lb">
													<!-- PM(관리자) --> 
													<label for="">PM(관리자)</label>
												</td>
												<td>
													<c:out value="${resultVO.pm}"></c:out>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용기간 --> 
													<label for="">사용기간</label> 
												</td>
												<td colspan="3">
													<c:out value="${resultVO.startDate}"></c:out> — <c:out value="${resultVO.endDate}"></c:out>
												</td>
											</tr>
										</table>
									</div>
									
									
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
											<c:forEach var="result" items="${resultList}"
												varStatus="status" >
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
								 <!-- 버튼  -->
									<div class="board_view_bot">
										<div class="right_btn btn1">
											<!-- 목록 -->
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="CarryList();return false;"> <spring:message
													code="button.list" />
											</a>
										</div>
									</div>
									<!-- // 버튼 끝  -->
									<%
											LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
										%>
									<c:set var="orgnztId" value="<%= loginVO.getOrgnztId()%>"/>
									<input type="hidden" id="menuOrgnzt" name="menuOrgnzt" value="<c:out value="${orgnztId}"/>" />
									<c:set var="start" value="<%=new java.util.Date(new java.util.Date().getTime() - 60*60*24*1000*90L)%>" />
									<input type="hidden" id="menuStartDate" name="menuStartDate" value="<fmt:formatDate value="${start}" pattern="yyyy-MM-dd" />" />
									<c:set var="end" value="<%=new java.util.Date()%>" />
									<input type="hidden" id="menuEndDate" name="menuEndDate" value="<fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />" />
									</form>
								</div>
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