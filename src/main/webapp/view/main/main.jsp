<%@ page contentType="text/html; charset=UTF-8"%>
<%
	
%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="main.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
  </head>
  <body>
  <%@ include file = "../top.jsp" %>
    <!-- 카테고리 -->
    <div class="main-container">
      <main>
      <div class="category">
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\sports.png" alt="운동 / 스포츠" />
            <div class="image-text">운동 / 스포츠</div>
          </div>
        </a>
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\coffee.png" alt="사교 / 인맥" />
            <div class="image-text">사교 / 인맥</div>
          </div>
        </a>
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\console.png" alt="게임 / 오락" />
            <div class="image-text">게임 / 오락</div>
          </div>
        </a>
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\spoon-and-fork.png" alt="요리 / 제조" />
            <div class="image-text">요리 / 제조</div>
          </div>
        </a>
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\butterfly.png" alt="자유주제" />
            <div class="image-text">자유주제</div>
          </div>
        </a>
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\plane.png" alt="아웃도어 / 여행" />
            <div class="image-text">아웃도어 / 여행</div>
          </div>
        </a>
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\book.png" alt="인문학 / 책글" width="60" height="60" />
            <div class = "image-text">인문학/ 책글</div>
          </div>
        </a>
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\abc.png" alt="외국 / 언어" />
            <div class = "image-text">외국 / 언어</div>
          </div>
        </a>
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\suitcase.png" alt="업종 / 직무" />
            <div class = "image-text">업종 / 직무</div>
          </div>
        </a>
        <a href="#">
          <div class = "image-wrapper">
            <img src="img_icon\carousel.png" alt="문화 / 공연 / 축제" />
            <div class = "image-text">문화 / 공연 / 축제</div>
          </div>
        </a>
        <div class="hidden-category">
          <a href="#">
            <div class = "image-wrapper">
              <img src="img_icon\music.png" alt="음악 / 악기" />
              <div class = "image-text">음악 / 악기</div>
            </div>
          </a>
          <a href="#">
            <div class = "image-wrapper">
              <img src="img_icon\palette.png" alt="공예 / 만들기" />
              <div class = "image-text">공예 / 만들기</div>
            </div>
          </a>
          <a href="#">
            <div class = "image-wrapper">
              <img src="img_icon\ballet-shoes.png" alt="댄스 / 무용" />
              <div class = "image-text">댄스 / 무용</div>
            </div>
          </a>
          <a href="#">
            <div class = "image-wrapper">
              <img src="img_icon\volunteer.png" alt="봉사활동" />
              <div class = "image-text">봉사활동</div>
            </div>
          </a>
          <a href="#">
            <div class = "image-wrapper">
              <img src="img_icon\car.png" alt="차 / 오토바이" />
              <div class = "image-text">차 / 오토바이</div>
            </div>
          </a>
          <a href="#">
            <div class = "image-wrapper">
              <img src="img_icon\camera.png" alt="사진 / 영상" />
              <div class = "image-text">사진 / 영상</div>
            </div>
          </a>
          <a href="#">
            <div class = "image-wrapper">
              <img src="img_icon\baseball.png" alt="야구관람" />
              <div class = "image-text">야구관람</div>
            </div>
          </a>
          <a href="#">
            <div class = "image-wrapper">
              <img src="img_icon\dog.png" alt="반려동물" />
              <div class = "image-text">반려동물</div>
            </div>
          </a>
          <a href="#">
            <div class = "image-wrapper">
              <img src="img_icon\family.png" alt="가족 / 결혼" />
              <div class = "image-text">가족 / 결혼</div>
            </div>
          </a>
        </div>

        <div class = "more-wrapper">
          <a href="#" class="more" >더보기</a>
        </div>

      </div>
    </main>
    </div>

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
        
