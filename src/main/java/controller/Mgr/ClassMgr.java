package controller.Mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import controller.DBConnectionMgr;
import model.Bean.ClassBean;

public class ClassMgr {
	DBConnectionMgr pool;
	public ClassMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 좋아요수 증가
	public boolean classLike(int classNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "update class set classLike=classLike+1"
				+ "where classNum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, classNum);
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
	//클래스 생성
	public boolean classMake(ClassBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = " insert into class(className,classArea, classPrice, classTime, "
				+ "classContent, memberId ,classHCount, classKakao, "
				+ "categoryNum, classOpenDate,,themeNum,taskNum, businessNum)  "
				+ "  values (?,?,?,?,?,?,?,?,?,now(),?,?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getClassName());
			pstmt.setString(2, bean.getClassArea());
			pstmt.setString(3, bean.getClassPrice());
			pstmt.setString(4, bean.getClassTime());
			pstmt.setString(5, bean.getClassContent());
			pstmt.setString(6, bean.getMemberId());
			pstmt.setInt(7, bean.getClassHCount());
			pstmt.setString(8, bean.getClassKakao());
			pstmt.setInt(9, bean.getCategoryNum());
			pstmt.setInt(10, bean.getThemeNum());
			pstmt.setInt(11, bean.getTaskNum());
			pstmt.setInt(12, bean.getBusinessNum());
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
	//클래스 수정
	public boolean classUpdate(ClassBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "update class"
				+ "set className= ?, classArea=?, classPrice=?, classTime=?, "
				+ "classContent=?, classKakao=?, categoruNum=?, themeNum=?, "
				+ "taskNum=?, businessNum=? where ClassNum= ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getClassName());
			pstmt.setString(2, bean.getClassArea());
			pstmt.setString(3, bean.getClassPrice());
			pstmt.setString(4, bean.getClassTime());
			pstmt.setString(5, bean.getClassContent());
			pstmt.setString(6, bean.getClassKakao());
			pstmt.setInt(7, bean.getCategoryNum());
			pstmt.setInt(8, bean.getThemeNum());
			pstmt.setInt(9, bean.getTaskNum());
			pstmt.setInt(10, bean.getBusinessNum());
			pstmt.setInt(11, bean.getClassNum());
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
	//클래스 삭제
	public boolean ClassDelete(int classNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "delete from class where ClassNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, classNum);
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
	
	//클래스 카테고리별 리스트 불러오기
	public Vector<ClassBean> cateClassList(int categoryNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<ClassBean> vlist = new Vector<ClassBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from class where categoryNum=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, categoryNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ClassBean bean = new ClassBean();
				bean.setClassNum(rs.getInt("classNum"));
				bean.setClassName(rs.getString("className"));
				bean.setClassArea(rs.getString("classArea"));
				bean.setClassPrice(rs.getString("classPrice"));
				bean.setClassTime(rs.getString("classTime"));
				bean.setClassContent(rs.getString("classContent"));
				bean.setClassLike(rs.getInt("clasLike"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setClassHCount(rs.getInt("classHCount"));
				bean.setClassNCount(rs.getInt("classNCount"));
				bean.setClassKakao(rs.getString("classKakao"));
				bean.setClassOpenDate(rs.getString("classOpenDate"));
				bean.setCategoryNum(rs.getInt("categoryNum"));
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
	//클래스 지역별 리스트 만들기
	public Vector<ClassBean> areaClassList(String classArea){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<ClassBean> vlist = new Vector<ClassBean>();
		String sql = null;
		try {
			con = pool.getConnection();
			sql = "select * from Class where classArea=? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, classArea);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ClassBean bean = new ClassBean();
				bean.setClassNum(rs.getInt("classNum"));
				bean.setClassName(rs.getString("className"));
				bean.setClassArea(rs.getString("classArea"));
				bean.setClassPrice(rs.getString("classPrice"));
				bean.setClassTime(rs.getString("classTime"));
				bean.setClassContent(rs.getString("classContent"));
				bean.setClassLike(rs.getInt("clasLike"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setClassHCount(rs.getInt("classHCount"));
				bean.setClassNCount(rs.getInt("classNCount"));
				bean.setClassKakao(rs.getString("classKakao"));
				bean.setClassOpenDate(rs.getString("classOpenDate"));
				bean.setCategoryNum(rs.getInt("categoryNum"));
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
	//클래스 상세
	public ClassBean ClassDetail(int ClassNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		ClassBean bean = new ClassBean();
		try {
			con = pool.getConnection();
			sql = "select * from Class where ClassNum=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ClassNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean.setClassNum(rs.getInt("classNum"));
				bean.setClassName(rs.getString("className"));
				bean.setClassArea(rs.getString("classArea"));
				bean.setClassPrice(rs.getString("classPrice"));
				bean.setClassTime(rs.getString("classTime"));
				bean.setClassContent(rs.getString("classContent"));
				bean.setClassLike(rs.getInt("clasLike"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setClassHCount(rs.getInt("classHCount"));
				bean.setClassNCount(rs.getInt("classNCount"));
				bean.setClassKakao(rs.getString("classKakao"));
				bean.setClassOpenDate(rs.getString("classOpenDate"));
				bean.setCategoryNum(rs.getInt("categoryNum"));
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
