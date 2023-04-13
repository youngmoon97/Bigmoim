<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="mMgr" class="model.Mgr.MemberMgr" />
<%
	String id = request.getParameter("login_id");
	String pw = request.getParameter("login_pw");
	int mode = mMgr.loginMember(id, pw);

	if(mode==0){
	 out.println("<script>alert('로그인 실패:아이디를 확인해주세요');</script>");
	}else if(mode==1){
		//response.sendRedirect("logError.jsp?mode=1");
		 out.println("<script>alert('로그인 실패:비밀번호를 확인해주세요');</script>");
	}else if(mode==2){
		//session.setAttribute("idKey",id);
		out.println("<script>alert('로그인 성공! 즐거운 모임 되세요~');</script>");
		//response.sendRedirect("login.html");
	}
%>
