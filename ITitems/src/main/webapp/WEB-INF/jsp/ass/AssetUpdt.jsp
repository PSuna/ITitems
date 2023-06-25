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
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
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
<link rel="stylesheet" href="<c:url value='/'/>css/jsh.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>
<script src="<c:url value='/'/>js/jquery.js"></script>
<script src="<c:url value='/'/>js/jqueryui.js"></script>
<script src="<c:url value='/'/>js/PhotoMng.js"></script>
<script src="<c:url value='/'/>js/Inputcheck.js"></script>
<script src="<c:url value='/'/>js/Confirm.js"></script>
<script src="<c:url value='/'/>js/Manual.js"></script>
<script src="<c:url value='/'/>js/SearchList.js"></script>
<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovCalPopup.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="assetUpdt" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
var userCheck = 0;
var resetBtn = $('<img class="reset_btn" src="<c:url value='/'/>images/jsh_icon_reset.png">');

/* ********************************************************
 * 자산 수정 처리
 ******************************************************** */
function UpdateAsset(){
	inputFile();
	getDelPhotoList();
    let formData = new FormData(document.getElementById('AssetUpdt'));
	   $.ajax({
		url: '${pageContext.request.contextPath}/ass/AssetUpdate.do',
		method: 'POST',
		enctype: "multipart/form-data",
		processData: false,
		contentType: false,
		data: formData,
		success: function (result) {
			fn_egov_modal_remove();
			UpdtSuccess();
		},
		error: function (error) {
			fn_egov_modal_remove();
			UpdtFail();
		}
	})      
}

/* ********************************************************
 * 수정확인 팝업창
 ******************************************************** */
 function UpdtConfirm(){
	
	  if(validateAssetUpdt(document.AssetUpdt)){
		 var $dialog = $('<div id="modalPan"></div>')
			.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/UpdtConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
			.dialog({
		    	autoOpen: false,
		        modal: true,
		        width: 400,
		        height: 300
		        
			});
		    $(".ui-dialog-titlebar").hide();
			$dialog.dialog('open');
	 } 
}

/* ********************************************************
 * 수정확인 결과 처리
 ******************************************************** */
 function returnConfirm(val){
 
	fn_egov_modal_remove();
	 if(val){
		 UpdtIng();
		 UpdateAsset();
	 }	  
}

/* ********************************************************
* 수정진행 팝업창
******************************************************** */
function UpdtIng(){

 var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/UpdtIng.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 수정완료 팝업창
 ******************************************************** */
 function UpdtSuccess(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/UpdtSuccess.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 수정완료 결과 처리
 ******************************************************** */
 function returnSuccess(){
	 fn_egov_modal_remove();
	 SelectAsset();
}

/* ********************************************************
 * 자산 상세 페이지 이동
 ******************************************************** */
function SelectAsset() {
    document.subForm.action = "<c:url value='/ass/SelectAsset.do'/>";
    document.subForm.submit(); 
}

/* ********************************************************
 * 목록 이동
 ******************************************************** */
function AssetList(){
	let code = $('#listCode').val();
	if(code == "AM"){
		document.subForm.action = "<c:url value='/ass/AssetManagement.do'/>";
	    document.subForm.submit();
	}else if (code == "MYAM"){
		document.subForm.action = "<c:url value='/ass/MyAssetManagement.do'/>";
	    document.subForm.submit();
	}
}

/* ********************************************************
 * 수정실패 팝업창
 ******************************************************** */
 function UpdtFail(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/UpdtFail.do'/>" +'" width="100%" height="100%"></iframe>')
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
	let val = '${resultVO.largeCategoryCode}';
	console.log(val);
	if(val == ""){
		document.getElementById('middleCategory').replaceChildren();
		let op = document.createElement('option');
		op.textContent = '선택하세요';
		op.value = "";
		document.getElementById('middleCategory').appendChild(op);
	}else{
		$.ajax({
			url: '${pageContext.request.contextPath}/cat/GetMCategoryList.do',
			method: 'POST',
			contentType: 'application/x-www-form-urlencoded',
			data: {'searchUpper' : val},
			success: function (result) {
				document.getElementById('middleCategory').replaceChildren();
				let op = document.createElement('option');
				op.textContent = '선택하세요';
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
 * 숫자 콤마 입력
 ******************************************************** */
 function getNumber(obj){
     var num01;
     var num02;
     num01 = $(obj).val();
     if(num01 != null && num01 != ""){
    	num02 = num01.replace(/(^0+)/, "");
	    num03 = num02.replace(/\D/g,"");
	    num01 = setComma(num03);
	    obj.value =  num01;
	
	    $('#test').text(num01); 
     }
     
  }

  function setComma(n) {
     var reg = /(^[+-]?\d+)(\d{3})/;
     n += '';         
     while (reg.test(n)) {
        n = n.replace(reg, '$1' + ',' + '$2');
     }         
     return n;
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
 * 검색 회원 입력
 ******************************************************** */
function returnUser(val){
	resetBtnCl = $(resetBtn).clone();
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

/* ********************************************************
 * date input 생성
 ******************************************************** */
function make_date(){
	
	$("#acquiredDate,#rcptDate,#assetStart,#assetEnd").datepicker(
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
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

/* ********************************************************
 * 유효성 체크
 ******************************************************** */
let typeList = ["input", "select"]

function removeP(objList) {
	$(typeList).each(function(index, type){
		$("#AssetUpdt").find(type).each(function(index, item){
			let td = $(item).closest("td");
			if($(td).children().last().prop('tagName') == 'P'){
				$(td).children().last().remove();
			}
		})
	})
}

function alertValid(objList) {
	removeP(objList);
	$(typeList).each(function(index, type){
		$("#AssetUpdt").find(type).each(function(index, item){
			let td = $(item).closest("td");
			for(key in objList){
				if($(item).attr("name") == key){
					$(td).append($('<p/>').addClass('alertV').text(objList[key]));
				}
			}
		})
	})
}

/* ********************************************************
 * 기존 지급확인서 파일 지우기
 ******************************************************** */
function addDelFile(fileId) {
	$('#fileNm').val('');
	$('input[name=file]').val('');
	$('#fileNm').closest(".filebox").find('img')[0].remove();
	$('#delFile').val(fileId);
}

/* ********************************************************
 * onload
 ******************************************************** */
window.onload = function(){
	getMCatList('${resultVO.middleCategory}');
	getNumber(document.AssetUpdt.acquiredPrice);
	make_date();
	checkMakerEtc();
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
						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="#LINK">Home</a></li>
										<li><a href="#LINK">${masterVO.assNm}관리</a></li>
										<li>${masterVO.assNm}수정</li>
									</ul>
								</div>
								<!--// Location -->

								<%
									LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
								%>
								<form id="AssetUpdt" name="AssetUpdt" method="post" enctype="multipart/form-data" autocomplete="off">
									<input type="hidden" id="assetId" name="assetId" value="${resultVO.assetId}">
									<h1 class="tit_1">${masterVO.assNm}관리</h1>

									<h2 class="tit_2">${masterVO.assNm}수정</h2>

									<c:if test="<%= !loginVO.getAuthorCode().equals(\"ROLE_HIGH_ADMIN\") && !loginVO.getAuthorCode().equals(\"ROLE_ADMIN\")%>">
									<p><span class="req">필수</span><spring:message code="ass.update.rcpt" /></p>
									</c:if>
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
												<td colspan="3">
													<input id="mngNum" class="f_txt w_full readonly" name="mngNum" type="text" value="${resultVO.mngNum}" maxlength="60" onchange="symbolCheck2(this);" onkeyup="symbolCheck2(this);" readonly="readonly"> 
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 대분류 --> 
													<label for="">대분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="largeCategoryNm" class="f_txt w_full readonly" name="largeCategoryNm" type="text" value="${resultVO.largeCategory}" readonly="readonly">
												</td>
												<td colspan="2">
												</td>
												<%-- <td class="lb">
													<!-- 수량 -->
													<label for="">수량</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="assetQty" class="f_txt w_full readonly" name="assetQty" type="text" value="${resultVO.assetQty}"  maxlength="20" readonly="readonly"
														onchange="getNumber(this);" onkeyup="getNumber(this);">
												</td> --%>
											</tr>
											<tr>
												<td class="lb">
													<!-- 중분류 --> 
													<label for="">중분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select w_full" for="middleCategory">
														<select id="middleCategory" name="middleCategory" onchange="checkMcatEtc();">
														</select>
													</label> 
												</td>
												<td colspan="2">
													<input id="mcatEtc" name="mcatEtc" class="f_txt w_full" type="hidden" value="${resultVO.mcatEtc}" maxlength="60" onchange="symbolCheck1(this);" onkeyup="symbolCheck1(this);"> 
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 제조사 --> 
													<label for="">제조사</label>
												</td>
												<td>
													<label class="f_select w_full" for="largeCategory">
															<select id="makerCode" name="makerCode" onchange="checkMakerEtc();">
																<option value="" label="선택하세요" />
																<c:forEach var="result" items="${maker_result}" varStatus="status">
																<c:choose>
																	<c:when test="${result.codeNm == '기타'}">
																		<option value="${result.code}" <c:if test="${result.code == resultVO.makerCode}">selected="selected"</c:if>>
																			<c:out value="${result.codeNm}(직접입력)" />
																		</option>
																	</c:when>
																	<c:otherwise>
																		<option value="${result.code}" <c:if test="${result.code == resultVO.makerCode}">selected="selected"</c:if>>
																			<c:out value="${result.codeNm}" />
																		</option>
																	</c:otherwise>
																</c:choose>
																</c:forEach>
															</select>
													</label>
												</td>
												<td colspan="2">
													<input id="maker" class="f_txt w_full" name="maker" type="hidden" value="${resultVO.maker}" maxlength="60" onchange="symbolCheck1(this);" onkeyup="symbolCheck1(this);"> 
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 품명 --> 
													<label for="">제품명(모델명)</label>
												</td>
												<td>
													<input id="assetName" class="f_txt w_full" name="assetName" type="text" value="${resultVO.assetName}"  maxlength="60" onchange="symbolCheck2(this);" onkeyup="symbolCheck2(this);">
												</td>
												<td class="lb">
													<!-- 시리얼넘버 --> 
													<label for="">시리얼넘버</label> <img class="manual_img" src="<c:url value='/'/>images/ico_question.png" onclick="AssetSnManual();">
												</td>
												<td>
													<input id="assetSn" class="f_txt w_full" name="assetSn" type="text" value="${resultVO.assetSn}" maxlength="60" onchange="symbolCheck2(this);" onkeyup="symbolCheck2(this);"> 
												</td>
											</tr>
											<c:if test="${masterVO.assId eq 'ASSMSTR_000000000002'}">
												<tr>
													<td class="lb">
														<!-- 렌탈업체 --> 
														<label for="">렌탈업체</label>
													</td>
													<td colspan="3">
														<input id="assetCompany" class="f_txt w_full" name="assetCompany" value="${resultVO.assetCompany}" type="text"  maxlength="60" onchange="symbolCheck2(this);" onkeyup="symbolCheck2(this);">
													</td>
												</tr>
											</c:if>
											<tr>
												<td class="lb">
													<!-- 수령일자 --> 
													<label for="">수령일자</label> 
												</td>
												<td colspan="3">
													<span class="search_date w_full">
														<input id="rcptDate" class="f_txt w_full readonly" value="${resultVO.rcptDate}" name="rcptDate" type="text" readonly="readonly">
													</span>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령자 --> 
													<label for="">수령자</label> 
													<span class="req">필수</span>
												</td>
												<c:choose>
													<c:when test="<%= !loginVO.getAuthorCode().equals(\"ROLE_HIGH_ADMIN\") && !loginVO.getAuthorCode().equals(\"ROLE_ADMIN\")%>">
														<td>
															<input id="rcptNm"  class="f_txt w_full readonly"  type="text" maxlength="100"
																readonly="readonly"  value="${resultVO.rcptNm}"/>
															<input name="rcptId" id="rcptId" type="hidden"
																maxlength="8" readonly="readonly" value="${resultVO.rcptId}"/>
														</td>
													</c:when>
													<c:otherwise>
														<td>
															<span class="f_search2 w_full"> 
															<input id="rcptNm" type="text" maxlength="100"
																readonly="readonly"  value="${resultVO.rcptNm}"/>
															<button type="button" class="btn" onclick="UserSearch(0);">조회</button>
															</span> 
															<input name="rcptId" id="rcptId" type="hidden"
																maxlength="8" readonly="readonly" value="${resultVO.rcptId}"/>
														</td>
													</c:otherwise>
												</c:choose>
												<td class="lb">
													<!-- 실사용자 --> 
													<label for="">실사용자</label> 
												</td>
												<td>
													<span class="f_search2 w_full"> 
														<input id="useNm" type="text" title="회원" maxlength="100"
															readonly="readonly" value="${resultVO.useNm}"/>
														<button type="button" class="btn" onclick="UserSearch(1);">조회</button>
													</span> 
													<input name="useId" id="useId" type="hidden"
														maxlength="8" readonly="readonly" value="${resultVO.useId}"/>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 부서 --> 
													<label for="orgnztId">본부/부서</label>
												</td>
												<td>
													<label class="f_select  w_full" for="orgnztId">
														<select id="orgnztId" name="orgnztId" title="부서">
															<option value="" label="선택하세요" />
															<c:forEach var="orgnztId" items="${orgnztId_result}"
																varStatus="status">
																<option value="${orgnztId.code}" <c:if test="${orgnztId.code == resultVO.orgnztId}">selected="selected"</c:if>>
																	<c:out value="${orgnztId.codeNm}" />
																</option>
															</c:forEach>
													</select>
													</label>
												</td>
												<td class="lb">
													<!-- 프로젝트 --> 
													<label for="">프로젝트</label>
												</td>
												<td>
													<span class="f_search2 w_full"> 
													<input id="prjNm" type="text" title="프로젝트" maxlength="100"
														readonly="readonly" value="${resultVO.prjNm}"/>
													<button type="button" class="btn"
														onclick="ProjectSearch();">조회</button>
													</span> 
													<form:errors path="prjId" /> 
													<input name="prjId" id="prjId" type="hidden" title="프로젝트"  maxlength="8"
														readonly="readonly" value="${resultVO.prjId}"/>
												</td>
											</tr>
											<c:choose>
											<c:when test="${masterVO.assId eq 'ASSMSTR_000000000001'}">
												<tr>
													<td class="lb">
														<!-- 취득일자 --> <label for="">취득일자</label>
													</td>
													<td>
													<span class="search_date w_full">
														<input id="acquiredDate" class="f_txt w_full readonly" name="acquiredDate" type="text" value="${resultVO.acquiredDate}" readonly="readonly">
													</span>
													</td>
													<td class="lb">
														<!-- 취득가액 --> <label for="">취득가액</label>
													</td>
													<td>
													<input id="acquiredPrice" class="f_txt w_full"
													name="acquiredPrice" type="text" value="${resultVO.acquiredPrice}"  maxlength="60" onchange="getNumber(this);" onkeyup="getNumber(this);">
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
													<div>
														<span class="search_date wp_date">
															<input id="assetStart" class="f_txt w_full readonly" name="assetStart" type="text" value="${resultVO.assetStart}" maxlength="60" readonly="readonly" onchange="checkStartDate()">
														</span>
														&nbsp;&nbsp;―&nbsp;&nbsp;
														<span class="search_date wp_date">
															<input id="assetEnd" class="f_txt w_full readonly" name="assetEnd" type="text" value="${resultVO.assetEnd}" maxlength="60" readonly="readonly" onchange="checkEndDate()">
														</span>
													</div>
												</tr>
												<tr>
													<td class="lb">
														<!-- 렌탈비용 --> 
														<label for="">렌탈비용</label> 
													</td>
													<td colspan="3">
													<input id="acquiredPrice" class="f_txt w_full"
													name="acquiredPrice" type="text" value="${resultVO.acquiredPrice}"  maxlength="60" onchange="getNumber(this);" onkeyup="getNumber(this);">
													</td>
												</tr>
											</c:when>
											</c:choose>
											<tr>
												<td class="lb">
													<label for="egovComFileUploader">지급확인서</label>
													<img class="manual_img" src="<c:url value='/'/>images/ico_question.png" onclick="FileManual();">
												</td>
												<td colspan="3">
													<div class="filebox">
													    <label for="fileFrm">파일찾기</label > 
													    <input name="fileFrm" id="fileFrm" type="file" onchange="getFileName(this)">
													    <c:if test="${not empty FileVO}">
													    	<img alt="" src="/images/ico_delete.png" onclick="addDelFile('${FileVO.atchFileId}')">
													    </c:if>
													    <div class="namebox">
													    	<input name="fileNm" id="fileNm" type="text" readonly="readonly" <c:if test="${not empty FileVO}">value="${FileVO.orignlFileNm}"</c:if> >
													    </div>
													</div>
													<input name="file" id="file" type="file" style="display: none">
													<input name="delFile" id="delFile" type="hidden">
												</td>
											</tr>
											<tr>
												<td class="lb">
													<label for="egovComFileUploader">제품사진</label>
													<img class="manual_img" src="<c:url value='/'/>images/ico_question.png" onclick="PhotoManual();"> <br><span class="f_14">(최대 5장)</span>
												<td colspan="3">
													<div class="filebox">
													    <label for="photoFrm">파일찾기</label> 
													    <input name="photoFrm" id="photoFrm" type="file" multiple accept=".jpg, .png, .jpeg" onchange="checkPhoto(this)">
													</div>
													<input name="photo" id="photo" type="file" style="display: none"/>
													<input name="delPhoto" id="delPhoto" type="hidden">
													<div class="photoList">
														<c:forEach var="photo" items="${PhotoList}" varStatus="status">
															<div class="photobox">
																<div class="boxBtn">
																	<img alt="" src="/images/ico_delete.png" onclick="addDelPhoto(this,'${photo.atchFileId}')">
																</div>
																<div class="boxImg">
																	<img alt="" src="/uploadFile/${photo.streFileNm}">
																</div>
															</div>
														</c:forEach>
													</div> 
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 비고 --> 
													<label for="note">비고</label>
												</td>
												<td colspan="3">
													<textarea id="note" name="note" class="f_txtar w_full " cols="30" rows="1" >${resultVO.note}</textarea>
												</td>
											</tr>
										</table>
									</div>
									<!-- 버튼  -->
									<div class="board_view_bot btn_bot">
										<div class="right_btn btn1">
											<!-- 수정 -->
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="UpdtConfirm(); return false;"><spring:message
													code="button.update" /></a>
											<!-- 취소 -->
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="SelectAsset(); return false;"><spring:message
													code="button.cancel" /></a>
											<!-- 목록 -->
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="AssetList(); return false;"><spring:message
													code="button.list" /></a>
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
</body>
<form id="subForm" name="subForm" method="post" action="<c:url value='/ass/SelectAsset.do'/>">
	<input type="hidden" id="assetId" name="assetId" value="${resultVO.assetId}">
	<input type="hidden" id="mngNum" name="mngNum" value="${resultVO.mngNum}">
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
	<input name="pageIndex" id="pageIndex" type="hidden"  value="<c:out value="${searchVO.pageIndex}"/>" />
	<input type="hidden" name="pageUnit" value="<c:out value='${searchVO.pageUnit}'/>"/>
</form>
</html>