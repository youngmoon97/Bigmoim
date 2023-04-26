<%@page import="controll.Mgr.MemberMgr"%>
<%@page import="model.Bean.MoimCategoryBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%@page import="model.Bean.TaskBean"%>
<%@page import="model.Bean.ThemeBean"%>
<%@page import="model.Bean.BusinessBean"%>
<%@page import="model.Bean.ZipcodeBean"%>

<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr" />   
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="macMgr" class="controll.Mgr.MyActivityMgr"/>
<jsp:useBean id="cMgr" class="controll.Mgr.CategoryMgr"/>

<%
   Vector<ZipcodeBean> vCity = mMgr.cityList(); //area1 시
   String area1 = "서울"; //시
   String moimName = "";
   String moimKakao = "";
   String moimProfile = "";
   String moimImg = "";
   int moimNCount = 0;
   String classprice = "";
   String memberId = (String)session.getAttribute("idKey");
   System.out.print(memberId);
   String moimZipcode = ""; //모임 우편번호
   String moimArea1 = ""; //모임주소 area1
   String moimArea2 = ""; //모임주소 area2


   Vector<ZipcodeBean> vArea2 = null; //area2 구/동
   
   if(request.getParameter("area1") != null){
      area1 = request.getParameter("area1");
      moimName = request.getParameter("moimName");
      moimKakao = request.getParameter("moimKakao");
      moimProfile = request.getParameter("moimProfile");
      moimImg = request.getParameter("moimImg");
      moimNCount = Integer.parseInt(request.getParameter("moimNCount"));
      moimZipcode = request.getParameter("moimZipcode");
      moimArea1 = request.getParameter("moimArea1");
      moimArea2 = request.getParameter("moimArea2");
   }

   vArea2 = mMgr.area2List(area1);
   
   Vector<MoimCategoryBean> vCategory = cMgr.categoryList();  //관심사
   Vector<BusinessBean> vBusiness = macMgr.businessList(); //업종
   Vector<TaskBean> vTask = macMgr.taskList(); //직무
   Vector<ThemeBean> vTheme = macMgr.themeList(); //테마 
   
%>


<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/favicon.ico" type="image/x-icon">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="../fonts/icomoon/style.css">

    <link rel="stylesheet" href="../css/owl.carousel.min.css">


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


    <title>모임 개설</title>
</head>

<body>

    <div class="main-wrapper">
        <div class="main-container">
            <div class="category">
                <div class="main-merge"> <!--main page 간격-->
                    <div class="back-button" style="margin-top: 3em">
                        <!--a 태그에 메인 URL 입력해야함-->
                        <a href="#" onclick="window.history.back(); return false;">
                            <img src="../../image/back-button.png" alt="뒤로가기">
                        </a>
                        <h3 style="margin-left: -7.5em"><strong>모임 개설</strong></h3>
                    </div>
                    <div style="display:flex; justify-content:center; gap:20px;">
                        <br>
                        <br>
                        <button type="button" class="btn btn-primary mr-2 btn-col" id = "moimBtn" value ="1"
                        style="background-color: pink; border: none; width: 250px;" onclick="change('모임')">모임 개설</button>
                    
                        <button type="button" class="btn btn-primary btn-col" id = "classBtn" value = "2"
                                style="background-color: pink; border: none; width: 250px;" onclick="change('클래스')">클래스 개설</button>
                    </div>

                     <form action="makemoimProc.jsp" method="post" name="frm" id = "frm" enctype="multipart/form-data">
                     	<input type="hidden" id="moimtype" value="2" name = "moimtype">
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
                                <label for="profile-image" class="file-input-container" style="margin-top: 6em">사진
                                    변경하기</label>
                                <input type="file" class="form-control-file" id="profile-image" name="moimImg"
                                 onchange="showPreviewImage(this)">
                            </div>

                            <div>
                                <label>모임 명</label>
                                <input type="text" class="form-control" name="moimName" rows="1" maxlength="30"
                                    placeholder="모임 이름을 적어주세요">
                                <br>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <label for="">모임주소</label>
                                    <br>
                                    <input name="moimZipcode" size="5" readonly style="height: 40px;" value="">
                                    <input type="button" name="memberAddrBtn" value="우편번호찾기"
                                        onClick="zipSearch(this.name)"
                                        style="background: pink; color: #fff; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px; height: 40px;">
                                    <br>
                                    <br>
                                    <input name="moimArea1" size="7" value="" readonly>
                                    <input name="moimArea2" size="10" value="" readonly>
                                    <input type="hidden" name="moimArea" id="moimArea">
                                </div>

                                <div class="col-md-6">
                                    <label >모임 종류</label>
                                    <select class="form-control" name="categoryNum"
                                        onchange="javascript:getCategoryNum(this.form.categoryNum.value)">
                                        <option value="0">관심사 선택</option>
                                        <% for (int i=0; i < vCategory.size(); i++) { MoimCategoryBean
                                            mcBean=vCategory.get(i); %>
                                            <option value="<%=mcBean.getCategoryNum()%>">
                                                <%=mcBean.getCategoryName()%>
                                            </option>
                                            <%}%>
                                    </select>
                                    <br>
                                    <select class="form-control" name="businessNum"
                                        onChange="javascript:getBusinessNum(this.form.businessNum.value)">
                                        <option value="0">업종</option>
                                        <% for (int i=0; i < vBusiness.size(); i++) { BusinessBean
                                            bBean=vBusiness.get(i); %>
                                            <option value="<%=bBean.getBusinessNum()%>">
                                                <%=bBean.getBusinessName()%>
                                            </option>
                                            <% } %>
                                    </select>
                                    <br>
                                    <select class="form-control" name="taskNum"
                                        onchange="javascript:getTaskNum(this.form.taskNum.value)">
                                        <option value="0">직무</option>
                                        <% for (int i=0; i < vTask.size(); i++) { TaskBean taBean=vTask.get(i); %>
                                            <option value="<%=taBean.getTaskNum()%>">
                                                <%=taBean.getTaskName()%>
                                            </option>
                                            <% } %>
                                    </select>
                                    <br>
                                    <select class="form-control" name="themeNum"
                                        onchange="javascript:getThemeNum(this.form.themeNum.value)">
                                        <option value="0">테마</option>
                                        <% for (int i=0; i < vTheme.size(); i++) { ThemeBean thBean=vTheme.get(i); %>
                                            <option value="<%=thBean.getThemeNum()%>">
                                                <%=thBean.getThemeName()%>
                                            </option>
                                            <% } %>
                                    </select>
                                </div>
                            </div>

                            <div>

                                <label for="moimHCount">정원 (1~300)</label>
                                <br>
                                <textarea class="form-control" id="moimHCount" name="moimHCount" rows="2" maxlength="3"
                                    placeholder="300"></textarea>
                                <br>
                            </div>
                                <div>
                                    <label>모임 소개</label>
                                    <br>
                                    <textarea class="form-control" id="moimProfile" name="moimProfile" rows="5"
                                      maxlength="500" placeholder="모임 소개를 작성해주세요"></textarea>
                                    <br>
                                </div>

                                    <div>
                                        <label>카카오톡 오픈채팅방</label>
                                        <textarea class="form-control" id="moimKakao" name="moimKakao" rows="2"
                                            maxlength="30" placeholder="카카오톡 오픈채팅 주소를 입력해주세요."></textarea>
                                        <br>
                                    </div>
                                    
                                    <div id = "addHtml"></div>

                                    <input type="button" value="모임 만들기" class="btn btn-pill text-white btn-block"
                                        style="background-color: pink;" onclick="abc()">
                                        <br>
                                   <input type="hidden" name="memberId" value="<%=memberId %>">
					</div>
                    </form>
                   
                    <form method="GET" name="hiddenFrm">
                        <input type="hidden" name="memberLikeArea_area1">
                        <input type="hidden" name="moimName" value="<%=moimName%>">
                        <input type="hidden" name="moimKakao" value="<%=moimKakao%>">
                        <input type="hidden" name="moimImg" value="<%=moimImg%>">
                        <input type="hidden" name="moimProfile" value="<%=moimProfile%>">
                        <input type="hidden" name="memberAddrZipcode" value="<%=moimZipcode%>">
                        <input type="hidden" name="memberAddrArea1" value="<%=moimArea1%>">
                        <input type="hidden" name="memberAddrArea2" value="<%=moimArea2%>">
                    </form>
                </div>
            </div>
        </div>
    </div>


</body>

	<script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/popper.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/main.js"></script>
    <script type="text/javascript">
        function abc() {

            moimArea1 = document.getElementsByName("moimArea1").item(0).value;
            moimArea2 = document.getElementsByName("moimArea2").item(0).value;
            moimArea = moimArea1 + " " + moimArea2;
            document.frm.moimArea.value = moimArea;
            /*        alert(moimfrm.moimname.value);
                     alert(moimfrm.moimImg.value);
                     alert(moimfrm.moimProfile.value);
                     alert(moimfrm.categoryName.value);
                     alert(moimfrm);  */

            document.frm.submit();
            //location.href = "makemoimProc.jsp";
        }
		
        // 카테고리 이름으로 카테고리번호 보내기
        function getCategoryNum(categoryNum) {
            document.frm.categoryNum.value = categoryNum;
        }
        
        // 비지니스 이름으로 비지니스 번호 보내기
        function getBusinessNum(businessNum) {
            document.frm.businessNum.value = businessNum;
        }
        
        // 테스크 이름으로 테스크 번호 보내기
        function getTaskNum(taskNum) {
            document.frm.taskNum.value = taskNum;
        }
        
        // 테마 이름으로 테마 번호 보내기
        function getThemeNum(themeNum) {
            document.frm.themeNum.value = themeNum;
        }
		
        
        function zipSearch(name) { //우편번호 검색
            url = "zipSearch.jsp?search=n&type=" + name;
            window.open(url, "bigmoim 우편번호 검색", "width=500, height=300, top=100, left=300, scrollbar=yes");
        }

        function setArea2List(memberLikeArea_area1) {
            
        	//
        	doucument.hiddenFrm.moimName.value = document.frm.moimName.value;
            doucument.hiddenFrm.moimImg.value = document.frm.moimImg.value;
            doucument.hiddenFrm.moimKakao.value = document.frm.moimKakao.value;
            doucument.hiddenFrm.moimProfile.value = document.frm.moimProfile.value;
            
			
            //
            document.hiddenFrm.moimZipcode.value = document.frm.moimZipcode.value;
            document.hiddenFrm.moimArea1.value = document.frm.moimArea1.value;
            document.hiddenFrm.moimArea2.value = document.frm.moimArea2.value;

            document.hiddenFrm.submit();
        }
        
        /*모임대표사진 불러오기*/
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
        
        
        // 클래스 개설시 price 추가 모임개설시 삭제
        
        const moimBtn = document.querySelector("#moimBtn");
        const classBtn = document.querySelector("#classBtn");
        const moimOrclass = document.querySelector("#moimtype");
        
        moimBtn.addEventListener("click", () =>{
        	const addHtml = document.querySelector("#addHtml");
        	//alert("모임개설");
        	while(addHtml.hasChildNodes()){
        		addHtml.removeChild(addHtml.lastChild);
        	}
        	moimOrclass.value = 2;
/*         	addHtml.insertAdjacentHTML(
        		"beforeend",
        		"<input id='aa' type='text' placeholder='1번'>"
        	); */
        });
        
        // 193번째 줄로 이동
        
        classBtn.addEventListener("click", () =>{
        const addHtml = document.querySelector("#addHtml");
        
        while(addHtml.hasChildNodes()){
        	addHtml.removeChild(addHtml.lastChild);
        };
        
        // console.log(moimOrclass);
        
        moimOrclass.value = "1";
        
        addHtml.insertAdjacentHTML(
        		"beforeend",
        		"<lable>클래스 회비</lable><br><textarea class = 'form-control' id='classprice' row = '2' name = 'classprice' >"
        	);
        });
      
            
        const change = (name) => {
        	const content = document.querySelector("#frm");
        	const labelList = content.querySelectorAll("label");
        	for(const el of labelList){
        		if(name == "클래스"){
        			console.log(1);
        			el.innerText = el.innerText.replace("모임", "클래스");
        		}else if(name == "모임"){
        			el.innerText = el.innerText.replace("클래스", "모임");
        			console.log(1);
        		}
        	}
        }
        
    </script>
</html>