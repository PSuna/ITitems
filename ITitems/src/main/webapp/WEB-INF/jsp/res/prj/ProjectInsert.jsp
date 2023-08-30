<%--
  Class Name : ProjectInsert.jsp
  Description : 프로젝트 등록 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.05.02   천세훈			최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.05.02
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="<c:url value='/'/>css/res/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/page.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>
<script src="<c:url value='/'/>js/res/Inputcheck.js"></script>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="projectVO" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
var userCheck = 0;
/* ********************************************************
 * 프로젝트 등록 처리
 ******************************************************** */
function fnPrjInsert(){
	let formData = new FormData(document.getElementById('projectVO'));
	$.ajax({
		url:'${pageContext.request.contextPath}/res/prj/ProjectInsert.do',
		method:'POST',
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
	});
}

/* ********************************************************
 * PM 등록 시 회원 검색
 ******************************************************** */
function UserSearch(ch){
	userCheck = ch;
    
    var $dialog = $('<div id="modalPan" class="SearchList"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/uss/umt/user/SearchNeUserList.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 회원검색값 반환
 ******************************************************** */
function returnUser(val){
	if (val) {
		if(userCheck == 0){
			document.getElementById("id").value  = val.address;
			document.getElementById("name").value  = val.userNm;
		}else if(userCheck == 1){
			document.getElementById("id").value  = val.address;
			document.getElementById("name").value  = val.userNm;
		}
	}
	fn_egov_modal_remove();
}

/* ********************************************************
 * 등록확인 팝업창
 ******************************************************** */
function RegistConfirm(){
	if(validateProjectVO(document.getElementById('projectVO'))){
		if(fncheckValid()){
			var $dialog = $('<div id="modalPan"></div>')
				.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/RegistConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
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
}
/* ********************************************************
 * 날짜 유효성 검사
 ******************************************************** */
function fncheckValid(){
	var prjStart = document.projectVO.prjStart.value;
	var prjEnd = document.projectVO.prjEnd.value;
	if(prjStart && prjEnd && prjStart > prjEnd){
		document.getElementById('prjStartErr').innerHTML='시작일은 종료일 이전이어야합니다.';
		return false;
	}else{
		document.getElementById('prjStartErr').innerHTML='';
		return true;
	}
}
/* ********************************************************
 * 등록확인 결과 처리
 ******************************************************** */
 function returnConfirm(val){
	
	fn_egov_modal_remove();
	 if(val){
		 RegistIng();
		 fnPrjInsert(); 
	 }	  
}
/* ********************************************************
* 등록진행 팝업창
******************************************************** */
function RegistIng(){
	var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/RegistIng.do'/>" +'" width="100%" height="100%"></iframe>')
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
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/RegistSuccess.do'/>" +'" width="100%" height="100%"></iframe>')
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
		document.getElementById('projectVO').reset();
	}else{
		document.projectVO.action = "<c:url value='/res/prj/ProjectManage.do'/>";
		document.projectVO.submit();
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
 * 유효성검사
 ******************************************************** */
let typeList = ["input", "select"]
function alertValid(objList) {
	removeP();
	$(typeList).each(function(index, type){
		$("#projectVO").find(type).each(function(index, item){
			let td = $(item).closest("td");
			for(key in objList){
				if($(item).attr("name") == key){
					$(td).append($('<p/>').addClass('alertV').text(objList[key]));
				}
			}
		})
	})
}
function removeP() {
	$(typeList).each(function(index, type){
		$("#projectVO").find(type).each(function(index, item){
			let td = $(item).closest("td");
			if($(td).children().last().prop('tagName') == 'P'){
				$(td).children().last().remove();
			}
		})
	})
}

/* ********************************************************
 * date input 생성
 ******************************************************** */
function make_date(){
	
	$("#prjStart,#prjEnd").datepicker(
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
 *  날짜 체크
 ******************************************************** */
function checkEndDate() {
	let startDate = $('#prjStart').val();
	let endDate = $('#prjEnd').val();
	if(startDate != null && startDate > endDate){
		$('#prjStart').val(endDate);
		$('#prjEnd').val("");
	}
}

function checkStartDate(){
	let startDate = $('#prjStart').val();
	let endDate = $('#prjEnd').val();
	if(startDate != null && startDate > endDate){
		$('#prjEnd').val("");
	}
}

/* ********************************************************
 * onload
 ******************************************************** */
window.onload = function(){
	make_date();
	  }
//-->
</script>
<style>
.errSpan{
	color:red;
}
.board_view_bot {
	margin-top:8px;
}
</style>
</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
						<!-- Left menu -->
						<c:import url="/res/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->

						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="">Home</a></li>
										<li><a href="">사이트관리</a></li>
										<li><a href="">프로젝트관리</a></li>
										<li>프로젝트등록</li>
									</ul>
								</div>
								<!--// Location -->
								<form:form modelAttribute="projectVO" action="${pageContext.request.contextPath}/res/prj/ProjectInsert.do" name="projectVO" method="post">

									<h2 class="tit_2">프로젝트 등록</h2>

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
													<label for="prjName">프로젝트명</label>
													<span class="req">필수</span>
												</td>
												<td colspan="3">
													<form:input path="prjName" id="prjName" class="f_txt w_full" maxlength="50"/>
													<form:errors path="prjName" /> <form:hidden path="prjId" />
													<span id="prjNameErr" class="errSpan"></span>
												</td>
											</tr>
											<tr>
												<td class="lb">
													<label for="name">PM</label> 
												</td>
												<td>
													<span class="f_search2 w_full"> 
													<form:input path="name" id="name" type="text" title="PM" maxlength="20" readonly="true" />
													<form:errors path="name" />
													<span id="nameErr" class="errSpan"></span>
													<button type="button" class="btn" onclick="UserSearch(0);">조회</button>
													</span> 
													<form:input path="id" id="id" type="hidden" title="id" />
												</td>
												<td class="lb">
													<label for="prjCode">프로젝트코드</label> 
												</td>
												<td>
	                                                <form:input path="prjCode" id="prjCode" class="f_txt w_full" maxlength="30" onchange="symbolCheck1(this);" onkeyup="symbolCheck1(this);"/>
													<form:errors path="prjCode" />
													
	                                            </td>
											</tr>
											<tr>
												<td class="lb">
													<label for="prjStart">시작일</label>
												</td>
												<td>
													<span class="search_date w_full">
														<form:input path="prjStart" id="prjStart" class="f_txt w_full readonly" name="prjStart" type="text"  onchange="checkStartDate()" readonly="true"/>
													</span>
													<%-- <form:input path="prjStart" id="prjStart" class="f_txt w_full" type="date" />--%>
													<form:errors path="prjStart" /> 
													<span id="prjStartErr" class="errSpan"></span>
												</td>
												<td class="lb">
													<label for="orgnztId">종료일</label>
												</td>
												<td>
													<span class="search_date w_full">
														<form:input path="prjEnd" id="prjEnd" class="f_txt w_full readonly" name="prjEnd" type="text" onchange="checkEndDate()" readonly="true"/>
													</span>
													<%-- <form:input path="prjEnd" id="prjEnd" class="f_txt w_full" type="date"/> --%>
													<form:errors path="prjEnd" />
												</td>
											</tr>
											<tr>
												<td class="lb">
	                                                <label for="client">고객사</label>
	                                            </td>
	                                            <td>
	                                                <form:input path="client" id="client" class="f_txt w_full" maxlength="30" />
													<form:errors path="client" />
	                                            </td>
												<td class="lb">
	                                                <label for="prjState">진행구분</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <label class="f_select w_full" for="prjState">
														<form:select path="prjState" id="prjState" name="prjState" title="진행구분">
															<form:option value="" label="선택하세요" />
															<form:options items="${prjState_result}" itemValue="code"
																itemLabel="codeNm" />
														</form:select>
													</label>
	                                            </td>
											</tr>
										</table>
									</div>

									<!-- 목록/저장버튼  -->
									<div class="board_view_bot">
										<div class="left_col btn3">
											<a href="#LINK" class="btn btn_skyblue_h46 w_100"
												onclick="javascript:document.projectVO.reset();">초기화</a>
											<!-- 초기화 -->
										</div>

										<div class="right_col btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="JavaScript:RegistConfirm(); return false;"><spring:message
													code="button.save" /></a>
											<!-- 등록 -->
											<a href="<c:url value='/res/prj/ProjectManage.do'/>"
												class="btn btn_blue_46 w_100"
												onclick="fnListPage(); return false;"><spring:message
													code="button.list" /></a>
											<!-- 목록 -->
										</div>
									</div>
									<!-- // 목록/저장버튼 끝  -->


								</form:form>

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
</html>
