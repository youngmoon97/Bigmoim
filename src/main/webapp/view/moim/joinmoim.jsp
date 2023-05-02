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
                                <div class="mb-4 d-flex align-items-center">
                                    <a href="#" class="btn btn-light ml-0">
                                        <span class="icon-arrow-left"></span>
                                    </a>
                                    <h3 class="ml-1 mb-0"><strong>모임 가입하기</strong></h3>
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