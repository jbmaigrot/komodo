package com.komodo.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.komodo.bdd.ConnectBDD;

/**
 * Servlet implementation class CreationCompetenceSecondaire
 */
@WebServlet("/CreationCompetenceSecondaire")
public class CreationCompetenceSecondaire extends HttpServlet {
	// Cette class permet d'afficher le formulaire pour la création de compétence secondaire.
	private static final long serialVersionUID = 1L;
	public static final String VUE          = "/creation_competence_secondaire.jsp";
	public static final String CHAMP_NOM_COMP_SEC = "nom_competence_secondaire";
	public static final String ATT_ERREURS  = "erreurs";
	public static final String ATT_RESULTAT = "resultatForm";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreationCompetenceSecondaire() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ConnectBDD conn = new ConnectBDD();
		conn.getConnection();
		String nomCompSec = request.getParameter(CHAMP_NOM_COMP_SEC);
		Map<String, String> erreurs = new HashMap<String, String>();
		String resultatForm;
		// TODO Auto-generated method stub
		
		/* Validation du champ Nom */
		try 
		{
			validationNomCompPrin(nomCompSec);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_NOM_COMP_SEC, e.getMessage());
		}
		/* On remplit les tables de la base de données si la condition est vérifiée. */
		if ( erreur(erreurs) == false )
		{
			conn.insertGroup("modele_comp_sec", "Nom", nomCompSec);
			resultatForm = "Réussite de la création de la compétence secondaire !";
			request.setAttribute( ATT_RESULTAT, resultatForm );
		//	request.setAttribute(CACHE, cache);
			this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
		} else
		{
			resultatForm = "Échec de la création de la compétence secondaire !";
			request.setAttribute( ATT_ERREURS, erreurs );
			request.setAttribute( ATT_RESULTAT, resultatForm );
		//	request.setAttribute(CACHE,cache);
			doGet(request,response);
		}
	}

	
	private void validationNomCompPrin(String nomCompPrin) throws Exception
	{
		if (nomCompPrin != null && nomCompPrin.trim().length() != 0)
		{
			if(nomCompPrin.length() >= 45)
				throw new Exception("Veuilez saisir un nom au plus égal à 45 caractères!");
		}else 
		{
			throw new Exception("Merci de saisir un nom pour cette compétence secondaire.");
		}
	}
	
	private boolean erreur( Map<String, String> erreurs){
		boolean err = false;
		for (Map.Entry<String,String> e : erreurs.entrySet()){
			if(e.getValue()!=null){
				err = true;
				return err;
			}else{
				err = false;
			}
		}
		return err;
	}
}