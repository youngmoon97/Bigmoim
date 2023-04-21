<%@page import="controll.Mgr.MemberMgr"%>
<%@page import="model.Bean.MoimBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@include file = "/view/top.jsp" %>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="myactMgr" class="controll.Mgr.MyActivityMgr"/>
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
	
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="/bigmoim/view/css/main.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
  </head>
  <body>
    <!-- 상단 -->
    
    
    <!-- 가입한모임 -->
	<% 
	if(joinmoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">가입한 모임이 아직 없습니다.</p>
      </div>
    </article>
    <!-- 가입안하면 본인 지역 모임 전부 출력 -->
    		<% 
    		for(int i=0;i<addrmoim.size();i++){
    			MoimBean moimbean = addrmoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
    		<% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    		</div>
    		
    		<%}//--for
    }else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text">가입한 모임</p>
 	     		</div>
    		</article>
    		
    		<% 
    		for(int i=0;i<joinmoim.size();i++){
    			MoimBean moimbean = joinmoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    		</div>
    		<%}//--for
    }//--if-else %>
    <hr>
   
    <!-- 최근본모임 -->
    <% if(recentmoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">최근 본 모임이 없네요! 추천드려요</p>
      </div>
    </article>
    <!-- 업무 선택안해서 본인 지역 모임 전부 출력 -->
    		<% 
    		for(int i=0;i<addrmoim.size();i++){
    			MoimBean moimbean = addrmoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    		</div>
    		<%}//--for
    }else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text">최근 본 모임</p>
 	     		</div>
    		</article>
    		
    		<% 
    		for(int i=0;i<recentmoim.size();i++){
    			MoimBean moimbean = recentmoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    		</div>
    		<%}//--for
    }//--if-else %>
	<br>
    <!-- 업무별 모임 -->
    <% if(bmoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">업무별 모임이 아직 없습니다. 추천드려용</p>
      </div>
    </article>
    <!-- 업무 선택안해서 본인 지역 모임 전부 출력 -->
    		<% 
    		for(int i=0;i<addrmoim.size();i++){
    			MoimBean moimbean = addrmoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    		</div>
    		<%}//--for
    }else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text">업무 맞춤 모임</p>
 	     		</div>
    		</article>
    		
    		<% 
    		for(int i=0;i<bmoim.size();i++){
    			MoimBean moimbean = bmoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        	</a>
    		</article>
    		</div>
    		<%}//--for
    }//--if-else %>
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
    		<% 
    		for(int i=0;i<addrmoim.size();i++){
    			MoimBean moimbean = addrmoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>
    		</div>
    		<%}//--for
    }else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text">직무 맞춤 모임</p>
 	     		</div>
    		</article>
    		
    		<% 
    		for(int i=0;i<taskmoim.size();i++){
    			MoimBean moimbean = taskmoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>
    		</div>
    		<%}//--for
    }//--if-else %>
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
    		<% 
    		for(int i=0;i<addrmoim.size();i++){
    			MoimBean moimbean = addrmoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>
    		</div>
    		<%}//--for
    }else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text">테마 맞춤 모임</p>
 	     		</div>
    		</article>
    		
    		<% 
    		for(int i=0;i<thememoim.size();i++){
    			MoimBean moimbean = thememoim.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">
          <h1></h1>
          <button class="like-btn">찜하기</button>
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value=""><%=moimbean.getMoimArea() %></p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value=""><%=moimbean.getCategoryNum() %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>
    		</div>
    		<%}//--for
    }//--if-else %>
    <hr>
    
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
      const moreBtn = document.querySelector(".more");
      const hiddenCategory = document.querySelector(".hidden-category");

      moreBtn.addEventListener("click", function() {
        if (hiddenCategory.style.display === "none") {
        hiddenCategory.style.display = "flex";
      } else {
        hiddenCategory.style.display = "none";
      }
      });
    </script>
</div>
</body>
</html>