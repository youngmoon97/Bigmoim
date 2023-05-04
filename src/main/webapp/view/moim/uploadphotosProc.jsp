<%@page import="model.Bean.MoimBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimphotoMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="photoBean" class="model.Bean.MoimPhotosBean"/>

<%

	String memberId = request.getParameter("memberId");
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	
	boolean result = moimphotoMgr.moimAddPhoto(request);
	
	String msg = "등록되지 않았습니다";

	if(result){
		msg = "등록되었습니다";
	}
	
%>

<script>
alert("<%=msg%>");
opener.location.reload();
self.close();
</script>