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
<header>
	<div class="navi">
		<table>
			<tr>
				<td rowspan="2"><h1>MY PORTFOLIO</h1></td>
				<td>
					<ul>
						<li class="loginfo">로그인</li>
						<li class="loginfo">회원가입</li>
					</ul>
				</td>
			</tr>
			<tr>
				<td>
					<ul>
						<li class="menu"><a href="<c:url value='/index.do'/>">MAIN</a></li>
						<li class="menu"><a href="<c:url value='/user/introduce.do'/>">INFORMATION</a></li>
						<li class="menu"><a href="<c:url value='/portfolio/pf_list.do'/>">PORTFOLIO</a></li>
						<li class="menu"><a href="<c:url value='/tech/tech_list.do'/>">TECHNOLOGY</a></li>
						<li class="menu"><a href="<c:url value='/ask/ask_write.do'/>">INQUERY</a></li>
						<li class="menu"><a href="<c:url value='/user/user_manage.do'/>">MANAGEMENT</a></li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
</header>

</body>
</html>
