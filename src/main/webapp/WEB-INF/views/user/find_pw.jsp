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
	<h3>FIND PW</h3>
	<form action="/user/find_pw.do" method="post" id="delForm">
		<div class="resultID" id="resultID">
			<ul>
			</ul>
		</div>
		<table class="regform">
		  <tr>
		  	<td class="title">아이디</td>
		  	<td><input type="text" class="infield" name="user_id" id="user_id"/></td>
		  </tr>
		  <tr>
		  	<td class="title">이름</td>
		  	<td><input type="text" class="infield" name="user_nm" id="user_nm" /></td>
		  </tr> 
		  <tr>
		  	<td colspan="3" class="bbtpos2">
		  		<button type="reset" class="bbt">취소</button>
		  		<button type="submit" class="bbt">비밀번호 찾기</button>
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
			if($("#user_id").val()==""){
				alert("아이디를 입력해주세요.");
				$("#user_mauser_idil").focus();
				return false;
			}
			$.ajax({
				url : "/user/find_pw.do"
				,type : "POST"
				,dataType : "json"
				,data : {"user_nm" : $("#user_nm").val(), "user_id" : $("#user_id")}
				,success : function(data) {
					var user_pw = data;
					alert("회원님의 비밀번호는 " +user_pw+"입니다.");
					}
				,error : function() {
					alert("정보를 다시 입력해 주십시오.");
					$("#user_nm").val();
					$("#user_id").val();
					$("#user_id").focus();
				}
			});
		});
			
	});
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>