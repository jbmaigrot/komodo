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
		<title>ElÃ¨ve</title>

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
		
		</script>
	 </head>

	 <body>

	 	<jsp:include page = "header.jsp" />
		
		<div class="container white">
			<div class="row">
				<menu class="col-md-3">
					<div class="aside-promo">
						<p><a id="ajout" href="ArborescenceEleve">Retour vers l'arborescence</a></p>
					</div>
				</menu>

				<section class="col-md-9">
					<h2></h2>
					<div id="content">
						<div id="tabs">
							<c:forEach items="${ compprinc }" varStatus="i">
							<a class="tab link" href="AffichageEleve?eleve=0&grille=0&competence=${ compprinc_id[i.index] }">${ compprinc[i.index] }</a>
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
											<div class="skill-level">Au-delà </div>
										</div>
									</th>
								</tr>
								<c:set var="loin" value="loin" scope="page" />
								<c:set var="proche" value="proche" scope="page" />
								<c:set var="tproche" value="tproche" scope="page" />
								<c:set var="attendu" value="attendu" scope="page" />
								<c:set var="audela" value="audela" scope="page" />
								
								<c:set var="J" value="Jugement global" scope="page" />
								
								<c:forEach items="${ competences }" varStatus="ligne"><c:if test="${ noms[ligne.index] == J }" var="variable">
								<tr>
									<td>
										<div class="skill">${ noms[ligne.index] }</div>
										<div class="criteria">
											${ criteres[ligne.index] }
										</div>
									</td>
									<td>${ cp[ligne.index] }</td>
									<td>${ ci[ligne.index] }</td>
									<td>${ cg[ligne.index] }</td>
									<td>
										<div class="skill-levels">
											<c:if test="${ evaluations[ligne.index] == loin }" var="variable">
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == proche }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == tproche }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == attendu }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == audela }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] != loin && evaluations[ligne.index] != proche && evaluations[ligne.index] != tproche && evaluations[ligne.index] != attendu && evaluations[ligne.index] != audela }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
										</div>
									</td>
								</tr>
								</c:if></c:forEach>
								
								<c:forEach items="${ competences }" varStatus="ligne"><c:if test="${ noms[ligne.index] != J }" var="variable">
								<tr>
									<td>
										<div class="skill">${ noms[ligne.index] }</div>
										<div class="criteria">
											${ criteres[ligne.index] }
										</div>
									</td>
									<td>${ cp[ligne.index] }</td>
									<td>${ ci[ligne.index] }</td>
									<td>${ cg[ligne.index] }</td>
									<td>
										<div class="skill-levels">
											<c:if test="${ evaluations[ligne.index] == loin }" var="variable">
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == proche }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == tproche }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == attendu }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
												<div class="skill-level-cell"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] == audela }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell" id="skill-level2"></div>
											</c:if>
											<c:if test="${ evaluations[ligne.index] != loin && evaluations[ligne.index] != proche && evaluations[ligne.index] != tproche && evaluations[ligne.index] != attendu && evaluations[ligne.index] != audela }" var="variable">
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
												<div class="skill-level-cell"></div>
											</c:if>
										</div>
									</td>
								</tr>
								</c:if></c:forEach>
							</table>
						</div>
					</div>
				</section>
			</div>
		</div>

		<jsp:include page = "footer.jsp" />
		
		<script>modifLink();</script>
	</body>

</html> 
