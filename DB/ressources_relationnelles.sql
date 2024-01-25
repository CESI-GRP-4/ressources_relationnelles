-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 18 jan. 2024 à 22:38
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

-- --------------------------------------------------------

--
-- Structure de la table `asso_resource_statistic`
--

CREATE TABLE `asso_resource_statistic` (
  `id_resource` int(11) NOT NULL,
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

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_bookmark`
--

CREATE TABLE `asso_user_bookmark` (
  `id_user` int(11) NOT NULL,
  `id_resource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_note`
--

CREATE TABLE `asso_user_note` (
  `id_user` int(11) NOT NULL,
  `id_resource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `asso_user_resource`
--

CREATE TABLE `asso_user_resource` (
  `id_user` int(11) NOT NULL,
  `id_resource` int(11) NOT NULL
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
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cities`
--

CREATE TABLE `cities` (
  `id_city` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

-- --------------------------------------------------------

--
-- Structure de la table `countries`
--

CREATE TABLE `countries` (
  `id_country` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `country_code` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `id_resource` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `postal_codes`
--

CREATE TABLE `postal_codes` (
  `id_postal_code` int(11) NOT NULL,
  `postal_code` varchar(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Structure de la table `status_resources`
--

CREATE TABLE `status_resources` (
  `id_status` int(11) NOT NULL,
  `label` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `is_verified` tinyint(1) DEFAULT NULL,
  `path_picture` varchar(255) DEFAULT NULL,
  `id_city` int(11) NOT NULL,
  `id_postal_code` int(11) NOT NULL,
  `id_country` int(11) NOT NULL,
  `id_role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  MODIFY `id_blocked` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cities`
--
ALTER TABLE `cities`
  MODIFY `id_city` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id_comment` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `countries`
--
ALTER TABLE `countries`
  MODIFY `id_country` int(11) NOT NULL AUTO_INCREMENT;

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
-- AUTO_INCREMENT pour la table `postal_codes`
--
ALTER TABLE `postal_codes`
  MODIFY `id_postal_code` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `resources`
--
ALTER TABLE `resources`
  MODIFY `id_resource` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `rights`
--
ALTER TABLE `rights`
  MODIFY `id_right` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `statistics_archive`
--
ALTER TABLE `statistics_archive`
  MODIFY `id_statistic_archive` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `status_resources`
--
ALTER TABLE `status_resources`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT;

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
