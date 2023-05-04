<%@page import="model.Bean.MoimPhotosBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimphotoMgr" class="controll.Mgr.MoimMgr"/>
<%
	// 등록일, 멤버 아이디, 사진이름, 이미지 나와야함	
	String memberId = request.getParameter("memberId");
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	int photoNum = Integer.parseInt(request.getParameter("photoNum"));
	 System.out.print("photoNum : " + photoNum );
	MoimPhotosBean mpBean = moimphotoMgr.getmoimImgDetail(photoNum);
	
	
	
%>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="../fonts/icomoon/style.css">

    <link rel="stylesheet" href="../css/owl.carousel.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="../css/bootstrap.min.css">

    <!-- Style -->
    <link rel="stylesheet" href="../css/style.css">

    <style>
        /*폼 스타일*/
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
    </style>
    <!--클릭한 이미지의 값이 들어오는 스크립트-->
      <script>
        var queryParams = new URLSearchParams(window.location.search);
        var imageUrl = queryParams.get("image");
        var photoElement = document.getElementById("photo");
        photoElement.src = imageUrl;
      </script>

    <title>상세 사진첩</title>
</head>

<body>

    <div class="main-wrapper">
        <div class="main-container">
            <div class="category">
                <div class="main-merge">
                    <div class="back-button" style="margin-top: 3em">
                        <!--a 태그에 메인 URL 입력해야함-->
                        <a href="#" onclick="window.history.back(); return false;">
                            <img src="/bigmoim/image/back-button.png" alt="뒤로가기">
                        </a>

                        <h3 style="margin-left: -7.5em"><strong>사진첩</strong></h3>
                    </div>
                    <div style="width: 500px; font-size: 16px;">
                        <div style="display: flex; align-items: center;">
                            <div class="sign-dateHeader" style="margin-right: 1em;">
                                <label for="regDate">등록일</label>
                                <input type="text" class="form-control" id="upDate" name="upDate" value="<%=mpBean.getUpDate() %>" readonly>
                            </div>
                            <div class="sign-nameHeader" style="margin-top: 1em; margin-left: 5em;">
                                <br>
                                <input type="text" class="form-control" name="memberName" value="<%=memberId%>" readonly>
                            </div>
                        </div>
                    </div>
                    <div style="float: left;">
                        <br>
                        <h3 id="photoName" style="margin-left: -9em;">
                            
                        </h3>
                    </div>
                    <div style="margin-top: 2em">
                        <img src="/bigmoim/image/<%=mpBean.getPhoto() %>" alt="사진" id="photo" style="max-width: 100%; max-height: 600px;">
                    </div>
                    <div style="display: flex; margin-top: 2em;">
                        
                        <a href="deletemoimphoto.jsp?photoNum=<%=photoNum%>&memberId=<%=memberId%>&moimNum=<%=moimNum%>">삭제</a>
                    </div>
                    <script>

                    </script>
                </div>
            </div>
        </div>
    </div>

    <script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/popper.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>

</body>
</html>
