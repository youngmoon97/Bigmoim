<%@page import="model.Bean.MoimBean"%>
<%@ include file = "/view/top.jsp" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<%	
	// top에 있는 멤버 데이터 가져와서 주소값가져오기
	String address = mbean.getMemberAddr();
	Vector<MoimBean> addrMoim = moimMgr.areaMoimList(address);
%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="/bigmoim/view/css/main.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
  </head>
  <body>
  
    <!-- 카테고리 -->
    <%@ include file = "/view/category.jsp" %>
    
    <!-- 카드 -->
    <!-- 클래스 -->
	<% 
	if(memberId!=null){
		if(addrMoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text"> <%=memberId %>님 주변 추천 모임이 없습니다 ㅜ</p>
      </div>
    </article>
    <!-- 클래스 리스트 -->
    		<%
    }else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text"> <%=memberId %>님 주변 추천 모임입니다</p>
 	     		</div>
    		</article>
    		
    		<% 
    		for(int i=0;i<addrMoim.size();i++){
    			MoimBean moimbean = addrMoim.get(i);
    			String cName = cMgr.categoryName(moimbean.getCategoryNum());

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
          <p class="categoryName" name="categoryName" value=""><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>
    		</div>
    		<%}//--for
    }//--if-else 
    }else{
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text"> 로그인을 해주세요!</p>
      </div>
    </article>
    <%} %>
    
    
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

      	
    </script>
    </div>
  </body>
</html>
        