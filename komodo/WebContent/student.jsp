<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<title>Elève</title>

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
	</head>
	<body>
		<div class="container">
			<div class="row">
				<menu class="col-md-3">
					<div class="group" onclick="menuToggle(this)">
						<img src="pictures/minus.png"/>
						<img src="pictures/plus.png" class="hidden-menu"/>
						APP électronique
						<div class="aside-student">
							<p id="student1">MOI<p>
							<p>François</p>
							<p>Gérard</p>
						</div>
					</div>
				</menu>

				<section class="col-md-9">
					<h2>APP électronique &gt; Moi</h2>
					<div id="content">
						<div id="tabs">
							<div class="tab selected-tab" onclick="selectSkill(1)">Compétence principale 1</div>
							<div class="tab" onclick="selectSkill(2)">Compétence principale 2</div>
							<div class="tab" onclick="selectSkill(3)">Compétence principale 3</div>
						</div>
						<article class="selected-article">
							<table class="grid">
								<tr>
									<th></th>
									<th>Commentaire au prof</th>
									<th class="hidden-comment">Commentaire à l'élève</th>
									<th class="hidden-comment">Commentaire de groupe</th>
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
									<td class="hidden-comment">Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
									<td class="hidden-comment">Nunc sed egestas leo.</td>
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
									<td class="hidden-comment">Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
									<td class="hidden-comment">Nunc sed egestas leo.</td>
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
									<td class="hidden-comment">Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
									<td class="hidden-comment">Donec commodo diam vitae erat bibendum ullamcorper. Nam faucibus purus non accumsan imperdiet. Proin tristique varius tempus. Aliquam eleifend vitae purus quis auctor.</td>
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

						<article>
							<table class="grid">
								<tr>
									<th></th>
									<th>Commentaire au prof</th>
									<th class="hidden-comment">Commentaire à l'élève</th>
									<th class="hidden-comment">Commentaire de groupe</th>
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
									<td>AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA</td>
									<td class="hidden-comment">Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
									<td class="hidden-comment">Nunc sed egestas leo.</td>
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
									<td class="hidden-comment">Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
									<td class="hidden-comment">Nunc sed egestas leo.</td>
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
									<td class="hidden-comment">Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
									<td class="hidden-comment">Donec commodo diam vitae erat bibendum ullamcorper. Nam faucibus purus non accumsan imperdiet. Proin tristique varius tempus. Aliquam eleifend vitae purus quis auctor.</td>
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

						<article>
							<table class="grid">
								<tr>
									<th></th>
									<th>Commentaire au prof</th>
									<th class="hidden-comment">Commentaire à l'élève</th>
									<th class="hidden-comment">Commentaire de groupe</th>
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
									<td>BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB</td>
									<td class="hidden-comment">Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
									<td class="hidden-comment">Nunc sed egestas leo.</td>
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
									<td class="hidden-comment">Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
									<td class="hidden-comment">Nunc sed egestas leo.</td>
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
									<td class="hidden-comment">Nullam et neque vel nulla commodo venenatis in eget urna. Sed et elit ante. Praesent eleifend ex velit, vel dictum libero efficitur at.</td>
									<td class="hidden-comment">Donec commodo diam vitae erat bibendum ullamcorper. Nam faucibus purus non accumsan imperdiet. Proin tristique varius tempus. Aliquam eleifend vitae purus quis auctor.</td>
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
			
		</div>



		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<!-- Include all compiled plugins (below), or include individual files as needed -->
		<script src="bootstrap/js/bootstrap.min.js"></script>
	</body>
</html>