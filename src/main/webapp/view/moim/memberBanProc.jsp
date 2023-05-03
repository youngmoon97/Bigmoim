<%@page import="model.Bean.MoimBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="moimMemberBean" class="model.Bean.MoimMemberBean"/>
<jsp:setProperty property="*" name="moimMemberBean"/>
<%
		String memberId = request.getParameter("memberId");
		int moimNum = Integer.parseInt(request.getParameter("moimNum"));
		boolean result = moimMgr.memberBan(memberId, moimNum);

		if(result){ //추방성공
%>
		<script>
			alert("회원 추방 완료");
			location.href="moimMemberManage.jsp?moimNum=<%=moimNum%>"
		</script>
<%}else{ //추방실패%>
		<script>
			alert("회원 추방 실패");
			history.back();
		</script>
<%}%>