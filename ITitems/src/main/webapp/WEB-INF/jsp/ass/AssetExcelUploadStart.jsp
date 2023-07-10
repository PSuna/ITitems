<%--
  Class Name : AssetExcelUploadStart.jsp
  Description : 자산 엑셀 업로드 안내 및 파일등록 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.07.07   천세훈              최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.07.07
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<script src="<c:url value='/'/>js/jquery.js"></script>
<script src="<c:url value='/'/>js/jqueryui.js"></script>
<script src="<c:url value='/'/>js/PhotoMng.js"></script>
<script src="<c:url value='/'/>js/FormSave.js"></script>
<script src="<c:url value='/'/>js/Confirm.js"></script>
<script src="<c:url value='/'/>js/Inputcheck.js"></script>
<script src="<c:url value='/'/>js/Manual.js"></script>
<script src="<c:url value='/'/>js/SearchList.js"></script>
<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javaScript" language="javascript">
function getOrgList(Oval) {
	let val = document.getElementById('searchOrgnzt').value;
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
					if(Oval == res.orgnztId){
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
/* ********************************************************
 * 검색 프로젝트 입력
 ******************************************************** */
function returnProject(val){
	
	if (val) {
		document.getElementById("searchPrj").value  = val.prjId;
		document.getElementById("prjNm").value  = val.prjNm;
	}
	
	fn_egov_modal_remove();
}
</script>
<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>
<style>
body {
    width: 100%;
    height: auto !important;
}
.board_list {
    border-top: 0;
}
.j_box02 div {
	margin:5px !important;
}
.condition2{
	padding-left:84px;
}
.marginBotH3{
	margin-bottom:15px;
}
.marginTopH3{
	margin-top:40px;
}
.important{
	color:red;
}
</style>
</head>
<body>
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>
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
										<li><a class="home" href="#LINK">Home</a></li>
										<li><a href="#LINK">${masterVO.assNm}관리</a></li>
										<li>${masterVO.assNm}엑셀업로드</li>
									</ul>
								</div>
								<!--// Location -->
								<h2 class="tit_2">${masterVO.assNm}엑셀업로드</h2>
								<!-- 검색조건 -->
								<form name="popForm" method="post" id="popForm" action="/com/xlsxAssetUpload.do" enctype="multipart/form-data">
									<div class="condition2">
										<h3 class="marginBotH3">Step1. 아래 [자산업로드엑셀양식]을 클릭하여 샘플 양식을 다운로드 합니다.</h3>
										<div class="ExcelConBox">
											<img src="<c:url value="/" />images/excelDown.png" alt="excel다운로드아이콘">
											<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
					                            <c:param name="param_atchFileId" value="${FileVO.atchFileId}" />
					                        </c:import>
				                        </div>
				                        <h3 class="marginBotH3 marginTopH3">Step2. [공통 입력값] 선택 후, [양식설명]을 참고하여 [Sheet1]에 자산정보를 입력합니다.</h3>
				                        <h4>[공통입력값]</h4>
				                        <div style="display:flex;">
					                        <div class="important">
					                        	<span>필수: 본부, 대분류 </span>
					                        </div>
					                        <span>/선택: 부서, 프로젝트</span>
				                        </div>
				                        <div class="j_box02">
				                        	<div>
												<label class="item f_select w_full" for="sel1"> 
													<select id="searchOrgnzt" name="searchOrgnzt" onchange="getOrgList();">
															<option value="" >본부</option>
															<c:forEach var="orgnztId" items="${orgnztId_result}" varStatus="status">
																<option value="${orgnztId.code}" <c:if test="${searchVO.searchOrgnzt == orgnztId.code}">selected="selected"</c:if>><c:out value="${orgnztId.codeNm}" /></option>
															</c:forEach>
													</select>
												</label> 
											</div>
											<div>
												<label class="item f_select w_full" for="sel1"> 
													<select id="lowerOrgnzt" name="lowerOrgnzt" >
															<option value="" >부서</option>
													</select>
												</label> 
											</div>
											<div>
												<label class="item f_select w_full" for="sel1">
													<select id="largeCategory" name="searchLCat">
															<option value='' label="대분류" />
															<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
																<option value="${LCat.catId}" <c:if test="${searchVO.searchLCat == LCat.catId}">selected="selected"</c:if>><c:out value="${LCat.catName}" /></option>
															</c:forEach>
													</select> 
												</label> 
											</div>
											<div class="search_box">
												<span class="f_search2 w_full"> <input id="prjNm" name="prjNm" type="text" placeholder="프로젝트"  maxlength="100" readonly="false" value="<c:out value="${searchVO.prjNm}"/>" />
													<button type="button" class="btn" onclick="ProjectSearch();">조회</button>
												</span><input name="searchPrj" id="searchPrj" type="hidden" value="<c:out value="${searchVO.searchPrj}"/>" maxlength="8" readonly="readonly" />
											</div>
										</div>
										<h4>[양식설명]</h4>
										<div class="important">
											<p>주황색으로 표시된 부분은 필수 입력값으로 반드시 입력하셔야 합니다.</p>
											<p>실제 업로드할 DATA는 3행부터 입력하셔야 합니다.</p>
											<p>임의로 행을 추가하거나 삭제하면 파일을 제대로 읽어오지 못하므로 주어진 양식안에 작성하시길 바랍니다.</p>
											<p>자산은 1건 이상 입력하셔야 합니다.</p>
										</div>
										<!-- 버튼 영역 -->
										<h3 class="marginBotH3 marginTopH3">Step3. 업로드할 파일 선택 후 업로드 버튼을 눌러 자산정보를 저장합니다.</h3>
										<div class="ExcelConBox">
											<img src="<c:url value="/" />images/excelUp.png" alt="excel다운로드아이콘">
											<input name="excelFile" id="excelFile" type="file" size="30">
											<button onclick="document.getElementById('popForm').submit();" class="btn pty_btn">업로드</button>
										</div>
									</div>	
								</form>
								<!--// 검색 조건 -->
									<!-- 게시판 -->
									<div class="board_list selete_table">
										<table>
										</table>
	                                </div>
								</div>
								<!--// 게시판 -->
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