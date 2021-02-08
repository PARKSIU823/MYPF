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
			<header>
				<h4 style="text-align: center;">기술 게시판</h4>
			</header>
				<section id="techWrite">
					<form method="post" action="tech_write.do">
						<table class="tech" border=1>
							<tbody class="wform">
								<tr>
									<td>
										<label for="user_id">이름</label><input class="title" type="text" name="user_id"/>
									</td>
								</tr>
								<tr>
									<td>
									<label for="tech_category">카테고리</label>
										<select name="tech_category">
											<optgroup label="카테고리 선택">
												<option value="Java">Java</option>
												<option value="JavaScript">JavaScript</option>
												<option value="Jsp">Jsp</option>
												<option value="Spring">Spring</option>
												<option value="기타">기타</option>
											</optgroup>
										</select>
									</td>
								</tr>
								<tr>
									<td>
										<label for="tech_title">제목</label><input class="title" type="text" name="tech_title"/>
									</td>
								</tr>	
								<tr>
									<td>
										<label for="tech_con">내용</label><textarea class="con" name="tech_con"></textarea>
									</td>
								</tr>
								<tr>
									<td>
										<label for="File">파일</label><input class="con" type="file" name="file"></textarea>
									</td>
								</tr>
								<tr>
									<td>						
										<button type="submit">작성</button>
										<input type="button" value="취소" onclick="location.href='tech_list.do'">
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