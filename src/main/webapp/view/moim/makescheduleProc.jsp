<%@ page import="model.Bean.MoimScheduleBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="msbean" class="model.Bean.MoimScheduleBean"/>
<jsp:setProperty property="*" name="msbean"/>
<%	
	boolean flag = moimMgr.msInsert(msbean);
	System.out.println(msbean.getMsArea());
	String msg = "일정 등록 실패";
	String url = "makeschedule.jsp?memberId="+msbean.getMemberId()+"&num="+msbean.getMoimNum();
	if(flag){
		msg = "일정 등록 완료";
		url = "moimdetail.jsp?num="+msbean.getMoimNum();
	}
%>
<script>

alert("<%=msg%>");
location.href="<%=url%>";
</script>