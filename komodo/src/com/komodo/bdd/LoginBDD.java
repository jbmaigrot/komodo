package com.komodo.bdd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class LoginBDD {
	
    public static String validate(String name, String pass) {        
        String status = null;
        ConnectBDD conn = new ConnectBDD();
        Statement pst = null;
        ResultSet rs = null;

        try {
            
            pst = conn.getConnection().createStatement();
                       
            rs = pst.executeQuery("SELECT * FROM utilisateur where NomConnection='"+name+"' and MotDePasse='"+pass+"'");
            if(rs.next()){
            	status = rs.getString("Type");
            	}
        } catch (Exception e) {
            System.out.println(e);
        } finally {

            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return status;
    }
    
//    public static String GetType(String name, String pass) {
//    	Connection conn = null;
//        PreparedStatement pst = null;
//        ResultSet rs = null;
//        String type =  null;
//
//        String url = "jdbc:mysql://localhost/Komodo";
//        String driver = "com.mysql.jdbc.Driver";
//        String userName = "root";
//        String password = "";
//        try {
//            Class.forName(driver).newInstance();
//            conn = DriverManager
//                    .getConnection(url , userName, password);
//
//            pst = conn
//                    .prepareStatement("SELECT * FROM UTILISATEUR where NomConnection=? and MotDePasse=?");
//            pst.setString(1, name);
//            pst.setString(2, pass);
//            
//            rs = pst.executeQuery();
//            type = rs.getString("Type");
//        } catch (Exception e) {
//            System.out.println(e);
//        } finally {
//            if (conn != null) {
//                try {
//                    conn.close();
//                } catch (SQLException e) {
//                    e.printStackTrace();
//                }
//            }
//            if (pst != null) {
//                try {
//                    pst.close();
//                } catch (SQLException e) {
//                    e.printStackTrace();
//                }
//            }
//            if (rs != null) {
//                try {
//                    rs.close();
//                } catch (SQLException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//        return type;
//    	
//    }
    
    
}
