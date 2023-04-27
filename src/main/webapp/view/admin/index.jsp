<%@page import="javax.tools.DocumentationTool.Location"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
String admin_name = (String)session.getAttribute("adminIdKey");
if(admin_name==null){%>
<script>
alert("어드민네임널");
location.href = "../login/login.html"
</script>
<%
}
%>
<html>
<head>
<title>Bigmoim Admin</title>
<link href="../style.css" rel="stylesheet" type="text/css">
</head>
<body bgcolor="#FFE7EB" topmargin="100">
	<%@ include file="top.jsp" %>
	<table width="75%" align="center" bgcolor="#FFFF99">
	<tr bordercolor="#FFFF99"> 
	<td height="190" align="center">대모임 관리자 화면입니다.</td>
	</tr>
		<td>관리자 이름:<%=admin_name %></td>
	</table>
	<%@ include file="bottom.jsp" %>
</body>
</html>    