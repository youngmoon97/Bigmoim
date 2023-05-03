<%@page import="model.Bean.MoimBean"%>
<%@ include file = "/view/top.jsp" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<%	
	// top에 있는 멤버 데이터 가져와서 
	String address = mbean.getMemberAddr();
	mbean= mMgr.getMember(memberId);
	Vector<MoimBean> newMoimList = moimMgr.newMoimList(address);
	Vector<MoimBean> newMoimListnoaddr = moimMgr.newMoimList();
	Vector<MoimBean> allMoim = moimMgr.moimAllList();
	if(memberId==null){ 
    	memberId = "방문자";
    }
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
    <!-- 신규모임 -->
	<% if(memberId!=null){ //로그인한 상태
	if(newMoimList.isEmpty()){
    %>
    <article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text"> <%=memberId %>님 주변 신규 모임이 없습니다 ㅜ</p>
      </div>
    </article>
    <!-- 신규모임 리스트 -->
    		<%
    }else{//--if-else %>
    		<article>
      			<div class = "text">
		        <p class = "join-text"> <%=memberId %>님 주변 추천 신규 모임입니다</p>
 	     		</div>
    		</article>
    		
    		<div class="card-group">
    		<% 
    		for(int i=0;i<newMoimList.size();i++){
    			MoimBean moimbean = newMoimList.get(i);
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

     	<form name="jjimFrm" action="../main/jjimProc.jsp" method="get">
			<%if (memberId!="방문자"){%> 
         <button class="like-btn" id="like-btn-<%=moimbean.getMoimNum()%>"
          onclick="likeBtnChange(<%=moimbean.getMoimNum()%>)" style="color:red; bgcolor: white;">
  			<i id="heart<%=moimbean.getMoimNum() %>"
  			<%if(moimMgr.jjimCheck(memberId, moimbean.getMoimNum())){ %>
  			class = "fas fa-heart"<% } else{%>
  			class = "far fa-heart"
  			<%}%>></i>
			</button>
			<%} %>
			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <h3><%=moimbean.getMoimNCount() %> / <%=moimbean.getMoimHCount() %></h3>
        
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>		
    		<%}//--for%>
    		 <input type="hidden" name ="jjimNum" value="">
    		<input type="hidden" name ="memberId" value="<%=memberId %>">
    		<input type="hidden" name ="moimNum" value="">
    		<input type="hidden" name ="classNum" value="">
    		</form>
    		</div><!--card-group-->
    <%}//--if-else 
    	}else{
    	%>
    	<article>
      <div class = "text">
        <!-- class 이름 알잘딱깔센으로 적어보시길... -->
        <p class = "join-text"> 로그인을 하시면 더 많은 정보를 보실 수 있습니다~</p>
      </div>
    </article>
    
    <div class="card-group">
    <% 
    		for(int i=0;i<allMoim.size();i++){
    			MoimBean moimbean = allMoim.get(i);
    			String cName = cMgr.categoryName(moimbean.getCategoryNum());

    		%>
    		
      		<article class="card">
      		<a href="/bigmoim/view/moim/moimdetail.jsp?num=<%=moimbean.getMoimNum()%>">
    		<div class="image-wrapper">
          <% 
    			img = "/bigmoim/image/"+moimbean.getMoimImg();
    			System.out.println("img : "+img);
    		%>
          <img src=<%=img %> alt="Image">

			
        </div>
        <h4><%=moimbean.getMoimName() %></h4>
        <div class="card-nav">
          <p class="moimArea" name="moimArea" value="" style="margin-top: 0;"><%=moimbean.getMoimArea() %></p>
          <p class="card-nav-line" style="margin-top: 0;" style="margin-top: 0;">&nbsp; | &nbsp;</p>
          <p class="categoryName" name="categoryName" value="" style="margin-top: 0;"><%=cName %></p>
      </div>
        <p class="moimProfile" name="moimProfile" value=""><%=moimbean.getMoimProfile() %></p>
        </a>
    		</article>
    		<%}//--for%>
    		</div><!--card-group-->
    <%}//--if-else    %>
    
    

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
    <!-- bottom.jsp -->
    <%@ include file = "/view/bottom.jsp" %>
  </body>
</html>
        