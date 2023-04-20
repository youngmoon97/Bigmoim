<%@page import="java.util.Vector"%>
<%@page import="model.Bean.MoimBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!-- 상단바 -->
<%@ include file = "/view/top.jsp" %>
<!-- 카테고리 -->
<%@ include file = "/view/category.jsp" %>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="cateMgr" class="controll.Mgr.CategoryMgr"/>
<%
	int no = Integer.parseInt(request.getParameter("num"));
	Vector<MoimBean> mvlist = moimMgr.cateMoimList(no);
	String categoryName = cateMgr.categoryName(no);
	
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

    
  <!-- 중단 -->
 	<% 
	if(mvlist.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">이 카테고리에 모임이 없네요 ㅠ </p>
      </div>
    </article>
    
    <!-- 카테고리 있음 -->		
    <%}else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text"><%=categoryName %> 별 모임</p>
 	     		</div>
    		</article>
    		<% 
    		for(int i=0;i<mvlist.size();i++){
    			MoimBean moimbean = mvlist.get(i);
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
   
  </body>
  </html>
