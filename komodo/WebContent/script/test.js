/*function selectSkill(n)
{
	$(".tab").removeClass("selected-tab");
	$(".tab").eq(n-1).addClass("selected-tab");

	$("article").removeClass("selected-article");
	$("article").eq(n-1).addClass("selected-article");
}

function menuToggle(element)
{
	$(element).children().toggleClass("hidden-menu");
}*/

function parseURLParams(url) {
    var queryStart = url.indexOf("?") + 1,
        queryEnd   = url.indexOf("#") + 1 || url.length + 1,
        query = url.slice(queryStart, queryEnd - 1),
        pairs = query.replace(/\+/g, " ").split("&"),
        parms = {}, i, n, v, nv;

    if (query === url || query === "") return;

    for (i = 0; i < pairs.length; i++) {
        nv = pairs[i].split("=", 2);
        n = decodeURIComponent(nv[0]);
        v = decodeURIComponent(nv[1]);

        if (!parms.hasOwnProperty(n)) parms[n] = [];
        parms[n].push(nv.length === 2 ? v : null);
    }
    return parms;
}