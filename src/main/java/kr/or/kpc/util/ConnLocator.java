package kr.or.kpc.util;

import java.sql.Connection;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnLocator {
	public static Connection getConnect(){
		//DataSource를 이용해서 Connection 객체를 생성하면 2가지 이점이 있다.
		//1. 드라이브 로드와 DriverManager 약할을 한다.
		//2. ConnectionPool를 사용한다.
		DataSource ds = null;
		Connection con = null;
		
		
		
		try {
			Context context = new InitialContext();
			//java:comp/env/는 고정
			//jdbc/kpc = >context.xml의 name 속성 참조해야함
			ds = (DataSource) context.lookup("java:comp/env/jdbc/kpc");
			//ConnectionPool에 만들어진 Connection 객체를 반환
				con = ds.getConnection();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		}
	return con;
		}
	}


