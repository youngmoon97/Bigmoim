<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file = "/view/top.jsp" %>
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
    <div class="card-group">
      <article class="card">
        <div class="card-wrapper">
          <img src="ex_img\토끼.jpg" alt="Image">
          <button class="like-btn"><i class="far fa-heart"></i></button>
        </div>
        <h4>좋은기타 동호회</h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;">금정구</p>
          <p class="card-nav-line" style="margin-top: 0;"> &nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;">음악 / 악기</p>
        </div>
        <p class="moimProfile" name="moimProfile" value="" style="margin-top: 0;">설명
        으앙 배고파 으앙 집 가고싶어 으앙 게임하고싶어 으앙 그냥 자고싶어 으앙으앙</p>
      </article>

    </div>
    
    
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
      
      const likeBtn = document.querySelector('.like-btn');
      	likeBtn.addEventListener('click', () => {
     	likeBtn.querySelector('i').classList.toggle('fas');
     	likeBtn.querySelector('i').classList.toggle('far');
     	});
      	
    </script>
    </div>
  </body>
</html>
        
