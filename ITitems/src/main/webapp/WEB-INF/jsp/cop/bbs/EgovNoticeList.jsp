<%--
  Class Name : EgovNoticeList.jsp
  Description : 게시물 목록화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.19   이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이삼섭
    since    : 2009.03.19
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="egovframework.com.cmm.service.EgovProperties" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="ImgUrl" value="/images_old/egovframework/cop/bbs/"/>
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
	<link rel="stylesheet" href="<c:url value='/'/>css/jsh.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />" ></script>
<c:choose>
<c:when test="${preview == 'true'}">
<script type="text/javascript">
<!--
    function press(event) {
    }

    function fn_egov_addNotice() {
    }
    
    function fn_egov_select_noticeList(pageNo) {
    }
    
    function fn_egov_inqire_notice(nttId, bbsId) {      
    }
//-->
</script>
</c:when>
<c:otherwise>
<script type="text/javascript">
<!--
    function press(event) {
        if (event.keyCode==13) {
            fn_egov_select_noticeList('1');
        }
    }

    function fn_egov_addNotice() {
        document.frm.action = "<c:url value='/cop/bbs${prefix}/addBoardArticle.do'/>";
        document.frm.submit();
    }
    
    function fn_egov_select_noticeList(pageNo) {
        document.frm.pageIndex.value = pageNo;
        document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
        document.frm.submit();  
    }
    
    function setPageUnit(obj) {
    	console.log("확인");
    	document.frm.pageIndex.value = '1';
    	document.frm.pageUnit.value = obj.value;
        document.frm.action = "<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>";
        document.frm.submit();
    }
    
    function fn_egov_inqire_notice(nttId, bbsId) {
        document.subForm.nttId.value = nttId;
        document.subForm.bbsId.value = bbsId;
        document.subForm.action = "<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>";
        document.subForm.submit();          
    }
//-->
</script>
</c:otherwise>
</c:choose>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- Header -->
        <c:import url="/sym/mms/EgovHeader.do" />
        <!--// Header -->
		<%
			LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
		%>
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
                                        <li><c:out value="${brdMstrVO.bbsNm}"/></li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">알림정보</h1>


                                <h2 class="tit_2"><c:out value="${brdMstrVO.bbsNm}"/></h2>    

                                <!-- 검색조건 -->
								<div class="condition">
									<form name="frm"
										action="<c:url value='/cop/bbs${prefix}/selectBoardList.do'/>"
										method="post">

										<input type="hidden" name="bbsId"
											value="<c:out value='${boardVO.bbsId}'/>" /> <input
											type="hidden" name="nttId" value="0" /> <input type="hidden"
											name="bbsTyCode"
											value="<c:out value='${brdMstrVO.bbsTyCode}'/>" /> <input
											type="hidden" name="bbsAttrbCode"
											value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" /> <input
											type="hidden" name="authFlag"
											value="<c:out value='${brdMstrVO.authFlag}'/>" /> <input
											name="pageIndex" type="hidden"
											value="<c:out value='${searchVO.pageIndex}'/>" />


										<div class="j_condition">
											<label class="item f_select" for="sel1">
												<select name="searchCnd" id="searchCnd" title="검색조건 선택">
													<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>제목</option>
													<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>내용</option>
												</select>
											</label> 
											<span class="item f_search"> 
												<input class="f_input w_250" name="searchWrd" type="text" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색어 입력">
												<%-- <button class="btn" type="submit" onclick="fn_egov_select_noticeList('1'); return false;"><spring:message code='button.inquire' /></button><!-- 조회 --> --%>
											</span>
											<button class="btn pty_btn search_btn" type="submit" onclick="fn_egov_select_noticeList('1'); return false;">검색</button>
											<!-- 조회 -->
										</div>
									</form>
								<!--// 검색조건 -->
								</div>		
                                <!-- 게시판 -->
                                
                              
                              <div class="board_list_top">
										<div class="left_col">
	                                		<div class="list_count">
													<div style="display: flex; justify-content: space-between; align-items: center;" class="pty_margin-bottom_8">
														
														<div>
															<span style="margin:0;">Total : </span> 
															<strong><c:out value="${paginationInfo.totalRecordCount}" /></strong> 
																	
														</div>
															
														<%--  <div style="display: flex; align-items: center;">
															<span style="margin-right: 16px;">페이지당 항목 수</span> 
															<label class="item f_select" for="pageUnit"> 
																	
																<select name="pageUnit" id="pageUnit" title="페이지당 항목 수" onchange="setPageUnit(this); return false;">										
																		<option value="10" <c:if test="${empty userSearchVO.pageUnit || userSearchVO.pageUnit == '10'}">selected="selected"</c:if>>10</option>
																		<option value="2" <c:if test="${userSearchVO.pageUnit == '2'}">selected="selected"</c:if>>2</option>
																		<option value="20" <c:if test="${userSearchVO.pageUnit == '20'}">selected="selected"</c:if>>20</option>
																		<option value="50" <c:if test="${userSearchVO.pageUnit == '50'}">selected="selected"</c:if>>50</option>
																		<option value="100" <c:if test="${userSearchVO.pageUnit == '100'}">selected="selected"</c:if>>100</option>
																		<option value="300" <c:if test="${userSearchVO.pageUnit == '300'}">selected="selected"</c:if>>300</option>
																		<option value="500" <c:if test="${userSearchVO.pageUnit == '500'}">selected="selected"</c:if>>500</option>
																</select>
															</label>
														</div>  --%>
														
													</div>
													
													
												</div>
                              			</div>
	                                </div> 
	                                
	                                
                                <div class="board_list pty_board_list selete_table">
                                    <table summary="번호, 제목, 게시시작일, 게시종료일, 작성자, 작성일, 조회수  입니다">
                                    	<caption>게시물 목록</caption>
                                        <colgroup>
                                            <col style="width: 8%;">
                                            <col style="width: 57%;">
                                            <col style="width: 10%;">
                                            <col style="width: 15%;">
                                            <col style="width: 10%;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">번호</th>
                                                <th scope="col">제목</th>
                                                <c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
                                                	<th scope="col">게시시작일</th>
                                                	<th scope="col">게시종료일</th>
                                                </c:if>
                                                <c:if test="${anonymous != 'true'}">
                                                	<th scope="col">작성자</th>
                                                </c:if>
                                                <th scope="col">작성일</th>
                                                <th scope="col">조회수</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        
                                        	<c:if test="${fn:length(resultList) == 0}">
                                        		<tr>
                                        			<c:choose>
                                        				<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
                                        					<td colspan="7"><spring:message code="common.nodata.msg" /></td>
                                        				</c:when>
	                                        			<c:otherwise>
	                                        				<c:choose>
	                                        					<c:when test="${anonymous == 'true'}">
	                                        						<td colspan="4" ><spring:message code="common.nodata.msg" /></td>
	                                        					</c:when>
	                                        					<c:otherwise>
	                                        						<td colspan="5" ><spring:message code="common.nodata.msg" /></td>
	                                        					</c:otherwise>
	                                        				</c:choose>
	                                        			</c:otherwise>
                                        			</c:choose>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="result" items="${resultList}" varStatus="status">
                                        	<c:if test="${result.useAt != 'N'}">
                                            <tr onclick="childNodes[3].childNodes[1].submit();">
                                                <td><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td>
                                                <td class="al">
                                                	<form name="subForm" method="post" action="<c:url value='/cop/bbs${prefix}/selectBoardArticle.do'/>">
                                               		<c:if test="${result.replyLc!=0}">
                                               			<c:forEach begin="0" end="${result.replyLc}" step="1">
                                               				&nbsp;
                                               			</c:forEach>
                                               			<img src="<c:url value='/'/>images/ico_reply.png" alt="reply arrow">
                                               		</c:if>
                                               		<c:choose>
										                <c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
										                    <c:out value="${result.nttSj}" />
										                </c:when>
										                <c:otherwise>
		                                                	<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
									                        <input type="hidden" name="nttId"  value="<c:out value="${result.nttId}"/>" />
									                        <input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
									                        <input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
									                        <input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
									                        <input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
									                        <input type="hidden" name="pageUnit" value="<c:out value='${searchVO.pageUnit}'/>"/>
									                        <input type="hidden" name="searchCnd" value="<c:out value='${searchVO.searchCnd}'/>">
			                    							<input type="hidden" name="searchWrd" value="<c:out value='${searchVO.searchWrd}'/>">
									                        <c:out value="${result.nttSj}"/>
                                                		</c:otherwise>
			            							</c:choose>
                                                	</form>
                                                </td>
                                                <c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA01'}">
                                                	<td><c:out value="${result.ntceBgnde}"/></td>
                                                	<td><c:out value="${result.ntceEndde}"/></td>
                                                </c:if>
                                                <c:if test="${anonymous != 'true'}">
                                                	<td><c:out value="${result.frstRegisterNm}"/></td>
                                                </c:if>
                                                <td><c:out value="${result.frstRegisterPnttm}"/></td>
                                                <td><c:out value="${result.inqireCo}"/></td>
                                            </tr>
                                            </c:if>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>
								<!--  문의사항과 공지사항 등록버튼 권한 구분 -->
                                 <c:choose> 
									<c:when test="${brdMstrVO.bbsId == 'BBSMSTR_AAAAAAAAAAAA'}"> <!-- 공지사항일때 등록버튼 여부 -->
	                                 <c:if test="<%= loginVO.getAuthorCode().equals(\"ROLE_ADMIN\") || loginVO.getAuthorCode().equals(\"ROLE_HIGH_ADMIN\")%>">
	                                   <div class="board_view_bot">
											<div class="right_btn btn1">
	                                    		<a href="<c:url value='/cop/bbs${prefix}/addBoardArticle.do'/>?bbsId=<c:out value="${boardVO.bbsId}"/>" class="item btn btn_blue_46 pty_margin-top_8"><spring:message code="button.create" /></a><!-- 등록 -->
											</div>
										</div>
	                                 </c:if>
									</c:when> 
									<c:when test="${brdMstrVO.bbsId == 'BBSMSTR_CCCCCCCCCCCC'}"> <!-- 문의게시판일떄 등록버튼 여부 -->
           	                         <div class="board_view_bot">
										<div class="right_btn btn1">
                                    		<a href="<c:url value='/cop/bbs${prefix}/addBoardArticle.do'/>?bbsId=<c:out value="${boardVO.bbsId}"/>" class="item btn btn_blue_46 pty_margin-top_8"><spring:message code="button.create" /></a><!-- 등록 -->
										</div>
									 </div>
									</c:when> 
								</c:choose> 
								
								
								<!-- 페이지 네비게이션 시작 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />
                                        </ul>
                                    </div>
                                </div>
                                <!-- //페이지 네비게이션 끝 -->
                                <!--// 게시판 -->
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