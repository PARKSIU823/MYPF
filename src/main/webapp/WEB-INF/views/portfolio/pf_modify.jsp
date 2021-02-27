<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="java.util.*"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
   <meta charset="utf-8">
      	<script src="https://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
   <link href="${path}/resources/css/style.css" rel="stylesheet" >
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<form method="post" action="/portfolio/pf_modify.do">
	<div class="project">
		<h3>PROJECT MODIFY</h3>
		<input type="hidden" name="user_id" value="mypf01"/>
		<!-- 등록 테이블 -->
		<table class="wform">
			<tr>
				<td class="title">글 번호</td>
				<td>
					<input type="text" name="prtf_num" value='<c:out value="${pfModify.prtf_num }"/>' readonly="readonly" style="border:none;"/>
				</td>
			</tr>
			<tr>
				<td class="title">카테고리 선택</td>
				<td>
					<select name="category" class="sOpt">
						<option>카테고리</option>
						<option value="siu" <c:if test="${pfModify.category=='siu'}"> selected='selected'</c:if>>시우</option>
						<option value="ej" <c:if test="${pfModify.category=='ej'}"> selected='selected'</c:if>>은주</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="title">프로젝트명</td>
				<td><input type="text" class="infield" name="prtf_title" value="<c:out value='${pfModify.prtf_title }'/>"/></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td class="title">개발 기간</td> -->
<!-- 				<td><input type="date" class="infield" name="frm_dt"/> ~ <input type="date" class="infield" name="to_dt"/></td> -->
<!-- 			</tr> -->
			<tr>
				<td class="title">프로젝트 내용 <br>(최대 2,000자)</td>
				<td><textarea class="con" name="prtf_con"><c:out value="${pfModify.prtf_con }"/></textarea></td>
			</tr>
			<tr>
				<td class="title">맡은 역할</td>
				<td><input type="text" class="infield" name="position" value="<c:out value='${pfModify.position}'/>"/></td>
			</tr>
			<tr>
				<td class="title">느낀 점</td>
				<td><textarea class="con" name="idea"><c:out value="${pfModify.idea }"/></textarea></td>
			</tr>
			<tr>
				<td class="title">관련 URL</td>
				<td><input type="url" class="infield" name="url" value="<c:out value='${pfModify.url}'/>"/></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td class="title">첨부파일</td> -->
<!-- 				<td><input type="file" class="infield"/></td> -->
<!-- 			</tr> -->
			<tr>
				<td colspan="2" class="bbtpos2">
					<button type="submit" data-oper="modify" class="bbt">수정</button>
					<button type="submit" data-oper="delete" class="bbt">삭제</button>
					<button type="submit" data-oper="list" class="bbt">목록</button>
				</td>
			</tr>
		</table>
	</div>
</form>
<script type="text/javascript">
$(document).ready(function(){
	var formObj = $("form");
	$('button').on("click", function(e) {
		e.preventDefault();
		var operation = $(this).data("oper");
		console.log(operation);
		if(operation === 'delete') {
			formObj.attr("action","/portfolio/pf_delete.do");
		}else if(operation==='list') {
			self.location = "/portfolio/pf_list.do";
			return;
		}
		formObj.submit();
	})
})</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>