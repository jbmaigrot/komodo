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
@WebServlet("/AffichageEleve")
public class AffichageEleve extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE          = "/eleve.jsp";  
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AffichageEleve() {
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
			
			String grille=request.getParameter("grille");
			List<String> l3 = conn.sendList("idCompPrin", "lie3", "idGrilleComp="+grille+" ORDER BY idGrilleComp", "compprinc_tmp", request);
			conn.sendListById("Nom_competence_principale", "competence_principale", "id_comp", l3, "compprinc", request);
			conn.sendListById("id_comp", "competence_principale", "id_comp", l3, "compprinc_id", request);
			
			String competence=request.getParameter("competence");
			
			String eleve=request.getParameter("eleve");
			//String filtre="idEleve="+eleve+" AND idComp_Sec_Util="+competence+" ORDER BY idComp_Sec_Util";
			List<String> ins = conn.sendList("id_comp_second", "competence_secondaire", "id_comp_princ = "+competence, "ins",request);
			List<String> grrp = conn.sendList("idGroupe", "appartient", "idEleve = "+eleve+" AND idGroupe IN (SELECT id_groupe FROM groupe WHERE idGrilleAPP = "+grille+")", "grrp",request);
			
			String filtre="idEleve="+eleve+" AND idComp_Sec_Util IN (SELECT id_comp_second FROM competence_secondaire WHERE id_comp_princ = "+competence+") ORDER BY idComp_Sec_Util";
			
			List<String> l = conn.sendList("idComp_Sec_Util", "evalue", filtre, "competences_",request);
			for(int i=0;i<ins.size();i++){
				if(l.contains(ins.get(i))==false){
					System.out.println("Manque competence secondaire ["+ins.get(i)+"] pour l'eleve "+eleve+" du groupe "+grrp.get(0));
					conn.insert("evalue", "idEleve, idGroupe, idComp_Sec_Util, Evaluation, CommentaireIndividuel, CommentaireGroupe, CommentaireProfesseur", eleve+","+grrp.get(0)+","+ins.get(i)+",'','','',''");
				}
			}
			l = conn.sendList("idComp_Sec_Util", "evalue", filtre, "competences",request);
			conn.sendListById("Nom", "competence_secondaire", "id_comp_second", l, "noms", request);
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
