<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr" />
<%
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String msg = "로그인 성공! 즐거운 모임 되세요~";
	//int mode = mMgr.loginMember(id, pw);
	boolean flag = mMgr.loginMember(memberId, memberPw);
	
	if (flag==true){ //로그인 성공
		////session.setAttribute("idKey",id);
		//alert(memberId+"님 환영합니다");
		response.sendRedirect("../main.jsp");
	}else{ //로그인 실패
		System.out.println("로그인 실패");
		response.sendRedirect("login.html");
	}
%>
