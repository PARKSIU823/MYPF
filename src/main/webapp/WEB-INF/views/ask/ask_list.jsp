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

<div id="inquery">
		<header>
			<h4 style="text-align: center;">문의 목록</h4>
		</header>
				<section id="askList">
					<table class="inquery" style="text-align: center">
						<tr class="ilist">
							<th style="width:100px">번호</th>
							<th style="width:450px">제목</th>
							<th style="width:200px">이름</th>		
							<th style="width:200px">작성일</th>
						</tr>
							<c:forEach items="${list}" var="list">
								<tr style="font-weight:bold; background: rgba(238, 227, 226, 1); font-size: 1.1em;">
									<td><c:out value="${list.ask_num}"/></td>
									<td style="text-align: left;">
										<a href="/ask_detail.do?ask_num=${list.ask_num}">${list.ask_title}</a>
									</td>
									<td><c:out value="${list.writer_nm}"/></td>
									<td><fmt:formatDate value="${list.ins_dt}" pattern="yyyy-MM-dd"/></td>
								</tr>
							</c:forEach>
					</table>
					
				</section>
	</div>


<jsp:include page="../main/footer.jsp"/>
</body>
</html>