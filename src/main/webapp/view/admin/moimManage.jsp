<%@page import="java.util.Vector"%>
<%@page import="controll.Mgr.UtilMgr"%>
<%@page import="model.Bean.MoimBean"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr" />
<html>
<head>
<title>Bigmoim Admin</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<script src="script.js"></script>
</head>
<body bgcolor="#FFE7EB" topmargin="100">
<%@ include file="top.jsp"%>
<table width="75%" align="center" bgcolor="#FFFF99">
	<tr>
		<td align="center" bgcolor="#FFFFCC">
		<table width="95%" align="center" bgcolor="#FFFF99" border="1">
			<tr  align="center" bgcolor="#996600">
				<td><font color="#FFFFFF">모임번호</font></td>
				<td><font color="#FFFFFF">모임이름</font></td>
				<td><font color="#FFFFFF">회장아이디</font></td>
				<td><font color="#FFFFFF">개설일자</font></td>
				<td><font color="#FFFFFF">모임삭제</font></td>
			</tr>
			<%
				Vector<MoimBean> vResult = moimMgr.moimAllList();
				if (vResult.size() == 0) {
			%>
			<tr>
				<td align="center" colspan="5">등록된 모임이 없습니다.</td>
			</tr>
			<%
				} else {
					for (int i = 0; i < vResult.size(); i++) {
						MoimBean moim = vResult.get(i);
			%>
			<tr  align="center">
				<td><%=moim.getMoimNum()%></td>
				<td><%=moim.getMoimName()%></td>
				<td><%=moim.getMemberId()%></td>
				<td><%=moim.getMoimDate()%></td>
				<td>
				<a href="moimDeleteProc.jsp?moimNum=<%=moim.getMoimNum()%>"
				style="color: blue;">삭제</a></td>
			</tr>
			<tr></tr><tr></tr>
			<%
					}//for
				}//if
			%>
		</table>
		</td>
	</tr>
</table>
<%@ include file="bottom.jsp"%>
<form name="detail" method="post" action="productDetail.jsp">
	<input type="hidden" name="moimNum">
</form>
</body>
</html>