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
<div>
	<table>
		<tr>
			<c:forEach items="techList" var="techList">
			
			<td></td>
			</c:forEach>
		</tr>
	</table>
	<table>
		<tr>
		</tr>
	</table>
</div>

<jsp:include page="../main/footer.jsp"/>
</body>
</html>