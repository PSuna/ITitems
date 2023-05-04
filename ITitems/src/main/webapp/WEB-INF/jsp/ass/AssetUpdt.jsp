<%--
  Class Name : AssetInsert.jsp
  Description : 자산등록 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.13   주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.04.13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
<script src="<c:url value='/'/>js/jquery.js"></script>
<script src="<c:url value='/'/>js/jqueryui.js"></script>
<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<link href="<c:url value='${brdMstrVO.tmplatCours}' />" rel="stylesheet"
	type="text/css">
<script type="text/javascript" src="<c:url value='/js/EgovBBSMng.js' />"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript"
	src="<c:url value='/js/EgovCalPopup.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="assetUpdt" staticJavascript="false"
	xhtml="true" cdata="false" />
<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* ********************************************************
 * 자산 수정 처리
 ******************************************************** */
function UpdateAsset(){
	if(confirm("수정하시겠습니까?")){
		if(validateAssetUpdt(document.AssetUpdt)){
			let formData = new FormData(document.getElementById('AssetUpdt'));
			
		 	 $.ajax({
				url: '${pageContext.request.contextPath}/ass/AssetUpdate.do',
				method: 'POST',
				enctype: "multipart/form-data",
				processData: false,
				contentType: false,
				data: formData,
				success: function (result) {
				},
				error: function (error) {
					console.log(error);
				}
			}) 
	    }
	}
}

/* ********************************************************
 * 중분류 조회
 ******************************************************** */
function getMCatList(Mval) {
	let val = document.getElementById('largeCategory').value;
	if(val == ""){
		document.getElementById('middleCategory').replaceChildren();
		let op = document.createElement('option');
		op.textContent = '선택하세요';
		op.value = "";
		document.getElementById('middleCategory').appendChild(op);
	}else{
		$.ajax({
			url: '${pageContext.request.contextPath}/cat/GetMCategoryList.do',
			method: 'POST',
			contentType: 'application/x-www-form-urlencoded',
			data: {'searchUpper' : val},
			success: function (result) {
				document.getElementById('middleCategory').replaceChildren();
				let op = document.createElement('option');
				op.textContent = '선택하세요';
				document.getElementById('middleCategory').appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.catId);
					op.textContent = res.catName;
					if(Mval == res.catName){
						op.setAttribute('selected', 'selected');
					}
					document.getElementById('middleCategory').appendChild(op);
				}
			},
			error: function (error) {
				console.log(error);
			}
		})
	}
}

window.onload = function(){
	getMCatList('${resultVO.middleCategory}');
	  }
//-->
</script>

<title>자산관리 > 자산등록</title>

</head>

<style type="text/css">
.ui-datepicker-trigger {
	margin-left: 10px;
	vertical-align: middle;
}

.board_view_bot {
	overflow: hidden;
}

.right_btn {
	float: right;
}
</style>

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
						<!-- Left menu -->
						<c:import url="/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->

						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="">Home</a></li>
										<li><a href="">자산관리</a></li>
										<li>신규자산등록</li>
									</ul>
								</div>
								<!--// Location -->


								<form:form modelAttribute="AssetInfoVO" id="AssetUpdt" name="AssetUpdt" method="post" enctype="multipart/form-data" >
									<input type="hidden" id="assetId" name="assetId" value="${resultVO.assetId}">
									<h1 class="tit_1">자산관리</h1>

									<h2 class="tit_2">신규자산등록</h2>

									<br>
									<!-- 추가/초기화 버튼  -->
									<!-- <div class="board_view_bot">
										<div class="right_btn btn1">
											<a href="#LINK" class="btn btn_blue_46 w_130"
												onclick="AssetSearch(); return fasle;">기존 자산 등록</a>
											기존 자산 추가
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="frm_reset(); return fasle;">초기화</a>
											초기화
										</div>
									</div> -->
									<!-- // 추가/초기화 버튼 끝  -->
									<div class="board_view2">
										<table>
											<colgroup>
												<col style="width: 190px;">
												<col style="width: auto;">
											</colgroup>
											<tr>
												<td class="lb">
													<!-- 대분류 --> 
													<label for="">대분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select" for="largeCategory">
															<select id="largeCategory" name="largeCategory"
																title="대분류" onchange="getMCatList();">
																<option value="" label="선택하세요" />
																<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
																	<option value="${LCat.catId}" <c:if test="${LCat.catName == resultVO.largeCategory}">selected="selected"</c:if>>
																		<c:out value="${LCat.catName}" />
																	</option>
																</c:forEach>
															</select>
															<form:errors path="largeCategory" />
													</label> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 중분류 --> 
													<label for="">중분류</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<label class="f_select" for="middleCategory">
														<select id="middleCategory" name="middleCategory">
														</select>
													</label> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 품명 --> 
													<label for="">품명</label>
												</td>
												<td>
													<input id="assetName" class="f_txt w_full" name="assetName" type="text" value="${resultVO.assetName}"  maxlength="60">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 수량 -->
													<label for="">수량</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="assetQty" class="f_txt w_full" name="assetQty" type="number" value="${resultVO.assetQty}"  maxlength="20">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 취득일자 --> 
													<label for="">취득일자</label> 
													<span class="req">필수</span>
												</td>
												<td>
													<input id="acquiredDate" class="f_txt w_full" name="acquiredDate" type="date" value="${resultVO.acquiredDate}">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 취득가액 --> 
													<label for="">취득가액</label>
												</td>
												<td>
													<input id="acquiredPrice" class="f_txt w_full"
													name="acquiredPrice" type="number" value="${resultVO.acquiredPrice}" maxlength="60">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 제조사 --> 
													<label for="">제조사</label>
												</td>
												<td>
													<input id="maker" class="f_txt w_full" name="maker" type="text" value="${resultVO.maker}" maxlength="60"> 
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 추가물품 --> 
													<label for="">추가물품</label>
												</td>
												<td>
													<input id="addAsset" class="f_txt w_full" name="addAsset" type="text" value="${resultVO.addAsset}" maxlength="60">
													<br />
												</td>
											</tr>
											<tr>
												<td class="lb">
													<!-- 비고 --> 
													<label for="note">비고</label>
												</td>
												<td>
													<textarea id="note" name="note" class="f_txtar w_full h_200" cols="30" rows="10" >${resultVO.note}</textarea>
												</td>
											</tr>
											<!-- 파일첨부 시작 -->
											<tr>
												<td class="lb">
													<label for="egovComFileUploader">사진첨부</label>
												<td>
													<div class="board_attach2" id="file_upload_posbl">
														<input name="photo" id="photo" type="file" />
														<div id="egovComFileList"></div>
													</div>
													<div class="board_attach2" id="file_upload_imposbl">
													</div> 
													<c:if test="${empty result.atchFileId}">
														<input type="hidden" id="fileListCnt" name="fileListCnt" value="0" />
													</c:if>
												</td>
											</tr>
										</table>

										<c:if test="${bdMstr.fileAtchPosblAt == 'Y'}">
											<script type="text/javascript">
												var maxFileNum = document.board.posblAtchFileNumber.value;
												if (maxFileNum == null
														|| maxFileNum == "") {
													maxFileNum = 3;
												}
												var multi_selector = new MultiSelector(
														document
																.getElementById('egovComFileList'),
														maxFileNum);
												multi_selector
														.addElement(document
																.getElementById('egovComFileUploader'));
											</script>
										</c:if>
									</div>
									
									<br>
									
									<!-- 등록버튼  -->
									<div class="board_view_bot">
										<div class="right_btn btn1">
											<a href="#LINK" class="btn btn_blue_46 w_100"
												onclick="UpdateAsset(); return false;"><spring:message
													code="button.update" /></a>
											<!-- 등록 -->
										</div>
									</div>
									<!-- // 등록버튼 끝  -->
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