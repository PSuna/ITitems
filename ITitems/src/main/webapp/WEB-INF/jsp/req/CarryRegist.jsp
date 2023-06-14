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
<link rel="stylesheet" href="<c:url value='/'/>css/pty.css">
<link rel="stylesheet" href="<c:url value='/'/>css/pty_m.css">
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
	let trList = document.querySelectorAll('#assetTbody tr');
	trList.forEach(function(items,index) {
		let formdata = new FormData();
		formdata.append('reqId', reqId);
		let assetId = items.querySelector('input').value;
		let reqQty = items.querySelector('.reqQty').value;
		console.log(assetId);
		formdata.append('assetId', assetId);
		formdata.append('reqQty', reqQty);
		formdata.append('reqOrder', trList.length - index);
		$.ajax({
			url: '${pageContext.request.contextPath}/req/insertRequestDetail.do',
			method: 'POST',
			enctype: "multipart/form-data",
			processData: false,
			contentType: false,
			data: formdata,
			success: function (result) {
			},
			error: function (error) {
				RegistFail();
				return;
			}
		}) 
	});
	insertApproval(reqId);
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
			return;
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
		formdata.append('aprvOrder', index);
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
				
			},error: function (error) {
				fn_egov_modal_remove();
				RegistFail();
				return;
			}
		})
	});
	fn_egov_modal_remove();
	RegistSuccess();
}

/* ********************************************************
 * 등록확인 팝업창
 ******************************************************** */
function RegistConfirm(){
	removeP();
	let trList = document.querySelectorAll('#assetTbody tr');
	if(trList.length > 0){
		if(validateCarryRegist(document.frm) && checkValid()){
			var $dialog = $('<div id="modalPan"></div>')
				.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/RegistConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
				.dialog({
			    	autoOpen: false,
			        modal: true,
			        width: 400,
			        height: 300
				});
			$(".ui-dialog-titlebar").hide();
			$dialog.dialog('open');
		}
	}else{
		alert('반출신청할 자산이 없습니다.');
		return;
	}
}

/* ********************************************************
 * 등록확인 결과 처리
 ******************************************************** */
 function returnConfirm(val){
 
	fn_egov_modal_remove();
	 if(val){
		 RegistIng();
		 insertCarry(); 
	 }	  
}

/* ********************************************************
 * 등록진행 팝업창
 ******************************************************** */
 function RegistIng(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/RegistIng.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 등록완료 팝업창
 ******************************************************** */
 function RegistSuccess(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/com/RegistSuccess.do'/>" +'" width="100%" height="100%"></iframe>')
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
		document.getElementById("prjNm").value  = "";
	    document.getElementById("pm").value  = "";
	    document.getElementById("aprv0").value  = "";
	    document.getElementById("aprv1").value  = "";
	    document.getElementById("aprv2").value  = "";
	    document.getElementById("aprv3").value  = "";
	    $("#assetTbody tr").remove();
	    
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
	        width: 400,
	        height: 300
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
        width: 660,
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
		document.getElementById("pmNm").value  = val.pmNm;
		document.getElementById("pm").value  = val.pmId;
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
 * 검색 자산 입력
 ******************************************************** */
function returnAss(val){
	var assetIds = document.querySelectorAll(".assetIds");
	for (let i=0; i<assetIds.length; i++){
		if(val.assetId == assetIds[i].value){
			alert("이미 추가된 자산입니다.");
			return;
		}
	}
	if (val) {
		var assetId = val.assetId;
		var middleCategory = val.middleCategory;
		var assetQty = val.assetQty;
		var assetSn = val.assetSn;
		var maker = val.maker;
		var rcptNm = val.rcptNm;
		var useNm = val.useNm;
		var p = `<tr style="text-align:center;">
					<input type='hidden' value='`+assetId+`' class='assetIds'>
					<td>`+middleCategory+`</td>
					<td><input type="text" class="reqQty" name="reqQty" value="`+assetQty+`" onchange="checkNum(this, `+assetQty+`)" style="width:70%;"/></td>
					<td>`+assetSn+` / `+maker+`</td>
					<td>`+rcptNm+`</td>
					<td>`+useNm+`</td>
					<td><button style="padding:0 15px;" class="btn pty_btn" onclick="deleteTr(this); return false;">삭제</button></td>
				 </tr>`;
		$("#assetTbody").append(p);
	}
	
	fn_egov_modal_remove();
}
/* ********************************************************
 * 자산 tr 삭제
 ******************************************************** */
 function deleteTr(e){
	 $(e).closest('tr').remove();
}
/* ********************************************************
 * 숫자 유효성 검사
 ******************************************************** */
function checkNum(e, assetQty){
	if(!isNaN(e.value)){
	 	if(Number(e.value) <= 0){
	 		e.value = 1;
	 		return;
	 	}else if(Number(e.value) > assetQty){
	 		e.value = assetQty;
	 		return;
	 	}else{
			return;
	 	}
 	}else{
 		e.value = assetQty;
 	}
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
	
	if($('#aprvTbl #aprv0').val() == $('#id').val()){
		$('#aprvTbl #aprv0').closest('td').append($('<p/>').addClass('alertV').text("본인은 자동으로 결재승인 처리합니다."));
		if(obj == null){
			obj = $('#aprvTbl #aprv0');
		}
	}
	if($('#aprvTbl #aprv1').val() == $('#id').val()){
		$('#aprvTbl #aprv1').closest('td').append($('<p/>').addClass('alertV').text("본인은 자동으로 결재승인 처리합니다."));
		if(obj == null){
			obj = $('#aprvTbl #aprv1');
		}
	}
	if($('#aprvTbl #aprv2').val() == $('#id').val()){
		$('#aprvTbl #aprv2').closest('td').append($('<p/>').addClass('alertV').text("본인은 자동으로 결재승인 처리합니다."));
		if(obj == null){
			obj = $('#aprvTbl #aprv2');
		}
	}
	if($('#aprvTbl #aprv3').val() == $('#id').val()){
		$('#aprvTbl #aprv3').closest('td').append($('<p/>').addClass('alertV').text("본인은 자동으로 결재승인 처리합니다."));
		if(obj == null){
			obj = $('#aprvTbl #aprv3');
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

/* ********************************************************
 * 목록 버튼
 ******************************************************** */
function ReqList(){
	document.CarryRequset.action="<c:url value='/req/CarryRequset.do'/>";
	document.CarryRequset.submit();
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

.board_view_bot {
	overflow: hidden;
}

.right_btn {
	float: right;
}

.board_view2 thead .lb{
	text-align: center;
}
.addAsset{
	display: flex;
    justify-content: space-between;
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
									<input name="reqGroup" value="C1" type="hidden">
									<br>
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
													<label for="">신청자</label>
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
												<td><span class="f_search2 w_full"> <input
														id="prjNm" type="text" title="프로젝트" maxlength="100"
														readonly="readonly"/>
														<button type="button" class="btn"
															onclick="ProjectSearch();">조회</button>
												</span> <input name="prjId" id="prjId"
													type="hidden" title="프로젝트" value="" 
													/></td>
													<td class="lb">
													<!-- PM(관리자) --> <label for="">PM(관리자)</label> <span
													class="req">필수</span>
												</td>
												<td>
													<span class="f_search2 w_full"> 
														<input name="pmNm" id="pmNm" type="text" title="회원" maxlength="100" readonly="false" />
														<button type="button" class="btn" onclick="UserSearch(0);">조회</button>
													</span>
													<input name="pm" id="pm" type="hidden" title="pm" value="" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용장소 --> <label for="">사용장소</label> <span class="req">필수</span>
												</td>
												<td colspan='3'><input type="text" class="f_txt w_full" id="place"
													name="place"></td>
												
											</tr>
											<tr>
												<td class="lb">
													<!-- 사용기간 --> <label for="">반출기간</label> (시작일<span class="req">필수</span>)
												</td>
												<td colspan="3">
													<div>
														<span class="search_date">
															<input id="startDate" class="f_txt w_40%" name="startDate" type="text" maxlength="60" readonly="readonly" checkStartDate()">
														</span>
														&nbsp;&nbsp;―&nbsp;&nbsp;
														<span class="search_date">
															<input id="endDate" class="f_txt w_40%" name="endDate" type="text" maxlength="60" readonly="readonly" onchange="checkEndDate()">
														</span>
													</div>
												</td>
											</tr>
										</table>
									</div>
								<br>
								<div class="addAsset">
									<h3> ■ 자산정보</h3>
									<button class="btn pty_btn" onclick="javascript:AssetSearch(); return false;" style="margin-bottom:4px;">자산추가 +</button>
								</div>
								<div class="board_view2 assetlist">
									<table>
										<colgroup>
											<col style="width: 15%;">
											<col style="width: 10%;">
											<col style="width: 35%;">
											<col style="width: 15%;">
											<col style="width: 15%;">
											<col style="width: 10%;">
										</colgroup>
										<thead>
											<tr>
												<td class="lb"><label for="">분류</label></td>
												<td class="lb"><label for="">수량</label></td>
												<td class="lb"><label for="">S/N(노트북)/제조사</label></td>
												<td class="lb"><label for="">수령자</label></td>
												<td class="lb"><label for="">실사용자</label></td>
												<td class="lb"></td>
											</tr>
										</thead>
										<tbody id='assetTbody'>
											<%-- <tr>
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
																<option value="" label="중분류" selected="selected" />
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
										</tr> --%>
										</tbody>
									</table>
								</div>
								<br>
								<div class="approvalList">
								<h3> ■ 결재정보</h3>
									<table class="board_view2" id="aprvTbl">
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
													<input name="aprv0" id="aprv0" type="hidden" class="aprvNms" title="결재자1ID" value="" />
												</td>
												<td class='apvrTd'>
													<span class="f_search2 w_80%">
														<input name="aprvNm1" id="aprvNm1" type="text" title="결재자1이름" maxlength="100" readonly="true" />
														<button type="button" class="btn" onclick="UserSearch(2);">조회</button>
													</span>
													<input name="aprv1" id="aprv1" type="hidden" class="aprvNms" title="결재자1ID" value="" />
												</td>
												<td class='apvrTd'>
													<span class="f_search2 w_80%">
														<input name="aprvNm2" id="aprvNm2" type="text" title="결재자1이름" maxlength="100" readonly="true" />
														<button type="button" class="btn" onclick="UserSearch(3);">조회</button>
													</span>
													<input name="aprv2" id="aprv2" type="hidden" class="aprvNms" title="결재자1ID" value="" />
												</td>
												<td class='apvrTd'>
													<span class="f_search2 w_80%">
														<input name="aprvNm3" id="aprvNm3" type="text" title="결재자1이름" maxlength="100" readonly="true" />
														<button type="button" class="btn" onclick="UserSearch(4);">조회</button>
													</span>
													<input name="aprv3" id="aprv3" type="hidden" class="aprvNms" title="결재자1ID" value="" />
												</td>
											</tr>
										</tbody>
									</table>
								</div>
								</form>
								<!-- 등록버튼  -->
								<div class="board_view_bot btn_bot">
									<div class="right_btn btn1">
										<a href="#LINK" class="btn btn_blue_46 w_100" onclick="RegistConfirm();return false;"><spring:message code="button.create" /></a>
										<a href="#LINK" class="btn btn_blue_46 w_100" onclick="ReqList();return false;"><spring:message code="button.list" /></a>
										<!-- 등록 -->
									</div>
								</div>
								<!-- // 등록버튼 끝  -->
								<form name="CarryRequset" method="post" action="<c:url value='/req/CarryRequset.do'/>">
									<c:set var="start" value="<%=new java.util.Date(new java.util.Date().getTime() - 60*60*24*1000*90L)%>" />
									<input type="hidden" id="menuStartDate" name="menuStartDate" value="<fmt:formatDate value="${start}" pattern="yyyy-MM-dd" />" />
									<c:set var="end" value="<%=new java.util.Date()%>" />
									<input type="hidden" id="menuEndDate" name="menuEndDate" value="<fmt:formatDate value="${end}" pattern="yyyy-MM-dd" />" />
									<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" >
									<input type="hidden" name="searchGroup" value="<c:out value='${searchVO.searchGroup}'/>">
									<input type="hidden" name="searchStatus" value="<c:out value='${searchVO.searchStatus}'/>" />
									<input type="hidden" name="prjNm" value="<c:out value='${searchVO.prjNm}'/>" />
									<input type="hidden" name="searchPrj" value="<c:out value='${searchVO.searchPrj}'/>" />
									<input type="hidden" name="searchWord" value="<c:out value='${searchVO.searchWord}'/>" />
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