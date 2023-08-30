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
<%@page import="java.awt.Window"%>
<%@page import="com.ibm.icu.text.ListFormatter.Width"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
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
<script type="text/javascript"
	src="<c:url value='/js/EgovCalPopup.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<c:if test="${masterVO.assId == 'ASSMSTR_000000000001'}">
<validator:javascript formName="assetRegist" staticJavascript="false"
	xhtml="true" cdata="false" />
</c:if>
<c:if test="${masterVO.assId == 'ASSMSTR_000000000002'}">
<validator:javascript formName="rentalRegist" staticJavascript="false"
	xhtml="true" cdata="false" />
</c:if>
<script type="text/javaScript" language="javascript" defer="defer">
var userCheck = 0;
var resetBtn = $('<img class="reset_btn" src="<c:url value='/'/>images/res/jsh_icon_reset.png">');
let loginId = '${loginId}';
/* ********************************************************
 * 자산 등록 처리
 ******************************************************** */
function insert_asset(){
		inputFile();
		inputPhoto();
		 let formData = new FormData(document.getElementById('assetRegist'));
	 	    $.ajax({
			url: '${pageContext.request.contextPath}/res/ass/AssetInsert.do',
			method: 'POST',
			enctype: "multipart/form-data",
			processData: false,
			contentType: false,
			data: formData,
			success: function (result) {
				fn_egov_modal_remove();
				RegistSuccess();
			},
			error: function (error) {
				fn_egov_modal_remove();
				RegistFail();
			}
		})    
}

/* ********************************************************
 * 필수 입력값 체크
 ******************************************************** */
 function RegistCheck(){
	<c:if test="${masterVO.assId == 'ASSMSTR_000000000001'}">
		if(validateAssetRegist(document.assetRegist) && fileCheck()){
		   RegistConfirm();
	 	}
	</c:if>
	<c:if test="${masterVO.assId == 'ASSMSTR_000000000002'}">
	console.log("실행 ==========")
		if(validateRentalRegist(document.assetRegist) && fileCheck()){
			console.log("실행")
		   RegistConfirm();
	 	}
	</c:if>
	   
}

 function fileCheck(){
	 
	 	let ch = true;
	 
	 	if($('.fileList').closest('td').children('.filebox').children().last().prop('tagName') == 'P'){
			$('.fileList').closest('td').children('.filebox').children().last().remove();
		}
		if($('.photoList').closest('td').children('.filebox').children().last().prop('tagName') == 'P'){
			$('.photoList').closest('td').children('.filebox').children().last().remove();
		}
	 	
		if($('.fileList').children('.namebox').length == 0){
			$('.fileList').closest('td').children('.filebox').append($('<p/>').addClass('alertV').text('지급확인서은(는) 필수 입력값입니다.'));
			ch = false;
		}
		if($('.photoList').children('.photobox').length == 0){
			$('.photoList').closest('td').children('.filebox').append($('<p/>').addClass('alertV').text('제품사진은(는) 필수 입력값입니다.'));
			ch = false;
		}
		
		return ch;
	}

/* ********************************************************
 * 등록확인 결과 처리
 ******************************************************** */
 function returnConfirm(val){
 
	fn_egov_modal_remove();
	 if(val){
		 RegistIng();
		 insert_asset();
	 }	  
}

/* ********************************************************
 * 등록완료 결과 처리
 ******************************************************** */
 function returnSuccess(val){
	removeVal('assetRegist');
	if(val){
		fn_egov_modal_remove();
	    $('form').each(function() {
	        this.reset();
	    });
		document.getElementById("rcptId").value  = loginId;
		document.getElementById("useId").value  = loginId;
		document.getElementById("prjId").value  = "";
		document.getElementById("rcptGroup").value  = "USER";
		document.getElementById("useGroup").value  = "USER";
	    document.assetRegist.largeCategory.focus(); 
	    $(".photoList").children().remove();
	    removeP();
	    $('#fileNm').closest(".filebox").find('img')[0].remove();
	}else{
		document.subFrm.submit(); 
	}
	
}

/* ********************************************************
 * 등록실패 팝업창
 ******************************************************** */
 function RegistFail(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/RegistFail.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 중분류 조회
 ******************************************************** */
function getMCatList(Mval) {
	let val = document.getElementById('largeCategory').value;

	if(val == "cat1"){
		$('#assetQty').attr("readonly","readonly").addClass("readonly").val("1");
	}else{
		$('#assetQty').removeAttr("readonly").removeClass("readonly");
	}
		
	if(val == ""){
		document.getElementById('middleCategory').replaceChildren();
		let op = document.createElement('option');
		op.textContent = '중분류';
		op.value = "";
		document.getElementById('middleCategory').appendChild(op);
	}else{
		$.ajax({
			url: '${pageContext.request.contextPath}/res/cat/GetMCategoryList.do',
			method: 'POST',
			contentType: 'application/x-www-form-urlencoded',
			data: {'searchUpper' : val},
			success: function (result) {
				document.getElementById('middleCategory').replaceChildren();
				let op = document.createElement('option');
				op.textContent = '중분류';
				op.value = "";
				document.getElementById('middleCategory').appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.catId);
					if(res.catName == '기타'){
						op.textContent = res.catName + "(직접입력)";
					}else{
						op.textContent = res.catName;	
					}
					if(Mval == res.catId){
						op.setAttribute('selected', 'selected');
					}
					document.getElementById('middleCategory').appendChild(op);
				}
				checkMcatEtc();
			},
			error: function (error) {
				console.log(error);
			}
		})
	}
}

/* ********************************************************
 * 중분류 직접입력
 ******************************************************** */
 function checkMcatEtc(){
	 let val = $("#middleCategory option:selected").text();
	 if(val.indexOf('기타') == -1){
		 $("#mcatEtc").attr("type","hidden").val("");
	 }else{
		 $("#mcatEtc").attr("type","text");
	 }
}
 
/* ********************************************************
 * 제조사 직접입력
 ******************************************************** */
 function checkMakerEtc(){
	 let val = $("#makerCode option:selected").text();
	 
	 if(val.indexOf('기타') == -1){
		 $("#maker").attr("type","hidden").val("");
	 }else{
		 $("#maker").attr("type","text");
	 }
 }

/* ********************************************************
 * 검색 프로젝트 입력
 ******************************************************** */
function returnProject(val){
	resetBtnCl = $(resetBtn).clone();
	if (val) {
		document.getElementById("prjId").value  = val.prjId;
		document.getElementById("prjNm").value  = val.prjNm;
	}
	
	fn_egov_modal_remove();
}
 
/* ********************************************************
 * 검색 회원 입력
 ******************************************************** */
function returnTotal(val){
	console.log(val.Id);
	console.log(val.Nm);
	console.log(val.Group);
	if (val) {
		if(userCheck == 0){
			document.getElementById("rcptId").value  = val.Id;
			document.getElementById("rcptNm").value  = val.Nm;
			document.getElementById("rcptGroup").value  = val.Group;
		}else if(userCheck == 1){
			document.getElementById("useId").value  = val.Id;
			document.getElementById("useNm").value  = val.Nm;
			document.getElementById("useGroup").value  = val.Group;
		}
	} 

	fn_egov_modal_remove();
}

/* ********************************************************
 * 검색 부서 입력
 ******************************************************** */
function returnOrg(val){
	resetBtnCl = $(resetBtn).clone();
	if(val) {
		document.getElementById("orgnztId").value  = val.Id;
		document.getElementById("orgnztNm").value  = val.Nm;
	}
	fn_egov_modal_remove();
}
 
/* ********************************************************
 * date input 생성
 ******************************************************** */
function make_date(){
	
	$("#acquiredDate,#rcptDt,#assetStart,#assetEnd").datepicker(
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/res/ico_calendar.png'/>'
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
 * 수령일자 모름
 ******************************************************** */
 function emptyDate(obj){
	if($(obj).is(':checked')){
		$(obj).closest('tr').find('#rcptDt').val("모름");
	}else{
		$(obj).closest('tr').find('#rcptDt').val("");
	}
	
	changeDt();
}

 /* ********************************************************
  * 수령일자 변경
  ******************************************************** */
 function changeDt(){
	 let rcptDt = $('#rcptDt').val();
	 let dt = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
	 if(rcptDt != null && rcptDt != "" && rcptDt.match(dt)){
		$('#rcptDate').val(rcptDt);
		$('#rcptDtCh').prop('checked',false);
	 }else if(rcptDt != null && rcptDt != ""){
		 $('#rcptDate').val("");
		 $('#rcptDtCh').prop('checked',true);
	 }else{
		 $('#rcptDate').val("");
		 $('#rcptDtCh').prop('checked',false);
	 }
 }

/* ********************************************************
 * 유효성 체크
 ******************************************************** */
let typeList = ["input", "select"]

function removeP() {
	$(typeList).each(function(index, type){
		$("#assetRegist").find(type).each(function(index, item){
			let td = $(item).closest("td");
			if($(td).children().last().prop('tagName') == 'P'){
				$(td).children().last().remove();
			}
		})
	})
	
	if($('.fileList').closest('td').children('.filebox').children().last().prop('tagName') == 'P'){
		$('.fileList').closest('td').children('.filebox').children().last().remove();
	}
	if($('.photoList').closest('td').children('.filebox').children().last().prop('tagName') == 'P'){
		$('.photoList').closest('td').children('.filebox').children().last().remove();
	}
}

function alertValid(objList) {
	removeP();
	$(typeList).each(function(index, type){
		$("#assetRegist").find(type).each(function(index, item){
			let td = $(item).closest("td");
			for(key in objList){
				if($(item).attr("name") == key){
					$(td).append($('<p/>').addClass('alertV').text(objList[key]));
				}
			}
		})
	})
	
	fileCheck();
}

/* ********************************************************
 * 목록 이동
 ******************************************************** */
function AssetList(){
	let code = $('#listCode').val();
	if(code == "AM"){
		document.subFrm.action = "<c:url value='/res/ass/AssetManagement.do'/>";
	    document.subFrm.submit();
	}else if (code == "MYAM"){
		document.subFrm.action = "<c:url value='/res/ass/MyAssetManagement.do'/>";
	    document.subFrm.submit();
	}
}
function ExcelUpload(){
	document.subFrm.action = "<c:url value='/res/ass/AssetExcelUploadStart.do'/>";
    document.subFrm.submit();
}
 
/* ********************************************************
 * 시리얼넘버 입력
 ******************************************************** */
function ReturnAssetSn(val){
	if (val.assetSn != null) {
		document.getElementById("assetSnNm").value  = val.assetSn;
		document.getElementById("assetSn").value  = val.assetSn;
	}else if(val.empty != null){
		document.getElementById("assetSnNm").value  = val.empty;
		document.getElementById("assetSn").value = "";
	}
	
	fn_egov_modal_remove();
}

/* ********************************************************
 * 등록폼 화면사이즈별 수정
 ******************************************************** */
 function editForm(){
	 if(width>425){
		
	}else{
		
	}
}
/* ********************************************************
 * onload
 ******************************************************** */
window.onload = function(){
	make_date();
	//editForm();
	/* pullVal('assetRegist',loginId);
	checkMakerEtc();
	setInterval(function() {
		pushVal('assetRegist',loginId)
	}, 1000); */
 }
 
/* ********************************************************
 *  날짜 체크
 ******************************************************** */
function checkEndDate() {
	let startDate = $('#AssetUpdt #assetStart').val();
	let endDate = $('#AssetUpdt #assetEnd').val();
	if(startDate != null && startDate > endDate){
		$('#AssetUpdt #assetStart').val(endDate);
		$('#AssetUpdt #assetEnd').val("");
	}
}

function checkStartDate(){
	let startDate = $('#AssetUpdt #assetStart').val();
	let endDate = $('#AssetUpdt #assetEnd').val();
	if(startDate != null && startDate > endDate){
		$('#AssetUpdt #assetEnd').val("");
	}
}

</script>

<link rel="icon" type="image/png" href="<c:url value="/" />images/res/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>
<style>
.btn_bot {
    display: flex;
    justify-content: space-between !important;
    align-items: center;
}
@media screen and (max-width: 900px){
 .left_btn{
 	display:none !important;
 }
 .btn_bot {
    display: flex;
    justify-content: flex-end !important;
    align-items: center;
}
 
}
</style>
</head>

<body>
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

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
										<li>신규${masterVO.assNm}등록</li>
									</ul>
								</div>
								<!--// Location -->

								<form id="assetRegist" name="assetRegist" method="post" enctype="multipart/form-data" autocomplete="off">
									<input name="assId" type="hidden" value="${masterVO.assId}">
									<h1 class="tit_1">${masterVO.assNm}관리</h1>

									<h2 class="tit_2">신규${masterVO.assNm}등록</h2>
									<p><span class="req">필수</span><spring:message code="ass.regist.notice" /></p>
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
													<!-- 대분류 --> 
													<label for=""><spring:message code="ass.largeCategory" /></label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select w_full" for="largeCategory">
															<select id="largeCategory" name="largeCategory" onchange="getMCatList();">
																<option value="" label="선택하세요" />
																<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
																	<option value="${LCat.catId}">
																		<c:out value="${LCat.catName}" />
																	</option>
																</c:forEach>
															</select>
													</label> 
												</td>
												<td class="lb">
													<!-- 수량 -->
													<label for="assetQty"><spring:message code="ass.assetQty" /></label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="assetQty" class="f_txt w_full" name="assetQty" type="text" maxlength="20" value="1"
														onchange="checkQty(this);" onkeyup="checkQty(this);">
												</td>
											</tr>
											<tr>
											<td class="lb">
													<!-- 중분류 --> 
													<label for=""><spring:message code="ass.middleCategory" /></label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select w_full" for="middleCategory">
														<select id="middleCategory" name="middleCategory" onchange="checkMcatEtc();">
															<option value='' label="선택하세요" selected="selected" />
														</select>
													</label> 
												</td>
												<td colspan="2">
													<input id="mcatEtc" name="mcatEtc" class="f_txt w_full" type="hidden" maxlength="20" onchange="symbolCheck1(this);" onkeyup="symbolCheck1(this);"> 
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 제조사 --> 
													<label for=""><spring:message code="ass.maker" /></label><span class="req">필수</span>
												</td>
												<td>
													<label class="f_select w_full" for="largeCategory">
															<select id="makerCode" name="makerCode" onchange="checkMakerEtc();">
																<option value="" label="선택하세요" />
																<c:forEach var="result" items="${maker_result}" varStatus="status">
																<c:choose>
																	<c:when test="${result.codeNm == '기타'}">
																		<option value="${result.code}">
																			<c:out value="${result.codeNm}(직접입력)" />
																		</option>
																	</c:when>
																	<c:otherwise>
																		<option value="${result.code}">
																			<c:out value="${result.codeNm}" />
																		</option>
																	</c:otherwise>
																</c:choose>
																</c:forEach>
															</select>
													</label>
												</td>
												<td colspan="2">
													<input id="maker" class="f_txt w_full" name="maker" type="hidden" maxlength="60" onchange="symbolCheck1(this);" onkeyup="symbolCheck1(this);"> 
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 품명 --> 
													<label for=""><spring:message code="ass.assetName2" /></label><span class="req">필수</span>
												</td>
												<td>
													<input id="assetName" class="f_txt w_full" name="assetName" type="text"  maxlength="60" onchange="symbolCheck2(this);" onkeyup="symbolCheck2(this);">
												</td>
												<td class="lb">
													<!-- 시리얼넘버 --> 
													${windowWidth}
													<label for=""><spring:message code="ass.assetSn" /></label><span class="req">필수</span><img class="manual_img" src="<c:url value='/'/>images/res/ico_question.png" onclick="AssetSnManual();">
												</td>
												<td>
													<span class="f_search2 w_full"> 
														<input id="assetSnNm" name="assetSnNm" type="text" maxlength="60"
															readonly="readonly" onclick="AssetSnCnfirm();"/>
														<button type="button" class="btn" onclick="AssetSnCnfirm();">조회</button>
													</span> 
													<input id="assetSn" name="assetSn" type="hidden" maxlength="60" readonly="readonly"/>
													<!-- <input id="assetSn" class="f_txt w_full" name="assetSn" type="text" maxlength="60" onchange="symbolCheck2(this);" onkeyup="symbolCheck2(this);">  -->
												</td>
											</tr>
											<c:if test="${masterVO.assId eq 'ASSMSTR_000000000002'}">
												<tr>
													<td class="lb">
														<!-- 렌탈업체 --> 
														<label for="">렌탈업체</label><span class="req">필수</span>
													</td>
													<td colspan="3">
														<input id="assetCompany" class="f_txt w_full" name="assetCompany" type="text"  maxlength="60" onchange="symbolCheck2(this);" onkeyup="symbolCheck2(this);">
													</td>
												</tr>
											</c:if>
											<%
												LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
											%>
											<tr>
												<td class="lb">
													<!-- 수령 --> 
													<label for=""><spring:message code="ass.rcptId" /></label> 
													<span class="req">필수</span>
												</td>
												<td>
													<c:set var="Nm" value="<%= loginVO.getName()%>"/>
													<c:set var="Id" value="<%= loginVO.getUniqId()%>"/>
													<span class="f_search2 w_full"> 
													<input id="rcptNm" name="rcptNm" type="text" maxlength="100"
														readonly="readonly" value="<c:out value="${Nm}"></c:out>" onclick="TotalUserSearch(0);"/>
													<button type="button" class="btn" onclick="TotalUserSearch(0);">조회</button>
													</span> 
													<input name="rcptId" id="rcptId" type="hidden" 
														value="<c:out value="${Id}"></c:out>" maxlength="8" readonly="readonly" />
													<input name="rcptGroup" id="rcptGroup" type="hidden" 
														value="<c:if test="${not empty Id}">USER</c:if>" maxlength="8" readonly="readonly" />
												</td>
												<td class="lb">
													<!-- 실사용 --> 
													<label for=""><spring:message code="ass.useId" /></label><span class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 w_full"> 
														<input id="useNm" name="useNm" type="text" maxlength="100"
															readonly="readonly" value="<c:out value="${Nm}"></c:out>"  onclick="TotalUserSearch(1);"/>
														<button type="button" class="btn" onclick="TotalUserSearch(1);">조회</button>
													</span>
													<input name="useId" id="useId" type="hidden" value="<c:out value="${Id}"></c:out>"
														maxlength="8" readonly="readonly" />
													<input name="useGroup" id="useGroup" type="hidden" 
														value="<c:if test="${not empty Id}">USER</c:if>" maxlength="8" readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 부서 --> 
													<label for="orgnztId"><spring:message code="ass.orgnzt" /></label><span class="req">필수</span>
												</td>
												<td>
													<c:set var="orgnzt" value="<%= loginVO.getOrgnztId()%>"/>
													<c:set var="orgNm" value="<%= loginVO.getOrgnztNm()%>"/>
													<span class="f_search2 w_full"> 
													<input id="orgnztNm" name="orgnztNm" type="text" maxlength="100"
														readonly="readonly" value="<c:out value="${orgNm }"></c:out>" onclick="OrgnztSearch();"/>
													<button type="button" class="btn" onclick="OrgnztSearch();">조회</button>
													</span> 
													<input name="orgnztId" id="orgnztId" type="hidden" 
														value="<c:out value="${orgnzt}"></c:out>" maxlength="8" readonly="readonly" />
													
												</td>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for=""><spring:message code="ass.prj" /></label><span class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 w_full"> 

													<input id="prjNm" name="prjNm" type="text" maxlength="100"

														readonly="readonly" onclick="ProjectSearch();"/>
													<button type="button" class="btn"
														onclick="ProjectSearch();">조회</button>
													</span> 
													<form:errors path="prjId" /> 
													<input name="prjId" id="prjId" type="hidden"  maxlength="8"
														readonly="readonly" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령일자 --> 
													<label for=""><spring:message code="ass.rcptDate" /></label><span class="req">필수</span>
												</td>
												<td colspan="3">
												<span class="search_date w_full">
													<input id="rcptDt" class="f_txt w_full readonly" name="rcptDt" type="text" onchange="changeDt()"  maxlength="60" readonly="readonly">
												</span>
												  <div class="empty_box">
													    <label for="rcptDtCh"><input name="rcptDtCh" id="rcptDtCh" type="checkbox" onclick="emptyDate(this);">수령일자 모름</label > 
												  </div>
												  <input name="rcptDate" id="rcptDate" type="hidden"  maxlength="8" readonly="readonly" />
												</td>
											</tr>
											<!-- 렌탈기간 --> 
											<c:if test="${masterVO.assId eq 'ASSMSTR_000000000002'}">
												<tr>
													<td class="lb">
														<label for=""><spring:message code="ass.rentDate" /></label> <span class="req">필수</span>
													</td>
													<td colspan="3">
													<div>
														<span class="search_date wp_date">
															<input id="assetStart" class="f_txt w_full readonly" name="assetStart" type="text"  maxlength="60" readonly="readonly" onchange="checkStartDate()">
														</span>
														&nbsp;&nbsp;―&nbsp;&nbsp;
														<span class="search_date wp_date">
															<input id="assetEnd" class="f_txt w_full readonly" name="assetEnd" type="text" maxlength="60" readonly="readonly" onchange="checkEndDate()">
														</span>
													</div>
												</tr>
											</c:if>
											<tr>
												<td class="lb">
													<label for="egovComFileUploader"><spring:message code="ass.file" /></label><span class="req">필수</span>
													<img class="manual_img" src="<c:url value='/'/>images/res/ico_question.png" onclick="FileManual();">
												</td>
												<td colspan="4">
													<div class="filebox">
													    <label for="fileFrm">파일찾기</label > 
													    <input name="fileFrm" id="fileFrm" type="file" onchange="getFileName(this,-1)">
													    <div class="empty_box">
														    <label for="fileCh"><input name="fileCh" id="fileCh" type="checkbox" onclick="emptyFile(this);">파일없음</label > 
													    </div>
													</div>
													<input name="file" id="file" type="file" style="display: none">
													<div class="fileList"></div>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<label for="egovComFileUploader"><spring:message code="ass.photo" /></label><span class="req">필수</span>
													<img class="manual_img" src="<c:url value='/'/>images/res/ico_question.png" onclick="PhotoManual();"> <br><span class="f_14">(최대 5장)</span>
												</td>
												<td colspan="3">
													<div class="filebox">
													    <label for="photoFrm">파일찾기</label> 
													    <input name="photoFrm" id="photoFrm" type="file" multiple accept=".jpg, .png, .jpeg" onchange="checkPhoto(this)">
													</div>
													<input name="photo" id="photo" type="file" style="display: none"/>
													<div class="photoList">
													</div>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 비고 --> 
													<label for="note"><spring:message code="ass.note" /></label>
												</td>
												<td colspan="4">
													<textarea id="note" name="note" class="f_txtar w_full" cols="30" rows="1" onchange="strLengthCheck(this);" onkeyup="strLengthCheck(this);" ></textarea>
												</td>
											</tr>
										</table>
									</div>
									<!-- 등록버튼  -->
									<div class="board_view_bot btn_bot">
										<div class="left_btn btn1">
											<!-- 엑셀 업로드 -->
											<a href="#LINK" onclick="ExcelUpload();return false;" class= "btn btn_blue_46 w_150">엑셀업로드</a>
										</div>
										<div class="right_btn btn1">

											<!-- 등록 -->
											<a href="#LINK" class="btn btn_blue_46 w_100"

												onclick="RegistCheck(); return false;"><spring:message
													code="button.create" /></a>
											<!-- 목록 -->
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="AssetList();return false;"> <spring:message
													code="button.list" />
											</a>
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
		<c:import url="/res/sym/mms/EgovFooter.do" />
		<!--// Footer -->
	</div>
</body>

<form name="subFrm" method="post" action="<c:url value='/res/ass/MyAssetManagement.do'/>">
<input type="hidden" id="assId" name="assId" value="<c:out value='${masterVO.assId}'/>" />
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
<input name="userGroup" id="userGroup" type="hidden"  value="<c:out value="${searchVO.userGroup}"/>" />
<input name="pageIndex" id="pageIndex" type="hidden"  value="<c:out value="${searchVO.pageIndex}"/>" />
<input type="hidden" name="pageUnit" value="<c:out value='${searchVO.pageUnit}'/>"/>
</form>
</html>