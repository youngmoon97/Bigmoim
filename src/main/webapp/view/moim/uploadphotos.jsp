<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimphotoMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="moimphotoBean" class="model.Bean.MoimPhotosBean"/>
<%
	String memberId = request.getParameter("memberId");
	int moimNum = Integer.parseInt(request.getParameter("moimNum"));
	
%>

<!DOCTYPE html>
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
    </style>
    <title>사진 등록하기</title>
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
                                    <h3 class="ml-1 mb-0"><strong>사진첩 등록</strong></h3>
                                </div>
                                <form action="uploadphotosProc.jsp?memberId=<%=memberId%>&moimNum=<%=moimNum%>" method="post" id = "frm" name="frm" enctype="multipart/form-data">
                                    <div>
                                        <label>작성자</label>
                                        <textarea class="form-control" id="memberId" name="memberId" rows="1" maxlength="30" readonly><%=memberId %></textarea>
                                        <br>
                                    </div>
                                    <div>
                                        <label>제목</label>
                                        <textarea name="photoName" id ="photoName" class="form-control" rows="1" maxlength="30" placeholder="사진의 제목을 입력해주세요."></textarea>
                                        <br>
                                    </div>
                                    <div>
                                        <label>사진 등록</label>
                                        <br>
                                    </div>
                                    <div class="image-preview-container">
                                        <img id="preview-image" src="" alt="Preview Image">
                                        <label for="profile-image" class="file-input-container"></label>
                                        <input type="file" class="form-control-file" id="profile-image" name="photo" onchange="showPreviewImage(this)">
         							</div>
         						</form>


				<div class="mt-4 text-center">
    			<input type="button" onclick ="addphoto()" value="등록하기" class="btn btn-pill text-white btn-block" style="background-color: pink;" >
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
	
	function addphoto() {
		const myFrm = document.frm;
		
		if(myFrm.photo.value.length < 1){
			alert("사진을 등록해 주세요");
			return;
		}
		if(myFrm.photoName.value.length < 1){
			alert("제목을 입력해 주세요");
			return;
		}
		

		myFrm.submit();
	}
	
</script>

</html>