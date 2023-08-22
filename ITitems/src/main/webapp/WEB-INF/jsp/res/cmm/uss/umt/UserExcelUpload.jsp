<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
    
    $(document).ready(function() {
      var msg = "${resMap.msg}";
        if(msg != "") alert(msg);
    });
    
    function _onSubmit(){
        
        if($("#file").val() == ""){
            alert("파일을 업로드해주세요.");
            $("#file").focus();
            return false;
        }
        
        if(!confirm(gTxt("confirm.save"))){
            return false;
        }
        
        return true;
    }
    
</script>
<title>Insert title here</title>
</head>
<body>
<div id="contAreaBox">
    <form name="inputForm" method="post" onsubmit="return _onSubmit();" action="${path}/adms/reserve/applicant/create_action.do"   enctype="multipart/form-data" class="form-horizontal">
        <div class="panel">
            <div class="panel-body">
            <h4 class="mt0"><i class="fa fa-cube" aria-hidden="true"></i>신청자 업로드</h4>
                <div class="table-responsive">
                <p> 양식파일을 다운로드 하시고 파일내에 있는 모든 항목들을 채워서 업로드하셔야 정상적으로 등록됩니다.</p>
                <table id="datatable-scroller" class="table table-bordered tbl_Form">
                        <caption>신청자 업로드</caption>
                        <colgroup>
                            <col width="250px" />
                            <col />
                        </colgroup>
                        <tbody>
                            <tr>
                                <th class="active" style="text-align:right"><label class="control-label" for="">파일 업로드</label></th>
                                <td>
                                    <input type="file" name="file" id="file" accept=".xlsx, .xls"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="pull-right">
            <input type="submit" value="엑셀파일 업로드" class="btn btn btn-primary btn-lg" />
            <a href="${path}/document/applicant_excelUpload_form.xlsx" class="btn btn btn-primary btn-lg">양식파일 다운로드</a>
        </div>
    </form>
</div>
</body>
</html>