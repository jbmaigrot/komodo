<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<title>Prof</title>

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
		
		<script type="text/javascript">
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
		
		function modifLink(){
			var obj=document.getElementsByClassName("link");
			for (i = 0; i < obj.length; i++) {
				//alert(obj[i].href);
				obj[i].href = obj[i].href.replace("eleve=0", "eleve="+get("eleve"));
				obj[i].href = obj[i].href.replace("grille=0", "grille="+get("grille"));
				//alert(obj[i].href);
			}
		}
		
		function modifLink2(){
			var obj=document.getElementsByClassName("link2");
			for (i = 0; i < obj.length; i++) {
				//alert(obj[i].href);
				obj[i].action = obj[i].action.replace("eleve=0", "eleve="+get("eleve"));
				obj[i].action = obj[i].action.replace("grille=0", "grille="+get("grille"));
				obj[i].action = obj[i].action.replace("competence=0", "competence="+get("competence"));
				//alert(obj[i].href);
			}
		}
		
		</script>
	 </head>

	 <body>

		<jsp:include page = "header.jsp" />
		
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
					<div class="aside-app">
						<p><a href="CreationGrille">Ajouter</a></p>
					</div>
					<div id="grille" onClick='clickGrille("grille","nomGrille");'>Grille APP</div>
					<div id="nomGrille" style="display:none;">
						<c:forEach items="${ nomGrille }" var="nomGrilleInd" varStatus="boucle">
							<p><a href="#">${nomGrilleInd}</a></p>
						</c:forEach>
					</div>
				</menu>
				
				<section class="col-md-9">
					<h2>Promo 2018 &gt; Tuteur &gt; APP électronique &gt; Groupe APP A &gt; Léo</h2>
					<div id="content">
						<div id="tabs">
							<c:forEach items="${ compprinc }" varStatus="i">
							<div class="tab"><a class="link" href="AffichageTeacher?eleve=0&grille=0&competence=${ compprinc_id[i.index] }">${ compprinc[i.index] }</a></div>
							</c:forEach>
						</div>
						<div>
							<table class="grid">
								<tr>
									<th></th>
									<th>Commentaire au prof</th>
									<th>Commentaire à l'élève</th>
									<th>Commentaire de groupe</th>
									<th>
										Niveau de compétence<br>
										<div class="skill-levels">
											<div class="skill-level">Loin</div>
											<div class="skill-level">Proche</div>
											<div class="skill-level">Très proche</div>
											<div class="skill-level">Attendu</div>
											<div class="skill-level">Au-delà</div>
											<div class="skill-level">[Evaluation]</div>
										</div>
									</th>
								</tr>
								
								<c:set var="loin" value="loin" scope="page" />
								<c:set var="proche" value="proche" scope="page" />
								<c:set var="tproche" value="tproche" scope="page" />
								<c:set var="attendu" value="attendu" scope="page" />
								<c:set var="audela" value="audela" scope="page" />
								
								<c:set var="J" value="Jugement global" scope="page" />
								<c:forEach items="${ competences }" varStatus="li">
								<c:if test="${ noms[li.index] == J }" var="variable">
								<tr>
									<td>
										<div class="skill">${ noms[li.index] }</div>
										<div class="criteria">
											${ criteres[li.index] }
										</div>
									</td>
									<td>
										<form id="frm_${ li.index }" class="link2" method="POST" action="AffichageTeacher?eleve=0&grille=0&competence=0&modif=${ id_noms[li.index] }&cp=1#frm_${ li.index }">
											<textarea name="value" id="value">${ cp[ligne.index] }</textarea>
											<input type="submit" value="Modifier" />
										</form>
									</td>
									<td>
										<form id="frm_${ li.index }" class="link2" method="POST" action="AffichageTeacher?eleve=0&grille=0&competence=0&modif=${ id_noms[li.index] }&ci=1#frm_${ li.index }">
											<textarea name="value" id="value">${ ci[li.index] }</textarea>
											<input type="submit" value="Modifier" />
										</form>
									</td>
									<td>
										<form id="frm_${ li.index }" class="link2" method="POST" action="AffichageTeacher?eleve=0&grille=0&competence=0&modif=${ id_noms[li.index] }&cg=1#frm_${ li.index }">
											<textarea name="value" id="value">${ cg[li.index] }</textarea>
											<input type="submit" value="Modifier" />
										</form>
									</td>
									<td>
										<div class="skill-levels">
											<c:if test="${ the_evaluation == loin }" var="variable">
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ the_evaluation == proche }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ the_evaluation == tproche }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ the_evaluation == attendu }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ the_evaluation == audela }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
											</c:if>
											<c:if test="${ the_evaluation != loin && the_evaluation != proche && the_evaluation != tproche && the_evaluation != attendu && the_evaluation != audela }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<div class="skill-level-cell">Modifier</div>
										</div>
									</td>
								</tr>
								</c:if>
								</c:forEach>
								
								<c:forEach items="${ competences }" varStatus="ligne"><c:if test="${ noms[ligne.index] != J }" var="variable">
								<tr>
									<td>
										<div class="skill">${ noms[ligne.index] }</div>
										<div class="criteria">
											${ criteres[ligne.index] }
										</div>
									</td>
									<td>
										<form id="frm_${ ligne.index }" class="link2" method="POST" action="AffichageTeacher?eleve=0&grille=0&competence=0&modif=${ id_noms[ligne.index] }&cp=1#frm_${ ligne.index }">
											<textarea name="value" id="value">${ cp[ligne.index] }</textarea>
											<input type="submit" value="Modifier" />
										</form>
									</td>
									<td>
										<form id="frm_${ ligne.index }" class="link2" method="POST" action="AffichageTeacher?eleve=0&grille=0&competence=0&modif=${ id_noms[ligne.index] }&ci=1#frm_${ ligne.index }">
											<textarea name="value" id="value">${ ci[ligne.index] }</textarea>
											<input type="submit" value="Modifier" />
										</form>
									</td>
									<td>
										<form id="frm_${ ligne.index }" class="link2" method="POST" action="AffichageTeacher?eleve=0&grille=0&competence=0&modif=${ id_noms[ligne.index] }&cg=1#frm_${ ligne.index }">
											<textarea name="value" id="value">${ cg[ligne.index] }</textarea>
											<input type="submit" value="Modifier" />
										</form>
									</td>
									<td><form class="link2" method="POST" action="AffichageTeacher?eleve=0&grille=0&competence=0&modif=${ id_noms[ligne.index] }&ev=1#frm_${ ligne.index }">
										<div class="skill-levels">
											<c:if test="${ evaluations[ligne.index] == loin }" var="variable">
												<div class="skill-level-cell"><input checked type="radio" name="eval${ 1+ligne.index }" value="loin" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="proche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="tproche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="attendu" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="audela" id="${ ligne.index }" /></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == proche }" var="variable">
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="loin" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input checked type="radio" name="eval${ 1+ligne.index }" value="proche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="tproche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="attendu" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="audela" id="${ ligne.index }" /></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == tproche }" var="variable">
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="loin" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="proche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input checked type="radio" name="eval${ 1+ligne.index }" value="tproche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="attendu" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="audela" id="${ ligne.index }" /></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == attendu }" var="variable">
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="loin" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="proche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="tproche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input checked type="radio" name="eval${ 1+ligne.index }" value="attendu" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="audela" id="${ ligne.index }" /></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == audela }" var="variable">
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="loin" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="proche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="tproche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="attendu" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input checked type="radio" name="eval${ 1+ligne.index }" value="audela" id="${ ligne.index }" /></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] != loin && evaluations[ligne.index] != proche && evaluations[ligne.index] != tproche && evaluations[ligne.index] != attendu && evaluations[ligne.index] != audela }" var="variable">
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="loin" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="proche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="tproche" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="attendu" id="${ ligne.index }" /></div>
												<div class="skill-level-cell"><input type="radio" name="eval${ 1+ligne.index }" value="audela" id="${ ligne.index }" /></div>
											</c:if>
											<div class="skill-level-cell"><input type="submit" value="Modifier"></div>
										</div>
									</form></td>
								</tr></c:if>
								</c:forEach>
							</table>
						</div>
					</div>
				</section>
			</div>
		</div>

		<jsp:include page = "footer.jsp" />
		<script>modifLink();</script>
		<script>modifLink2();</script>
	</body>

</html> 
