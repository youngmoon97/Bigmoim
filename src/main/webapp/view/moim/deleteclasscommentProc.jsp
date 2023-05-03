<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="classcomentMgr" class="controll.Mgr.ClassCommentMgr"/>
<%
	String memberId = request.getParameter("memberId");
	int cCnum = Integer.parseInt(request.getParameter("cCnum"));
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	
	String msg = "";
	String url = "";
	
	boolean result = classcomentMgr.ccDelete(cCnum);
	
	if(result){
		msg = "삭제되었습니다";
		url = "moimdetail.jsp?num=" + moimNum; 
	}
%>
<script>
alert("<%=msg%>");
location.href = "<%=url%>";
</script>