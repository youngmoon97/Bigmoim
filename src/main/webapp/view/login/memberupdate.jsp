<%@page import="javax.swing.plaf.basic.BasicInternalFrameTitlePane.SystemMenuBar"%>
<%@page import="java.beans.beancontext.BeanContext"%>
<%@page import="model.Bean.MoimCategoryBean"%>
<%@page import="model.Bean.MemberBean"%>
<%@page import="model.Bean.ZipcodeBean"%>
<%@page import="model.Bean.TaskBean"%>
<%@page import="model.Bean.ThemeBean"%>
<%@page import="model.Bean.BusinessBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<jsp:useBean id="macMgr" class="controll.Mgr.MyActivityMgr" />
<jsp:useBean id="cMgr" class="controll.Mgr.CategoryMgr" />
<%
		String memberId = (String)session.getAttribute("idKey");
		if(memberId==null){ //비로그인상태로 켜면 로그인화면으로 이동
			response.sendRedirect("login.html");
			return;
		}
		MemberBean mbean = mMgr.getMember(memberId);
		//ZipcodeBean zbean = mMgr.zipcodeRead(area3);
		
		
		Vector<ZipcodeBean> vCity = mMgr.cityList(); //area1 시
		Vector<ZipcodeBean> vArea2 = null; //area2 구/동
		
		String memberName = mbean.getMemberName(); //이름
		String memberPw=mbean.getMemberPw(); //비밀번호
		String newMemberPw=""; //새 비밀번호
		String newMemberPwConfirm = ""; //새비밀번호 재확인
		String memberTel = ""; //전화번호
		/////////////////////////////////////////////////////////////
		//집주소
		String memberAddr = mbean.getMemberAddr();	
		String[] memberAddrParts = memberAddr.split(" ", 2);
		String memberAddrArea1 = memberAddrParts[0]; 
		String memberAddrArea2 = memberAddrParts[1]; 
		String memberAddrZipcode = "";// 집주소 우편번호
		
		//직장주소(기존값이 없을수도 있음)
		String memberJobAddr = mbean.getMemberJobAddr();
		String memberJobAddrArea1 = "";
		String memberJobAddrArea2 = "";
		if(memberJobAddr!=null){
			String[] memberJobAddrParts = memberJobAddr.split(" ", 2);
			 memberJobAddrArea1 = memberJobAddrParts[0]; 
		 	 memberJobAddrArea2 = memberJobAddrParts[1]; 
		}
		String memberJobAddrZipcode = "";
		
		// 관심지역(기존값이 없을수도 있음)
		String memberLikeArea = mbean.getMemberLikeArea();	
		String memberLikeArea_area1 = "도/시";
		String memberLikeArea_area2 = "구/동";
		if(memberLikeArea!=null){
			String[] memberLikeAreaParts = memberLikeArea.split(" ", 2);
			 memberLikeArea_area1 = memberLikeAreaParts[0];
			 memberLikeArea_area2 = memberLikeAreaParts[1];
		}
		
		//생일
		String memberBirth = mbean.getMemberBirth();
		String[] memberBirthParts = memberBirth.split("-", 3);
		String memberBirth_year = memberBirthParts[0]; // 연
		String memberBirth_month = memberBirthParts[1]; // 월
		String memberBirth_day = memberBirthParts[2]; // 일
		/////////////////////////////////////////////////////////////
		
		if (request.getParameter("memberLikeArea_area1") != null) {
			   memberLikeArea_area1 = request.getParameter("memberLikeArea_area1");
			   memberName = request.getParameter("memberName");
			   memberId = request.getParameter("memberId");
			   memberPw = request.getParameter("memberPw");
			   newMemberPw=request.getParameter("newMemberPw");
			   newMemberPwConfirm = request.getParameter("newMemberPwConfirm");
			   memberTel = request.getParameter("memberTel");
			   
			   memberAddrZipcode = request.getParameter("memberAddrZipcode");
			   memberAddrArea1 = request.getParameter("memberAddrArea1");
			   memberAddrArea2 = request.getParameter("memberAddrArea2");
			   memberJobAddrZipcode = request.getParameter("memberJobAddrZipcode");
			   memberJobAddrArea1 = request.getParameter("memberJobAddrArea1");
			   memberJobAddrArea2 = request.getParameter("memberJobAddrArea2");
			}
			vArea2 = mMgr.area2List(memberLikeArea_area1);

			Vector<BusinessBean> vBusiness = macMgr.businessList(); //업종
			Vector<TaskBean> vTask = macMgr.taskList(); //직무
			Vector<ThemeBean> vTheme = macMgr.themeList(); //테마
			Vector<MoimCategoryBean> vCategory = cMgr.categoryList(); //관심사
%>
<script type="text/javascript">

function setArea2List(memberLikeArea_area1) {
	document.hiddenFrm.memberLikeArea_area1.value = memberLikeArea_area1;  
    document.hiddenFrm.memberPw.value = document.memberUpdateFrm.memberPw.value;
    document.hiddenFrm.newMemberPw.value = document.memberUpdateFrm.newMemberPw.value;
    document.hiddenFrm.newMemberPwConfirm.value = document.memberUpdateFrm.newMemberPwConfirm.value;
    document.hiddenFrm.memberTel.value=document.memberUpdateFrm.memberTel.value;
     
    document.hiddenFrm.memberAddrZipcode.value=document.memberUpdateFrm.memberAddrZipcode.value;
    document.hiddenFrm.memberAddrArea1.value=document.memberUpdateFrm.memberAddrArea1.value;
    document.hiddenFrm.memberAddrArea2.value=document.memberUpdateFrm.memberAddrArea2.value;
    document.hiddenFrm.memberJobAddrZipcode.value=document.memberUpdateFrm.memberJobAddrZipcode.value;
    document.hiddenFrm.memberJobAddrArea1.value=document.memberUpdateFrm.memberJobAddrArea1.value;
    document.hiddenFrm.memberJobAddrArea2.value=document.memberUpdateFrm.memberJobAddrArea2.value;
    document.hiddenFrm.submit();
 }
 
function memberUpdateZipSearch(name) { //우편번호 검색
    url = "memberUpdateZipSearch.jsp?search=n&type=" + name;
    window.open(url, "bigmoim 우편번호 검색", "width=500, height=300, top=100, left=300, scrollbar=yes");
 }
 
 function newMemberPwCheck(){//새 비밀번호 검사(기존 비밀번호와 다른지/새 비밀번호 확인과 같은지)
	 let memberPw = document.memberUpdateFrm.memberPw;
	 let newMemberPw = document.memberUpdateFrm.newMemberPw;
	 let newMemberPwConfirm = document.memberUpdateFrm.newMemberPwConfirm;
	if (newMemberPw.value == memberPw.value){
		alert("기존과 다른 비밀번호를 사용해주세요.");
		newMemberPw.focus();
		return;
	}else{
		if(newMemberPw.value!=newMemberPwConfirm.value){
			alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
			newMemberPwConfirm.focus();
			return false;
		}else{
			memberPw.value = newMemberPw.value;
			return true;
		}
	}
 }
 
function memberPwCheck(){//현재 비밀번호 검사(DB의 비밀번호와 같은지=> 같으면 새 비밀번호가 있는지 검사
// 새 비밀번호가 있으면 newMemberPwCheck() 실행=> 새 비번 값을 현재비번 값으로 넣음 => dataFormat()실행하고 submit)\
   let  memberPw = document.memberUpdateFrm.memberPw;
   let  newMemberPw = document.memberUpdateFrm.newMemberPw;
	if(memberPw.value.trim() == ""){
		 alert("현재 비밀번호를 입력해주세요.");
		    if (memberPw) {
		      memberPw.focus();
		      return;
		    }
	}else{
		if(memberPw.value!='<%=mbean.getMemberPw()%>'){
			alert("비밀번호를 정확히 입력해주세요.");
			memberPw.focus();
			return;
		}else{
			if (newMemberPw.value.trim() != ""){
				if(newMemberPwCheck()==true){
					dataFormat();
					document.memberUpdateFrm.submit();
				}else{
					return;
				}
			}else{ //새 비밀번호 미입력시
				//alert("새 비밀번호 미입력");
				dataFormat();
				document.memberUpdateFrm.submit();
			} //--맨아래 else
		}//--2번째 else
	}// --맨위 else	
 }// function
 
//선택된 값들을 가져와서 세팅
 function getYear(memberBirth_year){
    document.memberUpdateFrm.memberBirth_year.value=memberBirth_year;
 }
 function getMonth(memberBirth_month){
    document.memberUpdateFrm.memberBirth_month.value=memberBirth_month;
 }
 function getDay(memberBirth_day){
    document.memberUpdateFrm.memberBirth_day.value=memberBirth_day;
 }
 
 function getCategoryNum(categoryNum){
    document.memberUpdateFrm.categoryNum.value=categoryNum;
 }
 function getBusinessNum(businessNum){
    document.memberUpdateFrm.businessNum.value=businessNum;
 }
 function getTaskNum(taskNum){
    document.memberUpdateFrm.taskNum.value=taskNum;
 }
 function getThemeNum(themeNum){
    document.memberUpdateFrm.themeNum.value=themeNum;
 }
 
 function dataFormat(){ //String data들 붙이기
		//회원 집주소 붙여서 값 저장
		memberAddrArea1=document.getElementsByName("memberAddrArea1").item(0).value;
		memberAddrArea2=document.getElementsByName("memberAddrArea2").item(0).value;
		memberAddr=memberAddrArea1+" "+memberAddrArea2;
		document.memberUpdateFrm.memberAddr.value = memberAddr;
		//회원 직장주소 붙여서 값 저장
		memberJobAddrArea1=document.getElementsByName("memberJobAddrArea1").item(0).value;
		memberJobAddrArea2=document.getElementsByName("memberJobAddrArea2").item(0).value;
		memberJobAddr=memberJobAddrArea1+" "+memberJobAddrArea2;
		document.memberUpdateFrm.memberJobAddr.value = memberJobAddr;
		//회원 생일 붙여서 값 저장
		memberBirth_year=document.getElementsByName("memberBirth_year").item(0).value;
		memberBirth_month=document.getElementsByName("memberBirth_month").item(0).value;
		memberBirth_day=document.getElementsByName("memberBirth_day").item(0).value;
		memberBirth = memberBirth_year+"-"+memberBirth_month+"-"+memberBirth_day;
		document.memberUpdateFrm.memberBirth.value = memberBirth;
		//관심지역 붙여서 값 저장
		memberLikeArea_area1=document.getElementsByName("memberLikeArea_area1").item(0).value;
		memberLikeArea_area2=document.getElementsByName("memberLikeArea_area2").item(0).value;
		memberLikeArea=memberLikeArea_area1+" "+memberLikeArea_area2;
		document.memberUpdateFrm.memberLikeArea.value = memberLikeArea;
 }
 
 function phoneOK(){ //전화인증
	 
 }
</script>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="../css/owl.carousel.min.css">

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

        .file-input-container input[type=file] {
            position: absolute;
            top: 10px;
            /* 파일 선택 버튼을 부모 요소의 오른쪽 상단에 위치시킴 */
            margin-top: 20px;
            /* 버튼과 상위 요소 간의 간격을 20px로 지정함 */
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
            margin-right: 0.5em;
            /* 이미지와 글씨 사이의 간격 조절 */
            margin-top: -9px;
            /* 원하는 위치만큼의 음수 값을 입력하여 이미지를 높일 수 있습니다. */
            margin-left: -16em;
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

        /* 파일 선택 버튼 숨기기 */
        #profile-image {
            display: none;
        }

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
    </style>

    <title>내 정보 수정</title>
</head>

<body>
    <div class="main-wrapper">
        <div class="main-container">
            <div class="category">
                <div class="main-merge">
                    <div class="back-button" style="margin-top: 3em">
                        <!--a 태그에 메인 URL 입력해야함-->
                        <a href="javascript:history.back();">
                            <img src="/bigmoim/image/back-button.png" alt="뒤로가기" style="filter: FFC0C;" />
                        </a>
                        <h3 style="margin-left: -7.5em"><strong>프로필 수정</strong></h3>
                    </div>
                    <form name="memberUpdateFrm" action="memberupdateProc.jsp" method="POST" enctype="multipart/form-data">
                        <div style="width: 500px; font-size: 16px;">
                            <div class="sign-nameHeader">
                                <br>
                                <input type="text" class="form-control" name="memberName" value="<%=mbean.getMemberName()%>"
                                    readonly>
                            </div>

                            <!--버튼이 한줄에 오기위해  부모에 input-button-wrapper 추가후 
                                    css 수정-->
                            <div class="sign-nameHeader">
                                <br>
                                <input type="text" class="form-control" name="memberId" value="<%=mbean.getMemberId()%>" readonly>

                            </div>

							<div class="sign-nameHeader">
                                <label>현재 비밀번호</label>
                                <input type="password" class="form-control" name="memberPw" id="memberPw_id"
                                >
                            </div>

                            <div class="sign-nameHeader">
                                <label>새 비밀번호</label>
                                <input type="password" class="form-control" name="newMemberPw" id="newMemberPw_id"
                                placeholder="비밀번호 변경을 희망하시면 입력하세요">
                            </div>

                            <div class="sign-nameHeader">
                                <label for="passwordConfirm">새 비밀번호 재확인</label>
                                <input type="password" class="form-control" name="newMemberPwConfirm" id="newMemberPwConfirm_id"
                                placeholder="새 비밀번호 재확인">
                            </div>

                            <div class="sign-nameHeader">
                                <label for="memberTel">전화번호</label>
                                <div class="input-button-wrapper">
                                    <input type="text" class="form-control" name="memberTel" value="<%=mbean.getMemberTel()%>">
                                    <button type="button" onclick="phoneOK()"
                                        style="background: pink; color: #fff; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px;">인증</button>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="sign-nameHeader">
                                        <label for="memberAddr">집주소</label>
                                    </div>
                                    <div>
                                        
                                        <input name="memberAddrZipcode" size="5" style="height: 40px;" 
                                        value="<%=memberAddrZipcode%>"readonly >
                                        <input type="button" name ="memberAddrBtn" value="우편번호찾기" onClick="memberUpdateZipSearch(this.name)"
                                            style="background: pink; color: #fff; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px; height: 40px;">
                                    </div>
                                    <div class="sign-nameHeader">
                                        <br>
                                        <input name="memberAddrArea1" size="7" value="<%=memberAddrArea1%>" readonly>
                                        <input name="memberAddrArea2" size="10" value="<%=memberAddrArea2%>" readonly>
                                        <input type="hidden" name="memberAddr" id="memberAddr">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="sign-nameHeader">
                                        <label >직장 주소</label>
                                        <br />
                                    </div>
                                    <div>
                                        
                                         <input name="memberJobAddrZipcode" size="5" style="height: 40px;" 
                                        value="<%=memberJobAddrZipcode%>"readonly >
                                        <input type="button" name="memberJobAddrBtn" value="우편번호찾기" onClick="memberUpdateZipSearch(this.name)"
                                            style="background: pink; color: #fff; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px; height: 40px;">
                                    </div>
                                    <div class="sign-nameHeader">
                                        <br>
                                        <input name="memberJobAddrArea1" size="7" value="<%=memberJobAddrArea1%>" readonly>
                                        <input name="memberJobAddrArea2" size="10" value="<%=memberJobAddrArea2%>" readonly>
                                        <input type="hidden" name="memberJobAddr" id="memberJobAddr">
                                    </div>
                                </div>
                            </div>

                            <div class="sign-nameHeader fourth">
                                <label for="memberLikeArea">관심 지역</label>
                                <br>
                            </div>

                            <div class="sign-nameHeader">
                                <div class="form-row">
                                    <div class="col">
                                        <select class="form-control" name="memberLikeArea_area1" id="memberLikeArea_area1"
                                        onchange="javascript:setArea2List(this.form.memberLikeArea_area1.value)">
                                                   <option><%=memberLikeArea_area1%></option>
                                                          <%
                                                    for (int i = 0; i < vCity.size(); i++) {
                                                        ZipcodeBean bean = vCity.get(i);
                                                %>
                                                <option value="<%=bean.getArea1()%>">
                                                    <%=bean.getArea1()%>
                                                </option>
                                                <%
                                                    }
                                                %>
                                                </select>
                                    </div>
                                    
                                    <div class="col">
                                        <select class="form-control" name="memberLikeArea_area2" id="memberLikeArea_area2">
                                            <option value=""><%=memberLikeArea_area2 %></option>
                                        <%
                                                    for (int i = 0; i < vArea2.size(); i++) {
                                                        ZipcodeBean bean = vArea2.get(i);
                                                %>
                                                <option value="<%=bean.getArea2()%>">
                                                    <%=bean.getArea2()%>
                                                </option>
                                                <%
                                                    }
                                                %>
                                                </select>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="memberLikeArea">

                            <div class="sign-nameHeader">
                                <label>생일</label>
                                <br>

                            </div>
                            <div class="sign-nameHeader">
                                <div class="form-row">
                                    <div class="col">
                                        <select class="form-control" name="memberBirth_year" id="year">
                                            <option value="<%=memberBirth_year
                                            %>"><%=memberBirth_year
                                            %></option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <select class="form-control" name="memberBirth_month" id="month">
                                            <option value="<%=memberBirth_month
                                            %>"><%=memberBirth_month
                                            %></option>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <select class="form-control" name="memberBirth_day" id="day">
                                            <option value="<%=memberBirth_day
                                            %>"><%=memberBirth_day
                                            %></option>
                                        </select>
                                        <input type="hidden" name="memberBirth" id="memberBirth">
                                    </div>
                                </div>
                            </div>

                            <script>
                                // 연도 옵션 생성
                                var yearSelect = document.getElementById("year");
                                var currentYear = new Date().getFullYear();
                                for (var i = currentYear; i >= 1900; i--) {
                                    var option = document.createElement("option");
                                    option.text = i;
                                    option.value = i;
                                    yearSelect.add(option);
                                }

                                // 월 옵션 생성
                                var monthSelect = document.getElementById("month");
                                for (var i = 1; i <= 12; i++) {
                                    var option = document.createElement("option");
                                    option.text = i;
                                    option.value = i;
                                    monthSelect.add(option);
                                }

                                // 일 옵션 생성
                                var daySelect = document.getElementById("day");
                                for (var i = 1; i <= 31; i++) {
                                    var option = document.createElement("option");
                                    option.text = i;
                                    option.value = i;
                                    daySelect.add(option);
                                }
                            </script>

                            <div class="sign-nameHeader">
                                <label>업종 / 직무 / 테마</label>
                                <br>
                            </div>

                            <div class="sign-nameHeader">
                                <div class="form-row">
                                    <div class="col">
                                        <select class="form-control" name="businessNum"
                                        onChange="javascript:getBusinessNum(this.form.businessNum.value)">
                                            <option value=<%=mbean.getBusinessNum() %>>
                                            <%=macMgr.getBusinessName(mbean.getBusinessNum()) %></option>
                                             <%
                                                    for (int i = 0; i < vBusiness.size(); i++) {
                                                        BusinessBean bBean = vBusiness.get(i);
                                                %>
                                                <option value="<%=bBean.getBusinessNum()%>">
                                                    <%=bBean.getBusinessName()%>
                                                </option>
                                                <%
                                                    }
                                                %>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <select class="form-control" name="taskNum"
                                        onChange="javascript:getTaskNum(this.form.taskNum.value)">
                                            <option value="<%=mbean.getTaskNum()%>">
                                            <%=macMgr.getTaskName(mbean.getTaskNum()) %></option>
                                                 <%
                                                    for (int i = 0; i < vTask.size(); i++) {
                                                        TaskBean taBean = vTask.get(i);
                                                %>
                                                <option value="<%=taBean.getTaskNum()%>">
                                                    <%=taBean.getTaskName()%>
                                                </option>
                                                <%
                                                    }
                                                %>
                                        </select>
                                    </div>
                                    <div class="col">
                                        <select class="form-control" name="themeNum"
                                        onChange="javascript:getThemeNum(this.form.themeNum.value)">
                                            <option value="<%=mbean.getThemeNum()%>">
                                            <%=macMgr.getThemeName(mbean.getThemeNum()) %></option>
                                             <%
                                                    for (int i = 0; i < vTheme.size(); i++) {
                                                        ThemeBean thBean = vTheme.get(i);
                                                %>
                                                <option value="<%=thBean.getThemeNum()%>">
                                                    <%=thBean.getThemeName()%>
                                                </option>
                                                <%
                                                    }
                                                %>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="sign-nameHeader">
                                <label for="memberSex">성별</label>
                                <br>
                            </div>
                            <div style="text-align: center;">
                                <div class="d-inline-block" style="margin-right: 50px;">
                                    <input class="form-check-input" type="radio" name="memberSex" id="memberSex_male"
                                        value="1" <%if (mbean.getMemberSex()==1){%>
                                        checked="checked"
                                        <% }%>>
                                    <label class="form-check-label" for="male">
                                        남자
                                    </label>
                                </div>
                                <div class="d-inline-block" style="margin-left: 50px;">
                                    <input class="form-check-input" type="radio" name="memberSex" id="memberSex_female"
                                        value="2" <%if (mbean.getMemberSex()==2){%>
                                        checked="checked"
                                        <% }%>>
                                    <label class="form-check-label" for="female">
                                        여자
                                    </label>
                                </div>
                            </div>

                            <div class="sign-nameHeader">
                                <label>관심사</label>
                                <br>
                            </div>
                            <div class="col">
                                <select class="form-control" id="categoryNum" name="categoryNum"
                                onChange="javascript:getCategoryNum(this.form.categoryNum.value)">
                                    <option value="<%=mbean.getCategoryNum() %>"><%=cMgr.categoryName(mbean.getCategoryNum()) %></option>
                                                         <%
                                            for (int i = 0; i < vCategory.size(); i++) {
                                                MoimCategoryBean mcBean = vCategory.get(i);
                                        %>
                                        <option value="<%=mcBean.getCategoryNum()%>">
                                                <%=mcBean.getCategoryName()%>
                                                <%
                        }
                        %>
                                </select>
                            </div>
                                <br>
                            <div class="sign-nameHeader">
                                <label>회원사진</label>
                                <br>
                            </div>
							<%
							String img = "/bigmoim/image/"+mbean.getMemberImg();
							%>
                            <div class="image-preview-container">
                                <img id="preview-image" src="<%=img %>" alt="Preview Image">
                                <label for="profile-image" class="file-input-container">사진 선택하기</label>
                                <input type="file" class="form-control-file" id="profile-image" name="memberImg"
                                    onchange="showPreviewImage(this)">
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

                            <br>
                            <br>
                            <div class="sign-nameHeader">
                                <label>자기소개</label>
                                <br>
                            </div>

                            <div class="sign-nameHeader">
                                <textarea class="form-control" id="memberProfile" name="memberProfile" rows="4"
                                    maxlength="100"
                                    style="color: black;"><%=mbean.getMemberProfile()%></textarea>
                            </div>
                            <input type="button" value="수정하기" class="btn btn-pill text-white btn-block"
                                style="background-color: pink;"
                                onclick="memberPwCheck()">

                        </div>
                </div>
                </form>
                  <form method="POST" name="hiddenFrm">
                        <input type="hidden" name="memberLikeArea_area1">
                        <input type="hidden" name="memberName" value="<%=memberName%>">
                        <input type="hidden" name="memberId" value="<%=memberId%>">
                        <input type="hidden" name="memberPw" value="<%=memberPw%>">
                        <input type="hidden" name="newMemberPw" value="<%=newMemberPw%>">
                        <input type="hidden" name="newMemberPwConfirm" value="<%=newMemberPwConfirm%>">
                        <input type="hidden" name="memberTel" value="<%=memberTel%>">

                        <input type="hidden" name="memberAddrZipcode" value="<%=memberAddrZipcode%>">
                        <input type="hidden" name="memberAddrArea1" value="<%=memberAddrArea1%>">
                        <input type="hidden" name="memberAddrArea2" value="<%=memberAddrArea2%>">
                        <input type="hidden" name="memberJobAddrZipcode" value="<%=memberJobAddrZipcode%>">
                        <input type="hidden" name="memberJobAddrArea1" value="<%=memberJobAddrArea1%>">
                        <input type="hidden" name="memberJobAddrArea2" value="<%=memberJobAddrArea2%>">
                    </form>
            </div>
        </div>
    </div>
   
  
    <script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/main.js"></script>
</body>

</html>