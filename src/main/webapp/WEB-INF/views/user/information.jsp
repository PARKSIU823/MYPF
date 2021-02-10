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
	<div class="introduce">
		<img class="int01" src="img/profile/png"/>
		<section class="intro012">
			<p class="intname"> 이름이 나오는 영역 </p>
			가나다라마바사<br/>
			가나다라마바사<br/>
			가나다라마바사<br/>
			가나다라마바사<br/>
			가나다라마바사<br/>
			가나다라마바사<br/>
			가나다라마바사<br/>
			가나다라마바사<br/>
			가나다라마바사<br/>
		</section>
		<img class="int02" src="img/profile.png"/>
		<section class="intro022">
			<p class="intname">이름이 나오는 영역 </p>
			아자차카타파하<br/>
			아자차카타파하<br/>
			아자차카타파하<br/>
			아자차카타파하<br/>
			아자차카타파하<br/>
			아자차카타파하<br/>
			아자차카타파하<br/>
			아자차카타파하<br/>
			아자차카타파하<br/>
		</section>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>