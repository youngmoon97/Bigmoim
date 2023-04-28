<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="mBean" class="model.Bean.MemberBean"/>
<jsp:setProperty property="*" name="mBean"/>
<%
		boolean result = mMgr.updateMember(request);
		if(result){ //수정성공
%>
		<script>
			alert("회원정보 수정 완료");
			location.href = "../main/main.jsp";
		</script>
<%}else{ //수정실패%>
		<script>
			alert("회원정보 수정 실패");
			history.back();
		</script>
<%}%>