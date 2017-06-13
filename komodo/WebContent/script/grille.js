function selection(check_tab,id_comp,id_comp_sec,id_checkbox_sec,id_critere,id_ponderation,tabComp,tabCritere) 
{
	var cible = document.getElementById(id_comp);
	var cible_sec = document.getElementById(id_comp_sec);
	//var cible_critere = document.getElementById(tabCritere);
	//var cible_critere = document.getElementById(id_critere);
	//var cible_ponderation = document.getElementById(id_ponderation);
	
	// cas navigateur pour undefined.
	if (document.getElementById(check_tab).checked == true)
	{
		cible.style.display = 'block';
		//document.getElementById(id_comp).innerHTML = document.getElementById(id_tab).innerHTML;
		//document.getElementById(id_tab).disabled = true;
	}
	else
	{
		//alert("toto");
		cible.style.display = 'none';
		cible_sec.style.display = 'none';
		var i;
		//alert(tabComp);
		for (i = 1;i<=tabComp;i++){
			//alert(tabComp);
   			document.getElementById(id_critere+i).innerHTML = "";
   			document.getElementById(id_ponderation+i).options[0].selected = true;
			document.getElementById(id_checkbox_sec+i).checked = false;
			document.getElementById(tabCritere+i).style.display = 'none';
		}
	}
}

function selectionElementGrille(id_element,id_element_sec){
	var cible = document.getElementById(id_element_sec);
	if (document.getElementById(id_element).disabled == undefined || document.getElementById(id_element).disabled == false)
	{
		if(cible.style.display != '')
       		cible.style.display = '';
 		else
 		{
			cible.style.display = 'none';
			//document.getElementById(id_element_sec).innerHTML = "";
   			//cible.style.display = 'none';
		}
	}
}


function selectionElementGrilleSec(id_element,id_element_sec,id_critere,id_ponderation)
{
		
	var cible = document.getElementById(id_element_sec);
	var cible_critere = document.getElementById(id_critere);
	var cible_ponderation = document.getElementById(id_ponderation);
	if (document.getElementById(id_element).disabled == undefined || document.getElementById(id_element).disabled == false)
	{
		if(cible.style.display != ''){
        	cible.style.display = '';
		}
    	else{
    		document.getElementById(id_critere).innerHTML = "";
    		document.getElementById(id_ponderation).options[0].selected = true;
    		//document.getElementById(id_ponderation).value = null;
    		//document.getElementById(id_ponderation).options[document.getElementById(id_ponderation).selectedIndex].text = document.getElementById(id_ponderation).options[0];
       		cible.style.display = 'none';
    	}
	}
}
		
function affichageListeCoefficient(sel, coef)
{
	if (sel.size != coef)
   		sel.size = coef;
	else
		sel.size = '1';
}