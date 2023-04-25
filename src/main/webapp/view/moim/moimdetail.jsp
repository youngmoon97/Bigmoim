<%@page import="model.Bean.MoimScheduleBean"%>
<%@page import="model.Bean.ScheduleJoinBean"%>
<%@page import="model.Bean.MoimBean"%>
<%@page import="model.Bean.MoimCategoryBean"%>
<%@page import="java.util.Vector"%>
<%@ include file = "/view/top.jsp" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="cateMgr" class="controll.Mgr.CategoryMgr"/>
<jsp:useBean id="sjMgr" class="controll.Mgr.ScheduleJoinMgr"/>

<%
	//moimNum받아옴.
	int no = Integer.parseInt(request.getParameter("num"));
	System.out.print(no);
	//모임상세 mgr 가져옴
	MoimBean moimbean = moimMgr.moimDetail(no);
	String img = "/bigmoim/image/"+moimbean.getMoimImg();
	System.out.print("img : " + img);
	//moimnum을 받아서 해당 카테고리 이미지 가져옴.
	MoimCategoryBean cabean = cateMgr.categoryImg(no);
	//모임일정테이블에서 값들 가져오기
	Vector<MoimScheduleBean> msvlist = sjMgr.moimScheduleList(no);
	//모임일정에서 일만 가져오기
	String mjDay = sjMgr.moimScheduleDay(no);
	//모임일정에서 월만 가져오기
	String mmDay = sjMgr.moimScheduleMon(no);
	//모임일정에서 요일로 추출해서 가져오기
	String mjDayName = sjMgr.moimScheduleDayName(no);
	//일정 참여한 멤버 이름,소개,프로필 가져오기
	Vector<MemberBean> moimschvlist = sjMgr.moimScheduleImg(no);
	//모임에서 가입한 전체 멤버 이름,소개,프로필사진 가져오기
	Vector<MemberBean> moimAllMemvlist = sjMgr.moimScheduleAllMember(no);
	
	
%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title name="moimName"><%=moimbean.getMoimName()%></title>
    <link type="text/css" rel="stylesheet" href="../css/clubdetail.css">
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
  </head>
  <body>


      <!-- 카테고리 -->
      <!-- 메인 -->
      <main>
        <!-- 상세 네비게이션-->
        <nav1>
          <ul class="clubdetail-nav">
            <li class="clubdetail-nav-home"><a href="#">소개</a></li>
            <li class="clubdetail-nav-line1">|</li>
            <li class="clubdetail-nav-notice"><a href="#">게시판</a></li>
            <li class="clubdetail-nav-line2">|</li>
            <li class="clubdetail-nav-notice"><a href="#">사진첩</a></li>
          </ul>
        </nav1>
        <div class="clubdetail">
          <div class="category">
            <div class="image-wrapper">
              <img src="<%="/bigmoim/image/"+ cabean.getCategoruImg() %>" alt="게임 / 오락" />
            </div>
          </div>
          <div class="clubdetail-moim">
            <h4 class="clubdetail-moimname" name="moimName"><%=moimbean.getMoimName()%></h4>
            <ul class="clubdetail-area">
              <li class="clubdetail-moimarea" name="moimArea">
                <%=moimbean.getMoimArea() %>
              </li>
              <li class="moimarea-line">|</li>
              <li class="clubdetail-membercount" name="moimNCount">멤버&nbsp;<%=moimbean.getMoimNCount() %></li>
              <li><img class="clubdetail-jjim" src="./img_icon/heart.png" name="jjim" /></li>
            </ul>
          </div>
        </div>
        <div class="clubdetail-photo">
         <img
            class="clubdetail-photo-detail"
            src="<%=img %>"
            name="moimImg"
          /> 
        </div>
        <div class="clubdetail-content">
          <p name="moimProfile">
            <!-- 단락으로 들어올 시 끊어서 받을 수가 없음-->
			<%=moimbean.getMoimProfile() %>
          </p>
        </div>
        <div class="clubdetail-schedule">
          <h2>모임일정</h2>
          <ul class="meeting_list">
          	<%
          		if(msvlist.isEmpty()){
          	%>
          	<li>
          		<h4>일정이 없습니다.</h4>
          	</li>
          	<%}else{
          		for(int i=0;i<msvlist.size();i++){
          			MoimScheduleBean msbean = msvlist.get(i);
          		%>
		  	<li>
				<h2 name="msTitle"><%=msbean.getMsTitle() %></h2>
				<ul class="mlist_in">
					<li class="date" name="msTime"><%=mjDayName%><span><%=mjDay %></span></li>
					<li>
						<ul class="in_cont">
							<li class="ico calendar" name="msTime"><%=msbean.getMsTime()%></li>
							<li class="ico place" name="msArea"><%=msbean.getMsArea()%></li>
							<li class="ico cost" name="">없음</li>
						</ul>
					</li>
					<li class="btn">
						<a href="<%=moimbean.getMoimKakao() %>" class="share">
							친구에게<br />
							공유하기
						</a>
					</li>
				</ul>
				<div class="member" id="cont_1">
					<h4 name="msNCount">참여 멤버(<%=msbean.getMsNCount()%>/<%=msbean.getMsHCount() %>)</h4>
		            <div class="container">
		              <%
		              	if(moimschvlist.isEmpty()){
		              %>
			              <div>
			              	<h4>참여 멤버가 없습니다.</h4>
			              </div>
		              <%}else{
		            	  for(int j=0;j<moimschvlist.size();j++){
		            		//MemberBean memberBean = moimschvlist.get(j);
		          			MemberBean memberbean = moimschvlist.get(j);
		              %>
	              		<div>
	              			<img src="/bigmoim/image/<%=memberbean.getMemberImg()%>"/>
	           	  		</div>
	              	  <%}%><!-- for -->
		            <%}%><!-- if else -->
		          </div>
        	<%}%><!-- for -->
        <%} %><!-- if else -->
			</li>	
		  </ul>
      <div class="tab">
      	<%
      		if(moimAllMemvlist!=null){		
      	%>
      		<ul class="tabnav">
	          <li class="tab-link current" name="msTime" onclick="change(1)"><a href="javascript:void(0)">전체멤버</a></li>
	          <%
	          	if(msvlist!=null){
	          		for(int i=0;i<msvlist.size();i++){
	          			MoimScheduleBean msbean = msvlist.get(i);
	          %>
	          	<li class="tab-link current" name="msTime" onclick="change(2)"><a href="javascript:void(0)"><%=mmDay%>월<%=mjDay%>일</a></li>
	          	<%} %><!-- for -->
	          <%} %><!-- if -->
	          
	        </ul>
	        <div class="tabcontent tab1">
	          <h3 name="msNCount">모임멤버(<%=moimbean.getMoimNCount() %>)</h3>
	          <%
	      		for(int i=0;i<moimAllMemvlist.size();i++){
	      			MemberBean membean = moimAllMemvlist.get(i);
	       	  %>
	          <ul class="tabcontent-list">
	            <li class="tabcontent-list-img" name="memberImg"><img src="/bigmoim/image/<%=moimAllMemvlist.get(i).getMemberImg()%>" /></li>
	            <li>
	              <ul class="tabcontent-list-detail">
	                <li class="tabcontent-list-name" name="memberName"><%=moimAllMemvlist.get(i).getMemberName() %></li>
	                <li class="tabcontent-list-hello" name="memberProfile"><%=moimAllMemvlist.get(i).getMemberProfile() %></li>
	              </ul>
	            </li> 
	          </ul>
	          <%} %>  
	        </div>
	        <div class="tabcontent tab2" style="display: none">
		      <%
		      	for(int i=0;i<msvlist.size();i++){
		      		MoimScheduleBean moimschebean = msvlist.get(i);
		      %>
	          <h3 name="msNCount">모임멤버(<%=moimschebean.getMsNCount()%>)</h3>
	          <%} %>
	          <ul class="tabcontent-list">
	          <%
	          	if(moimschvlist.isEmpty()){
	          %>
	          	<li><h3>참여멤버가 없습니다.</h3></h4></li>
	          <%}else{ 
            	  for(int j=0;j<moimschvlist.size();j++){
            		//MemberBean memberBean = moimschvlist.get(j);
          			MemberBean memberBean = moimschvlist.get(j);
	          %>
	            <li class="tabcontent-list-img" name="memberImg"><img src="/bigmoim/image/<%=memberBean.getMemberImg()%>" /></li>
	            <li>
	              <ul class="tabcontent-list-detail">
	                <li class="tabcontent-list-name" name="memberName"><%=memberBean.getMemberName() %></li>
	                <li class="tabcontent-list-hello" name="memberProfile"><%=memberBean.getMemberProfile() %></li>
	              </ul>
	            </li>
	            <%} %> 
	          </ul>
	          <%} %>  
	        </div>
      	
     	<%}else {%>
	      	<ul class="tabnav">
	          <li class="tab-link current" name="msTime" data-tab="tab1"><a href="#tab01">전체멤버</a></li>
	        </ul>
	        <div class="tabcontent">
              <ul class="tabcontent-list">
                <li>가입된 멤버가 없습니다.</li>
              </ul>
	        </div>
      <%} %>
      </div>  
      </main>
      <!-- 하단 -->
      <footer>
        <ul>
          <li><a href="#">이용약관</a></li>
          <li><a href="#">개인정보처리방침</a></li>
          <li><a href="#">고객센터</a></li>
          <li><a href="#">대모임 소개</a></li>
          <li><a href="#">대모임 인재채용</a></li>
        </ul>
        <p>&copy; 2023 대모임</p>
      </footer>

      <script>

        
        const change = (num) =>{
        	const tabList = document.querySelectorAll(".tabcontent");
        	tabList.forEach((el) => (el.style.display = "none"));
        	const nowTab = document.querySelector(".tab"+ num);
        	nowTab.style.display = "block";
        };
  
      </script>
    </div>
  </body>
</html>
