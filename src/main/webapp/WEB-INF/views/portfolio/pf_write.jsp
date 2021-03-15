<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
   <link href="${path}/resources/css/style.css" rel="stylesheet" >
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<form method="post" action="/portfolio/pf_write.do">
	<div class="project">
		<h3>PROJECT ADD</h3>
		<input type="hidden" name="user_id" value="${user.user_id }"/>
		<!-- 등록 테이블 -->
		<table class="wform">
			<tr>
				<td class="title">카테고리 선택</td>
				<td>
					<select name="category" class="sOpt">
						<option>카테고리</option>
						<option value="siu">시우</option>
						<option value="ej">은주</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="title">프로젝트명</td>
				<td><input type="text" class="infield" name="prtf_title"/></td>
			</tr>
			<tr>
				<td class="title">개발 기간</td>
				<td><input type="date" class="infield" name="frm_dt"/> ~ <input type="date" class="infield" name="to_dt"/></td>
			</tr>
			<tr>
				<td class="title">프로젝트 내용 <br>(최대 2,000자)</td>
				<td><textarea class="con" name="prtf_con"></textarea></td>
			</tr>
			<tr>
				<td class="title">맡은 역할</td>
				<td><input type="text" class="infield" name="position"/></td>
			</tr>
			<tr>
				<td class="title">느낀 점</td>
				<td><textarea class="con" name="idea"></textarea></td>
			</tr>
			<tr>
				<td class="title">관련 URL</td>
				<td><input type="url" class="infield" name="url"/></td>
			</tr>
			<tr>
				<td class="title">첨부파일</td>
				<td><input type="file" class="infield" name="uploadFile"  multiple/></td>
			</tr>
			<tr>
				<td colspan="2" class="bbtpos2">
					<button type="submit" class="bbt" id="uploadPf">등록</button>
					<button type="reset" class="bbt">초기화</button>
					<button type="button" class="bbt" onclick="location.href='/portfolio/pf_list.do'">목록</button>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 파일 업로드시 섬네일 출력 -->
	<div class="uploadResult">
		<ul>
		</ul>
	</div>
	
</form>

<script type="text/javascript">
$(document).ready(function(e){
	var formObj = $("form[role='form']");
	$("button[type='submit']").on("click",function(e){
		e.preventDefault();
		console.log("등록 버튼 클릭");
		var str ="";
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
			console.dir(jobj);
			str += "<input type='hidden' name='pfFileList["+i+"].file_nm' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='pfFileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='pfFileList["+i+"].file_path' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='pfFileList["+i+"].file_type'value='"+jobj.data("type")+"'>";
		});
		
		formObj.append(str).submit();
	});
	
	//파일 크기, 형식 체크
	//이미지 파일만 업로드
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	//파일 최대 크기 5MB
	var maxSize = 5242880;
	function checkExtension(fileName, fileSize) {
		if(fileSize>=maxSize) {
			alert("파일 사이즈 제한 초과");
			return false;
		}
		if(regex.test(fileName)) {
			alert("이미지 파일만 업로드 가능합니다.");
			return false;
		}
		return true;
	}

	//섬네일 처리
	function showUploadResult(uploadResultArr) {
		if(!uploadResultArr || uploadResultArr.length == 0) { return; }
		var uploadUL = $(".uploadResult ul");
		var str ="";
		
		$(uploadResultArr).each(function(i, obj){
			var fileCallPath = encodeURIComponent(obj.file_path+"\\s_"+obj.uuid+"_"+obj.file_nm);
			str += "<li data-path='"+obj.file_path+"'";
			str += "data-uuid='"+obj.uuid+"'data-filename='"+obj.file_nm+"'data-type='"+obj.file_type+"'";
			str += "><div>";
			str += "<span>"+obj.file_nm+"</span>";
			str += "<button type='button' class='bbt02' data-file=\'"+fileCallPath+"\'"
			str += "data-type='image'>X</button><br>";
			str += "<img src='/portfolio/pfDisplay.do?file_nm="+fileCallPath+"'>";
			str += "</div>";
			str + "</li>";
		});
		uploadUL.append(str);
	}
	
	//첨부파일 삭제 처리
	$(".uploadResult").on("click","button",function(e){
		console.log("포트폴리오 첨부 파일 삭제");
		var targetFile = $(this).data("file");
		var type= $(this).data("type");
		var targetLi= $(this).closest("li");
		$.ajax({
			url : 'portfolio/deleteFile.do'
			,data : {fileName : tagetFile, type: type}
			,dataType : 'text'
			,type : 'POST'
			,success : function(result) {
					alert(result);
					targetLi.remove();
			}
		}); //.$.ajax
	})
	
	//파일 입력 변경시 업로드 처리
	$("input[type='file']").change(function(e){
		var formData = new FormData();
		var inputFile = $("input[name='uploadFile']");
		var files = inputFile[0].files;
		for(var i = 0; i< files.length; i++) {
			if(!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			formData.append("uploadFile", files[i]);
		}
		$.ajax({
			url : '/portfolio/file_write.do',
			processData : false,
			contentType : false,
			data : formData,
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				console.log(result);
				showUploadResult(result);
			}
		}); //$.ajax
	});
});
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>