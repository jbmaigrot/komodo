package com.komodo.servlets;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.komodo.bdd.ConnectBDD;

/**
 * Servlet implementation class CreationUtilisateur
 */
@WebServlet("/CreationUtilisateur")
public class CreationUtilisateur extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public static final String VUE2         = "/ArborescenceResponsableModule";
	public static final String VUE          = "/creation_utilisateur.jsp";
	public static final String CHAMP_NOM = "nom_utilisateur";
	public static final String CHAMP_PRENOM = "prenom_utilisateur";
	public static final String CHAMP_AGE = "age";
	public static final String CHAMP_TYPE = "type";
	public static final String CHAMP_NOM_CONNEXION = "identifiant";
	public static final String CHAMP_MOT_DE_PASSE = "mot_de_passe";
	public static final String ATT_ERREURS  = "erreurs";
	public static final String ATT_RESULTAT = "resultatForm";
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreationUtilisateur() {
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
		
		String nom = request.getParameter(CHAMP_NOM);
		String prenom = request.getParameter(CHAMP_PRENOM);
		String age = request.getParameter(CHAMP_AGE);
		String type = request.getParameter(CHAMP_TYPE);
		String nomConnexion = request.getParameter(CHAMP_NOM_CONNEXION);
		String motDePasse = request.getParameter(CHAMP_MOT_DE_PASSE);
		Map<String, String> erreurs = new HashMap<String, String>();
		String resultatForm;
	
		/* Validation du champ nom utilisateur */
		try 
		{
			validationNomUtilisateur(nom);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_NOM, e.getMessage());
		}
		
		/* Validation du champ prénom utilisateur */
		try 
		{
			validationPrenomUtilisateur(prenom);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_PRENOM, e.getMessage());
		}
		
		/* Validation du champ age utilisateur */
		try 
		{
			validationAgeUtilisateur(age);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_AGE, e.getMessage());
		}
		
		/* Validation du champ type */
		try 
		{
			validationTypeUtilisateur(type);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_TYPE, e.getMessage());
		}
		
		/* Validation du champ nom de connexion */
		try 
		{
			validationIdentifiantUtilisateur(nomConnexion);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_NOM_CONNEXION, e.getMessage());
		}
		
		/* Validation du champ mot de passe */
		try 
		{
			validationMotDePasseUtilisateur(motDePasse);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_MOT_DE_PASSE, e.getMessage());
		}
		
		if ( erreur(erreurs) == false )
		{
			MessageDigest md;
			try {
				md = MessageDigest.getInstance("SHA-256");
				md.update(motDePasse.getBytes("UTF-8")); // Change this to "UTF-16" if needed
				byte[] digest = md.digest();
				String mdp = getHexString(digest);
				//String mdp = new String( digest , "Cp1252" );
				System.out.print("mot de passe : "+mdp);
				conn.insertGroup("utilisateur","Nom","Prenom","Age","Type","NomConnection","MotDePasse",nom,prenom,age,type,nomConnexion,mdp);
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			resultatForm = "Réussite de l'ajout de l'utilisateur.";
			request.setAttribute( ATT_RESULTAT, resultatForm );
			this.getServletContext().getRequestDispatcher( VUE2 ).forward( request, response );
		}else
			{
				resultatForm = "Échec de l'ajout.";
				request.setAttribute( ATT_ERREURS, erreurs );
				request.setAttribute( ATT_RESULTAT, resultatForm );
				doGet(request,response);
			}
		}
	
	private void validationNomUtilisateur(String nom) throws Exception
	{
		if (nom != null && nom.trim().length() != 0)
		{
			if(nom.length() >= 45)
				throw new Exception("Veuilez saisir un nom au plus égal à 45 caractères !");
		}else 
		{
			throw new Exception("Merci de saisir un nom pour cet utilisateur.");
		}
	}

	private void validationPrenomUtilisateur(String prenom) throws Exception
	{
		if (prenom != null && prenom.trim().length() != 0)
		{
			if(prenom.length() >= 45)
				throw new Exception("Veuilez saisir un prénom au plus égal à 45 caractères !");
		}else 
		{
			throw new Exception("Merci de saisir un prénom pour cet utilisateur.");
		}
	}
	
	private void validationAgeUtilisateur(String age) throws Exception
	{
		if (age == null)
		{
				throw new Exception("Merci de bien vouloir sélectionner un âge !");
		}
	}
	
	private void validationTypeUtilisateur(String type) throws Exception
	{
		if (type == null)
		{
				throw new Exception("Merci de bien vouloir sélectionner un type !");
		}
	}
	private void validationIdentifiantUtilisateur(String identifiant) throws Exception
	{
		if (identifiant != null && identifiant.trim().length() != 0)
		{
			if(identifiant.length() >= 45)
				throw new Exception("Veuilez saisir un identifiant au plus égal à 32 caractères !");
		}else 
		{
			throw new Exception("Merci de saisir un identifiant pour cet utilisateur.");
		}
	}
	
	private void validationMotDePasseUtilisateur(String MotDePasse) throws Exception
	{
		if (MotDePasse != null && MotDePasse.trim().length() != 0)
		{
			if(MotDePasse.length() < 4)
				throw new Exception("Veuilez saisir un mot de passe au moins 4 caractères !");
			if(MotDePasse.length() > 20)
				throw new Exception("Veuilez saisir un mot de passe au plus égal à 20 caractères !");
		}else 
		{
			throw new Exception("Merci de saisir un mot de passe pour cet utilisateur.");
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
	
	public String getHexString(byte[] b) {
        String result = "";
        for (int i=0; i < b.length; i++) {
            result += Integer.toString( ( b[i] & 0xff ) + 0x100, 16).substring( 1 );
        }
    return result;
	}
}
