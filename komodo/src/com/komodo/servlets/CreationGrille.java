package com.komodo.servlets;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.sql.ResultSet;

import java.sql.SQLException;

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
	public static final String VUE2         = "/ArborescenceResponsableModule";
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
	public static final String CACHE = "cache";
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
		ConnectBDD conn = new ConnectBDD();
	    conn.getConnection();
        
			/* Initialisation des deux tableaux de bool�ens pour l'affichage du contenu lorsque l'on arrive pour la premi�re fois sur ce contr�leur. */
			if(request.getAttribute(ATT_RESULTAT) == null)
			{
				int nbLignes = conn.compte("*", "modele_comp_prin");
				valide = new boolean[nbLignes+1];
				int nbLignesSec = conn.compte("*", "modele_comp_sec");
				valideSec = new boolean[nbLignes+1][nbLignesSec+1];
			}
			
			conn.sendList("id_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "grilleTabId",request);
			conn.sendList("Nom_grille", "grille_de_competence_app", "1=1 ORDER BY id_grille", "grilleTabNom",request);
			
			conn.sendList("id_groupe", "groupe", "1=1 ORDER BY id_groupe", "groupeTabId",request);
			conn.sendList("Nom", "groupe", "1=1 ORDER BY id_groupe", "groupeTabNom",request);
			conn.sendList("Nom", "modele_comp_prin", "1=1 ORDER BY idModCompPrin", "nomCompPrincip",request);
			
			conn.sendList("Nom", "modele_comp_sec", "1=1 ORDER BY idModCompSec", "nomCompSec",request);
			
			request.setAttribute(VALIDE, valide);
			request.setAttribute(VALIDE_SEC, valideSec);
			
        /* Ex�cution d'une requ�te de lecture */
		
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
		int indiceCompSec = 1;
		int indiceTabCompSec =-1;
		int indiceCritere = 1;
		int indiceTabCritere = -1;
		int indicePonderation = 1;
		int indiceTabPonderation = -1;
		conn.getConnection();
		
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
			
			/* Ici on remplit des tableaux qui correspondent aux diff�rents �l�ments du formulaire pour ensuite tester la validation de ces valeurs. */
			// On compte le nombre de ligne dans la table modele_comp_prin 
			int nbLignes = conn.compte("*","modele_comp_prin");
			System.out.println("nbLignes : "+nbLignes);
			// On compte le nombre de ligne dans la table modele_comp_sec
			int nbLignesSec = conn.compte("*","modele_comp_sec");
			System.out.println("nbLignesSec : "+nbLignes);
			
			// On se sert des diff�rentes nombre trouver pour d�finir la taille des diff�rents tableaux qui contiendront les valeurs.
			String[] tabComp = new String[nbLignes+1];
			String[][] tabCompSec = new String[nbLignes+1][nbLignesSec+1];
			String[][] tabCritere = new String[nbLignes+1][nbLignesSec+1];
			String[][] tabPonderation = new String[nbLignes+1][nbLignesSec+1];
			// Ces deux tableaux vont permettre d'afficher o� non le contenu des comp�tences principales et respectivement les comp�tences secondaires coch�es dans le formulaire en affichant true pour les valeurs coch�es 
			// et false dans le cas contraire.
			valide = new boolean[nbLignes+1];
			valideSec = new boolean[nbLignes+1][nbLignesSec+1];
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
			
			/* Validation table modeleComp. */
			try
			{
				validationModeleComp(nbLignes);
			}catch(Exception e){
				erreurs.put("tab1", e.getMessage());
			}
			
			/* Validation comp�tences principales. */
			try
			{
				validationCompPrinc(tabComp);
			}catch(Exception e)
			{
				erreurs.put("tab1", e.getMessage());
			}
			
			if(nbLignes != 0 )
			{	
				try
				{
					validationModeleCompSec(nbLignesSec);
				}catch(Exception e)
				{
					erreurs.put("tab1", e.getMessage());
				}
				
				/* Validation comp�tences secondaires. */
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
				
				if (nbLignesSec != 0)
				{
					/* Validation crit�res. */
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
			
					/* Validation pond�ration. */
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
				}
			}
			
			/* On remplit les tables de la base de donn�es si la condition est v�rifi�e. */
			if ( erreur(erreurs) == false )
			{
				String ponderationJug = "1";
				String critereJug = "Regroupement g�n�ral des diff�rentes comp�tences secondaires de cette comp�tence principale.";
				String jugement = "Jugement global";
				ResultSet resIdGrille = conn.insertGroup("grille_de_competence_app","Nom_grille","Promo",nomGrille,promo);
				//conn.insert("grille_de_competence_app","Promo",promo);
				System.out.println("etape0");
				try {
					if (resIdGrille.next())
					{
						System.out.println("etape1");
						for (int c = 1;c <= nbLignes;c++ )
						{
							if (tabComp[c] != null)
							{	
								ResultSet resId = conn.insertGroup("competence_principale","Nom_competence_principale",tabComp[c]);
								if(resId.next())
								{
									System.out.println("etape2");
									for (int d = 1 ; d <= nbLignesSec;d++)
									{
										if (tabCompSec[c][d] != null && tabCritere[c][d] != null && tabPonderation[c][d] != null)
										{
											conn.insertGroup("competence_secondaire","id_comp_princ","Ponderation","Nom","Critere",resId.getString(1),tabPonderation[c][d],tabCompSec[c][d],tabCritere[c][d]);
										}
									}	
									conn.insertGroup("lie3","idGrilleComp","idCompPrin",resIdGrille.getString(1),resId.getString(1));
									conn.insertGroup("competence_secondaire", "id_comp_princ","Ponderation","Nom","Critere", resId.getString(1), ponderationJug, jugement, critereJug);
								}
							}
						}
						
					}
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				resultatForm = "R�ussite de l'inscription.";
				request.setAttribute( ATT_RESULTAT, resultatForm );
				this.getServletContext().getRequestDispatcher( VUE2 ).forward( request, response );
			} else
			{
				resultatForm = "�chec de l'inscription.";
				request.setAttribute(VALIDE, valide);
				request.setAttribute(VALIDE_SEC, valideSec);
				request.setAttribute( ATT_ERREURS, erreurs );
				request.setAttribute( ATT_RESULTAT, resultatForm );
				doGet(request,response);
			}
	}
	
	// Fonction pour v�rifier si il y a bien des comp�tences principales dans la table modele_com_prin
	private void validationModeleComp(int nbLignes) throws Exception
	{
		if (nbLignes == 0)
			throw new Exception("Veuilez ajouter au moins une comp�tence principale dans la base de donn�es !");
	}
	
	// Fonction pour v�rifier si il y a bien des comp�tences secondaires dans la table modele_comp_sec
	private void validationModeleCompSec(int nbLignesSec) throws Exception
	{
		if (nbLignesSec==0)
			throw new Exception("Veuilez ajouter au moins une comp�tence secondaire dans la base de donn�es !");
	}
	
	// Fonction pour v�rifier si le nombre de caract�res est correcte.
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
	
	// Fonction permettant de v�rifier si le champ promo est bien remplit, qu'une ann�e a �t� choisit.
	private void validationPromo(String promo) throws Exception
	{
		if (promo == null)
			throw new Exception("Merci de bien vouloir s�lectionner une promotion."); 
	}
	
	// Fonction permettant de v�rifier qu'au moins une comp�tence principale a �t� coch�e.
	private void validationCompPrinc(String[] compPrinc) throws Exception
	{	
		int j = 0;
		for(int i = 1;i<compPrinc.length;i++)
		{
			if(compPrinc[i] == null)
			{			
				j++;
				if(j == compPrinc.length-1)
					throw new Exception("Merci de bien vouloir cocher au moins une comp�tence principale.");
			}
		}	
	}
	
	// Fonction permettant de v�rifier qu'au moins une comp�tence secondaire a �t� coch�e.
	private void validationCompSec(String[] compPrinc, String[][] compSecond, int nbLignesSec, int indice) throws Exception
	{
		int k = 0;
		for(int m=1;m<=nbLignesSec;m++)
		{
			if(compSecond[indice][m] == null  && compPrinc[indice] != null)
			{			
				k++;
				if(k == nbLignesSec)
					throw new Exception("Merci de bien vouloir cocher au moins une comp�tence secondaire dans la comp�tence principale "+compPrinc[indice]+".");
			}
		}
	}
	
	// Fonction permettant de v�rifier que le nombre de caract�res est correct.
	private void validationCritere(String [][] compSecond, String[][] critere, int indicePrinc, int indiceSecond, String [] comp) throws Exception
	{
		if(critere[indicePrinc][indiceSecond] != null && critere[indicePrinc][indiceSecond].trim().length() != 0 && compSecond[indicePrinc][indiceSecond]!=null)
		{
			if(critere[indicePrinc][indiceSecond].length() >= 600)
				throw new Exception("Le nombre de caract�res est trop long pour le champ crit�re pour la comp�tence secondaire "+compSecond[indiceSecond][indicePrinc]+" dans la comp�tence principale "+comp[indicePrinc]+".");
		}else if(critere[indicePrinc][indiceSecond].trim().length() == 0 && compSecond[indicePrinc][indiceSecond]!=null)
		{
			throw new Exception("Merci de bien vouloir saisir un crit�re pour la comp�tence secondaire "+compSecond[indicePrinc][indiceSecond]+" dans la comp�tence principale "+comp[indicePrinc]+".");
		}
	}
	
	// Fonction permettant de v�rifier que le champ pond�ration est remplit.
	private void validationPonderation(String [][] compSecond, String[][] ponderation,  int indicePrinc, int indiceSecond,String[] comp) throws Exception
	{
		if(ponderation[indicePrinc][indiceSecond] == null && compSecond[indicePrinc][indiceSecond]!=null)
		{
			throw new Exception("Merci de bien vouloir s�lectionner une pond�ration pour la comp�tence secondaire "+compSecond[indicePrinc][indiceSecond]+" dans la comp�tence principale "+comp[indicePrinc]+".");
		}
	}
	
	/* Permet de cr�er une fonction pour l'affichage des comp�tences secondaires lorsque l'on clique sur une comp�tence principale. */
	private boolean affichageValidation(String[] compPrincip, int i, boolean[] valide)
	{
		if(compPrincip[i]!=null)
			valide[i] = true;
		else
			valide[i] =false;
		return valide[i];
	}
	
	/* Permet d'afficher les champs crit�res et pond�rations lorsque l'on clique sur une comp�tence secondaire. */
	private boolean affichageValidationSec(String[] compPrincip, String[][] compSecond, int indicePrinc, int indiceSecond, boolean[][] valideSec)
	{
		if(compPrincip[indicePrinc]!=null && compSecond[indicePrinc][indiceSecond]!=null)
			valideSec[indicePrinc][indiceSecond] = true;
		else
			valideSec[indicePrinc][indiceSecond] = false;
		return valideSec[indicePrinc][indiceSecond];
	}
	
	// Permet d'obtenir une condition pour savoir si la Map erreurs contient des erreurs et si c'est le cas retourne true sinon false. 
	// Cela permet d'obtenir une condition permettant de savoir si on peut ins�rer ou non les valeurs rentr�es dans le formulaire
	// dans la base de donn�es.
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