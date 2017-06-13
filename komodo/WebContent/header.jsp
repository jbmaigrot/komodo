<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>


<header>
<h1 class="col-md-6 col-md-offset-3">SITE WEB APP</h1>
	<div class="col-md-3">
		<a href="#">${ sessionScope.userName }</a><br> <a href="LogoutServlet">Déconnexion</a>
	</div>
</header>