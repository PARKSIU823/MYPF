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
<script>
 function ask() {
 	alert("문의가 접수되었습니다.");
 	}
</script>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<div class="inquery">
			<h3>문의 게시판</h3>
			<section id="askWrite">
				<form method="post" action="send_ask.do">
					<table class="wform">
						<tbody>
							<tr>
								<td class="title">
									<label for="writer_nm">이  름</label><input class="infield" type="text" id="writer_nm" name="writer_nm"/>
								</td>
							</tr>
							<tr>
								<td class="title">
									<label for="writer_mail">이메일</label><input class="infield" type="text" id="writer_mail" name="writer_mail"/>
								</td>
							</tr>	
							<tr>
								<td class="title">
									<label for="ask_title">제  목</label><input class="infield" type="text" id="ask_title" name="ask_title"/>
								</td>
							</tr>	
							<tr>
								<td class="title">
									<label for="ask_con">내 용</label><textarea class="con" id="ask_con" name="ask_con"></textarea>
								</td>
							</tr>
							<tr>
								<td>						
									<input type="submit" class="bbt" value="작성" onclick="ask()"/>
									<input type="button" class="bbt" value="취소" onclick="location.href='ask_write.do'">
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