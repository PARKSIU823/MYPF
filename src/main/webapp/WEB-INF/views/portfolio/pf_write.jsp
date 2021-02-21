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
<form method="post" action="/portfolio/pf_write.do">
	<div class="project">
		<h3>PROJECT ADD</h3>
		<input type="hidden" name="user_id" value="mypf01"/>
		<!-- 등록 테이블 -->
		<table class="wform">
			<tr>
				<td class="title">카테고리 선택</td>
				<td>
					<select name="category" class="sOpt">
						<option>카테고리</option>
						<option value="siu">시우</option>
						<option value="ej">은주</option>
					</select>
				</td>
			</tr>
			<tr>
				<td class="title">프로젝트명</td>
				<td><input type="text" class="infield" name="prtf_title"/></td>
			</tr>
<!-- 			<tr> -->
<!-- 				<td class="title">개발 기간</td> -->
<!-- 				<td><input type="date" class="infield" name="frm_dt"/> ~ <input type="date" class="infield" name="to_dt"/></td> -->
<!-- 			</tr> -->
			<tr>
				<td class="title">프로젝트 내용 <br>(최대 2,000자)</td>
				<td><textarea class="con" name="prtf_con"></textarea></td>
			</tr>
			<tr>
				<td class="title">맡은 역할</td>
				<td><input type="text" class="infield" name="position"/></td>
			</tr>
			<tr>
				<td class="title">느낀 점</td>
				<td><textarea class="con" name="idea"></textarea></td>
			</tr>
			<tr>
				<td class="title">관련 URL</td>
				<td><input type="url" class="infield" name="url"/></td>
			</tr>
			<tr>
				<td class="title">첨부파일</td>
				<td><input type="file" class="infield" name="file_nm"  multiple/></td>
			</tr>
			<tr>
				<td colspan="2" class="bbtpos2">
					<button type="submit" class="bbt">작성</button>
					<button type="reset" class="bbt">초기화</button>
					<button type="button" class="bbt" onclick="location.href='/portfolio/pf_list.do'">목록</button>
				</td>
			</tr>
		</table>
	</div>
	<div class="pf_thumb">
	
	</div>
</form>
<script>
</script>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>