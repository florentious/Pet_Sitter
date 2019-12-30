package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.acorn.dto.PointDto;
import kr.co.acorn.util.ConnLocator;

public class PointDao {
	private static PointDao single;
	private PointDao() {
	}
	public static PointDao getInstance() {
		if (single == null) {
			single = new PointDao();
		}
		return single;
	}
	
	private void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if (rs != null)
				rs.close();
			if (ps != null)
				ps.close();
			if (con != null)
				con.close();
		} catch (SQLException e) {
			// TODO: handle exception
		}
	}
	
	public PointDto select(String sitterId, String applicId) {
		PointDto dto = null;

		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("SELECT p_regDate ");
			sql.append("FROM p_point_date ");
			sql.append("WHERE p_sitter_id =? AND p_applic_id =? ");

			ps = con.prepareStatement(sql.toString());

			int index = 0;
			ps.setString(++index, sitterId);
			ps.setString(++index, applicId);

			rs = ps.executeQuery();

			if (rs.next()) {
				index = 0;
				String regDate = rs.getString(++index);
				dto = new PointDto(sitterId, applicId, regDate);
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, rs);

		}

		return dto;
		
		
	}
	
	
	public boolean insert(PointDto dto ) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO p_point_date(p_sitter_id, p_applic_id, p_regDate) ");
			sql.append("VALUES(?,?,DATE_ADD(NOW(), INTERVAL 7 DAY)) ");
			ps = con.prepareStatement(sql.toString());
			
			int index=0;
			ps.setString(++index, dto.getSitterId());
			ps.setString(++index, dto.getApplicId());
			
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
