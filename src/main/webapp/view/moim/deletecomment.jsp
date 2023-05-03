<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="boardcommentMgr" class="controll.Mgr.BoardCommentMgr"/>
<%
	String memberId = request.getParameter("memberId");
	int bcNum = Integer.parseInt(request.getParameter("bcNum"));
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	
	String msg = "삭제하지 못했습니다.";
	String url = "";
	boolean result = boardcommentMgr.bcDelete(bcNum);
	
	if(result){
		msg = "삭제 되었습니다.";
		url = "moimdetail.jsp?num=" + moimNum;
	}
%>

<script>
alert("<%=msg%>");
location.href = "<%=url%>";
</script>