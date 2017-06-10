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
		<title>Gestion de groupe</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
		<script>
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
					<h1>Gestion de groupe</h1>
					<h3>Edition de <strong>${nom_groupe}</strong> dans <strong>${nom_app}</strong></h3>
					<p> Tuteur : ${tuteur_prenom} ${tuteur_nom}<p>
					<p> Client : ${client_prenom} ${client_nom}<p>
					<p> Élèves membre :<p>
					<ul>
						<c:choose>
							<c:when test="${eleves_id[0] == null}">
								<li>Pas encore d'élèves</li>
							</c:when>
							
							<c:otherwise>
								<c:forEach var="i" begin="0" end="${nb_eleves}">
									<li>${eleves_annee[i]} ${eleves_numero[i]} ${eleves_prenom[i]} ${eleves_nom[i]} </li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</ul>
					<p class="${empty erreurs ? 'succes' : 'erreur'}">${resultat}</p>
					<span id="ajout_eleve" class="" onClick='affichageElementTier("ajout_eleve","choix_eleve");'>Ajouter</span>
					<div id="choix_eleve" style="display:none;">
						<form method="post" action="GestionGroupe">
						<input type="hidden" name="id_groupe" value="${id_groupe }"/>
							<select id="choix_nouveau" name="choix_nouveau">
							
								<c:choose>
									<c:when test="${eleves_id[0] == null}">
										<option>Pas d'élèves à ajouter</option>
									</c:when>
								
									<c:otherwise>
										<option disabled selected>Nouvel élève</option>
										<c:forEach var="i" begin="0" end="${nb_all}">
											<option value='<c:out value="${all_id[i]}"/>' > ${all_numero[i]} ${all_prenom[i]} ${all_nom[i]}</option>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</select>
							<input type="submit" name="Submit" value="Ajouter" id="Submit" >
						</form>
					</div>
				</section>
				<section>
					<h4>Planning du groupe</h4>
					<u1>
						<c:choose>
							<c:when test="${plan_id[0] == null}">
								<li>Pas d'évènements dans le planning</li>
							</c:when>
							
							<c:otherwise>
								<c:forEach var="i" begin="0" end="${nb_plan}">
									<li>Le ${plan_date[i]} de ${heure_debut[i]} à ${heure_fin[i]} : ${plan_nom[i]} 
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</u1>
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