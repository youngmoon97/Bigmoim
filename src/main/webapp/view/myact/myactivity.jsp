<%@page import="model.Bean.MemberBean"%>
<%@page import="model.Bean.MoimBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="cMgr" class="controll.Mgr.ClassMgr"/>
<jsp:useBean id="myactMgr" class="controll.Mgr.MyActivityMgr"/>
<%
	//id만 받아와서 넣으면 된다.
	MemberBean mbean = mMgr.getMember("aaa");
	int businessNum = mbean.getBusinessNum();	
	Vector<MoimBean> moimvlist = myactMgr.pbusinessList(businessNum);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="../main.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
  </head>
  <body>
    <!-- 상단 -->
    <div class = "main-wrapper">
    <header>
      <div class="logo">
        <a href="#"><img src="../../logo.png" alt="대모임 로고" width="130px" height="130px"/></a>
      </div>
      <div class="search-area">
        <form>
          <button type="submit" class="search-btn"><img src="../img_icon\search.png" alt="검색" style="width: 30px; height: 30px;">
          </button>
          <input type="text" />
        </form>
      </div>
        <div class="header-function">
          <button class="login-btn">로그인</button>
          <button class="signup-btn">회원가입</button>
          <button class="notification"><img src="../img_icon\bell.png" alt="알림" style="width: 25px; height: 25px;"></button>
        </div>
    </header>

    <!-- 네비게이션 -->
    <nav>
      <ul>
        <li><a href="#">클래스</a></li>
        <li><a href="#">모임추천</a></li>
        <li><a href="#">모임일정</a></li>
        <li><a href="#">모임신규</a></li>
        <li><a href="#">내 활동</a></li>
      </ul>
    </nav>
    
    <!-- 가입한모임 -->

    <hr>
    <!-- 최근본모임 -->
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">최근 본 모임</p>
      </div>
    </article>
    <div class="card-group">
      <article class="card">
        <div class="image-wrapper">
          <img src="../ex_img\토끼.jpg" alt="Image">
          <button class="like-btn">찜하기</button>
        </div>
        <h4>좋은기타 동호회</h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="">금정구</p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value="">음악 / 악기</p>
      </div>
        <p class="moimProfile" name="moimProfile" value="">설명</p>
      </article>
    </div>
    <hr>
    <!-- 업무별 모임(업무없으면 전체모임)-->
    <% if(moimvlist.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">가입한 모임이 아직 없습니다.</p>
      </div>
    </article>
    <%}else{%>
    		<article>
      			<div class = "text">
		        <p class = "join-text">업무 맞춤 모임</p>
 	     		</div>
    		</article>
    		
    		<% 
    		for(int i=0;i<moimvlist.size();i++){
    			MoimBean moimbean = moimvlist.get(i);
    		%>
    		<div class="card-group">
      		<article class="card">
    		<div class="image-wrapper">
          <img src=<%=moimbean.getMoimImg()%> alt="Image">
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
    <hr>
    <!-- 직무별 모임 -->
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">직무 맞춤 모임</p>
      </div>
    </article>
    
    <div class="card-group">
      <article class="card">
        <div class="image-wrapper">
          <img src="../ex_img\토끼.jpg" alt="Image">
          <button class="like-btn">찜하기</button>
        </div>
        <h4>좋은기타 동호회</h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="">금정구</p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value="">음악 / 악기</p>
      </div>
        <p class="moimProfile" name="moimProfile" value="">설명</p>
      </article>
    </div>
    
    <hr>
    <!-- 태마별 모임 -->
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text">테마 맞춤 모임</p>
      </div>
    </article>
    <div class="card-group">
      <article class="card">
        <div class="image-wrapper">
          <img src="../ex_img\토끼.jpg" alt="Image">
          <button class="like-btn">찜하기</button>
        </div>
        <h4>좋은기타 동호회</h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="">금정구</p>
          <p class="clubdetail-nav-line">|</p>
          <p class="categoryName" name="categoryName" value="">음악 / 악기</p>
      </div>
        <p class="moimProfile" name="moimProfile" value="">설명</p>
      </article>
    </div>
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