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
   
   //모임스케줄가져오기
   public Vector<MoimScheduleBean> moimScheduleList(int num) {
      Connection con = null;
      PreparedStatement pstmt = null;
      ResultSet rs = null;
      String sql = null;
      Vector<MoimScheduleBean> msvlist = new Vector<MoimScheduleBean>();
      try {
         con = pool.getConnection();
         sql = "select * from moimschedule where moimnum = ?";
         pstmt = con.prepareStatement(sql);
         pstmt.setInt(1, num);
         rs = pstmt.executeQuery();
         while(rs.next()) {
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
            msvlist.addElement(bean);
         }
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         pool.freeConnection(con, pstmt, rs);
      }
      return msvlist;
   }
   
   //모임일정에서 '일' 가져오기
   public String moimScheduleDay(int num) {
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   String sql = null;
	   String mjDay = null;
	   try {
		   con = pool.getConnection();
		   sql = "SELECT EXTRACT(day FROM moimschedule.msDate) AS moimScheduleDay "
		   		+ "FROM moimschedule "
		   		+ "where moimNum = ?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setInt(1, num);
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   mjDay = rs.getString(1);
		   }
	   } catch (Exception e) {
		   e.printStackTrace();
	   } finally {
		   pool.freeConnection(con, pstmt, rs);
	   }
	   return mjDay;
   }
   
   //모임일정에서 '월' 가져오기
   public String moimScheduleMon(int num) {
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   String sql = null;
	   String mmDay = null;
	   try {
		   con = pool.getConnection();
		   sql = "SELECT EXTRACT(month  FROM msDate) as mon "
		   		+ "FROM moimschedule "
		   		+ "where moimNum = ?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setInt(1, num);
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   mmDay = rs.getString(1);
		   }
	   } catch (Exception e) {
		   e.printStackTrace();
	   } finally {
		   pool.freeConnection(con, pstmt, rs);
	   }
	   return mmDay;
   }
   
   //모임일정의 요일 추출하기
   public String moimScheduleDayName(int num) {
	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	   String sql = null;
	   String mjDayName = null;
	   try {
		   con = pool.getConnection();
		   sql = "SELECT CASE DAYOFWEEK(msDate)"
		   		+ "    WHEN 1 THEN '일요일'"
		   		+ "    WHEN 2 THEN '월요일'"
		   		+ "    WHEN 3 THEN '화요일'"
		   		+ "    WHEN 4 THEN '수요일'"
		   		+ "    WHEN 5 THEN '목요일'"
		   		+ "    WHEN 6 THEN '금요일'"
		   		+ "    WHEN 7 THEN '토요일'"
		   		+ "END AS day_name "
		   		+ "FROM moimschedule "
		   		+ "where moimNum = ?";
		   pstmt = con.prepareStatement(sql);
		   pstmt.setInt(1, num);
		   rs = pstmt.executeQuery();
		   if(rs.next()) {
			   mjDayName = rs.getString(1);
		   }
	   } catch (Exception e) {
		   e.printStackTrace();
	   } finally {
		   pool.freeConnection(con, pstmt, rs);
	   }
	   return mjDayName;
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
    
    //모임에서 가입한 전체 멤버 이름,소개,프로필사진 가져오기
    public Vector<MemberBean> moimScheduleAllMember(int num) {
       Connection con = null;
       PreparedStatement pstmt = null;
       ResultSet rs = null;
       String sql = null;
       Vector<MemberBean> moimAllMemvlist = new Vector<MemberBean>();
       try {
          con = pool.getConnection();
          sql = "select m.memberImg , m.memberName , m.memberProfile "
          		+ "from member m inner join moimmember m2 ON m.memberId = m2.memberId "
          		+ "where m2.moimNum = ?";
          pstmt = con.prepareStatement(sql);
          pstmt.setInt(1, num);
          rs = pstmt.executeQuery();
          while(rs.next()) {
             MemberBean mbean = new MemberBean();
             mbean.setMemberImg(rs.getString(1));
             mbean.setMemberName(rs.getString(2));
             mbean.setMemberProfile(rs.getString(3));
             moimAllMemvlist.addElement(mbean);
          }
       } catch (Exception e) {
          e.printStackTrace();
       } finally {
          pool.freeConnection(con, pstmt, rs);
       }
       return moimAllMemvlist;
    }
    
    //같은 모임에서 다른 스케줄일때 구별해서 가져오기
    public Vector<ScheduleJoinBean> scheduleJoinMsvList(int moimNum) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ScheduleJoinBean> scheduleJoinMsvList = new Vector<ScheduleJoinBean>();
		try {
			con = pool.getConnection();
			sql = "select * "
				+ "from schedulejoin "
				+ "where moimNum = ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, moimNum);
			rs = pstmt.executeQuery();
			while(rs.next()) {
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
   
}