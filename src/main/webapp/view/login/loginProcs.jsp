<%@page contentType="text/html;charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr" />
<%
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String msg = "로그인 성공! 즐거운 모임 되세요~";
	boolean result = mMgr.loginMember(memberId, memberPw);
	String url = "/bigmoim/view/main/main.jsp";
	
	if (result){ //회원로그인 성공
		session.setAttribute("idKey",memberId);
		response.sendRedirect("../main/main.jsp");
	}else{ //회원 로그인 실패시 관리자 로그인 시도
		boolean flagAdmin = mMgr.adminCheck(memberId, memberPw);
	if(flagAdmin){
		session.setAttribute("adminIdKey", memberId);
		response.sendRedirect("../admin/index.jsp");
	}else{%>
		<script>
		alert("아이디나 비밀번호를 확인해주세요")
		history.back();
		</script>
	<%}
	}
%>