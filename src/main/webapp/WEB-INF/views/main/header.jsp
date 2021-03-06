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
						<!-- session의 유저 권한이 A(관리자/admin)가 아닌 경우 문의는 문의하기로 이동 -->
						<c:if test="${user.user_auth ne 'A'.charAt(0)  }">
						<li class="menu"><a href="<c:url value='/ask/ask_write.do'/>">INQUERY</a></li>
						</c:if>
						<!-- session의 유저 권한이 A(관리자/admin)인 경우, 문의는 문의 내역으로 이동. 회원 관리 메뉴 생성 -->
						<c:if test="${user.user_auth eq 'A'.charAt(0) }">
						<li class="menu"><a href="<c:url value='/ask/ask_list.do'/>">INQUERY</a></li>
						<li class="menu"><a href="<c:url value='/user/user_management.do'/>">MANAGEMENT</a></li>
						</c:if>
					</ul>
				</td>
			</tr>
		</table>
	</div>
		<!-- 	modal 추가 -->
	<div class="modal_wrap" class="informModal">
		<div class="modal_header">
			<button type="button" class="modal_close" data-dismiss="modal">&times;</button>
		</div>
		<div class="modal_body">
			처리가 완료되었습니다.
		</div>
		<div class="modal_footer"></div>
	</div>
</header>
