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
<body>
<jsp:include page="../main/header.jsp"/>
	<div class="introduce">
		<h3>INFORMATION</h3>
		<!-- 
		<c:forEach items="${information }" var="info">
			<img class="int01" src="${path }/resources/img/profile.png"/>
			<section class="intro012">
				<p class="intname"> <c:out value="${info.user_nm }"/> </p>
				<p>GIT : <c:out value="${info.url }"/></p>
				<p>Mail : <c:out value="${info.user_mail }"/></p>
				<p>Mail : <c:out value="${info.user_mail }"/></p>
				<p>Mail : <c:out value="${info.user_mail }"/></p>
			</section>
			<img class="int02" src="${path }/resources/img/profile.png"/>
			<section class="intro022">
				<p class="intname"> <c:out value="${info.user_nm }"/></p>
				GIT : <c:out value="${info.url }"/><br/>
				Mail : <c:out value="${info.user_mail }"/><br/>
			</section>
			</c:forEach>
		 -->
			<img class="int01" src="${path }/resources/img/profile.png"/>
			<section class="intro012">
				<p class="intname"> 박시우</p>
				<p>GIT : <a href="https://github.com/PARKSIU823/MYPF"> MYPF GIT</a></p>
				<p>Mail : parksiu823@gmail.com</p>
				<p class="intname">하고 싶은 말</p>
				<p>어쩌구 저쩌구</p>
			</section>
			<img class="int02" src="${path }/resources/img/profile.png"/>
			<section class="intro022">
				<p class="intname"> 차은주</p>
				<p>GIT : <c:out value="${info.url }"/></p>
				<p>Mail : <c:out value="${info.user_mail }"/></p>
				<p>Mail : <c:out value="${info.user_mail }"/></p>
				<p>Mail : <c:out value="${info.user_mail }"/></p>
			</section>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>