<%@page import="java.util.Vector"%>
<%@page import="model.Bean.MoimBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<%
	int categoryNum = request.getParameter("categoryNum");
	Vector<MoimBean> mvlist = moimMgr.cateMoimList(categoryNum);
%>

<h1>로그인</h1>
<%=categoryNum %>
<input name="categoryNum">	