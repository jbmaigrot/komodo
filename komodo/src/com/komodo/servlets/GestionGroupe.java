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
	// Reception
    public static final String ELEVE_AJOUTE = "choix_nouveau";
    // Retour
    public static final String ATT_RESULTAT = "resultat";
    public static final String ATT_ERREURS = "erreurs";
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
  // Creation du formulaire eleve
    public static final String INFO_ALL_ELEVES_ID = "all_id";
    public static final String INFO_ALL_ELEVES_NOM = "all_nom";
    public static final String INFO_ALL_ELEVES_PRENOM = "all_prenom";
    public static final String INFO_ALL_ELEVES_NUMERO = "all_numero";
    public static final String INFO_NOMBRE_ALL = "nb_all";
    // Creation du planning de groupe
    public static final String INFO_PLAN_ID = "plan_id";
    public static final String INFO_PLAN_NOM = "plan_nom";
    public static final String INFO_PLAN_DESCRIPTION = "plan_description";
    public static final String INFO_PLAN_DATE = "plan_date";
    public static final String INFO_PLAN_DEBUT = "heure_debut";
    public static final String INFO_PLAN_FIN = "heure_fin";
    public static final String INFO_NB_PLAN = "nb_plan";

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
	int numero_groupe = 1;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ConnectBDD conn = new ConnectBDD();
		ResultSet TuteurInfo = null;
		ResultSet ClientInfo = null;
		ResultSet listeEleves = null;
		ResultSet AllEleves = null;
		ResultSet planning = null;
		Statement statement_tuteur = null;
		Statement statement_client = null;
		Statement statement_eleves = null;
		Statement statement_tous_eleves = null;
		Statement statement_planning = null;

		String groupe_actif = null;
		String TuteurId = null;
		String TuteurPrenom = null;
		String TuteurNom = null;
		String ClientId = null;
		String ClientPrenom = null;
		String ClientNom = null;
		boolean pas_d_eleves = true;
		boolean pas_d_eleves_tot = true;
		boolean pas_de_plan = true;
		
		String nomAPP = null;
		
		ArrayList<String> listeEleveId = new ArrayList<String>();
		ArrayList<String> listeElevePrenom = new ArrayList<String>();
		ArrayList<String> listeEleveNom = new ArrayList<String>();
		ArrayList<String> listeEleveAnnee = new ArrayList<String>();
		ArrayList<String> listeEleveNumero = new ArrayList<String>();
		ArrayList<String> AllElevesId = new ArrayList<String>();
		ArrayList<String> AllElevesNom = new ArrayList<String>();
		ArrayList<String> AllElevesPrenom = new ArrayList<String>();
		ArrayList<String> AllElevesNum = new ArrayList<String>();
		ArrayList<String> plan_id = new ArrayList<String>();
		ArrayList<String> plan_nom = new ArrayList<String>();
		ArrayList<String> plan_description = new ArrayList<String>();
		ArrayList<String> plan_date = new ArrayList<String>();
		ArrayList<String> plan_debut = new ArrayList<String>();
		ArrayList<String> plan_fin = new ArrayList<String>();
		
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

SELECT l6.Date, l6.`Debut`, l6.`Fin`, p.`id_planning`, p.Nom_planning, p.Description FROM `lie6` l6 INNER JOIN `planning` p ON l6.idPlaning=p.id_planning WHERE `idGroupe`=1 ORDER BY Date, Debut, fin
		 */
		try 
		{
			statement_tuteur = conn.getConnection().createStatement();
			statement_client = conn.getConnection().createStatement();
			statement_eleves = conn.getConnection().createStatement();
			statement_tous_eleves = conn.getConnection().createStatement();
			statement_planning = conn.getConnection().createStatement();
			
			//Récupération du groupe, des profs et des eleves - ID GROUPE FIXÉ !!!
			TuteurInfo = statement_tuteur.executeQuery( "SELECT app.Nom_grille, app.Promo, g.Nom Nom_groupe, u.id, u.Nom Nom_prof, u.Prenom FROM grille_de_competence_app app INNER JOIN groupe g ON app.id_grille=g.idGrilleAPP INNER JOIN utilisateur u ON g.idTuteur=u.id WHERE id_groupe='"+ numero_groupe +"'" );
			ClientInfo = statement_client.executeQuery( "SELECT app.Nom_grille, app.Promo, g.Nom Nom_groupe, u.id, u.Nom Nom_prof, u.Prenom FROM grille_de_competence_app app INNER JOIN groupe g ON app.id_grille=g.idGrilleAPP INNER JOIN utilisateur u ON g.idClient=u.id WHERE id_groupe='"+ numero_groupe +"'" );
			listeEleves = statement_eleves.executeQuery("SELECT g.id_groupe, g.Nom Nom_grille, e.id_utilisateur, e.Numero_eleve, e.Annee, u.Prenom, u.Nom Nom_eleve FROM groupe g INNER JOIN appartient a ON a.idGroupe=g.id_groupe INNER JOIN eleves e ON a.idEleve=e.id_utilisateur INNER JOIN utilisateur u ON u.id= e.id_utilisateur WHERE g.id_groupe='"+ numero_groupe +"' AND a.actif='1' ");
			planning = statement_planning.executeQuery("SELECT l6.Date, l6.`Debut`, l6.`Fin`, p.`id_planning`, p.Nom_planning, p.Description FROM `lie6` l6 INNER JOIN `planning` p ON l6.idPlaning=p.id_planning WHERE `idGroupe`='"+ numero_groupe+"' ORDER BY Date, Debut, fin");
			
			TuteurInfo.next();
			ClientInfo.next();
			
			AllEleves = statement_tous_eleves.executeQuery("SELECT u.id, u.Nom, u.Prenom, e.Numero_eleve, a.idGroupe FROM utilisateur u INNER JOIN eleves e ON e.id_utilisateur=u.id LEFT JOIN appartient a ON a.idEleve=e.id_utilisateur WHERE e.Annee='"+ TuteurInfo.getString( "Promo" ) +"' AND u.id NOT IN (SELECT u.id FROM utilisateur u INNER JOIN eleves e ON e.id_utilisateur=u.id LEFT JOIN appartient a ON a.idEleve=e.id_utilisateur WHERE a.idGroupe='"+ numero_groupe +"')");
			
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
				pas_d_eleves = false;
			}
			if(pas_d_eleves)
			{
				listeEleveId.add(null);
			}
			
			while (AllEleves.next())
			{
				AllElevesId.add(AllEleves.getString( "id" ));
				AllElevesNom.add(AllEleves.getString( "Nom" ));
				AllElevesPrenom.add(AllEleves.getString( "Prenom" ));
				AllElevesNum.add(AllEleves.getString( "Numero_eleve" ));
				pas_d_eleves_tot = false;
			}
			if(pas_d_eleves_tot)
			{
				AllElevesId.add(null);
			}
			while (planning.next())
			{
				plan_id.add(planning.getString( "id_planning" ));
				plan_nom.add(planning.getString( "Nom_planning" ));
				plan_description.add(planning.getString( "Description" ));
				plan_date.add(planning.getString( "Date" ));
				plan_debut.add(planning.getString( "Debut" ));
				plan_fin.add(planning.getString( "Fin" ));
				pas_de_plan= false;
				/* Ajouts : date au format JJ-MM-AAAA (actuellement AAAA-MM-JJ)
				 * 			heures : retirer les secondes
				 * 			Ajouter une description cliquable pour étendre
				 * */
			}
			if(pas_de_plan)
			{
				plan_id.add(null);
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
			request.setAttribute(INFO_ALL_ELEVES_ID, AllElevesId);
			request.setAttribute(INFO_ALL_ELEVES_PRENOM, AllElevesPrenom);
			request.setAttribute(INFO_ALL_ELEVES_NOM, AllElevesNom);
			request.setAttribute(INFO_ALL_ELEVES_NUMERO, AllElevesNum);
			request.setAttribute(INFO_NOMBRE_ALL, (AllElevesId.size()-1) );
			request.setAttribute(INFO_PLAN_ID, plan_id);
			request.setAttribute(INFO_PLAN_NOM, plan_nom);
			request.setAttribute(INFO_PLAN_DESCRIPTION, plan_description);
			request.setAttribute(INFO_PLAN_DATE, plan_date);
			request.setAttribute(INFO_PLAN_DEBUT, plan_debut);
			request.setAttribute(INFO_PLAN_FIN, plan_fin);
			request.setAttribute(INFO_NB_PLAN, (plan_id.size()-1) );
			
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
		
        String nouvel_eleve = request.getParameter(ELEVE_AJOUTE);
        
		ConnectBDD conn = new ConnectBDD();
		Statement statement = null;
		
		// Validations des variables
		try {
			validationNouveau(nouvel_eleve);
		} catch (Exception e) {
			erreurs.put( nouvel_eleve, e.getMessage() );
			fail=true;
		}
		
		if(!fail)
		{
		// Accès BDD
			try {
				statement = conn.getConnection().createStatement();
				statement.executeUpdate("INSERT INTO appartient(idEleve, idGroupe) VALUES ('"+ nouvel_eleve +"', '"+ numero_groupe +"')");
			} catch (SQLException e) {
				e.printStackTrace();
				erreurs_bdd.put( ELEVE_AJOUTE, e.getMessage() );
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
        doGet(request,response);
	}
	
	private void validationNouveau(String id_utilisateur) throws Exception{
		if(id_utilisateur == null){
			throw new Exception( "Selectionnez un élève" );
		}else{
			try {
				Integer.parseInt(id_utilisateur);
			} catch (NumberFormatException e){
				throw new Exception( "Tricheur" );
			}
		}
	};
}
