<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>

<%
/* 		String memberName = request.getParameter("memberName");
		String memberTel = request.getParameter("memberTel");
		String memberId = mMgr.getIdSearch(memberName, memberTel);	 */
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>아이디 찾기 페이지</title>
    <link rel="stylesheet" href="idFind.css">
    <script>
        function findId() {
            var idfrm = document.idfind;

            if (idfrm.memberName.value.length < 1) {
                alert("아이디를 입력해주세요");
                return;
            }

            if (idfrm.memberTel.value.length < 1) {
                alert("전화번호를 입력하주세요");
                return;
            }       
            
            idfrm.action = "idFindProc.jsp";
            idfrm.submit();
            
        }
    </script>
</head>
<body>
    <div class="login-find-wrapper">
        <div class="login-find-content">
            <div class="login-find-header">
                <h1>아이디 찾기</h1>
            </div>
            <!-- 이름 -->
            <form name="idfind" method="post">
                <div class="login-find-input">
                    <div>
                        <h3 class="login-find-title"><label for="name">이름</label></h3>
                        <span class="box string-name">
                            <input type="text" name="memberName" class="string" maxlength="20">
                        </span>
                    </div>
                    <div>
                        <h3 class="login-find-title"><label for="tel">전화번호</label></h3>
                        <span class="box string-tel">
                            <input type="text" name="memberTel" class="string" maxlength="16">
                        </span>
                    </div>
                </div>
                <div class="login-find-btn">
                    <button type="button" onclick="findId()"> 아이디 찾기 </button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
