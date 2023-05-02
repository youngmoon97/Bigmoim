<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<%
	String memberId = request.getParameter("memberId");
	int num = Integer.parseInt(request.getParameter("moimNum"));
	String mjContent = request.getParameter("mjContent");
	String msg = "모임 가입 신청 실패";
	String url = "moimdetail.jsp?num="+num;
	System.out.println("memberId : "+ memberId);
	System.out.println("moimnum : "+ num);
	System.out.println("mjContent : "+ mjContent);
	boolean result = moimMgr.mjInsert(num, memberId, mjContent);
	if(result){
		msg = "모임 가입 신청 완료";
		
	}
	
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>