package controll.Mgr;

import java.lang.reflect.Member;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import controll.DBConnectionMgr;
import model.Bean.MemberBean;
import model.Bean.MoimScheduleBean;
import model.Bean.ScheduleJoinBean;

public class ScheduleJoinMgr {

	DBConnectionMgr pool;

	public ScheduleJoinMgr() {
		pool = DBConnectionMgr.getInstance();
	}

	//모든 모임일정가져오기
	   public Vector<MoimScheduleBean> allmoimScheduleList() {
		      Connection con = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      String sql = null;
		      Vector<MoimScheduleBean> msvlist = new Vector<MoimScheduleBean>();
		      try {
		         con = pool.getConnection();
		         sql = "select m.*, m2.moimImg from moimschedule m ,moim m2 "
		         	+ "where m.moimNum =m2.moimNum and "
		         	+ "datediff(msDate,now()) >= 0 "
		        	+ "order by m.msDate ";
		         pstmt = con.prepareStatement(sql);
		         rs = pstmt.executeQuery();
		         while(rs.next()) {
		            MoimScheduleBean bean = new MoimScheduleBean();
		            bean.setMsNum(rs.getInt("m.msNum"));
		            bean.setMsTime(rs.getString("m.msTime"));
		            bean.setMsArea(rs.getString("m.msArea"));
		            bean.setMoimNum(rs.getInt("m.moimNum"));
		            bean.setMsHCount(rs.getInt("m.msHCount"));
		            bean.setMemberId(rs.getString("m.memberId"));
		            bean.setMsNCount(rs.getInt("m.msNCount"));
		            bean.setMsTitle(rs.getString("m.msTitle"));
		            bean.setMsContent(rs.getString("m.msContent"));
		            bean.setMsDate(rs.getString("m.msDate"));
		            bean.setMoimImg(rs.getString("m2.moimImg"));
		            msvlist.addElement(bean);
		         }
		      } catch (Exception e) {
		         e.printStackTrace();
		      } finally {
		         pool.freeConnection(con, pstmt, rs);
		      }
		      return msvlist;
		   }
	 //모임스케줄에서 참여한 멤버 이름, 프로필, 사진 가져오기
	    public Vector<MemberBean> moimScheduleImg(int num) {
	       Connection con = null;
	       PreparedStatement pstmt = null;
	       ResultSet rs = null;
	       String sql = null;
	       Vector<MemberBean> moimschvlist = new Vector<MemberBean>();
	       try {
	          con = pool.getConnection();
	          sql = "select member.memberImg, member.memberName, member.memberProfile, member.memberId "
	          		+ "from member inner join schedulejoin on member.memberId = schedulejoin.memberId "
	          		+ "where schedulejoin.moimNum = ?";
	          pstmt = con.prepareStatement(sql);
	          pstmt.setInt(1, num);
	          rs = pstmt.executeQuery();
	          while(rs.next()) {
	             MemberBean mbean = new MemberBean();
	             mbean.setMemberImg(rs.getString(1));
	             mbean.setMemberName(rs.getString(2));
	             mbean.setMemberProfile(rs.getString(3));
	             mbean.setMemberId(rs.getString(4));
	             moimschvlist.addElement(mbean);
	          }
	       } catch (Exception e) {
	          e.printStackTrace();
	       } finally {
	          pool.freeConnection(con, pstmt, rs);
	       }
	       return moimschvlist;
	    }
	 // 모임스케줄가져오기(수정)
	    public Vector<MoimScheduleBean> moimScheduleList(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MoimScheduleBean> msvlist = new Vector<MoimScheduleBean>();
			try {
				con = pool.getConnection();
				sql = "select * from moimschedule where datediff(msDate,now()) >= 0 and moimNum = ? order by msDate asc";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					MoimScheduleBean bean = new MoimScheduleBean();
					bean.setMsNum(rs.getInt(1));
					bean.setMsTime(rs.getString(2));
					bean.setMsArea(rs.getString(3));
					bean.setMoimNum(rs.getInt(4));
					bean.setMsHCount(rs.getInt(5));
					bean.setMemberId(rs.getString(6));
					bean.setMsNCount(rs.getInt(7));
					bean.setMsTitle(rs.getString(8));
					bean.setMsContent(rs.getString(9));
					bean.setMsDate(rs.getString(10));
					msvlist.addElement(bean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return msvlist;
		}

	   // 모임일정에서 '일' 가져오기
	   public Vector<MoimScheduleBean> moimScheduleDayList(int num) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      Vector<MoimScheduleBean> mjDayList = new Vector<MoimScheduleBean>();
	      try {
	         con = pool.getConnection();
	         sql = "SELECT EXTRACT(day FROM moimschedule.msDate) AS moimScheduleDay "
	               + "FROM moimschedule "
	               + "where moimNum = ? "
	               + "order by moimScheduleDay asc";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, num);
	         rs = pstmt.executeQuery();
	         while (rs.next()) {
	            MoimScheduleBean bean = new MoimScheduleBean();
	            bean.setMsDate(rs.getString(1));
	            mjDayList.addElement(bean);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         pool.freeConnection(con, pstmt, rs);
	      }
	      return mjDayList;
	   }

	// 모임일정에서 '월' 가져오기
	public String moimScheduleMon(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String mmDay = null;
		try {
			con = pool.getConnection();
			sql = "SELECT EXTRACT(month  FROM msDate) as mon " + "FROM moimschedule " + "where moimNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mmDay = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mmDay;
	}

	// 모임일정의 요일 추출하기
	public String moimScheduleDayName(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String mjDayName = null;
		try {
			con = pool.getConnection();
			sql = "SELECT CASE DAYOFWEEK(msDate)" + "    WHEN 1 THEN '일요일'" + "    WHEN 2 THEN '월요일'"
					+ "    WHEN 3 THEN '화요일'" + "    WHEN 4 THEN '수요일'" + "    WHEN 5 THEN '목요일'"
					+ "    WHEN 6 THEN '금요일'" + "    WHEN 7 THEN '토요일'" + "END AS day_name " + "FROM moimschedule "
					+ "where moimNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mjDayName = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return mjDayName;
	}

	// 모임스케줄에서 참여한 멤버 이름, 프로필, 사진 가져오기(int msNum으로 바꿈)
		public Vector<MemberBean> moimScheduleMember(int msNum) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			Vector<MemberBean> moimschvlist = new Vector<MemberBean>();
			try {
				con = pool.getConnection();
				sql = "select member.memberImg, member.memberName, member.memberProfile, member.memberId "
						+ "from member inner join schedulejoin on member.memberId = schedulejoin.memberId "
						+ "where schedulejoin.msNum = ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, msNum);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					MemberBean mbean = new MemberBean();
					mbean.setMemberImg(rs.getString("member.memberImg"));
					mbean.setMemberName(rs.getString("member.memberName"));
					mbean.setMemberProfile(rs.getString("member.memberProfile"));
					mbean.setMemberId(rs.getString("member.memberId"));
					moimschvlist.addElement(mbean);
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				pool.freeConnection(con, pstmt, rs);
			}
			return moimschvlist;
		}

	// 모임에서 가입한 전체 멤버 이름,소개,프로필사진 가져오기
	public Vector<MemberBean> moimScheduleAllMember(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> moimAllMemvlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			sql = "select m.memberImg , m.memberName , m.memberProfile, m.memberId "
					+ "from member m inner join moimmember m2 ON m.memberId = m2.memberId " + "where m2.moimNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				MemberBean mbean = new MemberBean();
				mbean.setMemberImg(rs.getString(1));
				mbean.setMemberName(rs.getString(2));
				mbean.setMemberProfile(rs.getString(3));
				mbean.setMemberId(rs.getString(4));
				moimAllMemvlist.addElement(mbean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return moimAllMemvlist;
	}

	// 같은 모임에서 다른 스케줄일때 구별해서 가져오기
	public Vector<ScheduleJoinBean> scheduleJoinMsvList(int msNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ScheduleJoinBean> scheduleJoinMsvList = new Vector<ScheduleJoinBean>();
		try {
			con = pool.getConnection();
			sql = "select * from schedulejoin where msNum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, msNum);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ScheduleJoinBean bean = new ScheduleJoinBean();
				bean.setSjNum(rs.getInt(1));
				bean.setMsNum(rs.getInt(2));
				bean.setMemberid(rs.getString(3));
				bean.setMoimNum(rs.getInt(4));
				System.out.println("test " + bean.getMemberid());
				scheduleJoinMsvList.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return scheduleJoinMsvList;
	}
	// 모임회장의 이름, 자기소개, 이미지 가져오기
	public MemberBean moimManager(int moimNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		MemberBean bean = new MemberBean();
		try {
			con = pool.getConnection();
			sql = "select member.memberImg , member.memberProfile , member.memberName, member.memberId "
					+ "from member  inner join moim  on member.memberId = moim.memberId "
					+ "where moim.moimNum = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean.setMemberImg(rs.getString(1));
				bean.setMemberProfile(rs.getString(2));
				bean.setMemberName(rs.getString(3));
				bean.setMemberId(rs.getString(4));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return bean;
	}
	//일정참여하기-가입한 멤버인지 확인
	public boolean scjoinChk(int moimNum, String memberId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select count(*) from moimmember "
				+ "where moimNum = ? and memberId =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			pstmt.setString(2, memberId);
			rs = pstmt.executeQuery();
			if(rs.next()==true) {
				flag =true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	//일정참여하기 
	public boolean scJoin(int msNum, String memberId, int moimNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into schedulejoin (msNum, memberId, moimNum) "
					+ "values(?,?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, msNum);
			pstmt.setString(2, memberId);
			pstmt.setInt(3, moimNum);
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
	//모임 가입 여부
	   public boolean moimMemberCheck(int moimNum, String memberId) {
	      Connection con = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      String sql = null;
	      boolean flag = false;
	      try {
	         con = pool.getConnection();
	         sql = "select * from moimmember "
	            + "where moimNum = ? and  memberId = ?";
	         pstmt = con.prepareStatement(sql);
	         pstmt.setInt(1, moimNum);
	         pstmt.setString(2, memberId);         
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