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
<form id="authForm" method="post" action="/user/userAuth.do">
	<div class="userList">
		<h3>MANAGEMENT</h3>
		<table class="uList">
			<colgroup>
				<col width="5%"/>
				<col width="10%"/>
				<col width="10%"/>
				<col width="21%"/>
				<col width="18%"/>
				<col width="18%"/>
				<col width="18%"/>
			</colgroup>
			<tr>
				<td class="title underline">회원번호</td>
				<td class="title underline">아이디</td>
				<td class="title underline">이름</td>
				<td class="title underline">이메일</td>
				<td class="title underline">권한</td>
				<td class="title underline">가입일</td>
				<td class="title underline">최종 수정일</td>
			</tr>
			<tr>
				<td class="underline"><input type="text" style="border: 0" name="user_count" value="${userAuth.user_count }" readonly="readonly"/></td>
				<td class="underline"><input type="text" style="border: 0" name="user_id" value="${userAuth.user_id }" readonly="readonly"/></td>
				<td class="underline"><input type="text" style="border: 0" name="user_nm" value="${userAuth.user_nm }" readonly="readonly"/></td>
				<td class="underline"><input type="text" style="border: 0" name="user_mail" value="${userAuth.user_mail }" readonly="readonly"/></td>
				<td class="underline">
					<select name="user_auth" class="sOpt">
						<option>권한</option>
						<option value="A" <c:if test="${userAuth.user_auth eq'A'.charAt(0) }"> selected='selected'</c:if>>관리자</option>
						<option value="U" <c:if test="${userAuth.user_auth eq'U'.charAt(0) }"> selected='selected'</c:if>>일반회원</option>
					</select>
				</td>
				<td class="underline"><input type="text" style="border: 0" name="join_dt" value="<fmt:formatDate value='${userAuth.join_dt}'/>" pattern="yyyy-MM-dd"/>
				<td class="underline"><input type="text" style="border: 0" name="upt_dt" value="<fmt:formatDate value='${userAuth.upt_dt}'/>" pattern="yyyy-MM-dd"/>
			</tr>
			<tr>
				<td colspan="6">
				<button type="submit" id="authBbt" name="authBbt" class="bbt" style="float: right;">권한 수정</button>
				</td>
			</tr>
		</table>
	</div>
</form>
	
<script type="text/javascript">
$(document).ready(function(){

	//권한 수정
	var authForm = $("#authForm");
	$('#authBbt').on("click", function(e) {
		alert("권한이 수정되었습니다.");
		authForm.submit();
	})
	
});


</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>