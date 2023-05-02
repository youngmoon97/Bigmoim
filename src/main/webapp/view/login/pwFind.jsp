<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>

<%
/* 		String memberId = request.getParameter("memberId");
		String memberTel = request.getParameter("memberTel");
		String memberPw = mMgr.getPwSearch(memberId, memberTel); */		
%>
<!DOCTYPE html>
<html lang = "ko">
    <head>
        <meta charset = "UTF-8">
        <title>아이디 / 비밀번호 수정</title>
        <link rel = "stylesheet" href = "pwFind.css">
        <script>
        function findPw() {
    		var pwfrm = document.pwfind;
    		
    		if(pwfrm.memberId.value.length < 1){
    			alert("아이디를 입력해주세요");
    			return ;
    		}
    		
    		if(pwfrm.memberTel.value.length < 1){
    			alert("전화번호를 입력하주세요");
    			return;
    		}
    		
    		pwfrm.action = "pwFindProc.jsp";
    		pwfrm.submit();  		
        }
        </script>
    </head>
    <body>
        <div class="login-find-wrapper">
            <div class="login-find-content">
                <div id = "login-find-header">
                    <h1>비밀번호 찾기</h1>
                </div>
                <!-- 아이디 -->
                <form name="pwfind" method="post">
                    <div class="login-find-input">
                    <div>
                        <h3 class = "login-find-title"><label for = "id">아이디</label></h3>
                        <span class = "box string-id">
                            <input type = "text" name = "memberId" class = "string" maxlength = "20" style="width: 94%;">
                        </span>
                    </div>
                    <!-- 전화번호 -->
                    <div>
                        <h3 class = "login-find-title"><label for = "tel">전화번호</label></h3>
                        <span class = "box string-tel">
                            <input type = "text" name = "memberTel" class = "string" maxlength = "16" style="width: 94%;">
                        </span>
                    </div>
                </div>
                    <!-- 비밀번호 찾기 버튼 -->
                    <div class = "login-find-btn">
                        <button type = "button" onclick = "findPw()"> 비밀번호 찾기 </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>