<%--
  Class Name : EgovIdDplctCnfirm.jsp
  Description : 시리얼넘버중복확인
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.07.07   주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.07.07
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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
	<script src="<c:url value='/'/>js/Inputcheck.js"></script>
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>

<base target="_self">
<script type="text/javaScript">
<!--

function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}

function AssetSnCnfirm(){
	if($("#assetSn").val() != null && $("#assetSn").val() != ""){
		document.checkForm.action = "<c:url value='/ass/AssetSnCnfirm.do'/>";
	    document.checkForm.submit();
	}else{
		$(".result").text("결과: 등록할 시리얼넘버를 입력해주세요").css("color","red");
	}
}
function emptyAssetSn() {
	var val   = new Object();
	val.empty  = '없음';
	parent.parent.ReturnAssetSn(val);
}

function ReturnAssetSn(){
	var val   = new Object();
	val.assetSn  = '${assetSn}';
	
	parent.parent.ReturnAssetSn(val);
}
//-->
</script>

</head>
<body>

	<form id="checkForm" name="checkForm" action ="<c:url value='/uss/umt/cmm/EgovIdDplctCnfirm.do'/>" autocomplete="off">

    <!-- 아이디중복확인 팝업 -->
    <div class="popup POP_DUPID_CONF">
        <div class="pop_inner">
            <div class="pop_header">
                <h1><spring:message code="ass.assetSn" /> 중복확인</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>

            <div class="pop_container">
                <div class="box_1">
                    <label for="mid">등록할 <spring:message code="ass.assetSn" /></label>
                    <input id="assetSn" class="f_txt2 wp_80" name="assetSn" value="${assetSn}" type="text" maxlength="60" onchange="symbolCheck2(this);" onkeyup="symbolCheck2(this);">
                </div>

                <p class="result">
                    <!-- 결과 : 중복확인을 실행하십시오. -->
                    결과 : 
                    <c:choose>
                    	<c:when test="${usedCnt eq -1}">
                    		&nbsp;중복확인을 실행하십시오 
                    	</c:when>
                    	<c:when test="${usedCnt eq 0}">
                    		&nbsp;등록가능한 <spring:message code="ass.assetSn" />입니다.
                    	</c:when>
                    	<c:otherwise>
                    		&nbsp;이미 있는 <spring:message code="ass.assetSn" />입니다.
                    	</c:otherwise>
                    </c:choose>
                </p>

                <div class="btn_area al_c pt20 sn_btn">
                    <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:AssetSnCnfirm(); return false;"><spring:message code="button.inquire" /></a><!-- 조회하기 -->
                    <c:choose>
                    	<c:when test="${usedCnt eq 0}">
                    		<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:ReturnAssetSn(); return false;"><spring:message code="button.use" /></a><!-- 사용하기 -->
                    	</c:when>
                    	<c:otherwise>
                    		<a href="#LINK" class="btn btn_blue_46 w_150" onclick="javascript:emptyAssetSn(); return false;">시리얼넘버 없음</a><!-- 조회하기 -->
                    	</c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    <!--// 아이디중복확인 팝업 -->
    
    </form>
    
</body>
</html>