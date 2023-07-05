<%--
  Class Name : InAssetSearchList.jsp
  Description : 반입가능자산 검색 화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.06.16   천세훈              최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.06.16
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
<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
<link rel="stylesheet" href="<c:url value='/'/>css/pty_m2.css">
<link rel="stylesheet" href="<c:url value='/'/>css/pty.css">
<link rel="stylesheet" href="<c:url value='/'/>css/jsh.css">
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>


<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
<title>프로젝트 찾기</title>

<script type="text/javaScript" language="JavaScript">
/* ********************************************************
 * onload
 ******************************************************** */
window.onload = function(){
	getMCatList('${searchVO.searchdMCat}');
}
/* ********************************************************
 * 중분류 조회
 ******************************************************** */
function getMCatList(Mval) {
	let val = document.getElementById('largeCategory').value;
	if(val == ""){
		document.getElementById('middleCategory').replaceChildren();
		let op = document.createElement('option');
		op.textContent = '중분류';
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
				op.textContent = '중분류';
				op.value = "";
				document.getElementById('middleCategory').appendChild(op);
				for(res of result){
					op = document.createElement('option');
					op.setAttribute('value', res.catId);
					op.textContent = res.catName;
					if(Mval == res.catId){
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
/* ********************************************************
 * 프로젝트 검색
 ******************************************************** */
function ProjectSearch(){
    
    var $dialog = $('<div id="modalPan" class="SearchList"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/prj/ProjectSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 660,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
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

/* ********************************************************
 * 자산 검색
 ******************************************************** */
function SearchAssetList() {
	event.preventDefault();
	document.listForm.pageIndex.value = '1';
    document.listForm.action = "<c:url value='/ass/InAssetSearchList.do'/>";
    document.listForm.submit(); 
}

function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}

function fn_egov_return_Ass(assetId, middleCategory, assetQty, assetSn, maker, rcptNm, useNm) {
	var val = new Object();
	val.assetId = assetId;
	val.middleCategory = middleCategory;
	val.assetQty = assetQty;
	val.assetSn = assetSn;
	val.maker = maker;
	val.rcptNm = rcptNm;
	val.useNm = useNm;
	parent.parent.returnAss(val);
}

function fn_egov_pageview(page) {
	document.listForm.pageIndex.value = page;
	document.listForm.action = "<c:url value='/ass/InAssetSearchList.do'/>";
	document.listForm.submit();
}

function fn_egov_search_Prj() {
	document.listForm.pageIndex.value = 1;
	document.listForm.action = "<c:url value='/ass/InAssetSearchList.do'/>";
	document.listForm.submit();
}
</script>
<style>
.condition2 .j_box02 {
	flex-wrap: nowrap;
}
.j_box02 div {
	margin-right:3px;
}
</style>
</head>
<body>
	<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

	<form name="listForm"
		action="<c:url value='/ass/InAssetSearchList.do'/>" method="post">

		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
		<!-- 프로젝트 찾기 팝업 -->
		<div class="popup POP_POST_SEARCH">
			<div class="pop_inner">
				<div class="pop_header">
					<h1>반입가능 자산검색</h1>
					<button type="button" class="close"
						onclick="fn_egov_cancel_popup(); return false;">닫기</button>
				</div>
				<div class="pop_container pop_search">

					<!-- 검색조건 -->
					<div class="condition2">
						<div class="j_box03">
							<!-- <div>
								<span class="f_search2 w_full"> <input id="prjNm" name="prjNm" type="text" placeholder="프로젝트" maxlength="100" readonly="readonly" value="">
									<button type="button" class="btn" onclick="ProjectSearch();">조회</button>
								</span>
							</div> -->
							<div>
								<!-- <span class="lb">대분류</span>  -->
								<label class="item f_select w_full" for="sel1"> <select
									id="largeCategory" name="searchLCat" onchange="getMCatList();">
										<option value='' label="대분류" />
										<c:forEach var="LCat" items="${LCat_result}"
											varStatus="status">
											<option value="${LCat.catId}"
												<c:if test="${searchVO.searchLCat == LCat.catId}">selected="selected"</c:if>><c:out
													value="${LCat.catName}" /></option>
										</c:forEach>
								</select>
								</label>
							</div>
							<div>
								<!-- <span class="lb">중분류</span> -->
								<label class="item f_select w_full" for="sel1"> <select
									id="middleCategory" name="searchdMCat">
										<option value='' label="중분류" />
								</select>
								</label>
							</div>
							<div class="search_box" >
								<span class="item f_search w_full" >
									<input class="f_input w_full pty_f_input" type="text" name="searchName" onchange="SearchAssetList(); return false;" placeholder="실사용자 검색" title="검색어" value="<c:out value="${searchVO.searchName}"/>">
								</span>
							</div>
							<div class="btn_box" >
								<button class="btn pty_btn" type="submit" onclick="SearchAssetList();">검색</button>
							</div>
						</div>
					</div>
					<!--// 검색 조건 -->

					<!-- 게시판 -->
					<div class="board_list selete_table">
						<table>
							<colgroup>
								<col style="width: 40%;">
								<col style="width: 15%;">
								<col style="width: 30%;">
								<col style="width: 15%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">프로젝트</th>
									<th scope="col">중분류</th>
									<th scope="col">S/N</th>
									<th scope="col">실사용자</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr onclick="fn_egov_return_Ass( '${result.assetId}', '${result.middleCategory}', '${result.assetQty}', '${result.assetSn}', '${result.maker}', '${result.rcptNm}', '${result.useNm}');">
										<td><c:out value="${result.prjNm}" /></td>
										<td><c:out value="${result.middleCategory}" /></td>
										<td><c:out value="${result.assetSn}" /></td>
										<td><c:out value="${result.useNm}" /></td>
										<%-- <td><a href="#LINK" class="btn btn_blue_30 w_80"
											onclick="fn_egov_return_Prj( '${result.middleCategory}', '${result.assetSn}', '${result.rcptNm}', '${result.useNm}');">
												선택 </a></td> --%>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<!-- 페이지 네비게이션 시작 -->
					<div class="board_list_bot">
						<div class="paging" id="paging_div">
							<ul>
								<ui:pagination paginationInfo="${paginationInfo}" type="image"
									jsFunction="fn_egov_pageview" />
							</ul>
						</div>
					</div>
					<!-- //페이지 네비게이션 끝 -->
					<!--// 게시판 -->
				</div>
			</div>
		</div>
		<!--// 우편번호 찾기 팝업 -->

	</form>

</body>
</html>