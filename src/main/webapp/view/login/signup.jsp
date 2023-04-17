<%@page import="model.Bean.MoimCategoryBean"%>
<%@page import="model.Bean.TaskBean"%>
<%@page import="model.Bean.ThemeBean"%>
<%@page import="model.Bean.BusinessBean"%>
<%@page import="model.Bean.ZipcodeBean"%>
<%@page import="java.util.Vector"%>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr" />
<jsp:useBean id="macMgr" class="controll.Mgr.MyActivityMgr" />
<jsp:useBean id="cMgr" class="controll.Mgr.CategoryMgr" />
<%
Vector<ZipcodeBean> vCity = mMgr.cityList(); //area1 시
String area1 = "서울"; //시
String memberName = ""; //이름
String memberId = ""; //Id
String memberPw = ""; //비밀번호
String memberPwConfirm = ""; //비밀번호확인
String memberTel = ""; //전화번호

Vector<ZipcodeBean> vArea2 = null; //area2 구/동
if (request.getParameter("area1") != null) {
	area1 = request.getParameter("area1");
	memberName = request.getParameter("memberName");
	memberId = request.getParameter("memberId");
	memberPw = request.getParameter("memberPw");
	memberPwConfirm = request.getParameter("memberPwConfirm");
	memberTel = request.getParameter("memberTel");
}
vArea2 = mMgr.area2List(area1);
//System.out.println(vArea2.get(1));

Vector<BusinessBean> vBusiness = macMgr.businessList(); //업종
Vector<TaskBean> vTask = macMgr.taskList(); //직무
Vector<ThemeBean> vTheme = macMgr.themeList(); //테마
Vector<MoimCategoryBean> vCategory = cMgr.categoryList(); //관심사
%>

<!doctype html>
<html lang="en">

<head>
<script type = "text/javascript" src="signupScript.js"></script>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap"
	rel="stylesheet">

<link rel="stylesheet" href="fonts/icomoon/style.css">

<link rel="stylesheet" href="css/owl.carousel.min.css">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="css/bootstrap.min.css">

<!-- Style -->
<link rel="stylesheet" href="css/style.css">

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
</style>


<!--중복확인 기능 스크립트 (나중에 js로 옮겨야함)-->
<script>
	function checkDuplicate() {
		// 입력된 아이디 가져오기
		var username = document.getElementById("username").value;

		// 아이디 중복 확인 로직 추가
		// 중복된 경우 처리하는 로직 구현

		// 예시: 중복된 경우 알림창으로 메시지 출력
		if (username === "중복된아이디") {
			alert("중복된 아이디입니다. 다른 아이디를 입력해주세요.");
		} else {
			alert("사용 가능한 아이디입니다.");
		}
	}

	function setArea2List(area1) {
		//alert(area1);
		document.hiddenFrm.area1.value = area1;
		document.hiddenFrm.memberName.value = document.signFrm.memberName.value;
		document.hiddenFrm.memberId.value = document.signFrm.memberId.value;
		document.hiddenFrm.memberPw.value = document.signFrm.memberPw.value;
		document.hiddenFrm.memberPwConfirm.value = document.signFrm.memberPwConfirm.value;
		document.hiddenFrm.memberTel.value=document.signFrm.memberTel.value;
		document.hiddenFrm.submit();
	}
	
	function zipSearch() { //우편번호 검색
		url = "zipSearch.jsp?search=n";
		window.open(url, "bigmoim 우편번호 검색", "width=500, height=300, top=100, left=300, scrollbar=yes");
	}
</script>

<title>회원가입</title>
</head>

<body>

	<div class="content">
		<div class="wrapper">
			<div class="row justify-content-center">
				<div class="col-md-6 contents">
					<div class="row justify-content-center">
						<div class="col-md-12">
							<div class="main-merge">
								<div>
									<h3>
										<strong>회원가입</strong>
									</h3>
								</div>
								<form name="signFrm" action="signProc.jsp" method="post">
									<div class="sign-nameHeader">
										<label for="memberName">이름(필수)</label> 
										<input class="form-control" id="memberName" name="memberName" value="<%=memberName%>">
									</div>

									<!--버튼이 한줄에 오기위해  부모에 input-button-wrapper 추가후 
                                    css 수정-->
									<div class="sign-nameHeader">
										<div class="input-button-wrapper">
										<label for="memberId">아이디(필수)</label>
											<input class="form-control" id="memberId" name="memberId" value="<%=memberId%>">
											<button onclick="checkDuplicate()">중복확인</button>
										</div>
									</div>
									
									<div class="sign-nameHeader">
										<label for="memberPw">비밀번호(필수)</label> 
										<input type="password" class="form-control" id="memberPw" name="memberPw" value="<%=memberPw%>">
									</div>

									<div class="sign-nameHeader">
										<label for="memberPwConfirm">비밀번호 재확인</label> <input
											type="password" class="form-control" id="memberPwConfirm" name="memberPwConfirm"
											value="<%=memberPwConfirm%>">
									</div>

									<div class="sign-nameHeader">
										<label for="memberTel">전화번호(필수)</label>
										<div class="input-button-wrapper">
											<input type="text" class="form-control" id="memberTel" name="memberTel" value="<%=memberTel%>">
										</div>
									</div>

									<!--집주소 zipcode 그대로 사용한다고 가정-->
									<div class="sign-nameHeader">
										<label for="memberAddr">집주소</label>
									</div>
									<div>
										<br> <input name="memberAddrZipcode" size="5" readonly> <input name="memberAddrBtn"
											type="button" value="우편번호찾기" onClick="zipSearch()">
									</div>
									<div class="sign-nameHeader">
										<br> <input name="memberAddrArea1" size="7" readonly>
										<input name="memberAddrArea2" size="10" readonly>
									</div>

									<div class="sign-nameHeader">
										<label for="memberJobAddr">직장 주소</label> <br />
									</div>
									<div>
										<input name="memberJobAddrZipcode" size="5" readonly> <input name="memberJobAddrBtn"
											type="button" value="우편번호찾기" onClick="zipSearch()">
										<div class="sign-nameHeader">
											<br> <input name="memberJobAddrArea1" size="7" readonly>
											<input name="memberJobAddrArea2" size="10" readonly>
										</div>
									</div>

									<div class="sign-nameHeader fourth">
										<label for="memberLikeArea">관심 지역</label> <br>
									</div>

									<div class="sign-nameHeader">
										<div class="form-row">
											<div class="col">
												<form name="f1">
													<select class="form-control" name="area1" id="area1"
														onclick="setCityList()"
														onchange="javascript:setArea2List(this.form.area1.value)">
														<option value=""><%=area1%></option>
														<%
														for (int i = 0; i < vCity.size(); i++) {
															ZipcodeBean bean = vCity.get(i);
														%>
														<option value="<%=bean.getArea1()%>">
															<%=bean.getArea1()%></option>
														<%
														}
														%>
													</select>
													<script type="text/javascript">
														
													</script>
											</div>
											<div class="col">
												<select class="form-control" name="area2" id="area2">
													<option value="">구/동</option>
													<%
													for (int i = 0; i < vArea2.size(); i++) {
														ZipcodeBean bean = vArea2.get(i);
													%>
													<option value="<%=bean.getArea2()%>">
														<%=bean.getArea2()%></option>
													<%
													}
													%>
												</select>
								</form>
							</div>
						</div>
					</div>

					<form method="GET" name="hiddenFrm">
						<input type="hidden" name="area1"> 
						<input type="hidden"	 name="memberName" value="<%=memberName%>">
						<input type="hidden"	 name="memberId" value="<%=memberId%>">
						<input type="hidden"	 name="memberPw" value="<%=memberPw%>">
						<input type="hidden"	 name="memberPwConfirm" value="<%=memberPwConfirm%>">
						<input type="hidden"	 name="memberTel" value="<%=memberTel%>">
					</form>

					<div class="sign-nameHeader">
						<label for="jobadd">생일</label> <br>

					</div>
					<div class="sign-nameHeader">
						<div class="form-row">
							<div class="col">
								<select class="form-control" id="memberBirth_year" name="memberBirth_year">
									<option value="">연도</option>
								</select>
							</div>
							<div class="col">
								<select class="form-control" id="memberBirth_month" name="memberBirth_month">
									<option value="">월</option>
								</select>
							</div>
							<div class="col">
								<select class="form-control" id="memberBirth_day" name="memberBirth_day">
									<option value="">일</option>
								</select>
							</div>
						</div>
					</div>

					<script>
						// 연도 옵션 생성
						var yearSelect = document.getElementById("memberBirth_year");
						var currentYear = new Date().getFullYear();
						for (var i = currentYear; i >= 1900; i--) {
							var option = document.createElement("option");
							option.text = i;
							option.value = i;
							yearSelect.add(option);
						}

						// 월 옵션 생성
						var monthSelect = document.getElementById("memberBirth_month");
						for (var i = 1; i <= 12; i++) {
							var option = document.createElement("option");
							option.text = i;
							option.value = i;
							monthSelect.add(option);
						}

						// 일 옵션 생성
						var daySelect = document.getElementById("memberBirth_day");
						for (var i = 1; i <= 31; i++) {
							var option = document.createElement("option");
							option.text = i;
							option.value = i;
							daySelect.add(option);
						}
					</script>


					<div class="sign-nameHeader">
						<label for="jobadd">업종 / 직무 / 테마</label> <br>

					</div>

					<div class="sign-nameHeader">

						<div class="form-row">

							<div class="col">
								<select class="form-control" id="year">
									<option value="">업종</option>
									<%
									for (int i = 0; i < vBusiness.size(); i++) {
										BusinessBean bBean = vBusiness.get(i);
									%>
									<option value="<%=bBean.getBusinessName()%>">
										<%=bBean.getBusinessName()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="col">
								<select class="form-control" id="month">
									<option value="">직무</option>
									<%
									for (int i = 0; i < vTask.size(); i++) {
										TaskBean taBean = vTask.get(i);
									%>
									<option value="<%=taBean.getTaskName()%>">
										<%=taBean.getTaskName()%></option>
									<%
									}
									%>
								</select>
							</div>
							<div class="col">
								<select class="form-control" id="day">
									<option value="">테마</option>
									<%
									for (int i = 0; i < vTheme.size(); i++) {
										ThemeBean thBean = vTheme.get(i);
									%>
									<option value="<%=thBean.getThemeName()%>">
										<%=thBean.getThemeName()%></option>
									<%
									}
									%>
								</select>
							</div>
						</div>
					</div>
					<div class="sign-nameHeader">
						<label for="memberSex">성별</label> <br>
					</div>
					<div style="text-align: center;">
						<div class="d-inline-block" style="margin-right: 50px;">
							<input class="form-check-input" type="radio" name="memberSex_male"
								id="male" value="male" checked> <label class="form-check-label"
								for="male"> 남자 </label>
						</div>
						<div class="d-inline-block" style="margin-left: 50px;">
							<input class="form-check-input" type="radio" name="memberSex_female"
								id="female" value="female"> <label
								class="form-check-label" for="female"> 여자 </label>
						</div>
					</div>

					<div class="sign-nameHeader">
						<label for="categoryNum">관심사</label> <br>
					</div>
					<div class="col">
						<select class="form-control" id="day">
							<option value="categoryNum_select">관심사 선택</option>
							<%
							for (int i = 0; i < vCategory.size(); i++) {
								MoimCategoryBean mcBean = vCategory.get(i);
							%>
							<option value="<%=mcBean.getCategoryName()%>">
								<%=mcBean.getCategoryName()%>
								<%
								}
								%>		
						</select>
					</div>

					<div class="sign-nameHeader">
						<label for="memberImg">회원사진</label> <br>
					</div>

					<div class="image-preview-container">
						<img id="preview-image" src="" alt="Preview Image">
						<div class="file-input-container">
							<input type="file" class="form-control-file" id="profile-image"
								name="profile-image" onchange="showPreviewImage(this)">
						</div>
					</div>

					<script>
						function showPreviewImage(input) {
							var previewImage = document
									.getElementById('preview-image');
							if (input.files && input.files[0]) {
								var reader = new FileReader();
								reader.onload = function(e) {
									previewImage.src = e.target.result;
								}
								reader.readAsDataURL(input.files[0]);
							} else {
								previewImage.src = '';
							}
						}
					</script>

					<br> <br>
					<div class="sign-nameHeader">
						<label for="memberProfile_text">자기소개</label> <br>
					</div>

					<div class="sign-nameHeader">
						<textarea class="form-control" id="memberProfile_content" name="memberProfile_content"
							rows="4" maxlength="100" placeholder="자기소개를 해주세요. (100자 이내)"></textarea>
					</div>
					<input type="button" value="가입하기" onclick ="inputCheck()"
						class="btn btn-pill text-white btn-block"
						style="background-color: pink;">
				</div>
			</div>
			</form>
		</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	</div>
	<script src="js/jquery-3.3.1.min.js"></script>
	<script src="js/popper.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/main.js"></script>
</body>
</html>