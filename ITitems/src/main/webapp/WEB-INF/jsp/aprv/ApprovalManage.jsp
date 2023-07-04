<%--
  Class Name : ApprovalManage.jsp
  Description : 사용자관리(조회,삭제) JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.05.11   천세훈              최초 생성
 
    author   : 영남사업부 천세훈 선임
    since    : 2023.05.11
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>

		   <link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
		
<title>ITeyes 자산관리솔루션</title>


<script type="text/javaScript" language="javascript" defer="defer">
<!--
function setPageUnit(){
	inputPush();
	document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/aprv/ApprovalManage.do'/>";
    document.listForm.submit();
}

function fnSearch(){
    document.listForm.pageIndex.value = 1;
    document.listForm.action = "<c:url value='/aprv/ApprovalManage.do'/>";
    document.listForm.submit();
}
function fntrsfExcel(){
	inputPush();
	if(document.getElementById('noData')){
		alert("엑셀로 다운로드할 목록이 없습니다.")
	}else{
	    document.listForm.action = "<c:url value='/com/xlsxTrsfAprvList.do'/>";
	    document.listForm.submit();
	}
}
function fnSelectAprv(reqId){
	document.listForm.reqId.value = reqId;
	document.listForm.action = "<c:url value='/aprv/selectApproval.do'/>";
	document.listForm.submit();
}
function inputPush(){
	document.listForm.searchGroup.value = '${approvalSearchVO.searchGroup}';
	document.listForm.searchStatus.value = '${approvalSearchVO.searchStatus}';
	document.listForm.searchKeyword.value = '${approvalSearchVO.searchKeyword}';
}
function fnLinkPage(pageNo){
	inputPush();
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/aprv/ApprovalManage.do'/>";
    document.listForm.submit();
}

function resizeDate(width) {
	if(width>425){
		$(".resizeDate").each(function(index, item){
			let str = $(item).text();
			if(str.indexOf('.') != -1){
				$(item).text();
				let newDate = moment(str,'YY.MM.DD').format('YYYY-MM-DD');
				$(item).text(newDate);
			}else{
				return;
			}
		})
	}else{
		$(".resizeDate").each(function(index, item){
			let str = $(item).text();
			if(str.indexOf('-') != -1){
				$(item).text();
				let newDate = moment(str,'YYYY-MM-DD').format('YY.MM.DD');
				$(item).text(newDate);
			}else{
				return;
			}
		})
	}

}
$(window).resize(function(){
const width = window.innerWidth;
resizeDate(width);
});
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
                    
                    	<div class="content_wrap">
                    		<div id="contents" class="content">
                    			<!-- Location -->
                                <div class="location">
                                	<ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li>결재</li>
                                    </ul>
                                </div>
                                <!--// Location -->
                                
                                <form name="listForm" action="<c:url value='/aprv/ApprovalManage.do'/>" method="post">
                                	
                                	<input name="targetId" type="hidden" value="<c:out value='${approvalSearchVO.uniqId}'/>"/>
                                	<input name="pageIndex" type="hidden" value="<c:out value='${approvalSearchVO.pageIndex}'/>"/>
                                	<input name="firstIndex" type="hidden" value="<c:out value='${approvalSearchVO.firstIndex}'/>"/>
									<input name="recordCountPerPage" type="hidden" value="<c:out value='${approvalSearchVO.recordCountPerPage}'/>"/>
                                	<input name="reqId" type="hidden"/>
                                	<h2 class="tit_2">결재</h2>
                                	
                                	<!-- 검색조건 -->
                                	<div class="condition2" >
                                	<div class="j_box03">
	                                		<div>
		                                		<label class="item f_select w_full" for="searchGroup">
		                                			<select id="searchGroup" name="searchGroup" title="검색조건-결재분류" onchange="javascript:fnSearch(); return false;">
		                                				<option value="" label="분류" />
																<option value="C0" <c:if test="${approvalSearchVO.searchGroup == 'C0'}">selected="selected"</c:if> label="반입신청" />
																<option value="C1" <c:if test="${approvalSearchVO.searchGroup == 'C1'}">selected="selected"</c:if>label="반출신청" />
		                                			</select>
		                                		</label>
	                                		</div>
	                                		<div>
		                                		<label class="item f_select w_full" for="searchStatus">
		                                			<select id="searchStatus" name="searchStatus" title="검색조건-결재상태" onchange="javascript:fnSearch(); return false;">
		                                				<option value="" label="상태"/>
		                                				<c:forEach var="aprvStatus" items="${aprvStatus_result }">
		                                					<option value="<c:out value="${aprvStatus.code}"/>" <c:if test="${approvalSearchVO.searchStatus == aprvStatus.code}">selected="selected"</c:if>>${aprvStatus.codeNm}</option>
		                                				</c:forEach>
		                                			</select>
		                                		</label>
	                                		</div>
		                                    <div class="search_box ">
												<span class="item f_search w_full" >
													<input class="f_input pty_f_input" padding:0" type="text" name="searchKeyword" placeholder="신청자/프로젝트명 검색" title="검색어" value="<c:out value="${approvalSearchVO.searchKeyword}"/>">
												</span>
											</div>
											<div class="btn_box">
												<button class="btn pty_btn" onclick="javascript:fnSearch(); return false;">검색</button>
											</div>
	                                	</div>
                                	</div>
                                	<!-- //검색조건 -->

									<div class="board_list_top">
										<div class="left_col">
											<div class="list_count">
												<div style="display: flex; justify-content: space-between; align-items: center;" class="pty_margin-bottom_8">
													<div>
														<span style="margin: 0;">Total :</span>
														<strong><c:out value="${paginationInfo.totalRecordCount}" /></strong>
													</div>
													
													<div style="display: flex; align-items: center;">
														<span style="margin-right: 16px;">페이지당 항목 수</span>
														<label class="item f_select" for="pageUnit">
															<select name="pageUnit" id="pageUnit" title="페이지당 항목 수" onchange="setPageUnit(); return false;">
																<option value="10" <c:if test="${empty approvalSearchVO.pageUnit || approvalSearchVO.pageUnit == '10'}">selected="selected"</c:if>>10</option>
																<option value="20" <c:if test="${approvalSearchVO.pageUnit == '20'}">selected="selected"</c:if>>20</option>
																<option value="50" <c:if test="${approvalSearchVO.pageUnit == '50'}">selected="selected"</c:if>>50</option>
																<option value="100" <c:if test="${approvalSearchVO.pageUnit == '100'}">selected="selected"</c:if>>100</option>
																<option value="300" <c:if test="${approvalSearchVO.pageUnit == '300'}">selected="selected"</c:if>>300</option>
																<option value="500" <c:if test="${approvalSearchVO.pageUnit == '500'}">selected="selected"</c:if>>500</option>
															</select>
														</label>
													</div>
												</div>
											</div>
										</div>
									</div>

									<!-- 리스트 -->
                                	<div class="board_list">
                                		<table summary="결재요청 목록을 제공한다.">
                                			<caption>결재요청목록</caption>
                                			<colgroup>
	                                            <col style="width: 7%;">
												<col style="width: 12%;">
												<col style="width: 30%;">
												<col style="width: 17%;">
												<col style="width: 12%;">
												<col style="width: 12%;">
												<col style="width: 10%;">
                                        	</colgroup>
                                        	<thead>
                                        		<tr>
	                                				<th scope="col">번호</th>
	                                				<th scope="col">분류</th>
	                                				<th scope="col">프로젝트명</th>
	                                				<th scope="col">사용장소</th>
	                                				<th scope="col">신청자</th>
	                                				<th scope="col">신청일</th>
	                                				<th scope="col">상태</th>
                                				</tr>
                                			</thead>
                                			<tbody>
                                				<c:if test="${fn:length(resultList) == 0}">
                                					<tr>
                                						<td colspan="8" id="noData"><spring:message code="common.nodata.msg" /></td>
                                					</tr>
                                				</c:if>
                                				
                                				<c:forEach var = "result" items="${resultList}" varStatus="status">
                                					<tr onclick="fnSelectAprv('<c:out value="${result.reqId}"/>');">
                                						<td><c:out value="${paginationInfo.totalRecordCount - ((approvalSearchVO.pageIndex-1) * approvalSearchVO.pageUnit) - status.index}"/></td>
                                						<td><c:out value="${result.reqGroup}"/></td>
                                						<td class="pty_text-align_left pty_padding-left_24"><c:out value="${result.prjId}"/></td>
                                						<td class="pty_text-align_left pty_padding-left_24"><c:out value="${result.place}"/></td>
                                						<td><c:out value="${result.id} ${result.grade}"/></td>
                                						<td class="resizeDate"><c:out value="${result.reqDate}"/></td>
                                						<td><c:out value="${result.reqStatus}"/></td>
                                					</tr>
                                				</c:forEach>
                                			</tbody>
                                		</table>
                                		<div class="btn_area">
	                                		<div class="excel_btn pty_margin-left_8">
	                                			<button class="btn pty_btn" onclick="javascript:fntrsfExcel(); return false;">Excel</button>
	                                		</div>
                                		</div>
                                	</div>
                                <!-- 페이지 네비게이션 시작 -->
								<c:if test="${!empty approvalSearchVO.pageIndex }">
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