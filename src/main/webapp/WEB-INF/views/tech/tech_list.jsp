<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <title>기술 게시판 목록</title>
   <link href="${path}/resources/css/style.css" rel="stylesheet" >
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<div class="tech">
	<header>
		<h4 style="text-align: center;">기술 게시판</h4>
	</header>
		<table border=1>
	 		<thead>
	 			<th>번호</th>
	 			<th>제목</th>
	 			<th>이름</th>
	 			<th>작성일</th>
	 			<th>수정일</th>
	 			<th>조회</th>
	 		</thead>
	 	
	 			<c:forEach items="${list }" var="board">
	 				<tr>
	 					<td><c:out value="${board.tech_num}" /></td>
	 					<td><c:out value="[${board.tech_category }]${board.tech_title}" /></td>
	 					<td><c:out value="${board.user_id}" /></td>
	 					<td><fmt:formatDate pattern="yyyy-MM-dd"
	 					value="${board.ins_dt}" /></td>
	 					<td><fmt:formatDate pattern="yyyy-MM-dd"
	 					value="${board.upt_dt}" /></td>
	 					<td><c:out value="${board.hit}" /></td>
			 		</tr>
	 		</c:forEach>
	 			<tr>
						<td colspan="6">
							<input type="button" value="글작성" style="float: right;" onclick="location.href='tech_write.do'">
						</td>
				</tr>
		</table>
	</div>
	
<jsp:include page="../main/footer.jsp"/>
</body>
</html>