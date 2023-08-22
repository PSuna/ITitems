<%--
  Class Name : AssetExcelUploadStart.jsp
  Description : 자산 엑셀 업로드 안내 및 파일등록 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.07.07   천세훈              최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.07.07
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="<c:url value='/'/>css/res/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/page.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/jsh.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/csh.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>
<script src="<c:url value='/'/>js/jquery.js"></script>
<script src="<c:url value='/'/>js/jqueryui.js"></script>
<script src="<c:url value='/'/>js/res/PhotoMng.js"></script>
<script src="<c:url value='/'/>js/res/FormSave.js"></script>
<script src="<c:url value='/'/>js/res/Confirm.js"></script>
<script src="<c:url value='/'/>js/res/Inputcheck.js"></script>
<script src="<c:url value='/'/>js/res/Manual.js"></script>
<script src="<c:url value='/'/>js/res/SearchList.js"></script>
<link rel="stylesheet" href="<c:url value='/'/>css/res/jqueryui.css">

<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 목록 이동
 ******************************************************** */
function AssetList(){
		document.popForm.action = "<c:url value='/res/ass/AssetRegist.do'/>";
	    document.popForm.submit();
}
</script>
<link rel="icon" type="image/png" href="<c:url value="/" />images/res/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>
<style>
body {
    width: 100%;
    height: auto !important;
}
.condition2{
	padding:40px !important;
}
.board_list {
    border-top: 0;
}
.j_box02 div {
	margin:5px !important;
}
.condition2{
	padding-left:84px;
}
.marginBotH3{
	margin-bottom:15px;
}
.marginTopH3{
	margin-top:40px;
}
.important{
	color:red;
}
.resultH3{
	margin-bottom: 20px;
}
.resultBox{
	margin-bottom: 20px;
}
#resultTable{
	margin-top:10px;
	width:20%;
	text-align:center;
}
#resultTable td{
	padding:5px;
	border: 1px solid #aaa;
}
.firstTd{
 background: #eee;
}
#errorTable{
	width:auto;
}
#errorTable td{
	padding:10px;
	border: 1px solid #aaa;
	color: red;
}
</style>
</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
	<!-- Skip navigation -->
	<a href="#contents" class="skip_navi">본문 바로가기</a>
	<div class="wrap">
		<!-- Header -->
		<c:import url="/res/sym/mms/EgovHeader.do" />
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
										<li>${masterVO.assNm}엑셀업로드결과</li>
									</ul>
								</div>
								<form name="popForm" method="post" id="popForm" action="/res/com/xlsxAssetUpload.do" enctype="multipart/form-data">
								<input type="hidden" id="listCode" name="listCode" value="<c:out value="${searchVO.listCode}"/>" />
								<input type="hidden" id="assId" name="assId" value="<c:out value='${masterVO.assId}'/>" />
								<input type="hidden" id="isRental" name="isRental" value="<c:out value="${masterVO.assId}"/>" />
								</form>
								<!--// Location -->
								<h2 class="tit_2">${masterVO.assNm}엑셀업로드결과</h2>
								<div class="condition2">
									<div class="resultBox">
										<h3 class="resultH3">업로드 결과</h3>
										<p>업로드 하신 내용에 대한 결과입니다.</p>
										<p>등록 실패한 리스트는 하단의 실패내역을 참조하여 개별등록 하시거나 재업로드해 주시기 바랍니다.</p>
										<table id="resultTable">
											<tbody>
												<tr>
													<td class="firstTd">총 데이터 수</td>
													<td>${result.resultCnt} 개</td>
												</tr>
												<tr>
													<td class="firstTd">업로드 성공 수</td>
													<td>${result.successCnt} 개</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="resultBox">
										<h3 class="resultH3">업로드 실패 내역</h3>
										<div>
											<table id="errorTable">
												<thead>
												</thead>
												<tbody>
													<c:forEach var = "result" items="${result.msgList}" varStatus="status">
	                                					<tr>
	                                						<td><c:out value="${result.msg}"/></td>
	                                					</tr>
	                                				</c:forEach>
												</tbody>
											</table>
										</div>
									</div>
									<div class="board_view_bot btn_bot">
										<div class="right_btn btn1">
											<!-- 목록 -->
											<a href="#LINK" class="btn btn_blue_46 w_150"
												onclick="AssetList();return false;">업로드종료
											</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<c:import url="/res/sym/mms/EgovFooter.do" />
	<!--// Footer -->
</body>

</html>