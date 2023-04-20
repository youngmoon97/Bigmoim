<%@ page contentType="text/html; charset=UTF-8"%>
<%
		String memberId = (String)session.getAttribute("idKey");
		System.out.println("main.jsp:memberId = "+memberId);

%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="main.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
    <script>
   function toggleDropdown() {
      var dropdown = document.querySelector(".member-dropdown-content");
      if (dropdown.style.display === "none") {
         dropdown.style.display = "block";
      } else {
         dropdown.style.display = "none";
      }
   }
</script>

    
</head>
<body>
	<!-- 상단 -->
    <div class = "main-wrapper">
    <header>
      <div class="logo">
        <a href="/bigmoim/view/main/main.jsp"><img src="/bigmoim/image/logo.png" alt="대모임 로고" width="130px" height="130px" /></a>
      </div>
      <div class="search-area">
        <form>
          <button type="submit" class="search-btn"><img src="/bigmoim/image/search.png" alt="검색" style="width: 30px; height: 30px;">
          </button>
          <input type="text" />
        </form>
      </div>
        <div class="header-function">
        <!-- TODO 로그인 시 로그인 아이디나와야함 -->
          <%if(memberId != null){ %>
    			<div class="member-wrapper">
    				<div class="member-dropdown">
        			<button class="member-btn" onclick="toggleDropdown()"><%=memberId%></button>
        			<div class="member-dropdown-content">
            			<a href="#">내 정보</a>
            			<a href="#">내가 가입한 모임</a>
        			</div>
    				</div>
    			<button class="logout-btn" onclick="location.href='/bigmoim/view/login/logout.jsp'">로그아웃</button>
				</div>
				
			<%}else{%>
    			<button class="login-btn" onclick="location.href='/bigmoim/view/login/login.html'">로그인</button>
    			<button class="signup-btn" onclick="location.href='/bigmoim/view/login/signup.jsp'">회원가입</button>
				<%}%>
          <button class="notification"><img src="/bigmoim/image/bell.png" alt="알림" style="width: 25px; height: 25px;"></button>
        </div>
    </header>

    <!-- 네비게이션 -->
    <nav>
      <ul>
        <li><a href="/bigmoim/view/main/main.jsp">클래스</a></li>
        <li><a href="/bigmoim/view/moim/recomoim.jsp">모임추천</a></li>
        <li><a href="/bigmoim/view/moim/moimschedule.jsp">모임일정</a></li>
        <li><a href="/bigmoim/view/moim/newmoim.jsp">모임신규</a></li>
        <%if(memberId != null){ %>
        	<li><a href="/bigmoim/view/myact/myactivity.jsp">내 활동</a></li>
        <% }%>
        
      </ul>
    </nav>
    
</body>
</html>