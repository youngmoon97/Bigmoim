<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<%
	String memberId = request.getParameter("memberId");
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	String mjContent = request.getParameter("mjcontent");
	String msg = "모임 가입 신청 실패";
	String url = "moimdetail.jsp?moimnum="+moimNum;
	boolean result = moimMgr.mjInsert(moimNum,memberId, mjContent);
	if(result){
		msg = "모임 가입 신청 완료";
		
	}
	
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>