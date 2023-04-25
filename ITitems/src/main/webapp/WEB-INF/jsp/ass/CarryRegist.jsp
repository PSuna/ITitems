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
<script type="text/javascript">
	let userCheck = 0;
	
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

	function fn_egov_validateForm(obj) {
		return true;
	}

	function fn_egov_regist_notice() {
		//document.board.onsubmit();

		if (!validateBoard(document.board)) {
			return;
		}
		<c:if test="${bdMstr.bbsAttrbCode == 'BBSA02'}">
		if (document.getElementById("egovComFileUploader").value == "") {
			alert("갤러리 게시판의 경우 이미지 파일 첨부가 필수사항입니다.");
			return false;
		}
		</c:if>
		if (confirm('<spring:message code="common.regist.msg" />')) {
			//document.board.onsubmit();
			document.board.action = "<c:url value='/cop/bbs${prefix}/insertBoardArticle.do'/>";
			document.board.submit();
		}
	}

	function fn_egov_select_noticeList() {
		document.board.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
		document.board.submit();
	}

	/* ********************************************************
	 * 달력
	 ******************************************************** */
	function fn_egov_init_date() {

		$("#searchBgnDe").datepicker(
				{
					dateFormat : 'yy-mm-dd',
					showOn : 'button',
					buttonImage : '<c:url value='/images/ico_calendar.png'/>',
					buttonImageOnly : true

					,
					showMonthAfterYear : true,
					showOtherMonths : true,
					selectOtherMonths : true,
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ]

					,
					changeMonth : true // 월선택 select box 표시 (기본은 false)
					,
					changeYear : true // 년선택 selectbox 표시 (기본은 false)
					,
					showButtonPanel : true
				// 하단 today, done  버튼기능 추가 표시 (기본은 false)
				});

		$("#searchEndDe").datepicker(
				{
					dateFormat : 'yy-mm-dd',
					showOn : 'button',
					buttonImage : '<c:url value='/images/ico_calendar.png'/>',
					buttonImageOnly : true

					,
					showMonthAfterYear : true,
					showOtherMonths : true,
					selectOtherMonths : true,
					monthNamesShort : [ '1월', '2월', '3월', '4월', '5월', '6월',
							'7월', '8월', '9월', '10월', '11월', '12월' ]

					,
					changeMonth : true // 월선택 select box 표시 (기본은 false)
					,
					changeYear : true // 년선택 selectbox 표시 (기본은 false)
					,
					showButtonPanel : true
				// 하단 today, done  버튼기능 추가 표시 (기본은 false)
				});
	}
	
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
	
	function returnProject(val){
		
		if (val) {
			document.getElementById("prjId").value  = val.prjId;
			document.getElementById("prjNm").value  = val.prjNm;
		}
		
		fn_egov_modal_remove();
	}

function returnAsset(val){
		
		if (val) {
			document.getElementById("useId").value  = val.userId;
			document.getElementById("useNm").value  = val.userNm;
		}
		
		fn_egov_modal_remove();
	}
	
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

function insert_asset() {
	event.preventDefault();
	
	let formData = new FormData(document.getElementById('frm'));
	
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

.board_view2 thead .lb {
	text-align: center;
}
</style>

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
										<li>반입/반출 신청</li>
									</ul>
								</div>
								<!--// Location -->


								<form id="frm" name="frm">

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

									<c:if test="${anonymous != 'true'}">
										<input type="hidden" name="ntcrNm" value="dummy">
										<!-- validator 처리를 위해 지정 -->
										<input type="hidden" name="password" value="dummy">
										<!-- validator 처리를 위해 지정 -->
									</c:if>

									<c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
										<input name="ntceBgnde" type="hidden" value="10000101">
										<input name="ntceEndde" type="hidden" value="99991231">
									</c:if>

									<h1 class="tit_1">자산관리</h1>

									<h2 class="tit_2">반입/반출 신청</h2>

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
									<br>
									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 16%;">
												<col style="width: 34%;">
												<col style="width: 16%;">
												<col style="width: 34%;">
											</colgroup>
											<tr>
												<td class="lb">
													<!-- 신청분류 --> <label for="">신청분류</label> <span class="req">필수</span>
												</td>
												<td colspan="3"><input type="radio" name="checkType">
													반입
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input type="radio" name="checkType"> 반출</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 성명 --> <label for="">성명</label> <span class="req">필수</span>
												</td>
												<td><span class="f_search2 w_full"><input
														type="text" readonly="readonly"></span></td>
												<td class="lb">
													<!-- 직위 --> <label for="">직위</label> <span class="req">필수</span>
												</td>
												<td><span class="f_search2 w_full"><input
														type="text" readonly="readonly"></span></td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 프로젝트 --> <label for="">프로젝트</label>
												</td>
												<td colspan="3"><span class="f_search2 w_60%"> <input
														id="prjNm" type="text" title="프로젝트" maxlength="100"
														readonly="false" />
														<button type="button" class="btn"
															onclick="ProjectSearch();">조회</button>
												</span> <span class="f_txt_inner ml15">(프로젝트 검색)</span> <form:errors
														path="prjId" /> <input name="prjId" id="prjId"
													type="hidden" title="프로젝트" value="" maxlength="8"
													readonly="readonly" /></td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용장소 --> <label for="">사용장소</label> <span class="req">필수</span>
												</td>
												<td><input type="text" class="f_txt w_full"></td>
												<td class="lb">
													<!-- PM(관리자) --> <label for="">PM(관리자)</label> <span
													class="req">필수</span>
												</td>
												<td><input type="text" class="f_txt w_full"></td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용기간 --> <label for="">사용기간</label> <span class="req">필수</span>
												</td>
												<td colspan="3"><input id="acquiredDate"
													class="f_txt w_40%" name="acquiredDate" type="date"
													value="" maxlength="60">
													&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
													<input id="acquiredDate" class="f_txt w_40%"
													name="acquiredDate" type="date" value="" maxlength="60">
													<br /></td>
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
												<col style="width: 22%;">
												<col style="width: 15%;">
												<col style="width: 29%;">
												<col style="width: 34%;">
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
												<tr>
													<td><label class="f_select" for="largeCategory">
															<select id="largeCategory" name="largeCategory"
															title="대분류" onchange="getMCatList();">
																<option value="" label="선택하세요" />
																<c:forEach var="LCat" items="${LCat_result}"
																	varStatus="status">
																	<option value="${LCat.catId}"><c:out
																			value="${LCat.catName}" /></option>
																</c:forEach>
														</select>
													</label> <br>
													<br> <label class="f_select" for="middleCategory">
															<select id="middleCategory" name="middleCategory"
															title="중분류">
																<option value='' label="선택하세요" selected="selected" />
														</select>
													</label></td>
													<td><input type="number" value="0"
														class="f_txt w_full"></td>
													<td><input type="text" class="f_txt w_full"></td>
													<td><input type="text" class="f_txt w_full"></td>
												</tr>
											</tbody>
											<tr>
												<td colspan="4"><div class="right_btn btn1">
														<a href="#LINK" class="btn btn_blue_46 w_100"
															onclick=" return false;">+</a>
														<!-- 추가 -->
													</div></td>
											</tr>
										</table>
									</div>
									<br>
									<div>
										<input type="checkbox"> 상기와 같이 장비 반입/반출을 신청합니다.
									</div>
									<br>
									<!-- 등록버튼  -->
									<div class="board_view_bot">
										<div class="right_btn btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="return false;">신청 <spring:message
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