<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
   <title>기술 게시판</title>
   <link href="${path}/resources/css/style.css" rel="stylesheet" >
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<br>
<br>
<div id="tech">
	<h4 style="text-align: center;">기술 게시판</h4>
	<section id="techDetail">
		<form action="tech_modify.do" method="post">
			<input type="hidden" name="tech_num" value="${board.tech_num}" />
					<table class="wform">
						<tbody>
							<tr>
								<td class="title">
									<label for="tech_num">번호</label><input type="text" class="infiled" id="tech_num" name="tech_num" value="${board.tech_num}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td class="title">
									<label for="user_id">이름</label><input type="text" class="infiled" id="user_id" name="user_id" value="${board.user_id}" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td class="title">
									<label for="upt_dt">수정일</label>
									<input name="upt_dt" value='<fmt:formatDate pattern = 'yyyy/MM/dd' value = "${board.
									upt_dt}" />' readonly="readonly">						
								</td>
							</tr>
							<tr>
								<td class="title">
									<label for="tech_category">카테고리</label>
										<select name="tech_category" class="sOpt">
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
								<td class="title">
									<label for="tech_title">제목</label><input type="text" class="infiled" id="tech_title" name="tech_title" value="${board.tech_title}"/>
								</td>
							</tr>	
							<tr>
								<td class="title">
									<label for="tech_con">내용</label><textarea id="tech_con" class="con" name="tech_con"><c:out value="${board.tech_con}" /></textarea>
								</td>
							</tr>	
						</tbody>			
					</table>
						<div>
							<button type="submit" data-oper='tech_modify.do' class="btn btn-default">수정</button>
							<button type="submit" data-oper='tech_del.do' class="btn btn-danger">삭제</button>
							<button type="submit" data-oper='tech_list.do' class="btn btn-info">목록</button>
						</div>
				</form>
		</section>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>