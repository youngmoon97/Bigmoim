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
import model.Bean.JjimListBean;
import model.Bean.MemberBean;
import model.Bean.MoimBean;
import model.Bean.MoimJoinBean;
import model.Bean.MoimMemberBean;
import model.Bean.MoimPhotosBean;
import model.Bean.MoimScheduleBean;

public class MoimMgr {
	DBConnectionMgr pool;
	//업로드 파일 저장 위치
	public static final String SAVEFOLDER = "C:/Jsp/bigmoim/src/main/webapp/image/";
	//업로드 파일명 인코딩
	public static final String ENCODING = "UTF-8";
	//업로드 파일 크기
	public static final int MAXSIZE = 1024*1024*20;	//20MB
		
	public MoimMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	// 좋아요수 증가
		public boolean classLikeUP(int moimNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag=false;
			try {
				con = pool.getConnection();
				sql = "update moim set classLike=classLike+1"
					+ "where moimNum = ? ";
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
		// 모임에서 멤버 추방
		   public boolean memberBan(String memberId, int moimNum) {
		      Connection con = null;
		      PreparedStatement pstmt = null;
		      String sql = null;
		      boolean flag = false;
		      try {
		         con = pool.getConnection();
		         sql = "delete from moimmember where memberId = ? AND moimNum = ?";
		         pstmt = con.prepareStatement(sql);
		         pstmt.setString(1, memberId);
		         pstmt.setInt(2, moimNum);
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
		//한 모임의 전체 멤버 정보 받아오기(회원아이디, 회원이미지, 회원이름 받아옴)
		public Vector<MemberBean> getMemberList(int moimNum){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			 Vector<MemberBean> vlist = new Vector<MemberBean>();
			
			try {
				con = pool.getConnection();
				sql = "SELECT member.memberId, member.memberImg, member.memberName "
						+ "FROM member join moimmember on member.memberId = moimmember.memberId "
						+ "WHERE moimmember.moimNum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, moimNum);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MemberBean bean = new MemberBean();
					bean.setMemberId(rs.getString("memberId"));
					bean.setMemberImg(rs.getString("memberImg"));
					bean.setMemberName(rs.getString("memberName"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		//회원가입 테이블에서 멤버 정보 받아오기
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
	//모임 생성
		public boolean moimInsert(HttpServletRequest req) {
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
				String moimImg = null;
				if(multi.getFilesystemName("moimImg")!=null) {
					moimImg = multi.getFilesystemName("moimImg");
				}
				//File f = new File(memberImg);
				String moimName = multi.getParameter("moimName");
				String moimArea = multi.getParameter("moimArea");
				int moimHCount = Integer.parseInt(multi.getParameter("moimHCount"));
				String memberId = multi.getParameter("memberId");
				String moimKakao = multi.getParameter("moimKakao");
				String moimProfile = multi.getParameter("moimProfile");
				String moimDate = multi.getParameter("moimDate");
				String classprice = multi.getParameter("classprice");
				int categoryNum = Integer.parseInt(multi.getParameter("categoryNum"));
				int businessNum = Integer.parseInt(multi.getParameter("businessNum"));
				int taskNum = Integer.parseInt(multi.getParameter("taskNum"));
				int themeNum = Integer.parseInt(multi.getParameter("themeNum"));
				int moimOrclass = Integer.parseInt(multi.getParameter("moimtype"));
				con = pool.getConnection();
				sql = " insert into moim(moimName,moimArea,moimHCount,memberId,moimKakao, "
						+ "categoryNum,moimImg,moimProfile,moimDate,themeNum,taskNum,businessNum, "
						+ "classprice, moimOrclass)  "
						+ "  values (?,?,?,?,?,?,?,?,now(),?,?,?,?,?);";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, moimName);
				pstmt.setString(2, moimArea);
				pstmt.setInt(3, moimHCount);
				pstmt.setString(4, memberId);
				pstmt.setString(5, moimKakao);
				pstmt.setInt(6, categoryNum);
				pstmt.setString(7, moimImg);
				pstmt.setString(8, moimProfile);
				pstmt.setInt(9, themeNum);
				pstmt.setInt(10, themeNum);
				pstmt.setInt(11, businessNum);
				pstmt.setString(12, classprice);
				pstmt.setInt(13, moimOrclass);
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
	public boolean moimUpdate(HttpServletRequest req) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			File dir = new File(SAVEFOLDER);
			if(!dir.exists()/*존재하지 않으면*/) {
				dir.mkdirs();	// mkdirs는 상위폴더가 없어도 생성
				// mkdir은 상위폴더가 없으면 생성 불가
			}
			MultipartRequest multi = 
					new MultipartRequest(req, SAVEFOLDER, MAXSIZE, ENCODING
							,new DefaultFileRenamePolicy());
			String moimImg = null;
			con = pool.getConnection();
			if(multi.getFilesystemName("moimImg")!=null) {
				moimImg = multi.getFilesystemName("moimImg");
				int moimNum = Integer.parseInt(multi.getParameter("moimNum"));
				String moimName = multi.getParameter("moimName");
				String moimArea = multi.getParameter("moimArea");
				int moimHCount = Integer.parseInt(multi.getParameter("moimHCount"));
				String memberId = multi.getParameter("memberId");
				String moimKakao = multi.getParameter("moimKakao");
				String moimProfile = multi.getParameter("moimProfile");
				String moimDate = multi.getParameter("moimDate");
				String classprice = multi.getParameter("classprice");
				int categoryNum = Integer.parseInt(multi.getParameter("categoryNum"));
				int businessNum = Integer.parseInt(multi.getParameter("businessNum"));
				int taskNum = Integer.parseInt(multi.getParameter("taskNum"));
				int themeNum = Integer.parseInt(multi.getParameter("themeNum"));
				int moimOrclass = Integer.parseInt(multi.getParameter("moimOrclass"));
				con = pool.getConnection();
				sql = "update moim  "
						+ "set moimName= ?, moimArea=?, moimKakao=?, categoryNum=?, "
						+ "moimImg=?, moimProfile=?, themeNum=?, taskNum=?, moimHCount =?, "
						+ "businessNum=?, classprice=?, moimOrclass = ?  "
						+ "where moimNum= ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, moimName);
					pstmt.setString(2, moimArea);
					pstmt.setString(3, moimKakao);
					pstmt.setInt(4, categoryNum);
					pstmt.setString(5, moimImg);
					pstmt.setString(6, moimProfile);
					pstmt.setInt(7, themeNum);
					pstmt.setInt(8, taskNum);
					pstmt.setInt(9, moimHCount);
					pstmt.setInt(10, businessNum);
					pstmt.setString(11, classprice);
					pstmt.setInt(12, moimOrclass);
					pstmt.setInt(13, moimNum);
			}else {
				int moimNum = Integer.parseInt(multi.getParameter("moimNum"));
				String moimName = multi.getParameter("moimName");
				String moimArea = multi.getParameter("moimArea");
				int moimHCount = Integer.parseInt(multi.getParameter("moimHCount"));
				String memberId = multi.getParameter("memberId");
				String moimKakao = multi.getParameter("moimKakao");
				String moimProfile = multi.getParameter("moimProfile");
				String moimDate = multi.getParameter("moimDate");
				String classprice = multi.getParameter("classprice");
				int categoryNum = Integer.parseInt(multi.getParameter("categoryNum"));
				int businessNum = Integer.parseInt(multi.getParameter("businessNum"));
				int taskNum = Integer.parseInt(multi.getParameter("taskNum"));
				int themeNum = Integer.parseInt(multi.getParameter("themeNum"));
				int moimOrclass = Integer.parseInt(multi.getParameter("moimOrclass"));
				sql = "update moim  "
					+ "set moimName= ?, moimArea=?, moimKakao=?, categoryNum=?, "
					+ " moimProfile=?, themeNum=?, taskNum=?, moimHCount =?, "
					+ "businessNum=?, classprice=?, moimOrclass = ?  "
					+ "where moimNum= ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, moimName);
				pstmt.setString(2, moimArea);
				pstmt.setString(3, moimKakao);
				pstmt.setInt(4, categoryNum);
				pstmt.setString(5, moimProfile);
				pstmt.setInt(6, themeNum);
				pstmt.setInt(7, taskNum);
				pstmt.setInt(8, moimHCount);
				pstmt.setInt(9, businessNum);
				pstmt.setString(10, classprice);
				pstmt.setInt(11, moimOrclass);
				pstmt.setInt(12, moimNum);
			}
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
	//클래스페이지에 리스트 출력
	public Vector<MoimBean> classList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		try {
			con = pool.getConnection();
			sql = "select * from moim m where moimOrclass = 1;";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moimNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMoimNum(rs.getInt("moimNum"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimImg(rs.getString("moimImg"));
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
				bean.setCategoryNum(rs.getInt("categoryNum"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				bean.setClassprice(rs.getString("classprice"));
				bean.setClassLike(rs.getInt("classLike"));
				bean.setMoimOrclass(rs.getInt("moimOrclass"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//모임 직무별 리스트
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
				bean.setCategoryNum(rs.getInt("categoryNum"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				bean.setClassprice(rs.getString("classprice"));
				bean.setClassLike(rs.getInt("classLike"));
				bean.setMoimOrclass(rs.getInt("moimOrclass"));
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
				bean.setCategoryNum(rs.getInt("categoryNum"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				bean.setClassprice(rs.getString("classprice"));
				bean.setClassLike(rs.getInt("classLike"));
				bean.setMoimOrclass(rs.getInt("moimOrclass"));
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
				bean.setMoimNum(rs.getInt("moimNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setCategoryNum(rs.getInt("categoryNum"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				bean.setClassprice(rs.getString("classprice"));
				bean.setClassLike(rs.getInt("classLike"));
				bean.setMoimOrclass(rs.getInt("moimOrclass"));
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
			sql = "select * from moim where moimArea = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, moimArea);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moimNum"));
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
				bean.setCategoryNum(rs.getInt("categoryNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				bean.setClassprice(rs.getString("classprice"));
				bean.setClassLike(rs.getInt("classLike"));
				bean.setMoimOrclass(rs.getInt("moimOrclass"));
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
				bean.setMoimNum(rs.getInt("moimNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setCategoryNum(rs.getInt("categoryNum"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				bean.setClassprice(rs.getString("classprice"));
				bean.setClassLike(rs.getInt("classLike"));
				bean.setMoimOrclass(rs.getInt("moimOrclass"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//모임가입신청
	public boolean mjInsert(int moimNum, String memberId, String mjContent) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into moimjoin(moimNum,memberId,mjDate,mjContent)\r\n"
					+ "values (?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			pstmt.setString(2, memberId);
			pstmt.setString(3, mjContent);
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
	//가입신청리스트
	public Vector<MoimJoinBean> mjList(int moimNum){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MoimJoinBean> vlist = new Vector<MoimJoinBean>();
		try {
			con = pool.getConnection();
			sql = "select * from moimjoin  "
				+ "where moimNum =? and mjCheck = 0";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimJoinBean bean = new MoimJoinBean();
				bean.setMjNum(rs.getInt(1));
				bean.setMoimNum(rs.getInt(2));
				bean.setMemberId(rs.getString(3));
				bean.setMjCheck(rs.getInt(4));
				bean.setMjDate(rs.getString(5));				
				bean.setMjContent(rs.getString(6));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//가입수락 업데이트
	public boolean mjAccept(String memberId, int moimNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update moimjoin set mjcheck=1 "
				+ "where memberId =? and moimNum =?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, moimNum);		
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
	
	
	//멤버가 가입한 모임 리스트 가져오기
	public Vector<MoimBean> joinmoimList(String memberId){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		try {
			con = pool.getConnection();
			sql = "select m2.* from moimmember m , moim m2 "
				+ "where m.moimNum =m2.moimNum and "
				+ "m.memberId  = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moimNum"));
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
				bean.setCategoryNum(rs.getInt("categoryNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				bean.setClassprice(rs.getString("classprice"));
				bean.setClassLike(rs.getInt("classLike"));
				bean.setMoimOrclass(rs.getInt("moimOrclass"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	
	//모임가입신청 삭제(거절)
	   public boolean mjDelete(String memberId, int moimNum) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      String sql = null;
	      boolean flag = false;
	      try {
	         con = pool.getConnection();
	         sql = "delete from moimjoin where memberId=? and moimNum=?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, memberId);
	         pstmt.setInt(2, moimNum);
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
	
	//모임일정생성
	public boolean msInsert(MoimScheduleBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {		
			con = pool.getConnection();
			sql = "insert into moimschedule(msTime,msArea,moimNum,"
				+ "msHCount,memberId,msTitle,msContent, msDate) "
				+ "values (?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMsTime());
			pstmt.setString(2, bean.getMsArea());
			pstmt.setInt(3, bean.getMoimNum());
			pstmt.setInt(4, bean.getMsHCount());
			pstmt.setString(5, bean.getMemberId());
			pstmt.setString(6, bean.getMsTitle());
			pstmt.setString(7, bean.getMsContent());
			pstmt.setString(8, bean.getMsDate());
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
	
	//최근 생성 모임 리스트(10일) -- 지역별
	public Vector<MoimBean> newMoimList(String address){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		try {
			con = pool.getConnection();
			sql = "select * from moim m "
				+ "where abs(datediff(moimDate,now())) <= 10 and moimArea=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, address);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moimNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setCategoryNum(rs.getInt("categoryNum"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				bean.setClassprice(rs.getString("classprice"));
				bean.setClassLike(rs.getInt("classLike"));
				bean.setMoimOrclass(rs.getInt("moimOrclass"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
		
	}
	//최근 생성 모임 리스트(10일) -- 전체
	public Vector<MoimBean> newMoimList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MoimBean> vlist = new Vector<MoimBean>();
		try {
			con = pool.getConnection();
			sql = "select * from moim m "
				+ "where abs(datediff(moimDate,now())) <= 10";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimBean bean = new MoimBean();
				bean.setMoimNum(rs.getInt("moimNum"));
				bean.setMoimName(rs.getString("moimName"));
				bean.setMoimArea(rs.getString("moimArea"));
				bean.setMoimHCount(rs.getInt("moimHCount"));
				bean.setMoimNCount(rs.getInt("moimNCount"));
				bean.setMemberId(rs.getString("memberId"));
				bean.setMoimKakao(rs.getString("moimKakao"));
				bean.setMoimImg(rs.getString("moimImg"));
				bean.setCategoryNum(rs.getInt("categoryNum"));
				bean.setMoimProfile(rs.getString("moimProfile"));
				bean.setMoimDate(rs.getString("moimDate"));
				bean.setBusinessNum(rs.getInt("businessNum"));
				bean.setTaskNum(rs.getInt("taskNum"));
				bean.setThemeNum(rs.getInt("themeNum"));
				bean.setClassprice(rs.getString("classprice"));
				bean.setClassLike(rs.getInt("classLike"));
				bean.setMoimOrclass(rs.getInt("moimOrclass"));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	// 최근본모임 있으면 시간 업데이트 
	public boolean rsUpdate(String memberId, int moimNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		if(memberId==null) {
			return flag;
		}
		try {
			con = pool.getConnection();
			sql = "update recentseen set rsDate = now() "
				+ "where memberId = ? and moimNum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, moimNum);
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	// 최근본모임 
	public boolean rsInsert(String memberId, int moimNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into recentseen(memberId, moimNum, rsDate) "
				+ "values(?, ?, now());";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, moimNum);
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//멤버의 전체 모임+클래스 리스트
			public Vector<MoimBean> mymoimList(String memberId){
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<MoimBean> vlist = new Vector<MoimBean>();
				try {
					con = pool.getConnection();
					sql = "select * from moim where memberId = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, memberId);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						MoimBean bean = new MoimBean();
						bean.setMoimNum(rs.getInt("moimNum"));
						bean.setMoimName(rs.getString("moimName"));
						bean.setMoimArea(rs.getString("moimArea"));
						bean.setMoimHCount(rs.getInt("moimHCount"));
						bean.setMoimNCount(rs.getInt("moimNCount"));
						bean.setMemberId(rs.getString("memberId"));
						bean.setMoimKakao(rs.getString("moimKakao"));
						bean.setMoimImg(rs.getString("moimImg"));
						bean.setCategoryNum(rs.getInt("categoryNum"));
						bean.setMoimProfile(rs.getString("moimProfile"));
						bean.setMoimDate(rs.getString("moimDate"));
						bean.setBusinessNum(rs.getInt("businessNum"));
						bean.setTaskNum(rs.getInt("taskNum"));
						bean.setThemeNum(rs.getInt("themeNum"));
						bean.setClassprice(rs.getString("classprice"));
						bean.setClassLike(rs.getInt("classLike"));
						bean.setMoimOrclass(rs.getInt("moimOrclass"));
						vlist.addElement(bean);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return vlist;
			}
	//전체 모임+클래스 리스트
		public Vector<MoimBean> moimAllList(){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimBean> vlist = new Vector<MoimBean>();
			try {
				con = pool.getConnection();
				sql = "select * from moim ";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MoimBean bean = new MoimBean();
					bean.setMoimNum(rs.getInt("moimNum"));
					bean.setMoimName(rs.getString("moimName"));
					bean.setMoimArea(rs.getString("moimArea"));
					bean.setMoimHCount(rs.getInt("moimHCount"));
					bean.setMoimNCount(rs.getInt("moimNCount"));
					bean.setMemberId(rs.getString("memberId"));
					bean.setMoimKakao(rs.getString("moimKakao"));
					bean.setMoimImg(rs.getString("moimImg"));
					bean.setCategoryNum(rs.getInt("categoryNum"));
					bean.setMoimProfile(rs.getString("moimProfile"));
					bean.setMoimDate(rs.getString("moimDate"));
					bean.setBusinessNum(rs.getInt("businessNum"));
					bean.setTaskNum(rs.getInt("taskNum"));
					bean.setThemeNum(rs.getInt("themeNum"));
					bean.setClassprice(rs.getString("classprice"));
					bean.setClassLike(rs.getInt("classLike"));
					bean.setMoimOrclass(rs.getInt("moimOrclass"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		//검색별 모임 
		public Vector<MoimBean> searchMoimList(String search){
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimBean> vlist = new Vector<MoimBean>();
			try {
				con = pool.getConnection();
				sql = "select * from moim where moimName like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%"+search+"%");
				rs = pstmt.executeQuery();
				while(rs.next()) {
					MoimBean bean = new MoimBean();
					bean.setMoimNum(rs.getInt("moimNum"));
					bean.setMoimName(rs.getString("moimName"));
					bean.setMoimArea(rs.getString("moimArea"));
					bean.setMoimHCount(rs.getInt("moimHCount"));
					bean.setMoimNCount(rs.getInt("moimNCount"));
					bean.setMemberId(rs.getString("memberId"));
					bean.setMoimKakao(rs.getString("moimKakao"));
					bean.setMoimImg(rs.getString("moimImg"));
					bean.setCategoryNum(rs.getInt("categoryNum"));
					bean.setMoimProfile(rs.getString("moimProfile"));
					bean.setMoimDate(rs.getString("moimDate"));
					bean.setBusinessNum(rs.getInt("businessNum"));
					bean.setTaskNum(rs.getInt("taskNum"));
					bean.setThemeNum(rs.getInt("themeNum"));
					bean.setClassprice(rs.getString("classprice"));
					bean.setClassLike(rs.getInt("classLike"));
					bean.setMoimOrclass(rs.getInt("moimOrclass"));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		//찜리스트 insert
			public boolean jjimInsert(JjimListBean bean) {
				Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				boolean flag = false;
					try {
						con = pool.getConnection();
						sql = "insert into jjimlist(memberId, moimNum, classNum) "
							+ "values (?, ?, ?)";
						pstmt = con.prepareStatement(sql);
						//pstmt.setInt(1, bean.getJjimNum());
						pstmt.setString(1, bean.getMemberId());
						pstmt.setInt(2, bean.getMoimNum());
						pstmt.setInt(3, bean.getClassNum());
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
		//멤버아이디, 모임번호로 찜 여부 검사
		public boolean jjimCheck(String memberId, int moimNum) {
		        Connection con = null;
		         PreparedStatement pstmt = null;
		         ResultSet rs = null;
		         String sql = null;
		         boolean flag = false;
		         try {
		            con = pool.getConnection();
		            sql = "select * from jjimlist where memberId = ? and moimNum = ?";
		            pstmt = con.prepareStatement(sql);
			        pstmt.setString(1, memberId);
			        pstmt.setInt(2, moimNum);
			        rs = pstmt.executeQuery();
			        if(rs.next()) {
		              flag = true;
			           }
			        } catch (Exception e) {
			           e.printStackTrace();
			        } finally {
			           pool.freeConnection(con, pstmt, rs);
			        }
			        return flag;      
		      }
		      
		//찜 삭제
		public boolean jjimDelete(String memberId, int moimNum) {
			Connection con = null;
	        PreparedStatement pstmt = null;
	        String sql = null;
	        boolean flag=false;
		         try {
		            con = pool.getConnection();
		            sql = "delete from jjimlist where memberId=? and moimNum=?";
		            pstmt = con.prepareStatement(sql);
		            pstmt.setString(1, memberId);
		            pstmt.setInt(2, moimNum);
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
		      
	      //한 모임의 찜 개수 확인
		      public int jjimCount(int moimNum) {
		         Connection con = null;
		         PreparedStatement pstmt = null;
		         ResultSet rs = null;
		         String sql = null;
		         int jjimcount = 0;
		         try {
		            con = pool.getConnection();
		            sql = "select count(*) from jjimlist where moimNum = ?";
		            pstmt = con.prepareStatement(sql);
		            pstmt.setInt(1, moimNum);
		            rs = pstmt.executeQuery();
		            while(rs.next()) {
		               jjimcount = jjimcount + 1;
		            }
		         } catch (Exception e) {
		            e.printStackTrace();
		         } finally {
		            pool.freeConnection(con, pstmt, rs);
		         }
		         return jjimcount;
		      }
		//찜목록리스트 출력
		      public Vector<MoimBean> jjimList(String memberId){
		    	Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				Vector<MoimBean> vlist = new Vector<MoimBean>();
				try {
					con = pool.getConnection();
					sql = "select m.* from jjimlist j, moim m "
							+ "where j.moimNum = m.moimNum and j.memberId = ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, memberId);
					rs = pstmt.executeQuery();
					while(rs.next()) {
						MoimBean bean = new MoimBean();
						bean.setMoimNum(rs.getInt("moimNum"));
						bean.setMoimName(rs.getString("moimName"));
						bean.setMoimArea(rs.getString("moimArea"));
						bean.setMoimHCount(rs.getInt("moimHCount"));
						bean.setMoimNCount(rs.getInt("moimNCount"));
						bean.setMemberId(rs.getString("memberId"));
						bean.setMoimKakao(rs.getString("moimKakao"));
						bean.setMoimImg(rs.getString("moimImg"));
						bean.setCategoryNum(rs.getInt("categoryNum"));
						bean.setMoimProfile(rs.getString("moimProfile"));
						bean.setMoimDate(rs.getString("moimDate"));
						bean.setBusinessNum(rs.getInt("businessNum"));
						bean.setTaskNum(rs.getInt("taskNum"));
						bean.setThemeNum(rs.getInt("themeNum"));
						bean.setClassprice(rs.getString("classprice"));
						bean.setClassLike(rs.getInt("classLike"));
						bean.setMoimOrclass(rs.getInt("moimOrclass"));
						vlist.addElement(bean);
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return vlist;
		      }
		      //모임 사진 추가
	            public boolean moimAddPhoto(HttpServletRequest req) {
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
	       			String photo = null;
	       			if(multi.getFilesystemName("photo")!=null) {
	       				photo = multi.getFilesystemName("photo");
	       			}
	       			int moimNum = Integer.parseInt(multi.getParameter("moimNum"));
	       			String upDate = multi.getParameter("upDate");
	       			String memberId = multi.getParameter("memberId");
	       			String photoName = multi.getParameter("photoName");
	                  con = pool.getConnection();
	                  sql = "insert into moimphotos(moimNum, photo,`upDate`,memberId, photoName)"
	                        + "values(?,?,now(),?,?)";
	                  pstmt = con.prepareStatement(sql);
	                  pstmt.setInt(1, moimNum);
	                  pstmt.setString(2, photo);
	                  pstmt.setString(3, memberId);
	                  pstmt.setString(4, photoName);
	                  if(pstmt.executeUpdate()==1) {
	                     flag = true;
	                  };
	               } catch (Exception e) {
	                  e.printStackTrace();
	               } finally {
	                  pool.freeConnection(con, pstmt);
	               }
	               return flag;
	            }
	          //모임 사진 수정
	            public boolean moimUpdatePhoto(HttpServletRequest req) {
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
	       			String photo = null;
	       			if(multi.getFilesystemName("photo")!=null) {
	       				photo = multi.getFilesystemName("photo");
	       			}
	       			int photonum = Integer.parseInt(multi.getParameter("photonum"));
	       			String photoName = multi.getParameter("photoName");
	                  con = pool.getConnection();
	                  sql = "update moimphotos "
	                  	+ "set photo=? , `update`=now(), photoName= ?  "
	                  	+ "where photonum=?;";
	                  pstmt = con.prepareStatement(sql);
	                  pstmt.setString(1, photo);
	                  pstmt.setString(2, photoName);
	                  pstmt.setInt(3, photonum);
	                  if(pstmt.executeUpdate()==1) {
	                     flag = true;
	                  };
	               } catch (Exception e) {
	                  e.printStackTrace();
	               } finally {
	                  pool.freeConnection(con, pstmt);
	               }
	               return flag;
	            }
	            // 모임 사진 리스트
	            public Vector<MoimPhotosBean> getmoimImgList(int moimNum) {
	               Connection con = null;
	               PreparedStatement pstmt = null;
	               ResultSet rs = null;
	               String sql = null;
	               Vector<MoimPhotosBean> photovlist = new Vector<MoimPhotosBean>();
	               try {
	                  con = pool.getConnection();
	                  sql = "select photo, photoName, memberId, photoNum from moimphotos where moimNum = ?";
	                  pstmt = con.prepareStatement(sql);
	                  pstmt.setInt(1, moimNum);
	                  rs = pstmt.executeQuery();
	                  while (rs.next()) {
	                     MoimPhotosBean bean = new MoimPhotosBean();
	                     bean.setPhoto(rs.getString(1));
	                     bean.setPhotoName(rs.getString(2));
	                     bean.setMemberId(rs.getString(3));	                 
	                     bean.setPhotoNum(rs.getInt(4));
	                     photovlist.addElement(bean);
	                  }

	               } catch (Exception e) {
	                  e.printStackTrace();
	               } finally {
	                  pool.freeConnection(con, pstmt, rs);
	               }
	               return photovlist;
	            }
	         public boolean getMoimMemberId(String memberId, int moimNum) {
	            Connection con = null;
	            PreparedStatement pstmt = null;
	            ResultSet rs = null;
	            String sql = null;
	            boolean flag = false;
	            try {
	               con = pool.getConnection();
	               sql = "select memberId from Moim where memberId = ? and moimNum = ?";
	               pstmt = con.prepareStatement(sql);
	               pstmt.setString(1, memberId);
	               pstmt.setInt(2, moimNum);
	               rs = pstmt.executeQuery();
	               
	               if(rs.next()) {
	                  flag = true;
	               }
	               
	            
	            } catch (Exception e) {
	               e.printStackTrace();
	            } finally {
	               pool.freeConnection(con, pstmt, rs);
	            }
	            return flag;
	         }
	         //모임 탈퇴하기
	         public boolean moimLeave(String memberId, int moimNum) {
	            Connection con = null;
	            PreparedStatement pstmt = null;
	            String sql = null;
	            boolean flag = false;
	            try {
	               con = pool.getConnection();
	               sql = "delete from moimmember where memberId = ? AND moimNum = ?";
	               pstmt = con.prepareStatement(sql);
	               pstmt.setString(1, memberId);
	               pstmt.setInt(2, moimNum);
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
	      // 모임맴버에 모임장 바로추가
	         public boolean moimmemberInsert(String memberId, int moimNum) {
	        	 Connection con = null;
				PreparedStatement pstmt = null;
				String sql = null;
				boolean flag = false;
				try {
					con = pool.getConnection();
					sql = "insert into moimmember (memberId, moimNum) "
						+ "values(?,?);";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, memberId);
					pstmt.setInt(2, moimNum);
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
	         
	      // 모임 사진 삭제

	         public boolean deleteMoimphoto(int photoNum, String memberId) {
	            Connection con = null;
	            PreparedStatement pstmt = null;
	            String sql = null;
	            boolean flag = false;
	            try {
	               con = pool.getConnection();
	               sql = "delete from moimphotos where photoNum = ? and memberId = ?";
	               pstmt = con.prepareStatement(sql);
	               pstmt.setInt(1, photoNum);
	               pstmt.setString(2, memberId);
	               if (pstmt.executeUpdate() == 1) {
	                  flag = true;
	               }
	               ;
	            } catch (Exception e) {
	               e.printStackTrace();
	            } finally {
	               pool.freeConnection(con, pstmt);
	            }
	            return flag;
	         }
	         
	      // 모임 사진 상세 (모임에 사진 리스트에서 사진 누르면 얻어야함 )

	         public MoimPhotosBean getmoimImgDetail(int photoNum) {
	            Connection con = null;
	            PreparedStatement pstmt = null;
	            ResultSet rs = null;
	            String sql = null;
	            MoimPhotosBean bean = new MoimPhotosBean();
	            try {
	               con = pool.getConnection();
	               sql = "select * from moimPhotos where photoNum = ?";
	               pstmt = con.prepareStatement(sql);
	               pstmt.setInt(1, photoNum);

	               rs = pstmt.executeQuery();
	               if (rs.next()) {
	                  bean.setPhotoNum(rs.getInt(1));
	                  bean.setMoimNum(rs.getInt(2));
	                  bean.setPhoto(rs.getString(3));
	                  bean.setUpDate(rs.getString(4));
	                  bean.setMemberId(rs.getString(5));
	                  bean.setPhotoName(rs.getString(6));
	               }

	            } catch (Exception e) {
	               e.printStackTrace();
	            } finally {
	               pool.freeConnection(con, pstmt, rs);
	            }
	            return bean;
	         }
	         
	         //모임가입신청에 있는지 확인
	         
	         public boolean mjChk(String memberId, int moimNum) {
	        	Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = null;
				boolean flag=false;
				try {
					con = pool.getConnection();
					sql = "select * from moimjoin  "
						+ "where memberId = ? and moimNum = ? ";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, memberId);
					pstmt.setInt(2, moimNum);					
					rs = pstmt.executeQuery();
					if(rs.next()) {
						flag=true;
					}
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					pool.freeConnection(con, pstmt, rs);
				}
				return flag;
	         }
}