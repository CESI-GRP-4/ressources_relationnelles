-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 02 mai 2024 à 22:08
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
-- Structure de la table `asso_ressource_game`
--

CREATE TABLE `asso_ressource_game` (
  `id_ressource` int(11) NOT NULL,
  `id_game` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `asso_ressource_statistic`
--

CREATE TABLE `asso_ressource_statistic` (
  `id_ressource` int(11) NOT NULL,
  `id_statistic_archive` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_favorite`
--

CREATE TABLE `asso_user_favorite` (
  `id_user` int(11) NOT NULL,
  `id_ressource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `asso_user_favorite`
--

INSERT INTO `asso_user_favorite` (`id_user`, `id_ressource`) VALUES
(28, 4);

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_note`
--

CREATE TABLE `asso_user_note` (
  `id_user` int(11) NOT NULL,
  `id_ressource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_ressource`
--

CREATE TABLE `asso_user_ressource` (
  `id_user` int(11) NOT NULL,
  `id_ressource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `id_category` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `color` varchar(7) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`id_category`, `title`, `description`, `icon`, `color`, `is_active`, `created_by`, `created_at`, `updated_at`) VALUES
(3, 'Voyages', 'Tout sur les voyages, des destinations aux conseils.', 'ph:airplane', '#1E90FF', 1, 1, '2024-03-26 19:55:26', '2024-03-26 19:55:26'),
(4, 'Technologie', 'Dernières nouvelles et revues de technologie.', 'ph:device-mobile-camera', '#32CD32', 1, 1, '2024-03-26 19:55:26', '2024-03-26 19:55:26'),
(5, 'Cuisine', 'Recettes, astuces et plus sur la cuisine.', 'ph:fork-knife', '#FFA07A', 0, 1, '2024-03-26 19:55:26', '2024-03-26 21:42:01'),
(6, 'Title de ma catégorie', 'C\'est une catégorie de fou', '', '#555555', 1, 1, '2024-03-26 22:46:55', '2024-04-29 19:41:35'),
(7, 'Title de ma catégorie 2', 'C\'est une catégorie de fou', '', '#555555', 1, 1, '2024-03-26 22:49:00', '2024-04-29 19:41:35'),
(8, 'Title de ma catégorie 3', 'C\'est une catégorie de fou', '', '#555555', 0, 1, '2024-03-26 22:53:09', '2024-04-29 19:41:35'),
(9, 'Title de ma catégorie 4', 'C\'est une catégorie de fou', '', '#666abc', 1, 1, '2024-03-26 22:54:55', '2024-04-29 19:41:35'),
(10, 'le concert était cool', 'C\'est une catégorie de fou', '', '#ffefef', 1, 1, '2024-03-26 22:55:12', '2024-04-29 19:41:35'),
(16, 'PERIPHHHH', 'MAIS YA LA CHAMBRE 140', 'ya pas d\'icon mon reuf', '#faeaaa', 1, 1, '2024-04-10 20:08:54', '2024-04-10 20:08:57');

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
  `comment` varchar(1000) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_parent` int(11) DEFAULT NULL,
  `id_ressource` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id_comment`, `comment`, `created_at`, `id_parent`, `id_ressource`, `id_user`, `id_status`) VALUES
(8, 'ouai ouai', '2024-04-29 22:05:31', NULL, 5, 1, 3),
(9, 'ouai ouai', '2024-04-29 22:07:22', 8, 5, 1, 2),
(10, 'cc', '2024-04-30 17:37:47', NULL, 4, 1, 2),
(11, 'mais naaaann', '2024-04-30 17:38:07', 10, 4, 1, 2),
(12, 'aze', '2024-04-30 17:38:44', NULL, 4, 1, 2),
(13, 'Oh le SSSSS', '2024-04-30 17:40:38', 10, 4, 28, 2),
(14, 'aaaa', '2024-04-30 18:35:53', 13, 4, 1, 2),
(15, 'sss', '2024-04-30 18:36:05', 14, 4, 1, 2);

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
(19, 26, '2024-04-01 08:00:00'),
(20, 27, '2024-04-01 09:15:00'),
(21, 28, '2024-04-01 10:30:00'),
(22, 29, '2024-04-02 08:00:00'),
(23, 30, '2024-04-02 09:45:00'),
(24, 31, '2024-04-02 11:00:00'),
(25, 32, '2024-04-03 08:30:00'),
(26, 33, '2024-04-03 09:30:00'),
(28, 26, '2024-04-04 08:00:00'),
(29, 27, '2024-04-04 09:15:00'),
(30, 28, '2024-04-05 10:30:00'),
(31, 29, '2024-04-05 08:00:00'),
(32, 30, '2024-04-06 09:45:00'),
(33, 31, '2024-04-06 11:00:00'),
(34, 32, '2024-04-08 08:30:00'),
(35, 29, '2024-04-08 09:30:00'),
(37, 1, '2024-04-08 18:48:39'),
(38, 1, '2024-04-08 19:01:22'),
(39, 1, '2024-04-08 08:53:58'),
(40, 1, '2024-04-09 09:32:49'),
(41, 28, '2024-04-09 08:00:00'),
(42, 32, '2024-04-09 09:45:00'),
(43, 1, '2024-04-09 11:00:00'),
(44, 1, '2024-04-10 08:53:58'),
(45, 1, '2024-04-10 08:53:58'),
(46, 32, '2024-04-10 08:53:58'),
(47, 1, '2024-04-10 08:53:58'),
(48, 33, '2024-04-10 08:53:58'),
(49, 33, '2024-04-10 08:53:58'),
(50, 29, '2024-04-10 08:53:58'),
(51, 1, '2024-04-11 08:53:58'),
(52, 33, '2024-04-11 08:53:58'),
(53, 1, '2024-04-11 08:53:58'),
(54, 1, '2024-04-11 08:53:58'),
(55, 33, '2024-04-12 08:53:58'),
(56, 29, '2024-04-12 08:53:58'),
(57, 1, '2024-04-13 08:53:58'),
(58, 33, '2024-04-13 08:53:58'),
(59, 1, '2024-04-14 08:53:58'),
(60, 1, '2024-04-14 08:53:58'),
(61, 29, '2024-04-14 08:53:58'),
(62, 1, '2024-04-16 08:53:58'),
(63, 33, '2024-04-16 08:53:58'),
(64, 29, '2024-04-16 08:53:58'),
(65, 1, '2024-04-16 08:53:58'),
(66, 1, '2024-04-16 08:53:58'),
(67, 1, '2024-04-16 12:56:07'),
(68, 1, '2024-04-18 14:23:11'),
(69, 1, '2024-04-18 21:25:37'),
(70, 1, '2024-04-17 16:32:03'),
(71, 37, '2024-04-18 21:25:54'),
(72, 38, '2024-04-18 21:26:48'),
(73, 1, '2024-04-18 21:27:29'),
(75, 1, '2024-04-10 15:05:34'),
(76, 1, '2024-04-10 15:05:50'),
(77, 1, '2024-04-11 00:27:20'),
(78, 1, '2024-04-11 11:38:03'),
(79, 1, '2024-04-11 11:38:11'),
(80, 1, '2024-04-11 11:42:32'),
(81, 1, '2024-04-11 11:42:41'),
(82, 1, '2024-04-11 11:43:09'),
(83, 1, '2024-04-11 11:44:59'),
(84, 1, '2024-04-11 11:45:12'),
(85, 1, '2024-04-11 11:45:23'),
(86, 1, '2024-04-11 11:46:48'),
(87, 1, '2024-04-11 11:50:14'),
(88, 1, '2024-04-11 11:50:56'),
(89, 1, '2024-04-11 11:54:33'),
(90, 1, '2024-04-11 11:58:27'),
(91, 1, '2024-04-11 12:58:44'),
(92, 1, '2024-04-11 12:59:31'),
(93, 39, '2024-04-11 13:08:10'),
(94, 39, '2024-04-11 13:08:45'),
(95, 40, '2024-04-11 13:09:53'),
(96, 1, '2024-04-17 23:02:58'),
(97, 1, '2024-04-25 19:02:59'),
(98, 1, '2024-04-30 19:36:16'),
(99, 28, '2024-04-30 19:40:12'),
(100, 1, '2024-05-02 20:09:10');

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
-- Structure de la table `profile_pictures`
--

CREATE TABLE `profile_pictures` (
  `id_profile_picture` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `profile_pictures`
--

INSERT INTO `profile_pictures` (`id_profile_picture`, `name`, `url`) VALUES
(1, 'Oreo', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Oreo'),
(2, 'Charlie', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Charlie'),
(3, 'Princess', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Princess'),
(4, 'Gizmo', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Gizmo'),
(5, 'Willow', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Willow'),
(6, 'Sophie', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Sophie'),
(7, 'Oscar', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Oscar'),
(8, 'Shadow', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Shadow'),
(9, 'Snuggles', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Snuggles'),
(10, 'Missy', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Missy'),
(11, 'Sassy', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Sassy'),
(12, 'Simba', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Simba'),
(13, 'Ginger', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Ginger'),
(14, 'Mia', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Mia'),
(15, 'Tinkerbell', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Tinkerbell'),
(16, 'Zoey', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Zoey'),
(17, 'Simon', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Simon'),
(18, 'Cookie', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Cookie'),
(19, 'Leo', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Leo'),
(20, 'Patches', 'https://api.dicebear.com/8.x/bottts-neutral/svg?seed=Patches');

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
  `view_count` bigint(20) DEFAULT 0,
  `id_user` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_type` int(11) DEFAULT NULL,
  `file` varchar(200) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `staff_comment` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ressources`
--

INSERT INTO `ressources` (`id_ressource`, `label`, `description`, `content`, `is_public`, `view_count`, `id_user`, `id_category`, `id_status`, `id_type`, `file`, `created_at`, `updated_at`, `staff_comment`) VALUES
(4, 'A', 'Hello', NULL, 1, 7, 28, 3, 1, 1, NULL, '2024-04-10 11:10:06', '2024-04-27 10:35:58', NULL),
(5, 'B', 'Hello', NULL, 0, 72, 1, 3, 1, 1, NULL, '2024-04-10 11:11:48', '2024-04-30 15:48:48', 'C\'est pas une ress'),
(6, 'Wshee', 'Hello', NULL, 1, 150, 23, 3, 1, 1, NULL, '2024-04-10 11:13:44', '2024-04-11 08:29:57', NULL),
(8, 'ON ARRIVE A 200', 'PLK ', NULL, 1, 2553, 1, 16, 1, 1, NULL, '2024-04-10 20:09:04', '2024-04-11 06:48:04', NULL),
(9, 'TOUT ROULE POUR NOUS', 'PLK', NULL, 1, 17402, 30, 16, 1, 1, NULL, '2024-04-10 20:09:32', '2024-04-11 08:29:57', NULL),
(10, 'IL PLEUT A PARIS', 'PLK', NULL, 1, 12245, 1, 16, 2, 1, NULL, '2024-04-10 20:29:27', '2024-04-11 08:29:57', NULL),
(11, 'test', 'test', NULL, 1, 0, 1, 4, 3, 1, NULL, '2024-04-11 06:52:22', '2024-04-11 06:53:30', 'c\'est pas une ressource mon gars :('),
(13, 'test', 'test\n\nzzz\n\nee', NULL, 1, 0, 1, 4, 2, 1, NULL, '2024-04-11 07:09:50', '2024-04-11 07:09:50', NULL),
(14, 'test', 'test\n\nzzz\n\nee', NULL, 1, 0, 1, 4, 2, 1, NULL, '2024-04-27 09:11:25', '2024-04-27 09:11:25', NULL),
(15, 'test', 'test\n\nzzz\n\nee', NULL, 1, 0, 1, 4, 2, 1, NULL, '2024-04-29 18:05:29', '2024-04-29 18:05:29', NULL);

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
-- Structure de la table `status_comments`
--

CREATE TABLE `status_comments` (
  `id_status` int(11) NOT NULL,
  `label` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `status_comments`
--

INSERT INTO `status_comments` (`id_status`, `label`) VALUES
(1, 'accepted'),
(2, 'pending'),
(3, 'rejected');

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
(1, 'accepted'),
(2, 'pending'),
(3, 'rejected'),
(4, 'blocked'),
(5, 'disable');

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

CREATE TABLE `types` (
  `id_type` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `types`
--

INSERT INTO `types` (`id_type`, `name`) VALUES
(1, 'je suis111111111111111');

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
  `id_city` int(11) DEFAULT NULL,
  `id_postal_code` int(11) DEFAULT NULL,
  `id_country` int(11) DEFAULT NULL,
  `id_role` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `verification_token` varchar(150) DEFAULT NULL,
  `password_reset_token` varchar(100) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `id_profile_picture` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `email`, `first_name`, `last_name`, `password`, `is_verified`, `ban_until`, `id_city`, `id_postal_code`, `id_country`, `id_role`, `created_at`, `updated_at`, `verification_token`, `password_reset_token`, `deleted_at`, `id_profile_picture`) VALUES
(1, 'john.doe@example.com', 'John', 'Doe', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 1, 1, 1, 1, '2024-01-23 21:58:57', '2024-04-27 11:12:02', NULL, NULL, NULL, 12),
(22, 'jordan.davis53@example.com', 'Jordan', 'Davis', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, 3, 3, 1, 3, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, '2024-03-06 15:19:53', 2),
(23, 'dakota.wilson74@sample.com', 'Dakota', 'Wilsoaze', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 1742071249, 2, 2, 3, 3, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 3),
(24, 'jordan.smith21@sample.com', 'Jordan', 'Smith', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 3, 1, 1, 3, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 4),
(25, 'morgan.davis85@sample.com', 'Morgane', 'Davis', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, 1, 7, 18, 4, '2024-02-13 18:05:16', '2024-04-17 20:00:17', NULL, NULL, NULL, 5),
(26, 'robin.wilson93@example.com', 'Robin', 'Wilson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 1, 2, 1, 3, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 6),
(27, 'casey.brown77@sample.com', 'Casey', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 2, 3, 3, 2, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 7),
(28, 'robin.johnson19@example.com', 'Robin', 'Johnson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, 2, 2, 1, 1, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 8),
(29, 'riley.moore47@sample.com', 'Riley', 'Moore', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 2, 2, 1, 3, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 9),
(30, 'riley.williams18@sample.com', 'Riley', 'Williams', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, 7, 1, 3, 4, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 10),
(31, 'dakota.brown54@demo.com', 'Dakota', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 7, 3, 3, 4, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 11),
(32, 'azeaze.brown54@demo.com', 'Charlie', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 7, 3, 3, 4, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 1),
(33, 'aze.brown54@demo.com', 'Zoulou', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 1, 3, 3, 4, '2024-02-13 18:05:16', '2024-04-11 09:29:16', NULL, NULL, NULL, 13),
(37, 'azeazeAZEAZE123132@gmail.com', 'azeaze', 'AZEAZE', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, NULL, NULL, NULL, 4, '2024-03-18 19:25:52', '2024-04-11 11:08:29', NULL, NULL, '2024-03-18 19:29:06', 14),
(38, 'azeazeAZEAZE123132@gmail.comze', 'azeaze', 'AZEAZE', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, NULL, NULL, NULL, 4, '2024-03-18 19:26:46', '2024-04-11 11:08:29', NULL, NULL, '2024-03-18 19:27:45', 15),
(39, 'imneuw@a.com', 'imneuw', 'what', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, NULL, NULL, NULL, 4, '2024-04-11 09:08:08', '2024-04-11 11:08:29', 'S59Ry2htv4aPliwlDc20npWC0BsHN0A7XCd054RZILTv5aRI98n5LVEhRJ8eDSAC9xtS7CgyNHIjEnxZsDv7KheL2ImEFUT95xRZ', NULL, NULL, 15),
(40, 'test@pp.user', 'aze', 'aze', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 0, NULL, NULL, NULL, NULL, 4, '2024-04-11 09:09:51', '2024-04-11 11:09:57', 'du9xmwLyKrMCAFM3s2oHZSxujCzb9VSZcsR4QMKUTZE9g9Otik7IjaJJ2ch1qpl9rYWzI0Q6CDBkWCcX8YHy6AiGJappimeus4iQ', NULL, NULL, 19);

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
(78, 1, 25, 'Modify', 'last_name', 'Daviss', 'Davis', '2024-03-18 21:18:31'),
(79, 1, 25, 'Modify', 'first_name', 'Morgan', 'Morgane', '2024-04-17 22:00:17');

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
-- Index pour la table `asso_user_favorite`
--
ALTER TABLE `asso_user_favorite`
  ADD PRIMARY KEY (`id_user`,`id_ressource`),
  ADD KEY `idx_ressource` (`id_ressource`);

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
  ADD PRIMARY KEY (`id_category`),
  ADD UNIQUE KEY `title` (`title`),
  ADD KEY `fk_categories_created_by` (`created_by`);

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
  ADD KEY `id_ressource` (`id_ressource`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_parent` (`id_parent`),
  ADD KEY `id_status` (`id_status`);

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
-- Index pour la table `profile_pictures`
--
ALTER TABLE `profile_pictures`
  ADD PRIMARY KEY (`id_profile_picture`),
  ADD UNIQUE KEY `uc_name` (`name`),
  ADD UNIQUE KEY `uc_url` (`url`);

--
-- Index pour la table `ressources`
--
ALTER TABLE `ressources`
  ADD PRIMARY KEY (`id_ressource`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_category` (`id_category`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_type` (`id_type`);

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
-- Index pour la table `status_comments`
--
ALTER TABLE `status_comments`
  ADD PRIMARY KEY (`id_status`);

--
-- Index pour la table `status_ressources`
--
ALTER TABLE `status_ressources`
  ADD PRIMARY KEY (`id_status`);

--
-- Index pour la table `types`
--
ALTER TABLE `types`
  ADD PRIMARY KEY (`id_type`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD KEY `id_city` (`id_city`),
  ADD KEY `id_postal_code` (`id_postal_code`),
  ADD KEY `id_country` (`id_country`),
  ADD KEY `id_role` (`id_role`),
  ADD KEY `fk_profile_image` (`id_profile_picture`);

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
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `cities`
--
ALTER TABLE `cities`
  MODIFY `id_city` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id_comment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;

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
-- AUTO_INCREMENT pour la table `profile_pictures`
--
ALTER TABLE `profile_pictures`
  MODIFY `id_profile_picture` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `ressources`
--
ALTER TABLE `ressources`
  MODIFY `id_ressource` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
-- AUTO_INCREMENT pour la table `status_comments`
--
ALTER TABLE `status_comments`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `status_ressources`
--
ALTER TABLE `status_ressources`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `types`
--
ALTER TABLE `types`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT pour la table `user_history`
--
ALTER TABLE `user_history`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

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
-- Contraintes pour la table `asso_user_favorite`
--
ALTER TABLE `asso_user_favorite`
  ADD CONSTRAINT `fk_asuo_user_favorite_ressource_id` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_asuo_user_favorite_user_id` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE;

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
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`),
  ADD CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `fk_comments_parent` FOREIGN KEY (`id_parent`) REFERENCES `comments` (`id_comment`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_comments_ressource` FOREIGN KEY (`id_ressource`) REFERENCES `ressources` (`id_ressource`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_comments_status` FOREIGN KEY (`id_status`) REFERENCES `status_comments` (`id_status`);

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
  ADD CONSTRAINT `fk_ressources_types` FOREIGN KEY (`id_type`) REFERENCES `types` (`id_type`),
  ADD CONSTRAINT `ressources_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `ressources_ibfk_2` FOREIGN KEY (`id_category`) REFERENCES `categories` (`id_category`),
  ADD CONSTRAINT `ressources_ibfk_3` FOREIGN KEY (`id_status`) REFERENCES `status_ressources` (`id_status`);

--
-- Contraintes pour la table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_profile_image` FOREIGN KEY (`id_profile_picture`) REFERENCES `profile_pictures` (`id_profile_picture`),
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
