-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mar. 14 mai 2024 à 22:27
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

--
-- Déchargement des données de la table `asso_user_bookmark`
--

INSERT INTO `asso_user_bookmark` (`id_user`, `id_ressource`) VALUES
(1, 16),
(2, 6),
(25, 13),
(32, 5),
(32, 31),
(33, 16),
(35, 6);

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
(1, 16),
(2, 6),
(2, 13),
(3, 13),
(25, 13),
(30, 16),
(31, 16),
(32, 16),
(33, 16),
(34, 16),
(35, 6),
(35, 13),
(35, 16);

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
(1, 'Voitures', 'Découvrez l\'univers passionnant des automobiles, alliant innovation technologique et design esthétique. Cette catégorie couvre tout, des derniers modèles sur le marché aux classiques vintage, en passant par les tendances en matière de mobilité durable et les technologies de pointe comme les véhicules électriques et autonomes. Explorez des critiques détaillées, des conseils d\'entretien, et des guides d\'achat pour vous aider à choisir la voiture qui répond le mieux à vos besoins et préférences. Idéal pour les amateurs de voitures, qu\'ils soient novices ou connaisseurs expérimentés.', 'mdi:car-outline', '#00ff7b', 1, 1, '2024-05-13 08:57:19', '2024-05-13 14:18:51'),
(2, 'Communication', 'Maîtrisez l\'art de transmettre et de recevoir des informations de manière efficace. Cette catégorie couvre tous les aspects de la communication, des compétences verbales et non verbales aux stratégies de communication digitale et interpersonnelle. Découvrez comment améliorer vos présentations, renforcer votre persuasion et optimiser votre capacité à écouter et à répondre. Que ce soit pour améliorer vos relations personnelles ou professionnelles, ces ressources sont essentielles pour naviguer avec succès dans un monde de plus en plus connecté.', 'mdi:account-box-multiple-outline', '#ff0000', 1, 1, '2024-05-13 09:03:13', '2024-05-13 09:18:44'),
(3, 'Cultures', 'Explorez les richesses des traditions, des pratiques et des croyances qui façonnent les sociétés à travers le monde. Cette catégorie met en lumière la diversité des expressions culturelles, allant des festivals colorés aux rituels ancestraux, et des arts populaires aux langues parlées. Plongez dans un voyage éducatif pour découvrir comment l\'histoire, la géographie et la religion influencent les modes de vie des communautés du globe. Parfait pour les passionnés d\'anthropologie, d\'histoire et de voyages culturels.', 'material-symbols-light:bakery-dining-outline', '#e4bd2f', 1, 1, '2024-05-13 09:10:08', '2024-05-13 09:10:08'),
(4, 'Développement personnel', 'Découvrez des stratégies, des techniques et des inspirations pour améliorer votre vie quotidienne. Cette catégorie offre des ressources sur la gestion du stress, la confiance en soi, la productivité, et plus encore, visant à vous aider à atteindre vos objectifs personnels et professionnels. Apprenez à maîtriser l\'art de l\'équilibre vie-travail, à développer des habitudes saines, et à renforcer votre bien-être mental et émotionnel. Idéal pour ceux qui cherchent à s\'épanouir et à réaliser leur plein potentiel.', 'material-symbols-light:book-2-outline', '#3bc0c9', 1, 1, '2024-05-13 09:17:09', '2024-05-13 09:17:09'),
(5, 'Intelligence émotionnelle', 'Approfondissez votre compréhension des émotions et apprenez à les gérer de manière constructive, tant chez vous que chez les autres. Cette catégorie explore les compétences clés de l\'intelligence émotionnelle, telles que la conscience de soi, la régulation émotionnelle, la motivation personnelle, l\'empathie et les aptitudes sociales. Profitez de conseils pratiques et d\'exercices pour améliorer votre capacité à gérer les conflits, à établir des relations solides et à augmenter votre bien-être au travail et dans la vie personnelle. Idéal pour ceux qui souhaitent développer une meilleure harmonie émotionnelle et renforcer leurs interactions sociales.', 'ri:emotion-line', '#794e70', 1, 1, '2024-05-13 09:20:03', '2024-05-13 09:20:03'),
(6, 'Loisirs', 'Plongez dans le monde fascinant des activités de détente et de plaisir qui enrichissent la vie quotidienne. Cette catégorie propose une exploration de divers hobbies et passe-temps, allant des activités artistiques et artisanales aux jeux de société, en passant par la cuisine, la lecture, et le jardinage. Que vous cherchiez à découvrir une nouvelle passion ou à approfondir vos compétences dans un domaine spécifique, vous trouverez ici des ressources pour vous inspirer et vous guider. Idéal pour tous ceux qui souhaitent enrichir leur temps libre et ajouter une touche de créativité à leur quotidien.', 'ph:beach-ball-thin', '#718f66', 1, 1, '2024-05-13 09:22:05', '2024-05-13 09:22:05'),
(7, 'Monde professionnel', 'Cette catégorie est dédiée à tous les aspects de la vie professionnelle, de l\'ascension de carrière aux stratégies de leadership, en passant par la gestion d\'équipe et le développement d\'entreprises. Explorez des articles, des guides et des études de cas qui vous aideront à naviguer dans les défis du milieu professionnel contemporain. Découvrez des conseils pratiques sur la négociation, le réseautage, la gestion de conflits, et l\'innovation dans le lieu de travail. Parfait pour les professionnels ambitieux, les entrepreneurs, et ceux qui cherchent à faire progresser leur carrière ou à améliorer leur environnement de travail.', 'material-symbols-light:work-outline', '#5739d0', 1, 1, '2024-05-13 09:23:07', '2024-05-13 09:23:07'),
(8, 'Parentalité', 'Découvrez les joies et les défis de l\'éducation des enfants dans ce monde en constante évolution. Cette catégorie offre des conseils pratiques, des stratégies éducatives, et des perspectives enrichissantes pour soutenir les parents à chaque étape du développement de leur enfant. De la petite enfance à l\'adolescence, apprenez comment encourager l\'autonomie, gérer les comportements difficiles, et favoriser un environnement familial sain et aimant. Que vous soyez nouveau parent ou que vous cherchiez à rafraîchir vos compétences parentales, ces ressources sont conçues pour vous guider dans cette aventure essentielle.', 'icon-park-outline:family', '#a23434', 1, 1, '2024-05-13 09:24:24', '2024-05-13 09:24:24'),
(9, 'Qualité de vie', 'Explorez les divers aspects qui contribuent à une vie pleine et satisfaisante. Cette catégorie aborde des thèmes variés tels que le bien-être physique et mental, l\'équilibre travail-vie personnelle, et les environnements sains. Découvrez des conseils pour améliorer votre santé, optimiser votre espace de vie, et cultiver des relations enrichissantes. Apprenez à prioriser ce qui compte le plus pour vous et à mettre en place des pratiques quotidiennes qui augmentent votre bien-être général. Idéal pour ceux qui cherchent à améliorer leur quotidien et à vivre de manière plus consciente et harmonieuse.', 'la:star-of-life', '#56b88a', 1, 1, '2024-05-13 09:25:31', '2024-05-13 09:25:31'),
(10, 'Recherche de sens', 'Plongez dans l\'exploration de questions existentielles et de quêtes personnelles de significations profondes dans la vie. Cette catégorie offre des réflexions et des ressources pour ceux qui cherchent à comprendre leur place dans le monde, à identifier leurs passions, et à aligner leur vie avec leurs valeurs fondamentales. Découvrez des approches philosophiques, spirituelles et pratiques pour enrichir votre existence et répondre à l\'appel intérieur de vivre une vie authentique et épanouissante. Parfait pour les individus en période de transition ou pour ceux qui aspirent à une compréhension plus profonde de leur propre existence.', 'mingcute:crystal-ball-line', '#b0b0b0', 1, 1, '2024-05-13 09:26:46', '2024-05-13 09:26:46'),
(11, 'Santé physique', 'Cette catégorie est dédiée à tout ce qui concerne la santé corporelle et le bien-être. Des dernières recherches en nutrition et fitness, aux conseils pratiques sur la gestion des maladies chroniques, explorez une gamme de sujets qui vous aideront à maintenir ou à améliorer votre condition physique. Apprenez à adopter des habitudes saines, à comprendre les signaux de votre corps, et à utiliser l\'exercice comme outil de bien-être mental et physique. Idéal pour ceux qui cherchent à vivre une vie plus saine et plus active.', 'icon-park-outline:sport', '#3f3636', 1, 1, '2024-05-13 09:28:21', '2024-05-13 09:28:21'),
(12, 'Santé psychique', 'Approfondissez votre compréhension de la santé mentale et découvrez des stratégies pour préserver ou améliorer votre bien-être émotionnel. Cette catégorie propose des ressources sur des sujets tels que la gestion du stress, la lutte contre l\'anxiété, la dépression, et d\'autres problématiques psychiques. Explorez des techniques de relaxation, des pratiques de pleine conscience, et les dernières avancées en psychothérapie pour soutenir votre parcours vers une meilleure santé mentale. Idéal pour tous ceux qui cherchent à améliorer leur résilience émotionnelle et à vivre une vie plus équilibrée et sereine.', 'medical-icon:i-mental-health', '#ff0000', 0, 1, '2024-05-13 09:29:42', '2024-05-13 18:53:21'),
(13, 'Spiritualité', 'Explorez les dimensions profondes de l\'existence à travers différentes pratiques et croyances spirituelles. Cette catégorie offre des insights sur la méditation, la prière, la connexion avec la nature, et d\'autres voies menant à l\'épanouissement spirituel. Découvrez comment intégrer la spiritualité dans votre vie quotidienne pour favoriser la paix intérieure, l\'éveil personnel, et une connexion plus profonde avec le monde qui vous entoure. Idéale pour ceux qui cherchent à enrichir leur parcours personnel à travers une compréhension plus profonde des mystères de la vie et de l\'âme.', 'token:spirit', '#ff70d9', 0, 1, '2024-05-13 09:32:26', '2024-05-13 18:53:10'),
(14, 'Vie affective', 'Découvrez les clés pour cultiver et enrichir vos relations affectives. Cette catégorie explore les dynamiques des relations amoureuses, amicales et familiales, offrant des conseils pour renforcer les liens, gérer les conflits et communiquer efficacement. Apprenez à construire des relations saines et épanouissantes, à comprendre les besoins émotionnels propres et ceux des autres, et à naviguer dans les complexités des interactions humaines. Idéal pour tous ceux qui cherchent à améliorer leur vie affective et à développer une meilleure intelligence relationnelle.', 'eva:activity-fill', '#093a19', 0, 1, '2024-05-13 09:33:40', '2024-05-13 18:52:01'),
(15, 'Musiques', 'Plongez dans l\'univers fascinant de la musique, un langage universel qui transcende les frontières et les cultures. Cette catégorie explore les différents genres musicaux, des classiques immortels aux tendances contemporaines, et offre des analyses sur des œuvres et des artistes influents. Découvrez des conseils pour apprendre à jouer d\'un instrument, écrire vos propres chansons, ou simplement apprécier la musique à un niveau plus profond. Parfait pour les passionnés de musique de tous niveaux qui souhaitent explorer plus largement cet art formidables et ses impacts culturels et personnels.', 'mdi-light:music', '#9953ac', 1, 1, '2024-05-13 11:33:09', '2024-05-13 11:33:09');

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
(1, 'Salon de Provence'),
(2, 'Vitrolles'),
(3, 'Toulon'),
(4, 'Aix la Duranne'),
(5, 'Brest'),
(6, 'Elblag'),
(7, 'Andore');

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
(1, 'N\'hésitez pas à partager votre top !', '2024-05-13 14:08:33', NULL, 6, 2, 1),
(2, 'IL PLEUT A PARIIIIIS', '2024-05-13 14:09:55', 1, 6, 1, 1),
(3, 'Il pleut a paris devrait être première !', '2024-05-13 14:24:21', NULL, 6, 1, 1),
(4, 'Petrouchka c\'est nullllllllllllll', '2024-05-13 14:25:47', 1, 6, 1, 3),
(5, 'Défi réussi pour moi ! 😁', '2024-05-13 14:36:26', NULL, 4, 2, 2),
(6, 'Jolie liste !', '2024-05-13 14:39:54', 1, 6, 3, 2),
(7, 'Je pense, une petit Golf 7 GTI Stage 2 ou 3 serai un bon daily !', '2024-05-13 16:36:06', NULL, 13, 2, 1),
(8, 'Juste une polo GTI c\'est déjà bien. Puis c\'est moins cher.', '2024-05-13 16:37:50', 7, 13, 3, 1),
(9, 'Une RS6 c\'est pas mal effectivement, mais Range Rover ont des jolis bolide aussi.', '2024-05-13 16:38:59', NULL, 13, 3, 1),
(10, 'Effectivement ! J\'aime bien, faudra que tu nous fasses un ressources sur les Volkswagen mec !', '2024-05-13 16:40:21', 7, 13, 1, 1),
(11, 'Je n\'ai pas dis que les autres font du mauvais travaille hehe, moi je suis toujours fan de koenigsegg aussi 😉', '2024-05-13 16:41:21', 9, 13, 1, 2),
(12, 'C\'est de la me*** vos voitures !', '2024-05-13 16:47:24', 8, 13, 25, 2),
(13, 'C\'EST NUL COMME VOITUREEEEEE', '2024-05-13 16:47:52', 8, 13, 25, 2),
(14, 'La FSO Polonez, im bat table', '2024-05-13 16:49:57', NULL, 13, 25, 1),
(15, 'C\'est OUFFF ! Je recommande', '2024-05-13 20:34:53', NULL, 16, 32, 2),
(16, 'sandwich triangle, jambon emmental, 0.80€\nimbattable', '2024-05-13 20:57:56', NULL, 50, 1, 1),
(17, 'A cheval !', '2024-05-13 21:00:54', NULL, 13, 35, 2);

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
(1, 1, '2024-05-13 11:41:03'),
(2, 1, '2024-05-13 11:41:49'),
(3, 1, '2024-05-13 11:46:56'),
(4, 2, '2024-05-13 14:31:24'),
(5, 2, '2024-05-13 14:36:09'),
(6, 1, '2024-05-13 14:38:58'),
(7, 3, '2024-05-13 14:50:09'),
(8, 4, '2024-05-13 14:57:29'),
(9, 2, '2024-05-13 15:35:17'),
(10, 3, '2024-05-13 16:38:55'),
(11, 4, '2024-05-13 18:16:07'),
(12, 1, '2024-05-13 18:16:51'),
(13, 1, '2024-05-13 18:19:32'),
(14, 2, '2024-05-13 18:24:25'),
(15, 4, '2024-05-13 18:25:46'),
(16, 3, '2024-05-13 18:29:17'),
(17, 2, '2024-05-13 18:29:52'),
(18, 3, '2024-05-13 18:36:59'),
(19, 25, '2024-05-13 18:42:19'),
(20, 25, '2024-05-13 18:43:04'),
(21, 25, '2024-05-13 18:44:03'),
(22, 1, '2024-05-13 18:53:27'),
(23, 25, '2024-05-13 18:54:43'),
(24, 25, '2024-05-13 19:15:20'),
(25, 25, '2024-05-13 19:31:41'),
(26, 1, '2024-05-13 21:01:00'),
(27, 1, '2024-05-13 21:52:27'),
(28, 26, '2024-05-13 21:54:53'),
(29, 26, '2024-05-13 21:56:38'),
(30, 27, '2024-05-13 21:59:48'),
(31, 27, '2024-05-13 22:01:21'),
(32, 27, '2024-05-13 22:03:48'),
(33, 28, '2024-05-13 22:06:16'),
(34, 29, '2024-05-13 22:06:53'),
(35, 30, '2024-05-13 22:07:18'),
(36, 31, '2024-05-13 22:07:39'),
(37, 32, '2024-05-13 22:08:15'),
(38, 33, '2024-05-13 22:08:59'),
(39, 28, '2024-05-13 22:17:29'),
(40, 29, '2024-05-13 22:22:20'),
(41, 30, '2024-05-13 22:25:44'),
(42, 31, '2024-05-13 22:29:21'),
(43, 32, '2024-05-13 22:32:06'),
(44, 33, '2024-05-13 22:35:36'),
(45, 34, '2024-05-13 22:45:04'),
(46, 35, '2024-05-13 22:47:20'),
(47, 36, '2024-05-13 22:47:45'),
(48, 37, '2024-05-13 22:48:28'),
(49, 34, '2024-05-13 22:49:58'),
(50, 35, '2024-05-13 23:00:10'),
(51, 30, '2024-05-13 23:02:42'),
(52, 3, '2024-05-13 23:04:14'),
(53, 31, '2024-05-13 23:06:12'),
(54, 1, '2024-05-14 22:20:21');

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
(1, '13300'),
(2, '13127'),
(3, '83000'),
(4, '13100'),
(5, '05500'),
(6, '82300'),
(7, '000');

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
  `description` text DEFAULT NULL,
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
(1, 'Reconnaître ses émotions', 'L’objectif de cet exercice est de reconnaître les émotions sur soi. Pour ce faire, nous noterons dans un \npetit cahier prévu à cet effet, à des moments prédéfinis de la journée, comment nous nous sentons \némotionnellement. Quelle émotion nous habite ? Cette émotion est-elle positive ou négative ? Avec \nquelle force ? Quel a été le facteur déclencheur ?\nNous répèterons la démarche durant une semaine.\nAprès une semaine, reprenons nos notes et identifions avec un marqueur les émotions que nous \nressentons le plus souvent, si elles sont positives ou négatives et quel type de facteur déclencheur est \nobservé le plus souvent.\nPour conclure, demandons-nous si nos émotions auraient pu être différentes et si la situation en aurait \nété changée', NULL, 1, 65895, 1, 5, 1, 1, NULL, '2024-05-13 09:35:53', '2024-05-13 21:09:41', NULL),
(2, 'Emission ARTE : Travail | Travail, Salaire, Profit', 'Travail | Travail, Salaire, Profit\n\nhttps://www.youtube.com/watch?v=Dpzv8H16R-Q', NULL, 1, 138, 1, 7, 1, 1, NULL, '2024-05-13 10:07:29', '2024-05-13 21:09:41', NULL);
INSERT INTO `ressources` (`id_ressource`, `label`, `description`, `content`, `is_public`, `view_count`, `id_user`, `id_category`, `id_status`, `id_type`, `file`, `created_at`, `updated_at`, `staff_comment`) VALUES
(3, 'Le rire au travail et l’éthique', 'Introduction\n\n\n1 Dans cet article, nous souhaitons apporter des éléments de réponse à la question du rire\ndans les situations professionnelles. Notre objectif est d’orienter les travaux de recherche\nportant plus globalement sur l’éthique au travail, mais aussi de fournir des repères pour le\ndéveloppement des pratiques de management. Si le rire comme expression émotionnelle\nspontanée de joie semble de prime abord échapper à toute tentative de management, c’est\njustement cette attribution communément positive et, de plus, associée à une liberté\ninaliénable du sujet qui ressort de notre étude comme contribuant en partie aux problèmes\nqu’il soulève. En effet, le rire désigne un comportement individuel ou collectif qui n’émerge\net ne trouve son sens que dans un contexte d’échanges sociaux. Située dans le champ de la\ngestion des ressources humaines, cette étude se limite aux situations professionnelles\nd’interactions directes entre des personnes au travail. La complexité de la problématique du\nrire s’en trouve réduite puisque nous écartons les phénomènes de foule, les tabous sociétaux,\nle rapport au sacré ou encore l’exercice des contre-pouvoirs dans nos démocraties modernes.\n\n\n2 Le point de départ des travaux présentés est le constat dans le cadre d’une recherche plus\nlarge menée par recherche-action sur le rôle du tiers avec la posture de coach, que plusieurs\nsalariés, demandeurs d’une aide ponctuelle pour résoudre un problème ou sortir d’une\nsituation qu’ils ressentaient comme insupportable, évoquaient “le rire”, celui des autres ou le\nleur propre, soit comme une source de mal-être, soit comme un mode de résistance ou de\ndéfense de soi. Nous nous sommes alors appuyés sur sept cas sélectionnés car ils s’avéraient\nen rapport direct avec le sujet et l’analyse de contenu des 42 entretiens individuels ainsi\nréalisés pour proposer une grille d’intelligibilité du phénomène plaçant le rire au travail au\ncœur d’une problématique managériale d’ordre éthique.\n\n\n3 Pour cela, nous avons dans un premier temps effectué une revue de littérature en\nl’élargissant à la philosophie morale, pour dans une seconde partie procéder à l’analyse de nos\nmatériaux recueillis empiriquement. Nous avions en effet à traiter du rire d’une part en ce\nqu’il émerge au sein d’une situation professionnelle qu’il transforme, et de l’éthique abordée\ncomme un processus de questionnement de la morale (Ricœur, 2010). Ces deux notions\nsemblaient relever d’obligations s’imposant au sujet pour des raisons obscures et “au-delà” de\nlui de par sa nature humaine ou d’un impératif supérieur. La question centrale de notre étude\nest ainsi : le rire au travail est-il mal ? Et si oui, comment le réguler ? D’emblée, nous\npouvons préciser que le rire ne peut être considéré comme mal en soi et que par suite, notre\nquestionnement doit trouver une formulation plus appropriée. C’est déjà rentrer dans cette\nréflexion éthique chère aux philosophes et à laquelle ne peut échapper ni le chercheur en\ngestion soucieux d’apporter des réponses à la question du bon ou du mal-rire au travail, ni le\nmanager incapable de savoir quand et comment le réguler. Ainsi, les demandeurs d’aide de\nl’étude, tous cadres d’entreprise et tous, pour des raisons différentes, subissant concrètement\nune situation, où deux obligations, celle du rire et celle de la morale, se trouvaient en\nopposition, faisaient appel à un tiers pour en sortir.\n\n\n4 Comment dès lors identifier et traiter de ce qui rentre en tension pour les individus ou les\ncollectifs et qui semble relever moins d’un jugement que du sentiment moral ? S’agit-il, pour\nreprendre une grille d’analyse tirée de la psychologie sociale (Moscovici, 1984, p.9), d’un\nconflit dans le rapport à un objet, pour nous le travail, entre un sujet individuel en quête\nd’authenticité et d’affirmation, et un sujet social en quête de conformité et d’intégration ? Le\nrire se situant dans le champ des expressions spontanées d’un ressenti, peut-on solliciter la\nnotion de “dissonance émotionnelle”, déjà développée en appui sur les travaux de Leon\nFestinger (1957) dans le domaine du management (Van Hoorebeke, 2003) ?\nL’approfondissement dans cette voie au regard de notre problématique considérerait comme\nun double postulat initial que premièrement, pour prévenir les éventuelles divergences entre\nrire et morale, les sujets doivent au préalable accéder à la connaissance de l’un comme de\nl’autre, et deuxièmement, qu’ils arriveront par suite à un contrôle individuel et social des\nphénomènes du rire. Ce serait supposer que les définitions préexistent à la manifestation du\nrire, posées définitivement comme des vérités préalables et confondre “éthique” avec discours\nnormatif et pression de conformité. Or, le propre du rire est qu’il ne s’explique pas : il arrive\net surprend le rieur. Or, le propre du mal-rire est que s’il est désigné comme une vérité, c’est\ndans une approche par la manifestation consistant « à laisser-être ce qui se montre »\n(Thomasset, 1996, p.253).\n\n\n5 Nous souhaitons emprunter ce chemin de questionnement et de réflexion pour poser puis\ntenter de résoudre la problématique de cette étude. Partant de ce mal-rire présent dans les\ndiscours de plainte sur le travail, notre objectif est de nous tourner du côté des pratiques de\nmanagement au sein des organisations pour identifier en quoi elles en favorisent ou non\nl’émergence. L’objet de notre étude délimitant par ailleurs le champ de sa problématique est\ndonc le vécu d’un rire désigné comme “mal” par au moins un des acteurs de la situation, soit\ndans l’instant, soit après-coup. Nous avons ensuite questionné ce mal-rire désigné au regard\nde la littérature et par la mise en évidence et la discussion de trois puis quatre indicateurs nous\nconcluons sur les pratiques de régulation.\n\n\n\n1 – Des bienfaits du rire au travail à la problématique de sa nécessaire régulation\n\n6 Le questionnement sous-tendu par la tension entre rire et morale pourrait nous renvoyer à\nl’un des débats philosophiques toujours ouvert (Darwall, 1995), opposant notamment le comte\nde Shaftesbury (1715) [1][1]« On peut objecter que ces affections, toutes dénaturées…, qui\ndans la lignée des stoïciens, en appelait à un gouvernement de soi mais hors de toute loi\nexterne, hors de toute sanction, par satisfaction de l’action bonne, à Emmanuel Kant pour qui\nl’autodétermination est un exercice de la volonté individuelle pour appliquer la loi morale.\nMalgré tout, l’un comme l’autre se tournent vers le sujet avec implicitement l’injonction de ne\npas “mal-rire”. Sous cet angle, le management ne saurait être concerne?, puisqu’il ne s’agirait\nque d’une moralité proche de la discipline personnelle et hors du champ des compétences\nprofessionnelles. Le problème est tout autre si l’on aborde la question de l’interdiction du rire\nconsidéré comme un comportement professionnel inapproprié ou producteur de mal-être au\ntravail. Ainsi, l’interrogation, qui sous-tend cette étude est bien : « faut-il réguler le rire au\ntravail ? » avec pour corollaires : « comment sait-on qu’une régulation est nécessaire ? » et\n« si c’est nécessaire, comment procéder ? ». Pour répondre à ces questions, nous avons\nprocédé à une revue de littérature notamment dans le domaine de la philosophie morale.\n\n\n1.1 – Le rire comme problème d’ordre éthique entre droit naturel et contrôle social\n\n\n7 Sans considérer avec Jacques Abadie (2003, p.267) que « les hommes pensent que leur rire\nest toujours innocent, et pourtant il est toujours criminel et condamnable » car il émerge au\ndétriment d’un autre, la croyance opposée et socialement partagée que « les rieurs sont\ntoujours du bon côté [2][2]Nous indiquons les « extraits de discours » entre guillemets en… »\nen devient une arme puissante de domination. Pour Robert Solomon (1998), les émotions ne\n« font pas juste de nous arriver », et nous les utilisons pour affronter les autres. Sous cet\nangle, les personnes utilisent leurs émotions pour agir en leur faveur en mettant en œuvre ce\nqui peut être désigné comme une “stratégie du rire”. Si une conception d’un rire\nexclusivement “sous contrôle” est rapidement démentie empiriquement, ne serait-ce que par\nnotre propre expérience, quand le rire “éclate”, il est certes hors de la volonté du sujet, mais il\ns’inscrit dans un contexte social et même dans une situation directement vécue. Ainsi, le rire\nressort comme la résultante d’une forme d’obligation, qui rejoint celle du sens moral de\nFrancis Hutcheson (1993) dans la mesure où elle « n’est pas la contrainte d’une loi\nextérieure ; mais [où Hutcheson] n’a pas pour autant conçu cette obligation comme une\nobligation intérieure » (Jaffro, 2000, p.45). « Rire nerveux », « fou-rire », les rieurs\ns’exclameront : « c’est plus fort que moi ! ».\n\n\n8 Mais que faire ? Interdire de rire dans les organisations ? Bien évidemment même la\nquestion est absurde pour trois raisons, dont deux au moins semblent évidentes. D’une part, le\nrire est une expression émotionnelle généralement spontanée, échappant à la volonté des\npersonnes, voire à leur conscience. L’exiger [3][3]Le point souligné ressort comme encore plus\névident si on… ou l’interdire par une loi ou une règle en ressort comme contraire à l’éthique\ndans la mesure où, elle placerait les sujets dans une situation où il est impossible de bien se\nconduire, puisque quoi qu’ils fassent, aucun être humain n’a la capacité de s’y\nconformer [4][4]Nous nous démarquons ici des stoïciens qui avec Cicéron…. On retrouve la\nnotion “d’injonction paradoxale”, consistant à exiger un comportement « qui ne peut surgir\nque spontanément et non sur commande » (Watzlawick, 1980, p.106) et source de détresse\nchez les individus qui y sont soumis. Un autre courant théorique traitant des “obscurs\nressorts” du rire incontrôlé en introduisant la notion “d’inconscient” nous permet de souligner\nl’aberration de l’interdiction du rire, celui de la psychanalyse freudienne. Considérant que\n« Le sur-moi-de-la-culture a produit ses idéaux et élevé ses exigences ? Parmi ces dernières,\ncelles qui concernent les relations des hommes entre eux sont regroupées en tant\nqu’éthique », Sigmund Freud (1929, p.85-86) va s’interroger sur la possibilité « d’écarter le\nplus grand obstacle à la culture » qu’il ramène à deux pulsions humaines en conflit, celle de\nl’agression ou de l’auto-anéantissement et celle de la vie (Eros), tout en expliquant que leur\nrefoulement ou leur négation ne peut que conduire à leur surgissement inconscient et\nsocialement inapproprié, voir destructeur de soi ou d’autrui.\n \n\n9 Si le propos de Freud représente un modèle du constat contre-intuitif d’un développement\nconjoint de la violence et de la culture, il conforte la pertinence de notre premier argument.\n\n\n10 Une deuxième raison est que le recours formel à la coercition soulèverait des objections\nmorales bien plus importantes au point qu’on ne peut imaginer la stipulation dans un\nrèglement intérieur ou le code du travail qu’il est formellement interdit de rire dans les\nsituations professionnelles [5][5]Par contre, plusieurs cas de « fou-rire » ont été relevés…. En\neffet, d’un côté, cela atteindrait la liberté de critiquer, ce que le comte de Shaftesbury (1710,\np.1) condamnait dès le XVIIIe\nsiècle, tout en en questionnant les soubassements et les dérives\npotentielles : « Mais qui sera le juge de ce que la censure peut examiner librement, ou de ce\nqu’elle doit souffrir impunément ? Qui décidera des circonstances où la liberté peut agir sans\nscrupule, ou se taire ? ». Resituée dans le contexte actuel d’une entreprise, cela déposséderait\nles salariés de l’un de leurs modes d’expression fondamental, celui des émotions, dont l’usage\nserait défini hors d’eux-mêmes. Cela reviendrait à une forme de déshumanisation du\npersonnel, dont il n’est plus nécessaire aujourd’hui, de rappeler les multiples critiques non\nseulement d’ordre éthique, mais aussi associées au constat qu’un tel mode de gouvernance\nréifiant les forces de travail est contre-productif et dessert les intérêts économiques de\nl’organisation. D’un autre côté, la loi se tromperait là encore d’objet, car ou bien le rire est\n“bon” et l’interdire est injustifiable ou bien il est “mal”, et n’est-ce pas dès lors la dynamique\nmême du mal-rire qui est à bannir ? Si l’on considère que les ressorts du rire sont mauvais,\ncomme le soulignait en 1720 Gottfried Wilhelm Leibniz (1720, p.3) dans ce qu’il présentait\ncomme une réponse à Shaftesbury et qui ici nous semble se situer dans une logique\ncomplémentaire : « Je ne vois pas aussi que le ris, c’est-à-dire quelque chose qui tient du\nmépris et abaisse l’idée de l’objet, soit une pierre de touche qui serve à reconnaître la vérité.\nMépriser ce qu’on ne connaît pas encore est une prévention dont il faut se défaire ». Sous cet\nangle, et en poussant le raisonnement, la crainte du rire serait une peur des puissants que\ncelui-ci ne puisse révéler une vérité : au final, la censure serait l’indicateur de mensonges que\nles personnes ries chercheraient à protéger. Sans rentrer dans le débat, Shaftesbury comme\nLeibniz, nous ramène à la même interrogation : si une interdiction ou des sanctions sont à\nposer par une règle ou une loi, ne doivent-elles pas porter sur ce qui conduit à un mal-rire ?\n\n\n11 La troisième raison de l’inimaginable interdiction du rire est reliée aux deux autres mais\ntout en rappelant l’existence des vertus du “bon rire” qui permet de supporter sa condition\nhumaine et les épreuves de la vie, voire de préserver sa dignité. Malgré tout, la problématique\ndu rire au travail va bien au-delà d’un tri entre le bon et le mauvais rire. Nous pouvons\nretrouver à la fois la figure maléfique du pervers qui rit du malheur d’autrui, le surgissement\nd’une émotion échappant au contrôle du sujet, et qui par contrecoup le dessert ou que luimême trouve inapproprié, et en dernier une situation ou? le rire est la seule issue permettant à\nla personne d’exister dans un contexte d’aliénation. Le rire se manifeste mais rien n’est\n“risible” en soi. Cette expression émotionnelle spécifique ne donne que peu d’informations\nsur son objet ou sur ce que nous pourrions tenter de cerner en définissant la catégorie du\n“risible”. Par contre il désigne un contexte ou renseigne sur la nature du rieur, et soit dans\nl’un, soit dans le second, ou encore dans les deux, quelque chose de mauvais se joue, qu’il\nrévèle. Au final, aucuns des rieurs concernés - harceleurs, manipulée ou exclu - ne se trouvent\ndu bon côté. Il en ressort que la question posée n’est pas celle du “comique”, celui-ci\nd’ailleurs ne suscitant pas forcément un éclat de rire, mais celle de la dynamique du rire au\ntravail, qui semble associée à trois notions principales elles-mêmes inter-reliées [6][6]Cette\ninterrelation entre pouvoir, vérité et existence se…, celles du “pouvoir”, de “la vérité”, et de\n“l’existence”, avec une fonction restant à identifier et à questionner de régulateur et/ou\nd’indicateur.\n\n1.2 – Le rire au travail, un régulateur éthique ?\n\n\n12 Abordé comme régulateur, le rire peut tout d’abord être considéré comme une pratique\nsociale présupposant un déclencheur du rire et au moins un rieur. Il s’agit a minima d’une\ninteraction entre un sujet et son environnement social. Si le débat semble ouvert entre les\nphilosophes sur la possibilité de rire de soi, de rire seul ou si un tiers est nécessaire [7][7]Pour\nFreud S. (1905, p. 262-263), « Nul ne peut se satisfaire…, nous n’aborderons cette question\nqu’indirectement en nous focalisant sur les théories nous permettant d’éclairer l’éventuelle\nfonction d’indicateur ou de régulateur éthique du rire en situations professionnelles. Dans les\norganisations, comme le soulignait Ignasi Marti en 2009 (p.128) : « La vision traditionnelle\nde la résistance est une vision connotée d’opposition, voire d’agressivité ». Si l’apport des\nformes d’action sans violence est souligné par l’auteur, tout comme l’impact de la\ndéstabilisation, le recours à l’humour ou à l’ironie n’est pas évoqué.\n\n\n13 Par ailleurs, plusieurs travaux en sciences de gestion abordent le management en\nsoulignant le rôle d’une notion, “l’intelligence émotionnelle”, pour l’efficacité des leaders et\nleur capacité à influencer les individus et les groupes pour atteindre leurs objectifs (Kotzé et\nVenter, 2011). Le rire peut en ressortir comme une aptitude à extérioriser des émotions\n« positives » permettant de mieux faire face au stress et d’entretenir une vision optimiste de\nl’avenir favorable à la réalisation mais aussi à la mobilisation au travail. Le processus est\nsouvent identifié comme relevant de ce qui est désigné comme un processus de\n« contagion émotionnelle » (Barsade, 2002) favorisant, lorsque les émotions sont “positives”,\nla coopération et la performance individuelle et collective. Le rire est presque\nsystématiquement ramené à une expression de joie, cette dernière étant catégorisée dans le\ngroupe de ces émotions “positives”. Notre approche est bien différente dans la mesure où\nd’une part même si cette attribution est communément admise depuis Darwin [8][8]Darwin\nC.R. (1872) reste toutefois prudent, puisqu’il considère…, nous nous limiterons à considérer\nprudemment que le rire correspond à l’extériorisation d’une décharge émotionnelle et que\nd’autre part, tout en restant toutefois “binaire” puisque nous opposons le “bien” et le “mal”, le\nqualificatif de “positif” nous semble inapproprié pour le “mal-rire”. Cette affirmation trouve\nun étayage empirique dans l’un des cas de coaching ayant initié la réflexion présentée dans cet\narticle. En dehors de plusieurs situations où les coachés interprétaient mal la nature de leurs\némotions par conformité sociale et en éprouvaient un mal-être à l’origine de leur demande,\nnotamment du fait du caractère “sexué” des émotions (Braconnier, 2000), Or de nombreux\ntravaux ont montré que le processus de changement dans les situations de travail présente de\nfortes similitudes avec celui du deuil (Kets de Vries et Miller, 1985), dont la psychiatre\nElisabeth Kubler-Ross (1989) a conceptualisé les étapes : allant du déni de la réalité qui\nheurte le sujet, à l’acceptation, en passant par la révolte et le marchandage. Au niveau affectif,\nles personnes doivent « s’arracher pour se détacher » de leur état antérieur, ce qui\ns’accompagne de différents ressentis émotionnels, dont les deux principaux sont la colère puis\nla peine, deux émotions désignées comme “négatives”. Il en ressort que ce n’est pas le rire ou\nl’expression d’émotions positives qui représente en soi un mode de régulation mais la\nrégulation des émotions ressenties en autorisant et canalisant leur expression d’une façon\nsocialement acceptable. Ainsi, dans la lignée des études déjà menées, définissant comme\ncompétence du leader, celle de « régulateur des états émotionnels » de son équipe (Haag et\nLaroche, 2009), plus que d’orienter le groupe vers un type d’émotions, ne peut-on pas faire la\nproposition qu’il s’agirait plutôt de lui permettre une expression moralement acceptable d’un\nressenti par nature échappant au contrôle ? Ce cas confirme également d’autres résultats de\nrecherche soulignant l’importance pour les décideurs d’écouter leurs émotions pour bien\norienter leur jugement (Coger, Haag et Bonnefous, 2009).\n\n\n\n1.3 – Quels indicateurs du mal-rire au travail ?\n\n\n14 Notre analyse nous conduit également à questionner le caractère moralement acceptable de\nla moquerie, en ce qu’elle définit un rire dont l’objet est autrui, et par suite à nous interroger\nsur les indicateurs du mal-rire. En effet, lorsqu’elle se tourne vers autrui, qui d’objet du rire se\nretrouve placée en position de victime, la moquerie est aujourd’hui considérée comme\nillégitime et condamnable depuis la loi de 2002 contre le harcèlement moral au\ntravail [9][9]Loi n° 2002-73 du 17 janvier 2002 de modernisation sociale,…. Dans ces\nsituations, le “mal-rire” est évident, tout autant que la violence subie, tant depuis Nietzsche,\nl’on sait que : « Ce n’est pas par la colère, c’est par le rire que l’on tue » (Kessler, 2005,\np.507). Par contre, dans d’autres contextes une “gentille moquerie” peut « détendre\nl’atmosphère » et susciter le rire de l’intéressé(e), se considérant lui-même/elle-même comme\n“taquiné(e) avec bienveillance”. Ainsi, ce n’est pas la moquerie qui en ressort comme\nl’indicateur systématique du “mal-rire”, mais la volonté de son “bon usage”. Emmanuel\nJaffelin (2010, p.106) propose ainsi entre autres définitions de la gentillesse, celle de\n« l’expression de notre bon vouloir, qui est aussi vouloir du bien ». Nous retrouvons ici le\n“bon usage des passions” de René Descartes (1649, p.227 à 230) qui s’opère non par\ndomination de la raison mais par la volonté « résolue » d’un sujet « averti de l’emportement »\nque peut être une passion, et du « rempart que constitue sa fermeté ? d’âme ou sa\nrésolution », la générosité se définissant pour Descartes par l’estime de soi-même, considérée\ncomme une vertu, et non par l’altruisme ou l’oubli de soi. Malgré tout, et sans rentrer dans les\nressorts de ce bon usage des passions, il nous semblerait hasardeux de tenter de différencier\nles “méchantes” des “gentilles” moqueries en prenant comme critère la volonté du moqueur\nde blesser le moqué ou son incompétence à exercer son « libre arbitre avec justesse ». En\ndehors de la difficulté à “mesurer” l’intention de sujets qui dans bien des cas n’en ont pas une\nconscience claire, l’effet destructeur est tout aussi puissant quand les harceleurs s’exclament\n« mais c’est pas méchant ! » que lorsqu’ils avouent leur désir de faire souffrir. Ce serait plutôt\ntrois autres notions qui feraient la différence et qui définissent nos propositions de recherche\nsur les indicateurs du mal-rire au travail et dont nous avons étayé le bien-fondé\nempiriquement dans une deuxième partie : la “réciprocité”, “l’unanimité”, et la “persistance”.\n\n\n15 Il semble que la “réciprocité” ait deux dimensions. En effet, elle vise à indiquer que les\nrieurs sont à la fois moqueurs et moqués mais aussi que la situation est elle-même un\ndéclencheur du rire. Nous entendons par le deuxième indicateur, “l’unanimité”, non pas que la\nmoquerie fasse rire “tout le monde”, mais que le rire soit partagé par les trois groupes de\nprotagonistes directement concernés : moqueur, moqué mais aussi témoin. Pour ce dernier,\nplusieurs travaux soulignent que les spectateurs peuvent être affligés par l’expérience subie\nd’un “mal-rire” et en éprouver un malaise profond (Houba, 2007). À ce stade, il nous semble\nque deux conceptions opposées du rire et de son rapport à la régulation sociale peuvent être\nrelevées. Pour l’une, « Le rire est une expérience subversive […] Le rire est une arme de\nlibération massive contre les oppresseurs, un outil pour résister aux forces\nd’anéantissement » (Birnbaum, 2011, p.9), quand pour l’autre, le rire va être considéré avec\nHenri Bergson (1940) comme une « sanction sociale symbolique » permettant à la société\nd’exercer un contrôle et de se prémunir des sujets la menaçant. Si dans les deux cas,\nl’intelligence ou la clairvoyance est postulée du côté des rieurs et des moqueurs, pour le\npremier, elle s’inscrit dans une dynamique de refus de se soumettre à ce qui domine, alors que\ndans le second, elle exerce une pression de conformité sociale. Replacée dans le monde du\ntravail, chacune des approches peut trouver des objections remettant en question leur bienfondé et leur possible orientation des pratiques. En effet, de nombreux cas, comme par\nexemple ceux portant sur la discrimination au travail, mettent en évidence que résister peut\naussi consister à ne pas rire d’un bouc-émissaire au milieu d’un groupe hilare, ou affirmer son\nopposition à la ridiculisation de l’autre. Par ailleurs, le phénomène conduisant les collectifs à\nune euphorie groupale associée à un sentiment de surpuissance illusoire et une perte du sens\ndes réalités, a été largement étudié [10][10]Le premier à avoir affirme? que « l’individu en\nfoule diffère…. Non seulement les résultats sur les équipes professionnelles contredisent le\npostulat de clairvoyance des rieurs, mais ils conduisent au constat que les groupes alors\ndésignés comme fusionnels (Anzieu et Martin, 1982) finissent toujours par éclater : ce type de\nrire ne préserve la cohésion sociale que de façon précaire et artificielle. Le mouvement de\nretour à la réalité est aussi une prise de conscience individuelle que le collectif peut conduire à\nadopter un comportement que chaque membre condamne après-coup et considère comme\nirresponsable. Ainsi, désigner un autre comme une victime expiatoire ou un objet légitime de\nmoqueries est une ignorance de sa valeur d’homme et place dans une posture illusoire de\nsupériorité. Nous avons d’ailleurs relevé que Bergson (1932, p.90) affirme dans un ouvrage\nantérieur que « si sévèrement que nous affections de juger les autres hommes, nous les\ncroyons, au fond, meilleurs que nous. Sur cette heureuse illusion repose une bonne partie de\nla vie sociale ». Nous retrouvons ici une définition du troisième indicateur proposé : la\n“persistance”. Il répond à la question : le rieur considère-t-il après-coup qu’il a “mal-ri” ? La\nrégulation en ressort également comme un processus inachevable, toujours en cours et à\nmener.\n\n\n\n2 – Etayage empirique de l’existence du mal-rire au travail et de ses indicateurs\n\n\n16 Dans cette partie, après avoir explicité la méthodologie de la recherche, nous présentons les\nrésultats de sept études de cas d’accompagnement de responsables confrontés à des difficultés\nde management et demandeurs d’aide auprès d’un tiers complétés par l’analyse de contenu\ndes entretiens individuels menés, enregistrés et retranscrits dans le cadre de cette rechercheaction. Celle-ci s’inscrivait dans un projet visant plus globalement à explorer le rôle du tiers\ndans le changement des comportements professionnels et la résolution des problèmes de\nmanagement. L’étude présentée dans cet article a pour objectif de conforter l’existence de\nsituations de rire producteur de mal-être et d’étayer nos propositions de recherche sur les\nindicateurs de ce mal-rire au travail afin d’orienter les pratiques de régulation.\n\n\n2.1 – Méthodologie de l’étude : quand le rire conduit à une demande d’aide\n\n\n17 D’un point de vue épistémologique, nous nous situons dans un paradigme interprétativiste.\nEn effet, si notre recherche est de type exploratoire, il ne s’agit pas de faire abstraction des\ncadres théoriques existants mais d’identifier les théories pertinentes, de s’y appuyer pour les\nconfronter et investiguer la réalité, avec l’adoption d’une posture réflexive avec le terrain\n(Jodelet, 2003), dans un “va-et-vient” entre observations empiriques et hypothèses\ninterprétatives permettant “d’ancrer” une théorie en cours d’élaboration (Glaser et Strauss,\n1967). La méthode de cas nous est apparue comme la plus pertinente pour étudier les\nsituations du rire dans les situations de travail. Selon Miles et Huberman (1991), elle permet\nde développer les conceptualisations à partir de descriptions approfondies des phénomènes. Il\ns’agit d’appréhender l’impact d’un comportement humain dans une complexité, dont nous\nsouhaitons saisir toutes les dimensions, ce que l’étude de cas favorise (Giroux et Tremblay,\n2002). Enfin, le caractère éthique ou non est une préoccupation organisationnelle\ncontemporaine, et l’étude de cas, comme le souligne Yin (1994), est par définition une\ndémarche de recherche qui traite des phénomènes en prise directe avec les contextes dans\nlesquels ils émergent. La méthode utilisée est celle de la recherche-action (Koenig, 1993) avec\ncomme objectif en cohérence avec notre posture interprétativiste de nous appuyer sur un cadre\nthéorique issu de la littérature afin de faire émerger une grille d’intelligibilité du mal-rire au\ntravail, tout en co-élaborant avec les acteurs (les coachés) des construits opératoires.\n\n\n18 L’étude a été menée de 2006 à 2008. Elle a consisté à accompagner individuellement des\ndemandeurs d’aide dans une série de dix entretiens au maximum d’environ 60 minutes chacun\net enregistrés avec l’accord des intéressés. Seul un cas s’est concrétisé par dix entretiens. Pour\nles six autres cas, le coaché a considéré qu’il n’avait plus besoin d’accompagnement avant la\nfin des dix séances qui lui étaient ouvertes car son problème était résolu et qu’il pouvait faire\nface sans aide à ses situations professionnelles aussi difficiles soient-elles. Renforcer\nl’autonomie du coaché et la confiance en ses propres ressources est l’une des caractéristiques\nmajeures de la démarche d’accompagnement servant d’appui à la recherche-action. Les sept\ncas de l’étude présentée sont extraits d’un corpus de 34 cas et a abouti à l’analyse de 42\nentretiens. Sans que leur demande d’accompagnement concerne initialement directement le\nrire, les coachés ont été choisis car ils avaient évoqué la question du rire en termes éthiques et\ncela a émergé de l’échange comme définissant en totalité ou en partie ce qui leur posait\nproblème. La population de l’étude est composée de quatre femmes et de trois hommes, de 26\nà 54 ans et occupant des postes de responsable dans différents secteurs d’activités avec le statut\nde cadre.\n\n\nTableau 1\nLes sept cas de l’étude\n19En plus de l’analyse de cas proprement dite effectuée en confrontant nos notes prises avec\nla posture de chercheur-coach et l’évolution du discours des coachés au fil des séances, nous\navons procédé à une analyse de contenu des entretiens par strates de relecture manuelle et\n\nrépartition des extraits de discours dans les catégories issues d’une part de la revue de la\nlittérature (1\nère phase avec deux séries de relecture) puis d’autre part de l’analyse de contenu\nproprement dite (2\ne\nphase avec trois strates de relecture : approfondissement des contenus\nclassés avec émergence de nouvelles dimensions ; émergence d’un 4\ne\nindicateur du mal-rire ;\nrepérage des contenus d’étayage et de définition du 4\ne\nindicateur). La 1\nère phase d’analyse\ns’est appuyée sur les critères classant des discours tirés de la revue de la littérature : mal-être\ndu sujet ri, mal-être du sujet rieur et les trois indicateurs du mal-rire. Son apport a été\nd’approfondir le cadre théorique initial, que la 2\ne\nphase a permis de compléter essentiellement\npar le repérage d’une 4\ne\ncaractéristique.\n2.2 – Résultats : Le bon et le mauvais rire\ncoexistent au travail\n20La situation des quatre premiers cas permet d’illustrer les différentes dynamiques du rire au\ntravail et leur rapport à l’éthique. Les trois cas suivants nous ont permis de conforter nos\npropositions de recherche sur les trois indicateurs du mal rire. Nous les avons étayées par une\nanalyse de contenu des 42 entretiens retranscrits des sept cas de l’étude.\n2.2.1 – Les dynamiques du rire et leur\nrapport à l’éthique\n21Pour confirmer l’existence du mal-rire au travail et en proposer une grille d’intelligibilité,\nnous pourrions citer la déclaration de cette femme cadre de 48 ans en congé maladie pour\ndépression du cas n°1, qui confiait : « Au début, je suis restée de marbre mais à force ça\natteint. Stupidement ce sont les blagues sur mon poids qui m’ont usée. C’était juste…\nméchant ? ». Nos résultats font ressortir que le mal-être généré par le vécu du rire peut être\nressenti non seulement par le sujet-ri que par le sujet-rieur. Ainsi dans le cas n°2, une femme\nde 27 ans nouvellement embauchée dans un service marketing, se « sentait mal » de se\nretrouver à rire dans un groupe ayant pris l’habitude avant son arrivée de « taquiner » un\nstagiaire handicapé qui présentait de « légères difficultés d’élocution ». L’intérêt du poste et\n« la chance d’avoir décroché un job… formateur,… le salaire,… bien quoi ! » ne l’ont pas\nempêché de changer d’emploi au plus vite. Cela confirme que le “côté des rieurs” est loin\nd’être désigné systématiquement comme “le bon” même par l’inconfort qu’il procure. Une\ninterrogation d’ordre éthique est bien posée sur le rire au travail, non comme un jeu abstrait\nvisant principalement à distraire les philosophes, mais comme un facteur de souffrance en\nsituation professionnelle à aborder comme tel pour mettre en œuvre les politiques de\nprévention appelées de leurs vœux par les responsables d’entreprises et les syndicats. Nos\nrésultats ont également fait ressortir les bienfaits potentiels du rire. Ainsi dans le cas n°3, un\nresponsable de production de 54 ans qui nous avait sollicité pour la « redéfinition de [son]\nprojet professionnel » s’est exclamé lors du premier entretien : « Si y’a une chose qu’on ne\npeut pas m’empêcher, c’est de me marrer… c’est la seule chose… quand l’autre avec sa\ncravate m’a dit que c’était mon tour… éjecté… vous rigolez !… la veille j’ai fini à… je sais\npas… neuf heures… et le matin j’étais là pour leur réunion et ensuite… l’un après l’autre…\ndans son bureau… allez : j’étais dans le lot… dehors !… j’ai rien dit… je l’ai regardé en me\nmarrant… pas question de s’écrouler… et moi ça va… ».\n\n22Dans ces trois premiers cas nous retrouvons à la fois la figure maléfique du pervers qui rit\ndu malheur d’autrui, le surgissement d’une émotion échappant au contrôle du sujet, et qui par\ncontrecoup le dessert ou que lui-même trouve inapproprié, et en dernier une situation où le\nrire est la seule issue permettant à la personne d’exister dans un contexte d’aliénation. Le rire\nse manifeste mais rien n’est « risible » en soi. Le cas n°4 d’un manager de 38 ans, responsable\nd’une équipe chargée d’un projet dans le domaine de la haute technologie, que la direction lui\navait demandé d’abandonner en pleine réalisation pour se consacrer à un autre, nous permet\nde préciser cette dynamique du rire et ses limites. Convaincu que son rôle était de « maintenir\nle moral des troupes », il mettait son « point d’honneur à faire bonne figure », ce qui se\ntraduisait par ce qu’il désignait comme sa « nature à blaguer tout le temps ». Or, ni lui, ni son\ngroupe - « pourtant, on est des pros ! » - n’arrivaient à s’investir sur le nouveau dossier et\ncontinuaient à évoquer le précédent. Au cours du deuxième entretien, le manager a exprimé ce\nqu’il a défini ensuite comme sa “colère rentrée”. Il en est arrivé à la conclusion que ses\ncollègues devaient aussi « lâcher leur venin » pour pouvoir « se remettre au travail ». Ce qu’il\nfit, déclarant à la troisième et dernière séance : « Je leur ai dit : je sais pas vous mais moi je\nsuis furieux ; alors je vous propose d’en parler mais interdiction d’injurier ou de crier et\nchacun son tour et uniquement si vous avez envie… et alors, c’est parti !… je crois que c’est\nréglé… ils m’ont même dit : tu nous saoulais, parce qu’on voyait bien que c’était faux, ça\ngrinçait ! ».\n23L’analyse du contenu des 42 entretiens a permis de conforter cette notion de mal-rire interreliée à celles d’un double mal-être en miroir : le mal-être du sujet ri et le mal-être du sujetrieur (voir tableau 2).\nTableau 2\nLe mal-rire comme générateur de mal-être\n\n2.2.2 – Les indicateurs du mal-rire\n24Nous avons pu sélectionner trois cas permettant de conforter et préciser les trois indicateurs\ndu mal-rire issus de la revue de littérature, tout en confirmant la pertinence de la transposition\nd’un cadre théorique issu d’une revue de la littérature essentiellement philosophique.\nConcernant la “réciprocité”, nous retrouvons cette notion lorsque les sujets abordent la\ncompétition dans les relations professionnelles. Celle-ci comme pour les équipes de\ncommerciaux par exemple, peut être stimulante et prendre la définition donnée dans le sport.\nNous avons relevé dans les propos de l’une d’entre elles représentant notre cas n°5, cadre de\n47 ans, responsable d’une équipe de vente, qu’elle pouvait s’accompagner d’échanges\nverbaux utilisant une moquerie qu’elle qualifiait de « bonne guerre ». Notre coachée nous les\nindiquait pour expliciter son tempérament de « gagnante », ses compétences assertives et sa\npugnacité. Il en ressortait que si les moqueries étaient interprétées comme un échange\nconfraternel et respectueux, c’est qu’elle en « recevait tout autant ; ça me booste ! ». C’est\nd’ailleurs ce qui nous semble pouvoir réguler les formes autodestructrices d’autodérision,\ncomme pour le cas n°6 un malade du sida de 46 ans qui a arrêté de s’exclamer en riant lorsque\ndes échéanciers étaient en cours d’élaboration : « vous me raconterez, si je suis au\ncimetière ! ». La notion “d’unanimité” renvoie par suite à une nécessaire forme individuelle\nd’autorégulation du rire dans une même volonté de respect mutuel de soi et des autres. Enfin,\ndans le cas n°7, une femme de 26 ans, chef de travaux dans le bâtiment souhaitait « changer\nde secteur d’activité » car nous disait-elle dans le cadre de son coaching : « j’en peux plus de\nleur douce rigolade vulgaire d’obsédés par leur pénis ». Après plusieurs séances, et\nconsidérant qu’elle n’avait « rien à perdre d’essayer », elle a décidé de « leur dire » et s’y est\npréparée. Elle fut surprise de constater que plusieurs de ses collègues masculins également\npris à témoins des plaisanteries, appuyaient sa demande. Les rieurs furent priés de réserver\nl’usage de leur humour à une sphère non professionnelle d’amis susceptibles de l’apprécier.\n25L’analyse de contenu de nos 42 entretiens, nous a permis non seulement de retrouver dans\nles situations de travail les trois indicateurs au fil des discours des sujets de l’étude, mais d’en\nidentifier un quatrième que nous avons désigné par les termes de “plein accord préalable”. En\neffet, nous avons relevé la distinction faite entre le rire subi ou même consenti et le rire\napprouve?. Si les deux peuvent conduire le sujet-ri à « rire avec les rieurs » pour éviter de\nperdre la face, seul le second semble être une « sortie sans casse » pour la personne. Ainsi\npour Goffman (1974, p.39), « on peut [donc] considérer une relation sociale comme étant une\nsituation où une personne est particulièrement forcée de compter sur le tact et la probité\nd’autrui pour sauver la face et l’image qu’elle a d’elle-même ». Nous avons retrouvé cette\nsituation décrite par les sujets dans leurs entretiens, comme par exemple comme discours\ntype : « j’ai bien vu qu’il se retenait de rire… faut dire que quand je bafouille, j’y vais pas à\nmoitié… alors j’ai dit : ma chompre a trouché… et j’ai éclaté de rire… c’était marrant… on a\nbien ri et ça fait du bien ». On retrouve ici le rire, source de bien-être et permettant de\ndévelopper sa capacité de faire face aux situations critiques du monde professionnel (Mittal et\nMathur, 2011). Par contre, « rire jaune » tout en sortant meurtri de la situation d’échanges est\nrevenu dans les entretiens comme l’indicateur que « le rire n’était pas de bonne qualité ». Ne\npas rire est considéré comme une façon « d’empirer la situation », les protestations pouvant\nêtre encore plus risibles. Un discours type pourrait être « le plus douloureux est que je n’ai\nrien pu faire d’autres que faire semblant de trouver ça drôle » ou « c’était outrageant, il se\nmoquait de mon apparence ; le seul qui peut le faire c’est moi… c’est comme les blagues\njuives… c’est antisémite hein quand seuls les juifs ne rient pas ».\n\n2.3 – Discussion : vers la régulation du malrire au travail\n26Repérer en se référant aux indicateurs qu’il s’agit d’un mal-rire au travail ne suffit pas à\ndéfinir les modes de régulation. En effet, il ne faudrait pas en déduire qu’il s’agit de définir les\nnormes générales du “bon comique” au travail, mais plutôt que la nécessité s’impose d’en\nsouligner les dysfonctionnements. Nous avons ainsi montré que le poids du contexte sur\nl’évaluation de la situation, comme Hackney (2011) qui a démontré que certaines pratiques de\nmanagement pouvaient conduire à faire perdre le sens de l’humour des salariés même lorsque\nles plaisanteries ont été pré-testées comme drôles. Ce qui fait rire est non seulement\nculturellement ancré mais fait le ciment des groupes sociaux. Il est une arme de stéréotypage\net de discrimination tout autant qu’un puissant levier d’émancipation, comme en témoignent\nles travaux sur le rire des femmes (Willett et al., 2012). Gkorezis, Hatzithomas et Petridou\n(2011) soulignent ainsi que si l’utilisation de l’humour par les dirigeants est un levier puissant\nde mobilisation, son recours peut avoir des effets négatifs en fonction notamment de\nl’ancienneté des salariés. D’une part, le rôle de l’humour comme activateur de créativité ou de\nrésolution de problème a été mis en évidence, voire même pour assouplir les rigidités\norganisationnelles propres aux administrations publiques (Cates, 1979). D’autre part,\nplusieurs travaux ont souligné que les émotions positives comme l’euphorie pouvaient\nconduire à une prise de risque plus importante et inconsidérée notamment dans les décisions\nfinancières (Cavalheiro et al., 2011).\n27Nos quatre indicateurs, “réciprocité”, “unanimité”, “persistance” et “plein accord\npréalable” peuvent également ressortir comme des règles de comportement collectif à poser\npour permettre aux salariés de les intérioriser émotionnellement. Il s’agit ainsi moins de règles\nde politesse formelle que de l’apprentissage d’une forme de “civilité au travail”, en référence\nà la définition de l’incivilité par les philosophes et de leur étude de la recrudescence du\nphénomène dans nos civilisations (Habib et Raynaud, 2012 ; Bourin, 2012). Face au mal-être\nressenti par les “mal-rieurs” et de l’effet destructeur sur la personne “rie”, il s’agirait pour les\nmanagers en lien avec les travaux initiés par Sen (2004) au niveau socio-économique de créer\nles conditions d’une “vie au travail humainement digne” et une gestion des ressources\nhumaines qui intègre ce que Nussbaum (2012) désigne comme des “culpabilités” et parmi\nlesquelles se positionnent le ressenti émotionnel et la conception du bien.\nConclusion\n28Cette recherche menée en appui sur sept cas de coaching avec 42 entretiens individuels,\nnous a conduits à définir quatre indicateurs du rire au travail : la “réciprocité”, “l’unanimité”,\n“la persistance” et le “plein accord préalable” permettant d’orienter les pratiques de\nrégulation. Dans ce qu’ils présupposent comme dynamique à l’œuvre, les notions qu’ils\ndésignent sont aussi ce qui permet de ne pas limiter le rire à la moquerie. Il nous semble\nmême que le rire prend toute sa portée « d’intervention créatrice de la conscience » soulignée\npar Robert Escarpit (1960, p.94), et peut devenir une véritable force de progrès potentielle\ndans les organisations si le comique renonce à ridiculiser les personnes pour se positionner\ndans le champ de la dénonciation de et par l’absurde des systèmes ou des politiques. Hors de\nla moquerie, le rire est aussi un mode de faire face à la détresse de vivre et peut être relié à un\ncomique qui « manifeste la fragilité essentielle du sens humain, mais nous donne les moyens\nde l’exorciser » (Giribone, 2009, p. 58). Le rire des autres est dès lors potentiellement un\n\nencouragement à se distancier et même à transcender notre condition d’homme et la finitude\nde la vie. En cela, il est un vecteur de réflexivité et même de bien-être, non dans une\nrecherche exclusive de plaisir hédoniste, qui ne résiste pas au questionnement d’ordre éthique,\nmais dans une quête existentielle telle que Martin Heidegger (1927) l’a théorisée.\n29Cette première étude sur le rire au travail et l’éthique débouche enfin sur plusieurs pistes de\nrecherche et, nous semble-t-il, plus particulièrement sur un recensement des différentes\nsituations professionnelles d’émergence du rire afin de valider quantitativement nos résultats\naffirmant que c’est seulement lorsque le rire est réciproque, unanime, qu’il perdure et qu’il a\némergé dans un plein accord préalable des parties, qu’il s’inscrit dans une dynamique positive\npour les personnes comme pour les organisations.\nNotes\n• [1] « On peut objecter que ces affections, toutes dénaturées qu’elles sont, ne vont\npoint sans plaisir ; & qu’un plaisir quelque inhumain qu’il soit, est toujours un\nplaisir, fût-il place? dans la vengeance, dans la malignité & dans l’exercice même de\nla tyrannie. Cette difficulté serait sans réponse, si, comme dans les joies cruelles &\nbarbares, on ne pouvait arriver au plaisir qu’en passant par le tourment ; mais aimer\nles hommes, les traiter avec humanité, exercer la complaisance, la douceur, la\nbienveillance, & les autres affections sociales ; c’est jouir d’une satisfaction\nimmédiate à l’action & qui n’est payée d’aucune peine antérieure ; satisfaction\noriginelle & pure, qui n’est prévenue d’aucune amertume. Au contraire, l’animosité,\nla haine, la malignité, sont des tourments réels dont la suspension occasionnée par\nl’accomplissement du désir, est comptée pour un plaisir. » Cooper A.A., comte de\nShaftesbury (1715, p.248-249)\n• [2] Nous indiquons les « extraits de discours » entre guillemets en les distinguant\ndes « citations » mises quant à elles en italique. Nous utilisons un autre caractère pour\nles “notions” que nous questionnons. Ici il s’agit d’une affirmation prononcée\ncommunément comme un dicton.\n• [3] Le point souligné ressort comme encore plus évident si on questionne la mesure\nconsistant à imposer aux salariés de rire. Si l’on associe rire et joie, on pourrait y\nretrouver la dénonciation d’une pression exercée actuellement de façon implicite dans\ncertaines organisations et revenant à exiger que les salariés expriment leur bonheur de\ntravailler - Cf. en sciences de gestion : Gori R., Le Coz P. (2006) ; en philosophie :\nManzano M. (2008).\n• [4] Nous nous démarquons ici des stoïciens qui avec Cicéron considéraient que la\n« joie folle » est une « maladie de l’âme » au même titre que toutes les passions qui\néloigne l’homme de « la conscience du sage » : Cicéron (45 av. J.C.), Tusculanes, III,\nIV-V, in Bréhier E. (1997), pour considérer avec Baruch Spinoza (1677, Ethique, IV,\npropositions IV-VII) que « l’homme est nécessairement toujours soumis aux\npassions », Korichi M. (2000, p.113), mais sans rejeter toute possibilité\nd’autorégulation individuelle dans la lignée de René Descartes (1649) pour qui selon\nMichel Meyer (1991, p.238), « la passion m’aveugle, donc je suis dans la possible\nerreur, et je sais cela, donc je suis au-delà de la passion, la connaissant pour ce\nqu’elle est ».\n\n• [5] Par contre, plusieurs cas de « fou-rire » ont été relevés aboutissant au licenciement\ndes rieurs, comme par exemple pour l’employé d’une entreprise de pompes funèbres\nou encore pour une vendeuse de lingerie féminine.\n• [6] Cette interrelation entre pouvoir, vérité et existence se retrouve dans le manifeste\ncensuré d’Albert Camus, qui devait paraître dans Le Soir républicain, date? du 25\nnovembre 1939 et publie? dans le cahier du journal Le Monde, N° 20888, date? du 17\nmars 2012 : « […] l’ironie demeure une arme sans précédent contre les trop\npuissants. Elle complète le refus en ce sens qu’elle permet, non plus de rejeter ce qui\nest faux, mais de dire souvent ce qui est vrai. Un journaliste libre, en 1939, ne se fait\npas trop d’illusions sur l’intelligence de ceux qui l’oppriment. Il est pessimiste en ce\nqui regarde l’homme. […] Oui, c’est souvent à son corps défendant qu’un esprit libre\nde ce siècle fait sentir son ironie. Que trouver de plaisant dans ce monde enflamme? ?\nMais la vertu de l’homme est de maintenir en face de tout ce qui le nie. »\n• [7] Pour Freud S. (1905, p. 262-263), « Nul ne peut se satisfaire d’avoir fait un mot\nd’esprit pour soi tout seul. Au travail du mot d’esprit, est indissociablement lié le\nprofond besoin de communiquer le mot d’esprit à autrui »\n• [8] Darwin C.R. (1872) reste toutefois prudent, puisqu’il considère que le rire\n« paraît être » l’expression « primitive » de la joie et du bonheur (Smadja, 1993, p.33).\n• [9] Loi n° 2002-73 du 17 janvier 2002 de modernisation sociale, J.O. n°15 daté du 18\njanvier 2002, p. 1008.\n• [10] Le premier à avoir affirme? que « l’individu en foule diffère de l’individu isole? »\net souligne? les risques d’emportement associés aux dynamiques collectifs, est peutêtre Gustave Le Bon (1895, p.11).\nSource : https://www.cairn.info/revue-@grh-2013-1-page-45.htm', NULL, 1, 154, 1, 7, 1, 1, NULL, '2024-05-13 10:14:59', '2024-05-13 21:09:41', NULL),
(4, 'Partager des vrais moments de vie de famille', 'Carte défi : pendant une semaine, passer un repas en famille par jour, à table sans écrans (télévision, smartphone, tablette, etc.).\nBonus : cuisiner en famille en amont du repas.', NULL, 1, 308, 2, 9, 1, 1, NULL, '2024-05-13 10:37:25', '2024-05-13 21:09:41', NULL),
(5, 'Partager des vrais moments de vie de famille', 'Carte défi : lors de votre prochaine sortie, refuser de boire de l’alcool et observer les réactions de vos amis. Assumez votre choix et notez les émotions ressenties.', NULL, 1, 138, 4, 4, 1, 1, NULL, '2024-05-13 11:27:42', '2024-05-13 21:09:41', NULL);
INSERT INTO `ressources` (`id_ressource`, `label`, `description`, `content`, `is_public`, `view_count`, `id_user`, `id_category`, `id_status`, `id_type`, `file`, `created_at`, `updated_at`, `staff_comment`) VALUES
(6, 'PLK - Rappeur français', 'Je vous présente le top 50 des sons de PLK 😊\n\nPetrouchka\nÉmotif (Booska 1H)\nAttentat\nPilote\nUn peu de haine\nProblèmes\nJamais\nLe classico organisé\nNouvelles\nDemain\nMonégasque\nTrain de vie\nDingue\nOn sait jamais\nC\'est mort\nJack Fuego\nR.A.F\nChandon et Moët\nCopine\nEscorte\nBénef\nToute l\'année (feat. Timal)\nA la base\nPelo\nÇa mène à rien\nDans les clips\nAll Night\nMec de cité\nHola\nWaow (feat. Nekfeu)\nPolak\nHier (feat. SCH)\nCosmos\nPourtant\nFaut pas\nTu vois comment ?\nDis-moi oui\nIdiote\nTout recommencer (feat. Tessa B)\nPériph\nDécembre\nMauvais dans le fond\nToutes générations\nAu fond d\'ma tête\nPostiché\nPas les mêmes\nIncontrolables\nHubert et Saïd\nLe bruit des applaudissements\nLes comptes\n230', NULL, 1, 1035, 2, 15, 1, 1, NULL, '2024-05-13 11:46:39', '2024-05-13 21:09:41', NULL),
(7, 'Musique de Gims', 'Je vous conseils les musiques de Gims !\nhttps://www.allformusic.fr/maitre-gims/chansons', NULL, 1, 26703, 3, 15, 2, 1, NULL, '2024-05-13 12:42:25', '2024-05-13 21:09:41', NULL),
(8, 'Audi est la meilleur marque d\'après moi', 'Voir : https://www.youtube.com/watch?v=VO6fHvqwp2s\n\nAudi, avec son slogan « Vorsprung durch Technik » (L\'avance par la technologie), incarne l\'excellence dans le monde de l\'automobile. Depuis sa fondation, Audi a constamment repoussé les limites de l\'innovation, offrant des véhicules qui combinent performance, design et durabilité. Un aspect que j\'admire particulièrement chez Audi est son engagement envers la qualité. Chaque modèle, qu\'il s\'agisse de la sportive Audi R8 ou de la familiale Audi Q7, est conçu avec précision, garantissant une expérience de conduite supérieure.\n\nLa marque se distingue aussi par sa capacité à intégrer des technologies avancées. Par exemple, l\'Audi e-tron, l\'un des leaders du marché des SUV électriques, montre l\'engagement de la marque envers la mobilité durable sans compromettre les performances. De plus, l\'intérieur des véhicules Audi est souvent cité comme l\'un des plus raffinés du marché, alliant esthétique moderne et fonctionnalité, ce qui rend chaque voyage plaisant et confortable.\n\nAudi a également prouvé son excellence dans le domaine de la sécurité, une préoccupation majeure pour de nombreux conducteurs aujourd\'hui. Les systèmes d\'assistance au conducteur et les caractéristiques de sécurité active et passive sont parmi les plus avancés du secteur, renforçant la confiance des conducteurs dans leur véhicule.\n\nEn somme, choisir Audi, c\'est opter pour une marque qui ne se contente pas de suivre les tendances, mais les définit. C\'est pour ces raisons, et bien d\'autres encore, que je considère Audi comme la meilleure marque automobile.', NULL, 1, 4968, 1, 1, 2, 1, NULL, '2024-05-13 14:23:45', '2024-05-13 21:09:41', NULL),
(9, 'Volkswagen : Innovation et Tradition', 'Volkswagen, un pilier de l\'industrie automobile, combine avec habileté tradition et innovation, se forgeant une réputation de fiabilité et d\'accessibilité. Connue mondialement pour sa célèbre Coccinelle, Volkswagen a évolué pour offrir une gamme variée de véhicules qui répondent aux besoins de différents consommateurs, des robustes SUV comme le Tiguan aux familiales comme la Golf, sans oublier les citadines économiques telles que la Polo.\n\nUn des aspects les plus remarquables de Volkswagen est son engagement envers la technologie et la durabilité. La marque a pris un tournant décisif vers l\'électrification avec la série ID, qui promet une conduite zéro émission sans sacrifier la performance ou le confort. Le Volkswagen ID.4, par exemple, est un SUV électrique qui allie espace, style et efficacité, marquant une étape importante dans l\'adaptation de la marque aux défis environnementaux actuels.\n\nL\'intérieur des véhicules Volkswagen est conçu pour le confort et l\'efficacité, avec une attention particulière portée à la qualité des matériaux et à l\'ergonomie. Cela rend chaque trajet, qu\'il soit court ou long, une expérience agréable. De plus, Volkswagen continue d’innover en matière de systèmes d’assistance à la conduite, renforçant la sécurité pour tous les passagers.\n\nEn résumé, Volkswagen reste une force dominante dans l\'industrie automobile en mariant l\'artisanat traditionnel allemand avec des technologies avant-gardistes. C\'est cette combinaison qui lui permet de rester compétitive et pertinente dans un marché en constante évolution.', NULL, 1, 8274, 2, 1, 2, 1, NULL, '2024-05-13 14:25:21', '2024-05-13 21:09:41', NULL),
(10, 'Peugeot 206 : Un Classique Indémodable', 'La Peugeot 206, depuis son lancement en 1998, est devenue une figure emblématique sur les routes du monde entier, affirmant sa présence avec style, agilité et fiabilité. Ce modèle compact, aimé pour sa maniabilité et son design attrayant, s\'est rapidement imposé comme une référence dans la catégorie des petites voitures, adaptée à la fois pour les jeunes conducteurs et pour ceux recherchant une deuxième voiture pratique pour la ville.\n\nLa 206 offre une expérience de conduite équilibrée avec une suspension bien ajustée qui gère habilement les imperfections de la route, offrant un confort remarquable pour sa catégorie. Sa taille compacte facilite la navigation en milieu urbain et le stationnement dans des espaces restreints, un avantage indéniable dans les zones densément peuplées.\n\nSous le capot, la Peugeot 206 propose une gamme de motorisations essence et diesel, allant de moteurs économiques à faible consommation à des options plus puissantes, idéales pour ceux qui désirent un peu plus de vivacité sur la route. Malgré son âge, la 206 reste économique à entretenir, avec des pièces largement disponibles et à coût abordable.\n\nL\'intérieur, bien que simple, est fonctionnel avec une ergonomie bien pensée qui rend les commandes accessibles et simples à utiliser. La finition, selon les versions, peut offrir un aspect plus cossu avec des inserts décoratifs et des équipements améliorés.\n\nEn somme, la Peugeot 206 demeure une option attrayante pour les acheteurs de voitures d\'occasion. Sa réputation de durabilité, couplée à son esthétique intemporelle, garantit qu\'elle reste une valeur sûre dans le segment des petites voitures.', NULL, 1, 59290, 4, 1, 2, 1, NULL, '2024-05-13 14:27:04', '2024-05-13 21:09:41', NULL),
(11, 'Opel Corsa : Polyvalence et Innovation', 'La Opel Corsa, un nom synonyme de polyvalence et de fiabilité, a su évoluer à travers les générations pour répondre aux attentes changeantes des conducteurs. Depuis son lancement en 1982, ce modèle emblématique de la marque Opel a été plébiscité pour son excellent rapport qualité-prix, sa maniabilité et ses performances solides, ce qui en fait un choix privilégié pour une première voiture ou pour ceux qui recherchent un véhicule compact pratique.\n\nChaque génération de Corsa a apporté des améliorations significatives en termes de confort, de sécurité et de technologies embarquées. L\'une des caractéristiques les plus appréciées est la variété des motorisations offertes, incluant des options essence, diesel, et plus récemment, électrique avec la Corsa-e, témoignant de l\'engagement d\'Opel envers la mobilité durable.\n\nL\'intérieur de la Corsa est conçu avec un souci de fonctionnalité et de modernité. Les équipements de série et les options disponibles permettent une personnalisation avancée, allant des systèmes d\'infodivertissement à la pointe de la technologie aux aides à la conduite avancées, qui améliorent non seulement le confort mais aussi la sécurité du véhicule.\n\nEn matière de design, la Corsa n\'a jamais été en reste. Son apparence est régulièrement rafraîchie pour rester contemporaine, attirant à la fois les jeunes acheteurs et ceux qui restent jeunes de cœur. Sa taille compacte ne l\'empêche pas d\'offrir un espace intérieur surprenant, rendant chaque trajet agréable, que ce soit pour des déplacements urbains rapides ou des voyages plus longs sur autoroute.\n\nEn résumé, l\'Opel Corsa continue de séduire grâce à sa capacité à allier tradition et innovation, offrant une solution automobile complète et adaptable pour pratiquement tous les besoins de mobilité.', NULL, 1, 19866, 3, 1, 2, 1, NULL, '2024-05-13 14:29:27', '2024-05-13 21:09:41', NULL),
(12, 'Porsche : Une Histoire de Performance et d\'Innovation', 'Porsche, fondée en 1931 par Ferdinand Porsche, est devenue synonyme de voitures sportives de luxe alliant performance, qualité et design innovant. L\'histoire de Porsche débute à Stuttgart, en Allemagne, où l\'entreprise se concentrait initialement sur le conseil en ingénierie automobile et ne construisait pas de voitures sous son propre nom. Tout change en 1948 avec la création de la Porsche 356, conçue par Ferry Porsche, le fils de Ferdinand. Cette voiture, fabriquée dans une ancienne scierie à Gmünd, en Autriche, était révolutionnaire avec sa structure légère en aluminium et son moteur placé à l\'arrière, une caractéristique qui deviendra une signature de la marque.\n\nDans les années 1960, Porsche lance la 911, conçue par Ferdinand Alexander Porsche, petit-fils de Ferdinand. Ce modèle devient rapidement emblématique avec son moteur flat-six refroidi par air et sa silhouette élégante et intemporelle. La 911 a évolué au fil des décennies mais a toujours conservé ses lignes fondamentales et son moteur arrière, devenant ainsi le cœur de l\'identité de Porsche.\n\nAu-delà de ses voitures de sport, Porsche a également marqué l\'histoire de la course automobile. La marque a accumulé des succès dans des compétitions prestigieuses telles que les 24 Heures du Mans, où elle détient le record du nombre de victoires globales. Des modèles comme la 917, la 956, et la 962 ont dominé les circuits du monde entier, renforçant l\'image de Porsche en tant que constructeur de voitures performantes.\n\nDans les années 2000, Porsche a élargi sa gamme avec des modèles qui ont permis d\'atteindre un public plus large sans compromettre l\'héritage de performance de la marque. Le Cayenne, lancé en 2002, était le premier VUS de Porsche, et bien que controversé à l\'époque, il est devenu un succès commercial majeur, prouvant que Porsche pouvait réussir hors des sentiers battus du sport automobile. Suivi par des modèles comme le Panamera et le Macan, Porsche a continué à innover tout en restant fidèle à son ADN de performance.\n\nPlus récemment, Porsche a embrassé l\'électrification avec le Taycan, son premier véhicule entièrement électrique lancé en 2019. Le Taycan représente un tournant pour Porsche, combinant ses principes traditionnels de performance et de luxe avec les technologies d\'avenir. Cela marque une étape importante dans la transition de l\'industrie automobile vers des solutions plus durables, et Porsche est à l\'avant-garde de cette évolution, prouvant que les voitures électriques peuvent être à la fois performantes et désirables.\n\nL\'histoire de Porsche est une fusion d\'innovation, de tradition et de passion pour l\'automobile. Avec chaque nouveau modèle, Porsche continue de repousser les limites de ce qui est possible, tout en restant fidèle à son héritage de performance, de qualité et de sophistication unique.', NULL, 1, 75460, 2, 1, 1, 1, NULL, '2024-05-13 14:32:50', '2024-05-13 21:09:41', NULL),
(13, 'Bon ... Quelle est la meilleurs voiture pour 2024 ?', 'Je vous laisse débattre en commentaire !  (même si une Audi RS6 gagne malgré son prix)', NULL, 1, 84, 1, 1, 1, 1, NULL, '2024-05-13 14:34:02', '2024-05-13 21:09:41', NULL),
(14, 'INTITULÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉ', 'Je fais une ressource pour vous perdre !!!', NULL, 1, 5334, 25, 2, 2, 1, NULL, '2024-05-13 14:54:53', '2024-05-13 21:09:41', NULL),
(15, 'INTITULÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉ2', 'Je fais une ressource pour vous perdre !!!', NULL, 1, 29022, 25, 3, 4, 1, NULL, '2024-05-13 14:55:07', '2024-05-13 21:09:41', 'Pourquoi vouloir faire ça ?'),
(16, 'Falcko', 'Je vous conseille vivement d\'écouter le rappeur qui berce ma vie : Falcko. Son style unique et ses paroles percutantes méritent toute votre attention.\n\nSpotify : https://open.spotify.com/intl-fr/artist/0U4UrgHYuU5CiuJoMZf4fl?si=SUoAM9pUR9-5L3CZR5VY8Q\nYoutube : https://www.youtube.com/channel/UCvr4BkytrwMAbXu6tF5XGPg\nDeezer : https://deezer.page.link/jQcavvBh1RVtgSnB6\n\nFalcko se distingue par ses textes profonds et ses mélodies captivantes. Si je devais choisir une chanson emblématique de Falcko, ce serait Légendaire 2. Cette chanson incarne parfaitement son talent et son style unique.\n\nPour ceux qui apprécient les mélodies réfléchies et les paroles qui poussent à la réflexion, je recommande particulièrement les morceaux suivants :\n\nX (part 1)\nX (part 2)\nX (part 3)\n\nCes titres sont un véritable voyage introspectif et montrent la capacité de Falcko à aborder des thèmes profonds et universels.\n\nSi vous préférez les morceaux avec des basses puissantes et des instrus accrocheuses, la série des Error est faite pour vous. Ces morceaux sont parfaits pour ceux qui aiment les sons dynamiques et énergétiques. J\'aime également beaucoup RDP, qui offre un excellent mélange de basses et de mélodie.\n\nPour finir, je vous partage ma playlist dédiée à Falcko, où vous trouverez une sélection de ses meilleurs titres : https://open.spotify.com/playlist/7FDML09OgLPWYlfssCAjmA?si=4587e8e69e8546e7\n\nExplorez, écoutez, et laissez-vous emporter par l\'univers musical de Falcko. Ses chansons ont le pouvoir de toucher l\'âme et de résonner profondément en chacun de nous.', NULL, 1, 30000, 1, 15, 1, 1, NULL, '2024-05-13 17:28:53', '2024-05-13 19:12:16', NULL),
(17, 'La Communication Non Verbale : L\'Art de Parler Sans Mots', 'La communication non verbale, souvent sous-estimée, est un pilier essentiel dans nos interactions quotidiennes. Elle englobe les gestes, les expressions faciales, le langage corporel, le regard, et même l\'utilisation de l\'espace. Comprendre et maîtriser ces éléments peut considérablement améliorer la qualité de nos échanges et renforcer nos relations personnelles et professionnelles.\n\nLes gestes et les expressions faciales jouent un rôle crucial dans la communication. Un sourire peut exprimer l\'acceptation et la bienveillance, tandis qu\'un froncement de sourcils peut indiquer le doute ou l\'inquiétude. En observant attentivement les réactions non verbales des autres, on peut obtenir des indices précieux sur leurs véritables sentiments et intentions, souvent plus fiables que leurs paroles.\n\nLe langage corporel est une autre composante fondamentale. Une posture ouverte et détendue favorise la confiance et l\'accessibilité, tandis qu\'une posture fermée peut signaler la défensive ou l\'indisponibilité. Les mouvements des mains, les inclinaisons de la tête et la distance physique entre les interlocuteurs sont autant de facteurs à considérer. Par exemple, se pencher légèrement vers quelqu\'un peut indiquer un intérêt et une écoute active, tandis que se reculer peut être perçu comme un manque d\'engagement.\n\nLe contact visuel est également un outil puissant de communication non verbale. Maintenir un contact visuel approprié montre que l\'on est attentif et engagé dans la conversation. Cependant, il est crucial de trouver un équilibre, car un regard trop insistant peut être perçu comme intimidant ou agressif, tandis qu\'un manque de contact visuel peut suggérer un désintérêt ou une insécurité.\n\nEnfin, l\'utilisation de l\'espace personnel et de la proxémie (l\'étude de la distance entre les individus lors de la communication) peut grandement influencer les interactions. Respecter l\'espace personnel de quelqu\'un est essentiel pour instaurer un climat de confort et de respect. Dans des contextes culturels différents, la perception de cet espace peut varier, il est donc important d\'être conscient des normes culturelles en matière de proxémie.\n\nEn conclusion, la communication non verbale est un aspect complexe et multidimensionnel de la communication humaine. En développant une meilleure compréhension et une maîtrise de ces éléments, nous pouvons améliorer la clarté, l\'efficacité et l\'authenticité de nos interactions, renforçant ainsi nos relations et notre influence dans diverses situations sociales et professionnelles.', NULL, 1, 5175, 26, 2, 1, 1, NULL, '2024-05-13 17:58:53', '2024-05-13 21:09:41', NULL),
(18, 'Les Clés d\'une Présentation Impactante : Captiver et Convaincre Votre Auditoire', 'Réaliser une présentation efficace est un art qui requiert une préparation minutieuse, une compréhension de votre auditoire et une maîtrise de techniques de communication claires et engageantes. Que ce soit dans un cadre professionnel ou académique, la capacité à transmettre des informations de manière convaincante peut grandement influencer la perception et les décisions de votre public.\n\nLa préparation est la première étape cruciale. Avant de commencer à concevoir votre présentation, il est essentiel de définir vos objectifs. Que souhaitez-vous accomplir ? Informer, persuader, inspirer ou une combinaison de ces éléments ? Une fois ces objectifs établis, la structure de votre présentation doit être soigneusement planifiée. Une introduction captivante, un corps bien organisé et une conclusion mémorable sont les éléments fondamentaux d\'une présentation réussie.\n\nL\'introduction doit capter immédiatement l\'attention de votre auditoire. Commencez par une anecdote pertinente, une statistique surprenante ou une question provocatrice. Cette technique non seulement pique la curiosité, mais établit également le ton de votre présentation. Présentez brièvement le sujet et les points clés que vous allez aborder pour donner une feuille de route à votre auditoire.\n\nLe corps de la présentation doit être bien structuré et facile à suivre. Utilisez des sous-titres clairs et des transitions fluides entre les sections pour maintenir l\'attention et la compréhension. Illustrer vos points avec des exemples concrets, des données visuelles comme des graphiques ou des vidéos peut également renforcer l\'impact de votre message. Il est important de ne pas surcharger vos diapositives de texte. Privilégiez les points clés et les visuels attrayants pour soutenir vos propos.\n\nLa conclusion est tout aussi cruciale que l\'introduction. Résumez les points principaux, réitérez l\'objectif de votre présentation et terminez par un appel à l\'action ou une déclaration percutante qui laisse une impression durable. Remerciez votre auditoire pour leur attention et soyez prêt à répondre aux questions de manière concise et confiante.\n\nEn ce qui concerne la livraison de votre présentation, la pratique est essentielle. Répétez votre présentation plusieurs fois pour vous familiariser avec le contenu et améliorer votre fluidité. Travaillez sur votre langage corporel pour paraître ouvert et engageant. Utilisez des gestes pour accentuer vos points, maintenez un contact visuel avec votre auditoire et variez le ton de votre voix pour maintenir l\'intérêt.\n\nEn conclusion, une présentation impactante nécessite une préparation rigoureuse, une structure claire et une livraison engageante. En maîtrisant ces éléments, vous pouvez captiver et convaincre votre auditoire, rendant vos présentations mémorables et efficaces.', NULL, 1, 20838, 26, 2, 1, 1, NULL, '2024-05-13 17:59:10', '2024-05-13 21:09:41', NULL),
(19, 'La Communication Digitale : Naviguer et Exceller dans l\'Ère Numérique', 'La communication digitale est devenue un pilier central de la vie moderne, transformant la manière dont nous interagissons personnellement et professionnellement. Avec l\'avènement des réseaux sociaux, des plateformes de messagerie instantanée et des outils de collaboration en ligne, maîtriser la communication digitale est essentiel pour réussir dans un monde de plus en plus connecté.\n\nLa première étape pour exceller dans la communication digitale est de comprendre les différentes plateformes et leurs particularités. Chaque réseau social, qu\'il s\'agisse de Facebook, Twitter, LinkedIn ou Instagram, possède son propre langage, public et meilleures pratiques. Par exemple, LinkedIn est idéal pour les communications professionnelles et le réseautage, tandis qu\'Instagram est plus adapté au partage de contenu visuel créatif.\n\nLa création de contenu pertinent et engageant est cruciale pour capter l\'attention de votre audience en ligne. Le contenu doit être adapté à la plateforme utilisée et à votre public cible. Sur les réseaux sociaux, les messages doivent être concis, accrocheurs et souvent accompagnés de visuels attrayants. L\'utilisation de hashtags pertinents peut également augmenter la visibilité de vos publications.\n\nL\'interaction est une composante clé de la communication digitale. Répondre rapidement aux commentaires, questions et messages montre que vous êtes engagé et accessible. Cela peut renforcer les relations avec votre audience et accroître la confiance et la fidélité à votre égard ou envers votre marque. L\'écoute active et l\'empathie sont aussi importantes dans le monde digital que dans les interactions en face à face.\n\nLes outils de collaboration en ligne, tels que Slack, Microsoft Teams ou Zoom, sont devenus indispensables dans de nombreux environnements de travail, surtout avec l\'augmentation du télétravail. Savoir utiliser ces outils efficacement est essentiel pour maintenir une communication fluide et productive. Par exemple, la gestion des notifications, la maîtrise des fonctionnalités de partage d\'écran et l\'organisation de réunions virtuelles structurées peuvent grandement améliorer la collaboration à distance.\n\nLa gestion de votre réputation en ligne est un autre aspect crucial de la communication digitale. Ce que vous publiez sur Internet reste souvent accessible indéfiniment et peut avoir un impact significatif sur votre image personnelle ou professionnelle. Il est donc important de réfléchir soigneusement à ce que vous partagez et de maintenir une présence en ligne positive et cohérente.\n\nEn conclusion, la communication digitale nécessite une compréhension des plateformes, la création de contenu engageant, une interaction active avec votre audience, une utilisation efficace des outils de collaboration et une gestion prudente de votre réputation en ligne. En maîtrisant ces compétences, vous pouvez naviguer avec succès dans l\'ère numérique et maximiser votre impact personnel et professionnel.', NULL, 1, 19734, 26, 2, 1, 1, NULL, '2024-05-13 17:59:22', '2024-05-13 21:09:41', NULL),
(20, 'L\'Écoute Active : Une Compétence Essentielle pour une Communication Efficace', 'L\'écoute active est l\'une des compétences les plus importantes dans toute forme de communication, qu\'elle soit personnelle ou professionnelle. Cette pratique ne se limite pas simplement à entendre les mots prononcés par l\'autre personne, mais implique une participation active et consciente dans l\'écoute, afin de comprendre pleinement le message et les émotions qui l\'accompagnent. Développer cette compétence peut améliorer significativement vos relations, résoudre les conflits plus efficacement et renforcer votre capacité à collaborer et à influencer.\n\nL\'écoute active commence par donner toute son attention à l\'interlocuteur. Cela signifie éliminer les distractions, telles que les téléphones portables ou les ordinateurs, et se concentrer entièrement sur la personne qui parle. Le contact visuel est essentiel, car il montre que vous êtes engagé et intéressé par ce que l\'autre personne dit. Une posture ouverte et orientée vers l\'interlocuteur renforce également ce message.\n\nUn élément clé de l\'écoute active est la pratique du feedback. Cela peut inclure des signes non verbaux, comme hochements de tête et expressions faciales appropriées, ainsi que des réponses verbales qui montrent que vous suivez le discours. Des phrases telles que \"Je comprends\", \"Cela doit être difficile\" ou \"Raconte-moi en plus\" encouragent l\'interlocuteur à continuer à s\'exprimer et montrent que vous êtes investi dans la conversation.\n\nParaphraser ou reformuler ce que l\'interlocuteur a dit est une autre technique efficace de l\'écoute active. Cela permet non seulement de vérifier votre compréhension du message, mais montre aussi à l\'autre personne que vous l\'écoutez attentivement. Par exemple, \"Si je comprends bien, tu dis que...\" ou \"En d\'autres termes, tu penses que...\". Ce type de réponse peut également aider à clarifier les points flous et à approfondir la discussion.\n\nPoser des questions ouvertes est une autre stratégie importante. Contrairement aux questions fermées qui nécessitent des réponses courtes, les questions ouvertes encouragent l\'interlocuteur à développer ses idées et à fournir plus de détails. Par exemple, \"Qu\'est-ce qui t\'a amené à cette conclusion ?\" ou \"Comment te sens-tu à propos de cette situation ?\". Cela non seulement enrichit la conversation, mais montre également que vous êtes véritablement intéressé par les pensées et les sentiments de l\'autre.\n\nL\'écoute active implique également de gérer ses propres réponses émotionnelles et d\'éviter les interruptions. Parfois, il peut être tentant de couper la parole pour offrir des conseils ou exprimer son propre point de vue, mais cela peut souvent être perçu comme un manque de respect ou d\'intérêt pour ce que l\'autre personne dit. Il est important de laisser l\'interlocuteur terminer son propos avant de répondre.\n\nEnfin, l\'empathie est au cœur de l\'écoute active. Il s\'agit de se mettre à la place de l\'autre, de comprendre ses émotions et de reconnaître la validité de ses sentiments. Montrer de l\'empathie peut créer une connexion plus profonde et aider à résoudre les conflits de manière plus constructive.\n\nEn conclusion, l\'écoute active est une compétence cruciale qui enrichit la qualité de nos communications. En développant cette compétence, nous pouvons non seulement améliorer nos relations personnelles et professionnelles, mais aussi créer un environnement plus compréhensif et collaboratif. L\'écoute active est un outil puissant qui, lorsqu\'il est maîtrisé, peut transformer notre façon de communiquer et d\'interagir avec les autres.', NULL, 1, 40194, 27, 2, 1, 1, NULL, '2024-05-13 18:04:03', '2024-05-13 21:09:41', NULL),
(21, 'Les Festivals Français : Célébrations de Culture et de Tradition', 'La France est renommée pour ses festivals vibrants et diversifiés qui reflètent la richesse de sa culture et de ses traditions. Des événements nationaux aux célébrations locales, chaque festival offre une fenêtre unique sur les coutumes et les pratiques françaises, attirant des visiteurs du monde entier désireux de découvrir cette diversité culturelle.\n\nL\'un des festivals les plus célèbres est le Festival de Cannes, une vitrine prestigieuse pour l\'industrie cinématographique mondiale. Chaque année en mai, des stars de cinéma, des réalisateurs et des passionnés de cinéma affluent vers la Côte d\'Azur pour assister à des projections de films, des cérémonies de remise de prix et des événements glamour. Créé en 1946, le Festival de Cannes est devenu un symbole de l\'excellence cinématographique et une plateforme pour découvrir des talents émergents.\n\nLe Carnaval de Nice est une autre célébration emblématique, marquant la période précédant le Carême. Avec ses défilés colorés, ses chars spectaculaires et ses costumes extravagants, le Carnaval de Nice attire des centaines de milliers de visiteurs chaque année. Cette fête, dont les origines remontent au Moyen Âge, est un mélange de traditions païennes et chrétiennes, offrant un aperçu fascinant de l\'évolution culturelle de la région.\n\nLa Fête de la Musique, initiée en 1982 par le ministre de la Culture Jack Lang, est une célébration nationale qui a lieu chaque année le 21 juin, jour du solstice d\'été. Ce festival unique en son genre invite musiciens amateurs et professionnels à se produire dans les rues, les places publiques et les parcs, transformant la France en une immense scène musicale. La Fête de la Musique est devenue un phénomène mondial, célébré dans plus de 120 pays, mais reste profondément enracinée dans la culture française.\n\nLe Festival d\'Avignon, fondé en 1947 par Jean Vilar, est l\'un des plus grands festivals de théâtre au monde. Chaque été, la ville d\'Avignon se transforme en un théâtre à ciel ouvert, accueillant des spectacles de théâtre, de danse et de musique contemporaine. Les représentations ont lieu dans des lieux historiques tels que le Palais des Papes, créant une ambiance unique qui attire des artistes et des spectateurs internationaux.\n\nCes festivals, parmi tant d\'autres, témoignent de la diversité et de la vitalité de la culture française. Ils offrent non seulement des moments de divertissement et de célébration, mais aussi des opportunités de comprendre et d\'apprécier les traditions, les valeurs et la créativité qui caractérisent la France.', NULL, 1, 31626, 27, 3, 1, 1, NULL, '2024-05-13 18:04:55', '2024-05-13 21:09:41', NULL),
(22, 'Les Rituels Ancestraux en France : Héritage et Transmission', 'Les rituels ancestraux jouent un rôle crucial dans la préservation de l\'identité culturelle française, transmettant des valeurs, des croyances et des traditions de génération en génération. Ces pratiques, souvent ancrées dans des contextes religieux ou communautaires, offrent un aperçu profond des coutumes et des modes de vie historiques qui continuent de façonner la France contemporaine.\n\nL\'un des rituels les plus significatifs est la Fête de la Saint-Jean, célébrée le 24 juin, qui marque le solstice d\'été. Cette fête païenne, christianisée au fil des siècles, est célébrée avec des feux de joie allumés dans les villages et les villes. Les feux de la Saint-Jean symbolisent la purification et la protection, et sont souvent accompagnés de danses et de chants traditionnels. Cette célébration, qui varie d\'une région à l\'autre, est un moment de rassemblement communautaire et de transmission des coutumes locales.\n\nLe Mardi Gras est une autre célébration ancestrale, marquant la fin de la période de Carnaval avant le début du Carême. Cette fête est caractérisée par des défilés de chars, des costumes élaborés et des festins copieux. Le Mardi Gras de Dunkerque, en particulier, est célèbre pour ses défilés colorés et ses chants traditionnels, reflétant les influences maritimes de cette ville portuaire. Les origines de Mardi Gras remontent aux traditions païennes de la fête de la fin de l\'hiver et de l\'arrivée du printemps.\n\nEn Bretagne, le Pardon est un rituel religieux unique, mélange de pèlerinage et de fête populaire, célébré en l\'honneur des saints patrons locaux. Les Pardons, qui se déroulent tout au long de l\'année, sont marqués par des processions, des messes et des bénédictions, souvent suivies de festins et de danses bretonnes. Ces événements sont des moments de dévotion, de solidarité communautaire et de préservation des traditions bretonnes.\n\nLe Béarnais Salé, célébré dans la région du Béarn, est un rituel agricole ancestral qui marque la fin des récoltes. Les agriculteurs se rassemblent pour partager un repas traditionnel à base de produits locaux, tels que le jambon de Bayonne et le vin de Jurançon. Ce festin est non seulement une célébration de l\'abondance de la terre, mais aussi une occasion de renforcer les liens communautaires et de transmettre les savoir-faire agricoles.\n\nCes rituels ancestraux, bien que variés dans leurs formes et leurs significations, partagent une caractéristique commune : ils sont des expressions vivantes du patrimoine culturel français. En perpétuant ces traditions, les communautés locales préservent leur histoire, leur identité et leur cohésion sociale, tout en adaptant ces pratiques aux réalités contemporaines.', NULL, 1, 13524, 27, 3, 1, 1, NULL, '2024-05-13 18:05:07', '2024-05-13 21:09:41', NULL),
(23, 'Les Arts Populaires en France : Un Héritage Vivant', 'Les arts populaires en France, qu\'ils soient visuels, musicaux ou artisanaux, sont des expressions vibrantes de l\'identité culturelle et du patrimoine régional. Ils témoignent de la créativité et du savoir-faire des communautés locales, tout en reflétant les influences historiques et géographiques qui ont façonné le pays. Plonger dans les arts populaires français, c\'est découvrir un monde riche en traditions et en innovations artistiques.\n\nL\'un des arts populaires les plus emblématiques est la dentelle. La dentelle française, notamment celle de Calais et de Chantilly, est réputée pour sa finesse et son élégance. Cette tradition artisanale, qui remonte au XVIIe siècle, a évolué au fil des siècles, intégrant des techniques sophistiquées et des motifs complexes. La dentelle est utilisée dans la mode, la décoration et les costumes traditionnels, et reste un symbole de l\'excellence artisanale française.\n\nLa faïence est un autre art populaire important, particulièrement dans des régions comme Quimper en Bretagne et Moustiers-Sainte-Marie en Provence. La faïence de Quimper, caractérisée par ses motifs colorés et ses scènes bretonnes, est un héritage vivant de l\'art céramique breton. De même, la faïence de Moustiers, avec ses motifs baroques et ses scènes pastorales, est un témoignage de l\'influence italienne et provençale. Ces créations artisanales sont non seulement des objets d\'art, mais aussi des témoins de l\'histoire et des traditions locales.\n\nLa musique folklorique joue un rôle central dans les arts populaires français. Chaque région possède ses propres instruments, danses et chansons traditionnels. En Bretagne, par exemple, le biniou (cornemuse bretonne) et la bombarde accompagnent les fest-noz, des fêtes de nuit où l\'on danse des danses bretonnes traditionnelles. Dans le Sud-Ouest, les bandas (fanfares) animent les fêtes locales avec leurs airs entraînants. La musique folklorique est une expression de l\'identité régionale et un moyen de transmettre les histoires et les légendes locales.\n\nL\'art du vitrail, particulièrement dans les régions du Nord et de l\'Est de la France, est un autre exemple d\'art populaire qui a su traverser les siècles. Les vitraux, souvent présents dans les églises et les cathédrales, sont des œuvres d\'art qui racontent des histoires bibliques et des scènes de la vie quotidienne. Les techniques de fabrication et de restauration du vitrail sont transmises de génération en génération, assurant la préservation de ce patrimoine artistique unique.\n\nEn conclusion, les arts populaires en France sont une richesse culturelle qui continue de vivre et d\'évoluer. Ils sont le reflet de l\'histoire, des traditions et de la diversité des régions françaises. En découvrant ces arts, on accède à une compréhension plus profonde de l\'identité culturelle de la France et à une appréciation du talent et de la créativité des artisans et des artistes locaux.', NULL, 1, 49887, 27, 3, 1, 1, NULL, '2024-05-13 18:05:26', '2024-05-13 21:09:41', NULL),
(24, 'La Gastronomie Française : Un Voyage à Travers les Régions', 'La gastronomie française est mondialement reconnue pour sa diversité, sa qualité et ses traditions culinaires riches. Chaque région de France offre une palette unique de saveurs, d\'ingrédients et de techniques culinaires qui reflètent son terroir et son histoire. Plonger dans la cuisine française, c\'est entreprendre un voyage gustatif à travers des paysages variés et des cultures locales distinctes.\n\nLa Bourgogne, par exemple, est célèbre pour ses vins prestigieux et ses plats robustes. Le bœuf bourguignon, un ragoût de bœuf mijoté dans du vin rouge avec des légumes et des herbes, est un symbole de la cuisine bourguignonne. La région est également connue pour ses escargots, souvent préparés avec du beurre persillé et de l\'ail, et pour son coq au vin, une autre spécialité mijotée dans du vin rouge.\n\nLa Provence, au sud-est de la France, offre une cuisine colorée et ensoleillée, influencée par le climat méditerranéen. Les herbes de Provence, l\'huile d\'olive, l\'ail et les tomates sont des ingrédients de base dans de nombreux plats provençaux. La ratatouille, un ragoût de légumes méditerranéens, et la bouillabaisse, une soupe de poisson traditionnelle de Marseille, sont des exemples emblématiques de la cuisine provençale.\n\nEn Alsace, la proximité avec l\'Allemagne influence fortement la cuisine régionale. La choucroute garnie, composée de chou fermenté accompagné de viandes variées, et la tarte flambée (ou flammekueche), une sorte de pizza alsacienne à base de crème, d\'oignons et de lardons, sont des plats typiques. Les vins blancs d\'Alsace, tels que le Riesling et le Gewurztraminer, sont également célèbres pour leur qualité.\n\nLa Bretagne, avec ses côtes maritimes, est renommée pour ses fruits de mer et ses crêpes. Les galettes bretonnes, des crêpes de sarrasin garnies de diverses garnitures salées, et les crêpes sucrées au froment sont des incontournables de la région. Les fruits de mer, tels que les huîtres et les moules, sont souvent dégustés frais ou cuisinés dans des plats simples mais savoureux.\n\nEnfin, la Normandie est réputée pour ses produits laitiers et ses pommes. Le camembert, un fromage à pâte molle, est un symbole de la région, tout comme le cidre et le calvados, une eau-de-vie de pomme. La cuisine normande inclut également des plats riches en crème, tels que le poulet vallée d\'Auge, cuit avec des pommes, du calvados et de la crème.\n\nEn conclusion, la gastronomie française est une célébration de la diversité et de la richesse des terroirs régionaux. Chaque région apporte ses propres ingrédients, techniques et traditions, offrant une expérience culinaire unique et variée. Découvrir la cuisine française, c\'est savourer un patrimoine culturel vivant et dynamique.', NULL, 1, 1008, 28, 3, 1, 1, NULL, '2024-05-13 18:19:38', '2024-05-13 21:09:41', NULL),
(25, 'La Gestion du Stress : Techniques et Stratégies pour un Quotidien Plus Serein', 'La gestion du stress est essentielle pour mener une vie équilibrée et épanouissante. Le stress, bien qu\'inévitable, peut être géré efficacement grâce à diverses techniques et stratégies. En adoptant des pratiques de gestion du stress, vous pouvez améliorer votre bien-être mental et émotionnel, augmenter votre productivité et renforcer votre résilience face aux défis quotidiens.\n\nL\'une des techniques les plus efficaces pour gérer le stress est la méditation de pleine conscience. Cette pratique consiste à se concentrer sur le moment présent, en observant ses pensées et ses émotions sans jugement. La méditation de pleine conscience aide à réduire le stress en calmant l\'esprit et en améliorant la capacité à gérer les émotions. Des études ont montré que la méditation régulière peut diminuer les niveaux de cortisol, l\'hormone du stress, et améliorer la santé mentale globale.\n\nLa respiration profonde est une autre technique simple mais puissante pour réduire le stress. Prendre quelques minutes chaque jour pour pratiquer des exercices de respiration profonde peut aider à calmer le système nerveux, réduire l\'anxiété et augmenter la clarté mentale. Essayez la respiration diaphragmatique, où vous respirez profondément par le nez, remplissant votre abdomen d\'air, puis expirez lentement par la bouche. Cette technique peut être pratiquée n\'importe où et à tout moment, offrant une solution rapide pour soulager le stress.\n\nL\'activité physique est également cruciale pour la gestion du stress. L\'exercice libère des endorphines, des hormones du bien-être, qui aident à améliorer l\'humeur et à réduire le stress. Que ce soit la course à pied, le yoga, la natation ou simplement une promenade en plein air, trouver une activité physique que vous aimez peut avoir des effets bénéfiques significatifs sur votre bien-être mental et émotionnel.\n\nUne autre stratégie efficace est la gestion du temps. Souvent, le stress est causé par une surcharge de travail et des délais serrés. Apprendre à prioriser les tâches, à déléguer quand c\'est possible et à établir des limites claires peut aider à réduire le stress. Utiliser des outils de gestion du temps comme des listes de tâches, des calendriers et des applications de productivité peut vous aider à rester organisé et à mieux gérer vos responsabilités.\n\nEnfin, le soutien social joue un rôle crucial dans la gestion du stress. Parler de vos préoccupations avec des amis, des membres de la famille ou un professionnel peut vous aider à voir les choses sous un angle différent et à trouver des solutions. Le soutien émotionnel des autres peut également offrir un sentiment de connexion et de compréhension, réduisant ainsi les sentiments de stress et d\'isolement.\n\nEn conclusion, la gestion du stress implique une combinaison de techniques et de stratégies adaptées à vos besoins et à votre style de vie. En intégrant ces pratiques dans votre routine quotidienne, vous pouvez réduire le stress, améliorer votre bien-être mental et émotionnel et mener une vie plus équilibrée et épanouissante.', NULL, 1, 73227, 28, 4, 1, 1, NULL, '2024-05-13 18:21:17', '2024-05-13 21:09:41', NULL),
(26, 'Renforcer la Confiance en Soi : Outils et Techniques Pratiques', 'La confiance en soi est un élément clé du développement personnel. Elle influence la manière dont nous nous percevons, interagissons avec les autres et abordons les défis. Renforcer la confiance en soi peut transformer votre vie, vous aidant à atteindre vos objectifs personnels et professionnels. Voici quelques outils et techniques pratiques pour développer une confiance en soi solide et durable.\n\nTout d\'abord, il est essentiel de reconnaître et de célébrer vos réussites. Prenez le temps de réfléchir à vos accomplissements, qu\'ils soient grands ou petits. Tenir un journal de gratitude où vous notez vos succès quotidiens peut renforcer une vision positive de vous-même. En reconnaissant vos réussites, vous construisez une base de confiance en vos capacités et en votre potentiel.\n\nL\'auto-compassion est une autre technique puissante pour renforcer la confiance en soi. Soyez gentil avec vous-même, surtout en période de difficulté ou d\'échec. Plutôt que de vous critiquer sévèrement, adoptez une attitude bienveillante et encourageante. L\'auto-compassion permet de réduire l\'autocritique et d\'augmenter la résilience, vous aidant à rebondir plus rapidement face aux obstacles.\n\nLa visualisation positive est également un outil efficace. Prenez quelques minutes chaque jour pour visualiser vos objectifs et imaginez-vous en train de les atteindre. Visualiser le succès peut renforcer votre motivation et votre confiance en votre capacité à réaliser vos aspirations. En vous imaginant en train de réussir, vous conditionnez votre esprit à croire en votre potentiel.\n\nLe développement de compétences est une autre manière de renforcer la confiance en soi. Identifiez les domaines où vous souhaitez vous améliorer et prenez des mesures pour acquérir de nouvelles compétences. Suivre des cours, lire des livres ou participer à des ateliers peut vous donner les outils nécessaires pour exceller. En maîtrisant de nouvelles compétences, vous augmentez votre sentiment de compétence et de confiance en vous-même.\n\nIl est également important de sortir de votre zone de confort. Prenez des risques calculés et essayez de nouvelles expériences. Chaque fois que vous relevez un défi et que vous réussissez, même si cela semble effrayant au début, vous renforcez votre confiance en vos capacités. Les petites victoires accumulées en sortant de votre zone de confort peuvent avoir un impact significatif sur votre estime de soi.\n\nEnfin, entourez-vous de personnes positives et encourageantes. Les relations avec des personnes qui croient en vous et vous soutiennent peuvent renforcer votre confiance en vous-même. Évitez les personnes qui vous rabaissent ou vous critiquent de manière destructrice. Créez un environnement de soutien qui favorise votre croissance personnelle et votre confiance.\n\nEn conclusion, renforcer la confiance en soi est un processus continu qui nécessite des efforts conscients et des pratiques régulières. En utilisant ces outils et techniques, vous pouvez développer une confiance en vous-même solide et durable, vous permettant de réaliser vos objectifs et de vivre une vie épanouissante et réussie.', NULL, 1, 28686, 28, 4, 1, 1, NULL, '2024-05-13 18:21:30', '2024-05-13 21:09:41', NULL),
(27, 'L\'Équilibre Vie-Travail : Clés pour une Harmonie Personnelle et Professionnelle', 'L\'équilibre entre la vie professionnelle et la vie personnelle est essentiel pour maintenir un bien-être général et éviter le burn-out. Dans un monde où les frontières entre le travail et la vie personnelle sont souvent floues, il est crucial de trouver des stratégies pour gérer efficacement son temps et ses énergies. Voici quelques clés pour atteindre et maintenir un équilibre vie-travail harmonieux.\n\nLa première étape pour améliorer l\'équilibre vie-travail est de fixer des limites claires. Définissez des heures de travail spécifiques et respectez-les autant que possible. Évitez de ramener du travail à la maison ou de vérifier vos e-mails professionnels en dehors des heures de bureau. En établissant des frontières nettes entre le travail et la vie personnelle, vous pouvez mieux gérer votre temps et prévenir l\'épuisement professionnel.\n\nLa gestion du temps est également essentielle pour maintenir un équilibre vie-travail. Utilisez des outils de planification comme des calendriers, des listes de tâches et des applications de gestion du temps pour organiser votre journée. Priorisez les tâches importantes et urgentes et déléguez ou éliminez les tâches moins essentielles. Une gestion efficace du temps permet de réduire le stress et d\'augmenter la productivité.\n\nIl est important de prendre des pauses régulières tout au long de la journée de travail. Des pauses courtes mais fréquentes peuvent améliorer la concentration et la productivité. Levez-vous, étirez-vous, faites une courte promenade ou méditez pendant quelques minutes pour recharger vos batteries. Des pauses régulières aident également à prévenir la fatigue et à maintenir un niveau d\'énergie élevé.\n\nLa pratique de l\'auto-soin est cruciale pour un équilibre vie-travail sain. Prenez soin de votre bien-être physique, mental et émotionnel en intégrant des activités de bien-être dans votre routine quotidienne. Faites de l\'exercice régulièrement, mangez des repas équilibrés, dormez suffisamment et prenez le temps de vous détendre et de vous ressourcer. L\'auto-soin n\'est pas un luxe, mais une nécessité pour maintenir une vie équilibrée.\n\nApprendre à dire non est une compétence essentielle pour maintenir un équilibre vie-travail. Il est important de reconnaître vos limites et de ne pas surcharger votre emploi du temps avec des engagements professionnels ou personnels. Dire non à des demandes excessives ou non prioritaires vous permet de vous concentrer sur ce qui est vraiment important et de préserver votre énergie.\n\nEnfin, cultivez des relations positives tant au travail qu\'en dehors. Des relations de travail saines peuvent augmenter la satisfaction professionnelle et réduire le stress. En dehors du travail, passez du temps de qualité avec votre famille et vos amis pour renforcer les liens affectifs et trouver un soutien émotionnel. Les relations positives contribuent à un sentiment de bien-être et d\'équilibre.\n\nEn conclusion, atteindre un équilibre vie-travail harmonieux nécessite une combinaison de gestion du temps, de fixation de limites, de pratique de l\'auto-soin et de développement de relations positives. En appliquant ces clés, vous pouvez améliorer votre bien-être général, augmenter votre satisfaction professionnelle et personnelle, et vivre une vie plus épanouissante et équilibrée.', NULL, 1, 23604, 28, 4, 1, 1, NULL, '2024-05-13 18:21:41', '2024-05-13 21:09:41', NULL);
INSERT INTO `ressources` (`id_ressource`, `label`, `description`, `content`, `is_public`, `view_count`, `id_user`, `id_category`, `id_status`, `id_type`, `file`, `created_at`, `updated_at`, `staff_comment`) VALUES
(28, 'Les Langues Régionales en France : Diversité Linguistique et Préservation', 'La France est souvent perçue comme un pays monolingue, mais elle abrite en réalité une grande diversité de langues régionales, chacune avec sa propre histoire et sa culture. Ces langues, bien que minoritaires par rapport au français, jouent un rôle crucial dans la préservation de l\'identité culturelle des différentes régions.\n\nLe breton, parlé en Bretagne, est une langue celtique qui a survécu malgré des siècles de domination linguistique française. Le breton est enseigné dans certaines écoles et utilisé dans des contextes culturels et artistiques, tels que la musique traditionnelle et les festivals locaux. Efforts de revitalisation, tels que l\'enseignement bilingue et la signalisation bilingue, contribuent à maintenir la langue vivante.\n\nLe basque, parlé dans le Pays basque, est unique car il n\'est lié à aucune autre langue indo-européenne. Le basque, ou euskara, est utilisé dans la vie quotidienne, les médias et l\'éducation dans les zones basques de la France. Les écoles immersives en basque, appelées ikastolas, jouent un rôle essentiel dans la transmission de la langue aux nouvelles générations.\n\nLe corse, langue romane parlée en Corse, a des similitudes avec l\'italien, mais possède ses propres caractéristiques distinctives. La langue corse est enseignée dans les écoles et utilisée dans les médias locaux. La culture corse, riche en chants polyphoniques et en traditions orales, contribue à la préservation de la langue.\n\nL\'occitan, parlé dans le sud de la France, est une langue romane qui a été un important véhicule de la littérature médiévale des troubadours. L\'occitan connaît une résurgence grâce à des initiatives culturelles et éducatives. Des festivals de musique, de la littérature et des cours d\'occitan sont organisés pour promouvoir et préserver cette langue.\n\nLe catalan, parlé dans les Pyrénées-Orientales, est une langue romane partagée avec la région de Catalogne en Espagne. Le catalan est enseigné dans certaines écoles et utilisé dans les médias locaux. La culture catalane, avec ses traditions festives et culinaires, joue un rôle crucial dans la préservation de la langue.\n\nEn conclusion, les langues régionales en France sont des trésors culturels qui enrichissent la diversité linguistique du pays. La préservation et la revitalisation de ces langues sont essentielles pour maintenir le patrimoine culturel et l\'identité des régions. Grâce aux efforts éducatifs et culturels, ces langues continuent de vivre et de prospérer.', NULL, 1, 58520, 29, 3, 1, 1, NULL, '2024-05-13 18:22:42', '2024-05-13 21:09:41', NULL),
(29, 'La Conscience de Soi : La Fondation de l\'Intelligence Émotionnelle', 'La conscience de soi est l\'une des compétences clés de l\'intelligence émotionnelle. Elle implique une compréhension profonde de ses propres émotions, de ses forces et de ses faiblesses, ainsi que de l\'impact de ses comportements sur les autres. Développer cette conscience est essentiel pour améliorer ses relations personnelles et professionnelles, ainsi que pour naviguer efficacement dans des situations complexes.\n\nPour renforcer la conscience de soi, il est utile de pratiquer la réflexion personnelle. Prenez du temps chaque jour pour réfléchir à vos expériences, à vos émotions et à vos réactions. Tenir un journal peut être un outil puissant pour documenter vos pensées et vos sentiments, vous permettant ainsi d\'identifier des schémas récurrents et de mieux comprendre ce qui déclenche certaines émotions.\n\nL\'auto-évaluation régulière est également cruciale. Évaluez vos compétences, vos réussites et vos domaines d\'amélioration. Demandez des retours d\'information à des personnes de confiance pour obtenir une perspective extérieure sur vos comportements et vos performances. Utilisez ces informations pour ajuster vos actions et améliorer continuellement votre compréhension de vous-même.\n\nLa méditation de pleine conscience est une pratique efficace pour développer la conscience de soi. En se concentrant sur le moment présent et en observant ses pensées et ses émotions sans jugement, la pleine conscience aide à cultiver une compréhension plus profonde de soi. Cette pratique peut réduire le stress, améliorer la concentration et augmenter la capacité à gérer les émotions.\n\nReconnaître et accepter ses émotions est une autre étape importante. Il est essentiel de ne pas réprimer ou ignorer ses sentiments, mais plutôt de les reconnaître et de les comprendre. En acceptant vos émotions, vous pouvez les gérer de manière plus constructive et éviter qu\'elles n\'affectent négativement vos interactions et vos décisions.\n\nEnfin, fixez-vous des objectifs de développement personnel. Identifiez les domaines dans lesquels vous souhaitez vous améliorer et élaborez un plan pour atteindre ces objectifs. Que ce soit pour améliorer votre patience, votre capacité d\'écoute ou votre gestion du stress, des objectifs clairs peuvent vous guider dans votre parcours de développement de la conscience de soi.\n\nEn conclusion, la conscience de soi est la base de l\'intelligence émotionnelle. En cultivant cette compétence, vous pouvez mieux comprendre et gérer vos émotions, améliorer vos relations et naviguer avec succès dans les défis personnels et professionnels.', NULL, 1, 7728, 29, 5, 1, 1, NULL, '2024-05-13 18:23:12', '2024-05-13 21:09:41', NULL),
(30, 'La Régulation Émotionnelle : Maîtriser Ses Réactions pour un Bien-Être Accru', 'La régulation émotionnelle est la capacité à gérer et à modérer ses émotions de manière saine et constructive. Cette compétence est essentielle pour maintenir un bien-être émotionnel et pour interagir efficacement avec les autres. En apprenant à réguler vos émotions, vous pouvez éviter les réactions impulsives, réduire le stress et améliorer votre résilience face aux défis.\n\nL\'un des aspects clés de la régulation émotionnelle est la reconnaissance des déclencheurs émotionnels. Identifiez les situations, les personnes ou les pensées qui provoquent des émotions intenses. Une fois ces déclencheurs identifiés, vous pouvez élaborer des stratégies pour les gérer. Par exemple, si certaines interactions au travail vous mettent en colère, préparez-vous à répondre de manière calme et réfléchie.\n\nLa respiration profonde est une technique efficace pour calmer rapidement les émotions fortes. Lorsque vous ressentez du stress, de la colère ou de l\'anxiété, prenez quelques respirations profondes et lentes. La respiration diaphragmatique, où vous respirez profondément par le nez en remplissant votre abdomen, puis expirez lentement par la bouche, peut aider à apaiser votre système nerveux et à réduire l\'intensité des émotions négatives.\n\nLa restructuration cognitive est une autre méthode puissante pour réguler les émotions. Cette technique implique de changer la manière dont vous percevez et interprétez les situations. Plutôt que de voir une critique comme une attaque personnelle, essayez de la considérer comme une opportunité d\'apprentissage et de croissance. En changeant votre perspective, vous pouvez réduire les émotions négatives et adopter une attitude plus positive et constructive.\n\nIl est également important de pratiquer l\'auto-compassion. Traitez-vous avec la même gentillesse et compréhension que vous offririez à un ami proche. L\'auto-compassion permet de réduire l\'autocritique et de favoriser un état émotionnel plus équilibré. Lorsque vous faites face à des échecs ou à des difficultés, rappelez-vous que tout le monde éprouve des moments difficiles et que ces expériences font partie du processus d\'apprentissage.\n\nEnfin, trouver des exutoires sains pour vos émotions est essentiel. L\'exercice physique, la créativité (comme le dessin, l\'écriture ou la musique) et la pratique de loisirs relaxants peuvent aider à libérer les tensions émotionnelles et à améliorer votre humeur. Trouvez des activités qui vous permettent d\'exprimer vos émotions de manière positive et qui contribuent à votre bien-être général.\n\nEn conclusion, la régulation émotionnelle est une compétence cruciale pour maintenir un équilibre émotionnel et améliorer vos interactions avec les autres. En développant des techniques pour gérer vos émotions, vous pouvez vivre une vie plus sereine et épanouissante, tant sur le plan personnel que professionnel.', NULL, 1, 11718, 29, 5, 1, 1, NULL, '2024-05-13 18:24:13', '2024-05-13 21:09:41', NULL),
(31, 'L\'Empathie : La Clé pour des Relations Harmonieuses et Profondes', 'L\'empathie est la capacité à comprendre et à partager les sentiments des autres. C\'est une compétence essentielle de l\'intelligence émotionnelle qui permet de créer des relations harmonieuses et profondes, tant dans la vie personnelle que professionnelle. En développant votre empathie, vous pouvez améliorer votre communication, résoudre les conflits plus efficacement et renforcer votre réseau social.\n\nPour développer l\'empathie, il est crucial de pratiquer l\'écoute active. Cela signifie accorder toute votre attention à la personne qui parle, sans interrompre ni préparer votre réponse pendant qu\'elle s\'exprime. Utilisez des signaux non verbaux comme le contact visuel et les hochements de tête pour montrer que vous êtes engagé dans la conversation. Répétez ou reformulez ce que l\'autre personne a dit pour confirmer votre compréhension et pour montrer que vous vous souciez de ses sentiments.\n\nLa curiosité bienveillante est une autre composante importante de l\'empathie. Posez des questions ouvertes pour mieux comprendre les perspectives et les expériences des autres. Montrez un intérêt authentique pour ce qu\'ils vivent et ressentent. Par exemple, demandez : \"Peux-tu m\'en dire plus sur ce que tu ressens à propos de cette situation ?\" ou \"Comment cela t\'a-t-il affecté ?\". Cette attitude encourage l\'autre personne à s\'ouvrir et à partager ses émotions plus librement.\n\nLa mise en perspective est également essentielle pour développer l\'empathie. Essayez de vous mettre à la place de l\'autre personne et de voir la situation à travers ses yeux. Imaginez ce que vous ressentiriez dans une situation similaire et comment vous aimeriez être traité. Cette approche aide à cultiver une compréhension plus profonde et à répondre de manière plus compatissante.\n\nIl est important de reconnaître et de valider les émotions des autres. Montrez que vous comprenez et acceptez leurs sentiments, même si vous n\'êtes pas d\'accord avec leur point de vue. Utilisez des phrases comme \"Je comprends que tu te sentes ainsi\" ou \"Il est normal de ressentir cela dans une telle situation\". La validation des émotions renforce le lien émotionnel et favorise une communication ouverte et honnête.\n\nLa pratique de l\'auto-empathie est également essentielle. Soyez conscient de vos propres émotions et traitez-vous avec la même compassion et compréhension que vous offrez aux autres. L\'auto-empathie vous permet de mieux gérer vos propres émotions et d\'être plus disponible émotionnellement pour les autres.\n\nEn conclusion, l\'empathie est une compétence cruciale pour établir des relations profondes et harmonieuses. En développant votre capacité à comprendre et à partager les émotions des autres, vous pouvez améliorer votre communication, résoudre les conflits plus efficacement et renforcer votre bien-être émotionnel. Cultiver l\'empathie enrichit non seulement vos interactions sociales, mais contribue également à créer un environnement plus compréhensif et solidaire.', NULL, 1, 138, 29, 5, 1, 1, NULL, '2024-05-13 18:24:25', '2024-05-13 21:09:41', NULL),
(32, 'Les Traditions de Noël en France : Une Célébration de la Diversité Culturelle', 'Noël en France est une période de fête riche en traditions variées, qui reflètent la diversité culturelle et régionale du pays. Chaque région possède ses propres coutumes et pratiques uniques, offrant une mosaïque de célébrations qui enrichissent l\'esprit festif de la saison.\n\nEn Alsace, Noël est particulièrement magique avec ses marchés de Noël, qui sont parmi les plus anciens et les plus célèbres d\'Europe. Le marché de Noël de Strasbourg, par exemple, attire des millions de visiteurs chaque année avec ses stands d\'artisanat, ses décorations lumineuses et ses spécialités culinaires comme le pain d\'épices et le vin chaud. Les maisons alsaciennes, avec leurs façades à colombages, sont magnifiquement décorées de guirlandes et de lumières, créant une atmosphère féerique.\n\nEn Provence, la tradition des santons (petites figurines en argile) est au cœur des célébrations de Noël. Les santons représentent la crèche de Noël avec des personnages traditionnels comme les bergers, les boulangers, et bien sûr, la Sainte Famille. Les foires aux santons, où les artisans vendent leurs créations, sont un événement incontournable en Provence. La région est également connue pour les treize desserts de Noël, une tradition qui consiste à servir treize desserts différents le soir de Noël, symbolisant Jésus et ses douze apôtres.\n\nEn Bretagne, les célébrations de Noël sont influencées par les traditions celtiques. Les fest-noz (fêtes de nuit) sont organisées avec des danses et des chants bretons traditionnels. Le repas de Noël, appelé reviellon, est souvent composé de fruits de mer, de foie gras et de galettes bretonnes. Les Bretons ont également la tradition de la bûche de Noël, un dessert en forme de bûche décorée, qui rappelle les anciennes cérémonies païennes de brûler une bûche pour protéger la maison pendant l\'hiver.\n\nDans le Nord de la France, la Saint-Nicolas est une célébration importante, particulièrement dans les régions frontalières avec la Belgique et le Luxembourg. Saint Nicolas, le patron des écoliers, est fêté le 6 décembre avec des défilés et des distributions de friandises aux enfants. Les marchés de Noël de Lille et de Reims sont également célèbres pour leurs produits artisanaux et leurs spécialités culinaires comme les gaufres et les spéculoos.\n\nEn conclusion, les traditions de Noël en France sont diverses et colorées, reflétant les influences historiques et culturelles de chaque région. Ces célébrations enrichissent le patrimoine culturel français et offrent une expérience festive unique à chaque coin du pays. Que ce soit à travers les marchés de Noël, les santons provençaux, ou les fest-noz bretons, Noël en France est une période de partage, de joie et de découvertes culturelles.', NULL, 1, 2520, 30, 3, 1, 1, NULL, '2024-05-13 18:26:19', '2024-05-13 21:09:41', NULL),
(33, 'La Cuisine : Un Voyage Culinaire pour Enrichir Votre Quotidien', 'La cuisine est bien plus qu\'une simple nécessité quotidienne; c\'est un art et un loisir qui permet d\'explorer des saveurs, des cultures et des techniques culinaires variées. En plongeant dans le monde de la cuisine, vous pouvez découvrir une nouvelle passion, améliorer vos compétences culinaires et enrichir votre quotidien avec des expériences gustatives uniques.\n\nPour commencer votre aventure culinaire, essayez des cours de cuisine en ligne. De nombreuses plateformes offrent des cours dispensés par des chefs professionnels qui couvrent une large gamme de cuisines, des plats français classiques aux saveurs exotiques de l\'Asie. Ces cours vous permettent d\'apprendre à votre propre rythme et dans le confort de votre maison, tout en développant des compétences précieuses qui impressionneront vos amis et votre famille.\n\nUne autre excellente façon d\'explorer la cuisine est de participer à des ateliers de cuisine locaux. Ces ateliers offrent une expérience pratique et interactive où vous pouvez apprendre des techniques culinaires spécifiques, comme la fabrication de pâtes fraîches, la cuisson du pain ou la préparation de sushis. Les ateliers sont également une excellente occasion de rencontrer d\'autres passionnés de cuisine et de partager des astuces et des recettes.\n\nLa lecture de livres de cuisine est également une source d\'inspiration infinie. Des chefs renommés et des auteurs culinaires partagent leurs secrets et leurs recettes dans des livres magnifiquement illustrés. En explorant ces ouvrages, vous pouvez découvrir de nouvelles cuisines, expérimenter des recettes innovantes et améliorer vos compétences en suivant des instructions détaillées.\n\nPour ceux qui aiment l\'aventure, la cuisine expérimentale est une activité passionnante. Essayez de créer vos propres recettes en combinant des ingrédients et des techniques inattendus. La cuisine moléculaire, par exemple, utilise des principes scientifiques pour créer des textures et des saveurs uniques. Expérimenter avec des recettes est non seulement amusant, mais peut également conduire à des découvertes culinaires délicieuses et originales.\n\nEnfin, participer à des événements culinaires tels que des festivals gastronomiques, des foires alimentaires ou des dégustations de vin peut élargir votre palette et enrichir votre compréhension de la cuisine. Ces événements offrent l\'opportunité de goûter à des plats de chefs locaux, de découvrir des produits artisanaux et de rencontrer des experts culinaires.\n\nEn conclusion, la cuisine comme loisir offre une multitude de façons d\'explorer et d\'apprécier la nourriture. Que vous soyez débutant ou cuisinier expérimenté, il y a toujours de nouvelles techniques à apprendre, des recettes à essayer et des saveurs à découvrir. Enrichissez votre quotidien en plongeant dans le monde culinaire et en faisant de chaque repas une aventure savoureuse.', NULL, 1, 35497, 30, 6, 1, 1, NULL, '2024-05-13 18:26:39', '2024-05-13 21:09:41', NULL),
(34, 'Le Jardinage : Cultiver la Nature et le Bien-Être', 'Le jardinage est un loisir enrichissant qui permet de se connecter à la nature, de créer un espace de beauté et de tranquillité, et de récolter des fruits, des légumes et des fleurs cultivés de vos propres mains. Que vous disposiez d\'un vaste jardin, d\'un petit balcon ou même d\'un coin de votre maison, le jardinage offre des bénéfices multiples pour la santé mentale et physique.\n\nCommencez par planifier votre espace de jardinage. Si vous avez un jardin extérieur, déterminez les zones ensoleillées et ombragées et choisissez les plantes en conséquence. Pour ceux qui disposent d\'un espace limité, le jardinage en pots ou en conteneurs est une excellente option. Les plantes aromatiques, les légumes nains et les fleurs annuelles se développent bien dans des pots et ajoutent de la verdure et de la couleur à n\'importe quel espace.\n\nLe compostage est une pratique essentielle pour tout jardinier. En recyclant les déchets organiques de votre cuisine et de votre jardin, vous pouvez créer un compost riche en nutriments qui améliore la qualité du sol et favorise la croissance des plantes. Le compostage réduit également les déchets ménagers et soutient un mode de vie plus durable.\n\nPour les amateurs de jardinage urbain, la culture hydroponique est une technique innovante qui permet de cultiver des plantes sans sol, en utilisant une solution nutritive à base d\'eau. Cette méthode est idéale pour les espaces intérieurs ou les petits balcons et peut produire des herbes fraîches, des légumes et même des fleurs toute l\'année.\n\nLe jardinage communautaire est une autre façon de pratiquer ce loisir tout en renforçant les liens sociaux. De nombreuses villes offrent des jardins partagés où les résidents peuvent cultiver des parcelles de terre ensemble. Cela permet non seulement de partager des ressources et des connaissances, mais aussi de créer un sentiment de communauté et de collaboration.\n\nEnfin, n\'oubliez pas les jardins sensoriels, conçus pour stimuler les sens à travers les plantes. Choisissez des plantes aux textures variées, des herbes aromatiques et des fleurs colorées pour créer un espace qui éveille la vue, l\'odorat et le toucher. Un jardin sensoriel peut être un lieu de relaxation et de méditation, offrant un refuge paisible pour échapper au stress quotidien.\n\nEn conclusion, le jardinage est un loisir qui offre une multitude de bénéfices, de la satisfaction de cultiver ses propres plantes à l\'amélioration de la santé mentale et physique. Que vous soyez un jardinier débutant ou expérimenté, il existe de nombreuses façons de rendre votre espace de jardinage unique et productif. Plongez vos mains dans la terre et découvrez la joie de faire pousser des plantes tout en cultivant votre bien-être.', NULL, 1, 9548, 30, 6, 1, 1, NULL, '2024-05-13 18:26:55', '2024-05-13 21:09:41', NULL),
(35, 'La Lecture : Un Voyage Intérieur sans Limites', 'La lecture est un loisir intemporel qui permet de voyager à travers le temps et l\'espace, d\'explorer des mondes imaginaires et de découvrir des idées nouvelles sans jamais quitter le confort de votre maison. Que vous soyez passionné de romans, de poésie, d\'essais ou de bandes dessinées, la lecture offre une évasion enrichissante et une source inépuisable de connaissance et de plaisir.\n\nPour les amateurs de fiction, les romans offrent des récits captivants qui explorent la condition humaine, les relations et les cultures. Des classiques de la littérature mondiale comme \"Les Misérables\" de Victor Hugo ou \"Pride and Prejudice\" de Jane Austen, aux best-sellers contemporains, il y a toujours un livre pour chaque goût et chaque moment de la vie. La fiction permet de développer l\'empathie et d\'élargir votre perspective en vous plongeant dans les vies et les expériences des personnages.\n\nLa non-fiction est une autre facette enrichissante de la lecture. Les biographies, les mémoires et les essais offrent des aperçus profonds sur la vie de personnalités fascinantes, des événements historiques et des sujets d\'actualité. Lire des œuvres de non-fiction peut vous inspirer, vous éduquer et vous motiver à explorer de nouveaux domaines d\'intérêt. Des livres comme \"Sapiens: Une brève histoire de l\'humanité\" de Yuval Noah Harari ou \"Becoming\" de Michelle Obama sont des exemples de lectures qui combinent narration et apprentissage.\n\nLes livres de développement personnel sont également populaires parmi les lecteurs qui cherchent à améliorer leur vie quotidienne. Des titres comme \"The Power of Now\" d\'Eckhart Tolle ou \"Atomic Habits\" de James Clear offrent des conseils pratiques et des stratégies pour développer de nouvelles compétences, adopter des habitudes saines et atteindre vos objectifs personnels et professionnels.\n\nLa poésie est une forme de lecture qui permet d\'explorer la beauté et la profondeur du langage. Les recueils de poèmes peuvent offrir des moments de réflexion et de méditation, capturant des émotions et des expériences humaines avec une intensité unique. Des poètes comme Rumi, Pablo Neruda et Maya Angelou ont écrit des œuvres qui touchent l\'âme et inspirent la contemplation.\n\nPour les jeunes lecteurs et les amateurs de visuels, les bandes dessinées et les romans graphiques sont des genres qui combinent art et narration. Des classiques comme \"Tintin\" et \"Astérix\" aux œuvres contemporaines comme \"Persepolis\" de Marjane Satrapi, les bandes dessinées offrent une manière dynamique et engageante de lire. Ces formats sont également excellents pour encourager les enfants à développer une habitude de lecture.\n\nEn conclusion, la lecture est un loisir qui enrichit l\'esprit et nourrit l\'imagination. Que vous préfériez la fiction, la non-fiction, la poésie ou les bandes dessinées, il y a toujours un livre qui peut captiver votre intérêt et élargir vos horizons. Prenez le temps de lire et laissez-vous transporter par les mots dans des aventures infinies.', NULL, 1, 16215, 30, 6, 1, 1, NULL, '2024-05-13 18:27:12', '2024-05-13 21:09:41', NULL),
(36, 'Les Jeux de Société : Divertissement et Connexion Sociale', 'Les jeux de société sont un moyen fantastique de passer du temps de qualité avec la famille et les amis, tout en stimulant l\'esprit et en favorisant la convivialité. Ils offrent une variété de styles et de genres, adaptés à tous les âges et à tous les goûts, des jeux stratégiques complexes aux jeux de cartes rapides et amusants. Plonger dans le monde des jeux de société peut transformer une soirée ordinaire en une expérience mémorable et enrichissante.\n\nLes jeux de stratégie, comme \"Les Colons de Catane\" ou \"Risk\", sont parfaits pour ceux qui aiment les défis intellectuels. Ces jeux exigent de la planification, de la réflexion tactique et de la gestion des ressources. Ils sont idéaux pour les joueurs qui aiment élaborer des stratégies complexes et prendre des décisions critiques qui influencent le cours du jeu.\n\nPour des sessions de jeu plus légères et rapides, les jeux de cartes comme \"Uno\" ou \"Exploding Kittens\" sont d\'excellents choix. Faciles à apprendre et rapides à jouer, ces jeux sont parfaits pour les rassemblements sociaux et les soirées en famille. Ils offrent des moments de rire et de compétition amicale, tout en étant accessibles à un large public.\n\nLes jeux coopératifs, où les joueurs travaillent ensemble pour atteindre un objectif commun, sont de plus en plus populaires. Des jeux comme \"Pandemic\" ou \"Forbidden Island\" encouragent la collaboration et la communication, renforçant les compétences de travail en équipe et de résolution de problèmes. Ces jeux sont parfaits pour ceux qui préfèrent l\'esprit de coopération à la compétition.\n\nLes jeux de rôle sur table (RPG), comme \"Donjons et Dragons\", offrent une expérience de jeu immersive et narrative. Les joueurs incarnent des personnages et créent des histoires ensemble, guidés par un maître de jeu. Les RPG favorisent la créativité, l\'imagination et les compétences sociales, tout en offrant des aventures épiques et des moments inoubliables.\n\nEnfin, les jeux de société éducatifs sont une excellente manière d\'apprendre tout en s\'amusant. Des jeux comme \"Scrabble\" ou \"Trivial Pursuit\" stimulent le vocabulaire et les connaissances générales, tandis que des jeux comme \"Catan Junior\" ou \"The Magic Labyrinth\" sont conçus pour développer les compétences cognitives des enfants de manière ludique.\n\nEn conclusion, les jeux de société sont un loisir polyvalent qui offre divertissement, stimulation intellectuelle et connexion sociale. Que vous soyez un stratège chevronné ou un amateur de jeux occasionnels, il existe un jeu de société pour chaque occasion. Organisez une soirée de jeux, rassemblez vos proches et profitez des plaisirs simples et des défis passionnants que les jeux de société peuvent offrir.', NULL, 1, 62062, 30, 6, 1, 1, NULL, '2024-05-13 18:27:36', '2024-05-13 21:09:41', NULL),
(37, 'Les Danses Traditionnelles Françaises : Un Patrimoine Culturel Vivant', 'Les danses traditionnelles françaises sont un aspect essentiel du patrimoine culturel du pays, reflétant la diversité et la richesse des régions. Chaque danse raconte une histoire, transmet des valeurs et renforce les liens communautaires, faisant de ces pratiques un héritage vivant qui continue d\'être célébré aujourd\'hui.\n\nEn Bretagne, les danses bretonnes sont au cœur des fest-noz, des fêtes de nuit où les habitants se réunissent pour danser en cercle ou en chaîne. Parmi les danses les plus populaires, on trouve l\'andro, le plinn, et le gavotte, chacune ayant ses propres pas et rythmes spécifiques. Les fest-noz sont accompagnées de musique traditionnelle bretonne, jouée sur des instruments comme la bombarde, le biniou (cornemuse bretonne) et l\'accordéon. Ces danses, autrefois pratiquées dans les fermes et les villages, sont aujourd\'hui une part importante de l\'identité culturelle bretonne.\n\nLa bourrée est une danse traditionnelle des régions du Massif central, comme l\'Auvergne et le Limousin. La bourrée peut être dansée en couple ou en groupe, avec des mouvements vifs et rythmés. Elle est souvent accompagnée par des instruments tels que la vielle à roue, la cabrette (cornemuse auvergnate) et l\'accordéon. La bourrée est une danse joyeuse et énergique, qui reflète le caractère festif des communautés rurales.\n\nEn Provence, la farandole est une danse en chaîne populaire, où les danseurs se tiennent par la main et forment de longues lignes sinueuses. La farandole est souvent dansée lors des fêtes de village et des festivals, accompagnée par des tambourins et des galoubets (flûtes provençales). Cette danse symbolise l\'unité et la solidarité de la communauté, et elle est souvent pratiquée lors des célébrations de Noël et des fêtes patronales.\n\nLa gigue, originaire des régions de l\'Est de la France, comme la Lorraine et l\'Alsace, est une danse vive et rythmée, souvent accompagnée par des violons et des accordéons. La gigue se caractérise par des sauts et des mouvements rapides des pieds, nécessitant une grande agilité et endurance. Cette danse est souvent exécutée lors des fêtes locales et des mariages, ajoutant une ambiance joyeuse et dynamique aux célébrations.\n\nLe cancan, bien que souvent associé aux cabarets parisiens comme le Moulin Rouge, est également considéré comme une danse traditionnelle française. Originaire des bals publics de Paris au XIXe siècle, le cancan est une danse haute en énergie, connue pour ses mouvements de jambes acrobatiques et ses jupes volantées. Le cancan incarne l\'esprit festif et exubérant de la culture parisienne.\n\nEn conclusion, les danses traditionnelles françaises sont une expression vivante de l\'histoire et de la culture des régions. Elles jouent un rôle important dans la préservation des traditions et dans la création de liens communautaires. En célébrant ces danses, les Français honorent leur patrimoine culturel tout en transmettant ces pratiques aux générations futures.', NULL, 1, 13566, 31, 3, 1, 1, NULL, '2024-05-13 18:29:37', '2024-05-13 21:09:41', NULL),
(38, 'Conseils de Placement d\'Argent : Stratégies pour Construire un Avenir Financier Sain', 'Investir de manière judicieuse est essentiel pour construire un avenir financier stable et prospère. Que vous soyez un investisseur novice ou expérimenté, il est crucial de comprendre les différentes options de placement disponibles et de développer une stratégie adaptée à vos objectifs et à votre tolérance au risque. Voici quelques conseils pratiques pour optimiser vos placements d\'argent et maximiser vos rendements.\n\nDiversifiez Votre Portefeuille\nLa diversification est une règle d\'or en matière d\'investissement. En répartissant vos investissements sur différentes classes d\'actifs, comme les actions, les obligations, l\'immobilier et les produits dérivés, vous pouvez réduire le risque global de votre portefeuille. La diversification permet de compenser les pertes potentielles dans une catégorie d\'actifs par des gains dans une autre, assurant ainsi une meilleure stabilité financière.\n\nInvestissez dans les Fonds Indiciel et les ETF\nLes fonds indiciels et les fonds négociés en bourse (ETF) sont des options d\'investissement populaires pour ceux qui cherchent à diversifier leur portefeuille à faible coût. Ces fonds suivent la performance d\'un indice de marché, comme le S&P 500, et offrent une exposition à un large éventail d\'actions ou d\'obligations. Les ETF, en particulier, sont appréciés pour leur liquidité et leurs faibles frais de gestion, ce qui les rend accessibles et attrayants pour les investisseurs à long terme.\n\nConsidérez l\'Immobilier\nL\'immobilier est une classe d\'actifs tangible qui peut offrir des revenus réguliers et une appréciation du capital. Investir dans des biens immobiliers locatifs, des REIT (Real Estate Investment Trusts) ou même des plateformes de crowdfunding immobilier peut diversifier davantage votre portefeuille et générer des flux de trésorerie constants. L\'immobilier est également souvent perçu comme une couverture contre l\'inflation, car les loyers et la valeur des biens ont tendance à augmenter avec le temps.\n\nExplorez les Placements à Long Terme\nLes placements à long terme, tels que les actions de croissance ou les obligations d\'État, peuvent offrir des rendements substantiels sur une période prolongée. Investir dans des entreprises solides avec des perspectives de croissance à long terme peut augmenter considérablement la valeur de votre portefeuille. Les obligations d\'État, quant à elles, offrent une sécurité et des rendements stables, même si ceux-ci sont généralement plus faibles que ceux des actions.\n\nUtilisez les Comptes Fiscalement Avantageux\nMaximiser l\'utilisation des comptes fiscalement avantageux, comme les comptes de retraite (IRA, 401(k)) ou les comptes d\'épargne éducatifs (529 plans), peut améliorer vos rendements nets en minimisant votre charge fiscale. Ces comptes offrent des avantages fiscaux, comme des déductions d\'impôts, des croissances exonérées d\'impôts ou des retraits non imposables, ce qui peut grandement contribuer à l\'accumulation de richesse sur le long terme.\n\nRestez Informé et Éduqué\nLes marchés financiers sont dynamiques et peuvent être influencés par une multitude de facteurs économiques, politiques et sociaux. Il est donc crucial de rester informé et d\'éduquer continuellement sur les tendances du marché, les nouvelles opportunités d\'investissement et les stratégies financières. Lire des livres sur l\'investissement, suivre des cours en ligne, et consulter des experts financiers peut vous aider à prendre des décisions d\'investissement éclairées et stratégiques.\n\nConsultez un Conseiller Financier\nSi vous êtes incertain quant à vos choix d\'investissement ou si vous avez des objectifs financiers complexes, il peut être judicieux de consulter un conseiller financier professionnel. Un conseiller peut vous aider à évaluer votre situation financière, à définir des objectifs clairs et à élaborer un plan de placement personnalisé. Ils peuvent également offrir des conseils sur la gestion des risques et vous aider à naviguer dans les marchés financiers.\n\nEn conclusion, une stratégie de placement d\'argent bien pensée et diversifiée est essentielle pour atteindre vos objectifs financiers à long terme. En comprenant vos options, en diversifiant votre portefeuille et en restant informé, vous pouvez maximiser vos rendements et assurer une sécurité financière durable. Investir de manière judicieuse aujourd\'hui peut ouvrir la voie à une prospérité future et à la réalisation de vos rêves financiers.', NULL, 1, 13662, 31, 7, 1, 1, NULL, '2024-05-13 18:30:16', '2024-05-13 21:09:41', NULL),
(39, 'Leadership Efficace : Clés pour Inspirer et Motiver Votre Équipe', 'Le leadership efficace est essentiel pour le succès de toute organisation. Un bon leader sait inspirer, motiver et guider son équipe vers l\'atteinte des objectifs communs. Que vous soyez un leader expérimenté ou en devenir, ces conseils pratiques vous aideront à renforcer vos compétences en leadership et à créer un environnement de travail positif et productif.\n\nDéveloppez une Vision Claire\nUn leader efficace doit avoir une vision claire et inspirante pour l\'avenir de l\'équipe ou de l\'organisation. Cette vision doit être communiquée de manière transparente et régulièrement rappelée pour maintenir l\'alignement et l\'engagement de l\'équipe. Assurez-vous que chaque membre de l\'équipe comprend comment son travail contribue à la réalisation de cette vision globale.\n\nFavorisez une Culture de Confiance et de Respect\nLa confiance et le respect sont les fondements d\'un environnement de travail harmonieux. Encouragez la transparence, l\'honnêteté et l\'intégrité dans toutes les interactions. Montrez de la reconnaissance pour les contributions de chacun et créez un espace où les opinions et les idées sont valorisées et respectées. Une culture de confiance favorise la collaboration et la créativité, et réduit les conflits.\n\nCommuniquez Efficacement\nLa communication est une compétence clé pour un leader. Soyez clair, concis et cohérent dans vos messages. Écoutez activement vos collègues et montrez de l\'empathie envers leurs préoccupations. Utilisez différents canaux de communication, comme les réunions en personne, les e-mails et les plateformes de collaboration en ligne, pour vous assurer que tout le monde est informé et aligné.\n\nEncouragez le Développement Personnel et Professionnel\nInvestir dans le développement de vos employés est crucial pour leur engagement et leur satisfaction. Offrez des opportunités de formation, de mentorat et de croissance professionnelle. Encouragez-les à fixer des objectifs de développement personnels et professionnels et soutenez-les dans leur parcours. Un environnement de travail qui valorise l\'apprentissage continu attire et retient les talents.\n\nPratiquez la Décision Collaborative\nImpliquer votre équipe dans le processus décisionnel peut augmenter l\'engagement et la satisfaction des employés. Sollicitez des avis et des idées de votre équipe avant de prendre des décisions importantes. Cela montre que vous valorisez leurs contributions et que vous êtes ouvert à diverses perspectives. La prise de décision collaborative peut également conduire à des solutions plus créatives et efficaces.\n\nEn conclusion, le leadership efficace repose sur une combinaison de vision, de communication, de confiance et de développement continu. En appliquant ces principes, vous pouvez inspirer et motiver votre équipe, créer un environnement de travail positif et atteindre vos objectifs organisationnels avec succès.\n\nLa Négociation : Stratégies pour des Résultats Gagnant-Gagnant\nLa négociation est une compétence essentielle dans le monde professionnel, que ce soit pour conclure un contrat, obtenir une augmentation ou résoudre un conflit. Maîtriser l\'art de la négociation peut vous aider à atteindre des résultats avantageux pour toutes les parties impliquées. Voici des stratégies pratiques pour mener des négociations efficaces et obtenir des résultats gagnant-gagnant.\n\nPréparez-Vous Soigneusement\nLa préparation est la clé d\'une négociation réussie. Rassemblez toutes les informations pertinentes sur le sujet de la négociation, y compris les besoins, les attentes et les points de vue des autres parties. Établissez vos objectifs et identifiez vos points de négociation les plus importants, ainsi que ceux sur lesquels vous êtes prêt à faire des compromis. Une préparation minutieuse vous donnera confiance et vous aidera à anticiper les objections et les contre-arguments.\n\nÉcoutez Activement\nL\'écoute active est cruciale pour comprendre les besoins et les préoccupations de l\'autre partie. Montrez de l\'empathie et de l\'intérêt pour leurs points de vue et posez des questions ouvertes pour clarifier leurs positions. En écoutant attentivement, vous pouvez identifier des domaines de convergence et des opportunités de compromis. L\'écoute active renforce également la confiance et la coopération entre les parties.\n\nAdoptez une Attitude de Collaboration\nPlutôt que d\'aborder la négociation comme une confrontation, adoptez une attitude de collaboration. Cherchez des solutions mutuellement bénéfiques et mettez l\'accent sur les intérêts communs plutôt que sur les positions divergentes. Utilisez des expressions telles que \"nous\" et \"ensemble\" pour renforcer l\'idée de coopération. Une attitude de collaboration peut conduire à des accords plus durables et satisfaisants pour toutes les parties.\n\nUtilisez des Techniques de Persuasion\nLes techniques de persuasion peuvent être utiles pour influencer positivement l\'autre partie. Par exemple, la réciprocité consiste à offrir quelque chose de valeur à l\'autre partie pour encourager un geste en retour. L\'ancrage implique de présenter une proposition initiale élevée pour influencer les attentes de l\'autre partie. Utilisez ces techniques de manière éthique et respectueuse pour renforcer votre position et favoriser une issue positive.\n\nSoyez Prêt à Faire des Concessions\nLa flexibilité est essentielle dans toute négociation. Soyez prêt à faire des concessions sur certains points pour atteindre un accord global satisfaisant. Identifiez les domaines où vous pouvez être flexible sans compromettre vos objectifs principaux. Les concessions mutuelles montrent une volonté de coopération et peuvent faciliter l\'atteinte d\'un consensus.\n\nEn conclusion, la négociation efficace repose sur une préparation minutieuse, une écoute active, une attitude de collaboration, des techniques de persuasion et une disposition à faire des concessions. En appliquant ces stratégies, vous pouvez mener des négociations réussies qui aboutissent à des résultats gagnant-gagnant, renforçant ainsi vos relations professionnelles et atteignant vos objectifs.', NULL, 1, 1242, 31, 7, 1, 1, NULL, '2024-05-13 18:30:50', '2024-05-13 21:09:41', NULL),
(40, 'La Gestion de Conflits : Transformer les Défis en Opportunités', 'Les conflits sont inévitables dans tout environnement professionnel, mais leur gestion efficace est cruciale pour maintenir un climat de travail harmonieux et productif. La gestion de conflits implique des compétences en communication, en empathie et en résolution de problèmes. Voici des stratégies pratiques pour transformer les conflits en opportunités de croissance et de collaboration.\n\nIdentifiez les Causes Sous-Jacentes\nLa première étape dans la gestion des conflits est d\'identifier les causes sous-jacentes. Les conflits peuvent découler de malentendus, de différences de valeurs, de besoins non satisfaits ou de problèmes de communication. En comprenant la source du conflit, vous pouvez aborder les problèmes de manière plus ciblée et efficace. Prenez le temps d\'écouter toutes les parties impliquées pour obtenir une vue d\'ensemble complète de la situation.\n\nPratiquez l\'Écoute Active et l\'Empathie\nL\'écoute active et l\'empathie sont essentielles pour résoudre les conflits. Montrez de l\'empathie en reconnaissant les sentiments et les perspectives de chaque partie. Posez des questions ouvertes et reformulez leurs points de vue pour montrer que vous comprenez leurs préoccupations. L\'écoute active et l\'empathie peuvent réduire les tensions et ouvrir la voie à un dialogue constructif.\n\nFavorisez une Communication Ouverte et Respectueuse\nEncouragez une communication ouverte et respectueuse entre les parties en conflit. Établissez des règles de base pour la discussion, telles que l\'absence d\'interruptions, le respect des opinions des autres et l\'utilisation de déclarations \"je\" pour exprimer des sentiments personnels plutôt que des accusations. Une communication ouverte permet de clarifier les malentendus et de trouver des solutions mutuellement acceptables.\n\nRecherchez des Solutions Gagnant-Gagnant\nL\'objectif de la gestion des conflits est de trouver des solutions qui répondent aux besoins de toutes les parties impliquées. Recherchez des solutions créatives et collaboratives qui offrent des avantages à chacun. Impliquez les parties dans le processus de résolution en leur demandant de proposer des idées et des alternatives. Une approche gagnant-gagnant favorise la coopération et renforce les relations.\n\nUtilisez des Techniques de Médiation\nLa médiation peut être un outil précieux pour gérer les conflits. En tant que médiateur, vous pouvez faciliter la communication entre les parties, aider à clarifier les problèmes et guider le processus de résolution. Les techniques de médiation incluent la reformulation des points de vue, la gestion des émotions et la négociation de compromis. La médiation peut aider à trouver des solutions équitables et à restaurer la confiance.\n\nEn conclusion, la gestion des conflits nécessite des compétences en écoute active, en empathie, en communication et en médiation. En adoptant ces stratégies, vous pouvez transformer les conflits en opportunités de croissance, renforcer les relations professionnelles et créer un environnement de travail plus harmonieux et productif.', NULL, 1, 34293, 31, 7, 1, 1, NULL, '2024-05-13 18:31:09', '2024-05-13 21:09:41', NULL),
(41, 'La Gestion de Conflits : Transformer les Défis en Opportunités', 'Les conflits sont inévitables dans tout environnement professionnel, mais leur gestion efficace est cruciale pour maintenir un climat de travail harmonieux et productif. La gestion de conflits implique des compétences en communication, en empathie et en résolution de problèmes. Voici des stratégies pratiques pour transformer les conflits en opportunités de croissance et de collaboration.\n\nIdentifiez les Causes Sous-Jacentes\nLa première étape dans la gestion des conflits est d\'identifier les causes sous-jacentes. Les conflits peuvent découler de malentendus, de différences de valeurs, de besoins non satisfaits ou de problèmes de communication. En comprenant la source du conflit, vous pouvez aborder les problèmes de manière plus ciblée et efficace. Prenez le temps d\'écouter toutes les parties impliquées pour obtenir une vue d\'ensemble complète de la situation.\n\nPratiquez l\'Écoute Active et l\'Empathie\nL\'écoute active et l\'empathie sont essentielles pour résoudre les conflits. Montrez de l\'empathie en reconnaissant les sentiments et les perspectives de chaque partie. Posez des questions ouvertes et reformulez leurs points de vue pour montrer que vous comprenez leurs préoccupations. L\'écoute active et l\'empathie peuvent réduire les tensions et ouvrir la voie à un dialogue constructif.\n\nFavorisez une Communication Ouverte et Respectueuse\nEncouragez une communication ouverte et respectueuse entre les parties en conflit. Établissez des règles de base pour la discussion, telles que l\'absence d\'interruptions, le respect des opinions des autres et l\'utilisation de déclarations \"je\" pour exprimer des sentiments personnels plutôt que des accusations. Une communication ouverte permet de clarifier les malentendus et de trouver des solutions mutuellement acceptables.\n\nRecherchez des Solutions Gagnant-Gagnant\nL\'objectif de la gestion des conflits est de trouver des solutions qui répondent aux besoins de toutes les parties impliquées. Recherchez des solutions créatives et collaboratives qui offrent des avantages à chacun. Impliquez les parties dans le processus de résolution en leur demandant de proposer des idées et des alternatives. Une approche gagnant-gagnant favorise la coopération et renforce les relations.\n\nUtilisez des Techniques de Médiation\nLa médiation peut être un outil précieux pour gérer les conflits. En tant que médiateur, vous pouvez faciliter la communication entre les parties, aider à clarifier les problèmes et guider le processus de résolution. Les techniques de médiation incluent la reformulation des points de vue, la gestion des émotions et la négociation de compromis. La médiation peut aider à trouver des solutions équitables et à restaurer la confiance.\n\nEn conclusion, la gestion des conflits nécessite des compétences en écoute active, en empathie, en communication et en médiation. En adoptant ces stratégies, vous pouvez transformer les conflits en opportunités de croissance, renforcer les relations professionnelles et créer un environnement de travail plus harmonieux et productif.', NULL, 1, 18144, 31, 7, 1, 1, NULL, '2024-05-13 18:31:35', '2024-05-13 21:09:41', NULL);
INSERT INTO `ressources` (`id_ressource`, `label`, `description`, `content`, `is_public`, `view_count`, `id_user`, `id_category`, `id_status`, `id_type`, `file`, `created_at`, `updated_at`, `staff_comment`) VALUES
(42, 'L\'Innovation au Lieu de Travail : Cultiver une Culture de Créativité et de Progrès', 'L\'innovation est un moteur essentiel de la croissance et du succès dans le monde professionnel moderne. Cultiver une culture d\'innovation au sein de votre organisation peut conduire à des améliorations continues, à des solutions créatives et à un avantage concurrentiel. Voici des stratégies pratiques pour favoriser l\'innovation au lieu de travail et encourager une pensée créative.\n\nEncouragez la Curiosité et l\'Apprentissage Continu\nUne culture d\'innovation commence par la curiosité et l\'apprentissage continu. Encouragez vos employés à poser des questions, à explorer de nouvelles idées et à rechercher des opportunités d\'apprentissage. Offrez des formations, des ateliers et des ressources pour développer les compétences et les connaissances. L\'apprentissage continu stimule la créativité et permet aux employés de rester à jour avec les dernières tendances et technologies.\n\nFavorisez la Collaboration Interdisciplinaire\nLa collaboration interdisciplinaire est un catalyseur puissant pour l\'innovation. Rassemblez des équipes composées de membres ayant des compétences et des perspectives diverses. Encouragez le partage d\'idées et la collaboration entre les départements. Les échanges d\'idées entre différentes disciplines peuvent conduire à des solutions novatrices et à des approches uniques pour résoudre les problèmes.\n\nCréez un Environnement Propice à l\'Innovation\nUn environnement de travail qui favorise l\'innovation est essentiel. Aménagez des espaces de travail collaboratifs où les employés peuvent échanger des idées librement. Offrez des outils et des technologies qui facilitent la créativité et la collaboration. Récompensez les initiatives innovantes et reconnaissez les contributions des employés qui proposent des idées nouvelles et amélioratrices.\n\nAdoptez une Mentalité de Prise de Risque Calculée\nL\'innovation implique souvent de prendre des risques. Encouragez une mentalité de prise de risque calculée en créant un environnement où les erreurs sont vues comme des opportunités d\'apprentissage. Permettez aux employés d\'expérimenter de nouvelles idées sans craindre les répercussions négatives. La tolérance à l\'échec et la volonté de prendre des risques peuvent conduire à des découvertes révolutionnaires et à des avancées significatives.\n\nImplémentez des Processus d\'Innovation Structurés\nDes processus structurés peuvent aider à canaliser la créativité et à transformer les idées en actions concrètes. Utilisez des méthodologies d\'innovation comme le design thinking, l\'agile ou le lean pour guider le développement et la mise en œuvre de nouvelles idées. Ces approches offrent des cadres pour explorer, prototyper et tester des solutions de manière itérative et collaborative.\n\nEn conclusion, l\'innovation au lieu de travail est essentielle pour maintenir la compétitivité et favoriser la croissance. En encourageant la curiosité, la collaboration, la prise de risque et en mettant en place des processus structurés, vous pouvez créer une culture d\'innovation qui inspire la créativité et conduit à des progrès significatifs. Cultivez l\'innovation pour propulser votre organisation vers de nouveaux sommets de succès et de performance.', NULL, 1, 28014, 31, 7, 1, 1, NULL, '2024-05-13 18:31:47', '2024-05-13 21:09:41', NULL),
(43, 'Les Traditions Artisanales en France : Savoir-Faire et Héritage Culturel', 'Les traditions artisanales en France sont le reflet d\'un riche héritage culturel et d\'un savoir-faire transmis de génération en génération. Ces pratiques artisanales, qu\'elles soient liées à la poterie, à la tapisserie, à la coutellerie ou à la viticulture, sont des témoignages vivants de l\'histoire et de l\'identité régionale de la France.\n\nLa poterie de Soufflenheim en Alsace est une tradition artisanale qui remonte au Moyen Âge. Les potiers de Soufflenheim utilisent des techniques ancestrales pour créer des poteries colorées et fonctionnelles, souvent décorées de motifs floraux et d\'animaux. Les plats à baeckeoffe, les moules à kouglof et les terrines sont des produits typiques de cette région, reflétant à la fois la culture culinaire alsacienne et le savoir-faire artisanal local.\n\nLa tapisserie d\'Aubusson, dans le Limousin, est une autre tradition artisanale prestigieuse, inscrite au patrimoine culturel immatériel de l\'humanité par l\'UNESCO. Depuis le XIVe siècle, les ateliers d\'Aubusson produisent des tapisseries d\'une qualité exceptionnelle, utilisant des techniques de tissage complexes et des matériaux de haute qualité. Les tapisseries d\'Aubusson ornent les murs des châteaux, des palais et des musées du monde entier, symbolisant l\'excellence artistique et technique de cette région.\n\nLa coutellerie de Laguiole, dans l\'Aveyron, est renommée pour ses couteaux artisanaux, fabriqués avec précision et expertise. Chaque couteau Laguiole est une œuvre d\'art, souvent ornée d\'une abeille ou d\'une croix de berger. Les couteliers utilisent des matériaux nobles comme le bois d\'olivier, la corne et l\'acier inoxydable pour créer des couteaux à la fois beaux et fonctionnels. La tradition de la coutellerie de Laguiole est un symbole de l\'authenticité et du savoir-faire artisanal français.\n\nLa viticulture, bien que largement industrialisée, conserve également des traditions artisanales, notamment dans les régions viticoles comme la Bourgogne, la Champagne et le Bordelais. Les vignerons utilisent des techniques traditionnelles pour cultiver leurs vignes, vendanger manuellement et vinifier leurs raisins. Ces pratiques artisanales, combinées à des terroirs uniques, donnent naissance à des vins d\'exception, reconnus et appréciés dans le monde entier. La culture de la vigne et la production de vin sont des éléments essentiels du patrimoine culturel français.\n\nLa broderie de Lunéville, en Lorraine, est une technique artisanale délicate utilisée pour embellir des tissus avec des perles, des paillettes et des fils d\'or ou d\'argent. La broderie de Lunéville, également connue sous le nom de \"point de Lunéville\", est utilisée dans la haute couture pour créer des motifs élaborés et luxueux sur des robes de soirée, des accessoires et des costumes de scène. Cette tradition artisanale met en valeur la créativité et l\'habileté des artisans français.\n\nEn conclusion, les traditions artisanales en France sont un témoignage précieux de l\'histoire et de la culture des régions. Elles incarnent l\'excellence, la créativité et le dévouement des artisans français, qui perpétuent ces savoir-faire avec passion et fierté. En découvrant ces traditions, on accède à une compréhension plus profonde de l\'identité culturelle française et à une appréciation des arts et des métiers qui continuent de prospérer dans le pays.', NULL, 1, 2849, 32, 3, 1, 1, NULL, '2024-05-13 18:32:56', '2024-05-13 21:09:41', NULL),
(44, 'Encourager l\'Autonomie chez les Enfants : Clés pour un Développement Sain et Épanoui', 'Encourager l\'autonomie chez les enfants est essentiel pour leur développement personnel et leur confiance en eux. En leur permettant de prendre des décisions, d\'assumer des responsabilités et de résoudre des problèmes par eux-mêmes, vous les aidez à devenir des individus indépendants et compétents. Voici des stratégies pratiques pour encourager l\'autonomie à chaque étape du développement de votre enfant.\n\nOffrez des Choix Appropriés\nDès le plus jeune âge, offrir des choix à vos enfants leur permet de développer leur sens de l\'indépendance et de la responsabilité. Proposez des options adaptées à leur âge et laissez-les décider. Par exemple, vous pouvez leur demander de choisir entre deux tenues à porter ou de décider quel légume inclure dans le dîner. Offrir des choix aide les enfants à développer leurs compétences décisionnelles et à se sentir valorisés.\n\nEncouragez la Résolution de Problèmes\nEncourager vos enfants à résoudre leurs propres problèmes renforce leur confiance en eux et leur capacité à faire face aux défis. Plutôt que de leur donner des solutions toutes faites, posez-leur des questions pour les guider dans leur réflexion. Par exemple, demandez-leur : \"Quelles sont les options possibles pour résoudre ce problème ?\" ou \"Que penses-tu qu\'il faudrait faire ensuite ?\". Cette approche les aide à développer leur pensée critique et leur autonomie.\n\nFixez des Limites et des Attentes Claires\nBien que l\'autonomie soit importante, il est également crucial de fixer des limites et des attentes claires. Expliquez les règles et les raisons derrière celles-ci, et assurez-vous que vos enfants comprennent les conséquences de leurs actions. Des limites claires offrent un cadre sécurisant dans lequel les enfants peuvent explorer leur indépendance de manière responsable.\n\nEncouragez les Tâches Ménagères\nImpliquer vos enfants dans les tâches ménagères est un excellent moyen de leur enseigner la responsabilité et l\'autonomie. Attribuez-leur des tâches adaptées à leur âge, comme ranger leurs jouets, mettre la table ou aider à préparer les repas. Valorisez leurs efforts et montrez-leur comment accomplir ces tâches de manière efficace. Participer aux tâches ménagères renforce leur sentiment de contribution et de compétence.\n\nSoyez un Modèle d\'Autonomie\nLes enfants apprennent beaucoup en observant leurs parents. Montrez-leur comment vous prenez des décisions, résolvez des problèmes et gérez vos responsabilités. Parlez ouvertement de vos processus de réflexion et de vos expériences, et encouragez-les à poser des questions. Être un modèle d\'autonomie aide vos enfants à comprendre l\'importance de ces compétences dans la vie quotidienne.\n\nEn conclusion, encourager l\'autonomie chez les enfants est essentiel pour leur développement sain et épanoui. En offrant des choix, en encourageant la résolution de problèmes, en fixant des limites claires, en impliquant vos enfants dans les tâches ménagères et en étant un modèle d\'autonomie, vous pouvez les aider à devenir des individus indépendants, confiants et responsables.', NULL, 1, 14168, 32, 8, 1, 1, NULL, '2024-05-13 18:33:33', '2024-05-13 21:09:41', NULL),
(45, 'Gérer les Comportements Difficiles : Stratégies pour un Environnement Familial Harmonieux', 'Gérer les comportements difficiles chez les enfants peut être l\'un des aspects les plus éprouvants de la parentalité. Toutefois, avec des stratégies appropriées, il est possible de transformer ces défis en opportunités d\'apprentissage et de croissance. Voici des conseils pratiques pour gérer les comportements difficiles et favoriser un environnement familial harmonieux.\n\nComprenez les Causes Sous-Jacentes\nLes comportements difficiles peuvent souvent être des signes de besoins non satisfaits ou d\'émotions mal exprimées. Prenez le temps d\'identifier les causes sous-jacentes du comportement de votre enfant. Est-il fatigué, affamé, stressé ou en quête d\'attention ? En comprenant les raisons derrière le comportement, vous pouvez adopter une approche plus empathique et ciblée pour y remédier.\n\nUtilisez des Techniques de Discipline Positive\nLa discipline positive se concentre sur l\'enseignement et la correction des comportements de manière respectueuse et encourageante. Plutôt que de punir, utilisez des conséquences logiques et naturelles pour aider votre enfant à comprendre les effets de ses actions. Par exemple, si votre enfant renverse intentionnellement son verre d\'eau, demandez-lui de nettoyer le désordre. Cela lui apprend la responsabilité et les conséquences de ses actes de manière constructive.\n\nPratiquez la Consistance et la Cohérence\nLa consistance et la cohérence sont essentielles pour gérer les comportements difficiles. Assurez-vous que les règles et les attentes sont claires et appliquées de manière uniforme par tous les membres de la famille. Les enfants se sentent plus en sécurité et sont plus susceptibles de respecter les règles lorsqu\'ils savent à quoi s\'attendre. Évitez les réactions impulsives et restez ferme, mais bienveillant, dans l\'application des conséquences.\n\nEnseignez des Compétences de Gestion des Émotions\nAider vos enfants à développer des compétences de gestion des émotions peut réduire les comportements difficiles. Apprenez-leur à reconnaître et à exprimer leurs émotions de manière appropriée. Utilisez des techniques comme la respiration profonde, les pauses de calme et les jeux de rôle pour enseigner des stratégies de régulation émotionnelle. Encouragez-les à utiliser des mots pour exprimer leurs sentiments plutôt que des comportements inappropriés.\n\nRenforcez les Comportements Positifs\nLe renforcement positif est une stratégie puissante pour encourager les comportements souhaités. Félicitez et récompensez vos enfants lorsqu\'ils se comportent bien. Utilisez des éloges spécifiques pour souligner ce qu\'ils ont bien fait. Par exemple, dites : \"Je suis fier de toi pour avoir partagé tes jouets avec ton frère\" plutôt que des compliments généraux comme \"Bon travail\". Le renforcement positif motive les enfants à répéter les comportements positifs.\n\nEn conclusion, gérer les comportements difficiles nécessite de la patience, de la compréhension et des stratégies de discipline positive. En comprenant les causes sous-jacentes, en pratiquant la consistance, en enseignant des compétences de gestion des émotions et en renforçant les comportements positifs, vous pouvez créer un environnement familial harmonieux et soutenir le développement émotionnel de vos enfants.', NULL, 1, 55821, 32, 8, 1, 1, NULL, '2024-05-13 18:33:45', '2024-05-13 21:09:41', NULL),
(46, 'Favoriser un Environnement Familial Sain et Aimant', 'Créer un environnement familial sain et aimant est essentiel pour le bien-être et le développement des enfants. Un foyer où règnent l\'amour, la sécurité et le respect favorise la croissance émotionnelle et mentale, renforce les liens familiaux et prépare les enfants à devenir des adultes épanouis et responsables. Voici des stratégies pratiques pour favoriser un environnement familial sain et aimant.\n\nCommuniquez Ouvertement et Écoutez Attentivement\nLa communication ouverte est la clé d\'un environnement familial sain. Encouragez les échanges honnêtes et bienveillants entre tous les membres de la famille. Prenez le temps d\'écouter attentivement vos enfants et de montrer de l\'empathie envers leurs sentiments et leurs préoccupations. Une bonne communication renforce la confiance et le respect mutuel et aide à résoudre les conflits de manière constructive.\n\nPartagez des Moments de Qualité\nPasser du temps de qualité ensemble est crucial pour renforcer les liens familiaux. Organisez des activités régulières en famille, comme des dîners, des sorties ou des jeux. Ces moments partagés créent des souvenirs positifs et renforcent le sentiment d\'appartenance et de connexion. Assurez-vous que ces activités sont agréables pour tous les membres de la famille et favorisent la participation active de chacun.\n\nPratiquez la Gratitude et la Reconnaissance\nExprimer de la gratitude et de la reconnaissance contribue à créer une atmosphère positive et aimante. Encouragez les membres de la famille à exprimer leur gratitude pour les petits gestes du quotidien et à reconnaître les efforts et les réussites des autres. Tenir un journal de gratitude familial ou partager des \"moments de gratitude\" lors des repas peut renforcer cette pratique et inculquer des valeurs positives aux enfants.\n\nÉtablissez des Routines et des Traditions Familiales\nLes routines et les traditions familiales offrent une structure et un sentiment de sécurité aux enfants. Établissez des routines quotidiennes, comme des heures de repas régulières, des rituels du coucher et des moments de jeu. Les traditions familiales, comme les célébrations des anniversaires, les vacances ou les rituels saisonniers, renforcent le sentiment d\'unité et créent des souvenirs durables.\n\nMontrez de l\'Amour et de l\'Affection\nL\'amour et l\'affection sont les fondements d\'un environnement familial sain. Montrez de l\'amour à vos enfants à travers des gestes affectueux, des paroles bienveillantes et du temps passé ensemble. Les câlins, les compliments et les encouragements renforcent le sentiment de sécurité et de bien-être chez les enfants. L\'affection et l\'amour inconditionnels leur donnent la confiance nécessaire pour explorer le monde et surmonter les défis.\n\nModèle des Comportements Positifs\nLes enfants apprennent en observant les comportements de leurs parents. Soyez un modèle de comportements positifs en montrant du respect, de l\'empathie et de la responsabilité. Gérez vos émotions de manière constructive et montrez comment résoudre les conflits de manière pacifique. Vos actions et vos attitudes servent de guide à vos enfants et influencent leur développement comportemental et émotionnel.\n\nEn conclusion, favoriser un environnement familial sain et aimant repose sur la communication ouverte, le partage de moments de qualité, la gratitude, les routines, l\'affection et le modèle de comportements positifs. En adoptant ces stratégies, vous pouvez créer un foyer où les enfants se sentent aimés, en sécurité et soutenus, favorisant ainsi leur épanouissement et leur bien-être global.', NULL, 1, 34086, 32, 8, 1, 1, NULL, '2024-05-13 18:33:55', '2024-05-13 21:09:41', NULL),
(47, 'Améliorer le Bien-Être Physique et Mental : Clés pour une Vie Épanouie', 'Le bien-être physique et mental est essentiel pour mener une vie pleine et satisfaisante. En adoptant des habitudes saines et en prenant soin de votre corps et de votre esprit, vous pouvez améliorer votre qualité de vie de manière significative. Voici quelques conseils pratiques pour optimiser votre bien-être physique et mental.\n\nAdoptez une Alimentation Équilibrée\nUne alimentation saine et équilibrée est la base du bien-être physique. Consommez une variété d\'aliments riches en nutriments, y compris des fruits, des légumes, des protéines maigres, des grains entiers et des graisses saines. Évitez les aliments transformés et riches en sucres ajoutés. Hydratez-vous suffisamment en buvant de l\'eau tout au long de la journée. Une alimentation équilibrée fournit l\'énergie nécessaire pour les activités quotidiennes et contribue à maintenir un poids santé.\n\nPratiquez une Activité Physique Régulière\nL\'exercice régulier est crucial pour maintenir une bonne santé physique et mentale. Choisissez des activités que vous aimez, comme la marche, la course, le vélo, la natation ou le yoga, et intégrez-les dans votre routine quotidienne. L\'activité physique améliore la circulation sanguine, renforce les muscles et les os, et libère des endorphines qui améliorent l\'humeur. Essayez de faire au moins 150 minutes d\'exercice modéré par semaine pour des bénéfices optimaux.\n\nGérez le Stress\nLa gestion du stress est essentielle pour le bien-être mental. Pratiquez des techniques de relaxation comme la méditation, la respiration profonde ou le yoga pour réduire le stress et l\'anxiété. Prenez des pauses régulières tout au long de la journée pour vous détendre et vous ressourcer. Établissez des limites claires entre le travail et la vie personnelle pour éviter le burn-out. Trouvez des activités qui vous plaisent et qui vous aident à vous détendre, comme la lecture, la peinture ou écouter de la musique.\n\nDormez Suffisamment\nLe sommeil est crucial pour le bien-être général. Assurez-vous de dormir entre 7 et 9 heures par nuit pour permettre à votre corps de se reposer et de se régénérer. Créez une routine de sommeil régulière en vous couchant et en vous levant à la même heure chaque jour. Évitez les écrans avant de dormir et créez un environnement de sommeil confortable et sombre. Un bon sommeil améliore la concentration, l\'humeur et la santé physique.\n\nCultivez des Relations Positives\nLes relations sociales jouent un rôle important dans le bien-être mental. Entourez-vous de personnes positives et bienveillantes qui vous soutiennent et vous inspirent. Prenez le temps de nourrir vos relations en passant du temps de qualité avec vos amis et votre famille. La communication ouverte et honnête renforce les liens et contribue à un sentiment de connexion et d\'appartenance. Les interactions sociales positives réduisent le stress et augmentent la satisfaction de vie.\n\nEn conclusion, améliorer le bien-être physique et mental repose sur une alimentation équilibrée, l\'exercice régulier, la gestion du stress, un sommeil suffisant et des relations positives. En adoptant ces habitudes saines, vous pouvez augmenter votre qualité de vie et vivre de manière plus épanouie et harmonieuse.', NULL, 1, 2898, 33, 9, 1, 1, NULL, '2024-05-13 18:38:03', '2024-05-13 21:09:41', NULL),
(48, 'Optimiser Votre Espace de Vie : Créez un Environnement Sain et Harmonieux', 'Un espace de vie bien organisé et agréable peut grandement contribuer à votre qualité de vie. Un environnement sain et harmonieux favorise le bien-être physique et mental, réduit le stress et augmente la productivité. Voici des conseils pratiques pour optimiser votre espace de vie et créer un lieu de vie épanouissant.\n\nDésencombrez Votre Espace\nLe désencombrement est la première étape pour créer un environnement harmonieux. Éliminez les objets inutiles et ceux que vous n\'utilisez plus. Un espace dégagé et organisé réduit le stress et augmente la clarté mentale. Utilisez des boîtes de rangement, des étagères et des solutions de rangement créatives pour organiser vos affaires de manière efficace. Un espace propre et ordonné améliore également l\'hygiène et la sécurité de votre domicile.\n\nMaximisez la Lumière Naturelle\nLa lumière naturelle a un impact positif sur le bien-être mental et physique. Elle améliore l\'humeur, augmente les niveaux d\'énergie et favorise un sommeil de qualité. Ouvrez les rideaux et les stores pour laisser entrer la lumière naturelle. Utilisez des miroirs pour refléter la lumière et rendre votre espace plus lumineux. Si l\'accès à la lumière naturelle est limité, utilisez des ampoules à spectre complet qui imitent la lumière du jour.\n\nIntégrez des Éléments de la Nature\nL\'intégration d\'éléments naturels dans votre espace de vie peut améliorer votre bien-être. Les plantes d\'intérieur purifient l\'air, augmentent l\'humidité et ajoutent une touche de verdure à votre maison. Choisissez des plantes faciles à entretenir, comme les succulentes, les fougères ou les plantes araignées. Les matériaux naturels, comme le bois, la pierre et le bambou, ajoutent également une sensation de chaleur et de confort à votre espace.\n\nCréez des Zones Fonctionnelles\nDivisez votre espace de vie en zones fonctionnelles pour améliorer l\'organisation et la productivité. Créez des zones spécifiques pour le travail, la détente, les repas et les loisirs. Utilisez des meubles modulables et des séparateurs de pièce pour définir ces zones sans encombrer l\'espace. Un environnement bien structuré facilite la concentration et permet de passer facilement d\'une activité à l\'autre.\n\nPersonnalisez Votre Espace\nPersonnaliser votre espace de vie en fonction de vos goûts et de votre style peut augmenter votre sentiment de bien-être. Utilisez des couleurs, des textures et des décorations qui vous plaisent et qui reflètent votre personnalité. Affichez des photos, des œuvres d\'art et des souvenirs qui évoquent des souvenirs positifs et des émotions agréables. Un espace de vie qui vous ressemble vous rendra plus heureux et plus à l\'aise chez vous.\n\nEn conclusion, optimiser votre espace de vie peut avoir un impact significatif sur votre qualité de vie. En désencombrant, maximisant la lumière naturelle, intégrant des éléments naturels, créant des zones fonctionnelles et personnalisant votre espace, vous pouvez créer un environnement sain et harmonieux. Un espace de vie bien organisé et agréable favorise le bien-être physique et mental, réduisant le stress et augmentant la satisfaction globale.', NULL, 1, 50232, 33, 9, 1, 1, NULL, '2024-05-13 18:38:16', '2024-05-13 21:09:41', NULL),
(49, 'Voter pour Michel C. : Pour une Amélioration de Notre Qualité de Vie', 'L\'amélioration de la qualité de vie de tous les citoyens est un enjeu crucial pour notre société. En cette période électorale, il est essentiel de choisir un leader qui s\'engage à promouvoir le bien-être de chacun et à créer un environnement sain et harmonieux. Michel C. est ce leader. Voici pourquoi voter pour Michel C. est la meilleure décision pour améliorer notre qualité de vie.\n\nEngagement pour la Santé Publique\nMichel C. a toujours placé la santé publique au cœur de ses priorités. Il s\'engage à améliorer l\'accès aux soins de santé pour tous les citoyens, indépendamment de leur revenu ou de leur lieu de résidence. Michel C. propose de renforcer les infrastructures médicales, de soutenir les professionnels de santé et de promouvoir des programmes de prévention des maladies. Avec Michel C., vous pouvez être sûr que votre santé et celle de votre famille seront protégées et valorisées.\n\nPromotion d\'Environnements Sains\nMichel C. est également un fervent défenseur de la protection de l\'environnement. Il comprend l\'importance de vivre dans des environnements propres et sains pour notre bien-être physique et mental. Michel C. propose des initiatives pour réduire la pollution, promouvoir les énergies renouvelables et protéger nos espaces verts. En votant pour Michel C., vous soutenez un futur plus vert et plus durable, où la qualité de l\'air et la propreté des espaces publics sont des priorités.\n\nAmélioration de l\'Équilibre Vie-Travail\nMichel C. reconnaît les défis que rencontrent de nombreux citoyens pour équilibrer leur vie professionnelle et personnelle. Il propose des politiques pour améliorer les conditions de travail, comme la réduction du temps de travail, l\'extension des congés parentaux et la promotion du télétravail. Michel C. s\'engage à créer un environnement où chaque individu peut s\'épanouir tant sur le plan professionnel que personnel.\n\nDéveloppement des Infrastructures Locales\nMichel C. comprend que des infrastructures de qualité sont essentielles pour une vie épanouie. Il s\'engage à améliorer les transports publics, à moderniser les infrastructures scolaires et à construire des logements abordables et durables. En soutenant Michel C., vous choisissez un leader qui investira dans notre communauté et rendra notre cadre de vie plus agréable et accessible.\n\nRenforcement des Liens Communautaires\nMichel C. croit fermement en la force de la communauté. Il propose des initiatives pour renforcer les liens sociaux, comme la création de centres communautaires, le soutien aux associations locales et l\'organisation d\'événements culturels et sportifs. Michel C. veut créer un environnement où chacun se sent inclus et valorisé, où la solidarité et l\'entraide sont au cœur de nos interactions.\n\nEn conclusion, voter pour Michel C. est un choix pour améliorer notre qualité de vie. Son engagement pour la santé publique, la protection de l\'environnement, l\'équilibre vie-travail, le développement des infrastructures et le renforcement des liens communautaires en font le candidat idéal pour un futur meilleur. Faites le choix de la qualité de vie et votez pour Michel C. ensemble, nous pouvons créer une société où chacun peut s\'épanouir et vivre harmonieusement.', NULL, 1, 35535, 33, 9, 3, 1, NULL, '2024-05-13 18:39:39', '2024-05-13 21:09:41', 'Merci de ne pas faire de propagande sur le site !'),
(50, 'La Philosophie du Sandwich Parfait : Trouver le Sens de la Vie à Travers la Gastronomie', 'Vous êtes-vous déjà demandé comment un simple sandwich pouvait vous aider à trouver un sens plus profond à la vie ? Bienvenue dans la philosophie du sandwich parfait, une exploration existentielle qui révèle que même les choses les plus banales peuvent offrir des enseignements précieux sur notre place dans le monde et nos valeurs fondamentales.\n\nLa Structure du Sandwich : Un Métaphore de la Vie\nLe pain, la garniture et les condiments représentent les différents aspects de notre existence. Le pain, qui enveloppe et soutient le tout, symbolise les fondations de notre vie : notre famille, nos amis et nos croyances fondamentales. La garniture représente nos expériences et nos passions, ces éléments qui ajoutent de la saveur et du caractère à notre quotidien. Enfin, les condiments sont les petites choses qui agrémentent notre existence : les hobbies, les moments de joie, et les plaisirs simples.\n\nEn construisant métaphoriquement votre sandwich parfait, vous apprenez à équilibrer ces éléments pour créer une vie harmonieuse et satisfaisante. Un excès de condiments peut masquer les véritables saveurs, tout comme trop d\'occupations superficielles peuvent nous éloigner de nos valeurs essentielles.\n\nLe Rituel de la Préparation : Une Pratique de Pleine Conscience\nPréparer un sandwich parfait n\'est pas seulement une question de choix des ingrédients, mais aussi de processus. Prenez le temps de choisir chaque composant avec soin et d\'assembler votre création avec attention. Ce rituel devient une pratique de pleine conscience, où chaque étape est accomplie avec intention et présence. En prêtant attention à chaque détail, vous cultivez une attitude de gratitude et d\'appréciation pour les petites choses de la vie.\n\nLe Partage du Sandwich : La Communion Humaine\nUn sandwich partagé est un acte de communion et de connexion humaine. Invitez quelqu\'un à partager votre sandwich et engagez une conversation significative. Partager de la nourriture a toujours été une façon de renforcer les liens sociaux et de célébrer la vie ensemble. À travers cet acte simple, vous découvrez la joie de donner et de recevoir, et l\'importance des relations humaines dans notre quête de sens.\n\nEn conclusion, la philosophie du sandwich parfait nous enseigne que même les aspects les plus simples de la vie peuvent offrir des insights profonds. En explorant cette métaphore gastronomique, nous apprenons à apprécier les petits plaisirs, à vivre de manière consciente et à valoriser nos relations, nous guidant ainsi vers une existence plus authentique et épanouissante.', NULL, 1, 26841, 34, 10, 1, 1, NULL, '2024-05-13 18:54:53', '2024-05-13 21:09:41', NULL),
(51, 'La Cosmologie des Chaussettes Perdues : Comprendre le Mystère de l\'Existence', 'Les chaussettes perdues sont un mystère universel qui semble défier toute logique. Et si ce phénomène apparemment insignifiant détenait la clé pour comprendre des questions existentielles plus profondes ? Plongez dans la cosmologie des chaussettes perdues et explorez comment cet énigme peut éclairer notre quête de sens.\n\nLa Disparition Inexplicable : Le Chaos et l\'Incertitude\nLa disparition de chaussettes dans la machine à laver est une métaphore du chaos et de l\'incertitude dans la vie. Tout comme nous ne pouvons jamais prévoir quelle chaussette va disparaître, nous ne pouvons pas non plus contrôler tous les aspects de notre existence. Accepter ce chaos nous permet de lâcher prise sur le besoin de tout maîtriser et de trouver la paix dans l\'incertitude.\n\nLa Quête de la Chaussette Perdue : La Recherche de Complétude\nLa recherche incessante de la chaussette manquante symbolise notre quête de complétude et de sens. Nous cherchons constamment à combler les vides dans notre vie, à retrouver ce qui nous manque pour nous sentir entiers. Cette quête nous pousse à explorer de nouvelles possibilités, à sortir de notre zone de confort et à grandir en tant qu\'individus.\n\nLa Communauté des Chaussettes Orphelines : La Solidarité dans l\'Incomplétude\nLes chaussettes orphelines, celles qui restent seules après la disparition de leur partenaire, forment une communauté de solidarité. Elles nous rappellent que nous ne sommes pas seuls dans nos pertes et nos manques. En nous connectant avec d\'autres qui partagent des expériences similaires, nous trouvons du réconfort et du soutien, renforçant notre résilience face aux défis de la vie.\n\nEn conclusion, la cosmologie des chaussettes perdues offre une perspective unique sur les mystères de l\'existence. En embrassant l\'incertitude, en poursuivant notre quête de complétude et en trouvant solidarité dans l\'incomplétude, nous pouvons naviguer notre vie avec une compréhension plus profonde et une acceptation sereine.', NULL, 1, 27462, 34, 10, 1, 1, NULL, '2024-05-13 18:55:17', '2024-05-13 21:09:41', NULL),
(52, 'Les Licornes du Quotidien : Trouver la Magie dans la Vie de Tous les Jours', 'Les licornes, ces créatures mythiques et fantastiques, symbolisent la magie, la pureté et l\'émerveillement. Bien que les licornes n\'existent pas dans le monde réel, leur concept peut nous inspirer à trouver la magie et l\'émerveillement dans notre vie quotidienne. Voici comment adopter la philosophie des licornes pour enrichir notre existence.\n\nLa Magie des Petits Moments\nLes licornes nous rappellent que la magie se trouve souvent dans les petits moments de la vie. Prenez le temps de savourer un coucher de soleil, d\'apprécier une tasse de café le matin ou de rire avec un ami. Ces moments simples, mais précieux, apportent une touche de magie à notre quotidien et nous rappellent la beauté de la vie.\n\nL\'Émerveillement et la Curiosité\nAdopter une attitude d\'émerveillement et de curiosité est essentiel pour vivre une vie magique. Posez-vous des questions, explorez de nouveaux endroits et essayez de nouvelles activités. L\'émerveillement nous pousse à voir le monde avec des yeux neufs, à redécouvrir la joie et l\'excitation dans les choses que nous tenons pour acquises.\n\nLa Pureté de l\'Intention\nLes licornes symbolisent également la pureté. Appliquez cette idée en agissant avec des intentions pures et bienveillantes. Soyez honnête avec vous-même et avec les autres, et cultivez des relations basées sur la confiance et le respect. La pureté de l\'intention crée des interactions authentiques et enrichissantes, ajoutant une dimension magique à nos relations.\n\nEn conclusion, les licornes du quotidien nous invitent à trouver la magie et l\'émerveillement dans chaque aspect de notre vie. En appréciant les petits moments, en cultivant l\'émerveillement et en agissant avec pureté, nous pouvons vivre une existence plus joyeuse et pleine de sens.', NULL, 1, 34566, 34, 10, 3, 1, NULL, '2024-05-13 18:55:42', '2024-05-13 21:09:41', 'Les Licornes.. sérieusement ?'),
(53, 'La Philosophie des Mèmes Internet : Découvrir la Sagesse dans l\'Humour en Ligne', 'Les mèmes Internet, ces images humoristiques et virales, peuvent sembler être des distractions légères, mais ils contiennent souvent des grains de sagesse et des vérités profondes sur la vie humaine. Explorez comment la philosophie des mèmes Internet peut enrichir votre compréhension de la condition humaine et ajouter une touche de légèreté à votre quête de sens.\n\nL\'Instantanéité et l\'Éphémérité\nLes mèmes Internet sont créés et partagés rapidement, et leur popularité peut être éphémère. Cette nature fugace nous rappelle l\'importance de vivre dans l\'instant présent et d\'apprécier les moments de joie quand ils se présentent. Les mèmes nous enseignent à ne pas prendre la vie trop au sérieux et à trouver l\'humour même dans les situations les plus banales.\n\nLa Connectivité Globale\nLes mèmes ont le pouvoir de traverser les frontières culturelles et linguistiques, créant un sentiment de connexion globale. Ils montrent que, malgré nos différences, nous partageons des expériences et des sentiments communs. Cette connectivité nous rappelle que nous faisons partie d\'une humanité plus large et que nous pouvons trouver du soutien et de la solidarité dans la communauté en ligne.\n\nL\'Autodérision et l\'Acceptation de Soi\nBeaucoup de mèmes utilisent l\'humour autodérisoire pour traiter des défis et des imperfections de la vie. En riant de nos propres faiblesses et erreurs, nous apprenons à les accepter et à les voir sous un jour plus léger. L\'autodérision peut être un outil puissant pour développer la résilience émotionnelle et pour cultiver une attitude de bienveillance envers soi-même.\n\nEn conclusion, la philosophie des mèmes Internet nous offre des leçons précieuses sur l\'instantanéité, la connectivité globale et l\'autodérision. En intégrant ces enseignements dans notre vie quotidienne, nous pouvons enrichir notre compréhension de la condition humaine, trouver la sagesse dans l\'humour et vivre de manière plus joyeuse et connectée.', NULL, 1, 38598, 34, 10, 1, 1, NULL, '2024-05-13 18:55:59', '2024-05-13 21:09:41', NULL),
(54, 'Le Yoga : Flexibilité et Sérénité', 'Le yoga est une pratique ancienne qui combine des postures physiques, des techniques de respiration et de la méditation pour améliorer la flexibilité, la force et le bien-être mental. Idéal pour tous les âges et niveaux de condition physique, le yoga aide à réduire le stress, à améliorer la posture et à augmenter la concentration. Que vous choisissiez le Hatha pour une pratique douce ou le Vinyasa pour un flux plus dynamique, le yoga offre des bienfaits holistiques pour le corps et l\'esprit.', NULL, 1, 8832, 34, 11, 1, 1, NULL, '2024-05-13 18:59:51', '2024-05-13 21:09:41', NULL),
(55, 'La Course à Pied : Endurance et Vitalité', 'La course à pied est un exercice simple et efficace pour améliorer l\'endurance cardiovasculaire, renforcer les muscles et brûler des calories. Accessible à tous, ce sport peut être pratiqué en plein air ou sur un tapis de course. En plus de ses bienfaits physiques, la course à pied est connue pour libérer des endorphines, les \"hormones du bonheur\", aidant ainsi à réduire le stress et à améliorer l\'humeur. Que vous soyez débutant ou coureur expérimenté, intégrer la course à pied dans votre routine peut transformer votre santé physique et mentale.', NULL, 1, 67914, 35, 11, 1, 1, NULL, '2024-05-13 19:01:23', '2024-05-13 21:09:41', NULL),
(56, 'La Natation : Force et Résistance', 'La natation est un excellent exercice complet qui sollicite tous les groupes musculaires sans impacter les articulations. Idéale pour tous les âges, la natation améliore la capacité cardiovasculaire, renforce les muscles et augmente la flexibilité. Elle est particulièrement bénéfique pour ceux qui recherchent un entraînement à faible impact. Les styles variés comme le crawl, le dos crawlé ou la brasse permettent de diversifier les séances et de cibler différentes zones musculaires.', NULL, 1, 1725, 35, 2, 3, 1, NULL, '2024-05-13 19:01:49', '2024-05-13 21:09:41', 'Mauvaise Catégorie :)'),
(57, 'Le Pilates : Équilibre et Contrôle', 'Le Pilates est une méthode d\'entraînement qui se concentre sur le renforcement du core (muscles abdominaux, dorsaux et pelviens), l\'amélioration de la posture et l\'augmentation de la flexibilité. Avec des exercices précis et contrôlés, le Pilates aide à prévenir les douleurs lombaires et à améliorer l\'équilibre. Que ce soit sur un tapis ou avec des équipements spécialisés comme le Reformer, le Pilates est bénéfique pour le bien-être physique et mental.', NULL, 1, 20076, 30, 11, 1, 1, NULL, '2024-05-13 19:03:28', '2024-05-13 19:12:02', NULL),
(58, 'Le CrossFit : Intensité et Polyvalence', 'Le CrossFit est un programme de conditionnement physique qui combine des éléments de gymnastique, d\'haltérophilie, et d\'exercices cardiovasculaires. Les séances de CrossFit sont variées et intenses, visant à améliorer la force, l\'endurance, la flexibilité et la coordination. Adapté à tous les niveaux grâce à des options de modifications, le CrossFit favorise la camaraderie et la motivation au sein de la communauté.', NULL, 1, 21597, 3, 11, 1, 1, NULL, '2024-05-13 19:04:27', '2024-05-13 21:09:41', NULL),
(59, 'Le Tennis : Agilité et Réflexes', 'Le tennis est un sport dynamique qui améliore l\'agilité, la coordination et la condition cardiovasculaire. En jouant en simple ou en double, vous engagez tous les groupes musculaires et développez des réflexes rapides. Le tennis est également excellent pour la santé mentale, car il nécessite une concentration intense et une stratégie continue. Que vous jouiez pour le plaisir ou en compétition, le tennis offre un excellent entraînement physique et mental.', NULL, 1, 9039, 31, 11, 1, 1, NULL, '2024-05-13 19:06:51', '2024-05-13 19:11:58', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `rights`
--

CREATE TABLE `rights` (
  `id_right` int(11) NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(1, '1');

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
(1, 'c.nicolas@gmail.com', 'Nicolas', 'Ch', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 4, 4, 75, 1, '2024-05-13 09:39:58', '2024-05-13 17:03:42', NULL, NULL, NULL, 12),
(2, 'c.arthur@gmail.com', 'Arthur', 'Cr', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 1, 1, 75, 1, '2024-05-13 10:31:21', '2024-05-13 17:11:58', NULL, NULL, NULL, 1),
(3, 'r.tristan@gmail.com', 'Tristan', 'Ro', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 2, 2, 75, 3, '2024-05-13 10:50:04', '2024-05-13 21:04:10', 'Lk3mRaGwd3YeAwAYVnCxRxSsUykyx4RykFZshYjEJL7qBfZGbjAuFP78DucYNArfPKMjktvw63hVUYq1jJ8O6AK73K4ySxjEm6SY', NULL, NULL, 11),
(4, 'k.breton83@gmail.com', 'Kilian', 'Br', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 3, 3, 75, 2, '2024-05-13 10:57:27', '2024-05-13 17:11:58', '4NjTnqJEbMrU6aMLL0iU8S4YlhTHzo3EE67CRap1ngghKu6WcBYjlxZGblkjbQdWAu5RYZOCcPYRKrfP7B4YbEirQnHOtnS1h7qb', NULL, NULL, 13),
(5, 's.mathilde@viacesi.fr', 'Mathilde', 'Sa', '$2y$12$eCy0l1ksOZT0sFd21N8xheVE2tZ1RIu4R2IpAONTvL.NFyOYgYn/6', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:13:15', '2024-05-13 17:11:58', 'cCn20hCUvmVjJ1zLvXw3adogSAih4RmRGfcTgdNAJrZAs94BwElHjOHzLPN6ZdAAnw4RMhWqr7qII40PGdgQyl91jKneMgurezXN', NULL, NULL, 4),
(6, 'Rhizlene.a@viacesi.fr', 'Rhizlène', 'Al', '$2y$12$.Gdl1by3kFKlpOhoX/qfXOoSARyXL.sqH495YgY3mWi486GwI2.6W', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:14:51', '2024-05-13 17:11:58', '8jRupe5A5nooC2AJzTNIFD0Exi744gEnZN6A9qsL8GZeG2S38Ng2Ec1Q0qTHwhHcKyUWBpCmumNbHG0G7DLzpHuzVeCENB55Myet', NULL, NULL, 3),
(7, 'Gabriel.b@viacesi.fr', 'Gabriel', 'Be', '$2y$12$QKnKXxOTU/u11smiqchm4ucL.26XHUwxSZFyFCiXZUo4h8PAndOYS', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:15:24', '2024-05-13 17:11:58', 'XcOqxJ16mBYKSa0mYSvgjMbRxoX3SNQ6TyayhTAzzg3E0KbmBP25WPmtm1PkjmylukvQID2IkFLNruDVxe1orazolkYgJsJRYB6s', NULL, NULL, 13),
(8, 'Véran.b@viacesi.fr', 'Véran', 'Bo', '$2y$12$r7zfaVUnnOJgDKgr71YL1uV/mqONP.QtpegV72jErs.qXF.nwkhbG', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:16:11', '2024-05-13 17:11:58', 'bsWYic6Ow8b9T7x6xbE5fbeEEEvcleECWLvPmIBsS7nGyZa0LimAmUuZ0aJJN94EoYnePq5Q9fxcmo9dpTmk2ZJFVYoZPiARWhr1', NULL, NULL, 10),
(9, 'Adam.b@viacesi.fr', 'Adam', 'Bo', '$2y$12$s4IjCni74cFGiX0Yzb88kehGW.OyxGzeUlWJHSXPxzyl6pgyI2vT6', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:16:49', '2024-05-13 17:11:58', 'Awz5GGDgSZRJI87czBZ872RlwitJGVZIS2plCn0qUbHvChdGIDWtIlUX1QY8BMu3XFhhFbhuETfcbABdjSPgS9S5rtfvvql1uBiS', NULL, NULL, 4),
(10, 'Raphaël.c@viacesi.fr', 'Raphaël', 'Ca', '$2y$12$eEOqqsvGoR9FhqXM8Fgls.MGOblqtxZwDjdfwQS4reh.T4G0mdo7u', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:17:28', '2024-05-13 17:11:58', 'w1si9HTQhYdIcbtI385PTxoos8zmXjsW3MK6KkyRpQvt7Q9e678kpaj4tbj7GFT3Jhl8m3czAgwga9vLpbbq5tOFOmhWm8oKtiZe', NULL, NULL, 1),
(11, 'Youcef.d@viacesi.fr', 'Youcef', 'Dj', '$2y$12$iI4jp0f9L6Xm0xubzHYXJO5ETZqCkMiPMr2rWgOBX9AQMsoctNU9G', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:18:05', '2024-05-13 17:11:58', 'Xgulk0ZbJ2xt9uazgCCOg9s4Br48TmfVMJseDlOyzkJn4QM9AiJlt1ZSf3wMHeomllX86W4pdCDipL3DOql9Pjg75O7euqSdij5D', NULL, NULL, 10),
(12, 'Corentin.d@viacesi.fr', 'Corentin', 'Du', '$2y$12$Jtor9dJS3ZIShVaGmRw6/uyKxRpwuo9tCxKvYn5/dyPbmLN8pSEre', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:19:00', '2024-05-13 17:11:58', 'SqyRq0UOjQ4QOcebioyyjK6JDHVQxyMO8JeJWgKrebGFglBXpIdHZNWU9zRVf8nz6LYSy5TkSsWN0PNM0f1Ex8A8uDL5FYzsqLq7', NULL, NULL, 10),
(13, 'Zinedine.g@viacesi.fr', 'Zinedine', 'Gh', '$2y$12$loF68G1PdRvbpdhDgjKz3ugkwWGBzS03/SG/QQ5iLUgUaCk.gKae2', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:19:26', '2024-05-13 17:11:58', 'Rn4YTSEXXSUlAQnJ9T1imNpeDHPHC6o4u9eh7oujRclHdeUFTeqYwClgnr1CeUpcs0DE6ZZj4DP5MSiopez3CYR8NoaW5MtVEfx4', NULL, NULL, 20),
(14, 'Anass.k@viacesi.fr', 'Anass', 'Kh', '$2y$12$D13XUtB5FSpz/Zy7wn.Mgupfn.2haDHbdsLj7dEvPUhRFg2txQunu', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:20:08', '2024-05-13 17:11:58', '0uzY6O3nUvUUegQYDDVk2SuDuOK5NBvEyDPHjkz0MiWY6jXYxV2adJy6UHllhCVLzcWN83QMNwVohFVxGumrVpEzUCaIj5kZ8LpJ', NULL, NULL, 7),
(15, 'Jordan.k@viacesi.Fr', 'Jordan', 'Kr', '$2y$12$fVgFOKx/e0IH.QqJizWWKOr7tQAhv1lmOmqrFjgV5fjxyvslEOu.G', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:20:38', '2024-05-13 17:11:58', 'hOPw7SQJvfp2jSvFDzVSrGmf5FGc1DrHcW6vowxB0SWMLbwespmuSJb3sltXiOTKMsDEJOjZu4dh4uD0w6aXM1vPogSfNwJj6S0H', NULL, NULL, 13),
(16, 'David.l@viacesi.fr', 'David', 'La', '$2y$12$tnWWXZ5AI0Z9Jn/0hKxTE.h98dJIegotqvUGIcW83axpY6wi2kNIK', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:21:06', '2024-05-13 17:11:58', 'DvMkMDgbBjv0Yers0Cw2PUVpHd3W4jSz0CzxifmswYCiyfQELrqs9LV1ULgiPJ2zILOzPkDTzIijhRi6z2JixqGvDt7ynai4f4o0', NULL, NULL, 9),
(17, 'Thomas.l@viacesi.fr', 'Thomas', 'La', '$2y$12$hd5Q7nXiOAJ2ln3pFePsvuUYVTIq/hKm4/hz8bpmYixMyD5IXz3Yi', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:21:35', '2024-05-13 17:11:58', 'eelcsXzB6DgHHBkcWhhm7XcQHnqj8wOIcfADJPrFnbDBOrA8sgV8qlRFswudUL9mmif1irh2UTqikIPZlJclvS5qjb2ew8olBhRj', NULL, NULL, 10),
(18, 'Alexandre.l@viacesi.fr', 'Alexandre', 'La', '$2y$12$WZlkri3Q9RG4zP2QA4ejheo11wP8If7rYLWvTPSdzJotU35W/Bn9W', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:21:58', '2024-05-13 17:11:58', 'QuUFkaKhPGZzYIqX1oeUM1eNvi8l2zG7XuQrYqvNcl7ONgaM4LNB84GrZotagvKWx7IkDI866GWcjeTplm2fQ6iFYtjLzkeJNaV3', NULL, NULL, 16),
(19, 'Antoine.l@viacesi.fr', 'Antoine', 'Le', '$2y$12$j9RZX20hd810ODnGNGwnAuhTtu2CuVVgBdAcxTAb9zjN.46iz.KZO', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:22:42', '2024-05-13 17:11:58', 'I7wpBSKPNnYO5cyKCIPCfHNgWRIyknhLCeyoP5kGNJAhO5Nkrx9KwD455mvJCKGEcPs4Iy9aTQ90Q8PBQ6k7rkfjHEub4OODwvdx', NULL, NULL, 7),
(20, 'Clément.l@viacesi.fr', 'Clément', 'Lo', '$2y$12$ZYVoIoZxHuWNymbZzcNZ5uD85fnAiVMng10.F2fo5lN8e/vS9xulu', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:23:36', '2024-05-13 17:11:58', 'yY965gnCqAEEnQYP07lJX9zVjVSsbKdLZQdVuv2J0TMeHGVKdmPnqK8QPy2jdxKVtEWwKOZC7nZYngtqrKM7TO8fYLc40pWbdZUk', NULL, NULL, 9),
(21, 'Rémi.m@viacesi.fr', 'Rémi', 'Mi', '$2y$12$pVoAcra5nZw/GyxyPFA9sO4quGI7XJG2xDEUy4lVg3UFOuWE4Roam', 1, NULL, 5, 5, 3, 3, '2024-05-13 11:23:58', '2024-05-13 17:11:58', 'asIP49PY4tYBo0x803Ooh4L8qrUh80plEY40E6INZLz2etwwHJwsRkHy6cVktAL85dOcDGBWMGfczCGfI0Z0wrxdbsg9vxysnvwi', NULL, NULL, 9),
(22, 'Nathan.m@viacesi.fr', 'Nathan', 'Mo', '$2y$12$6bBvza6hw8LtWXeHI3Ayt.Q9YBULPcke03fxeLVoOGgQqY3KxcGv6', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:24:21', '2024-05-13 17:11:58', 'VQGB8rbMokhoSAUwlrwWMtCy1NtumyZDqFiNbglgYvQ182zN6UCGYXs4XL0YKi2T4kjHZU3UuZQLa1FQ3spA91mwEhgVjl0bUzkY', NULL, NULL, 1),
(23, 'Arno.r@viacesi.fr', 'Arno', 'Ro', '$2y$12$g3fnjVZ6NX0zTMU8sjfz0eGPX6pnlRtlFVI.f2VHvEsdXvehVF4wi', 0, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:24:45', '2024-05-13 17:11:58', 'B49eS9g8fgI18w0wmBaASKVUVmnISkc4yRGEH3f94q92HUsclAXygiTb0KGKkfE7FobHa4dZF77fjnFi7LFEP684xiRqnbVi0b9Y', NULL, NULL, 19),
(24, 'Adrien.v@viacesi.fr', 'Adrien', 'Ve', '$2y$12$FnNb1vgRYb/xVcxMrk2Oj.B72WxDAP3OQD.0jh53ZIjZPS9.6wswa', 1, NULL, NULL, NULL, NULL, 4, '2024-05-13 11:25:12', '2024-05-13 17:11:58', NULL, NULL, NULL, 4),
(25, 'John.doe@example.com', 'John', 'Doe', '$2y$12$15rytgj9MeKVt4LUUmol7.IEzTq9ThFGBoV9/ncS18Dpxm9vi5Ct6', 1, NULL, 6, 6, 174, 4, '2024-05-13 14:42:17', '2024-05-13 20:11:07', NULL, NULL, NULL, 4),
(26, 'jane.smith@example.com', 'Jane', 'Smith', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 7, 7, 6, 4, '2024-05-13 17:54:51', '2024-05-13 20:11:07', NULL, NULL, NULL, 15),
(27, 'michael.brown@example.com', 'Michael', 'Brown', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, NULL, 4, '2024-05-13 17:59:46', '2024-05-13 20:11:07', NULL, NULL, NULL, 6),
(28, 'emily.johnson@example.com', 'Emily', 'Johnson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, NULL, 4, '2024-05-13 18:06:14', '2024-05-13 18:17:17', NULL, NULL, NULL, 18),
(29, 'robert.davis@example.com', 'Robert', 'Davis', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, NULL, 4, '2024-05-13 18:06:51', '2024-05-13 18:17:11', NULL, NULL, NULL, 12),
(30, 'sarah.miller@example.com', 'Sarah', 'Miller', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, 182, 4, '2024-05-13 18:07:16', '2024-05-13 19:03:04', NULL, NULL, NULL, 5),
(31, 'james.wilson@example.com', 'James', 'Wilson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, NULL, 4, '2024-05-13 18:07:37', '2024-05-13 18:17:03', NULL, NULL, NULL, 2),
(32, 'jessica.moore@example.com', 'Jessica', 'Moore', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, NULL, 4, '2024-05-13 18:08:14', '2024-05-13 18:16:59', NULL, NULL, NULL, 8),
(33, 'david.taylor@example.com', 'David', 'Taylor', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, 25, 4, '2024-05-13 18:08:57', '2024-05-13 18:41:32', NULL, NULL, NULL, 12),
(34, 'laura.anderson@example.com', 'Laura', 'Anderson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 2, 7, 37, 4, '2024-05-13 18:45:02', '2024-05-13 18:54:21', NULL, NULL, NULL, 15),
(35, 'daniel.thomas@example.com', 'Daniel', 'Thomas', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, 220, 4, '2024-05-13 18:47:18', '2024-05-13 19:01:35', NULL, NULL, NULL, 15),
(36, 'emma.jackson@example.com', 'Emma', 'Jackson', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, 231, 4, '2024-05-13 18:47:44', '2024-05-13 20:49:51', NULL, NULL, NULL, 4),
(37, 'matthew.white@example.com', 'Matthew', 'White', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, 11, 4, '2024-05-13 18:48:26', '2024-05-13 20:49:51', NULL, NULL, NULL, 10),
(38, 'John.ban@example.com', 'John', 'Ban', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, 253402297199000, NULL, NULL, NULL, 4, '2024-05-14 18:21:31', '2024-05-14 18:23:26', 'NszcDLLMMPJytugQaznH5G6u8EuRS5dbWVHsqqcQuSCp0JIMEWnFrL5Z15V64kVRtw1ZMliF6Y0oPpcYIJO6JRuF065z6yJbXvhF', NULL, NULL, 15),
(39, 'John.sup@example.com', 'John', 'Sup', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, NULL, NULL, NULL, 4, '2024-05-14 18:21:56', '2024-05-14 18:23:32', NULL, NULL, '2024-05-14 18:23:32', 1);

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
(1, 2, 2, 'Modify', 'country', NULL, 'France', '2024-05-13 12:33:54'),
(2, 2, 2, 'Modify', 'city', NULL, 'Salon de Provence', '2024-05-13 12:33:54'),
(3, 2, 2, 'Modify', 'postal_code', NULL, '13300', '2024-05-13 12:33:54'),
(4, 3, 3, 'Modify', 'country', NULL, 'France', '2024-05-13 12:55:15'),
(5, 3, 3, 'Modify', 'city', NULL, 'Vitrolles', '2024-05-13 12:55:15'),
(6, 3, 3, 'Modify', 'postal_code', NULL, '13127', '2024-05-13 12:55:15'),
(7, 1, 4, 'Modify', 'is_verified', '0', '1', '2024-05-13 13:09:03'),
(8, 4, 4, 'Modify', 'country', NULL, 'France', '2024-05-13 13:11:19'),
(9, 4, 4, 'Modify', 'city', NULL, 'Toulon', '2024-05-13 13:11:19'),
(10, 4, 4, 'Modify', 'postal_code', NULL, '83000', '2024-05-13 13:11:19'),
(11, 1, 2, 'Modify', 'role', 'Utilisateur', 'SuperAdministrateur', '2024-05-13 13:12:22'),
(12, 1, 3, 'Modify', 'role', 'Utilisateur', 'Moderateur', '2024-05-13 13:12:28'),
(13, 1, 4, 'Modify', 'role', 'Utilisateur', 'Administrateur', '2024-05-13 13:12:35'),
(14, 1, 5, 'Create', NULL, NULL, NULL, '2024-05-13 13:13:18'),
(15, 1, 6, 'Create', NULL, NULL, NULL, '2024-05-13 13:14:54'),
(16, 1, 7, 'Create', NULL, NULL, NULL, '2024-05-13 13:15:26'),
(17, 1, 8, 'Create', NULL, NULL, NULL, '2024-05-13 13:16:13'),
(18, 1, 9, 'Create', NULL, NULL, NULL, '2024-05-13 13:16:51'),
(19, 1, 10, 'Create', NULL, NULL, NULL, '2024-05-13 13:17:30'),
(20, 1, 11, 'Create', NULL, NULL, NULL, '2024-05-13 13:18:08'),
(21, 1, 12, 'Create', NULL, NULL, NULL, '2024-05-13 13:19:03'),
(22, 1, 13, 'Create', NULL, NULL, NULL, '2024-05-13 13:19:29'),
(23, 1, 14, 'Create', NULL, NULL, NULL, '2024-05-13 13:20:10'),
(24, 1, 15, 'Create', NULL, NULL, NULL, '2024-05-13 13:20:42'),
(25, 1, 16, 'Create', NULL, NULL, NULL, '2024-05-13 13:21:08'),
(26, 1, 17, 'Create', NULL, NULL, NULL, '2024-05-13 13:21:37'),
(27, 1, 18, 'Create', NULL, NULL, NULL, '2024-05-13 13:22:01'),
(28, 1, 19, 'Create', NULL, NULL, NULL, '2024-05-13 13:22:45'),
(29, 1, 20, 'Create', NULL, NULL, NULL, '2024-05-13 13:23:38'),
(30, 1, 21, 'Create', NULL, NULL, NULL, '2024-05-13 13:24:00'),
(31, 1, 22, 'Create', NULL, NULL, NULL, '2024-05-13 13:24:25'),
(32, 1, 23, 'Create', NULL, NULL, NULL, '2024-05-13 13:24:47'),
(33, 1, 24, 'Create', NULL, NULL, NULL, '2024-05-13 13:25:15'),
(34, 1, 3, 'Modify', 'is_verified', '0', '1', '2024-05-13 13:26:14'),
(35, 1, 1, 'Modify', 'country', NULL, 'France', '2024-05-13 13:36:13'),
(36, 1, 1, 'Modify', 'city', NULL, 'Aix la Duranne', '2024-05-13 13:36:13'),
(37, 1, 1, 'Modify', 'postal_code', NULL, '13100', '2024-05-13 13:36:13'),
(38, 1, 21, 'Modify', 'is_verified', '0', '1', '2024-05-13 14:31:53'),
(39, 1, 21, 'Modify', 'country', NULL, 'Antarctique', '2024-05-13 14:31:53'),
(40, 1, 21, 'Modify', 'city', NULL, 'Brest', '2024-05-13 14:31:53'),
(41, 1, 21, 'Modify', 'postal_code', NULL, '05500', '2024-05-13 14:31:53'),
(42, 1, 21, 'Modify', 'role', 'Utilisateur', 'Moderateur', '2024-05-13 14:31:53'),
(43, 25, 25, 'Modify', 'email', 'John.doe@example.com', 'John.doe@exemple.com', '2024-05-13 16:43:11'),
(44, 25, 25, 'Modify', 'country', NULL, 'Pologne', '2024-05-13 16:46:27'),
(45, 25, 25, 'Modify', 'city', NULL, 'Elblag', '2024-05-13 16:46:27'),
(46, 25, 25, 'Modify', 'postal_code', NULL, '82300', '2024-05-13 16:46:27'),
(47, 1, 25, 'Modify', 'is_verified', '0', '1', '2024-05-13 16:54:06'),
(48, 1, 1, 'Modify', 'last_name', 'Ch', 'Chwiej', '2024-05-13 17:18:19'),
(49, 1, 1, 'Modify', 'email', 'c.nicolas@gmail.com', 'chwiej.nicolas@gmail.com', '2024-05-13 17:18:19'),
(50, 1, 1, 'Modify', 'last_name', 'Chwiej', 'Ch', '2024-05-13 19:03:42'),
(51, 1, 1, 'Modify', 'email', 'chwiej.nicolas@gmail.com', 'c.nicolas@gmail.com', '2024-05-13 19:03:42'),
(52, 26, 26, 'Modify', 'country', NULL, 'Andorre', '2024-05-13 19:55:49'),
(53, 26, 26, 'Modify', 'city', NULL, 'Andore', '2024-05-13 19:55:49'),
(54, 26, 26, 'Modify', 'postal_code', NULL, '000', '2024-05-13 19:55:49'),
(55, 1, 26, 'Modify', 'is_verified', '0', '1', '2024-05-13 19:56:21'),
(56, 1, 27, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:03:28'),
(57, 1, 33, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:16:54'),
(58, 1, 32, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:16:59'),
(59, 1, 31, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:17:03'),
(60, 1, 30, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:17:07'),
(61, 1, 29, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:17:11'),
(62, 1, 28, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:17:17'),
(63, 33, 33, 'Modify', 'country', NULL, 'Brésil', '2024-05-13 20:41:32'),
(64, 36, 36, 'Modify', 'country', NULL, 'États-Unis', '2024-05-13 20:48:08'),
(65, 37, 37, 'Modify', 'country', NULL, 'Australie', '2024-05-13 20:48:37'),
(66, 1, 37, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:49:16'),
(67, 1, 36, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:49:19'),
(68, 1, 35, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:49:23'),
(69, 1, 34, 'Modify', 'is_verified', '0', '1', '2024-05-13 20:49:27'),
(70, 34, 34, 'Modify', 'country', NULL, 'Canada', '2024-05-13 20:54:21'),
(71, 34, 34, 'Modify', 'city', NULL, 'Vitrolles', '2024-05-13 20:54:21'),
(72, 34, 34, 'Modify', 'postal_code', NULL, '000', '2024-05-13 20:54:21'),
(73, 35, 35, 'Modify', 'country', NULL, 'Turquie', '2024-05-13 21:01:35'),
(74, 30, 30, 'Modify', 'country', NULL, 'Fédération de Russie', '2024-05-13 21:03:04'),
(75, 1, 38, 'Create', NULL, NULL, NULL, '2024-05-14 20:21:33'),
(76, 1, 39, 'Create', NULL, NULL, NULL, '2024-05-14 20:21:57'),
(77, 1, 38, 'Ban', 'ban_until', NULL, '253402297199000', '2024-05-14 20:23:26'),
(78, 1, 39, 'Delete', 'deleted_at', NULL, '2024-05-14 20:23:32', '2024-05-14 20:23:32');

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
  MODIFY `id_blocked` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `cities`
--
ALTER TABLE `cities`
  MODIFY `id_city` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id_comment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pour la table `countries`
--
ALTER TABLE `countries`
  MODIFY `id_country` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=242;

--
-- AUTO_INCREMENT pour la table `files`
--
ALTER TABLE `files`
  MODIFY `id_file` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `games`
--
ALTER TABLE `games`
  MODIFY `id_game` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `invitations`
--
ALTER TABLE `invitations`
  MODIFY `id_invitation` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `login_logs`
--
ALTER TABLE `login_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

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
  MODIFY `id_ressource` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT pour la table `rights`
--
ALTER TABLE `rights`
  MODIFY `id_right` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `statistics_archive`
--
ALTER TABLE `statistics_archive`
  MODIFY `id_statistic_archive` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

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
