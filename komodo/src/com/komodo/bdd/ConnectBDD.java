package com.komodo.bdd;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import java.sql.Connection;

public class ConnectBDD {
	
	Connection connexion=null;
	
    public Connection getConnection() {
	    /* Chargement du driver JDBC pour MySQL */
	    try {
	        System.out.println( "Chargement du driver..." );
	        Class.forName( "com.mysql.jdbc.Driver" );
	        System.out.println( "Driver chargé !" );
	    } catch ( ClassNotFoundException e ) {
	    	System.out.println( "Erreur lors du chargement : le driver n'a pas été trouvé dans le classpath ! <br/>"
	                + e.getMessage() );
	    }

	    /* Connexion à la base de données */
	    String url = "jdbc:mysql://localhost/komodo";
	    String utilisateur = "root";
	    String motDePasse = "";
	    
	    try {
	    	System.out.println( "Connexion à la base de données..." );
	        connexion = DriverManager.getConnection( url, utilisateur, motDePasse );
	        System.out.println( "Connexion réussie !" );
	       
	    } catch ( SQLException e ) {
	    	System.out.println( "Erreur lors de la connexion : <br/>"
	                + e.getMessage() );
	    } 
	    return connexion;
    }
    
    public String secure(String s){
		String r=new String();
		r=s.replace("'", "\'");
		r=r.replace("\"", "\'");
		return r;
	}
    
    public String getLine(String SELECT, String FROM, String WHERE, int n){
    		
		SELECT=secure(SELECT);
    	FROM=secure(FROM);
    	WHERE=secure(WHERE);
    	
    	Statement statement = null;
	    ResultSet resultat = null;
	    String r="";
        try {
			statement = connexion.createStatement();
			resultat = statement.executeQuery( "SELECT " + SELECT + " FROM " + FROM + " WHERE " + WHERE +"");
			
			for(int i=0;i<n;i++)
		    	resultat.next();
		    r = resultat.getString(SELECT);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return r;
    }
    
    public List<String> sendList(String SELECT,String FROM,String WHERE,String nom,HttpServletRequest request){
    	
    	SELECT=secure(SELECT);
    	FROM=secure(FROM);
    	WHERE=secure(WHERE);
    	
    	Statement statement = null;
	    ResultSet resultat = null;
	    List<String> values = new ArrayList<String>();
        try {
			statement = connexion.createStatement();
			resultat = statement.executeQuery( "SELECT "+SELECT+" FROM "+FROM+" WHERE "+WHERE );
			System.out.println("SELECT "+SELECT+" FROM "+FROM+" WHERE "+WHERE); 
			while ( resultat.next() ) {
	            String nomGrille = resultat.getString( SELECT );
	            values.add(nomGrille);
	        }
			request.setAttribute( nom, values );
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return values;
    }
    
    public List<String> sendListRelation(String SELECT,String t_relation,String t_cible,String cle_in,String cle_out,String cle_cible,String id,String nom,HttpServletRequest request){
    	return sendList(SELECT,t_cible+","+t_relation,t_relation+"."+cle_in+"="+id+" AND "+t_cible+"."+cle_cible+"="+t_relation+"."+cle_out,nom,request);
    }
    
    public List<String> sendListById(String SELECT, String FROM, String nom_id, List<String> ids,String nom,HttpServletRequest request){
    	String WHERE=new String();
    	for(int i=0;i<ids.size();i++)
    		WHERE=WHERE+nom_id+"="+ids.get(i)+" OR ";
    	WHERE=WHERE+"1=0 ORDER BY "+nom_id;
    	return sendList(SELECT,FROM,WHERE,nom,request);
    }
    
    public void insert(String INSERT_INTO,String attributs,String valeurs){
    	
    	INSERT_INTO=secure(INSERT_INTO);
    	attributs=secure(attributs);
    	valeurs=secure(valeurs);
    	
    	valeurs=valeurs.replace(",", "','");
    	valeurs="'"+valeurs+"'";
    	
    	Statement statement = null;
        try {
			statement = connexion.createStatement();
			//System.out.println("Ca marche");
			statement.executeUpdate( "INSERT INTO "+INSERT_INTO+" ("+attributs+") VALUES ("+valeurs+")" );
			//System.out.println(resultat);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    public void update(String UPDATE,String attribut,String valeur,String WHERE){
    	
    	UPDATE=secure(UPDATE);
    	attribut=secure(attribut);
    	valeur=secure(valeur);
    	WHERE=secure(WHERE);
 
    	
    	Statement statement = null;
        try {
			statement = connexion.createStatement();
			//System.out.println("Ca marche");
			statement.executeUpdate( "UPDATE "+UPDATE+" SET "+attribut+" = '"+valeur+"' WHERE "+WHERE);
			//System.out.println(resultat);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    public void delete(String DELETE_FROM,String WHERE){
    	
    	DELETE_FROM=secure(DELETE_FROM);
    	WHERE=secure(WHERE);
 
    	
    	Statement statement = null;
        try {
			statement = connexion.createStatement();
			//System.out.println("Ca marche");
			statement.executeUpdate( "DELETE FROM "+DELETE_FROM+" WHERE "+WHERE);
			//System.out.println("DELETE FROM "+DELETE_FROM+" WHERE "+WHERE);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
}