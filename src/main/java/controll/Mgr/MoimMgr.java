package controll.Mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import controll.DBConnectionMgr;
import model.Bean.MemberBean;
import model.Bean.MoimBean;
import model.Bean.MoimJoinBean;
import model.Bean.MoimMemberBean;
import model.Bean.MoimScheduleBean;

public class MoimMgr {
	DBConnectionMgr pool;
	public MoimMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//모임 생성
	public boolean moimInsert(MoimBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = " insert into moim(moimName,moimArea,moimHCount,memberId,moimKakao,"
					+ "categoryNum,moimImg,moimProfile,moimDate,themeNum,taskNum,businessNum)  "
					+ "  values (?,?,?,?,?,?,?,?,now(),?,?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMoimName());
			pstmt.setString(2, bean.getMoimArea());
			pstmt.setInt(3, bean.getMoimHCount());
			pstmt.setString(4, bean.getMemberId());
			pstmt.setString(5, bean.getMoimKakao());
			pstmt.setInt(6, bean.getCategoryNum());
			pstmt.setString(7, bean.getMoimImg());
			pstmt.setString(8, bean.getMoimProfile());
			pstmt.setInt(9, bean.getThemeNum());
			pstmt.setInt(10, bean.getTaskNum());
			pstmt.setInt(11, bean.getBusinessNum());
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//모임 수정
	public boolean moimUpdate(MoimBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "update moim"
				+ "set moinName= ?, moimArea=?, moimKakao=?, categoruNum=?,"
				+ " moimImg=?, moimProfile=?, themeNum=?, taskNum=?, businessNum=?"
				+ "where moimNum= ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMoimName());
			pstmt.setString(2, bean.getMoimArea());
			pstmt.setString(3, bean.getMoimKakao());
			pstmt.setInt(4, bean.getCategoryNum());
			pstmt.setString(5, bean.getMoimImg());
			pstmt.setString(6, bean.getMoimProfile());
			pstmt.setInt(7, bean.getThemeNum());
			pstmt.setInt(8, bean.getTaskNum());
			pstmt.setInt(9, bean.getBusinessNum());
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//모임 삭제
	public boolean moimDelete(int moimNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "delete from moim where moimNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
		
	}
	//모임 업종별 리스트
	public Vector<MoimBean> busiMoimList(int businessNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from moim where businessNum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, businessNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moinNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//모임 업무별 리스트
	public Vector<MoimBean> taskMoimList(int taskNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from moim where taskNum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, taskNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moinNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//모임 테마별 리스트
	public Vector<MoimBean> themeMoimList(int themeNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from moim where themeNum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, themeNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moinNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//모임 카테고리별 리스트 불러오기
	public Vector<MoimBean> cateMoimList(int categoryNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from moim where categoryNum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, categoryNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moinNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//모임 지역별 리스트 만들기
	public Vector<MoimBean> areaMoimList(String moimArea){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from moim where moimArea=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, moimArea);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moinNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//모임 상세
	public MoimBean moimDetail(int moimNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MoimBean bean = new MoimBean();
		try {
			con = pool.getConnection();
			sql = "select * from moim where moimNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean.setMoimNum(rs.getInt("moinNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//모임가입신청
	public boolean mjInsert(MoimJoinBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into moimjoin(moimNum,memberId,mjDate,mjContent)\r\n"
					+ "values (?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getMoimNum());
			pstmt.setString(2, bean.getMemberId());
			pstmt.setString(3, bean.getMjContent());
			if(pstmt.executeUpdate()==1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//모임멤버리스트->멤버아이디 받아오기
	public Vector<MemberBean> mmList(int moimNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			sql = "select m.memberId, m.memberImg ,m.memberProfile "
					+ "from `member` m , moimjoin mj "
					+ "where m.memberId = mj.memberId and "
					+ "	mj.moimNum =? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setMemberId("memberId");
				bean.setMemberImg("memberImg");
				bean.setMemberProfile("memberProfile");
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//모임일정생성
	public boolean msInsert(MoimScheduleBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into moimschedule(msTime,msArea,moimNum,"
				+ "msHCount,memberId,msTitle,msContent) "
				+ "values (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMsTime());
			pstmt.setString(2, bean.getMsArea());
			pstmt.setInt(3, bean.getMoimNum());
			pstmt.setInt(4, bean.getMsHCount());
			pstmt.setString(5, bean.getMemberId());
			pstmt.setString(6, bean.getMsTitle());
			pstmt.setString(7, bean.getMsContent());
			if(pstmt.executeUpdate()==1) {
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//모임일정멤버리스트출력
	public Vector<MemberBean> smList(int moimNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			MemberBean bean = new MemberBean();
			con = pool.getConnection();
			sql = "select m.memberId ,m.memberImg ,m.memberProfile "
				+ "from schedulejoin s , `member` m "
				+ "where s.memberId =m.memberId and s.moimNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean.setMemberId(rs.getString("memberId"));
				bean.setMemberImg(rs.getString("memberImg"));
				bean.setMemberProfile(rs.getString("memberProfile"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
}