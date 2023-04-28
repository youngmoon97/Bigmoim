<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="moimBean" class="model.Bean.MoimBean"/>
<jsp:setProperty property="*" name="moimBean"/>
<%
		boolean result = moimMgr.moimUpdate(request);
		if(result){ //수정성공
%>
		<script>
			alert("모임정보 수정 완료");
			location.href = "../moim/mymoim.jsp";
		</script>
<%}else{ //수정실패%>
		<script>
			alert("모임정보 수정 실패");
			history.back();
		</script>
<%}%>