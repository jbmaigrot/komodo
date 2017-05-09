package com.komodo.bdd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LoginBDD {
	
    public static boolean validate(String name, String pass) {        
        boolean status = false;
        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        String url = "jdbc:mysql://cpg.sharethepool.ovh:443/komodo";
        String dbName = "form";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "komodo";
        String password = "password";
        try {
            Class.forName(driver).newInstance();
            conn = DriverManager
                    .getConnection(url + dbName, userName, password);

            pst = conn
                    .prepareStatement("SELECT * FROM UTILISATEUR where user=? and password=?");
            pst.setString(1, name);
            pst.setString(2, pass);
            
            rs = pst.executeQuery();
            status = rs.next();

        } catch (Exception e) {
            System.out.println(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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
    
    public static String GetType(String name, String pass) {
    	Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        String type =  null;

        String url = "jdbc:mysql://cpg.sharethepool.ovh:443/komodo";
        String dbName = "form";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "komodo";
        String password = "password";
        try {
            Class.forName(driver).newInstance();
            conn = DriverManager
                    .getConnection(url + dbName, userName, password);

            pst = conn
                    .prepareStatement("SELECT Type FROM UTILISATEUR where user=? and password=?");
            pst.setString(1, name);
            pst.setString(2, pass);
            
            rs = pst.executeQuery();
            type = rs.getString("Type");
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
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
        return type;
    	
    }
    
    
}
