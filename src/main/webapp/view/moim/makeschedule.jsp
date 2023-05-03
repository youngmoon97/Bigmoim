<%@ page contentType="text/html; charset=UTF-8"%>
<%
		
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>모임 일정 작성</title>
    <link rel="stylesheet" href="/bigmoim/view/css/makeschedule.css">
</head>
<body>
	<form>
	
		<h2> 모임 일정 작성 </h2>
		<br>
		
		<!-- 해당 모임의 관리자 아이디를 불러온다. -->
		<label for="creator_id" >모임 생성자 아이디</label>
		<input type="text" id="creator_id" name="creator_id" readonly value=""><br><br>
		
		<!-- 해당 모임 스케줄의 이름 작성 -->
		<label for="makeschedule-title">모임 일정 제목</label>
		<input type="text" id="title" name="title"><br><br>

		<!-- 해당 모임의 컨텐츠(내용)을 작성 -->
		<label for="makeschedule-content">모임 일정 내용</label>
		<textarea id="content" name="content"></textarea><br><br>

		<!-- 해당 모임 스케줄의 날짜를 작성 -->
		<label for="makeschedule-date">모임 일정 날짜</label>
		<input type="date" id="date" name="date"><br><br>

		<!-- 해당 모임 스케줄의 시간을 작성 -->
		<label for="makeschedule-time">모임 일정 시간</label>
		<input type="time" id="time" name="time"><br><br>

		<!-- 해당 모임의 Zipcode를 불러온다. -->
		<!-- makemoim.jsp 참고 -->
		<div class = "makeschedule-address">
           <label for="">모임주소</label>
           <br>
              <input name="makeschedule-Zipcode" size="5" readonly value="">
              <input type="button" name="memberAddrBtn" value="우편번호찾기"
                      onClick="zipSearch(this.name)">
              <br>
              <br>
              
              <input name="moimArea1" size="7" value="" readonly >
              <input name="moimArea2" size="10" value="" readonly >
              <input type="hidden" name="moimArea" id="moimArea">
              
              <br>
              <br>
        </div>

		<!--  해당 모임 스케줄의 최대 인원을 작성 -->
		<label for="makeschedule-max-attendees">모임 최대 인원 수</label>
		<input type="number" id="max_attendees" name="max_attendees"><br><br>

		<!-- 등록 버튼 -->
		<button>등록</button>
	</form>
</body>
</html>
