package com.komodo.servlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.komodo.bdd.ConnectBDD;

/**
 * Servlet implementation class AffichageEleve
 */
@WebServlet("/AffichageTeacher")
public class AffichageTeacher extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE          = "/teacher.jsp";  
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AffichageTeacher() {
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
		if(request.getParameter("eleve")!=null&&request.getParameter("sql")==null){//gestion du contenu (exemple de test : http://localhost:8080/TechnoWeb/AffichageEleve?eleve=1&grille=1&competence=1)
			
			
			if(request.getParameter("modif")!=null){
				if(request.getParameter("cp")!=null){
					conn.update("evalue", "CommentaireProfesseur", request.getParameter("value"), "idEleve="+request.getParameter("eleve")+" AND idComp_Sec_Util="+request.getParameter("modif"));
				}
				else if(request.getParameter("ci")!=null){
					conn.update("evalue", "CommentaireIndividuel", request.getParameter("value"), "idEleve="+request.getParameter("eleve")+" AND idComp_Sec_Util="+request.getParameter("modif"));
				}
				else if(request.getParameter("cg")!=null){
					conn.update("evalue", "CommentaireGroupe", request.getParameter("value"), "idEleve="+request.getParameter("eleve")+" AND idComp_Sec_Util="+request.getParameter("modif"));
				}
				else if(request.getParameter("ev")!=null){
					String l = request.getParameter("modif");
					conn.update("evalue", "Evaluation", request.getParameter("eval"+l), "idEleve="+request.getParameter("eleve")+" AND idComp_Sec_Util="+request.getParameter("modif"));
				}
			}
			
			String grille=request.getParameter("grille");
			List<String> l3 = conn.sendList("idCompPrin", "lie3", "idGrilleComp="+grille+" ORDER BY idGrilleComp", "compprinc_tmp", request);
			conn.sendListById("Nom_competence_principale", "competence_principale", "id_comp", l3, "compprinc", request);
			conn.sendListById("id_comp", "competence_principale", "id_comp", l3, "compprinc_id", request);
			
			String competence=request.getParameter("competence");
			
			String eleve=request.getParameter("eleve");
			String filtre="idEleve="+eleve+" AND idComp_Sec_Util IN (SELECT id_comp_second FROM competence_secondaire WHERE id_comp_princ = "+competence+") ORDER BY idComp_Sec_Util";
			
			List<String> l = conn.sendList("idComp_Sec_Util", "evalue", filtre, "competences",request);
			conn.sendListById("Nom", "competence_secondaire", "id_comp_second", l, "noms", request);
			conn.sendListById("id_comp_second", "competence_secondaire", "id_comp_second", l, "id_noms", request);
			conn.sendList("CommentaireIndividuel", "evalue", filtre, "ci",request);
			conn.sendList("CommentaireGroupe", "evalue", filtre, "cg",request);
			conn.sendList("CommentaireProfesseur", "evalue", filtre, "cp",request);
			conn.sendList("Evaluation", "evalue", filtre, "evaluations",request);
			
			conn.sendListById("Critere", "competence_secondaire", "id_comp_second", l, "criteres", request);
			//List<String> l2 = conn.sendListById("idCritere", "lie5", "idCompSecUtil", l, "criteres_tmp", request);
			//conn.sendListById("Descriptif", "critere", "id_critere", l2, "criteres", request);
		}
		//conn.sendListRelation("Numero_eleve", "appartient", "eleves", "idGroupe", "idEleve", "id_utilisateur", "1", "eleves", request);
		//conn.delete("utilisateur", "1=1");
			    
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
