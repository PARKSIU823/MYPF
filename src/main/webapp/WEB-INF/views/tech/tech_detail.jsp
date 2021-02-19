<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>기술 게시판</title>
<link href="${path}/resources/css/style.css" rel="stylesheet" >
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="${path}/resources/js/reply.js"></script>
<script>
	document.addEventListener("DOMContentLoaded", function() {
		console.log("===================");
		console.log("JS TEST");
		
		var tech_numValue = '<c:out value="${board.tech_num}"/>';
		
		//for replyService add test
		replyService.add(
			{comm_con:"JS TEST", user_id:"tester", tech_num:tech_numValue}
			,
			function(result){
				alert("RESULT: " + result);
			}
		);
		//reply List Test
		replyService.getList({tech_num:tech_numValue, page : 1}, function(list){
			for(var i = 0, len = list.length||0; i < len; i++){
				console.log(list[i]);
			}
		});
		//4번 댓글 삭제 테스트
		replyService.remove(4, function(count){
			console.log(count);
			if (count === "success") {
				alert("REMOVED");
			}
		}, function(err) {
			alert('ERROR...');
		});
		//6번 댓글 수정
		replyService.update({
			comm_num : 6,
			tech_num : tech_numValue,
			comm_con : "Modified Reply..."
			}, function(result) {
				alert("수정 완료..");
			});
		replyService.get(6, function(data){
			console.log(data);
		});
	});
</script>
</head>
<body>
<jsp:include page="../main/header.jsp"/>
	<div class="tech">
		<h3 style="text-align: center;">기술 게시판</h3>
		<section id="techDetail">
				<input type="hidden" id="techNum" name="tech_num" value="${board.tech_num}" />
					<table class="tech" border=1>
						<tbody>
							<tr>
								<td>
									<label for="user_id">이름</label> ${board.user_id }
								</td>
							</tr>
							<tr>
								<td>
									<label for="tech_title">제목</label> [${board.tech_category }]${board.tech_title }
								</td>
							</tr>	
							<tr>
								<td>
									<label for="tech_con">내용</label> ${board.tech_con }
								</td>
							</tr>
							<tr>
								<td>
									<button data-oper='tech_modify.do' onclick="location.href='tech_modify.do?tech_num=<c:out value="${board.tech_num}"/>'">수정</button>
									<button data-oper='tech_list.do' onclick="location.href='tech_list.do'">목록</button>
								</td>
							</tr>		
						</tbody>
							
					</table>
				</form>
					
			</section>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>