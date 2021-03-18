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
				<td><a href="/portfolio/pf_read.do?prtf_num=<c:out value='${list.prtf_num}'/>"><img src='/portfolio/pfDisplay.do?file_nm=${list.file_nm}'/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="3" end="5" step="1">
				<td><a href="/portfolio/pf_read.do?prtf_num=<c:out value='${list.prtf_num}'/>"><img src='/portfolio/pfDisplay.do?file_nm=${list.file_nm}'/></a><br/> <c:out value="${list.prtf_title }"/></td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach items="${pfList}" var="list" begin="6" end="8" step="1">
				<td><a href="/portfolio/pf_read.do?prtf_num=<c:out value='${list.prtf_num}'/>"><img src="${path }/resources/img/prthumb.png"/></a><br/> <c:out value="${list.prtf_title }"/></td>
<%-- 				<td><a href="/portfolio/pf_read.do?prtf_num=<c:out value='${list.prtf_num}'/>"><img src='${list.file_nm}'/></a><br/> <c:out value="${list.prtf_title }"/></td> --%>
				</c:forEach>
			</tr>
		</table>
		
		<!-- 포트폴리오 검색 -->
		<form id="searchForm" action="/portfolio/pf_list.do" method="get">
		<!-- 검색 -->
		<div class="pfSearch">
			<select name="type" class="pfOpt">
				<option>선택</option>
				<option value="user_id" <c:out value="${pageMaker.pfCri.type eq 'user_id'?'selected' :'' }"/>>아이디</option>
			</select>
			<input type="text" name="keyword" class="underline" value='<c:out value="${pageMaker.pfCri.keyword }"/>'/>
			<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.pfCri.pageNum }"/>' />
			<input type='hidden' name='amount' value='<c:out value="${pageMaker.pfCri.amount }"/>' />
			<button type="submit" name="searchBbt" class="bbt">검색</button>
		</div>
		</form>			
		<!-- 포트폴리오 페이징 -->
		<form id="actionForm" action="/portfolio/pf_list.do" method="get">
		<div class="pfPage">
			<input type='hidden' name='pageNum' value = '${pageMaker.pfCri.pageNum }'>
			<input type='hidden' name='amount' value = '${pageMaker.pfCri.amount }'>
			<input type='hidden' name="keyword" value="${pageMaker.pfCri.keyword }"/>
			<input type='hidden' name="type" value="${pageMaker.pfCri.type }"/>
			<c:if test="${pageMaker.prev }">
				<li class="pagination"><a href="<c:out value='${pageMaker.startPage-1}'/>">이전</a></li>
			</c:if>
			<c:forEach var="num" begin="${pageMaker.startPage }" end ="${pageMaker.endPage }">
				<li class="pagination ${pageMaker.pfCri.pageNum == num ? "active":"" }" style="float: left; list-style: none; font-weight: bold; "> <a href="<c:out value='${num}'/>">${num}</a></li>
			</c:forEach>
			<c:if test="${pageMaker.next }">
				<li class="pagination"><a href="<c:out value='${pageMaker.startPage-1}'/>">이전</a></li>
			</c:if>
		</div>
		</form>
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
	$('.pagination a').on("click", function(e) {
		e.preventDefault();
		console.log('click');
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();
	})
	
	//검색
	var searchForm = $("#searchForm");
	$("#searchForm button").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("키워드를 입력하세요.");
			$(".userOpt").focus();
			return false;
		}
		if(!searchForm.find("input[name='keyword']").val()){
			alert("키워드를 입력하세요.");
			$(".keyword").focus();
			return false;
		}
		searchForm.find("input[name='pageNum']").val("1");
		e.preventDefault();
		searchForm.submit();
	})
});
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>