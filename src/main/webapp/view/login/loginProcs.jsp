<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr" />
<%
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String msg = "로그인 성공! 즐거운 모임 되세요~";
	boolean flag = mMgr.loginMember(memberId, memberPw);
	
	if (flag==true){ //회원로그인 성공
		session.setAttribute("idKey",memberId);
		//alert(memberId+"님 환영합니다");
		response.sendRedirect("../main/main.jsp");
	}else{ //회원 로그인 실패시 관리자 로그인 시도
		boolean flagAdmin = mMgr.adminCheck(memberId, memberPw);
	if(flagAdmin==true){
		session.setAttribute("adminIdKey", memberId);
		response.sendRedirect("../admin/index.jsp");
	}else{%>
	<script>
	alert("아이디 또는 비밀번호를 확인해주세요");
	</script>	
	<%
		response.sendRedirect("login.html");
	}
	}
%>
