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
				<td rowspan="2"><h1 class="pagename menu"><a href="<c:url value='/index.do'/>">MY PORTFOLIO</a></h1></td>
				<td>
					<ul>
						<c:if test="${user == null }">
						<li class="menu"><a href="<c:url value='/user/login.do'/>">로그인</a></li>
						<li class="menu"><a href="<c:url value='/user/register.do'/>">회원가입</a></li>
						</c:if>
						<c:if test="${user != null }">
						<li class="menu">${user.user_nm }님 </li>
						<li class="menu"><a href="<c:url value='/user/logout.do'/>">로그아웃</a></li>
						<li class="menu"><a href="<c:url value='/user/modify.do'/>">정보관리</a></li>
						</c:if>
					</ul>
				</td>
			</tr>
			<tr>
				<td>
					<ul>
						<li class="menu"><a href="<c:url value='/index.do'/>">MAIN</a></li>
						<li class="menu"><a href="<c:url value='/user/information.do'/>">INFORMATION</a></li>
						<li class="menu"><a href="<c:url value='/portfolio/pf_list.do'/>">PORTFOLIO</a></li>
						<li class="menu"><a href="<c:url value='/tech/tech_list.do'/>">TECHNOLOGY</a></li>
						<li class="menu"><a href="<c:url value='/ask/ask_write.do'/>">INQUERY</a></li>
						<c:if test="${user.user_auth eq 'A'.charAt(0) }">
						<li class="menu"><a href="<c:url value='/user/user_management.do'/>">MANAGEMENT</a></li>
						</c:if>
					</ul>
				</td>
			</tr>
		</table>
	</div>
</header>
