<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
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
    <head>
        <meta charset="UTF-8"/>
		<title>Ma grille de compétence</title>
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
		
		<div id="page">
			<section>
				<h2>Promo 2018 &gt; Tuteur &gt; APP électronique &gt; Groupe APP A &gt; Léo</h2>
				<div id="content">
					<div id="tabs">
						<c:forEach items="${ compprinc }" varStatus="i">
						<div class="tab"><a class="link" href="AffichageEleve?eleve=0&grille=0&competence=${ compprinc_id[i.index] }">${ compprinc[i.index] }</a></div>
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
									</div>
								</th>
							</tr>
							<tr>
								<td>
									<div class="skill">Jugement global</div>
								</td>
								<td></td>
								<td></td>
								<td></td>
								<td>
									<div class="skill-levels">
										<div class="skill-level-cell"></div>
										<div class="skill-level-cell"></div>
										<div class="skill-level-cell" id="skill-level1"></div>
										<div class="skill-level-cell"></div>
										<div class="skill-level-cell"></div>
									</div>
								</td>
							</tr>
							<c:set var="loin" value="loin" scope="page" />
							<c:set var="proche" value="proche" scope="page" />
							<c:set var="tproche" value="tproche" scope="page" />
							<c:set var="attendu" value="attendu" scope="page" />
							<c:set var="audela" value="audela" scope="page" />
							<c:forEach items="${ competences }" varStatus="ligne">
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
										<c:if test="${ evaluations[ligne.index] == tproch }" var="variable">
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
									</div>
								</td>
							</tr>
							</c:forEach>
						</table>
					</div>
				</div>
			</section>
		</div>

		<footer style="width:100%;float:left;">
			<div><a href="#">CGU</a></div>
			<div><a href="#">FAQ</a></div>
			<div><a href="#">Nous contacter</a></div>
		</footer>
		<script>modifLink();</script>
	</body>

</html> 