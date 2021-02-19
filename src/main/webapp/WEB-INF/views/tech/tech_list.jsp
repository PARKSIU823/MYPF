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
<style type="text/css">
	li {list-style: none; float: left; padding: 6px;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e){
			
			e.preventDefault();
			
			console.log('click');
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		})
	});
</script>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<div class="tech">
	<h3 style="text-align:center;">기술 게시판</h3>
	<table class="tlist" style="text-align: center">
 		<thead>
 			<th class="underline title01">번호</th>
 			<th class="underline title01">제목</th>
 			<th class="underline title01">이름</th>
 			<th class="underline title01">작성일</th>
 			<th class="underline title01">수정일</th>
 			<th class="underline title01">조회</th>
 		</thead>
 			<c:forEach items="${list }" var="board">
 				<tr>
 					<td class="title02"><c:out value="${board.tech_num}" /></td>
 					<td class="title02" style="text-align: left;">
 						<a href='tech_detail.do?tech_num=<c:out value="${board.tech_num }"/>'>
 						<c:out value="[${board.tech_category }]${board.tech_title}" /></a></td>
 					<td class="title02"><c:out value="${board.user_id}" /></td>
 					<td class="title02"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.ins_dt}" /></td>
 					<td class="title02"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.upt_dt}" /></td>
 					<td class="title02"><c:out value="${board.hit}" /></td>
		 		</tr>
 		</c:forEach>
		 		<tr>
 					<td colspan="6" class="underline"></td>
 				</tr>
 			<tr>
					<td colspan="6">
						<input type="button" class="bbt" value="글작성" style="float: right;" onclick="location.href='tech_write.do'">
					</td>
			</tr>
	</table>
	<form id='actionForm' action="tech_list.do" method='get'>
		<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
		<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
	</form>
	<div class='paging' style="margin: 0 auto; width:70%; border: 3px">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous">
					<a href="${pageMaker.startPage -1}">Previous</a>
				</li>
			</c:if>
			
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
				<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num }">${num }</a></li>
			</c:forEach>
			
			<c:if test="${pageMaker.next }">
				<li class="paginate_button next">
					<a href="${pageMaker.endPage +1 }">Next</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
	
<jsp:include page="../main/footer.jsp"/>
</body>
</html>