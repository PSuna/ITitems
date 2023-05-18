<%--
  Class Name : EgovUserSelectUpdt.jsp
  Description : 사용자상세조회, 수정 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.10   천세훈			최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.04.10
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
<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>

<title>사용자 상세 및 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.userManageVO.submit();
}
function fnDeleteUser(checkedIds) {
    if(confirm("<spring:message code="common.delete.msg" />")){
        document.userManageVO.checkedIdForDel.value=checkedIds;
        document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
        document.userManageVO.submit(); 
    }
}
function fnPasswordMove(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}
function fnUpdate(){
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
    if(validateUserManageVO(document.userManageVO)){
        document.userManageVO.submit();
    }
}
function fn_egov_inqire_cert() {
    var url = '/uat/uia/EgovGpkiRegist.do';
    var popupwidth = '500';
    var popupheight = '400';
    var title = '인증서';

    Top = (window.screen.height - popupheight) / 3;
    Left = (window.screen.width - popupwidth) / 2;
    if (Top < 0) Top = 0;
    if (Left < 0) Left = 0;
    Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
    PopUpWindow = window.open(url, title, Future)
    PopUpWindow.focus();
}

function fn_egov_dn_info_setting(dn) {
    var frm = document.userManageVO;
    
    frm.subDn.value = dn;
}

function fn_egov_ZipSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

function fn_egov_returnValue(retVal){
	
	if (retVal) {
		document.getElementById("zip_view").value  = retVal.sAddr;
	}
	
	fn_egov_modal_remove();
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
			url: '${pageContext.request.contextPath}/org/GetMOrgnztList.do',
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
//-->
</script>
<style>
.errSpan{
	color:red;
}
</style>
</head>
<body>
	<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
										<li><a href="">사이트관리</a></li>
										<li><a href="">사용자관리</a></li>
										<li>사용자등록관리</li>
									</ul>
								</div>
								<!--// Location -->

								<form:form modelAttribute="userManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserSelectUpdt.do"	name="userManageVO" method="post">
									<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
									<input name="checkedIdForDel" type="hidden" />
									<!-- 검색조건 유지 -->
									<input type="hidden" name="searchCondition"
										value="<c:out value='${userSearchVO.searchCondition}'/>" />
									<input type="hidden" name="searchKeyword"
										value="<c:out value='${userSearchVO.searchKeyword}'/>" />
									<input type="hidden" name="sbscrbSttus"
										value="<c:out value='${userSearchVO.sbscrbSttus}'/>" />
									<input type="hidden" name="pageIndex"
										value="<c:out value='${userSearchVO.pageIndex}'/>" />
									<!-- 우편번호검색 -->
									<input type="hidden" name="zip_url"
										value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" />
									<!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
									<input type="hidden" name="userTyForPassword"
										value="<c:out value='${userManageVO.userTy}'/>" />

									<h2 class="tit_2">사용자정보 상세조회 및 수정</h2>

									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 126px;">
												<col style="width: auto;">
												<col style="width: 120px;">
												<col style="width: auto;">
											</colgroup>
											<tr>
												<td class="lb">
													<label for="emplyrId">사용자ID</label>
													<span class="req">필수</span>
												</td>
												<td>
													<form:input path="emplyrId" id="emplyrId" class="f_txt w_full" maxlength="100" readonly="true" />
													<form:errors path="emplyrId" /> <form:hidden path="uniqId" />
												</td>
												<td class="lb">
													<label for="moblphonNo">H.P</label>
												</td>
												<td>
													<form:input path="moblphonNo" id="moblphonNo" class="f_txt w_full" maxlength="15" />
													<form:errors path="moblphonNo" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<label for="emplyrNm">이름</label>
													<span class="req">필수</span>
												</td>
												<td>
													<form:input path="authorCode" id="authorCode" type="hidden"/>
													<form:input path="emplyrNm" id="emplyrNm" class="f_txt w_full" maxlength="60" />
													<form:errors path="emplyrNm" />
													<span id="emplyrNmErr" class="errSpan"></span>
												</td>
												<td class="lb">
	                                                <label for="orgnztId">본부</label>
	                                                <span class="req">필수</span>
	                                            </td>
                                            	<td>
	                                                <label class="item f_select w_full" for="orgnztId"> 
														<form:select path="orgnztId" id="orgnztId" name="orgnztId" title="본부" style=" width: 200px;" onchange="getMOrgList();">
															<form:option value="" label="본부"/>
															<form:options items="${orgnztId_result}" itemValue="code" itemLabel="codeNm"/>
														</form:select>
													</label>
                                                <form:errors path="orgnztId" />
                                                <span id="orgnztIdErr" class="errSpan"></span>
                                            </td>
											</tr>
											<tr>
												<td class="lb">
	                                                <label for="grade">직급</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <label class="f_select w_full" for="grade">
	                                                    <form:select path="grade" id="grade" name="grade" title="직위">
		                                                    <form:option value="" label="선택하세요"/>
		                                                    <form:options items="${grd_result}" itemValue="code" itemLabel="codeNm"/>
	                                                    </form:select>
	                                                </label>
	                                                <form:errors path="grade" /> 
	                                                <span id="gradeErr" class="errSpan"></span>
	                                            </td>
	                                            <td class="lb">
	                                            	<label for="orgnztId">부서</label>
	                                            </td>
	                                            <td>
	                                            	<label class="f_select w_full" for="lowerOrgnzt">
														<form:select path="lowerOrgnzt" id="lowerOrgnzt" name="lowerOrgnzt" title="부서">
															<form:option value='' label="부서" />
														</form:select>
													</label> 
	                                            </td>
											</tr>
										</table>
									</div>

									<!-- 목록/저장버튼  -->
									<div class="board_view_bot">
										<div class="left_col btn3">
											<a href="<c:url value='/uss/umt/user/EgovUserDelete.do'/>"
												class="btn btn_skyblue_h46 w_100"
												onclick="fnDeleteUser('<c:out value='${userManageVO.userTy}'/>:<c:out value='${userManageVO.uniqId}'/>'); return false;"><spring:message
													code="button.delete" /></a>
											<!-- 삭제 -->
											<a
												href="<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>"
												class="btn btn_skyblue_h46 w_100"
												onclick="JavaScript:fnPasswordMove(); return false;">
												<spring:message code="button.passwordUpdate" /></a>
											<!-- 비밀번호변경 -->
											<a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.userManageVO.reset();">초기화</a>
											<!-- 초기화 -->
										</div>

										<div class="right_col btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="JavaScript:fnUpdate(); return false;"><spring:message
													code="button.save" /></a>
											<!-- 저장 -->
											<a href="<c:url value='/uss/umt/user/EgovUserManage.do'/>"
												class="btn btn_blue_46 w_100"
												onclick="JavaScript:fnListPage(); return false;"><spring:message
													code="button.list" /></a>
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
		<c:import url="/sym/mms/EgovFooter.do" />
		<!--// Footer -->
	</div>
<script>
var OrgnztUp = '${userManageVO.lowerOrgnzt}';
getMOrgList(OrgnztUp);
</script>
</body>
</html>