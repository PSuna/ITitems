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
	 document.subForm.submit();

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
	let val = document.getElementById('largeCategory').value;
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
				document.getElementById('middleCategory').appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.catId);
					op.textContent = res.catName;
					if(Mval == res.catName){
						op.setAttribute('selected', 'selected');
					}
					document.getElementById('middleCategory').appendChild(op);
				}
			},
			error: function (error) {
				console.log(error);
			}
		})
	}
}

/* ********************************************************
 * 숫자 콤마 입력
 ******************************************************** */
  function getNumber(obj){
     var num01;
     var num02;
     num01 = obj.value;
     num02 = num01.replace(/(^0+)/, "");
     num03 = num02.replace(/\D/g,"");
     num01 = setComma(num03);
     obj.value =  num01;

     $('#test').text(num01);
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
 * 프로젝트 검색
 ******************************************************** */
function ProjectSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/prj/ProjectSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
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
        width: 660,
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
	
	$("#acquiredDate").datepicker(
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
	
	$("#rcptDate").datepicker(
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
 * 유효성 체크
 ******************************************************** */
let typeList = ["input", "select"]

function removeP(objList) {
	$(typeList).each(function(index, type){
		$("#assetRegist").find(type).each(function(index, item){
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
 * 제품사진 안내
 ******************************************************** */
function PhotoManual(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/ass/PhotoManual.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 500
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 시리얼넘버 안내
 ******************************************************** */
function AssetSnManual(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/ass/AssetSnManual.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 450
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 지급확인서 안내
 ******************************************************** */
function FileManual(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/ass/FileManual.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 파일명 가져오기
 ******************************************************** */
 function getFileName(obj) {
	 if(obj.files.length>0){
		 $('#fileNm').val(obj.files[0].name);
	 }
}

/* ********************************************************
 * 지급확인서 파일명 가져오기
 ******************************************************** */
 function getFileName(obj) {
	 if(obj.files.length>0){
		 $('#fileNm').val(obj.files[0].name);
		 const dataTransfer = new DataTransfer();
		 dataTransfer.items.add(obj.files[0]);
		 $('input[name=file]')[0].files = dataTransfer.files; 
		 if($(obj).next().prop('tagName') != 'IMG'){
			 $(obj).after($("<img/>").attr("src","/images/ico_delete.png").on("click",function(){
				 delFileName();
				}));
		 }
		 $(obj).val('');
	 }
}

/* ********************************************************
 * 지급확인서 파일 지우기
 ******************************************************** */
 function delFileName() {
	 $('#fileNm').val('');
	 $('input[name=file]').val('');
	 $('#fileNm').closest(".filebox").find('img')[0].remove();
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
										<li><a href="#LINK">자산관리</a></li>
										<li>자산수정</li>
									</ul>
								</div>
								<!--// Location -->

								<%
									LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
								%>
								<form:form modelAttribute="AssetInfoVO" id="AssetUpdt" name="AssetUpdt" method="post" enctype="multipart/form-data" autocomplete="off">
									<input type="hidden" id="assetId" name="assetId" value="${resultVO.assetId}">
									<h1 class="tit_1">자산관리</h1>

									<h2 class="tit_2">자산수정</h2>

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
													<!-- 대분류 --> 
													<label for="">대분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select w_full" for="largeCategory">
															<select id="largeCategory" name="largeCategory"
																title="대분류" onchange="getMCatList();">
																<option value="" label="선택하세요" />
																<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
																	<option value="${LCat.catId}" <c:if test="${LCat.catName == resultVO.largeCategory}">selected="selected"</c:if>>
																		<c:out value="${LCat.catName}" />
																	</option>
																</c:forEach>
															</select>
															<form:errors path="largeCategory" />
													</label> 
													<br />
												</td>
												<td class="lb">
													<!-- 중분류 --> 
													<label for="">중분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select w_full" for="middleCategory">
														<select id="middleCategory" name="middleCategory">
														</select>
													</label> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 제조사 --> 
													<label for="">제조사</label>
												</td>
												<td>
													<input id="maker" class="f_txt w_full" name="maker" type="text" value="${resultVO.maker}" maxlength="60"> 
													<br />
												</td>
												<td class="lb">
													<!-- 품명 --> 
													<label for="">제품명(모델명)</label>
												</td>
												<td>
													<input id="assetName" class="f_txt w_full" name="assetName" type="text" value="${resultVO.assetName}"  maxlength="60">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 시리얼넘버 --> 
													<label for="">시리얼넘버</label> <img class="manual_img" src="<c:url value='/'/>images/ico_question.png" onclick="AssetSnManual();">
												</td>
												<td>
													<input id="assetSn" class="f_txt w_full" name="assetSn" type="text" value="${resultVO.assetSn}" maxlength="60"> 
												</td>
												<td class="lb">
													<!-- 수량 -->
													<label for="">수량</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="assetQty" class="f_txt w_full" name="assetQty" type="text" value="${resultVO.assetQty}"  maxlength="20"
														onchange="getNumber(this);" onkeyup="getNumber(this);">
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령일자 --> 
													<label for="">수령일자</label> 
												</td>
												<td colspan="4">
													<span class="search_date w_full">
														<input id="rcptDate" class="f_txt w_full" value="${resultVO.rcptDate}" name="rcptDate" type="text" readonly="readonly">
													</span>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수령자 --> 
													<label for="">소유자</label> 
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
																<option value="${orgnztId.code}" <c:if test="${orgnztId.codeNm == resultVO.orgnztId}">selected="selected"</c:if>>
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
											<tr>
												<td class="lb">
													<!-- 취득일자 --> 
													<label for="">취득일자</label>
												</td>
												<td>
													<span class="search_date w_full">
														<input id="acquiredDate" class="f_txt w_full" name="acquiredDate" type="text" value="${resultVO.acquiredDate}" readonly="readonly">
													</span>
												</td>
												<td class="lb">
													<!-- 취득가액 --> 
													<label for="">취득가액</label>
												</td>
												<td>
													<input id="acquiredPrice" class="f_txt w_full"
													name="acquiredPrice" type="text" value="${resultVO.acquiredPrice}"  maxlength="60" onchange="getNumber(this);" onkeyup="getNumber(this);">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<label for="egovComFileUploader">지급확인서</label>
													<img class="manual_img" src="<c:url value='/'/>images/ico_question.png" onclick="FileManual();">
												</td>
												<td colspan="4">
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
												<td colspan="4">
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
												<td colspan="4">
													<textarea id="note" name="note" class="f_txtar w_full " cols="30" rows="1" >${resultVO.note}</textarea>
												</td>
											</tr>
											<%-- <tr>
												<td class="lb">
													<!-- 반출사유 --> 
													<label for="carryReason">반출사유</label>
												</td>
												<td colspan="4">
												
													<textarea id="carryReason" name="carryReason"
														class="f_txtar w_full" cols="30" rows="1">${resultVO.carryReason}</textarea>
												</td>
											</tr> --%>
										</table>
									</div>
									<!-- 등록버튼  -->
									<div class="board_view_bot btn_bot">
										<div class="right_btn btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="UpdtConfirm(); return false;"><spring:message
													code="button.update" /></a>
											<!-- 등록 -->
										</div>
									</div>
									<!-- // 등록버튼 끝  -->
								</form:form>
								<form name="subForm" method="post" action="<c:url value='/ass/SelectAsset.do'/>">
									<input type="hidden" name="assetId"
										value="<c:out value='${resultVO.assetId}'/>" />
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