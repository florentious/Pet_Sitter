package kr.co.acorn.util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


// db �뿰寃곗떆�뿉 媛앹껜
public class ConnLocator {
	
	public static Connection getConnection() throws SQLException{
		DataSource ds = null;
		Connection con = null;
		
		try {
			Context context = new InitialContext();
			ds = (DataSource) context.lookup("java:comp/env/jdbc/acorn");
			con = ds.getConnection();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return con;
	}
	
}
