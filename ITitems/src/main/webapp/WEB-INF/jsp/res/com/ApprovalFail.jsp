<%--
  Class Name : ApprovalFail.jsp
  Description : 결재등록실패 모달
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.05.12   천세훈              최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.05.12
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
	<link rel="stylesheet" href="<c:url value='/'/>css/res/jsh.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>


<script type="text/javaScript" language="JavaScript">
	function fn_egov_cancel_popup() {
		parent.fn_egov_modal_remove();
	}
	
</script>
</head>

<body>
	<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

		<!-- 프로젝트 찾기 팝업 -->
		<div class="popup POP_POST_SEARCH">
			<div class="pop_inner">
				<div class="pop_header">
					<h1>결재승인실패</h1>
				</div>
				<div class="pop_container check">
					<div class="pop_check2">
						<h4><spring:message code="fail.common.approve" /></h4>
						<h4><spring:message code="fail.common.msg" /></h4>
						<!-- 버튼  -->
						<div class="board_view_bot">
							<div class="btn1">
							<!-- 확인  -->
								<a href="#LINK" class="btn btn_blue_46 w_100"
									onclick="fn_egov_cancel_popup();return false;"><spring:message
										code="button.confirm" /></a>
							</div>
						</div>
						<!-- // 버튼 끝  -->
					</div>
				</div>
			</div>
		</div>

</body>
</html>