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
	<h3 style="text-align: center;">문의 게시판 목록</h3>
<!-- 	<h4 style="text-align: center;">문의 게시판 목록</h4> -->
		<section id="askList">
			<table class="inquery" style="text-align: center">
				<tr class="ilist">
					<th class="underline title01" style="width:100px">번호</th>
					<th class="underline title01" style="width:450px">제목</th>
					<th class="underline title01" style="width:200px">이름</th>
					<th class="underline title01" style="width:100px">답변여부</th>		
					<th class="underline title01" style="width:200px">작성일</th>
				</tr>
					<c:forEach items="${list}" var="list">
						<tr>
							<td class="title02"><c:out value="${list.ask_num}"/></td>
							<td class="title02"style="text-align: left;">
								<a href="/ask_detail.do?ask_num=${list.ask_num}">${list.ask_title}</a>
							</td>
							<td class="title02"><c:out value="${list.writer_nm}"/></td>
							<td class="title02"><c:out value="${list.comm_yn}"/></td>
							<td class="title02"><fmt:formatDate value="${list.ins_dt}" pattern="yyyy-MM-dd"/></td>
						</tr>
					</c:forEach>
					<tr>
 					<td colspan="5" class="underline"></td>
 				</tr>
			</table>
					
				</section>
	</div>


<jsp:include page="../main/footer.jsp"/>
</body>
</html>