package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.co.acorn.dto.BookDto;
import kr.co.acorn.util.ConnLocator;

public class BookDao {
	// singleton
	private static BookDao single;
	private BookDao() {
		
	}
	public static BookDao getInstance() {
		if(single == null) {
			single = new BookDao();
		}
		return single;
	}
	
	
	private void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if(rs!=null) rs.close();
			if(ps!=null) ps.close();
			if(con!=null) con.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int getMaxRows() {
		int maxRows = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("SELECT COUNT(b_no) ");
			sql.append("FROM p_book ");
			
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				int index = 0;
				maxRows = rs.getInt(++index);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
		}
		
		return maxRows;
	}
	
	// get Max index Number
		public int getMaxNo() {
			int maxNo = 0;
			
			Connection con = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			try {
				con = ConnLocator.getConnection();
				
				StringBuffer sql = new StringBuffer();
				sql.append("SELECT IFNULL(MAX(b_no)+1,1) FROM p_book ");
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
	
	public ArrayList<BookDto> select() {
		ArrayList<BookDto> list = new ArrayList<BookDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT b_no, b_wantedNo, b_applicId, b_content, b_regDate, b_bookStart, b_bookEnd, b_isConfirm ");
			sql.append("FROM p_book ");
			sql.append("ORDER BY b_no ");
			
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int index = 0;
				int no = rs.getInt(++index);
				int wantedNo = rs.getInt(++index);				
				String applicId = rs.getString(++index);
				String content = rs.getString(++index);
				String regDate =rs.getString(++index);
				String bookStart =rs.getString(++index);
				String bookEnd =rs.getString(++index);
				Boolean isConfirm = rs.getBoolean(++index);
				
				BookDto dto = new BookDto(no, wantedNo, applicId, content, regDate, bookStart, bookEnd, isConfirm);
				
				list.add(dto);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
		}
		
		return list;
	}
	
	public JSONArray selectJson(int wantedNumber) {
		JSONArray list = new JSONArray();
		JSONObject obj = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT b_no, b_wantedNo, b_applicId, b_content, b_regDate, b_bookStart, b_bookEnd, b_isConfirm ");
			sql.append("FROM p_book ");
			sql.append("WHERE b_wantedNo = ? ");
			sql.append("ORDER BY b_no ");
			ps = con.prepareStatement(sql.toString());
			int index = 0;
			ps.setInt(++index, wantedNumber);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				int no = rs.getInt(++index);
				int wantedNo = rs.getInt(++index);				
				String applicId = rs.getString(++index);
				String content = rs.getString(++index);
				String regDate =rs.getString(++index);
				String bookStart =rs.getString(++index);
				String bookEnd =rs.getString(++index);
				Boolean isConfirm = rs.getBoolean(++index);
				
				obj = new JSONObject();
				
				obj.put("no", no);
				obj.put("wantedNo", wantedNo);
				obj.put("applicId", applicId);
				obj.put("content", content);
				obj.put("regDate", regDate);
				obj.put("bookStart", bookStart);
				obj.put("bookEnd", bookEnd);
				obj.put("isConfirm", isConfirm);
				
				list.add(obj);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
		}
		
		return list;
	}
	
	
	public boolean insert(BookDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO p_book(b_no, b_wantedNo, b_applicId, b_content, b_regDate, b_bookStart, b_bookEnd, b_isConfirm) ");
			sql.append("VALUES(?,?,?,?,NOW(),?,?,?) ");
			
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setInt(++index, dto.getNo());
			ps.setInt(++index, dto.getWantedNo());
			ps.setString(++index, dto.getApplicId());
			ps.setString(++index, dto.getContent());
			ps.setString(++index, dto.getBookStart());
			ps.setString(++index, dto.getBookEnd());
			ps.setBoolean(++index, dto.getIsConfirm());
			
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
	
	public boolean delete(int no) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM p_book ");
			sql.append("WHERE b_no = ? ");
			
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setInt(++index, no);
			
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
	
	public boolean update(BookDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE p_book ");
			sql.append("SET b_content = ?, b_bookStart=?, b_bookEnd=? ");
			sql.append("WHERE b_no=? ");
			
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setString(++index, dto.getContent());
			ps.setString(++index, dto.getBookStart());
			ps.setString(++index, dto.getBookEnd());
			
			ps.setInt(++index, dto.getNo());
			
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
	
	public boolean updateConfirm(BookDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE p_book ");
			sql.append("SET b_isConfirm = ? ");
			sql.append("WHERE b_no=? ");
			
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setBoolean(++index, dto.getIsConfirm());
			
			ps.setInt(++index, dto.getNo());
			
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
