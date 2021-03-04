<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
<div class="inquery">
		<h3>문의 게시판</h3>
		<section id="askDetail">
				<input type="hidden" id="ask_num" name="ask_num" value="${read.ask_num}" />
					<table class="ask" border=1>
						<tbody>
							<tr>
								<td>
									<label for="writer_nm">이름</label> 
								</td>
								<td>	
									${read.writer_nm }
								</td>
							</tr>
							<tr>
								<td>
									<label for="writer_mail">이메일</label>
								</td>
								<td>	
									${read.writer_mail }
								</td>
							</tr>	
							<tr>
								<td>
									<label for="ask_title">문의 제목</label>
								</td>
								<td>	
									${read.ask_title }
								</td>
							</tr>	
							<tr>
								<td>
									<label for="ask_con">문의 내용</label>
								</td>
								<td>	
									${read.ask_con }
								</td>
							</tr>
						</tbody>
					</table>
					<br>
						<form action="send_answer.do" method="post">
							<table border="1">
								<input type="hidden" id="ask_num" name="ask_num" value="${read.ask_num}" />
									<tr>
										<td>
											<label>보내는 사람</label>
										</td>
										<td>
											<input type="text" name="user_id" value="MYPF 관리자" readonly>
										</td>
									</tr>
									<tr>
										<td>
											<label>받는 사람 email 주소</label>
										</td>
										<td>
											<input type="text" name="writer_mail" value=${read.writer_mail } readonly>
										</td>
									</tr>
										<c:set var="comm_yn" value="${read.comm_yn }" />
											<c:choose>
												<c:when test ="${fn:contains(comm_yn, 'Y')}">
													<tr>
														<td>
															<label>답변 제목</label>
														</td>
														<td>
															${comm.comm_title }
														</td>
													</tr>
													<tr>
														<td>
															<label>답변 내용</label>
														</td>
														<td>
															${comm.comm_con }
														</td>
													</tr>
											</c:when>
											<c:otherwise>
													<tr>
														<td>
															<label>답변 제목</label>
														</td>
														<td>
															<input text="text" name="comm_title">
														</td>
													</tr>
													<tr>
														<td>
															<label>답변 내용</label>
														</td>
														<td>
															<textarea rows="5"  cols="80" name="comm_con"></textarea>
														</td>
													</tr>
											</c:otherwise>
										</c:choose>
									<tr>
										<td colspan="2">
											<input type="submit" class="bbt" value="전송"/>
											<input type="button" class="bbt" value="목록" onclick="location.href='ask_list.do'">
										</td>
									</tr>
								</table>
							</form>	
					</section>
				</div>
	<jsp:include page="../main/footer.jsp"/>
</body>
</html>