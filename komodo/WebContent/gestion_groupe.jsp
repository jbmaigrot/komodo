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
		
		<title>Gestion de groupe</title>
		
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
							<div><p><a href="ModifierGrille?id=${grilleInd }">${grilleTabNom[iterator.index]}</a></p></div>
						</c:forEach>
				    </div>
				     <div class="aside-app" id="groupeAjout">
						<p><a href="AjoutGroupe">Ajouter groupe</a></p>
					</div>
				    <div class="aside-app" id="groupe" onClick='selectionElementGrille("groupe","nomGroupe");'>Groupe</div>
				    <div id="nomGroupe" style="display:none;">
				    <c:forEach items="${groupeTabId }" var="groupeInd" varStatus="iterator">
							<div><p><a href="GestionGroupe?id_groupe=${groupeInd }">${groupeTabNom[iterator.index]}</a></p></div>
						</c:forEach>
				    </div>
				    <div class="aside-app" id="ajoutCompPrin">
				    	<p><a id="ajoutCompPrin" href="#creation" onClick='selectionElementGrille("ajoutCompPrin","creation");'>Ajouter un mod�le de comp�tence principale</a></p>
				    </div>
				    <div class="aside-app" id="ajoutCompSec">
				    	<p><a id="ajoutCompSec" href="CreationCompetenceSecondaire">Ajouter un mod�le de comp�tence secondaire</a></p>
				    </div>
				    <div class="aside-app" id="ajoutUtilisateur">
				    	<p><a id="ajoutCompSec" href="CreationUtilisateur">Ajouter un utilisateur</a></p>
					</div>
				</menu>
		
				
				<section class="col-md-9">
					<div>
						<h1>Gestion de groupe</h1>
						<h3>Edition de <strong>${nom_groupe}</strong> dans <strong>${nom_app}</strong></h3>
						<p> Tuteur : ${tuteur_prenom} ${tuteur_nom}<p>
						<p> Client : ${client_prenom} ${client_nom}<p>
						<p> �l�ves membre :<p>
						<ul>
							<c:choose>
								<c:when test="${nb_eleves == 0}">
									<li>Pas encore d'�l�ves</li>
								</c:when>
								
								<c:otherwise>
									<c:forEach var="i" begin="0" end="${nb_eleves - 1}">
										<li>${eleves_annee[i]} ${eleves_numero[i]} ${eleves_prenom[i]} ${eleves_nom[i]} </li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</ul>
						<p class="${empty erreurs ? 'succes' : 'erreur'}">${resultat}</p>
						<div class="button"><span id="ajout_eleve" onClick='affichageElementTier("ajout_eleve","choix_eleve");'>Ajouter</span></div>
						<div id="choix_eleve" style="display:none;">
							<form method="post" action="GestionGroupe">
								<input type="hidden" name="id_groupe" value="${id_groupe }"/>
								<input type="hidden" name="id_app" value="${id_app }"/>
								<select id="choix_nouveau" name="choix_nouveau">
								
									<c:choose>
										<c:when test="${nb_all == 0}">
											<option>Pas d'�l�ves � ajouter</option>
										</c:when>
									
										<c:otherwise>
											<option disabled selected>Nouvel �l�ve</option>
											<c:forEach var="i" begin="0" end="${nb_all - 1}">
												<option value='<c:out value="${all_id[i]}"/>' > ${all_numero[i]} ${all_prenom[i]} ${all_nom[i]}</option>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</select>
								<input type="submit" name="Submit" value="Ajouter" id="Submit" >
							</form>
						</div>
					</div>
					<div>
						<h4>Planning du groupe</h4>
						<u1>
							<c:choose>
								<c:when test="${nb_plan == 0}">
									<li>Pas d'�v�nements dans le planning</li>
								</c:when>
								
								<c:otherwise>
									<c:forEach var="i" begin="0" end="${nb_plan - 1}">
										<li>Le ${plan_date[i]} de ${heure_debut[i]} � ${heure_fin[i]} : ${plan_nom[i]} 
										</li>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</u1>
					</div>
				</section>
			
		
		<jsp:include page = "footer.jsp" />
	</body>
</html>