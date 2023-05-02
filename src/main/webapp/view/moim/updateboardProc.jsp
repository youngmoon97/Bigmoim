<%@page import="model.Bean.MemberBoardBean"%>
<%@page import="model.Bean.MemberBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="memberMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="boardMgr" class="controll.Mgr.BoardMgr"/>
<jsp:useBean id="updatebean" class="model.Bean.MemberBoardBean"/>
<jsp:setProperty property="*" name="updatebean"/>

<%
	String msg = "수정 실패";
	String url = "makeboard.jsp";
	int mbNum = Integer.parseInt(request.getParameter("num"));
	
	updatebean.setMbNum(mbNum);
	System.out.println("게시판 번호 " + updatebean.getMbNum());
	
	boolean result = boardMgr.boardUpdate(request);
	
	if(result){
		msg = "수정 되었습니다.";
	}
	
	System.out.println(result + "맞아?");

%>

<script>
alert("<%=msg%>");
opener.location.reload();
self.close();
</script>

