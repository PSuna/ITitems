<%--
  Class Name : ProjectInsert.jsp
  Description : 프로젝트 등록 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.05.02   천세훈			최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.05.02
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
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>

<title>프로젝트 등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="projectVO" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
var userCheck = 0;
/* ********************************************************
 * 프로젝트 등록 처리
 ******************************************************** */
function fnPrjInsert(){
	var prjStart = document.projectVO.prjStart.value;
	var prjEnd = document.projectVO.prjEnd.value;
	if(!document.projectVO.prjName.value){
		document.getElementById('prjNameErr').innerHTML='프로젝트명은 필수입력값입니다.';
	}else{
		document.getElementById('prjNameErr').innerHTML='';
	}
	if(!document.projectVO.prjState.value){
		document.getElementById('prjStateErr').innerHTML='진행상태는 필수입력값입니다.';
	}else{
		document.getElementById('prjStateErr').innerHTML='';
	}
	if(prjStart && prjEnd && prjStart > prjEnd){
		alert("프로젝트 시작일은 종료일보다 이전이어야 합니다.")
		return;
	}
	confirm("저장하시겠습니까?")
    if(validateProjectVO(document.projectVO)){
		document.projectVO.submit();
    }
}

/* ********************************************************
 * PM 등록 시 회원 검색
 ******************************************************** */
function UserSearch(ch){
	userCheck = ch;
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/uss/umt/user/SearchUserList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/* ********************************************************
 * 회원검색값 반환
 ******************************************************** */
function returnUser(val){
	if (val) {
		if(userCheck == 0){
			document.getElementById("id").value  = val.address;
			document.getElementById("name").value  = val.userNm;
		}else if(userCheck == 1){
			document.getElementById("id").value  = val.address;
			document.getElementById("name").value  = val.userNm;
		}
	}
	fn_egov_modal_remove();
}
//-->
</script>
<style>
.errSpan{
	color:red;
}
</style>
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
										<li>프로젝트등록</li>
									</ul>
								</div>
								<!--// Location -->
								<form:form modelAttribute="projectVO" action="${pageContext.request.contextPath}/prj/ProjectInsert.do" name="projectVO" method="post">

									<h2 class="tit_2">프로젝트 등록</h2>

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
													<span class="req">필수</span>
												</td>
												<td>
													<form:input path="prjName" id="prjName" class="f_txt w_full" maxlength="50"/>
													<form:errors path="prjName" /> <form:hidden path="prjId" />
													<span id="prjNameErr" class="errSpan"></span>
												</td>
												<td class="lb">
													<!-- 수령자 --> 
													<label for="name">PM</label> 
												</td>
												<td>
													<span class="f_search2 w_30%"> 
													<form:input path="name" id="name" type="text" title="PM" maxlength="20" readOnly="true" />
													<form:errors path="name" />
													<span id="nameErr" class="errSpan"></span>
													<button type="button" class="btn" onclick="UserSearch(0);">조회</button>
													</span> 
													<form:input path="id" id="id" type="hidden" title="id" />
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
													<span id="clientErr" class="errSpan"></span>
	                                            </td>
												<td class="lb">
	                                                <label for="prjState">진행여부</label>
	                                                <span class="req">필수</span>
	                                            </td>
	                                            <td>
	                                                <label class="f_select w_full" for="prjState">
														<form:select path="prjState" id="prjState" name="prjState" title="진행여부">
															<form:option value="" label="선택하세요" />
															<form:options items="${prjState_result}" itemValue="code"
																itemLabel="codeNm" />
														</form:select>
													</label>
													<span id="prjStateErr" class="errSpan"></span>
	                                            </td>
											</tr>
										</table>
									</div>

									<!-- 목록/저장버튼  -->
									<div class="board_view_bot">
										<div class="left_col btn3">
											<a href="#LINK" class="btn btn_skyblue_h46 w_100"
												onclick="javascript:document.projectVO.reset();">초기화</a>
											<!-- 초기화 -->
										</div>

										<div class="right_col btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="JavaScript:fnPrjInsert(); return false;"><spring:message
													code="button.save" /></a>
											<!-- 등록 -->
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