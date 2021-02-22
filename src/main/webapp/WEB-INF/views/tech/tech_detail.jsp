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
<script type="text/javascript" src="${path}/resources/js/reply.js"></script>
<!-- Remember to include jQuery :) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<!-- jQuery Modal -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<script>
	$(document).ready(function () {
		
		var tech_numValue = '<c:out value="${board.tech_num}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		// 댓글 목록 처리
		function showList(page){
			replyService.getList({tech_num:tech_numValue, page:page|| 1 }, function(list){
				var str="";
				if(list == null || list.length == 0 ) {
					replyUL.html("");
					
					return;
				}
				for (var i = 0, len = list.length || 0; i < len; i++) {
					str += "<li class='left clearfix' data-comm_num='"+list[i].comm_num+"'>";
					str += " <div><div class='header'><strong class='primary-font'>"+list[i].user_id+"</strong>";
					str += " <small class='pull-right text-muted'>"+replyService.displayTime(list[i].ins_dt)+"</small></div>";
					str += " <p>"+list[i].comm_con+"</p></div></li>";
				}
				replyUL.html(str);
			});
		}
		//  새로운 댓글 처리
		var modal = $(".modal");
		var modalInputComm_con = modal.find("textarea[name='comm_con']");
		var modalInputUser_id = modal.find("input[name='user_id']");
		var modalInputIns_dt = modal.find("input[name='ins_dt']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn  = $("#modalRegisterBtn");
		
		$("#addReplyBtn").on("click", function(e){
			
			modal.find("input").val("");
			modalInputIns_dt.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		})
		
		modalRegisterBtn.on("click",function(e){
			
			var comm_con = {
					comm_con : modalInputComm_con.val(),
					user_id : modalInputUser_id.val(),
					tech_num : tech_numValue
			};
			replyService.add(comm_con, function(result){
				
				alert(result);
				
				modal.find("input").val("");
				modal.find("textarea").val("");
				modal.modal("hide");
				
				showList(1);
			})
		})
		
		});
		
		/*
		//for replyService add test
		
		var tech_numValue = '<c:out value="${board.tech_num}"/>';
		
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
	
		replyService.get(36, function(data){
			console.log(data);
		});
		});
		*/
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
			</section>
			<br>
			<br>
			<div class='row'>
					<div class="default">
					<div class="heading">
							Reply
						<button id='addReplyBtn' style="float: right;">New Reply</button>
					</div>
					<div class="body">
						<ul class="chat">
							<li class="left clearfix" data-comm_num='12'>
								<div>
									<div class="header">
										<strong class="primary-font">user00</strong>
										<small class="pull-right text-muted">2021-0202 13:13</small>
									</div>
									<p>안녕!</p>
								</div>
							</li>					
						</ul>
					</div>
				</div>	
				</div>
			</div>
	</div>
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" ari-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
					 aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">댓글</h4> 
				</div>
			<div class="modal-body">
				<div class="form-group">
				 	<label>이름</label>
				 	<input class="form-control" name='user_id' value='user_id'>
				</div>
				<div class="form-group">
					<label>내용</label>
					<textarea class="form-control" cols="40" rosw="10" name='comm_con' value="New Reply!!!"></textarea>
				</div>
				<div class="form-group">
					<label>작성일</label>
					<input class="form-control" name='ins_dt' value=''>
				</div>
				
			</div>
		<div class="modal-footer">
			<button id='modalModBtn' type="button">Modify</button>
			<button id='modalRemoveBtn' type="button">Remove</button>
			<button id='modalRegisterBtn' type="button" data-dismiss="modal">Register</button>
			<button id='modalCloseBtn' type="button" data-dismiss="modal">Close</button>
			</div>
		</div>		
		</div>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>