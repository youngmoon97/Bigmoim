<%@ page pageEncoding="UTF-8"%>
<%
    String admin_id = (String)session.getAttribute("idKey");
	//if(admin_id == null) {
	//	response.sendRedirect("../login/login.html");
	//}
%>
<table width="75%" align="center" bgcolor="##FFC0CB">
  <tr bgcolor="#FFC0CB"> 
    <th><a href="../login/logout.jsp" style="color: blue;">로그아웃</a></th>
    <th><a href="memberManage.jsp" style="color: blue;">회원관리</a></th>
    <th><a href="moimManage.jsp" style="color: blue;">모임관리</a></th>
  </tr>
</table> 