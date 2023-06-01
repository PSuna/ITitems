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

/*let type = "input,select";

function pushVal(frm) {
	let valList = [];
	$("#"+frm).find(type).each(function(index, item){
		let name = $(item).attr("name");
		let val = $(item).val();
		valList[name] = val;
	})
	window.localStorage.setItem(frm,JSON.stringify(valList));
}

function pullVal(frm) {
	let valList = localStorage.getItem(frm);
	console.log(valList);
	if(valList != null && valList !=""){
		valList = JSON.parse(valList);
		$("#"+frm).find(type).each(function(index, item){
			let name = $(item).attr("name");
			$(item).val(valList[name]);
		})		
	}
}*/

