<%@ page contentType="text/html; charset=UTF-8"%>
<%
   String memberId = request.getParameter("memberId");
   int moimNum=Integer.parseInt(request.getParameter("moimNum"));
   System.out.println("m : "+moimNum);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>모임 일정 작성</title>
<style>
       /* 전체 폼 스타일링 */
form {
  width: 40%;
  height: 40%;
  margin: 50px auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 10px;
  font-size: 20px;
  line-height: 1.5;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
}


/* 레이블 스타일링 */
label {
display: block;
margin-bottom: 5px;
font-weight: bold;
}

h2 {
        text-align: center;
        font-size: 2em;
        margin-bottom: 1em;
    }
    
/* 버튼 스타일링 */
    .button-container {
        text-align: center;
    }
    
    .button-container button {
        margin: 1em;
    }
    
/* 텍스트 입력 필드 스타일링 */
input[type="text"], input[type="number"], input[type="date"], input[type="time"] {
  width: 35%;
  padding: 10px;
  margin-bottom: 20px;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-size: 16px;
  box-sizing: border-box;
}

input[name="msHCount"] {
   width: 20%;
}

input[name="memberId"] {
   width: 20%;
}

textarea {
   width: 60%;
     padding: 10px;
     margin-bottom: 20px;
     border: 1px solid #ccc;
     border-radius: 5px;
     font-size: 16px;
     box-sizing: border-box;
}

/* 주소 입력 필드 스타일링 */
.makeschedule-address {
margin-bottom: 20px;
}

.makeschedule-address label {
margin-bottom: 5px;
font-weight: bold;
}

.makeschedule-address input {
margin-bottom: 10px;
}

/* 주소 입력 필드 스타일링 */
.makeschedule-address {
  margin-bottom: 20px;
}

.makeschedule-address label {
  margin-bottom: 5px;
  font-weight: bold;
}

.makeschedule-address input[name="moimZipcode"] {
  margin-bottom: 10px;
  width: 120px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-size: 16px;
  box-sizing: border-box;
}

.makeschedule-address input[type="button"] {
  background-color: rgb(255, 231, 235);
  color: white;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  font-size: 16px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.makeschedule-address input[type="button"]:hover {
  background-color: pink;
}

.makeschedule-address input[name="moimArea1"],
.makeschedule-address input[name="moimArea2"] {
  margin-bottom: 10px;
  width: 200px;
  padding: 10px;
  border: 1px solid #ccc;
  border-radius: 5px;
  font-size: 16px;
  box-sizing: border-box;
}


/* 제출 버튼 스타일링 */
button {
background-color: rgb(255, 231, 235);
color: white;
padding: 10px 20px;
border: none;
border-radius: 5px;
font-size: 18px;
cursor: pointer;
transition: background-color 0.3s;
}

button:hover {
background-color: pink;
}

.makeschedule-wrapper {
  margin-left: 3cm;
}

.makeschedule-button {
   margin-left: 9.5cm;
}

    </style>
    
</head>
<body>
   <form name="frm" action = "makescheduleProc.jsp" method="post" >
   
      <h2> 모임 일정 작성 </h2>
      <br>
      
      <div class = "makeschedule-wrapper">
      <!-- 해당 모임의 관리자 아이디를 불러온다. -->
      <label for="creator_id" >모임장 아이디</label>
      <input type="text" id="memberId" name="memberId" readonly value="<%=memberId %>"><br><br>
      
      <!-- 해당 모임 스케줄의 이름 작성 -->
      <label for="makeschedule-title">모임 일정 제목</label>
      <input type="text" id="msTitle" name="msTitle"><br><br>

      <!-- 해당 모임의 컨텐츠(내용)을 작성 -->
      <label for="makeschedule-content">모임 일정 내용</label>
      <textarea id="msContent" name="msContent"></textarea><br><br>

      <!-- 해당 모임 스케줄의 날짜를 작성 -->
      <label for="makeschedule-date">모임 일정 날짜</label>
      <input type="date" id="msDate" name="msDate"><br><br>

      <!-- 해당 모임 스케줄의 시간을 작성 -->
      <label for="makeschedule-time">모임 일정 시간</label>
      <input type="time" id="msTime" name="msTime"><br><br>

      <!-- 해당 모임의 Zipcode를 불러온다. -->
      <!-- makemoim.jsp 참고 -->
      <div class = "makeschedule-address">
           <label for="">모임주소</label>
           <br>
              <input name="moimZipcode" size="5" readonly value="">
              <input type="button" name="memberAddrBtn" value="우편번호찾기"
                      onClick="zipSearch(this.name)">
              <br>
              <br>
              
              <input name="moimArea1" size="7" value="" readonly >
              <input name="moimArea2" size="10" value="" readonly >
              <input type="hidden" name="msArea" id="msArea">
              <input type="hidden" name="moimNum" id="moimNum" value="<%=moimNum%>">
              <br>
              <br>
        </div>

      <!--  해당 모임 스케줄의 최대 인원을 작성 -->
      <label for="makeschedule-max-attendees">모임 최대 인원 수</label>
      <input type="number" id="msHCount" name="msHCount"><br><br>
      </div>

      <!-- 등록 버튼 -->
      <div class = "makeschedule-button">
         <button onclick="abc()">등록</button>
      </div>
      <br>
   </form>
</body>
<script>
function zipSearch(name) { //우편번호 검색
    url = "zipSearch.jsp?search=n&type=" + name;
    window.open(url, "bigmoim 우편번호 검색", "width=500, height=300, top=100, left=300, scrollbar=yes");
}
function abc() {

    moimArea1 = document.getElementsByName("moimArea1").item(0).value;
    moimArea2 = document.getElementsByName("moimArea2").item(0).value;
    msArea = moimArea1 + " " + moimArea2;
    document.frm.msArea.value = msArea;
    /*        alert(moimfrm.moimname.value);
             alert(moimfrm.moimImg.value);
             alert(moimfrm.moimProfile.value);
             alert(moimfrm.categoryName.value);
             alert(moimfrm);  */

    document.frm.submit();
    //location.href = "makemoimProc.jsp";
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
</script>
</html>