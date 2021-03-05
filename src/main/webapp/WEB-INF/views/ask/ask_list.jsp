<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>문의 게시판</title>
<link href="${path}/resources/css/style.css" rel="stylesheet" >
<style type="text/css">
	.pagination	li {list-style: none; float: left; padding: 6px; font-family:'Nanum Gothic', sans-serif; font-weight: bold;}
</style>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<div class="inquery">
	<h3>문의 게시판</h3>
			<table class="ilist" style="text-align: center">
				<thead>
					<th class="underline title01" style="width:100px">번호</th>
					<th class="underline title01" style="width:450px">제목</th>
					<th class="underline title01" style="width:200px">이름</th>
					<th class="underline title01" style="width:100px">답변여부</th>		
					<th class="underline title01" style="width:200px">작성일</th>
				</thead>
					<c:forEach items="${list}" var="list">
						<tr>
							<td class="title02"><c:out value="${list.ask_num}"/></td>
							<td class="title02" style="text-align: left;">
								<a href="ask_detail.do?ask_num=${list.ask_num}">${list.ask_title}</a></td>
							<td class="title02"><c:out value="${list.writer_nm}"/></td>
							<td class="title02"><c:out value="${list.comm_yn}"/></td>
							<td class="title02"><fmt:formatDate value="${list.ins_dt}" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
					<tr>
 					<td colspan="5" class="underline"></td>
 				</tr>
			</table>
		<div class="pagination" style="margin: 0 auto; width:70%; border: 3px">
 						 <ul>
    						<c:if test="${pageMaker.prev}">
    							<li><a href="ask_list.do${pageMaker.makeQuery(pageMaker.startPage - 1)}">이전</a></li>
    						</c:if> 
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    							<li><a href="ask_list.do${pageMaker.makeQuery(idx)}">${idx}</a></li>
    						</c:forEach>
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    							<li><a href="ask_list.do${pageMaker.makeQuery(pageMaker.endPage + 1)}">다음</a></li>
    						</c:if> 
  						</ul>
					</div>
	</div>


<jsp:include page="../main/footer.jsp"/>
</body>
</html>