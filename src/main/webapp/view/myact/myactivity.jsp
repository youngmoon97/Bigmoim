<%@page import="controll.Mgr.MemberMgr"%>
<%@page import="model.Bean.MoimBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file = "/view/top.jsp" %>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="myactMgr" class="controll.Mgr.MyActivityMgr"/>
<jsp:useBean id="cateMgr" class="controll.Mgr.CategoryMgr"/>
<%
	//id만 받아와서 넣으면 된다.
	mbean = mMgr.getMember(memberId);
	int businessNum = mbean.getBusinessNum();
	int taskNum = mbean.getTaskNum();
	int themeNum = mbean.getThemeNum();
	String memberAddr = mbean.getMemberAddr();
	String img = null;
	//자기지역모임
	Vector<MoimBean> addrmoim = moimMgr.areaMoimList(memberAddr);
	//가입한모임
	Vector<MoimBean> joinmoim = moimMgr.joinmoimList(memberId);
	//최근본모임
	Vector<MoimBean> recentmoim = myactMgr.rsList(memberId);
	//업무별
	Vector<MoimBean> bmoim = myactMgr.pbusinessList(businessNum);
	//직무별
	Vector<MoimBean> taskmoim = myactMgr.ptaskList(taskNum);
	//테마별
	Vector<MoimBean> thememoim = myactMgr.pthemeList(themeNum);
	//찜목록
	Vector<MoimBean> jjimList = moimMgr.jjimList(memberId);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="/bigmoim/view/css/main.css" />
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
  <body style = "padding-top: 150px">
    <!-- 상단 -->
    
    
    <!-- 가입한모임 -->
	<% 
	if(joinmoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">가입한 모임이 아직 없습니다. 주변 모임 추천해드려요~</p>
      </div>
    </article>
    <div class="card-group">
    <!-- 가입안하면 본인 지역 모임 전부 출력 -->
    		<% 
    		for(int i=0;i<addrmoim.size();i++){
    			MoimBean moimbean = addrmoim.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
    		<% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			//System.out.println("img : "+img);
    		%>
    		
          <img src=<%=img %> alt="Image">
          <form name="jjimFrm" action="../main/jjimProc.jsp" method="get">		
         <button class="like-btn" id="area-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value="" style="margin-top: 0;"><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    		
    		<%} //--for%>
    		</div><!--card-group-->
    <%}else{//--if-else %>
    <!-- 가입한 모임이 있을때 -->
    		<article>
      			<div class = "text">
		        <p class = "join-text">가입한 모임</p>
 	     		</div>
    		</article>
    	
    		
    		<div class="card-group">
    		<% 
    		for(int i=0;i<joinmoim.size();i++){
    			MoimBean moimbean = joinmoim.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    			
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			//System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          	    <form name="jjimFrm" action="../main/jjimProc.jsp" method="get">		
         <button class="like-btn" id="joinMoim-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
			
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value="" style="margin-top: 0;"><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    	
    		
    		<%}%> <!-- for -->
    		</div> <!-- card-group -->
    <%}//--if-else %>
    <hr>
    
   <!-- 찜목록 -->
	<% 
	if(jjimList.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">찜한 모임이 아직 없습니다!</p>
      </div>
    </article>
    
    <%}else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text">찜 목록</p>
 	     		</div>
    		</article>
    	
    		<div class="card-group">
    		<% 
    		for(int i=0;i<jjimList.size();i++){
    			MoimBean moimbean = jjimList.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    			
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			//System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          	    <form name="jjimFrm" action="../main/jjimProc.jsp" method="get">		
         <button class="like-btn" id="joinMoim-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
			
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value="" style="margin-top: 0;"><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    	
    		
    		<%}%> <!-- for -->
    		</div> <!-- card-group -->
    <%}//--if-else %>
    <hr>
      <!-- 최근본모임 -->
    <% if(recentmoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text"></p>
      </div>
    </article>

    
    <div class="card-group">
  	<!-- 최근 본 모임이 없음 -->
	</div><!--card-group-->
    <%}else{//--if-else %>
    		<!-- <article>
      			<div class = "text">
		        <p class = "join-text">최근 본 모임</p>
 	     		</div>
    		</article> -->

    		<div class="card-group">
    		<% 
    		for(int i=0;i<recentmoim.size();i++){
    			MoimBean moimbean = recentmoim.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			//System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          
    
			 
         <button class="like-btn" id="recentSeen-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
		
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
		<h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        	</a>
  </article>
  <%}%><!--for-->
</div><!--card-group-->
<%}//--if-else %>

    <br>
    <!-- 업무별 모임 -->
    <% if(bmoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">업무별 모임이 아직 없습니다. 회원님 주변 모임 추천드려용</p>
      </div>
    </article>
    
    <div class="card-group">
    <!-- 업무 선택안해서 본인 지역 모임 전부 출력 -->
    		<% 
    		for(int i=0;i<addrmoim.size();i++){
    			MoimBean moimbean = addrmoim.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			//System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          
    
         <button class="like-btn" id="business-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
		
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
		<h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    		

    		<%}%><!--for-->
</div><!--card-group-->
    <%}else{//--if-else %>
    
    		<article>
      			<div class = "text">
		        <p class = "join-text">업무 맞춤 모임</p>
 	     		</div>
    		</article>
    		
    		<div class="card-group">
    		<% 
    		for(int i=0;i<bmoim.size();i++){
    			MoimBean moimbean = bmoim.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">

          <%if (memberId!="null"){%> 
         <button class="like-btn" id="businessReco-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: black; width: 100px; height: 100px;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
			<%} %>
		
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>

    		<%}%><!--for-->
</div><!--card-group-->

<%}//--if-else %>
    
    
    <hr>
    
    <!-- 직무별 모임 -->
    <% if(taskmoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">직무별 모임이 아직 없습니다. 추천해드려요</p>
      </div>
    </article>
    <!-- 업무 선택안해서 본인 지역 모임 전부 출력 -->
    
    <div class="card-group">
    		<% 
    		for(int i=0;i<addrmoim.size();i++){
    			MoimBean moimbean = addrmoim.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			//System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          
       
         <button class="like-btn" id="task-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
		
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
		<h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>


    		<%}%><!--for-->
</div><!--card-group-->
    <% }else{//--if-else %>
    
    		<article>
      			<div class = "text">
		        <p class = "join-text">직무 맞춤 모임</p>
 	     		</div>
    		</article>
    		
    		<div class="card-group">
    		<% 
    		for(int i=0;i<taskmoim.size();i++){
    			MoimBean moimbean = taskmoim.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			//System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
 
         <button class="like-btn" id="taskReco-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
		<h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>

    		<%}%><!--for-->
</div><!--card-group-->
<%}//--if-else %>

    <hr>
    <!-- 테마별 모임 -->
    <% if(thememoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">테마별 모임이 아직 없습니다. 추천해드려요</p>
      </div>
    </article>
    
    <!-- 업무 선택안해서 본인 지역 모임 전부 출력 -->
    <div class="card-group">
    		<% 
    		for(int i=0;i<addrmoim.size();i++){
    			MoimBean moimbean = addrmoim.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">

         <button class="like-btn" id="theme-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
		<h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>

    		<%}%><!--for-->
</div><!--card-group-->
    <%}else{//--if-else %>
    
    		<article>
      			<div class = "text">
		        <p class = "join-text">테마 맞춤 모임</p>
 	     		</div>
    		</article>
    		
    		<div class="card-group">
    		<% 
    		for(int i=0;i<thememoim.size();i++){
    			MoimBean moimbean = thememoim.get(i);
    			int cNum = moimbean.getCategoryNum();
    			String cName = cateMgr.categoryName(cNum);
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			//System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">

         <button class="like-btn" id="themeReco-like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>
    		<%}%><!--for-->
    		<input type="hidden" name ="jjimNum" value="">
    		<input type="hidden" name ="memberId" value="<%=memberId %>">
    		<input type="hidden" name ="moimNum" value="">
    		<input type="hidden" name ="classNum" value="">
    		</form>
			</div><!--card-group-->
			<%}//--if-else %>
    
    

    <script>
      //const moreBtn = document.querySelector(".more");
      //const hiddenCategory = document.querySelector(".hidden-category");

      //moreBtn.addEventListener("click", function() {
        //if (hiddenCategory.style.display === "none") {
       // hiddenCategory.style.display = "flex";
      //} else {
      //  hiddenCategory.style.display = "none";
      //}
      //});
      
      function likeBtnChange(num) {
      	//Proc에 보내기
      	//document.jjimFrm.submit();
      	//alert(num); //정상적으로 나옴
      	let jjimFrm = document.forms["jjimFrm"];
      	jjimFrm.moimNum.value = num;
          jjimFrm.submit();
      	//$("#jjimFrm").submit();
      	
      	//색상 변경
  		let likeBtn = document.getElementById("heart"+ num)
  		if(likeBtn.className == "far fa-heart"){//빈 하트면
  			likeBtn.className = "fas fa-heart" //꽉찬 하트로
  		}else if(likeBtn.className == "fas fa-heart"){//꽉찬 하트면
  			likeBtn.className = "far fa-heart"//빈 하트로
  		}
      }
    </script>
</div>
<!-- bottom.jsp -->
    <%@ include file = "/view/bottom.jsp" %>
</body>
</html>