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
   <style type="text/css">
   	.thumb {width : 75%;}
   	.thumb ul { display:flex; flex-flow: row; justify-content: center; align-items: center;}
   	.thumb ul li {list-style: none; padding: 10px; align-content: center; text-align: center;}
   	.thumb ul li img {width: 200px; height: 200px;}
   	.bigPictureWrapper {position: absolute; display: none; justify-content: center; align-items: center; top: 0%; width: 100%;
   						height: 100%; background-color: gray; z-index: 100; background: rgba(255,255,255,0.5);}
   	.bigPicture{position: relative; display: flex; justify-content: center; align-items: center;}
   	.bigPicture img{width:600px;}
   </style>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<div class="bigPictureWrapper">
	<div class="bigPicture"></div>
</div>
<div class="project">
	<h3>PORTFOLIO</h3>
	<!-- 섬네일 테이블 -->
	<form method="get" action="/portfolio/pf_modify.do">
	<table class="pboard">
		<tr>
			<td rowspan="5" class="thumb"> 
				<ul>
				</ul>
			</td>
			<td class="info title"> 
				글번호 <input type="text" name="prtf_num" value='<c:out value="${pfRead.prtf_num }"/>' readonly="readonly" style="border:none;"/>
			</td>
		</tr>
		<tr>
			<td class="info title">프로젝트명 <c:out value="${pfRead.prtf_title }"/>
			</td>
		</tr>
		<tr>
			<td class="info title"> 개발기간  <c:out value="${pfRead.frm_dt }"/> ~ <c:out value="${pfRead.to_dt }" /></td>
		</tr>
		<tr>
<!-- 			<td class="info title"> 사용 툴 </td> -->
		</tr>
		<tr>
			<td class="info">
<%-- 				 ◀ <c:forEach items="${pfFileList }" var="fList"> <img src="<c:out value='${thumb.file_path }'/>"></c:forEach>▶</td> --%>
<%-- 				 ◀ <img src="${path }/resources/img/pfview.png" style="height: 150px; width: 150px;"> ▶</td> --%>
		</tr>	
	</table>
	<!-- 상세 내용 테이블 -->
	<table class="pboard">
		<tr>
			<td class="underline title"> 프로젝트 내용 </td>
			<td class="underline"><c:out value="${pfRead.prtf_title}"/></td>
		</tr>
		<tr>
			<td class="underline title"> 관련 URL</td>
			<td class="underline"><a href='<c:out value="${pfRead.url}"/>'><c:out value="${pfRead.url}"/></a></td>
		</tr>
		<tr>
			<td class="underline title"> 맡은 역할 </td>
			<td class="underline"><c:out value="${pfRead.position}"/></td>
		</tr>
		<tr>
			<td class="underline title"> 느낀 점 </td>
			<td class="underline"><c:out value="${pfRead.idea}"/></td>
		</tr>
		<tr>
			<td colspan="2" class="bbtpos1">
				<input type="button" class="bbt" value="목록" onclick="location='/portfolio/pf_list.do'"/>
				<input type="submit" class="bbt" value="수정 / 삭제" />
			</td>
		</tr>
	</table>
	</form>
</div>
<script type="text/javascript">
$(document).ready(function(){
	(function() {
		var prtf_num = '<c:out value="${pfRead.prtf_num}"/>';
		$.getJSON("/portfolio/getPfFileList.do",{prtf_num : prtf_num}, function(arr){
			console.log(arr);
			var str ="";
			$(arr).each(function(i, pfFile) {
				var fileCallPath = encodeURIComponent(pfFile.file_path+"\\s_"+pfFile.uuid+"_"+pfFile.file_nm);
				str += "<li data-path='"+pfFile.file_path+"' data-uuid='"+pfFile.uuid+"' data-filename = '"+pfFile.file_nm+"' data-type='"+pfFile.file_type+"' ><div>";
				str += "<img src='/portfolio/pfDisplay.do?file_nm="+fileCallPath+"'>";
				str +="</li>";
			});
			$(".thumb ul").html(str);		
			
			//첨부파일 클릭 시 이벤트 처리
			$(".thumb").on("click","li",function(e){
				console.log("첨부파일 이미지 보기");
				var liObj = $(this);
				var path = encodeURIComponent(lioObj.data("file_path")+"/"+liObj.data("uuid")+"_"+liObj.data("file_nm"));
				showImage(path.replace(new RegExp(/\\/g),"/"));
			});
			//이미지 확대
			function showImage(fileCallPath) {
				alert(fileCallPath);
				$(".bigPictureWrapper").css("display","flex").show();
				$(".bigPicture").html("<img src='/portfolio/pfDisplay.do?file_nm="+fileCallPath+"'>").animate({width:'100%', height:'100%'}, 1000);
			}
			//이미지 창 닫기
			$(".bigPictureWrapper").on("click", function(e) {
				$(".bigPicture").animate({width:'0%', height:'0%'}, 1000);
				setTimeout(function(){
					$('.bigPictureWrapper').hide();
				},1000);
			})
		}); //.getJSON
	})(); //.function
});
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>