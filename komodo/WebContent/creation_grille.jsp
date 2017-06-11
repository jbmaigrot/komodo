<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<title>Création grille</title>

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
			function selection(check_tab,id_comp,id_comp_sec,id_checkbox_sec,id_critere,id_ponderation,tabComp,tabCritere) 
			{
				var cible = document.getElementById(id_comp);
				var cible_sec = document.getElementById(id_comp_sec);
				//var cible_critere = document.getElementById(tabCritere);
				//var cible_critere = document.getElementById(id_critere);
				//var cible_ponderation = document.getElementById(id_ponderation);
				
				// cas navigateur pour undefined.
				if (document.getElementById(check_tab).checked == true)
				{
					cible.style.display = '';
					//document.getElementById(id_comp).innerHTML = document.getElementById(id_tab).innerHTML;
					//document.getElementById(id_tab).disabled = true;
				}
				else
				{
					alert("toto");
					cible.style.display = 'none';
					 cible_sec.style.display = 'none';
					var i;
					alert(tabComp);
					for (i = 1;i<=tabComp;i++){
						alert(tabComp);
			   			document.getElementById(id_critere+i).innerHTML = "";
			   			document.getElementById(id_ponderation+i).options[0].selected = true;
		    			document.getElementById(id_checkbox_sec+i).checked = false;
		    			document.getElementById(tabCritere+i).style.display = 'none';
		    		}
				}
			}
			
			function selectionElementGrille(id_element,id_element_sec){
				var cible = document.getElementById(id_element_sec);
				if (document.getElementById(id_element).disabled == undefined || document.getElementById(id_element).disabled == false)
				{
					if(cible.style.display != '')
			       		cible.style.display = '';
			 		else
			 		{
						cible.style.display = 'none';
		    			//document.getElementById(id_element_sec).innerHTML = "";
		       			//cible.style.display = 'none';
		    		}
				}
			}
		
			
			function selectionElementGrilleSec(id_element,id_element_sec,id_critere,id_ponderation)
			{
					
				var cible = document.getElementById(id_element_sec);
				var cible_critere = document.getElementById(id_critere);
				var cible_ponderation = document.getElementById(id_ponderation);
				if (document.getElementById(id_element).disabled == undefined || document.getElementById(id_element).disabled == false)
				{
					if(cible.style.display != ''){
			        	cible.style.display = '';
					}
			    	else{
			    		document.getElementById(id_critere).innerHTML = "";
			    		document.getElementById(id_ponderation).options[0].selected = true;
			    		//document.getElementById(id_ponderation).value = null;
			    		//document.getElementById(id_ponderation).options[document.getElementById(id_ponderation).selectedIndex].text = document.getElementById(id_ponderation).options[0];
			       		cible.style.display = 'none';
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
						<p><a id="ajout" href="#creation" onClick='selectionElementGrille("ajout","creation");'>Ajouter Grille</a></p>
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
				    	<p><a id="ajoutCompSec" href="CreationUtilisateur">Ajouter un utilisateur</a></p>
					</div>
				</menu>
		
				<section class="col-md-9">
					<div id="creation">
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
							
							<h3>Compétence(s) principale(s)</h3>
							<div class="scroll">
								<c:forEach items="${ nomCompPrincip }" var="nomCompPrincipInd" varStatus="boucle">
									<c:set var="tabNum" value="tab${boucle.count }"/>
									<p>
										<label id="tab${boucle.count}">${ nomCompPrincipInd }</label><input type="checkbox" name ="${tabNum}" value = "${nomCompPrincipInd}" id="checkbox${tabNum }"<c:if test = "${param[tabNum] == nomCompPrincipInd}">checked = "checked" </c:if> onclick='selection("checkbox${tabNum}","comp_princip${boucle.count }","comp_Sec${boucle.count }","checkboxCompSec${boucle.count }","critereCompSec${boucle.count }","ponderation${boucle.count }", ${nomCompSec.size()}, "critere${boucle.count }");'/>
									</p>
								</c:forEach>
								<span class="erreur">${erreurs['tab1']}</span>
							</div>
							
							<h4>Compétence(s) secondaire(s)</h4>
							<div class="scroll">
								<c:forEach items="${ nomCompPrincip }" var="nomCompPrincipInd" varStatus="boucle">
								<c:set var = "tabComp" value="checkboxtab${boucle.count }"/>
									<div class="comp${boucle.count}" >
										<a href="#comp_Sec${boucle.count }" id="comp_princip${boucle.count }" <c:choose><c:when test = "${valide[boucle.count] == false}"> style="display:none;"</c:when> <c:when test = "${valide[boucle.count] == true}"> style="display:'';" </c:when></c:choose> onClick='selectionElementGrille("comp_princip${boucle.count}","comp_Sec${boucle.count }");'>
											<img src="pictures/arrow.png"/>
											${nomCompPrincipInd}
										</a>
										<div id="comp_Sec${boucle.count }" <c:choose><c:when test = "${valide[boucle.count] == false}"> style="display:none;"</c:when> <c:when test = "${valide[boucle.count] == true}"> style="display:'';"</c:when></c:choose>>
											<c:forEach items="${ nomCompSec }" var="nomCompSecInd" varStatus="boucleSec">
											<c:set var="tabNumCompSecond" value="compSec${boucle.count }${boucleSec.count}"/>
											<c:set var="tabNumCompSecErreur" value="compSec${boucle.count }1"/>
											<c:set var="tabNumCritere" value="critere${boucle.count }${boucleSec.count}"/>
											<c:set var="tabNumPonderation" value="ponderation${boucle.count }${boucleSec.count }"/>
											<div>
												<label id="compSec${boucle.count }${boucleSec.count }">${nomCompSecInd}</label><input type="checkbox" name="${tabNumCompSecond }" value ="${nomCompSecInd}" id="checkboxCompSec${boucle.count }${boucleSec.count}"<c:if test = "${param[tabNumCompSecond] == nomCompSecInd}">checked = "checked" </c:if> onClick='selectionElementGrilleSec("compSec${boucle.count}${boucleSec.count }","critere${boucle.count }${boucleSec.count }","critereCompSec${boucle.count }${boucleSec.count }","ponderation${boucle.count }${boucleSec.count }");' >
												<div id = "critere${boucle.count }${boucleSec.count}" <c:choose><c:when test = "${valideSec[boucle.count][boucleSec.count] == false}"> style="display:none;"</c:when> <c:when test = "${valideSec[boucle.count][boucleSec.count] == true}"> style="display:'';" </c:when></c:choose>>
													<p> Critère de sélection : <textarea rows="5" cols="50" name="${tabNumCritere}" id="critereCompSec${boucle.count}${boucleSec.count}" ><c:out value="${param[tabNumCritere]}"/></textarea></p>
													<span>${erreurs[tabNumCritere]}</span>
													<p> Pondération : 
														<select name="${tabNumPonderation}" size="1" id="ponderation${boucle.count}${boucleSec.count}" onclick="affichageListeCoefficient(this, '4');">
															<option disabled selected>Coefficient</option>
															<c:forEach var="i" begin="1" end ="30" step="1">
																<option value="${ i}" <c:if test = "${param[tabNumPonderation] == i}">selected</c:if>><c:out value="${ i }" /> </option>
															</c:forEach>
														</select>
													</p>
													<span>${erreurs[tabNumPonderation]}</span>
												</div>
											</div>
												
											</c:forEach>
											<br>
											<span>${erreurs[tabNumCompSecErreur]}</span>
										</div>
									</div>
								</c:forEach>
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