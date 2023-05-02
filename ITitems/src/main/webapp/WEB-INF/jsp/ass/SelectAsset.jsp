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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
<title>자산관리 > 자산등록</title>

</head>

<body onload="fn_egov_init_date();">
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
						<!-- Left menu -->
						<c:import url="/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->

						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="">Home</a></li>
										<li><a href="">자산관리</a></li>
										<li>자산정보</li>
									</ul>
								</div>
								<!--// Location -->


								<form id="frm" name="frm">

									<h1 class="tit_1">자산관리</h1>

									<h2 class="tit_2">자산정보</h2>

									<br>
									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 190px;">
												<col style="width: auto;">
											</colgroup>
											<tr>
												<td class="lb">
													<!-- 대분류 --> <label for="">대분류</label>
												</td>
												<td>${resultVO.largeCategory}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 중분류 --> <label for="">중분류</label>
												</td>
												<td>${resultVO.middleCategory}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 품명 --> <label for="">품명</label>
												</td>
												<td>${resultVO.assetName}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수량 --> <label for="">수량</label>
												</td>
												<td>${resultVO.assetQty}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 취득일자 --> <label for="">취득일자</label>
												</td>
												<td>${resultVO.acquiredDate}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 취득가액 --> <label for="">취득가액</label>
												</td>
												<td>${resultVO.acquiredPrice}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 제조사 --> <label for="">제조사</label>
												</td>
												<td>${resultVO.maker}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 추가물품 --> <label for="">추가물품</label>
												</td>
												<td>${resultVO.addAsset}</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 비고 --> <label for="note">비고</label>
												</td>
												<td>${resultVO.note}</td>
											</tr>
											<!-- 파일첨부 시작 -->
											<tr>
												<td class="lb"><label for="egovComFileUploader">사진</label>
												</td>
												<td>
													<img alt="" src="C:${resultPhoto.fileStreCours}${resultPhoto.streFileNm}">
												</td>
											</tr>
										</table>

										<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">
											<script type="text/javascript">
												var maxFileNum = document.board.posblAtchFileNumber.value;
												if (maxFileNum == null
														|| maxFileNum == "") {
													maxFileNum = 3;
												}
												var multi_selector = new MultiSelector(
														document
																.getElementById('egovComFileList'),
														maxFileNum);
												multi_selector
														.addElement(document
																.getElementById('egovComFileUploader'));
											</script>
										</c:if>
									</div>
									<br>
									<div class="board_list">
										<table>
											<colgroup>
												<col style="width: 20%;">
												<col style="width: 20%;">
												<col style="width: 20%;">
												<col style="width: 20%;">
												<col style="width: 20%;">
											</colgroup>
											<tr>
												<th scope="col">일자</th>
												<th scope="col">분류</th>
												<th scope="col">수량</th>
												<th scope="col">사용자</th>
												<th scope="col">상태</th>
											</tr>
											<c:forEach var="result" items="${resultList}" varStatus="status">
												<tr>
													<td><c:out value="${result.histDate}"></c:out></td>
													<td><c:out value="${result.histGroup}"></c:out></td>
													<td><c:out value="${result.histQty}"></c:out></td>
													<td><c:out value="${result.useId}"></c:out></td>
													<td><c:out value="${result.histStatus}"></c:out></td>
												</tr>
											</c:forEach>
										</table>
									</div>

									<!-- 페이지 네비게이션 시작 -->
									<%-- <div class="board_list_bot">
											<div class="paging" id="paging_div">
												<ul>
													<ui:pagination paginationInfo="${paginationInfo}"
														type="image" jsFunction="fn_egov_select_noticeList" />
												</ul>
											</div>
										</div> --%>
									<!-- //페이지 네비게이션 끝 -->
									<br>
									<!-- 등록버튼  -->
									<div class="board_view_bot">
										<div class="right_col btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="return false;"> <spring:message
													code="button.create" />
											</a>
											<!-- 등록 -->
										</div>
									</div>
									<!-- // 등록버튼 끝  -->
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