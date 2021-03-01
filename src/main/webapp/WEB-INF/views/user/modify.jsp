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
		<h3>MODIFY</h3>
		<form action="/user/register.do" method="post" id="modifyForm">
			<table class="regform">
<!-- 			  <tr> -->
<!-- 			  	<td class="title">사진</td> -->
<!-- 			  	<td colspan="2"><input type="file" class="infield"/></td> -->
<!-- 			  </tr> -->
			  <tr>
			  	<td class="title">이름</td>
			  	<td colspan="2"><input type="text" class="infield" value="${user.user_nm }" name="user_nm" readonly="readonly"/></td>
			  </tr>
			  <tr>
			  	<td class="title">아이디</td>
			  	<td><input type="text" class="infield" name="user_id" id="user_id" value="${user.user_id }" readonly="readonly"/> </td>
			  </tr>
			  <tr>
			  	<td class="title">비밀번호</td>
			  	<td colspan="2"><input type="password" class="infield" name="user_pw" id="user_pw"/></td>
			  </tr>
			  <tr>
			  	<td class="title">비밀번호 확인</td>
			  	<td colspan="2"><input type="password" class="infield" id="user_pw_chk"/></td>
			  </tr>
			  <tr>
			  	<td class="title">이메일</td>
			  	<td>
			  	<input type="text" class="infield" name="user_mail" id="user_mail" value="${user.user_mail }" />
<!-- 			  		<input type="text" name="mailBody" class="infield03"/> @ -->
<!-- 			  		<select class="sOpt" name="mailDomain"> -->
<!-- 			  			<option>naver.com</option> -->
<!-- 			  			<option>gmail.com</option> -->
<!-- 			  			<option>daum.net</option> -->
<!-- 			  			<option>직접 입력</option> -->
<!-- 			  		</select> -->
			  	</td>
			  </tr>
			  <tr>
			  	<td class="title">주소</td>
			  	<td colspan="2"><input type="text" class="infield" name="user_addr" id="user_addr" value="${user.user_addr }" /></td>
			  </tr>
			  <tr>
			  	<td class="title">연락처</td>
			  	<td colspan="2"><input type="text" class="infield" name="user_tel" id="user_tel" value="${user.user_tel }" /></td>
			  </tr>
			  <tr>
			  	<td class="title">URL</td>
			  	<td colspan="2"><input type="url" class="infield" name="user_tel" id="url"/></td>
			  </tr>
			  <tr>
			  	<td colspan="3" class="bbtpos2">
			  		<button type="reset" class="bbt">취소</button>
			  		<button type="submit" class="bbt">정보 수정</button>
			  	</td>
			  </tr>
			  <tr>
			  	<td colspan="3">
			  		<a href="<c:url value='/user/remove.do'/>">회원탈퇴</a>
			  	</td>
			  </tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
	
	//비밀번호 동일 체크
	$(function(){
		$('#user_pw_chk').blur(function(){
		   if($('#user_pw').val() != $('#user_pw_chk').val()){
		    	if($('#user_pw_chk').val()!=''){
			    alert("비밀번호가 일치하지 않습니다.");
		    	    $('#user_pw_chk').val('');
		          $('#user_pw_chk').focus();
		       }
		    }
		})  	   
	});

		$(document).ready(function(){
			$("button[type='submit']").on("click", function(){
				if($("#user_pw").val()==""){
					alert("비밀번호를 입력해주세요.");
					$("#user_pw").focus();
					return false;
				}
				if($("#user_mail").val()==""){
					alert("이메일을 입력해주세요.");
					$("#user_mail").focus();
					return false;
				}
				if($("#user_tel").val()==""){
					alert("연락처를 입력해주세요.");
					$("#user_tel").focus();
					return false;
				}
				if($("#user_addr").val()==""){
					alert("주소를 입력해주세요.");
					$("#user_addr").focus();
					return false;
				}
				//비밀번호 암호화 확인 후 수정
				$.ajax({
					url : "/user/check_pw.do",
					type : "POST",
					dateType : "json",
					data : $("#modifyForm").serializeArray(),
					success: function(data){
						
						if(data==true){
							if(confirm("정보를 수정하시겠습니까?")){
								$("#modifyForm").submit();
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