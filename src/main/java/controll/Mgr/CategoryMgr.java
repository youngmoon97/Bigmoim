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