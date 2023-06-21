/****************************************************************
 *
 * 파일명 : PhotoMng.js
 * 설  명 : 사진 다중 업로드 & 단건 파일 업로드 JavaScript
 *
 *    수정일      수정자     Version        Function 명
 * ------------    ---------   -------------  ----------------------------
 * 2023.05.12    주소현       1.0             최초생성
 *
 *
 */
let photoFileList = [];
let delPhotoList = "";

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
	}else if(val == 1){
		$(obj).closest(".filebox").append($("<p/>").text("같은 이름을 파일은 동시에 등록할 수 없습니다").addClass("alertV"));
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
	let photobox = $('.photoList').find('.photobox').length
	if (photoFileList.length + fileCnt > 5 || photobox + fileCnt > 5) {
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
		let val = true;
		for (let i = 0; i < photoFileList.length; i++) {
			if (photoFileList[i].name == file.name) {
				val = false;
			}
		}
		if(val == true){
			photoFileList.push(file);
		}else{
			return;
		}
		let delBtn = $("<img/>").attr("src","/images/ico_delete.png").on("click",function(){
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

// 기존파일 삭제
function addDelPhoto(obj,fileId) {
	$(obj).closest(".photobox").remove();
	 if(fileId != null && fileId != ""){
	 	delPhotoList += fileId + "/";
	 }
}

// 파일들을 원하는 input에 담기
function inputFile() {
	const dataTransfer = new DataTransfer();
	photoFileList.forEach(file => {
		dataTransfer.items.add(file);
	});
	$('input[name=photo]')[0].files = dataTransfer.files; 
	photoFileList = [];
}



// 삭제할 파일 목록 input에 담기
function getDelPhotoList() {
	$('#delPhoto').val(delPhotoList);
}

/* ********************************************************
 * 지급확인서 파일명 가져오기
 ******************************************************** */
 function getFileName(obj) {
	 if(obj.files.length>0){
		 $('#fileNm').val(obj.files[0].name);
		 const dataTransfer = new DataTransfer();
		 dataTransfer.items.add(obj.files[0]);
		 $('input[name=file]')[0].files = dataTransfer.files; 
		 if($(obj).next().prop('tagName') != 'IMG'){
			 $(obj).after($("<img/>").attr("src","/images/ico_delete.png").on("click",function(){
				 delFileName();
				}));
		 }
		 $(obj).val('');
	 }
}

/* ********************************************************
 * 지급확인서 파일 지우기
 ******************************************************** */
 function delFileName() {
	 $('#fileNm').val('');
	 $('input[name=file]').val('');
	 $('#fileNm').closest(".filebox").find('img')[0].remove();
}


