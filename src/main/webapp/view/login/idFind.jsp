<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>

<%
	
	String memberName = request.getParameter("memberName");
	String memberTel = request.getParameter("memberTel");
	
	
	String memberId = mMgr.getIdSearch(memberName, memberTel);
	
	System.out.println(memberId);		
%>

<!DOCTYPE html>
<html lang = "ko">
    <head>
        <meta charset = "UTF-8">
        <title>아이디 찾기 페이지</title>
        <link rel = "stylesheet" href = "style.css">
        <script>
    	function findId(){
    		var idfrm = document.idfind;
    		
    		if(idfrm.memberName.value.length < 1){
    			alert("아이디를 입력해주세요");
    			return ;
    		}
    		
    		if(idfrm.memberTel.value.length < 1){
    			alert("전화번호를 입력하주세요");
    			return;
    		}
    		
 		
    		idfrm.submit();
    	}
        </script>
    </head>
    <body>
        <!-- header -->
        <div id = "header">
            <h1 class = "login-find-header">
                <label for = "header">아이디 찾기</label>
            </h1>
        </div>

        <!-- wrapper -->
        <div class = "login-find-wrapper">

            <!-- content -->
            <div class = "login-find-content">

                <form name = "idfind" method="post">
                <!-- 아이디 찾기 -->
                <h2 class = "login-find-id"></h2>

                <!-- 이름 -->
                <div>
                    <h3 class = "login-find-title" ><label for = "name">이름</label></h3>
                    <span class = "box string-name">
                        <input type = "text" name = "memberName" class = "string" maxlength = "20">
                    </span>
                </div>

                <!-- 전화번호 -->
                <div>
                    <h3 class = "login-find-title"><label for = "tel">전화번호</label></h3>
                    <span class = "box string-tel">
                        <input type = "text" name = "memberTel" class = "string" maxlength = "16">
                    </span>
                </div>

                <!-- 아이디 찾기 버튼 -->
                <div class = "find-id-btn">
                    <button type = "button" onclick = "findId()">
                        <span> 아이디 찾기</span>
                    </button>
                </div>
            </form>
            

                </div>
            </div>
        </div>

    </body>
