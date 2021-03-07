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
		<h3>USER INFORMATION</h3>
		<form action="/user/modifyForm.do" method="post" id="pwSubmitForm">
			<input type="hidden" name="user_id" id="user_id" value="<c:out value='${user.user_id}'/>"/>
			<table class="regform">
			  <tr>
			  <tr>
			  	<td class="title">비밀번호</td>
			  	<td colspan="2"><input type="password" class="infield" name="user_pw" id="user_pw"/></td>
			  </tr>
			  <tr>
			  	<td class="title">비밀번호 확인</td>
			  	<td colspan="2"><input type="password" class="infield" id="user_pw_chk"/></td>
			  </tr>
			  <tr>
			  	<td colspan="3" class="bbtpos2">
			  		<button type="reset" class="bbt">취소</button>
			  		<button type="submit" class="bbt" onclick="fn_pwChk();">확인</button>
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

	
	//아이디 중복 체크
	
	function fn_pwChk(){
		var pwSubmitForm = $('#pwSubmitForm');
		$.ajax({
			url : "/user/check_pw.do",
			type : "post",
			dataType : "json",
			data : {"user_id" : $("#user_id").val(), "user_pw" : $("#user_pw").val()},
			success : function(data){
				if(data == 1){
					alert("확인 완료");
					$('#pwSubmitForm').submit();
				}else if(data == 0){
					alert("비밀번호가 일치하지 않습니다.");
					$('#user_pw').val('');
					$('#user_pw_chk').val('');
					$('#user_pw').focus();
					
				}
			}
		})
	}
	
	</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>