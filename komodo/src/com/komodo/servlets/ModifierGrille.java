package com.komodo.servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
 * Servlet implementation class ModifierGrille
 */
@WebServlet("/ModifierGrille")
public class ModifierGrille extends HttpServlet {
	public static final long serialVersionUID = 1L;
	public static final String VUE                     = "/modification_grille.jsp";
	public static final String VUE2                    = "/ArborescenceResponsableModule";
	public static final String VUE3                    = "/ModifierGrille";
	public static final String GRILLE_ID               = "id";
	public static final String GRILLE_NOM              = "grilleNom";
	public static final String CHAMP_NOM_GRILLE        = "nom_grille";
	public static final String CHAMP_PROMO             = "promo";
	public static final String GRILLE_PROMO            = "grillePromo";
	public static final String RESULTAT_COMP_PRINC     = "resultatNomCompPrincip";
	public static final String RESULTAT_ID_COMP_PRINC  = "resultatIdNomCompPrincip";
	public static final String RESULTAT_COMP_SEC       = "resultatNomCompSec";
	public static final String RESULTAT_ID_COMP_SEC    = "resultatIdNomCompSec";
	public static final String RESULTAT_ID_COMP_SECOND = "resultatIdCompSecond";
	public static final String COMP_PRINC              = "nomCompPrincip";
	public static final String COMP_SEC                = "nomCompSec";
	public static final String CRITERE                 = "resultatCompCritere";
	public static final String PONDERATION             = "resultatCompPonderation";
	public static final String ATT_ERREURS             = "erreurs";
	public static final String ATT_RESULTAT            = "resultatForm";
	public static final String VALIDE                  = "valide";
	public static final String VALIDE_SEC              = "valideSec";
	boolean[] valide;
	boolean[][] valideSec;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModifierGrille() 
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
		Statement statement = null;
		ResultSet resultat = null;
		ResultSet comp = null;
		ResultSet compSec = null;
		ResultSet resultatComp = null;
		ResultSet resultatCompSec = null;
		ResultSet resultatCritere = null;
		ResultSet resultatPonderation = null; 
		ResultSet resultatCompte = null;
		ResultSet resultatCompteSec =null;
		ResultSet resultatCompteSecSec = null;
		Statement statementSec = null;
		String id = request.getParameter(GRILLE_ID);
		String promo = request.getParameter(CHAMP_PROMO);
		System.out.println("id get : "+id);
		System.out.println("id get : "+promo);
		try 
        {
			statement = conn.getConnection().createStatement();
			statementSec= conn.getConnection().createStatement();
			
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
			resultat = statement.executeQuery("Select * From grille_de_competence_app WHERE id_grille="+id+";");
			resultat.next();
			String grilleNom = resultat.getString( "Nom_grille" );
			String grillePromo = resultat.getString( "Promo" );
			comp = statement.executeQuery( "SELECT Nom FROM modele_comp_prin;" );
			List<String> nomCompPrincip = new ArrayList<String>(); 
			List<String> nomCompSec = new ArrayList<String>();
			while ( comp.next() ) 
			{
	            String nomCompPrincipInd = comp.getString( "Nom" );
	            
	            /* Formatage des données pour affichage dans la page JSP au niveau des compétences principales. */
	            nomCompPrincip.add(nomCompPrincipInd);
	            System.out.println( " nom competence principale = " +nomCompPrincipInd+ "." );
	        }
			
			compSec = statement.executeQuery( "SELECT Nom FROM modele_comp_sec;" );
			while ( compSec.next() ) 
			{	
				String nomCompSecInd = compSec.getString( "Nom" );
				
				/* Formatage des données pour affichage dans la page JSP au niveau des compétences secondaires. */
		        nomCompSec.add(nomCompSecInd);
		        System.out.println( " nom competence secondaire = " +nomCompSecInd+ "." );
		    }
			
			resultatComp = statement.executeQuery("Select id_comp, Nom_competence_principale From competence_principale INNER JOIN lie3 ON (competence_principale.id_comp=lie3.idCompPrin) Where idGrilleComp='"+id+"';");
			List<String> resultatNomCompPrincip = new ArrayList<String>();
			List<String> resultatIdNomCompPrincip = new ArrayList<String>();
			while ( resultatComp.next() ) 
			{
				String resultatNomCompInd = resultatComp.getString( "Nom_competence_principale" );
				String resultatIdNomCompInd = resultatComp.getString("id_comp");
				/* Formatage des données pour affichage dans la page JSP au niveau des compétences secondaires. */
				resultatNomCompPrincip.add(resultatNomCompInd);
				resultatIdNomCompPrincip.add(resultatIdNomCompInd);
		    }
			
			resultatCompSec = statement.executeQuery("Select id_comp_second, id_comp_princ, Nom From competence_secondaire Where id_comp_princ in (Select id_comp From competence_principale INNER JOIN lie3 ON (competence_principale.id_comp=lie3.idCompPrin) Where idGrilleComp="+id+");");
			List<String> resultatNomCompSec = new ArrayList<String>();
			List<String> resultatIdNomCompSec = new ArrayList<String>();
			List<String> resultatIdCompSecond = new ArrayList<String>();
			while ( resultatCompSec.next() ) 
			{
				String resultatNomCompSecInd = resultatCompSec.getString( "Nom" );
				String resultatIdNomCompSecInd = resultatCompSec.getString("id_comp_princ");
				String resultatIdCompSecondInd = resultatCompSec.getString("id_comp_second");
				
				/* Formatage des données pour affichage dans la page JSP au niveau des compétences secondaires. */
				resultatNomCompSec.add(resultatNomCompSecInd);
				resultatIdNomCompSec.add(resultatIdNomCompSecInd);
				resultatIdCompSecond.add(resultatIdCompSecondInd);
			}
			
			resultatCritere = statement.executeQuery("Select Critere From competence_secondaire Where id_comp_princ in(Select id_comp From competence_principale INNER JOIN lie3 ON (competence_principale.id_comp=lie3.idCompPrin) Where idGrilleComp="+id+");");
			List<String> resultatCompCritere = new ArrayList<String>();
			while (resultatCritere.next())
			{
				String resultatCompCritereInd = resultatCritere.getString( "Critere" );
				resultatCompCritere.add(resultatCompCritereInd);
			}
			
			resultatPonderation = statement.executeQuery("Select Ponderation From competence_secondaire Where id_comp_princ in(Select id_comp From competence_principale INNER JOIN lie3 ON (competence_principale.id_comp=lie3.idCompPrin) Where idGrilleComp="+id+");");
			List<String> resultatCompPonderation = new ArrayList<String>();
			while (resultatPonderation.next())
			{
				System.out.print("id : "+id);
				System.out.println("result ponderation : "+resultatPonderation.getString( "Ponderation" ));
				String resultatCompPonderationInd = resultatPonderation.getString( "Ponderation" );
				resultatCompPonderation.add(resultatCompPonderationInd);
			}
			
			request.setAttribute(GRILLE_NOM, grilleNom);
			request.setAttribute(GRILLE_PROMO, grillePromo);
			request.setAttribute(GRILLE_ID, id);
			request.setAttribute(RESULTAT_COMP_PRINC, resultatNomCompPrincip);
			request.setAttribute(RESULTAT_ID_COMP_PRINC, resultatIdNomCompPrincip);
			request.setAttribute(COMP_SEC, nomCompSec);
			request.setAttribute(RESULTAT_COMP_SEC, resultatNomCompSec);
			request.setAttribute(RESULTAT_ID_COMP_SEC, resultatIdNomCompSec);
			request.setAttribute(RESULTAT_ID_COMP_SECOND, resultatIdCompSecond);
			request.setAttribute(COMP_PRINC, nomCompPrincip);
			request.setAttribute(CRITERE, resultatCompCritere);
			request.setAttribute(PONDERATION, resultatCompPonderation);
			request.setAttribute(VALIDE, valide);
			request.setAttribute(VALIDE_SEC, valideSec);
			
        }catch (SQLException e) 
        {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.getServletContext().getRequestDispatcher( VUE ).forward( request, response );
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub
		String promo = request.getParameter(CHAMP_PROMO);
		String nomGrille = request.getParameter(CHAMP_NOM_GRILLE);
		Statement statement = null;
		Statement statementSec = null;
		ConnectBDD conn = new ConnectBDD();
		ResultSet resultat = null;
		ResultSet resultSec = null;
		Map<String, String> erreurs = new HashMap<String, String>();
		String id = request.getParameter("id");
		System.out.print("");
		System.out.println("compid post : "+id);
		String resultatForm;
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
			String[] tabCompId = new String[nbLignes+1];
			String[][] tabCompSecId = new String[nbLignes+1][nbLignesSec+1];
			String[][] tabCompSec = new String[nbLignes+1][nbLignesSec+1];
			String[][] tabCritere = new String[nbLignes+1][nbLignesSec+1];
			String[][] tabPonderation = new String[nbLignes+1][nbLignesSec+1];
			valide = new boolean[nbLignes+1];
			valideSec = new boolean[nbLignes+1][nbLignesSec+1];
			for (int i = 1;i <= nbLignes;i++ )
			{
				tabComp[i] = request.getParameter("tab"+i);
				affichageValidation(tabComp, i, valide);
				tabCompId[i] = request.getParameter("compId"+i);
				System.out.println("tab ="+tabComp[i]);
				System.out.println("tabCompId : "+tabCompId[i]);
				if(tabComp[i]!=null)
				{
					for (int j = 1 ; j <= nbLignesSec;j++)
					{
						tabCompSecId[i][j] = request.getParameter("compSecId"+i+j);
						System.out.println("tabSecId = "+tabCompSecId[i][j]);
						tabCompSec[i][j] = request.getParameter("compSec"+i+j);
						affichageValidationSec(tabComp, tabCompSec, i, j, valideSec);
						System.out.println("tabSec ="+tabCompSec[i][j]);
						tabCritere[i][j] = request.getParameter("critere"+i+j);
						System.out.println("critere ="+tabCritere[i][j]);
						tabPonderation[i][j] = request.getParameter("ponderation"+i+j);	
						System.out.println("tabPonderation ="+tabPonderation[i][j]);
					}
				}
			}
			
			/* Validation compétences principales. */
			try
			{
				validationCompPrinc(tabComp);
			}catch(Exception e)
			{
				System.out.println("Je viens de passer !!!");
				erreurs.put("tab1", e.getMessage());
			}
			
		if(nbLignesSec!=0){
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
		}
			if ( erreur(erreurs) == false )
			{
				statement.executeUpdate("UPDATE grille_de_competence_app set Nom_grille='"+nomGrille+"', Promo='"+promo+"' where id_grille='"+id+"'");
				for (int c = 1;c <= nbLignes;c++ )
				{	
					if (tabComp[c] != null && (tabCompId[c]!=null && !tabCompId[c].equals("")))
					{
						for (int d = 1 ; d <= nbLignesSec;d++)
						{
							System.out.println("tabCompSecId[c][d] = "+tabCompSecId[c][d]+"  tabCompSec[c][d]="+tabCompSec[c][d]);
							if ((tabCompSecId[c][d] != null && !tabCompSecId[c][d].equals("")) && tabCompSec[c][d] != null && tabCritere[c][d] != null && tabPonderation[c][d] != null)
							{
								System.out.println("1er passage !");
								System.out.print("");
								System.out.print("UPDATE competence_secondaire set id_comp_princ='"+tabCompId[c]+"', Ponderation='"+tabPonderation[c][d]+"', Nom='"+tabCompSec[c][d]+"', Critere='"+tabCritere[c][d]+"' where id_comp_second='"+tabCompSecId[c][d]+"'");
								System.out.print("");
								statementSec.executeUpdate("UPDATE competence_secondaire set id_comp_princ='"+tabCompId[c]+"', Ponderation='"+tabPonderation[c][d]+"', Nom='"+tabCompSec[c][d]+"', Critere='"+tabCritere[c][d]+"' where id_comp_second='"+tabCompSecId[c][d]+"'");
							}
							
							if ((tabCompSecId[c][d] == null || tabCompSecId[c][d].equals("")) && tabCompSec[c][d] != null && tabCritere[c][d] != null && tabPonderation[c][d] != null)
							{
								System.out.print("2e Passage !");
								System.out.print("");
								System.out.print("INSERT INTO competence_secondaire (id_comp_princ, Ponderation, Nom, Critere) VALUES ('"+tabCompId[c]+"','"+tabPonderation[c][d]+"','"+tabCompSec[c][d]+"','"+tabCritere[c][d]+"')");
								statementSec.executeUpdate("INSERT INTO competence_secondaire (id_comp_princ, Ponderation, Nom, Critere) VALUES ('"+tabCompId[c]+"','"+tabPonderation[c][d]+"','"+tabCompSec[c][d]+"','"+tabCritere[c][d]+"')");
							}
							
							if ((tabCompSecId[c][d] != null && !tabCompSecId[c][d].equals("")) && tabCompSec[c][d] == null ){
								System.out.println("3e Passage !");
								System.out.println("");
								System.out.println("DELETE FROM competence_secondaire where id_comp_second='"+tabCompSecId[c][d]+"'");
								statementSec.executeUpdate("DELETE FROM competence_secondaire where id_comp_second='"+tabCompSecId[c][d]+"'");
							}
						}
						
					}
					if(tabComp[c] != null && (tabCompId[c]==null || tabCompId[c].equals("")))
					{
						System.out.println("4e Passage !");
						System.out.println("");
						System.out.println("INSERT INTO competence_principale (Nom_competence_principale) VALUES ('"+tabComp[c]+"')");
						statementSec.executeUpdate("INSERT INTO competence_principale (Nom_competence_principale) VALUES ('"+tabComp[c]+"')",Statement.RETURN_GENERATED_KEYS);
						ResultSet resId = statementSec.getGeneratedKeys();
						if(resId.next())
						{
							for (int d = 1 ; d <= nbLignesSec;d++)
							{
								if (tabCompSec[c][d] != null && tabCritere[c][d] != null && tabPonderation[c][d] != null)
								{
									System.out.println("5e Passage !");
									System.out.println("");
									System.out.println("INSERT INTO competence_secondaire (id_comp_princ, Ponderation, Nom, Critere) VALUES ('"+resId.getInt(1)+"','"+tabPonderation[c][d]+"','"+tabCompSec[c][d]+"','"+tabCritere[c][d]+"')");
									statementSec.executeUpdate("INSERT INTO competence_secondaire (id_comp_princ, Ponderation, Nom, Critere) VALUES ('"+resId.getInt(1)+"','"+tabPonderation[c][d]+"','"+tabCompSec[c][d]+"','"+tabCritere[c][d]+"')");
								}
							}		
							statementSec.executeUpdate("INSERT INTO lie3 (idGrilleComp, idCompPrin) VALUES ('"+id+"','"+resId.getInt(1)+"')");
						}
					}
					if(tabComp[c] == null && (tabCompId[c]!=null && !tabCompId[c].equals(""))){
						System.out.println("6e Passage !");
						System.out.println("");
						System.out.println("DELETE FROM competence_principale where id_comp='"+tabCompId[c]+"'");
						statementSec.executeUpdate("DELETE FROM competence_principale where id_comp='"+tabCompId[c]+"'");
					}
				}
				
				resultatForm = "Réussite de la modification.";
				request.setAttribute( ATT_RESULTAT, resultatForm );
				this.getServletContext().getRequestDispatcher( VUE2 ).forward( request, response );
			}else{
				System.out.println("tototototototototottotottototototototototototototo !");
				resultatForm = "Échec de la modification.";
				request.setAttribute(VALIDE, valide);
	        	request.setAttribute(VALIDE_SEC, valideSec);
				request.setAttribute( ATT_RESULTAT, resultatForm );
				request.setAttribute( ATT_ERREURS, erreurs );
				doGet(request,response);
			}
		}catch(Exception e){
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
