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

function MakePhotoList(obj){
	 
}

//이미지목록에서 삭제하면 input file도 삭제
function delfileList(fileName) {
	for (let i = 0; i < photoFileList.length; i++) {
		if (photoFileList[i].name == fileName) {
			photoFileList.splice(i, 1);
		}
	}
	$('#aks-file-upload').find('input#aksfileupload').val("");
}

//img 비교해서 이미 표시된 이미지면 표시안함
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
}

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
}

// 이미지 갯수 확인
function fileCount(inputCount) {
	if ($('input[name=applyFile]').parentsUntil('.form').prev().prop('tagName') == 'P') {
		$('input[name=applyFile]').parentsUntil('.form').prev().remove();
	}
	let check = true;
	if (photoFileList.length + inputCount > 10) {
		$('input[name=applyFile]').parentsUntil('.form').before($('<p/>').text("사진은 최대 10장까지 등록가능합니다").css(
			"margin-left", "20%").css("color", "#f20000"));
		check = false;
	} else if (photoFileList.length + inputCount < 5) {
		$('input[name=applyFile]').parentsUntil('.form').before($('<p/>').text("사진을 최소 5장이상 등록해주세요").css(
			"margin-left", "20%").css("color", "#f20000"));
	}
	return check;
}

// 파일들 원하는 input에 담기
function inputFile() {
	const dataTransfer = new DataTransfer();
	photoFileList.forEach(file => {
		dataTransfer.items.add(file);
	});
	$('input[name=photo]')[0].files = dataTransfer.files; //제거 처리된 FileList를 돌려줌
}
