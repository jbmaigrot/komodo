package com.komodo.servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.komodo.bdd.ConnectBDD;

/**
 * Servlet implementation class AffichageTeacher
 */
@WebServlet("/AffichageTeacher")
public class AffichageTeacher extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	public static final String VUE          = "/teacher.jsp";  
	public static final String INFO         = "nomGrille";   
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AffichageTeacher() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		ConnectBDD conn = new ConnectBDD();
        Statement statement = null; 
	    ResultSet resultat = null;
	    conn.getConnection();
	    try 
        {
			statement = conn.getConnection().createStatement();
			resultat = statement.executeQuery( "SELECT Nom_grille FROM grille_de_competence_app;" );
			List<String> nomGrille = new ArrayList<String>(); 
			while ( resultat.next() ) 
			{
				
	            String nomGrilleUni = resultat.getString("Nom_grille" );
	            
	            /* Formatage des données pour affichage dans la page JSP au niveau des compétences principales. */
	            nomGrille.add(nomGrilleUni);
	            
	            System.out.println( " nom grille = " +nomGrilleUni+ "." );
	        }
			request.setAttribute(INFO, nomGrille);
        }catch(SQLException e){
        	e.printStackTrace();
        };
		 this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
