<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr" />
<jsp:useBean id="moimBean" class="model.Bean.MoimBean" />
<jsp:setProperty property="*" name="moimBean" />
<%
		boolean result = moimMgr.moimDelete(moimBean.getMoimNum());
		if (result){%>
<script>
alert("모임 삭제함");
location.href = "moimManage.jsp";
</script>
<% }else{%>
<script>
alert("모임 삭제 실패");
history.back();
</script>
<%} %>