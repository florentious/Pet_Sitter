package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.co.acorn.dto.CommentDto;
import kr.co.acorn.util.ConnLocator;

public class CommentDao {
	//singleton
	private static CommentDao single;
	private CommentDao() {
	}
	public static CommentDao getInstance() {
		if(single == null) {
			single = new CommentDao();
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
	
	// get Max index Number
	public int getMaxNo() {
		int maxNo = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT IFNULL(MAX(c_no)+1,1) FROM p_comment ");
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
	
	public int getTotalRows(int wantedNo) {
		int totalRows = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT COUNT(c_no) ");
			sql.append("FROM p_comment ");
			sql.append("WHERE c_wanted_no = ? ");
			ps = con.prepareStatement(sql.toString());
			int index = 0;
			ps.setInt(++index, wantedNo);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				index = 0;
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
	
	
	
	// CRUD - Select All
	public ArrayList<CommentDto> select(int start, int len) {
		ArrayList<CommentDto> list = new ArrayList<CommentDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT c_no, c_wanted_no, c_member_id, c_comment, c_regdate ");
			sql.append("FROM p_comment ");
			sql.append("ORDER BY c_regdate DESC ");
			sql.append("LIMIT ?,?");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setInt(++index, start);
			ps.setInt(++index, len);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				int no = rs.getInt(++index);
				int wantedNo = rs.getInt(++index);
				String id = rs.getString(++index);
				String comment = rs.getString(++index);
				String regDate = rs.getString(++index);
				
				list.add(new CommentDto(no,wantedNo ,id,comment,regDate));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
			
		}
		
		return list;
	}
	
	public ArrayList<CommentDto> select() {
		ArrayList<CommentDto> list = new ArrayList<CommentDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT c_no, c_wanted_no, c_member_id, c_comment, c_regdate ");
			sql.append("FROM p_comment ");
			sql.append("ORDER BY c_regdate DESC ");
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				int no = rs.getInt(++index);
				int wantedNo = rs.getInt(++index);
				String id = rs.getString(++index);
				String comment = rs.getString(++index);
				String regDate = rs.getString(++index);
				
				list.add(new CommentDto(no,wantedNo ,id,comment,regDate));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
			
		}
		
		return list;
	}
	
	public ArrayList<CommentDto> select(int newWantedNo) {
		ArrayList<CommentDto> list = new ArrayList<CommentDto>();
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT c_no, c_wanted_no, c_member_id, c_comment, c_regdate ");
			sql.append("FROM p_comment ");
			sql.append("WHERE c_wanted_no = ? ");
			sql.append("ORDER BY c_regdate DESC ");
			ps = con.prepareStatement(sql.toString());
			int index = 0;
			
			ps.setInt(++index, newWantedNo);
			
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				index = 0;
				int no = rs.getInt(++index);
				int wantedNo = rs.getInt(++index);
				String id = rs.getString(++index);
				String comment = rs.getString(++index);
				String regDate = rs.getString(++index);
				
				list.add(new CommentDto(no,wantedNo ,id,comment,regDate));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
			
		}
		
		return list;
	}
	
	public JSONArray selectJson() {
		JSONArray item = new JSONArray();	// JSONObject ArrayList
		JSONObject obj = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT c_no, c_wanted_no, c_member_id, c_comment, c_regdate ");
			sql.append("FROM p_comment ");
			sql.append("ORDER BY c_regdate DESC ");
			
			ps = con.prepareStatement(sql.toString());
			
			rs = ps.executeQuery();
			while(rs.next()) {
				int index = 0;
				int no = rs.getInt(++index);
				int wantedNo = rs.getInt(++index);
				String id = rs.getString(++index);
				String comment = rs.getString(++index);
				String regDate = rs.getString(++index);
				
				// item에 넣어서확인
				obj = new JSONObject();
				obj.put("no", no);
				obj.put("wantedNo", wantedNo);
				obj.put("id", id);
				obj.put("comment", comment);
				obj.put("regDate", regDate);
				
				item.add(obj);
				
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
		}
		
		
		
		return item;
	}
	
	public JSONArray selectJson(int newWantedNo) {
		JSONArray item = new JSONArray();	// JSONObject ArrayList
		JSONObject obj = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("SELECT c_no, c_wanted_no, c_member_id, c_comment, c_regdate ");
			sql.append("FROM p_comment ");
			sql.append("WHERE c_wanted_no = ? ");
			sql.append("ORDER BY c_regdate DESC ");
			ps = con.prepareStatement(sql.toString());
			int index = 0;
			ps.setInt(++index, newWantedNo);
			
			
			rs = ps.executeQuery();
			while(rs.next()) {
				index = 0;
				int no = rs.getInt(++index);
				int wantedNo = rs.getInt(++index);
				String id = rs.getString(++index);
				String comment = rs.getString(++index);
				String regDate = rs.getString(++index);
				
				// item에 넣어서확인
				obj = new JSONObject();
				obj.put("no", no);
				obj.put("wantedNo", wantedNo);
				obj.put("id", id);
				obj.put("comment", comment);
				obj.put("regDate", regDate);
				
				item.add(obj);
				
			}
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
		}
		
		
		
		return item;
	}
	
	
	
	//insert
	public boolean insert(CommentDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO p_comment(c_no, c_wanted_no, c_member_id, c_comment, c_regdate ) ");
			sql.append("VALUES(?,?,?,?,NOW() ) ");
			
			ps = con.prepareStatement(sql.toString());
			int index=0;
			ps.setInt(++index, dto.getNo());
			ps.setInt(++index, dto.getWantedNo());
			ps.setString(++index, dto.getId());
			ps.setString(++index, dto.getComment());
			
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
	
	public boolean update(CommentDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("UPDATE p_comment ");
			sql.append("SET c_comment = ? ");
			sql.append("WHERE c_no = ? ");
			
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setString(++index, dto.getComment());
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
	
	// 댓글번호 기준 삭제
	public boolean delete(int no) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM p_comment ");
			sql.append("WHERE c_no=? ");
			
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
	
	// 글번호 기준 삭제(글삭제용
	public boolean deleteWantedNo(int wantedNo) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM p_comment ");
			sql.append("WHERE c_wanted_no=? ");
			
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setInt(++index, wantedNo);
			
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
	
	public boolean deleteFromId(String id) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			sql.append("DELETE FROM p_comment ");
			sql.append("WHERE c_member_id = ? ");
			
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setString(++index, id);
			
			ps.executeUpdate();
			
			
			sql.setLength(0);
			sql.append("DELETE FROM p_comment ");
			sql.append("WHERE c_wantedNo IN (SELECT w_no FROM p_wanted WHERE w_id=?) ");
			
			ps2 = con.prepareStatement(sql.toString());
			index = 0;
			ps2.setString(++index, id);
			ps2.executeUpdate();
			
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
