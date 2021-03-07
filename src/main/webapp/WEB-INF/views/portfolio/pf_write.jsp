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
<form method="post" action="/portfolio/pf_write.do" enctype="multipart/form-data">
	<div class="project">
		<h3>PROJECT ADD</h3>
		<input type="hidden" name="user_id" value="mypf01"/>
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
<!-- 			<tr> -->
<!-- 				<td class="title">개발 기간</td> -->
<!-- 				<td><input type="date" class="infield" name="frm_dt"/> ~ <input type="date" class="infield" name="to_dt"/></td> -->
<!-- 			</tr> -->
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
				<td><input type="file" class="infield" name="file_nm"  multiple/></td>
			</tr>
			<tr>
				<td colspan="2" class="bbtpos2">
					<button type="submit" class="bbt" id="uploadPf">작성</button>
					<button type="reset" class="bbt">초기화</button>
					<button type="button" class="bbt" onclick="location.href='/portfolio/pf_list.do'">목록</button>
				</td>
			</tr>
		</table>
	</div>
	
	<!-- 파일 업로드시 섬네일 출력 -->
	<div class="pf_thumb">
		<ul>
		</ul>
	</div>
	
</form>
<script>
$(document).ready(function(e){
	
	var formObj = $("form[role='form']");

	//파일 업로드 처리
	//이미지 파일만 업로드
	var regex = new RegExp("/\.(jpg|gif|tif|bmp|png)$/i");
	//파일 최대 크기5MB;
	var maxSize = 5242880; 
	
	function checkExtenstion(fileName, fileSize) {
		if(fileSize >= maxSize) {
			alert("파일 크기 초과");
			return false;
		}
		if(regex.test(fileName)) {
			alert("이미지 파일만 업로드 가능합니다.");
			return false;
		}
		return true;
	}

	$("#uploadPf").on("click", function(e){
		var formData = new FormData();
		var inputFile = $("input[name='file_nm']");
		var files = inputFile[0].files;
		console.log(files);
		
		for(var i = 0; i <files.length; i++) {{
			if(!checkExtenstion(files[i].name, files[i].size)) {
				return false;
			}
			formData.append("file_nm", files[i]);
		}}
		
	})

	$.ajax({
		url:'/portfolio/pf_write.do';
		,processData : false;
		,contentType : false,data;
		,dataType : 'json'
		,formData, type : 'POST'
		,success : function(result) {
			alert("업로드 성공");
// 			showUploadedFile(result);
// 			$(".project").html(cloneObj.html());
		}
	});
	//$.ajax 종료
	$("buttin[type='submit']").on("click", function(e) {
		e.preventDefault();
		console.log("등록 버튼 클릭");
	});
});
	
	
	
// 	var cloneObj = $(".project").clone();
	
// 	//파일 섬네일 출력
// 	var uploadResult = $(".pf_thumb ul");
// 		function showUploadedFile(uploadResultArr) {
// 			var str ="";
// 			$(uploadResultArr).each(function(i, obj) {
// 				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.file_nm);
// 				str += "<li><img src='/pfDisplay.do?file_nm="+fileCallPath"'><li>";
// 			});
// 			uploadResult.append(str);
// 		}
	
// });
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>