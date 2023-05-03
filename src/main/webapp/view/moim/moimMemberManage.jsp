<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="model.Bean.MemberBean"%>
<%@page import="model.Bean.MoimBean"%>
<%@page import="model.Bean.MoimMemberBean"%>
<%@page import="model.Bean.MoimJoinBean"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>

<%

int moimNum=Integer.parseInt(request.getParameter("moimNum")); //모임번호 받아오기
Vector<MemberBean> vMoimMembers = moimMgr.getMemberList(moimNum);
MoimBean moimbean = moimMgr.moimDetail(moimNum);
Vector<MoimJoinBean> vMoimJoinList = moimMgr.mjList(moimNum);

%>
<script type="text/javascript">
function memberBan(banMemberId){ //회원추방
    document.moimMemberManageFrm.action = "memberBanProc.jsp";
    document.moimMemberManageFrm.memberId.value=banMemberId;
    document.moimMemberManageFrm.submit();   
}

function moimJoinCheck_accept(mjMemberId){ //가입수락
    document.moimMemberManageFrm.action = "moimJoinCheckProc.jsp";
    document.moimMemberManageFrm.memberId.value=mjMemberId;
    document.moimMemberManageFrm.mjflag.value="true";
    document.moimMemberManageFrm.submit();   
}

function moimJoinCheck_refuse(mjMemberId){ //가입거절
    document.moimMemberManageFrm.action = "moimJoinCheckProc.jsp";
    document.moimMemberManageFrm.memberId.value=mjMemberId;
    document.moimMemberManageFrm.mjflag.value="false";
    document.moimMemberManageFrm.submit();
}

</script>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>모임 회원 관리</title>
</head>
<style>

/* 전체 페이지 */
body {
  font-family: 'Nanum Gothic', sans-serif;
  background-color: #f5f5f5;
}

/* 전체 컨테이너 */
.admin-moim-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
}

/* 전체 래퍼 */
.admin-moim-wrapper {
  width: 60%;
  max-width: 1200px;
  background-color: #fff;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  padding: 30px;
}

.admin-moim-request a img {
  width: 20px;
  margin-right: 5px;
}


/* 회원 신청 리스트 */
.request-list-group {
  list-style: none;
  padding-left: 0;
}

.request-list-group li,
.kick-list-group li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  padding: 10px;
  background-color: #f5f5f5;
  border-radius: 5px;
}

.request-list-group .accept-btn,
.request-list-group .refuse-btn,
.kick-list-group .kick-btn {
  padding: 10px 20px; /* 패딩 크기 조정 */
  color: #fff;
  border: none;
  border-radius: 10px; /* 버튼을 둥글게 만듦 */
  cursor: pointer;
  margin-left: auto;
  font-size: 14px; /* 폰트 크기 조정 */
  transition: background-color 0.3s; /* 마우스 오버 효과 추가 */
}

/* 추방 리스트 */
.kick-list-group {
  list-style: none;
  padding-left: 0;
}

.kick-list-group li {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 10px;
  padding: 10px;
  background-color: #f5f5f5;
  border-radius: 5px;
}

/* 추방 버튼 */
.kick-list-group .kick-btn {
  padding: 10px 20px; /* 패딩 크기 조정 */
  background-color: #F44336; /* 버튼 색상 변경 */
  color: #fff;
  border: none;
  border-radius: 10px; /* 버튼을 둥글게 만듦 */
  font-size: 14px; /* 폰트 크기 조정 */
  transition: background-color 0.3s; /* 마우스 오버 효과 추가 */
}

.request-list-group .accept-btn:hover,
.request-list-group .refuse-btn:hover,
.kick-list-group .kick-btn:hover {
  background-color: #555; /* 마우스 오버시 버튼 색상 변경 */
}

/* li 크기 조정 */
.request-list-group li,
.kick-list-group li {
  padding: 15px;
}

/* 버튼 크기 조정 */
button {
  width: 80px;
  height: 50px;
}

.kick-list-group span {
  position: relative;
  top: -20px;
  left: 10px;
}

/* 가입수락 버튼 스타일 */
.request-list-group .accept-btn {
  margin-right: 10px;
  background-color: #4CAF50; /* 버튼 색상 변경 */
}

/* 가입거절 버튼 스타일 */
.request-list-group .refuse-btn {
  background-color: #F44336; /* 버튼 색상 변경 */
}


</style>
<body>


<div class = "admin-moim-container">
<div class = "admin-moim-wrapper">

<div class="admin-moim-top">
  <a class="admin-moim-back" href="moimdetail.jsp?num=<%=moimNum %>" onmouseover="this.style.opacity='0.7';" onmouseout="this.style.opacity='1';">
    <img src="/bigmoim/image/back-button.png" alt="뒤로가기" style="width: 40px; height: 40px;"/>
  </a>
  <h1>모임 회원 관리</h1>
</div>



<!-- 회원 신청 -->
<div class = "admin-moim-request">

<ul class = "request-list-group">

<br>

<h3>회원 승인</h3>
<form name="moimMemberManageFrm" action="memberBanProc.jsp" method="get">
<%for(int i=0;i<vMoimJoinList.size();i++) {
     MoimJoinBean mjBean = vMoimJoinList.get(i);
%>
  <li>
     <!-- 회원 아이디 -->
     <span><%=mjBean.getMemberId() %></span>
    <!-- 회원 가입인사 -->
    <span><%=mjBean.getMjContent() %></span>
    <!-- 수락, 거절 버튼 -->
    <div class = "admin-moim-select-btn">
         <button class="accept-btn" type="button" onclick="moimJoinCheck_accept('<%=mjBean.getMemberId() %>')" >수락</button>
       <button class="refuse-btn" type="admin-button" onclick="moimJoinCheck_refuse('<%=mjBean.getMemberId() %>')">거절</button>
    </div>
  </li>
  <%}//--for %>
</ul>

</div>

<br>

<!-- 회원 추방 -->
<div class = "admin-moim-kick">
<ul class="kick-list-group">

<h3>회원 추방</h3>
<% String img = "";
      for(int i=0;i<vMoimMembers.size();i++) {
        MemberBean memberBean = vMoimMembers.get(i);
        if(!memberBean.getMemberId().equals(moimbean.getMemberId())) {
        img = "/bigmoim/image/"+memberBean.getMemberImg();
        %>
<li class="list-group-item d-flex justify-content-between align-items-center">
      <!-- 회원 이미지 -->
      <div class="d-flex align-items-center">
       <img src = "<%=img%>" class="mr-3" width="50" height="50"
       name="memberImg-<%=memberBean.getMemberId()%>">
       <!-- 회원 이름 -->
       <span name="memberId-<%=memberBean.getMemberId()%>"><%=memberBean.getMemberName() %></span>
       <!-- 추방 버튼 -->
       </div>
         <button class="kick-btn" type="button" onclick="memberBan('<%=memberBean.getMemberId()%>')">추방</button>
    </li>
    <%} //if 
     } //for%> 
     
</ul>

   <input type="hidden" name ="memberId">
   <input type="hidden" name ="moimNum" value='<%=moimNum%>'>
   <input type="hidden" name ="mjflag" value="true">

</div>

</div>
</div>

</form>
</body>
</html>