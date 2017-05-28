package com.komodo.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//import java.util.Arrays;
//import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.komodo.bdd.ConnectBDD;

/**
 * Servlet implementation class AjoutGroupe
 */
@WebServlet("/AjoutGroupe")
public class AjoutGroupe extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE = "/ajout_groupe.jsp";
	public static final String APP = "choix_APP";
	public static final String NOM_GROUPE = "nom_groupe";
	public static final String NOM_TUTEUR = "nom_tuteur";
	public static final String NOM_CLIENT = "nom_client";
    public static final String ATT_ERREURS  = "erreurs";
    public static final String ATT_RESULTAT = "resultat";
    public static final String INFO_PROFS_ID = "profs_id";
    public static final String INFO_PROFS_NOM = "profs_nom";
    public static final String INFO_PROFS_PRENOM = "profs_prenom";
    public static final String NOMBRE_PROFS = "nombre_profs";
    public static final String INFO_APP_ID = "app_id";
    public static final String INFO_APP_NOM = "app_nom";
    public static final String INFO_APP_PROMO = "app_promo";
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjoutGroupe() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ConnectBDD conn = new ConnectBDD();
		//Statement statement = null;
		ResultSet listeProfs = null;
		ResultSet listeAPP = null;
		Statement statement = null;
		Statement statement_APP = null;
		
		try 
		{
			statement = conn.getConnection().createStatement();
			statement_APP = conn.getConnection().createStatement();
			//Récupération des utilisateurs "prof"
			listeProfs = statement.executeQuery( "SELECT id, Prenom, Nom FROM utilisateur WHERE Type='professeur';" );
			ArrayList<String> listeProfId = new ArrayList<String>();
			ArrayList<String> listeProfPrenom = new ArrayList<String>();
			ArrayList<String> listeProfNom = new ArrayList<String>();
			while (listeProfs.next())
			{
				listeProfId.add(listeProfs.getString( "id" ));
				listeProfPrenom.add(listeProfs.getString( "Prenom" ));
				listeProfNom.add(listeProfs.getString( "Nom" ));
			}
			//Récuperation des APP
			listeAPP = statement_APP.executeQuery( "SELECT id_grille, Nom_grille, Promo FROM grille_de_competence_app;" );
			ArrayList<String> listeAPPId = new ArrayList<String>();
			ArrayList<String> listeNomGrille = new ArrayList<String>();
			ArrayList<String> listePromo = new ArrayList<String>();
			while (listeAPP.next())
			{
				listeAPPId.add(listeAPP.getString( "id_grille" ));
				listeNomGrille.add(listeAPP.getString( "Nom_grille" ));
				listePromo.add(listeAPP.getString( "Promo" ));
			}
			//Définition des Attributs pour la page jsp
			request.setAttribute(INFO_PROFS_ID, listeProfId);
			request.setAttribute(INFO_PROFS_NOM, listeProfNom);
			request.setAttribute(INFO_PROFS_PRENOM, listeProfPrenom);
			request.setAttribute(NOMBRE_PROFS, (listeProfId.size()-1) );
			request.setAttribute(INFO_APP_ID, listeAPPId);
			request.setAttribute(INFO_APP_NOM, listeNomGrille);
			request.setAttribute(INFO_APP_PROMO, listePromo);
		} catch (SQLException e) 
        {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        this.getServletContext().getRequestDispatcher(VUE).forward( request, response );
    }
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String resultat;
        Map<String, String> erreurs = new HashMap<String, String>();
        Map<String, String> erreurs_bdd = new HashMap<String, String>();
        boolean fail=false;
		
        String id_APP = request.getParameter(APP);
        String nom_groupe = request.getParameter(NOM_GROUPE);
		String id_tuteur = request.getParameter(NOM_TUTEUR);
		String id_client = request.getParameter(NOM_CLIENT);
		
		System.out.println("id APP : "+id_APP);
		System.out.println("tuteur : "+id_tuteur);
		System.out.println("client : "+id_client);
		
		ConnectBDD conn = new ConnectBDD();
		Statement statement = null;
		
		// Validations des variables
		try {
			validationAPP(id_APP);
		} catch (Exception e) {
			erreurs.put( APP, e.getMessage() );
			fail=true;
		}
		try {
			validationGroupe(nom_groupe);
		} catch (Exception e) {
			erreurs.put( NOM_GROUPE, e.getMessage() );
			fail=true;
		}
		try {
			validationClientTuteur(id_tuteur);
		} catch (Exception e) {
			erreurs.put( NOM_TUTEUR, e.getMessage() );
			fail=true;
		}
		try {
			validationClientTuteur(id_client);
		} catch (Exception e) {
			erreurs.put( NOM_CLIENT, e.getMessage() );
			fail=true;
		}
		
		if(!fail)
		{
		// Accès BDD
			try {
				statement = conn.getConnection().createStatement();
				System.out.println("INSERT INTO groupe(Nom, idClient, idTuteur, idGrilleAPP) VALUES ('"+ nom_groupe +"', '"+ id_client +"', '"+ id_tuteur +"', '"+ id_APP +"')");
				statement.executeUpdate("INSERT INTO groupe(Nom, idClient, idTuteur, idGrilleAPP) VALUES ('"+ nom_groupe +"', '"+ id_client +"', '"+ id_tuteur +"', '"+ id_APP +"')");
			} catch (SQLException e) {
				e.printStackTrace();
				erreurs_bdd.put( NOM_GROUPE, e.getMessage() );
			}
		}
		
		// Renvoie des erreurs
		if (erreurs.isEmpty() && erreurs_bdd.isEmpty()) {
			resultat = "Ajout Réussi";
		}else if (erreurs_bdd.isEmpty()) {
			resultat = "Entrée(s) invalide(s)";
		} else {
			resultat = "Une erreur est survenue";
		}
        request.setAttribute( ATT_ERREURS, erreurs );
        request.setAttribute( ATT_RESULTAT, resultat );
        
        	//Transmission
		this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
	}
	
	
	private void validationGroupe(String nom_groupe) throws Exception{
		if(nom_groupe == ""){
			throw new Exception( "Le nom du groupe doit être spécifié" );
		}
		else if ( nom_groupe.trim().length() < 4 ) {
	        throw new Exception( "Le nom du groupe doit contenir au moins 4 caractères." );
	    }
	};
	private void validationClientTuteur(String id_utilisateur) throws Exception{
		if(id_utilisateur == null){
			throw new Exception( "Selectionnez un tuteur et un client parmi les professeurs" );
		}else{
			try {
				Integer.parseInt(id_utilisateur);
			} catch (NumberFormatException e){
				throw new Exception( "Tricheur" );
			}
		}
	};
	private void validationAPP(String id_APP) throws Exception{
		if(id_APP == null){
			throw new Exception( "Selectionnez un APP" );
		} else {
			try {
				Integer.parseInt(id_APP);
			} catch (NumberFormatException e){
				throw new Exception( "Tricheur" );
			}
		}
	};
}
