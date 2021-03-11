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
</head>
<body>
<jsp:include page="../main/header.jsp"/>
	<form id='actionForm' action="/portfolio/pf_list.do" method="get">
		<input type="hidden" name="pageNum" value="${pageMaker.pfCri.pageNum }"/>
		<input type="hidden" name="amount" value="${pageMaker.pfCri.amount}"/>
	</form>
	<div class="project">
		<h3>PORTFOLIO</h3>
<!-- 		<ul> -->
<!-- 			<li><a href="#">SIU</a></li> -->
<!-- 			<li><a href="#">EJ</a></li> -->
<!-- 		</ul> -->
		<table class="pfview">
			<c:if test="${user.user_auth eq 'A'.charAt(0) }">
			<tr>
<!-- 				<td colspan="3"><button type="button" class="bbt" name="prtfRegBtn">등록</button></td> -->
				<td colspan="3"><a href="<c:url value='/portfolio/pf_write.do'/>"> 글 작성</a></td>
			</tr>
			</c:if>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="0" end="2" step="1">
				<td><a href="/portfolio/pf_read.do?prtf_num=<c:out value='${list.prtf_num}'/>"><img src="${pfFile.file_nm }"/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="3" end="5" step="1">
				<td ><a href="/portfolio/pf_read.do?prtf_num=<c:out value='${list.prtf_num}'/>"><img src="${pfFile.file_nm }"/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="6" end="8" step="1">
				<td ><a href="/portfolio/pf_read.do?prtf_num=<c:out value='${list.prtf_num}'/>"><img src="${pfFile.file_nm }"/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
		</table>
		
		<!-- 포트폴리오 페이징 -->
		<div class="pfPage">
		<form id="actionForm" action="/portfolio/pf_list.do" method="get">
			<input type='hidden' name='pageNum' value = '${pageMaker.pfCri.pageNum }'>
			<input type='hidden' name='amount' value = '${pageMaker.pfCri.amount }'>
			<c:if test="${pageMaker.prev }">
				<a href="<c:out value='${pageMaker.startPage - 1 }'/>">이전</a>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage }" end ="${pageMaker.endPage }">
				<li class="pfPagination" style="float: left;
				"><a href="<c:out value='${num}'/>">${num}</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<a href="<c:out value='${pageMaker.endPage + 1 }'/>">다음</a>
			</c:if>
		</form>
		</div>
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
	
<script type="text/javascript">
// modal
$(document).ready(function(){
	var result = '<c:out value="${result}"/>';
	
	// 	modal 
	checkModal(result);
	function checkModal(result){
		//result 값이 null일 경우 return;
		if(result==='') {return;}
		//result 값(등록한 글 번호)이 0 이상일 경우
		if(parseInt(result)>0){
			$(".modal_body").html(parseInt(result) + "번 글이 등록되었습니다.");	
		}
		$(".informModal").modal("show");
	}
	
	// 등록 버튼 클릭시 등록창 이동
	$("#prtfRegBtn").on("click",function(){
		self.location="/portfolio/pf_write.do";
	});
	
	//페이지 이동
	var actionForm = $('#actionForm');
	$('.pfPagination a').on("click", function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	})
});
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>