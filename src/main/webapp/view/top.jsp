<%@page import="model.Bean.NotificationBean"%>
<%@page import="java.util.Vector"%>
<%@page import="model.Bean.MemberBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<%
      String memberId = (String)session.getAttribute("idKey");
      MemberBean mbean = mMgr.getMember(memberId);
      int notiCount = mMgr.notiCount(memberId);
      Vector<NotificationBean> notiList = mMgr.notiList(memberId);
      //System.out.println(memberId);
      //System.out.println("main.jsp:memberId= "+ mbean.getMemberName());
      //System.out.println(mbean.getMemberImg());

%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="/bigmoim/view/css/main.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
      
      
		.notification-dropdown:before {
content: "";
display: block;
position: absolute;
top: -20px;
left: 50%;
transform: translateX(-50%);
border: 20px solid transparent;
border-bottom-color: transparent;
}

.notification-dropdown:after {
content: "";
position: absolute;
top: -40px;
left: 30%;
transform: translateX(-50%);
border: 20px solid transparent;
border-bottom-color: rgb(255, 231, 235);
}

.notification-dropdown {
position: absolute;
top: 105px;
display: none;
width: 210px;
background-color: rgb(255, 231, 235);
padding: 10px;
}
		
    </style>
    <script>
    function toggleDropdown() {
         var dropdown = document.querySelector(".member-dropdown-content");
         if (dropdown.style.display === "none" || dropdown.style.display === "") {
           dropdown.style.display = "block";
         } else {
           dropdown.style.display = "none";
         }
       }
    
    function toggleDropdown() {
        var dropdown = document.querySelector(".notification-dropdown");
        if (dropdown.style.display === "none" || dropdown.style.display === "") {
            dropdown.style.display = "block";
        } else {
            dropdown.style.display = "none";
        }
    }

    
    function addNotification(message) {
        var dropdown = document.querySelector(".notification-dropdown");
        var link = document.createElement("a");
        link.href = "#";
        link.textContent = message;
        dropdown.appendChild(link);
    }

    // TODO: 메시지가 도착했을 때 호출되는 함수를 작성해야된다...
    function onNewMessage() {
      addNotification("새로운 메시지가 도착했습니다.");
    }



</script>

    
</head>
<body>

   <!-- 상단 -->
    <div class = "main-wrapper" >
    <header id = "fix-area" style = 
      	"
      	position: fixed;
  		top: 0;
  		width: 33.35cm;
  		z-index: 500;
  		">
      <div class="logo">
        <a href="/bigmoim/view/main/main.jsp"><img src="/bigmoim/image/logo.png" alt="대모임 로고" width="130px" height="130px" /></a>
      </div>
      <div class="search-area">
        <form name=searchFrm action="/bigmoim/view/moim/searchmoim.jsp">
          <button type="submit" class="search-btn" >
             <img src="/bigmoim/image/search.png" alt="검색" style="width: 30px; height: 30px;">
          </button>
          <input type="text" name=searchText value="" placeholder="모임 이름으로 검색하세요!" style="outline: none;"/>
        </form>
      </div>
        <div class="header-function">
        <!-- TODO 로그인 시 로그인 아이디나와야함 -->
          <%if(memberId != null){ %>
             <div class="member-wrapper">
                <div class="member-dropdown">
                 <img class="member-img" src="/bigmoim/image/<%= mbean.getMemberImg()%>" onclick="toggleDropdown()" 
                 style = " width: 40px; height: 40px; border-radius: 50%; margin-right: 10px;"/>
                 <!-- 이미지 스타일 값은 이미지 받아오고 수정해봅니다. -->
                 <div class="member-dropdown-content">
                     <a href="/bigmoim/view/login/memberupdate.jsp">내 정보 수정</a>
                     <a href="/bigmoim/view/moim/mymoim.jsp">내 모임 관리</a>
                     <a href="/bigmoim/view/moim/makemoim.jsp">모임개설</a>
                 </div>
                </div>
             <span class="member-name" style = "padding-right: 20px;"><%=mbean.getMemberName()%></span>
             <button class="logout-btn" onclick="location.href='/bigmoim/view/login/logout.jsp'">로그아웃</button>
            </div>
            
         <%}else{%>
             <button class="login-btn" onclick="location.href='/bigmoim/view/login/login.html'">로그인</button>
             <button class="signup-btn" onclick="location.href='/bigmoim/view/login/signup.jsp'">회원가입</button>
            <%}%>
          <button class="notification" onclick="toggleDropdown()">
           <img src="/bigmoim/image/bell.png" alt="알림" style="width: 25px; height: 25px;">
           
           <!-- 알람 개수 -->
           <span class="badge"><%=notiCount %></span>
           
           <!-- 드롭 다운으로 만들어 봄. -->
           <div class="notification-dropdown" style = "top: 125px; right: -103px;">
           <!-- 새로운 알람이 있는 곳으로 링크 타면 될 듯 합니다? -->
           <%if(notiList.isEmpty()){ %>
             <a href="#">새로운 알림이 없습니다.</a>
           <%}else{ 
           		for(int i=0;i<notiList.size();i++){
           			NotificationBean bean = notiList.get(i);
           			//게시판에 새글, 모임사진첩에 새 사진, 새로운 모임일정
           			if(bean.getPhotoNum()!=0){%>
					<a href="#">모임에 새로운 사진이 추가되었습니다.</a>
           	<% }else if(bean.getMbNum()!=0){%>
           			<a href="#">모임에 새로운 게시글이 추가되었습니다.</a>
           	<% }else if(bean.getMsNum()!=0){ %>
           			<a href="#">모임에 새로운 일정이 추가되었습니다.</a>
           	<% }else if(bean.getCcNum()!=0){ 
           	System.out.println("ccnum :" + bean.getCcNum());%>
           			
             		<a href="#">클래스에 새로운 댓글이 추가되었습니다.</a>
            <%} //if-else-2
           			}//-for
           	}//--if-else-1%>
             
</button>

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