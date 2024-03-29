<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html>
    <head>
        <meta charset="UTF-8"/>
		<title>Arborescence</title>

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
						<a id="${ i }" href="ArborescenceTeacher?sql=1&promo=${ i }&role=0&app=0&groupe=0&eleve=0#${ i }"><img src="pictures/minus.png"/>Promo ${ i }</a>
						<div id="f${ i }" class="aside-category${ i }">
						<c:forTokens var="elt" items="Tuteur/Client/Autre" delims="/"><p>
							<a id="${ i }${ elt }" href="ArborescenceTeacher?sql=1&promo=${ i }&role=${ elt }&app=0&groupe=0&eleve=0#${ i }${ elt }"><img src="pictures/minus.png"/>${ elt }</a>
							<div id="f${ i }${ elt }" class="aside-app">
							<c:forEach items="${ apps }" varStatus="s2"><c:if test="${ promos[s2.index] == i }" var="variable"><p>
								<a id="${ i }${ elt }${ apps_id[s2.index] }" href="ArborescenceTeacher?sql=1&promo=${ i }&role=${ elt }&app=${ apps_id[s2.index] }&groupe=0&eleve=0#${ i }${ elt }${ apps_id[s2.index] }"><img src="pictures/minus.png"/>${ apps[s2.index] }</a>
								<div id="f${ i }${ elt }${ apps_id[s2.index] }" class="aside-group">
									<c:forEach items="${ groupes }" varStatus="s3"><p>
										<a id="${ i }${ elt }${ apps_id[s2.index] }${ groupes_id[s3.index] }" href="ArborescenceTeacher?sql=1&promo=${ i }&role=${ elt }&app=${ apps_id[s2.index] }&groupe=${ groupes_id[s3.index] }&eleve=0#${ i }${ elt }${ apps_id[s2.index] }${ groupes_id[s3.index] }"><img src="pictures/minus.png"/>${ groupes[s3.index] }</a>
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
				
				</menu>
			</div>
		</div>

		<jsp:include page = "footer.jsp" />
	</body>

</html> 
