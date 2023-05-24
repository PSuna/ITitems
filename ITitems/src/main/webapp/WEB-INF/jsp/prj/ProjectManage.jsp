<%--
  Class Name : ProjectManage.jsp
  Description : 프로젝트목록관리 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.27    천세훈             최초 생성
 
    author   : 영남사업부 천세훈 선임
    since    : 2023.04.21
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<title>사이트관리 > 프로젝트관리 > 프로젝트목록관리</title>

<script language="javascript1.2" type="text/javaScript">
<!--

/* ********************************************************
 * 프로젝트검색
 ******************************************************** */
function fnSearchPrj() {
	document.listForm.pageIndex.value = 1;
   	document.listForm.submit();
}

/* ********************************************************
 * 페이지 이동
 ******************************************************** */
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/prj/ProjectManage.do'/>";
    document.listForm.submit();
}

/* ********************************************************
 * 검색 기능
 ******************************************************** */
function fnSearch(){
    document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/prj/ProjectManage.do'/>";
    document.listForm.submit();
}

/* ********************************************************
 * 프로젝트 등록화면 이동
 ******************************************************** */
function fnAddProjectView() {
    document.listForm.action = "<c:url value='/prj/ProjectInsertView.do'/>";
    document.listForm.submit();
}

/* ********************************************************
 * 페이지당 리스트 갯수 설정
 ******************************************************** */
function setPageUnit(){
	document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/prj/ProjectManage.do'/>";
    document.listForm.submit();
}

//-->
</script>
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
										<li><a href="">프로젝트관리</a></li>
										<li>프로젝트목록관리</li>
									</ul>
								</div>
								<!--// Location -->
								
								<form name="listForm" action="<c:url value='/prj/ProjectManage.do'/>" method="post">
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<h2 class="tit_2">프로젝트목록관리</h2>
								<!-- 검색조건 -->
				                <div class="condition2">
				                    <label for="" class="lb mr10">프로젝트명 : </label>
				                    <span class="item f_search">
				                        <input class="f_input" name="searchWord" value="<c:out value="${searchVO.searchWord}"/>" type="text"  maxlength="20" title="동명"/>
				                        <button class="btn" type="submit" onclick="fnSearchPrj();"><spring:message code='button.inquire' /></button><!-- 조회 -->
				                    </span>
				                    <button class="btn pty_btn search_btn" type="submit" onclick="fnSearchPrj(); return false;">검색</button>
				                </div>
				                <!--// 검색조건 -->
				                <!-- 게시판 -->
				                	<div class="board_list_top">
										<div class="left_col">
	                                 		<div style="float: right;display: flex;align-items: center;">
		                                 		<span>페이지당 항목 수</span>
		                                 		<label class="item f_select" for="pageUnit">
			                                 		<select name="pageUnit" id="pageUnit" title="페이지당 항목 수" onchange="setPageUnit(); return false;">
			                                 			<option value="10" <c:if test="${empty searchVO.pageUnit || searchVO.pageUnit == '10'}">selected="selected"</c:if>>10</option>
			                                 			<option value="20" <c:if test="${searchVO.pageUnit == '20'}">selected="selected"</c:if>>20</option>
			                                 			<option value="50" <c:if test="${searchVO.pageUnit == '50'}">selected="selected"</c:if>>50</option>
			                                 			<option value="100" <c:if test="${searchVO.pageUnit == '100'}">selected="selected"</c:if>>100</option>
			                                 			<option value="300" <c:if test="${searchVO.pageUnit == '300'}">selected="selected"</c:if>>300</option>
			                                 			<option value="500" <c:if test="${searchVO.pageUnit == '500'}">selected="selected"</c:if>>500</option>
			                                 		</select>
		                                 		</label>
                                   				<a href="<c:url value='/prj/EgovUserInsertView.do'/>" style="margin-left:4px;" class="item btn btn_blue_46 w_100" onclick="fnAddProjectView(); return false;"><spring:message code="button.create" /></a><!-- 등록 -->
	                                 		</div>
		                            	</div>
	                                </div>
				                <div class="board_list pty_board_list">
				                    <table summary="프로젝트 건색 결과를 알려주는 테이블입니다.">
				                        <colgroup>
				                            <col style="width: 5%;">
				                            <col style="width: 25%;">
				                            <col style="width: 20%;">
				                            <col style="width: 15%;">
				                            <col style="width: 12%;">
				                            <col style="width: 10%;">
				                        </colgroup>
				                        <thead>
				                            <tr>
				                                <th scope="col">번호</th>
				                                <th scope="col">프로젝트명</th>
				                                <th scope="col">기간</th>
				                                <th scope="col">PM</th>
				                                <th scope="col">고객사</th>
				                                <th scope="col">상태</th>
				                            </tr>
				                        </thead>
				                        <tbody>
				                        	<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
				                            <tr>
				                            	<td><c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageSize) - status.index}"/></td>
				                                <td>
				                                <a href="<c:url value='/prj/ProjectSelectView.do'/>?selectedId=<c:out value="${resultInfo.prjId}"/>" class="lnk">
				                                ${resultInfo.prjName}
				                                </a>
				                                </td>
				                                <td class="pty_font-size_12">${resultInfo.prjStart} ― ${resultInfo.prjEnd}</td>
				                                <td class="pty_font-size_12">${resultInfo.name} ${resultInfo.position}</td>
				                                <td>${resultInfo.client}</td>
				                                <td>${resultInfo.prjState}</td>
				                            </tr>
				                            </c:forEach>
				                        </tbody>
				                    </table>
				                </div>
				
								<!-- 페이지 네비게이션 시작 -->
								<c:if test="${!empty searchVO.pageIndex }">
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fnLinkPage" />
                                        </ul>
                                    </div>
                                </div>
                                </c:if>
                                <!-- //페이지 네비게이션 끝 -->
				                <!--// 게시판 -->
				                </form>
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
</body>
</html>