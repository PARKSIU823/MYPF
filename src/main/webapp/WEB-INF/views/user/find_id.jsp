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
	<h3>FIND ID</h3>
	<form action="/user/find_id.do" method="post">
		<div class="resultID" id="resultID">
			<ul>
			</ul>
		</div>
		<table class="regform">
		  <tr>
		  	<td class="title">이름</td>
		  	<td><input type="text" class="infield" name="user_nm" id="user_nm"/></td>
		  </tr>
		  <tr>
		  	<td class="title">이메일</td>
		  	<td colspan="2"><input type="email" class="infield" name="user_mail" id="user_mail" pattern="[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.]+[a-zA-Z]+[.]*[a-zA-Z]*"/></td>
		  </tr> 
		  <tr>
		  	<td colspan="3" class="bbtpos2">
		  		<button type="reset" class="bbt">취소</button>
		  		<button type="submit" class="bbt">아이디 찾기</button>
		  	</td>
		  </tr>
		</table>
	</form>
</div>
<script type="text/javascript">
		
	$(document).ready(function(){
		
		//아이디 찾기 버튼 클릭시 누락 항목 체크
		$("button[type='submit']").on("click", function(){
			if($("#user_nm").val()==""){
				alert("성명을 입력해주세요.");
				$("#user_nm").focus();
				return false;
			}
			if($("#user_mail").val()==""){
				alert("이메일을 입력해주세요.");
				$("#user_mail").focus();
				return false;
			}
			$.ajax({
				url : "/user/find_id.do"
				,type : "POST"
				,dataType : "json"
				,data : {"user_nm" : $("#user_nm").val(), "user_mail" : $("#user_mail")}
				,success : function(data) {
					var user_id = data;
					alert("회원님의 아이디는 " +user_id+"입니다.");
					}
				,error : function() {
					alert("정보를 다시 입력해 주십시오.");
					$("#user_nm").val();
					$("#user_mail").val();
					$("#user_nm").focus();
				}
			});
		});
			
	});
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>