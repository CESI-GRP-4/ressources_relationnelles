-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 06 mars 2024 à 08:58
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
-- Base de données : `ressources_relationnelles`
--

-- --------------------------------------------------------

--
-- Structure de la table `asso_resource_game`
--

CREATE TABLE `asso_resource_game` (
  `id_resource` int(11) NOT NULL,
  `id_game` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_resource_game`
--

INSERT INTO `asso_resource_game` (`id_resource`, `id_game`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `asso_resource_statistic`
--

CREATE TABLE `asso_resource_statistic` (
  `id_resource` int(11) NOT NULL,
  `id_statistic_archive` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_resource_statistic`
--

INSERT INTO `asso_resource_statistic` (`id_resource`, `id_statistic_archive`) VALUES
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
  `id_resource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_user_bookmark`
--

INSERT INTO `asso_user_bookmark` (`id_user`, `id_resource`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_note`
--

CREATE TABLE `asso_user_note` (
  `id_user` int(11) NOT NULL,
  `id_resource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_user_note`
--

INSERT INTO `asso_user_note` (`id_user`, `id_resource`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_resource`
--

CREATE TABLE `asso_user_resource` (
  `id_user` int(11) NOT NULL,
  `id_resource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_user_resource`
--

INSERT INTO `asso_user_resource` (`id_user`, `id_resource`) VALUES
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
(7, 'Pariss');

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

CREATE TABLE `comments` (
  `id_comment` int(11) NOT NULL,
  `content` varchar(1000) NOT NULL,
  `posting_date` datetime NOT NULL,
  `id_parent_comment` int(11) DEFAULT NULL,
  `id_resource` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id_comment`, `content`, `posting_date`, `id_parent_comment`, `id_resource`, `id_user`) VALUES
(1, 'Great Resource!', '2024-01-18 22:38:55', NULL, 1, 1);

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
  `id_resource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `files`
--

INSERT INTO `files` (`id_file`, `path`, `is_verified`, `download_count`, `id_resource`) VALUES
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
  `id_resource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `invitations`
--

INSERT INTO `invitations` (`id_invitation`, `link`, `status`, `creation_date`, `expiration_date`, `id_resource`) VALUES
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
(27, 36, '2024-01-03 10:45:00'),
(28, 26, '2024-01-04 08:00:00'),
(29, 27, '2024-01-04 09:15:00'),
(30, 28, '2024-01-05 10:30:00'),
(31, 29, '2024-01-05 08:00:00'),
(32, 30, '2024-01-06 09:45:00'),
(33, 31, '2024-01-06 11:00:00'),
(34, 32, '2024-01-07 08:30:00'),
(35, 33, '2024-01-07 09:30:00'),
(36, 36, '2024-01-07 10:45:00'),
(37, 1, '2024-03-05 18:48:39'),
(38, 1, '2024-03-05 19:01:22'),
(39, 1, '2024-03-06 08:53:58');

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
-- Structure de la table `resources`
--

CREATE TABLE `resources` (
  `id_resource` int(11) NOT NULL,
  `label` varchar(255) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `content` varchar(8000) DEFAULT NULL,
  `is_public` tinyint(1) DEFAULT NULL,
  `view_count` bigint(20) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `id_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `resources`
--

INSERT INTO `resources` (`id_resource`, `label`, `description`, `content`, `is_public`, `view_count`, `id_user`, `id_category`, `id_status`) VALUES
(1, 'Resource 1', 'Description of Resource 1', 'Content of Resource 1', 1, 100, 1, 1, 1);

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
-- Structure de la table `status_resources`
--

CREATE TABLE `status_resources` (
  `id_status` int(11) NOT NULL,
  `label` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `status_resources`
--

INSERT INTO `status_resources` (`id_status`, `label`) VALUES
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
  `is_banned` tinyint(1) DEFAULT 0,
  `path_picture` varchar(255) DEFAULT NULL,
  `id_city` int(11) DEFAULT NULL,
  `id_postal_code` int(11) DEFAULT NULL,
  `id_country` int(11) DEFAULT NULL,
  `id_role` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `verification_token` varchar(150) DEFAULT NULL,
  `password_reset_token` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `email`, `first_name`, `last_name`, `password`, `is_verified`, `is_banned`, `path_picture`, `id_city`, `id_postal_code`, `id_country`, `id_role`, `created_at`, `updated_at`, `verification_token`, `password_reset_token`) VALUES
(1, 'john.doe@example.com', 'John', 'Doe', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture', 1, 1, 1, 1, '2024-01-23 21:58:57', '2024-02-26 20:57:50', NULL, NULL),
(22, 'jordan.davis53@example.com', 'Jordan', 'Davis', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, 0, '/path/to/picture/user_1.jpg', 3, 3, 1, 3, '2024-02-13 18:05:16', '2024-02-13 18:05:16', NULL, NULL),
(23, 'dakota.wilson74@sample.com', 'Dakota', 'Wilsoaze', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture/user_2.jpg', 2, 2, 3, 3, '2024-02-13 18:05:16', '2024-02-26 19:56:33', NULL, NULL),
(24, 'jordan.smith21@sample.com', 'Jordan', 'Smith', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture/user_3.jpg', 3, 1, 1, 3, '2024-02-13 18:05:16', '2024-02-13 18:05:16', NULL, NULL),
(25, 'morgan.davis85@sample.com', 'Morgan', 'Davis', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, 0, '/path/to/picture/user_4.jpg', 2, 7, 18, 3, '2024-02-13 18:05:16', '2024-03-05 17:08:45', NULL, NULL),
(26, 'robin.wilson93@example.com', 'Robin', 'Wilson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture/user_5.jpg', 1, 2, 1, 3, '2024-02-13 18:05:16', '2024-02-13 18:05:16', NULL, NULL),
(27, 'casey.brown77@sample.com', 'Casey', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture/user_6.jpg', 2, 3, 3, 2, '2024-02-13 18:05:16', '2024-02-13 18:05:16', NULL, NULL),
(28, 'robin.johnson19@example.com', 'Robin', 'Johnson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, 0, '/path/to/picture/user_7.jpg', 2, 2, 1, 1, '2024-02-13 18:05:16', '2024-02-13 18:05:16', NULL, NULL),
(29, 'riley.moore47@sample.com', 'Riley', 'Moore', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture/user_8.jpg', 2, 2, 1, 3, '2024-02-13 18:05:16', '2024-02-13 18:05:16', NULL, NULL),
(30, 'riley.williams18@sample.com', 'Rileyy', 'Williams', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture/user_9.jpg', 1, 1, 3, 4, '2024-02-13 18:05:16', '2024-02-22 19:08:45', NULL, NULL),
(31, 'dakota.brown54@demo.com', 'Dakota', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture/user_10.jpg', 7, 3, 3, 4, '2024-02-13 18:05:16', '2024-02-20 17:41:27', NULL, NULL),
(32, 'azeaze.brown54@demo.com', 'Dakota', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture/user_10.jpg', 7, 3, 3, 4, '2024-02-13 18:05:16', '2024-02-20 17:41:27', NULL, NULL),
(33, 'aze.brown54@demo.com', 'Dakota', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 0, '/path/to/picture/user_10.jpg', 7, 3, 3, 4, '2024-02-13 18:05:16', '2024-02-20 17:41:27', NULL, NULL),
(36, 'nicolas.chwiej@viacesi.fr', 'Nicolas', 'CHWIEJ', '$2y$12$z3TTUPvA6a0lH5ShBVAUaOqORGu6sndLbG.Cji6/ceB430eKQUXHi', 0, 0, '', NULL, NULL, NULL, 2, '2024-02-29 18:17:50', '2024-02-29 20:29:57', 'EnkYq05kxT9njZmzbpG8BngNEuWLz3Zi7gOfjYq4HUpoDMGgXxGv4jw6cYzutAhJ2Jtb1IFT0L6eoqzSQYj5IhWDmk91cBWA6eXF', NULL);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `asso_resource_game`
--
ALTER TABLE `asso_resource_game`
  ADD PRIMARY KEY (`id_resource`,`id_game`),
  ADD KEY `id_game` (`id_game`);

--
-- Index pour la table `asso_resource_statistic`
--
ALTER TABLE `asso_resource_statistic`
  ADD PRIMARY KEY (`id_resource`,`id_statistic_archive`),
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
  ADD PRIMARY KEY (`id_user`,`id_resource`),
  ADD KEY `id_resource` (`id_resource`);

--
-- Index pour la table `asso_user_note`
--
ALTER TABLE `asso_user_note`
  ADD PRIMARY KEY (`id_user`,`id_resource`),
  ADD KEY `id_resource` (`id_resource`);

--
-- Index pour la table `asso_user_resource`
--
ALTER TABLE `asso_user_resource`
  ADD PRIMARY KEY (`id_user`,`id_resource`),
  ADD KEY `id_resource` (`id_resource`);

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
  ADD KEY `id_resource` (`id_resource`),
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
  ADD KEY `id_resource` (`id_resource`);

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
  ADD KEY `id_resource` (`id_resource`);

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
-- Index pour la table `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id_resource`),
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
-- Index pour la table `status_resources`
--
ALTER TABLE `status_resources`
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
  MODIFY `id_city` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

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
-- AUTO_INCREMENT pour la table `resources`
--
ALTER TABLE `resources`
  MODIFY `id_resource` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
-- AUTO_INCREMENT pour la table `status_resources`
--
ALTER TABLE `status_resources`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `asso_resource_game`
--
ALTER TABLE `asso_resource_game`
  ADD CONSTRAINT `asso_resource_game_ibfk_1` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`),
  ADD CONSTRAINT `asso_resource_game_ibfk_2` FOREIGN KEY (`id_game`) REFERENCES `games` (`id_game`);

--
-- Contraintes pour la table `asso_resource_statistic`
--
ALTER TABLE `asso_resource_statistic`
  ADD CONSTRAINT `asso_resource_statistic_ibfk_1` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`),
  ADD CONSTRAINT `asso_resource_statistic_ibfk_2` FOREIGN KEY (`id_statistic_archive`) REFERENCES `statistics_archive` (`id_statistic_archive`);

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
  ADD CONSTRAINT `asso_user_bookmark_ibfk_2` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`);

--
-- Contraintes pour la table `asso_user_note`
--
ALTER TABLE `asso_user_note`
  ADD CONSTRAINT `asso_user_note_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `asso_user_note_ibfk_2` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`);

--
-- Contraintes pour la table `asso_user_resource`
--
ALTER TABLE `asso_user_resource`
  ADD CONSTRAINT `asso_user_resource_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `asso_user_resource_ibfk_2` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`);

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
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`),
  ADD CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Contraintes pour la table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`);

--
-- Contraintes pour la table `invitations`
--
ALTER TABLE `invitations`
  ADD CONSTRAINT `invitations_ibfk_1` FOREIGN KEY (`id_resource`) REFERENCES `resources` (`id_resource`);

--
-- Contraintes pour la table `login_logs`
--
ALTER TABLE `login_logs`
  ADD CONSTRAINT `login_logs_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`);

--
-- Contraintes pour la table `resources`
--
ALTER TABLE `resources`
  ADD CONSTRAINT `resources_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `resources_ibfk_2` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id_category`),
  ADD CONSTRAINT `resources_ibfk_3` FOREIGN KEY (`id_status`) REFERENCES `status_resources` (`id_status`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_city`) REFERENCES `cities` (`id_city`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`id_postal_code`) REFERENCES `postal_codes` (`id_postal_code`),
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id_country`),
  ADD CONSTRAINT `users_ibfk_4` FOREIGN KEY (`id_role`) REFERENCES `roles` (`id_role`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
