<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Creation grille</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	 </head>
	 <body>
	 	<header>
	    	<h1>SITE WEB APP</h1>
	    	<div>
	    		<a href="#">Thomas (mon profil)</a>
	    		<a href="#">Déconnexion</a>
	    	</div>
		</header>
		<script>
					function selection(id_tab,id_comp,id_comp_sec) {
						//alert(document.getElementById(id_tab).disabled);
						//Cas navigateur uniquement
						var cible = document.getElementById(id_comp);
						var cible_sec = document.getElementById(id_comp_sec);
						if (document.getElementById(id_tab).disabled == undefined || document.getElementById(id_tab).disabled == false){
						    cible.style.display = '';
							document.getElementById(id_comp).innerHTML = document.getElementById(id_tab).innerHTML;
							document.getElementById(id_tab).disabled = true;
							//alert(document.getElementById(id_tab).disabled);
						}else {
						
						       cible.style.display = 'none';
						       cible_sec.style.display = 'none';
							//document.getElementById(id_comp).innerHTML = "";
							document.getElementById(id_tab).disabled = false;
							//alert(document.getElementById(id_tab).disabled);
						}
					}
					function selectionCompSec(id_comp,id_comp_sec){
					
						var cible = document.getElementById(id_comp_sec);
						if (document.getElementById(id_comp).disabled == undefined || document.getElementById(id_comp).disabled == false){
							if(cible.style.display != '')
					        	cible.style.display = '';
					    	else 
					       		cible.style.display = 'none';
						}
					}
					function selectionCritere(id_comp_sec,id_critere){
						var cible = document.getElementById(id_critere);
						if (document.getElementById(id_comp_sec).disabled == undefined || document.getElementById(id_comp_sec).disabled == false){
							if(cible.style.display != ''){
					        	cible.style.display = '';
							}
					    	else {
					       		cible.style.display = 'none';
					    	}
						}
					}
					
					function affichageListeCoefficient(sel, coef){
						//alert("g");
						if (sel.size != coef){
							//alert("gigi");
			           		sel.size = coef;
						}
						else
							sel.size = '1';
			
			           }
					
					function clickGrille(grille,nomGrille){
						//alert("gigi");
						var cible = document.getElementById(nomGrille);
						if (document.getElementById(grille).disabled == undefined || document.getElementById(nomGrille).disabled == false){
							//alert("gogo");
							if(cible.style.display != ''){
								//alert("false");
					        	cible.style.display = '';
							}
					    	else {
					    		//alert("true");
					       		cible.style.display = 'none';
					    	}
						}
					}
					
					function ajoutGrille(ajoutGrille,form){
						var cible = document.getElementById(form);
						if (document.getElementById(ajoutGrille).disabled == undefined || document.getElementById(ajoutGrille).disabled == false){
							//alert("gogo");
							if(cible.style.display != ''){
								//alert("false");
					        	cible.style.display = '';
							}
					    	else {
					    		//alert("true");
					       		cible.style.display = 'none';
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
					<p><a href="CreationGrille">Ajouter</a></p>
				</div>
				<div class="aside-app" id="grille" onClick='clickGrille("grille","nomGrille");'>Grille APP</div>
				<div id="nomGrille" style="display:none;">
					<c:forEach items="" var="GrilleInd" varStatus="boucle">
						<p><a href="ModifierGrille"></a></p>
					</c:forEach>
				</div>
			</aside>
	
				<section>
				<form method="post" action="CreationGrille">
					<p>
						<label>Nom APP : </label><input type="text" name="nom_grille" value="<c:out value="${param.nom_grille }"/>"/>
				 		<span class="erreur">${erreurs['nom_grille']}</span>
					</p>
					
					<p>
						<label>Promo : </label><select name="promo" size="1" onclick="affichageListeCoefficient(this, '4');">
						<option disabled selected >Promo</option>
						<c:forEach var="i" begin="2015" end ="2050" step="1">
							<option value="${ i}"><c:out value="${ i }" /> </option>
						</c:forEach>
						</select>
						<span class="erreur">${erreurs['promo']}</span>
					</p>
					<p>Compétence(s) principale(s)</p>
					<c:forEach items="${ nomCompPrincip }" var="nomCompPrincipInd" varStatus="boucle">
						<p>
							<label id="tab${boucle.count}">${ nomCompPrincipInd }</label><input type="checkbox" name ="tab${boucle.count}" value = "${nomCompPrincipInd}" onclick='selection("tab${boucle.count}","comp_princip${boucle.count }","comp_Sec${boucle.count }");' />
						</p>
					</c:forEach>
					<span class="erreur">${erreurs['tab1']}</span>
					
					<div id="content">
						<c:forEach items="${ nomCompPrincip }" varStatus="boucle">
			  				<div id="tabs">
								<div class="comp${boucle.count }" ><a href="#" id="comp_princip${boucle.count }" style="display:none;" onClick='selectionCompSec("comp_princip${boucle.count}","comp_Sec${boucle.count }");'></a>
									<div id="comp_Sec${boucle.count }" style="display:none;">
									<p>Compétence(s) secondaire(s)</p>
										<c:forEach items="${ nomCompSec }" var="nomCompSecInd" varStatus="boucleSec">
											<label id="compSec${boucle.count }${boucleSec.count }">${nomCompSecInd}</label><input type="checkbox" name="compSec${boucle.count }${boucleSec.count}" value = "${nomCompSecInd}" onClick='selectionCritere("compSec${boucle.count}${boucleSec.count }","critere${boucle.count }${boucleSec.count }");'>
											<div id = "critere${boucle.count }${boucleSec.count}" style="display:none;">
												<p> Critère de sélection : <textarea rows="5" cols="50" name="critere${boucle.count }${boucleSec.count}" ></textarea></p>
												<p> Pondération : 
													<select name="ponderation${boucle.count }${boucleSec.count}" size="1" onclick="affichageListeCoefficient(this, '4');">
														<option disabled selected >Coefficient</option>
														<c:forEach var="i" begin="1" end ="30" step="1">
															<option value="${ i}"><c:out value="${ i }" /> </option>
														</c:forEach>
													</select>
												</p>
											</div>
										</c:forEach>
									</div>
								</div>
							</div>
						</c:forEach>
			
						<c:forEach items="${compte}" var = "compteUni">
							<c:if test="${not empty compteUni }">
								<span>${erreurs[compteUni]}</span>
								<br>
							</c:if>			
						</c:forEach>
						<br>
						<c:forEach items="${compteCritere}" var = "compteCritereUni">
							<c:if test="${not empty compteCritereUni }">
								<span>${erreurs[compteCritereUni]}</span>
								<br>
							</c:if>				
						</c:forEach>
						<br>
						<c:forEach items="${comptePonderation}" var = "comptePonderationUni">
							<c:if test="${not empty comptePonderationUni }">
								<span>${erreurs[comptePonderationUni]}</span>
								<br>
							</c:if>				
						</c:forEach>
						
					</div>
					<input type="submit" name="Submit" value="Valider" id="submit">
				</form>
				<span>${resultatForm }</span>					
			</section>
		</div>
	</body>
	<footer>
		<div><a href="#">CGU</a></div>
		<div><a href="#">FAQ</a></div>
		<div><a href="#">Nous contacter</a></div>
	</footer>
</html>