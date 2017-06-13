<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html>

    <head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		
		<title>Arborescence responsable module</title>

		<!-- Bootstrap -->
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="style.css">
		
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
				function displ(classname){
					var x=document.getElementsByClassName(classname);
					for (i = 0; i < x.length; i++) {
						if(document.getElementsByClassName(classname)[i].style.display=='none')
							document.getElementsByClassName(classname)[i].style.display='block';
						else
							document.getElementsByClassName(classname)[i].style.display='none';
					}
				}
				
				function get(param) {
					var vars = {};
					window.location.href.replace( location.hash, '' ).replace( 
						/[?&]+([^=&]+)=?([^&]*)?/gi, // regexp
						function( m, key, value ) { // callback
							vars[key] = value !== undefined ? value : '';
						}
					);
			
					if ( param ) {
						return vars[param] ? vars[param] : null;	
					}
					return vars;
				}
				
				function hideRoles(id,promo){
					if(promo!=get("promo")){
						document.getElementById(id).style.display='none';
					}
				}
				
				function hideApps(id,role){
					if(role!=get("role")){
						document.getElementById(id).style.display='none';
					}
				}
				
				function hideGroupes(id,app){
					if(app!=get("app")){
						document.getElementById(id).style.display='none';
					}
				}
				
				function hideEleves(id,groupe){
					if(groupe!=get("groupe")){
						document.getElementById(id).style.display='none';
					}
				}
				
			</script>
	 </head>

	 <body>
		<jsp:include page = "header.jsp" />

		<div class="container white">
			<div class="row">
				<menu class="col-md-3">
					<c:forEach items="${ is }" var="i">
						<div class="aside-promo">
							<a id="${ i }" href="ArborescenceResponsableModule?sql=1&promo=${ i }&role=0&app=0&groupe=0&eleve=0#${ i }"><img src="pictures/minus.png"/>Promo ${ i }</a>
							<div id="f${ i }" class="aside-category${ i }">
								<c:forTokens var="elt" items="Autre" delims="/"><p>
									<a id="${ i }${ elt }" href="ArborescenceResponsableModule?sql=1&promo=${ i }&role=${ elt }&app=0&groupe=0&eleve=0#${ i }${ elt }"><img src="pictures/minus.png"/>Tout</a>
									<div id="f${ i }${ elt }" class="aside-app">
										<c:forEach items="${ apps }" varStatus="s2"><c:if test="${ promos[s2.index] == i }" var="variable"><p>
											<a id="${ i }${ elt }${ apps_id[s2.index] }" href="ArborescenceResponsableModule?sql=1&promo=${ i }&role=${ elt }&app=${ apps_id[s2.index] }&groupe=0&eleve=0#${ i }${ elt }${ apps_id[s2.index] }"><img src="pictures/minus.png"/>${ apps[s2.index] }</a>
											<div id="f${ i }${ elt }${ apps_id[s2.index] }" class="aside-group">
												<c:forEach items="${ groupes }" varStatus="s3"><p>
													<a id="${ i }${ elt }${ apps_id[s2.index] }${ groupes_id[s3.index] }" href="ArborescenceResponsableModule?sql=1&promo=${ i }&role=${ elt }&app=${ apps_id[s2.index] }&groupe=${ groupes_id[s3.index] }&eleve=0#${ i }${ elt }${ apps_id[s2.index] }${ groupes_id[s3.index] }"><img src="pictures/minus.png"/>${ groupes[s3.index] }</a>
													<div id="f${ i }${ elt }${ apps_id[s2.index] }${ groupes_id[s3.index] }" class="aside-student">
														<c:forEach items="${ eleves }" varStatus="s4">
															<p><a href="AffichageTeacher?eleve=${ eleves_id[s4.index] }&grille=${ apps_id[s2.index] }&competence=1">${ eleves[s4.index] }</a></p>
														</c:forEach>
														<p><a href="PlanningEleve?groupe=${ groupes_id[s3.index] }">[Planning]</a></p>
													</div>
													<script>hideEleves('f${ i }${ elt }${ apps_id[s2.index] }${ groupes_id[s3.index] }','${ groupes_id[s3.index] }');</script>
												</p></c:forEach>
											</div>
											<script>hideGroupes('f${ i }${ elt }${ apps_id[s2.index] }','${ apps_id[s2.index] }');</script>
										</p></c:if></c:forEach>
									</div>
									<script>hideApps('f${ i }${ elt }','${ elt }');</script>
								</p></c:forTokens>
							</div>
							<script>hideRoles('f${ i }','${ i }');</script>
						</div>
					</c:forEach>
				<div class="aside-app" id="groupeAjout">
					<p><a href="EditionPlanning">Ajouter planning</a></p>
				</div>
			    <div class="aside-app" id="groupeAjout">
					<p><a href="AjoutGroupe">Ajouter groupe</a></p>
				</div>
			    <div><a href = "#" class="aside-app" id="groupe" onClick='selectionElementGrille("groupe","nomGroupe");'><img src = "pictures/minus.png"/> Groupe</a></div>
			    <div id="nomGroupe" style="display:none;">
			    <c:forEach items="${groupeTabId }" var="groupeInd" varStatus="iterator">
						<div><a href="GestionGroupe?id_groupe=${groupeInd }">${groupeTabNom[iterator.index]}</a></div>
					</c:forEach>
			    </div>
			    <div class="aside-app" id="editionPlan">
					<p><a id="lienEditionPlan" href="EditionPlanning">Edition des plannings élève</a></p>
				</div>
				     <div class="aside-app" id="ajoutCompPrin">
					    	<p><a id="ajoutCompPrin" href="CreationCompetencePrincipale">Ajouter un modèle de compétence principale</a></p>
					    </div>
					    <div class="aside-app" id="ajoutCompSec">
					    	<p><a id="ajoutCompSec" href="CreationCompetenceSecondaire">Ajouter un modèle de compétence secondaire</a></p>
					    </div>
				    <div class="aside-app" id="ajoutUtilisateur">
					    <p><a id="ajoutCompSec" href="CreationUtilisateur">Ajouter un utilisateur</a></p>
					</div>
				</menu>
		
				<section class="col-md-9">
					<span>${resultatForm }</span>
				</section>
			</div>
		</div>

		<jsp:include page = "footer.jsp" />
		
		<script>
			var number = 2015;
			while (number < 2030) {
				//displ('aside-category'+number);
				number++;
			}
		</script>
	</body>

</html> 
