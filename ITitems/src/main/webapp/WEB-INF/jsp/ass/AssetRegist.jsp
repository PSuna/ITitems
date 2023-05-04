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
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
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
<link rel="stylesheet" href="<c:url value='/'/>css/pty_m.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/pty.css">
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
<validator:javascript formName="assetRegist" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
var userCheck = 0;
/* ********************************************************
 * 자산 등록 처리
 ******************************************************** */
function insert_asset(){
	confirm("등록하시겠습니까?")
	if(validateAssetRegist(document.assetRegist)){
		let formData = new FormData(document.getElementById('assetRegist'));
		
	 	 $.ajax({
			url: '${pageContext.request.contextPath}/ass/AssetInsert.do',
			method: 'POST',
			enctype: "multipart/form-data",
			processData: false,
			contentType: false,
			data: formData,
			success: function (result) {
				document.getElementById("largeCategory").value  = "";
				document.getElementById("middleCategory").value  = "";
				document.getElementById("assetQty").value  = 0;
				document.getElementById("assetName").value  = "";
				document.getElementById("acquiredDate").value  = "";
				document.getElementById("acquiredPrice").value  = 0;
				document.getElementById("maker").value  = "";
				document.getElementById("addAsset").value  = "";
				document.getElementById("note").value  = "";
				document.getElementById("photo").value  = "";
			},
			error: function (error) {
				console.log(error);
			}
		}) 
    }
}

/* ********************************************************
 * 중분류 조회
 ******************************************************** */
function getMCatList() {
	let val = document.getElementById('largeCategory').value;
	
	$.ajax({
		url: '${pageContext.request.contextPath}/cat/GetMCategoryList.do',
		method: 'POST',
		contentType: 'application/x-www-form-urlencoded',
		data: {'searchUpper' : val},
		success: function (result) {
			document.getElementById('middleCategory').replaceChildren();
			let op = document.createElement('option');
			op.textContent = '선택하세요';
			document.getElementById('middleCategory').appendChild(op);
			for(res of result){
				op = document.createElement('option');
				op.setAttribute('value', res.catId);
				op.textContent = res.catName;
				document.getElementById('middleCategory').appendChild(op);
			}
		},
		error: function (error) {
			console.log(error);
		}
	})
}

/* ********************************************************
 * 프로젝트 검색
 ******************************************************** */
function ProjectSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/prj/ProjectSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 자산 검색
 ******************************************************** */
function AssetSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/ass/AssetSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 회원 검색
 ******************************************************** */
function UserSearch(ch){
	userCheck = ch;
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/uss/umt/user/SearchUserList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 검색 프로젝트 입력
 ******************************************************** */
function returnProject(val){
	
	if (val) {
		document.getElementById("prjId").value  = val.prjId;
		document.getElementById("prjNm").value  = val.prjNm;
	}
	
	fn_egov_modal_remove();
}

/* ********************************************************
 * 검색 자산 입력
 ******************************************************** */
function returnAsset(val){
	
	if (val) {
		document.getElementById("useId").value  = val.userId;
		document.getElementById("useNm").value  = val.userNm;
	}
	
	fn_egov_modal_remove();
}

/* ********************************************************
 * 검색 회원 입력
 ******************************************************** */
function returnUser(val){

if (val) {
	if(userCheck == 0){
		document.getElementById("rcptId").value  = val.userId;
		document.getElementById("rcptNm").value  = val.userNm;
	}else if(userCheck == 1){
		document.getElementById("useId").value  = val.userId;
		document.getElementById("useNm").value  = val.userNm;
	}
	
}

fn_egov_modal_remove();
}
//-->
</script>

<title>자산관리 > 자산등록</title>

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
</style>

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
										<li>신규자산등록</li>
									</ul>
								</div>
								<!--// Location -->


								<form id="assetRegist" name="assetRegist" method="post" enctype="multipart/form-data" >

									<input name="pageIndex" type="hidden"
										value="<c:out value='${searchVO.pageIndex}'/>" /> <input
										type="hidden" name="bbsId"
										value="<c:out value='${bdMstr.bbsId}'/>" /> <input
										type="hidden" name="bbsAttrbCode"
										value="<c:out value='${bdMstr.bbsAttrbCode}'/>" /> <input
										type="hidden" name="bbsTyCode"
										value="<c:out value='${bdMstr.bbsTyCode}'/>" /> <input
										type="hidden" name="replyPosblAt"
										value="<c:out value='${bdMstr.replyPosblAt}'/>" /> <input
										type="hidden" name="fileAtchPosblAt"
										value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" /> <input
										type="hidden" name="posblAtchFileNumber"
										value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" /> <input
										type="hidden" name="posblAtchFileSize"
										value="<c:out value='${bdMstr.posblAtchFileSize}'/>" /> <input
										type="hidden" name="tmplatId"
										value="<c:out value='${bdMstr.tmplatId}'/>" /> <input
										type="hidden" name="cal_url"
										value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" /> <input
										type="hidden" name="authFlag"
										value="<c:out value='${bdMstr.authFlag}'/>" />

									<h1 class="tit_1">자산관리</h1>

									<h2 class="tit_2">신규자산등록</h2>

									<br>
									<!-- 추가/초기화 버튼  -->
									<!-- <div class="board_view_bot">
										<div class="right_btn btn1">
											<a href="#LINK" class="btn btn_blue_46 w_130"
												onclick="AssetSearch(); return fasle;">기존 자산 등록</a>
											기존 자산 추가
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="frm_reset(); return fasle;">초기화</a>
											초기화
										</div>
									</div> -->
									<!-- // 추가/초기화 버튼 끝  -->
									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 190px;">
												<col style="width: auto;">
											</colgroup>
											<tr>
												<td class="lb">
													<!-- 대분류 --> 
													<label for="">대분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select" for="largeCategory">
															<select id="largeCategory" name="largeCategory"
																title="대분류" onchange="getMCatList();">
																<option value="" label="선택하세요" />
																<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
																	<option value="${LCat.catId}">
																		<c:out value="${LCat.catName}" />
																	</option>
																</c:forEach>
															</select>
													</label> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 중분류 --> 
													<label for="">중분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select" for="middleCategory">
														<select id="middleCategory" name="middleCategory">
															<option value='' label="선택하세요" selected="selected" />
														</select>
													</label> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 품명 --> 
													<label for="">품명</label>
												</td>
												<td>
													<input id="assetName" class="f_txt w_full" name="assetName" type="text"  maxlength="60" >
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수량 -->
													<label for="assetQty">수량</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="assetQty" class="f_txt w_full" name="assetQty" type="number" maxlength="20" >
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 취득일자 --> 
													<label for="acquiredDate">취득일자</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="acquiredDate" class="f_txt w_full" name="acquiredDate" type="date" >
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 취득가액 --> 
													<label for="">취득가액</label>
												</td>
												<td>
													<input id="acquiredPrice" class="f_txt w_full"
													name="acquiredPrice" type="number" value="0" maxlength="60">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 제조사 --> 
													<label for="">제조사</label>
												</td>
												<td>
													<input id="maker" class="f_txt w_full" name="maker" type="text" value="" maxlength="60"> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 추가물품 --> 
													<label for="">추가물품</label>
												</td>
												<td>
													<input id="addAsset" class="f_txt w_full" name="addAsset" type="text" value="" maxlength="60">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 비고 --> 
													<label for="note">비고</label>
												</td>
												<td>
													<textarea id="note" name="note" class="f_txtar w_full h_200" cols="30" rows="10"></textarea>
												</td>
											</tr>
											<!-- 파일첨부 시작 -->
											<tr>
												<td class="lb">
													<label for="egovComFileUploader">사진첨부</label>
													<span class="req">필수</span></td>
												<td>
													<div class="board_attach2" id="file_upload_posbl">
														<input name="photo" id="photo" type="file" />
														<div id="egovComFileList"></div>
													</div>
													<div class="board_attach2" id="file_upload_imposbl">
													</div> 
													<c:if test="${empty result.atchFileId}">
														<input type="hidden" id="fileListCnt" name="fileListCnt" value="0" />
													</c:if>
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
									
									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 190px;">
												<col style="width: auto;">
											</colgroup>
											<tr>
												<td class="lb">
													<label for="egovComFileUploader">지급확인서</label>
													<span class="req">필수</span>
												</td>
												<td>
													<div class="board_attach2" id="file_upload_posbl">
														<input name="file" id="egovComFileUploader" type="file" />
														<div id="egovComFileList"></div>
													</div>
													<div class="board_attach2" id="file_upload_imposbl"></div>
													<c:if test="${empty result.atchFileId}">
														<input type="hidden" id="fileListCnt" name="fileListCnt"
															value="0" />
													</c:if>
												</td>
											</tr>
											<!-- /파일첨부 끝 -->
											<tr>
												<td class="lb">
													<!-- 부서 --> 
													<label for="orgnztId">부서</label>
												</td>
												<td>
													<label class="f_select w_30%" for="orgnztId">
														<select id="orgnztId" name="orgnztId" title="부서">
															<option value="" label="선택하세요" />
															<c:forEach var="orgnztId" items="${orgnztId_result}"
																varStatus="status">
																<option value="${orgnztId.code}">
																	<c:out value="${orgnztId.codeNm}" />
																</option>
															</c:forEach>
													</select>
													</label>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for="">프로젝트</label>
												</td>
												<td>
													<span class="f_search2 w_30%"> 
													<input id="prjNm" type="text" title="프로젝트" maxlength="100"
														readonly="false" />
													<button type="button" class="btn"
														onclick="ProjectSearch();">조회</button>
													</span> 
													<span class="f_txt_inner ml15">(프로젝트 검색)</span> 
													<form:errors path="prjId" /> 
													<input name="prjId" id="prjId" type="hidden" title="프로젝트" value="" maxlength="8"
														readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- CODE명 --> 
													<label for="">CODE명</label>
												</td>
												<td>
													<input id="code" class="f_txt w_full" name="code"
														type="text" value="" maxlength="60"> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령자 --> 
													<label for="">수령자</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 w_30%"> 
													<input id="rcptNm" type="text" title="회원" maxlength="100"
														readonly="false" />
													<button type="button" class="btn" onclick="UserSearch(0);">조회</button>
													</span> 
													<span class="f_txt_inner ml15">(회원 검색)</span> 
													<input name="rcptId" id="rcptId" type="hidden" title="프로젝트"
														value="" maxlength="8" readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 실사용자 --> 
													<label for="">실사용자</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 w_30%"> 
														<input id="useNm" type="text" title="회원" maxlength="100"
															readonly="false" />
														<button type="button" class="btn" onclick="UserSearch(1);">조회</button>
													</span> 
													<span class="f_txt_inner ml15">(회원 검색)</span> 
													<input name="useId" id="useId" type="hidden" title="프로젝트" value=""
														maxlength="8" readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령일자 --> 
													<label for="">수령일자</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="rcptDate" class="f_txt w_full" name="rcptDate" type="date" value="" maxlength="60">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 반출사유 --> 
													<label for="carryReason">반출사유</label>
												</td>
												<td>
													<textarea id="carryReason" name="carryReason"
														class="f_txtar w_full h_200" cols="30" rows="10">
													</textarea>
												</td>
											</tr>
										</table>
									</div>
									<!-- 등록버튼  -->
									<div class="board_view_bot">
										<div class="right_btn btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="insert_asset(); return false;"><spring:message
													code="button.create" /></a>
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