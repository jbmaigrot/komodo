package com.komodo.bdd;

import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

public class ConnectBDD 
{
    public Connection getConnection() 
    {
	    /* Chargement du driver JDBC pour MySQL */
	    try 
	    {
	        System.out.println( "Chargement du driver..." );
	        Class.forName( "com.mysql.jdbc.Driver" );
	        System.out.println( "Driver charg� !" );
	    } catch ( ClassNotFoundException e ) 
	    {
	    	System.out.println( "Erreur lors du chargement : le driver n'a pas �t� trouv� dans le classpath ! <br/>"
	                + e.getMessage() );
	    }

	    /* Connexion � la base de donn�es */
	    String url = "jdbc:mysql://localhost/komodo2";
	    String utilisateur = "root";
	    String motDePasse = "";
	    Connection connexion=null;
	    try 
	    {
	    	System.out.println( "Connexion � la base de donn�es..." );
	        connexion = DriverManager.getConnection( url, utilisateur, motDePasse );
	        System.out.println( "Connexion r�ussie !" );
	    } catch ( SQLException e ) 
	    {
	    	System.out.println( "Erreur lors de la connexion : <br/>"
	                + e.getMessage() );
	    } 
	    return connexion;
    }
}