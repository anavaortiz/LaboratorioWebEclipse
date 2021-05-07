package Conector;

import java.sql.*;

public class Conector {
	
	protected String Controlador = "com.mysql.cj.jdbc.Driver";
	protected String url = "jdbc:mysql://localhost/Tienda";
	protected String user = "profesor";
	protected String password = "Pepino76$";
	
	public Connection conn() throws ClassNotFoundException{
		Connection dbConn = null;
		try {
			Class.forName(Controlador);
			dbConn = DriverManager.getConnection(url,user,password);
		} catch (SQLException ex) {
			ex.getMessage();
		}
		return dbConn;
	}

}
