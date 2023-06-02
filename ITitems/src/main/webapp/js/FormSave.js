/****************************************************************
 *
 * 파일명 : FormSave.js
 * 설  명 : 임시저장(로컬스토리지) JavaScript
 *
 *    수정일      수정자     Version        Function 명
 * ------------    ---------   -------------  ----------------------------
 * 2023.05.12    주소현       1.0             최초생성
 *
 *
 */

let type = "input,select";

function pushVal(frm, id) {
	let setName = id + "_" + frm;
	let valList = {};
	$("#"+frm).find(type).each(function(index, item){
		let name = $(item).attr("name");
		let val = $(item).val();
		if(val != null && val != ""){
			valList[name] = val;			
		}
	})
	window.localStorage.setItem(setName,JSON.stringify(valList));
}

function pullVal(frm, id) {
	let setName = id + "_" + frm;
	let valList = localStorage.getItem(setName);
	if(valList != null && valList !=""){
		valList = JSON.parse(valList);
		$("#"+frm).find(type).each(function(index, item){
			let name = $(item).attr("name");
			let val = valList[name];
			if(val != null && val != ""){
				$(item).val(val);
			}
		})
		getMCatList(valList['middleCategory']);
	}
}

function removeVal(frm, id){
	let setName = id + "_" + frm;
	window.localStorage.removeItem(setName);
}

