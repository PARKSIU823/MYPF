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
.pagination	li {list-style: none; float: left; padding: 6px; font-family:'Nanum Gothic', sans-serif; font-weight: bold;}
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
		
		$(".move").on("click", function(e){
			
			e.preventDefault();
			actionForm.append("<input type='hidden' name='tech_num' value='"+$(this).attr("href")+"'>");
			actionForm.attr("action", "tech_detail.do");
			actionForm.submit();
		})
		
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e){
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요.");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
		})
	});
</script>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<div class="tech">
	<h3><a href="tech_list.do">기술 게시판</a></h3>
	<table class="tlist" style="text-align: center">
 		<tr>
 			<th class="underline title01" style="width:100px">번호</th>
 			<th class="underline title01" style="width:150px">카테고리</th>
 			<th class="underline title01" style="width:450px">제목</th>
 			<th class="underline title01" style="width:150px">이름</th>
 			<th class="underline title01" style="width:200px">작성일</th>
 			<th class="underline title01" style="width:200px">수정일</th>
 			<th class="underline title01" style="width:100px">조회</th>
 		</tr>
 			<c:forEach items="${list }" var="board">
 				<tr>
 					<td class="title02"><c:out value="${board.tech_num}" /></td>
 					<td class="title02"><c:out value="[${board.tech_category }]" /></td>
 					<td class="title02" style="text-align: left;">
 						<a class='move' href='<c:out value="${board.tech_num }"/>'>
						<c:out value="${board.tech_title}" /></a></td>
 					<td class="title02"><c:out value="${board.user_id}" /></td>
 					<td class="title02"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.ins_dt}" /></td>
 					<td class="title02"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.upt_dt}" /></td>
 					<td class="title02"><c:out value="${board.hit}" /></td>
		 		</tr>
 		</c:forEach>
		 		<tr>
 					<td colspan="7" class="underline"></td>
 				</tr>
 			<tr>
					<td colspan="7">
						<input type="button" class="bbt" value="글작성" style="float: right;" onclick="location.href='tech_write.do'">
					</td>
			</tr>
	</table>
	
	<div class='searcht'>
			<form id='searchForm' action='tech_list.do' method='get'>
				<select class='sOpt' name='type'>
					<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected' :'' }"/>>제목</option>
					<option value="U" <c:out value="${pageMaker.cri.type eq 'U'?'selected' :'' }"/>>이름</option>
					<option value="G" <c:out value="${pageMaker.cri.type eq 'G'?'selected' :'' }"/>>카테고리</option>
					<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected' :'' }"/>>내용</option>		
				</select>
				<input class='underline' type='text' placeholder="키워드를 입력하세요." name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>' />
				<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>' />
				<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount }"/>' />
				<button class='bbt'>검색</button>
			</form>
	</div>
	<form id='actionForm' action="tech_list.do" method='get'>
		<input type='hidden' name='pageNum' value = '${pageMaker.cri.pageNum }'>
		<input type='hidden' name='amount' value = '${pageMaker.cri.amount }'>
		<input type='hidden' name='type' value = '<c:out value="${pageMaker.cri.type }"/>'>
		<input type='hidden' name='keyword' value = '<c:out value="${pageMaker.cri.keyword }"/>'>
	</form>
	<div class='paging' style="margin: 0 auto; width:70%; border: 3px">
		<ul class="pagination">
			<c:if test="${pageMaker.prev}">
				<li class="paginate_button previous">
					<a href="${pageMaker.startPage -1}">이전</a>
				</li>
			</c:if>
			
			<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
				<li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num }">${num }</a></li>
			</c:forEach>
			
			<c:if test="${pageMaker.next }">
				<li class="paginate_button next">
					<a href="${pageMaker.endPage +1 }">다음</a>
				</li>
			</c:if>
		</ul>
	</div>
</div>
	
<jsp:include page="../main/footer.jsp"/>
</body>
</html>