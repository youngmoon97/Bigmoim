<%@page import="model.Bean.MoimScheduleBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Bean.MoimBean"%>	
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="scMgr" class="controll.Mgr.ScheduleJoinMgr"/>
<%@ include file = "/view/top.jsp" %>
<%
	Vector<MoimScheduleBean> scheduleList = scMgr.allmoimScheduleList();
	Vector<MemberBean> joinmember = null;
%>

<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="/bigmoim/view/css/moimschedule.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    	
    	footer ul {
  			padding-left: 9cm;
		}

		footer p {
			padding-right: 10cm;
		}
		
    </style>
  </head>
<body style="min-height: 100vh; display: flex; flex-direction: column; padding-top: 150px;">
  <!-- 카테고리 -->
  <%@ include file = "/view/category.jsp" %>
  
  <!-- 모임일정 리스트 -->
  <div class="container" style="width: 1300px; margin: 0 auto;">
    <%if(scheduleList.isEmpty()){ %>
    <article>
      <div class = "text">
        <p class = "join-text"> 모임 일정이 없습니다. </p>
      </div>
    </article>
    <%}else{ %>
    <article>
      <div class = "text">
        <p class = "join-text"> 모임 일정입니다. </p>
      </div>
    </article>
    <%
      for(int i=0;i<scheduleList.size();i++){
        MoimScheduleBean bean = scheduleList.get(i);
      %>
	<a href="moimdetail.jsp?num=<%=bean.getMoimNum() %>">
	<div class="cards">     
		<div class="wrapper">
	  	<div class="moim-image">
	    	<img src="/bigmoim/image/<%=bean.getMoimImg() %>" alt="모임 이미지" />
	  	</div>
	  <div class="info">
	    <div class="info-inner">
	      <div class="title">
	        
	        <h1 class="msTitle"><strong><%=bean.getMsTitle() %></h2>	
	      </strong></div>
	      <div class="content" style="line-height: 1.2;">
		  <p class="msArea"><%=bean.getMsArea() %></p>
		  <p class="msDate"><%=bean.getMsDate() %></p>
		  <p class="msContent"><%=bean.getMsContent() %></p>
			</div>
	      <div class="members">
	        <div class="member-list">
	          <% 
	            joinmember = scMgr.moimScheduleMember(bean.getMsNum());
	          	//System.out.println("joinmember : "+i+ bean.getMsNum());
	          if(joinmember.isEmpty()){%>
	        	  <h4>참여 멤버가 없습니다.</h4>
	          <%}else{
	            for(int j=0;j<joinmember.size();j++){
	              	mbean = joinmember.get(j);
		          	//System.out.println("mbean : "+ mbean.getMemberImg());
		          	//System.out.println("mbean : "+ joinmember.get(i).getMemberImg());

	          %>
	          <img src="/bigmoim/image/<%=mbean.getMemberImg() %>" alt="멤버 이미지1" />
	          <%}
	          }%>
	          <span class="member-count"></span>
	        </div>
	      </div>
	    </div>
	  </div>
	</div>
</div>
</a>
      <% }//--for 
    }//--if-else 젤큰 ifelse %>
  </div>
  <!-- 하단 -->
  <%@ include file = "/view/bottom.jsp" %>
</body>

</html>
</html>
