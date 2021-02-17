<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <link href="${path}/resources/css/style.css" rel="stylesheet" >
   <script src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
	<div class="project">
		<ul>
			<li><a href="#">SIU</a></li>
			<li><a href="#">EJ</a></li>
		</ul>
		<table class="pfview">
			<tr>
<!-- 				<td colspan="3"><button type="button" class="bbt" name="prtfRegBtn">등록</button></td> -->
				<td colspan="3"><a href="<c:url value='/portfolio/pf_write.do'/>"> 글 작성</a></td>
			</tr>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="0" end="2" step="1">
				<td ><a><img src="${path }/resources/img/prthumb.png"/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="3" end="5" step="1">
				<td ><a><img src="${path }/resources/img/prthumb.png"/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="6" end="8" step="1">
				<td ><a><img src="${path }/resources/img/prthumb.png"/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
		</table>
	</div>
	<!-- 	modal 추가 -->
	<div class="modal_wrap" class="informModal">
		<div class="modal_header">
			<button type="button" class="modal_close" data-dismiss="modal">&times;</button>
		</div>
		<div class="modal_body">
			처리가 완료되었습니다.
		</div>
		<div class="modal_footer"></div>
	</div>
	
<script type="text/javascript">
// modal
$(document).ready(function(){
	var result = '<c:out value="${result}"/>';
	
	// 	modal 
	checkModal(result);
	function checkModal(result){
		//result 값이 null일 경우 return;
		if(result==='') {return;}
		//result 값(등록한 글 번호)이 0 이상일 경우
		if(parseInt(result)>0){
			$(".modal_body").html(parseInt(result) + "번 글이 등록되었습니다.");	
		}
		$(".informModal").modal("show");
	}
	
	// 등록 버튼 클릭시 등록창 이동
	$("#prtfRegBtn").on("click",function(){
		self.location="/portfolio/pf_write.do";
	});
});
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>