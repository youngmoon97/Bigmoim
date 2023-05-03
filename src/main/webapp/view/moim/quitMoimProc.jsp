<%@page import="model.Bean.MoimBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="moimMemberBean" class="model.Bean.MoimMemberBean"/>
<jsp:setProperty property="*" name="moimMemberBean"/>
<%
		String memberId = request.getParameter("memberId");
		int moimNum = Integer.parseInt(request.getParameter("moimNum"));
		boolean result = moimMgr.moimLeave(memberId, moimNum);

		if(result){ //탈퇴성공
%>
		<script>
			alert("회원 탈퇴 완료");
			location.href="/bigmoim/view/main/main.jsp"
		</script>
<%}else{ //탈퇴실패%>
		<script>
			alert("회원 탈퇴 실패");
			history.back();
		</script>
<%}%>