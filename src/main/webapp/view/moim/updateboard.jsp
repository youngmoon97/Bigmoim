<%@page import="model.Bean.MemberBoardBean"%>
<%@page import="model.Bean.MemberBean"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="memberMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="boardMgr" class="controll.Mgr.BoardMgr"/>

<%
	// 게시판 번호 
	int mbNum = Integer.parseInt(request.getParameter("num"));
	// 게시판 작성 회원
	String memberId = request.getParameter("memberId");
	
	// 게시판 작성되는 모임 추가 
	
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	// 게시판 번호로 게시판 정보 받아오기 
	MemberBoardBean mbBean = boardMgr.boarddetail(mbNum);
	
	// 게시판 정보에 작성자아이디와 로그인한 아이디가 일치하면 bean에 저장
	if(memberId == mbBean.getMemberId()){
	MemberBoardBean updatebean = boardMgr.getmemberBoard(memberId, mbNum);
	}
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


    <title>게시글 수정</title>
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
                     
                      function updateBoard(){
						var myFrm = document.updateFrm;
						if(myFrm.mbContent.value.length < 1){
							alert("내용을 적어주세요");
							return;
						}
						if(myFrm.mbTitle.value.length < 1){
							alert("제목을 적어주세요");
							return;
						}
						if(myFrm.mbImg.value == null){
							alert("사진을 추가해 주세요");
							return;
						}

						myFrm.submit();
					}
                      
                   </script>
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
                                        <a href="#" onclick="window.close();" return false;">
                                            <img src="../../image/back-button.png" alt="뒤로가기">
                                        </a>
                                    </div>
                                    <h3 class="ml-1 mb-0"><strong>게시글 수정</strong></h3>
                                </div>
                                <form action="updateboardProc.jsp?mbNum=<%=mbNum%>&memberId=<%=memberId%>&moimNum=<%=moimNum %>" method = "post" name="updateFrm" id="updateFrm" enctype="multipart/form-data">
                                    <div>
                                    	<label>게시글 번호 </label>
                                    	<input  type="text" class="form-control" id="mbNum" name="mbNum" rows="1"
                                           maxlength="30" readonly value="<%=mbNum%>"></input>
                                    </div>
                                    <div>
                                        <label>작성자</label>
                                        <input class="form-control" id="memberId" name="memberId" rows="1"
                                            maxlength="30" placeholder="작성자 이름" readonly value = "<%=mbBean.getMemberId()%>"></input>
                                    </div>

                                    <div>
                                        <label>수정 일자</label>
                                        <input class="form-control" id="mbDate" name="mbDate" rows="1" maxlength="30"
                                            readonly value = "<%=mbBean.getMbDate()%>"></input>
                                            <br>
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
                                        <input class="form-control" id="mbTitle" name="mbTitle" rows="1"
                                            maxlength="30" value="<%=mbBean.getMbTitle()%>"></input>
                                            <br>
                                        <br>
                                        <label>게시글 내용</label>
                                        <br>
                                        <input class="form-control" id="mbContent" name="mbContent" rows="5"
                                            maxlength="500" value="<%=mbBean.getMbContent()%>"></input>
                                        <br>
                                        <br>
                                    </div>

                                    <div>
                                        <label>사진 등록</label>
                                        <br>
                                    </div>

                                    <div class="image-preview-container">
                                    
                                        <img id="preview-image" src="/bigmoim/image/<%=mbBean.getMbImg()%>" alt="Preview Image" name="mbImg">
                                        <label for="profile-image" class="file-input-container"></label>
                                        <input type="file" class="form-control-file" id="profile-image" name="mbImg"
                                            onchange="showPreviewImage(this)">
                                    </div>
                                    <div class="mt-4 text-center">
                                        <button type="button" class="btn btn-pill text-white btn-block"
                                            style="background-color: pink;" onclick="updateBoard()">수정하기</button>
                                    </div>
                                </form >
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