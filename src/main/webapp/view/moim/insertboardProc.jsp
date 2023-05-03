<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="boardcommentBean" class="model.Bean.BoardCommentBean"/>
<jsp:useBean id="boardcommentMgr" class="controll.Mgr.BoardCommentMgr"/>
<%
	int mbNum = Integer.parseInt(request.getParameter("mbNum"));
	String memberId = request.getParameter("memberId");
	String comment = request.getParameter("comment-input");
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	
	boardcommentBean.setMbNum(mbNum);
	boardcommentBean.setMemberId(memberId);
	boardcommentBean.setBcContent(comment);
	
	String msg = "등록하지 못했습니다";
	
	boolean result = boardcommentMgr.bcInsert(boardcommentBean);
	
	String url = "moimdetail.jsp?num=" + moimNum; 
	if(result){
		msg = "등록완료";
	}
	
%>

<script>
alert("<%=msg%>");
location.href = "<%=url%>";
</script>