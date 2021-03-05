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
					<table class="ilist">
<!-- 					<table class="ask" border=1> -->
						<tbody>
							<colgroup>
								<col width="20%"/>
								<col width="auto"/>
							</colgroup>
							<tr>
								<td class="underline">
									<label for="writer_nm" class="title01">이름</label> 
								</td>
								<td class="underline">	
									${read.writer_nm }
								</td>
							</tr>
							<tr>
								<td class="underline">
									<label for="writer_mail" class="title01">이메일</label>
								</td>
								<td class="underline">	
									${read.writer_mail }
								</td>
							</tr>	
							<tr>
								<td class="underline">
									<label for="ask_title" class="title01">문의 제목</label>
								</td>
								<td class="underline">	
									${read.ask_title }
								</td>
							</tr>	
							<tr>
								<td class="underline">
									<label for="ask_con" class="title01">문의 내용</label>
								</td>
								<td class="underline">	
									${read.ask_con }
								</td>
							</tr>
						</tbody>
					</table>
					<br>
						<form action="send_answer.do" method="post">
							<h3>문의 답변</h3>
							<table class="wform">
									<tr>
										<td>
										<input type="hidden" id="ask_num" name="ask_num" value="${read.ask_num}"/>
											<label class="title">보내는 사람</label>
										</td>
										<td>
											<input type="text" class="infield" name="user_id" value="MYPF 관리자" readonly>
										</td>
									</tr>
									<tr>
										<td>
											<label class="title">받는 사람 email 주소</label>
										</td>
										<td>
											<input type="text" class="infield" name="writer_mail" value=${read.writer_mail } readonly>
										</td>
									</tr>
										<c:set var="comm_yn" value="${read.comm_yn }" />
											<c:choose>
												<c:when test ="${fn:contains(comm_yn, 'Y')}">
													<tr>
														<td>
															<label class="title">답변 제목</label>
														</td>
														<td class="infield">
															${comm.comm_title }
														</td>
													</tr>
													<tr>
														<td>
															<label class="title">답변 내용</label>
														</td>
														<td  class="infield">
															${comm.comm_con }
														</td>
													</tr>
											</c:when>
											<c:otherwise>
													<tr>
														<td>
															<label class="title">답변 제목</label>
														</td>
														<td>
															<input text="text" name="comm_title" class="infield">
														</td>
													</tr>
													<tr>
														<td>
															<label class="title">답변 내용</label>
														</td>
														<td>
															<textarea rows="5" class="infield" cols="80" name="comm_con" style="resize: none;"></textarea>
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