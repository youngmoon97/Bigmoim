<%@page import="model.Bean.MoimBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="moimMemberBean" class="model.Bean.MoimMemberBean"/>
<jsp:useBean id="moimJoinBean" class="model.Bean.MoimJoinBean"/>

<%
		String flag = request.getParameter("mjflag");
		String memberId = request.getParameter("memberId");
		int moimNum = Integer.parseInt(request.getParameter("moimNum"));
		boolean result = false;
		String msg = "회원 가입 거절";
		String url= "moimMemberManage.jsp?moimNum="+moimNum;
		System.out.println("flag : "+ flag);
		
		if(flag.equals("true")){ //가입수락
			result = moimMgr.mjAccept(memberId, moimNum);
			System.out.println("result : "+ result);
			if(result){	
				msg="회원 가입 수락";
			}else{
				msg="회원 가입 수락 오류";
				url="javascript:history.back()";
			}
		}else if(flag.equals("false")){
			result=moimMgr.mjDelete(memberId, moimNum);
			if(result){
				msg = "회원 가입 거절";
				
			}else{
				msg = "회원 가입 거절 오류";
				url="javascript:history.back()";
			}
		}		
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>