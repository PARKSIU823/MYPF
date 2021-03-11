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
</head>
<body>
<jsp:include page="../main/header.jsp"/>
<div class="project">
	<h3>PORTFOLIO</h3>
	<!-- 섬네일 테이블 -->
	<form method="get" action="/portfolio/pf_modify.do">
	<table class="pboard">
		<tr>
			<td rowspan="5" class="thumb"> 
<%-- 				<img src="<c:out vlaue='${pfFileRead.file_path }'/>"> --%>
				<img src="${path }/resources/img/prthumb.png">
			</td>
			<td class="info title"> 
				글번호 <input type="text" name="prtf_num" value='<c:out value="${pfRead.prtf_num }"/>' readonly="readonly" style="border:none;"/>
			</td>
		</tr>
		<tr>
			<td class="info title">프로젝트명 <c:out value="${pfRead.prtf_title }"/>
			</td>
		</tr>
		<tr>
			<td class="info title"> 개발기간  <c:out value="${pfRead.frm_dt }"/> ~ <c:out value="${pfRead.to_dt }" /></td>
		</tr>
		<tr>
<!-- 			<td class="info title"> 사용 툴 </td> -->
		</tr>
		<tr>
			<td class="info">
<%-- 				 ◀ <c:forEach items="${pfFileList }" var="fList"> <img src="<c:out value='${thumb.file_path }'/>"></c:forEach>▶</td> --%>
<%-- 				 ◀ <img src="${path }/resources/img/pfview.png" style="height: 150px; width: 150px;"> ▶</td> --%>
		</tr>	
	</table>
	<!-- 상세 내용 테이블 -->
	<table class="pboard">
		<tr>
			<td class="underline title"> 프로젝트 내용 </td>
			<td class="underline"><c:out value="${pfRead.prtf_title}"/></td>
		</tr>
		<tr>
			<td class="underline title"> 관련 URL</td>
			<td class="underline"><a href='<c:out value="${pfRead.url}"/>'><c:out value="${pfRead.url}"/></a></td>
		</tr>
		<tr>
			<td class="underline title"> 맡은 역할 </td>
			<td class="underline"><c:out value="${pfRead.position}"/></td>
		</tr>
		<tr>
			<td class="underline title"> 느낀 점 </td>
			<td class="underline"><c:out value="${pfRead.idea}"/></td>
		</tr>
		<tr>
			<td colspan="2" class="bbtpos1">
				<input type="button" class="bbt" value="목록" onclick="location='/portfolio/pf_list.do'"/>
				<input type="submit" class="bbt" value="수정 / 삭제" />
			</td>
		</tr>
	</table>
	</form>
</div>
<jsp:include page="../main/footer.jsp"/>
</body>
</html>