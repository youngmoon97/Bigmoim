
function inputCheck(){
	//회원 집주소 붙여서 값 저장
	memberAddrArea1=document.getElementsByName("memberAddrArea1").item(0).value;
	memberAddrArea2=document.getElementsByName("memberAddrArea2").item(0).value;
	memberAddr=memberAddrArea1+" "+memberAddrArea2;
	document.signFrm.memberAddr.value = memberAddr;
	
	//회원 직장주소 붙여서 값 저장
	memberJobAddrArea1=document.getElementsByName("memberJobAddrArea1").item(0).value;
	memberJobAddrArea2=document.getElementsByName("memberJobAddrArea2").item(0).value;
	memberJobAddr=memberJobAddrArea1+" "+memberJobAddrArea2;
	document.signFrm.memberJobAddr.value = memberJobAddr;
	
	//회원 생일 붙여서 값 저장(되는거)
	memberBirth_year=document.getElementsByName("memberBirth_year").item(0).value;
	memberBirth_month=document.getElementsByName("memberBirth_month").item(0).value;
	memberBirth_day=document.getElementsByName("memberBirth_day").item(0).value;
	memberBirth = memberBirth_year+"-"+memberBirth_month+"-"+memberBirth_day;
	document.signFrm.memberBirth.value = memberBirth;
	
	//관심지역 붙여서 값 저장
	memberLikeArea_area1=document.getElementsByName("memberLikeArea_area1").item(0).value;
	memberLikeArea_area2=document.getElementsByName("memberLikeArea_area2").item(0).value;
	memberLikeArea=memberLikeArea_area1+" "+memberLikeArea_area2;
	document.signFrm.memberLikeArea.value = memberLikeArea;
	
	if(document.signFrm.memberName.value==""){
		alert("이름을 입력해 주세요.");
		document.signFrm.memberName.focus();
		return;
	}
	if(document.signFrm.memberId.value==""){
		alert("아이디를 입력해 주세요.");
		document.signFrm.memberId.focus();
		return;
	}
	if(document.signFrm.memberPw.value==""){
		alert("비밀번호를 입력해 주세요.");
		document.signFrm.memberPw.focus();
		return;
	}
	if(document.signFrm.memberPwConfirm.value==""){
		alert("비밀번호를 확인해 주세요");
		document.signFrm.memberPwConfirm.focus();
		return;
	}
	if(document.signFrm.memberPw.value != document.signFrm.memberPwConfirm.value){
		alert("비밀번호가 일치하지 않습니다.");
		document.signFrm.memberPwConfirm.value="";
		document.signFrm.memberPwConfirm.focus();
		return;
	}	
	if(document.signFrm.memberTel.value==""){
		alert("전화번호를 입력해 주세요.");
		document.signFrm.memberTel.focus();
		return;
	}
    if(document.signFrm.memberAddrZipcode.value==""){
		alert("집주소를 검색해 주세요.");
		return;
	}

	if(document.signFrm.memberBirth_year.value==""||
	document.signFrm.memberBirth_month.value==""||
	document.signFrm.memberBirth_day.value==""){
		alert("생일을 입력해 주세요.");
		document.signFrm.memberBirth_year.focus();
		return;
	}
	 document.signFrm.submit();
	
	//console.log(document.signFrm);
}

function win_close(){
	self.close();
}