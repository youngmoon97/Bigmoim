<%@page import="model.Bean.MoimPhotosBean"%>
<%@page import="model.Bean.BoardCommentBean"%>
<%@page import="model.Bean.MemberBoardBean"%>
<%@page import="model.Bean.ClassCommentBean"%>
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
<jsp:useBean id="ccmgr" class="controll.Mgr.ClassCommentMgr"/>
<jsp:useBean id="boardMgr" class="controll.Mgr.BoardMgr"/>
<jsp:useBean id="memberboardBean" class="model.Bean.MemberBoardBean"/>
<jsp:useBean id="boardcommentMgr" class="controll.Mgr.BoardCommentMgr"/>
<jsp:useBean id="memberMgr" class="controll.Mgr.MemberMgr"/>
<%
// String memberId = (String)session.getAttribute("idKey");
	//moimNum받아옴.
	int no = Integer.parseInt(request.getParameter("num"));
	//System.out.print(no + "뭐야?");
	//모임상세 mgr 가져옴
	MoimBean moimbean = moimMgr.moimDetail(no);
	//모임안에서 클래스를 구분하기
	int moimChk = moimbean.getMoimOrclass();
	//System.out.println(moimbean.getMoimOrclass());
	String img = "/bigmoim/image/"+moimbean.getMoimImg();
	//System.out.print("img : " + img);
	//moimnum을 받아서 해당 카테고리 이미지 가져옴.
	MoimCategoryBean cabean = cateMgr.categoryImg(no);
	//모임일정테이블에서 값들 가져오기
	Vector<MoimScheduleBean> msvlist = sjMgr.moimScheduleList(no);
	//모임일정에서 일만 가져오기
	Vector<MoimScheduleBean> sjvlist = sjMgr.moimScheduleDayList(no);
	//모임일정에서 월만 가져오기
	String mmDay = sjMgr.moimScheduleMon(no);
	//모임일정에서 요일로 추출해서 가져오기
	String mjDayName = sjMgr.moimScheduleDayName(no);
	
	//모임에서 가입한 전체 멤버 이름,소개,프로필사진,id 가져오기
	Vector<MemberBean> moimAllMemvlist = sjMgr.moimScheduleAllMember(no);
	//같은 모임에 일정이 1개 이상이 될때 구별해서 가져오기
	Vector<ScheduleJoinBean> scheduleJoinMsvList = sjMgr.scheduleJoinMsvList(no);
	//모임장 추출
	MemberBean manngerBean = sjMgr.moimManager(no);
	//클래스만 추출(모임 빼고);
	Vector<MoimBean> allmoimList = moimMgr.moimAllList();
	//클래스 댓글 리스트
	Vector<ClassCommentBean> ccList = ccmgr.ccList(no);
//	System.out.print(manngerBean.getMemberId());
//-----------------------게시판-------------------------------------------------------
	Vector<MemberBoardBean> boardvlist = boardMgr.boardList(no);
//-----------------------사진첩-------------------------------------------------------
    Vector<MoimPhotosBean> moimphotovlist = moimMgr.getmoimImgList(no);
    boolean result = moimMgr.getMoimMemberId(memberId, no);     


%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title name="moimName"><%=moimbean.getMoimName()%></title>
    <link type="text/css" rel="stylesheet" href="../css/clubdetail.css">
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
   
  <%if(moimChk==1){ %>
  <!-- 클래스모임디테일 -->
  <!-- 메인 -->     
      <div class="mainwrapper">
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
               <form name="jjimFrm_class" action="../main/jjimProc.jsp" method="get">
                 <button  id="detailjjim_class"
	          onclick="likeBtnChange_class(<%=moimbean.getMoimNum()%>)" 
	          style="color : red;  
	          background-color: transparent;
			  border: none;
			  font-size: 24px;
			  cursor: pointer;
			  width: 30px;
			  height: 30px;">
	  			<i id="heart_class_<%=moimbean.getMoimNum() %>"
	  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
	  			class = "fas fa-heart" style="display: inline-block; width: 100%; height: 100%;"<% } else{%>
	  			class = "far fa-heart" style="display: inline-block; width: 100%; height: 100%;"
	  			<%}%>
	  			></i>
			</button>
              <%if(memberId==null){ %>
              <%}else if(manngerBean.getMemberId().equals(memberId)){%>
              <li><button type="button" class="moimEditorBtn" onclick="moimUpdate_class()">내클래스관리</button></li>
              <li><button type="button" class="classManageBtn" onclick="memberManage_class()">클래스회원관리</button></li>
              
              <%}%>
              	<input type="hidden" name ="jjimNum" value="">
    			<input type="hidden" name ="memberId" value="<%=memberId %>">
    			<input type="hidden" name ="moimNum" value="<%=no%>">
    		</form>
            </ul>
          </div>
        </div>
        <!-- 클래스 대표 이미지 -->
        <div class="clubdetail-photo">
         <img
            class="clubdetail-photo-detail"
            src="<%=img %>"
            name="moimImg"
          /> 
        </div>
        <!-- 클래스 소개 -->
        <div class="clubdetail-content">
          <p name="moimProfile">
            <!-- 단락으로 들어올 시 끊어서 받을 수가 없음-->
			<%=moimbean.getMoimProfile() %>
          </p>
        </div>
        <!-- 클래스 일정 -->
        <div class="clubdetail-schedule">
          <div style="display: flex;">
          	<h2 class="clubdetail-text" style="margin: 0px;">클래스일정</h2>
          	<%if(manngerBean.getMemberId().equals(memberId)){%>
          	<a href="makeschedule.jsp?memberId=<%=memberId%>&moimNum=<%=no%>">
          		<img alt="모임일정 생성" src="../../image/플러스버튼.png" width="30" height="30" style="margin-left: 10px">
          	</a>
          	<%} %>
          </div>
          <ul class="meeting_list">
          	<%
          		if(msvlist.isEmpty()){
          	%>
          	<div>
          		<h4>일정이 없습니다.</h4>
          	</div>
          	<%}else{
          		for(int i=0;i<msvlist.size();i++){
          			MoimScheduleBean msbean = msvlist.get(i);
          			//일만 받아오는 리스트
          			MoimScheduleBean moimschbean = sjvlist.get(i);
          			//msNum기준으로 일정 참여 멤버 가져오기
          			Vector<MemberBean> moimScheduleMember = sjMgr.moimScheduleMember(msbean.getMsNum());
          		%>
		  	<li>
				<h2 name="msTitle"><%=msbean.getMsTitle() %></h2>
				<ul class="mlist_in">
					<li class="date" name="msTime"><%=mjDayName%><span><%=moimschbean.getMsDate() %></span></li>
					<li>
						<ul class="in_cont">
							<li class="ico calendar" name="msTime"><%=msbean.getMsDate()%>&nbsp;<%=msbean.getMsTime()%></li>
							<li class="ico place" name="msArea"><%=msbean.getMsArea()%></li>
							<li class="ico cost" name=""><%=moimbean.getClassprice() %></li>
						</ul>
					</li>
					<li class="btn">
						<%
					if(moimScheduleMember.size() < msbean.getMsHCount()){
					boolean memberChk = sjMgr.moimMemberCheck(no, memberId);
					if(memberChk){
						%>
						<a href="schedulejoinProc.jsp?moimNum=<%=no %>&memberId=<%=memberId %>&msNum=<%=msbean.getMsNum() %>" class="share">
							일정<br />
							참여
						</a>
					<% 
						}
					}else{%>
						<a>
						인원<br />
						초과
					</a>
					<% }
					%>
					</li>
				</ul>
				<div class="member" id="cont_1">
					<!-- 추가-->
					<h4 name="msNCount">참여 멤버(<%=moimScheduleMember.size() %>/<%=msbean.getMsHCount() %>)</h4>
		            <div class="container">
		            <%
		              	if(moimScheduleMember.isEmpty()){
		            %>
			          <h4>참여 멤버가 없습니다.</h4>
		              <%}else{
		            	  for(int j=0;j<moimScheduleMember.size();j++){
		            		  MemberBean memberbean = moimScheduleMember.get(j);
		            		//MemberBean memberBean = moimschvlist.get(j);
		          			//MemberBean memberbean = moimScheduleMember.get(j);
		              %>
	              		<div class="joinMemberImg">
	              			<img src="/bigmoim/image/<%=memberbean.getMemberImg()%>"/>
	           	  		</div>
	              	  <%}%><!-- for -->
		            <%}%><!-- if else -->
		         </div>
		       </div>
        	<%}%><!-- 큰 for -->
          <%} %><!-- 큰 if else -->
		  </li>	
	  	</ul>
	  <!-- 클래스 멤버 -->
      <div class="tab">
      	<%
      		if(moimAllMemvlist!=null){		
      	%>
      		<!-- 클래스 멤버 탭 부분 -->
      		<ul class="tabnav">
	          <li class="tab-link current" name="msTime" onclick="change(0)"><a href="javascript:void(0)">전체멤버</a></li>
	          <%
	          	if(msvlist!=null){
	          		for(int i=0;i<msvlist.size();i++){
	          			MoimScheduleBean msbean = msvlist.get(i);
	          			MoimScheduleBean moimschbean = sjvlist.get(i); 

	          %>
	          <li class="tab-link current" name="msTime" onclick="change(<%=msbean.getMsNum() %>)"><a href="javascript:void(0)"><%=mmDay%>월<%=moimschbean.getMsDate()%>일</a></li>
	          		<%} %><!-- for -->
	          <%} %><!-- if -->
	        </ul>
	        <!-- 클래스 멤버 탭에 따른 멤버 출력 -->
	        <div class="tabcontent tab0">
	          <h3 name="msNCount">클래스멤버(<%=moimAllMemvlist.size() %>)</h3>
	          <!-- 클래스장 위에 나오는 왕관부분 -->
	          <div class="manager"></div>
	          <!-- 클래스장 출력 -->
	          <ul class="tabcontent-list">
	            <li class="tabcontent-list-img " name="memberImg"><img src="/bigmoim/image/<%=manngerBean.getMemberImg()%>" class="memberImg" /></li>
	            <li>
	              <ul class="tabcontent-list-detail">
	              	<li class="tabcontent-list-name" name="memberName"><%=manngerBean.getMemberName() %></li>
	                <li class="tabcontent-list-hello" name="memberProfile"><%=manngerBean.getMemberProfile() %></li>
	              </ul>
	            </li> 
	          </ul>
	          <!-- 모임장을 뺀 클래스 멤버들 -->
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
	          <%} %><!-- if -->
	          <%} %><!-- for -->  
	        </div>
	        <!-- 일정에 따른 참여멤버 출력 -->
			<% 
			for(int z=0;z<msvlist.size();z++){
				MoimScheduleBean moimScheduleBean = msvlist.get(z);
				Vector<MemberBean> moimScheduleMember = sjMgr.moimScheduleMember(moimScheduleBean.getMsNum());
				// Vector<ScheduleJoinBean> filteredList = scheduleJoinMsvList.stream().filter(item -> item.getMsNum() == moimScheduleBean.getMsNum()).collect(Collectors.toCollection(Vector::new));		
			%>
			<div class="tabcontent tab<%=moimScheduleBean.getMsNum() %>" style="display: none" >
	          <h3 name="msNCount">클래스멤버(<%=moimScheduleMember.size() %>)</h3>
	          <%
	          	if(moimScheduleMember.size() <= 0){
	          %>
	          	<li><h3>참여멤버가 없습니다.</h3></li>
	          <%}else{		
            	  for(int j=0;j<moimScheduleMember.size();j++){
            		  MemberBean memberBean = moimScheduleMember.get(j);
            		  // filteredList.stream().filter(item -> item.getMemberid().equals(memberBean.getMemberId())).count() > 0	
					if(moimScheduleMember.size() > 0){
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
	            <%}%><!-- if --> 
	            <%}%><!-- for -->
	          <%} %><!-- if else --> 
	        </div>
	        <%} %><!-- 큰 for -->
     	<%}%><!-- 큰 if else -->
 	</div>
      	<!-- 클래스 댓글 -->
      	<h2>댓글을 달아보세요</h2>
    	<div class="commenttab">
      	<%
      		if(ccList.isEmpty()){
      			//System.out.print("클래스 : "+ccList);
      	%>
	      	<div class="comments">
				<h3>등록된 댓글이 없습니다.</h3>
	      	</div>
      	<%}else{ %>
	      	<div class="comments">
	      		<%
	      			for(int i=0;i<ccList.size();i++){
	      				ClassCommentBean ccbean = ccList.get(i);
	      		%>
		      	<div class="comment">
		        	<div class="author"><%=ccbean.getMemberId() %></div>
		        	<div class="message"><%=ccbean.getCcComment() %></div>
		        	<div class="date"><%=ccbean.getCcDate() %></div>
		      	</div>
		      	<%if(ccbean.getMemberId().equals(memberId)) {%>
		      	<div class="commentBtn">
        			<a href="deleteclasscommentProc.jsp?num=<%=memberId%>&cCnum=<%=ccbean.getCcNum()%>&moimNum=<%=no%>">[삭제]</a>
      			</div>
      			<%} %>
      			<%}%><!-- for -->
	      	</div>
	     	<%} %><!-- if else -->
	      	<form action = "moimdetailProc.jsp?num=<%=no%>&memberId=<%=memberId%>" class="comment-form" method="post" name="commentFrm" id="ccComment">
	      		<input type="text" id="ccComment" name="ccComment" placeholder="댓글을 입력하세요." style="width: 610px; outline: none; height: fit-content;"/>
	      		<button type="button" onclick="commentCheck()" style="width: 52px;">등록</button>
    		</form>
      	</div>
    </div>
  </div>

    
      <!--  
      <a id="topBtn" href="#">top</a>
      -->
      <!-- 하단 -->
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
              <form name="jjimFrm_moim" action="../main/jjimProc.jsp" method="get">
                 <button  id="detailjjim_moim"
	          onclick="likeBtnChange_moim(<%=moimbean.getMoimNum()%>)" 
	          style="color : red;  
	          background-color: transparent;
			  border: none;
			  font-size: 24px;
			  cursor: pointer;
			  width: 30px;
			  height: 30px;">
	  			<i id="heart_moim_<%=moimbean.getMoimNum() %>"
	  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
	  			class = "fas fa-heart" style="display: inline-block; width: 100%; height: 100%;"
	  			<% } else{%>
	  			class = "far fa-heart" style="display: inline-block; width: 100%; height: 100%;"
	  			<%}%>
	  			></i>
			</button>
              <%if(memberId==null){ %>
              <%}else if(manngerBean.getMemberId().equals(memberId)){%>
              <li><button type="button" class="moimEditorBtn" onclick="moimUpdate_moim()">내모임관리</button></li>
              <li><button type="button" class="memberManageBtn" onclick="memberManage_moim()">모임회원관리</button></li>
              <%}%>
            <input type="hidden" name ="jjimNum" value="">
    		<input type="hidden" name ="memberId" value="<%=memberId %>">
    		<input type="hidden" name ="moimNum" value="<%=no%>">
    		</form>
            </ul>
          </div>
        </div>
        <!-- 모임 대표 사진 -->
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
          <div style="display: flex;">
          	<h2 class="clubdetail-text" style="margin: 0px;">모임일정</h2>
          	<%if(manngerBean.getMemberId().equals(memberId)){%>
          	<a href="makeschedule.jsp?memberId=<%=memberId%>&moimNum=<%=no%>">
          		<img alt="모임일정 생성" src="../../image/플러스버튼.png" width="30" height="30" style="margin-left: 10px">
          	</a>
          	<%} %>
          </div>
          <ul class="meeting_list">
          	<%
          		if(msvlist.isEmpty()){
          	%>
          	<div>
          		<h4>일정이 없습니다.</h4>
          	</div>
          	<%}else{
          		for(int i=0;i<msvlist.size();i++){
          			MoimScheduleBean msbean = msvlist.get(i);
          			MoimScheduleBean moimschbean = sjvlist.get(i);
          			Vector<MemberBean> moimScheduleMember = sjMgr.moimScheduleMember(msbean.getMsNum());
          		%>
		  	<li>
				<h2 name="msTitle"><%=msbean.getMsTitle() %></h2>
				<ul class="mlist_in">
					<li class="date" name="msTime"><%=mjDayName%><span><%=moimschbean.getMsDate()%></span></li>
					<li>
						<ul class="in_cont">
							<li class="ico calendar" name="msTime"><%=msbean.getMsDate()%>&nbsp;<%=msbean.getMsTime()%></li>
							<li class="ico place" name="msArea"><%=msbean.getMsArea()%></li>
							<li class="ico cost" name="">없음</li>
						</ul>
					</li>
					<li class="btn">
					<%
					if(moimScheduleMember.size() < msbean.getMsHCount()){
					boolean memberChk = sjMgr.moimMemberCheck(no, memberId);
					if(memberChk){
						%>
						<a href="schedulejoinProc.jsp?moimNum=<%=no %>&memberId=<%=memberId %>&msNum=<%=msbean.getMsNum() %>" class="share">
							일정<br />
							참여
						</a>
					<% 
						}
					}else{%>
						<a>
						인원<br />
						초과
					</a>
					<% }
					%>
						
					</li>
				</ul>
				<div class="member" id="cont_1">
					<!-- 추가-->
					<h4 name="msNCount">참여 멤버(<%=moimScheduleMember.size() %>/<%=msbean.getMsHCount() %>)</h4>
		            <div class="container">
		            <%
		              	if(moimScheduleMember.isEmpty()){
		            %>
			          <h4>참여 멤버가 없습니다.</h4>
		              <%}else{
		            	  for(int j=0;j<moimScheduleMember.size();j++){
		            		//MemberBean memberBean = moimschvlist.get(j);
		          			MemberBean memberbean = moimScheduleMember.get(j);
		              %>
	              		<div class="joinMemberImg">
	              			<img src="/bigmoim/image/<%=memberbean.getMemberImg()%>"/>
	           	  		</div> 
	              	  <%}%><!-- for -->
		            <%}%><!-- if else -->
		            </div>
		        </div>
        	<%}%><!-- for -->
        <%} %><!-- if else -->
			</li>	
		  </ul>

       <!-- 모임멤버 탭 -->   
      <div class="tab">
         <%
            if(moimAllMemvlist!=null){      
         %>
            <!-- 모임멤버 탭 부분 -->
            <ul class="tabnav">
             <li class="tab-link current" name="msTime" onclick="change(0)"><a href="javascript:void(0)">전체멤버</a></li>
             <%
                if(msvlist!=null){
                   for(int i=0;i<msvlist.size();i++){
                      MoimScheduleBean msbean = msvlist.get(i);
                      MoimScheduleBean moimschbean = sjvlist.get(i);
             %>
                <li class="tab-link current" name="msTime" onclick="change(<%=msbean.getMsNum() %>)"><a href="javascript:void(0)"><%=mmDay%>월<%=moimschbean.getMsDate()%>일</a></li>
                <%} %><!-- for -->
             <%} %><!-- if -->
           </ul>
           <!-- 모임 멤버 탭에 따른 멤버 출력 -->
         <div class="tabcontent tab0">
             <h3 name="msNCount">모임멤버(<%=moimAllMemvlist.size() %>)</h3>
             <!-- 모임장 위에 나오는 왕관부분 -->
             <div class="manager"></div>
             <!-- 모임장 출력 -->
             <ul class="tabcontent-list">
               <li class="tabcontent-list-img " name="memberImg"><img src="/bigmoim/image/<%=manngerBean.getMemberImg()%>" class="memberImg" /></li>
               <li>
                 <ul class="tabcontent-list-detail">
                    <li class="tabcontent-list-name" name="memberName"><%=manngerBean.getMemberName() %></li>
                   <li class="tabcontent-list-hello" name="memberProfile"><%=manngerBean.getMemberProfile() %></li>
                 </ul>
               </li> 
             </ul>
             <!-- 모임장을 뺀 모임 멤버들 -->
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
             <%} %><!-- if -->
             <%} %><!-- for -->  
           </div>
            <!-- 일정에 따른 참여멤버출력 -->
           <% 
         for(int z=0;z<msvlist.size();z++){
            MoimScheduleBean moimScheduleBean = msvlist.get(z);
            Vector<MemberBean> moimScheduleMember = sjMgr.moimScheduleMember(moimScheduleBean.getMsNum());
            // Vector<ScheduleJoinBean> filteredList = scheduleJoinMsvList.stream().filter(item -> item.getMsNum() == moimScheduleBean.getMsNum()).collect(Collectors.toCollection(Vector::new));            
         %>
         <div class="tabcontent tab<%=moimScheduleBean.getMsNum() %>" style="display: none" >
             <h3 name="msNCount">모임멤버(<%=moimScheduleMember.size() %>)</h3>
             <%
                if(moimScheduleMember.size() <= 0){
             %>
                <li><h3>참여멤버가 없습니다.</h3></li>
             <%}else{      
                 for(int j=0;j<moimScheduleMember.size();j++){
                    MemberBean memberBean = moimScheduleMember.get(j);
                    // filteredList.stream().filter(item -> item.getMemberid().equals(memberBean.getMemberId())).count() > 0   
               if(moimScheduleMember.size() > 0){
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
               <% }%><!-- if -->
              <%} %><!-- for -->
             <%} %><!-- if else -->
           </div>
          <%} %><!-- 큰 for --> 
         <%} %><!-- 큰 if else --> 
      </div>
       </div>
      </div>
 <!-- ---------------------------------------------------게시판------------------------------- -->
  
  
   <div class="mainwrapper content2" style="display: none";>
        <div class="main-containera">
          <div class="categorya">
            <div class="main-mergea">
              <div class="uploadb">
            <%
            Vector<MemberBean> moimMemberList = moimMgr.getMemberList(no);
            for(int i=0;i<moimMemberList.size();i++){
            	
            	if(memberId != null && memberId.equals(moimMemberList.get(i).getMemberId())){ 
            %>
				<button type="button" onclick="makeboard('<%=no %>' , '<%=memberId %>')"
                    style="background: pink; color: #fff; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px;">
                    게시글 등록
                </button>
            <%
            	}
            	
            }%> 
            
            </div>
            <br>
            <% if(boardvlist.isEmpty()){%>
            	<div>게시글이 없습니다.</div>
            <%}else	// 게시글이 있는 경우 %>
                   <% for(int i = 0; i < boardvlist.size(); i++) {
                	   // mbBean : 해당 모임의 게시글 리스트
                   MemberBoardBean mbBean = boardvlist.get(i); 
                   MemberBean memberBean = memberMgr.getMember(memberId);%>
              <div class="post-containerb">
                  <div class="post-headerb" style="position: relative;">
                       <div class="profile-infob">
               <p class="author-nameb" style="margin-top: 1em;"><%=mbBean.getMemberId()%></p>
              </div>
              <%if(mbBean.getMemberId().equals(memberId)){%>
                    <a href="javascript:updateFn('<%=mbBean.getMbNum()%>','<%=mbBean.getMemberId() %>','<%=mbBean.getMoimNum()%>')" style="position: absolute; top: 5px; right: 45px;"> [수정]&nbsp</a>                   
                    <a href="deleteboardProc.jsp?num=<%=memberId%>&mbnum=<%=mbBean.getMbNum()%>&moimnum=<%=no%>" style="position: absolute; top: 5px;; right: 0; margin-right: 5px"> [삭제] </a> 
              <%}%>
                    <div class="post-timeb">
                     <!--올린 날자-->
                     <p id="mbDate"><%=mbBean.getMbDate()%></p>
                    </div>
                  </div>                 
                    <div class="post-bodyb">
                      <div class="post-contentb">
                      		<h3>제목: <%=mbBean.getMbTitle() %></h3>
	                        <p><%=mbBean.getMbContent()%></p>
	                      </div>
	                      <div class="post-imageb">
	                        <img src="/bigmoim/image/<%=mbBean.getMbImg()%>" width="150" height="150">
	                      </div>
	                      </div>
                    <hr>
                    <!--댓글 라인-->
 
	               <div class="post-footerb">
	               <div class="post-actions" style="display: flex; justify-content: space-between;">
	                 <button class="show-comments" style="position: relative; left: 17cm; bottom: 5px;" onclick="showComments(<%=mbBean.getMbNum()%>)">댓글보기</button>
	                 <br>
	               </div> 
 
 				<!-- ---------------------------댓글 폼 보이기 --------------------------->
 				
				<script>
				  function showComments(mbNum) {
				    var comments = document.querySelector('#comments_' + mbNum);
				    if (comments.style.display === 'none') {
				      comments.style.display = 'block';
				    } else {
				      comments.style.display = 'none';
				    }
				  }
				</script>
 
 
                            <!-- 댓글 영역에 고유한 ID 할당 -->
               <div class="comments" id="comments_<%=mbBean.getMbNum()%>" style="display: none;">
                 <% Vector<BoardCommentBean> bcvlist = boardcommentMgr.bcList(mbBean.getMbNum()); 
                    for(int j = 0; j < bcvlist.size(); j++) {
                      BoardCommentBean bcBean = bcvlist.get(j); %>
                    <li style = "list-style-type: none; position: relative; bottom: -10px;">
                            <div class="comment-info">
                            
                              <p class="comment-author" id="memberId"><%=bcBean.getMemberId() %> &nbsp</p>
                              <p class="comment-date" id ="bcDate"><%=bcBean.getBcDate()%></p>
                              
                              <%if(bcBean.getMemberId().equals(memberId)) {%>
                            <a href="deletecomment.jsp?memberId=<%=memberId%>&bcNum=<%=bcBean.getBcNum()%>&moimNum=<%=no%> " style = "margin-left: 15px;">[삭제]</a>
                            
                            <%} // 댓글 수정,삭제 버튼%>
                            
                            </div>
                            <p class="comment-text" id="bcContent"><%=bcBean.getBcContent()%></p>
                         </li>
                         <br>
                         
                    <%}// 댓글 for문%>
                    <form method="post" action="insertboardProc.jsp?mbNum=<%=mbBean.getMbNum()%>&memberId=<%=memberId%>&moimNum=<%=no%>" class="comment-form" name="commentFrm" id="commentFrm">
                      <label for="comment-input" style = "width: 95px; position: relative; bottom: -20px; left: 20px;"> 댓글 </label>
                      <input type="text" id="comment-input" name="comment-input">
                      <button onclick="makeboardcomment()" style = "width: 75px;">작성</button>
                   </form>
                  </div>
                 </div>
              	</div>
              <br>
           	<%}// else%>
           </div>
          </div>
         </div>
        </div>
  	                   <!-- ---------------------사진첩 ---------------------------------------------------------------->
  <div class="mainwrapper content3" style="display: none;">
    <div class="main-container">
        <div class="categorys">
            <div class="main-mergea">
                <div class="upload">
                <%
                	
                	for(int i=0;i<moimMemberList.size();i++){
                	
                	if(memberId != null && memberId.equals(moimMemberList.get(i).getMemberId())){ 
                %>
                 <button type="button" onclick="registerPhoto('<%=memberId %>', '<%=no %>')" value="<%=result%>" id="photoBtn" name="photoBtn"
                            style="background: pink; color: #fff; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px; margin-left: 20.5cm;
                            cm;">사진등록
                    </button>
                  <%	} 
                  }%>
                      <script>
    function registerPhoto() {
                                var w = 500; // 창 너비
                                var h = 750; // 창 높이
                                var left = (screen.width / 2) - (w / 2); // 중앙에서부터 창의 왼쪽 위치 계산
                                var top = (screen.height / 2) - (h / 2); // 중앙에서부터 창의 위쪽 위치 계산
                                window.open("uploadphotos.jsp", "새창 이름", "width=" + w + ",height=" + h + ",top=" + top + ",left=" + left);
                            }
    </script>
                </div>
                <br>
                <div class="image-container">
                    <% 
                    if(moimphotovlist.size() <= 0){%>
                       <div style="text-align: center;">등록된 사진이 없습니다.</div>   
                   <%}else{
                       for(int k = 0; k < moimphotovlist.size(); k++){
                       
                        MoimPhotosBean photobean = moimphotovlist.get(k);
                        
                        %>
                        <div class="image-box" onclick="showDetail('<%=photobean.getPhotoName()%>', '<%=photobean.getMemberId()%>', '<%=no%>', '<%=photobean.getPhotoNum()%>')">
                            <img src="/bigmoim/image/<%=photobean.getPhoto()%>" id="photo" width="280" height="200">
                            <h2 style = "text-align: center;"><%=photobean.getPhotoName()%></h2>
                        </div>
                    <%}%>
                <%}%>
                </div>

            </div>
        </div>
    </div>
</div>
  
  <%} %><!-- 클래스와 모임 구분 if else -->
  <!-- 가입/탈퇴/로그인 버튼 -->
  <%if(memberId==null){%>
  <div class="moimdetailBtn" style="bottom: 300px; right: 170px;">
  <a href="../login/login.html">
      <p class="moimdetailBtn-txt">로그인하기</p>
  </a>
  </div>
  <%}else{
     boolean memberChk = sjMgr.moimMemberCheck(no, memberId);
     System.out.println("memberChk : " +memberChk);
     Vector<MoimScheduleBean> allmoimScheduleList = sjMgr.allmoimScheduleList();
        if(memberChk){ //있다 -탈퇴하기
  %>
        <div class="moimdetailBtn" style="bottom: 50px; right: 100px;">
          <a href="#" onclick="moimQuit();">
            <p class="moimdetailBtn-txt">탈퇴하기</p>
           </a>
           </div>
           
       <%}else{ // 없다 가입하기
    	   boolean mjChk = moimMgr.mjChk(memberId, no);
       		if(!mjChk){ // 모입가입신청안헀으면
       %>		
          <div class="moimdetailBtn" style="bottom: 300px; right: 170px;">
          <a href="joinmoim.jsp?moimNum=<%=no%>&memberId=<%=memberId%>">
            <p class="moimdetailBtn-txt">가입하기</p>
           </a>
           </div>
          <%}
          } %>

  <%} %><!-- if else -->
  <script>
  
 
  //탈퇴하기
  function moimQuit(){//예
     if(confirm("정말 탈퇴하시겠습니까?")){
        location.href = "quitMoimProc.jsp?memberId=<%=memberId %>&moimNum=<%=no%>";
        return true;
        
     }else{//아니오
        
         return false;
     }
  }
  // 멤버관리
  function memberManage_moim(){
	  document.jjimFrm_moim.action = "moimMemberManage.jsp";
	  document.jjimFrm_moim.submit();
  }
  function memberManage_class(){
	  document.jjimFrm_class.action = "moimMemberManage.jsp";
	  document.jjimFrm_class.submit();
  }
  
  //찜목록 
  function moimUpdate_moim(){//모임정보 수정 페이지로 감(모임)
		document.jjimFrm_moim.action = "moimupdate.jsp";
		document.jjimFrm_moim.submit();
	}
  
  function moimUpdate_class(){//모임정보 수정 페이지로 감(클래스)
		document.jjimFrm_class.action = "moimupdate.jsp";
		document.jjimFrm_class.submit();
	}
  //////////////////////////////////////////////
  function likeBtnChange_moim(num) {
  	//Proc에 보내기 
  	let jjimFrm_moim = document.forms["jjimFrm_moim"];
  	jjimFrm_moim.moimNum.value = num;
      jjimFrm_moim.submit();
  	
  	//색상 변경
		let likeBtn = document.getElementById("heart_moim_"+ num)
		if(likeBtn.className == "far fa-heart"){//빈 하트면
			likeBtn.className = "fas fa-heart" //꽉찬 하트로
		}else if(likeBtn.className == "fas fa-heart"){//꽉찬 하트면
			likeBtn.className = "far fa-heart"//빈 하트로
		}
	}
  
  function likeBtnChange_class(num) {
	  	//Proc에 보내기 
	  	let jjimFrm_class= document.forms["jjimFrm_class"];
	  	jjimFrm_class.moimNum.value = num;
	      jjimFrm_class.submit();
	  	
	  	//색상 변경
			let likeBtn = document.getElementById("heart_class_"+ num)
			if(likeBtn.className == "far fa-heart"){//빈 하트면
				likeBtn.className = "fas fa-heart" //꽉찬 하트로
			}else if(likeBtn.className == "fas fa-heart"){//꽉찬 하트면
				likeBtn.className = "far fa-heart"//빈 하트로
			}
		}
  //모임 및 클래스 js
	//모임 및 클래스 멤버들 탭js  
    const change = (num) =>{
    	const tabList = document.querySelectorAll(".tabcontent");
    	tabList.forEach((el) => (el.style.display = "none"));
    	const nowTab = document.querySelector(".tab"+ num);
    	nowTab.style.display = "block";
    };
    
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
    //클래스 댓글 미입력시 js
   	function commentCheck() {
		if(document.commentFrm.ccComment.value==""){
			alert("댓글을 입력해주세요!");
			document.commentFrm.ccComment.focus();
			return;
		}
		document.commentFrm.submit();
	}
   	
    //게시판 js
    function updateFn(num, memberId, moimNum){
    	
       url = "updateboard.jsp?num="+num + "&memberId=" + memberId + "&moimNum=" + moimNum;
       
       window.open(url,"Board Update","width=540, height=600");
    }
    
    //게시글 댓글 공백 체크 및 내용 submit
    function makeboardcomment() {
       const commentFrm = document.commentFrm;       
       if(commentFrm.comment-input.value.length < 1){
          alert("댓글을 작성해주세요");
          return ;
       }
       commentFrm.submit();
    }
    //게시글 등록 창 띄우기
    function makeboard(no, memberId){
   //    url = "makeboard.jsp?num=" + no + "&memberId=" + memberId;
   //        window.open(url,"Board MAKE","width=700, height=800");   

                    var w = 500; // 창 너비
                    var h = 850; // 창 높이
                    var left = (screen.width / 2) - (w / 2); // 중앙에서부터 창의 왼쪽 위치 계산
                    var top = (screen.height / 2) - (h / 2); // 중앙에서부터 창의 위쪽 위치 계산
                    window.open("makeboard.jsp?num=" + no + "&memberId=" + memberId, "새창 이름", "width=" + w + ",height=" + h + ",top=" + top + ",left=" + left);
                
   
    }
    
    // 사진 js
        function registerPhoto(memberId, no){
   //		url = "uploadphotos.jsp?memberId=" + memberId + "&moimNum=" + no;
    //  	window.open(url,"Board MAKE","width=700, height=800");
      	
        var w = 500; // 창 너비
        var h = 750; // 창 높이
        var left = (screen.width / 2) - (w / 2); // 중앙에서부터 창의 왼쪽 위치 계산
        var top = (screen.height / 2) - (h / 2); // 중앙에서부터 창의 위쪽 위치 계산
        window.open("uploadphotos.jsp?memberId=" + memberId + "&moimNum=" + no , "새창 이름", "width=" + w + ",height=" + h + ",top=" + top + ",left=" + left);
    }

    function showDetail(imageUrl, memberId, no, photoNum) {
  			window.location.href = "photodetail.jsp?image=" + encodeURIComponent(imageUrl) + "&memberId=" + memberId + "&moimNum=" + no + "&photoNum=" + photoNum;
		}

  </script>
  <!-- bottom.jsp -->
  <%@ include file = "/view/bottom.jsp" %>
  </body>
</html>
