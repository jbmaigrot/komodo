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
		<title>Planning APP Edition</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
		<script>
			function affichageElementTier(id_element,id_element_sec){
				var cible = document.getElementById(id_element_sec);
				if (document.getElementById(id_element).disabled == undefined || document.getElementById(id_element).disabled == false)
				{
					if(cible.style.display != '')
			       		cible.style.display = '';
			 		else{
					cible.style.display = 'none';
		    		}
				}
			}
			function affichageElementList(id_element, limit){
				var cible = document.getElementById("choix_groupe_" + id_element.value);
				
		       	cible.style.display = '';
		 		for(i=1; i<=limit; i++) {
		 			if(id_element.value != i)
		 				document.getElementById("choix_groupe_" + i).style.display = 'none';
		 		}
			}
		</script>
	 </head>
	 
	 <body>
	 	<header>
			<h1 class="col-md-6 col-md-offset-3">SITE WEB APP</h1>
			<div class="col-md-3">
	    		<a href="#">Thomas (mon profil)</a>
	    		<a href="#">Déconnexion</a>
	    	</div>
		</header>

		<div class="container">

			<div class="row">
				<menu class="col-md-3">
					<div class="aside-promo">
						<p id="promo1"><img src="pictures/minus.png"/>[TO BE MADE : MENU] PROMO 20XX</p>
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
						<p><a href="CreationGrille">Ajouter</a></p>
					</div>
					<div class="aside-app" id="grille" onClick='selectionElementGrille("grille","grilles");'>
						<p><img src="pictures/plus.png"/>Grille APP<p>
						<div id="grilles" style="display:none;">
							<c:forEach items="${grilleTabId }" var="grilleInd" varStatus="iterator">
								<p><a href="ModifierGrille?id=${grilleInd }">${grilleTabNom[iterator.index]}</a></p>
							</c:forEach>
						</div>
					</div>
				</menu>
				<section class="col-md-9">
				<section>
					<h4>Ajouter un élement au planning</h4>
					<form method="post" action="EditionPlanning">
						<label>Nom de l'événement : </label><input type="text" name="nom_plan" id="nom_plan" /><br/>
						<span class="erreur">${erreurs['nom_grille']}</span>
						<label>Description : </label><input type="textarea" name="descr_plan" id="descr_plan" /><br/>
						<span class="erreur">${erreurs['nom_grille']}</span>
						<label>Date : </label><input type="date" name="date_plan" id="date_plan" />
						<span class="erreur">${erreurs['nom_grille']}</span>
						<label>Heure de début: </label><input type="time" name="time_debut" id="time_debut" />
						<span class="erreur">${erreurs['nom_grille']}</span>
						<label>Heure de fin : </label><input type="time" name="time_fin" id="time_fin" />
						<span class="erreur">${erreurs['nom_grille']}</span>
						<select name="choix_app" id="choix_app" onchange="affichageElementList(choix_app, ${liste_app_size})">
							<option disabled selected>Choisir un APP</option>
							<c:forEach var="j" begin="0" end="${liste_app_size - 1}">
								<option value="${inp_id_app[j]}">${inp_nom_app[j] }</option>
							</c:forEach>
						</select>
						<c:forEach var="i" begin="0" end="${liste_app_size - 1}">
							<select id="choix_groupe_${inp_id_app[i] }" name="groupe_choisi" style="display:none">
								<option disabled selected>choisir un groupe</option>
								<c:choose>
									<c:when test="${i==0}">
										<c:forEach var="j" begin="0" end="${taille_groupes[i] - 1}">
											<option value="${id_all_group[j]}" >${nom_all_group[j]}</option>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<c:forEach var="j" begin="${taille_groupes[i-1]}" end="${taille_groupes[i] - 1}">
											<option value="${id_all_group[j]}" >${nom_all_group[j]}</option>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</select>
						</c:forEach><br/><br/>
						<input type="submit" name="Submit" value="Ajouter un évenement" id="Submit" >
					</form>
					<div>
						<h4>Liste des événements</h4>
						<u1>
							<c:choose>
								<c:when test="${nb_plan == 0}">
									<li>Pas d'évènements prévu</li>
								</c:when>
								
								<c:otherwise>
									<c:forEach var="i" begin="0" end="${nb_plan - 1}">
										<li>Le <strong>${plan_date[i]}</strong> de ${heure_debut[i]} à ${heure_fin[i]} - <strong>${plan_groupe_nom[i]}</strong> dans <strong>${plan_groupe_app[i]}</strong> : ${plan_nom[i]} 
										</li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</u1>
					</div>
				</section>
			</div>
		</div>
		<footer>
			<div><a href="#">CGU</a></div>
			<div><a href="#">FAQ</a></div>
			<div><a href="#">Nous contacter</a></div>
		</footer>
	</body>
</html>