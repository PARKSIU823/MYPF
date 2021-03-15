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
   <script src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>
<body>
<jsp:include page="../main/header.jsp"/>

<form id="actionForm" method="post" action="/user/user_management.do">
	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"/>
	<input type="hidden" name="amount" value="${pageMaker.cri.amount }"/>
</form>
<form id="authForm" method="get" action="/user/userAuth.do">
	<input type="hidden" name="user_id" value="${list.user_id }"/>
	<div class="userList">
		<h3>MANAGEMENT</h3>
		<table class="uList">
			<colgroup>
				<col width="10%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="30%"/>
				<col width="30%"/>
			</colgroup>
			<tr>
				<td class="title underline">회원번호</td>
				<td class="title underline">아이디</td>
				<td class="title underline">이름</td>
				<td class="title underline">이메일</td>
				<td class="title underline">권한</td>
			</tr>
			<c:forEach items="${userList }" var="list">
			<tr>
				<td class="underline">${list.user_count }</td>
				<td class="underline"><a href="<c:url value='/user/userAuth.do?user_id=${list.user_id }'/>">${list.user_id }</a></td>
				<td class="underline">${list.user_nm }</td>
				<td class="underline">${list.user_mail }</td>
				<td class="underline">
					<select name="user_auth" class="sOpt">
						<option>권한</option>
						<option value="A" <c:if test="${list.user_auth eq'A'.charAt(0) }"> selected='selected'</c:if>>관리자</option>
						<option value="U" <c:if test="${list.user_auth eq'U'.charAt(0) }"> selected='selected'</c:if>>일반회원</option>
					</select>
				</td>
			</tr>
			</c:forEach>
<!-- 			<tr> -->
<!-- 				<td colspan="6"> -->
<!-- 				<button type="submit" id="authBbt" name="authBbt" class="bbt" style="float: right;">권한 수정</button> -->
<!-- 				</td> -->
<!-- 			</tr> -->
		</table>
	</div>
</form>

<form id="searchForm" action="/user/user_management.do" method="get">
	<!-- 검색 -->
	<div class="userSearch">
		<select name="userOpt" class="userOpt">
			<option>선택</option>
			<option value="user_id" <c:out value="${pageMaker.cri.type eq 'user_id'?'selected' :'' }"/>>아이디</option>
			<option value="user_nm" <c:out value="${pageMaker.cri.type eq 'user_nm'?'selected' :'' }"/>>이름</option>
			<option value="user_mail" <c:out value="${pageMaker.cri.type eq 'user_mail'?'selected' :'' }"/>>이메일</option>
		</select>
		<input type="text" name="keyword" class="underline" value='<c:out value="${pageMaker.cri.keyword }"/>'/>
		<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>' />
		<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount }"/>' />
		<button type="submit" name="searchBbt" class="bbt">검색</button>
	</div>
</form>			
<form id='actionForm' action="/user/user_management.do" method='get'>
	<!-- 회원관리 페이징 -->
	<div class="userPage">
		<c:if test="${pageMaker.prev }">
			<li class="userPagination"><a href="<c:out value='${pageMaker.startPage-1}'/>">이전</a></li>
		</c:if>
		<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
			<li class="userPagination"><a href="<c:out value='${num}'/>">${num }</a></li>
		</c:forEach>
		<c:if test="${pageMaker.next }">
			<li class="userPagination"><a href="<c:out value='${pageMaker.endPage+1}'/>">다음</a></li>
		</c:if>
	</div>
</form>
<script type="text/javascript">
$(document).ready(function(){
	//페이징
	var actionForm = $("#actionForm");
	$('.userPagination a').on("click", function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	})
	
	//검색
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function(e){
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요.");
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	})

	//권한 수정
	var authForm = $("#authForm");
	$('#authBbt').on("click", function(e) {
		authForm.submit();
	})
	
});


</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>