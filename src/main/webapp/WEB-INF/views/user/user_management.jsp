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

<form method="post" action="user/userAuth.do">
<div class="userList">
	<h3>MANAGEMENT</h3>
		<table class="uList">
			<tr>
				<td></td>
				<td class="title underline">회원번호</td>
				<td class="title underline">아이디</td>
				<td class="title underline">이름</td>
				<td class="title underline">이메일</td>
				<td class="title underline">권한</td>
			</tr>
			<c:forEach items="${userList }" var="list">
			<tr>
				<td><input type="checkbox" value="${list.user_count }"></td>
				<td class="underline">${list.user_count }</td>
				<td class="underline"><input type="hidden" name="user_id" value="${list.user_id }"/>${list.user_id }</td>
				<td class="underline">${list.user_nm }</td>
				<td class="underline">${list.user_mail }</td>
				<td class="underline">
					<select name="user_auth" class="sOpt">
						<option>권한</option>
						<option value="A" <c:if test="${list.user_auth eq'A'.charAt(0) }"> selected='selected'</c:if>>관리자</option>
						<option value="U" <c:if test="${list.user_auth eq'U'.charAt(0) }"> selected='selected'</c:if>>일반회원</option>
					</select>
<%-- 				${list.user_auth } --%>
				</td>
			</tr>
			</c:forEach>
			<tr>
				<td colspan="6">
				<button type="submit">권한 수정</button>
				</td>
			</tr>
		</table>
	</div>
</form>

<jsp:include page="../main/footer.jsp"/>
</body>
</html>