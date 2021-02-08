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
<div class="inquery">
		<header>
			<h4 style="text-align: center;">문의 게시판 글 작성</h4>
		</header>
			<section id="askWrite">
				<form method="post" action="send_ask.do">
					<table class="wform" border=1>
						<tbody class="wform">
							<tr>
								<td>
									<label for="writer_nm">이름</label><input class="title" type="text" id="writer_nm" name="writer_nm"/>
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer_mail">이메일</label><input class="title" type="text" id="writer_mail" name="writer_mail"/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="ask_title">제목</label><input class="title" type="text" id="ask_title" name="ask_title"/>
								</td>
							</tr>	
							<tr>
								<td>
									<label for="ask_con">내용</label><textarea class="con" id="ask_con" name="ask_con"></textarea>
								</td>
							</tr>
							<tr>
								<td>						
									<input type="submit" value="작성"/>
									<input type="button" value="취소" onclick="location.href='ask_write.do'">
								</td>
							</tr>			
						</tbody>			
					</table>
				</form>
			</section>
		</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>