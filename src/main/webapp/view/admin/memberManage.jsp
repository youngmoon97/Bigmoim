<%@page import="java.util.Vector"%>
<%@page import="model.Bean.MemberBean"%>
<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<html>
<head>
<title>Bigmoim Admin</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="script.js"></script>
</head>
<body bgcolor="#FFE7EB" topmargin="100">
	<%@ include file="top.jsp" %> 
	<%Vector<MemberBean> vlist = mMgr.getMemberList();%>
	<table width="75%" align="center" bgcolor="#FFFF99">
	<tr> 
	<td align="center" bgcolor="#FFFFCC">
	
		<table width="95%" align="center" bgcolor="#FFFF99" border="1">
		<tr align="center" bgcolor="#996600"> 
			<td><font color="#FFFFFF">회원아이디</font></td>
			<td><font color="#FFFFFF">회원이름</font></td>
			<td><font color="#FFFFFF">회원전화번호</font></td>
			<td><font color="#FFFFFF">회원자기소개</font></td> 
			<td><font color="#FFFFFF">회원추방</font></td>
		</tr>
		<%
		for(int i=0; i<vlist.size(); i++){
			MemberBean mBean = vlist.get(i);
		%>
		
		<tr align="center"> 
			<td><%=mBean.getMemberId()%></td>
			<td><%=mBean.getMemberName()%></td>
			<td><%=mBean.getMemberTel()%></td>
			<td><%=mBean.getMemberProfile()%></td>
			<td><a href="memberDeleteProc.jsp?memberId=<%=mBean.getMemberId()%>"
			style="color: blue;">추방</a>
			</font></td>
		</tr>
		<tr></tr><tr></tr>
		<%}%>
		</table>
	</td>
	</tr>
	</table>
	<%@ include file="bottom.jsp" %>
	<form name="delete" method="post" action="memberDeleteProc.jsp">
	<input type="hidden" name="memberId">
	</form>
</body>
</html>
