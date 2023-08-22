<%--
  Class Name : MyManage.jsp
  Description : 내정보 조회, 수정 jsp
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.05.08   천세훈			최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.05.08
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="<c:url value='/'/>css/res/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/page.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>


<link rel="icon" type="image/png" href="<c:url value="/" />images/res/pty_tap_icon.png" />
<title>마이페이지</title>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/**********************************************************
 * 이전화면 이동
 ******************************************************** */
function fnListPage(){
    document.userManageVO.action = "<c:url value='/res/cmm/main/mainPage.do'/>";
    document.userManageVO.submit();
}

/**********************************************************
 * 암호변경화면 이동
 ******************************************************** */
function fnPasswordMove(){
    document.userManageVO.action = "<c:url value='/res/uss/myp/EgovUserMyPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}
/* ********************************************************
 * 내정보 수정 처리
 ******************************************************** */
function UpdateMyPage(){
	if(fncheckNums() == 'false'){
		fn_egov_modal_remove();
		return;
	}else{
		let formData = new FormData(document.getElementById('userManageVO'));
		$.ajax({
			url: '${pageContext.request.contextPath}/res/uss/myp/MyPageUpdt.do',
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
		});
	}
}
/* ********************************************************
 * 숫자 유효성 검사
 ******************************************************** */
function checkNum(e){
    var num01;
    var num02;
    num01 = e.value;
    if(num01 != null && num01 != ""){
    	num02 = num01.replace(/(^0-9+)/, "");
	    num03 = num02.replace(/\D/g,"");
	    num01 = num03;
	    e.value =  num01;
    }
    if (e.value.length == e.maxLength) {
    	if(e.id == 'moblphonNo1'){
        	document.getElementById('moblphonNo2').focus();
    	}
    	if(e.id == 'moblphonNo2'){
        	document.getElementById('moblphonNo3').focus();
    	}
    }
}
/* ********************************************************
 * 필수값, 사번, 휴대폰 번호 형식 검사
 ******************************************************** */
 function fncheckValid(){
 	if(!document.userManageVO.emplyrNm.value){
		document.getElementById('emplyrNmErr').innerHTML='이름은 필수입력값입니다.';
	}else{
		document.getElementById('emplyrNmErr').innerHTML='';
	}
	
	if(!document.userManageVO.orgnztId.value){
		document.getElementById('orgnztIdErr').innerHTML='본부는 필수입력값입니다.';
	}else{
		document.getElementById('orgnztIdErr').innerHTML='';
	}
	
	if(!document.userManageVO.grade.value){
		document.getElementById('gradeErr').innerHTML='직급은 필수입력값입니다.';
	}else{
		document.getElementById('gradeErr').innerHTML='';
	}
	
 	var phone1 = document.getElementById('moblphonNo1');
	var phone2 = document.getElementById('moblphonNo2');
	var phone3 = document.getElementById('moblphonNo3');
	moblphoneNo= phone1.value + '-' +phone2.value+ '-' +phone3.value;
	var patt = new RegExp("[0-9]{3}-[0-9]{3,4}-[0-9]{4}");
	var res = patt.test(moblphoneNo);
	if(phone1.value != null && phone1.value != '' || phone2.value != null && phone2.value != '' || phone3.value != null && phone3.value != '' ){
		if(!patt.test(moblphoneNo)){
			document.getElementById('phoneErr').innerHTML='전화번호를 정확히 입력해주세요.';
		}else{
			document.userManageVO.moblphonNo.value = moblphoneNo;
			document.getElementById('phoneErr').innerHTML='';
		}
	}else{
		document.getElementById('phoneErr').innerHTML='';
	}
	
	var empUniqNum = document.getElementById('empUniqNum').value;
	var patt1 = new RegExp("20[0-9]{7}");
	var res1 = patt.test(empUniqNum);
	if(empUniqNum != null && empUniqNum != ''){
		if(!patt1.test(empUniqNum)){
			document.getElementById('empUniqErr').innerHTML='유효하지 않은 사원번호입니다.';
		}else{
			document.userManageVO.empUniqNum.value = empUniqNum;
			document.getElementById('empUniqErr').innerHTML='';
		}
	}else{
		document.getElementById('empUniqErr').innerHTML='';
	}
}
/* ********************************************************
 * 사번, 휴대폰 번호 형식 검사
 ******************************************************** */
function fncheckNums(){
	var phone1 = document.getElementById('moblphonNo1');
	var phone2 = document.getElementById('moblphonNo2');
	var phone3 = document.getElementById('moblphonNo3');
	let checkNum = 'true';
	moblphoneNo= phone1.value + '-' +phone2.value+ '-' +phone3.value;
	var patt = new RegExp("[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}");
	var res = patt.test(moblphoneNo);
	if(phone1.value != null && phone1.value != '' || phone2.value != null && phone2.value != '' || phone3.value != null && phone3.value != '' ){
		if(!patt.test(moblphoneNo)){
			document.getElementById('phoneErr').innerHTML='전화번호를 정확히 입력해주세요.';
			checkNum = 'false';
		}else{
			document.userManageVO.moblphonNo.value = moblphoneNo;
			document.getElementById('phoneErr').innerHTML='';
		}
	}else{
		document.getElementById('phoneErr').innerHTML='';
	}
	
	var empUniqNum = document.getElementById('empUniqNum').value;
	var patt1 = new RegExp("20[0-9]{7}");
	var res1 = patt.test(empUniqNum);
	if(empUniqNum != null && empUniqNum != ''){
		if(!patt1.test(empUniqNum)){
			document.getElementById('empUniqErr').innerHTML='유효하지 않은 사원번호입니다.';
			checkNum = 'false'
		}else{
			document.userManageVO.empUniqNum.value = empUniqNum;
			document.getElementById('empUniqErr').innerHTML='';
		}
	}else{
		document.getElementById('empUniqErr').innerHTML='';
	}
	return checkNum;
}
/* ********************************************************
 * 수정확인 팝업창
 ******************************************************** */
 function UpdtConfirm(){
    if(validateUserManageVO(document.userManageVO)){
		var $dialog = $('<div id="modalPan"></div>')
			.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/UpdtConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
			.dialog({
		    	autoOpen: false,
		        modal: true,
		        width: 400,
		        height: 300
		        
			});
		    $(".ui-dialog-titlebar").hide();
			$dialog.dialog('open');
    }else{
		fn_egov_modal_remove();
		fncheckValid();
	}
}

/* ********************************************************
 * 수정확인 결과 처리
 ******************************************************** */
 function returnConfirm(val){
 
	fn_egov_modal_remove();
	 if(val){
		 UpdtIng();
		 UpdateMyPage();
	 }	  
}

/* ********************************************************
* 수정진행 팝업창
******************************************************** */
function UpdtIng(){
 var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/UpdtIng.do'/>" +'" width="100%" height="100%"></iframe>')
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
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/UpdtSuccess.do'/>" +'" width="100%" height="100%"></iframe>')
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
	 document.userManageVO.action = "<c:url value='/res/uss/myp/MyManage.do'/>";
	 document.userManageVO.submit();
}

/* ********************************************************
 * 수정실패 팝업창
 ******************************************************** */
 function UpdtFail(){
	
	 var $dialog = $('<div id="modalPan"></div>')
		.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/UpdtFail.do'/>" +'" width="100%" height="100%"></iframe>')
		.dialog({
	    	autoOpen: false,
	        modal: true,
	        width: 400,
	        height: 300
		});
	    $(".ui-dialog-titlebar").hide();
		$dialog.dialog('open');
}

/**********************************************************
 * 모달 종료 버튼
 ******************************************************** */
function fn_egov_modal_remove() {
	$('#modalPan').remove();
}

/**********************************************************
 * 본부/부서 선택
 ******************************************************** */
function getMOrgList(MOval) {
	let val = document.getElementById('orgnztId').value;
	if(val == ""){
		document.getElementById('lowerOrgnzt').replaceChildren();
		let op = document.createElement('option');
		op.textContent = '부서';
		op.value = "";
		document.getElementById('lowerOrgnzt').appendChild(op);
	}else{
		$.ajax({
			url: '${pageContext.request.contextPath}/res/org/GetMOrgnztList.do',
			method: 'POST',
			contentType: 'application/x-www-form-urlencoded',
			data: {'searchUpperOrg' : val},
			success: function (result) {
				document.getElementById('lowerOrgnzt').replaceChildren();
				let op = document.createElement('option');
				op.textContent = '부서';
				op.value = "";
				document.getElementById('lowerOrgnzt').appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.orgnztId);
					op.textContent = res.orgnztNm;
					if(MOval == res.orgnztId){
						op.setAttribute('selected', 'selected');
					}
					document.getElementById('lowerOrgnzt').appendChild(op);
				}
			},
			error: function (error) {
				console.log(error);
			}
		})
		
	}
}
window.onload = function(){
	getMOrgList('${userManageVO.lowerOrgnzt}');
}
//-->
</script>
<style>
.errSpan {
	color: red;
	font-size: 12px;
}

.board_view_bot {
	margin-top: 8px;
}

.phoneNumBox {
	display: flex;
}

.divPnum {
	font-size: 22px;
	padding: 0 6px;
}

.f_txt {
	padding: 0 13px;
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
						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="">Home</a></li>
										<li>마이페이지</li>
									</ul>
								</div>
								<!--// Location -->

								<form:form modelAttribute="userManageVO" id="userManageVO" action="${pageContext.request.contextPath}/res/uss/myp/MyManage.do" name="userManageVO" method="post">
									<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
									<input name="checkedIdForDel" type="hidden" />
									<!-- 검색조건 유지 -->
									<input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>" />
									<input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>" />
									<input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>" />
									<input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>" />
									<input type="hidden" name="pageUnit" value="<c:out value='${userSearchVO.pageUnit}'/>" />
									<input type="hidden" name="searchOrgnzt" value="<c:out value='${userSearchVO.searchOrgnzt}'/>" />
									<input type="hidden" name="searchLOrgnzt" value="<c:out value='${userSearchVO.searchLOrgnzt}'/>" />
									<input type="hidden" name="searchGrade" value="<c:out value='${userSearchVO.searchGrade}'/>" />
									<input type="hidden" name="searchAuthor" value="<c:out value='${userSearchVO.searchAuthor}'/>" />
									<input type="hidden" name="selectedId" value="<c:out value='${userSearchVO.selectedId}'/>" />
									<!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
									<input type="hidden" name="userTyForPassword" value="<c:out value='${userManageVO.userTy}'/>" />

									<h2 class="tit_2">사용자정보 상세조회 및 수정</h2>

									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 16%;">
												<col style="width: 34%;">
												<col style="width: 16%;">
												<col style="width: 34%;">
											</colgroup>
											<tr>
												<td class="lb"><label for="emplyrId">사용자ID</label> <span class="req">필수</span></td>
												<td colspan="3"><form:input path="emplyrId" id="emplyrId" class="f_txt w_full readonly" maxlength="100" readonly="true" /> <form:errors path="emplyrId" /> <form:hidden path="uniqId" /></td>
												
											</tr>

											<tr>
												<td class="lb"><label for="emplyrNm">이름</label> <span class="req">필수</span></td>
												<td><form:input path="authorCode" id="authorCode" type="hidden" /> <form:input path="emplyrNm" id="emplyrNm" class="f_txt w_full" maxlength="60" /> <form:errors path="emplyrNm" /> <span
													id="emplyrNmErr" class="errSpan"></span></td>
												<td class="lb"><label for="orgnztId">본부</label> <span class="req">필수</span></td>
												<td><label class="item f_select w_full" for="orgnztId"> <form:select path="orgnztId" id="orgnztId" name="orgnztId" title="본부" onchange="getMOrgList();">
															<form:option value="" label="본부" />
															<form:options items="${orgnztId_result}" itemValue="code" itemLabel="codeNm" />
														</form:select>
												</label> <form:errors path="orgnztId" /> <span id="orgnztIdErr" class="errSpan"></span></td>
											</tr>
											<tr>
												<td class="lb"><label for="grade">직급</label> <span class="req">필수</span></td>
												<td><label class="f_select w_full" for="grade"> <form:select path="grade" id="grade" name="grade" title="직위">
															<form:option value="" label="선택하세요" />
															<form:options items="${grd_result}" itemValue="code" itemLabel="codeNm" />
														</form:select>
												</label> <form:errors path="grade" /> <span id="gradeErr" class="errSpan"></span></td>
												<td class="lb"><label for="orgnztId">부서</label></td>
												<td><label class="f_select w_full" for="lowerOrgnzt"> <form:select path="lowerOrgnzt" id="lowerOrgnzt" name="lowerOrgnzt" title="부서">
															<form:option value="" label="부서" />
														</form:select>
												</label></td>
											</tr>
											<tr>
												<td class="lb"><label for="empUniqNum">사번</label><br> </td>
												<td colspan="3"><label for="empUniqNum" class="inputHint">숫자9자리 ex)20XXXXXXX</label><form:input path="empUniqNum" id="empUniqNum" placeholder="ex) 20XXXXXXX" onkeyup="checkNum(this)" class="f_txt w_full" maxlength="9" /> <form:errors path="empUniqNum" /> <span
													id="empUniqErr" class="errSpan"></span></td>
											</tr>
											<tr>
												<td class="lb"><label for="moblphonNo">연락처</label><br> </td>
												<td colspan="3">
													<label for="moblphonNo" class="inputHint">ex) 010-XXXX-XXXX</label>
													<div class="phoneNumBox">
														<input value="<c:out value='${userManageVO.moblphonNo1}'/>" id="moblphonNo1" name="moblphonNo1" onkeyup="checkNum(this)" class="f_txt w_full inputs" maxLength="3" /><span class="divPnum">-</span>
														<input value="<c:out value='${userManageVO.moblphonNo2}'/>" id="moblphonNo2" name="moblphonNo2" onkeyup="checkNum(this)" class="f_txt w_full inputs" maxLength="4" /><span class="divPnum">-</span>
														<input value="<c:out value='${userManageVO.moblphonNo3}'/>" id="moblphonNo3" name="moblphonNo3" onkeyup="checkNum(this)" class="f_txt w_full inputs" maxLength="4" />
													</div> <form:input path="moblphonNo" id="moblphonNo" type="hidden" maxlength="13" /> <form:errors path="moblphonNo" /> <span id="phoneErr" class="errSpan"></span>
												</td>
											</tr>
										</table>
									</div>

									<!-- 목록/저장버튼  -->
									<div class="board_view_bot">
										<div class="left_col btn3">

											<a href="<c:url value='/res/uss/umt/user/EgovUserPasswordUpdtView.do'/>" class="btn btn_skyblue_h46 w_120" onclick="JavaScript:fnPasswordMove(); return false;"> <spring:message
													code="button.passwordUpdate" />
											</a>
											<!-- 비밀번호변경 -->
											<a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.userManageVO.reset();">초기화</a>
											<!-- 초기화 -->
										</div>

										<div class="right_col btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:UpdtConfirm(); return false;">수정</a>
											<!-- 저장 -->
											<a href="<c:url value='/res/uss/umt/user/EgovUserManage.do'/>" class="btn btn_blue_46 w_100" onclick="JavaScript:fnListPage(); return false;">메인</a>
											<!-- 목록 -->
										</div>
									</div>
									<!-- // 목록/저장버튼 끝  -->

									<form:hidden path="password" />

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