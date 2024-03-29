<%--
  Class Name : ApprovalConfirm.jsp
  Description : 등록확인 모달
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


<link rel="icon" type="image/png" href="<c:url value="/" />images/res/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>

<script type="text/javaScript" language="JavaScript">
	function fn_egov_cancel_popup() {
		parent.fn_egov_modal_remove();
	}

	function return_val(val) {

		parent.parent.returnDisConfirm(val);
	}
	
</script>
<style>
</style>
</head>

<body>
	<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

		<!-- 프로젝트 찾기 팝업 -->
		<div class="popup POP_POST_SEARCH">
			<div class="pop_inner">
				<div class="pop_header">
					<h1>반려 확인</h1>
				</div>
				<div class="pop_container check">
					<div class="pop_check">
						<h4><spring:message code="common.acknowledgementcancel.msg" /></h4>
						<!-- 버튼  -->
						<div class="board_view_bot">
							<div class="btn1">
								<!-- 예  -->
								<a href="#LINK" class="btn btn_blue_46 w_100"
									onclick="return_val(true);return false;"><spring:message
										code="button.yes" /></a>
								<!-- 아니오  -->
								<a href="#LINK" class="btn btn_blue_46 w_100"
									onclick="return_val(false);return false;"><spring:message
										code="button.no" /></a>
							</div>
						</div>
						<!-- // 버튼 끝  -->
					</div>
				</div>
			</div>
		</div>

</body>
</html>