<%@page import="model.Bean.MoimBean"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"></jsp:useBean>
<%@ include file = "/view/top.jsp" %>
<%
	Vector<MoimBean> classList = moimMgr.classList();
%>
<!DOCTYPE html>
<html lang="kr">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>대모임에 오신걸 환영합니다!</title>
    <link type="text/css" rel="stylesheet" href="/bigmoim/view/css/main.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    	
    	footer ul {
  			padding-left: 9cm;
		}

		footer p {
			padding-right: 10cm;
		}
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
	if(classList.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text"> <%=memberId %>님 주변 클래스 모임이 아직 없습니다 ㅠ</p>
      </div>
    </article>
    <!-- 클래스 리스트 -->
    		<%
    }else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text"> <%=memberId %>님! 클래스 모임입니다</p>
 	     		</div>
    		</article>
    		
    		<div class="card-group">
    		<% 
    		for(int i=0;i<classList.size();i++){
    			MoimBean moimbean = classList.get(i);
    			String cName = cMgr.categoryName(moimbean.getCategoryNum());
    		%>
    		
      		<article class="card">
      		  
      		
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="card-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			//System.out.println("img : "+img);
    		%>
    		
          <img src=<%=img %> alt="Image">
		<form name="jjimFrm" action="jjimProc.jsp" method="get">
		
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
        <h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0; color: black; text-decoration: none;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0; color: black; text-decoration: none;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0; color: black; text-decoration: none;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value="" style="margin-top: 0; color: black; text-decoration: none;"><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>
    		<%}%><!--for-->
    		<input type="hidden" name ="jjimNum" value="">
    		<input type="hidden" name ="memberId" value="<%=memberId %>">
    		<input type="hidden" name ="moimNum" value="">
    		<input type="hidden" name ="classNum" value="">
    		</form>
 
</div><!--card-group-->
<%}//--if-else 
%>

   

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
   <!-- bottom.jsp -->
    <%@ include file = "/view/bottom.jsp" %>
  </body>
</html>
        
