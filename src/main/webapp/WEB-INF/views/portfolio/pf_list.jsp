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
				<td colspan="3"><a href="<c:url value='/portfolio/pf_write.do'/>">글 작성</a>
				</td>
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

<jsp:include page="../main/footer.jsp"/>
</body>
</html>