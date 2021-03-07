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
		<h3>REGISTER</h3>
		<form action="/user/register.do" method="post">
			<table class="regform">
<!-- 			  <tr> -->
<!-- 			  	<td class="title">사진</td> -->
<!-- 			  	<td colspan="2"><input type="file" class="infield"/></td> -->
<!-- 			  </tr> -->
			  <tr>
			  	<td class="title">이름</td>
			  	<td colspan="2"><input type="text" class="infield" id="user_nm" name="user_nm"/></td>
			  </tr>
			  <tr>
			  	<td class="title">아이디</td>
			  	<td><input type="text" class="infield02" name="user_id" id="user_id"/> <button type="button" id="chkID" value="N" class="bbt" onclick="fn_idChk();">중복확인</button></td>
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
			  	<input type="hidden" name="chkMail" id="chkMail" value="N"/>
			  	<input type="email" class="infield" name="user_mail" id="user_mail" pattern="[a-zA-Z0-9]+[@][a-zA-Z0-9]+[.]+[a-zA-Z]+[.]*[a-zA-Z]*" onchange="fn_mailChk();"/>
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
			  	<td colspan="2"><input type="text" class="infield" name="user_addr" id="user_addr"/></td>
			  </tr>
			  <tr>
			  	<td class="title">연락처</td>
			  	<td colspan="2"><input type="text" class="infield" name="user_tel" id="user_tel"/></td>
			  </tr>
			  <tr>
			  	<td class="title">URL</td>
			  	<td colspan="2"><input type="url" class="infield" name="user_tel" id="url"/></td>
			  </tr>
			  <tr>
			  	<td colspan="3" class="bbtpos2">
			  		<button type="reset" class="bbt">취소</button>
			  		<button type="submit" class="bbt">가입</button>
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
		//회원 가입 버튼 클릭시 누락 항목 체크
		$("button[type='submit']").on("click", function(){
			if($("#chkID").val()=="N"){
				alert("아이디 중복확인을 해주세요.");
				$("#user_id").focus();
				return false;
			}
			if($("#chkMail").val()=="N"){
				alert("다른 메일을 입력해주세요.");
				$("#user_id").focus();
				return false;
			}
			if($("#user_id").val()==""){
				alert("아이디를 입력해주세요.");
				$("#user_id").focus();
				return false;
			}
			if($("#user_pw").val()==""){
				alert("비밀번호를 입력해주세요.");
				$("#user_pw").focus();
				return false;
			}
			if($("#user_pw_chk").val()==""){
				alert("비밀번호 확인을 입력해주세요.");
				$("#user_pw_chk").focus();
				return false;
			}
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
		});
			
	});
	
	//아이디 중복 체크
	function fn_idChk(){
		$.ajax({
			url : "/user/chkID.do",
			type : "post",
			dataType : "json",
			data : {"user_id" : $("#user_id").val()},
			success : function(data){
				if(data == 1){
					alert("중복된 아이디입니다.");
				}else if(data == 0){
					$("#chkID").attr("value", "Y");
					alert("사용가능한 아이디입니다.");
				}
			}
		})
	}
	
	//이메일 중복 체크
	function fn_mailChk(){
		$.ajax({
			url : "/user/chkMail.do",
			type : "post",
			dataType : "json",
			data : {"user_mail" : $("#user_mail").val()},
			success : function(data){
				if(data > 0){
					alert("회원 가입된 메일입니다.");
					$('#user_mail').val('');
			         $('#user_mail').focus();
				}else if(data == 0){
					$("#chkMail").attr("value", "Y");
					alert("사용가능한 메일입니다.");
				}
			}
		})
	}
	</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>