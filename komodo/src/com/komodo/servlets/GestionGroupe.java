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
		ConnectBDD conn = new ConnectBDD();
	    conn.getConnection();
	 	//Récupération du groupe, des profs, du planning et des eleves - ID GROUPE FIXÉ !!!
		conn.recuperationGroupe(numero_groupe, request);
        this.getServletContext().getRequestDispatcher(VUE).forward( request, response );
    }
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String resultat;
        Map<String, String> erreurs = new HashMap<String, String>();
        Map<String, String> erreurs_bdd = new HashMap<String, String>();
        boolean fail=false;
		
        String nouvel_eleve = request.getParameter(ELEVE_AJOUTE);
        
		ConnectBDD conn = new ConnectBDD();
		conn.getConnection();
		
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
			conn.insertGroup("appartient", "idEleve", "idGroupe", nouvel_eleve, ""+numero_groupe);
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
