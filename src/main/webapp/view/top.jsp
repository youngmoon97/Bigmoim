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
</head>
<body>
	<!-- 상단 -->
    <div class = "main-wrapper">
    <header>
      <div class="logo">
        <a href="main.jsp"><img src="../logo.png" alt="대모임 로고" width="130px" height="130px" /></a>
      </div>
      <div class="search-area">
        <form>
          <button type="submit" class="search-btn"><img src="img_icon\search.png" alt="검색" style="width: 30px; height: 30px;">
          </button>
          <input type="text" />
        </form>
      </div>
        <div class="header-function">
        <!-- TODO 로그인 시 로그인 아이디나와야함 -->
          <%if(memberId != null){ %>
           <input type = "button" id="member-btn" name="member-btn" value="<%=memberId%>"><%=memberId%></button>
          <script type="text/javascript">
  			alert("멤버아이디 넘어옴."); //테스트후 삭제
		</script>
         <%}else{%>
          <button class="login-btn" onclick="location.href='./login/login.html'">로그인</button>
          <button class="signup-btn" onclick="location.href='./login/signup.jsp'">회원가입</button>
            <script type="text/javascript">
  			alert("멤버아이디 안넘어옴."); //테스트후 삭제
		</script>
         <%}%>
          <button class="notification"><img src="img_icon\bell.png" alt="알림" style="width: 25px; height: 25px;"></button>
        </div>
    </header>

    <!-- 네비게이션 -->
    <nav>
      <ul>
        <li><a href="main.jsp">클래스</a></li>
        <li><a href="recomoim.jsp">모임추천</a></li>
        <li><a href="moimschedule.jsp">모임일정</a></li>
        <li><a href="newmoim.jsp">모임신규</a></li>
        <li><a href="myactivity.jsp">내 활동</a></li>
      </ul>
    </nav>
    
</body>
</html>