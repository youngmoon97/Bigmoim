<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<%
	String memberId = request.getParameter("memberId");
	int photoNum = Integer.parseInt(request.getParameter("photoNum"));
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	String msg = "삭제하지 못했습니다.";
	
	boolean result = moimMgr.deleteMoimphoto(photoNum, memberId);
	String url = "moimdetail.jsp?num=" + moimNum;
	if(result){
		msg = "삭제되었습니다.";
	}
	
	
%>
<script>
alert("<%=msg%>");
location.href = "<%=url%>";
</script>