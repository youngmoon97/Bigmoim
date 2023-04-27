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
	
	//business(업종) 리스트
	public Vector<BusinessBean> businessList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BusinessBean> vlist = new Vector<BusinessBean>();
		try {
			con = pool.getConnection();
			sql = "select * from business";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BusinessBean bean = new BusinessBean();
				bean.setBusinessNum(rs.getInt(1));
				bean.setBusinessName(rs.getString(2));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//
	//최근본 모임 리스트 출력
			public Vector<MoimBean> rsList(String memberId){
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<MoimBean> vlist = new Vector<MoimBean>();
				try {
					con = pool.getConnection();
					sql = "select m.moimNum, m.moimName ,m.moimImg,m.moimArea, m.moimHCount, "
						+ "m.moimNCount ,m.categoryNum, m.moimProfile, m.categoryNum "
						+ "from moim m ,recentseen r "
						+ "where m.moimNum = r.moimNum and "
						+ "r.memberId = ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, memberId);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						MoimBean bean = new MoimBean();
						bean.setMoimNum(rs.getInt("moimNum"));
						bean.setMoimName(rs.getString("moimName"));
						bean.setMoimImg(rs.getString("moimImg"));
						bean.setMoimArea(rs.getString("moimArea"));
						bean.setMoimHCount(rs.getInt("moimHCount"));
						bean.setMoimNCount(rs.getInt("moimNCount"));
						bean.setCategoryNum(rs.getInt("categoryNum"));
						bean.setMoimProfile(rs.getString("moimProfile"));
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
	//business(업종) 리스트
	public Vector<TaskBean> taskList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<TaskBean> vlist = new Vector<TaskBean>();
		try {
			con = pool.getConnection();
			sql = "select * from task";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				TaskBean bean = new TaskBean();
				bean.setTaskNum(rs.getInt(1));
				bean.setTaskName(rs.getString(2));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//theme(테마) 리스트
		public Vector<ThemeBean> themeList(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<ThemeBean> vlist = new Vector<ThemeBean>();
			try {
				con = pool.getConnection();
				sql = "select * from theme";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					ThemeBean bean = new ThemeBean();
					bean.setThemeNum(rs.getInt(1));
					bean.setThemeName(rs.getString(2));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
	//업종 별 개인의 모임 가져오기
		public Vector<MoimBean> pbusinessList(int businessNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimBean> vlist = new Vector<MoimBean>();
			try {
				con = pool.getConnection();
				sql = "select moimNum, moimName, moimArea, moimHCount,"
					+ "moimNCount ,moimImg ,moimProfile, categoryNum "
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
					bean.setCategoryNum(rs.getInt(8));
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
		public Vector<MoimBean> ptaskList(int taskNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimBean> vlist = new Vector<MoimBean>();
			try {
				con = pool.getConnection();
				sql = "select moimNum, moimName, moimArea, moimHCount,"
					+ "moimNCount ,moimImg ,moimProfile, categoryNum "
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
					bean.setCategoryNum(rs.getInt(8));
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
		public Vector<MoimBean> pthemeList(int themeNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimBean> vlist = new Vector<MoimBean>();
			try {
				con = pool.getConnection();
				sql = "select moimNum, moimName, moimArea, moimHCount,"
					+ "moimNCount ,moimImg ,moimProfile, categoryNum  "
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
					bean.setCategoryNum(rs.getInt(8));
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
	//business(업종) 하나의 이름 가져오기
	public String getBusinessName(int businessNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String bName = null;
		try {
			con = pool.getConnection();
			sql = "select businessName from business where businessNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, businessNum);
			rs = pstmt.executeQuery();
		    if(rs.next()) {
		    	bName = rs.getString("businessName");
		    }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bName;
	}
	
	//task(직무) 하나의 이름 가져오기
		public String getTaskName(int taskNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String taName = null;
			try {
				con = pool.getConnection();
				sql = "select taskName from task where taskNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, taskNum);
				rs = pstmt.executeQuery();
			    if(rs.next()) {
			    	taName = rs.getString("taskName");
			    }
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return taName;
		}
		
		//theme(테마) 하나의 이름 가져오기
		public String getThemeName(int themeNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			String tmName = null;
			try {
				con = pool.getConnection();
				sql = "select themeName from theme where themeNum=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, themeNum);
				rs = pstmt.executeQuery();
			    if(rs.next()) {
			    	tmName = rs.getString("themeName");
			    }
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return tmName;
		}
		
}