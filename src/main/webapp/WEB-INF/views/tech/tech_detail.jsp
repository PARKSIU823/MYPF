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
	<div id="tech">
		<h3 style="text-align: center;">기술 게시판</h3>
<!-- 		<h4 style="text-align: center;">기술 게시판</h4> -->
		<section id="techDetail">
				<input type="hidden" id="techNum" name="tech_num" value="${board.tech_num}" />
					<table class="tech" border=1>
						<tbody>
							<tr>
								<td>
									<label for="user_id">이름</label> ${board.user_id }
								</td>
							</tr>
							<tr>
								<td>
									<label for="tech_title">제목</label> [${board.tech_category }]${board.tech_title }
								</td>
							</tr>	
							<tr>
								<td>
									<label for="tech_con">내용</label> ${board.tech_con }
								</td>
							</tr>
							<tr>
								<td>
									<button data-oper='tech_modify.do' onclick="location.href='tech_modify.do?tech_num=<c:out value="${board.tech_num}"/>'">수정</button>
									<button data-oper='tech_list.do' onclick="location.href='tech_list.do'">목록</button>
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