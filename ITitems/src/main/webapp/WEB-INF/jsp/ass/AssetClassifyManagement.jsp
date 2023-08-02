<%--
  Class Name : AssetClassifyManagement.jsp 
  Description : 자산소유구분 관리화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.08.01   천세훈              최초 생성
 
    author   : 영남사업부 천세훈
    since    : 2023.08.01
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<link rel="stylesheet" href="<c:url value='/'/>css/csh.css">
<script src="<c:url value='/'/>js/SearchList.js"></script>
<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
<script src="<c:url value='/'/>js/ui.js"></script>


<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--
/* ********************************************************
 * 회원 검색
 ******************************************************** */
function UserSearch(){
    
    var $dialog = $('<div id="modalPan" class="SearchList"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/uss/umt/user/SearchUserList.do'/>" +'" width="100%" height="100%"></iframe>')
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
 * 검색 회원 입력
 ******************************************************** */
function returnUser(val){
	document.getElementById("userId").value  = val.userId;
	document.getElementById("userNm").value  = val.userNm;
	fn_egov_modal_remove();
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
 * 부서 조회
 ******************************************************** */
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
 * 자산 검색
 ******************************************************** */
function SearchAssetList() {
	event.preventDefault();
	
	document.frm.pageIndex.value = '1';
    document.frm.action = "<c:url value='/ass/DelReqManagement.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * 페이지 항목 수 변경
 ******************************************************** */
function setPageUnit(obj) {
	event.preventDefault();
	inputpush();
	document.frm.pageIndex.value = '1';
	document.frm.pageUnit.value = obj.value;
    document.frm.action = "<c:url value='/ass/DelReqManagement.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * 페이지 이동
 ******************************************************** */
function fn_egov_select_noticeList(pageNo) {
	event.preventDefault()
	inputpush();
	document.frm.pageIndex.value = pageNo;
    document.frm.action = "<c:url value='/ass/DelReqManagement.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * input 정리
 ******************************************************** */
function inputpush() {
	document.frm.searchOrgnzt.value = '${searchVO.searchOrgnzt}';
	document.frm.lowerOrgnzt.value = '${searchVO.lowerOrgnzt}';
	document.frm.searchLCat.value = '${searchVO.searchLCat}';
	document.frm.searchdMCat.value = '${searchVO.searchdMCat}';
	document.frm.userId.value = '${searchVO.userId}';
	document.frm.userNm.value = '${searchVO.userNm}';
}

/* ********************************************************
 * 자산 상세 페이지 이동
 ******************************************************** */
function SelectAsset(assetId,mngNum) {
	inputpush();
	event.preventDefault();
	document.frm.assetId.value = assetId;
	document.frm.mngNum.value = mngNum;
    document.frm.action = "<c:url value='/ass/SelectAsset.do'/>";
    document.frm.submit(); 
}

/* ********************************************************
 * Excel
 ******************************************************** */
function fntrsfExcel(){
	inputpush();
	if(document.getElementById('noData')){
		alert("엑셀로 다운로드할 목록이 없습니다.")
	}else{
	    document.frm.action = "<c:url value='/com/xlsxTrsfAssetList.do'/>";
	    document.frm.submit();
	}
}


/* ********************************************************
 * onload
 ******************************************************** */
window.onload = function(){
	getMCatList('${searchVO.searchdMCat}');
	getOrgList('${searchVO.lowerOrgnzt}')
	
	  }
//-->
</script>
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
						<!-- Left menu -->
						<c:import url="/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->
						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="#LINK">Home</a></li>
										<li><a href="#LINK">자산데이터관리</a></li>
										<li>자산렌탈삭제요청</li>
									</ul>
								</div>
								<!--// Location -->
								<h2 class="tit_2">자산렌탈삭제요청</h2>
								<!-- 검색조건 -->
								<form id="frm" name="frm" autocomplete="off" method="post">
								<input name="startPage" type="hidden" value="<c:out value='${searchVO.startPage}'/>"/>
								<input name="totalRecord" type="hidden" value="<c:out value='${searchVO.totalRecord}'/>"/>
									<div class="condition2">
										<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
										<input type="hidden" name="pageUnit" value="<c:out value='${searchVO.pageUnit}'/>"/>
										<input type="hidden" name="assetId" />
										<input type="hidden" name="mngNum" />
										<input type="hidden" name="assId" value="<c:out value='${searchVO.assId}'/>"/>
										<input type="hidden" name="listCode" value="DM" />
										<div class="j_box05">
											<div>
												<!-- <span class="lb">본부/부서</span> -->
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
												<!-- <span class="lb">본부/부서</span> -->
												<label class="item f_select w_full" for="sel1"> 
													<select id="lowerOrgnzt" name="lowerOrgnzt" >
															<option value="" >부서</option>
													</select>
												</label> 
											</div>
											<div>
												<!-- <span class="lb">대분류</span>  -->
												<label class="item f_select w_full" for="sel1">
												<select id="largeCategory" name="searchLCat" onchange="getMCatList();">
														<option value='' label="대분류" />
														<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
															<option value="${LCat.catId}" <c:if test="${searchVO.searchLCat == LCat.catId}">selected="selected"</c:if>><c:out value="${LCat.catName}" /></option>
														</c:forEach>
												</select> 
												</label> 
											</div>
																							
											<div>
												<!-- <span class="lb">중분류</span> --> <label class="item f_select w_full" for="sel1"> <select id="middleCategory" name="searchdMCat" >
														<option value='' label="중분류" />
												</select>
												</label> 
											</div>
											<div class="search_box">
												<!-- <span class="lb">신청자</span> -->
												<span class="f_search2 w_full"> 
													<input id="userNm" name="userNm" type="text" placeholder="신청자" maxlength="100"
														readonly="readonly" value="<c:out value="${searchVO.userNm}"></c:out>" onclick="UserSearch()"/>
													<button type="button" class="btn" onclick="UserSearch()">조회</button>
												</span>
												<input name="userId" id="userId" type="hidden" value="<c:out value="${searchVO.userId}"></c:out>"
													maxlength="8" readonly="readonly" />
											</div>
											<div class="btn_box">
												<button class="btn pty_btn" onclick="SearchAssetList();">검색</button>
											</div>
										</div>
									</div>	
								</form>
								<!--// 검색 조건 -->
								<div class="board_list_top">
									<div class="left_col">
											<div class="list_count">


												<div style="display: flex; justify-content: space-between; align-items: center;" class="pty_margin-bottom_8">
													
													<div>
														<span style="margin:0;">Total :</span> 
														<strong><c:out value="${paginationInfo.totalRecordCount}" /></strong> 
																
													</div>
														
													<div style="display: flex; align-items: center;">
														<span style="margin-right: 16px;">페이지당 항목 수</span> 
														<label class="item f_select" for="pageUnit"> 
																
															<select name="pageUnit" id="pageUnit"  onchange="setPageUnit(this); return false;">										
																	<option value="10" <c:if test="${empty searchVO.pageUnit || searchVO.pageUnit == '10'}">selected="selected"</c:if>>10</option>
																	<option value="20" <c:if test="${searchVO.pageUnit == '20'}">selected="selected"</c:if>>20</option>
																	<option value="50" <c:if test="${searchVO.pageUnit == '50'}">selected="selected"</c:if>>50</option>
																	<option value="100" <c:if test="${searchVO.pageUnit == '100'}">selected="selected"</c:if>>100</option>
																	<option value="300" <c:if test="${searchVO.pageUnit == '300'}">selected="selected"</c:if>>300</option>
																	<option value="500" <c:if test="${searchVO.pageUnit == '500'}">selected="selected"</c:if>>500</option>
															</select>
														</label>
													</div>
													
												</div>
												
												
											</div>
										</div>
                                </div>
								<!-- 게시판 -->
								<div class="board_list selete_table">
									<table>
										<colgroup>
											<col style="width: 10%;">
											<col style="width: 18%;">
											<col style="width: 18%;">
											<col style="width: 18%;">
											<col style="width: 18%;">
											<col style="width: 18%;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">본부</th>
												<th scope="col">부서</th>
												<th scope="col">분류</th>
												<th scope="col">신청자</th>
												<th scope="col">신청일자</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="result" items="${resultList}"
												varStatus="status">
												<tr onclick="SelectAsset('${result.assetId}','${result.mngNum}');">
													<td>
														<c:out value="${paginationInfo.totalRecordCount - ((searchVO.pageIndex-1) * searchVO.pageUnit) - status.index}" />
													</td>
													<td><c:out value="${result.orgnztNm}" /></td>
													<td><c:out value="${result.lowerOrgnztNm}" /></td>
													<td><c:out value="${result.middleCategory}" /></td>
													<td><c:out value="${result.creatId}" /></td>
													<td><c:out value="${result.reqDate}" /></td>
												</tr>
											</c:forEach>
											<c:if test="${empty resultList}">
												<tr>
                               						<td colspan="8" id="noData">등록된 요청이 없거나 조건에 맞는 요청이 없습니다</td>
                               					</tr>
											</c:if>
										</tbody>
									</table>
								</div>
								<div>
								
								<div class="btn_area">
                                </div>
                                </div>
								<c:if test="${not empty resultList}">
									<!-- 페이지 네비게이션 시작 -->
									<div class="board_list_bot">
										<div class="paging" id="paging_div">
											<ul>
												<ui:pagination paginationInfo="${paginationInfo}"
													type="image" jsFunction="fn_egov_select_noticeList" />
											</ul>
										</div>
									</div>
									<!-- //페이지 네비게이션 끝 -->
								</c:if>
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
	</div>

</body>
</html>