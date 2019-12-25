package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kr.co.acorn.dto.MemberDto;
import kr.co.acorn.util.ConnLocator;

public class MemberDao {
	// singleton - use just 1 object
	private static MemberDao single;
	private MemberDao() {
	}
	public static MemberDao getInstance() {
		if (single == null) {
			single = new MemberDao();
		}
		return single;
	}
	
	//close re-factoring extract method
	private void close(Connection con, PreparedStatement ps, ResultSet rs) {
		try {
			if(rs!= null) rs.close();
			if(ps!= null) ps.close();
			if(con!= null) con.close();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	
	// check Duplicate id
	public boolean isDuplicateId(String id) {
		boolean isDuplicate = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			
			sql.append("SELECT m_id ");
			sql.append("FROM p_member ");
			sql.append("WHERE m_id = ?");
			
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setString(++index, id);
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				isDuplicate = true;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con, ps, rs);
			
		}
		
		return isDuplicate;
	}
	
	// use log-in session
	public MemberDto getMember(MemberDto dto) {
		MemberDto memberDto = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = ConnLocator.getConnection();
			
			StringBuffer sql = new StringBuffer();
			
			sql.append("SELECT m_id, m_name, m_loc, m_phone, m_pet, m_img_path, m_comment, m_type, m_regdate, m_point, m_point_count ");
			sql.append("FROM p_member ");
			sql.append("WHERE m_id = ? AND m_pwd = PASSWORD(?) ");
			
			ps = con.prepareStatement(sql.toString());
			
			int index = 0;
			ps.setString(++index, dto.getId());
			ps.setString(++index, dto.getPwd());
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				index = 0;
				String id = rs.getString(++index);
				String name = rs.getString(++index);
				String loc = rs.getString(++index);
				String phone = rs.getString(++index);
				String curPet = rs.getString(++index);
				String imgPath = rs.getString(++index);
				String comment = rs.getString(++index);
				byte type = rs.getByte(++index);
				String regDate = rs.getString(++index);
				int point = rs.getInt(++index);
				int pointCount = rs.getInt(++index);
				
				memberDto = new MemberDto(id,name,null,loc,phone,curPet,imgPath,comment,type,regDate,point,pointCount);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(con,ps,rs);
		}
		
		return memberDto;
	
	}
	
	
	
	//CRUD - Insert
	public boolean insert(MemberDto dto) {
		boolean isSuccess = false;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con = ConnLocator.getConnection();
			StringBuffer sql = new StringBuffer();
			sql.append("INSERT INTO member(m_id, PASSWORD(m_pwd), m_name, m_loc, m_phone, m_pet, m_img_path, m_comment, m_type, m_regdate, m_point, m_point_count) ");
			sql.append(" VALUES(?,PASSWORD(?),?,?,?,?,?,?,?,NOW(),0,0) ");
			ps = con.prepareStatement(sql.toString());
			
			// regDate => now , point => must do not control themselves
			int index=0;
			ps.setString(++index, dto.getId());
			ps.setString(++index, dto.getPwd());
			ps.setString(++index, dto.getName());
			ps.setString(++index, dto.getLoc());
			ps.setString(++index, dto.getPhone());
			ps.setString(++index, dto.getCurPet());
			ps.setString(++index, dto.getImgPath());
			ps.setString(++index, dto.getComment());
			ps.setByte(++index, dto.getType());
			
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
