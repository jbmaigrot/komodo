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
		<title>Planning APP</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		
		<script>
			function affichageElementTier(id_element,id_element_sec){
				var cible = document.getElementById(id_element_sec);
				if (document.getElementById(id_element).disabled == undefined || document.getElementById(id_element).disabled == false)
				{
					if(cible.style.display != '')
			       		cible.style.display = '';
			 		else{
					cible.style.display = 'none';
		    		}
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
						<p><a class="link3" id="ajout" href="LoginServlet">Retour vers l'arborescence</a></p>
					</div>
				</menu>
				<section class="col-md-9">
				<section>
					<h4>Planning du groupe <strong>${nom_groupe}</strong> de <strong>${nom_app}</strong></h4>
					<u1>
						<c:choose>
							<c:when test="${nb_plan == 0}">
								<li>Pas d'évènements dans le planning</li>
							</c:when>
							
							<c:otherwise>
								<c:forEach var="i" begin="0" end="${nb_plan - 1}">
									<li>Le ${plan_date[i]} de ${heure_debut[i]} Ã  ${heure_fin[i]} : ${plan_nom[i]} 
									</li>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</u1>
				</section>
			</div>
		</div>
		
		<footer>
			<div><a href="#">CGU</a></div>
			<div><a href="#">FAQ</a></div>
			<div><a href="#">Nous contacter</a></div>
		</footer>
	</body>
</html>
