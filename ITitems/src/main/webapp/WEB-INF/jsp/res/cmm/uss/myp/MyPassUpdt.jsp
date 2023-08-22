<%--
  Class Name : MyPassUpdt.jsp
  Description : 암호수정 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.16   천세훈              최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.04.16
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
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

	
<link rel="icon" type="image/png" href="<c:url value="/" />images/res/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>

<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="passwordChgVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(id){
	location.href="${pageContext.request.contextPath}/res/uss/myp/MyManage.do?uniqId="+id;
}
function fnUpdate(){
	let formData = new FormData(document.getElementById('passwordChgVO'));
	$.ajax({
		url:'${pageContext.request.contextPath}/res/uss/myp/EgovMyPasswordUpdt.do',
		method:'POST',
		enctype: "multipart/form-data",
		processData: false,
		contentType: false,
		data: formData,
		success:function(result){
			console.log(result);
			if(result == "true"){
				fn_egov_modal_remove();
				UpdateSuccess();
			}else{
				fn_egov_modal_remove();
				document.getElementById('oldPasswordErr').innerHTML='비밀번호가 일치하지 않습니다.';
			}
		}
	})
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>

/* ********************************************************
 * 수정확인 팝업창
 ******************************************************** */
function fnCheckPw(e){
	fnCheckPw1(e);
	fnCheckPw2(e);
	fnCheckPw3(e);
}

function fnCheckPw1(e){
	let p_pass = e.value;

    if (e.value.length < 8 || e.value.length > 20 ){
		document.getElementById('hint1').style.color= 'red';
    }else{
    	document.getElementById('hint1').style.color= 'green';
    }
}
function fnCheckPw2(e){
	let p_pass = e.value;
    var cnt=0,cnt2=1,cnt3=1;
    var temp="";

    for(i=0;i < p_pass.length;i++){
            temp_pass1 = p_pass.charAt(i);
            next_pass = (parseInt(temp_pass1.charCodeAt(0)))+1;
            temp_p = p_pass.charAt(i+1);
            temp_pass2 = (parseInt(temp_p.charCodeAt(0)));
            if (temp_pass2 == next_pass)
                cnt2 = cnt2 + 1;
            else
                cnt2 = 1;
            if (temp_pass1 == temp_p)
                cnt3 = cnt3 + 1;
            else
                cnt3 = 1;
            if (cnt2 > 3) break;
            if (cnt3 > 3) break;
    }
    if (cnt2 > 3){
    	document.getElementById('hint2').style.color= 'red';
    }else{
    	document.getElementById('hint2').style.color= 'green';
    }
}

function fnCheckPw3(e){
	let p_pass = e.value;
    var cnt=0,cnt2=1,cnt3=1;
    var temp="";

    for(i=0;i < p_pass.length;i++){
            temp_pass1 = p_pass.charAt(i);
            next_pass = (parseInt(temp_pass1.charCodeAt(0)))+1;
            temp_p = p_pass.charAt(i+1);
            temp_pass2 = (parseInt(temp_p.charCodeAt(0)));
            if (temp_pass2 == next_pass)
                cnt2 = cnt2 + 1;
            else
                cnt2 = 1;
            if (temp_pass1 == temp_p)
                cnt3 = cnt3 + 1;
            else
                cnt3 = 1;
            if (cnt2 > 3) break;
            if (cnt3 > 3) break;
    }
    if (cnt3 > 3){
    	document.getElementById('hint3').style.color= 'red';
    }else{
    	document.getElementById('hint3').style.color= 'green';
    }
}
/* ********************************************************
 * 수정확인 팝업창
 ******************************************************** */
function UpdateConfirm(){
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
		
}
/* ********************************************************
 * 수정확인 결과 처리
 ******************************************************** */
 function returnConfirm(val){
	
	fn_egov_modal_remove();
	 if(val){
		 UpdateIng();
		 fncheckValid();
	 }	  
}
 /* ********************************************************
 * 수정진행 팝업창
 ******************************************************** */
 function UpdateIng(){
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
  function UpdateSuccess(){
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
 	document.passwordChgVO.action= "<c:url value='/res/uss/myp/MyManage.do'/>";
	document.passwordChgVO.submit();
}
/* ********************************************************
* 수정실패 팝업창
******************************************************** */
function UpdateFail(){
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
function fncheckValid(){
		if(!document.passwordChgVO.oldPassword.value){
			fn_egov_modal_remove();
			document.getElementById('oldPasswordErr').innerHTML='이전비밀번호를 입력하세요';
			return;
		}else{
			document.getElementById('oldPasswordErr').innerHTML='';
		}
		if(!document.passwordChgVO.newPassword.value ){
			fn_egov_modal_remove();
			document.getElementById('newPasswordErr').innerHTML='비밀번호를 입력하세요';
			return;
		}else{
			document.getElementById('newPasswordErr').innerHTML='';
		}
		if(!document.passwordChgVO.newPassword2.value){
			fn_egov_modal_remove();
			document.getElementById('newPassword2Err').innerHTML='비밀번호 확인을 입력하세요';
			return;
		}else{
			document.getElementById('newPassword2Err').innerHTML='';
		}
		
		if(validatePasswordChgVO(document.passwordChgVO)){
	        if(document.passwordChgVO.newPassword.value != document.passwordChgVO.newPassword2.value){
	        	fn_egov_modal_remove();
	            document.getElementById('newPassword2Err').innerHTML='비밀번호가 일치하지 않습니다.';
	            return;
	        }else{
	        	document.getElementById('newPassword2Err').innerHTML= '';
	        	fnUpdate();
	        }
        }
}
//-->
</script>
<style>
.errSpan{
	color:red;
	font-size:14px;
}
.inputHint{
	font-size:14px;
	color:#bbb;
}
.board_view_bot{
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
                    	<div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">사이트관리</a></li>
                                        <li><a href="">사용자관리</a></li>
                                        <li>비밀번호변경</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="passwordChgVO" id="passwordChgVO" method="post" action="${pageContext.request.contextPath}/res/uss/myp/EgovMyPasswordUpdt.do" >
								<!-- onsubmit="javascript:return FormValidation(document.passwordChgVO);" >  -->
								<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
								<input name="checkedIdForDel" type="hidden" />
								<!-- 검색조건 유지 -->
								<input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
								<input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
								<input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
								<input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
								<!-- 우편번호검색 -->
								<input type="hidden" name="url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />

                                <h2 class="tit_2">비밀번호변경</h2>

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 25%;">
                                            <col style="width: 25%;">
                                            <col style="width: 50%;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrId">사용자아이디</label>
                                            </td>
                                            <td colspan="3">
                                                <input name="emplyrId" id="emplyrId" class="f_txt w_full readonly"  title="사용자아이디" type="text" value="<c:out value='${userManageVO.emplyrId}'/>" maxlength="20" readonly="readonly"/>
                                                <input name="uniqId" id="uniqId" title="uniqId" type="hidden" value="<c:out value='${userManageVO.uniqId}'/>"/>
                                                <input name="userTy" id="userTy" title="userTy" type="hidden" value="<c:out value='${userManageVO.userTy}'/>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="oldPassword">기존 비밀번호</label>
                                            </td>
                                            <td colspan="3">
                                                <input name="oldPassword" id="oldPassword" class="f_txt w_full" title="기존 비밀번호" type="password" value="" maxlength="100" />
                                                <br><span id="oldPasswordErr" class="errSpan"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="newPassword">변경할 비밀번호</label>
                                            </td>
                                            <td colspan="3">
                                            	<div class="passHint">
	                                            	<label for="empUniqNum" class="inputHint" id="hint1">8~20자 이내</label><br>
				                                    <label for="empUniqNum" class="inputHint" id="hint2">연속된 문자나 순차적인 문자 4개이상 사용금지</label><br>
				                                    <label for="empUniqNum" class="inputHint" id="hint3">반복문자나 숫자 연속 4개이상 사용금지</label>
			                                    </div>
                                                <input name="newPassword" id="newPassword" class="f_txt w_full" title="비밀번호" type="password" value="" onkeyup="fnCheckPw(this);"maxlength="100" />
                                                <br><span id="newPasswordErr" class="errSpan"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="newPassword2">변경할 비밀번호확인</label>
                                            </td>
                                            <td colspan="3">
                                                <input name="newPassword2" id="newPassword2" class="f_txt w_full" title="비밀번호확인" type="password" value="" maxlength="100" />
                                                <br><span id="newPassword2Err" class="errSpan"></span>
                                            </td>
                                        </tr>
                                    </table>
                                    
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.passwordChgVO.reset();">초기화</a><!-- 초기화 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:UpdateConfirm(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:fnListPage('${userManageVO.uniqId}'); return false;">이전</a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                </form>
                            </div>
                        </div>
                        <%-- <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">마이페이지</a></li>
                                        <li>비밀번호변경</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="passwordChgVO" method="post" action="${pageContext.request.contextPath}/res/uss/myp/EgovMyPasswordUpdt.do" >
								<!-- onsubmit="javascript:return FormValidation(document.passwordChgVO);" >  -->
								<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
								<input name="checkedIdForDel" type="hidden" />
								<!-- 검색조건 유지 -->
								<input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
								<input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
								<input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
								<input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
								<!-- 우편번호검색 -->
								<input type="hidden" name="url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />

                                <h2 class="tit_2">비밀번호변경</h2>

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrId">사용자아이디</label>
                                            </td>
                                            <td>
                                                <input name="emplyrId" id="emplyrId" class="f_txt" title="사용자아이디" type="text" value="<c:out value='${userManageVO.emplyrId}'/>" maxlength="20" readonly="readonly"/>
                                                <input name="uniqId" id="uniqId" title="uniqId" type="hidden" value="<c:out value='${userManageVO.uniqId}'/>"/>
                                                <input name="userTy" id="userTy" title="userTy" type="hidden" value="<c:out value='${userManageVO.userTy}'/>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="oldPassword">기존 비밀번호</label>
                                            </td>
                                            <td>
                                                <input name="oldPassword" id="oldPassword" class="f_txt" title="기존 비밀번호" type="password" value="" maxlength="100" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="newPassword">비밀번호</label>
                                            </td>
                                            <td>
                                                <input name="newPassword" id="newPassword" class="f_txt" title="비밀번호" type="password" value="" maxlength="100" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="newPassword2">비밀번호확인</label>
                                            </td>
                                            <td>
                                                <input name="newPassword2" id="newPassword2" class="f_txt" title="비밀번호확인" type="password" value="" maxlength="100" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.passwordChgVO.reset();">초기화</a><!-- 초기화 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:fnUpdate(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/cmm/myp/MyManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage('${userManageVO.uniqId}'); return false;">이전</a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                </form>
                                
                            </div>
                        </div> --%>
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