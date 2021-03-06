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
<style>
.uploadResult { width:80%; background-color: ; }
/* .uploadResult { width:100%; background-color: gray; } */
.uploadResult ul { display:flex; flex-flow: row; justify-content: center; align-items: center; }
.uploadResult ul li { list-style: none; padding: 10px; align-content: center; text-align: center; }
.uploadResult ul li img { width: 100px; }
.bigPictureWrapper { position: absolute; display: none; justify-content: center;
					align-items: center; top:0%; width:100%; height:100%; background-color:gray; 
					z-index: 100px; background:rgba(255,255,255,0.5); }
.bigPicture { position: relative; display:flex; justify-content:center; align-items: center; }
.bigPicture img { width:600px; }
ul { list-style:none;}
.paging {margin-left: 30%;}
.paging	.page-item {list-style: none; float: left; padding: 6px; font-family:'Nanum Gothic', sans-serif; font-weight: bold;}
</style>
<script>
	$(document).ready(function(){
		console.log("첨부파일");
		(function(){
			console.log("첨부파일");
			var tech_num = '<c:out value="${board.tech_num}"/>';
			// 첨부파일 조회
			$.getJSON("/tech/getFileList.do", {tech_num : tech_num}, function(arr){
				console.log(arr);
				var str = "";
				$(arr).each(function(i, file){
					var fileCallPath = encodeURIComponent(file.file_path+"/s_"+file.uuid+"_"+file.file_nm);
					//image type
					if(file.file_type) {
						console.log(file.file_path);
						str += "<li data-path='"+file.file_path+"' data-uuid='"+file.uuid+"' data-filename = '"+file.file_nm+"' data-type='"+file.file_type+"' ><div>";
						str += "<img src='/tech/display.do?file_nm="+fileCallPath+"'>";
						str +="</li>";
					} else {
						str += "<li data-path='"+file.file_path+"' data-uuid='"+file.uuid+"' data-filename = '"+file.file_nm+"' data-type='"+file.file_type+"' ><div>";
						str += "<span> "+file.file_nm+"</span><br/>";
						str += "<img src='/resources/img/attach.png'>";
						str += "</div>";
						str +"</li>";
					}
				});
				$(".uploadResult ul").html(str);
				
				$(".uploadResult").on("click", "li", function(e){
					console.log("view image");
					var liObj = $(this);
					console.log(liObj.data("path"));
					console.log(liObj.data("uuid"));
					console.log(liObj.data("filename"));
					console.log(liObj.data("type"));
					var path = encodeURIComponent(liObj.data("path")+"/" + liObj.data("uuid")+"_" +liObj.data("filename"));
					console.log(path.replace(new RegExp(/\\/g),"/"));
					if(liObj.data("type")){
						showImage(path.replace(new RegExp(/\\/g),"/"));
					} else {
						// download
						console.log(path);
						self.location="/tech/download.do?file_nm="+path
					}
				});
				function showImage(fileCallPath){
					console.log(fileCallPath);
					$(".bigPictureWrapper").css("display", "flex").show();
					$(".bigPicture")
					.html("<img src='/tech/display.do?file_nm="+fileCallPath+"'>")
					.animate({width: '100%', height: '100%'}, 1000);
				}
				$(".bigPictureWrapper").on("click",function(e){
					$(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
					setTimeout(function(){
						$(".bigPictureWrapper").hide();
					}, 1000);
				})
			}); // end getjson
		})(); // end function
	});
</script>
<script>
	$(document).ready(function () {
		
		var tech_numValue = '<c:out value="${board.tech_num}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		// 댓글 목록 처리
		function showList(page){
			console.log("show list : " + page);
			replyService.getList({tech_num:tech_numValue, page:page|| 1 }, function(commCnt, list){
				
				console.log("commCnt : " + commCnt);
				console.log("list : " + list);
				console.log(list);
				
				if(page == -1) {
					pageNum = Math.ceil(commCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var str="";
				
				if(list == null || list.length == 0 ) {
					return;
				}
				for (var i = 0, len = list.length || 0; i < len; i++) {
					if(list[i].depth == 1) {
						if(list[i].del_yn == 'Y') {
							str += "<li class='chat-li'>삭제된 댓글입니다.</li>";
						} else {
							str += "<li class='chat-li' data-comm_num='"+list[i].comm_num+"'>";
							str += " <div><div class='header'><strong class='primary-font'>"+list[i].user_id+"</strong>";
							str += " <small class='pull-right text-muted'>"+replyService.displayTime(list[i].ins_dt)+"</small></div>";
							str += " <p>"+list[i].comm_con+"</p></div></li>";
						}
					} else {
						if(list[i].del_yn == 'Y') {
							str += "<li class='chat-li'><img src='/resources/img/reply.png' style='width:23px;'>삭제된 댓글입니다.</li>";
						} else {
							str += " <li class='chat-li' data-comm_num='"+list[i].comm_num+"'>";
							str += " <div><div class='header'><strong class='primary-font'><img src='/resources/img/reply.png' style='width:23px;'>"+list[i].user_id+"</strong>";
							str += " <small class='pull-right text-muted'>"+replyService.displayTime(list[i].ins_dt)+"</small></div>";
							str += " <p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+list[i].comm_con+"</p></div></li>";
						}
					}
				}
				replyUL.html(str);
				
				showCommPage(commCnt);
			});// end function
			
		} // end showList
		
		var pageNum = 1;
		var commPageFooter = $(".footer");
		
		// 댓글 페이지 번호 출력
		function showCommPage(commCnt) {
			
			var endNum = Math.ceil(pageNum / 10.0) * 10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= commCnt) {
				endNum = Math.ceil(commCnt/10.0);
			}
			
			if(endNum * 10 < commCnt) {
				next = true;
			}
			
			var str = "<ul class='paging'>";
			
			if(prev) {
				str += "<li class='page-item'><a class='page-link' href='"+(startNum -1)+"'>이전</a></li>";
			}
			
			for(var i = startNum ; i <= endNum; i++) {
				
				var active = pageNum == i? "active":"";
				
				str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
			}
			
			if(next) {
				str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>다음</a></li>";
			}
			
			str += "</ul></div>";
			
			console.log(str);
			
			commPageFooter.html(str);
		}
		
		// 페이지의 번호를 클릭했을 때 새로운 댓글 불러오기
		commPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum : " + targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});
		
		//  새로운 댓글 추가 처리
		var modal = $(".modal");
		var modalInputComm_con = modal.find("textarea[name='comm_con']");
		var modalInputUser_id = modal.find("input[name='user_id']");
		var modalInputIns_dt = modal.find("input[name='ins_dt']");
		
		var modalReCommBtn = $("#modalReCommBtn");
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn  = $("#modalRegisterBtn");
		var modalReCommRegBtn = $("#modalReCommRegBtn");
		
		$("#addReplyBtn").on("click", function(e){
			
			modal.find("input").val("");
			modal.find("textarea").val("");
			modalInputIns_dt.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		})
		
		modalRegisterBtn.on("click",function(e){
			
			var reply = {
					comm_con : modalInputComm_con.val(),
					user_id : modalInputUser_id.val(),
					tech_num : tech_numValue,
					depth : 1
			};
			replyService.add(reply, function(result){
				
				console.log(result);
				alert("댓글이 등록되었습니다.");
				
				modal.find("input").val("");
				modal.find("textarea").val("");
				modal.modal("hide");
				
				//showList(1);
				showList(-1);
			})
		})
		// 댓글 조회 클릭 이벤트 처리
		$(".chat").on("click", "li", function(e){
			
			var comm_num = $(this).data("comm_num");
			console.log("부모 댓글 번호  : " + $(this).data("comm_num"));
			
			replyService.get(comm_num, function(reply){
				modalInputUser_id.val($(reply).find("user_id").text());
				modalInputComm_con.val($(reply).find("comm_con").text());
				//modalInputIns_dt.val(replyService.displayTime(reply.ins_dt)).attr("readonly","readonly");
				//modalInputIns_dt.val($(reply).find("ins_dt").text());
				//modal.data("comm_num", reply.comm_num);
				modal.data("comm_num",$(reply).find("comm_num").text());
				modal.find("button[id != 'modalCloseBtn']").hide();
				
				if($(reply).find("depth").text() == 1){
					modalReCommBtn.show();	
				};
				
				modalModBtn.show();
				modalRemoveBtn.show();
				$(".modal").modal("show");
				console.log("댓글 클릭 이벤트 : " + comm_num);
				console.log(reply);
				console.log(reply.comm_num);
				console.log($(reply).find("comm_num").text());
				console.log(reply.ins_dt);
				console.log($(reply).find("ins_dt").text());
			});
		});
		// 답글 추가 처리
		$("#modalReCommBtn").on("click", function(e){
			console.log(modal.data("comm_num"));
			modal.find("input").val("");
			modal.find("textarea").val("");
			modalInputIns_dt.closest("div").hide();
			modal.find("button[id != 'modalCloseBtn']").hide();
			
			modalReCommRegBtn.show();
			
			$(".modal").modal("show");
		});
		modalReCommRegBtn.on("click",function(e){
			var reply = {
					comm_con : modalInputComm_con.val(),
					user_id : modalInputUser_id.val(),
					tech_num : tech_numValue,
					depth : 2,
					parent_num : modal.data("comm_num")
			};
			replyService.add(reply, function(result){
				
				console.log(result);
				alert("답글이 등록되었습니다.");
				
				modal.find("input").val("");
				modal.find("textarea").val("");
				modal.modal("hide");
				
				//showList(1);
				showList(pageNum);
			})
		});
		
		// 댓글의 수정 이벤트 처리
		modalModBtn.on("click", function(e){
			var reply = {comm_num:modal.data("comm_num"), comm_con:modalInputComm_con.val()};
			replyService.update(reply, function(result){
				console.log(result);
				alert("댓글이 수정되었습니다.");
				modal.modal("hide");
				showList(pageNum);
			});
		});
		// 댓글의 삭제 이벤트 처리
		modalRemoveBtn.on("click", function (e){
			var comm_num = modal.data("comm_num");
			replyService.remove(comm_num, function(result){
				console.log(result);
				alert("댓글이 삭제되었습니다.");
				modal.modal('hide');
				showList(pageNum);
				modal.find("input").val("");
				modal.find("textarea").val("");
			});
		});
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
<script>
	$(document).ready(function(){
		
		var openForm = $("#openForm");
		
		$("button[data-oper='tech_modify.do']").on("click", function(e){
			
			openForm.attr("action", "tech_modify.do").submit();
			
		});
		
		$("button[data-oper='tech_list.do']").on("click", function(e){
			
			openForm.find("#tech_num").remove();
			openForm.attr("action", "tech_list.do");
			openForm.submit();
		})
	})
</script>
</head>
<body>
<header>
	<div class="navi">
		<table>
			<tr>
				<td rowspan="2"><h1 class="pagename menu"><a href="<c:url value='/index.do'/>">MY PORTFOLIO</a></h1></td>
				<td>
					<ul>
						<c:if test="${user == null }">
						<li class="menu"><a href="<c:url value='/user/login.do'/>">로그인</a></li>
						<li class="menu"><a href="<c:url value='/user/register.do'/>">회원가입</a></li>
						</c:if>
						<c:if test="${user != null }">
						<li class="menu">${user.user_nm }님 </li>
						<li class="menu"><a href="<c:url value='/user/logout.do'/>">로그아웃</a></li>
						<li class="menu"><a href="<c:url value='/user/check_pw.do'/>">정보관리</a></li>
						</c:if>
					</ul>
				</td>
			</tr>
			<tr>
				<td>
					<ul>
						<li class="menu"><a href="<c:url value='/index.do'/>">MAIN</a></li>
						<li class="menu"><a href="<c:url value='/user/information.do'/>">INFORMATION</a></li>
						<li class="menu"><a href="<c:url value='/portfolio/pf_list.do'/>">PORTFOLIO</a></li>
						<li class="menu"><a href="<c:url value='/tech/tech_list.do'/>">TECHNOLOGY</a></li>
						<!-- session의 유저 권한이 A(관리자/admin)가 아닌 경우 문의는 문의하기로 이동 -->
						<c:if test="${user.user_auth ne 'A'.charAt(0)  }">
						<li class="menu"><a href="<c:url value='/ask/ask_write.do'/>">INQUERY</a></li>
						</c:if>
						<!-- session의 유저 권한이 A(관리자/admin)인 경우, 문의는 문의 내역으로 이동. 회원 관리 메뉴 생성 -->
						<c:if test="${user.user_auth eq 'A'.charAt(0) }">
						<li class="menu"><a href="<c:url value='/ask/ask_list.do'/>">INQUERY</a></li>
						<li class="menu"><a href="<c:url value='/user/user_management.do'/>">MANAGEMENT</a></li>
						</c:if>
					</ul>
				</td>
			</tr>
		</table>
	</div>
		<!-- 	modal 추가 -->
	<div class="modal_wrap" class="informModal">
		<div class="modal_header">
			<button type="button" class="modal_close" data-dismiss="modal">&times;</button>
		</div>
		<div class="modal_body">
			처리가 완료되었습니다.
		</div>
		<div class="modal_footer"></div>
	</div>
</header>

<script type="text/javascript">
// modal
 $(document).ready(function(){
 	var result = '<c:out value="${user.user_nm}"/>';
	
 	// 	modal 
 	checkModal(result);
 	function checkModal(result){
 		//user_nm 값이 null일 경우 return;
 		if(result==='') {return;}
 		//result_nm 값이 있을 경우
 		if(result!=null){
 			alert(result + "님 로그인 완료");
 		}
 		$(".informModal").modal("show");
 	}

// });
</script>
	<div class="tech">
		<h3>기술게시판</h3>
<!-- 		<h3 style="text-align: center;">기술 게시판</h3> -->
		<form id='openForm' action="tech_modify.do" method="get">
			<input type='hidden' id='techNum' name='tech_num' value='<c:out value="${board.tech_num}"/>'>
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
			<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
			<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
			<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
		</form>
			<!-- 본문 글 시작 -->
			<table class="tboard">
<!-- 			<table class="tech" border=1> -->
				<tbody>
					<tr>
						<td class="underline">
							<label for="tech_num" class="title">글 번호</label> ${board.tech_num }
						</td>
					</tr>
					<tr>
						<td class="underline">
							<label for="user_id" class="title">이름</label> ${board.user_id }
						</td>
					</tr>
					<tr>
						<td class="underline">
							<label for="tech_title" class="title">제목</label> [${board.tech_category }]${board.tech_title }
						</td>
					</tr>	
					<tr>
						<td class="underline">
							<label for="tech_con" class="title">내용</label> ${board.tech_con }
						</td>
					</tr>
					<tr>
						<td class="underline">
						<!-- 첨부파일 원본 -->
							<div class='bigPictureWrapper'>
								<div class='bigPicture'>
								</div>
							</div>
							<!-- 첨부파일 목록-->
							<div class="row">
								<div class="heading"><label class="title">첨부파일(※클릭 시 이미지 파일은 원본 파일이 생성되고, 그 외 파일은 다운로드됩니다.)</label></div>
								<div class="body">
									<div class='uploadResult'>
										<ul>
										</ul>
									</div> 
								</div>	
							</div>
						</td>
					</tr>
					<tr>
						<td class="bbtpos1">
							<button data-oper='tech_modify.do' class="bbt">수정</button>
							<button data-oper='tech_list.do' class="bbt">목록</button>
						</td>
					</tr>		
				</tbody>
			</table>
			<!-- 글 테이블 종료 -->
			<!-- 댓글 등록 -->
			<div class='row'>
					<div class="heading">
							<label class="title">댓글</label>
						<button id='addReplyBtn' class="bbt">등록</button>
		<!-- 						<button id='addReplyBtn' style="float: right;">댓글등록</button> -->
					</div>
					<div class="body">
						<ul class="chat">
							<li class="chat-li" data-comm_num='12'>
								<div>
									<div class="header">
										<strong class="primary-font"></strong>
										<small class="pull-right text-muted"></small>
									</div>
									<p></p>
								</div>
							</li>					
						</ul>
					</div>
					<div class="footer">
					
					</div>
			</div>
		</div>
<!-- 		</div> -->
	<!-- Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" 
		aria-labelledby="myModalLabel" ari-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
<!-- 					<h4 class="modal-title" id="myModalLabel">댓글</h4>  -->
					<h4 id="myModalLabel">댓글</h4> 
				</div>
			<div class="modal-body">
				<div class="form-group">
				 	<label class="title">이름</label>
				 	<input type="text" name='user_id' value='user_id'/>
				</div>
				<div class="form-group">
					<label class="title">내용</label>
					<textarea style="width:350px; height:70px; resize: none;" name='comm_con' value="New Reply!!!"></textarea>
				</div>
			</div>
		<div class="modal-footer">
			<button id='modalReCommBtn' type="button" class="bbt">답글</button>
			<button id='modalReCommRegBtn' type="button" class="bbt">등록</button>
			<button id='modalModBtn' type="button" class="bbt">수정</button>
			<button id='modalRemoveBtn' type="button" class="bbt">삭제</button>
			<button id='modalRegisterBtn' type="button" data-dismiss="modal" class="bbt">등록</button>
			</div>
		</div>		
		</div>
	</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>