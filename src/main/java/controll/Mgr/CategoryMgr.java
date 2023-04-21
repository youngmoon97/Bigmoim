package controll.Mgr;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import com.mysql.cj.xdevapi.Result;

import controll.DBConnectionMgr;
import model.Bean.MoimCategoryBean;

public class CategoryMgr {
	DBConnectionMgr pool;
	public CategoryMgr() {
		pool = DBConnectionMgr.getInstance();
	}
	//리스크가져오기
	public Vector<MoimCategoryBean> categoryList(){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MoimCategoryBean> vlist = new Vector<MoimCategoryBean>();
		try {
			con = pool.getConnection();
			sql = "select * from moimcategory";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MoimCategoryBean bean = new MoimCategoryBean();
				bean.setCategoryNum(rs.getInt(1));
				bean.setCategoryName(rs.getString(2));
				bean.setCategoruImg(rs.getString(3));
				vlist.addElement(bean);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	public String categoryName(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		String name = null;
		try {
			con = pool.getConnection();
			sql = "select categoryName from moimcategory where categoryNum =? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				name = rs.getString("categoryName");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return name;
	}
	//카테고리 이미지 받기(모임상세에서)
	   public MoimCategoryBean categoryImg(int num) {
		      Connection con = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      String sql = null;
		      String Img = null;
		      MoimCategoryBean bean = new MoimCategoryBean();
		      try {
		         con = pool.getConnection();
		         sql = "select moimcategory.categoryImg "
		               + "from moim inner join moimcategory ON moim.categoryNum = moimcategory.categoryNum "
		               + "where moimNum = ?";
		         pstmt = con.prepareStatement(sql);
		         pstmt.setInt(1, num);
		         rs = pstmt.executeQuery();
		         
		         if(rs.next()) {
		            bean.setCategoruImg(rs.getString(1));
		         }
		      } catch (Exception e) {
		         e.printStackTrace();
		      } finally {
		         pool.freeConnection(con, pstmt, rs);
		      }
		      return bean;
		   }
	
	
}
