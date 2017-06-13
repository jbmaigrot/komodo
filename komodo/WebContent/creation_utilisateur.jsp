<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<title>Création utilisateur</title>

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
			
			function affichageListeCoefficient(sel, coef)
			{
				if (sel.size != coef)
	           		sel.size = coef;
				else
					sel.size = '1';
	        }
			
			function changementType(eleve){
				
				var type = document.getElementById("type").value;
				
				var div = document.getElementById(eleve);
				alert(div);
				if (type=="eleve"){
					
					div.style.display='';
				}else{
					div.style.display='none';
				}
			}
		</script>
	 </head>
	 <body>
		<jsp:include page="header.jsp" />
		
		<div class="container white">
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
				     <div class="aside-app" id="groupeAjout">
						<p><a href="AjoutGroupe">Ajouter groupe</a></p>
					</div>
				    <div class="aside-app" id="groupe" onClick='selectionElementGrille("groupe","nomGroupe");'>Groupe</div>
				    <div id="nomGroupe" style="display:none;">
				    <c:forEach items="${groupeTabId }" var="groupeInd" varStatus="iterator">
							<p><a href="GestionGroupe?id_groupe=${groupeInd }">${groupeTabNom[iterator.index]}</a></p>
						</c:forEach>
				    </div>
				    <div class="aside-app" id="ajoutCompPrin">
				    	<p><a id="ajoutCompPrin" href="CreationCompetencePrincipale">Ajouter un modèle de compétence principale</a></p>
				    </div>
				    <div class="aside-app" id="ajoutCompSec">
				    	<p><a id="ajoutCompSec" href="CreationCompetenceSecondaire">Ajouter un modèle de compétence secondaire</a></p>
				    </div>
				     <div class="aside-app" id="ajoutUtilisateur">
				    	<p><a id="ajoutCompSec" href="#creation" onClick='selectionElementGrille("ajoutUtilisateur","creation");'>Ajouter un utilisateur</a></p>
				    </div>
				</menu>
		
				<section class="col-md-9">
					<div id="creation">
						<form method="post" action="CreationUtilisateur">
							<div>
								<label>Nom : </label><input type="text" name="nom_utilisateur" value='<c:out value="${param.nom_utilisateur}"/>' id="nom_utilisateur" />
				 				<span class="erreur">${erreurs['nom_utilisateur']}</span>
							</div>
							<div>
								<label>Prénom : </label><input type="text" name="prenom_utilisateur" value='<c:out value="${param.prenom_utilisateur}"/>' id="prenom_utilisateur" />
				 				<span class="erreur">${erreurs['prenom_utilisateur']}</span>
							</div>
							<p>
								<label>Age : </label><select name="age" size="1" onclick="affichageListeCoefficient(this, '4');" >
								<option disabled selected >Age</option>
								<c:forEach var="i" begin="17" end ="70" step="1">
								
									<option value="${ i}" <c:if test = "${param.age == i}">selected</c:if>><c:out value="${ i }" /> </option>
								</c:forEach>
								</select>
								<span class="erreur">${erreurs['age']}</span>
							</p>
							<c:set var="eleve" value="eleve"/>
							<c:set var="professeur" value="professeur"/>
							<c:set var="responsable" value="responsable"/>
							<c:set var="affEleve" value="false"/>
							<div>
								<label>Type : </label><select name="type" size="1" id="type" onchange='changementType("eleve");'>
							    <option disabled selected >Type</option>
								<option value="${eleve}" <c:if test="${param.type == eleve }">selected<c:set var="affEleve" value="true"/></c:if>>élève</option>
								<option value="${professeur }" <c:if test="${param.type == professeur }">selected</c:if>>professeur</option>
								<option value="${responsable }" <c:if test="${param.type == responsable }">selected</c:if>>responsable</option>
								</select>
				 				<span class="erreur">${erreurs['type']}</span>
							</div>
							
							<div>
								<label>Identifiant : </label><input type="text" name="identifiant" value='<c:out value="${param.identifiant}"/>' id="identifiant" />
				 				<span class="erreur">${erreurs['identifiant']}</span>
							</div>
							<div>
								<label>Mot de passe : </label><input type="password" name="mot_de_passe" value='<c:out value="${param.mot_de_passe}"/>' id="mot_de_passe" />
				 				<span class="erreur">${erreurs['mot_de_passe']}</span>
							</div>
							<div id="eleve" <c:choose><c:when test = "${affEleve == false}"> style="display:none;"</c:when> <c:when test = "${affEleve == true}"> style="display:'';"</c:when></c:choose>>
							<div>
								<label>Numéro élève : </label><input type="text" name="numero_eleve" value='<c:out value="${param.numero_eleve}"/>' id="numero_eleve" />
				 				<span class="erreur">${erreurs['numero_eleve']}</span>
							</div>
							<p>
								<label>Année : </label><select name="annee" size="1" onclick="affichageListeCoefficient(this, '4');" >
								<option disabled selected >Année</option>
								<c:forEach var="i" begin="2015" end ="2050" step="1">
								
									<option value="${ i}" <c:if test = "${param.annee == i}">selected</c:if>><c:out value="${ i }" /> </option>
								</c:forEach>
								</select>
								<span class="erreur">${erreurs['annee']}</span>
							</p>
							<div>
								<label>Spécialité : </label><input type="text" name="specialite" value='<c:out value="${param.specialite}"/>' id="specialite" />
				 				<span class="erreur">${erreurs['specialite']}</span>
							</div>
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