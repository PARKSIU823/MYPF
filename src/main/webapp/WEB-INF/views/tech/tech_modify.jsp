<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>기술 게시판</title>
<link href="${path}/resources/css/style.css" rel="stylesheet" >
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
.uploadResult { width:80%; background-color: ; }
.uploadResult ul { display:flex; flex-flow: row; justify-content: center; align-items: center; }
.uploadResult ul li { list-style: none; padding: 10px; align-content: center; text-align: center; }
.uploadResult ul li img { width: 100px; }
.bigPictureWrapper { position: absolute; display: none; justify-content: center;
					align-items: center; top:0%; width:100%; height:100%; background-color:gray; 
					z-index: 100px; background:rgba(255,255,255,0.5); }
.bigPicture { position: relative; display:flex; justify-content:center; align-items: center; }
.bigPicture img { width:600px; }
</style>
<script>
$(document).ready(function(){
	(function(){
		var tech_num = '<c:out value="${board.tech_num}"/>'
		$.getJSON("/tech/getFileList.do", {tech_num : tech_num}, function(arr){
			console.log(arr);
			var str = "";
			$(arr).each(function(i, file) {
				//image type
				if(file.file_type){
					var fileCallPath = encodeURIComponent(file.file_path+"/s_"+file.uuid+"_"+file.file_nm);
					str += "<li data-path='"+file.file_path+"' data-uuid='"+file.uuid+"' data-filename = '"+file.file_nm+"' data-type='"+file.file_type+"' ><div>";
					str += "<span> "+ file.file_nm+"</span>";
					str += "<button type='button' class='bbt02' data-file=\'"+fileCallPath+"\' data-type='image' "
					str += ">X</button><br>";
					str += "<img src='/tech/display.do?file_nm="+fileCallPath+"'>";
					str += "</div>";
					str + "</li>";
				} else {
					str += "<li data-path='"+file.file_path+"' data-uuid='"+file.uuid+"' data-filename='"+file.file_nm+"' data-type='"+file.file_type+"' ><div>";
					str += "<span> "+file.file_nm+"</span><br/>";
					str += "<button type='button' class='bbt02' data-file=\'"+fileCallPath+"\' data-type='file' "
					str += ">x</button><br>";
					str += "<img src='/resources/img/attach.png'></a>";
					str += "</div>";
					str +"</li>";
				}
			});
			$(".uploadResult ul").html(str);
		}); // end getjson
	})(); // end function
	$(".uploadResult").on("click", "button", function(e){
		console.log("delete file");
		if(confirm("이 파일을 삭제하시겠습니까? ")) {
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
	});
	// 첨부파일 추가
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
				str += "<button type='button' class='bbt02' data-file=\'"+fileCallPath+"\' "
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
				str += "<button type='button' class='bbt02' data-file=\'"+fileCallPath+"\' data-type='file'>X</button><br>";
				str += "<img src='/resources/img/attach.png'></a>";
				str += "</div>";
				str +"</li>";
			}
		});
		uploadUL.append(str);
	}
	
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
<script>
$(document).ready(function(){

	var formObj = $("form");

	$('button').on("click", function(e){
	
	e.preventDefault();

	var operation = $(this).data("oper");

	console.log(operation);

	if(operation === 'tech_del.do'){
		formObj.attr("action", "tech_del.do");
		
	}else if(operation === 'tech_list.do'){
		//move to list
		formObj.attr("action", "tech_list.do").attr("method","get");
		
		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amount']").clone();
		var keywordTag = $("input[name='keyword']").clone();
		var typeTag = $("input[name='type']").clone();
		
		formObj.empty();
		
		formObj.append(pageNumTag);
		formObj.append(amountTag);
		formObj.append(keywordTag);
		formObj.append(typeTag);
		
	}else if(operation === 'tech_modify.do') {
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
		
		if($("#tech_title").val()=="") {
			alert("제목을 입력하세요.");
			return false;
		}
		if($("#tech_con").val()=="") {
			alert("내용을 입력하세요.");
			return false;
		}
		alert("수정 완료되었습니다.")
		
		formObj.append(str).submit();
	}

	formObj.submit();

	});
});
</script>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<br>
<br>
<div class="tech">
	<h3 style="text-align:center;">기술 게시판</h3>
	<section id="techDetail">
		<form role="form" action="tech_modify.do" method="post">
			<input type='hidden' name="tech_num" value="${board.tech_num}" />
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
			<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
					<table class="wform">
						<tbody>
							<tr>
								<td>
									<label for="tech_num" class="title">번호</label><input type="text" class="infield" id="tech_num" name="tech_num" value="${board.tech_num}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>
									<label for="user_id" class="title">이름</label><input type="text" class="infield" id="user_id" name="user_id" value="${board.user_id}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td>
									<label for="upt_dt" class="title">수정일</label>
									<input name="upt_dt" class="infield" value='<fmt:formatDate pattern = 'yyyy/MM/dd' value = "${board.
									upt_dt}" />' readonly="readonly">						
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
									<label for="tech_title">제목</label><input type="text" class="infield" id="tech_title" name="tech_title" value="${board.tech_title}"/>
								</td>
							</tr>	
							<tr>
								<td class="title">
									<label for="tech_con">내용</label><textarea id="tech_con" class="con" name="tech_con" ><c:out value="${board.tech_con}" /></textarea>
								</td>
							</tr>
							<tr>
								<td class="title">
									<label for="File">파일</label><input class="con" type="file" name="uploadFile" multiple/>
								</td>
							</tr>	
							<tr>
								<td class="infield">
									<!-- 첨부파일 원본 -->
									<div class='bigPictureWrapper'>
										<div class='bigPicture'>
										</div>
									</div>
									<!-- 첨부파일 목록-->
									<div class="row">
										<div class="heading"><label class="title">첨부파일</label></div>
											<div class="body">
												<div class='uploadResult'>
													<ul>
							
													</ul>
												</div>
											</div>	
										</div>
									</td>
								</tr>
						</tbody>			
						</table>
						<div>
							<button type="submit" data-oper='tech_modify.do' class="bbt">수정</button>
							<button type="submit" data-oper='tech_del.do' class="bbt">삭제</button>
							<button type="submit" data-oper='tech_list.do' class="bbt">목록</button>
						</div>
				</form>
		</section>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>