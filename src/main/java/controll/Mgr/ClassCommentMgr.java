package controll.Mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import controll.DBConnectionMgr;
import model.Bean.ClassCommentBean;

public class ClassCommentMgr {
	DBConnectionMgr pool;
	public ClassCommentMgr() {
		pool= DBConnectionMgr.getInstance();
	}
	//클래스 댓글 작성
	public boolean ccInsert(ClassCommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into classComment"
				+ "(ccContent, memberId, bcDate, classNum) "
				+ "values(?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getCcContent());
			pstmt.setString(2, bean.getMemberId());
			pstmt.setInt(3, bean.getClassNum());
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
	//클래스 댓글 삭제
	public boolean ccDelete(int ccNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from classComment "
				+ "where ccNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ccNum);
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
	//클래스 댓글 수정
	public boolean ccUpdate(int ccNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update classComment set ccContent=? "
				+ "where ccNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ccNum);
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
	//클래스 댓글 리스트
	public Vector<ClassCommentBean> ccList(int classNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ClassCommentBean> vlist = new Vector<ClassCommentBean>();
		try {
			con = pool.getConnection();
			sql = "select * from classComment  "
				+ "where classNum =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, classNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ClassCommentBean bean = new ClassCommentBean();
				bean.setCcNum(rs.getInt("ccNum"));
				bean.setCcContent(rs.getString("ccContent"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setCcDate(rs.getString("ccDate"));
				bean.setClassNum(rs.getInt("classNum"));
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
