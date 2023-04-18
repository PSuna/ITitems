<%--
  Class Name : AssetManagement.jsp 
  Description : 자산조회 화면
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

<title>자산관리 > 자산조회</title>
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
										<li>자산조회</li>
									</ul>
								</div>
								<!--// Location -->

								<h1 class="tit_1">자산관리</h1>

								<h2 class="tit_2">자산조회</h2>

								<!-- 검색조건 -->
								<div class="condition2">
									<span class="lb">위치</span> <label class="item f_select"
										for="sel1"> <select name="" id="sel1" title="조건">
											<option value="">위치</option>
									</select>
									</label> <span class="lb">프로젝트</span> <label class="item f_select"
										for="sel1"> <select name="" id="sel1" title="조건">
											<option value="">프로젝트</option>
									</select>
									</label> <span class="lb">대분류</span> <label class="item f_select"
										for="sel1"> <select name="" id="sel1" title="조건">
											<option value="">대분류</option>
									</select>
									</label> <span class="lb">중분류</span> <label class="item f_select"
										for="sel1"> <select name="" id="sel1" title="조건">
											<option value="">중분류</option>
									</select>
									</label> <br> <span class="lb">상태</span> <label
										class="item f_select" for="sel1"> <select name=""
										id="sel1" title="조건">
											<option value="">상태</option>
									</select>
									</label> <span class="lb ml20">취득일자</span> <input class="f_date"
										type="date"> ― <input class="f_date"
										type="date"> <span class="item f_search">검색
										<input class="f_input w_130" type="text" name="" id="usernm"
										title="검색어">
										<button class="btn" type="submit">조회</button>
									</span>
								</div>
								<!--// 검색조건 -->

								<!-- 게시판 -->
								<div class="board_list">
									<table>
										<colgroup>
											<col style="width: 80px;">
											<col style="width: auto;">
											<col style="width: 150px;">
											<col style="width: 150px;">
											<col style="width: 150px;">
											<col style="width: 150px;">
										</colgroup>
										<thead>
											<tr>
												<th scope="col"></th>
												<th scope="col">대분류</th>
												<th scope="col">중분류</th>
												<th scope="col">품명</th>
												<th scope="col">수량</th>
												<th scope="col">취득일자</th>
												<th scope="col">취득가액</th>
												<th scope="col">제조사</th>
												<th scope="col">상태</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="result" items="${resultList}"
												varStatus="status">
												<tr>
													<td><c:out value="${result.rum}" /></td>
													<td><c:out value="${result.largeCategory}" /></td>
													<td><c:out value="${result.middleCategory}" /></td>
													<td><c:out value="${result.assetName}" /></td>
													<td><c:out value="${result.histQty}" /></td>
													<td><c:out value="${result.acquiredDate}" /></td>
													<td><c:out value="${result.acquiredPrice}" /></td>
													<td><c:out value="${result.maker}" /></td>
													<td><c:out value="${result.histStatus}" /></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>

								<!-- 페이지 네비게이션 시작 -->
								<div class="board_list_bot">
									<div class="paging" id="paging_div">
										<ul>
											<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />
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