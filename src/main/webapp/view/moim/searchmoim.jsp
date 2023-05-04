<%@page import="model.Bean.MoimBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file = "/view/top.jsp" %>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>

<%
	String str = request.getParameter("searchText").trim();
	String searchText = "";
	for(int i = 0; i < str.length(); i++) {
				if(str.charAt(i) != ' ')
					searchText += str.charAt(i);
	}
	//System.out.println("trim : "+str);
	//out.print(str);
	Vector<MoimBean> searchMoim = moimMgr.searchMoimList(searchText);
%>
<!DOCTYPE html>
<html lang="kr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="/bigmoim/view/css/main.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
  </head>
  <body style = "padding-top: 150px">
  
    <!-- 카테고리 -->
    <%@ include file = "/view/category.jsp" %>
    
    <!-- 카드 -->
    <!-- 클래스 -->
	<% 
	if(memberId==null){ 
    	memberId = "방문자";
    }
	if(searchMoim.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text"> <%=memberId %>님 해당 검색 모임이 없습니다ㅠ</p>
      </div>
    </article>
    <!-- 검색 별 모임 리스트 -->
    		<%
    }else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text"> <%=memberId %>님! 해당 검색 모임입니다</p>
 	     		</div>
    		</article>
    		
    		<div class="card-group">
    		<% 
    		for(int i=0;i<searchMoim.size();i++){
    			MoimBean moimbean = searchMoim.get(i);
    			String cName = cMgr.categoryName(moimbean.getCategoryNum());
    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">

         <%if (memberId!="방문자"){%> 
         <button class="like-btn" id="like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
           <i id="heart<%=moimbean.getMoimNum() %>"
           <%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
           class = "fas fa-heart"
           <% } else{%>
           class = "far fa-heart"
           <%}%>></i>
      		</button>
     	 <%} %>
     	 
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0; color: black; text-decoration: none;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0; color: black; text-decoration: none;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0; color: black; text-decoration: none;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value="" style="margin-top: 0; color: black; text-decoration: none;"><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>
    	  <input type="hidden" name ="jjimNum" value="">
          <input type="hidden" name ="memberId" value="<%=memberId %>">
          <input type="hidden" name ="moimNum" value="">
          <input type="hidden" name ="classNum" value="">
          </form>
    		<%}%><!--for-->
</div><!--card-group-->
<%}//--if-else 
%>
    
    
    <!-- 하단 -->
    <footer>
      <ul>
        <li><a href="#">이용약관</a></li>
        <li><a href="#">개인정보처리방침</a></li>
        <li><a href="#">고객센터</a></li>
        <li><a href="#">대모임 소개</a></li>
        <li><a href="#">대모임 인재채용</a></li>
      </ul>
      <p>&copy; 2023 대모임</p>
    </footer>

    <script>
    function likeBtnChange(num) {
        //Proc에 보내기
        //document.jjimFrm.submit();
        //alert(num)
        let jjimFrm = document.forms["jjimFrm"];
        jjimFrm.moimNum.value = num;
         jjimFrm.submit();
        //$("#jjimFrm").submit();
        
        //색상 변경
       let likeBtn = document.getElementById("heart"+ num)
       if(likeBtn.className == "far fa-heart"){//빈 하트면
          likeBtn.className = "fas fa-heart" //꽉찬 하트로
       }else if(likeBtn.className == "fas fa-heart"){//꽉찬 하트면
          likeBtn.className = "far fa-heart"//빈 하트로
       }
        
    }
      	
    </script>
    </div>
  </body>
</html>