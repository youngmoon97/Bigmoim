
function inputCheck(){
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
}

function win_close(){
	self.close();
}