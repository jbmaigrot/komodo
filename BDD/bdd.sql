-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Sam 29 Avril 2017 à 18:18
-- Version du serveur :  5.7.18-0ubuntu0.16.04.1
-- Version de PHP :  5.6.30-10+deb.sury.org~xenial+2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `komodo`
--
CREATE DATABASE IF NOT EXISTS `komodo` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `komodo`;

-- --------------------------------------------------------

--
-- Structure de la table `Appartient`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Appartient` (
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idGroupe` int(10) UNSIGNED NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `datecrea` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Appartient`:
--   `idEleve`
--       `Eleves` -> `id_utilisateur`
--   `idGroupe`
--       `Groupe` -> `id_groupe`
--

-- --------------------------------------------------------

--
-- Structure de la table `Competence_principale`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Competence_principale` (
  `id_comp` int(10) UNSIGNED NOT NULL,
  `Nom_competence_principale` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Competence_principale`:
--

-- --------------------------------------------------------

--
-- Structure de la table `Competence_secondaire`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Competence_secondaire` (
  `id_comp_second` int(10) UNSIGNED NOT NULL,
  `id_comp_princ` int(10) UNSIGNED NOT NULL,
  `Ponderation` decimal(2,2) NOT NULL,
  `Nom` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Competence_secondaire`:
--   `id_comp_princ`
--       `Competence_principale` -> `id_comp`
--

-- --------------------------------------------------------

--
-- Structure de la table `Consulte`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Consulte` (
  `Evaluation` varchar(45) NOT NULL,
  `CommentaireGroupe` text NOT NULL,
  `CommentaireIndividuel` text NOT NULL,
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idCom_Sec_Util` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Consulte`:
--   `idCom_Sec_Util`
--       `Competence_secondaire` -> `id_comp_princ`
--   `idEleve`
--       `Eleves` -> `id_utilisateur`
--

-- --------------------------------------------------------

--
-- Structure de la table `Critere`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Critere` (
  `id_critere` int(10) UNSIGNED NOT NULL,
  `Descriptif` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Critere`:
--

-- --------------------------------------------------------

--
-- Structure de la table `Eleves`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Eleves` (
  `id_utilisateur` int(10) UNSIGNED NOT NULL,
  `Numero_eleve` int(10) UNSIGNED NOT NULL,
  `Annee` int(10) UNSIGNED NOT NULL,
  `Specialite` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Eleves`:
--   `id_utilisateur`
--       `Utilisateur` -> `id`
--

-- --------------------------------------------------------

--
-- Structure de la table `Evalue`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Evalue` (
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idGroupe` int(10) UNSIGNED NOT NULL,
  `idComp_Sec_Util` int(10) UNSIGNED NOT NULL,
  `Evaluation` varchar(45) NOT NULL,
  `CommentaireIndividuel` text NOT NULL,
  `CommentaireGroupe` text NOT NULL,
  `CommentaireProfesseur` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Evalue`:
--   `idComp_Sec_Util`
--       `Competence_secondaire` -> `id_comp_princ`
--   `idEleve`
--       `Eleves` -> `id_utilisateur`
--   `idGroupe`
--       `Groupe` -> `id_groupe`
--

-- --------------------------------------------------------

--
-- Structure de la table `Grille_de_competence_APP`
--
-- Création :  Sam 29 Avril 2017 à 16:16
--

CREATE TABLE `Grille_de_competence_APP` (
  `id_grille` int(10) UNSIGNED NOT NULL,
  `Nom_grille` varchar(45) NOT NULL,
  `Promo` int(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Grille_de_competence_APP`:
--

-- --------------------------------------------------------

--
-- Structure de la table `Groupe`
--
-- Création :  Sam 29 Avril 2017 à 16:14
--

CREATE TABLE `Groupe` (
  `id_groupe` int(10) UNSIGNED NOT NULL,
  `Nom` varchar(45) NOT NULL,
  `idClient` int(10) UNSIGNED DEFAULT NULL,
  `idTuteur` int(10) UNSIGNED DEFAULT NULL,
  `idGrilleAPP` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Groupe`:
--   `idClient`
--       `Utilisateur` -> `id`
--   `id_groupe`
--       `Grille_de_competence_APP` -> `id_grille`
--   `idTuteur`
--       `Utilisateur` -> `id`
--

-- --------------------------------------------------------

--
-- Structure de la table `Lie2`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Lie2` (
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idGrilleComp` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Lie2`:
--   `idEleve`
--       `Eleves` -> `id_utilisateur`
--   `idGrilleComp`
--       `Grille_de_competence_APP` -> `id_grille`
--

-- --------------------------------------------------------

--
-- Structure de la table `Lie3`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Lie3` (
  `idGrilleComp` int(10) UNSIGNED NOT NULL,
  `idCompPrin` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Lie3`:
--   `idCompPrin`
--       `Competence_principale` -> `id_comp`
--   `idGrilleComp`
--       `Grille_de_competence_APP` -> `id_grille`
--

-- --------------------------------------------------------

--
-- Structure de la table `Lie5`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Lie5` (
  `idCompSecUtil` int(10) UNSIGNED NOT NULL,
  `idCritere` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Lie5`:
--   `idCompSecUtil`
--       `Competence_secondaire` -> `id_comp_princ`
--   `idCritere`
--       `Critere` -> `id_critere`
--

-- --------------------------------------------------------

--
-- Structure de la table `Lie6`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Lie6` (
  `idGroupe` int(10) UNSIGNED NOT NULL,
  `idPlaning` int(10) UNSIGNED NOT NULL,
  `Descriptif` text NOT NULL,
  `Date` date NOT NULL,
  `Heure` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Lie6`:
--   `idGroupe`
--       `Groupe` -> `id_groupe`
--   `idPlaning`
--       `Planning` -> `id_planning`
--

-- --------------------------------------------------------

--
-- Structure de la table `Planning`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Planning` (
  `id_planning` int(10) UNSIGNED NOT NULL,
  `Nom_planning` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Planning`:
--

-- --------------------------------------------------------

--
-- Structure de la table `Utilisateur`
--
-- Création :  Sam 29 Avril 2017 à 16:05
--

CREATE TABLE `Utilisateur` (
  `id` int(10) UNSIGNED NOT NULL,
  `Nom` varchar(45) NOT NULL,
  `Prenom` varchar(45) NOT NULL,
  `Age` int(10) UNSIGNED NOT NULL,
  `Type` varchar(45) NOT NULL,
  `NomConnection` varchar(32) NOT NULL,
  `MotDePasse` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- RELATIONS POUR LA TABLE `Utilisateur`:
--

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Appartient`
--
ALTER TABLE `Appartient`
  ADD KEY `Appartient_Eleves_idx` (`idEleve`),
  ADD KEY `Appartient_Groupe_idx` (`idGroupe`);

--
-- Index pour la table `Competence_principale`
--
ALTER TABLE `Competence_principale`
  ADD PRIMARY KEY (`id_comp`);

--
-- Index pour la table `Competence_secondaire`
--
ALTER TABLE `Competence_secondaire`
  ADD PRIMARY KEY (`id_comp_second`),
  ADD KEY `CompSec_compPrinc` (`id_comp_princ`);

--
-- Index pour la table `Consulte`
--
ALTER TABLE `Consulte`
  ADD KEY `Consulte_Eleve_idx` (`idEleve`),
  ADD KEY `Consulte_CompSecUtil_idx` (`idCom_Sec_Util`);

--
-- Index pour la table `Critere`
--
ALTER TABLE `Critere`
  ADD PRIMARY KEY (`id_critere`);

--
-- Index pour la table `Eleves`
--
ALTER TABLE `Eleves`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD UNIQUE KEY `id_utilisateur_UNIQUE` (`id_utilisateur`),
  ADD UNIQUE KEY `Numero eleve_UNIQUE` (`Numero_eleve`);

--
-- Index pour la table `Evalue`
--
ALTER TABLE `Evalue`
  ADD KEY `Evalue_Eleve_idx` (`idEleve`),
  ADD KEY `Evalue_Groupe_idx` (`idGroupe`),
  ADD KEY `Evalue_CompSecUtil_idx` (`idComp_Sec_Util`);

--
-- Index pour la table `Grille_de_competence_APP`
--
ALTER TABLE `Grille_de_competence_APP`
  ADD PRIMARY KEY (`id_grille`);

--
-- Index pour la table `Groupe`
--
ALTER TABLE `Groupe`
  ADD PRIMARY KEY (`id_groupe`),
  ADD UNIQUE KEY `Groupe_grilleAPP_idx` (`idGrilleAPP`),
  ADD KEY `Groupe_prof_idx` (`idClient`),
  ADD KEY `Groupe_tuteur_idx` (`idTuteur`);

--
-- Index pour la table `Lie2`
--
ALTER TABLE `Lie2`
  ADD KEY `Lie2_Eleve_idx` (`idEleve`),
  ADD KEY `Lie2_GrilleComp_idx` (`idGrilleComp`);

--
-- Index pour la table `Lie3`
--
ALTER TABLE `Lie3`
  ADD KEY `Lie3_GrilleComp_idx` (`idGrilleComp`),
  ADD KEY `Lie3_CompPrin_idx` (`idCompPrin`);

--
-- Index pour la table `Lie5`
--
ALTER TABLE `Lie5`
  ADD KEY `Lie5_CompSecUtil_idx` (`idCompSecUtil`),
  ADD KEY `Lie5_Critere_idx` (`idCritere`);

--
-- Index pour la table `Lie6`
--
ALTER TABLE `Lie6`
  ADD KEY `Lie6_Groupe_idx` (`idGroupe`),
  ADD KEY `Lie6_Planning_idx` (`idPlaning`);

--
-- Index pour la table `Planning`
--
ALTER TABLE `Planning`
  ADD PRIMARY KEY (`id_planning`);

--
-- Index pour la table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `NomConnection_UNIQUE` (`NomConnection`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `Competence_principale`
--
ALTER TABLE `Competence_principale`
  MODIFY `id_comp` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Competence_secondaire`
--
ALTER TABLE `Competence_secondaire`
  MODIFY `id_comp_second` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Critere`
--
ALTER TABLE `Critere`
  MODIFY `id_critere` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Eleves`
--
ALTER TABLE `Eleves`
  MODIFY `id_utilisateur` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Grille_de_competence_APP`
--
ALTER TABLE `Grille_de_competence_APP`
  MODIFY `id_grille` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Groupe`
--
ALTER TABLE `Groupe`
  MODIFY `id_groupe` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Planning`
--
ALTER TABLE `Planning`
  MODIFY `id_planning` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `Appartient`
--
ALTER TABLE `Appartient`
  ADD CONSTRAINT `Appartient_Eleves` FOREIGN KEY (`idEleve`) REFERENCES `Eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Appartient_Groupe` FOREIGN KEY (`idGroupe`) REFERENCES `Groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Competence_secondaire`
--
ALTER TABLE `Competence_secondaire`
  ADD CONSTRAINT `CompSec_compPrinc` FOREIGN KEY (`id_comp_princ`) REFERENCES `Competence_principale` (`id_comp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Consulte`
--
ALTER TABLE `Consulte`
  ADD CONSTRAINT `Consulte_CompSecUtil` FOREIGN KEY (`idCom_Sec_Util`) REFERENCES `Competence_secondaire` (`id_comp_princ`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Consulte_Eleve` FOREIGN KEY (`idEleve`) REFERENCES `Eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Eleves`
--
ALTER TABLE `Eleves`
  ADD CONSTRAINT `Eleves_idUtil` FOREIGN KEY (`id_utilisateur`) REFERENCES `Utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Evalue`
--
ALTER TABLE `Evalue`
  ADD CONSTRAINT `Evalue_CompSecUtil` FOREIGN KEY (`idComp_Sec_Util`) REFERENCES `Competence_secondaire` (`id_comp_princ`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Evalue_Eleve` FOREIGN KEY (`idEleve`) REFERENCES `Eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Evalue_Groupe` FOREIGN KEY (`idGroupe`) REFERENCES `Groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Groupe`
--
ALTER TABLE `Groupe`
  ADD CONSTRAINT `Groupe_client` FOREIGN KEY (`idClient`) REFERENCES `Utilisateur` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Groupe_grilleAPP` FOREIGN KEY (`id_groupe`) REFERENCES `Grille_de_competence_APP` (`id_grille`),
  ADD CONSTRAINT `Groupe_tuteur` FOREIGN KEY (`idTuteur`) REFERENCES `Utilisateur` (`id`) ON UPDATE CASCADE;

--
-- Contraintes pour la table `Lie2`
--
ALTER TABLE `Lie2`
  ADD CONSTRAINT `Lie2_Eleve` FOREIGN KEY (`idEleve`) REFERENCES `Eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie2_GrilleComp` FOREIGN KEY (`idGrilleComp`) REFERENCES `Grille_de_competence_APP` (`id_grille`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Lie3`
--
ALTER TABLE `Lie3`
  ADD CONSTRAINT `Lie3_CompPrin` FOREIGN KEY (`idCompPrin`) REFERENCES `Competence_principale` (`id_comp`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie3_GrilleComp` FOREIGN KEY (`idGrilleComp`) REFERENCES `Grille_de_competence_APP` (`id_grille`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Lie5`
--
ALTER TABLE `Lie5`
  ADD CONSTRAINT `Lie5_CompSecUtil` FOREIGN KEY (`idCompSecUtil`) REFERENCES `Competence_secondaire` (`id_comp_princ`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie5_Critere` FOREIGN KEY (`idCritere`) REFERENCES `Critere` (`id_critere`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `Lie6`
--
ALTER TABLE `Lie6`
  ADD CONSTRAINT `Lie6_Groupe` FOREIGN KEY (`idGroupe`) REFERENCES `Groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie6_Planning` FOREIGN KEY (`idPlaning`) REFERENCES `Planning` (`id_planning`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
