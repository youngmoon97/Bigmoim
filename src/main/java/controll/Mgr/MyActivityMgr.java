package controll.Mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import controll.DBConnectionMgr;
import model.Bean.BusinessBean;
import model.Bean.MoimBean;
import model.Bean.TaskBean;
import model.Bean.ThemeBean;

public class MyActivityMgr {
	DBConnectionMgr pool;
	public MyActivityMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	//business(업종)
	//업종 별 개인의 모임 가져오기
		public Vector<MoimBean> businessList(int businessNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimBean> vlist = new Vector<MoimBean>();
			try {
				con = pool.getConnection();
				sql = "select moimNum, moimName, moimArea, moimHCount,"
					+ "moimNCount ,moimImg ,moimProfile  "
					+ "from moim where businessNum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, businessNum);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MoimBean bean = new MoimBean();
					bean.setMoimNum(rs.getInt(1));
					bean.setMoimName(rs.getString(2));
					bean.setMoimArea(rs.getString(3));
					bean.setMoimHCount(rs.getInt(4));
					bean.setMoimNCount(rs.getInt(5));
					bean.setMoimImg(rs.getString(6));
					bean.setMoimProfile(rs.getString(7));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
	// 업종별클래스도 만들어야함
	/////////////////////////////////////////
	//task(직무)
		public Vector<MoimBean> taskList(int taskNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimBean> vlist = new Vector<MoimBean>();
			try {
				con = pool.getConnection();
				sql = "select moimNum, moimName, moimArea, moimHCount,"
					+ "moimNCount ,moimImg ,moimProfile  "
					+ "from moim where taskNum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, taskNum);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MoimBean bean = new MoimBean();
					bean.setMoimNum(rs.getInt(1));
					bean.setMoimName(rs.getString(2));
					bean.setMoimArea(rs.getString(3));
					bean.setMoimHCount(rs.getInt(4));
					bean.setMoimNCount(rs.getInt(5));
					bean.setMoimImg(rs.getString(6));
					bean.setMoimProfile(rs.getString(7));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
	/////////////////////////////////////////	
	//theme(테마)
		public Vector<MoimBean> themeList(int themeNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimBean> vlist = new Vector<MoimBean>();
			try {
				con = pool.getConnection();
				sql = "select moimNum, moimName, moimArea, moimHCount,"
					+ "moimNCount ,moimImg ,moimProfile  "
					+ "from moim where themeNum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, themeNum);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MoimBean bean = new MoimBean();
					bean.setMoimNum(rs.getInt(1));
					bean.setMoimName(rs.getString(2));
					bean.setMoimArea(rs.getString(3));
					bean.setMoimHCount(rs.getInt(4));
					bean.setMoimNCount(rs.getInt(5));
					bean.setMoimImg(rs.getString(6));
					bean.setMoimProfile(rs.getString(7));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
	/////////////////////////////////////////	
	//recentseenInsert(최근 본 모임 추가)
		public boolean rsInsert(String memberId, int moimNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "insert into recentseen(memberId,moimNum) "
					+ "values (?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, memberId);
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
	//최근본 모임 리스트 출력
		public Vector<MoimBean> rsList(String memberId){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimBean> vlist = new Vector<MoimBean>();
			try {
				con = pool.getConnection();
				sql = "select m.moimName ,m.moimImg ,m.moimArea ,m.moimNCount ,m.categoryNum "
					+ "from moim m ,recentseen r "
					+ "where m.moimNum = r.moimNum and "
					+ "r.memberId = ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, memberId);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MoimBean bean = new MoimBean();
					bean.setMoimName(rs.getString("moimName"));
					bean.setMoimImg(rs.getString("moimImg"));
					bean.setMoimArea(rs.getString("moimArea"));
					bean.setMoimNCount(rs.getInt("moimNCount"));
					bean.setCategoryNum(rs.getInt("categoryNum"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
	// 찜 목록 추가
	public boolean jjimInsert(String memberId, int moimNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into jjimlist(memberId,moimNum) "
					+ "values (?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
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
	//jjimlist(찜 목록 리스트출력)
	public Vector<MoimBean> jjimList(String memberId){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		try {
			con = pool.getConnection();
			sql = "select m.moimName ,m.moimImg ,m.moimArea ,m.moimNCount ,m.categoryNum "
				+ "from moim m ,jjimlist j "
				+ "where m.moimNum = j.moimNum and "
				+ "j.memberId = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setCategoryNum(rs.getInt("categoryNum"));
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