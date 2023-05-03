<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="scMgr" class="controll.Mgr.ScheduleJoinMgr"/>
<%
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	String memberId = request.getParameter("memberId");
	int msNum = Integer.parseInt(request.getParameter("msNum"));
	boolean flag = scMgr.scJoin(msNum, memberId, moimNum);
	String msg="모임 참여 실패";
	String url="moimdetail.jsp?num="+moimNum;
	if(flag){
		msg= "모임 참여 성공";
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>
