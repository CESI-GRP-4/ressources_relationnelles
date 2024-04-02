-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
re-- Généré le : mar. 02 avr. 2024 à 22:15
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Structure de la table `pma__bookmark`
--

CREATE TABLE `pma__bookmark` (
  `id` int(10) UNSIGNED NOT NULL,
  `dbase` varchar(255) NOT NULL DEFAULT '',
  `user` varchar(255) NOT NULL DEFAULT '',
  `label` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `query` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Bookmarks';

-- --------------------------------------------------------

--
-- Structure de la table `pma__central_columns`
--

CREATE TABLE `pma__central_columns` (
  `db_name` varchar(64) NOT NULL,
  `col_name` varchar(64) NOT NULL,
  `col_type` varchar(64) NOT NULL,
  `col_length` text DEFAULT NULL,
  `col_collation` varchar(64) NOT NULL,
  `col_isNull` tinyint(1) NOT NULL,
  `col_extra` varchar(255) DEFAULT '',
  `col_default` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Central list of columns';

-- --------------------------------------------------------

--
-- Structure de la table `pma__column_info`
--

CREATE TABLE `pma__column_info` (
  `id` int(5) UNSIGNED NOT NULL,
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `column_name` varchar(64) NOT NULL DEFAULT '',
  `comment` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `mimetype` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `transformation` varchar(255) NOT NULL DEFAULT '',
  `transformation_options` varchar(255) NOT NULL DEFAULT '',
  `input_transformation` varchar(255) NOT NULL DEFAULT '',
  `input_transformation_options` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Column information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Structure de la table `pma__designer_settings`
--

CREATE TABLE `pma__designer_settings` (
  `username` varchar(64) NOT NULL,
  `settings_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Settings related to Designer';

-- --------------------------------------------------------

--
-- Structure de la table `pma__export_templates`
--

CREATE TABLE `pma__export_templates` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL,
  `export_type` varchar(10) NOT NULL,
  `template_name` varchar(64) NOT NULL,
  `template_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved export templates';

-- --------------------------------------------------------

--
-- Structure de la table `pma__favorite`
--

CREATE TABLE `pma__favorite` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Favorite tables';

-- --------------------------------------------------------

--
-- Structure de la table `pma__history`
--

CREATE TABLE `pma__history` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db` varchar(64) NOT NULL DEFAULT '',
  `table` varchar(64) NOT NULL DEFAULT '',
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp(),
  `sqlquery` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='SQL history for phpMyAdmin';

-- --------------------------------------------------------

--
-- Structure de la table `pma__navigationhiding`
--

CREATE TABLE `pma__navigationhiding` (
  `username` varchar(64) NOT NULL,
  `item_name` varchar(64) NOT NULL,
  `item_type` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Hidden items of navigation tree';

-- --------------------------------------------------------

--
-- Structure de la table `pma__pdf_pages`
--

CREATE TABLE `pma__pdf_pages` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `page_nr` int(10) UNSIGNED NOT NULL,
  `page_descr` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='PDF relation pages for phpMyAdmin';

-- --------------------------------------------------------

--
-- Structure de la table `pma__recent`
--

CREATE TABLE `pma__recent` (
  `username` varchar(64) NOT NULL,
  `tables` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Recently accessed tables';

-- --------------------------------------------------------

--
-- Structure de la table `pma__relation`
--

CREATE TABLE `pma__relation` (
  `master_db` varchar(64) NOT NULL DEFAULT '',
  `master_table` varchar(64) NOT NULL DEFAULT '',
  `master_field` varchar(64) NOT NULL DEFAULT '',
  `foreign_db` varchar(64) NOT NULL DEFAULT '',
  `foreign_table` varchar(64) NOT NULL DEFAULT '',
  `foreign_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Relation table';

-- --------------------------------------------------------

--
-- Structure de la table `pma__savedsearches`
--

CREATE TABLE `pma__savedsearches` (
  `id` int(5) UNSIGNED NOT NULL,
  `username` varchar(64) NOT NULL DEFAULT '',
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `search_name` varchar(64) NOT NULL DEFAULT '',
  `search_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Saved searches';

-- --------------------------------------------------------

--
-- Structure de la table `pma__table_coords`
--

CREATE TABLE `pma__table_coords` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `pdf_page_number` int(11) NOT NULL DEFAULT 0,
  `x` float UNSIGNED NOT NULL DEFAULT 0,
  `y` float UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table coordinates for phpMyAdmin PDF output';

-- --------------------------------------------------------

--
-- Structure de la table `pma__table_info`
--

CREATE TABLE `pma__table_info` (
  `db_name` varchar(64) NOT NULL DEFAULT '',
  `table_name` varchar(64) NOT NULL DEFAULT '',
  `display_field` varchar(64) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Table information for phpMyAdmin';

-- --------------------------------------------------------

--
-- Structure de la table `pma__table_uiprefs`
--

CREATE TABLE `pma__table_uiprefs` (
  `username` varchar(64) NOT NULL,
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `prefs` text NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Tables'' UI preferences';

-- --------------------------------------------------------

--
-- Structure de la table `pma__tracking`
--

CREATE TABLE `pma__tracking` (
  `db_name` varchar(64) NOT NULL,
  `table_name` varchar(64) NOT NULL,
  `version` int(10) UNSIGNED NOT NULL,
  `date_created` datetime NOT NULL,
  `date_updated` datetime NOT NULL,
  `schema_snapshot` text NOT NULL,
  `schema_sql` text DEFAULT NULL,
  `data_sql` longtext DEFAULT NULL,
  `tracking` set('UPDATE','REPLACE','INSERT','DELETE','TRUNCATE','CREATE DATABASE','ALTER DATABASE','DROP DATABASE','CREATE TABLE','ALTER TABLE','RENAME TABLE','DROP TABLE','CREATE INDEX','DROP INDEX','CREATE VIEW','ALTER VIEW','DROP VIEW') DEFAULT NULL,
  `tracking_active` int(1) UNSIGNED NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Database changes tracking for phpMyAdmin';

-- --------------------------------------------------------

--
-- Structure de la table `pma__userconfig`
--

CREATE TABLE `pma__userconfig` (
  `username` varchar(64) NOT NULL,
  `timevalue` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `config_data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User preferences storage for phpMyAdmin';

--
-- Déchargement des données de la table `pma__userconfig`
--

INSERT INTO `pma__userconfig` (`username`, `timevalue`, `config_data`) VALUES
('root', '2024-01-20 10:58:20', '{\"Console\\/Mode\":\"collapse\",\"lang\":\"fr\"}');

-- --------------------------------------------------------

--
-- Structure de la table `pma__usergroups`
--

CREATE TABLE `pma__usergroups` (
  `usergroup` varchar(64) NOT NULL,
  `tab` varchar(64) NOT NULL,
  `allowed` enum('Y','N') NOT NULL DEFAULT 'N'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='User groups with configured menu items';

-- --------------------------------------------------------

--
-- Structure de la table `pma__users`
--

CREATE TABLE `pma__users` (
  `username` varchar(64) NOT NULL,
  `usergroup` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Users and their assignments to user groups';

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pma__central_columns`
--
ALTER TABLE `pma__central_columns`
  ADD PRIMARY KEY (`db_name`,`col_name`);

--
-- Index pour la table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`);

--
-- Index pour la table `pma__designer_settings`
--
ALTER TABLE `pma__designer_settings`
  ADD PRIMARY KEY (`username`);

--
-- Index pour la table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_user_type_template` (`username`,`export_type`,`template_name`);

--
-- Index pour la table `pma__favorite`
--
ALTER TABLE `pma__favorite`
  ADD PRIMARY KEY (`username`);

--
-- Index pour la table `pma__history`
--
ALTER TABLE `pma__history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `username` (`username`,`db`,`table`,`timevalue`);

--
-- Index pour la table `pma__navigationhiding`
--
ALTER TABLE `pma__navigationhiding`
  ADD PRIMARY KEY (`username`,`item_name`,`item_type`,`db_name`,`table_name`);

--
-- Index pour la table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  ADD PRIMARY KEY (`page_nr`),
  ADD KEY `db_name` (`db_name`);

--
-- Index pour la table `pma__recent`
--
ALTER TABLE `pma__recent`
  ADD PRIMARY KEY (`username`);

--
-- Index pour la table `pma__relation`
--
ALTER TABLE `pma__relation`
  ADD PRIMARY KEY (`master_db`,`master_table`,`master_field`),
  ADD KEY `foreign_field` (`foreign_db`,`foreign_table`);

--
-- Index pour la table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `u_savedsearches_username_dbname` (`username`,`db_name`,`search_name`);

--
-- Index pour la table `pma__table_coords`
--
ALTER TABLE `pma__table_coords`
  ADD PRIMARY KEY (`db_name`,`table_name`,`pdf_page_number`);

--
-- Index pour la table `pma__table_info`
--
ALTER TABLE `pma__table_info`
  ADD PRIMARY KEY (`db_name`,`table_name`);

--
-- Index pour la table `pma__table_uiprefs`
--
ALTER TABLE `pma__table_uiprefs`
  ADD PRIMARY KEY (`username`,`db_name`,`table_name`);

--
-- Index pour la table `pma__tracking`
--
ALTER TABLE `pma__tracking`
  ADD PRIMARY KEY (`db_name`,`table_name`,`version`);

--
-- Index pour la table `pma__userconfig`
--
ALTER TABLE `pma__userconfig`
  ADD PRIMARY KEY (`username`);

--
-- Index pour la table `pma__usergroups`
--
ALTER TABLE `pma__usergroups`
  ADD PRIMARY KEY (`usergroup`,`tab`,`allowed`);

--
-- Index pour la table `pma__users`
--
ALTER TABLE `pma__users`
  ADD PRIMARY KEY (`username`,`usergroup`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `pma__bookmark`
--
ALTER TABLE `pma__bookmark`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pma__column_info`
--
ALTER TABLE `pma__column_info`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pma__export_templates`
--
ALTER TABLE `pma__export_templates`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pma__history`
--
ALTER TABLE `pma__history`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pma__pdf_pages`
--
ALTER TABLE `pma__pdf_pages`
  MODIFY `page_nr` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `pma__savedsearches`
--
ALTER TABLE `pma__savedsearches`
  MODIFY `id` int(5) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- Base de données : `ressources_relationnelles`
--
CREATE DATABASE IF NOT EXISTS `ressources_relationnelles` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `ressources_relationnelles`;

-- --------------------------------------------------------

--
-- Structure de la table `asso_ressource_game`
--

CREATE TABLE `asso_ressource_game` (
  `id_ressource` int(11) NOT NULL,
  `id_game` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_ressource_game`
--

INSERT INTO `asso_ressource_game` (`id_ressource`, `id_game`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `asso_ressource_statistic`
--

CREATE TABLE `asso_ressource_statistic` (
  `id_ressource` int(11) NOT NULL,
  `id_statistic_archive` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_ressource_statistic`
--

INSERT INTO `asso_ressource_statistic` (`id_ressource`, `id_statistic_archive`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `asso_role_right`
--

CREATE TABLE `asso_role_right` (
  `id_role` int(11) NOT NULL,
  `id_right` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_role_right`
--

INSERT INTO `asso_role_right` (`id_role`, `id_right`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_bookmark`
--

CREATE TABLE `asso_user_bookmark` (
  `id_user` int(11) NOT NULL,
  `id_ressource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_user_bookmark`
--

INSERT INTO `asso_user_bookmark` (`id_user`, `id_ressource`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_note`
--

CREATE TABLE `asso_user_note` (
  `id_user` int(11) NOT NULL,
  `id_ressource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_user_note`
--

INSERT INTO `asso_user_note` (`id_user`, `id_ressource`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_ressource`
--

CREATE TABLE `asso_user_ressource` (
  `id_user` int(11) NOT NULL,
  `id_ressource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_user_ressource`
--

INSERT INTO `asso_user_ressource` (`id_user`, `id_ressource`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `blocked_users`
--

CREATE TABLE `blocked_users` (
  `id_blocked` int(11) NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `blocked_users`
--

INSERT INTO `blocked_users` (`id_blocked`, `start_date`, `end_date`, `id_user`) VALUES
(6, '2024-02-22 20:15:30', '2124-02-22 20:15:30', 31),
(8, '2024-02-26 20:50:48', '2124-02-26 20:50:48', 25);

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id_category` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id_category`, `name`) VALUES
(1, 'Education'),
(2, 'Entertainment');

-- --------------------------------------------------------

--
-- Structure de la table `cities`
--

CREATE TABLE `cities` (
  `id_city` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `cities`
--

INSERT INTO `cities` (`id_city`, `name`) VALUES
(1, 'Paris'),
(2, 'New York'),
(3, 'Tokyo'),
(7, 'Pariss'),
(8, 'Parisssss');

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

CREATE TABLE `comments` (
  `id_comment` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `posting_date` datetime NOT NULL,
  `id_parent_comment` int(11) DEFAULT NULL,
  `id_ressource` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id_comment`, `content`, `posting_date`, `id_parent_comment`, `id_ressource`, `id_user`) VALUES
(1, 'Great Ressource!', '2024-01-18 22:38:55', NULL, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `countries`
--

CREATE TABLE `countries` (
  `id_country` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country_code` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `countries`
--

INSERT INTO `countries` (`id_country`, `name`, `country_code`) VALUES
(1, 'Afghanistan', 'AF'),
(2, 'Albanie', 'AL'),
(3, 'Antarctique', 'AQ'),
(4, 'Algérie', 'DZ'),
(5, 'Samoa Américaines', 'AS'),
(6, 'Andorre', 'AD'),
(7, 'Angola', 'AO'),
(8, 'Antigua-et-Barbuda', 'AG'),
(9, 'Azerbaïdjan', 'AZ'),
(10, 'Argentine', 'AR'),
(11, 'Australie', 'AU'),
(12, 'Autriche', 'AT'),
(13, 'Bahamas', 'BS'),
(14, 'Bahreïn', 'BH'),
(15, 'Bangladesh', 'BD'),
(16, 'Arménie', 'AM'),
(17, 'Barbade', 'BB'),
(18, 'Belgique', 'BE'),
(19, 'Bermudes', 'BM'),
(20, 'Bhoutan', 'BT'),
(21, 'Bolivie', 'BO'),
(22, 'Bosnie-Herzégovine', 'BA'),
(23, 'Botswana', 'BW'),
(24, 'Île Bouvet', 'BV'),
(25, 'Brésil', 'BR'),
(26, 'Belize', 'BZ'),
(27, 'Territoire Britannique de l\'Océan Indien', 'IO'),
(28, 'Îles Salomon', 'SB'),
(29, 'Îles Vierges Britanniques', 'VG'),
(30, 'Brunéi Darussalam', 'BN'),
(31, 'Bulgarie', 'BG'),
(32, 'Myanmar', 'MM'),
(33, 'Burundi', 'BI'),
(34, 'Belarus', 'BY'),
(35, 'Cambodge', 'KH'),
(36, 'Cameroun', 'CM'),
(37, 'Canada', 'CA'),
(38, 'Cap-vert', 'CV'),
(39, 'Îles Caïmanes', 'KY'),
(40, 'République Centrafricaine', 'CF'),
(41, 'Sri Lanka', 'LK'),
(42, 'Tchad', 'TD'),
(43, 'Chili', 'CL'),
(44, 'Chine', 'CN'),
(45, 'Taïwan', 'TW'),
(46, 'Île Christmas', 'CX'),
(47, 'Îles Cocos (Keeling)', 'CC'),
(48, 'Colombie', 'CO'),
(49, 'Comores', 'KM'),
(50, 'Mayotte', 'YT'),
(51, 'République du Congo', 'CG'),
(52, 'République Démocratique du Congo', 'CD'),
(53, 'Îles Cook', 'CK'),
(54, 'Costa Rica', 'CR'),
(55, 'Croatie', 'HR'),
(56, 'Cuba', 'CU'),
(57, 'Chypre', 'CY'),
(58, 'République Tchèque', 'CZ'),
(59, 'Bénin', 'BJ'),
(60, 'Danemark', 'DK'),
(61, 'Dominique', 'DM'),
(62, 'République Dominicaine', 'DO'),
(63, 'Équateur', 'EC'),
(64, 'El Salvador', 'SV'),
(65, 'Guinée Équatoriale', 'GQ'),
(66, 'Éthiopie', 'ET'),
(67, 'Érythrée', 'ER'),
(68, 'Estonie', 'EE'),
(69, 'Îles Féroé', 'FO'),
(70, 'Îles (malvinas) Falkland', 'FK'),
(71, 'Géorgie du Sud et les Îles Sandwich du Sud', 'GS'),
(72, 'Fidji', 'FJ'),
(73, 'Finlande', 'FI'),
(74, 'Îles Åland', 'AX'),
(75, 'France', 'FR'),
(76, 'Guyane Française', 'GF'),
(77, 'Polynésie Française', 'PF'),
(78, 'Terres Australes Françaises', 'TF'),
(79, 'Djibouti', 'DJ'),
(80, 'Gabon', 'GA'),
(81, 'Géorgie', 'GE'),
(82, 'Gambie', 'GM'),
(83, 'Territoire Palestinien Occupé', 'PS'),
(84, 'Allemagne', 'DE'),
(85, 'Ghana', 'GH'),
(86, 'Gibraltar', 'GI'),
(87, 'Kiribati', 'KI'),
(88, 'Grèce', 'GR'),
(89, 'Groenland', 'GL'),
(90, 'Grenade', 'GD'),
(91, 'Guadeloupe', 'GP'),
(92, 'Guam', 'GU'),
(93, 'Guatemala', 'GT'),
(94, 'Guinée', 'GN'),
(95, 'Guyana', 'GY'),
(96, 'Haïti', 'HT'),
(97, 'Îles Heard et Mcdonald', 'HM'),
(98, 'Saint-Siège (état de la Cité du Vatican)', 'VA'),
(99, 'Honduras', 'HN'),
(100, 'Hong-Kong', 'HK'),
(101, 'Hongrie', 'HU'),
(102, 'Islande', 'IS'),
(103, 'Inde', 'IN'),
(104, 'Indonésie', 'ID'),
(105, 'République Islamique d\'Iran', 'IR'),
(106, 'Iraq', 'IQ'),
(107, 'Irlande', 'IE'),
(108, 'Israël', 'IL'),
(109, 'Italie', 'IT'),
(110, 'Côte d\'Ivoire', 'CI'),
(111, 'Jamaïque', 'JM'),
(112, 'Japon', 'JP'),
(113, 'Kazakhstan', 'KZ'),
(114, 'Jordanie', 'JO'),
(115, 'Kenya', 'KE'),
(116, 'République Populaire Démocratique de Corée', 'KP'),
(117, 'République de Corée', 'KR'),
(118, 'Koweït', 'KW'),
(119, 'Kirghizistan', 'KG'),
(120, 'République Démocratique Populaire Lao', 'LA'),
(121, 'Liban', 'LB'),
(122, 'Lesotho', 'LS'),
(123, 'Lettonie', 'LV'),
(124, 'Libéria', 'LR'),
(125, 'Jamahiriya Arabe Libyenne', 'LY'),
(126, 'Liechtenstein', 'LI'),
(127, 'Lituanie', 'LT'),
(128, 'Luxembourg', 'LU'),
(129, 'Macao', 'MO'),
(130, 'Madagascar', 'MG'),
(131, 'Malawi', 'MW'),
(132, 'Malaisie', 'MY'),
(133, 'Maldives', 'MV'),
(134, 'Mali', 'ML'),
(135, 'Malte', 'MT'),
(136, 'Martinique', 'MQ'),
(137, 'Mauritanie', 'MR'),
(138, 'Maurice', 'MU'),
(139, 'Mexique', 'MX'),
(140, 'Monaco', 'MC'),
(141, 'Mongolie', 'MN'),
(142, 'République de Moldova', 'MD'),
(143, 'Montserrat', 'MS'),
(144, 'Maroc', 'MA'),
(145, 'Mozambique', 'MZ'),
(146, 'Oman', 'OM'),
(147, 'Namibie', 'NA'),
(148, 'Nauru', 'NR'),
(149, 'Népal', 'NP'),
(150, 'Pays-Bas', 'NL'),
(151, 'Antilles Néerlandaises', 'AN'),
(152, 'Aruba', 'AW'),
(153, 'Nouvelle-Calédonie', 'NC'),
(154, 'Vanuatu', 'VU'),
(155, 'Nouvelle-Zélande', 'NZ'),
(156, 'Nicaragua', 'NI'),
(157, 'Niger', 'NE'),
(158, 'Nigéria', 'NG'),
(159, 'Niué', 'NU'),
(160, 'Île Norfolk', 'NF'),
(161, 'Norvège', 'NO'),
(162, 'Îles Mariannes du Nord', 'MP'),
(163, 'Îles Mineures Éloignées des États-Unis', 'UM'),
(164, 'États Fédérés de Micronésie', 'FM'),
(165, 'Îles Marshall', 'MH'),
(166, 'Palaos', 'PW'),
(167, 'Pakistan', 'PK'),
(168, 'Panama', 'PA'),
(169, 'Papouasie-Nouvelle-Guinée', 'PG'),
(170, 'Paraguay', 'PY'),
(171, 'Pérou', 'PE'),
(172, 'Philippines', 'PH'),
(173, 'Pitcairn', 'PN'),
(174, 'Pologne', 'PL'),
(175, 'Portugal', 'PT'),
(176, 'Guinée-Bissau', 'GW'),
(177, 'Timor-Leste', 'TL'),
(178, 'Porto Rico', 'PR'),
(179, 'Qatar', 'QA'),
(180, 'Réunion', 'RE'),
(181, 'Roumanie', 'RO'),
(182, 'Fédération de Russie', 'RU'),
(183, 'Rwanda', 'RW'),
(184, 'Sainte-Hélène', 'SH'),
(185, 'Saint-Kitts-et-Nevis', 'KN'),
(186, 'Anguilla', 'AI'),
(187, 'Sainte-Lucie', 'LC'),
(188, 'Saint-Pierre-et-Miquelon', 'PM'),
(189, 'Saint-Vincent-et-les Grenadines', 'VC'),
(190, 'Saint-Marin', 'SM'),
(191, 'Sao Tomé-et-Principe', 'ST'),
(192, 'Arabie Saoudite', 'SA'),
(193, 'Sénégal', 'SN'),
(194, 'Seychelles', 'SC'),
(195, 'Sierra Leone', 'SL'),
(196, 'Singapour', 'SG'),
(197, 'Slovaquie', 'SK'),
(198, 'Viet Nam', 'VN'),
(199, 'Slovénie', 'SI'),
(200, 'Somalie', 'SO'),
(201, 'Afrique du Sud', 'ZA'),
(202, 'Zimbabwe', 'ZW'),
(203, 'Espagne', 'ES'),
(204, 'Sahara Occidental', 'EH'),
(205, 'Soudan', 'SD'),
(206, 'Suriname', 'SR'),
(207, 'Svalbard et Île Jan Mayen', 'SJ'),
(208, 'Swaziland', 'SZ'),
(209, 'Suède', 'SE'),
(210, 'Suisse', 'CH'),
(211, 'République Arabe Syrienne', 'SY'),
(212, 'Tadjikistan', 'TJ'),
(213, 'Thaïlande', 'TH'),
(214, 'Togo', 'TG'),
(215, 'Tokelau', 'TK'),
(216, 'Tonga', 'TO'),
(217, 'Trinité-et-Tobago', 'TT'),
(218, 'Émirats Arabes Unis', 'AE'),
(219, 'Tunisie', 'TN'),
(220, 'Turquie', 'TR'),
(221, 'Turkménistan', 'TM'),
(222, 'Îles Turks et Caïques', 'TC'),
(223, 'Tuvalu', 'TV'),
(224, 'Ouganda', 'UG'),
(225, 'Ukraine', 'UA'),
(226, 'L\'ex-République Yougoslave de Macédoine', 'MK'),
(227, 'Égypte', 'EG'),
(228, 'Royaume-Uni', 'GB'),
(229, 'Île de Man', 'IM'),
(230, 'République-Unie de Tanzanie', 'TZ'),
(231, 'États-Unis', 'US'),
(232, 'Îles Vierges des États-Unis', 'VI'),
(233, 'Burkina Faso', 'BF'),
(234, 'Uruguay', 'UY'),
(235, 'Ouzbékistan', 'UZ'),
(236, 'Venezuela', 'VE'),
(237, 'Wallis et Futuna', 'WF'),
(238, 'Samoa', 'WS'),
(239, 'Yémen', 'YE'),
(240, 'Serbie-et-Monténégro', 'CS'),
(241, 'Zambie', 'ZM');

-- --------------------------------------------------------

--
-- Structure de la table `files`
--

CREATE TABLE `files` (
  `id_file` int(11) NOT NULL,
  `path` varchar(2048) NOT NULL,
  `is_verified` tinyint(1) DEFAULT NULL,
  `download_count` bigint(20) NOT NULL,
  `id_ressource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `files`
--

INSERT INTO `files` (`id_file`, `path`, `is_verified`, `download_count`, `id_ressource`) VALUES
(1, '/path/to/file', 1, 50, 1);

-- --------------------------------------------------------

--
-- Structure de la table `games`
--

CREATE TABLE `games` (
  `id_game` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `max_player` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `games`
--

INSERT INTO `games` (`id_game`, `name`, `max_player`) VALUES
(1, 'Chess', 2),
(2, 'Monopoly', 6);

-- --------------------------------------------------------

--
-- Structure de la table `invitations`
--

CREATE TABLE `invitations` (
  `id_invitation` int(11) NOT NULL,
  `link` varchar(2048) NOT NULL,
  `status` varchar(50) NOT NULL,
  `creation_date` datetime NOT NULL,
  `expiration_date` datetime NOT NULL,
  `id_ressource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `invitations`
--

INSERT INTO `invitations` (`id_invitation`, `link`, `status`, `creation_date`, `expiration_date`, `id_ressource`) VALUES
(1, 'http://example.com/invite', 'Sent', '2024-01-18 22:38:55', '2024-01-19 22:38:55', 1);

-- --------------------------------------------------------

--
-- Structure de la table `login_logs`
--

CREATE TABLE `login_logs` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `login_datetime` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `login_logs`
--

INSERT INTO `login_logs` (`id`, `id_user`, `login_datetime`) VALUES
(19, 26, '2024-01-01 08:00:00'),
(20, 27, '2024-01-01 09:15:00'),
(21, 28, '2024-01-01 10:30:00'),
(22, 29, '2024-01-02 08:00:00'),
(23, 30, '2024-01-02 09:45:00'),
(24, 31, '2024-01-02 11:00:00'),
(25, 32, '2024-01-03 08:30:00'),
(26, 33, '2024-01-03 09:30:00'),
(28, 26, '2024-01-04 08:00:00'),
(29, 27, '2024-01-04 09:15:00'),
(30, 28, '2024-01-05 10:30:00'),
(31, 29, '2024-01-05 08:00:00'),
(32, 30, '2024-01-06 09:45:00'),
(33, 31, '2024-01-06 11:00:00'),
(34, 32, '2024-01-07 08:30:00'),
(35, 29, '2024-01-07 09:30:00'),
(37, 1, '2024-03-05 18:48:39'),
(38, 1, '2024-03-05 19:01:22'),
(39, 1, '2024-03-06 08:53:58'),
(40, 1, '2024-03-06 09:32:49'),
(41, 28, '2024-01-09 08:00:00'),
(42, 32, '2024-01-09 09:45:00'),
(43, 1, '2024-01-09 11:00:00'),
(44, 1, '2024-03-06 08:53:58'),
(45, 1, '2024-03-06 08:53:58'),
(46, 32, '2024-03-06 08:53:58'),
(47, 1, '2024-03-06 08:53:58'),
(48, 33, '2024-03-06 08:53:58'),
(49, 33, '2024-03-06 08:53:58'),
(50, 29, '2024-03-06 08:53:58'),
(51, 1, '2024-03-06 08:53:58'),
(52, 33, '2024-03-06 08:53:58'),
(53, 1, '2024-03-06 08:53:58'),
(54, 1, '2024-03-06 08:53:58'),
(55, 33, '2024-03-06 08:53:58'),
(56, 29, '2024-03-06 08:53:58'),
(57, 1, '2024-03-06 08:53:58'),
(58, 33, '2024-03-06 08:53:58'),
(59, 1, '2024-03-06 08:53:58'),
(60, 1, '2024-03-06 08:53:58'),
(61, 29, '2024-03-06 08:53:58'),
(62, 1, '2024-03-06 08:53:58'),
(63, 33, '2024-03-06 08:53:58'),
(64, 29, '2024-03-06 08:53:58'),
(65, 1, '2024-03-06 08:53:58'),
(66, 1, '2024-03-06 08:53:58'),
(67, 1, '2024-03-06 12:56:07'),
(68, 1, '2024-03-06 14:23:11'),
(69, 1, '2024-03-11 21:25:37'),
(70, 1, '2024-03-14 16:32:03'),
(71, 37, '2024-03-18 21:25:54'),
(72, 38, '2024-03-18 21:26:48'),
(73, 1, '2024-03-18 21:27:29');

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `postal_codes`
--

CREATE TABLE `postal_codes` (
  `id_postal_code` int(11) NOT NULL,
  `postal_code` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `postal_codes`
--

INSERT INTO `postal_codes` (`id_postal_code`, `postal_code`) VALUES
(1, '75000'),
(2, '10001'),
(3, '100-0001'),
(7, '101');

-- --------------------------------------------------------

--
-- Structure de la table `ressources`
--

CREATE TABLE `ressources` (
  `id_ressource` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `content` varchar(8000) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `view_count` bigint(20) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `file` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ressources`
--

INSERT INTO `ressources` (`id_ressource`, `label`, `description`, `content`, `is_public`, `view_count`, `id_user`, `id_category`, `id_status`, `file`, `created_at`, `updated_at`) VALUES
(1, 'Ressource 1', 'Description of Ressource 1', 'Content of Ressource 1', 1, 100, 1, 1, 1, NULL, '2024-04-02 19:25:44', '2024-04-02 19:25:44');

-- --------------------------------------------------------

--
-- Structure de la table `rights`
--

CREATE TABLE `rights` (
  `id_right` int(11) NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `rights`
--

INSERT INTO `rights` (`id_right`, `label`, `description`) VALUES
(1, 'Edit Post', 'Can edit any post'),
(2, 'Delete Post', 'Can delete any post');

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id_role` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id_role`, `name`) VALUES
(1, 'SuperAdministrateur'),
(2, 'Administrateur'),
(3, 'Moderateur'),
(4, 'Utilisateur');

-- --------------------------------------------------------

--
-- Structure de la table `statistics_archive`
--

CREATE TABLE `statistics_archive` (
  `id_statistic_archive` int(11) NOT NULL,
  `archive_date` datetime DEFAULT NULL,
  `bookmarks_count` bigint(20) NOT NULL,
  `views_count` bigint(20) DEFAULT NULL,
  `total_download_count` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `statistics_archive`
--

INSERT INTO `statistics_archive` (`id_statistic_archive`, `archive_date`, `bookmarks_count`, `views_count`, `total_download_count`) VALUES
(1, '2024-01-18 22:38:55', 10, 150, 5);

-- --------------------------------------------------------

--
-- Structure de la table `status_ressources`
--

CREATE TABLE `status_ressources` (
  `id_status` int(11) NOT NULL,
  `label` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `status_ressources`
--

INSERT INTO `status_ressources` (`id_status`, `label`) VALUES
(1, 'Active'),
(2, 'Inactive'),
(3, 'Pending');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `password` varchar(65) NOT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `ban_until` bigint(20) DEFAULT NULL,
  `path_picture` varchar(255) DEFAULT NULL,
  `id_city` int(11) DEFAULT NULL,
  `id_postal_code` int(11) DEFAULT NULL,
  `id_country` int(11) DEFAULT NULL,
  `id_role` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `verification_token` varchar(150) DEFAULT NULL,
  `password_reset_token` varchar(100) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `email`, `first_name`, `last_name`, `password`, `is_verified`, `ban_until`, `path_picture`, `id_city`, `id_postal_code`, `id_country`, `id_role`, `created_at`, `updated_at`, `verification_token`, `password_reset_token`, `deleted_at`) VALUES
(1, 'john.doe@example.com', 'John', 'Doe', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Toby', 1, 1, 1, 1, '2024-01-23 21:58:57', '2024-03-14 19:43:49', NULL, NULL, NULL),
(22, 'jordan.davis53@example.com', 'Jordan', 'Davis', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Socks', 3, 3, 1, 3, '2024-02-13 18:05:16', '2024-03-14 19:43:49', NULL, NULL, '2024-03-06 15:19:53'),
(23, 'dakota.wilson74@sample.com', 'Dakota', 'Wilsoaze', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 1742071249, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Angel', 2, 2, 3, 3, '2024-02-13 18:05:16', '2024-03-14 20:42:24', NULL, NULL, NULL),
(24, 'jordan.smith21@sample.com', 'Jordan', 'Smith', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Kiki', 3, 1, 1, 3, '2024-02-13 18:05:16', '2024-03-14 19:43:49', NULL, NULL, NULL),
(25, 'morgan.davis85@sample.com', 'Morgan', 'Davis', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Toby', 1, 7, 18, 4, '2024-02-13 18:05:16', '2024-03-18 20:18:31', NULL, NULL, NULL),
(26, 'robin.wilson93@example.com', 'Robin', 'Wilson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Toby', 1, 2, 1, 3, '2024-02-13 18:05:16', '2024-03-14 19:43:49', NULL, NULL, NULL),
(27, 'casey.brown77@sample.com', 'Casey', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Angel', 2, 3, 3, 2, '2024-02-13 18:05:16', '2024-03-14 19:43:49', NULL, NULL, NULL),
(28, 'robin.johnson19@example.com', 'Robin', 'Johnson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Angel', 2, 2, 1, 1, '2024-02-13 18:05:16', '2024-03-14 19:43:49', NULL, NULL, NULL),
(29, 'riley.moore47@sample.com', 'Riley', 'Moore', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Kiki', 2, 2, 1, 3, '2024-02-13 18:05:16', '2024-03-14 19:43:49', NULL, NULL, NULL),
(30, 'riley.williams18@sample.com', 'Riley', 'Williams', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Toby', 7, 1, 3, 4, '2024-02-13 18:05:16', '2024-03-14 19:43:49', NULL, NULL, NULL),
(31, 'dakota.brown54@demo.com', 'Dakota', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Socks', 7, 3, 3, 4, '2024-02-13 18:05:16', '2024-03-14 19:43:49', NULL, NULL, NULL),
(32, 'azeaze.brown54@demo.com', 'Charlie', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Angel', 7, 3, 3, 4, '2024-02-13 18:05:16', '2024-03-18 19:35:42', NULL, NULL, NULL),
(33, 'aze.brown54@demo.com', 'Zoulou', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 'https://api.dicebear.com/7.x/bottts-neutral/svg?seed=Kiki', 1, 3, 3, 4, '2024-02-13 18:05:16', '2024-03-18 20:17:39', NULL, NULL, NULL),
(37, 'azeazeAZEAZE123132@gmail.com', 'azeaze', 'AZEAZE', '$2y$12$l8mw5o/wM9MNYP0xUto7zeNtPwQ88Dxow/pCv./28J3XpHqu3X98W', 0, NULL, NULL, NULL, NULL, NULL, 4, '2024-03-18 19:25:52', '2024-03-18 21:17:05', NULL, NULL, '2024-03-18 19:29:06'),
(38, 'azeazeAZEAZE123132@gmail.comze', 'azeaze', 'AZEAZE', '$2y$12$fdlI3ydiRmFw/Y9vI/8WtOZBfRHLMKnk1.73OidlaXwfD8YjQhEOK', 0, NULL, NULL, NULL, NULL, NULL, 4, '2024-03-18 19:26:46', '2024-03-18 21:17:05', NULL, NULL, '2024-03-18 19:27:45');

-- --------------------------------------------------------

--
-- Structure de la table `user_history`
--

CREATE TABLE `user_history` (
  `id` int(11) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `affected_user_id` int(11) NOT NULL,
  `action` enum('Modify','Delete','Ban','Unban','Create') NOT NULL,
  `modified_column` varchar(255) DEFAULT NULL,
  `old_value` text DEFAULT NULL,
  `new_value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user_history`
--

INSERT INTO `user_history` (`id`, `user_id`, `affected_user_id`, `action`, `modified_column`, `old_value`, `new_value`, `created_at`) VALUES
(59, 1, 38, 'Delete', 'deleted_at', NULL, '2024-03-18 20:27:45', '2024-03-18 20:27:45'),
(60, 1, 37, 'Delete', 'deleted_at', NULL, '2024-03-18 20:29:06', '2024-03-18 20:29:06'),
(62, 1, 32, 'Modify', 'first_name', 'Dakota', 'Charlie', '2024-03-18 20:35:42'),
(63, 1, 33, 'Modify', 'first_name', 'Dakota', 'Zoulou', '2024-03-18 20:36:00'),
(67, 1, 33, 'Ban', 'ban_until', NULL, '1710796080', '2024-03-18 21:07:14'),
(68, 1, 33, 'Unban', 'ban_until', '1710796080', NULL, '2024-03-18 21:08:16'),
(69, 1, 33, 'Ban', 'ban_until', NULL, '1710796180', '2024-03-18 21:08:30'),
(70, 1, 33, 'Ban', 'ban_until', '1710796180', '253402297199', '2024-03-18 21:09:49'),
(71, 1, 33, 'Unban', 'ban_until', '253402297199', NULL, '2024-03-18 21:12:35'),
(72, 1, 33, 'Modify', 'city', 'Pariss', 'Paris', '2024-03-18 21:17:39'),
(73, 1, 25, 'Modify', 'city', 'New York', 'Paris', '2024-03-18 21:17:59'),
(74, 1, 25, 'Modify', 'first_name', 'Morgan', 'Morgans', '2024-03-18 21:18:22'),
(75, 1, 25, 'Modify', 'last_name', 'Davis', 'Daviss', '2024-03-18 21:18:22'),
(76, 1, 25, 'Modify', 'role', 'Moderateur', 'Utilisateur', '2024-03-18 21:18:22'),
(77, 1, 25, 'Modify', 'first_name', 'Morgans', 'Morgan', '2024-03-18 21:18:31'),
(78, 1, 25, 'Modify', 'last_name', 'Daviss', 'Davis', '2024-03-18 21:18:31');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `asso_ressource_game`
--
ALTER TABLE `asso_ressource_game`
  ADD PRIMARY KEY (`id_ressource`,`id_game`),
  ADD KEY `id_game` (`id_game`);

--
-- Index pour la table `asso_ressource_statistic`
--
ALTER TABLE `asso_ressource_statistic`
  ADD PRIMARY KEY (`id_ressource`,`id_statistic_archive`),
  ADD KEY `id_statistic_archive` (`id_statistic_archive`);

--
-- Index pour la table `asso_role_right`
--
ALTER TABLE `asso_role_right`
  ADD PRIMARY KEY (`id_role`,`id_right`),
  ADD KEY `id_right` (`id_right`);

--
-- Index pour la table `asso_user_bookmark`
--
ALTER TABLE `asso_user_bookmark`
  ADD PRIMARY KEY (`id_user`,`id_ressource`),
  ADD KEY `id_ressource` (`id_ressource`);

--
-- Index pour la table `asso_user_note`
--
ALTER TABLE `asso_user_note`
  ADD PRIMARY KEY (`id_user`,`id_ressource`),
  ADD KEY `id_ressource` (`id_ressource`);

--
-- Index pour la table `asso_user_ressource`
--
ALTER TABLE `asso_user_ressource`
  ADD PRIMARY KEY (`id_user`,`id_ressource`),
  ADD KEY `id_ressource` (`id_ressource`);

--
-- Index pour la table `blocked_users`
--
ALTER TABLE `blocked_users`
  ADD PRIMARY KEY (`id_blocked`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id_category`);

--
-- Index pour la table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id_city`);

--
-- Index pour la table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id_comment`),
  ADD KEY `id_parent_comment` (`id_parent_comment`),
  ADD KEY `id_ressource` (`id_ressource`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id_country`);

--
-- Index pour la table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id_file`),
  ADD KEY `id_ressource` (`id_ressource`);

--
-- Index pour la table `games`
--
ALTER TABLE `games`
  ADD PRIMARY KEY (`id_game`);

--
-- Index pour la table `invitations`
--
ALTER TABLE `invitations`
  ADD PRIMARY KEY (`id_invitation`),
  ADD KEY `id_ressource` (`id_ressource`);

--
-- Index pour la table `login_logs`
--
ALTER TABLE `login_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `postal_codes`
--
ALTER TABLE `postal_codes`
  ADD PRIMARY KEY (`id_postal_code`);

--
-- Index pour la table `ressources`
--
ALTER TABLE `ressources`
  ADD PRIMARY KEY (`id_ressource`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_category` (`id_category`),
  ADD KEY `id_status` (`id_status`);

--
-- Index pour la table `rights`
--
ALTER TABLE `rights`
  ADD PRIMARY KEY (`id_right`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_role`);

--
-- Index pour la table `statistics_archive`
--
ALTER TABLE `statistics_archive`
  ADD PRIMARY KEY (`id_statistic_archive`);

--
-- Index pour la table `status_ressources`
--
ALTER TABLE `status_ressources`
  ADD PRIMARY KEY (`id_status`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_city` (`id_city`),
  ADD KEY `id_postal_code` (`id_postal_code`),
  ADD KEY `id_country` (`id_country`),
  ADD KEY `id_role` (`id_role`);

--
-- Index pour la table `user_history`
--
ALTER TABLE `user_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `affected_user_id` (`affected_user_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `blocked_users`
--
ALTER TABLE `blocked_users`
  MODIFY `id_blocked` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `cities`
--
ALTER TABLE `cities`
  MODIFY `id_city` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id_comment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `countries`
--
ALTER TABLE `countries`
  MODIFY `id_country` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT pour la table `files`
--
ALTER TABLE `files`
  MODIFY `id_file` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `games`
--
ALTER TABLE `games`
  MODIFY `id_game` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `invitations`
--
ALTER TABLE `invitations`
  MODIFY `id_invitation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `postal_codes`
--
ALTER TABLE `postal_codes`
  MODIFY `id_postal_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `ressources`
--
ALTER TABLE `ressources`
  MODIFY `id_ressource` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `rights`
--
ALTER TABLE `rights`
  MODIFY `id_right` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `statistics_archive`
--
ALTER TABLE `statistics_archive`
  MODIFY `id_statistic_archive` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `status_ressources`
--
ALTER TABLE `status_ressources`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT pour la table `user_history`
--
ALTER TABLE `user_history`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `asso_ressource_game`
--
ALTER TABLE `asso_ressource_game`
  ADD CONSTRAINT `asso_ressource_game_ibfk_1` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`),
  ADD CONSTRAINT `asso_ressource_game_ibfk_2` FOREIGN KEY (`id_game`) REFERENCES `games` (`id_game`);

--
-- Contraintes pour la table `asso_ressource_statistic`
--
ALTER TABLE `asso_ressource_statistic`
  ADD CONSTRAINT `asso_ressource_statistic_ibfk_1` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`),
  ADD CONSTRAINT `asso_ressource_statistic_ibfk_2` FOREIGN KEY (`id_statistic_archive`) REFERENCES `statistics_archive` (`id_statistic_archive`);

--
-- Contraintes pour la table `asso_role_right`
--
ALTER TABLE `asso_role_right`
  ADD CONSTRAINT `asso_role_right_ibfk_1` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`),
  ADD CONSTRAINT `asso_role_right_ibfk_2` FOREIGN KEY (`id_right`) REFERENCES `rights` (`id_right`);

--
-- Contraintes pour la table `asso_user_bookmark`
--
ALTER TABLE `asso_user_bookmark`
  ADD CONSTRAINT `asso_user_bookmark_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `asso_user_bookmark_ibfk_2` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`);

--
-- Contraintes pour la table `asso_user_note`
--
ALTER TABLE `asso_user_note`
  ADD CONSTRAINT `asso_user_note_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `asso_user_note_ibfk_2` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`);

--
-- Contraintes pour la table `asso_user_ressource`
--
ALTER TABLE `asso_user_ressource`
  ADD CONSTRAINT `asso_user_ressource_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `asso_user_ressource_ibfk_2` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`);

--
-- Contraintes pour la table `blocked_users`
--
ALTER TABLE `blocked_users`
  ADD CONSTRAINT `blocked_users_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`id_parent_comment`) REFERENCES `comments` (`id_comment`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`),
  ADD CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Contraintes pour la table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`);

--
-- Contraintes pour la table `invitations`
--
ALTER TABLE `invitations`
  ADD CONSTRAINT `invitations_ibfk_1` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`);

--
-- Contraintes pour la table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Contraintes pour la table `ressources`
--
ALTER TABLE `ressources`
  ADD CONSTRAINT `ressources_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `ressources_ibfk_2` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id_category`),
  ADD CONSTRAINT `ressources_ibfk_3` FOREIGN KEY (`id_status`) REFERENCES `status_ressources` (`id_status`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_city`) REFERENCES `cities` (`id_city`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`id_postal_code`) REFERENCES `postal_codes` (`id_postal_code`),
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id_country`),
  ADD CONSTRAINT `users_ibfk_4` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`);

--
-- Contraintes pour la table `user_history`
--
ALTER TABLE `user_history`
  ADD CONSTRAINT `user_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `user_history_ibfk_2` FOREIGN KEY (`affected_user_id`) REFERENCES `users` (`id_user`);
--
-- Base de données : `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Base de données : `voyageburger`
--
CREATE DATABASE IF NOT EXISTS `voyageburger` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `voyageburger`;

-- --------------------------------------------------------

--
-- Structure de la table `addresses`
--

CREATE TABLE `addresses` (
  `id_address` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `addresses`
--

INSERT INTO `addresses` (`id_address`, `title`, `link`) VALUES
(1, 'Aix la Duranne, Avenue Augustin Fresnel', 'https://maps.app.goo.gl/PXTTTF75YaQQ6WaG7'),
(2, 'Calas, Rue du Queirelet', 'https://maps.app.goo.gl/raQ8Hf4NSbkqyVnt8');

-- --------------------------------------------------------

--
-- Structure de la table `admin_auth`
--

CREATE TABLE `admin_auth` (
  `id` int(11) NOT NULL,
  `password` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `admin_auth`
--

INSERT INTO `admin_auth` (`id`, `password`) VALUES
(1, '9adfb0a6d03beb7141d8ec2708d6d9fef9259d12cd230d50f70fb221ae6cabd5');

-- --------------------------------------------------------

--
-- Structure de la table `allergenes`
--

CREATE TABLE `allergenes` (
  `id_allergene` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `allergenes`
--

INSERT INTO `allergenes` (`id_allergene`, `name`, `description`, `icon`) VALUES
(1, 'fruits à coque', 'Les amandes, les noix du Brésil, les noix de cajou, les noisettes, les noix macadamia, les noix de pacane, les pignons (pignes, pignoles), les pistaches et les noix de Grenoble', 'fruit_a_carcace.svg'),
(2, 'Cacahuètes ou des dérivés', 'Cacahuètes, beurre de cacahuète, huile de cacahuète', 'cacahuete.svg'),
(3, 'Graine de sésame ou des dérivés', 'Graines de sésame, huile de sésame, tahini', 'graine.svg'),
(4, 'Lait ou des dérivés', 'Lait, beurre, fromage, crème, yaourt, lactose', 'lait.svg'),
(5, 'Œufs ou des dérivés', 'Œufs entiers, blancs d\'œufs, jaunes d\'œufs, lysozyme', 'oeuf.svg'),
(6, 'Lupin ou des dérivés', 'Farine de lupin, graines de lupin', 'lupin.svg'),
(7, 'Soja ou des dérivés', 'Lait de soja, tofu, sauce soja, lecithine de soja', 'soja.svg'),
(8, 'Blé et gluten', 'Pain, pâtes, seitan, sauce soja, bières', 'gluten.svg'),
(9, 'Poissons ou des dérivés', 'Poissons, sauce de poisson, caviar', 'poisson.svg'),
(10, 'Crustacés ou des dérivés', 'Crevettes, crabes, homards, langoustes', 'crustace.svg'),
(11, 'Céleri ou des dérivés', 'Céleri-rave, graines de céleri, épice de céleri', 'celeri.svg'),
(12, 'Mollusques ou des dérivés', 'Moules, huîtres, calamars, poulpes', 'mollusque.svg'),
(13, 'Anhydride sulfureux et sulfites', 'Vin, bière, fruits secs, cornichons, conserves', 'sulfureux_sulfites.svg'),
(14, 'Moutarde ou des dérivés', 'Graines de moutarde, poudre de moutarde, sauces à la moutarde', 'moutarde.svg');

-- --------------------------------------------------------

--
-- Structure de la table `asso_address_hours`
--

CREATE TABLE `asso_address_hours` (
  `id_address` int(11) NOT NULL,
  `id_opening_hour` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_address_hours`
--

INSERT INTO `asso_address_hours` (`id_address`, `id_opening_hour`) VALUES
(1, 3),
(1, 5),
(1, 7),
(2, 2);

-- --------------------------------------------------------

--
-- Structure de la table `asso_burger_ingredient`
--

CREATE TABLE `asso_burger_ingredient` (
  `id_burger` int(11) NOT NULL,
  `id_ingredient` int(11) NOT NULL,
  `multiplicateur` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_burger_ingredient`
--

INSERT INTO `asso_burger_ingredient` (`id_burger`, `id_ingredient`, `multiplicateur`) VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 2),
(1, 4, 1),
(1, 5, 1),
(2, 1, 1),
(2, 2, 1),
(2, 3, 2),
(2, 4, 2),
(2, 5, 1),
(2, 6, 1),
(3, 1, 1),
(3, 2, 1),
(3, 3, 3),
(3, 4, 3),
(3, 5, 1),
(3, 6, 1),
(3, 7, 1),
(4, 1, 1),
(4, 2, 1),
(4, 3, 1),
(4, 4, 1),
(4, 5, 1),
(4, 6, 1),
(5, 1, 1),
(5, 2, 1),
(5, 3, 2),
(5, 4, 2),
(5, 5, 1),
(5, 6, 1),
(6, 1, 1),
(6, 2, 1),
(6, 3, 2),
(6, 5, 1),
(6, 6, 1),
(6, 8, 1),
(7, 1, 1),
(7, 2, 1),
(7, 3, 2),
(7, 4, 2),
(7, 5, 1),
(7, 6, 1),
(7, 7, 1),
(8, 1, 1),
(8, 2, 1),
(8, 4, 1),
(8, 5, 1),
(8, 10, 1),
(8, 11, 1),
(9, 1, 1),
(9, 4, 1),
(9, 5, 2),
(9, 9, 1),
(9, 10, 1),
(9, 11, 1),
(10, 1, 1),
(10, 3, 1),
(10, 4, 1),
(10, 5, 1),
(10, 10, 1),
(10, 11, 1),
(10, 12, 1),
(11, 1, 1),
(11, 2, 1),
(11, 4, 1),
(11, 5, 1),
(11, 6, 2),
(11, 17, 1),
(11, 19, 1),
(12, 1, 1),
(12, 2, 1),
(12, 4, 1),
(12, 5, 1),
(12, 6, 2),
(12, 18, 1),
(13, 1, 1),
(13, 2, 1),
(13, 3, 4),
(13, 4, 1),
(13, 5, 1),
(13, 6, 4);

-- --------------------------------------------------------

--
-- Structure de la table `asso_burger_sauce`
--

CREATE TABLE `asso_burger_sauce` (
  `id_burger` int(11) NOT NULL,
  `id_sauce` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_burger_sauce`
--

INSERT INTO `asso_burger_sauce` (`id_burger`, `id_sauce`) VALUES
(1, 1),
(1, 3),
(5, 2),
(7, 5),
(8, 4),
(9, 3),
(10, 3),
(13, 6);

-- --------------------------------------------------------

--
-- Structure de la table `asso_ingredient_allergene`
--

CREATE TABLE `asso_ingredient_allergene` (
  `id_ingredient` int(11) NOT NULL,
  `id_allergene` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_ingredient_allergene`
--

INSERT INTO `asso_ingredient_allergene` (`id_ingredient`, `id_allergene`) VALUES
(1, 8),
(3, 4),
(9, 8),
(17, 4),
(18, 4);

-- --------------------------------------------------------

--
-- Structure de la table `asso_sauce_allergene`
--

CREATE TABLE `asso_sauce_allergene` (
  `id_sauce` int(11) NOT NULL,
  `id_allergene` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `asso_sauce_allergene`
--

INSERT INTO `asso_sauce_allergene` (`id_sauce`, `id_allergene`) VALUES
(1, 14),
(2, 13),
(5, 1),
(6, 5),
(6, 14);

-- --------------------------------------------------------

--
-- Structure de la table `burgers`
--

CREATE TABLE `burgers` (
  `id_burger` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` float NOT NULL,
  `price_menu` float NOT NULL,
  `permanent` tinyint(1) DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `burgers`
--

INSERT INTO `burgers` (`id_burger`, `name`, `price`, `price_menu`, `permanent`, `active`) VALUES
(1, 'American cheese', 10, 14, 1, 1),
(2, 'American bacon', 10, 14, 1, 1),
(3, 'Petit canadien', 11, 15, 1, 1),
(4, 'Petit cheese', 9, 13, 1, 1),
(5, 'Texan', 10, 14, 1, 1),
(6, 'American fire', 10, 14, 1, 1),
(7, 'Tex-Mex', 10, 14, 1, 1),
(8, 'American Burger', 10, 14, 1, 1),
(9, 'Végétarien', 10, 13.5, 1, 1),
(10, 'American Chicken', 10, 13.5, 1, 1),
(11, 'Dauphinois', 14, 16, 1, 0),
(12, 'Raclette Savoyard', 14, 16, 1, 0),
(13, 'Le Cajun', 13, 16, 0, 1);

-- --------------------------------------------------------

--
-- Structure de la table `hours`
--

CREATE TABLE `hours` (
  `id_opening_hour` int(1) NOT NULL,
  `day` varchar(8) NOT NULL,
  `opening_time` time NOT NULL,
  `closing_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `hours`
--

INSERT INTO `hours` (`id_opening_hour`, `day`, `opening_time`, `closing_time`) VALUES
(2, 'Mardi', '19:00:00', '21:00:00'),
(3, 'Mercredi', '19:00:00', '21:00:00'),
(5, 'Vendredi', '19:00:00', '21:30:00'),
(7, 'Dimanche', '19:00:00', '21:00:00');

-- --------------------------------------------------------

--
-- Structure de la table `info_messages`
--

CREATE TABLE `info_messages` (
  `id` int(11) NOT NULL,
  `message` varchar(500) NOT NULL,
  `visible_until` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ingredients`
--

CREATE TABLE `ingredients` (
  `id_ingredient` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `vegetarien` tinyint(1) DEFAULT 0,
  `piquant` tinyint(1) DEFAULT 0,
  `supplement_price` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ingredients`
--

INSERT INTO `ingredients` (`id_ingredient`, `name`, `vegetarien`, `piquant`, `supplement_price`) VALUES
(1, 'Pain boulanger', 1, 0, 0),
(2, 'Steak haché façon bouchère 150g', 0, 0, 3),
(3, 'Tranche cheddar', 1, 0, 1.5),
(4, 'Oignons frits', 1, 0, 0.5),
(5, 'Oignons rouges', 1, 0, 0),
(6, 'Tranche de poitrine fumée', 0, 0, 1.5),
(7, 'Sirop d\'érable', 1, 0, 0),
(8, 'Piment doux', 1, 1, 0),
(9, 'Galette blé', 1, 0, 0),
(10, 'Salade de jeunes pousses', 1, 0, 0),
(11, 'Tomates', 1, 0, 0),
(12, 'Émincé de poulet', 0, 0, 1.5),
(13, 'Fromage de la semaine', 1, 0, 1.5),
(14, 'Charcuterie de la semaine', 0, 0, 1.5),
(15, 'Frites fraîches', 1, 0, 3),
(16, 'Boisson', 1, 0, 2),
(17, 'Saint Marcellin', 1, 0, 0),
(18, 'Raclette', 1, 0, 0),
(19, 'Confit d’oignons', 1, 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sauces`
--

CREATE TABLE `sauces` (
  `id_sauce` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `vegetarien` tinyint(1) DEFAULT 0,
  `piquant` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sauces`
--

INSERT INTO `sauces` (`id_sauce`, `name`, `vegetarien`, `piquant`) VALUES
(1, 'Sauce moutarde douce', 1, 0),
(2, 'Sauce barbecue', 1, 0),
(3, 'Sauce ketchup', 1, 0),
(4, 'Sauce burger', 1, 0),
(5, 'Sauce pice piment chipotle', 1, 1),
(6, 'Sauce Cajun', 1, 1);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id_address`);

--
-- Index pour la table `admin_auth`
--
ALTER TABLE `admin_auth`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `allergenes`
--
ALTER TABLE `allergenes`
  ADD PRIMARY KEY (`id_allergene`);

--
-- Index pour la table `asso_address_hours`
--
ALTER TABLE `asso_address_hours`
  ADD PRIMARY KEY (`id_address`,`id_opening_hour`),
  ADD KEY `id_opening_hour` (`id_opening_hour`);

--
-- Index pour la table `asso_burger_ingredient`
--
ALTER TABLE `asso_burger_ingredient`
  ADD PRIMARY KEY (`id_burger`,`id_ingredient`),
  ADD KEY `id_ingredient` (`id_ingredient`);

--
-- Index pour la table `asso_burger_sauce`
--
ALTER TABLE `asso_burger_sauce`
  ADD PRIMARY KEY (`id_burger`,`id_sauce`),
  ADD KEY `id_sauce` (`id_sauce`);

--
-- Index pour la table `asso_ingredient_allergene`
--
ALTER TABLE `asso_ingredient_allergene`
  ADD PRIMARY KEY (`id_ingredient`,`id_allergene`),
  ADD KEY `id_allergene` (`id_allergene`);

--
-- Index pour la table `asso_sauce_allergene`
--
ALTER TABLE `asso_sauce_allergene`
  ADD PRIMARY KEY (`id_sauce`,`id_allergene`),
  ADD KEY `id_allergene` (`id_allergene`);

--
-- Index pour la table `burgers`
--
ALTER TABLE `burgers`
  ADD PRIMARY KEY (`id_burger`);

--
-- Index pour la table `hours`
--
ALTER TABLE `hours`
  ADD PRIMARY KEY (`id_opening_hour`);

--
-- Index pour la table `info_messages`
--
ALTER TABLE `info_messages`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ingredients`
--
ALTER TABLE `ingredients`
  ADD PRIMARY KEY (`id_ingredient`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sauces`
--
ALTER TABLE `sauces`
  ADD PRIMARY KEY (`id_sauce`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id_address` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `admin_auth`
--
ALTER TABLE `admin_auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `allergenes`
--
ALTER TABLE `allergenes`
  MODIFY `id_allergene` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `burgers`
--
ALTER TABLE `burgers`
  MODIFY `id_burger` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `info_messages`
--
ALTER TABLE `info_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `ingredients`
--
ALTER TABLE `ingredients`
  MODIFY `id_ingredient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `sauces`
--
ALTER TABLE `sauces`
  MODIFY `id_sauce` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `asso_address_hours`
--
ALTER TABLE `asso_address_hours`
  ADD CONSTRAINT `asso_address_hours_ibfk_1` FOREIGN KEY (`id_address`) REFERENCES `addresses` (`id_address`) ON DELETE CASCADE,
  ADD CONSTRAINT `asso_address_hours_ibfk_2` FOREIGN KEY (`id_opening_hour`) REFERENCES `hours` (`id_opening_hour`) ON DELETE CASCADE;

--
-- Contraintes pour la table `asso_burger_ingredient`
--
ALTER TABLE `asso_burger_ingredient`
  ADD CONSTRAINT `asso_burger_ingredient_ibfk_1` FOREIGN KEY (`id_burger`) REFERENCES `burgers` (`id_burger`),
  ADD CONSTRAINT `asso_burger_ingredient_ibfk_2` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredients` (`id_ingredient`);

--
-- Contraintes pour la table `asso_burger_sauce`
--
ALTER TABLE `asso_burger_sauce`
  ADD CONSTRAINT `asso_burger_sauce_ibfk_1` FOREIGN KEY (`id_burger`) REFERENCES `burgers` (`id_burger`),
  ADD CONSTRAINT `asso_burger_sauce_ibfk_2` FOREIGN KEY (`id_sauce`) REFERENCES `sauces` (`id_sauce`);

--
-- Contraintes pour la table `asso_ingredient_allergene`
--
ALTER TABLE `asso_ingredient_allergene`
  ADD CONSTRAINT `asso_ingredient_allergene_ibfk_1` FOREIGN KEY (`id_ingredient`) REFERENCES `ingredients` (`id_ingredient`),
  ADD CONSTRAINT `asso_ingredient_allergene_ibfk_2` FOREIGN KEY (`id_allergene`) REFERENCES `allergenes` (`id_allergene`);

--
-- Contraintes pour la table `asso_sauce_allergene`
--
ALTER TABLE `asso_sauce_allergene`
  ADD CONSTRAINT `asso_sauce_allergene_ibfk_1` FOREIGN KEY (`id_sauce`) REFERENCES `sauces` (`id_sauce`),
  ADD CONSTRAINT `asso_sauce_allergene_ibfk_2` FOREIGN KEY (`id_allergene`) REFERENCES `allergenes` (`id_allergene`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
