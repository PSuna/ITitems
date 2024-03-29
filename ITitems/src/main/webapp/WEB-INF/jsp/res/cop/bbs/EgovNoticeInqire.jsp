<%--
  Class Name : EgovNoticeInqire.jsp
  Description : 게시물 조회 화면
  Modification Information
 
      수정일      수정자              수정내용
     ----------  --------    ---------------------------
     2009.03.23   이삼섭        최초 생성
     2009.06.26   한성곤        2단계 기능 추가 (댓글관리, 만족도조사)
     2011.08.31   JJY       	경량환경 버전 생성
     2013.05.23   이기하       	상세보기 오류수정
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.23
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
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
	<link rel="stylesheet" href="<c:url value='/'/>css/res/pty_m2.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/pty.css">
<link rel="stylesheet" href="<c:url value='/'/>css/res/jsh.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
    function onloading() {
        if ("<c:out value='${msg}'/>" != "") {
            alert("<c:out value='${msg}'/>");
        }
    }
    
    function fn_egov_select_noticeList() {
        document.frm.action = "<c:url value='/res/cop/bbs${prefix}/selectBoardList.do'/>";
        document.frm.submit();  
    }
    

    /* ********************************************************
     * 삭제확인 팝업창
     ******************************************************** */
     function DelConfirm(){
    	 var $dialog = $('<div id="modalPan"></div>')
    		.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/DelConfirm.do'/>" +'" width="100%" height="100%"></iframe>')
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
     * 삭제확인 결과 처리
     ******************************************************** */
     function returnDelConfirm(val){
    	fn_egov_modal_remove();
    	 if(val){
    		 DelIng();
    		 fn_egov_delete_notice(); 
    	 }	  
    }

    /* ********************************************************
    * 삭제진행 팝업창
    ******************************************************** */
    function DelIng(){

     var $dialog = $('<div id="modalPan"></div>')
    	.html('<iframe style="border: 0px; " src="' + "<c:url value='/res/com/DelIng.do'/>" +'" width="100%" height="100%"></iframe>')
    	.dialog({
        	autoOpen: false,
            modal: true,
            width: 400,
            height: 300
    	});
        $(".ui-dialog-titlebar").hide();
    	$dialog.dialog('open');
    }
    
    function fn_egov_delete_notice() {
            document.frm.action = "<c:url value='/res/cop/bbs${prefix}/deleteBoardArticle.do'/>";
            document.frm.submit();  
    }
    
    function fn_egov_moveUpdt_notice() {
        if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
            alert('등록시 사용한 패스워드를 입력해 주세요.');
            document.frm.password.focus();
            return;
        }

        document.frm.action = "<c:url value='/res/cop/bbs${prefix}/forUpdateBoardArticle.do'/>";
        document.frm.submit();
    }
    
    function fn_egov_addReply() {
        document.frm.action = "<c:url value='/res/cop/bbs${prefix}/addReplyBoardArticle.do'/>";
        document.frm.submit();
    }
</script>
<!-- 2009.06.29 : 2단계 기능 추가  -->
<c:if test="${useComment == 'true'}">
<c:import url="/res/cop/bbs/selectCommentList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useSatisfaction == 'true'}">
<c:import url="/res/cop/bbs/selectSatisfactionList.do" charEncoding="utf-8">
    <c:param name="type" value="head" />
</c:import>
</c:if>
<c:if test="${useScrap == 'true'}">
<script type="text/javascript">
    function fn_egov_addScrap() {
        document.frm.action = "<c:url value='/res/cop/bbs/addScrap.do'/>";
        document.frm.submit();          
    }
</script>
</c:if>
<!-- 2009.06.29 : 2단계 기능 추가  -->
<link rel="icon" type="image/png" href="<c:url value="/" />images/res/pty_tap_icon.png"/>

<title>내부업무 사이트 > 알림정보 > <c:out value='${result.bbsNm}'/></title>


</head>
<body onload="onloading();">
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
                        <div class="content_wrap notice_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="/uat/uia/web/actionMain.do">Home</a></li>
                                        <li><a href="">알림정보</a></li>
                                        <li><c:out value='${result.bbsNm}'/></li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="frm" method="post" action="<c:url value='/res/cop/bbs${prefix}/selectBoardList.do'/>">
								<%
									LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
								%>
			                    <input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>">
			                    <input type="hidden" name="pageUnit" value="<c:out value='${searchVO.pageUnit}'/>"/>
			                    <input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>">
			                    <input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>">
			                    <input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" >
			                    <input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" >
			                    <input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" >
			                    <input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" >
			                    <input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" >
			                    <input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" >

                                <h1 class="tit_1">알림정보</h1>

                                <h2 class="tit_2"><c:out value='${result.bbsNm}'/></h2>

                                <!-- 게시판 상세보기 -->
                                <div class="board_view">
                                    <div class="board_view_top">
                                        <div class="tit"><c:out value="${result.nttSj}" /></div>
                                        <div class="info">
                                            <dl>
                                                <dt>작성자</dt>
                                                <dd>
                                                	<c:choose>
                                                		<c:when test="${anonymous == 'true'}">
                                                			******
                                                		</c:when>
                                                		<c:when test="${result.ntcrNm == ''}">
                                                			<c:out value="${result.frstRegisterNm}" />
                                                		</c:when>
                                                		<c:otherwise>
                                                			<c:out value="${result.ntcrNm}" />
                                                		</c:otherwise>
                                                	</c:choose>
                                                </dd>
                                            </dl>
                                            <dl>
                                                <dt>작성일</dt>
                                                <dd><c:out value="${result.frstRegisterPnttm}" /></dd>
                                            </dl>
                                            <dl>
                                                <dt>조회수</dt>
                                                <dd><c:out value="${result.inqireCo}" /></dd>
                                            </dl>
                                        </div>
                                    </div>

                                    <div class="board_article">
										<textarea id="nttCn" name="nttCn" class="textarea" cols="30" rows="10" readonly="readonly" title="글내용"><c:out value="${result.nttCn}" escapeXml="false" /></textarea>
                                    </div>

									<c:if test="${not empty result.atchFileId}">
										<c:if test="${result.bbsAttrbCode == 'BBSA02'}">
		                                    <div class="board_attach">
		                                        <dl>
		                                            <dt>첨부이미지</dt>
		                                            <dd>
		                                                <c:import url="/cmm/fms/selectImageFileInfs.do" charEncoding="utf-8">
		                                                	<c:param name="atchFileId" value="${result.atchFileId}" />
		                                                </c:import>
		                                            </dd>
		                                        </dl>
		                                    </div>
		                                </c:if>
		                                <div class="board_attach">
	                                        <dl>
	                                            <dt>첨부파일</dt>
	                                            <dd>
	                                                <c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				                                        <c:param name="param_atchFileId" value="${result.atchFileId}" />
				                                    </c:import>
	                                            </dd>
	                                        </dl>
	                                    </div>
	                                </c:if>
	                                
                                    <c:if test="${anonymous == 'true'}">
                                    	<div class="board_attach">
	                                    	<dl>
                                                <dt><label for="password"><spring:message code="cop.password" /></label></dt>
                                                <dd><input name="password" title="암호" type="password" size="20" value="" maxlength="20" ></dd>
                                            </dl>
                                           </div>
                                    </c:if>

									<!-- 목록/저장버튼  -->
                                    <div class="board_view_bot btn_bot">
                                        <div class="right_btn btn3">
                                        	<c:if test="${result.frstRegisterId == sessionUniqId}"> 
	                                            <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fn_egov_moveUpdt_notice(); return false;">수정</a><!-- 수정 -->
	                                            <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="DelConfirm(); return false;">삭제</a><!-- 삭제 -->
                                            </c:if>
                                           <%-- <c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_ADMIN\") || loginVO.getAuthorCode().equals(\"ROLE_HIGH_ADMIN\")%>">
	                                            <c:if test="${result.replyPosblAt == 'Y' && result.bbsId == 'BBSMSTR_CCCCCCCCCCCC'}">  

	                                            	<a href="#LINK" class="btn btn_skyblue_h46 w_120" onclick="javascript:fn_egov_addReply(); return false;">답글작성</a><!-- 답글작성 -->
	                                            </c:if>
                                            </c:if>  --%>
                                            <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_select_noticeList(); return false;">목록</a><!-- 목록 -->
                                        </div>
                                    </div>
                                    <!-- // 목록/저장버튼 끝  -->
                                </div>
                                
                                </form>
                                
                                <!-- 게시판 상세보기 -->
                              
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