<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>기술 게시판 </title>
<link href="${path}/resources/css/style.css" rel="stylesheet" >
<style>
.uploadResult { width:70%; background-color: gray; }
.uploadResult ul { display:flex; flex-flow: row; justify-content: center; align-items: center; }
.uploadResult ul li { list-style: none; padding: 10px; align-content: center; text-align: center; }
.uploadResult ul li img { width: 100px; }
.uploadResult ul li span { color:white; }
.bigPictureWrapper { position: absolute; display: none; justify-content: center;
					align-items: center; top:0%; width:100%; height:100%; background-color:gray; 
					z-index: 100px; background:rgba(255,255,255,0.5); }
.bigPicture { position: relative; display:flex; justify-content:center; align-items: center; }
.bigPicture img { width:600px; }
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
<script>
	$(document).ready(function(e){
		var formObj = $("form[role='form']");
		$("button[type='submit']").on("click",function(e){
			e.preventDefault();
			console.log("submit clicked");
			var str = "";
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
				console.dir(jobj);
				
				str += "<input type = 'hidden' name = 'fileList["+i+"].file_nm'value='"+jobj.data("filename")+"'>";
				str += "<input type = 'hidden' name = 'fileList["+i+"].uuid'value='"+jobj.data("uuid")+"'>";
				str += "<input type = 'hidden' name = 'fileList["+i+"].file_path'value='"+jobj.data("path")+"'>";
				str += "<input type = 'hidden' name = 'fileList["+i+"].file_type'value='"+jobj.data("type")+"'>";
			});
			formObj.append(str).submit();
		});
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
		function checkExtension(file_nm, fileSize) {
			if(fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			if(regex.test(file_nm)) {
				alert("해당 종류의 파일은 업로드 할 수 없습니다.");
				return false;
			}
			return true;
		}
		function showUploadResult(uploadResultArr) {
			if(!uploadResultArr || uploadResultArr.length == 0) { return; }
			var uploadUL = $(".uploadResult ul");
			var str = "";
			$(uploadResultArr).each(function(i, obj){
				// image type
				if(obj.file_type){
					var fileCallPath = encodeURIComponent(obj.file_path+"/s_"+obj.uuid+"_"+obj.file_nm);
					str += "<li data-path='"+obj.file_path+"'";
					str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.file_nm+"' data-type='"+obj.file_type+"'";
					str += " ><div>";
					str += "<span> "+ obj.file_nm+"</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' "
					str += "data-type='image'>X</button><br>";
					str += "<img src='/tech/display.do?file_nm="+fileCallPath+"'>";
					str += "</div>";
					str +"</li>";
				}else {
					var fileCallPath = encodeURIComponent( obj.file_path+"/"+obj.uuid+"_"+obj.file_nm);
					var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					
					str += "<li ";
					str += "data-path='"+obj.file_path+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.file_nm+"' data-type='"+obj.file_type+"'><div>";
					str += "<span> "+obj.file_nm + "</span>";
					str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file'>X</button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str +"</li>";
				}
			});
			uploadUL.append(str);
		}
		$(".uploadResult").on("click", "button", function(e){
			console.log("delete file");
			
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			
			var targetLi = $(this).closest("li");
			
			$.ajax({
				url : '/tech/deleteFile.do',
				data : {file_nm : targetFile, type : type},
				dataType : 'text',
				type : 'POST',
				success : function(result){
					alert(result);
					targetLi.remove();
				}
			}); //$.ajax
		})
		$("input[type='file']").change(function(e){
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			for(var i = 0; i < files.length; i++) {
			 	if(!checkExtension(files[i].name, files[i].size)) {
					 return false;
				 }	
				formData.append("uploadFile", files[i]);
			}
			$.ajax({
				url : '/tech/uploadAjaxAction.do',
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
</head>
<body>
<jsp:include page="../main/header.jsp"/>
	<div class="tech">
		<h3>기술 게시판</h3>
		<section id="techWrite">
			<form role="form" action="/tech/tech_write.do" method="post">
				<table class="wform">
					<tr>
						<td class="title">
							<label for="user_id">이름</label><input class="infield" type="text" name="user_id"/>
						</td>
					</tr>
					<tr>
						<td class="title">
						<label for="tech_category">카테고리</label>
							<select name="tech_category" class="sOpt">
								<optgroup label="카테고리 선택">
									<option value="Java">Java</option>
									<option value="JavaScript">JavaScript</option>
									<option value="Jsp">Jsp</option>
									<option value="Spring">Spring</option>
									<option value="기타">기타</option>
								</optgroup>
							</select>
						</td>
					</tr>
					<tr>
						<td class="title">
							<label for="tech_title">제목</label><input class="infield" type="text" name="tech_title"/>
						</td>
					</tr>	
					<tr>
						<td class="title">
							<label for="tech_con">내용</label><textarea class="con" name="tech_con"></textarea>
						</td>
					</tr>
					<tr>
						<td class="title">
							<label for="File">파일</label><input class="con" type="file" name="uploadFile" multiple/>
						</td>
					</tr>
					</table>
						<div class='uploadResult'>
							<ul>
						
							</ul>
						</div>					
							<button type="submit" class="bbt">작성</button>
							<input type="button" class="bbt"value="취소" onclick="location.href='tech_list.do'">
			</form>
		</section>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>