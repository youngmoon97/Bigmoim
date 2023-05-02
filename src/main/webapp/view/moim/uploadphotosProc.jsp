<%@page import="model.Bean.MoimBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimphotoMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="photoBean" class="model.Bean.MoimPhotosBean"/>
<jsp:setProperty property="*" name = "photoBean"/>
<%
	String memberId = (String)session.getAttribute("idKey");
	photoBean.setMemberId(memberId);
	int moimNum = 1;
	photoBean.setMoimNum(moimNum);
	// 모임넘 받아오면 됨
//	int moimNum = Integer.parseInt(request.getParameter("num"));
	String photoName = request.getParameter("photoName");
	photoBean.setPhotoName(photoName);
	String photo = request.getParameter("photo");
	photoBean.setPhoto(photo);

	System.out.print(photo);
	
	boolean result = moimphotoMgr.moimAddPhoto(request);
	
	String msg = "등록되지 않았습니다";

	if(result){
		msg = "등록되었습니다";
	}
	
%>

<script>
alert("<%=msg%>");
</script>