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
<div class="pfMain">
	<table class="mainForm">
		<tr>
			<td class="tdfield01">
				<span class="title">PORTFOLIO</span>
			</td>
			<td width="2%" rowspan="2">
				
			</td>
			<td class="tdfield02">
				<span class="title">TECH</span>		
			</td>
		</tr>
		<tr>
			<td>
				<c:forEach items="${pfList}" var="pfList" begin="0" end="2" step="1">
					<a href="/portfolio/pf_read.do?prtf_num=<c:out value='${pfList.prtf_num}'/>"><img src='/portfolio/pfDisplay.do?file_nm=${pfList.file_nm}'/></a>
				</c:forEach>
			</td>
			<td>
				<c:forEach items="${techList}" var="techList" begin="0" end="4" step="1">
					<p><a href='/tech/tech_detail.do?tech_num=<c:out value="${techList.tech_num }"/>'>${techList.tech_title}</a> </p>
				</c:forEach>
			</td>
			
		</tr>
	</table>
</div>

<jsp:include page="../main/footer.jsp"/>
</body>
</html>