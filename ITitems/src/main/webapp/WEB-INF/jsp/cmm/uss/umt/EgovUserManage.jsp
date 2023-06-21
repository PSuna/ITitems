<%--
  Class Name : EgovUserManage.jsp
  Description : 사용자관리(조회,삭제) JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.17   천세훈              최초 생성
 
    author   : 영남사업부 천세훈
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
	<link rel="stylesheet" href="<c:url value='/'/>css/jsh.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/csh.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>


<script type="text/javaScript" language="javascript" defer="defer">
<!--
window.onload = function(){
	getMOrgList('${userSearchVO.searchLOrgnzt}');
}
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
/* ********************************************************
 * 페이지 이동
 ******************************************************** */
function fnLinkPage(pageNo){
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
    document.listForm.submit();
}
function fnSelectUser(id) {
    document.listForm.selectedId.value = id;
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

/* function fnViewCheck(){ 
    if(insert_msg.style.visibility == 'hidden'){
        insert_msg.style.visibility = 'visible';
    }else{
        insert_msg.style.visibility = 'hidden';
    }
} */

function setPageUnit(){
	document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 엑셀다운로드
 ******************************************************** */
function fntrsfExcel(){
	if(document.getElementById('noData')){
		alert("엑셀로 다운로드할 항목이 없습니다.")
	}else{
	    document.listForm.action = "<c:url value='/com/xlsxTrsfUserList.do'/>";
	    document.listForm.submit();
	}
}

function getMOrgList(MOval) {
	let val = document.getElementById('orgnztId').value;
	if(val == ""){
		document.getElementById('lowerOrgnzt').replaceChildren();
		let op = document.createElement('option');
		op.textContent = '부서';
		op.value = "";
		document.getElementById('lowerOrgnzt').appendChild(op);
	}else{
		$.ajax({
			url: '${pageContext.request.contextPath}/org/GetMOrgnztList.do',
			method: 'POST',
			contentType: 'application/x-www-form-urlencoded',
			data: {'searchUpperOrg' : val},
			success: function (result) {
				document.getElementById('lowerOrgnzt').replaceChildren();
				let op = document.createElement('option');
				op.textContent = '부서';
				op.value = "";
				document.getElementById('lowerOrgnzt').appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.orgnztId);
					op.textContent = res.orgnztNm;
					if(MOval == res.orgnztId){
						op.setAttribute('selected', 'selected');
					}
					document.getElementById('lowerOrgnzt').appendChild(op);
				}
			},
			error: function (error) {
				console.log(error);
			}
		})
		
	}
}
//-->
</script>
<style>
.board_list tbody tr:hover {
	background: #ccc;
	cursor: pointer;
}
.board_list_top+.board_list{
	margin-top:0;
}

</style>

<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>

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
                                        <li>사용자목록</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="listForm" action="<c:url value='/uss/umt/user/EgovUserManage.do'/>" method="post">
									
									<input name="selectedId" type="hidden" />
									<input name="checkedIdForDel" type="hidden" />
									<input name="pageIndex" type="hidden" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
									<input name="firstIndex" type="hidden" value="<c:out value='${userSearchVO.firstIndex}'/>"/>
									<input name="recordCountPerPage" type="hidden" value="<c:out value='${userSearchVO.recordCountPerPage}'/>"/>
									
	                                <h2 class="tit_2">사용자목록</h2>
	                                
	                                <!-- 검색조건 -->
	                                <div class="condition">
	                                
	                                	<div class="pty_condition">
	                                	
		                                    <div>
												<label class="item f_select w_180" for="sel1"> 
													<select id="orgnztId" name="searchOrgnzt" title="본부"  onchange="getMOrgList(); fnSearch();">
															<option value="" label="본부"/>
															<c:forEach var="orgnztId" items="${orgnztId_result}" varStatus="status">
																<option value="${orgnztId.code}" <c:if test="${userSearchVO.searchOrgnzt == orgnztId.code}">selected="selected"</c:if>><c:out value="${orgnztId.codeNm}" /></option>
															</c:forEach>
													</select>
												</label> 
											</div>
											<div>
												<label class="item f_select w_180" for="sel1">
												<select id="lowerOrgnzt" name="searchLOrgnzt" title="부서" onchange="fnSearch();">
													<option value='' label="부서" <c:if test="${userSearchVO.searchLOrgnzt == orgnztId.code}">selected="selected"</c:if>></option>
												</select>
												</label> 
											</div>
											
											<div>
			                                    <label class="item f_select w_150"  for="searchGrade">
			                                    	<select id="searchGrade" name="searchGrade" title="검색조건-직급" onchange="javascript:fnSearch(); return false;">
				                                        <option value="" label="직급"/>
				                                        <c:forEach var="grade" items="${grd_result}">
				                                        	<option value="<c:out value="${grade.code}"/>" <c:if test="${userSearchVO.searchGrade == grade.code}">selected="selected"</c:if>>${grade.codeNm}</option>
				                                        </c:forEach>
			                                    	</select>
			                                    </label>
			                                  </div>  
			                                    
			                                <div>    
			                                  <label class="item f_select w_150" for="searchAuthor">
		                                        <select name="searchAuthor" id="searchAuthor" title="검색조건-권한" onchange="fnSearch();">
		                                        	<option value="" label="권한"/>
			                                        <c:forEach var="author" items="${auth_result}">
			                                        	<option value="<c:out value="${author.code}"/>" <c:if test="${userSearchVO.searchAuthor == author.code}">selected="selected"</c:if>>${author.codeNm}</option>
			                                        </c:forEach>
		                                        </select>
		                                    </label> 
			                                    
			                                    
			                                 </div>   
		                                    
		                             
											<div class="pty_search">
												<span class="item f_search">
													<input class="f_input pty_f_input" style="margin-right:8px;" type="text" name="searchKeyword" placeholder="사번/사용자명/아이디" title="검색어" value="<c:out value="${userSearchVO.searchKeyword}"/>">
												</span>
												
											</div>
											
											<button class="btn pty_btn" onclick="javascript:fnSearch(); return false;">검색</button>
											
		                                </div>
	                                </div>
	                                
	                                
	                                
	                                
	                                <!--// 검색조건 -->
									
									<div class="board_list_top">
										<div class="left_col">
												<div class="list_count">
	
	
													<div style="display: flex; justify-content: space-between; align-items: center;" class="pty_margin-bottom_8">
														
														<div>
															<span style="margin:0;">Total:</span> 
															<strong><c:out value="${paginationInfo.totalRecordCount}" /></strong> 
																	
														</div>
															
														<div style="display: flex; align-items: center;">
															<span style="margin-right: 16px;">페이지당 항목 수</span> 
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
															
															
														</div>
														
													</div>
													
													
												</div>
											</div>
	                                </div>
									
	                                <!-- 게시판 -->
	                                <div class="board_list">
	                                    <table summary="사용자 목록을 제공한다.">
	                                    	<caption>사용자목록</caption>
	                                        <colgroup>
	                                            <col style="width: 3%;">
	                                            <col style="width: 5%;">
	                                            <col style="width: 15%;">
	                                            <col style="width: 18%;">
	                                            <col style="width: 24%;">
	                                            <col style="width: 11%;">
	                                            <col style="width: 14%;">
	                                            <col style="width: 10%;">
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
	                                                <th scope="col">부서</th>
	                                                <th scope="col">사용자아이디</th>
	                                                <th scope="col">사번</th>
	                                                <th scope="col">전화번호</th>
	                                                <th scope="col">권한</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        	<c:if test="${fn:length(resultList) == 0}">
		                                        	<tr>
		                                        		<td colspan="8" id="noData"><spring:message code="common.nodata.msg" /></td>
		                                        	</tr>
	                                        	</c:if>
	                                        	<c:forEach var="result" items="${resultList}" varStatus="status">
	                                            <tr onclick="fnSelectUser('<c:out value="${result.uniqId}"/>');">
	                                                <td onclick='event.cancelBubble=true;'>
	                                                    <span class="f_chk_only">
	                                                        <input name="checkField" title="Check <c:out value="${status.count}"/>" type="checkbox"/>
	                                                        <input name="checkId" type="hidden" value="<c:out value='${result.userTy}'/>:<c:out value='${result.uniqId}'/>"/>
	                                                    </span>
	                                                </td>
	                                                <td><c:out value="${paginationInfo.totalRecordCount - ((userSearchVO.pageIndex-1) * userSearchVO.pageUnit) - status.index}"/></td>
	                                                <td><c:out value="${result.userNm} ${result.grade}"/></td>
	                                                <td><c:out value="${result.orgnztId}"/></td>
	                                                <td><c:out value="${result.userId}"/></td>
	                                                <td><c:out value="${result.empUniqNum}"/></td>
	                                                <td class="pty_font-size_12"><c:out value="${result.moblphonNo}"/></td>
	                                                <c:if test="${result.authorCode == '사용자'}">
	                                               		<td><c:out value="${result.authorCode}"/></td>
	                                               	</c:if>
	                                                <c:if test="${result.authorCode == '관리자'}">
	                                               		<td id="adminC"><c:out value="${result.authorCode}"/></td>
	                                               	</c:if>
	                                                <c:if test="${result.authorCode == '최고관리자'}">
	                                               		<td id="adminH"><c:out value="${result.authorCode}"/></td>
	                                               	</c:if>
	                                            </tr>
	                                            </c:forEach>
	                                            
	                                        </tbody>
	                                    </table>
	                                    <div class="btn_area">
		                                    <div class="excel_btn pty_margin-left_8">
												<button class="btn pty_btn" onclick="javascript:fntrsfExcel(); return false;">Excel</button>
												<%-- <img src="<c:url value="/" />images/pty_icon_03.png"> --%>								
											</div>
											
											<div>
			                                    <a href="#LINK" style="margin-left:4px;" class="item btn btn_blue_46" onclick="javascript:fnDeleteUser(); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
			                                    <a href="<c:url value='/uss/umt/user/EgovUserInsertView.do'/>" style="margin-left:4px;" class="item btn btn_blue_46" onclick="fnAddUserView(); return false;"><spring:message code="button.create" /></a><!-- 등록 -->
		                                   	</div>
	                                    </div>
	                                    
	                                  
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