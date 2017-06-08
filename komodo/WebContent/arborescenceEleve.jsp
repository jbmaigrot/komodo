<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<html>
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
    <head>
        <meta charset="UTF-8"/>
		<title>Arborescence</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	 </head>

	 <body>

	    <jsp:include page = "header.jsp">

		
		<div id="page">
			<menu>
				<div>MOI<p>
				<c:forEach items="${ groupes }" varStatus="s3"><p>
					<a id="${ groupes_id[s3.index] }" href="ArborescenceEleve?sql=1&groupe=${ groupes_id[s3.index] }#${ groupes_id[s3.index] }"><img src="pictures/minus.png"/>${ groupes[s3.index] }</a>
					<div id="f${ groupes_id[s3.index] }" class="aside-student">
						<c:forEach items="${ eleves }" varStatus="s4">
						<p><a href="AffichageEleve?eleve=${ eleves_id[s4.index] }&grille=${ apps_id[s3.index] }&competence=1">${ eleves[s4.index] }</a></p>
						</c:forEach>
					</div>
					<script>hideEleves('f${ groupes_id[s3.index] }','${ groupes_id[s3.index] }');</script>
				</p></c:forEach>
				</p></div>
			</menu>
		</div>

		<footer>
			<div><a href="#">CGU</a></div>
			<div><a href="#">FAQ</a></div>
			<div><a href="#">Nous contacter</a></div>
		</footer>
	</body>

</html> 