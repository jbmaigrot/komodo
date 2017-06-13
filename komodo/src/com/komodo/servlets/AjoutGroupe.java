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
		conn.getConnection();
		
		conn.sendList("id_groupe", "groupe", "1=1 ORDER BY id_groupe", "groupeTabId",request);
		conn.sendList("Nom", "groupe", "1=1 ORDER BY id_groupe", "groupeTabNom",request);
		
		conn.sendList("id_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "grilleTabId",request);
		conn.sendList("Nom_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "grilleTabNom",request);
		
		conn.sendList("id", "utilisateur", "Type='professeur'", "profs_id", request);
		conn.sendList("Nom", "utilisateur", "Type='professeur'", "profs_nom", request);
		conn.sendList("Prenom", "utilisateur", "Type='professeur'", "profs_prenom", request);
		int nbProfs = conn.compte("id", "`utilisateur` WHERE Type='professeur'");
		conn.sendList("id_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "app_id", request);
		conn.sendList("Nom_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "app_nom", request);
		conn.sendList("Promo", "grille_de_competence_app", "1=1 ORDER BY id_grille", "app_promo", request);
		int nbAPP = conn.compte("id_grille", "grille_de_competence_app");
			System.out.println("nbAPP"+nbAPP);
		request.setAttribute("nombre_profs", nbProfs);
		request.setAttribute("nb_app", nbAPP);
			
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

		ConnectBDD conn = new ConnectBDD();
		
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
			conn.getConnection();
			conn.insertGroup("groupe", "Nom", "idClient", "idTuteur", "idGrilleAPP", nom_groupe, id_client, id_tuteur, id_APP);
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
        doGet(request,response);
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
