-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 13, 2017 at 03:01 PM
-- Server version: 5.7.18-0ubuntu0.16.04.1
-- PHP Version: 7.0.18-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `komodo`
--




CREATE DATABASE IF NOT EXISTS `komodo` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `komodo`;
CREATE USER 'root'@'localhost' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON komodo.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
-- --------------------------------------------------------

--
-- Table structure for table `appartient`
--

DROP TABLE IF EXISTS `appartient`;
CREATE TABLE `appartient` (
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idGroupe` int(10) UNSIGNED NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `datecrea` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `appartient`
--

TRUNCATE TABLE `appartient`;
--
-- Dumping data for table `appartient`
--

INSERT INTO `appartient` (`idEleve`, `idGroupe`, `actif`, `datecrea`) VALUES
(1, 3, 1, '2017-06-10 20:04:07'),
(15, 3, 1, '2017-06-10 20:04:13');

-- --------------------------------------------------------

--
-- Table structure for table `competence_principale`
--

DROP TABLE IF EXISTS `competence_principale`;
CREATE TABLE `competence_principale` (
  `id_comp` int(10) UNSIGNED NOT NULL,
  `Nom_competence_principale` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `competence_principale`
--

TRUNCATE TABLE `competence_principale`;
--
-- Dumping data for table `competence_principale`
--

INSERT INTO `competence_principale` (`id_comp`, `Nom_competence_principale`) VALUES
(23, ' Agir en bon communicant '),
(24, 'Agir en acteur dynamique dans une équipe'),
(34, 'Composante Informatique');

-- --------------------------------------------------------

--
-- Table structure for table `competence_secondaire`
--

DROP TABLE IF EXISTS `competence_secondaire`;
CREATE TABLE `competence_secondaire` (
  `id_comp_second` int(10) UNSIGNED NOT NULL,
  `id_comp_princ` int(10) UNSIGNED NOT NULL,
  `Ponderation` int(2) NOT NULL,
  `Nom` varchar(45) NOT NULL,
  `Critere` varchar(650) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `competence_secondaire`
--

TRUNCATE TABLE `competence_secondaire`;
--
-- Dumping data for table `competence_secondaire`
--

INSERT INTO `competence_secondaire` (`id_comp_second`, `id_comp_princ`, `Ponderation`, `Nom`, `Critere`) VALUES
(24, 23, 1, 'Echanger', 'Ecouter et se faire écouter\r\n - être disposé à l\'écoute et être capable d\'exposer son point de vue\r\n - admettre que l\'autre peut avoir raison et maintenir l\'intérêt de son auditoire\r\nDialoguer, argumenter et convaincre\r\n - savoir réunir les conditions d\'un dialogue et l\'engager\r\n - avancer des arguments convaincants qui font évoluer les positions des interlocuteurs'),
(25, 23, 1, 'Communiquer à l\'oral ', 'Savoir communiquer, de façon claire et structurée, en français ou en anglais, sur un sujet technique\r\n\r\nAnalyser et synthétiser ses idées scientifiques de façon pertinente tout en s\'adaptant à son public'),
(26, 23, 1, 'Communiquer à l\'écrit', 'Savoir communiquer, de façon claire et structurée, en français ou en anglais, sur un sujet technique\r\n\r\nAnalyser et synthétiser ses idées scientifiques de façon pertinente tout en s\'adaptant à son public'),
(27, 23, 1, 'Jugement global', 'Regroupement général des différentes compétences secondaires de cette compétence principale.'),
(28, 24, 1, 'Travailler en équipe', 'Participer à la vie de l\'équipe\r\n - se montrer ouvert, collaboratif et participatif\r\n - agir avec coordination et entre-aide\r\nAnimer une équipe et la motiver\r\n - animer en maintenant la cohésion de l\'équipe et un minimum d\'intérêt\r\n - motiver les membres de l\'équipe'),
(29, 24, 1, 'Être force de proposition', 'Emettre une idée pertinente\r\n\r\nJustifier et défendre une idée\r\n'),
(30, 24, 1, 'Utiliser des outils de travail collaboratif', 'Utiliser des outils de stockage et de partage de documents (Google drive, dropbox, ...)\r\n\r\nOrganiser et versionner les dossiers et les fichiers de façon claire et structurée dans les espaces de stockage'),
(31, 24, 1, 'Jugement global', 'Regroupement général des différentes compétences secondaires de cette compétence principale.'),
(66, 34, 1, 'Jugement global', 'Regroupement général des différentes compétences secondaires de cette compétence principale.'),
(67, 34, 1, 'Spécification des besoins (MOA)', 'Extraire et comprendre les besoins fonctionnels et non fonctionnels\r\n\r\nModéliser les fonctionnalités (UML, scénario basique, algorithme, processus, langage naturel, etc.)'),
(68, 34, 1, 'Conception visuelle (MOE)', 'Traduire les besoins en interfaces et définir leur enchainement (charte graphique, logo, plan du site)\r\n\r\nTenir compte de l\'ergonomie et de la fluidité de la navigation\r\n'),
(69, 34, 2, 'Mise en place d\'un SGBD', 'Réaliser le mapping d\'un modèle E/A vers le modèle relationnel\r\n\r\nImplémenter une BD dans un SGBD\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `eleves`
--

DROP TABLE IF EXISTS `eleves`;
CREATE TABLE `eleves` (
  `id_utilisateur` int(10) UNSIGNED NOT NULL,
  `Numero_eleve` int(10) UNSIGNED NOT NULL,
  `Annee` int(10) UNSIGNED NOT NULL,
  `Specialite` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `eleves`
--

TRUNCATE TABLE `eleves`;
--
-- Dumping data for table `eleves`
--

INSERT INTO `eleves` (`id_utilisateur`, `Numero_eleve`, `Annee`, `Specialite`) VALUES
(1, 8851, 2020, 'Génie Logiciel'),
(15, 9456, 2020, 'Génie Logiciel');

-- --------------------------------------------------------

--
-- Table structure for table `evalue`
--

DROP TABLE IF EXISTS `evalue`;
CREATE TABLE `evalue` (
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idGroupe` int(10) UNSIGNED NOT NULL,
  `idComp_Sec_Util` int(10) UNSIGNED NOT NULL,
  `Evaluation` varchar(45) NOT NULL,
  `CommentaireIndividuel` text NOT NULL,
  `CommentaireGroupe` text NOT NULL,
  `CommentaireProfesseur` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `evalue`
--

TRUNCATE TABLE `evalue`;
--
-- Dumping data for table `evalue`
--

INSERT INTO `evalue` (`idEleve`, `idGroupe`, `idComp_Sec_Util`, `Evaluation`, `CommentaireIndividuel`, `CommentaireGroupe`, `CommentaireProfesseur`) VALUES
(1, 3, 24, 'attendu', 'Elève qui sait écouter et se faire écouter.', 'De bons échanges au sein de ce groupe.', ''),
(1, 3, 25, 'attendu', 'Explication clair et structurée sur le projet.', 'Une bonne communication au sein de ce groupe.', ''),
(1, 3, 27, '', 'Bon communiquant à l\'écrit comme à l\'oral.', 'Groupe qui sait communiquer à l\'écrit et à l\'oral.', ''),
(1, 3, 28, 'attendu', 'Eleve qui sait bien insérer dans son groupe.', 'Groupe qui avance bien et qui s\'entend bien.', ''),
(1, 3, 26, 'attendu', 'Bon communiquant à l\'écrit.', '', ''),
(1, 3, 29, 'attendu', 'Elève qui a des idées et qui sait les défendre.', '', ''),
(1, 3, 30, 'attendu', 'Elève qui sait se servir d\'outils de travail collaboratif.', 'Groupe qui sait se servir d\'outils de travail collaboratif.', ''),
(1, 3, 31, '', 'Eleve qui travaille bien en équipe avec des outils variés et qui sait être force de proposition pour son groupe. ', 'Groupe qui sait utilisé des outils de travail collaboratif.', ''),
(1, 3, 66, 'tproche', 'Quelques difficultés pour visualiser les besoins, avoir une bonne conception visuelle du sujet. ', '', ''),
(1, 3, 67, 'tproche', 'Pas assez de rigueur pour bien comprendre les spécifications.', '', ''),
(1, 3, 68, 'tproche', 'Mauvaise visualisation du sujet.', '', ''),
(1, 3, 69, 'tproche', 'Pas très bien compris le concept d\'un SGBD au début du projet, ce qui a été pénalisant pour la suite.', '', ''),
(15, 3, 24, 'attendu', 'Bonne capacité pour échanger.', 'De bons échanges au sein de ce groupe.', ''),
(15, 3, 25, 'attendu', 'Bon communiquant à l\'oral', 'Une bonne communication au sein de ce groupe.', ''),
(15, 3, 26, 'attendu', 'Bon communiquant à l\'écrit.', '', ''),
(15, 3, 27, '', 'Bon communiquant à l\'écrit comme à l\'oral.', 'Groupe qui sait communiquer à l\'écrit et à l\'oral.', ''),
(15, 3, 28, 'attendu', 'Elève qui sait travailler en équipe.', 'Groupe qui avance bien et qui s\'entend bien.', ''),
(15, 3, 29, 'proche', 'Elève très réservé.', '', ''),
(15, 3, 30, 'attendu', 'Elève qui sait se servir d\'outils collaboratif.', 'Groupe qui sait se servir d\'outils de travail collaboratif.', ''),
(15, 3, 31, '', 'Bonne adaptation à l\'équipe au niveau des tâches à effectuer mais encore trop discret. ', 'Groupe qui sait travailler avec des outils de travail collaboratif et qui travail bien en équipe.', ''),
(15, 3, 66, '', 'Besoin très bien compris et très clair.', '', ''),
(15, 3, 67, 'attendu ', 'Spécification définit rapidement car une bonne compréhension des besoins. ', '', ''),
(15, 3, 68, 'attendu', 'Conception visuelle nette et propre, compréhensible par tous.', '', ''),
(15, 3, 69, 'attendu', 'Bonne compréhension de l\'utilisation du SGBD.', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `grille_de_competence_app`
--

DROP TABLE IF EXISTS `grille_de_competence_app`;
CREATE TABLE `grille_de_competence_app` (
  `id_grille` int(10) UNSIGNED NOT NULL,
  `Nom_grille` varchar(45) NOT NULL,
  `Promo` int(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `grille_de_competence_app`
--

TRUNCATE TABLE `grille_de_competence_app`;
--
-- Dumping data for table `grille_de_competence_app`
--

INSERT INTO `grille_de_competence_app` (`id_grille`, `Nom_grille`, `Promo`) VALUES
(6, 'APP composante informatique', 2020);

-- --------------------------------------------------------

--
-- Table structure for table `groupe`
--

DROP TABLE IF EXISTS `groupe`;
CREATE TABLE `groupe` (
  `id_groupe` int(10) UNSIGNED NOT NULL,
  `Nom` varchar(45) NOT NULL,
  `idClient` int(10) UNSIGNED DEFAULT NULL,
  `idTuteur` int(10) UNSIGNED DEFAULT NULL,
  `idGrilleAPP` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `groupe`
--

TRUNCATE TABLE `groupe`;
--
-- Dumping data for table `groupe`
--

INSERT INTO `groupe` (`id_groupe`, `Nom`, `idClient`, `idTuteur`, `idGrilleAPP`) VALUES
(3, 'Groupe APP informatique', 14, 9, 6);

-- --------------------------------------------------------

--
-- Table structure for table `lie2`
--

DROP TABLE IF EXISTS `lie2`;
CREATE TABLE `lie2` (
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idGrilleComp` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `lie2`
--

TRUNCATE TABLE `lie2`;
--
-- Dumping data for table `lie2`
--

INSERT INTO `lie2` (`idEleve`, `idGrilleComp`) VALUES
(1, 6),
(15, 6);

-- --------------------------------------------------------

--
-- Table structure for table `lie3`
--

DROP TABLE IF EXISTS `lie3`;
CREATE TABLE `lie3` (
  `idGrilleComp` int(10) UNSIGNED NOT NULL,
  `idCompPrin` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `lie3`
--

TRUNCATE TABLE `lie3`;
--
-- Dumping data for table `lie3`
--

INSERT INTO `lie3` (`idGrilleComp`, `idCompPrin`) VALUES
(6, 23),
(6, 24),
(6, 34);

-- --------------------------------------------------------

--
-- Table structure for table `lie6`
--

DROP TABLE IF EXISTS `lie6`;
CREATE TABLE `lie6` (
  `idGroupe` int(10) UNSIGNED NOT NULL,
  `idPlaning` int(10) UNSIGNED NOT NULL,
  `Date` date NOT NULL,
  `Debut` time DEFAULT NULL,
  `Fin` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `lie6`
--

TRUNCATE TABLE `lie6`;
--
-- Dumping data for table `lie6`
--

INSERT INTO `lie6` (`idGroupe`, `idPlaning`, `Date`, `Debut`, `Fin`) VALUES
(3, 1, '2018-01-26', '10:20:00', '10:40:00'),
(3, 1, '2018-02-24', '15:00:00', '15:30:00'),
(3, 1, '2018-04-10', '14:20:00', '14:50:00'),
(3, 2, '2018-06-22', '11:00:00', '11:50:00');

-- --------------------------------------------------------

--
-- Table structure for table `modele_comp_prin`
--

DROP TABLE IF EXISTS `modele_comp_prin`;
CREATE TABLE `modele_comp_prin` (
  `idModCompPrin` int(10) UNSIGNED NOT NULL,
  `Nom` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `modele_comp_prin`
--

TRUNCATE TABLE `modele_comp_prin`;
--
-- Dumping data for table `modele_comp_prin`
--

INSERT INTO `modele_comp_prin` (`idModCompPrin`, `Nom`) VALUES
(1, ' Agir en bon communicant '),
(2, 'Agir en acteur dynamique dans une équipe'),
(3, 'Conduite de projet'),
(4, ' Agir en professionnel responsable'),
(5, 'Composante Electronique'),
(6, 'Composante Informatique');

-- --------------------------------------------------------

--
-- Table structure for table `modele_comp_sec`
--

DROP TABLE IF EXISTS `modele_comp_sec`;
CREATE TABLE `modele_comp_sec` (
  `idModCompSec` int(10) UNSIGNED NOT NULL,
  `Nom` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `modele_comp_sec`
--

TRUNCATE TABLE `modele_comp_sec`;
--
-- Dumping data for table `modele_comp_sec`
--

INSERT INTO `modele_comp_sec` (`idModCompSec`, `Nom`) VALUES
(23, 'Echanger'),
(24, 'Communiquer à l\'oral '),
(25, 'Communiquer à l\'écrit'),
(26, 'Travailler en équipe'),
(27, 'Être force de proposition'),
(28, 'Utiliser des outils de travail collaboratif'),
(29, 'Planifier un projet'),
(30, 'Suivre l\'évolution du projet'),
(31, 'Utiliser des outils de gestion de projets'),
(32, 'Agir avec probité professionnelle'),
(33, 'Respecter les délais'),
(34, 'Faire preuve d?autonomie'),
(35, 'Vue systémique'),
(36, 'Lois des circuits électriques'),
(37, 'Puissance'),
(38, 'Spécification des besoins (MOA)'),
(39, 'Conception visuelle (MOE)'),
(40, 'Mise en place d\'un SGBD');

-- --------------------------------------------------------

--
-- Table structure for table `planning`
--

DROP TABLE IF EXISTS `planning`;
CREATE TABLE `planning` (
  `id_planning` int(10) UNSIGNED NOT NULL,
  `Nom_planning` varchar(45) NOT NULL,
  `Description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `planning`
--

TRUNCATE TABLE `planning`;
--
-- Dumping data for table `planning`
--

INSERT INTO `planning` (`id_planning`, `Nom_planning`, `Description`) VALUES
(1, 'Réunion client', 'Présenter son travail réaliser depuis les dernières séances.'),
(2, 'Soutenance final', 'Présenter l\'ensemble de son travail réaliser au cours de l\'année.');

-- --------------------------------------------------------

--
-- Table structure for table `utilisateur`
--

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE `utilisateur` (
  `id` int(10) UNSIGNED NOT NULL,
  `Nom` varchar(45) NOT NULL,
  `Prenom` varchar(45) NOT NULL,
  `Age` int(10) UNSIGNED NOT NULL,
  `Type` varchar(45) NOT NULL,
  `NomConnection` varchar(32) NOT NULL,
  `MotDePasse` varchar(320) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `utilisateur`
--

TRUNCATE TABLE `utilisateur`;
--
-- Dumping data for table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `Nom`, `Prenom`, `Age`, `Type`, `NomConnection`, `MotDePasse`) VALUES
(1, 'HUBERT', 'Alexandre', 22, 'eleve', 'AlexHub', '9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0'),
(5, 'Monas', 'Pierre', 45, 'responsable', 'PierreMon', '9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0'),
(9, 'Dupond', 'Alexandre', 40, 'professeur', 'AlexDup', '9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0'),
(13, 'Dupont', 'Sylvain', 34, 'responsable', 'SylvainDup', '9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0'),
(14, 'Allain', 'Thomas', 30, 'professeur', 'ThomasAll', '9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0'),
(15, 'Edouard', 'Pierre', 22, 'eleve', 'PierreEdo', '9af15b336e6a9619928537df30b2e6a2376569fcf9d7e773eccede65606529a0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appartient`
--
ALTER TABLE `appartient`
  ADD KEY `Appartient_Eleves_idx` (`idEleve`),
  ADD KEY `Appartient_Groupe_idx` (`idGroupe`);

--
-- Indexes for table `competence_principale`
--
ALTER TABLE `competence_principale`
  ADD PRIMARY KEY (`id_comp`);

--
-- Indexes for table `competence_secondaire`
--
ALTER TABLE `competence_secondaire`
  ADD PRIMARY KEY (`id_comp_second`),
  ADD KEY `CompSec_compPrinc` (`id_comp_princ`);

--
-- Indexes for table `eleves`
--
ALTER TABLE `eleves`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD UNIQUE KEY `id_utilisateur_UNIQUE` (`id_utilisateur`),
  ADD UNIQUE KEY `Numero eleve_UNIQUE` (`Numero_eleve`);

--
-- Indexes for table `evalue`
--
ALTER TABLE `evalue`
  ADD KEY `Evalue_Eleve_idx` (`idEleve`),
  ADD KEY `Evalue_Groupe_idx` (`idGroupe`),
  ADD KEY `Evalue_CompSecUtil_idx` (`idComp_Sec_Util`);

--
-- Indexes for table `grille_de_competence_app`
--
ALTER TABLE `grille_de_competence_app`
  ADD PRIMARY KEY (`id_grille`);

--
-- Indexes for table `groupe`
--
ALTER TABLE `groupe`
  ADD PRIMARY KEY (`id_groupe`),
  ADD KEY `Groupe_prof_idx` (`idClient`),
  ADD KEY `Groupe_tuteur_idx` (`idTuteur`),
  ADD KEY `Groupe_grilleAPP_idx` (`idGrilleAPP`) USING BTREE;

--
-- Indexes for table `lie2`
--
ALTER TABLE `lie2`
  ADD KEY `Lie2_Eleve_idx` (`idEleve`),
  ADD KEY `Lie2_GrilleComp_idx` (`idGrilleComp`);

--
-- Indexes for table `lie3`
--
ALTER TABLE `lie3`
  ADD KEY `Lie3_GrilleComp_idx` (`idGrilleComp`),
  ADD KEY `Lie3_CompPrin_idx` (`idCompPrin`);

--
-- Indexes for table `lie6`
--
ALTER TABLE `lie6`
  ADD KEY `Lie6_Groupe_idx` (`idGroupe`),
  ADD KEY `Lie6_Planning_idx` (`idPlaning`);

--
-- Indexes for table `modele_comp_prin`
--
ALTER TABLE `modele_comp_prin`
  ADD PRIMARY KEY (`idModCompPrin`);

--
-- Indexes for table `modele_comp_sec`
--
ALTER TABLE `modele_comp_sec`
  ADD PRIMARY KEY (`idModCompSec`);

--
-- Indexes for table `planning`
--
ALTER TABLE `planning`
  ADD PRIMARY KEY (`id_planning`);

--
-- Indexes for table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `NomConnection_UNIQUE` (`NomConnection`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `competence_principale`
--
ALTER TABLE `competence_principale`
  MODIFY `id_comp` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT for table `competence_secondaire`
--
ALTER TABLE `competence_secondaire`
  MODIFY `id_comp_second` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;
--
-- AUTO_INCREMENT for table `eleves`
--
ALTER TABLE `eleves`
  MODIFY `id_utilisateur` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `grille_de_competence_app`
--
ALTER TABLE `grille_de_competence_app`
  MODIFY `id_grille` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `groupe`
--
ALTER TABLE `groupe`
  MODIFY `id_groupe` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `modele_comp_prin`
--
ALTER TABLE `modele_comp_prin`
  MODIFY `idModCompPrin` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `modele_comp_sec`
--
ALTER TABLE `modele_comp_sec`
  MODIFY `idModCompSec` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;
--
-- AUTO_INCREMENT for table `planning`
--
ALTER TABLE `planning`
  MODIFY `id_planning` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `appartient`
--
ALTER TABLE `appartient`
  ADD CONSTRAINT `Appartient_Eleves` FOREIGN KEY (`idEleve`) REFERENCES `eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Appartient_Groupe` FOREIGN KEY (`idGroupe`) REFERENCES `groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `competence_secondaire`
--
ALTER TABLE `competence_secondaire`
  ADD CONSTRAINT `CompSec_compPrinc` FOREIGN KEY (`id_comp_princ`) REFERENCES `competence_principale` (`id_comp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `eleves`
--
ALTER TABLE `eleves`
  ADD CONSTRAINT `Eleves_idUtil` FOREIGN KEY (`id_utilisateur`) REFERENCES `utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `evalue`
--
ALTER TABLE `evalue`
  ADD CONSTRAINT `Evalue_CompSecUtil` FOREIGN KEY (`idComp_Sec_Util`) REFERENCES `competence_secondaire` (`id_comp_second`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Evalue_Eleve` FOREIGN KEY (`idEleve`) REFERENCES `eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Evalue_Groupe` FOREIGN KEY (`idGroupe`) REFERENCES `groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `groupe`
--
ALTER TABLE `groupe`
  ADD CONSTRAINT `Groupe_client` FOREIGN KEY (`idClient`) REFERENCES `utilisateur` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Groupe_grilleAPP` FOREIGN KEY (`idGrilleAPP`) REFERENCES `grille_de_competence_app` (`id_grille`),
  ADD CONSTRAINT `Groupe_tuteur` FOREIGN KEY (`idTuteur`) REFERENCES `utilisateur` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `lie2`
--
ALTER TABLE `lie2`
  ADD CONSTRAINT `Lie2_Eleve` FOREIGN KEY (`idEleve`) REFERENCES `eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie2_GrilleComp` FOREIGN KEY (`idGrilleComp`) REFERENCES `grille_de_competence_app` (`id_grille`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lie3`
--
ALTER TABLE `lie3`
  ADD CONSTRAINT `Lie3_CompPrin` FOREIGN KEY (`idCompPrin`) REFERENCES `competence_principale` (`id_comp`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie3_GrilleComp` FOREIGN KEY (`idGrilleComp`) REFERENCES `grille_de_competence_app` (`id_grille`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lie6`
--
ALTER TABLE `lie6`
  ADD CONSTRAINT `Lie6_Groupe` FOREIGN KEY (`idGroupe`) REFERENCES `groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie6_Planning` FOREIGN KEY (`idPlaning`) REFERENCES `planning` (`id_planning`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
