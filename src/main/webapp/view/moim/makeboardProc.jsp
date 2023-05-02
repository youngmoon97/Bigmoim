<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="boardMgr" class="controll.Mgr.BoardMgr"/>
<jsp:useBean id="boardBean" class="model.Bean.MemberBoardBean"/>
<jsp:setProperty property="*" name="boardBean"/>
<%

	String msg = "등록되지 않았습니다";

	
	String memberId = request.getParameter("num");
	boardBean.setMemberId(memberId);
	int moimNum = Integer.parseInt(request.getParameter("moimnum"));
	boardBean.setMoimNum(moimNum);
	
	boolean result = boardMgr.boardInsert(request);
	
	if(result){
		
		msg = "등록완료";

	}
	
	System.out.println("결과는 : " + result);
%>
<script>
alert("<%=msg%>");
opener.location.reload();
self.close();
</script>