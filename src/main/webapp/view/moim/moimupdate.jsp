<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="model.Bean.MoimBean"%>	
<%

	String moimImg = request.getParameter("moimImg");
	String moimName = request.getParameter("moimName");
	String moimArea = request.getParameter("moimArea");
	int moimHCount = Integer.parseInt(request.getParameter("moimHCount"));
	int categoryNum = Integer.parseInt(request.getParameter("categoryNum"));
	int businessNum = Integer.parseInt(request.getParameter("businessNum"));
	int taskNum = Integer.parseInt(request.getParameter("taskNum"));
	int themeNum = Integer.parseInt(request.getParameter("themeNum"));
	String moimProfile = request.getParameter("moimProfile");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="../css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/style.css">
    <style>
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

        /*모임 대표 이미지 관련 css*/
        #preview-image {
            max-width: 200px;
            /* 변경된 부분: 최대 너비를 200px로 설정 */
            max-height: 200px;
            /* 변경된 부분: 최대 높이를 200px로 설정 */
        }
        
                    .file-input-container {
            background-color: pink;
            color: white;
            padding: 10px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            margin-left: 15px;
            /* 해당 버튼의 margin-left 값을 조정하여 간격 조절 가능 */
            }

                .file-input-container input[type=file] {
            position: absolute;
            top: 10px;
            /* 파일 선택 버튼을 부모 요소의 오른쪽 상단에 위치시킴 */
            margin-top: 20px;
            /* 버튼과 상위 요소 간의 간격을 20px로 지정함 */
        }

        /* 파일 선택 버튼 숨기기 */
        #profile-image {
            display: none;
        }

    </style>

    <title>모임 수정</title>
</head>

<body>

    <div class="main-wrapper">
        <div class="main-container">
            <div class="category">
                <div class="main-merge"> <!--main page 간격-->
                    <div class="back-button" style="margin-top: 3em">
                        <!--a 태그에 메인 URL 입력해야함-->
                        <a href="#">
                            <img src="../images/back-button.png" alt="뒤로가기" style="filter: FFC0C;" />
                        </a>
                        <h3 style="margin-left: -7.5em"><strong>모임 관리하기</strong></h3>
                    </div>
                    <form action="#" method="post">
                        <div style="width: 500px; font-size: 16px;">

                            <div class="image-preview-container">
                                <div>
                                    <label>
                                        <br>
                                        모임 대표 이미지
                                        <br>
                                    </label>
                                </div>
                                <img id="preview-image" src="" alt="Preview Image">
                                <label for="profile-image" class="file-input-container" style="margin-top: 6em">사진 변경하기</label>
                                <input type="file" class="form-control-file" id="profile-image" name="moimImg" value=<%= moimImg %>
                                    onchange="showPreviewImage(this)" >
                            </div>

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
                            </script>

                            <div>
                                <br>
                                <label>모임 명</label>
                                <textarea class="form-control" id="moimName" name="moimName" rows="1" maxlength="30"
                                    value ="<%= moimName %>"></textarea>
                                <br>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <label>지역</label>
                                    <textarea class="form-control" id="moimArea" name="moimArea" rows="2" maxlength="30"
                                        value=<%= moimArea %>></textarea>
                                    <br>

                                    <label for="moimHCount">정원 (1~300)</label>
                                    <br>
                                    <textarea class="form-control" id="moimHCount" name="moimHCount" rows="2"
                                        maxlength="3" value=<%= moimHCount %>></textarea>

                                </div>
                                <div class="col-md-6">
                                    <label>모임 종류</label>
                                    <select class="form-control" name="categoryNum">
                                        <option value=<%= categoryNum %>>카테고리</option>
                                    </select>
                                    <br>
                                    <select class="form-control" name="businessNum">
                                        <option value=<%= businessNum %>>업종</option>
                                    </select>
                                    <br>

                                    <select class="form-control" name="taskNum">
                                        <option value=<%= taskNum %>>직무</option>
                                    </select>
                                    <br>
                                    <select class="form-control" name="themeNum">
                                        <option value=<%= themeNum %>>테마</option>
                                    </select>
                                    <br>
                                </div>
                            </div>




                            <div>
                                <label>모임 소개</label>
                                <br>
                                <textarea class="form-control" id="moimProfile" name="moimProfile" rows="5"
                                    maxlength="500"  value=<%= moimProfile %>></textarea>
                            </div>

                            <div>
                                <br>
                                <label>모임 맴버</label>
                                <!-- 회원 리스트를 서버에서 받아와서 동적으로 생성 -->
                                <!-- 예시로 더미 데이터를 사용 -->
                                <ul id="memberList" class="list-group">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center">
                                            <img src="../images/samplememberImg.png" class="mr-3" width="50" height="50"
                                                name="memberImg"> <!-- 프로필 사진 이미지 태그 -->
                                            <span name="memberName">회원1</span> <!-- 회원 이름 텍스트 -->
                                        </div>
                                        <button class="btn btn-danger" onclick="expelMember(1)">추방</button>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        <div class="d-flex align-items-center">
                                            <img src="../images/samplememberImg2.png" class="mr-3" width="50"
                                                height="50" name="memberImg"> <!-- 프로필 사진 이미지 태그 -->
                                            <span name="memberName">회원2</span> <!-- 회원 이름 텍스트 -->
                                        </div>
                                        <button class="btn btn-danger" onclick="expelMember(2)">추방</button>
                                    </li>
                                </ul>

                                <!--
                                자동으로 추가되고 추방버튼 클릭시 삭제되는 기능의 스크립트
                                <script>
                                // 예시 데이터
                                var memberData = [
                                { id: 1, name: '회원1', profilePic: 'profile1.jpg' },
                                { id: 2, name: '회원2', profilePic: 'profile2.jpg' }
                                ];

                                // 회원 추가 함수
                                function addMember(memberData) {
                                // 회원 데이터를 받아와서 동적으로 회원을 추가하는 로직
                                // 예시로는 memberData를 사용하여 회원을 추가하는 로직을 작성
                                // ...

                                // 추방 버튼을 생성하고 해당 버튼에 이벤트 리스너를 등록하는 로직
                                var expelButton = document.createElement('button');
                                expelButton.className = 'btn btn-danger';
                                expelButton.textContent = '추방';
                                expelButton.addEventListener('click', function() {
                                // 추방 버튼 클릭 시 실행되는 로직
                                // 추방할 회원의 아이디(또는 인덱스)를 사용하여 추방 로직을 작성
                                // ...
                                });

                                // 회원 프로필 사진을 생성하는 로직
                                var profilePic = document.createElement('img');
                                profilePic.src = memberData.profilePic; // 회원의 프로필 사진 경로를 설정
                                profilePic.className = 'profile-pic'; // 프로필 사진의 클래스를 설정

                                // 회원을 추가하고 프로필 사진과 추방 버튼을 추가하는 로직
                                var memberListItem = document.createElement('li');
                                memberListItem.className = 'list-group-item d-flex justify-content-between align-items-center';
                                memberListItem.appendChild(profilePic); // 프로필 사진을 추가
                                memberListItem.textContent = memberData.name; // 회원의 이름을 텍스트로 추가
                                memberListItem.appendChild(expelButton); // 추방 버튼을 추가
                                document.getElementById('memberList').appendChild(memberListItem); // 회원 목록에 추가
                                }

                                // 예시 데이터를 사용하여 회원1을 추가
                                addMember(memberData[0]);
                                </script> 
                            -->
                            </div>

                            <div class="mt-4 text-center">
                                <input type="submit" value="수정하기" class="btn btn-pill text-white btn-block"
                                    style="background-color: pink;">

                            </div>
                    </form>
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