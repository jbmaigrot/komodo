package com.komodo.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
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

@WebServlet("/EditionPlanning")
public class EditionPlanning extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE = "/edition_planning.jsp";

	 /**
     * @see HttpServlet#HttpServlet()
     */
    public EditionPlanning() {
        super();
        // TODO Auto-generated constructor stub
    }

	    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//Création des plannings
		ConnectBDD conn = new ConnectBDD();
		conn.getConnection();
		List<String> listIdApp = new ArrayList<String>();
		List<String> listNomApp = new ArrayList<String>();
		List<Integer> listLength = new ArrayList<Integer>();
		
		listIdApp = conn.sendList("id_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "inp_id_app", request);
		listNomApp = conn.sendList("Nom_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "inp_nom_app", request);
				
		conn.sendList("id_groupe", "groupe", "1=1 ORDER BY idGrilleAPP", "id_all_group", request);
		conn.sendList("Nom", "groupe", "1=1 ORDER BY idGrilleAPP", "nom_all_group", request);
		
		for(int i=0; i<listIdApp.size(); i++)
		{
			if(i!=0)
			{
				int sum = conn.compte("id_groupe", "groupe WHERE idGrilleAPP="+listIdApp.get(i)) + listLength.get(i-1);
				listLength.add(sum);
			} else {
				listLength.add(conn.compte("id_groupe", "groupe WHERE idGrilleAPP="+listIdApp.get(i)));
			}
		}
		
		request.setAttribute("taille_groupes", listLength);
		request.setAttribute( "liste_app_size", listIdApp.size() );
		
		// Liste des plannings
		conn.affichagePlanning(0, true, request);
		
        this.getServletContext().getRequestDispatcher(VUE).forward( request, response );
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("etape 0");
		String id_APP = request.getParameter("choix_app");
        String id_groupe = request.getParameter("groupe_choisi");
		String nom_planning = request.getParameter("nom_plan");
		String descr_planning = request.getParameter("descr_plan");
		String date_planning = request.getParameter("date_plan");
		String time_debut = request.getParameter("time_debut");
		String time_fin = request.getParameter("time_fin");
		ResultSet res_planning;
		int id_planning = 0;
		
		ConnectBDD conn = new ConnectBDD();
		System.out.println(id_APP);
		conn.getConnection();
		res_planning = conn.insertGroup("planning", "Nom_planning", "Description", nom_planning, descr_planning);
		System.out.println("etape 1");
		try {
			System.out.println("étape 2");
			if(res_planning.next()){
				conn.insertGroup("lie6", "idGroupe", "idPlaning", "Date", "Debut", "Fin", id_groupe, res_planning.getString(1), date_planning, time_debut, time_fin);
			}
			//id_planning = res_planning.getInt("id_planning");
			//System.out.println("id_planning " + id_planning);
		} catch (SQLException e) {
		}
		
		//conn.insertGroup("lie6", "idGroupe", "idPlaning", "Date", "Debut", "Fin", id_groupe, String.valueOf(id_planning), date_planning, time_debut, time_fin);
		
		doGet(request,response);
	}
}
