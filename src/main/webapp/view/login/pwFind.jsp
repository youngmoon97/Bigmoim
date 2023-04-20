<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<%
		String memberId = request.getParameter("memberId");
		String memberTel = request.getParameter("memberTel");
		String memberPw = mMgr.getPwSearch(memberId, memberTel);
		
		System.out.println(memberPw);
		
		
%>

<!DOCTYPE html>
<html lang = "ko">
    <head>
        <meta charset = "UTF-8">
        <title>아이디 / 비밀번호 수정</title>
        <link rel = "stylesheet" href = "style.css">
        <script>
        function pwFind() {
    		var pwfrm = document.pwfind;
    		
    		if(pwfrm.memberId.value.length < 1){
    			alert("아이디를 입력해주세요");
    			return ;
    		}
    		
    		if(pwfrm.memberTel.value.length < 1){
    			alert("전화번호를 입력하주세요");
    			return;
    		}
    		
    		pwfrm.action = "idFind.jsp";
    		pwfrm.submit();  		
        }
        </script>
    </head>
    <body>
        <!-- header -->
        <div id = "header">
            <h1 class = "login-find-header">
                
            </h1>

                <form name = "pwfind" method="post">
                <!-- 비밀번호 찾기 -->
                <h2 class = "login-find-ps">
                    <label for = "find-pw">비밀번호 변경</label>
                </h2>

                <!-- 아이디 -->
                <div>
                    <h3 class = "login-find-title"><label for = "id">아이디</label></h3>
                    <span class = "box string-id">
                        <input type = "text" name = "memberId" class = "string" maxlength = "20">
                    </span>
                </div>

                <!-- 전화번호 -->
                <div>
                    <h3 class = "login-find-title"><label for = "tel">전화번호</label></h3>
                    <span class = "box string-tel">
                        <input type = "text" name = "memberTel" class = "string" maxlength = "16">
                    </span>
                </div>

                <!-- 비밀번호 찾기 버튼 -->
                <div class = "find-pw-btn">
                    <button type = "button" onclick = "pwFind()">
                        <span> 비밀번호 찾기 </span>
                    </button>
                </div>
            </form>

                </div>
            </div>
        </div>

    </body>