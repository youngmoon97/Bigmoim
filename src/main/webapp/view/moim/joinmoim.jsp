<%@page import="model.Bean.MoimBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<%
	String memberId = request.getParameter("memberId");
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	MoimBean moimbean = moimMgr.moimDetail(moimNum);
	
%>
<!doctype html>
<html lang="en">
    <style>
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
            /* 원하는 위치만큼의 음수 값을 입력하여 이미지를 높일 수 있습니다. */
        }
    </style>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">

    <!-- Style -->
    <link rel="stylesheet" href="../css/style.css">


    <title>모임 가입하기</title>
</head>

<body>

    <div class="content">
        <div class="wrapper">
            <div class="row justify-content-center">

                <div class="col-md-6 contents">
                    <div class="row justify-content-center">
                        <div class="col-md-12">
                               <div class="main-merge"> <!--main page 간격-->
                    <div class="back-button" style="margin-top: 3em">
                        <a href="javascript:history.back();">
                            <img src="/bigmoim/image/back-button.png" alt="뒤로가기" style="filter: FFC0C;" />
                                    </a>
                                    <h3 class="ml-1 mb-0" ><strong>모임 가입하기</strong></h3>
                                    
                                </div>
                                <form action="joinmoimProc.jsp" method="post">
                                    <div>
                                        <label>모임 이름</label>
                                        <textarea class="form-control" id="moimName" name="moimName" rows="1"
                                            maxlength="30" placeholder="<%=moimbean.getMoimName() %>" readonly></textarea>
                                    </div>

                                    <div>
                                        <label>신청 일자</label>
                                        <textarea class="form-control" id="mjDate" name="mjDate" rows="1" maxlength="30"
                                            readonly></textarea>
                                    </div>

                                    <!-- 현제의 날짜를 받는 JavaScript 코드  -->
                                    <script>
                                        var currentDate = new Date().toLocaleDateString(); // 현재 날짜를 문자열로 가져옴
                                        document.getElementById("mjDate").value = currentDate; // 텍스트 영역에 현재 날짜를 넣음
                                        document.getElementById("mjDate").readOnly = true; // 텍스트 영역을 읽기 전용으로 설정
                                    </script>




                                    <div>
                                        <br>
                                        <label>가입 인사</label>
                                        <br>
                                        <textarea class="form-control" id="mjContent" name="mjContent" rows="5"
                                            maxlength="500" placeholder="가입인사를 작성해 주세요"></textarea>
                                        <input type="hidden" name="moimNum" value="<%=moimNum %>">
                                        <input type="hidden" name="memberId" value="<%=memberId %>">
                                    </div>



                                    <div class="mt-4 text-center">
                                        <input type="submit" value="가입하기" class="btn btn-pill text-white btn-block"
                                            style="background-color: pink;">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="../js/jquery-3.6.0.min.js"></script>
    <script src="../js/popper.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
</body>

</html>