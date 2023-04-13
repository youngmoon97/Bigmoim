package model.Mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import model.DBConnectionMgr;
import model.Bean.MemberBean;
import model.Bean.ZipcodeBean;



public class MemberMgr {
	DBConnectionMgr pool;
	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//로그인
	public int loginMember(String memberId, String memberPw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int mode = 0;
		// 0-id false, 1-id true pwd-false, 2-id&pwd true
		try {
			if (!checkId(memberId))
				return mode;
			con = pool.getConnection();
			sql = "select memberId, memberPw from member "
				+ "where memberId = ? and memberPw = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberPw);
			rs = pstmt.executeQuery();
			if (rs.next())
				mode = 2;
			else
				mode = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mode;
	}
	//id 중복 체크 : 중복 -> true
	public boolean checkId(String memberId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select memberId from member where memberId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	//우편번호 검색 - area1,area2만 쓸꺼임 시랑 구,동
	public  Vector<ZipcodeBean> zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+area3+"%");//'%강남대로%'
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				vlist.addElement(bean);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//회원가입
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into member  "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMemberId());
			pstmt.setString(2, bean.getMemberPw());
			pstmt.setString(3, bean.getMemberName());
			pstmt.setString(4, bean.getMemberTel());
			pstmt.setString(5, bean.getMemberBirth());
			pstmt.setString(6, bean.getMemberImg());
			pstmt.setString(7, bean.getMemberProfile());
			pstmt.setInt(8, bean.getMemberSex());
			pstmt.setString(9, bean.getMemberAddr());
			pstmt.setString(10, bean.getMemberJobAddr());
			pstmt.setString(11, bean.getMemberLikeArea());
			pstmt.setInt(12, bean.getCategoryNum());
			pstmt.setInt(13, bean.getBusinessNum());
			pstmt.setInt(14, bean.getTaskNum());
			pstmt.setInt(15, bean.getThemeNum());	
			if(pstmt.executeUpdate()==1) { //정상
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//회원정보 가져오기
		public MemberBean getMember(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MemberBean bean = new MemberBean();
			try {
				con = pool.getConnection();
				sql = "select * from tblMember where memberId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setMemberId(rs.getString(1));
					bean.setMemberPw(rs.getString(2));
					bean.setMemberName(rs.getString(3));
					bean.setMemberTel(rs.getString(4));
					bean.setMemberBirth(rs.getString(5));
					bean.setMemberImg(rs.getString(6));
					bean.setMemberProfile(rs.getString(7));
					bean.setMemberSex(rs.getInt(8));
					bean.setMemberAddr(rs.getString(9));
					bean.setMemberJobAddr(rs.getString(10));
					bean.setMemberLikeArea(rs.getString(11));
					bean.setCategoryNum(rs.getInt(12));
					bean.setBusinessNum(rs.getInt(13));
					bean.setTaskNum(rs.getInt(14));
					bean.setThemeNum(rs.getInt(15));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
		//회원정보 수정
		public boolean updateMember(MemberBean bean) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "update member "
					+ "set memberPw=?,memberName=?,memberTel =?,memberImg =?,memberProfile =?,"
					+ "memberAddr =?, memberJobAddr =?, memberLikeArea =?, categoryNum=?"
					+ "businessNum =?, taskNum =?,themeNum =?  "
					+ "where memberid = ?;";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, bean.getMemberPw());
				pstmt.setString(2, bean.getMemberName());
				pstmt.setString(3, bean.getMemberTel());
				pstmt.setString(4, bean.getMemberImg());
				pstmt.setString(5, bean.getMemberProfile());
				pstmt.setString(6, bean.getMemberAddr());
				pstmt.setString(7, bean.getMemberJobAddr());
				pstmt.setString(8, bean.getMemberLikeArea());
				pstmt.setInt(9, bean.getCategoryNum());
				pstmt.setInt(10, bean.getBusinessNum());
				pstmt.setInt(11, bean.getTaskNum());
				pstmt.setInt(12, bean.getThemeNum());	
				pstmt.setString(13, bean.getMemberId());			
				if(pstmt.executeUpdate()==1)
					flag = true;
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
		///admin mode/////////////
		public Vector<MemberBean> getMemberList() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MemberBean> vlist = new Vector<MemberBean>();
			try {
				con = pool.getConnection();
				sql = "select * from member";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					MemberBean bean = new MemberBean();
					bean.setMemberId(rs.getString(1));
					bean.setMemberPw(rs.getString(2));
					bean.setMemberName(rs.getString(3));
					bean.setMemberTel(rs.getString(4));
					bean.setMemberBirth(rs.getString(5));
					bean.setMemberImg(rs.getString(6));
					bean.setMemberProfile(rs.getString(7));
					bean.setMemberSex(rs.getInt(8));
					bean.setMemberAddr(rs.getString(9));
					bean.setMemberJobAddr(rs.getString(10));
					bean.setMemberLikeArea(rs.getString(11));
					bean.setCategoryNum(rs.getInt(12));
					bean.setBusinessNum(rs.getInt(13));
					bean.setTaskNum(rs.getInt(14));
					bean.setThemeNum(rs.getInt(15));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//Admin Login
		public boolean adminCheck(String adminId, String adminPw) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "select adminId, adminPw from admin "
						+ "where adminId = ? and adminPw = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, adminId);
				pstmt.setString(2, adminPw);
				rs = pstmt.executeQuery();
				flag = rs.next();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return flag;
		}
		
		
}
