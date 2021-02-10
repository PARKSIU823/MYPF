<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <title>문의 게시판</title>
   <link href="${path}/resources/css/style.css" rel="stylesheet" >
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<br>
<br>
<div id="ask">
		<h3 style="text-align: center;">문의 게시판 상세 조회 및 답변</h3>
		<section id="askDetail">
				<input type="hidden" id="ask_num" name="ask_num" value="${read.ask_num}" />
					<table class="ask" border=1>
						<tbody>
							<tr>
								<td>
									<label for="writer_nm">이름</label> ${read.writer_nm }
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer_mail">이메일</label> ${read.writer_mail }
								</td>
							</tr>	
							<tr>
								<td>
									<label for="ask_title">제목</label> ${read.ask_title }
								</td>
							</tr>	
							<tr>
								<td>
									<label for="ask_con">내용</label> ${read.ask_con }
								</td>
							</tr>
						</tbody>
					</table>
					
			</section>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>