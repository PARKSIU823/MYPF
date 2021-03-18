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

<div class="regist">
		<h3>DELETE</h3>
		<form action="/user/remove.do" method="post" id="delForm">
			<table class="regform">
			  <tr>
			  	<td class="title">아이디</td>
			  	<td><input type="text" class="infield" name="user_id" id="user_id" value="${user.user_id }" readonly="readonly"/></td>
			  </tr>
			  <tr>
			  	<td class="title">비밀번호</td>
			  	<td colspan="2"><input type="password" class="infield" name="user_pw" id="user_pw"/></td>
			  </tr>
			  <tr>
			  	<td colspan="3" class="bbtpos2">
			  		<button type="reset" class="bbt">취소</button>
			  		<button type="submit" class="bbt">회원탈퇴</button>
			  	</td>
			  </tr>
			</table>
		</form>
	</div>
	<div>
		<c:if test="${msg == false}">
					비밀번호가 맞지 않습니다.
		</c:if>
	</div>
<script type="text/javascript">
$(document).ready(function(){
	$("button[type='submit']").on("click", function(){
		
		$.ajax({
			url : "/user/check_pw.do",
			type : "POST",
			dateType : "json",
			data : {"user_id" : $("#user_id").val(),"user_pw" : $("#user_pw").val()},
			success: function(data){
				
				if(data==true){
					if(confirm("회원 탈퇴 하시겠습니까?")){
						$("#delForm").submit();
						alert("탈퇴되었습니다.");
					}
				}else{
					alert("비밀번호가 틀렸습니다.");
					return;
				}
			}
		})
	});
})
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>