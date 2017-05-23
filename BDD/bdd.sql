-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 23, 2017 at 03:07 PM
-- Server version: 5.7.18-0ubuntu0.16.04.1
-- PHP Version: 7.0.15-0ubuntu0.16.04.4

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

-- --------------------------------------------------------

--
-- Table structure for table `Appartient`
--

CREATE TABLE `Appartient` (
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idGroupe` int(10) UNSIGNED NOT NULL,
  `actif` tinyint(1) NOT NULL DEFAULT '1',
  `datecrea` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Appartient`
--

TRUNCATE TABLE `Appartient`;
-- --------------------------------------------------------

--
-- Table structure for table `Competence_principale`
--

CREATE TABLE `Competence_principale` (
  `id_comp` int(10) UNSIGNED NOT NULL,
  `Nom_competence_principale` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Competence_principale`
--

TRUNCATE TABLE `Competence_principale`;
-- --------------------------------------------------------

--
-- Table structure for table `Competence_secondaire`
--

CREATE TABLE `Competence_secondaire` (
  `id_comp_second` int(10) UNSIGNED NOT NULL,
  `id_comp_princ` int(10) UNSIGNED NOT NULL,
  `Ponderation` int(2) NOT NULL,
  `Nom` varchar(45) NOT NULL,
  `Critere` varchar(650) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Competence_secondaire`
--

TRUNCATE TABLE `Competence_secondaire`;
-- --------------------------------------------------------

--
-- Table structure for table `Consulte`
--

CREATE TABLE `Consulte` (
  `Evaluation` varchar(45) NOT NULL,
  `CommentaireGroupe` text NOT NULL,
  `CommentaireIndividuel` text NOT NULL,
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idCom_Sec_Util` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Consulte`
--

TRUNCATE TABLE `Consulte`;
-- --------------------------------------------------------

--
-- Table structure for table `Eleves`
--

CREATE TABLE `Eleves` (
  `id_utilisateur` int(10) UNSIGNED NOT NULL,
  `Numero_eleve` int(10) UNSIGNED NOT NULL,
  `Annee` int(10) UNSIGNED NOT NULL,
  `Specialite` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Eleves`
--

TRUNCATE TABLE `Eleves`;
-- --------------------------------------------------------

--
-- Table structure for table `Evalue`
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
-- Truncate table before insert `Evalue`
--

TRUNCATE TABLE `Evalue`;
-- --------------------------------------------------------

--
-- Table structure for table `Grille_de_competence_APP`
--

CREATE TABLE `Grille_de_competence_APP` (
  `id_grille` int(10) UNSIGNED NOT NULL,
  `Nom_grille` varchar(45) NOT NULL,
  `Promo` int(5) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Grille_de_competence_APP`
--

TRUNCATE TABLE `Grille_de_competence_APP`;
--
-- Dumping data for table `Grille_de_competence_APP`
--

INSERT INTO `Grille_de_competence_APP` (`id_grille`, `Nom_grille`, `Promo`) VALUES
(1, 'Grille APP électronique', 2017),
(2, 'Grille APP informatique', 2009);

-- --------------------------------------------------------

--
-- Table structure for table `Groupe`
--

CREATE TABLE `Groupe` (
  `id_groupe` int(10) UNSIGNED NOT NULL,
  `Nom` varchar(45) NOT NULL,
  `idClient` int(10) UNSIGNED DEFAULT NULL,
  `idTuteur` int(10) UNSIGNED DEFAULT NULL,
  `idGrilleAPP` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Groupe`
--

TRUNCATE TABLE `Groupe`;
-- --------------------------------------------------------

--
-- Table structure for table `Lie2`
--

CREATE TABLE `Lie2` (
  `idEleve` int(10) UNSIGNED NOT NULL,
  `idGrilleComp` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Lie2`
--

TRUNCATE TABLE `Lie2`;
-- --------------------------------------------------------

--
-- Table structure for table `Lie3`
--

CREATE TABLE `Lie3` (
  `idGrilleComp` int(10) UNSIGNED NOT NULL,
  `idCompPrin` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Lie3`
--

TRUNCATE TABLE `Lie3`;
-- --------------------------------------------------------

--
-- Table structure for table `Lie6`
--

CREATE TABLE `Lie6` (
  `idGroupe` int(10) UNSIGNED NOT NULL,
  `idPlaning` int(10) UNSIGNED NOT NULL,
  `Descriptif` text NOT NULL,
  `Date` date NOT NULL,
  `Heure` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Lie6`
--

TRUNCATE TABLE `Lie6`;
-- --------------------------------------------------------

--
-- Table structure for table `Modele_Comp_Prin`
--

CREATE TABLE `Modele_Comp_Prin` (
  `idModCompPrin` int(10) UNSIGNED NOT NULL,
  `Nom` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Modele_Comp_Prin`
--

TRUNCATE TABLE `Modele_Comp_Prin`;
--
-- Dumping data for table `Modele_Comp_Prin`
--

INSERT INTO `Modele_Comp_Prin` (`idModCompPrin`, `Nom`) VALUES
(1, 'Intéragir avec son groupe'),
(2, 'Communiquer en anglais et en français');

-- --------------------------------------------------------

--
-- Table structure for table `Modele_Comp_Sec`
--

CREATE TABLE `Modele_Comp_Sec` (
  `idModCompSec` int(10) UNSIGNED NOT NULL,
  `ponderation` int(11) NOT NULL,
  `Nom` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Modele_Comp_Sec`
--

TRUNCATE TABLE `Modele_Comp_Sec`;
-- --------------------------------------------------------

--
-- Table structure for table `Planning`
--

CREATE TABLE `Planning` (
  `id_planning` int(10) UNSIGNED NOT NULL,
  `Nom_planning` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Truncate table before insert `Planning`
--

TRUNCATE TABLE `Planning`;
-- --------------------------------------------------------

--
-- Table structure for table `Utilisateur`
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
-- Truncate table before insert `Utilisateur`
--

TRUNCATE TABLE `Utilisateur`;
--
-- Indexes for dumped tables
--

--
-- Indexes for table `Appartient`
--
ALTER TABLE `Appartient`
  ADD KEY `Appartient_Eleves_idx` (`idEleve`),
  ADD KEY `Appartient_Groupe_idx` (`idGroupe`);

--
-- Indexes for table `Competence_principale`
--
ALTER TABLE `Competence_principale`
  ADD PRIMARY KEY (`id_comp`);

--
-- Indexes for table `Competence_secondaire`
--
ALTER TABLE `Competence_secondaire`
  ADD PRIMARY KEY (`id_comp_second`),
  ADD KEY `CompSec_compPrinc` (`id_comp_princ`);

--
-- Indexes for table `Consulte`
--
ALTER TABLE `Consulte`
  ADD KEY `Consulte_Eleve_idx` (`idEleve`),
  ADD KEY `Consulte_CompSecUtil_idx` (`idCom_Sec_Util`);

--
-- Indexes for table `Eleves`
--
ALTER TABLE `Eleves`
  ADD PRIMARY KEY (`id_utilisateur`),
  ADD UNIQUE KEY `id_utilisateur_UNIQUE` (`id_utilisateur`),
  ADD UNIQUE KEY `Numero eleve_UNIQUE` (`Numero_eleve`);

--
-- Indexes for table `Evalue`
--
ALTER TABLE `Evalue`
  ADD KEY `Evalue_Eleve_idx` (`idEleve`),
  ADD KEY `Evalue_Groupe_idx` (`idGroupe`),
  ADD KEY `Evalue_CompSecUtil_idx` (`idComp_Sec_Util`);

--
-- Indexes for table `Grille_de_competence_APP`
--
ALTER TABLE `Grille_de_competence_APP`
  ADD PRIMARY KEY (`id_grille`);

--
-- Indexes for table `Groupe`
--
ALTER TABLE `Groupe`
  ADD PRIMARY KEY (`id_groupe`),
  ADD UNIQUE KEY `Groupe_grilleAPP_idx` (`idGrilleAPP`),
  ADD KEY `Groupe_prof_idx` (`idClient`),
  ADD KEY `Groupe_tuteur_idx` (`idTuteur`);

--
-- Indexes for table `Lie2`
--
ALTER TABLE `Lie2`
  ADD KEY `Lie2_Eleve_idx` (`idEleve`),
  ADD KEY `Lie2_GrilleComp_idx` (`idGrilleComp`);

--
-- Indexes for table `Lie3`
--
ALTER TABLE `Lie3`
  ADD KEY `Lie3_GrilleComp_idx` (`idGrilleComp`),
  ADD KEY `Lie3_CompPrin_idx` (`idCompPrin`);

--
-- Indexes for table `Lie6`
--
ALTER TABLE `Lie6`
  ADD KEY `Lie6_Groupe_idx` (`idGroupe`),
  ADD KEY `Lie6_Planning_idx` (`idPlaning`);

--
-- Indexes for table `Modele_Comp_Prin`
--
ALTER TABLE `Modele_Comp_Prin`
  ADD PRIMARY KEY (`idModCompPrin`);

--
-- Indexes for table `Modele_Comp_Sec`
--
ALTER TABLE `Modele_Comp_Sec`
  ADD PRIMARY KEY (`idModCompSec`);

--
-- Indexes for table `Planning`
--
ALTER TABLE `Planning`
  ADD PRIMARY KEY (`id_planning`);

--
-- Indexes for table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `NomConnection_UNIQUE` (`NomConnection`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Competence_principale`
--
ALTER TABLE `Competence_principale`
  MODIFY `id_comp` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Competence_secondaire`
--
ALTER TABLE `Competence_secondaire`
  MODIFY `id_comp_second` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Eleves`
--
ALTER TABLE `Eleves`
  MODIFY `id_utilisateur` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Grille_de_competence_APP`
--
ALTER TABLE `Grille_de_competence_APP`
  MODIFY `id_grille` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `Groupe`
--
ALTER TABLE `Groupe`
  MODIFY `id_groupe` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Modele_Comp_Prin`
--
ALTER TABLE `Modele_Comp_Prin`
  MODIFY `idModCompPrin` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `Modele_Comp_Sec`
--
ALTER TABLE `Modele_Comp_Sec`
  MODIFY `idModCompSec` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Planning`
--
ALTER TABLE `Planning`
  MODIFY `id_planning` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `Utilisateur`
--
ALTER TABLE `Utilisateur`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `Appartient`
--
ALTER TABLE `Appartient`
  ADD CONSTRAINT `Appartient_Eleves` FOREIGN KEY (`idEleve`) REFERENCES `Eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Appartient_Groupe` FOREIGN KEY (`idGroupe`) REFERENCES `Groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Competence_secondaire`
--
ALTER TABLE `Competence_secondaire`
  ADD CONSTRAINT `CompSec_compPrinc` FOREIGN KEY (`id_comp_princ`) REFERENCES `Competence_principale` (`id_comp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Consulte`
--
ALTER TABLE `Consulte`
  ADD CONSTRAINT `Consulte_CompSecUtil` FOREIGN KEY (`idCom_Sec_Util`) REFERENCES `Competence_secondaire` (`id_comp_princ`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Consulte_Eleve` FOREIGN KEY (`idEleve`) REFERENCES `Eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Eleves`
--
ALTER TABLE `Eleves`
  ADD CONSTRAINT `Eleves_idUtil` FOREIGN KEY (`id_utilisateur`) REFERENCES `Utilisateur` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Evalue`
--
ALTER TABLE `Evalue`
  ADD CONSTRAINT `Evalue_CompSecUtil` FOREIGN KEY (`idComp_Sec_Util`) REFERENCES `Competence_secondaire` (`id_comp_princ`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Evalue_Eleve` FOREIGN KEY (`idEleve`) REFERENCES `Eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Evalue_Groupe` FOREIGN KEY (`idGroupe`) REFERENCES `Groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Groupe`
--
ALTER TABLE `Groupe`
  ADD CONSTRAINT `Groupe_client` FOREIGN KEY (`idClient`) REFERENCES `Utilisateur` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `Groupe_grilleAPP` FOREIGN KEY (`id_groupe`) REFERENCES `Grille_de_competence_APP` (`id_grille`),
  ADD CONSTRAINT `Groupe_tuteur` FOREIGN KEY (`idTuteur`) REFERENCES `Utilisateur` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `Lie2`
--
ALTER TABLE `Lie2`
  ADD CONSTRAINT `Lie2_Eleve` FOREIGN KEY (`idEleve`) REFERENCES `Eleves` (`id_utilisateur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie2_GrilleComp` FOREIGN KEY (`idGrilleComp`) REFERENCES `Grille_de_competence_APP` (`id_grille`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Lie3`
--
ALTER TABLE `Lie3`
  ADD CONSTRAINT `Lie3_CompPrin` FOREIGN KEY (`idCompPrin`) REFERENCES `Competence_principale` (`id_comp`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie3_GrilleComp` FOREIGN KEY (`idGrilleComp`) REFERENCES `Grille_de_competence_APP` (`id_grille`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Lie6`
--
ALTER TABLE `Lie6`
  ADD CONSTRAINT `Lie6_Groupe` FOREIGN KEY (`idGroupe`) REFERENCES `Groupe` (`id_groupe`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Lie6_Planning` FOREIGN KEY (`idPlaning`) REFERENCES `Planning` (`id_planning`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
