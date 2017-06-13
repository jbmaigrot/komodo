package com.komodo.servlets;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
	public static final String CHAMP_NUMERO_ELEVE = "numero_eleve";
	public static final String CHAMP_ANNEE = "annee";
	public static final String CHAMP_SPECIALITE = "specialite";
	
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
		ConnectBDD conn = new ConnectBDD();
	    conn.getConnection();
	    conn.sendList("id_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "grilleTabId",request);
		conn.sendList("Nom_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "grilleTabNom",request);
	    
		conn.sendList("id_groupe", "groupe", "1=1 ORDER BY id_groupe", "groupeTabId",request);
		conn.sendList("Nom", "groupe", "1=1 ORDER BY id_groupe", "groupeTabNom",request);
	    
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
		String numeroEleve = request.getParameter(CHAMP_NUMERO_ELEVE);
		String annee = request.getParameter(CHAMP_ANNEE);
		String specialite = request.getParameter(CHAMP_SPECIALITE);
		Map<String, String> erreurs = new HashMap<String, String>();
		String resultatForm;
		List<String> tabIdEleve = new ArrayList<String>();
		
		tabIdEleve = conn.sendList("Numero_eleve", "eleves", "1=1 ORDER BY Numero_eleve", "num",request);
		System.out.print("tabIdEleve"+tabIdEleve.get(0));
	
		/* Validation du champ nom utilisateur */
		try 
		{
			validationNomUtilisateur(nom);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_NOM, e.getMessage());
		}
		
		/* Validation du champ pr�nom utilisateur */
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
		//System.out.println("type = "+type);
		if (type!=null && type.equals("eleve")){
			//System.out.println("Integer.parseInt(numeroEleve))"+Integer.parseInt(numeroEleve));
			
			/* Validation du champ num�ro �l�ve. */
			try 
			{
				validationNumeroEleve(numeroEleve, tabIdEleve);
			}catch(Exception e)
			{
				erreurs.put(CHAMP_NUMERO_ELEVE, e.getMessage());
			}
			
			/* Validation du champ ann�e. */
			try 
			{
				validationAnnee(annee);
			}catch(Exception e)
			{
				erreurs.put(CHAMP_ANNEE, e.getMessage());
			}
			
			/* Validation du champ sp�cialit�. */
			try 
			{
				validationSpecialite(specialite);
			}catch(Exception e)
			{
				erreurs.put(CHAMP_SPECIALITE, e.getMessage());
			}
			
		}
		
		if ( erreur(erreurs) == false )
		{
			MessageDigest md;
			try {
				md = MessageDigest.getInstance("SHA-256");
				md.update(motDePasse.getBytes("UTF-8"));
				byte[] digest = md.digest();
				String mdp = getHexString(digest);
				
				System.out.print("mot de passe : "+mdp);
				ResultSet resId = conn.insertGroup("utilisateur","Nom","Prenom","Age","Type","NomConnection","MotDePasse",nom,prenom,age,type,nomConnexion,mdp);
				if (resId.next()){
					if (type.equals("eleve")){
				
						conn.insertGroup("eleves","id_utilisateur","Numero_eleve","Annee","Specialite", resId.getString(1),numeroEleve,annee,specialite);
					}
				}
			} catch (NoSuchAlgorithmException e)
			{
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			resultatForm = "R�ussite de l'ajout de l'utilisateur.";
			request.setAttribute( ATT_RESULTAT, resultatForm );
			this.getServletContext().getRequestDispatcher( VUE2 ).forward( request, response );
		}else
		{
			resultatForm = "�chec de l'ajout.";
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
				throw new Exception("Veuilez saisir un nom au plus �gal � 45 caract�res !");
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
				throw new Exception("Veuilez saisir un pr�nom au plus �gal � 45 caract�res !");
		}else 
		{
			throw new Exception("Merci de saisir un pr�nom pour cet utilisateur.");
		}
	}
	
	private void validationAgeUtilisateur(String age) throws Exception
	{
		if (age == null)
		{
				throw new Exception("Merci de bien vouloir s�lectionner un �ge !");
		}
	}
	
	private void validationTypeUtilisateur(String type) throws Exception
	{
		if (type == null)
		{
				throw new Exception("Merci de bien vouloir s�lectionner un type !");
		}
	}
	private void validationIdentifiantUtilisateur(String identifiant) throws Exception
	{
		if (identifiant != null && identifiant.trim().length() != 0)
		{
			if(identifiant.length() >= 45)
				throw new Exception("Veuilez saisir un identifiant au plus �gal � 32 caract�res !");
		}else 
		{
			throw new Exception("Merci de saisir un identifiant pour cet utilisateur.");
		}
	}
	
	private void validationMotDePasseUtilisateur(String motDePasse) throws Exception
	{
		if (motDePasse != null && motDePasse.trim().length() != 0)
		{
			if(motDePasse.length() < 4)
				throw new Exception("Veuilez saisir un mot de passe au moins �gal � 4 caract�res !");
			if(motDePasse.length() > 20)
				throw new Exception("Veuilez saisir un mot de passe au plus �gal � 20 caract�res !");
		}else 
		{
			throw new Exception("Merci de saisir un mot de passe pour cet utilisateur.");
		}
	}
	
	private void validationNumeroEleve(String numeroEleve, List<String> tabIdEleve) throws Exception
	{
		if (numeroEleve != null && numeroEleve.trim().length() != 0)
		{
			
			if (numeroEleve.matches("-?\\d+")){
				for(int i=0;i<tabIdEleve.size();i++){
					if (tabIdEleve.get(i).equals(numeroEleve)){
						throw new Exception("Ce num�ro �l�ve est d�j� pr�sent dans la base de donn�es !");
					}
				}
				if(numeroEleve.length() < 4)
					throw new Exception("Veuilez saisir un num�ro d'�l�ve au moins �gal � 4 caract�res !");
				if(numeroEleve.length() > 5)
					throw new Exception("Veuilez saisir un num�ro d'�l�ve au plus �gal � 5 caract�res !");
			}else{
				throw new Exception("Veuilez �crire seulement des chiffres, les autres caract�res ne sont pas autoris�s !");
			}
		}else 
		{
			throw new Exception("Merci de saisir un num�ro d'�l�ve.");
		}
	}
	
	private void validationAnnee(String annee) throws Exception
	{
		if (annee == null)
			throw new Exception("Merci de bien vouloir s�lectionner une ann�e."); 
	}
	
	private void validationSpecialite(String specialite) throws Exception
	{
		if (specialite != null && specialite.trim().length() != 0)
		{
			if(specialite.length() < 4)
				throw new Exception("Veuilez saisir une sp�cialit� d'au moins 4 caract�res !");
			if(specialite.length() > 45)
				throw new Exception("Veuilez saisir une sp�cialit� au plus �gal � 45 caract�res !");
		}else 
		{
			throw new Exception("Merci de saisir une sp�cialit� pour cet �l�ve.");
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
