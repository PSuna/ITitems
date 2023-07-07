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
<script type="text/javaScript" language="javascript" defer="defer">

</script>
<link rel="icon" type="image/png" href="<c:url value="/" />images/pty_tap_icon.png"/>
<title>ITeyes 자산관리솔루션</title>
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
								<form id="frm" name="frm" autocomplete="off" method="post">
								<input name="startPage" type="hidden" value="<c:out value='${searchVO.startPage}'/>"/>
								<input name="totalRecord" type="hidden" value="<c:out value='${searchVO.totalRecord}'/>"/>
									<div class="condition2">
										<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
										<input type="hidden" name="pageUnit" value="<c:out value='${searchVO.pageUnit}'/>"/>
										<input type="hidden" name="assetId" />
										<input type="hidden" name="mngNum" />
										<input type="hidden" name="assId" value="<c:out value='${searchVO.assId}'/>"/>
										<input type="hidden" name="listCode" value="AM" />
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
												<select id="largeCategory" name="searchLCat" onchange="getMCatList();">
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
											<div class="btn_box">
												<button class="btn pty_btn" onclick="SearchAssetList();">검색</button>
											</div>
										</div>
										<p>아래 지급확인서를 다운받아 작성하여 등록해주세요.</p>
										<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				                            <c:param name="param_atchFileId" value="${FileVO.atchFileId}" />
				                        </c:import>
									</div>	
								</form>
								<!--// 검색 조건 -->
								
									<!-- 게시판 -->
									<div class="board_list selete_table">
										<table>
										</table>
	                                </div>
								</div>
								<div>
									<div class="btn_area">
											<div class="excel_btn pty_margin-left_8">
												<button class="btn pty_btn" onclick="javascript:fntrsfExcel(); return false;">Excel</button>
												<%-- <img src="<c:url value="/" />images/pty_icon_03.png"> --%>								
											</div>
	                                    	<a href="#LINK" style="margin-left:4px;" class="item btn btn_blue_46" onclick="AssetRegist(); return false;">
	                                    	<spring:message code="button.create" /></a><!-- 등록 -->
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

</body>
</html>