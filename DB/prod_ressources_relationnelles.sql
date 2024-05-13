-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 13 mai 2024 à 20:23
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
-- Base de données : `prod_ressources_relationnelles`
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
(2, 6),
(25, 13);

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
(2, 6),
(2, 13),
(3, 13),
(25, 13);

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
(12, 'Santé psychique', 'Approfondissez votre compréhension de la santé mentale et découvrez des stratégies pour préserver ou améliorer votre bien-être émotionnel. Cette catégorie propose des ressources sur des sujets tels que la gestion du stress, la lutte contre l\'anxiété, la dépression, et d\'autres problématiques psychiques. Explorez des techniques de relaxation, des pratiques de pleine conscience, et les dernières avancées en psychothérapie pour soutenir votre parcours vers une meilleure santé mentale. Idéal pour tous ceux qui cherchent à améliorer leur résilience émotionnelle et à vivre une vie plus équilibrée et sereine.', 'medical-icon:i-mental-health', '#ff0000', 1, 1, '2024-05-13 09:29:42', '2024-05-13 09:29:42'),
(13, 'Spiritualité', 'Explorez les dimensions profondes de l\'existence à travers différentes pratiques et croyances spirituelles. Cette catégorie offre des insights sur la méditation, la prière, la connexion avec la nature, et d\'autres voies menant à l\'épanouissement spirituel. Découvrez comment intégrer la spiritualité dans votre vie quotidienne pour favoriser la paix intérieure, l\'éveil personnel, et une connexion plus profonde avec le monde qui vous entoure. Idéale pour ceux qui cherchent à enrichir leur parcours personnel à travers une compréhension plus profonde des mystères de la vie et de l\'âme.', 'token:spirit', '#ff70d9', 1, 1, '2024-05-13 09:32:26', '2024-05-13 09:32:26'),
(14, 'Vie affective', 'Découvrez les clés pour cultiver et enrichir vos relations affectives. Cette catégorie explore les dynamiques des relations amoureuses, amicales et familiales, offrant des conseils pour renforcer les liens, gérer les conflits et communiquer efficacement. Apprenez à construire des relations saines et épanouissantes, à comprendre les besoins émotionnels propres et ceux des autres, et à naviguer dans les complexités des interactions humaines. Idéal pour tous ceux qui cherchent à améliorer leur vie affective et à développer une meilleure intelligence relationnelle.', 'eva:activity-fill', '#093a19', 1, 1, '2024-05-13 09:33:40', '2024-05-13 09:33:40'),
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
(6, 'Elblag');

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
(14, 'La FSO Polonez, im bat table', '2024-05-13 16:49:57', NULL, 13, 25, 1);

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
(25, 25, '2024-05-13 19:31:41');

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
(6, '82300');

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
(1, 'Reconnaître ses émotions', 'L’objectif de cet exercice est de reconnaître les émotions sur soi. Pour ce faire, nous noterons dans un \npetit cahier prévu à cet effet, à des moments prédéfinis de la journée, comment nous nous sentons \némotionnellement. Quelle émotion nous habite ? Cette émotion est-elle positive ou négative ? Avec \nquelle force ? Quel a été le facteur déclencheur ?\nNous répèterons la démarche durant une semaine.\nAprès une semaine, reprenons nos notes et identifions avec un marqueur les émotions que nous \nressentons le plus souvent, si elles sont positives ou négatives et quel type de facteur déclencheur est \nobservé le plus souvent.\nPour conclure, demandons-nous si nos émotions auraient pu être différentes et si la situation en aurait \nété changée', NULL, 1, 0, 1, 5, 1, 1, NULL, '2024-05-13 09:35:53', '2024-05-13 10:24:12', NULL),
(2, 'Emission ARTE : Travail | Travail, Salaire, Profit', 'Travail | Travail, Salaire, Profit\n\nhttps://www.youtube.com/watch?v=Dpzv8H16R-Q', NULL, 1, 0, 1, 7, 1, 1, NULL, '2024-05-13 10:07:29', '2024-05-13 10:24:45', NULL);
INSERT INTO `ressources` (`id_ressource`, `label`, `description`, `content`, `is_public`, `view_count`, `id_user`, `id_category`, `id_status`, `id_type`, `file`, `created_at`, `updated_at`, `staff_comment`) VALUES
(3, 'Le rire au travail et l’éthique', 'Introduction\n\n\n1 Dans cet article, nous souhaitons apporter des éléments de réponse à la question du rire\ndans les situations professionnelles. Notre objectif est d’orienter les travaux de recherche\nportant plus globalement sur l’éthique au travail, mais aussi de fournir des repères pour le\ndéveloppement des pratiques de management. Si le rire comme expression émotionnelle\nspontanée de joie semble de prime abord échapper à toute tentative de management, c’est\njustement cette attribution communément positive et, de plus, associée à une liberté\ninaliénable du sujet qui ressort de notre étude comme contribuant en partie aux problèmes\nqu’il soulève. En effet, le rire désigne un comportement individuel ou collectif qui n’émerge\net ne trouve son sens que dans un contexte d’échanges sociaux. Située dans le champ de la\ngestion des ressources humaines, cette étude se limite aux situations professionnelles\nd’interactions directes entre des personnes au travail. La complexité de la problématique du\nrire s’en trouve réduite puisque nous écartons les phénomènes de foule, les tabous sociétaux,\nle rapport au sacré ou encore l’exercice des contre-pouvoirs dans nos démocraties modernes.\n\n\n2 Le point de départ des travaux présentés est le constat dans le cadre d’une recherche plus\nlarge menée par recherche-action sur le rôle du tiers avec la posture de coach, que plusieurs\nsalariés, demandeurs d’une aide ponctuelle pour résoudre un problème ou sortir d’une\nsituation qu’ils ressentaient comme insupportable, évoquaient “le rire”, celui des autres ou le\nleur propre, soit comme une source de mal-être, soit comme un mode de résistance ou de\ndéfense de soi. Nous nous sommes alors appuyés sur sept cas sélectionnés car ils s’avéraient\nen rapport direct avec le sujet et l’analyse de contenu des 42 entretiens individuels ainsi\nréalisés pour proposer une grille d’intelligibilité du phénomène plaçant le rire au travail au\ncœur d’une problématique managériale d’ordre éthique.\n\n\n3 Pour cela, nous avons dans un premier temps effectué une revue de littérature en\nl’élargissant à la philosophie morale, pour dans une seconde partie procéder à l’analyse de nos\nmatériaux recueillis empiriquement. Nous avions en effet à traiter du rire d’une part en ce\nqu’il émerge au sein d’une situation professionnelle qu’il transforme, et de l’éthique abordée\ncomme un processus de questionnement de la morale (Ricœur, 2010). Ces deux notions\nsemblaient relever d’obligations s’imposant au sujet pour des raisons obscures et “au-delà” de\nlui de par sa nature humaine ou d’un impératif supérieur. La question centrale de notre étude\nest ainsi : le rire au travail est-il mal ? Et si oui, comment le réguler ? D’emblée, nous\npouvons préciser que le rire ne peut être considéré comme mal en soi et que par suite, notre\nquestionnement doit trouver une formulation plus appropriée. C’est déjà rentrer dans cette\nréflexion éthique chère aux philosophes et à laquelle ne peut échapper ni le chercheur en\ngestion soucieux d’apporter des réponses à la question du bon ou du mal-rire au travail, ni le\nmanager incapable de savoir quand et comment le réguler. Ainsi, les demandeurs d’aide de\nl’étude, tous cadres d’entreprise et tous, pour des raisons différentes, subissant concrètement\nune situation, où deux obligations, celle du rire et celle de la morale, se trouvaient en\nopposition, faisaient appel à un tiers pour en sortir.\n\n\n4 Comment dès lors identifier et traiter de ce qui rentre en tension pour les individus ou les\ncollectifs et qui semble relever moins d’un jugement que du sentiment moral ? S’agit-il, pour\nreprendre une grille d’analyse tirée de la psychologie sociale (Moscovici, 1984, p.9), d’un\nconflit dans le rapport à un objet, pour nous le travail, entre un sujet individuel en quête\nd’authenticité et d’affirmation, et un sujet social en quête de conformité et d’intégration ? Le\nrire se situant dans le champ des expressions spontanées d’un ressenti, peut-on solliciter la\nnotion de “dissonance émotionnelle”, déjà développée en appui sur les travaux de Leon\nFestinger (1957) dans le domaine du management (Van Hoorebeke, 2003) ?\nL’approfondissement dans cette voie au regard de notre problématique considérerait comme\nun double postulat initial que premièrement, pour prévenir les éventuelles divergences entre\nrire et morale, les sujets doivent au préalable accéder à la connaissance de l’un comme de\nl’autre, et deuxièmement, qu’ils arriveront par suite à un contrôle individuel et social des\nphénomènes du rire. Ce serait supposer que les définitions préexistent à la manifestation du\nrire, posées définitivement comme des vérités préalables et confondre “éthique” avec discours\nnormatif et pression de conformité. Or, le propre du rire est qu’il ne s’explique pas : il arrive\net surprend le rieur. Or, le propre du mal-rire est que s’il est désigné comme une vérité, c’est\ndans une approche par la manifestation consistant « à laisser-être ce qui se montre »\n(Thomasset, 1996, p.253).\n\n\n5 Nous souhaitons emprunter ce chemin de questionnement et de réflexion pour poser puis\ntenter de résoudre la problématique de cette étude. Partant de ce mal-rire présent dans les\ndiscours de plainte sur le travail, notre objectif est de nous tourner du côté des pratiques de\nmanagement au sein des organisations pour identifier en quoi elles en favorisent ou non\nl’émergence. L’objet de notre étude délimitant par ailleurs le champ de sa problématique est\ndonc le vécu d’un rire désigné comme “mal” par au moins un des acteurs de la situation, soit\ndans l’instant, soit après-coup. Nous avons ensuite questionné ce mal-rire désigné au regard\nde la littérature et par la mise en évidence et la discussion de trois puis quatre indicateurs nous\nconcluons sur les pratiques de régulation.\n\n\n\n1 – Des bienfaits du rire au travail à la problématique de sa nécessaire régulation\n\n6 Le questionnement sous-tendu par la tension entre rire et morale pourrait nous renvoyer à\nl’un des débats philosophiques toujours ouvert (Darwall, 1995), opposant notamment le comte\nde Shaftesbury (1715) [1][1]« On peut objecter que ces affections, toutes dénaturées…, qui\ndans la lignée des stoïciens, en appelait à un gouvernement de soi mais hors de toute loi\nexterne, hors de toute sanction, par satisfaction de l’action bonne, à Emmanuel Kant pour qui\nl’autodétermination est un exercice de la volonté individuelle pour appliquer la loi morale.\nMalgré tout, l’un comme l’autre se tournent vers le sujet avec implicitement l’injonction de ne\npas “mal-rire”. Sous cet angle, le management ne saurait être concerne?, puisqu’il ne s’agirait\nque d’une moralité proche de la discipline personnelle et hors du champ des compétences\nprofessionnelles. Le problème est tout autre si l’on aborde la question de l’interdiction du rire\nconsidéré comme un comportement professionnel inapproprié ou producteur de mal-être au\ntravail. Ainsi, l’interrogation, qui sous-tend cette étude est bien : « faut-il réguler le rire au\ntravail ? » avec pour corollaires : « comment sait-on qu’une régulation est nécessaire ? » et\n« si c’est nécessaire, comment procéder ? ». Pour répondre à ces questions, nous avons\nprocédé à une revue de littérature notamment dans le domaine de la philosophie morale.\n\n\n1.1 – Le rire comme problème d’ordre éthique entre droit naturel et contrôle social\n\n\n7 Sans considérer avec Jacques Abadie (2003, p.267) que « les hommes pensent que leur rire\nest toujours innocent, et pourtant il est toujours criminel et condamnable » car il émerge au\ndétriment d’un autre, la croyance opposée et socialement partagée que « les rieurs sont\ntoujours du bon côté [2][2]Nous indiquons les « extraits de discours » entre guillemets en… »\nen devient une arme puissante de domination. Pour Robert Solomon (1998), les émotions ne\n« font pas juste de nous arriver », et nous les utilisons pour affronter les autres. Sous cet\nangle, les personnes utilisent leurs émotions pour agir en leur faveur en mettant en œuvre ce\nqui peut être désigné comme une “stratégie du rire”. Si une conception d’un rire\nexclusivement “sous contrôle” est rapidement démentie empiriquement, ne serait-ce que par\nnotre propre expérience, quand le rire “éclate”, il est certes hors de la volonté du sujet, mais il\ns’inscrit dans un contexte social et même dans une situation directement vécue. Ainsi, le rire\nressort comme la résultante d’une forme d’obligation, qui rejoint celle du sens moral de\nFrancis Hutcheson (1993) dans la mesure où elle « n’est pas la contrainte d’une loi\nextérieure ; mais [où Hutcheson] n’a pas pour autant conçu cette obligation comme une\nobligation intérieure » (Jaffro, 2000, p.45). « Rire nerveux », « fou-rire », les rieurs\ns’exclameront : « c’est plus fort que moi ! ».\n\n\n8 Mais que faire ? Interdire de rire dans les organisations ? Bien évidemment même la\nquestion est absurde pour trois raisons, dont deux au moins semblent évidentes. D’une part, le\nrire est une expression émotionnelle généralement spontanée, échappant à la volonté des\npersonnes, voire à leur conscience. L’exiger [3][3]Le point souligné ressort comme encore plus\névident si on… ou l’interdire par une loi ou une règle en ressort comme contraire à l’éthique\ndans la mesure où, elle placerait les sujets dans une situation où il est impossible de bien se\nconduire, puisque quoi qu’ils fassent, aucun être humain n’a la capacité de s’y\nconformer [4][4]Nous nous démarquons ici des stoïciens qui avec Cicéron…. On retrouve la\nnotion “d’injonction paradoxale”, consistant à exiger un comportement « qui ne peut surgir\nque spontanément et non sur commande » (Watzlawick, 1980, p.106) et source de détresse\nchez les individus qui y sont soumis. Un autre courant théorique traitant des “obscurs\nressorts” du rire incontrôlé en introduisant la notion “d’inconscient” nous permet de souligner\nl’aberration de l’interdiction du rire, celui de la psychanalyse freudienne. Considérant que\n« Le sur-moi-de-la-culture a produit ses idéaux et élevé ses exigences ? Parmi ces dernières,\ncelles qui concernent les relations des hommes entre eux sont regroupées en tant\nqu’éthique », Sigmund Freud (1929, p.85-86) va s’interroger sur la possibilité « d’écarter le\nplus grand obstacle à la culture » qu’il ramène à deux pulsions humaines en conflit, celle de\nl’agression ou de l’auto-anéantissement et celle de la vie (Eros), tout en expliquant que leur\nrefoulement ou leur négation ne peut que conduire à leur surgissement inconscient et\nsocialement inapproprié, voir destructeur de soi ou d’autrui.\n \n\n9 Si le propos de Freud représente un modèle du constat contre-intuitif d’un développement\nconjoint de la violence et de la culture, il conforte la pertinence de notre premier argument.\n\n\n10 Une deuxième raison est que le recours formel à la coercition soulèverait des objections\nmorales bien plus importantes au point qu’on ne peut imaginer la stipulation dans un\nrèglement intérieur ou le code du travail qu’il est formellement interdit de rire dans les\nsituations professionnelles [5][5]Par contre, plusieurs cas de « fou-rire » ont été relevés…. En\neffet, d’un côté, cela atteindrait la liberté de critiquer, ce que le comte de Shaftesbury (1710,\np.1) condamnait dès le XVIIIe\nsiècle, tout en en questionnant les soubassements et les dérives\npotentielles : « Mais qui sera le juge de ce que la censure peut examiner librement, ou de ce\nqu’elle doit souffrir impunément ? Qui décidera des circonstances où la liberté peut agir sans\nscrupule, ou se taire ? ». Resituée dans le contexte actuel d’une entreprise, cela déposséderait\nles salariés de l’un de leurs modes d’expression fondamental, celui des émotions, dont l’usage\nserait défini hors d’eux-mêmes. Cela reviendrait à une forme de déshumanisation du\npersonnel, dont il n’est plus nécessaire aujourd’hui, de rappeler les multiples critiques non\nseulement d’ordre éthique, mais aussi associées au constat qu’un tel mode de gouvernance\nréifiant les forces de travail est contre-productif et dessert les intérêts économiques de\nl’organisation. D’un autre côté, la loi se tromperait là encore d’objet, car ou bien le rire est\n“bon” et l’interdire est injustifiable ou bien il est “mal”, et n’est-ce pas dès lors la dynamique\nmême du mal-rire qui est à bannir ? Si l’on considère que les ressorts du rire sont mauvais,\ncomme le soulignait en 1720 Gottfried Wilhelm Leibniz (1720, p.3) dans ce qu’il présentait\ncomme une réponse à Shaftesbury et qui ici nous semble se situer dans une logique\ncomplémentaire : « Je ne vois pas aussi que le ris, c’est-à-dire quelque chose qui tient du\nmépris et abaisse l’idée de l’objet, soit une pierre de touche qui serve à reconnaître la vérité.\nMépriser ce qu’on ne connaît pas encore est une prévention dont il faut se défaire ». Sous cet\nangle, et en poussant le raisonnement, la crainte du rire serait une peur des puissants que\ncelui-ci ne puisse révéler une vérité : au final, la censure serait l’indicateur de mensonges que\nles personnes ries chercheraient à protéger. Sans rentrer dans le débat, Shaftesbury comme\nLeibniz, nous ramène à la même interrogation : si une interdiction ou des sanctions sont à\nposer par une règle ou une loi, ne doivent-elles pas porter sur ce qui conduit à un mal-rire ?\n\n\n11 La troisième raison de l’inimaginable interdiction du rire est reliée aux deux autres mais\ntout en rappelant l’existence des vertus du “bon rire” qui permet de supporter sa condition\nhumaine et les épreuves de la vie, voire de préserver sa dignité. Malgré tout, la problématique\ndu rire au travail va bien au-delà d’un tri entre le bon et le mauvais rire. Nous pouvons\nretrouver à la fois la figure maléfique du pervers qui rit du malheur d’autrui, le surgissement\nd’une émotion échappant au contrôle du sujet, et qui par contrecoup le dessert ou que luimême trouve inapproprié, et en dernier une situation ou? le rire est la seule issue permettant à\nla personne d’exister dans un contexte d’aliénation. Le rire se manifeste mais rien n’est\n“risible” en soi. Cette expression émotionnelle spécifique ne donne que peu d’informations\nsur son objet ou sur ce que nous pourrions tenter de cerner en définissant la catégorie du\n“risible”. Par contre il désigne un contexte ou renseigne sur la nature du rieur, et soit dans\nl’un, soit dans le second, ou encore dans les deux, quelque chose de mauvais se joue, qu’il\nrévèle. Au final, aucuns des rieurs concernés - harceleurs, manipulée ou exclu - ne se trouvent\ndu bon côté. Il en ressort que la question posée n’est pas celle du “comique”, celui-ci\nd’ailleurs ne suscitant pas forcément un éclat de rire, mais celle de la dynamique du rire au\ntravail, qui semble associée à trois notions principales elles-mêmes inter-reliées [6][6]Cette\ninterrelation entre pouvoir, vérité et existence se…, celles du “pouvoir”, de “la vérité”, et de\n“l’existence”, avec une fonction restant à identifier et à questionner de régulateur et/ou\nd’indicateur.\n\n1.2 – Le rire au travail, un régulateur éthique ?\n\n\n12 Abordé comme régulateur, le rire peut tout d’abord être considéré comme une pratique\nsociale présupposant un déclencheur du rire et au moins un rieur. Il s’agit a minima d’une\ninteraction entre un sujet et son environnement social. Si le débat semble ouvert entre les\nphilosophes sur la possibilité de rire de soi, de rire seul ou si un tiers est nécessaire [7][7]Pour\nFreud S. (1905, p. 262-263), « Nul ne peut se satisfaire…, nous n’aborderons cette question\nqu’indirectement en nous focalisant sur les théories nous permettant d’éclairer l’éventuelle\nfonction d’indicateur ou de régulateur éthique du rire en situations professionnelles. Dans les\norganisations, comme le soulignait Ignasi Marti en 2009 (p.128) : « La vision traditionnelle\nde la résistance est une vision connotée d’opposition, voire d’agressivité ». Si l’apport des\nformes d’action sans violence est souligné par l’auteur, tout comme l’impact de la\ndéstabilisation, le recours à l’humour ou à l’ironie n’est pas évoqué.\n\n\n13 Par ailleurs, plusieurs travaux en sciences de gestion abordent le management en\nsoulignant le rôle d’une notion, “l’intelligence émotionnelle”, pour l’efficacité des leaders et\nleur capacité à influencer les individus et les groupes pour atteindre leurs objectifs (Kotzé et\nVenter, 2011). Le rire peut en ressortir comme une aptitude à extérioriser des émotions\n« positives » permettant de mieux faire face au stress et d’entretenir une vision optimiste de\nl’avenir favorable à la réalisation mais aussi à la mobilisation au travail. Le processus est\nsouvent identifié comme relevant de ce qui est désigné comme un processus de\n« contagion émotionnelle » (Barsade, 2002) favorisant, lorsque les émotions sont “positives”,\nla coopération et la performance individuelle et collective. Le rire est presque\nsystématiquement ramené à une expression de joie, cette dernière étant catégorisée dans le\ngroupe de ces émotions “positives”. Notre approche est bien différente dans la mesure où\nd’une part même si cette attribution est communément admise depuis Darwin [8][8]Darwin\nC.R. (1872) reste toutefois prudent, puisqu’il considère…, nous nous limiterons à considérer\nprudemment que le rire correspond à l’extériorisation d’une décharge émotionnelle et que\nd’autre part, tout en restant toutefois “binaire” puisque nous opposons le “bien” et le “mal”, le\nqualificatif de “positif” nous semble inapproprié pour le “mal-rire”. Cette affirmation trouve\nun étayage empirique dans l’un des cas de coaching ayant initié la réflexion présentée dans cet\narticle. En dehors de plusieurs situations où les coachés interprétaient mal la nature de leurs\némotions par conformité sociale et en éprouvaient un mal-être à l’origine de leur demande,\nnotamment du fait du caractère “sexué” des émotions (Braconnier, 2000), Or de nombreux\ntravaux ont montré que le processus de changement dans les situations de travail présente de\nfortes similitudes avec celui du deuil (Kets de Vries et Miller, 1985), dont la psychiatre\nElisabeth Kubler-Ross (1989) a conceptualisé les étapes : allant du déni de la réalité qui\nheurte le sujet, à l’acceptation, en passant par la révolte et le marchandage. Au niveau affectif,\nles personnes doivent « s’arracher pour se détacher » de leur état antérieur, ce qui\ns’accompagne de différents ressentis émotionnels, dont les deux principaux sont la colère puis\nla peine, deux émotions désignées comme “négatives”. Il en ressort que ce n’est pas le rire ou\nl’expression d’émotions positives qui représente en soi un mode de régulation mais la\nrégulation des émotions ressenties en autorisant et canalisant leur expression d’une façon\nsocialement acceptable. Ainsi, dans la lignée des études déjà menées, définissant comme\ncompétence du leader, celle de « régulateur des états émotionnels » de son équipe (Haag et\nLaroche, 2009), plus que d’orienter le groupe vers un type d’émotions, ne peut-on pas faire la\nproposition qu’il s’agirait plutôt de lui permettre une expression moralement acceptable d’un\nressenti par nature échappant au contrôle ? Ce cas confirme également d’autres résultats de\nrecherche soulignant l’importance pour les décideurs d’écouter leurs émotions pour bien\norienter leur jugement (Coger, Haag et Bonnefous, 2009).\n\n\n\n1.3 – Quels indicateurs du mal-rire au travail ?\n\n\n14 Notre analyse nous conduit également à questionner le caractère moralement acceptable de\nla moquerie, en ce qu’elle définit un rire dont l’objet est autrui, et par suite à nous interroger\nsur les indicateurs du mal-rire. En effet, lorsqu’elle se tourne vers autrui, qui d’objet du rire se\nretrouve placée en position de victime, la moquerie est aujourd’hui considérée comme\nillégitime et condamnable depuis la loi de 2002 contre le harcèlement moral au\ntravail [9][9]Loi n° 2002-73 du 17 janvier 2002 de modernisation sociale,…. Dans ces\nsituations, le “mal-rire” est évident, tout autant que la violence subie, tant depuis Nietzsche,\nl’on sait que : « Ce n’est pas par la colère, c’est par le rire que l’on tue » (Kessler, 2005,\np.507). Par contre, dans d’autres contextes une “gentille moquerie” peut « détendre\nl’atmosphère » et susciter le rire de l’intéressé(e), se considérant lui-même/elle-même comme\n“taquiné(e) avec bienveillance”. Ainsi, ce n’est pas la moquerie qui en ressort comme\nl’indicateur systématique du “mal-rire”, mais la volonté de son “bon usage”. Emmanuel\nJaffelin (2010, p.106) propose ainsi entre autres définitions de la gentillesse, celle de\n« l’expression de notre bon vouloir, qui est aussi vouloir du bien ». Nous retrouvons ici le\n“bon usage des passions” de René Descartes (1649, p.227 à 230) qui s’opère non par\ndomination de la raison mais par la volonté « résolue » d’un sujet « averti de l’emportement »\nque peut être une passion, et du « rempart que constitue sa fermeté ? d’âme ou sa\nrésolution », la générosité se définissant pour Descartes par l’estime de soi-même, considérée\ncomme une vertu, et non par l’altruisme ou l’oubli de soi. Malgré tout, et sans rentrer dans les\nressorts de ce bon usage des passions, il nous semblerait hasardeux de tenter de différencier\nles “méchantes” des “gentilles” moqueries en prenant comme critère la volonté du moqueur\nde blesser le moqué ou son incompétence à exercer son « libre arbitre avec justesse ». En\ndehors de la difficulté à “mesurer” l’intention de sujets qui dans bien des cas n’en ont pas une\nconscience claire, l’effet destructeur est tout aussi puissant quand les harceleurs s’exclament\n« mais c’est pas méchant ! » que lorsqu’ils avouent leur désir de faire souffrir. Ce serait plutôt\ntrois autres notions qui feraient la différence et qui définissent nos propositions de recherche\nsur les indicateurs du mal-rire au travail et dont nous avons étayé le bien-fondé\nempiriquement dans une deuxième partie : la “réciprocité”, “l’unanimité”, et la “persistance”.\n\n\n15 Il semble que la “réciprocité” ait deux dimensions. En effet, elle vise à indiquer que les\nrieurs sont à la fois moqueurs et moqués mais aussi que la situation est elle-même un\ndéclencheur du rire. Nous entendons par le deuxième indicateur, “l’unanimité”, non pas que la\nmoquerie fasse rire “tout le monde”, mais que le rire soit partagé par les trois groupes de\nprotagonistes directement concernés : moqueur, moqué mais aussi témoin. Pour ce dernier,\nplusieurs travaux soulignent que les spectateurs peuvent être affligés par l’expérience subie\nd’un “mal-rire” et en éprouver un malaise profond (Houba, 2007). À ce stade, il nous semble\nque deux conceptions opposées du rire et de son rapport à la régulation sociale peuvent être\nrelevées. Pour l’une, « Le rire est une expérience subversive […] Le rire est une arme de\nlibération massive contre les oppresseurs, un outil pour résister aux forces\nd’anéantissement » (Birnbaum, 2011, p.9), quand pour l’autre, le rire va être considéré avec\nHenri Bergson (1940) comme une « sanction sociale symbolique » permettant à la société\nd’exercer un contrôle et de se prémunir des sujets la menaçant. Si dans les deux cas,\nl’intelligence ou la clairvoyance est postulée du côté des rieurs et des moqueurs, pour le\npremier, elle s’inscrit dans une dynamique de refus de se soumettre à ce qui domine, alors que\ndans le second, elle exerce une pression de conformité sociale. Replacée dans le monde du\ntravail, chacune des approches peut trouver des objections remettant en question leur bienfondé et leur possible orientation des pratiques. En effet, de nombreux cas, comme par\nexemple ceux portant sur la discrimination au travail, mettent en évidence que résister peut\naussi consister à ne pas rire d’un bouc-émissaire au milieu d’un groupe hilare, ou affirmer son\nopposition à la ridiculisation de l’autre. Par ailleurs, le phénomène conduisant les collectifs à\nune euphorie groupale associée à un sentiment de surpuissance illusoire et une perte du sens\ndes réalités, a été largement étudié [10][10]Le premier à avoir affirme? que « l’individu en\nfoule diffère…. Non seulement les résultats sur les équipes professionnelles contredisent le\npostulat de clairvoyance des rieurs, mais ils conduisent au constat que les groupes alors\ndésignés comme fusionnels (Anzieu et Martin, 1982) finissent toujours par éclater : ce type de\nrire ne préserve la cohésion sociale que de façon précaire et artificielle. Le mouvement de\nretour à la réalité est aussi une prise de conscience individuelle que le collectif peut conduire à\nadopter un comportement que chaque membre condamne après-coup et considère comme\nirresponsable. Ainsi, désigner un autre comme une victime expiatoire ou un objet légitime de\nmoqueries est une ignorance de sa valeur d’homme et place dans une posture illusoire de\nsupériorité. Nous avons d’ailleurs relevé que Bergson (1932, p.90) affirme dans un ouvrage\nantérieur que « si sévèrement que nous affections de juger les autres hommes, nous les\ncroyons, au fond, meilleurs que nous. Sur cette heureuse illusion repose une bonne partie de\nla vie sociale ». Nous retrouvons ici une définition du troisième indicateur proposé : la\n“persistance”. Il répond à la question : le rieur considère-t-il après-coup qu’il a “mal-ri” ? La\nrégulation en ressort également comme un processus inachevable, toujours en cours et à\nmener.\n\n\n\n2 – Etayage empirique de l’existence du mal-rire au travail et de ses indicateurs\n\n\n16 Dans cette partie, après avoir explicité la méthodologie de la recherche, nous présentons les\nrésultats de sept études de cas d’accompagnement de responsables confrontés à des difficultés\nde management et demandeurs d’aide auprès d’un tiers complétés par l’analyse de contenu\ndes entretiens individuels menés, enregistrés et retranscrits dans le cadre de cette rechercheaction. Celle-ci s’inscrivait dans un projet visant plus globalement à explorer le rôle du tiers\ndans le changement des comportements professionnels et la résolution des problèmes de\nmanagement. L’étude présentée dans cet article a pour objectif de conforter l’existence de\nsituations de rire producteur de mal-être et d’étayer nos propositions de recherche sur les\nindicateurs de ce mal-rire au travail afin d’orienter les pratiques de régulation.\n\n\n2.1 – Méthodologie de l’étude : quand le rire conduit à une demande d’aide\n\n\n17 D’un point de vue épistémologique, nous nous situons dans un paradigme interprétativiste.\nEn effet, si notre recherche est de type exploratoire, il ne s’agit pas de faire abstraction des\ncadres théoriques existants mais d’identifier les théories pertinentes, de s’y appuyer pour les\nconfronter et investiguer la réalité, avec l’adoption d’une posture réflexive avec le terrain\n(Jodelet, 2003), dans un “va-et-vient” entre observations empiriques et hypothèses\ninterprétatives permettant “d’ancrer” une théorie en cours d’élaboration (Glaser et Strauss,\n1967). La méthode de cas nous est apparue comme la plus pertinente pour étudier les\nsituations du rire dans les situations de travail. Selon Miles et Huberman (1991), elle permet\nde développer les conceptualisations à partir de descriptions approfondies des phénomènes. Il\ns’agit d’appréhender l’impact d’un comportement humain dans une complexité, dont nous\nsouhaitons saisir toutes les dimensions, ce que l’étude de cas favorise (Giroux et Tremblay,\n2002). Enfin, le caractère éthique ou non est une préoccupation organisationnelle\ncontemporaine, et l’étude de cas, comme le souligne Yin (1994), est par définition une\ndémarche de recherche qui traite des phénomènes en prise directe avec les contextes dans\nlesquels ils émergent. La méthode utilisée est celle de la recherche-action (Koenig, 1993) avec\ncomme objectif en cohérence avec notre posture interprétativiste de nous appuyer sur un cadre\nthéorique issu de la littérature afin de faire émerger une grille d’intelligibilité du mal-rire au\ntravail, tout en co-élaborant avec les acteurs (les coachés) des construits opératoires.\n\n\n18 L’étude a été menée de 2006 à 2008. Elle a consisté à accompagner individuellement des\ndemandeurs d’aide dans une série de dix entretiens au maximum d’environ 60 minutes chacun\net enregistrés avec l’accord des intéressés. Seul un cas s’est concrétisé par dix entretiens. Pour\nles six autres cas, le coaché a considéré qu’il n’avait plus besoin d’accompagnement avant la\nfin des dix séances qui lui étaient ouvertes car son problème était résolu et qu’il pouvait faire\nface sans aide à ses situations professionnelles aussi difficiles soient-elles. Renforcer\nl’autonomie du coaché et la confiance en ses propres ressources est l’une des caractéristiques\nmajeures de la démarche d’accompagnement servant d’appui à la recherche-action. Les sept\ncas de l’étude présentée sont extraits d’un corpus de 34 cas et a abouti à l’analyse de 42\nentretiens. Sans que leur demande d’accompagnement concerne initialement directement le\nrire, les coachés ont été choisis car ils avaient évoqué la question du rire en termes éthiques et\ncela a émergé de l’échange comme définissant en totalité ou en partie ce qui leur posait\nproblème. La population de l’étude est composée de quatre femmes et de trois hommes, de 26\nà 54 ans et occupant des postes de responsable dans différents secteurs d’activités avec le statut\nde cadre.\n\n\nTableau 1\nLes sept cas de l’étude\n19En plus de l’analyse de cas proprement dite effectuée en confrontant nos notes prises avec\nla posture de chercheur-coach et l’évolution du discours des coachés au fil des séances, nous\navons procédé à une analyse de contenu des entretiens par strates de relecture manuelle et\n\nrépartition des extraits de discours dans les catégories issues d’une part de la revue de la\nlittérature (1\nère phase avec deux séries de relecture) puis d’autre part de l’analyse de contenu\nproprement dite (2\ne\nphase avec trois strates de relecture : approfondissement des contenus\nclassés avec émergence de nouvelles dimensions ; émergence d’un 4\ne\nindicateur du mal-rire ;\nrepérage des contenus d’étayage et de définition du 4\ne\nindicateur). La 1\nère phase d’analyse\ns’est appuyée sur les critères classant des discours tirés de la revue de la littérature : mal-être\ndu sujet ri, mal-être du sujet rieur et les trois indicateurs du mal-rire. Son apport a été\nd’approfondir le cadre théorique initial, que la 2\ne\nphase a permis de compléter essentiellement\npar le repérage d’une 4\ne\ncaractéristique.\n2.2 – Résultats : Le bon et le mauvais rire\ncoexistent au travail\n20La situation des quatre premiers cas permet d’illustrer les différentes dynamiques du rire au\ntravail et leur rapport à l’éthique. Les trois cas suivants nous ont permis de conforter nos\npropositions de recherche sur les trois indicateurs du mal rire. Nous les avons étayées par une\nanalyse de contenu des 42 entretiens retranscrits des sept cas de l’étude.\n2.2.1 – Les dynamiques du rire et leur\nrapport à l’éthique\n21Pour confirmer l’existence du mal-rire au travail et en proposer une grille d’intelligibilité,\nnous pourrions citer la déclaration de cette femme cadre de 48 ans en congé maladie pour\ndépression du cas n°1, qui confiait : « Au début, je suis restée de marbre mais à force ça\natteint. Stupidement ce sont les blagues sur mon poids qui m’ont usée. C’était juste…\nméchant ? ». Nos résultats font ressortir que le mal-être généré par le vécu du rire peut être\nressenti non seulement par le sujet-ri que par le sujet-rieur. Ainsi dans le cas n°2, une femme\nde 27 ans nouvellement embauchée dans un service marketing, se « sentait mal » de se\nretrouver à rire dans un groupe ayant pris l’habitude avant son arrivée de « taquiner » un\nstagiaire handicapé qui présentait de « légères difficultés d’élocution ». L’intérêt du poste et\n« la chance d’avoir décroché un job… formateur,… le salaire,… bien quoi ! » ne l’ont pas\nempêché de changer d’emploi au plus vite. Cela confirme que le “côté des rieurs” est loin\nd’être désigné systématiquement comme “le bon” même par l’inconfort qu’il procure. Une\ninterrogation d’ordre éthique est bien posée sur le rire au travail, non comme un jeu abstrait\nvisant principalement à distraire les philosophes, mais comme un facteur de souffrance en\nsituation professionnelle à aborder comme tel pour mettre en œuvre les politiques de\nprévention appelées de leurs vœux par les responsables d’entreprises et les syndicats. Nos\nrésultats ont également fait ressortir les bienfaits potentiels du rire. Ainsi dans le cas n°3, un\nresponsable de production de 54 ans qui nous avait sollicité pour la « redéfinition de [son]\nprojet professionnel » s’est exclamé lors du premier entretien : « Si y’a une chose qu’on ne\npeut pas m’empêcher, c’est de me marrer… c’est la seule chose… quand l’autre avec sa\ncravate m’a dit que c’était mon tour… éjecté… vous rigolez !… la veille j’ai fini à… je sais\npas… neuf heures… et le matin j’étais là pour leur réunion et ensuite… l’un après l’autre…\ndans son bureau… allez : j’étais dans le lot… dehors !… j’ai rien dit… je l’ai regardé en me\nmarrant… pas question de s’écrouler… et moi ça va… ».\n\n22Dans ces trois premiers cas nous retrouvons à la fois la figure maléfique du pervers qui rit\ndu malheur d’autrui, le surgissement d’une émotion échappant au contrôle du sujet, et qui par\ncontrecoup le dessert ou que lui-même trouve inapproprié, et en dernier une situation où le\nrire est la seule issue permettant à la personne d’exister dans un contexte d’aliénation. Le rire\nse manifeste mais rien n’est « risible » en soi. Le cas n°4 d’un manager de 38 ans, responsable\nd’une équipe chargée d’un projet dans le domaine de la haute technologie, que la direction lui\navait demandé d’abandonner en pleine réalisation pour se consacrer à un autre, nous permet\nde préciser cette dynamique du rire et ses limites. Convaincu que son rôle était de « maintenir\nle moral des troupes », il mettait son « point d’honneur à faire bonne figure », ce qui se\ntraduisait par ce qu’il désignait comme sa « nature à blaguer tout le temps ». Or, ni lui, ni son\ngroupe - « pourtant, on est des pros ! » - n’arrivaient à s’investir sur le nouveau dossier et\ncontinuaient à évoquer le précédent. Au cours du deuxième entretien, le manager a exprimé ce\nqu’il a défini ensuite comme sa “colère rentrée”. Il en est arrivé à la conclusion que ses\ncollègues devaient aussi « lâcher leur venin » pour pouvoir « se remettre au travail ». Ce qu’il\nfit, déclarant à la troisième et dernière séance : « Je leur ai dit : je sais pas vous mais moi je\nsuis furieux ; alors je vous propose d’en parler mais interdiction d’injurier ou de crier et\nchacun son tour et uniquement si vous avez envie… et alors, c’est parti !… je crois que c’est\nréglé… ils m’ont même dit : tu nous saoulais, parce qu’on voyait bien que c’était faux, ça\ngrinçait ! ».\n23L’analyse du contenu des 42 entretiens a permis de conforter cette notion de mal-rire interreliée à celles d’un double mal-être en miroir : le mal-être du sujet ri et le mal-être du sujetrieur (voir tableau 2).\nTableau 2\nLe mal-rire comme générateur de mal-être\n\n2.2.2 – Les indicateurs du mal-rire\n24Nous avons pu sélectionner trois cas permettant de conforter et préciser les trois indicateurs\ndu mal-rire issus de la revue de littérature, tout en confirmant la pertinence de la transposition\nd’un cadre théorique issu d’une revue de la littérature essentiellement philosophique.\nConcernant la “réciprocité”, nous retrouvons cette notion lorsque les sujets abordent la\ncompétition dans les relations professionnelles. Celle-ci comme pour les équipes de\ncommerciaux par exemple, peut être stimulante et prendre la définition donnée dans le sport.\nNous avons relevé dans les propos de l’une d’entre elles représentant notre cas n°5, cadre de\n47 ans, responsable d’une équipe de vente, qu’elle pouvait s’accompagner d’échanges\nverbaux utilisant une moquerie qu’elle qualifiait de « bonne guerre ». Notre coachée nous les\nindiquait pour expliciter son tempérament de « gagnante », ses compétences assertives et sa\npugnacité. Il en ressortait que si les moqueries étaient interprétées comme un échange\nconfraternel et respectueux, c’est qu’elle en « recevait tout autant ; ça me booste ! ». C’est\nd’ailleurs ce qui nous semble pouvoir réguler les formes autodestructrices d’autodérision,\ncomme pour le cas n°6 un malade du sida de 46 ans qui a arrêté de s’exclamer en riant lorsque\ndes échéanciers étaient en cours d’élaboration : « vous me raconterez, si je suis au\ncimetière ! ». La notion “d’unanimité” renvoie par suite à une nécessaire forme individuelle\nd’autorégulation du rire dans une même volonté de respect mutuel de soi et des autres. Enfin,\ndans le cas n°7, une femme de 26 ans, chef de travaux dans le bâtiment souhaitait « changer\nde secteur d’activité » car nous disait-elle dans le cadre de son coaching : « j’en peux plus de\nleur douce rigolade vulgaire d’obsédés par leur pénis ». Après plusieurs séances, et\nconsidérant qu’elle n’avait « rien à perdre d’essayer », elle a décidé de « leur dire » et s’y est\npréparée. Elle fut surprise de constater que plusieurs de ses collègues masculins également\npris à témoins des plaisanteries, appuyaient sa demande. Les rieurs furent priés de réserver\nl’usage de leur humour à une sphère non professionnelle d’amis susceptibles de l’apprécier.\n25L’analyse de contenu de nos 42 entretiens, nous a permis non seulement de retrouver dans\nles situations de travail les trois indicateurs au fil des discours des sujets de l’étude, mais d’en\nidentifier un quatrième que nous avons désigné par les termes de “plein accord préalable”. En\neffet, nous avons relevé la distinction faite entre le rire subi ou même consenti et le rire\napprouve?. Si les deux peuvent conduire le sujet-ri à « rire avec les rieurs » pour éviter de\nperdre la face, seul le second semble être une « sortie sans casse » pour la personne. Ainsi\npour Goffman (1974, p.39), « on peut [donc] considérer une relation sociale comme étant une\nsituation où une personne est particulièrement forcée de compter sur le tact et la probité\nd’autrui pour sauver la face et l’image qu’elle a d’elle-même ». Nous avons retrouvé cette\nsituation décrite par les sujets dans leurs entretiens, comme par exemple comme discours\ntype : « j’ai bien vu qu’il se retenait de rire… faut dire que quand je bafouille, j’y vais pas à\nmoitié… alors j’ai dit : ma chompre a trouché… et j’ai éclaté de rire… c’était marrant… on a\nbien ri et ça fait du bien ». On retrouve ici le rire, source de bien-être et permettant de\ndévelopper sa capacité de faire face aux situations critiques du monde professionnel (Mittal et\nMathur, 2011). Par contre, « rire jaune » tout en sortant meurtri de la situation d’échanges est\nrevenu dans les entretiens comme l’indicateur que « le rire n’était pas de bonne qualité ». Ne\npas rire est considéré comme une façon « d’empirer la situation », les protestations pouvant\nêtre encore plus risibles. Un discours type pourrait être « le plus douloureux est que je n’ai\nrien pu faire d’autres que faire semblant de trouver ça drôle » ou « c’était outrageant, il se\nmoquait de mon apparence ; le seul qui peut le faire c’est moi… c’est comme les blagues\njuives… c’est antisémite hein quand seuls les juifs ne rient pas ».\n\n2.3 – Discussion : vers la régulation du malrire au travail\n26Repérer en se référant aux indicateurs qu’il s’agit d’un mal-rire au travail ne suffit pas à\ndéfinir les modes de régulation. En effet, il ne faudrait pas en déduire qu’il s’agit de définir les\nnormes générales du “bon comique” au travail, mais plutôt que la nécessité s’impose d’en\nsouligner les dysfonctionnements. Nous avons ainsi montré que le poids du contexte sur\nl’évaluation de la situation, comme Hackney (2011) qui a démontré que certaines pratiques de\nmanagement pouvaient conduire à faire perdre le sens de l’humour des salariés même lorsque\nles plaisanteries ont été pré-testées comme drôles. Ce qui fait rire est non seulement\nculturellement ancré mais fait le ciment des groupes sociaux. Il est une arme de stéréotypage\net de discrimination tout autant qu’un puissant levier d’émancipation, comme en témoignent\nles travaux sur le rire des femmes (Willett et al., 2012). Gkorezis, Hatzithomas et Petridou\n(2011) soulignent ainsi que si l’utilisation de l’humour par les dirigeants est un levier puissant\nde mobilisation, son recours peut avoir des effets négatifs en fonction notamment de\nl’ancienneté des salariés. D’une part, le rôle de l’humour comme activateur de créativité ou de\nrésolution de problème a été mis en évidence, voire même pour assouplir les rigidités\norganisationnelles propres aux administrations publiques (Cates, 1979). D’autre part,\nplusieurs travaux ont souligné que les émotions positives comme l’euphorie pouvaient\nconduire à une prise de risque plus importante et inconsidérée notamment dans les décisions\nfinancières (Cavalheiro et al., 2011).\n27Nos quatre indicateurs, “réciprocité”, “unanimité”, “persistance” et “plein accord\npréalable” peuvent également ressortir comme des règles de comportement collectif à poser\npour permettre aux salariés de les intérioriser émotionnellement. Il s’agit ainsi moins de règles\nde politesse formelle que de l’apprentissage d’une forme de “civilité au travail”, en référence\nà la définition de l’incivilité par les philosophes et de leur étude de la recrudescence du\nphénomène dans nos civilisations (Habib et Raynaud, 2012 ; Bourin, 2012). Face au mal-être\nressenti par les “mal-rieurs” et de l’effet destructeur sur la personne “rie”, il s’agirait pour les\nmanagers en lien avec les travaux initiés par Sen (2004) au niveau socio-économique de créer\nles conditions d’une “vie au travail humainement digne” et une gestion des ressources\nhumaines qui intègre ce que Nussbaum (2012) désigne comme des “culpabilités” et parmi\nlesquelles se positionnent le ressenti émotionnel et la conception du bien.\nConclusion\n28Cette recherche menée en appui sur sept cas de coaching avec 42 entretiens individuels,\nnous a conduits à définir quatre indicateurs du rire au travail : la “réciprocité”, “l’unanimité”,\n“la persistance” et le “plein accord préalable” permettant d’orienter les pratiques de\nrégulation. Dans ce qu’ils présupposent comme dynamique à l’œuvre, les notions qu’ils\ndésignent sont aussi ce qui permet de ne pas limiter le rire à la moquerie. Il nous semble\nmême que le rire prend toute sa portée « d’intervention créatrice de la conscience » soulignée\npar Robert Escarpit (1960, p.94), et peut devenir une véritable force de progrès potentielle\ndans les organisations si le comique renonce à ridiculiser les personnes pour se positionner\ndans le champ de la dénonciation de et par l’absurde des systèmes ou des politiques. Hors de\nla moquerie, le rire est aussi un mode de faire face à la détresse de vivre et peut être relié à un\ncomique qui « manifeste la fragilité essentielle du sens humain, mais nous donne les moyens\nde l’exorciser » (Giribone, 2009, p. 58). Le rire des autres est dès lors potentiellement un\n\nencouragement à se distancier et même à transcender notre condition d’homme et la finitude\nde la vie. En cela, il est un vecteur de réflexivité et même de bien-être, non dans une\nrecherche exclusive de plaisir hédoniste, qui ne résiste pas au questionnement d’ordre éthique,\nmais dans une quête existentielle telle que Martin Heidegger (1927) l’a théorisée.\n29Cette première étude sur le rire au travail et l’éthique débouche enfin sur plusieurs pistes de\nrecherche et, nous semble-t-il, plus particulièrement sur un recensement des différentes\nsituations professionnelles d’émergence du rire afin de valider quantitativement nos résultats\naffirmant que c’est seulement lorsque le rire est réciproque, unanime, qu’il perdure et qu’il a\némergé dans un plein accord préalable des parties, qu’il s’inscrit dans une dynamique positive\npour les personnes comme pour les organisations.\nNotes\n• [1] « On peut objecter que ces affections, toutes dénaturées qu’elles sont, ne vont\npoint sans plaisir ; & qu’un plaisir quelque inhumain qu’il soit, est toujours un\nplaisir, fût-il place? dans la vengeance, dans la malignité & dans l’exercice même de\nla tyrannie. Cette difficulté serait sans réponse, si, comme dans les joies cruelles &\nbarbares, on ne pouvait arriver au plaisir qu’en passant par le tourment ; mais aimer\nles hommes, les traiter avec humanité, exercer la complaisance, la douceur, la\nbienveillance, & les autres affections sociales ; c’est jouir d’une satisfaction\nimmédiate à l’action & qui n’est payée d’aucune peine antérieure ; satisfaction\noriginelle & pure, qui n’est prévenue d’aucune amertume. Au contraire, l’animosité,\nla haine, la malignité, sont des tourments réels dont la suspension occasionnée par\nl’accomplissement du désir, est comptée pour un plaisir. » Cooper A.A., comte de\nShaftesbury (1715, p.248-249)\n• [2] Nous indiquons les « extraits de discours » entre guillemets en les distinguant\ndes « citations » mises quant à elles en italique. Nous utilisons un autre caractère pour\nles “notions” que nous questionnons. Ici il s’agit d’une affirmation prononcée\ncommunément comme un dicton.\n• [3] Le point souligné ressort comme encore plus évident si on questionne la mesure\nconsistant à imposer aux salariés de rire. Si l’on associe rire et joie, on pourrait y\nretrouver la dénonciation d’une pression exercée actuellement de façon implicite dans\ncertaines organisations et revenant à exiger que les salariés expriment leur bonheur de\ntravailler - Cf. en sciences de gestion : Gori R., Le Coz P. (2006) ; en philosophie :\nManzano M. (2008).\n• [4] Nous nous démarquons ici des stoïciens qui avec Cicéron considéraient que la\n« joie folle » est une « maladie de l’âme » au même titre que toutes les passions qui\néloigne l’homme de « la conscience du sage » : Cicéron (45 av. J.C.), Tusculanes, III,\nIV-V, in Bréhier E. (1997), pour considérer avec Baruch Spinoza (1677, Ethique, IV,\npropositions IV-VII) que « l’homme est nécessairement toujours soumis aux\npassions », Korichi M. (2000, p.113), mais sans rejeter toute possibilité\nd’autorégulation individuelle dans la lignée de René Descartes (1649) pour qui selon\nMichel Meyer (1991, p.238), « la passion m’aveugle, donc je suis dans la possible\nerreur, et je sais cela, donc je suis au-delà de la passion, la connaissant pour ce\nqu’elle est ».\n\n• [5] Par contre, plusieurs cas de « fou-rire » ont été relevés aboutissant au licenciement\ndes rieurs, comme par exemple pour l’employé d’une entreprise de pompes funèbres\nou encore pour une vendeuse de lingerie féminine.\n• [6] Cette interrelation entre pouvoir, vérité et existence se retrouve dans le manifeste\ncensuré d’Albert Camus, qui devait paraître dans Le Soir républicain, date? du 25\nnovembre 1939 et publie? dans le cahier du journal Le Monde, N° 20888, date? du 17\nmars 2012 : « […] l’ironie demeure une arme sans précédent contre les trop\npuissants. Elle complète le refus en ce sens qu’elle permet, non plus de rejeter ce qui\nest faux, mais de dire souvent ce qui est vrai. Un journaliste libre, en 1939, ne se fait\npas trop d’illusions sur l’intelligence de ceux qui l’oppriment. Il est pessimiste en ce\nqui regarde l’homme. […] Oui, c’est souvent à son corps défendant qu’un esprit libre\nde ce siècle fait sentir son ironie. Que trouver de plaisant dans ce monde enflamme? ?\nMais la vertu de l’homme est de maintenir en face de tout ce qui le nie. »\n• [7] Pour Freud S. (1905, p. 262-263), « Nul ne peut se satisfaire d’avoir fait un mot\nd’esprit pour soi tout seul. Au travail du mot d’esprit, est indissociablement lié le\nprofond besoin de communiquer le mot d’esprit à autrui »\n• [8] Darwin C.R. (1872) reste toutefois prudent, puisqu’il considère que le rire\n« paraît être » l’expression « primitive » de la joie et du bonheur (Smadja, 1993, p.33).\n• [9] Loi n° 2002-73 du 17 janvier 2002 de modernisation sociale, J.O. n°15 daté du 18\njanvier 2002, p. 1008.\n• [10] Le premier à avoir affirme? que « l’individu en foule diffère de l’individu isole? »\net souligne? les risques d’emportement associés aux dynamiques collectifs, est peutêtre Gustave Le Bon (1895, p.11).\nSource : https://www.cairn.info/revue-@grh-2013-1-page-45.htm', NULL, 1, 2, 1, 7, 1, 1, NULL, '2024-05-13 10:14:59', '2024-05-13 10:24:39', NULL),
(4, 'Partager des vrais moments de vie de famille', 'Carte défi : pendant une semaine, passer un repas en famille par jour, à table sans écrans (télévision, smartphone, tablette, etc.).\nBonus : cuisiner en famille en amont du repas.', NULL, 1, 4, 2, 9, 1, 1, NULL, '2024-05-13 10:37:25', '2024-05-13 16:07:16', NULL),
(5, 'Partager des vrais moments de vie de famille', 'Carte défi : lors de votre prochaine sortie, refuser de boire de l’alcool et observer les réactions de vos amis. Assumez votre choix et notez les émotions ressenties.', NULL, 1, 0, 4, 4, 1, 1, NULL, '2024-05-13 11:27:42', '2024-05-13 11:30:02', NULL);
INSERT INTO `ressources` (`id_ressource`, `label`, `description`, `content`, `is_public`, `view_count`, `id_user`, `id_category`, `id_status`, `id_type`, `file`, `created_at`, `updated_at`, `staff_comment`) VALUES
(6, 'PLK - Rappeur français', 'Je vous présente le top 50 des sons de PLK 😊\n\nPetrouchka\nÉmotif (Booska 1H)\nAttentat\nPilote\nUn peu de haine\nProblèmes\nJamais\nLe classico organisé\nNouvelles\nDemain\nMonégasque\nTrain de vie\nDingue\nOn sait jamais\nC\'est mort\nJack Fuego\nR.A.F\nChandon et Moët\nCopine\nEscorte\nBénef\nToute l\'année (feat. Timal)\nA la base\nPelo\nÇa mène à rien\nDans les clips\nAll Night\nMec de cité\nHola\nWaow (feat. Nekfeu)\nPolak\nHier (feat. SCH)\nCosmos\nPourtant\nFaut pas\nTu vois comment ?\nDis-moi oui\nIdiote\nTout recommencer (feat. Tessa B)\nPériph\nDécembre\nMauvais dans le fond\nToutes générations\nAu fond d\'ma tête\nPostiché\nPas les mêmes\nIncontrolables\nHubert et Saïd\nLe bruit des applaudissements\nLes comptes\n230', NULL, 1, 15, 2, 15, 1, 1, NULL, '2024-05-13 11:46:39', '2024-05-13 16:05:17', NULL),
(7, 'Musique de Gims', 'Je vous conseils les musiques de Gims !\nhttps://www.allformusic.fr/maitre-gims/chansons', NULL, 1, 0, 3, 15, 2, 1, NULL, '2024-05-13 12:42:25', '2024-05-13 12:42:25', NULL),
(8, 'Audi est la meilleur marque d\'après moi', 'Voir : https://www.youtube.com/watch?v=VO6fHvqwp2s\n\nAudi, avec son slogan « Vorsprung durch Technik » (L\'avance par la technologie), incarne l\'excellence dans le monde de l\'automobile. Depuis sa fondation, Audi a constamment repoussé les limites de l\'innovation, offrant des véhicules qui combinent performance, design et durabilité. Un aspect que j\'admire particulièrement chez Audi est son engagement envers la qualité. Chaque modèle, qu\'il s\'agisse de la sportive Audi R8 ou de la familiale Audi Q7, est conçu avec précision, garantissant une expérience de conduite supérieure.\n\nLa marque se distingue aussi par sa capacité à intégrer des technologies avancées. Par exemple, l\'Audi e-tron, l\'un des leaders du marché des SUV électriques, montre l\'engagement de la marque envers la mobilité durable sans compromettre les performances. De plus, l\'intérieur des véhicules Audi est souvent cité comme l\'un des plus raffinés du marché, alliant esthétique moderne et fonctionnalité, ce qui rend chaque voyage plaisant et confortable.\n\nAudi a également prouvé son excellence dans le domaine de la sécurité, une préoccupation majeure pour de nombreux conducteurs aujourd\'hui. Les systèmes d\'assistance au conducteur et les caractéristiques de sécurité active et passive sont parmi les plus avancés du secteur, renforçant la confiance des conducteurs dans leur véhicule.\n\nEn somme, choisir Audi, c\'est opter pour une marque qui ne se contente pas de suivre les tendances, mais les définit. C\'est pour ces raisons, et bien d\'autres encore, que je considère Audi comme la meilleure marque automobile.', NULL, 1, 0, 1, 1, 2, 1, NULL, '2024-05-13 14:23:45', '2024-05-13 14:23:45', NULL),
(9, 'Volkswagen : Innovation et Tradition', 'Volkswagen, un pilier de l\'industrie automobile, combine avec habileté tradition et innovation, se forgeant une réputation de fiabilité et d\'accessibilité. Connue mondialement pour sa célèbre Coccinelle, Volkswagen a évolué pour offrir une gamme variée de véhicules qui répondent aux besoins de différents consommateurs, des robustes SUV comme le Tiguan aux familiales comme la Golf, sans oublier les citadines économiques telles que la Polo.\n\nUn des aspects les plus remarquables de Volkswagen est son engagement envers la technologie et la durabilité. La marque a pris un tournant décisif vers l\'électrification avec la série ID, qui promet une conduite zéro émission sans sacrifier la performance ou le confort. Le Volkswagen ID.4, par exemple, est un SUV électrique qui allie espace, style et efficacité, marquant une étape importante dans l\'adaptation de la marque aux défis environnementaux actuels.\n\nL\'intérieur des véhicules Volkswagen est conçu pour le confort et l\'efficacité, avec une attention particulière portée à la qualité des matériaux et à l\'ergonomie. Cela rend chaque trajet, qu\'il soit court ou long, une expérience agréable. De plus, Volkswagen continue d’innover en matière de systèmes d’assistance à la conduite, renforçant la sécurité pour tous les passagers.\n\nEn résumé, Volkswagen reste une force dominante dans l\'industrie automobile en mariant l\'artisanat traditionnel allemand avec des technologies avant-gardistes. C\'est cette combinaison qui lui permet de rester compétitive et pertinente dans un marché en constante évolution.', NULL, 1, 0, 2, 1, 2, 1, NULL, '2024-05-13 14:25:21', '2024-05-13 14:25:21', NULL),
(10, 'Peugeot 206 : Un Classique Indémodable', 'La Peugeot 206, depuis son lancement en 1998, est devenue une figure emblématique sur les routes du monde entier, affirmant sa présence avec style, agilité et fiabilité. Ce modèle compact, aimé pour sa maniabilité et son design attrayant, s\'est rapidement imposé comme une référence dans la catégorie des petites voitures, adaptée à la fois pour les jeunes conducteurs et pour ceux recherchant une deuxième voiture pratique pour la ville.\n\nLa 206 offre une expérience de conduite équilibrée avec une suspension bien ajustée qui gère habilement les imperfections de la route, offrant un confort remarquable pour sa catégorie. Sa taille compacte facilite la navigation en milieu urbain et le stationnement dans des espaces restreints, un avantage indéniable dans les zones densément peuplées.\n\nSous le capot, la Peugeot 206 propose une gamme de motorisations essence et diesel, allant de moteurs économiques à faible consommation à des options plus puissantes, idéales pour ceux qui désirent un peu plus de vivacité sur la route. Malgré son âge, la 206 reste économique à entretenir, avec des pièces largement disponibles et à coût abordable.\n\nL\'intérieur, bien que simple, est fonctionnel avec une ergonomie bien pensée qui rend les commandes accessibles et simples à utiliser. La finition, selon les versions, peut offrir un aspect plus cossu avec des inserts décoratifs et des équipements améliorés.\n\nEn somme, la Peugeot 206 demeure une option attrayante pour les acheteurs de voitures d\'occasion. Sa réputation de durabilité, couplée à son esthétique intemporelle, garantit qu\'elle reste une valeur sûre dans le segment des petites voitures.', NULL, 1, 0, 4, 1, 2, 1, NULL, '2024-05-13 14:27:04', '2024-05-13 14:27:04', NULL),
(11, 'Opel Corsa : Polyvalence et Innovation', 'La Opel Corsa, un nom synonyme de polyvalence et de fiabilité, a su évoluer à travers les générations pour répondre aux attentes changeantes des conducteurs. Depuis son lancement en 1982, ce modèle emblématique de la marque Opel a été plébiscité pour son excellent rapport qualité-prix, sa maniabilité et ses performances solides, ce qui en fait un choix privilégié pour une première voiture ou pour ceux qui recherchent un véhicule compact pratique.\n\nChaque génération de Corsa a apporté des améliorations significatives en termes de confort, de sécurité et de technologies embarquées. L\'une des caractéristiques les plus appréciées est la variété des motorisations offertes, incluant des options essence, diesel, et plus récemment, électrique avec la Corsa-e, témoignant de l\'engagement d\'Opel envers la mobilité durable.\n\nL\'intérieur de la Corsa est conçu avec un souci de fonctionnalité et de modernité. Les équipements de série et les options disponibles permettent une personnalisation avancée, allant des systèmes d\'infodivertissement à la pointe de la technologie aux aides à la conduite avancées, qui améliorent non seulement le confort mais aussi la sécurité du véhicule.\n\nEn matière de design, la Corsa n\'a jamais été en reste. Son apparence est régulièrement rafraîchie pour rester contemporaine, attirant à la fois les jeunes acheteurs et ceux qui restent jeunes de cœur. Sa taille compacte ne l\'empêche pas d\'offrir un espace intérieur surprenant, rendant chaque trajet agréable, que ce soit pour des déplacements urbains rapides ou des voyages plus longs sur autoroute.\n\nEn résumé, l\'Opel Corsa continue de séduire grâce à sa capacité à allier tradition et innovation, offrant une solution automobile complète et adaptable pour pratiquement tous les besoins de mobilité.', NULL, 1, 0, 3, 1, 2, 1, NULL, '2024-05-13 14:29:27', '2024-05-13 14:29:27', NULL),
(12, 'Porsche : Une Histoire de Performance et d\'Innovation', 'Porsche, fondée en 1931 par Ferdinand Porsche, est devenue synonyme de voitures sportives de luxe alliant performance, qualité et design innovant. L\'histoire de Porsche débute à Stuttgart, en Allemagne, où l\'entreprise se concentrait initialement sur le conseil en ingénierie automobile et ne construisait pas de voitures sous son propre nom. Tout change en 1948 avec la création de la Porsche 356, conçue par Ferry Porsche, le fils de Ferdinand. Cette voiture, fabriquée dans une ancienne scierie à Gmünd, en Autriche, était révolutionnaire avec sa structure légère en aluminium et son moteur placé à l\'arrière, une caractéristique qui deviendra une signature de la marque.\n\nDans les années 1960, Porsche lance la 911, conçue par Ferdinand Alexander Porsche, petit-fils de Ferdinand. Ce modèle devient rapidement emblématique avec son moteur flat-six refroidi par air et sa silhouette élégante et intemporelle. La 911 a évolué au fil des décennies mais a toujours conservé ses lignes fondamentales et son moteur arrière, devenant ainsi le cœur de l\'identité de Porsche.\n\nAu-delà de ses voitures de sport, Porsche a également marqué l\'histoire de la course automobile. La marque a accumulé des succès dans des compétitions prestigieuses telles que les 24 Heures du Mans, où elle détient le record du nombre de victoires globales. Des modèles comme la 917, la 956, et la 962 ont dominé les circuits du monde entier, renforçant l\'image de Porsche en tant que constructeur de voitures performantes.\n\nDans les années 2000, Porsche a élargi sa gamme avec des modèles qui ont permis d\'atteindre un public plus large sans compromettre l\'héritage de performance de la marque. Le Cayenne, lancé en 2002, était le premier VUS de Porsche, et bien que controversé à l\'époque, il est devenu un succès commercial majeur, prouvant que Porsche pouvait réussir hors des sentiers battus du sport automobile. Suivi par des modèles comme le Panamera et le Macan, Porsche a continué à innover tout en restant fidèle à son ADN de performance.\n\nPlus récemment, Porsche a embrassé l\'électrification avec le Taycan, son premier véhicule entièrement électrique lancé en 2019. Le Taycan représente un tournant pour Porsche, combinant ses principes traditionnels de performance et de luxe avec les technologies d\'avenir. Cela marque une étape importante dans la transition de l\'industrie automobile vers des solutions plus durables, et Porsche est à l\'avant-garde de cette évolution, prouvant que les voitures électriques peuvent être à la fois performantes et désirables.\n\nL\'histoire de Porsche est une fusion d\'innovation, de tradition et de passion pour l\'automobile. Avec chaque nouveau modèle, Porsche continue de repousser les limites de ce qui est possible, tout en restant fidèle à son héritage de performance, de qualité et de sophistication unique.', NULL, 1, 0, 2, 1, 2, 1, NULL, '2024-05-13 14:32:50', '2024-05-13 14:32:50', NULL),
(13, 'Bon ... Quelle est la meilleurs voiture pour 2024 ?', 'Je vous laisse débattre en commentaire !  (même si une Audi RS6 gagne malgré son prix)', NULL, 1, 0, 1, 1, 1, 1, NULL, '2024-05-13 14:34:02', '2024-05-13 14:34:19', NULL),
(14, 'INTITULÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉ', 'Je fais une ressource pour vous perdre !!!', NULL, 1, 0, 25, 2, 2, 1, NULL, '2024-05-13 14:54:53', '2024-05-13 14:54:53', NULL),
(15, 'INTITULÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉÉ2', 'Je fais une ressource pour vous perdre !!!', NULL, 1, 0, 25, 3, 4, 1, NULL, '2024-05-13 14:55:07', '2024-05-13 14:55:44', 'Pourquoi vouloir faire ça ?');

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
(1, 'chwiej.nicolas@gmail.com', 'Nicolas', 'Chwiej', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 4, 4, 75, 1, '2024-05-13 09:39:58', '2024-05-13 15:18:19', NULL, NULL, NULL, 12),
(2, 'c.arthur@gmail.com', 'Arthur', 'Cr', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 1, 1, 75, 1, '2024-05-13 10:31:21', '2024-05-13 17:11:58', NULL, NULL, NULL, 1),
(3, 't.roos@gmail.com', 'Tristan', 'Ro', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 2, 2, 75, 3, '2024-05-13 10:50:04', '2024-05-13 17:11:58', 'Lk3mRaGwd3YeAwAYVnCxRxSsUykyx4RykFZshYjEJL7qBfZGbjAuFP78DucYNArfPKMjktvw63hVUYq1jJ8O6AK73K4ySxjEm6SY', NULL, NULL, 11),
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
(25, 'John.doe@example.com', 'John', 'Doe', '$2y$12$lIhe391bPTE7QR1h8NVjQ.wpKCh5VWt2lvLcEvedSn9vFgK99T40m', 1, NULL, 6, 6, 174, 4, '2024-05-13 14:42:17', '2024-05-13 17:31:38', 'NfjbvzRegbAFBZIive2qROxG2Gw2PQCw4BtEAvChX5OGoBsPfZAiBHIFx9jVfoaG1VQ5cUbQ6S9dYeb72iz9r0pVgR6ID9XqU06q', NULL, NULL, 4);

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
(49, 1, 1, 'Modify', 'email', 'c.nicolas@gmail.com', 'chwiej.nicolas@gmail.com', '2024-05-13 17:18:19');

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
  MODIFY `id_city` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id_comment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `postal_codes`
--
ALTER TABLE `postal_codes`
  MODIFY `id_postal_code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT pour la table `user_history`
--
ALTER TABLE `user_history`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

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
