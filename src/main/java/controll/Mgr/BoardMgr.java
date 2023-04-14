package controll.Mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import controll.DBConnectionMgr;
import model.Bean.MemberBoardBean;

public class BoardMgr {
	DBConnectionMgr pool;
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 게시판 생성
	public boolean boardInsert(MemberBoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into memberboard(mbTitle,mbContent,mbDate, "
				+ "memberId,mbImg,moimNum,boardType) "
				+ "values(?,?,now(),?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,bean.getMbTitle());
			pstmt.setString(2,bean.getMbContent());
			pstmt.setString(3,bean.getMemberId());
			pstmt.setString(4,bean.getMbImg());
			pstmt.setInt(5,bean.getMoimNum());
			pstmt.setString(6,bean.getBoardType());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	// 게시판 삭제
	public boolean boardDelete(int mbNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "delete from memberboard "
				+ "where mbNum =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mbNum);
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
	// 게시판 수정
	public boolean boardUpdate(MemberBoardBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update memberboard "
				+ "set mbTitle=?,mbContent=?,mbImg=?, "
				+ "boardType=?,mbDate=now()  "
				+ "where mbNum =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMbTitle());
			pstmt.setString(2, bean.getMbContent());
			pstmt.setString(3, bean.getMbImg());
			pstmt.setString(4, bean.getBoardType());
			pstmt.setInt(5, bean.getMbNum());
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
	// 게시판 리스트 가져오기
	public Vector<MemberBoardBean> boardList(int moimNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBoardBean> vlist = new Vector<MemberBoardBean>();
		try {
			con = pool.getConnection();
			sql = "select * from memberboard  "
				+ "where moimNum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBoardBean bean = new MemberBoardBean();
				bean.setMbNum(rs.getInt(1));
				bean.setMbTitle(rs.getString(2));
				bean.setMbContent(rs.getString(3));
				bean.setMbDate(rs.getString(4));
				bean.setMemberId(rs.getString(5));
				bean.setMbImg(rs.getString(6));
				bean.setMoimNum(rs.getInt(7));
				bean.setBoardType(rs.getString(8));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	// 게시판 상세
	public MemberBoardBean boarddetail(int mbNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBoardBean bean = new MemberBoardBean();
		try {
			con = pool.getConnection();
			sql = "select * from memberboard"
				+ "where mbNum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mbNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean.setMbNum(rs.getInt(1));
				bean.setMbTitle(rs.getString(2));
				bean.setMbContent(rs.getString(3));
				bean.setMbDate(rs.getString(4));
				bean.setMbImg(rs.getString(5));
				bean.setMoimNum(rs.getInt(6));				
				bean.setBoardType(rs.getString(7));				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//
}
