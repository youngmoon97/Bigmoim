<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="memberBean" class="model.Bean.MemberBean"/>
<jsp:setProperty property="*" name="memberBean"/>
<%
		boolean result = moimMgr.memberBan(memberBean.getMemberName());
		if(result){ //추방성공
%>
		<script>
			alert("회원 추방 완료");
			history.back();
			location.reload(true);//새로고침, 서버로부터 새 데이터 받아옴
		</script>
<%}else{ //추방실패%>
		<script>
			alert("회원 추방 실패");
			history.back();
		</script>
<%}%>