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
    <!-- 임시로 주석처리함 수정필요 <link rel="stylesheet" href="/bigmoim/view/css/adminmoim.css">  -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/style.css">
      <style>
        .main-container {
            padding: 50px;
            background-color: rgb(255, 231, 235);
            min-width: min-content;
            /* 내용 최소너비를 유지 */
        }

        .main-wrapper {
            max-width: 1300px;
            /* 전체적인 크기를 1300px로 제한 */
            margin: 0 auto;
            /* 가운데 정렬 */
        }

        .category {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            gap: 20px 56px;
            align-content: center;
        }

        .main-merge {
            max-width: 900px;
            margin: 0 auto;
            /* 가운데 정렬을 위한 margin 설정 */
            width: 85%;
            /* 예시 값 */
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 50px;
            background-color: white;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
        }

        /*뒤로가기 버튼 수정 css*/
        .back-button {
            display: flex;
            align-items: center;
        }

        .back-button img {
            width: 2em;
            /* 이미지의 너비를 글씨 크기와 동일하게 조절 */
            height: 2em;
            /* 이미지의 높이를 글씨 크기와 동일하게 조절 */
            margin-right: 0.5em;
            /* 이미지와 글씨 사이의 간격 조절 */
            margin-top: -9px;
            /* 원하는 위치만큼의 음수 값을 입력하여 이미지를 높일 수 있습니다. */
            margin-left: -16em;
        }

        /*모임 대표 이미지 관련 css*/
        #preview-image {
            max-width: 200px;
            /* 변경된 부분: 최대 너비를 200px로 설정 */
            max-height: 200px;
            /* 변경된 부분: 최대 높이를 200px로 설정 */
        }
        
                    .file-input-container {
            background-color: pink;
            color: white;
            padding: 10px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            margin-left: 15px;
            /* 해당 버튼의 margin-left 값을 조정하여 간격 조절 가능 */
            }

                .file-input-container input[type=file] {
            position: absolute;
            top: 10px;
            /* 파일 선택 버튼을 부모 요소의 오른쪽 상단에 위치시킴 */
            margin-top: 20px;
            /* 버튼과 상위 요소 간의 간격을 20px로 지정함 */
        }

        /* 파일 선택 버튼 숨기기 */
        #profile-image {
            display: none;
        }

    </style>
</head>
<body>

<div class = "admin-moim-container">
<div class = "admin-moim-wrapper">

<div class = "admin-moim-request">
<ul>
<a href="moimdetail.jsp?num=<%=moimNum%>">
<img src="/bigmoim/image/back-button.png" alt="뒤로가기" style="filter: FFC0C;" />
</a>
<h3>모임 회원 관리</h3>
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
    <button type="button" onclick="moimJoinCheck_accept('<%=mjBean.getMemberId() %>')">수락</button>
    <button type="button" onclick="moimJoinCheck_refuse('<%=mjBean.getMemberId() %>')">거절</button>
  </li>
  <%}//--for %>
</ul>
</div>

<div class = "admin-moim-kick">
<ul id = "memberList" class="list-group">
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
   		<button type="button" onclick="memberBan('<%=memberBean.getMemberId()%>')">추방</button>
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
