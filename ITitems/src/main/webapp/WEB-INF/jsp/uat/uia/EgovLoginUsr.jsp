<%--
  Class Name : EgovLoginUsr.jsp
  Description : 로그인화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.10    천세훈             최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.04.10
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >

	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/pty_m.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/pty.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
<script type="text/javascript">
<!--
function actionLogin() {

    if (document.loginForm.id.value =="") {
        alert("아이디를 입력하세요");
        return false;
    } else if (document.loginForm.password.value =="") {
        alert("비밀번호를 입력하세요");
        return false;
    } else {
        document.loginForm.action="<c:url value='/uat/uia/web/actionSecurityLogin.do'/>";
        document.loginForm.submit();
    }
}


function setCookie (name, value, expires) {
    document.cookie = name + "=" + escape (value) + "; path=/; expires=" + expires.toGMTString();
}

function getCookie(Name) {
    var search = Name + "="
    if (document.cookie.length > 0) { // 쿠키가 설정되어 있다면
        offset = document.cookie.indexOf(search)
        if (offset != -1) { // 쿠키가 존재하면
            offset += search.length
            // set index of beginning of value
            end = document.cookie.indexOf(";", offset)
            // 쿠키 값의 마지막 위치 인덱스 번호 설정
            if (end == -1)
                end = document.cookie.length
            return unescape(document.cookie.substring(offset, end))
        }
    }
    return "";
}

function saveid(form) {
    var expdate = new Date();
    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
    if (form.checkId.checked)
        expdate.setTime(expdate.getTime() + 1000 * 3600 * 24 * 30); // 30일
    else
        expdate.setTime(expdate.getTime() - 1); // 쿠키 삭제조건
    setCookie("saveid", form.id.value, expdate);
}

function getid(form) {
    form.checkId.checked = ((form.id.value = getCookie("saveid")) != "");
}

function fnInit() {
    var message = document.loginForm.message.value;
    if (message != "") {
        alert(message);
    }
    getid(document.loginForm);
}
//-->
</script>
 <link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>   

</head>
<body onload="fnInit();">
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <div class="container pty_container" style="padding-bottom: 60px;">
            <div class="sub_layout pty_sub_layout">
                <div class="sub_in">
                    <div class="layout">
                        <div class="P_LOGIN">
                        	
                        	<div class="pty_P_LOGIN_bottom">	
	                        	<img src="<c:url value='/'/>images/iteyes_logo.png" height="70px">
	                            <h1>자산관리 솔루션</h1>
	                           <!--  <p class="txt">로그인</p> -->
	                         </div>   
                            
                            <div class="loginbox">
                                <form:form id="loginForm" name="loginForm" method="post">
                                    <fieldset>
                                        <legend>로그인</legend>
                                        <div class="pty_flex">
	                                        <div>
		                                        <dl>
		                                         <dt><label for="memid">이메일주소</label></dt> 
		                                            <dd><input class="pdi" type="text" placeholder="아이디" style="width:180px; margin-right:10px;" title="사내 메일 주소를 입력하세요." id="id" name="id" maxlength="30"/>@ iteyes.co.kr</dd>
		                                        </dl>
		            
		                                        <dl>
		                                          <dt><label for="pwd">비밀번호  </label></dt> 
		                                            
		                                            <dd>
		                                            	<input type="password" maxlength="25" placeholder="비밀번호" title="비밀번호를 입력하세요." id="password" name="password" onkeydown="javascript:if (event.keyCode == 13) { actionLogin(); }"/>
		                                            	  
		                                            	  <div class="bot pty_bot">
				                                            <label for="chk" class="f_chk pty_f_chk">
						                                        <input type="checkbox" name="checkId" id="chk" title="ID 저장" onClick="javascript:saveid(document.loginForm);" />
						                                        <span>ID 저장</span>
						                                    </label>
		                                    				<!-- <a href="/uat/uia/egovSrchPw.do" style="color:#aaa; cursor:pointer">비밀번호 찾기</a> -->
                                   						 </div>		                                            	
		                                            </dd>
		                                            
		                                        </dl>
		                                    </div>    
										
	                                        <a href="#LINK" class="btn_login" onclick="javascript:actionLogin()">로그인</a>
										</div>
											 <a href="#LINK" class="pty_m_btn_login" onclick="javascript:actionLogin()">로그인</a>
                                      
                                    </fieldset>
                                    <input type="hidden" name="message" value="${message}" />
		                            <input type="hidden" name="userSe" value="USR"/>
		                            <input name="j_username" type="hidden"/>
		                    	</form:form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

       
    </div>
    
     
       <!--// Footer -->
    
</body>
</html>