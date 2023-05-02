<%@ page contentType="text/html; charset=UTF-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="/bigmoim/view/css/clubdetail.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
</head>
<body>
      <nav1>
        <ul class="clubdetail-nav">
          <li class="clubdetail-nav-home" onclick="boardchange(1)" >소개</li>
          <li class="clubdetail-nav-line1">|</li>
          <li class="clubdetail-nav-notice" onclick="boardchange(2)">게시판</li>
          <li class="clubdetail-nav-line2">|</li>
          <li class="clubdetail-nav-notice" onclick="boardchange(3)">사진첩</li>
        </ul>
      </nav1>
</body>

<script>

	const boardchange = (num) =>{
	   const boardtabList = document.querySelectorAll(".mainwrapper");
	   boardtabList.forEach((el) => (el.style.display = "none"));
	   const boardnowTab = document.querySelector(".content"+ num);
	   boardnowTab.style.display = "block";
	};

</script>

</html>