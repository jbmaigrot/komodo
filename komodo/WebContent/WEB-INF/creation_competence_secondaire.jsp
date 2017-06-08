<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Creation competence secondaire</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	 </head>
	 <body>-->
	 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
	 	<header>
	    	<h1>SITE WEB APP</h1>
	    	<div>
	    		<a href="#">Thomas (mon profil)</a>
	    		<a href="#">Déconnexion</a>
	    	</div>
		</header>
		<script>		
			function selectionElementGrille(id_element,id_element_sec){
				var cible = document.getElementById(id_element_sec);
				if (document.getElementById(id_element).disabled == undefined || document.getElementById(id_element).disabled == false)
				{
					if(cible.style.display != '')
			       		cible.style.display = '';
			 		else{
					cible.style.display = 'none';
			    		
		    			//document.getElementById(id_element_sec).innerHTML = "";
		       			//cible.style.display = 'none';
		    		}
				}
			}
		</script>
	<div id="page">
			<aside>
				<div class="aside-promo">
					<p id="promo1"><img src="pictures/minus.png"/>Promo 2018</p>
					<div class="aside-category">
						<p id="category1"><img src="pictures/minus.png"/>Tuteur</p>
						<div class="aside-app">
							<p id="app1"><img src="pictures/minus.png"/>APP électronique</p>
							<div class="aside-group">
								<p id="group1"><img src="pictures/minus.png"/>Groupe APP A</p>
								<div class="aside-student">
									<p id="student1">Léo<p>
									<p>François</p>
									<p>Gérard</p>
								</div>
							</div>
						</div>
					</div>
					<div class="aside-category"><img src="pictures/plus.png"/>Client</div>
				</div>
				<div class="aside-promo">
					<p><img src="pictures/plus.png"/>Autres promos</p>
				</div>
				<div class="aside-app" id="grille">
					<p><a id="ajout" href="CreationGrille">Ajouter Grille</a></p>
				</div>
				<div class="aside-app" id="grille" onClick='selectionElementGrille("grille","nomGrille");'>Grille APP</div>
				<div id="nomGrille" style="display:none;">
					<c:forEach items="${grilleTabId }" var="grilleInd" varStatus="iterator">
						<p><a href="ModifierGrille?id=${grilleInd }">${grilleTabNom[iterator.index]}</a></p>
					</c:forEach>
			    </div>
			    <div class="aside-app" id="ajoutCompPrin">
			    <p><a id="ajoutCompPrin" href="CreationCompetencePrincipale">Ajouter un modèle de compétence principale</a></p>
			    </div>
			    <div class="aside-app" id="ajoutCompSec">
			    <p><a id="ajoutCompSec" href="#creation" onClick='selectionElementGrille("ajoutCompSec","creation");'>Ajouter un modèle de compétence secondaire</a></p>
			    </div>
			</aside>
		</div>
		
		<section>
		<div id="creation">
			<form method="post" action="CreationCompetenceSecondaire">
				<div>
					<label>Nom compétence secondaire : </label><input type="text" name="nom_competence_secondaire" value="" id="nom_competence_secondaire" />
			 		<span class="erreur">${erreurs['nom_competence_secondaire']}</span>
				</div>
				<input type="submit" name="Submit" value="Valider" id="Submit" >
			</form>
			  <span>${resultatForm }</span>
			  </div> 
 	</section>
	</body>
	<footer>
		<div><a href="#">CGU</a></div>
		<div><a href="#">FAQ</a></div>
		<div><a href="#">Nous contacter</a></div>
	</footer>
</html>