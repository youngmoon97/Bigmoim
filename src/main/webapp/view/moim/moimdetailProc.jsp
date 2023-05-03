<%@page import="model.Bean.ClassCommentBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="ccMgr" class="controll.Mgr.ClassCommentMgr"/>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="ccBean" class="model.Bean.ClassCommentBean"/>
<%
	String memberId = request.getParameter("memberId");
	//System.out.println("아니왜 안뜨냐고"  + memberId);
	
	int no = Integer.parseInt(request.getParameter("num"));
	String ccComment = request.getParameter("ccComment");
	//System.out.print(no +"번호" + memberId +"입니다");
	String msg = "댓글을 등록할 수 없습니다.";
	String url = "moimdetail.jsp?num="+no;
	ccBean.setMemberId(memberId);
	ccBean.setCcComment(ccComment);
	ccBean.setMoimNum(no);
	int ccNum = ccMgr.getCcNum(memberId, no, ccComment);
	boolean flag = ccMgr.ccInsert(ccBean);
	
	//System.out.print(flag +"입니다");
	
	if(flag){
		msg = "댓글이 등록되었습니다.";
		
	}
	
	
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>