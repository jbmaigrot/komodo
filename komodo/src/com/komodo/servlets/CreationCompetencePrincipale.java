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
 * Servlet implementation class CreationCompetencePrincipale
 */
@WebServlet("/CreationCompetencePrincipale")
public class CreationCompetencePrincipale extends HttpServlet {
	
	// Cette classe permet d'afficher le formulaire pour la création de compétence principale
	private static final long serialVersionUID = 1L;
	public static final String VUE          = "/creation_competence_principale.jsp";
	public static final String CHAMP_NOM_COMP_PRIN = "nom_competence_principale";
	public static final String ATT_ERREURS  = "erreurs";
	public static final String ATT_RESULTAT = "resultatForm";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreationCompetencePrincipale() {
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
		ConnectBDD conn = new ConnectBDD();
		conn.getConnection();
		// On récupère le contenu du champ du formulaire nom_competence_principale
		String nomCompPrin = request.getParameter(CHAMP_NOM_COMP_PRIN);
		Map<String, String> erreurs = new HashMap<String, String>();
		String resultatForm;
		// TODO Auto-generated method stub
		
		/* Validation du champ Nom. Vérifier qu'il n'y a pas d'erreur.*/
		try 
		{
			validationNomCompPrin(nomCompPrin);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_NOM_COMP_PRIN, e.getMessage());
		}
		/* On remplit les tables de la base de données si la condition est vérifiée. C'est à dire s'in n'y a aucune erreur trouver précédemment. */
		if ( erreur(erreurs) == false )
		{
			// On insère dans la table modele_comp_prin, dans la colonne nom le contenu de la variable nomCompPrin (contenu du champ du formulaire).
			conn.insertGroup("modele_comp_prin", "Nom", nomCompPrin);
			// On change la valeur du string pour qu'il affiche le bon message lors de la validation du formulaire.
			resultatForm = "Réussite de la création de la compétence principale.";
			// On récupère le contenu de la varibale pour l'utiliser dans la page .jsp
			request.setAttribute( ATT_RESULTAT, resultatForm );
			// On envoie vers la page VUE correspondant ici creation_competence_principale.jsp.
			this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
		} else
		{
			resultatForm = "Échec de la création de la compétence principale.";
			
			// Récupère les erreurs pour l'afficher sur le formulaire dans le cas où une ou plusieurs seraient trouvées.
			request.setAttribute( ATT_ERREURS, erreurs );
			
			request.setAttribute( ATT_RESULTAT, resultatForm );
			doGet(request,response);
		}
	}

	// Fonction pour définir les erreurs possibles lorsque l'utilisateur remplit le champ nom de la compétence principale.
	private void validationNomCompPrin(String nomCompPrin) throws Exception
	{
		if (nomCompPrin != null && nomCompPrin.trim().length() != 0)
		{
			if(nomCompPrin.length() >= 45)
				throw new Exception("Veuilez saisir un nom au plus égal à 45 caractères!");
		}else 
		{
			throw new Exception("Merci de saisir un nom pour cette compétence principale.");
		}
	}
	
	// Fonction utilisé pour savoir si il n'y a aucune erreur dans le formulaire.
	private boolean erreur( Map<String, String> erreurs){
		boolean err = false;
		for (Map.Entry<String,String> e : erreurs.entrySet()){
			// Si au moins une erreur est repéré alors cela signifie que le formulaire ne peut pas être validé.
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