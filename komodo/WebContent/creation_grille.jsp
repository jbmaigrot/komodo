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
		<title>Creation grille</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
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
	 </head>
	 <jsp:include page = "header.jsp"/> 
	 <body>

		<div class="container">

			<div class="row">
				<menu class="col-md-3">
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
					<h1>Nouvel APP</h1>
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
									<div class="comp" id="comp${boucle.count}" >
										<div class="comp_princip" id="comp_princip${boucle.count }" <c:choose><c:when test = "${valide[boucle.count] == false}"> style="display:none;"</c:when> <c:when test = "${valide[boucle.count] == true}"> style="display:'';" </c:when></c:choose> onClick='selectionElementGrille("comp_princip${boucle.count}","comp_Sec${boucle.count }");'>${nomCompPrincipInd}</div>
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
			</div>
		</div>
	</body>
	    <jsp:include page = "footer.jsp" />
</html>