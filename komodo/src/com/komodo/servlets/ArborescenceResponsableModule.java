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
 * Servlet implementation class ArborescenceResponsableModule
 */
@WebServlet("/ArborescenceResponsableModule")
public class ArborescenceResponsableModule extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE          = "/arborescenceResponsableModule.jsp";  
	public static final String INFO         = "nomGrille";   
	public static final String INFO_GRILLE_ID         = "grilleTabId";   
	public static final String INFO_GRILLE_NOM         = "grilleTabNom"; 
	public static final String INFO_GROUPE_NOM        = "groupeTabNom";
	public static final String INFO_GROUPE_ID         = "groupeTabId";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArborescenceResponsableModule() 
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
        Statement statementSec = null;
	    ResultSet compteGrille = null;
	    conn.getConnection();
	    try 
        {
			statement = conn.getConnection().createStatement();
			compteGrille = statement.executeQuery( "SELECT id_grille, Nom_grille FROM grille_de_competence_app;" );
			
			ArrayList<String> grilleTabId = new ArrayList<String>();
			ArrayList<String> grilleTabNom = new ArrayList<String>();
			while (compteGrille.next())
			{
				String grilleId = compteGrille.getString( "id_grille" );
				String grilleNom = compteGrille.getString( "Nom_grille" );
				grilleTabId.add(grilleId);
				System.out.print("aff id : "+grilleId);
				grilleTabNom.add(grilleNom);
				System.out.print("aff nom : "+grilleNom);
			}
			request.setAttribute(INFO_GRILLE_ID, grilleTabId);
			request.setAttribute(INFO_GRILLE_NOM, grilleTabNom);
        }catch (SQLException e) 
        {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      //controleur
      		conn.sendList( "Promo", "grille_de_competence_app", "1=1 ORDER BY id_grille", "is",request);
      		if(request.getParameter("sql")!=null){//gestion de l'arborescence
      			
      			/*gestion de l'arborescence*/
      			
      			//faux cookie pour l'exemple
      			int monIdUtilisateur=1;
      			
      			try 
      	        {
      	        	
      	        	/* Connexion à la base de données. */
      				statement = conn.getConnection().createStatement();
      				statementSec = conn.getConnection().createStatement();
      			compteGrille = statement.executeQuery( "SELECT id_groupe, Nom FROM groupe;" );
    			
    			ArrayList<String> groupeTabId = new ArrayList<String>();
    			ArrayList<String> groupeTabNom = new ArrayList<String>();
    			while (compteGrille.next())
    			{
    				String groupeId = compteGrille.getString( "id_groupe" );
    				String groupeNom = compteGrille.getString( "Nom" );
    				groupeTabId.add(groupeId);
    				System.out.print("aff id : "+groupeId);
    				groupeTabNom.add(groupeNom);
    				System.out.print("aff nom : "+groupeNom);
    			}
    			request.setAttribute(INFO_GROUPE_ID, groupeTabId);
    			request.setAttribute(INFO_GROUPE_NOM, groupeTabNom);
      	        }catch (SQLException e) 
      	        {
      				// TODO Auto-generated catch block
      				e.printStackTrace();
      			}
      			//preparation donnes app
      			//String promo=request.getParameter("promo");
      			String role=request.getParameter("role");
      			
      			if(role.contains("Autre"))
      			{
      				conn.sendList("Promo", "grille_de_competence_app", "1=1 ORDER BY id_grille", "promos",request);
      				conn.sendList("Nom_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "apps",request);
      				conn.sendList("id_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "apps_id",request);
      			}
      			else if(role.contains("Tuteur"))
      			{
      				List<String> l3 = conn.sendList("idGrilleAPP", "groupe", "idTuteur="+monIdUtilisateur, "tmp3", request);
      				conn.sendListById("Promo", "grille_de_competence_app", "id_grille", l3, "promos", request);
      				conn.sendListById("Nom_grille", "grille_de_competence_app", "id_grille", l3, "apps", request);
      				conn.sendListById("id_grille", "grille_de_competence_app", "id_grille", l3, "apps_id", request);
      			}
      			else if(role.contains("Client"))
      			{
      				List<String> l3 = conn.sendList("idGrilleAPP", "groupe", "idClient="+monIdUtilisateur, "tmp3", request);
      				conn.sendListById("Promo", "grille_de_competence_app", "id_grille", l3, "promos", request);
      				conn.sendListById("Nom_grille", "grille_de_competence_app", "id_grille", l3, "apps", request);
      				conn.sendListById("id_grille", "grille_de_competence_app", "id_grille", l3, "apps_id", request);
      			}
      			
      			//preparation donnes groupe
      			String app=request.getParameter("app");
      			List<String> l1 = conn.sendList("idEleve", "lie2", "idGrilleComp="+app, "tmp1",request);
      			List<String> l2 = conn.sendListById("idGroupe", "appartient", "idEleve", l1, "tmp2", request);
      			//donnes groupe
      			conn.sendListById("Nom", "groupe", "id_groupe", l2, "groupes", request);
      			conn.sendListById("id_groupe", "groupe", "id_groupe", l2, "groupes_id", request);
      			
      			
      			//conn.sendList("Nom", "groupe", "1=1 ORDER BY id_groupe", "groupes",request);
      			//conn.sendList("id_groupe", "groupe", "1=1 ORDER BY id_groupe", "groupes_id",request);
      			
      			//preparation donnes eleves
      			String groupe=request.getParameter("groupe");
      			List<String> l = conn.sendListRelation("id_utilisateur", "appartient", "eleves", "idGroupe", "idEleve", "id_utilisateur", groupe, "tmp", request);
      			conn.sendListById("Nom", "utilisateur", "id", l, "eleves", request);
      			conn.sendListById("id", "utilisateur", "id", l, "eleves_id", request);
      			
      			
      		}
        
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
