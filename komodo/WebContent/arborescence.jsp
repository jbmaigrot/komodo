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
	
	function open(promo,role,app,groupe,eleve){
		document.location.href="Arborescence?sql=1&promo="+promo+"&role="+role+"&app="+app+"&groupe="+groupe+"&eleve="+eleve;
	}
	
</script>
    <head>
        <meta charset="UTF-8"/>
		<title>Arborescence</title>
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
			<aside>
				<c:forEach var="i" begin="2015" end="2025" step="1">
				<div class="aside-promo">
					<p onclick="displ('aside-category${ i }')"><img src="pictures/minus.png"/>Promo ${ i }</p>
					<c:forTokens var="elt" items="Tuteur/Client/Autre" delims="/">
					<div class="aside-category${ i }">
						<p onclick="open('0','${ elt }','0','0','0')"><img src="pictures/minus.png"/>${ elt }</p>
						<c:forEach items="${ apps }" varStatus="s2"><c:if test="${ promos[s2.index] == i }" var="variable">
						<div class="aside-app">
							<p onclick="open('0','${ elt }','${ apps_id[s2.index] }','0','0')"><img src="pictures/minus.png"/>${ apps[s2.index] }</p>
							<c:forEach items="${ groupes }" varStatus="s3">
							<div class="aside-group">
								<p onclick="open('0','${ elt }','${ apps_id[s2.index] }','${ groupes_id[s3.index] }','0')"><img src="pictures/minus.png"/>${ groupes[s3.index] }</p>
								<div class="aside-student">
									<c:forEach items="${ eleves }" varStatus="s4">
									<p>${ eleves[s4.index] }</p>
									</c:forEach>
								</div>
							</div>
							</c:forEach>
						</div>
						</c:if></c:forEach>
					</div>
					</c:forTokens>
				</div>
				</c:forEach>
			</aside>
			<script>
				var number = 2015;
				while (number < 2030) {
					//displ('aside-category'+number);
					number++;
				}
			</script>
			<section>
				
			</section>
		</div>

		<footer>
			<div><a href="#">CGU</a></div>
			<div><a href="#">FAQ</a></div>
			<div><a href="#">Nous contacter</a></div>
		</footer>

	</body>

</html> 