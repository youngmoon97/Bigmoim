package controll.Mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import controll.DBConnectionMgr;
import model.Bean.BoardCommentBean;

public class BoardCommentMgr {
	DBConnectionMgr pool;
	public BoardCommentMgr() {
		pool= DBConnectionMgr.getInstance();
	}
	//게시판 댓글 작성
	public boolean bcInsert(BoardCommentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into boardcomment"
				+ "(bcContent,memberId, bcDate,mbNum) "
				+ "values(?,?,now(),?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getBcContent());
			pstmt.setString(2, bean.getMemberId());
			pstmt.setInt(3, bean.getMbNum());
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
	//게시판 댓글 삭제
	public boolean bcDelete(int bcNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from boardcomment "
				+ "where bcNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bcNum);
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
	//게시판 댓글 수정
	public boolean bcUpdate(int bcNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update boardcomment set bcContent=? "
				+ "where bcNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bcNum);
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
	//게시판 댓글 리스트
	public Vector<BoardCommentBean> bcList(int mbNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<BoardCommentBean> vlist = new Vector<BoardCommentBean>();
		try {
			con = pool.getConnection();
			sql = "select * from boardcomment  "
				+ "where mbNum =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mbNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardCommentBean bean = new BoardCommentBean();
				bean.setBcNum(rs.getInt(1));
				bean.setBcContent(rs.getString(2));
				bean.setMemberId(rs.getString(3));
				bean.setBcDate(rs.getString(4));
				bean.setMbNum(rs.getInt(5));
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
