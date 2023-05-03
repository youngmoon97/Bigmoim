<%@page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="moimBean" class="model.Bean.MoimBean"/>


<%  
	final String SAVEFOLDER = "C:/Jsp/bigmoim/src/main/webapp/image/";
	final String ENCODING = "UTF-8";
	final int MAXSIZE = 1024*1024*20;
	
	//String memberId = (String)session.getAttribute("idKey");
	/*moimBean.setMemberId(memberId);
	int moimOrclass = Integer.parseInt(request.getParameter("moimtype"));
	moimBean.setMoimOrclass(moimOrclass);
	String classprice = request.getParameter("classprice");
	moimBean.setClassprice(classprice);
	System.out.print(moimBean.getMemberId());*/
    boolean result = moimMgr.moimInsert(request);
   	
   String msg = "모임개설 실패";
   String url = "makemoim.jsp";
   
   if(result){
      msg = "개설성공";
      url = "/bigmoim/view/main/main.jsp";
   }
   System.out.print(result);
%>

<script>
alert("<%=msg%>");
location.href = "<%=url%>";
</script>