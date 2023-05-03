<%@page import="model.Bean.MemberBoardBean"%>
<%@page import="model.Bean.MemberBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="memberMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="boardMgr" class="controll.Mgr.BoardMgr"/>
<jsp:useBean id="updatebean" class="model.Bean.MemberBoardBean"/>


<%
	String msg = "수정 실패";
	String url = "makeboard.jsp";
	
	int mbNum = Integer.parseInt(request.getParameter("mbNum"));
	System.out.println("mbNum : " + mbNum);
	String memberId = request.getParameter("memberId");
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	String mbDate = request.getParameter("mbDate");
	String mbTitle = request.getParameter("mbTitle");
	String mbContent = request.getParameter("mbContent");
	String mbImg = request.getParameter("mbImg");
	

	
	
	boolean result = boardMgr.boardUpdate(request);
	
	if(result){
		msg = "수정 되었습니다.";
	}

%>

<script>
alert("<%=msg%>");
opener.location.reload();
self.close();
</script>

