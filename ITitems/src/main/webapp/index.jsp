<%--
  Class Name : index.jsp
  Description : 최초화면으로 메인화면으로 이동한다.(system)
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.11  천세훈, 주소현       최초 생성

    author   : 영남사업부 천세훈, 주소현
    since    : 2023.04.11
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
<script type="text/javaScript">document.location.href="<c:url value='/uat/uia/egovLoginUsr.do'/>"</script>