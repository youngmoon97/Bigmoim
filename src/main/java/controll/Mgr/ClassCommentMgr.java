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
				+ "(ccComment, memberId, ccDate, moimNum) "
				+ "values(?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getCcComment());
			pstmt.setString(2, bean.getMemberId());
			pstmt.setInt(3, bean.getMoimNum());
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
			sql = "update classComment set ccComment=? "
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
	public Vector<ClassCommentBean> ccList(int moimNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ClassCommentBean> vlist = new Vector<ClassCommentBean>();
		try {
			con = pool.getConnection();
			sql = "select * from classcomment c where moimNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ClassCommentBean bean = new ClassCommentBean();
				bean.setCcNum(rs.getInt("ccNum"));
				bean.setCcComment(rs.getString("ccComment"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setCcDate(rs.getString("ccDate"));
				bean.setMoimNum(rs.getInt("moimNum"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//클래스댓글번호가져오기
	public int getCcNum(String memberId, int moimNum, String ccComment) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int ccNum = 0 ;
		try {
			con = pool.getConnection();
			sql = "select ccNum from classcomment "
			+ "where memberId =? and moimNum and ccComment =?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, moimNum);
			pstmt.setString(3, ccComment);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ccNum = rs.getInt("ccNum");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return ccNum;
	}
}
