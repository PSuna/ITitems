<%--
  Class Name : AssetInsert.jsp
  Description : 자산등록 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------      --------    ---------------------------
     2023.04.13    주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.04.13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
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
<validator:javascript formName="carryRegist" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
let trClone;
let addtrClone;
var userCheck = 0;
var resetBtn = $('<img class="reset_btn" src="<c:url value='/'/>images/jsh_icon_reset.png">');
/* ********************************************************
 * 반출신청상세 등록 처리
 ******************************************************** */
function insertCarryDetail(reqId) {
	let dataList;
	let trList = document.querySelector('.assetlist tbody').querySelectorAll("tr");
	trList.forEach(function(items,index) {
		let formdata = new FormData();
		formdata.append('reqId', reqId);
		let Mcat = items.querySelector('#middleCategory').value;
		let qty = items.querySelector('#reqQty').value;
		if(Mcat != '' && Mcat != null && qty != null && qty != '' && qty != 0){
			formdata.append('largeCategory', items.querySelector('#largeCategory').value);
			formdata.append('middleCategory', Mcat);
			formdata.append('reqQty', qty);
			formdata.append('maker', items.querySelector('#maker').value);
			formdata.append('user', items.querySelector('#user').value);
			formdata.append('reqOrder', trList.length - index);
			$.ajax({
				url: '${pageContext.request.contextPath}/req/insertRequestDetail.do',
				method: 'POST',
				enctype: "multipart/form-data",
				processData: false,
				contentType: false,
				data: formdata,
				success: function (result) {
					insertApproval(result);
				},
				error: function (error) {
					RegistFail();
				}
			}) 
		}
		
	});
}

/* ********************************************************
 * 반출신청 등록 처리
 ******************************************************** */
function insertCarry() {
		let formData = new FormData(document.getElementById('frm'));
	 	$.ajax({
			url: '${pageContext.request.contextPath}/req/insertRequest.do',
			method: 'POST',
			enctype: "multipart/form-data",
			processData: false,
			contentType: false,
			data: formData,
			success: function (result) {
				insertCarryDetail(result);
			},
			error: function (error) {
				RegistFail();
			}
		})
}
/* ********************************************************
 * 결재자 등록 처리
 ******************************************************** */
function insertApproval(reqId){
	let tdList = document.querySelector('.approvalList tbody').querySelectorAll('td');
	let i = 0;
	let targetUp = '';
	tdList.forEach(function(items,index) {
		let formdata = new FormData();
		formdata.append('reqId', reqId);
		let aprv = '#aprv'+index;
		let targetId = items.querySelector(aprv).value;
		
		if(!targetId && targetId == ''){
			return;
		}
		
		formdata.append('targetId', targetId);
		
		if(targetUp != null && targetUp != ''){
			console.log(targetUp);
			formdata.append('targetUp', targetUp);
		}
		
		targetUp = targetId;
		
		$.ajax({
			url: '${pageContext.request.contextPath}/aprv/ApprovalInsert.do',
			method: 'POST',
			enctype: "multipart/form-data",
			processData: false,
			contentType: false,
			data: formdata,
			success: function (result) {
				RegistSuccess();
			},error: function (error) {
				RegistFail();
			}
		})
	});
}

/* ********************************************************
 * 등록확인 팝업창
 ******************************************************** */
 function RegistConfirm(){
	 removeP();
	 if(validateCarryRegist(document.frm) && checkValid()){
		 var $dialog = $('<div id="modalPan"></div>')
			.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/RegistConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
			.dialog({
		    	autoOpen: false,
		        modal: true,
		        width: 500,
		        height: 300
			});
		    $(".ui-dialog-titlebar").hide();
			$dialog.dialog('open');
	 } 
}

/* ********************************************************
 * 등록확인 결과 처리
 ******************************************************** */
 function returnConfirm(val){
 
	fn_egov_modal_remove();
	 if(val){
		 insertCarry();
	 }	  
}

/* ********************************************************
 * 등록완료 팝업창
 ******************************************************** */
 function RegistSuccess(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/RegistSuccess.do'/>" +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 600,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}

/* ********************************************************
 * 등록완료 결과 처리
 ******************************************************** */
 function returnSuccess(val){
	
	if(val){
		fn_egov_modal_remove();
	    $('form').each(function() {
	        this.reset();
	    });
	    removeP();
	    console.log($('#frm #delTr'));
	    if($('#frm #delTr').length == 9){
	    	$('#clonehere').append(addtrClone);
	    }
	    $('#frm #delTr').each(function(){
	    	$(this).closest('tr').remove();
		})
		document.frm.prjNm.focus(); 
	}else{
		document.CarryRequset.submit();
	}

}

/* ********************************************************
 * 등록실패 팝업창
 ******************************************************** */
 function RegistFail(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/RegistFail.do'/>" +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 600,
	        height: 400
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}

/* ********************************************************
 * 자산 입력 폼 추가
 ******************************************************** */
function addTr(num) {
	for(let i=0; i<num; i++){
	 let tr = $(trClone).clone(true);
	 let a = $('<a/>').addClass('btn').text('-').on('click',function(){
		 delTr(this);
	 });
	 let btn = $('<div/>').addClass('btn1').attr("id","delTr").append(a);
	 $(tr).children('td').last().append(btn);
	 $('#clonehere tr').last().before(tr);
	 if($('#clonehere').children('tr').length == 11){
		 $('#clonehere tr').last().remove();
		 return;
	 }
	}
}

/* ********************************************************
 * 자산 입력 폼 삭제
 ******************************************************** */
function delTr(obj) {
	 $(obj).closest('tr').remove();
	 if($('#clonehere').children('tr').length == 9){
		 $('#clonehere').append(addtrClone);
	 }
	 console.log($('#clonehere').children('tr'));
}

/* ********************************************************
 * 중분류 조회
 ******************************************************** */
function getMCatList(Lcat) {
	
	let val = Lcat.value;
	let mCat = Lcat.closest("td").querySelector("div");
	if (val == "ETC"){
		mCat.replaceChildren();
		let input = document.createElement('input');
		input.setAttribute('id', 'middleCategory');
		input.setAttribute('name', 'middleCategory');
		input.setAttribute('type', 'text');
		input.setAttribute('class', 'f_txt w_full');
		mCat.appendChild(input);
	}else if (val == ""){
		mCat.replaceChildren();
		let label = document.createElement('label');
		label.setAttribute('class', 'f_select w_full');
		let select = document.createElement('select');
		select.setAttribute('id', 'middleCategory');
		select.setAttribute('name', 'middleCategory');
		let op = document.createElement('option');
		op.textContent = '중분류';
		op.value = "";
		select.appendChild(op);
		label.appendChild(select);
		mCat.appendChild(label);
	}else{
		$.ajax({
			url: '${pageContext.request.contextPath}/cat/GetMCategoryList.do',
			method: 'POST',
			contentType: 'application/x-www-form-urlencoded',
			data: {'searchUpper' : val},
			success: function (result) {
				mCat.replaceChildren();
				let label = document.createElement('label');
				label.setAttribute('class', 'f_select w_full');
				let select = document.createElement('select');
				select.setAttribute('id', 'middleCategory');
				select.setAttribute('name', 'middleCategory');
				let op = document.createElement('option');
				op.textContent = '중분류';
				op.value = "";
				select.appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.catId);
					op.textContent = res.catName;
					select.appendChild(op);
				}
				label.appendChild(select);
				mCat.appendChild(label);
			},
			error: function (error) {
				console.log(error);
			}
		})	
	} 
	
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
 * 검색 회원 입력
 ******************************************************** */
function returnUser(val){
if (val) {
	if(userCheck == 0){
		document.getElementById("pm").value  = val.userId;
		document.getElementById("pmNm").value  = val.userNm;
	}else if(userCheck == 1){
		document.getElementById("aprv0").value  = val.userId;
		document.getElementById("aprvNm0").value  = val.userNm;
	}else if(userCheck == 2){
		document.getElementById("aprv1").value  = val.userId;
		document.getElementById("aprvNm1").value  = val.userNm;
	}else if(userCheck == 3){
		document.getElementById("aprv2").value  = val.userId;
		document.getElementById("aprvNm2").value  = val.userNm;
	}else if(userCheck == 4){
		document.getElementById("aprv3").value  = val.userId;
		document.getElementById("aprvNm3").value  = val.userNm;
	}
	
}

fn_egov_modal_remove();
}


/* ********************************************************
 * date input 생성
 ******************************************************** */
function make_date(){
	
	$("#startDate").datepicker(
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

	$("#endDate").datepicker( 
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
 * 유효성 체크
 ******************************************************** */
let typeList = ["input", "select"]

function removeP() {
	$(typeList).each(function(index, type){
		$("#frm").find(type).each(function(index, item){
			let td = $(item).closest("td");
			if($(td).children().last().prop('tagName') == 'P'){
				$(td).children().last().remove();
			}
		})
	})
}

function alertValid(objList) {
	$(typeList).each(function(index, type){
		$("#frm").find(type).each(function(index, item){
			let td = $(item).closest("td");
			for(key in objList){
				if($(item).attr("name") == key){
					$(td).append($('<p/>').addClass('alertV').text(objList[key]));
				}
			}
		})
	})
	checkTd();
}

function checkValid(){
	let result = checkTd();
	if(result != null){
		$(result).focus();
		return false;
	}else{
		return true;
	}
}

function checkTd(){
	let obj = null;
	$('#frm #middleCategory, #frm #reqQty').each(function(){
		if($(this).val() == null || $(this).val() == ""){
			if($(this).attr('id') == 'middleCategory'){
				$(this).closest('td').append($('<p/>').addClass('alertV').text("중분류은(는) 필수 입력값입니다."));	
			}else if($(this).attr('id') == 'reqQty'){
				$(this).closest('td').append($('<p/>').addClass('alertV').text("수량은(는) 필수 입력값입니다."));
			}
			if(obj == null){
				obj = $(this);
			}
		}
	})
	
	if($('#frm #aprvNm3').val() == null || $('#frm #aprvNm3').val() == 0){
		$('#frm #aprvNm3').closest('td').append($('<p/>').addClass('alertV').text("결재자4은(는) 필수 입력값입니다."));
		if(obj == null){
			obj = $('#frm #aprvNm3');
		}
	}
	
	return obj;
}

/* ********************************************************
 *  검색 날짜 체크
 ******************************************************** */
function checkEndDate() {
	let startDate = $('#frm #startDate').val();
	let endDate = $('#frm #endDate').val();
	if(startDate != null && startDate > endDate){
		$('#frm #startDate').val(endDate);
		$('#frm #endDate').val("");
	}
}

function checkStartDate(){
	let startDate = $('#frm #startDate').val();
	let endDate = $('#frm #endDate').val();
	if(startDate != null && startDate > endDate){
		$('#frm #endDate').val("");
	}
}

/* ********************************************************
 * onload
 ******************************************************** */
window.onload = function(){
	addtrClone =  $('#clonehere tr').last().clone(true);
	trClone = $('#clonehere tr').last().prev().clone(true);
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
										<li>반출 신청</li>
									</ul>
								</div>
								<!--// Location -->
								<form id="frm" name="frm" autocomplete="off">
									<h2 class="tit_2">반출 신청</h2>
									<input name="reqGroup" value="C1" type="hidden"> <input
										name="reqStatus" value="A0" type="hidden"> <br>
									<h3> ■ 신청자정보</h3>
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
													<!-- 성명 --> <label for="">성명</label> <span class="req">필수</span>
												</td>
												<td><span class="f_search2 w_full"> <input
														value="${userManageVO.emplyrNm}" type="text"
														readonly="readonly">
												</span> <input value="${userManageVO.uniqId}" id="id" name="id"
													type="hidden" readonly="readonly"></td>
												<td class="lb">
													<!-- 직위 --> <label for="">직위</label>
												</td>
												<td><span class="f_search2 w_full"> <input
														type="text" readonly="readonly"
														value="${userManageVO.grade}">

												</span></td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 프로젝트 --> <label for="">프로젝트</label>
												</td>
												<td colspan="3"><span class="f_search2 wp_90"> <input
														id="prjNm" type="text" title="프로젝트" maxlength="100"
														readonly="readonly"/>
														<button type="button" class="btn"
															onclick="ProjectSearch();">조회</button>
												</span> <input name="prjId" id="prjId"
													type="hidden" title="프로젝트" value="" 
													/></td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용장소 --> <label for="">사용장소</label> <span class="req">필수</span>
												</td>
												<td><input type="text" class="f_txt w_full" id="place"
													name="place"></td>
												<td class="lb">
													<!-- PM(관리자) --> <label for="">PM(관리자)</label> <span
													class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 wp_90"> 
														<input name="pmNm" id="pmNm" type="text" title="회원" maxlength="100" readonly="false" />
														<button type="button" class="btn" onclick="UserSearch(0);">조회</button>
													</span>
													<input name="pm" id="pm" type="hidden" title="pm" value="" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용기간 --> <label for="">반출기간</label> <span class="req">필수</span>
												</td>
												<td colspan="3">
													<div>
														<span class="search_date">
															<input id="startDate" class="f_txt w_40%" name="startDate" type="text" maxlength="60" onchange="checkStartDate()">
														</span>
														&nbsp;&nbsp;―&nbsp;&nbsp;
														<span class="search_date">
															<input id="endDate" class="f_txt w_40%" name="endDate" type="text" maxlength="60" onchange="checkEndDate()">
														</span>
													</div>
												</td>
											</tr>
										</table>
									</div>
								<br>
								<h3> ■ 자산정보 <span class="f_s_15">(최대 10칸)</span></h3>
								<div class="board_view2 assetlist">
									<table>
										<colgroup>
											<col style="width: 22%;">
											<col style="width: 15%;">
											<col style="width: 29%;">
											<col style="width: 34%;">
										</colgroup>
										<thead>
											<tr>
												<td class="lb"><label for="">분류</label><span
													class="req">필수</span></td>
												<td class="lb"><label for="">수량</label><span
													class="req">필수</span></td>
												<td class="lb"><label for="">S/N(노트북)/제조사</label></td>
												<td class="lb"><label for="">사용자</label></td>
											</tr>
										</thead>
										<tbody id='clonehere'>
											<tr>
												<td><label class="f_select w_full" for="largeCategory">
														<select id="largeCategory" name="largeCategory"
														title="대분류" onchange="getMCatList(this);">
															<option value="" label="대분류" />
															<c:forEach var="LCat" items="${LCat_result}"
																varStatus="status">
																<option value="${LCat.catId}">
																	<c:out value="${LCat.catName}" />
																</option>
															</c:forEach>
															<option value="ETC" label="직접입력" />
													</select>
												</label>
													<div id="mCat">
														<label class="f_select w_full" for="middleCategory"> <select
															id="middleCategory" name="middleCategory" title="중분류">
																<option value='' label="중분류" selected="selected" />
														</select>
														</label>
													</div></td>
												<td><input id="reqQty" name="reqQty" type="text"
													class="f_txt w_full" onchange="getNumber(this);" onkeyup="getNumber(this);"></td>
												<td><input id="maker" name="maker" type="text"
													class="f_txt w_full"></td>
												<td class="btn_rel"><input id="user" name="user" type="text"
													class="f_txt w_full">	
												</td>
											</tr>
											<tr>
											<td colspan="4">
												<div class="right_btn btn1">
													<!-- 입력칸 1개 추가 -->
													<a href="#LINK" class="btn btn_blue_46 w_80 f_s_21"
														onclick="addTr(1);">+</a>
													<!-- 입력칸 5개 추가 -->
													<a href="#LINK" class="btn btn_blue_46 w_80 f_s_21"
														onclick="addTr(5);">+ 5</a>
												</div>
											</td>
										</tr>
										</tbody>
									</table>
								</div>
								<br>
								<div class="approvalList">
								<h3> ■ 결재정보</h3>
									<table class="board_view2">
										<colgroup>
											<col style="width: 25%;">
											<col style="width: 25%;">
											<col style="width: 25%;">
											<col style="width: 25%;">
										</colgroup>
										<thead>
											<tr>
												<td>결재자1</td>
												<td>결재자2</td>
												<td>결재자3</td>
												<td>결재자4<span class="req">필수</span></td>
											</tr>
										</thead>
										<tbody>
											<tr>
												<td class='apvrTd'>
													<span class="f_search2 w_80%">
														<input name="aprvNm0" type="text" id="aprvNm0" title="결재자1이름" maxlength="100" readonly="true" />
														<button type="button" class="btn" onclick="UserSearch(1);">조회</button>
													</span>
													<button type="button" class="btn" onclick="UserDelete(1);">X</button>
													<input name="aprv0" id="aprv0" type="hidden" title="결재자1ID" value="" />
												</td>
												<td class='apvrTd'>
													<span class="f_search2 w_80%">
														<input name="aprvNm1" id="aprvNm1" type="text" title="결재자1이름" maxlength="100" readonly="true" />
														<button type="button" class="btn" onclick="UserSearch(2);">조회</button>
													</span>
													<button type="button" class="btn" onclick="UserDelete(2);">X</button>
													<input name="aprv1" id="aprv1" type="hidden" title="결재자1ID" value="" />
												</td>
												<td class='apvrTd'>
													<span class="f_search2 w_80%">
														<input name="aprvNm2" id="aprvNm2" type="text" title="결재자1이름" maxlength="100" readonly="true" />
														<button type="button" class="btn" onclick="UserSearch(3);">조회</button>
													</span>
													<button type="button" class="btn" onclick="UserDelete(3);">X</button>
													<input name="aprv2" id="aprv2" type="hidden" title="결재자1ID" value="" />
												</td>
												<td class='apvrTd'>
													<span class="f_search2 w_80%">
														<input name="aprvNm3" id="aprvNm3" type="text" title="결재자1이름" maxlength="100" readonly="true" />
														<button type="button" class="btn" onclick="UserSearch(4);">조회</button>
													</span>
													<button type="button" class="btn" onclick="UserDelete(4);">X</button>
													<input name="aprv3" id="aprv3" type="hidden" title="결재자1ID" value="" />
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								</form>
								<br>
								<!-- 등록버튼  -->
								<div class="board_view_bot">
									<div class="right_btn btn1">
										<a href="#LINK" class="btn btn_blue_46 w_100" onclick="RegistConfirm();return false;"><spring:message code="button.create" /></a>
										<!-- 등록 -->
									</div>
								</div>
								<!-- // 등록버튼 끝  -->
								<form name="CarryRequset" method="post" action="<c:url value='/req/CarryRequset.do'/>">
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
	<!-- Footer -->
	<c:import url="/sym/mms/EgovFooter.do" />
	<!--// Footer -->
	</div>
</body>
</html>