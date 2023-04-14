package controller.Mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import controller.DBConnectionMgr;
import model.Bean.MoimBean;

public class MoimMgr {
	DBConnectionMgr pool;
	public MoimMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//모임 생성
	public boolean moimMake(MoimBean bean) {
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
}
