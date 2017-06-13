<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<html>

    <head>

        <meta charset="utf-8" />

        <title>Mise en ligne des utilisateurs</title>

        <link rel="stylesheet" type="text/css" href="style.css">

    </head>

    <body>

        <form action="<c:url value="/upload" />" method="post" enctype="multipart/form-data">

            <fieldset>

                <legend>Envoi de fichier</legend>

                <label for="description">Type d'utilisateur</label>

                <input type="text" id="description" name="description" value="" />

                <br />


                <label for="fichier">Emplacement du fichier <span class="requis">*</span></label>

                <input type="file" id="fichier" name="fichier" />

                <br />

                

                <input type="submit" value="Envoyer" class="sansLabel" />

                <br />                

            </fieldset>

        </form>

    </body>

</html>