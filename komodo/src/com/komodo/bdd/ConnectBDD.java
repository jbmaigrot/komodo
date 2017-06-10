package com.komodo.bdd;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import java.sql.Connection;

public class ConnectBDD {
	
	Connection connexion=null;
	
    public Connection getConnection() {
	    /* Chargement du driver JDBC pour MySQL */
	    try {
	        System.out.println( "Chargement du driver..." );
	        Class.forName( "com.mysql.jdbc.Driver" );
	        System.out.println( "Driver chargé !" );
	    } catch ( ClassNotFoundException e ) {
	    	System.out.println( "Erreur lors du chargement : le driver n'a pas été trouvé dans le classpath ! <br/>"
	                + e.getMessage() );
	    }

	    /* Connexion à la base de données */
	    String url = "jdbc:mysql://localhost/komodo";
	    String utilisateur = "root";
	    String motDePasse = "";
	    try {
	    	System.out.println( "Connexion à la base de données..." );
	        connexion = DriverManager.getConnection( url, utilisateur, motDePasse );
	        System.out.println( "Connexion réussie !" );
	       
	    } catch ( SQLException e ) {
	    	System.out.println( "Erreur lors de la connexion : <br/>"
	                + e.getMessage() );
	    } 
	    return connexion;
    }
    public String secure(String s){
  		String r=new String();
  		r=s.replace("'", "\'");
  		r=r.replace("\"", "\'");
  		return r;
  	}
      
      public String getLine(String SELECT, String FROM, String WHERE, int n){
      		
  		SELECT=secure(SELECT);
      	FROM=secure(FROM);
      	WHERE=secure(WHERE);
      	
      	Statement statement = null;
  	    ResultSet resultat = null;
  	    String r="";
          try {
  			statement = connexion.createStatement();
  			resultat = statement.executeQuery( "SELECT " + SELECT + " FROM " + FROM + " WHERE " + WHERE +"");
  			
  			for(int i=0;i<n;i++)
  		    	resultat.next();
  		    r = resultat.getString(SELECT);
  		} catch (SQLException e) {
  			e.printStackTrace();
  		}
  		
  		return r;
      }
      
      public String sendString(String SELECT,String FROM,String WHERE,String nom,HttpServletRequest request){
        	
        	SELECT=secure(SELECT);
        	FROM=secure(FROM);
        	WHERE=secure(WHERE);
        	
        	Statement statement = null;
    	    ResultSet resultat = null;
            try {
    			statement = connexion.createStatement();
    			resultat = statement.executeQuery( "SELECT "+SELECT+" FROM "+FROM+" WHERE "+WHERE );
    			System.out.println("SELECT "+SELECT+" FROM "+FROM+" WHERE "+WHERE);
    			resultat.next();
    	        String nomGrille = resultat.getString( SELECT );
    			request.setAttribute( nom, nomGrille );
    		} catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
            return null;
        }
      
      public List<String> sendList(String SELECT,String FROM,String WHERE,String nom,HttpServletRequest request){
      	
      	SELECT=secure(SELECT);
      	FROM=secure(FROM);
      	WHERE=secure(WHERE);
      	
      	Statement statement = null;
  	    ResultSet resultat = null;
  	    List<String> values = new ArrayList<String>();
          try {
  			statement = connexion.createStatement();
  			resultat = statement.executeQuery( "SELECT "+SELECT+" FROM "+FROM+" WHERE "+WHERE );
  			System.out.println("SELECT "+SELECT+" FROM "+FROM+" WHERE "+WHERE);
  			SELECT=SELECT.replace("DISTINCT ", "");
  			while ( resultat.next() ) {
  	            String nomGrille = resultat.getString( SELECT );
  	            values.add(nomGrille);
  	        }
  			request.setAttribute( nom, values );
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
          return values;
      }
      
      public List<String> sendListRelation(String SELECT,String t_relation,String t_cible,String cle_in,String cle_out,String cle_cible,String id,String nom,HttpServletRequest request){
      	return sendList(SELECT,t_cible+","+t_relation,t_relation+"."+cle_in+"="+id+" AND "+t_cible+"."+cle_cible+"="+t_relation+"."+cle_out,nom,request);
      }
      
      public List<String> sendListInner(String SELECT, String FROM, String INNERJOIN, String id_in, String id_out, String WHERE, String nom, HttpServletRequest request){
    	  SELECT=secure(SELECT);
          FROM=secure(FROM);
          INNERJOIN=secure(INNERJOIN);
          WHERE=secure(WHERE);
          id_in=secure(id_in);
          id_out=secure(id_out);
          
          Statement statement = null;
    	  ResultSet resultat = null;
    	  List<String> values = new ArrayList<String>();
    	  try {
    			statement = connexion.createStatement();
    			resultat = statement.executeQuery( "SELECT "+SELECT+" FROM "+FROM+" INNER JOIN "+INNERJOIN+" ON ("+FROM+"."+id_in+"="+INNERJOIN+"."+id_out+") WHERE "+WHERE);
    			System.out.println("SELECT "+SELECT+" FROM "+FROM+" WHERE "+WHERE);
    			SELECT=SELECT.replace("DISTINCT ", "");
    			while ( resultat.next() ) {
    	            String nomElement = resultat.getString( SELECT );
    	            values.add(nomElement);
    	        }
    			request.setAttribute( nom, values );
    	  } catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
            return values;
      }
      
      public List<String> sendListInnerIn(String SELECT, String FROM, String WHERE, String SELECT_2, String FROM_2, String INNERJOIN, String id_in, String id_out, String WHERE_2, String nom, HttpServletRequest request){
    	  SELECT=secure(SELECT);
          FROM=secure(FROM);
          WHERE=secure(WHERE);
          SELECT_2=secure(SELECT_2);
          FROM_2=secure(FROM_2);
          INNERJOIN=secure(INNERJOIN);
          WHERE_2=secure(WHERE_2);
          id_in=secure(id_in);
          id_out=secure(id_out);
          Statement statement = null;
    	  ResultSet resultat = null;
    	  List<String> values = new ArrayList<String>();
    	  try {
    			statement = connexion.createStatement();
    			resultat = statement.executeQuery( "SELECT "+SELECT+" FROM "+FROM+" WHERE "+WHERE+" IN (SELECT "+SELECT_2+" FROM "+FROM_2+" INNER JOIN "+INNERJOIN+" ON ("+FROM_2+"."+id_in+"="+INNERJOIN+"."+id_out+") WHERE "+WHERE_2+")");
    	
    			while ( resultat.next() ) {
    	            String nomElement = resultat.getString( SELECT );
    	            values.add(nomElement);
    	        }
    			request.setAttribute( nom, values );
    	  } catch (SQLException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}
            return values;
      }
      
      public List<String> sendListById(String SELECT, String FROM, String nom_id, List<String> ids,String nom,HttpServletRequest request){
      	String WHERE=new String();
      	for(int i=0;i<ids.size();i++)
      		WHERE=WHERE+nom_id+"="+ids.get(i)+" OR ";
      	WHERE=WHERE+"1=0 ORDER BY "+nom_id;
      	return sendList(SELECT,FROM,WHERE,nom,request);
      }
      
      public void insert(String INSERT_INTO,String attributs,String valeurs){
      	
      	INSERT_INTO=secure(INSERT_INTO);
      	attributs=secure(attributs);
      	valeurs=secure(valeurs);
      	
      	valeurs=valeurs.replace(",", "','");
      	valeurs="'"+valeurs+"'";
      	
      	Statement statement = null;
          try {
  			statement = connexion.createStatement();
  			//System.out.println("Ca marche");
  			statement.executeUpdate( "INSERT INTO "+INSERT_INTO+" ("+attributs+") VALUES ("+valeurs+")" ,Statement.RETURN_GENERATED_KEYS);
  			//System.out.println(resultat);
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
      }
      
      public int compte(String SELECT_COUNT, String FROM){
    	  SELECT_COUNT=secure(SELECT_COUNT);
    	  FROM=secure(FROM);
    	  Statement statement = null;
    	  ResultSet resultat = null;
    	  int nbLignes = 0;
    	  try {
    		  statement = connexion.createStatement();
    		  resultat = statement.executeQuery("Select count("+SELECT_COUNT+") as nbLignes From "+FROM+";");
    		  if(resultat.next()){
    		  nbLignes = resultat.getInt("nbLignes");
    		  return nbLignes;
    		  }
    	  }catch (SQLException e)
    	  {
    		  e.printStackTrace();
    	  }
    	 return 0;
      }
      
      
      public ResultSet insertGroup(String INSERT_INTO,String... attributs){
    	  String secondMoitie ="";
    	  String premiereMoitie ="";
    	  INSERT_INTO=secure(INSERT_INTO);
    	  for(int i=0;i<attributs.length;++i)
    	  {
    		  attributs[i]=secure(attributs[i]);
    		  if (i<attributs.length/2)
    		  { 
    			  if (i<(attributs.length/2)-1)
    			  {
    				  secondMoitie+="'"+attributs[i+attributs.length/2]+"',";
    				  premiereMoitie+=attributs[i]+",";
    			  }
    			  else
    			  {
    				  secondMoitie+="'"+attributs[i+attributs.length/2]+"'";
    				  premiereMoitie+=attributs[i];
    			  }
    		  }
    	  }
    	  Statement statement = null;
    	  try 
    	  {	
    		  statement = connexion.createStatement();
    		  //System.out.println("Ca marche");
    		  statement.executeUpdate( "INSERT INTO "+INSERT_INTO+" ("+premiereMoitie+") VALUES ("+secondMoitie+")" ,Statement.RETURN_GENERATED_KEYS);
    		  //System.out.println(resultat);
    		  ResultSet resId = statement.getGeneratedKeys();
    		  return resId;
    	  } catch (SQLException e) 
    	  {
			// TODO Auto-generated catch block
			e.printStackTrace();
    	  }
    	  return null;
      }
      
      public void updateGroup(String UPDATE, String WHERE, String... attributs){
    	  String SET = "";
    	  WHERE=secure(WHERE);
    	  UPDATE=secure(UPDATE);
    	  for(int i=0;i<attributs.length;++i)
    	  {
    		  attributs[i]=secure(attributs[i]);
    		  if (i<attributs.length/2){
    			  if (i<(attributs.length/2)-1)
    			  {
    				  SET+= attributs[i]+" = '"+attributs[i+attributs.length/2]+"', ";
    			  }
    			  else
    			  {
    				  SET+= attributs[i]+" = '"+attributs[i+attributs.length/2]+"'";
    			  }
    		  }
    	  }
    	  Statement statement = null;
    	  try 
    	  {	
    		  statement = connexion.createStatement();
    		  statement.executeUpdate( "UPDATE "+UPDATE+" SET "+SET+" WHERE "+WHERE);
    	  } catch (SQLException e) 
    	  {
			// TODO Auto-generated catch block
			e.printStackTrace();
    	  }
      }
      
      public void update(String UPDATE,String attribut,String valeur,String WHERE){
      	
      	UPDATE=secure(UPDATE);
      	attribut=secure(attribut);
      	valeur=secure(valeur);
      	WHERE=secure(WHERE);
   
      	
      	Statement statement = null;
          try {
  			statement = connexion.createStatement();
  			//System.out.println("Ca marche");
  			statement.executeUpdate( "UPDATE "+UPDATE+" SET "+attribut+" = '"+valeur+"' WHERE "+WHERE);
  			//System.out.println(resultat);
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
      }
      
      public void delete(String DELETE_FROM,String WHERE){
      	
      	DELETE_FROM=secure(DELETE_FROM);
      	WHERE=secure(WHERE);
   
      	
      	Statement statement = null;
          try {
  			statement = connexion.createStatement();
  			//System.out.println("Ca marche");
  			statement.executeUpdate( "DELETE FROM "+DELETE_FROM+" WHERE "+WHERE);
  			//System.out.println("DELETE FROM "+DELETE_FROM+" WHERE "+WHERE);
  		} catch (SQLException e) {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
      }
      
      public void recuperationGroupe(int numero_groupe, HttpServletRequest request) {
    	ResultSet TuteurInfo = null;
  		ResultSet ClientInfo = null;
  		ResultSet listeEleves = null;
  		ResultSet AllEleves = null;
  		ResultSet planning = null;
  		Statement statement_tuteur = null;
  		Statement statement_client = null;
  		Statement statement_eleves = null;
  		Statement statement_tous_eleves = null;
  		Statement statement_planning = null;

  		String groupe_actif = null;
  		String TuteurId = null;
  		String TuteurPrenom = null;
  		String TuteurNom = null;
  		String ClientId = null;
  		String ClientPrenom = null;
  		String ClientNom = null;
  		boolean pas_d_eleves = true;
  		boolean pas_d_eleves_tot = true;
  		boolean pas_de_plan = true;
  		
  		String nomAPP = null;
  		
  		ArrayList<String> listeEleveId = new ArrayList<String>();
  		ArrayList<String> listeElevePrenom = new ArrayList<String>();
  		ArrayList<String> listeEleveNom = new ArrayList<String>();
  		ArrayList<String> listeEleveAnnee = new ArrayList<String>();
  		ArrayList<String> listeEleveNumero = new ArrayList<String>();
  		ArrayList<String> AllElevesId = new ArrayList<String>();
  		ArrayList<String> AllElevesNom = new ArrayList<String>();
  		ArrayList<String> AllElevesPrenom = new ArrayList<String>();
  		ArrayList<String> AllElevesNum = new ArrayList<String>();
  		ArrayList<String> plan_id = new ArrayList<String>();
  		ArrayList<String> plan_nom = new ArrayList<String>();
  		ArrayList<String> plan_description = new ArrayList<String>();
  		ArrayList<String> plan_date = new ArrayList<String>();
  		ArrayList<String> plan_debut = new ArrayList<String>();
  		ArrayList<String> plan_fin = new ArrayList<String>();
  		
  		try 
  		{
  			statement_tuteur = connexion.createStatement();
  			statement_client = connexion.createStatement();
  			statement_eleves = connexion.createStatement();
  			statement_tous_eleves = connexion.createStatement();
  			statement_planning = connexion.createStatement();
  			
  			TuteurInfo = statement_tuteur.executeQuery( "SELECT app.Nom_grille, app.Promo, g.Nom Nom_groupe, u.id, u.Nom Nom_prof, u.Prenom FROM grille_de_competence_app app INNER JOIN groupe g ON app.id_grille=g.idGrilleAPP INNER JOIN utilisateur u ON g.idTuteur=u.id WHERE id_groupe='"+ numero_groupe +"'" );
  			ClientInfo = statement_client.executeQuery( "SELECT app.Nom_grille, app.Promo, g.Nom Nom_groupe, u.id, u.Nom Nom_prof, u.Prenom FROM grille_de_competence_app app INNER JOIN groupe g ON app.id_grille=g.idGrilleAPP INNER JOIN utilisateur u ON g.idClient=u.id WHERE id_groupe='"+ numero_groupe +"'" );
  			listeEleves = statement_eleves.executeQuery("SELECT g.id_groupe, g.Nom Nom_grille, e.id_utilisateur, e.Numero_eleve, e.Annee, u.Prenom, u.Nom Nom_eleve FROM groupe g INNER JOIN appartient a ON a.idGroupe=g.id_groupe INNER JOIN eleves e ON a.idEleve=e.id_utilisateur INNER JOIN utilisateur u ON u.id= e.id_utilisateur WHERE g.id_groupe='"+ numero_groupe +"' AND a.actif='1' ");
  			planning = statement_planning.executeQuery("SELECT l6.Date, l6.`Debut`, l6.`Fin`, p.`id_planning`, p.Nom_planning, p.Description FROM `lie6` l6 INNER JOIN `planning` p ON l6.idPlaning=p.id_planning WHERE `idGroupe`='"+ numero_groupe+"' ORDER BY Date, Debut, fin");
  			
  			TuteurInfo.next();
  			ClientInfo.next();
  			
  			AllEleves = statement_tous_eleves.executeQuery("SELECT u.id, u.Nom, u.Prenom, e.Numero_eleve, a.idGroupe FROM utilisateur u INNER JOIN eleves e ON e.id_utilisateur=u.id LEFT JOIN appartient a ON a.idEleve=e.id_utilisateur WHERE e.Annee='"+ TuteurInfo.getString( "Promo" ) +"' AND u.id NOT IN (SELECT u.id FROM utilisateur u INNER JOIN eleves e ON e.id_utilisateur=u.id LEFT JOIN appartient a ON a.idEleve=e.id_utilisateur WHERE a.idGroupe='"+ numero_groupe +"')");
  			
  			nomAPP = TuteurInfo.getString( "Nom_grille" );
  			groupe_actif = TuteurInfo.getString( "Nom_groupe" );
  			TuteurId = TuteurInfo.getString( "id" );
  			TuteurPrenom = TuteurInfo.getString( "Prenom" );
  			TuteurNom = TuteurInfo.getString( "Nom_prof" );
  			ClientId = ClientInfo.getString( "id" );
  			ClientPrenom = ClientInfo.getString( "Prenom" );
  			ClientNom = ClientInfo.getString( "Nom_prof" );
  			
  			while (listeEleves.next())
  			{
  				listeEleveId.add(listeEleves.getString( "id_utilisateur" ));
  				listeElevePrenom.add(listeEleves.getString( "Prenom" ));
  				listeEleveNom.add(listeEleves.getString( "Nom_eleve" ));
  				listeEleveAnnee.add(listeEleves.getString( "Annee" ));
  				listeEleveNumero.add(listeEleves.getString( "Numero_eleve" ));
  				pas_d_eleves = false;
  			}
  			if(pas_d_eleves)
  			{
  				listeEleveId.add(null);
  			}
  			
  			while (AllEleves.next())
  			{
  				AllElevesId.add(AllEleves.getString( "id" ));
  				AllElevesNom.add(AllEleves.getString( "Nom" ));
  				AllElevesPrenom.add(AllEleves.getString( "Prenom" ));
  				AllElevesNum.add(AllEleves.getString( "Numero_eleve" ));
  				pas_d_eleves_tot = false;
  			}
  			if(pas_d_eleves_tot)
  			{
  				AllElevesId.add(null);
  			}
  			while (planning.next())
  			{
  				plan_id.add(planning.getString( "id_planning" ));
  				plan_nom.add(planning.getString( "Nom_planning" ));
  				plan_description.add(planning.getString( "Description" ));
  				plan_date.add(planning.getString( "Date" ));
  				plan_debut.add(planning.getString( "Debut" ));
  				plan_fin.add(planning.getString( "Fin" ));
  				pas_de_plan= false;
  				/* Ajouts : date au format JJ-MM-AAAA (actuellement AAAA-MM-JJ)
  				 * 			heures : retirer les secondes
  				 * 			Ajouter une description cliquable pour étendre
  				 * */
  			}
  			if(pas_de_plan)
  			{
  				plan_id.add(null);
  			}
  			
  			//Définition des Attributs pour la page jsp
  			request.setAttribute("nom_app", nomAPP);
  			request.setAttribute("nom_groupe", groupe_actif);
  			request.setAttribute("tuteur_id", TuteurId);
  			request.setAttribute("tuteur_prenom", TuteurPrenom);
  			request.setAttribute("tuteur_nom", TuteurNom);
  			request.setAttribute("client_id", ClientId);
  			request.setAttribute("client_prenom", ClientPrenom);
  			request.setAttribute("client_nom", ClientNom);
  			request.setAttribute("eleves_id", listeEleveId);
  			request.setAttribute("eleves_prenom", listeElevePrenom);
  			request.setAttribute("eleves_nom", listeEleveNom);
  			request.setAttribute("eleves_annee", listeEleveAnnee);
  			request.setAttribute("eleves_numero", listeEleveNumero);
  			request.setAttribute("nb_eleves", (listeEleveId.size()-1) );
  			request.setAttribute("all_id", AllElevesId);
  			request.setAttribute("all_prenom", AllElevesPrenom);
  			request.setAttribute("all_nom", AllElevesNom);
  			request.setAttribute("all_numero", AllElevesNum);
  			request.setAttribute("nb_all", (AllElevesId.size()-1) );
  			request.setAttribute("plan_id", plan_id);
  			request.setAttribute("plan_nom", plan_nom);
  			request.setAttribute("plan_description", plan_description);
  			request.setAttribute("plan_date", plan_date);
  			request.setAttribute("heure_debut", plan_debut);
  			request.setAttribute("heure_fin", plan_fin);
  			request.setAttribute("nb_plan", (plan_id.size()-1) );
  			
  		} catch (SQLException e) 
          {
  			// TODO Auto-generated catch block
  			e.printStackTrace();
  		}
  	}
    
    public void affichagePlanningEleve(int numero_groupe, boolean isRespo, HttpServletRequest request) {
		Statement statement_planning = null;
		Statement statement_groupe = null;
		ResultSet planning = null;
		ResultSet groupe = null;

		String groupe_actif = null;
		String nomAPP = null;
		boolean pas_de_plan = true;
		
		ArrayList<String> plan_id = new ArrayList<String>();
		ArrayList<String> plan_nom = new ArrayList<String>();
		ArrayList<String> plan_description = new ArrayList<String>();
		ArrayList<String> plan_date = new ArrayList<String>();
		ArrayList<String> plan_debut = new ArrayList<String>();
		ArrayList<String> plan_fin = new ArrayList<String>();
		
		/*
		 * Requête

SELECT l6.Date, l6.`Debut`, l6.`Fin`, p.`id_planning`, p.Nom_planning, p.Description FROM `lie6` l6 INNER JOIN `planning` p ON l6.idPlaning=p.id_planning WHERE `idGroupe`=1 ORDER BY Date, Debut, fin
		 */
		try 
		{
			statement_planning = connexion.createStatement();
			statement_groupe = connexion.createStatement();
			
			//Récupération du planning - ID GROUPE FIXÉ !!!
			if(isRespo) {
				planning = statement_planning.executeQuery("SELECT l6.Date, l6.`Debut`, l6.`Fin`, p.`id_planning`, p.Nom_planning, p.Description, g.Nom Nom_groupe, g.id_groupe, app.id_grille, app.Nom_grille FROM `lie6` l6 INNER JOIN `planning` p ON l6.idPlaning=p.id_planning INNER JOIN groupe g ON g.id_groupe=l6.idGroupe INNER JOIN grille_de_competence_app app ON app.id_grille=g.idGrilleAPP ORDER BY Date, Debut, fin");
				
			}else{
				groupe = statement_groupe.executeQuery("SELECT app.Nom_grille, g.Nom Nom_groupe FROM grille_de_competence_app app INNER JOIN groupe g ON app.id_grille=g.idGrilleAPP WHERE id_groupe='"+numero_groupe+"'");
				planning = statement_planning.executeQuery("SELECT l6.Date, l6.`Debut`, l6.`Fin`, p.`id_planning`, p.Nom_planning, p.Description FROM `lie6` l6 INNER JOIN `planning` p ON l6.idPlaning=p.id_planning WHERE `idGroupe`='"+ numero_groupe+"' ORDER BY Date, Debut, fin");
			
				groupe.next();
				nomAPP = groupe.getString( "Nom_grille" );
				groupe_actif = groupe.getString( "Nom_groupe" );
				
				while (planning.next())
				{
					plan_id.add(planning.getString( "id_planning" ));
					plan_nom.add(planning.getString( "Nom_planning" ));
					plan_description.add(planning.getString( "Description" ));
					plan_date.add(planning.getString( "Date" ));
					plan_debut.add(planning.getString( "Debut" ));
					plan_fin.add(planning.getString( "Fin" ));
					pas_de_plan= false;
					/* Ajouts : date au format JJ-MM-AAAA (actuellement AAAA-MM-JJ)
					 * 			heures : retirer les secondes
					 * 			Ajouter une description cliquable pour étendre
					 * */
				}
				if(pas_de_plan)
				{
					plan_id.add(null);
				}
				
				//Définition des Attributs pour la page jsp
				request.setAttribute("nom_app", nomAPP);
				request.setAttribute("nom_groupe", groupe_actif);
				request.setAttribute("plan_id", plan_id);
				request.setAttribute("plan_nom", plan_nom);
				request.setAttribute("plan_description", plan_description);
				request.setAttribute("plan_date", plan_date);
				request.setAttribute("heure_debut", plan_debut);
				request.setAttribute("heure_fin", plan_fin);
				request.setAttribute("nb_plan", (plan_id.size()-1) );
			
			}
			
	  } catch (SQLException e) 
      {
			// TODO Auto-generated catch block
			e.printStackTrace();
      }
	}
}