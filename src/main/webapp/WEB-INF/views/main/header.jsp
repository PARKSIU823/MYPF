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
						<li class="menu">MAIN</li>
						<li class="menu">INFORMATION</li>
						<li class="menu">PORTFOLIO</li>
						<li class="menu">TECHNOLOGY</li>
						<li class="menu">INQUERY</li>
						<li class="menu">MANAGEMENT</li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
</header>

</body>
</html>