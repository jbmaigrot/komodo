package com.komodo.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.sql.ResultSet;

import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.komodo.bdd.ConnectBDD;

/**
 * Servlet implementation class CreationGrille
 */
@WebServlet("/CreationGrille")
public class CreationGrille extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	public static final String VUE          = "/creation_grille.jsp";
	public static final String VUE2         = "/AffichageTeacher";
	public static final String INFO = "nomCompPrincip";
	public static final String INFO_COMP_SEC = "nomCompSec";
	public static final String CHAMP_NOM_GRILLE = "nom_grille";
	public static final String CHAMP_PROMO = "promo";
	public static final String ATT_ERREURS  = "erreurs";
	public static final String ATT_RESULTAT = "resultatForm";
	public static final String INFO_GRILLE_ID = "grilleTabId";
	public static final String INFO_GRILLE_NOM = "grilleTabNom";
	public static final String VALIDE = "valide";
	public static final String VALIDE_SEC = "valideSec";
	boolean[] valide;
	boolean[][] valideSec;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreationGrille() 
    {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		//Arrays.fill(valide, false);
		ConnectBDD conn = new ConnectBDD();
        Statement statement = null;
        Statement statementSec = null;
	    ResultSet resultat = null;
	    ResultSet resultatCompSec = null;
	    ResultSet compteGrille = null;
	    ResultSet resultatCompte = null;
	    ResultSet resultatCompteSec =null;
	    ResultSet resultatCompteSecSec = null;
	    conn.getConnection();
	    
	    /* Création de l'objet gérant les requêtes */
        try 
        {
        	
        	/* Connexion à la base de données. */
			statement = conn.getConnection().createStatement();
			statementSec = conn.getConnection().createStatement();
			
			/* Initialisation des deux tableaux de booléens pour l'affichage du contenu lorsque l'on arrive pour la première fois sur ce contrôleur. */
			if(request.getAttribute(ATT_RESULTAT) == null)
			{
			
				resultatCompte = statement.executeQuery("Select count(*) as nbLignes From modele_comp_prin;");
				if(resultatCompte.next())
				{
					
					int nbLignes = resultatCompte.getInt("nbLignes");
					valide = new boolean[nbLignes+1];
				}
				resultatCompteSec = statement.executeQuery("Select count(*) as nbLignes From modele_comp_prin;");
				resultatCompteSecSec = statementSec.executeQuery("Select count(*) as nbLignesSec From modele_comp_sec;");
				resultatCompteSec.next();
				resultatCompteSecSec.next();
				int nbLignes = resultatCompteSec.getInt("nbLignes");
				int nbLignesSec = resultatCompteSecSec.getInt("nbLignesSec");
				valideSec = new boolean[nbLignes+1][nbLignesSec+1];
			}
			compteGrille = statement.executeQuery( "SELECT id_grille, Nom_grille FROM grille_de_competence_app;" );
			ArrayList<String> grilleTabId = new ArrayList<String>();
			ArrayList<String> grilleTabNom = new ArrayList<String>();
			while (compteGrille.next())
			{
				
				String grilleId = compteGrille.getString( "id_grille" );
				String grilleNom = compteGrille.getString( "Nom_grille" );
				grilleTabId.add(grilleId);
				grilleTabNom.add(grilleNom);
			}		
			resultat = statement.executeQuery( "SELECT Nom FROM modele_comp_prin;" );
			
			//System.out.println(resultat);
			List<String> nomCompPrincip = new ArrayList<String>(); 
			List<String> nomCompSec = new ArrayList<String>();
			while ( resultat.next() ) 
			{
				
	            String nomCompPrincipInd = resultat.getString( "Nom" );
	            
	            /* Formatage des données pour affichage dans la page JSP au niveau des compétences principales. */
	            nomCompPrincip.add(nomCompPrincipInd);
	            System.out.println( " nom competence principale = " +nomCompPrincipInd+ "." );
	        }
			
			resultatCompSec = statement.executeQuery( "SELECT Nom FROM modele_comp_sec;" );
			while ( resultatCompSec.next() ) 
			{
				
				String nomCompSecInd = resultatCompSec.getString( "Nom" );
				
				/* Formatage des données pour affichage dans la page JSP au niveau des compétences secondaires. */
		        nomCompSec.add(nomCompSecInd);
		        System.out.println( " nom competence secondaire = " +nomCompSecInd+ "." );
		    }
			request.setAttribute(INFO_GRILLE_ID, grilleTabId);
			request.setAttribute(INFO_GRILLE_NOM, grilleTabNom);
			request.setAttribute(INFO, nomCompPrincip);
			request.setAttribute( INFO_COMP_SEC, nomCompSec );
			request.setAttribute(VALIDE, valide);
			request.setAttribute(VALIDE_SEC, valideSec);
		} catch (SQLException e) 
        {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        /* Exécution d'une requête de lecture */
		this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		String resultatForm;
        Map<String, String> erreurs = new HashMap<String, String>();
		ConnectBDD conn = new ConnectBDD();
		String nomGrille = request.getParameter(CHAMP_NOM_GRILLE);
		String promo = request.getParameter(CHAMP_PROMO);
		Statement statement = null;
		Statement statementSec = null;
		ResultSet resultat =null;
		ResultSet resultSec = null;
		int indiceCompSec = 1;
		int indiceTabCompSec =-1;
		int indiceCritere = 1;
		int indiceTabCritere = -1;
		int indicePonderation = 1;
		int indiceTabPonderation = -1;
		
		/* Validation du champ nom APP */
		try 
		{
			validationNomApp(nomGrille);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_NOM_GRILLE, e.getMessage());
		}
		
		/* Validation du champ promo */
		try 
		{
			validationPromo(promo);
		}catch(Exception e)
		{
			erreurs.put(CHAMP_PROMO, e.getMessage());
		}
		
		try 
		{
			
			/* Ici on remplit des tableaux qui correspondent aux différents éléments du formulaire pour ensuite tester la validation de ces valeurs. */
			statement = conn.getConnection().createStatement();
			statementSec = conn.getConnection().createStatement();
			resultat = statement.executeQuery("Select count(*) as nbLignes From modele_comp_prin;");
			int nbLignes = 0;		
			resultSec = statementSec.executeQuery("Select count(*) as nbLignesSec From modele_comp_sec;");
			int nbLignesSec = 0;
			resultat.next();
			resultSec.next();
			nbLignesSec = resultSec.getInt("nbLignesSec");
			nbLignes = resultat.getInt("nbLignes");
			String[] tabComp = new String[nbLignes+1];
			String[][] tabCompSec = new String[nbLignes+1][nbLignesSec+1];
			String[][] tabCritere = new String[nbLignes+1][nbLignesSec+1];
			String[][] tabPonderation = new String[nbLignes+1][nbLignesSec+1];
			valide = new boolean[nbLignes+1];
			for (int i = 1;i <= nbLignes;i++ )
			{
				tabComp[i] = request.getParameter("tab"+i);
				affichageValidation(tabComp, i, valide);
				System.out.println("valide = "+affichageValidation(tabComp, i, valide));
				System.out.println("tab ="+tabComp[i]);
				if(tabComp[i]!=null)
				{
					for (int j = 1 ; j <= nbLignesSec;j++)
					{
						tabCompSec[i][j] = request.getParameter("compSec"+i+j);
						affichageValidationSec(tabComp, tabCompSec, i, j, valideSec);
						System.out.println("valideSec = "+affichageValidationSec(tabComp, tabCompSec, i, j, valideSec));
						System.out.println("tabSec ="+tabCompSec[i][j]);
						tabCritere[i][j] = request.getParameter("critere"+i+j);
						tabPonderation[i][j] = request.getParameter("ponderation"+i+j);	
					}
				}
			}
			
			/* Validation compétences principales. */
			try
			{
				validationCompPrinc(tabComp);
			}catch(Exception e)
			{
				erreurs.put("tab1", e.getMessage());
			}
			
			/* Validation compétences secondaires. */
			String[] compte = new String[nbLignes+1];
			do
			{
				try
				{
					validationCompSec(tabComp, tabCompSec, nbLignesSec, indiceCompSec);
				}catch(Exception e)
				{
					indiceTabCompSec++;
					compte[indiceTabCompSec] = "compSec"+indiceCompSec+"1";
					erreurs.put( compte[indiceTabCompSec], e.getMessage());
				}
				indiceCompSec++;
			}while(indiceCompSec<=nbLignes);
			request.setAttribute("compte", compte);
			
			/* Validation critères. */
			String[] compteCritere = new String[nbLignes*nbLignesSec+1];
			do
			{ 
				int indiceCritereSecond=1;
				do
				{
					indiceTabCritere++;
					try
					{
						validationCritere(tabCompSec,tabCritere, indiceCritere, indiceCritereSecond, tabComp);
					}catch(Exception e)
					{
						compteCritere[indiceTabCritere] = "critere"+indiceCritere+indiceCritereSecond;
						erreurs.put(compteCritere[indiceTabCritere], e.getMessage());
					}
					indiceCritereSecond++;
				}while(indiceCritereSecond<=nbLignesSec);
				indiceCritere++;
			}while(indiceCritere<=nbLignes);
			request.setAttribute("compteCritere", compteCritere);
			
			/* Validation pondération. */
			String[] comptePonderation = new String[nbLignes*nbLignesSec+1];
			do
			{ 
				int indicePonderationSecond=1;
				do
				{
					indiceTabPonderation++;
					try
					{
						validationPonderation(tabCompSec,tabPonderation, indicePonderation, indicePonderationSecond, tabComp);
					}catch(Exception e)
					{
						comptePonderation[indiceTabPonderation] = "ponderation"+indicePonderation+indicePonderationSecond;
						erreurs.put(comptePonderation[indiceTabPonderation], e.getMessage());
					}
					indicePonderationSecond++;
				}while(indicePonderationSecond<=nbLignesSec);
				indicePonderation++;
			}while(indicePonderation<=nbLignes);
			request.setAttribute("comptePonderation", comptePonderation);
		
			boolean erreur = false;
			for (int i =0; i<erreurs.size();i++){
				if (erreurs.get(i)!=null){
					erreur=true;
				}
			}
		/* On remplit les tables de la base de données si la condition est vérifiée. */
		if ( erreur == false )
		{
			
			statement.executeUpdate("INSERT INTO grille_de_competence_app (Nom_grille, Promo) VALUES ('"+nomGrille+"','"+promo+"')",Statement.RETURN_GENERATED_KEYS);
			ResultSet resIdGrille = statement.getGeneratedKeys();
			for (int c = 1;c <= nbLignes;c++ )
			{
				if (tabComp[c] != null)
				{
					
					System.out.println("tabComp[c]="+tabComp[c]);
					statementSec.executeUpdate("INSERT INTO competence_principale (Nom_competence_principale) VALUES ('"+tabComp[c]+"')",Statement.RETURN_GENERATED_KEYS);
					ResultSet resId = statementSec.getGeneratedKeys();
					if(resId.next())
					{
						for (int d = 1 ; d <= nbLignesSec;d++)
						{
							if (tabCompSec[c][d] != null && tabCritere[c][d] != null && tabPonderation[c][d] != null)
							{
								
								statementSec.executeUpdate("INSERT INTO competence_secondaire (id_comp_princ, Ponderation, Nom) VALUES ('"+resId.getInt(1)+"','"+tabPonderation[c][d]+"','"+tabCompSec[c][d]+"')",Statement.RETURN_GENERATED_KEYS);
								ResultSet resCompSec = statementSec.getGeneratedKeys();
								if (resCompSec.next())
								{
									
									statementSec.executeUpdate("INSERT INTO critere (Descriptif) VALUES ('"+tabCritere[c][d]+"')",Statement.RETURN_GENERATED_KEYS);
									ResultSet resCritere = statementSec.getGeneratedKeys();
									if (resCritere.next())
									{
										
										System.out.println(resCritere.getInt(1));
										statementSec.executeUpdate("INSERT INTO lie5 (idCompSecUtil, idCritere) VALUES ('"+resCompSec.getInt(1)+"','"+resCritere.getInt(1)+"')");
									}
								}
							}
						}
					}
					if(resIdGrille.next())
					{
						
						statementSec.executeUpdate("INSERT INTO lie3 (idGrilleComp, idCompPrin) VALUES ('"+resIdGrille.getInt(1)+"','"+resId.getInt(1)+"')");
					}
				}
			}
			resultatForm = "Réussite de l'inscription.";
			request.setAttribute( ATT_RESULTAT, resultatForm );
            this.getServletContext().getRequestDispatcher( VUE2 ).forward( request, response );
        } else
        {
        	
        	resultatForm = "Échec de l'inscription.";
        	request.setAttribute(VALIDE, valide);
        	request.setAttribute(VALIDE_SEC, valideSec);
        	request.setAttribute( ATT_ERREURS, erreurs );
            request.setAttribute( ATT_RESULTAT, resultatForm );
        	doGet(request, response);
        }
	}catch (SQLException e) 
	{
		
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
	
	private void validationNomApp(String nomApp) throws Exception
	{
		if (nomApp != null && nomApp.trim().length() != 0)
		{
			if(nomApp.length() >= 45)
				throw new Exception("Veuilez saisir un nom moins long !");
		}else 
		{
			throw new Exception("Merci de saisir un nom pour cet APP.");
		}
	}
	
	private void validationPromo(String promo) throws Exception
	{
		if (promo == null)
			throw new Exception("Merci de bien vouloir sélectionner une promotion."); 
	}
	
	private void validationCompPrinc(String[] compPrinc) throws Exception
	{
		int j = 0;
		for(int i = 1;i<compPrinc.length;i++)
		{
			if(compPrinc[i] == null)
			{
				
				j++;
				if(j == compPrinc.length-1)
					throw new Exception("Merci de bien vouloir cocher au moins une compétence principale.");
			}
		}	
	}
	
	private void validationCompSec(String[] compPrinc, String[][] compSecond, int nbLignesSec, int indice) throws Exception
	{
		int k = 0;
		for(int m=1;m<=nbLignesSec;m++)
		{
			if(compSecond[indice][m] == null  && compPrinc[indice] != null)
			{
				
				k++;
				if(k == nbLignesSec)
					throw new Exception("Merci de bien vouloir cocher au moins une compétence secondaire dans la compétence principale "+compPrinc[indice]+".");
			}
		}
	}
	
	private void validationCritere(String [][] compSecond, String[][] critere, int indicePrinc, int indiceSecond, String [] comp) throws Exception
	{
		if(critere[indicePrinc][indiceSecond] != null && critere[indicePrinc][indiceSecond].trim().length() != 0 && compSecond[indicePrinc][indiceSecond]!=null)
		{
			if(critere[indicePrinc][indiceSecond].length() >= 600)
				throw new Exception("Le nombre de caractères est trop long pour le champ critère pour la compétence secondaire "+compSecond[indiceSecond][indicePrinc]+" dans la compétence principale "+comp[indicePrinc]+".");
		}else if(critere[indicePrinc][indiceSecond].trim().length() == 0 && compSecond[indicePrinc][indiceSecond]!=null)
		{
			throw new Exception("Merci de bien vouloir saisir un critère pour la compétence secondaire "+compSecond[indicePrinc][indiceSecond]+" dans la compétence principale "+comp[indicePrinc]+".");
		}
	}
	
	private void validationPonderation(String [][] compSecond, String[][] ponderation,  int indicePrinc, int indiceSecond,String[] comp) throws Exception
	{
		if(ponderation[indicePrinc][indiceSecond] == null && compSecond[indicePrinc][indiceSecond]!=null)
		{
			throw new Exception("Merci de bien vouloir sélectionner une pondération pour la compétence secondaire "+compSecond[indicePrinc][indiceSecond]+" dans la compétence principale "+comp[indicePrinc]+".");
		}
	}
	
	/* Permet de créer une fonction pour l'affichage des compétences econdaires lorsque l'on clique sur une compétence principale. */
	private boolean affichageValidation(String[] compPrincip, int i, boolean[] valide)
	{
		if(compPrincip[i]!=null)
			valide[i] = true;
		else
			valide[i] =false;
		return valide[i];
	}
	
	/* Permet d'afficher les champs critères et pondérations lorsque l'on clique sur une compétence secondaire. */
	private boolean affichageValidationSec(String[] compPrincip, String[][] compSecond, int indicePrinc, int indiceSecond, boolean[][] valideSec)
	{
		if(compPrincip[indicePrinc]!=null && compSecond[indicePrinc][indiceSecond]!=null)
			valideSec[indicePrinc][indiceSecond] = true;
		else
			valideSec[indicePrinc][indiceSecond] = false;
		return valideSec[indicePrinc][indiceSecond];
	}
}