<%--
  Class Name : ReturnRequest.jsp 
  Description : 반납신청조회 화면
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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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

<title>자산관리 > 반납신청조회</title>

<script type="text/javascript">
function ProjectSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/prj/ProjectSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

function fn_egov_returnValue(val){
	
	if (val) {
		document.getElementById("prjId").value  = val.prjId;
		document.getElementById("prjNm").value  = val.prjNm;
	}
	
	fn_egov_modal_remove();
}

function getMCatList() {
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
					document.getElementById('middleCategory').appendChild(op);
				}
			},
			error: function (error) {
				console.log(error);
			}
		})
	}
	
}

function SearchCarryList() {
	event.preventDefault();

	document.frm.pageIndex.value = '1';
    document.frm.action = "<c:url value='/req/CarryRequset.do'/>";
    document.frm.submit(); 
}


function fn_egov_select_noticeList(pageNo) {
	event.preventDefault()
	document.frm.searchOrgnzt.value = '${searchVO.searchOrgnzt}';
	document.frm.prjNm.value = '${searchVO.prjNm}';
	document.frm.searchPrj.value = '${searchVO.searchPrj}';
	document.frm.searchLCat.value = '${searchVO.searchLCat}';
	document.frm.searchdMCat.value = '${searchVO.searchdMCat}';
	document.frm.searchStatus.value = '${searchVO.searchStatus}';
	document.frm.startDate.value = '${searchVO.startDate}';
	document.frm.endDate.value = '${searchVO.endDate}';
	document.frm.pageIndex.value = pageNo;
    document.frm.action = "<c:url value='/req/CarryRequset.do'/>";
    document.frm.submit(); 
}

window.onload = function(){
	getMCatList();
	  }

function CarryRegist() {
	 document.regist.submit();
}
</script>
<style type="text/css">
.board_view_bot {
	overflow: hidden;
}

.right_btn {
	float: right;
}

.board_list tbody tr:hover {
	background: #ccc;
	cursor: pointer;
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
										<li><a href="">자산관리</a></li>
										<li>반출/반입신청조회</li>
									</ul>
								</div>
								<!--// Location -->

								<h1 class="tit_1">자산관리</h1>

								<h2 class="tit_2">반출/반입신청조회</h2>

								<br />
								<form name="regist" method="post"
									action="<c:url value='/req/CarryRegist.do'/>">
									<div class="board_view_bot">
										<div class="right_btn btn1">
											<a href="#LINK" class="btn btn_blue_46 w_130"
												onclick="CarryRegist();">반출신청</a>
										</div>
									</div>
								</form>
								<br>
								<!-- 검색조건 -->
								<form id="searchVO" name="frm">
									<input type="hidden" name="pageIndex">
									<div class="condition2">
										<div class="pty_box01">
											<div>
												<span class="lb">부서</span> <label class="item f_select"
													for="sel1"> <select id="searchOrgnzt"
													name="searchOrgnzt" title="부서">
														<option value="" label="선택하세요" />
														<c:forEach var="orgnztId" items="${orgnztId_result}"
															varStatus="status">
															<option value="${orgnztId.code}"><c:out
																	value="${orgnztId.codeNm}" /></option>
														</c:forEach>
												</select>
												</label>
											</div>
											<div>
												<span class="lb">프로젝트</span> <span class="f_search2 w_200">
													<input id="prjNm" type="text" title="주소" maxlength="100"
													readonly="false" />
													<button type="button" class="btn"
														onclick="ProjectSearch();">조회</button>
												</span><input name="searchPrj" id="searchPrj" type="hidden"
													title="프로젝트" value="" maxlength="8" readonly="readonly" /><br>
											</div>

										</div>


										<div class="pty_box01">
											<div>
												<span class="lb">대분류</span> <label class="item f_select"
													for="sel1"><select id="largeCategory"
													name="largeCategory" title="대분류" onchange="getMCatList();">
														<option value='' label="선택하세요" selected="selected" />
														<c:forEach var="LCat" items="${LCat_result}"
															varStatus="status">
															<option value="${LCat.catId}"><c:out
																	value="${LCat.catName}" /></option>
														</c:forEach>
												</select> </label>
											</div>


											<div>
												<span class="lb">중분류</span> <label class="item f_select"
													for="sel1"> <select id="middleCategory"
													name="middleCategory" title="중분류">
														<option value='' label="선택하세요" selected="selected" />
												</select>
												</label>
											</div>
										</div>
										<div class="pty_box01">
											<div>
												<span class="lb">상태</span> <label class="item f_select"
													for="sel1"> <select id="searchStatus"
													name="searchStatus" title="상태">
														<option value='' label="선택하세요" selected="selected" />
														<c:forEach var="stat" items="${status_result}"
															varStatus="status">
															<option value="${stat.code}"><c:out
																	value="${stat.codeNm}" /></option>
														</c:forEach>
												</select>
											</div>

											<span class="lb ml20">신청일자</span> <input
												class="f_date pty_f_date" name="startDate" type="date">
											― <input class="f_date pty_f_date" type="date" name="endDate">
											<button class="btn pty_btn" type="submit"
												style="margin-left: 6px" onclick="SearchCarryList();">검색</button>
										</div>
									</div>
								</form>

								<!--// 검색 조건 -->

								<!-- 게시판 -->
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 5%;">
											<col style="width: 10%;">
											<col style="width: 25%;">
											<col style="width: 25%;">
											<col style="width: 25%;">
											<col style="width: 10%;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col"></th>
												<th scope="col">분류</th>
												<th scope="col">신청자</th>
												<th scope="col">프로젝트</th>
												<th scope="col">신청일자</th>
												<th scope="col">신청상태</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="result" items="${resultList}"
												varStatus="status">
												<tr onclick="childNodes[1].childNodes[1].submit();">
													<td><c:out value="${result.rum}" />
														<form name="subForm" method="post"
															action="<c:url value='/req/SelectCarry.do'/>">
															<input type="hidden" name="reqId"
																value="<c:out value='${result.reqId}'/>" />
														</form></td>
													<td><c:out value="${result.reqGroup}" /></td>
													<td><c:out value="${result.id}" /></td>
													<td><c:out value="${result.prjId}" /></td>
													<td><c:out value="${result.reqDate}" /></td>
													<td><c:out value="${result.reqStatus}" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

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