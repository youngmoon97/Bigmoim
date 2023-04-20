<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<jsp:setProperty property="*" name ="mMgr"/>

<%
	String url = "login.html";
	String memberId = request.getParameter("memberId");
	String memberTel = request.getParameter("memberTel");
	
	String memberPw = mMgr.getPwSearch(memberId, memberTel);
	String msg = "회원님의 비밀번호는 " + memberPw + " 입니다.";
	
	if(memberPw == null || memberPw.equals("")){
		msg = "가입된 정보가 없습니다.";
		url = "pwFind.jsp";
	}
	
	System.out.print(msg);
%>
<script>
alert("<%=msg%>");
location.href = "<%=url%>";
</script>