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
		
		linkParams=parseURLParams(obj[i].href);
		if(linkParams.competence == get("competence")) {
			obj[i].className += " selected-tab";
		}
	}
}

function modifLink2(){
	var obj=document.getElementsByClassName("link2");
	for (i = 0; i < obj.length; i++) {
		//alert(obj[i].href);
		obj[i].action = obj[i].action.replace("eleve=0", "eleve="+get("eleve"));
		obj[i].action = obj[i].action.replace("grille=0", "grille="+get("grille"));
		obj[i].action = obj[i].action.replace("competence=0", "competence="+get("competence"));
		//alert(obj[i].href);
	}
}
