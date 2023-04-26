<%--
  Class Name : CategoryManage.jsp
  Description : 카테고리 관리 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.21    천세훈             최초 생성
 
    author   : 영남사업부 천세훈 선임
    since    : 2023.04.21
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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
<title>사이트관리 > 카테고리관리 > 카테고리목록관리</title>
<script type="text/javaScript">
<!-- 
var imgpath = "<c:url value='/'/>images/";
//-->
</script>
<script language="javascript1.2" type="text/javaScript"
	src="<c:url value='/js/EgovMenuCreat.js'/>"></script>
<script language="javascript1.2" type="text/javaScript">
<!--

/* ********************************************************
 * 대분류 조회 함수
 ******************************************************** */
function fnSetUpperCat(){
	document.getElementById('upperUl').replaceChildren();
	var setUpper = document.getElementById('settedUpper');
	setUpper.setAttribute('value','');
	console.log(setUpper.value);
	$.ajax({
		url:"${pageContext.request.contextPath}/cat/GetMCategoryList.do",
		method : "post",
		success:function(result){
			if(result.length==0){
				document.getElementById('upperUl').appendChild(document.createTextNode('==상위카테고리가 없습니다=='))
			}else{
				for(res of result){
					var upperLi = document.createElement('li');
					upperLi.setAttribute('id', res.catId);
					upperLi.setAttribute('class', 'upperLi');
					upperLi.textContent = res.catName;
					upperLi.onclick = function(){
						fnSetLowerCat(this);
					};
					var delBtn = document.createElement('button');
					delBtn.innerHTML = 'X';
					delBtn.setAttribute('id', res.catId);
					delBtn.onclick = function(){
						fnDeleteCat(this);
					};
					upperLi.appendChild(delBtn);
					document.getElementById('upperUl').appendChild(upperLi);
				}
			}
		},error:function(error){
			console.log(error);
		}
	})
}

/* ********************************************************
 * 중분류 조회 함수
 ******************************************************** */
function fnSetLowerCat(e){
	document.getElementById('lowerUl').replaceChildren();
	var searchUpper = e.id;
	var setUpper = document.getElementById('settedUpper');
	setUpper.setAttribute('value',e.id);
	$.ajax({
		url : "${pageContext.request.contextPath}/cat/GetMCategoryList.do",
		method : "post",
		data : {
			searchUpper
		},
		success:function(result){
			if(result.length==0){
				document.getElementById('lowerUl').appendChild(document.createTextNode('==하위카테고리가 없습니다=='))
			}else{
				for(res of result){
					var lowerLi = document.createElement('li');
					lowerLi.setAttribute('id', res.catId);
					lowerLi.setAttribute('class', 'lowerLi');
					lowerLi.textContent = res.catName;
					var delBtn = document.createElement('button');
					delBtn.innerHTML = 'X';
					delBtn.setAttribute('id', res.catId);
					delBtn.onclick = function(){
						fnDeleteCat(this);
					}
					lowerLi.appendChild(delBtn);
					document.getElementById('lowerUl').appendChild(lowerLi)
				}
			}
		},error:function(error){
			console.log(error);
		}
	})
}
/* ********************************************************
 * 대분류 추가 함수
 ******************************************************** */
function fnUpperInsertCat(){
	var catName = document.getElementById('upperCatName').value;
	$.ajax({
		url: "${pageContext.request.contextPath}/cat/InsertCategory.do",
		method : "post",
		data : {
			catName
		},
		success:function(result){
			alert("등록 성공!");
			document.getElementById('upperCatName').value = "";
			fnSetUpperCat();
		},error:function(){
			alert("중복된 대분류명이 존재합니다.");
		}
	})
}

/* ********************************************************
 * 중분류 추가 함수
 ******************************************************** */
function fnLowerInsertCat(){
	var catName = document.getElementById('lowerCatName').value;
	var upperCat = document.getElementById('settedUpper').value;
	var setLow = document.createElement('input');
	setLow.setAttribute('id', upperCat);
	$.ajax({
		url: "${pageContext.request.contextPath}/cat/InsertCategory.do",
		method : "post",
		data : {
			catName,
			upperCat
		},
		success:function(result){
			alert("등록 성공!");
			document.getElementById('lowerCatName').value = "";
			fnSetLowerCat(setLow);
		},error:function(){
			alert("중복된 중분류명이 존재합니다.")
		}
	})
}
/* ********************************************************
 * 분류 삭제 함수
 ******************************************************** */
function fnDeleteCat(e){
	var catId = e.id;
	$.ajax({
		url : "${pageContext.request.contextPath}/cat/DeleteCategory.do",
		method : "post",
		data: {
			catId
		},
		success:function(result){
			console.log(result);
			if(result<1){
				alert("하위 항목이 존재합니다.");
			}else{
				alert("삭제 성공");
				fnSetUpperCat();
				document.getElementById('lowerUl').replaceChildren();
			}
		}
	})
}
-->
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
						<!-- Left menu -->
						<c:import url="/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->
						<div class="content_wrap">
							<div id="contents" class="content">
								<!-- Location -->
								<div class="location">
									<ul>
										<li><a class="home" href="">Home</a></li>
										<li><a href="">사이트관리</a></li>
										<li><a href="">카테고리관리</a></li>
										<li>카테고리목록관리</li>
									</ul>
								</div>
								<!--// Location -->
								<input id="settedUpper" name="upperId" type="hidden" />
								<h2 class="tit_2">카테고리목록관리</h2>
								<div class="upperCat">
									<h3>대분류</h3>
									<div class="box">
										<ul id="upperUl">
										</ul>
									</div>
									<label for="upperCatName" class="lb mr10">대분류명 : </label>
									<input id="upperCatName" class="f_txt item" name="catName" type="text" maxlength="20" title="대분류명">
									<a href="#LINK" id="upperCatIn" class="item btn btn_blue_46 w_100" onclick="fnUpperInsertCat()">추가</a>
								</div>
								<div class="lowerCat">
									<h3>중분류</h3>
									<div class="box">
										<ul id="lowerUl">
										</ul>
									</div>
									<label for="lowerCatName" class="lb mr10">중분류명 : </label>
									<input id="lowerCatName" class="f_txt item" name="catName" type="text" maxlength="20" title="중분류명">
									<a href="#LINK" id="lowerCatIn" class="item btn btn_blue_46 w_100" onclick="fnLowerInsertCat(this)">추가</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<c:import url="/sym/mms/EgovFooter.do" />
	<!--// Footer -->
<script>
fnSetUpperCat();
</script>
</body>
</html>