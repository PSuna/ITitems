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
<title>비밀번호찾기</title>
<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
<script type="text/javascript">
<!--
function actionSearchPassword() {

    if (document.SrchPwForm.id.value =="") {
        alert("메일주소를 입력하세요");
        return false;
    } else if (document.SrchPwForm.name.value =="") {
        alert("이름을 입력하세요");
        return false;
    } else {
        document.SrchPwForm.action="<c:url value='/uat/uia/actionSearchPassword.do'/>";
        //document.loginForm.j_username.value = document.loginForm.userSe.value + document.loginForm.username.value;
        //document.loginForm.action="<c:url value='/j_spring_security_check'/>";
        document.SrchPwForm.submit();
    }
}
//-->
</script>
</head>
<body>
<div class="wrap">
        <div class="container" style="padding-bottom: 60px;">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout">
                        <div class="P_LOGIN">
                            <h1>비밀번호찾기</h1>
                            <p class="txt">입력된 메일주소로 임시비밀번호가 발급됩니다.</p>
                            <div class="loginbox">
                                <form:form id="SrchPwForm" name="SrchPwForm" method="post">
                                    <fieldset>
                                        <legend>비밀번호찾기</legend>
                                        <dl>
                                            <dt><label for="memid">이메일주소</label></dt>
                                            <dd><input type="text" title="사내 메일 주소를 입력하세요." id="id" name="id" maxlength="30"/></dd>
                                        </dl>
            
                                        <dl>
                                            <dt><label for="name">이름</label></dt>
                                            <dd>
                                            	<input type="text" maxlength="25" title="이름을 입력하세요." id="name" name="name"/>
                                            </dd>
                                        </dl>

                                        <a href="#LINK" class="btn_login" onclick="javascript:actionSearchPassword()">발송</a>
										<div class="bot">
                                        	<a href="/ebt_webapp/uat/uia/egovLoginUsr.do" style="color:#aaa; cursor:pointer">이전페이지</a>
                                        </div>
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

        <!-- Footer -->
        <c:import url="/sym/mms/EgovFooter.do" />
        <!--// Footer -->
    </div>
</body>
</html>