package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.WantedDto;
import kr.co.acorn.util.ConnLocator;

public class WantedDao {
	// singleton
	private static WantedDao single;
	private WantedDao() {

	}
	public static WantedDao getInstance() {
		if (single == null) {
			single = new WantedDao();
		}
		return single;
	}
	
	// close extent method
	private void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if(rs!= null) rs.close();
			if(ps!= null) ps.close();
			if(con!= null) con.close();
		} catch (SQLException e) {
			// TODO: handle exception
		}
	}
	
	
	// need to paging
	public int getTotalRows() {
		int totalRows = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(w_no) FROM p_wanted ");
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				int index = 0;
				totalRows = rs.getInt(++index);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
			
		}
		
		return totalRows;
		
	}
	
	// get Max Number
	public int getMaxNo() {
		int maxNo = 1;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT MAX(w_no)+1 FROM p_wanted ");
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				int index = 0;
				maxNo = rs.getInt(++index);
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
			
		}
		
		return maxNo;
		
	}
	
	public WantedDto select(int number) {
		WantedDto dto = null;

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("SELECT w_no, w_title, w_content, W_regDate, w_isEnd, w_id ");
			sql.append("FROM  p_wanted ");
			sql.append("WHERE w_no = ? ");

			ps = con.prepareStatement(sql.toString());

			int index = 0;
			ps.setInt(++index, number);

			rs = ps.executeQuery();

			if (rs.next()) {
				index = 0;
				int no = rs.getInt(++index);
				String title = rs.getString(++index);
				String content = rs.getString(++index);
				String regDate = rs.getString(++index);
				boolean isEnd = rs.getBoolean(++index);
				String id = rs.getString(++index);
				
				dto = new WantedDto(no,title,content,regDate,isEnd,id);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);

		}

		return dto;
		
		
	}
	
	
	
	
	
	// CRUD
	public ArrayList<WantedDto> select(int start, int len) {
		ArrayList<WantedDto> list = new ArrayList<WantedDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT w_no, w_title, w_content, w_regDate, w_isEnd, w_id ");
			sql.append("FROM p_wanted ");
			sql.append("WHERE w_isEnd = TRUE ");
			sql.append("ORDER BY w_no DESC ");
			sql.append("LIMIT ?,?");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setInt(++index, start);
			ps.setInt(++index, len);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				int no = rs.getInt(++index);
				String title = rs.getString(++index);
				String content = rs.getString(++index);
				String regDate = rs.getString(++index);
				boolean isEnd = rs.getBoolean(++index);
				String id = rs.getString(++index);
				
				list.add(new WantedDto(no,title,content,regDate,isEnd,id));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
			
		}
		
		return list;
	}
	
	//CRUD - index myPage(my content)
	public ArrayList<WantedDto> select(int start, int len, String myId) {
		ArrayList<WantedDto> list = new ArrayList<WantedDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT w_no, w_title, w_content, w_regDate, w_isEnd, w_id ");
			sql.append("FROM p_wanted ");
			sql.append("WHERE w_id = ? ");
			sql.append("ORDER BY w_no DESC ");
			sql.append("LIMIT ?,?");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setString(++index, myId);
			ps.setInt(++index, start);
			ps.setInt(++index, len);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				int no = rs.getInt(++index);
				String title = rs.getString(++index);
				String content = rs.getString(++index);
				String regDate = rs.getString(++index);
				boolean isEnd = rs.getBoolean(++index);
				String id = rs.getString(++index);
				
				list.add(new WantedDto(no,title,content,regDate,isEnd,id));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
			
		}
		
		return list;
	}
	
	
	//insert
	public boolean insert(WantedDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO p_wanted(w_no, w_title, w_content, w_regDate, w_isEnd, w_id ) ");
			sql.append("VALUES(?,?,?,NOW(),?,?	 ) ");
			
			ps = con.prepareStatement(sql.toString());
			int index=0;
			ps.setInt(++index, dto.getNo());
			ps.setString(++index, dto.getTitle());
			ps.setString(++index, dto.getContent());
			ps.setBoolean(++index, dto.getIsEnd());
			ps.setString(++index, dto.getId());
			
			ps.executeUpdate();
			
			isSuccess = true;
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,null);
		}
		
		
		
		return isSuccess;
	}
	
	
	
	
}
