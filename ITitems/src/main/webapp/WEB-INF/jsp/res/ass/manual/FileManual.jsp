<%--
  Class Name : PhotoManual.jsp
  Description : 제품사진 안내 화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.05.09   주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.05.09
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

<title>프로젝트 찾기</title>

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
					<h1>지급확인서 안내</h1>
					<button type="button" class="close"
						onclick="fn_egov_cancel_popup(); return false;">닫기</button>
				</div>
				<div class="pop_container pop_Manual_File">
						<p>아래 지급확인서를 다운받아 작성하여 등록해주세요.</p>
						<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
                            <c:param name="param_atchFileId" value="${FileVO.atchFileId}" />
                        </c:import>
                        <p>(예시)</p>
						<img alt="" src="<c:url value='/'/>images/res/FileManual.png">


				</div>
			</div>
		</div>

</body>
</html>