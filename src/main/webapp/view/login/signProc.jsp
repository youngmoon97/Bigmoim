<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="mBean" class="model.Bean.MemberBean"/>

<%
	final String SAVEFOLDER = "C:/Jsp/bigmoim/src/main/webapp/image/";
	final String ENCODING = "UTF-8";
	final int MAXSIZE = 1024*1024*20;	//20MB
	
	//회원가입 진행, 실패하면 '가입실패' 알림, signup.jsp로 이동
	//성공하면 '가입성공' 알림 이후 메인 페이지로 이동(session에 id값 저장)
	boolean result = mMgr.insertMember(request);
	String msg = "가입실패";
	String url = "signup.jsp";
	if(result){
		msg = "가입성공";
		url = "/bigmoim/view/main/main.jsp"; //추후에 main페이지로 가도록 수정필요
		//가입과 동시에 로그인 처리
		session.setAttribute("idKey", mBean.getMemberId());
	}
%>
<script>
alert("<%=msg%>");
location.href = "<%=url%>";
</script>