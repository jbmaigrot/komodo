function selectSkill(tabId, skillId)
{
	var x = document.getElementsByTagName('article');
		for(i=0 ; i<x.length ; i++)
		{
			x[i].style.display = "none";
		}
	document.getElementById(skillId).style.display = "block";

	var x = document.getElementsByClassName('tab');
		for(i=0 ; i<x.length ; i++)
		{
			x[i].style.color = "black";
			x[i].style.backgroundColor = "white";
		}
	document.getElementById(tabId).style.color = "white";
	document.getElementById(tabId).style.backgroundColor = "#26F";

}