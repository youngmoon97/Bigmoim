<%@page import="java.util.Vector"%>
<%@page import="model.Bean.MoimCategoryBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cMgr" class="controll.Mgr.CategoryMgr"/>

<%
Vector<MoimCategoryBean> cvlist = cMgr.categoryList();
String img = null;
int categoryNum;
%>

<!DOCTYPE html>	
<html>
<head>
	<meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="/bigmoim/view/css/main.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
</head>
<body>
	<!-- 카테고리 -->
    <div class="main-container">
      <main>
      
  <%
  if(cvlist.isEmpty()){
	  out.print("카테고리가 없습니다.");
  }else{
  %>
  <div class="category">
  <%   
	  for(int i=1;i<9;i++){
		  MoimCategoryBean cbean = cvlist.get(i);
		  img = "/bigmoim/image/"+ cbean.getCategoruImg();
		  categoryNum=cbean.getCategoryNum();
  %>
   	  <a href="/bigmoim/view/moim/categorymoim.jsp?num=<%=cbean.getCategoryNum()%>">
      <input type="hidden" name="categoryNum" value="<%=cbean.getCategoryNum()%>">
      <div class = "image-wrapper">
        <img src=<%=img %> alt="" />
        <div class="image-text"><%=cbean.getCategoryName() %></div>
      </div>
      </a>
 <%		}%>
 <% if(cvlist.size() > 9){ %>
 <div class="hidden-category" style="display: none;">
 <%
	  for(int i=9;i<cvlist.size();i++){
		  MoimCategoryBean cbean = cvlist.get(i);
		  img = "/bigmoim/image/"+ cbean.getCategoruImg();
		  categoryNum=cbean.getCategoryNum();
 %>
 	<a href="/bigmoim/view/moim/categorymoim.jsp?num=<%=cbean.getCategoryNum()%>">
      <input type="hidden" name="categoryNum" value="<%=cbean.getCategoryNum()%>">
      <div class = "image-wrapper">
        <img src=<%=img %> alt="" />
        <div class="image-text"><%=cbean.getCategoryName() %></div>
      </div>
      </a>
	<%}
  }%>
 </div>
 <% } %>
 
  <div class="more-wrapper">
      <a href="#" class="more-btn">더보기</a>
  </div>
  
   </div>
</main>
</div>

<script>
  const moreBtn = document.querySelector('.more-btn');
  const hiddenCategories = document.querySelector('.hidden-category');
  let isHidden = true; // hiddenCategories가 숨겨져 있는 상태
  
  moreBtn.addEventListener('click', () => {
    if (isHidden) {
      hiddenCategories.style.display = 'flex';
      hiddenCategories.style.flexWrap = 'wrap';
      hiddenCategories.style.justifyContent = 'space-between';
      hiddenCategories.style.alignContent = 'space-between';
      isHidden = false; // hiddenCategories를 보여주는 상태로 변경
    } else {
      hiddenCategories.style.display = 'none';
      isHidden = true; // hiddenCategories를 숨기는 상태로 변경
    }
  });
</script> 

</body>
</html>