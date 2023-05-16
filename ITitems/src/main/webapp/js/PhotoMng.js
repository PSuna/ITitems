/****************************************************************
 *
 * 파일명 : PhotoMng.js
 * 설  명 : 사진 다중 업로드 JavaScript
 *
 *    수정일      수정자     Version        Function 명
 * ------------    ---------   -------------  ----------------------------
 * 2023.05.12    주소현       1.0             최초생성
 *
 *
 */
let photoFileList = [];

// 알람 지우기 
function delAlert(obj){
	if($(obj).closest(".filebox").children().last().prop('tagName') == 'P'){
		$(obj).closest(".filebox").children().last().remove();
	}
}

//경고,알람 표시 
function alertPhoto(obj, val){
	if(val == 0){
		$(obj).closest(".filebox").append($("<p/>").text("등록할 수 없는 파일입니다").addClass("alertV"));
  	    $(obj).val("");
	}else if(val == 1){
		$(obj).closest(".filebox").append($("<p/>").text("등록하는 파일이 5장을 초과할 수 없습니다").addClass("alertV"));
  	    $(obj).val("");
	}
}


// 제품사진 확장자 체크
 function checkPhoto(obj){
	delAlert(obj);
	if( $(obj).val() != "" ){
          var ext = $(obj).val().split('.').pop().toLowerCase();
  	  if($.inArray(ext, ['png','jpg','jpeg']) == -1) {
  	     alertPhoto(obj, 0);
  	     return;
 	  }else{
			checkCount(obj);
		}
     }
}

// 이미지 갯수 체크
function checkCount(obj) {
	let fileCnt = obj.files.length;
	if (photoFileList.length + fileCnt > 5) {
		alertPhoto(obj, 1);
	} else {
		MakePhotoList(obj);
	}
}

// 이미지 미리보기 생성
function MakePhotoList(obj){
	 let fileList = obj.files;
	for (var i = 0; i < fileList.length; i++) {
		let file = fileList[i];
		let fileUrl = URL.createObjectURL(file);
		photoFileList.push(file);
		let delBtn = $("<img/>").attr("src","/ebt_webapp/images/ico_delete.png").on("click",function(){
			delfileList(this,file);
		});
		let boxBtn =$("<div/>").addClass("boxBtn").append(delBtn);
		let boxImg = $("<div/>").addClass("boxImg").append($("<img/>").attr("src",fileUrl));
		$(".photoList").append($("<div/>").addClass("photobox").append(boxBtn,boxImg));
	}
	$(obj).val('');
}

//이미지 삭제
function delfileList(obj,file) {
	$(obj).closest(".photobox").remove();
	for (let i = 0; i < photoFileList.length; i++) {
		if (photoFileList[i].name == file.name) {
			photoFileList.splice(i, 1);
		}
	}
}

// 파일들을 원하는 input에 담기
function inputFile() {
	const dataTransfer = new DataTransfer();
	photoFileList.forEach(file => {
		dataTransfer.items.add(file);
	});
	$('input[name=photo]')[0].files = dataTransfer.files; 
}

// 기존 파일 출력
function getPhotoList(PhotoList){
	console.log(PhotoList);
	/*PhotoList.each(file,function(index, file){
		let delBtn = $("<img/>").attr("src","/ebt_webapp/images/ico_delete.png").on("click",function(){
			delPhoto(this);
		});
		let boxBtn =$("<div/>").addClass("boxBtn").append(delBtn);
		let boxImg = $("<div/>").addClass("boxImg").append($("<img/>").attr("src","/uploadFile/"+file.streFileNm));
		$(".photoList").append($("<div/>").addClass("photobox").append(boxBtn,boxImg));
	})*/
}

// 기존파일 삭제
function delPhoto(obj) {
	$(obj).closest(".photobox").remove();
}
/*//img 비교해서 이미 표시된 이미지면 표시안함
function matchfile(fileName) {
	let check = true;
	if (photoFileList.length == 0) {
		listinput(fileName);
		return check;
	} else {
		for (let i = 0; i < photoFileList.length; i++) {
			if (photoFileList[i].name == fileName) {
				check = false;
			}
		}
	}
	if (check) {
		listinput(fileName);
	}
	return check;
}*/

/*
// 중복되지 않는 파일은 저장
function listinput(fileName) {
	let files = $('#aks-file-upload').find('input#aksfileupload')[0].files;
	let fileArray = Array.from(files);
	for (let i = 0; i < fileArray.length; i++) {
		if (fileArray[i].name == fileName) {
			photoFileList.push(fileArray[i]);
		}
	}
	return;
}*/


