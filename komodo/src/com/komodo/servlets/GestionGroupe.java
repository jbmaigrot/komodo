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
@WebServlet("/GestionGroupe")
public class GestionGroupe extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE = "/gestion_groupe.jsp";
	///
	public static final String APP = "choix_APP";
	//public static final String NOM_GROUPE = "nom_groupe";
	public static final String NOM_TUTEUR = "nom_tuteur";
	public static final String NOM_CLIENT = "nom_client";
    public static final String ATT_ERREURS  = "erreurs";
    public static final String ATT_RESULTAT = "resultat";
    ///
    // Creation de la page : groupe
    public static final String INFO_NOM_APP = "nom_app";
    public static final String INFO_NOM_GROUPE = "nom_groupe";
    // Creation de la page : tuteur
    public static final String INFO_TUTEUR_ID = "tuteur_id";
    public static final String INFO_TUTEUR_NOM = "tuteur_nom";
    public static final String INFO_TUTEUR_PRENOM = "tuteur_prenom";
    // Creation de la page : client
    public static final String INFO_CLIENT_ID = "client_id";
    public static final String INFO_CLIENT_NOM = "client_nom";
    public static final String INFO_CLIENT_PRENOM = "client_prenom";
    // Creation de la page : eleve
    public static final String INFO_ELEVES_ID = "eleves_id";
    public static final String INFO_ELEVES_NOM = "eleves_nom";
    public static final String INFO_ELEVES_PRENOM = "eleves_prenom";
    public static final String INFO_ELEVES_ANNEE = "eleves_annee";
    public static final String INFO_ELEVES_NUMERO = "eleves_numero";
    public static final String INFO_NOMBRE_ELEVES = "nb_eleves";

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestionGroupe() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ConnectBDD conn = new ConnectBDD();
		ResultSet TuteurInfo = null;
		ResultSet ClientInfo = null;
		ResultSet listeEleves = null;
		Statement statement_tuteur = null;
		Statement statement_client = null;
		Statement statement_eleves = null;
		/*
		 * Besoin de :
		 * le groupe -->SELECT * FROM groupe WHERE id_groupe='9';

		 * les profs, le groupe et l'APP -->
SELECT app.Nom_grille, g.Nom Nom_groupe, u.id, u.Nom Nom_prof, u.Prenom 
FROM grille_de_competence_app app
INNER JOIN groupe g
ON app.id_grille=g.idGrilleAPP
INNER JOIN utilisateur u
ON g.idTuteur=u.id OR g.idClient=u.id
WHERE id_groupe='9'

		 * les eleves du groupe -->
SELECT g.id_groupe, g.Nom, e.id_utilisateur, e.Numero_eleve, e.Annee, u.Prenom, u.Nom
FROM groupe g
INNER JOIN appartient a 
ON a.idGroupe=g.id_groupe
INNER JOIN eleves e
ON a.idEleve=e.id_utilisateur
INNER JOIN utilisateur u
ON u.id= e.id_utilisateur
WHERE g.id_groupe='9' and a.actif='1' 
		 */
		try 
		{
			statement_tuteur = conn.getConnection().createStatement();
			statement_client = conn.getConnection().createStatement();
			statement_eleves = conn.getConnection().createStatement();
			
			//Récupération du groupe, des profs et des eleves - ID FIXÉ !!!
			TuteurInfo = statement_tuteur.executeQuery( "SELECT app.Nom_grille, g.Nom Nom_groupe, u.id, u.Nom Nom_prof, u.Prenom FROM grille_de_competence_app app INNER JOIN groupe g ON app.id_grille=g.idGrilleAPP INNER JOIN utilisateur u ON g.idTuteur=u.id WHERE id_groupe='9'" );
			ClientInfo = statement_client.executeQuery( "SELECT app.Nom_grille, g.Nom Nom_groupe, u.id, u.Nom Nom_prof, u.Prenom FROM grille_de_competence_app app INNER JOIN groupe g ON app.id_grille=g.idGrilleAPP INNER JOIN utilisateur u ON g.idClient=u.id WHERE id_groupe='9'" );
			listeEleves = statement_eleves.executeQuery("SELECT g.id_groupe, g.Nom Nom_grille, e.id_utilisateur, e.Numero_eleve, e.Annee, u.Prenom, u.Nom Nom_eleve FROM groupe g INNER JOIN appartient a ON a.idGroupe=g.id_groupe INNER JOIN eleves e ON a.idEleve=e.id_utilisateur INNER JOIN utilisateur u ON u.id= e.id_utilisateur WHERE g.id_groupe='9' AND a.actif='1' ");
			
			String groupe_actif = null;
			String TuteurId = null;
			String TuteurPrenom = null;
			String TuteurNom = null;
			String ClientId = null;
			String ClientPrenom = null;
			String ClientNom = null;
			
			String nomAPP = null;
			
			ArrayList<String> listeEleveId = new ArrayList<String>();
			ArrayList<String> listeElevePrenom = new ArrayList<String>();
			ArrayList<String> listeEleveNom = new ArrayList<String>();
			ArrayList<String> listeEleveAnnee = new ArrayList<String>();
			ArrayList<String> listeEleveNumero = new ArrayList<String>();
			
			TuteurInfo.next();
			ClientInfo.next();
			
			nomAPP = TuteurInfo.getString( "Nom_grille" );
			groupe_actif = TuteurInfo.getString( "Nom_groupe" );
			TuteurId = TuteurInfo.getString( "id" );
			TuteurPrenom = TuteurInfo.getString( "Prenom" );
			TuteurNom = TuteurInfo.getString( "Nom_prof" );
			ClientId = ClientInfo.getString( "id" );
			ClientPrenom = ClientInfo.getString( "Prenom" );
			ClientNom = ClientInfo.getString( "Nom_prof" );
			
			while (listeEleves.next())
			{
				listeEleveId.add(listeEleves.getString( "id_utilisateur" ));
				listeElevePrenom.add(listeEleves.getString( "Prenom" ));
				listeEleveNom.add(listeEleves.getString( "Nom_eleve" ));
				listeEleveAnnee.add(listeEleves.getString( "Annee" ));
				listeEleveNumero.add(listeEleves.getString( "Numero_eleve" ));
			}
			
			//Définition des Attributs pour la page jsp
			request.setAttribute(INFO_NOM_APP, nomAPP);
			request.setAttribute(INFO_NOM_GROUPE, groupe_actif);
			request.setAttribute(INFO_TUTEUR_ID, TuteurId);
			request.setAttribute(INFO_TUTEUR_PRENOM, TuteurPrenom);
			request.setAttribute(INFO_TUTEUR_NOM, TuteurNom);
			request.setAttribute(INFO_CLIENT_ID, ClientId);
			request.setAttribute(INFO_CLIENT_PRENOM, ClientPrenom);
			request.setAttribute(INFO_CLIENT_NOM, ClientNom);
			request.setAttribute(INFO_ELEVES_ID, listeEleveId);
			request.setAttribute(INFO_ELEVES_PRENOM, listeElevePrenom);
			request.setAttribute(INFO_ELEVES_NOM, listeEleveNom);
			request.setAttribute(INFO_ELEVES_ANNEE, listeEleveAnnee);
			request.setAttribute(INFO_ELEVES_NUMERO, listeEleveNumero);
			request.setAttribute(INFO_NOMBRE_ELEVES, (listeEleveId.size()-1) );
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
		/*
		String resultat;
        Map<String, String> erreurs = new HashMap<String, String>();
        Map<String, String> erreurs_bdd = new HashMap<String, String>();
        boolean fail=false;
		
        String id_APP = request.getParameter(APP);
        String nom_groupe = request.getParameter(NOM_GROUPE);
		String id_tuteur = request.getParameter(NOM_TUTEUR);
		String id_client = request.getParameter(NOM_CLIENT);

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
        */
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
