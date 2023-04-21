<%@page import="model.Bean.MoimBean"%>
<%@page import="model.Bean.MoimCategoryBean"%>
<%@page import="java.util.Vector"%>
<%@ include file = "/view/top.jsp" %>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="moimMgr" class="controll.Mgr.MoimMgr"/>
<jsp:useBean id="cateMgr" class="controll.Mgr.CategoryMgr"/>

<%
	int no = Integer.parseInt(request.getParameter("num"));
	System.out.print(no);
	
	MoimBean moimbean = moimMgr.moimDetail(no);
	String img = "/bigmoim/image/"+moimbean.getMoimImg();
	System.out.print("img : " + img);
	
	MoimCategoryBean cabean = cateMgr.categoryImg(no);
%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title name="moimName"><%=moimbean.getMoimName()%></title>
    <link type="text/css" rel="stylesheet" href="../css/clubdetail.css">
    <style>
      @import url("https://fonts.googleapis.com/css2?family=Barlow:wght@600&family=Heebo:wght@500&display=swap");
    </style>
  </head>
  <body>


      <!-- 카테고리 -->
      <!-- 메인 -->
      <main>
        <!-- 상세 네비게이션-->
        <nav1>
          <ul class="clubdetail-nav">
            <li class="clubdetail-nav-home"><a href="#">소개</a></li>
            <li class="clubdetail-nav-line1">|</li>
            <li class="clubdetail-nav-notice"><a href="#">게시판</a></li>
            <li class="clubdetail-nav-line2">|</li>
            <li class="clubdetail-nav-notice"><a href="#">사진첩</a></li>
          </ul>
        </nav1>
        <div class="clubdetail">
          <div class="category">
            <div class="image-wrapper">
              <img src="<%="/bigmoim/image/"+ cabean.getCategoruImg() %>" alt="게임 / 오락" />
            </div>
          </div>
          <div class="clubdetail-moim">
            <h4 class="clubdetail-moimname" name="moimName"><%=moimbean.getMoimName()%></h4>
            <ul class="clubdetail-area">
              <li class="clubdetail-moimarea" name="moimArea">
                <%=moimbean.getMoimArea() %>
              </li>
              <li class="moimarea-line">|</li>
              <li class="clubdetail-membercount" name="moimNCount">멤버&nbsp;<%=moimbean.getMoimNCount() %></li>
              <li><img class="clubdetail-jjim" src="./img_icon/heart.png" name="jjim" /></li>
            </ul>
          </div>
        </div>
        <div class="clubdetail-photo">
         <img
            class="clubdetail-photo-detail"
            src="<%=img %>"
            name="moimImg"
          /> 
        </div>
        <div class="clubdetail-content">
          <p name="moimProfile">
            <!-- 단락으로 들어올 시 끊어서 받을 수가 없음-->
			<%=moimbean.getMoimProfile() %>
          </p>
        </div>
        <div class="clubdetail-schedule">
          <h2>모임일정</h2>
          <ul class="meeting_list">
		  	<li>
				<h2 name="msTitle">건강한 찐 산책</h2>
				<ul class="mlist_in">
					<li class="date" name="msTime">금요일<span>21</span></li>
					<li>
						<ul class="in_cont">
							<li class="ico calendar" name="msTime"><%=moimbean.getMoimDate() %></li>
							<li class="ico place" name="msArea">시민공원</li>
							<li class="ico cost" name="">커피값만.</li>
						</ul>
					</li>
					<li class="btn">
						<a href="<%=moimbean.getMoimKakao() %>" class="share">
							친구에게<br />
							공유하기
						</a>
					</li>
				</ul>
				<div class="member" id="cont_1">
					<h4 name="msNCount">참여 멤버(10/20)</h4>
          <div class="container">
            <div>
              <img src="./images/profile.jpg"/>
            </div>            <div>
              <img src="./images/profile.jpg"/>
            </div>            <div>
              <img src="./images/profile.jpg"/>
            </div>            <div>
              <img src="./images/profile.jpg"/>
            </div>            <div>
              <img src="./images/profile.jpg"/>
            </div>            <div>
              <img src="./images/profile.jpg"/>
            </div>            <div>
              <img src="./images/profile.jpg"/>
            </div>            <div>
              <img src="./images/profile.jpg"/>
            </div>            <div>
              <img src="./images/profile.jpg"/>
            </div>
          </div>
        </div>
			</li>	
			<li>
				<h2 name="msTitle">건강한 찐 산책</h2>
				<ul class="mlist_in">
					<li class="date" name="msTime">금요일<span>21</span></li>
					<li>
						<ul class="in_cont">
							<li class="ico calendar" name="msTime">5월 21일</li>
							<li class="ico place" name="msArea">시민공원</li>
							<li class="ico cost" name="">커피값만.</li>
						</ul>
					</li>
					<li class="btn">
						<a href="#" class="share">
							친구에게<br />
							공유하기
						</a>
					</li>
					
				</ul>
				<div class="member">
					<h4>참여 멤버(10/20)</h4>
					<ul class="member_in" name="msNCount">
						<li><img src="./images/profile.jpg" /></li>
						<li><img src="./images/profile.jpg" /></li>
						<li><img src="./images/profile.jpg" /></li>
						<li><img src="./images/profile.jpg" /></li>
						<li><img src="./images/profile.jpg" /></li>
						<li><img src="./images/profile.jpg" /></li>
						<li><img src="./images/profile.jpg" /></li>
						<li><img src="./images/profile.jpg" /></li>
						<li><img src="./images/profile.jpg" /></li>
						<li><img src="./images/profile.jpg" /></li>
					</ul>
				</div>
			</li>
		  </ul>
      <div class="tab">
        <ul class="tabnav">
          <li class="tab-link current" name="msTime" data-tab="tab1"><a href="#tab01">4월21일</a></li>
          <li class="tab-link" name="msTime" data-tab="tab2"><a href="#tab02">5월21일</a></li>
        </ul>
        <div class="tabcontent">
          <h3 name="msNCount">모임멤버(20명)</h3>
          <ul class="tabcontent-list">
            <li class="tabcontent-list-img" name="memberImg"><img src="./images/profile.jpg" /></li>
            <li>
              <ul class="tabcontent-list-detail">
                <li class="tabcontent-list-name" name="memberName">서지우</li>
                <li class="tabcontent-list-hello" name="memberProfile">안녕하세요</li>
              </ul>
            </li> 
          </ul>
          <ul class="tabcontent-list">
            <li class="tabcontent-list-img" name="memberImg"><img src="./images/profile.jpg" /></li>
            <li>
              <ul class="tabcontent-list-detail">
                <li class="tabcontent-list-name" name="memberName">서지우</li>
                <li class="tabcontent-list-hello" name="memberProfile">안녕하세요</li>
              </ul>
            </li> 
          </ul>
        </div>
      </div>  
      </main>
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
        function row_scroll(){
          $(".container div").on('mousewheel',function(e){
            var wheelDelta = e.originalEvent.wheelDelta;
            if(wheelDelta > 0){
              $(this).scrollLeft(-wheelDelta + $(this).scrollLeft());
            } else{
              $(this).scrollLeft(-wheelDelta + $(this).scrollLeft());
            }
          });
        }
        row_scroll();

        $(function(){
          $('.tabcontent-list > ul').hide();
          $('.tabnav a').click(function () {
            $('.tabcontent-list > ul').hide().filter(this.hash).fadeIn();
            $('.tabnav a').removeClass('active');
            $(this).addClass('active');
            return false;
          }).filter(':eq(0)').click();
        });

        $(document).ready(function(){
          $('ul.tabnav li').click(function(){
            var tab_id = $(this).attr('data-tab');
            $('ul.tabnav li').removeClass('current');
            $('.tab-content').removeClass('current');
            $(this).addClass('current');
            $("#"+tab_id).addClass('current');
          })
        })
      </script>
    </div>
  </body>
</html>
