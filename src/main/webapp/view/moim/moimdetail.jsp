<%@page import="org.eclipse.jdt.internal.compiler.batch.ClasspathJmod"%>
<%@page import="java.util.stream.Collectors"%>
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
// String memberId = (String)session.getAttribute("idKey");
	//moimNum받아옴.
	int no = Integer.parseInt(request.getParameter("num"));
	System.out.print(no + "뭐야?");
	//모임상세 mgr 가져옴
	MoimBean moimbean = moimMgr.moimDetail(no);
	int moimChk = moimbean.getMoimOrclass();
	System.out.println(moimbean.getMoimOrclass());
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
	//일정 참여한 멤버 이름,소개,프로필,id 가져오기
	Vector<MemberBean> moimschvlist = sjMgr.moimScheduleMember(no);
	//모임에서 가입한 전체 멤버 이름,소개,프로필사진,id 가져오기
	Vector<MemberBean> moimAllMemvlist = sjMgr.moimScheduleAllMember(no);
	//같은 모임에 일정이 1개 이상이 될때 구별해서 가져오기
	Vector<ScheduleJoinBean> scheduleJoinMsvList = sjMgr.scheduleJoinMsvList(no);
	//모임장 추출
	MemberBean manngerBean = sjMgr.moimManager(no);
	//클래스만 추출(모임 빼고);
	Vector<MoimBean> allmoimList = moimMgr.moimAllList();
//	System.out.print(manngerBean.getMemberId());
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
    	
    	footer ul {
  			padding-left: 9cm;
		}

		footer p {
			padding-right: 10cm;
		}
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  </head>
   <body style = "padding-top: 150px">
   
  <%if(moimChk==1){ %>
  <!-- 클래스모임디테일 -->
  <!-- 메인 -->     
      <div class="mainwrapper content1">
        <div class="clubdetail">
          <div class="category">
            <div class="image-wrapper">
              <img src="<%="/bigmoim/image/"+ cabean.getCategoruImg() %>" alt="카테고리이미지" />
            </div>
          </div>
          <div class="clubdetail-moim">
            <h4 class="clubdetail-moimname" name="moimName"><%=moimbean.getMoimName()%></h4>
            <ul class="clubdetail-area">
              <li class="clubdetail-moimarea" name="moimArea">
                <%=moimbean.getMoimArea() %>
              </li>
              <li class="moimarea-line">|</li>
              <li class="clubdetail-membercount" name="moimNCount">멤버&nbsp;<%=moimAllMemvlist.size() %></li>
              <li><img class="clubdetail-jjim" src="/bigmoim/image/heart.png" name="jjim" /></li>
              <li><button class="moimEditorBtn" >수정하기</button></li>
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
          <h2>클래스일정</h2>
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
							<li class="ico cost" name=""><%=moimbean.getClassprice() %></li>
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
					<h4 name="msNCount">참여 멤버(<%=moimschvlist.size() %>/<%=msbean.getMsHCount() %>)</h4>
		            <div class="container">
		              <%
		              	if(moimschvlist.isEmpty()){
		              %>
		              <div class="noMemberTxt">
			          		<h4 class="memTxt">참여 멤버가 없습니다.</h4>
			          </div>
		              <%}else{
		            	  for(int j=0;j<moimschvlist.size();j++){
		            		//MemberBean memberBean = moimschvlist.get(j);
		          			MemberBean memberbean = moimschvlist.get(j);
		              %>
	              		<div class="joinMemberImg">
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
	          <li class="tab-link current" name="msTime" onclick="change(0)"><a href="javascript:void(0)">전체멤버</a></li>
	          <%
	          	if(msvlist!=null){
	          		for(int i=0;i<msvlist.size();i++){
	          			MoimScheduleBean msbean = msvlist.get(i);
	          %>
	          	<li class="tab-link current" name="msTime" onclick="change(<%=msbean.getMsNum() %>)"><a href="javascript:void(0)"><%=mmDay%>월<%=mjDay%>일</a></li>
	          	<%} %><!-- for -->
	          <%} %><!-- if -->

	        </ul>
	        <div class="tabcontent tab0">
	          <h3 name="msNCount">모임멤버(<%=moimAllMemvlist.size() %>)</h3>
	          <div class="manager"></div>
	          <ul class="tabcontent-list">
	            <li class="tabcontent-list-img " name="memberImg"><img src="/bigmoim/image/<%=manngerBean.getMemberImg()%>" class="memberImg" /></li>
	            <li>
	              <ul class="tabcontent-list-detail">
	              	<li class="tabcontent-list-name" name="memberName"><%=manngerBean.getMemberName() %></li>
	                <li class="tabcontent-list-hello" name="memberProfile"><%=manngerBean.getMemberProfile() %></li>
	              </ul>
	            </li> 
	          </ul>
	          <%
	      		for(int i=0;i<moimAllMemvlist.size();i++){
	      			//System.out.println(moimAllMemvlist.get(i).getMemberId());
	      			if(!manngerBean.getMemberId().equals(moimAllMemvlist.get(i).getMemberId())){
	      				MemberBean membean = moimAllMemvlist.get(i);
	       	  %>
	          <ul class="tabcontent-list">
	            <li class="tabcontent-list-img" name="memberImg"><img src="/bigmoim/image/<%=membean.getMemberImg()%>" class="memberImg"/></li>
	            <li>
	              <ul class="tabcontent-list-detail">
	                <li class="tabcontent-list-name" name="memberName"><%=membean.getMemberName() %></li>
	                <li class="tabcontent-list-hello" name="memberProfile"><%=membean.getMemberProfile() %></li>
	              </ul>
	            </li> 
	          </ul>
	          <%} %>
	          <%} %>  
	        </div>
			<% 
			for(int z=0;z<msvlist.size();z++){
				MoimScheduleBean moimScheduleBean = msvlist.get(z);
				// Vector<ScheduleJoinBean> filteredList = scheduleJoinMsvList.stream().filter(item -> item.getMsNum() == moimScheduleBean.getMsNum()).collect(Collectors.toCollection(Vector::new));
				Vector<ScheduleJoinBean> filteredList = new Vector<ScheduleJoinBean>();
				for(ScheduleJoinBean bean : scheduleJoinMsvList){
					if(bean.getMsNum() == moimScheduleBean.getMsNum()){
						filteredList.addElement(bean);
					}
				}				
			%>
			<div class="tabcontent tab<%=moimScheduleBean.getMsNum() %>" style="display: none" >
	          <h3 name="msNCount">모임멤버(<%=filteredList.size() %>)</h3>
	          <%
	          	if(moimschvlist.isEmpty()){
	          %>
	          	<li><h3>참여멤버가 없습니다.</h3></li>
	          <%}else{		
            	  for(int j=0;j<moimschvlist.size();j++){
            		  MemberBean memberBean = moimschvlist.get(j);
            		  // filteredList.stream().filter(item -> item.getMemberid().equals(memberBean.getMemberId())).count() > 0
            		  Vector<ScheduleJoinBean> memberFilteredList = new Vector<ScheduleJoinBean>();
      				for(ScheduleJoinBean bean : filteredList){
    					if(bean.getMemberid().equals(memberBean.getMemberId())){
    						memberFilteredList.addElement(bean);
    					}
    				}	
					if(memberFilteredList.size() > 0){
	          %>
	          	<ul class="tabcontent-list">
		            <li class="tabcontent-list-img" name="memberImg"><img src="/bigmoim/image/<%=memberBean.getMemberImg()%>" class="memberImg"/></li>
		            <li>
		              <ul class="tabcontent-list-detail">
		                <li class="tabcontent-list-name" name="memberName"><%=memberBean.getMemberName() %></li>
		                <li class="tabcontent-list-hello" name="memberProfile"><%=memberBean.getMemberProfile() %></li>
		              </ul>
		            </li>
	            </ul>
	            <% } } %> 
	          <%} %>  
	        </div>
	        <%} %>  
     	<%}else {%>
	      	<ul class="tabnav">
	          <li class="tab-link current" name="msTime"><a href="#tab01">전체멤버(0)</a></li>
	        </ul>
	        <div class="tabcontent">
              <ul class="tabcontent-list">
                <li>가입된 멤버가 없습니다.</li>
              </ul>
	        </div>
      <%} %>
      </div>
      </div>

      <!--  
      <a id="topBtn" href="#">top</a>
      -->
      <!-- 하단 -->

    </div>
  <%}else if(moimChk==2){ %>
  <!-- 모임디테일 -->
  <!-- 메인 -->     
      <%@ include file = "/view/moimdetailtop.jsp" %>
      <div class="mainwrapper content1">
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
              <li class="clubdetail-membercount" name="moimNCount">멤버&nbsp;<%=moimAllMemvlist.size() %></li>
              <li><img class="clubdetail-jjim" src="/bigmoim/image/heart.png" name="jjim" /></li>
              <li><button class="moimEditorBtn">수정하기</button></li>
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
          			System.out.println("2");
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
					<h4 name="msNCount">참여 멤버(<%=moimschvlist.size() %>/<%=msbean.getMsHCount() %>)</h4>
		            <div class="container">
		              <%
		              	if(moimschvlist.isEmpty()){
		              %>
		              <div class="noMemberTxt">
			          		<h4 class="memTxt">참여 멤버가 없습니다.</h4>
			          </div>
		              <%}else{
		            	  for(int j=0;j<moimschvlist.size();j++){
		            		  System.out.println("3");
		            		//MemberBean memberBean = moimschvlist.get(j);
		          			MemberBean memberbean = moimschvlist.get(j);
		              %>
	              		<div class="joinMemberImg">
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
	          <li class="tab-link current" name="msTime" onclick="change(0)"><a href="javascript:void(0)">전체멤버</a></li>
	          <%
	          	if(msvlist!=null){
	          		for(int i=0;i<msvlist.size();i++){
	          			System.out.println("4");
	          			MoimScheduleBean msbean = msvlist.get(i);
	          %>
	          	<li class="tab-link current" name="msTime" onclick="change(<%=msbean.getMsNum() %>)"><a href="javascript:void(0)"><%=mmDay%>월<%=mjDay%>일</a></li>
	          	<%} %><!-- for -->
	          <%} %><!-- if -->

	        </ul>
	        <div class="tabcontent tab0">
	          <h3 name="msNCount">모임멤버(<%=moimAllMemvlist.size() %>)</h3>
	          <div class="manager"></div>
	          <ul class="tabcontent-list">
	            <li class="tabcontent-list-img " name="memberImg"><img src="/bigmoim/image/<%=manngerBean.getMemberImg()%>" class="memberImg" /></li>
	            <li>
	              <ul class="tabcontent-list-detail">
	              	<li class="tabcontent-list-name" name="memberName"><%=manngerBean.getMemberName() %></li>
	                <li class="tabcontent-list-hello" name="memberProfile"><%=manngerBean.getMemberProfile() %></li>
	              </ul>
	            </li> 
	          </ul>
	          <%
	      		for(int i=0;i<moimAllMemvlist.size();i++){
	      			System.out.println("5");
	      			//System.out.println(moimAllMemvlist.get(i).getMemberId());
	      			if(!manngerBean.getMemberId().equals(moimAllMemvlist.get(i).getMemberId())){
	      				MemberBean membean = moimAllMemvlist.get(i);
	       	  %>
	          <ul class="tabcontent-list">
	            <li class="tabcontent-list-img" name="memberImg"><img src="/bigmoim/image/<%=membean.getMemberImg()%>" class="memberImg"/></li>
	            <li>
	              <ul class="tabcontent-list-detail">
	                <li class="tabcontent-list-name" name="memberName"><%=membean.getMemberName() %></li>
	                <li class="tabcontent-list-hello" name="memberProfile"><%=membean.getMemberProfile() %></li>
	              </ul>
	            </li> 
	          </ul>
	          <%} %>
	          <%} %>  
	        </div>
			<% 
			for(int z=0;z<msvlist.size();z++){
				System.out.println("6");
				MoimScheduleBean moimScheduleBean = msvlist.get(z);
				// Vector<ScheduleJoinBean> filteredList = scheduleJoinMsvList.stream().filter(item -> item.getMsNum() == moimScheduleBean.getMsNum()).collect(Collectors.toCollection(Vector::new));
				Vector<ScheduleJoinBean> filteredList = new Vector<ScheduleJoinBean>();
				for(ScheduleJoinBean bean : scheduleJoinMsvList){
					System.out.println("7");
					if(bean.getMsNum() == moimScheduleBean.getMsNum()){
						filteredList.addElement(bean);
					}
				}				
			%>
			<div class="tabcontent tab<%=moimScheduleBean.getMsNum() %>" style="display: none" >
	          <h3 name="msNCount">모임멤버(<%=filteredList.size() %>)</h3>
	          <%
	          	if(moimschvlist.isEmpty()){
	          %>
	          	<li><h3>참여멤버가 없습니다.</h3></li>
	          <%}else{		
            	  for(int j=0;j<moimschvlist.size();j++){
            		  System.out.println("8");
            		  MemberBean memberBean = moimschvlist.get(j);
            		  // filteredList.stream().filter(item -> item.getMemberid().equals(memberBean.getMemberId())).count() > 0
            		  Vector<ScheduleJoinBean> memberFilteredList = new Vector<ScheduleJoinBean>();
      				for(ScheduleJoinBean bean : filteredList){
      					System.out.println("9");
    					if(bean.getMemberid().equals(memberBean.getMemberId())){
    						memberFilteredList.addElement(bean);
    					}
    				}	
					if(memberFilteredList.size() > 0){
	          %>
	          	<ul class="tabcontent-list">
		            <li class="tabcontent-list-img" name="memberImg"><img src="/bigmoim/image/<%=memberBean.getMemberImg()%>" class="memberImg"/></li>
		            <li>
		              <ul class="tabcontent-list-detail">
		                <li class="tabcontent-list-name" name="memberName"><%=memberBean.getMemberName() %></li>
		                <li class="tabcontent-list-hello" name="memberProfile"><%=memberBean.getMemberProfile() %></li>
		              </ul>
		            </li>
	            </ul>
	            <% } } %> 
	          <%} %>  
	        </div>
	        <%} %>  
     	<%}else {%>
	      	<ul class="tabnav">
	          <li class="tab-link current" name="msTime"><a href="#tab01">전체멤버(0)</a></li>
	        </ul>
	        <div class="tabcontent">
              <ul class="tabcontent-list">
                <li>가입된 멤버가 없습니다.</li>
              </ul>
	        </div>
      <%} %>
      </div>
      </div>

      <!--  
      <a id="topBtn" href="#">top</a>
      -->
      <!-- 하단 -->


    </div>
  <%} %>
	<div class="btn_gotop" style="position:fixed; bottom:220px; right:240px; z-index:99;"> 
		<a href="/bigmoim/view/moim/joinmoim.jsp">
		  <img src="/bigmoim/image/가입하기버튼.png"> 
		</a>
	</div>
    <script>
	    const change = (num) =>{
	    	const tabList = document.querySelectorAll(".tabcontent");
	    	tabList.forEach((el) => (el.style.display = "none"));
	    	const nowTab = document.querySelector(".tab"+ num);
	    	nowTab.style.display = "block";
	    };
	    
	    $(window).scroll(function(){
	    	if ($(this).scrollTop() > 600){
	    		$('.btn_gotop').show();
	    	} else{
	    		$('.btn_gotop').hide();
	    	}
	    });
	    $('.btn_gotop').click(function(){
	    	$('html, body').animate({scrollTop:0},700);
	    	return false;
	    });
	    
	    function row_scroll(){
	        $(".container .joinMemberImg").on('mousewheel',function(e){
	          var wheelDelta = e.originalEvent.wheelDelta;
	          if(wheelDelta > 0){
	            $(this).scrollLeft(-wheelDelta + $(this).scrollLeft());
	          } else{
	            $(this).scrollLeft(-wheelDelta + $(this).scrollLeft());
	          }
	        });
	      }
	      row_scroll();

  </script>
  <!-- bottom.jsp -->
    <%@ include file = "/view/bottom.jsp" %>
  </body>
</html>
