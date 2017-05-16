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
					
			function affichageListeCoefficient(sel, coef)
			{
				if (sel.size != coef)
	           		sel.size = coef;
				else
					sel.size = '1';
	        }
		</script>

		<div id="page">
			<menu>
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
				<div class="aside-app" id="grille" onClick='selectionElementGrille("grille","nomGrille");'>Grille APP</div>
				<div id="nomGrille" style="display:none;">
					<c:forEach items="${grilleTabId }" var="grilleInd" varStatus="iterator">
						<p><a href="ModifierGrille?id=${grilleInd }">${grilleTabNom[iterator.index]}</a></p>
					</c:forEach>
				</div>
			</menu>
		</div>
		
		<section>
			<form method="post" action="CreationGrille">
				<div>
					<label>Nom APP : </label><input type="text" name="nom_grille" value='<c:out value="${param.nom_grille}"/>' id="nom_grille" />
			 		<span class="erreur">${erreurs['nom_grille']}</span>
				</div>
				
				<p>
					<label>Promo : </label><select name="promo" size="1" onclick="affichageListeCoefficient(this, '4');" >
					<option disabled selected >Promo</option>
					<c:forEach var="i" begin="2015" end ="2050" step="1">
					
						<option value="${ i}" <c:if test = "${param.promo == i}">selected</c:if>><c:out value="${ i }" /> </option>
					</c:forEach>
					</select>
					<span class="erreur">${erreurs['promo']}</span>
				</p>
				
				<p>Compétence(s) principale(s)</p>
				<c:forEach items="${ nomCompPrincip }" var="nomCompPrincipInd" varStatus="boucle">
					<c:set var="tabNum" value="tab${boucle.count }"/>
					<p>
						<label id="tab${boucle.count}">${ nomCompPrincipInd }</label><input type="checkbox" name ="${tabNum}" value = "${nomCompPrincipInd}" id="checkbox${tabNum }"<c:if test = "${param[tabNum] == nomCompPrincipInd}">checked = "checked" </c:if> onclick='selection("checkbox${tabNum}","comp_princip${boucle.count }","comp_Sec${boucle.count }");'/>
					</p>
				</c:forEach>
				<span class="erreur">${erreurs['tab1']}</span>
				
				<div id="content">
					<c:forEach items="${ nomCompPrincip }" var="nomCompPrincipInd" varStatus="boucle">
		  				<div id="tabs">
							<div class="comp${boucle.count}" ><a href="#" id="comp_princip${boucle.count }" <c:choose><c:when test = "${valide[boucle.count] == false}"> style="display:none;"</c:when> <c:when test = "${valide[boucle.count] == true}"> style="display:'';" </c:when></c:choose> onClick='selectionElementGrille("comp_princip${boucle.count}","comp_Sec${boucle.count }");'>${nomCompPrincipInd}</a>
								<div id="comp_Sec${boucle.count }" <c:choose><c:when test = "${valide[boucle.count] == false}"> style="display:none;"</c:when> <c:when test = "${valide[boucle.count] == true}"> style="display:'';"</c:when></c:choose>>
								<p>Compétence(s) secondaire(s)</p>
									<c:forEach items="${ nomCompSec }" var="nomCompSecInd" varStatus="boucleSec">
									<c:set var="tabNumCompSecond" value="compSec${boucle.count }${boucleSec.count}"/>
									<c:set var="tabNumCompSecErreur" value="compSec${boucle.count }1"/>
									<c:set var="tabNumCritere" value="critere${boucle.count }${boucleSec.count}"/>
									<c:set var="tabNumPonderation" value="ponderation${boucle.count }${boucleSec.count }"/>
										<label id="compSec${boucle.count }${boucleSec.count }">${nomCompSecInd}</label><input type="checkbox" name="${tabNumCompSecond }" value ="${nomCompSecInd}" <c:if test = "${param[tabNumCompSecond] == nomCompSecInd}">checked = "checked" </c:if> onClick='selectionElementGrille("compSec${boucle.count}${boucleSec.count }","critere${boucle.count }${boucleSec.count }");' >
										<div id = "critere${boucle.count }${boucleSec.count}" <c:choose><c:when test = "${valideSec[boucle.count][boucleSec.count] == false}"> style="display:none;"</c:when> <c:when test = "${valideSec[boucle.count][boucleSec.count] == true}"> style="display:'';" </c:when></c:choose>>
											<p> Critère de sélection : <textarea rows="5" cols="50" name="${tabNumCritere}"><c:out value="${param[tabNumCritere] }"/></textarea></p>
											<span>${erreurs[tabNumCritere]}</span>
											<p> Pondération : 
												<select name="${tabNumPonderation}" size="1" onclick="affichageListeCoefficient(this, '4');">
													<option disabled selected >Coefficient</option>
													<c:forEach var="i" begin="1" end ="30" step="1">
														<option value="${ i}" <c:if test = "${param[tabNumPonderation] == i}">selected</c:if>><c:out value="${ i }" /> </option>
													</c:forEach>
												</select>
											</p>
											<span>${erreurs[tabNumPonderation]}</span>
										</div>
										
									</c:forEach>
									<br>
									<span>${erreurs[tabNumCompSecErreur]}</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<input type="submit" name="Submit" value="Valider" id="Submit" >
			</form>
			<span>${resultatForm }</span>					
		</section>
	</body>
	<footer>
		<div><a href="#">CGU</a></div>
		<div><a href="#">FAQ</a></div>
		<div><a href="#">Nous contacter</a></div>
	</footer>
</html>