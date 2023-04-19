<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>

<%
	String name = request.getParameter("name");
	String tel = request.getParameter("idtel");
	
	String id = mMgr.getIdSearch(name, tel);
	System.out.println(id);		
%>

<!DOCTYPE html>
<html lang = "ko">
    <head>
        <meta charset = "UTF-8">
        <title>아이디 / 비밀번호 수정</title>
        <link rel = "stylesheet" href = "style.css">
        <script>

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
                        <input type = "text" name = "name" class = "string" maxlength = "20">
                    </span>
                </div>

                <!-- 전화번호 -->
                <div>
                    <h3 class = "login-find-title"><label for = "tel">전화번호</label></h3>
                    <span class = "box string-tel">
                        <input type = "text" name = "idtel" class = "string" maxlength = "16">
                    </span>
                </div>

                <!-- 아이디 찾기 버튼 -->
                <div class = "find-id-btn">
                    <button type = "button" onclick = "findId()">
                        <span> 아이디 찾기</span>
                    </button>
                </div>
            </form>
            
                <script>
            	function findId(){
            		var idfrm = document.idfind;
            		
            		if(idfrm.name.value.length < 1){
            			alert("아이디를 입력해주세요");
            			return ;
            		}
            		
            		if(idfrm.idtel.value.length < 1){
            			alert("전화번호를 입력하주세요");
            			return;
            		}
            		
            		idfrm.action = "idFind.jsp"
            		idfrm.submit();
            		alert("아이디찾기 성공");
            	}
                </script>
                </div>
            </div>
        </div>

    </body>
