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

@WebServlet("/PlanningEleve")
public class PlanningServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE = "/planning_eleve.jsp";
	public static final String INFO_NOM_APP = "nom_app";
    public static final String INFO_NOM_GROUPE = "nom_groupe";
	// Creation planning
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
    public PlanningServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	int numero_groupe = 1;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ConnectBDD conn = new ConnectBDD();
		Statement statement_planning = null;
		Statement statement_groupe = null;
		ResultSet planning = null;
		ResultSet groupe = null;

		String groupe_actif = null;
		String nomAPP = null;
		boolean pas_de_plan = true;
		
		ArrayList<String> plan_id = new ArrayList<String>();
		ArrayList<String> plan_nom = new ArrayList<String>();
		ArrayList<String> plan_description = new ArrayList<String>();
		ArrayList<String> plan_date = new ArrayList<String>();
		ArrayList<String> plan_debut = new ArrayList<String>();
		ArrayList<String> plan_fin = new ArrayList<String>();
		
		/*
		 * Requête

SELECT l6.Date, l6.`Debut`, l6.`Fin`, p.`id_planning`, p.Nom_planning, p.Description FROM `lie6` l6 INNER JOIN `planning` p ON l6.idPlaning=p.id_planning WHERE `idGroupe`=1 ORDER BY Date, Debut, fin
		 */
		try 
		{
			statement_planning = conn.getConnection().createStatement();
			statement_groupe = conn.getConnection().createStatement();
			
			//Récupération du planning - ID GROUPE FIXÉ !!!
			groupe = statement_groupe.executeQuery("SELECT app.Nom_grille, g.Nom Nom_groupe FROM grille_de_competence_app app INNER JOIN groupe g ON app.id_grille=g.idGrilleAPP WHERE id_groupe='"+numero_groupe+"'");
			planning = statement_planning.executeQuery("SELECT l6.Date, l6.`Debut`, l6.`Fin`, p.`id_planning`, p.Nom_planning, p.Description FROM `lie6` l6 INNER JOIN `planning` p ON l6.idPlaning=p.id_planning WHERE `idGroupe`='"+ numero_groupe+"' ORDER BY Date, Debut, fin");
			
			groupe.next();
			nomAPP = groupe.getString( "Nom_grille" );
			groupe_actif = groupe.getString( "Nom_groupe" );
			
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
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}
}
