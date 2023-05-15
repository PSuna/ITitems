<%--
  Class Name : EgovUserManage.jsp
  Description : 사용자관리(조회,삭제) JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.17   천세훈              최초 생성
 
    author   : 영남사업부 천세훈 선임
    since    : 2023.04.17
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

<title>내부업무 사이트 > 내부시스템관리 > 사용자등록관리</title>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnCheckAll() {
    var checkField = document.listForm.checkField;
    if(document.listForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
function fnDeleteUser() {
    var checkField = document.listForm.checkField;
    var id = document.listForm.checkId;
    var checkedIds = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkedIds += ((checkedCount==0? "" : ",") + id[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkedIds = id.value;
            }
        }
    }
    if(checkedIds.length > 0) {
        if(confirm("<spring:message code="common.delete.msg" />")){
            document.listForm.checkedIdForDel.value=checkedIds;
            document.listForm.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
            document.listForm.submit();
        }
    }
}
function fnSelectUser(id) {
    document.listForm.selectedId.value = id;
    array = id.split(":");
    if(array[0] == "") {
    } else {
        userTy = array[0];
        userId = array[1];    
    }
    document.listForm.selectedId.value = userId;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserSelectUpdtView.do'/>";
    document.listForm.submit();
      
}
function fnAddUserView() {
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserInsertView.do'/>";
    document.listForm.submit();
}
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnSearch(){
    document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.listForm.submit();
}
function fnViewCheck(){ 
    if(insert_msg.style.visibility == 'hidden'){
        insert_msg.style.visibility = 'visible';
    }else{
        insert_msg.style.visibility = 'hidden';
    }
}
function setPageUnit(){
	document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.listForm.submit();
}
functino trsfExcel(){
	
}
//-->
</script>
<style>
.board_list tbody tr:hover {
	background: #ccc;
	cursor: pointer;
}
</style>
</head>
<body>
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
                                        <li><a href="">사이트관리</a></li>
                                        <li><a href="">사용자관리</a></li>
                                        <li>사용자목록</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="listForm" action="<c:url value='/uss/umt/user/EgovUserManage.do'/>" method="post">
								
								<input name="selectedId" type="hidden" />
								<input name="checkedIdForDel" type="hidden" />
								<input name="pageIndex" type="hidden" value="<c:out value='${userSearchVO.pageIndex}'/>"/>

                                <h2 class="tit_2">사용자목록</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition pty_condition" style="display: flex; justify-content: center;">
                                    <label class="item f_select" for="searchOrgnzt">
                                    	<select id="searchOrgnzt" name="searchOrgnzt" title="검색조건-부서" onchange="javascript:fnSearch(); return false;">
	                                        <option value="" label="부서"/>
	                                        <c:forEach var="orgnztId" items="${orgnztId_result}">
	                                        	<option value="<c:out value="${orgnztId.code}"/>"<c:if test="${userSearchVO.searchOrgnzt == orgnztId.code}">selected="selected"</c:if>>${orgnztId.codeNm}</option>
	                                        </c:forEach>
                                    	</select>
                                    </label>
                                    
                                    <label class="item f_select" for="searchGrade">
                                    	<select id="searchGrade" name="searchGrade" title="검색조건-직급" onchange="javascript:fnSearch(); return false;">
	                                        <option value="" label="직급"/>
	                                        <c:forEach var="grade" items="${grd_result}">
	                                        	<option value="<c:out value="${grade.code}"/>" <c:if test="${userSearchVO.searchGrade == grade.code}">selected="selected"</c:if>>${grade.codeNm}</option>
	                                        </c:forEach>
                                    	</select>
                                    </label>
                                    
                                    <label class="item f_select" for="searchCondition">
                                        <select name="searchCondition" id="searchCondition" title="검색조건-검색어구분">
                                            <option value="0" <c:if test="${userSearchVO.searchCondition == '0'}">selected="selected"</c:if> >사용자ID</option>
                                            <option value="1" <c:if test="${empty userSearchVO.searchCondition || userSearchVO.searchCondition == '1'}">selected="selected"</c:if> >사용자명</option>
                                        </select>
                                    </label> 
									<div class="pty_search" style="margin-left:10px;">
										<span class="item f_search">
											<input class="f_input w_250 pty_f_input" type="text" name="searchKeyword" placeholder="검색어를 입력해주세요" title="검색어" value="<c:out value="${userSearchVO.searchKeyword}"/>">
										</span>
										<button class="btn pty_btn" onclick="javascript:fnSearch(); return false;">검색</button>
									</div>
                                </div>
                                <!--// 검색조건 -->
								
								<div class="board_list_top">
									<div class="left_col">
	                                	<div class="list_count">
			                                 	<span>사용자수</span>
			                                 	<strong><c:out value="${paginationInfo.totalRecordCount}"/></strong>
		                                 		<div style="float: right;display: flex;align-items: center;">
			                                 		<span>페이지당 항목 수</span>
			                                 		<label class="item f_select" for="pageUnit">
				                                 		<select name="pageUnit" id="pageUnit" title="페이지당 항목 수" onchange="setPageUnit(); return false;">
				                                 			<option value="10" <c:if test="${empty userSearchVO.pageUnit || userSearchVO.pageUnit == '10'}">selected="selected"</c:if>>10</option>
				                                 			<option value="20" <c:if test="${userSearchVO.pageUnit == '20'}">selected="selected"</c:if>>20</option>
				                                 			<option value="50" <c:if test="${userSearchVO.pageUnit == '50'}">selected="selected"</c:if>>50</option>
				                                 			<option value="100" <c:if test="${userSearchVO.pageUnit == '100'}">selected="selected"</c:if>>100</option>
				                                 			<option value="300" <c:if test="${userSearchVO.pageUnit == '300'}">selected="selected"</c:if>>300</option>
				                                 			<option value="500" <c:if test="${userSearchVO.pageUnit == '500'}">selected="selected"</c:if>>500</option>
				                                 		</select>
			                                 		</label>
			                                 		<a href="#LINK" style="margin-left:4px;" class="item btn btn_blue_46 w_100" onclick="javascript:fnDeleteUser(); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    				<a href="<c:url value='/uss/umt/user/EgovUserInsertView.do'/>" style="margin-left:4px;" class="item btn btn_blue_46 w_100" onclick="fnAddUserView(); return false;"><spring:message code="button.create" /></a><!-- 등록 -->
		                                 		</div>
	                                 	</div>
	                            	</div>
                                </div>
								
                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="사용자 목록을 제공한다.">
                                    	<caption>사용자목록</caption>
                                        <colgroup>
                                            <col style="width: 30px;">
                                            <col style="width: 30px;">
                                            <col style="width: 70px;">
                                            <col style="width: 80px;">
                                            <col style="width: 120px;">
                                            <col style="width: 180px;">
                                            <col style="width: 100px;">
                                            <col style="width: 80px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <span class="f_chk_only chkAll">
                                                        <input name="checkAll" type="checkbox" title="Check All" onclick="javascript:fnCheckAll();"/>
                                                    </span>
                                                </th>
                                                <th scope="col">번호</th>
                                                <th scope="col">사용자명</th>
                                                <th scope="col">직급</th>
                                                <th scope="col">부서</th>
                                                <th scope="col">사용자아이디</th>
                                                <th scope="col">전화번호</th>
                                                <th scope="col">권한</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${fn:length(resultList) == 0}">
	                                        	<tr>
	                                        		<td colspan="8" ><spring:message code="common.nodata.msg" /></td>
	                                        	</tr>
                                        	</c:if>
                                        	<c:forEach var="result" items="${resultList}" varStatus="status">
                                            <tr onclick="location.href='${pageContext.request.contextPath}/uss/umt/user/EgovUserSelectUpdtView.do?selectedId=<c:out value="${result.uniqId};"/>'">
                                                <td>
                                                    <span class="f_chk_only">
                                                        <input name="checkField" title="Check <c:out value="${status.count}"/>" type="checkbox"/>
                                                        <input name="checkId" type="hidden" value="<c:out value='${result.userTy}'/>:<c:out value='${result.uniqId}'/>"/>
                                                    </span>
                                                </td>
                                                <td><c:out value="${paginationInfo.totalRecordCount - ((userSearchVO.pageIndex-1) * userSearchVO.pageSize) - status.index}"/></td>
                                                <td><c:out value="${result.userNm}"/></td>
                                                <td><c:out value="${result.grade}"/></td>
                                                <td><c:out value="${result.orgnztId}"/></td>
                                                <td><c:out value="${result.userId}"/></td>
                                                <td><c:out value="${result.moblphonNo}"/></td>
                                                <td><c:out value="${result.authorCode}"/></td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                    <!-- <button class="btn pty_btn" onclick="javascript:trsfExcel(); return false;">Excel</button> -->
                                </div>

								<!-- 페이지 네비게이션 시작 -->
								<c:if test="${!empty userSearchVO.pageIndex }">
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

        <!-- Footer -->
		<c:import url="/sym/mms/EgovFooter.do" />
		<!--// Footer -->
    </div>
    
</body>
</html>