<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
	<script src="https://code.jquery.com/jquery-3.5.1.js"
	  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	  crossorigin="anonymous"></script>
   <link href="${path}/resources/css/style.css" rel="stylesheet" >
   <style type="text/css">
   	.uploadResult ul { display:flex; flex-flow: row; justify-content: center; align-items: center;}
   	.uploadResult ul li {list-style: none; padding: 10px; align-content: center; text-align: center;}
   	.uploadResult ul li img {width: 200px; height: 200px;}
   	.bigPictureWrapper {position: absolute; display: none; justify-content: center; align-items: center; top: 0%; width: 100%;
   						height: 100%; background-color: gray; z-index: 100; background: rgba(255,255,255,0.5);}
   	.bigPicture{position: relative; display: flex; justify-content: center; align-items: center;}
   	.bigPicture img{width:600px;}
   </style>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<form method="post" action="/portfolio/pf_modify.do">
	<div class="project">
		<h3>PROJECT MODIFY</h3>
		<input type="hidden" name="user_id" value="mypf01"/>
		<!-- 등록 테이블 -->
		<table class="wform">
			<tr>
				<td class="title">글 번호</td>
				<td>
					<input type="text" name="prtf_num" value='<c:out value="${pfModify.prtf_num }"/>' readonly="readonly" style="border:none;"/>
				</td>
			</tr>
			<tr>
				<td class="title">카테고리 선택</td>
				<td>
					<select name="category" class="sOpt">
						<option>카테고리</option>
						<option value="siu" <c:if test="${pfModify.category=='siu'}"> selected='selected'</c:if>>시우</option>
						<option value="ej" <c:if test="${pfModify.category=='ej'}"> selected='selected'</c:if>>은주</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="title">프로젝트명</td>
				<td><input type="text" class="infield" name="prtf_title" value="<c:out value='${pfModify.prtf_title }'/>"/></td>
			</tr>
			<tr>
				<td class="title">개발 기간</td>
				<td><input type="date" class="infield" name="frm_dt"/> ~ <input type="date" class="infield" name="to_dt"/></td>
			</tr>
			<tr>
				<td class="title">프로젝트 내용 <br>(최대 2,000자)</td>
				<td><textarea class="con" name="prtf_con"><c:out value="${pfModify.prtf_con }"/></textarea></td>
			</tr>
			<tr>
				<td class="title">맡은 역할</td>
				<td><input type="text" class="infield" name="position" value="<c:out value='${pfModify.position}'/>"/></td>
			</tr>
			<tr>
				<td class="title">느낀 점</td>
				<td><textarea class="con" name="idea"><c:out value="${pfModify.idea }"/></textarea></td>
			</tr>
			<tr>
				<td class="title">관련 URL</td>
				<td><input type="url" class="infield" name="url" value="<c:out value='${pfModify.url}'/>"/></td>
			</tr>
			<tr>
				<td class="title">첨부파일</td>
				<td><input type="file" class="infield" name="uploadFile" multiple="multiple"/></td>
			</tr>
			<tr class="uploadResult">
				<td colspan="2">
					<ul>
					</ul>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="bbtpos2">
					<button type="submit" data-oper="modify" class="bbt">수정</button>
					<button type="submit" data-oper="delete" class="bbt">삭제</button>
					<button type="submit" data-oper="list" class="bbt">목록</button>
				</td>
			</tr>
		</table>
	</div>
	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>
</form>
<script type="text/javascript">
$(document).ready(function(){
	(function() {
		var prtf_num = '<c:out value="${pfModify.prtf_num}"/>';
		$.getJSON("/portfolio/getPfFileList.do",{prtf_num : prtf_num}, function(arr){
			console.log(arr);
			var str ="";
			$(arr).each(function(i, pfFile) {
				var fileCallPath = encodeURIComponent(pfFile.file_path+"/s_"+pfFile.uuid+"_"+pfFile.file_nm);
				str += "<li data-path='"+pfFile.file_path+"' data-uuid='"+pfFile.uuid+"' data-filename='"+pfFile.file_nm+"'data-type='"+pfFile.file_type+"'><div>";
				str += "<span>"+pfFile.file_nm+"</span>";
				str += "<button type='button' class='bbt02' data-file=\'"+fileCallPath+"\' data-type='image'"
				str += ">X</button><br>";
				str +="<img src='/portfolio/pfDisplay.do?file_nm="+fileCallPath+"'>";
				str +="</div>";
				str +"</li>";
			});
			$(".uploadReault ul").html(str);
		}); //.getJSON
	})(); //.function

	//첨부 파일 삭제
	$(".uploadResult").on("click","button",function(e){
		console.log("포트폴리오 첨부파일 삭제");
		if(confirm("이 파일을 삭제하시겠습니까?")) {
			var targetLi = $(this).closest("li");
			targetLi.remove();
		}
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
			var fileCallPath = encodeURIComponent(obj.file_path+"/s_"+obj.uuid+"_"+obj.file_nm);
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
<script>
//파일 수정
$(document).ready(function(){
	var formObj = $("form");
	$('button').on("click",function(e){
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		if(operation === 'remove') {
			formObj.attr("action","/portfolio/pf_delete.do");
		}else if(operation ==='list'){
			formObj.attr("action","/portfolio/pf_list.do");
		}else if(operation ==='modify') {
			console.log("수정 클릭");
			var str ="";
			$(".uploadResult ul li").each(function(i, obj){
				var jobj = $(obj);
				console.dir(jobj);
				str += "<input type='hidden' name='pfFileList["+i+"].file_nm' value='"+jobj.data("filename")+"'>";
				str += "<input type='hidden' name='pfFileList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
				str += "<input type='hidden' name='pfFileList["+i+"].file_path' value='"+jobj.data("path")+"'>";
				str += "<input type='hidden' name='pfFileList["+i+"].fileType' value='"+jobj.data("type")+"'>";
			});
			
			formObj.append(str).submit();
		}
		formObj.submit();
	});
})
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>