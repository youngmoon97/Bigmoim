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
    	
    	footer ul {
  			padding-left: 9cm;
		}

		footer p {
			padding-right: 10cm;
		}
		
    </style>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    function likeBtnChange(num) {
      	//Proc에 보내기
      	//alert(num)
      	let jjimFrm = document.forms["jjimFrm"];
      	jjimFrm.moimNum.value = num;
        jjimFrm.submit();

      	//색상 변경
  		let likeBtn = document.getElementById("heart"+ num)
  		if(likeBtn.className == "far fa-heart"){//빈 하트면
  			likeBtn.className = "fas fa-heart" //꽉찬 하트로
  		}else if(likeBtn.className == "fas fa-heart"){//꽉찬 하트면
  			likeBtn.className = "far fa-heart"//빈 하트로
  		}
    
    	//더보기 버튼 누르면 카테고리 안보이던부분 확장되는 코드
	      const moreBtn = document.querySelector(".more");
	      const hiddenCategory = document.querySelector(".hidden-category");
	
	      moreBtn.addEventListener("click", function() {
	        if (hiddenCategory.style.display === "none") {
	        hiddenCategory.style.display = "flex";
	      } else {
	        hiddenCategory.style.display = "none";
	      }
	      });
      }
    </script>
  </head>
  <body style = "padding-top: 150px">

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
<%}else{//--if-else %>
<article>
  <div class = "text">
    <p class = "join-text"> <%=categoryName %> 별 모임</p>
  </div>
</article>
<div class="card-group">
  <% 
  for(int i=0;i<mvlist.size();i++){
    MoimBean moimbean = mvlist.get(i);
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
			<%if (memberId!=null){%> 
         <button class="like-btn" id="like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
			<%} %>

    </div>
    <h4><%=moimbean.getMoimName() %></h4>
    <div class="card-nav">
      <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
      <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
      <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=categoryName %></p>
    </div>
    <p class="moimProfile" name="moimProfile" value="" style="margin-top: 0;"><%=moimbean.getMoimProfile() %></p>
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
   
   <!-- bottom.jsp -->
    <%@ include file = "/view/bottom.jsp" %>
  </body>
  </html>
