<%--
  Class Name : ProjectSelectUpdt.jsp
  Description : 카테고리 상세조회, 수정 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.27   천세훈			최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.04.27
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator"
	uri="http://www.springmodules.org/tags/commons-validator"%>
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

<title>사용자 상세 및 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnUpdate(){
    if(validateProjectManageVO(document.projectVO)){
        document.projectVO.submit();
    }
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
										<li>프로젝트상세조회</li>
									</ul>
								</div>
								<!--// Location -->
								<form:form modelAttribute="projectVO" action="${pageContext.request.contextPath}/prj/ProjectSelectUpdt.do"
									name="projectVO" method="post">

									<!-- 상세정보 프로젝트 삭제시 prameter 전달용 input -->
									<input name="checkedIdForDel" type="hidden" />
									<!-- 검색조건 유지 -->
									<input type="hidden" name="searchWord"
										value="<c:out value='${searchVO.searchWord}'/>" />
									<input type="hidden" name="pageIndex"
										value="<c:out value='${searchVO.pageIndex}'/>" />

									<h2 class="tit_2">프로젝트 상세조회 및 수정</h2>

									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 160px;">
												<col style="width: auto;">
												<col style="width: 160px;">
												<col style="width: auto;">
											</colgroup>
											<tr>
												<td class="lb">
													<label for="prjName">프로젝트명</label>
												</td>
												<td>
													<form:input path="prjName" id="prjName" class="f_txt w_full" maxlength="50"/>
													<form:errors path="prjName" /> <form:hidden path="prjId" />
												</td>
												<td class="lb">
													<label for="name">PM</label>
												</td>
												<td>
													<form:input path="name" id="name" class="f_txt w_full" maxlength="20" />
													<form:errors path="name" />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<label for="prjStart">시작일</label>
												</td>
												<td>
													<form:input path="prjStart" id="prjStart" class="f_txt w_full" type="date" />
													<form:errors path="prjStart" />
												</td>
												<td class="lb">
													<label for="orgnztId">종료일</label>
												</td>
												<td>
													<form:input path="prjEnd" id="prjEnd" class="f_txt w_full" type="date"/>
													<form:errors path="prjEnd" />
												</td>
											</tr>
											<tr>
												<td class="lb">
	                                                <label for="client">고객사</label>
	                                            </td>
	                                            <td>
	                                                <form:input path="client" id="client" class="f_txt w_full" maxlength="30" />
													<form:errors path="client" />
	                                            </td>
												<td class="lb">
	                                                <label for="prjState">진행여부</label>
	                                            </td>
	                                            <td>
	                                                <label class="f_select w_full" for="prjState">
														<form:select path="prjState" id="prjState" name="prjState" title="진행여부">
															<form:option value="" label="선택하세요" />
															<form:options items="${prjState_result}" itemValue="code"
																itemLabel="codeNm" />
														</form:select>
													</label>
	                                            </td>
											</tr>
										</table>
									</div>

									<!-- 목록/저장버튼  -->
									<div class="board_view_bot">
										<div class="left_col btn3">
											<a href="<c:url value='/prj/ProjectDelete.do'/>"
												class="btn btn_skyblue_h46 w_100"
												onclick="fnDeletePrj('<c:out value='${projectVO.prjId}'/>'); return false;">
												<spring:message	code="button.delete" />
											</a>
											<!-- 삭제 -->
											<a href="#LINK" class="btn btn_skyblue_h46 w_100"
												onclick="javascript:document.projectVO.reset();">초기화</a>
											<!-- 초기화 -->
										</div>

										<div class="right_col btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="JavaScript:fnUpdate(); return false;"><spring:message
													code="button.save" /></a>
											<!-- 저장 -->
											<a href="<c:url value='/prj/ProjectManage.do'/>"
												class="btn btn_blue_46 w_100"
												onclick="fnListPage(); return false;"><spring:message
													code="button.list" /></a>
											<!-- 목록 -->
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