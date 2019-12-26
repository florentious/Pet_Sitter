package kr.co.acorn.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import kr.co.acorn.dto.NoticeDto;
import kr.co.acorn.util.ConnLocator;

public class NoticeDao {
	private static NoticeDao single;

	private NoticeDao() {

	}

	public static NoticeDao getInstance() {

		if (single == null) {

			single = new NoticeDao();

		}

		return single;

	}

	public int getTotalRows() {

		int count = 0;

		Connection con = null;

		PreparedStatement pstmt = null;

		ResultSet rs = null;

		try {

			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("SELECT COUNT(n_no) ");

			sql.append("FROM notice ");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;

			rs = pstmt.executeQuery();

			if (rs.next()) {

				index = 0;

				count = rs.getInt(++index);

			}

		} catch (SQLException e) {

			// TODO Auto-generated catch block

			e.printStackTrace();

		} finally {

			try {

				if (rs != null)
					rs.close();

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			} catch (SQLException e2) {

				// TODO: handle exception

			}

		}

		return count;

	}

	public ArrayList<NoticeDto> select(int start, int len) {

		ArrayList<NoticeDto> list = new ArrayList<NoticeDto>();

		Connection con = null;

		PreparedStatement pstmt = null;

		ResultSet rs = null;

		try {

			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("SELECT n_no, DATE_FORMAT(n_regdate,'%Y/%m/%d'), n_title, n_id ");

			sql.append("FROM notice ");

			sql.append("ORDER BY n_no DESC ");

			sql.append("LIMIT ?, ? ");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;

			pstmt.setInt(++index, start);

			pstmt.setInt(++index, len);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				index = 0;

				int no = rs.getInt(++index);

				String regdate = rs.getString(++index);

				String title = rs.getString(++index);

				String id = rs.getString(++index);

				// String contents = rs.getString(++index);

				list.add(new NoticeDto(no,title,id,regdate, null));

			}

		} catch (SQLException e) {

			// TODO Auto-generated catch block

			e.printStackTrace();

		} finally {

			try {

				if (rs != null)
					rs.close();

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			} catch (SQLException e2) {

				// TODO: handle exception

			}

		}

		return list;

	}

	public int getMaxNextNo() {

		int result = 0;

		Connection con = null;

		PreparedStatement pstmt = null;

		ResultSet rs = null;

		try {

			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("SELECT ifnull(MAX(n_no) + 1 , 1) ");

			sql.append("FROM notice ");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;

			rs = pstmt.executeQuery();

			if (rs.next()) {

				index = 0;

				result = rs.getInt(++index);

			}

		} catch (SQLException e) {

			// TODO Auto-generated catch block

			e.printStackTrace();

		} finally {

			try {

				if (rs != null)
					rs.close();

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			} catch (SQLException e2) {

				// TODO: handle exception

			}

		}

		return result;

	}

	public boolean insert(NoticeDto dto) {

		boolean isSuccess = false;

		Connection con = null;

		PreparedStatement pstmt = null;

		try {

			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("INSERT INTO notice(n_no, n_regdate, n_title, n_id, n_contents) ");

			sql.append("VALUES(?, NOW(), ?, ?, ? ) ");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;
			pstmt.setInt(++index, dto.getNo());
			pstmt.setString(++index, dto.getTitle());
			pstmt.setString(++index, dto.getId());
			pstmt.setString(++index, dto.getContents());

			pstmt.executeUpdate();

			isSuccess = true;

		} catch (SQLException e) {

			// TODO Auto-generated catch block

			e.printStackTrace();

		} finally {

			try {

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			} catch (SQLException e2) {

				// TODO: handle exception

			}

		}

		return isSuccess;

	}

	public boolean update(NoticeDto dto) {

		boolean isSuccess = false;

		Connection con = null;

		PreparedStatement pstmt = null;

		try {

			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("UPDATE notice ");

			sql.append("SET n_regdate=NOW(), n_title=?, n_id=? n_contents ");

			sql.append("WHERE n_no=? ");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;


			pstmt.setString(++index, dto.getTitle());

			pstmt.setString(++index, dto.getId());
			
			pstmt.setString(++index, dto.getContents());
			
			pstmt.setInt(++index, dto.getNo());

			pstmt.executeUpdate();

			isSuccess = true;

		} catch (SQLException e) {

			// TODO Auto-generated catch block

			e.printStackTrace();

		} finally {

			try {

				if (pstmt != null)
					pstmt.close();

				if (con != null)
					con.close();

			} catch (SQLException e2) {

				// TODO: handle exception

			}

		}

		return isSuccess;

	}

	public boolean delete(int n_no) {

		boolean isSuccess = false;

		Connection con = null;

		PreparedStatement pstmt = null;

		try {

			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("DELETE FROM notice WHERE n_no=? ");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;

			pstmt.setInt(++index, n_no);

			pstmt.executeUpdate();

			isSuccess = true;

		} catch (SQLException e) {

			// TODO Auto-generated catch block

			e.printStackTrace();

		} finally {

			try {

				if (pstmt != null)
					pstmt.close();
				if (con != null)
					con.close();

			} catch (SQLException e2) {

				// TODO: handle exception

			}

		}

		return isSuccess;

	}

	public NoticeDto select(int number) {

		NoticeDto dto = null;

		Connection con = null;

		PreparedStatement pstmt = null;

		ResultSet rs = null;

		try {

			con = ConnLocator.getConnection();

			StringBuffer sql = new StringBuffer();

			sql.append("SELECT n_no, n_id, n_title, n_regdate,n_contents ");

			sql.append("FROM notice ");

			sql.append("WHERE n_no = ?");

			pstmt = con.prepareStatement(sql.toString());

			int index = 0;

			pstmt.setInt(++index, number);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				index = 0;

				int no = rs.getInt(++index);

				String id = rs.getString(++index);

				String title = rs.getString(++index);

				String regDate = rs.getString(++index);

				String contents = rs.getString(++index);

				dto = new NoticeDto(no, title, id, regDate, contents);

			}

		} catch (SQLException e) {

			// TODO Auto-generated catch block

			e.printStackTrace();

		} finally {

			try {

				if (rs != null)

					rs.close();

				if (pstmt != null)

					pstmt.close();

				if (con != null)

					con.close();

			} catch (SQLException e2) {

				// TODO: handle exception

			}

		}

		return dto;

	}

}
