<%--
  Class Name : AssetInsert.jsp
  Description : 자산등록 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.13   주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.04.13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js'/>" ></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="board" staticJavascript="false" xhtml="true" cdata="false"/>
<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript">
    function fn_egov_validateForm(obj) {
        return true;
    }
    
    function fn_egov_regist_notice() {
        //document.board.onsubmit();
        
        if (!validateBoard(document.board)){
            return;
        }
        <c:if test="${bdMstr.bbsAttrbCode == 'BBSA02'}">
        if(document.getElementById("egovComFileUploader").value==""){
            alert("갤러리 게시판의 경우 이미지 파일 첨부가 필수사항입니다.");
            return false;
        }
        </c:if>
        if (confirm('<spring:message code="common.regist.msg" />')) {
            //document.board.onsubmit();
            document.board.action = "<c:url value='/cop/bbs${prefix}/insertBoardArticle.do'/>";
            document.board.submit();
        }
    }
    
    function fn_egov_select_noticeList() {
        document.board.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
        document.board.submit();
    }
    
    /* ********************************************************
     * 달력
     ******************************************************** */
    function fn_egov_init_date(){
    	
    	$("#searchBgnDe").datepicker(
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

    	$("#searchEndDe").datepicker( 
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
    
</script>

<title>자산관리 > 자산등록</title>

</head>

<style type="text/css">
.ui-datepicker-trigger {
	margin-left: 10px;
	vertical-align: middle;
}
</style>

<body onload="fn_egov_init_date();">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

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
                                        <li><a href="">자산관리</a></li>
                                        <li>자산등록</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="board" name="board" method="post" enctype="multipart/form-data" >
                				
				                <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
				                <input type="hidden" name="bbsId" value="<c:out value='${bdMstr.bbsId}'/>" />
				                <input type="hidden" name="bbsAttrbCode" value="<c:out value='${bdMstr.bbsAttrbCode}'/>" />
				                <input type="hidden" name="bbsTyCode" value="<c:out value='${bdMstr.bbsTyCode}'/>" />
				                <input type="hidden" name="replyPosblAt" value="<c:out value='${bdMstr.replyPosblAt}'/>" />
				                <input type="hidden" name="fileAtchPosblAt" value="<c:out value='${bdMstr.fileAtchPosblAt}'/>" />
				                <input type="hidden" name="posblAtchFileNumber" value="<c:out value='${bdMstr.posblAtchFileNumber}'/>" />
				                <input type="hidden" name="posblAtchFileSize" value="<c:out value='${bdMstr.posblAtchFileSize}'/>" />
				                <input type="hidden" name="tmplatId" value="<c:out value='${bdMstr.tmplatId}'/>" />
				                
				                <input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
				                <input type="hidden" name="authFlag" value="<c:out value='${bdMstr.authFlag}'/>" />
				                
				                <c:if test="${anonymous != 'true'}">
				                    <input type="hidden" name="ntcrNm" value="dummy">   <!-- validator 처리를 위해 지정 -->
				                    <input type="hidden" name="password" value="dummy"> <!-- validator 처리를 위해 지정 -->
				                </c:if>
				                
				                <c:if test="${bdMstr.bbsAttrbCode != 'BBSA01'}">
				                   <input name="ntceBgnde" type="hidden" value="10000101">
				                   <input name="ntceEndde" type="hidden" value="99991231">
				                </c:if>

                                <h1 class="tit_1">자산관리</h1>

                                <h2 class="tit_2"><c:out value='${bdMstr.bbsNm}'/>자산등록</h2>
                                
                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                            <!-- 대분류 -->
                                                <label for="">대분류</label>
                                                <span class="req">필수</span>
                                            </td>
                                             <td>
                                                <label class="f_select" for="largeCategory">
                                                <select name="">
                                                <option>선택하세요</option>
                                                </select>
                                                    <%-- <form:select path="largeCategory" id="largeCategory" name="largeCategory" title="대분류">
                                                        <form:option value='' label="선택하세요" selected="selected" />
                                                        <form:options items="${typeList}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select> --%>
                                                </label>
                                                <br/><form:errors path="largeCategory" />
                                            </td>
                                        </tr>
                                         <tr>
                                            <td class="lb">
                                            <!-- 중분류 -->
                                                <label for="">중분류</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="middleCategory">
                                                <select name="">
                                                <option>선택하세요</option>
                                                </select>
                                                    <%-- <form:select path="middleCategory" id="middleCategory" name="middleCategory" title="중분류">
                                                        <form:option value='' label="선택하세요" selected="selected" />
                                                        <form:options items="${typeList}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select> --%>
                                                </label>
                                                <br/><form:errors path="middleCategory" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            <!-- 품명 -->
                                                <label for="">품명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="assetName" class="f_txt w_full" name="assetName" type="text" value="" maxlength="60" >
                                                <br/><form:errors path="assetName" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            <!-- 수량 -->
                                                <label for="">수량</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="assetQty" class="f_txt w_full" name="assetQty" type="number" value="" maxlength="60" >
                                                <br/><form:errors path="assetQty" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            <!-- 취득일자 -->
                                                <label for="">취득일자</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="acquiredDate" class="f_txt w_full" name="acquiredDate" type="date" value="" maxlength="60" >
                                                <br/><form:errors path="acquiredDate" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            <!-- 취득가액 -->
                                                <label for="">취득가액</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="acquiredPrice" class="f_txt w_full" name="acquiredPrice" type="text" value="" maxlength="60" >
                                                <br/><form:errors path="acquiredPrice" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            <!-- 제조사 -->
                                                <label for="">제조사</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="maker" class="f_txt w_full" name="maker" type="number" value="" maxlength="60" >
                                                <br/><form:errors path="maker" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            <!-- 비고 -->
                                                <label for="note">비고</label>
                                            </td>
                                            <td>
                                                <textarea id="note" name="note" class="f_txtar w_full h_200" cols="30" rows="10"></textarea>
                                                <form:errors path="note" />
                                            </td>
                                        </tr>
                                        <!-- 파일첨부 시작 -->
	                                        <tr>
	                                            <td class="lb">
	                                            	<label for="egovComFileUploader" >사진첨부</label>
	                                            	<span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <div class="board_attach2" id="file_upload_posbl">
	                                                    <input name="file_1" id="egovComFileUploader" type="file" />
	                                                    <div id="egovComFileList"></div>
	                                                </div>
	                                                <div class="board_attach2" id="file_upload_imposbl">
	                                                </div>
	                                                <c:if test="${empty result.atchFileId}">
											            <input type="hidden" id="fileListCnt" name="fileListCnt" value="0" />
											        </c:if>
	                                            </td>
	                                        </tr>
                                        <!-- /파일첨부 끝 -->
                                        <tr>
                                            <td class="lb">
                                            <!-- 부서 -->
                                                <label for="">부서</label>
                                            </td>
                                            <td>
                                                <label class="f_select" for="deptId">
                                                <select name="">
                                                <option>선택하세요</option>
                                                </select>
                                                    <%-- <form:select path="deptId" id="deptId" name="deptId" title="부서">
                                                        <form:option value='' label="선택하세요" selected="selected" />
                                                        <form:options items="${typeList}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select> --%>
                                                </label>
                                                <br/><form:errors path="deptId" />
                                            </td>
                                        </tr>
                                         <tr>
                                            <td class="lb">
                                            <!-- 프로젝트 -->
                                                <label for="">프로젝트</label>
                                            </td>
                                             <td>
                                                <span class="f_search2 w_150">
                                                    <input id="prjId" title="주소" maxlength="100" readonly="false" />
                                                    <form:errors path="prjId" />
                                                    <button type="button" class="btn" onclick="">조회</button>
                                                </span>
                                                <span class="f_txt_inner ml15">(프로젝트 검색)</span>
                                                <form:errors path="prjId" />
                                                <input name="prjId" id="prjId" type="hidden" title="프로젝트" value="" maxlength="8" readonly="readonly" />
                                            </td>
                                        </tr>
                                    </table>
                                    
                                    
                                    <c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">
			                        <script type="text/javascript">
			                            var maxFileNum = document.board.posblAtchFileNumber.value;
			                            if(maxFileNum==null || maxFileNum==""){
			                                maxFileNum = 3;
			                            } 
			                            var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
			                            multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
			                        </script>
                        			</c:if>
                                    
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    </div>

                                    <div class="right_col btn1">
                                    	<c:if test="${bdMstr.authFlag == 'Y'}">
                                        	<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_regist_notice(); return fasle;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        </c:if>
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fn_egov_select_noticeList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
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
        <c:import url="/sym/mms/EgovFooter.do" />
        <!--// Footer -->
    </div>
    
</body>
</html>