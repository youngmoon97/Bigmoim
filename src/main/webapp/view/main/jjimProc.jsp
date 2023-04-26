<%@page import="com.mysql.cj.jdbc.ha.ReplicationMySQLConnection"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="jBean" class="model.Bean.JjimListBean"/>
<jsp:setProperty property="*" name="jBean"/>
			<%
		//String Id = request.getParameter("memberId");
		//System.out.println("jjimProc.멤버아이디값: "+Id);
		
		if(moimMgr.jjimCheck(jBean.getMemberId(),jBean.getMoimNum())){ //찜 테이블에 이미 있으면
			boolean deleteResult = moimMgr.jjimDelete(jBean.getMemberId(), jBean.getMoimNum());	//찜 데이터 삭제		
			if(deleteResult){ //찜 삭제 성공
			%>
			<script>
			//alert("찜 삭제 성공");
			history.back();
			</script>
			<%}else{ //찜 삭제 실패%>
				<script>
			//alert("찜 삭제 실패");
			history.back();
			</script>
			<% }}
		else{//찜 테이블에 없으면
		boolean result = moimMgr.jjimInsert(jBean); //찜 테이블에 추가
		if(result){ //찜 테이블에 추가성공
%>
		<script>
			//alert("찜 성공!");
			history.back();
		</script>
<%}else{ //찜 테이블에 추가실패%>
		<script>
			//alert("찜 실패");
			history.back();
		</script>
<%}
}%>