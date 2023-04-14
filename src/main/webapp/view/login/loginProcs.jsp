<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controller.Mgr.MemberMgr" />
<%
	String id = request.getParameter("login_id");
	String pw = request.getParameter("login_pw");
	String msg = "로그인 성공! 즐거운 모임 되세요~";
	int mode = mMgr.loginMember(id, pw);

	if(mode==0){
		msg = "로그인 실패:아이디를 확인해주세요! ";
	 	response.sendRedirect("login.html");
	}else if(mode==1){
		msg = "로그인 실패:비밀번호를 확인해주세요! ";
		response.sendRedirect("login.html");
	}else if(mode==2){
		//session.setAttribute("idKey",id);
		out.println("<script>alert('로그인 성공! 즐거운 모임 되세요~');</script>");
		//response.sendRedirect("login.html");
	}
%>
