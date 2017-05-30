<%@ page pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
    	<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
		<title>Connexion</title>

		<!-- Bootstrap -->
		<link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link rel="stylesheet" type="text/css" href="style.css">

		<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
		<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
    </head>
    
    <body>
    	<div class="center">
	        <form class="connexion" method="post" action="LoginServelt">
	        	<div class="container">
	            	<h2>Connexion</h2>
					<div class="row">
						<div class="col-sm-6">Nom d'utilisateur <span class="requis">*</span></div>
			            <input class="col-sm-6" type="text" id="userName" name="userName" value="" />
				    </div>
					<div class="row">
			            <div class="col-sm-6">Mot de passe <span class="requis">*</span></div>
			            <input class="col-sm-6" type="password" id="motdepasse" name="motdepasse" value="" size="20" maxlength="20" />
			        </div>
					<div class="hcenter"><input class="submit" type="submit" value="Connexion" class="sansLabel" /></div>
				</div>
	        </form>
	    </div>
    </body>
    
</html>