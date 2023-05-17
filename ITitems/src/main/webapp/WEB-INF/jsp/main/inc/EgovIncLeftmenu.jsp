<%--
  Class Name : EgovIncLeftmenu.jsp
  Description : 좌메뉴화면(include)
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2023.04.10   천세훈       최초생성

    author   : 영남사업부 천세훈
    since    : 2023.04.10
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="nav">
	<div class="inner">
	
	<script type="text/javascript">
		// 메뉴 목록 추출
		var menuList = new Array;
		if(document.menuListForm.tmp_menuNm != null){
			
			for (var j = 0; j < document.menuListForm.tmp_menuNm.length; j++) {
				menuList[j] = document.menuListForm.tmp_menuNm[j].value;
			}
		}
		var leftStartMenuValue = document.getElementById("baseMenuNo").value;
		if (leftStartMenuValue==null || leftStartMenuValue=="" || leftStartMenuValue=="null") leftStartMenuValue = '1000000';
		console.log("leftStartMenuValue = "+leftStartMenuValue);
		
		// 서브 메뉴 생성
		function subMenuTag(menuList, mainMenuNo) {
			var subMenuTag = "";
			menuList.forEach(function(item,index){
				var itemList = item.split('|');
				
				if ( mainMenuNo == itemList[1] ) {
					subMenuTag += '<li><a href="<c:url value='/'/>'+itemList[5].substr(1)+'">'+itemList[2]+'</a></li>';
				}
			});
			if (subMenuTag != "") subMenuTag = "<ul>"+subMenuTag+"</ul>";
			return subMenuTag;
		}
	
		var topMenuTag = "";
		var mainMenuTag = "";
		
		menuList.forEach(function(item,index){
			console.log(item,index);
			var itemList = item.split('|');
			switch(leftStartMenuValue) {
			case itemList[0]:
				topMenuTag = "<h2>"+itemList[2]+"</h2>";
			    break;
			case itemList[1]:
				mainMenuTag += '<li><a href="<c:url value='/'/>'+itemList[5].substr(1)+'">'+itemList[2]+'</a>'
								+ subMenuTag(menuList, itemList[0])
								+ '</li>';
			    break;
			default:
			    break;
			}
		});
	
		document.write(topMenuTag + '<ul>' + mainMenuTag + '</ul>');
		
	</script>
	
	</div>
</div>