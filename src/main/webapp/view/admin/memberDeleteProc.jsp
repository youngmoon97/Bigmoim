<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="mBean" class="model.Bean.MemberBean"/>
<jsp:setProperty property="*" name ="mBean"/>
<%
		mMgr.deleteMember(mBean.getMemberId());
%>
<script>
alert("회원 추방함");
location.href = "memberManage.jsp";
</script>
