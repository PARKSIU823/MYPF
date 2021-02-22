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
	<div class="regist">
		<h3>REGISTER</h3>
		<form action="/user/register.do" method="post">
			<table class="regform">
<!-- 			  <tr> -->
<!-- 			  	<td class="title">사진</td> -->
<!-- 			  	<td colspan="2"><input type="file" class="infield"/></td> -->
<!-- 			  </tr> -->
			  <tr>
			  	<td class="title">이름</td>
			  	<td colspan="2"><input type="text" class="infield" name="user_nm"/></td>
			  </tr>
			  <tr>
			  	<td class="title">아이디</td>
			  	<td><input type="text" class="infield02" name="user_id"/> <input type="button"  value="중복확인" class="bbt"/></td>
			  </tr>
			  <tr>
			  	<td class="title">비밀번호</td>
			  	<td colspan="2"><input type="text" class="infield" name="user_pw"/></td>
			  </tr>
<!-- 			  <tr> -->
<!-- 			  	<td class="title">비밀번호 확인</td> -->
<!-- 			  	<td colspan="2"><input type="text" class="infield"/></td> -->
<!-- 			  </tr> -->
			  <tr>
			  	<td class="title">이메일</td>
			  	<td>
			  		<input type="text" name="mailBody" class="infield03"/> @
			  		<select class="sOpt" name="mailDomain">
			  			<option>naver.com</option>
			  			<option>gmail.com</option>
			  			<option>daum.net</option>
			  			<option>직접 입력</option>
			  		</select>
			  	</td>
			  </tr>
			  <tr>
			  	<td class="title">주소</td>
			  	<td colspan="2"><input type="text" class="infield" name="user_addr"/></td>
			  </tr>
			  <tr>
			  	<td class="title">연락처</td>
			  	<td colspan="2"><input type="text" class="infield" name="user_tel"/></td>
			  </tr>
			  <tr>
			  	<td colspan="3" class="bbtpos2">
			  		<button type="reset" class="bbt">취소</button>
			  		<button type="submit" class="bbt">가입</button>
			  	</td>
			  </tr>
			</table>
		</form>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>