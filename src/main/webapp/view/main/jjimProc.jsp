<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="jBean" class="model.Bean.JjimListBean"/>
<jsp:setProperty property="*" name="jBean"/>
<%
		boolean result = moimMgr.jjimInsert(jBean);
		if(result){ //찜 테이블에 추가성공
%>
		<script>
			alert("찜 성공!");
			history.back();
		</script>
<%}else{ //찜 테이블에 추가실패%>
		<script>
			alert("찜 실패");
			history.back();
		</script>
<%}%>