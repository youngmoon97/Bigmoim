package model.Bean;

public class MemberBean {

	private String memberId;
	private String memberPw;
	private String memberName;
	private String memberTel;
	private String memberBirth;
	private String memberImg;
	private String memberProfile;
	private int memberSex;	//남자=1, 여자=2
	private String memberAddr;
	private String memberJobAddr;
	private String memberLikeArea;
	private int categoryNum;
	private int businessNum;
	private int taskNum;
	private int themeNum;
	
	public String getMemberLikeArea() {
		return memberLikeArea;
	}
	public void setMemberLikeArea(String memberLikeArea) {
		this.memberLikeArea = memberLikeArea;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getMemberPw() {
		return memberPw;
	}
	public void setMemberPw(String memberPw) {
		this.memberPw = memberPw;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public String getMemberTel() {
		return memberTel;
	}
	public void setMemberTel(String memberTel) {
		this.memberTel = memberTel;
	}
	public String getMemberBirth() {
		return memberBirth;
	}
	public void setMemberBirth(String memberBirth) {
		this.memberBirth = memberBirth;
	}
	public String getMemberImg() {
		return memberImg;
	}
	public void setMemberImg(String memberImg) {
		this.memberImg = memberImg;
	}
	public String getMemberProfile() {
		return memberProfile;
	}
	public void setMemberProfile(String memberProfile) {
		this.memberProfile = memberProfile;
	}
	public int getMemberSex() {
		return memberSex;
	}
	public void setMemberSex(int memberSex) {
		this.memberSex = memberSex;
	}
	public String getMemberAddr() {
		return memberAddr;
	}
	public void setMemberAddr(String memberAddr) {
		this.memberAddr = memberAddr;
	}
	public String getMemberJobAddr() {
		return memberJobAddr;
	}
	public void setMemberJobAddr(String memberJobAddr) {
		this.memberJobAddr = memberJobAddr;
	}
	public int getCategoryNum() {
		return categoryNum;
	}
	public void setCategoryNum(int categoryNum) {
		this.categoryNum = categoryNum;
	}
	public int getBusinessNum() {
		return businessNum;
	}
	public void setBusinessNum(int businessNum) {
		this.businessNum = businessNum;
	}
	public int getTaskNum() {
		return taskNum;
	}
	public void setTaskNum(int taskNum) {
		this.taskNum = taskNum;
	}
	public int getThemeNum() {
		return themeNum;
	}
	public void setThemeNum(int themeNum) {
		this.themeNum = themeNum;
	}
	
	
}
