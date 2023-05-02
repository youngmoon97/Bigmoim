<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="boardcommentBean" class="model.Bean.BoardCommentBean"/>
<jsp:useBean id="boardcommentMgr" class="controll.Mgr.BoardCommentMgr"/>
<%
	int mbNum = Integer.parseInt(request.getParameter("mbnum"));
	String memberId = request.getParameter("memberId");
	String comment = request.getParameter("comment-input");
	
	boardcommentBean.setMbNum(mbNum);
	boardcommentBean.setMemberId(memberId);
	boardcommentBean.setBcContent(comment);
	
	String msg = "등록하지 못했습니다";
	
	boolean result = boardcommentMgr.bcInsert(boardcommentBean);
	
	if(result){
		msg = "등록완료";
	}
	
%>

<script>
alert("<%=msg%>");
opener.location.reload();
self.close();
</script>