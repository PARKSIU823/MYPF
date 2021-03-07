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

<div class="regist">
		<h3>LOGIN</h3>
		<form action="/user/login.do" method="post">
			<table class="regform">
			  <tr>
			  	<td class="title">아이디</td>
			  	<td><input type="text" class="infield" name="user_id" id="user_id"/></td>
			  </tr>
			  <tr>
			  	<td class="title">비밀번호</td>
			  	<td colspan="2"><input type="password" class="infield" name="user_pw" id="user_pw"/></td>
			  </tr>
			  <tr>
			  	<td colspan="3" class="bbtpos2">
			  		<button type="reset" class="bbt">취소</button>
			  		<button type="submit" class="bbt">로그인</button>
			  	</td>
			  </tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
		
		//
		$(document).ready(function() {
			var msgReg = '<c:out value="${msg_register}"/>"';
			if(msgReg === '') {return;}
			if(mgsReg != null) {alert (msgReg.user_nm+"님 회원 가입 완료");}
			
		});
	</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>