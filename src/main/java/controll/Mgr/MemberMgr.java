package controll.Mgr;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import com.mysql.cj.protocol.a.result.ResultsetRowsStatic;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import controll.DBConnectionMgr;
import model.Bean.MemberBean;
import model.Bean.NotificationBean;
import model.Bean.ZipcodeBean;



public class MemberMgr {
	DBConnectionMgr pool;
	public static final String SAVEFOLDER = "C:/Jsp/bigmoim/src/main/webapp/image/";	
	public static final String ENCODING = "UTF-8";
	public static final int MAXSIZE = 1024*1024*20;	//20MB
	public MemberMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//회원탈퇴(삭제)
		public void deleteMember(String memberId) {
			Connection con = null;
			PreparedStatement pstmt = null;
			String sql = null;
			boolean flag = false;
			
			try {
				con = pool.getConnection();
				sql = "delete from member where memberId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, memberId);
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt);
			}
		}
	//로그인
	public boolean loginMember(String memberId, String memberPw) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select memberId, memberPw from member  "
				+"where memberId = ? and memberPw = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberPw);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con);
		}
		return flag;
	}
	
	//id 중복 체크 : 중복 -> true
	public boolean checkId(String memberId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select memberId from member where memberId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			flag = rs.next();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	//우편번호 검색 - area1,area2만 쓸꺼임 시랑 구,동
	public  Vector<ZipcodeBean> zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblZipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+area3+"%");//'%강남대로%'
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				bean.setArea4(rs.getString(5));
				vlist.addElement(bean);
			} 
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//시 리스트 가져오기
	   public Vector<ZipcodeBean> cityList() {
	         Connection con = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         String sql = null;
	         Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
	         try {
	            con = pool.getConnection();
	            sql = "select distinct area1 from tblzipcode";
	            pstmt = con.prepareStatement(sql);
	            rs = pstmt.executeQuery();
	            while(rs.next()) {
	               ZipcodeBean bean = new ZipcodeBean();
	               bean.setArea1(rs.getString("area1"));
	               vlist.addElement(bean);
	            }
	         } catch (Exception e) {
	            e.printStackTrace();
	         } finally {
	            pool.freeConnection(con, pstmt, rs);
	         }
	         return vlist;
	      }
	   
	   // 구 리스트 가져오기
	      public Vector<ZipcodeBean> area2List(String area1) {
	         Connection con = null;
	         PreparedStatement pstmt = null;
	         ResultSet rs = null;
	         String sql = null;
	         Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
	         try {
	            con = pool.getConnection();
	            sql = "select distinct area2 from tblzipcode where area1=?";
	            pstmt = con.prepareStatement(sql);
	            pstmt.setString(1, area1);
	            rs = pstmt.executeQuery();
	            while(rs.next()) {
	               ZipcodeBean bean = new ZipcodeBean();
	               bean.setArea2(rs.getString("area2"));
	               vlist.addElement(bean);
	            }
	         } catch (Exception e) {
	            e.printStackTrace();
	         } finally {
	            pool.freeConnection(con, pstmt, rs);
	         }
	         return vlist;
	      }

	   // ID찾기
	   public String getIdSearch(String name , String tel) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      String id = null;
	      String mid = null;
	      
	      try {
	         con = pool.getConnection();
	         sql = "select memberId from Member where membername = ? and "
	               + "membertel = ?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, name);
	         pstmt.setString(2, tel);
	         rs = pstmt.executeQuery();
	            if(rs.next()) {
	               mid = rs.getString("memberId");
	            }
	         
	      
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt, rs);
	      }
	      return mid;
	   }
	   
	   // 비밀번호 찾기  id 와 전화번호
	   public String getPwSearch(String id , String pwtel) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      String mpw = null;
	      try {
	         con = pool.getConnection();
	         sql = "select memberPw from Member where memberid = ? and membertel = ?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setString(1, id);
	         pstmt.setString(2, pwtel);
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            mpw = rs.getString("memberPw");
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt, rs);
	      }
	      return mpw;
	   }
	//회원가입
	public boolean insertMember(HttpServletRequest req) {
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
			String memberImg = null;
			if(multi.getFilesystemName("memberImg")!=null) {
				memberImg = multi.getFilesystemName("memberImg");
			}
			//File f = new File(memberImg);
			String memberId = multi.getParameter("memberId");
			String memberPw = multi.getParameter("memberPw");
			String memberName = multi.getParameter("memberName");
			String memberTel = multi.getParameter("memberTel");
			String memberBirth = multi.getParameter("memberBirth");
			String memberProfile = multi.getParameter("memberProfile");
			String memberAddr = multi.getParameter("memberAddr");
			String memberJobAddr = multi.getParameter("memberJobAddr");
			String memberLikeArea = multi.getParameter("memberLikeArea");
			int categoryNum = Integer.parseInt(multi.getParameter("categoryNum"));
			int businessNum = Integer.parseInt(multi.getParameter("businessNum"));
			int taskNum = Integer.parseInt(multi.getParameter("taskNum"));
			int themeNum = Integer.parseInt(multi.getParameter("themeNum"));
			int memberSex = Integer.parseInt(multi.getParameter("memberSex"));
			con = pool.getConnection();
			sql = "insert into member  "
				+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberPw);
			pstmt.setString(3, memberName);
			pstmt.setString(4, memberTel);
			pstmt.setString(5, memberBirth);
			if(memberImg == null) {
				memberImg = "defaultuser.png";
			}
			pstmt.setString(6, memberImg);
			pstmt.setString(7, memberProfile);
			pstmt.setInt(8, memberSex);
			pstmt.setString(9, memberAddr);
			pstmt.setString(10, memberJobAddr);
			pstmt.setString(11, memberLikeArea);
			pstmt.setInt(12, categoryNum);
			pstmt.setInt(13, businessNum);
			pstmt.setInt(14, taskNum);
			pstmt.setInt(15, themeNum);	
			if(pstmt.executeUpdate()==1) { //정상
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//회원정보 가져오기
		public MemberBean getMember(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			MemberBean bean = new MemberBean();
			try {
				con = pool.getConnection();
				sql = "select * from member where memberId = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					bean.setMemberId(rs.getString(1));
					bean.setMemberPw(rs.getString(2));
					bean.setMemberName(rs.getString(3));
					bean.setMemberTel(rs.getString(4));
					bean.setMemberBirth(rs.getString(5));
					bean.setMemberImg(rs.getString(6));
					bean.setMemberProfile(rs.getString(7));
					bean.setMemberSex(rs.getInt(8));
					bean.setMemberAddr(rs.getString(9));
					bean.setMemberJobAddr(rs.getString(10));
					bean.setMemberLikeArea(rs.getString(11));
					bean.setCategoryNum(rs.getInt(12));
					bean.setBusinessNum(rs.getInt(13));
					bean.setTaskNum(rs.getInt(14));
					bean.setThemeNum(rs.getInt(15));
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return bean;
		}
	//회원정보 수정
	public boolean updateMember(HttpServletRequest req) {
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
			String memberImg = null;
			if(multi.getFilesystemName("memberImg")!=null) {
				memberImg = multi.getFilesystemName("memberImg");
			}
			//File f = new File(memberImg);
			String memberId = multi.getParameter("memberId");
			String memberPw = multi.getParameter("memberPw");
			String memberName = multi.getParameter("memberName");
			String memberTel = multi.getParameter("memberTel");
			String memberBirth = multi.getParameter("memberBirth");
			String memberProfile = multi.getParameter("memberProfile");
			String memberAddr = multi.getParameter("memberAddr");
			String memberJobAddr = multi.getParameter("memberJobAddr");
			String memberLikeArea = multi.getParameter("memberLikeArea");
			int categoryNum = Integer.parseInt(multi.getParameter("categoryNum"));
			int businessNum = Integer.parseInt(multi.getParameter("businessNum"));
			int taskNum = Integer.parseInt(multi.getParameter("taskNum"));
			int themeNum = Integer.parseInt(multi.getParameter("themeNum"));
			int memberSex = Integer.parseInt(multi.getParameter("memberSex"));
			con = pool.getConnection();
			sql = "update member "
				+ "set memberPw=?,memberName=?,memberTel =?,memberImg =?,memberProfile =?, "
				+ "memberAddr =?, memberJobAddr =?, memberLikeArea =?, categoryNum=?, "
				+ "businessNum =?, taskNum =?,themeNum =?, memberBirth=?, memberSex=?   "
				+ "where memberid = ?;";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberPw);
			pstmt.setString(2, memberName);
			pstmt.setString(3, memberTel);
			if(memberImg == null) {
				memberImg = "defaultuser.png";
			}
			pstmt.setString(4, memberImg);
			pstmt.setString(5, memberProfile);
			pstmt.setString(6, memberAddr);
			pstmt.setString(7, memberJobAddr);
			pstmt.setString(8, memberLikeArea);
			pstmt.setInt(9, categoryNum);
			pstmt.setInt(10, businessNum);
			pstmt.setInt(11, taskNum);
			pstmt.setInt(12, themeNum);	
			pstmt.setString(13, memberBirth);
			pstmt.setInt(14, memberSex);
			pstmt.setString(15, memberId);
			if(pstmt.executeUpdate()==1)
				flag = true;
		} catch (Exception e) {
			e.printStackTrace();
			} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
		///admin mode/////////////
		public Vector<MemberBean> getMemberList() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MemberBean> vlist = new Vector<MemberBean>();
			try {
				con = pool.getConnection();
				sql = "select * from member";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					MemberBean bean = new MemberBean();
					bean.setMemberId(rs.getString(1));
					bean.setMemberPw(rs.getString(2));
					bean.setMemberName(rs.getString(3));
					bean.setMemberTel(rs.getString(4));
					bean.setMemberBirth(rs.getString(5));
					bean.setMemberImg(rs.getString(6));
					bean.setMemberProfile(rs.getString(7));
					bean.setMemberSex(rs.getInt(8));
					bean.setMemberAddr(rs.getString(9));
					bean.setMemberJobAddr(rs.getString(10));
					bean.setMemberLikeArea(rs.getString(11));
					bean.setCategoryNum(rs.getInt(12));
					bean.setBusinessNum(rs.getInt(13));
					bean.setTaskNum(rs.getInt(14));
					bean.setThemeNum(rs.getInt(15));
					vlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return vlist;
		}
		
		//Admin Login
		public boolean adminCheck(String adminId, String adminPw) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			boolean flag = false;
			try {
				con = pool.getConnection();
				sql = "select adminId, adminPw from admin "
						+ "where adminId = ? and adminPw = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, adminId);
				pstmt.setString(2, adminPw);
				rs = pstmt.executeQuery();
				flag = rs.next();
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con);
			}
			return flag;
		}
	// 알림 추가 - MoimMgr.mmList로 모임의 멤버아이디 전부 가져와서 포문으로 넣어줘야함
	//mb=memberBoard, ms=moimschedule, bc=BoardComment
	public boolean notiInsert(String memberId, int photoNum, int mbNum, int msNum, int ccNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into notification (memberId, photoNum, mbNum, msNum, ccNum) "
				+ "value(?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setInt(2, photoNum);
			pstmt.setInt(3, mbNum);
			pstmt.setInt(4, msNum);
			pstmt.setInt(5, ccNum);
			if(pstmt.executeUpdate()==1){
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//알람 카운트 멤버별로
	public int notiCount(String memberId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int count = 0;
		try {
			con = pool.getConnection();
			sql = "select count(*) from notification  "
				+ "where memberId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			while(rs.next()){
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return count;
	}
	//알람 리스트 멤버별로
	public Vector<NotificationBean> notiList(String memberId){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<NotificationBean> vlist = new Vector<NotificationBean>();
		try {
			con = pool.getConnection();
			sql = "select * from notification  "
				+ "where memberId = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				NotificationBean bean = new NotificationBean();
				bean.setNotiNum(rs.getInt(1));
				bean.setMemberId(rs.getString(2));
				bean.setPhotoNum(rs.getInt(3));
				bean.setMbNum(rs.getInt(4));
				bean.setMsNum(rs.getInt(5));
				bean.setRead(rs.getInt(6));				
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//알람 읽기
	public boolean notiRead(String memberId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "update notification set read = 1"
				+ "where memberId =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
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
		
}
