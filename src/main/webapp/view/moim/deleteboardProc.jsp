<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="boardMgr" class="controll.Mgr.BoardMgr"/>
<%
		
		String memberId = request.getParameter("num");
		int moimnum = Integer.parseInt(request.getParameter("moimnum"));
		int mbnum = Integer.parseInt(request.getParameter("mbnum"));
		boolean result = boardMgr.boardDelete(mbnum, memberId);
		System.out.println(moimnum + " 모임번호");
		System.out.println(mbnum + " 게시글번호");
		System.out.println(memberId + " 아이디");
		String msg = "본인만 삭제할수 있습니다.";
		String url = "moimdetail.jsp?num=" + moimnum;
		if(result){
			msg = "삭제되었습니다.";
		}
		
%>
<script>
alert("<%=msg%>");
location.href = "<%=url%>";
</script>