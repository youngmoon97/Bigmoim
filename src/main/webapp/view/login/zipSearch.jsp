<!-- bigmoim/zipSearch.jsp -->
<%@page import="model.Bean.ZipcodeBean"%>
<%@ page import="java.util.Vector" %>
<%@page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="mMgr" class="controll.Mgr.MemberMgr"/>
<%
		String search = request.getParameter("search");
        String type = request.getParameter("type");
     	//out.print(type);
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		//search값이 y일때는 검색, n일때는 창만 open
		String area3 = null;
		if(search.equals("y"))
		{
			area3 = request.getParameter("area3");
			vlist = mMgr.zipcodeRead(area3);
			out.print("검색된 결과 수: "+vlist.size());
		}
%>

<!doctype html>
<html>
<head>
<title>대모임 우편번호 검색</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript">
	function loadSearch() 
	{
		frm = document.zipFrm;
		if(frm.area3.value=="")
		{
			alert("도로명을 입력하세요.");
			return;
		}
		frm.action = "zipSearch.jsp?type="+"<%=type%>";	
		frm.submit();
	}
	
	function sendMemberAdd(zipcode, area1, area2) 
	{
		opener.document.signFrm.memberAddrZipcode.value=zipcode; //회원주소 우편번호
		opener.document.signFrm.memberAddrArea1.value=area1; //회원주소 area1(시)
		opener.document.signFrm.memberAddrArea2.value=area2;//회원주소 area2(구/동)
		self.close();
	}
	
	function sendMemberJobAdd(zipcode, area1, area2) 
	{
		opener.document.signFrm.memberJobAddrZipcode.value=zipcode; //직장주소 우편번호
		opener.document.signFrm.memberJobAddrArea1.value=area1; //직장주소 area1(시)
		opener.document.signFrm.memberJobAddrArea2.value=area2;//직장주소 area2(구/동)
		self.close();
	}
	
</script>
</head>
<body bgcolor=#FFE7EB>
	<div align="center">
		<br />
		<form name="zipFrm" method="post">
			<table>
				    <tr>
               <td>
               <br/>동 입력 :    
               <input name="area3" value="" style= "height: 30px; font-size: 20px; margin-top: 2.5em;">
               <input type="button" value="검색" onclick="loadSearch()"
                  style="background: pink; color: #fff; border: none; padding: 10px 20px; cursor: pointer; border-radius: 5px;">
               </td>
            </tr>
				<!-- 검색 결과 Start -->
				<%
				if (search.equals("y")) 
				{
					if (vlist.isEmpty()) 
					{
				%>
				<tr>
					<td align="center"><br>검색된 결과가 없습니다.</td>
				</tr>
				<%
					}
					else
					{
				%>
				<tr>
					<td align="center"><br>※검색 후, 아래 주소를 클릭하면 자동으로 입력됩니다.</td>
				</tr>
				<%
						for(int i = 0; i<vlist.size();i++)
						{
							ZipcodeBean bean = vlist.get(i);
							String zipcode = bean.getZipcode();
							String area1 = bean.getArea1();
							String area2 = bean.getArea2();
							String adds = bean.getArea1()+ " ";
							adds = adds + bean.getArea2() + " ";
							adds = adds + bean.getArea3() + " ";
							adds = adds + bean.getArea4() + " ";
				%>
				<tr>
				<td>
				<% if(type.equals("memberAddrBtn")){ %>
				<a href="#" onclick="sendMemberAdd('<%=zipcode%>','<%=area1%>', '<%=area2%>')"><%=zipcode+" "+adds%></a>
				<%}else{%>
				<a href="#" onclick="sendMemberJobAdd('<%=zipcode%>','<%=area1%>', '<%=area2%>')"><%=zipcode+" "+adds%></a>
				<% }%>
				</td>
				</tr>
				<%
						}//--for
					} //--if2
				} //--if1
				%>
				<!-- 검색 결과 End -->
				<tr>
					<td align="center"><br/>
					<a href="#" onClick="self.close()">닫기</a></td>
				</tr>
			</table>
			<input type="hidden" name="search" value="y">
		</form>
	</div>
</body>
</html>