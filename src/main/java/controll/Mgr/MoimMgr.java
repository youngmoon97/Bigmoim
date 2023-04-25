package controll.Mgr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import controll.DBConnectionMgr;
import model.Bean.MemberBean;
import model.Bean.MoimBean;
import model.Bean.MoimJoinBean;
import model.Bean.MoimMemberBean;
import model.Bean.MoimScheduleBean;

public class MoimMgr {
	DBConnectionMgr pool;
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
	//모임 생성
	public boolean moimInsert(MoimBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = " insert into moim(moimName,moimArea,moimHCount,memberId,moimKakao, "
					+ "categoryNum,moimImg,moimProfile,moimDate,themeNum,taskNum,businessNum, "
					+ "classprice, moimOrclass)  "
					+ "  values (?,?,?,?,?,?,?,?,now(),?,?,?,?,?);";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMoimName());
			pstmt.setString(2, bean.getMoimArea());
			pstmt.setInt(3, bean.getMoimHCount());
			pstmt.setString(4, bean.getMemberId());
			pstmt.setString(5, bean.getMoimKakao());
			pstmt.setInt(6, bean.getCategoryNum());
			pstmt.setString(7, bean.getMoimImg());
			pstmt.setString(8, bean.getMoimProfile());
			pstmt.setInt(9, bean.getThemeNum());
			pstmt.setInt(10, bean.getTaskNum());
			pstmt.setInt(11, bean.getBusinessNum());
			pstmt.setString(12, bean.getClassprice());
			pstmt.setInt(14, bean.getMoimOrclass());
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
	public boolean moimUpdate(MoimBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag=false;
		try {
			con = pool.getConnection();
			sql = "update moim"
				+ "set moinName= ?, moimArea=?, moimKakao=?, categoruNum=?,"
				+ " moimImg=?, moimProfile=?, themeNum=?, taskNum=?, "
				+ "businessNum=?, classprice=?, moimOrclass = ?"
				+ "where moimNum= ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMoimName());
			pstmt.setString(2, bean.getMoimArea());
			pstmt.setString(3, bean.getMoimKakao());
			pstmt.setInt(4, bean.getCategoryNum());
			pstmt.setString(5, bean.getMoimImg());
			pstmt.setString(6, bean.getMoimProfile());
			pstmt.setInt(7, bean.getThemeNum());
			pstmt.setInt(8, bean.getTaskNum());
			pstmt.setInt(9, bean.getBusinessNum());
			pstmt.setString(10, bean.getClassprice());
			pstmt.setInt(11, bean.getMoimOrclass());
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
	public boolean mjInsert(MoimJoinBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into moimjoin(moimNum,memberId,mjDate,mjContent)\r\n"
					+ "values (?,?,now(),?) ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getMoimNum());
			pstmt.setString(2, bean.getMemberId());
			pstmt.setString(3, bean.getMjContent());
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
	//모임멤버리스트->멤버아이디 받아오기
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
	//모임일정생성
	public boolean msInsert(MoimScheduleBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert into moimschedule(msTime,msArea,moimNum,"
				+ "msHCount,memberId,msTitle,msContent) "
				+ "values (?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getMsTime());
			pstmt.setString(2, bean.getMsArea());
			pstmt.setInt(3, bean.getMoimNum());
			pstmt.setInt(4, bean.getMsHCount());
			pstmt.setString(5, bean.getMemberId());
			pstmt.setString(6, bean.getMsTitle());
			pstmt.setString(7, bean.getMsContent());
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
}
