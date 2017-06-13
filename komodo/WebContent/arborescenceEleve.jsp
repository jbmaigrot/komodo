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

		<!-- Bootstrap -->
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="style.css">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
		<title>Arborescence</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
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
				value = 0;
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
		<div class="container">
			<div class="row">
				<menu class="col-md-3">
					<div>MOI<p>
					<c:forEach items="${ groupes }" varStatus="s3"><p>
						<a id="${ groupes_id[s3.index] }" href="ArborescenceEleve?sql=1&groupe=${ groupes_id[s3.index] }#${ groupes_id[s3.index] }"><img src="pictures/minus.png"/>${ groupes[s3.index] }</a>
						<div id="f${ groupes_id[s3.index] }" class="aside-student">
							<c:forEach items="${ eleves }" varStatus="s4">
							<p><a href="AffichageEleve?eleve=${ eleves_id[s4.index] }&grille=${ apps_id[0] }&competence=1">${ eleves[s4.index] }</a></p>
							</c:forEach>
						</div>
						<script>hideEleves('f${ groupes_id[s3.index] }','${ groupes_id[s3.index] }');</script>
					</p></c:forEach>
					</p></div>
				</menu>
			</div>
		</div>

		<jsp:include page = "footer.jsp" />
	</body>

</html> 
