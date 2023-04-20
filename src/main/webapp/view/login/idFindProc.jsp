<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<jsp:setProperty property="*" name ="mMgr"/>
<%
	
	String url = "login.html";
	String memberName = request.getParameter("memberName");
	String memberTel = request.getParameter("memberTel");
	
	String memberId = mMgr.getIdSearch(memberName, memberTel);
	String msg = "회원님의 아이디는 " + memberId + " 입니다.";
	
	if(memberId == null || memberId.equals("")){
		msg = "가입된 정보가 없습니다.";
		url = "idFind.jsp";
	}
	
	System.out.print(msg);
%>
<script>
alert("<%=msg%>");
location.href = "<%=url%>";
</script>