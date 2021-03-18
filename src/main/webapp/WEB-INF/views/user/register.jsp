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
			  	<td class="title" rowspan="4">주소</td>
			  	<td colspan="2">
			  		<input type="text" id="sample6_postcode" placeholder="우편번호" class="infield02" readonly="readonly" name="zipcode">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호" class="bbt">
				</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" id="sample6_address" placeholder="주소" class="infield" readonly="readonly" name="addr01"><br>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" id="sample6_detailAddress" placeholder="상세주소" class="infield" name="addr02"><br>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="text" id="sample6_extraAddress" placeholder="참고항목" class="infield" readonly="readonly" name="addr03">
				  	</td>
<!-- 			  	<td colspan="2"><input type="text" class="infield" name="user_addr" id="user_addr"/></td> -->
			  </tr>
			  <tr>
			  	<td class="title">연락처</td>
			  	<td colspan="2"><input type="text" class="infield" name="user_tel" id="user_tel"/></td>
			  </tr>
			  <tr>
			  	<td class="title">URL</td>
			  	<td colspan="2"><input type="url" class="infield" name="url" id="url"/></td>
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
			alert("회원 가입이 완료되었습니다");
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
	
	<!-- 다음 주소 api -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수
	
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
	</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>