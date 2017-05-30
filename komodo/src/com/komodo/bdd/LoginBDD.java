package com.komodo.bdd;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
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
        	String hash = sha256(pass);
        	System.out.println(hash);
            pst = conn.getConnection().createStatement();  
            rs = pst.executeQuery("SELECT * FROM utilisateur where NomConnection='"+name+"' and MotDePasse='"+hash+"'");
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
    
    public static String sha256(String base) {
        try{
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(base.getBytes("UTF-8"));
            StringBuffer hexString = new StringBuffer();

            for (int i = 0; i < hash.length; i++) {
                String hex = Integer.toHexString(0xff & hash[i]);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }

            return hexString.toString();
        } catch(Exception ex){
           throw new RuntimeException(ex);
        }
    }
    
    
}
