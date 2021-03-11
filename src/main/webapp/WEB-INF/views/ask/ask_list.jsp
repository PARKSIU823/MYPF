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
<style type="text/css">
	.pagination	li {list-style: none; float: left; padding: 6px; font-family:'Nanum Gothic', sans-serif; font-weight: bold;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
	$(function(){
		$("#searchBtn").click(function(){
			self.location = "ask_list.do" 
				+ '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val()
				+ "&keyword=" + encodeURIComponent($('#keywordInput').val());
		});
	});
</script>
</head>
<body>
<fmt:formatDate var="cdate" value="${cdate }" pattern="yyyy-MM-dd"/>
<jsp:include page="../main/header.jsp"/>
<div class="inquery">
	<h3><a href="ask_list.do">문의 게시판</a></h3>
		<form role="form" method="get">
			<table class="ilist" style="text-align: center">
				<thead>
					<th class="underline title01" style="width:100px">번호</th>
					<th class="underline title01" style="width:450px">문의 제목</th>
					<th class="underline title01" style="width:200px">이름</th>
					<th class="underline title01" style="width:100px">답변 여부</th>		
					<th class="underline title01" style="width:200px">작성일</th>
				</thead>
					<c:forEach items="${list}" var="list">
						<tr>
							<td class="title02"><c:out value="${list.ask_num}"/></td>
								<fmt:formatDate var="date" value="${list.ins_dt }" pattern="yyyy-MM-dd"/>
									<c:choose>
										<c:when test="${cdate eq date }">
											<td class="title02" style="text-align: left;">
											<a href="ask_detail.do?ask_num=${list.ask_num}">${list.ask_title}&nbsp;<img src="/resources/img/new.png" style="width:25px;"></a></td>
										</c:when>
										<c:otherwise>
											<td class="title02" style="text-align: left;">
											<a href="ask_detail.do?ask_num=${list.ask_num}">${list.ask_title}</a></td>
										</c:otherwise>
									</c:choose>
							<td class="title02"><c:out value="${list.writer_nm}"/></td>
							<td class="title02"><c:out value="${list.comm_yn}"/></td>
								<c:choose>
									<c:when test="${cdate eq date }">
										<td class="title02"><fmt:formatDate value="${list.ins_dt}" pattern="HH:mm"/></td>
									</c:when>
									<c:otherwise>
										<td class="title02"><fmt:formatDate value="${list.ins_dt}" pattern="yyyy-MM-dd"/></td>
									</c:otherwise>
								</c:choose>
						</tr>
					</c:forEach>
					<tr>
 					<td colspan="5" class="underline"></td>
 				</tr>
			</table>
		</form>	
		<div class="searcht">
			<select class="sOpt" name="searchType">
				<option value="TC"<c:out value="${scri.searchType eq 'TC' ? 'selected': ''}"/>>문의 제목or문의 내용</option>
				<option value="T"<c:out value="${scri.searchType eq 'T' ? 'selected': ''}"/>>문의 제목</option>
				<option value="W"<c:out value="${scri.searchType eq 'W' ? 'selected': ''}"/>>이름</option>
				<option value="C"<c:out value="${scri.searchType eq 'C' ? 'selected': ''}"/>>문의 내용</option>
				<option value="Y"<c:out value="${scri.searchType eq 'C' ? 'selected': ''}"/>>답변 여부</option>
			</select>
			<input class="underline" type="text" placeholder="키워드를 입력하세요." name="keyword" id="keywordInput" value="${scri.keyword }"/>
			<button id="searchBtn" class="bbt" type="button">검색</button>
		</div>
		<div class="pagination" style="margin: 0 auto; width:70%; border: 3px">
 						 <ul>
    						<c:if test="${pageMaker.prev}">
    							<li><a href="ask_list.do${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
    						</c:if> 
							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
    							<li><a href="ask_list.do${pageMaker.makeSearch(idx)}">${idx}</a></li>
    						</c:forEach>
							<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
    							<li><a href="ask_list.do${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
    						</c:if> 
  						</ul>
					</div>
	</div>


<jsp:include page="../main/footer.jsp"/>
</body>
</html>