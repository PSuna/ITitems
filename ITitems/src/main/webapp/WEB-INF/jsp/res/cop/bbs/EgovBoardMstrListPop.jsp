<%--
  Class Name : EgovBoardMstrListPop.jsp
  Description : 게시판 속성 조회 팝업
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.12   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.12
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
	<link rel="stylesheet" href="<c:url value='/'/>css/res/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/res/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/res/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/res/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript">
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_brdMstr('1');
        }
    }
    function fn_egov_select_brdMstr(pageNo){
        document.frm.pageIndex.value = pageNo; 
        document.frm.action = "<c:url value='/res/cop/bbs/SelectBBSMasterInfsPop.do'/>";
        document.frm.submit();                  
    }
    
    function fn_egov_select_brdMstrInfo(bbsId, bbsNm){
        var retVal = bbsId +"|"+bbsNm;
        parent.fn_egov_returnValue(retVal);
    }
    
    /* ********************************************************
     * 취소처리
     ******************************************************** */
    function fn_egov_cancel_popup() {
    	parent.fn_egov_modal_remove();
    }
</script>


</head>
<body>

	<form name="frm" method="post" action="<c:url value='/res/cop/bbs/SelectBBSMasterInfsPop.do'/>">
	
    <input type="hidden" name="bbsId" value="">

	<!-- 게시판정보 팝업 -->
    <!-- default : display: none 상태 -->
    <div class="popup POP_BOARD_INFO" style="display: block;">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>게시판 정보</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <!-- 검색조건 -->
                <div class="condition">
                    <label class="item f_select" for="sel1">
                        <select name="searchCnd" class="select" title="검색유형선력">
                            <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
                            <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >게시판유형</option>
                        </select>
                    </label>

                    <span class="item f_search">
                        <input id="searchWrd" class="f_input w_500" name="searchWrd" type="text" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);">
                        <button class="btn" type="submit" onclick="javascript:fn_egov_select_brdMstr('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                    </span>
                </div>
                <!--// 검색조건 -->

                <!-- 게시판 -->
                <div class="board_list">
                    <table summary="">
                    	<caption>게시판정보</caption>
                        <colgroup>
                            <col style="width: 80px;">
                            <col style="width: 150px;">
                            <col style="width: 130px;">
                            <col style="width: auto;">
                            <col style="width: 150px;">
                            <col style="width: 150px;">
                            <col style="width: 100px;">
                        </colgroup>
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">게시판명</th>
                                <th scope="col">게시판유형</th>
                                <th scope="col">게시판속성</th>
                                <th scope="col">생성일</th>
                                <th scope="col">사용여부</th>
                                <th scope="col">선택</th>
                            </tr>
                        </thead>
                        <tbody>
                        	
                        	<c:if test="${fn:length(resultList) == 0}">
                        		<tr>
                        			<td nowrap colspan="7" ><spring:message code="common.nodata.msg" /></td>
                        		</tr>
                        	</c:if>
                        	
                        	<c:forEach var="result" items="${resultList}" varStatus="status">
                            <tr>
                                <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
                                <td><c:out value="${result.bbsNm}"/></td>
                                <td><c:out value="${result.bbsTyCodeNm}"/></td>
                                <td><c:out value="${result.bbsAttrbCodeNm}"/></td>
                                <td><c:out value="${result.frstRegisterPnttm}"/></td>
                                <td>
                                	<c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
                                	<c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
                                </td>
                                <td>
                                	<a href="#LINK" class="btn btn_blue_30 w_80" onClick="javascript:fn_egov_select_brdMstrInfo('<c:out value="${result.bbsId}"/>','<c:out value="${result.bbsNm}"/>');">
                                		선택
                                	</a>
                                </td>
                            </tr>
                            </c:forEach>
                            
                        </tbody>
                    </table>
                </div>

				<!-- 페이지 네비게이션 시작 -->
                <div class="board_list_bot">
                    <div class="paging" id="paging_div">
                        <ul>
                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_brdMstr" />
                        </ul>
                    </div>
                </div>
                <!-- // 페이지 네비게이션 끝 -->
                <!--// 게시판 -->
            </div>
        </div>
    </div>
    <!--// 게시판정보 팝업 -->
    
    <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
    
    </form>
    
</body>
</html>