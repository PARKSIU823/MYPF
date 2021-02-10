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
	</div>
	<div class="project">
		<table class="pfview">
			<tr>
				<c:forEach items="${pfList}" var="list" begin="1" end="3" step="1">
				<td ><a><img src="${path }/resources/img/prthumb.png"/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="4" end="6" step="1">
				<td ><a><img src="${path }/resources/img/prthumb.png"/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="7" end="9" step="1">
				<td ><a><img src="${path }/resources/img/prthumb.png"/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
		</table>
	</div>

<jsp:include page="../main/footer.jsp"/>
</body>
</html>