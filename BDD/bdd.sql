-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 23, 2017 at 02:24 PM
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
DROP DATABASE `komodo`;
CREATE DATABASE IF NOT EXISTS `komodo` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `komodo`;

-- --------------------------------------------------------

--
-- Table structure for table `Appartient`
--
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Appartient`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Competence_principale`;
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
-- Creation: May 23, 2017 at 11:41 AM
--

DROP TABLE IF EXISTS `Competence_secondaire`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Consulte`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Eleves`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Evalue`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Grille_de_competence_APP`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Groupe`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Lie2`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Lie3`;
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
-- Creation: May 09, 2017 at 12:24 PM
--

DROP TABLE IF EXISTS `Lie6`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Modele_Comp_Prin`;
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
-- Creation: May 09, 2017 at 02:41 PM
--

DROP TABLE IF EXISTS `Modele_Comp_Sec`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Planning`;
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
-- Creation: May 09, 2017 at 12:23 PM
--

DROP TABLE IF EXISTS `Utilisateur`;
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
--
-- Database: `phpmyadmin`
--
DROP DATABASE `phpmyadmin`;
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__bookmark`;
CREATE TABLE `pma__bookmark` (
  `id` int(11) NOT NULL,
  `dbase` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `user` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `query` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

--
-- Truncate table before insert `pma__bookmark`
--

TRUNCATE TABLE `pma__bookmark`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__central_columns`;
CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_length` text COLLATE utf8_bin,
  `col_collation` varchar(64) COLLATE utf8_bin NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) COLLATE utf8_bin DEFAULT '',
  `col_default` text COLLATE utf8_bin
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

--
-- Truncate table before insert `pma__central_columns`
--

TRUNCATE TABLE `pma__central_columns`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__column_info`;
CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `column_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

--
-- Truncate table before insert `pma__column_info`
--

TRUNCATE TABLE `pma__column_info`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--
-- Creation: May 09, 2017 at 11:37 AM
-- Last update: May 23, 2017 at 11:43 AM
--

DROP TABLE IF EXISTS `pma__designer_settings`;
CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `settings_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

--
-- Truncate table before insert `pma__designer_settings`
--

TRUNCATE TABLE `pma__designer_settings`;
--
-- Dumping data for table `pma__designer_settings`
--

INSERT INTO `pma__designer_settings` (`username`, `settings_data`) VALUES
('root', '{"angular_direct":"angular","relation_lines":"true","snap_to_grid":"off"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__export_templates`;
CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `export_type` varchar(10) COLLATE utf8_bin NOT NULL,
  `template_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `template_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

--
-- Truncate table before insert `pma__export_templates`
--

TRUNCATE TABLE `pma__export_templates`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__favorite`;
CREATE TABLE `pma__favorite` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

--
-- Truncate table before insert `pma__favorite`
--

TRUNCATE TABLE `pma__favorite`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__history`;
CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sqlquery` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

--
-- Truncate table before insert `pma__history`
--

TRUNCATE TABLE `pma__history`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__navigationhiding`;
CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `item_type` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

--
-- Truncate table before insert `pma__navigationhiding`
--

TRUNCATE TABLE `pma__navigationhiding`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--
-- Creation: May 09, 2017 at 11:37 AM
-- Last update: May 23, 2017 at 11:46 AM
--

DROP TABLE IF EXISTS `pma__pdf_pages`;
CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

--
-- Truncate table before insert `pma__pdf_pages`
--

TRUNCATE TABLE `pma__pdf_pages`;
--
-- Dumping data for table `pma__pdf_pages`
--

INSERT INTO `pma__pdf_pages` (`db_name`, `page_nr`, `page_descr`) VALUES
('komodo', 1, 'komodo'),
('komodo', 2, 'komodo_05_23');

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--
-- Creation: May 09, 2017 at 11:37 AM
-- Last update: May 23, 2017 at 11:51 AM
--

DROP TABLE IF EXISTS `pma__recent`;
CREATE TABLE `pma__recent` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `tables` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

--
-- Truncate table before insert `pma__recent`
--

TRUNCATE TABLE `pma__recent`;
--
-- Dumping data for table `pma__recent`
--

INSERT INTO `pma__recent` (`username`, `tables`) VALUES
('root', '[{"db":"phpmyadmin","table":"pma__userconfig"},{"db":"phpmyadmin","table":"pma__table_uiprefs"},{"db":"phpmyadmin","table":"pma__table_info"},{"db":"phpmyadmin","table":"pma__table_coords"},{"db":"phpmyadmin","table":"pma__savedsearches"},{"db":"phpmyadmin","table":"pma__relation"},{"db":"phpmyadmin","table":"pma__recent"},{"db":"phpmyadmin","table":"pma__pdf_pages"},{"db":"phpmyadmin","table":"pma__navigationhiding"},{"db":"phpmyadmin","table":"pma__history"}]');

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__relation`;
CREATE TABLE `pma__relation` (
  `master_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `master_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_db` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_table` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `foreign_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

--
-- Truncate table before insert `pma__relation`
--

TRUNCATE TABLE `pma__relation`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__savedsearches`;
CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `search_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

--
-- Truncate table before insert `pma__savedsearches`
--

TRUNCATE TABLE `pma__savedsearches`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--
-- Creation: May 09, 2017 at 11:37 AM
-- Last update: May 23, 2017 at 11:46 AM
--

DROP TABLE IF EXISTS `pma__table_coords`;
CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT '0',
  `x` float UNSIGNED NOT NULL DEFAULT '0',
  `y` float UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

--
-- Truncate table before insert `pma__table_coords`
--

TRUNCATE TABLE `pma__table_coords`;
--
-- Dumping data for table `pma__table_coords`
--

INSERT INTO `pma__table_coords` (`db_name`, `table_name`, `pdf_page_number`, `x`, `y`) VALUES
('komodo', 'Appartient', 1, 1042, 236),
('komodo', 'Appartient', 2, 1042, 236),
('komodo', 'Competence_principale', 1, 65, 602),
('komodo', 'Competence_principale', 2, 65, 602),
('komodo', 'Competence_secondaire', 1, 74, 324),
('komodo', 'Competence_secondaire', 2, 74, 324),
('komodo', 'Consulte', 1, 106, 1),
('komodo', 'Consulte', 2, 106, 1),
('komodo', 'Eleves', 1, 1046, 71),
('komodo', 'Eleves', 2, 1046, 71),
('komodo', 'Evalue', 1, 485, 146),
('komodo', 'Evalue', 2, 485, 146),
('komodo', 'Grille_de_competence_APP', 1, 1061, 780),
('komodo', 'Grille_de_competence_APP', 2, 1061, 780),
('komodo', 'Groupe', 1, 1062, 510),
('komodo', 'Groupe', 2, 1062, 510),
('komodo', 'Lie2', 1, 1700, 293),
('komodo', 'Lie2', 2, 1700, 293),
('komodo', 'Lie3', 1, 405, 781),
('komodo', 'Lie3', 2, 405, 781),
('komodo', 'Lie6', 1, 518, 563),
('komodo', 'Lie6', 2, 518, 563),
('komodo', 'Modele_Comp_Prin', 1, 451, 946),
('komodo', 'Modele_Comp_Prin', 2, 451, 946),
('komodo', 'Modele_Comp_Sec', 1, 812, 951),
('komodo', 'Modele_Comp_Sec', 2, 812, 951),
('komodo', 'Planning', 1, 521, 435),
('komodo', 'Planning', 2, 521, 435),
('komodo', 'Utilisateur', 1, 1296, 368),
('komodo', 'Utilisateur', 2, 1296, 368);

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__table_info`;
CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '',
  `display_field` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

--
-- Truncate table before insert `pma__table_info`
--

TRUNCATE TABLE `pma__table_info`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__table_uiprefs`;
CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `prefs` text COLLATE utf8_bin NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

--
-- Truncate table before insert `pma__table_uiprefs`
--

TRUNCATE TABLE `pma__table_uiprefs`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__tracking`;
CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `table_name` varchar(64) COLLATE utf8_bin NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text COLLATE utf8_bin NOT NULL,
  `schema_sql` text COLLATE utf8_bin,
  `data_sql` longtext COLLATE utf8_bin,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') COLLATE utf8_bin DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

--
-- Truncate table before insert `pma__tracking`
--

TRUNCATE TABLE `pma__tracking`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__userconfig`;
CREATE TABLE `pma__userconfig` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `config_data` text COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Truncate table before insert `pma__userconfig`
--

TRUNCATE TABLE `pma__userconfig`;
--
-- Dumping data for table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2017-05-09 12:21:59', '{"collation_connection":"utf8mb4_unicode_ci"}');

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__usergroups`;
CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL,
  `tab` varchar(64) COLLATE utf8_bin NOT NULL,
  `allowed` enum('Y','N') COLLATE utf8_bin NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

--
-- Truncate table before insert `pma__usergroups`
--

TRUNCATE TABLE `pma__usergroups`;
-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--
-- Creation: May 09, 2017 at 11:37 AM
--

DROP TABLE IF EXISTS `pma__users`;
CREATE TABLE `pma__users` (
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `usergroup` varchar(64) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Truncate table before insert `pma__users`
--

TRUNCATE TABLE `pma__users`;
--
-- Indexes for dumped tables
--

--
-- Indexes for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Indexes for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Indexes for table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Indexes for table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Indexes for table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Indexes for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Indexes for table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Indexes for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Indexes for table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Indexes for table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Indexes for table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Indexes for table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Indexes for table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Indexes for table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
