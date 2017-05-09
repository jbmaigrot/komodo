<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<html>
    <head>
		<title>Teacher</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	 </head>

	 <body>

	 	<header>
	    	<h1>SITE WEB APP</h1>
	    	<div>
	    		<a href="#">Thomas (mon profil)</a>
	    		<a href="#">D�connexion</a>
	    	</div>
		</header>
<script>
function clickGrille(grille,nomGrille){
	//alert("gigi");
	var cible = document.getElementById(nomGrille);
	if (document.getElementById(grille).disabled == undefined || document.getElementById(nomGrille).disabled == false){
		//alert("gogo");
		if(cible.style.display != ''){
			//alert("false");
        	cible.style.display = '';
		}
    	else {
    		//alert("true");
       		cible.style.display = 'none';
    	}
	}
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
				<div class="aside-app">
					<p><a href="CreationGrille">Ajouter</a></p>
				</div>
				<div id="grille" onClick='clickGrille("grille","nomGrille");'>Grille APP</div>
				<div id="nomGrille" style="display:none;">
					<c:forEach items="${ nomGrille }" var="nomGrilleInd" varStatus="boucle">
						<p><a href="#">${nomGrilleInd}</a></p>
					</c:forEach>
				</div>
			</aside>
 
			<section>
			<p><span>${resultatForm }</span></p>	
			<!--
				<h2>Promo 2018 &gt; Tuteur &gt; APP �lectronique &gt; Groupe APP A &gt; L�o</h2>
				<div id="content">
					<div id="tabs">
						<div class="tab" id="tab1">Comp�tence principale 1</div>
						<div class="tab">Comp�tence principale 2</div>
						<div class="tab">...</div>
					</div>
					<article>
						<table class="grid">
							<tr>
								<th></th>
								<th>Commentaire au prof</th>
								<th>Commentaire � l'�l�ve</th>
								<th>Commentaire de groupe</th>
								<th>
									Niveau de comp�tence<br>
									<div class="skill-levels">
										<div class="skill-level">Loin</div>
										<div class="skill-level">Proche</div>
										<div class="skill-level">Tr�s proche</div>
										<div class="skill-level">Attendu</div>
										<div class="skill-level">Au-del�</div>
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
									<div class="skill">Comp�tence secondaire 1</div>
									<div class="criteria">
										- Crit�re 1<br>
										- Crit�re 2
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
									<div class="skill">Comp�tence secondaire 2</div>
									<div class="criteria">
										- Crit�re 1<br>
										- Crit�re 2
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
				-->
			</section>
		</div>

		<footer>
			<div><a href="#">CGU</a></div>
			<div><a href="#">FAQ</a></div>
			<div><a href="#">Nous contacter</a></div>
		</footer>

	</body>

</html> 