<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>	
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<title>Creation competence secondaire</title>

		<!-- Bootstrap -->
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="style.css">

		<script src="script/jquery.min.js"></script>
		<script src="script/test.js"></script>

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		
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
	</head>
	<body>
		<jsp:include page="header.jsp" />
		<div class="container">
			<div class="row">
				<menu class="col-md-3">
					<div class="aside-promo">
						<p><a id="ajout" href="ArborescenceResponsableModule">Retour vers l'arborescence du responsable module</a></p>
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
			    	<div class="aside-app" id="ajoutUtilisateur">
				   		<p><a id="ajoutCompSec" href="CreationUtilisateur">Ajouter un utilisateur</a></p>
					</div>
				</menu>
		
				<section class="col-md-9">
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
 			</div>
 		</div>
 		<jsp:include page = "footer.jsp" />
	</body>
</html>