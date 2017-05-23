<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Modification grille</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	 </head>
	 <body>
	 <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
	 	<jsp:include page="header.jsp"/>
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
			 		else{
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

		<div id="page">
			<aside>
				<div class="aside-promo">
					<p id="promo1"><img src="pictures/minus.png"/>Promo 2018</p>
					<div class="aside-category">
						<p id="category1"><img src="pictures/minus.png"/>Tuteur</p>
						<div class="aside-app">
							<p id="app1"><img src="pictures/minus.png"/>APP �lectronique</p>
							<div class="aside-group">
								<p id="group1"><img src="pictures/minus.png"/>Groupe APP A</p>
								<div class="aside-student">
									<p id="student1">L�o<p>
									<p>Fran�ois</p>
									<p>G�rard</p>
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
			</aside>
		</div>
		<section>
		<form method="post" action="ModifierGrille">
		<input type="hidden" name="id" value="${id }"/>
 		<div>
				<label>Nom APP : </label><input type="text" name="nom_grille" value='<c:out value="${grilleNom}"/>' id="nom_grille" />
				<span class="erreur">${erreurs['nom_grille']}</span>
		</div>
		<p>
			<label>Promo : </label><select name="promo" size="1" onclick="affichageListeCoefficient(this, '4');" >
			<option disabled selected >Promo</option>
			<c:forEach var="i" begin="2015" end ="2050" step="1">
					
				<option value="${ i}" <c:if test = "${grillePromo == i}">selected</c:if>><c:out value="${ i }" /> </option>
			</c:forEach>
			</select>
			<span class="erreur">${erreurs['promo']}</span>
		</p>
		
		<p>Comp�tence(s) principale(s)</p>
				<c:forEach items="${ nomCompPrincip }" var="nomCompPrincipInd" varStatus="boucle">
					<c:set var="tabNum" value="tab${boucle.count }"/>
					<p>
						<label id="tab${boucle.count}">${ nomCompPrincipInd }</label><input type="checkbox" name ="${tabNum}" value = "${nomCompPrincipInd}" id="checkbox${tabNum }" <c:forEach items="${resultatNomCompPrincip }" var="resultatNomCompPrincipInd" varStatus="boucleResultatComp"> <c:if test = "${resultatNomCompPrincipInd == nomCompPrincipInd}">checked = "checked" </c:if></c:forEach> onclick='selection("checkbox${tabNum}","comp_princip${boucle.count }","comp_Sec${boucle.count }","checkboxCompSec${boucle.count }","critereCompSec${boucle.count }","ponderation${boucle.count }", ${nomCompSec.size()}, "critere${boucle.count }");'/>
					</p>
				</c:forEach>
				<span class="erreur">${erreurs[tabNum]}</span>
		<div id="content">
		<c:set var="compteTest2" value="-1"/>
					<c:forEach items="${ nomCompPrincip }" var="nomCompPrincipInd" varStatus="boucle">
					<c:set var = "tabComp" value="checkboxtab${boucle.count }"/>
		  				<div id="tabs">
							<div class="comp${boucle.count}" ><a href="#" id="comp_princip${boucle.count }" onClick='selectionElementGrille("comp_princip${boucle.count}","comp_Sec${boucle.count }");'>${nomCompPrincipInd}</a>
								<div id="comp_Sec${boucle.count }">
							<c:set var="compte" value="-1"/>
								<p>Comp�tence(s) secondaire(s)</p>
									<c:forEach items="${ nomCompSec }" var="nomCompSecInd" varStatus="boucleSec">
									<c:set var="tabNumCompSecond" value="compSec${boucle.count }${boucleSec.count}"/>
									<c:set var="tabNumCompSecErreur" value="compSec${boucle.count }1"/>
									<c:set var="tabNumCritere" value="critere${boucle.count }${boucleSec.count}"/>
									<c:set var="tabNumPonderation" value="ponderation${boucle.count }${boucleSec.count }"/>
									<c:set var="tabNumPonderation" value="${resultatNomComp }"/>
									<c:set var="compteTest" value="-1"/>
										<label id="compSec${boucle.count }${boucleSec.count }">${nomCompSecInd}</label> <input type="checkbox" name="${tabNumCompSecond }" value ="${nomCompSecInd}" id="checkboxCompSec${boucle.count }${boucleSec.count}" <c:forTokens items="${resultatNomCompPrincip }" delims=", " varStatus="boucleResult" ><c:forEach items="${resultatNomCompSec }" var="resultatNomCompSecInd" varStatus="boucleResultCompSec"><c:if test="${resultatNomCompPrincip[boucleResult.count-1] == nomCompPrincipInd && resultatNomCompSecInd == nomCompSecInd && resultatIdNomCompPrincip[boucleResult.count -1] == resultatIdNomCompSec[boucleResultCompSec.count-1]}" ><c:set var="compteTest2" value="${compteTest2 + 1 }"/>checked="checked"</c:if></c:forEach></c:forTokens> onclick='selectionElementGrilleSec("compSec${boucle.count}${boucleSec.count }","critere${boucle.count }${boucleSec.count }","critereCompSec${boucle.count }${boucleSec.count }","ponderation${boucle.count }${boucleSec.count }");'>
									<c:set var ="CompteCritere" value="0"/>
										<div id = "critere${boucle.count }${boucleSec.count}" <c:choose><c:when test = "${valideSec[boucle.count][boucleSec.count] == false}"> style="display:none;"</c:when> <c:when test = "${valideSec[boucle.count][boucleSec.count] == true}"> style="display:'';" </c:when></c:choose>>
											<p> Crit�re de s�lection : <textarea rows="5" cols="50" name="${tabNumCritere}" id="critereCompSec${boucle.count}${boucleSec.count}"><c:forTokens items="${resultatNomCompPrincip }" delims=", " varStatus="boucleResult" ><c:forEach items="${resultatNomCompSec }" var="resultatNomCompSecInd" varStatus="boucleResultCompSec"><c:if test="${resultatNomCompPrincip[boucleResult.count-1] == nomCompPrincipInd && resultatNomCompSecInd == nomCompSecInd && resultatIdNomCompPrincip[boucleResult.count-1] == resultatIdNomCompSec[boucleResultCompSec.count-1]}"><c:out value="${resultatCompCritere[compteTest2] }"/></c:if></c:forEach></c:forTokens></textarea></p>
											
											<p> Pond�ration : 
												<select name="${tabNumPonderation}" size="1" id="ponderation${boucle.count}${boucleSec.count}" onclick="affichageListeCoefficient(this, '4');">
													<option disabled selected>Coefficient</option>
													<c:forEach var="i" begin="1" end ="30" step="1">
														
														  <option value="${ i}" <c:forTokens items="${resultatNomCompPrincip }" delims=", " varStatus="boucleResult" ><c:forEach items="${resultatNomCompSec }" var="resultatNomCompSecInd" varStatus="boucleResultCompSec"><c:if test="${resultatNomCompPrincip[boucleResult.count-1] == nomCompPrincipInd && resultatNomCompSecInd == nomCompSecInd && resultatIdNomCompPrincip[boucleResult.count -1] == resultatIdNomCompSec[boucleResultCompSec.count-1]}" ><c:if test="${resultatCompPonderation[compteTest2] == i }"> selected</c:if></c:if></c:forEach></c:forTokens>><c:out value="${ i }" /> </option>
													</c:forEach>
												</select>
											</p>
											
										</div>
										
									</c:forEach>
									<br>
									<!--  <span>${erreurs[tabNumCompSecErreur]}</span> -->
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<input type="submit" name="Submit" value="Valider" id="Submit" >
</form>
		</section>
</body>
<jsp:include page="footer.jsp"/>
</html>