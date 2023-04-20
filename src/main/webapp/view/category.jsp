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
    <script>
    	function categoryNum(categoryNum){
    		alert(categoryNum);
    		document.category.categoryNum.value=categoryNum;
    		document.category.submit();
    	}
    </script>
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
    		  //System.out.println(img);
    		  categoryNum=cbean.getCategoryNum();
    		  //System.out.println(categoryNum);
      %>
       	  <a href="/bigmoim/view/moim/categorymoim.jsp?num=<%=cbean.getCategoryNum()%>">
          <input type="hidden" name="categoryNum" value="<%=cbean.getCategoryNum()%>">
          <div class = "image-wrapper">
            <img src=<%=img %> alt="" />
            <div class="image-text"><%=cbean.getCategoryName() %></div>
          </div>
          </a>
          
     <%		}%>
     </div>
     <div class="hidden-category">
     <%
    	  for(int i=9;i<cvlist.size();i++){
    		  MoimCategoryBean cbean = cvlist.get(i);
    		  img = "/bigmoim/image/"+ cbean.getCategoruImg();
    		  //System.out.println(img);
    		  categoryNum=cbean.getCategoryNum();
    		  //System.out.println(categoryNum);
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
        <div class = "more-wrapper">
          <a href="#" class="more" >더보기</a>
        </div>
      </div>
    </main>
    </div>
    
</body>
</html>