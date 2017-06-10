package com.komodo.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.komodo.bdd.ConnectBDD;

/**
 * Servlet implementation class ArborescenceEleve
 */
@WebServlet("/ArborescenceEleve")
public class ArborescenceEleve extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE          = "/arborescenceEleve.jsp";  
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArborescenceEleve() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
				//Modele
				ConnectBDD conn = new ConnectBDD();
				conn.getConnection();

				//controleur
				//conn.sendList( "DISTINCT Promo", "grille_de_competence_app", "1=1 ORDER BY id_grille", "is",request);
				//if(request.getParameter("sql")!=null){//gestion de l'arborescence
					
					HttpSession session = request.getSession(false);
					String username = (String) session.getAttribute("userName");
					
					String filter=new String();
					List<String> u_tmp = conn.sendList("id", "utilisateur", "NomConnection='"+username+"'", "u_tmp",request);
					filter="id_groupe IN (SELECT idGroupe FROM appartient WHERE idEleve="+u_tmp.get(0)+") AND ";
					conn.sendList("Nom", "groupe", filter+"1=1 ORDER BY id_groupe", "groupes",request);
					conn.sendList("id_groupe", "groupe", filter+"1=1 ORDER BY id_groupe", "groupes_id",request);
					
					String groupe=request.getParameter("groupe");
					List<String> l = conn.sendListRelation("id_utilisateur", "appartient", "eleves", "idGroupe", "idEleve", "id_utilisateur", groupe, "tmp", request);
					conn.sendListById("Nom", "utilisateur", "id", l, "eleves", request);
					conn.sendListById("id", "utilisateur", "id", l, "eleves_id", request);
					
					List<String> l3 = conn.sendList("idGrilleAPP", "groupe", "id_groupe="+groupe, "apps_id", request);
					//conn.sendListById("id_grille", "grille_de_competence_app", "id_grille", l3, "apps_id", request);
					
				//}
					    
				//vue
				this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
