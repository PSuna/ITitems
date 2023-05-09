<%--
  Class Name : DisposeRequest.jsp 
  Description : 처분신청조회 화면 
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.13   주소현              최초 생성
 
    author   : 영남사업부 주소현
    since    : 2023.04.13
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	
<title>ITitems</title>

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
</script>
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
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">자산관리</a></li>
                                        <li>처분신청조회</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">자산관리</h1>

                                <h2 class="tit_2">처분신청조회</h2>
                                <br>
                                
                                <!-- 검색조건 -->
								<form id="searchVO">
									<div class="condition2">
										
										<div class="pty_box01">
											<div>
												<span class="lb">부서</span> 
												
												<label class="item f_select" for="sel1"> 
													<select id="searchOrgnzt" name="searchOrgnzt" title="부서">
															<option value="" label="선택하세요" />
															<c:forEach var="orgnztId" items="${orgnztId_result}" varStatus="status">
																<option value="${orgnztId.code}">
																	<c:out value="${orgnztId.codeNm}" />
																</option>
															</c:forEach>
													</select>
												</label> 
											</div>	
																																		
											<div>
												<span class="lb">프로젝트</span> 
																			
												<span class="f_search2 w_200"> 
													<input id="prjNm" type="text" title="주소" maxlength="100" readonly="false" />
													<button type="button" class="btn" onclick="ProjectSearch();">조회</button>										
												</span>										
												<input name="searchPrj" id="searchPrj" type="hidden" title="프로젝트" value="" maxlength="8" readonly="readonly" />
											</div>	
											
										</div>		
		
										<div class="pty_box01">
											<div>
												<span class="lb">대분류</span> 
												
												<label class="item f_select" for="sel1">										
													<select id="largeCategory" name="largeCategory" title="대분류" onchange="getMCatList();">
															<option value='' label="선택하세요" selected="selected" />
															<c:forEach var="LCat" items="${LCat_result}" varStatus="status">
																<option value="${LCat.catId}"><c:out value="${LCat.catName}" /></option>
															</c:forEach>
													</select> 										
												</label> 
											</div>	
												
											
											<div>	
												<span class="lb">중분류</span> 
												
												<label class="item f_select" for="sel1"> 									
													<select id="middleCategory" name="middleCategory" title="중분류">
															<option value='' label="선택하세요" selected="selected" />
													</select>										
												</label> 
											</div>
												
										</div>		
												
												
										<div class="pty_box01">		
											<div>	
												 <span class="lb">상태</span> 
												 
												 <label class="item f_select" for="sel1"> 										 
													 <select id="searchStatus" name="searchStatus" title="상태">
															<option value='' label="선택하세요" selected="selected" />
															<c:forEach var="stat" items="${status_result}" varStatus="status">
																<option value="${stat.code}"><c:out value="${stat.codeNm}" /></option>
															</c:forEach>
													</select>
												</label> 
												
												
												
												
											</div>	
												
												
											<div>
												<span class="lb ml20">신청일자</span> 
												
												<input class="f_date pty_f_date" name="startDate" type="date"> ― <input class="f_date pty_f_date" type="date" name="endDate"> 
												
												
											
											</div>	
											
											
											
									
										</div>
										
										
										<div class="pty_search">
											<span class="lb">조회</span>
										
											<span class="item f_search">
												<input class="f_input w_250 pty_f_input" type="text" name="searchWord" id="usernm" placeholder="검색어를 입력해주세요" title="검색어">
											</span>
											
											<button class="btn pty_btn" type="submit">검색</button>
										</div>
												
									</div>
								</form>
								<!--// 검색 조건 -->
							
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
                                                <th scope="col"> </th>
                                                <th scope="col">대분류</th>
                                                <th scope="col">중분류</th>
                                                <th scope="col">품명</th>
                                                <th scope="col">수량</th>
                                                <th scope="col">신청일자</th>
                                                <th scope="col">신청상태</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <li class="btn"><a href="" class="first">처음</a></li>
                                            <li class="btn"><a href="" class="btn prev">이전</a></li>
                                            <li><strong>1</strong></li>
                                            <li><a href="">2</a></li>
                                            <li><a href="">3</a></li>
                                            <li><a href="">4</a></li>
                                            <li><a href="">5</a></li>
                                            <li><a href="">6</a></li>
                                            <li><a href="">7</a></li>
                                            <li><a href="">8</a></li>
                                            <li><a href="">9</a></li>
                                            <li><a href="">10</a></li>
                                            <li class="btn"><a href="" class="btn next">다음</a></li>
                                            <li class="btn"><a href="" class="btn last">마지막</a></li>
                                        </ul>
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
    </div>
    
</body>
</html>