<%--
  Class Name : EgovMenuCreat.jsp
  Description : 메뉴생성 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

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



<script type="text/javaScript">
<!--
var imgpath = "<c:url value='/'/>images/";
//-->
</script>
<script language="javascript1.2" type="text/javaScript" src="<c:url value='/js/EgovMenuCreat.js'/>"></script>
<script language="javascript1.2" type="text/javaScript">

// 폴더 접기 (하위부서 가리기)
function DelTreeBox(obj,Id,lList) {
	if($(obj).closest(".tree_box").children(".tree_list").length != 0){
		$(obj).closest(".tree_box").children(".tree_list").remove();
	}
	$(obj).attr("src","/images/add-folder.png").attr("onclick","AddTreeBox(this,'" + Id + "','" + lList + "')")

}

// 폴더 열기 (하위부서 조회)
function AddTreeBox(obj,Id,lList) {

	let formData = new FormData(document.getElementById('listForm'));
	formData.append("searchOrgnztId",Id);
    $.ajax({
		url: '${pageContext.request.contextPath}/org/SelectOrgnztVOList.do',
		method: 'POST',
		enctype: "multipart/form-data",
		processData: false,
		contentType: false,
		data: formData,
		success: function (result) {
			makeTreeList(obj,Id,lList,result);
		},
		error: function (error) {
			console.log(error);
		}
	})    
	
}
 
// 하위부서 리스트 생성
function makeTreeList(obj,Id,lList,list){
	
	if($(list).length > 0 ) {
		let treeList = $("<div/>").addClass("tree_list");
		$(list).each(function(index, item){
			let lineList = [];
			if(lList != null && lList != ""){
				lineList = lList.split("");
			}
			console.log(lineList);
			let treeBox = $("<div/>").addClass("tree_box");
			$(lineList).each(function(i, line){
				console.log(line);
				if(line == 1){
					$(treeBox).append($("<img/>").attr("src","/images/line0.png").addClass("tree_line"));
				}else if(line == 0){
					$(treeBox).append($("<img/>").attr("src","/images/line3.png").addClass("tree_line"));
				}
			})
			let treeP = $("<p/>").text(item.orgnztNm).attr("onclick","return_val('" + item.orgnztId + "','" + item.orgnztNm + "')");
			let emptyImg = $("<img/>").attr("src","/images/empty-folder.png");
			let addImg = $("<img/>").attr("src","/images/add-folder.png").addClass("action_folder");
			if(index == $(list).length - 1){
				$(treeBox).append($("<img/>").attr("src","/images/line2.png").addClass("tree_line"));
				lineList.push(0);
			}else{
				$(treeBox).append($("<img/>").attr("src","/images/line1.png").addClass("tree_line"));
				lineList.push(1);
			}
			let newLlist = lineList.join('');
			console.log(newLlist);
			if(item.lowCnt == 0){
				$(treeBox).append(emptyImg,treeP);
			}else{
				(addImg).attr("onclick","AddTreeBox(this,'" + item.orgnztId + "','" + newLlist + "')");
				$(treeBox).append(addImg,treeP);
			}
			$(treeList).append(treeBox);
		})
		$(obj).closest(".tree_box").append(treeList);
		$(obj).attr("src","/images/delete-folder.png").attr("onclick","DelTreeBox(this,'" + Id + "','" + lList +  "')");
	}else{
		$(obj).attr("src","/images/empty-folder.png").attr("onclick","");
	}

}


// 값 보내기
function return_val(Id, Nm){
	var val   = new Object();
	val.Id  = Id;
	val.Nm  = Nm;
	parent.parent.returnOrg(val);
}

// 초기화
function reset_val(){
	var val   = new Object();
	val.Id  = "";
	val.Nm  = "";
	parent.parent.returnOrg(val);
}
// 팝업창 닫기
function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}

</script>

</head>

<body>
<!-- 자바스크립트 경고 태그  -->
	<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부
		기능을 사용하실 수 없습니다.</noscript>

	<form name="listForm" id="listForm"
		action="<c:url value='/uss/umt/user/TotalSearchUserList.do'/>"
		method="post">
	
	<!-- 프로젝트 찾기 팝업 -->
    <div class="popup POP_POST_SEARCH">
        <div class="pop_inner">
            <div class="pop_header">
                <h1>부서</h1>
                <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
            </div>
			
            <div class="pop_container">
            	<div class="btn_box">
            		<a href="#LINK" style="margin-left:8px;" class="item btn btn_blue_46" onclick="reset_val(); return false;">
		                   	<spring:message code="button.reset" /></a>
		        </div>
            	<!-- Tree -->
                <div class="tree_ui tree-ui">
	                <div class="tree_list">
	                	<div class="tree_box">
                			<img class="action_folder" src="/images/delete-folder.png" onclick="DelTreeBox(this,'${resultList[0].orgnztId}','')" >
                			<p onclick="return_val('${resultList[0].orgnztId}', '${resultList[0].orgnztNm}')"><c:out value="${resultList[0].orgnztNm}" /></p>
                			<div class="tree_list">
		                		<c:forEach var="org" items="${resultList}" varStatus="status" >
			                	<div class="tree_box">
			                		<c:choose>
			                			<c:when test="${status.last}">
			                				<img class="tree_line" src="/images/line2.png">
			                			</c:when>
			                			<c:when test="${!status.first}">
			                				<img class="tree_line" src="/images/line1.png">
			                			</c:when>
			                		</c:choose>
			                		<c:choose>
			                			<c:when test="${!status.first && org.lowCnt == 0}">
			                				<img src="/images/empty-folder.png">
			                			</c:when>
			                			<c:when test="${status.last}">
			                				<img class="action_folder" src="/images/add-folder.png" onclick="AddTreeBox(this,'${org.orgnztId}','0')" >
			                			</c:when>
			                			<c:when test="${!status.first}">
			                				<img class="action_folder" src="/images/add-folder.png" onclick="AddTreeBox(this,'${org.orgnztId}','1')" >
			                			</c:when>
			                		</c:choose>
		                			<c:if test="${!status.first }">
			                			<p onclick="return_val('${org.orgnztId}', '${org.orgnztNm}')"><c:out value="${org.orgnztNm}" /></p>
			                		</c:if>
			                	</div>
			                	</c:forEach>
		                	</div>
		                </div>
	            	</div>
                </div>
                <!--// Tree -->
            </div>
        </div>
    </div>
   
    </form>
    
</body>
</html>