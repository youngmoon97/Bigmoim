<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file = "/view/top.jsp" %>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<%
	
%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="../css/main.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
  </head>
  <body>
  
    <!-- 카테고리 -->
    <%@ include file = "/view/category.jsp" %>
    
    <!-- 카드 -->
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
    		</article>
    		</div>
    		<%}//--for
    }//--if-else %>
    
    
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
      
      const likeBtn = document.querySelector('.like-btn');
      	likeBtn.addEventListener('click', () => {
     	likeBtn.querySelector('i').classList.toggle('fas');
     	likeBtn.querySelector('i').classList.toggle('far');
     	});
      	
    </script>
    </div>
  </body>
</html>
        
