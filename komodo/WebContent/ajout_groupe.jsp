<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

		<!-- Bootstrap -->
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="style.css">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Ajout de groupe</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
		<script>
			/*
			function selection(check_tab,id_comp,id_comp_sec) 
			{
				
				var cible = document.getElementById(id_comp);
				var cible_sec = document.getElementById(id_comp_sec);
				
				// cas navigateur pour undefined.
				if (document.getElementById(check_tab).checked == true)
				{
					cible.style.display = '';
					//document.getElementById(id_comp).innerHTML = document.getElementById(id_tab).innerHTML;
					//document.getElementById(id_tab).disabled = true;
				}
				else
				{
					cible.style.display = 'none';
				    cible_sec.style.display = 'none';
				//	document.getElementById(id_tab).disabled = false;
				}
			}
			*/
			function selectionElementGrille(id_element,id_element_sec)
			{
					
				var cible = document.getElementById(id_element_sec);
				if (document.getElementById(id_element).disabled == undefined || document.getElementById(id_element).disabled == false)
				{
					if(cible.style.display != '')
			        	cible.style.display = '';
			    	else 
			       		cible.style.display = 'none';
				}
			}
			
			/*
			function affichageListeCoefficient(sel, coef)
			{
				if (sel.size != coef)
	           		sel.size = coef;
				else
					sel.size = '1';
	        }
			*/
		</script>
	 </head>
	 
	 <body>
	 	<jsp:include page = "header.jsp" />

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
				    	<p><a id="ajoutCompPrin" href="#creation" onClick='selectionElementGrille("ajoutCompPrin","creation");'>Ajouter un modèle de compétence principale</a></p>
				    </div>
				    <div class="aside-app" id="ajoutCompSec">
				    	<p><a id="ajoutCompSec" href="CreationCompetenceSecondaire">Ajouter un modèle de compétence secondaire</a></p>
				    </div>
				    <div class="aside-app" id="ajoutUtilisateur">
				    	<p><a id="ajoutCompSec" href="CreationUtilisateur">Ajouter un utilisateur</a></p>
					</div>
				</menu>
				
				<section class="col-md-9">
				<h1>Ajouter un Groupe</h1>
					<form method="post" action="AjoutGroupe">
						<div>
							<label>Choississez un APP :  </label>
							<select id="choix_APP" name="choix_APP">
								<c:choose>
									<c:when test="${nb_app == 0}">
										<option disabled selected>Pas d'APP à afficher</option>
									</c:when>
							
									<c:otherwise>
										<option disabled selected>Choisissez une grille d'APP</option>
										<c:forEach var="i" begin="0" end="${nb_app-1}">
											<option value='<c:out value="${app_id[i]}"/>' >[Promo : ${app_promo[i]}] ${app_nom[i]}</option>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</select>
							<span class="erreur">${erreurs['choix_APP']}</span>
						</div>
						<div>
							<label>Nom du Groupe : </label><input type="text" id="nom_groupe" name="nom_groupe" <c:if test="${empty erreurs}">value=""</c:if>
								<c:if test="${not empty erreurs }">value='<c:out value="${param.nom_groupe}"/>'</c:if> />
								<span class="erreur">${erreurs['nom_groupe']}</span>
						</div>
						<div>
							<label>Tuteur : </label>
							<select id="nom_tuteur" name="nom_tuteur">
								<c:choose>
									<c:when test="${nombre_profs == 0}">
										<option disabled selected>Pas de professeurs</option>
									</c:when>
							
									<c:otherwise>
										<option disabled selected>Choisissez un professeur</option>
										<c:forEach var="i" begin="0" end="${nombre_profs-1}">
											<option value='<c:out value="${profs_id[i]}"/>' >${profs_prenom[i]} ${profs_nom[i]}</option>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</select>
							<span class="erreur">${erreurs['nom_tuteur']}</span>
						</div>
						<div>
							<label>Client : </label>
							<select id="nom_client" name="nom_client">
								<c:choose>
									<c:when test="${nombre_profs == 0}">
										<option disabled selected>Pas de professeurs</option>
									</c:when>
							
									<c:otherwise>
										<option disabled selected>Choisissez un professeur</option>
										<c:forEach var="i" begin="0" end="${nombre_profs - 1}">
											<option value='<c:out value="${profs_id[i]}"/>' >${profs_prenom[i]} ${profs_nom[i]}</option>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</select>
							<span class="erreur">${erreurs['nom_client']}</span>
						</div>
						<div>
						<p class="${empty erreurs ? 'succes' : 'erreur'}">${resultat}</p>
							<input type="submit" name="Submit" value="Ajouter un groupe" id="Submit" >
						</div>
					</form>		
				</section>
			</div>
		</div>
		
		<jsp:include page = "footer.jsp" />
	</body>
</html>