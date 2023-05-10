<%--
  Class Name : EgovMainView.jsp 
  Description : 메인화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	
<title>표준프레임워크 경량환경 내부업무템플릿</title>
</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	
<!-- 전체 레이어 시작 -->

<body>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- Header -->
        <c:import url="/sym/mms/EgovHeader.do" />
        <!--// Header -->

        <div class="container main">
            <div class="P_MAIN">

                <div class="bot">
                    <div class="col">
                        <div class="left_col">
                            <div class="box">
                            	
                            	<div class="pty_icon_box">
	                                <a href="<c:url value='/ass/AssetRegist.do'/>" style="width:100%; height:100%">
	                                	<img src="<c:url value='/'/>images/pty_icon_01.png">
	                                	<h2>자산등록</h2>
	                                	<p>바로가기 →</p>
	                                </a>
	                            </div>    
                            </div>
                            <div class="box">
                            
                            	<div class="pty_icon_box">
	                            	<a href="<c:url value='/req/CarryRegist.do'/>">
	                            		<img src="<c:url value='/'/>images/pty_icon_02.png">
	                            		<h2>반출신청</h2>
	                                	<p>바로가기 →</p>
	                            	</a>
	                            </div>	
                            	
                            </div>
                        </div>
                        <div class="right_col">
                            <div class="box pty_colbox">
                                <div class="head">
                                    <h2>최신 <span>공지사항</span></h2>
                                    <a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA'/>" class="more">더보기</a>
                                </div>
                                <div class="list">
                                    <table>
                                        <colgroup>
                                            <col style="width: auto;">
                                            <col style="width: 80px">
                                            <col style="width: 110px">
                                        </colgroup>
                                        <c:forEach var="result" items="${notiList}" varStatus="status">
                                        <c:if test="${!(result.isExpired=='Y' || result.useAt == 'N')}">
                                        <tr>
                                            <td>
                                            	<c:if test="${result.replyLc!=0}">
                                        			<c:forEach begin="0" end="${result.replyLc}" step="1">
                                        				&nbsp;
                                        			</c:forEach>
                                        			<img src="<c:url value='/'/>images/ico_reply.png" alt="reply arrow">
                                        		</c:if>
                                            	<a href="<c:url value='/cop/bbs/selectBoardList.do?bbsId=BBSMSTR_AAAAAAAAAAAA'/>">
                                            		<c:out value="${result.nttSj}" />
                                            	</a>
                                            	<span>NEW</span>
                                            </td>
                                            <td class="al_c"><c:out value="${result.frstRegisterNm}" /></td>
                                            <td class="al_r date"><c:out value="${result.frstRegisterPnttm}" /></td>
                                        </tr>
                                        </c:if>
                                        </c:forEach>
                                    </table>
                                </div>
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