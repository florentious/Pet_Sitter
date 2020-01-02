package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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
	
	public ArrayList<BookDto> select() {
		ArrayList<BookDto> list = new ArrayList<BookDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT b_no, b_sitterId, b_applicId, b_content, b_regDate, b_bookStart, b_bookEnd, b_isConfirm ");
			sql.append("FROM p_book ");
			sql.append("ORDER BY b_no DESC ");
			
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				int index = 0;
				int no = rs.getInt(++index);
				String sitterId = rs.getString(++index);
				String applicId = rs.getString(++index);
				String content = rs.getString(++index);
				String regDate =rs.getString(++index);
				String bookStart =rs.getString(++index);
				String bookEnd =rs.getString(++index);
				Boolean isConfirm = rs.getBoolean(++index);
				
				BookDto dto = new BookDto(no, sitterId, applicId, content, regDate, bookStart, bookEnd, isConfirm);
				
				list.add(dto);
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
		}
		
		return list;
	}
	
	
	
	
	
	
}
