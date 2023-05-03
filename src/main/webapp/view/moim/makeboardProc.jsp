<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="boardMgr" class="controll.Mgr.BoardMgr"/>
<jsp:useBean id="boardBean" class="model.Bean.MemberBoardBean"/>
<%

	String msg = "등록되지 않았습니다";

	
	String memberId = request.getParameter("memberId");
	System.out.println("memberId : " + memberId);

	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	String mbTitle = request.getParameter("mbTitle");
	String mbContent = request.getParameter("mbContent");
	String mbImg = request.getParameter("mbImg");

	
	boolean result = boardMgr.boardInsert(request);
	
	if(result){
		
		msg = "등록완료";

	}
%>
<script>
alert("<%=msg%>");
opener.location.reload();
self.close();
</script>