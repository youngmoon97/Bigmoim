<%@page import="model.Bean.MemberBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="boardMgr" class="controll.Mgr.BoardMgr"/>
<jsp:useBean id="boardBean" class="model.Bean.MemberBoardBean"/>

<%
	String memberId = request.getParameter("memberId");
	int moimNum = Integer.parseInt(request.getParameter("num"));
	System.out.println("moimNum : "+ moimNum);
	
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

    <style>
        /*<!-- 사진 추가용 스타일-->*/
        .image-preview-container {
            display: flex;
            align-items: center;
        }

        .file-input-container {
            margin-right: 10px;
        }

        #preview-image {
            max-width: 200px;
            max-height: 200px;
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
            margin-top: -3em;
            margin-right: 0.5em;
        }
     
    </style>
        <script>
             function showPreviewImage(input) {
             var previewImage = document.getElementById('preview-image');
              var fileInput = document.getElementById('profile-image');
               if (input.files && input.files[0]) {
              var reader = new FileReader();
             reader.onload = function (e) {
            previewImage.src = e.target.result;
             }
           reader.readAsDataURL(input.files[0]);
    		} else {
       		 previewImage.src = '';
         	}
       		}
             
             /*function addboard() {
				const myFrm = document.frm;
				myFrm.submit();
			}*/
      </script>	

    <title>게시글 작성</title>
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
                                    
                    <div class="back-button" style="margin-top: 3em">
                        <!--a 태그에 메인 URL 입력해야함-->
                        <a href="#" onclick="window.history.back(); return false;">
                            <img src="/bigmoim/image/back-button.png" alt="뒤로가기" style="filter: FFC0C;" />
                        </a>
                    </div>
                                    <h3 class="ml-1 mb-0"><strong>게시글 작성</strong></h3>
                                </div>
                                <!-- 멤버 아이디 Proc파일로 넘김 -->
                                <form action="makeboardProc.jsp?memberId=<%=memberId %>&moimNum=<%=moimNum%>" method="POST" id="frm" name="frm" enctype="multipart/form-data">
                                    <div>
                                        <label>작성자</label>

                                    </div>

                                    <!-- 현제의 날짜를 받는 JavaScript 코드  -->
                                    <script>
                                        var currentDate = new Date().toLocaleDateString(); // 현재 날짜를 문자열로 가져옴
                                        document.getElementById("mbDate").value = currentDate; // 텍스트 영역에 현재 날짜를 넣음
                                        document.getElementById("mbDate").readOnly = true; // 텍스트 영역을 읽기 전용으로 설정
                                    </script>

                                    <div>
                                        		<label>게시글 제목</label>
                                        <br>
                                        <textarea class="form-control" id="mbTitle" name="mbTitle" rows="1"
                                            maxlength="30" placeholder="게시글 제목을 입력하세요"></textarea>
                                         <br><br>
                                         
                                        		<label>게시글 내용</label>
                                        <br>
                                        <textarea class="form-control" id="mbContent" name="mbContent" rows="5"
                                            maxlength="500" placeholder="게시글 내용을 입력해주세요"></textarea>
                                        <br>
                                        <br>
                                    </div>

                                    <div>
                                        <label>사진 등록</label>
                                        <br>
                                    </div>

                                    <div class="image-preview-container">
                                        <img id="preview-image" src="" alt="Preview Image">
                                        <label for="profile-image" class="file-input-container"></label>
                                        <input type="file" class="form-control-file" id="profile-image" name="mbImg"
                                            onchange="showPreviewImage(this)">
                                    </div>



                                <div class="mt-4 text-center">
                                        <button type="submit"  class="btn btn-pill text-white btn-block"
                                            style="background-color: pink;"  >등록하기</button>
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
    <script src="js/jquery-3.6.0.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>

</html>