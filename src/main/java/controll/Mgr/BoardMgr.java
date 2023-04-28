package controll.Mgr;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import controll.DBConnectionMgr;
import model.Bean.MemberBoardBean;

public class BoardMgr {
	DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/bigmoim/src/main/webapp/image/";
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;	//20MB
	public BoardMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	
	// 게시판 생성
	public boolean boardInsert(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()/*존재하지 않으면*/) {
				dir.mkdirs();	// mkdirs는 상위폴더가 없어도 생성
				// mkdir은 상위폴더가 없으면 생성 불가
			}
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING
							,new DefaultFileRenamePolicy());
			String mbImg = null;
			if(multi.getFilesystemName("mbImg")!=null) {
				mbImg = multi.getFilesystemName("mbImg");
			}
			//File f = new File(memberImg);
			String mbTitle = multi.getParameter("mbTitle");
			String mbContent = multi.getParameter("mbContent");
			int moimNum = Integer.parseInt(multi.getParameter("moimNum"));
			String mbDate = multi.getParameter("mbDate");
			String memberId = multi.getParameter("memberId");
			String boardType = multi.getParameter("boardType");
			con = pool.getConnection();
			sql = "insert into memberboard(mbTitle,mbContent,mbDate, "
				+ "memberId,mbImg,moimNum,boardType) "
				+ "values(?,?,now(),?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1,mbTitle);
			pstmt.setString(2,mbContent);
			pstmt.setString(3,mbDate);
			pstmt.setString(4,memberId);
			pstmt.setString(4,mbImg);
			pstmt.setInt(5,moimNum);
			pstmt.setString(6,boardType);
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
	public boolean boardUpdate(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()/*존재하지 않으면*/) {
				dir.mkdirs();	// mkdirs는 상위폴더가 없어도 생성
				// mkdir은 상위폴더가 없으면 생성 불가
			}
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING
							,new DefaultFileRenamePolicy());
			String mbImg = null;
			if(multi.getFilesystemName("mbImg")!=null) {
				mbImg = multi.getFilesystemName("mbImg");
			}
			//File f = new File(memberImg);
			String mbTitle = multi.getParameter("mbTitle");
			
			String mbContent = multi.getParameter("mbContent");
			int moimNum = Integer.parseInt(multi.getParameter("moimNum"));
			int mbNum = Integer.parseInt(multi.getParameter("mbNum"));
			String mbDate = multi.getParameter("mbDate");
			String memberId = multi.getParameter("memberId");
			String boardType = multi.getParameter("boardType");
			con = pool.getConnection();
			sql = "update memberboard "
				+ "set mbTitle=?,mbContent=?,mbImg=?, "
				+ "boardType=?,mbDate=now()  "
				+ "where mbNum =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mbTitle);
			pstmt.setString(2, mbContent);
			pstmt.setString(3, mbImg);
			pstmt.setString(4, boardType);
			pstmt.setInt(5, mbNum);
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
			sql = "select * from memberboard "
				+ "where mbNum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, mbNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				bean.setMbNum(rs.getInt(1));
				bean.setMbTitle(rs.getString(2));
				bean.setMbContent(rs.getString(3));
				bean.setMbDate(rs.getString(4));
				bean.setMemberId(rs.getString(5));
				bean.setMbImg(rs.getString(6));
				bean.setMoimNum(rs.getInt(7));				
				bean.setBoardType(rs.getString(8));				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	
}
