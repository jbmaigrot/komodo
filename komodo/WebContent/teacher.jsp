<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


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
		document.location.href="AffichageTeacher?sql=1&promo="+promo+"&role="+role+"&app="+app+"&groupe="+groupe+"&eleve="+eleve;
	}
	
</script>

<html>
    <head>
        <meta charset="UTF-8"/>
		<title>Teacher</title>
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
						<p onclick="open('','${ elt }','','','')"><img src="pictures/minus.png"/>${ elt }</p>
						<c:forEach items="${ apps }" varStatus="s2"><c:if test="${ promos[s2.index] == i }" var="variable">
						<div class="aside-app">
							<p onclick="open('','${ elt }',${ apps_id[s2.index] },'','')"><img src="pictures/minus.png"/>${ apps[s2.index] }</p>
							<c:forEach items="${ groupes }" varStatus="s3">
							<div class="aside-group">
								<p onclick="open('','${ elt }',${ apps_id[s2.index] },${ groupes_id[s3.index] },'')"><img src="pictures/minus.png"/>${ groupes[s3.index] }</p>
								<div class="aside-student">
									<c:forEach items="${ eleves }" varStatus="s4">
									<p>${ eleves[s4.index] }</p>
									</c:forEach>
								</div>
							</div>
							</c:forEach>
						</div>
						</c:if></c:forEach>
						<div class="aside-app">
							<p><a href="CreationGrille">Ajouter</a></p>
						</div>
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
				<h2>Promo 2018 &gt; Tuteur &gt; APP électronique &gt; Groupe APP A &gt; Léo</h2>
				<div id="content">
					<div id="tabs">
						<div class="tab" id="tab1">Compétence principale 1</div>
						<div class="tab">Compétence principale 2</div>
						<div class="tab">...</div>
					</div>
					<article>
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
								<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam blandit vitae urna at eleifend. Vivamus nec posuere risus. Aliquam erat volutpat.</td>
								<td>Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
								<td>Nunc sed egestas leo.</td>
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
							<tr>
								<td>
									<div class="skill">Compétence secondaire 1</div>
									<div class="criteria">
										- Critère 1<br>
										- Critère 2
									</div>
								</td>
								<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam blandit vitae urna at eleifend. Vivamus nec posuere risus. Aliquam erat volutpat.</td>
								<td>Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
								<td>Nunc sed egestas leo.</td>
								<td>
									<div class="skill-levels">
										<div class="skill-level-cell"></div>
										<div class="skill-level-cell"></div>
										<div class="skill-level-cell" id="skill-level2"></div>
										<div class="skill-level-cell"></div>
										<div class="skill-level-cell"></div>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<div class="skill">Compétence secondaire 2</div>
									<div class="criteria">
										- Critère 1<br>
										- Critère 2
									</div>
								</td>
								<td>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam blandit vitae urna at eleifend. Vivamus nec posuere risus. Aliquam erat volutpat.</td>
								<td>Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
								<td>Donec commodo diam vitae erat bibendum ullamcorper. Nam faucibus purus non accumsan imperdiet. Proin tristique varius tempus. Aliquam eleifend vitae purus quis auctor.</td>
								<td>
									<div class="skill-levels">
										<div class="skill-level-cell"></div>
										<div class="skill-level-cell" id="skill-level3"></div>
										<div class="skill-level-cell"></div>
										<div class="skill-level-cell"></div>
										<div class="skill-level-cell"></div>
									</div>
								</td>
							</tr>
						</table>
					</article>
				</div>
			</section>
		</div>

		<footer>
			<div><a href="#">CGU</a></div>
			<div><a href="#">FAQ</a></div>
			<div><a href="#">Nous contacter</a></div>
		</footer>

	</body>

</html> 