function selectSkill(n)
{
	$(".tab").removeClass("selected-tab");
	$(".tab").eq(n-1).addClass("selected-tab");

	$("article").removeClass("selected-article");
	$("article").eq(n-1).addClass("selected-article");
}

function menuToggle(element)
{
	$(element).children().toggleClass("hidden-menu");
}