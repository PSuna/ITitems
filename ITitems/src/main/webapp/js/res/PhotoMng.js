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
let attachfileList = [];
let delfileList = "";

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
		$(obj).closest(".filebox").append($("<p/>").text("등록하는 파일이 5개를 초과할 수 없습니다").addClass("alertV"));
  	    $(obj).val("");
	}else if(val == -1){
		$(obj).closest(".filebox").append($("<p/>").text("같은 이름의 파일은 동시에 등록할 수 없습니다").addClass("alertV"));
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
	let cnt = 0;
	for (var i = 0; i < fileList.length; i++) {
		let file = fileList[i];
		let fileUrl = URL.createObjectURL(file);
		let val = true;
		for (let i = 0; i < photoFileList.length; i++) {
			if (photoFileList[i].name == file.name) {
				cnt ++;
				val = false;
			}
		}
		if(val == true){
			photoFileList.push(file);
			let delBtn = $("<img/>").attr("src","/images/res/ico_delete.png").on("click",function(){
				delPhoto(this,file);
			});
			let boxBtn =$("<div/>").addClass("boxBtn").append(delBtn);
			let boxImg = $("<div/>").addClass("boxImg").append($("<img/>").attr("src",fileUrl));
			$(".photoList").append($("<div/>").addClass("photobox").append(boxBtn,boxImg));
		}
	}
	$(obj).val('');
	if(cnt > 0){
		alertPhoto(obj, -1);
	}
}

//이미지 삭제
function delPhoto(obj,file) {
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
function inputPhoto() {
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

// 지급확인서 없음
function emptyFile(obj,fileId){
	delAlert(obj);
	$('.fileList').find('.namebox').each(function(index, item){
		$(item).remove();
	})
	if($(obj).is(':checked')){
		let NmInput = $("<input/>").attr("type","text").attr("id","fileNm").attr("readonly","readonly").val("파일 없음");
	let filebox = $("<div/>").addClass("namebox").append(NmInput);
	$(".fileList").append(filebox);
	}
	if(fileId != null && fileId != ""){
		addDelFile(fileId);
	}
}

/* ********************************************************
 * 지급확인서 파일명 가져오기
 ******************************************************** */
 function getFileName(obj,fileCnt) {
	delAlert(obj);
	$('#fileCh').prop('checked',false);
	if(fileCnt != -1){
		if(!checkFileCnt(obj,fileCnt)){
			alertPhoto(obj, 1);
			return;
		}else{
			addNameBox(obj,fileCnt);
		}
	}else{
		addNameBox(obj,fileCnt);
	}
	
	
}

// 파일 이름출력
function addNameBox(obj,fileCnt){
	let fileList = obj.files;
	let cnt = 0;
	 if(fileList.length>0){
		if(fileCnt == -1){
			attachfileList = [];
			$('.fileList').find('.namebox').each(function(index, item){
				$(item).remove();
			})
		}
		for (var i = 0; i < fileList.length; i++) {
			let file = fileList[i];
			let val = true;
			for (let i = 0; i < attachfileList.length; i++) {
				if (attachfileList[i].name == file.name) {
					cnt ++;
					val = false;
				}
			}
			if(val == true){
				attachfileList.push(file);
				let delBtn =  $("<img/>").attr("src","/images/res/ico_delete.png").on("click",function(){
					 delfile(this,file);
				});
				let NmInput = $("<input/>").attr("type","text").attr("id","fileNm").attr("readonly","readonly").val(file.name);
				let filebox = $("<div/>").addClass("namebox").append(delBtn,NmInput);
				$(".fileList").append(filebox);
			}
		}
		$(obj).val('');
		if(cnt > 0){
			alertPhoto(obj, -1);
		}
	 }
}

// 파일 갯수 체크
function checkFileCnt(obj,cnt) {
	let fileCnt = obj.files.length;
	let namebox = $('.fileList').find('.namebox').length
	if (photoFileList.length + fileCnt > cnt || namebox + fileCnt > cnt) {
		return false;
	} else {
		return true;
	}
}


//파일 삭제
function delfile(obj,file) {
	$(obj).closest(".namebox").remove();
	for (let i = 0; i < attachfileList.length; i++) {
		if (attachfileList[i].name == file.name) {
			attachfileList.splice(i, 1);
		}
	}
}


// 파일들을 원하는 input에 담기
function inputFile() {
	const dataTransfer = new DataTransfer();
	attachfileList.forEach(file => {
		dataTransfer.items.add(file);
	});
	$('input[name=file]')[0].files = dataTransfer.files; 
	attachfileList = [];
}

/* ********************************************************
 * 지급확인서 파일 지우기
 ******************************************************** */
 function delFileName(fileId) {
	 $('#fileNm').val('');
	 $('input[name=file]').val('');
	 $('#fileNm').closest(".namebox").remove();
	if(fileId != null && fileId != ""){
		addDelFile(fileId);
	}
}


