-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 07 fév. 2025 à 01:15
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `vapostore_project`
--

-- --------------------------------------------------------

--
-- Structure de la table `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cart_products`
--

CREATE TABLE `cart_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cart_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `cart_id` bigint(20) UNSIGNED NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `item_number` int(11) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `postal_code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(8,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `type_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image`, `type_id`, `created_at`, `updated_at`) VALUES
(1, 'Câble USB / USB-C', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 1.00, 'https://www.vapostore.com/50986-large_default/cable-usb-usb-c-blanc.jpg', 5, NULL, NULL),
(2, 'Verre de Remplacement UFORCE-X Nano Tank', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 2.00, 'https://www.vapostore.com/50971-large_default/verre-de-remplacement-uforce-x-nano-tank-45ml-voopoo.jpg', 5, NULL, NULL),
(3, 'Câble USB / Micro USB E-Leaf', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 2.00, 'https://www.vapostore.com/2248-large_default/cable-usb-micro-usb-e-leaf.jpg', 5, NULL, NULL),
(4, 'Étui Silicone Couleur Aléatoire Accu 18650', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 1.00, 'https://www.vapostore.com/2271-large_default/etui-silicone-couleur-aleatoire-accu-18650.jpg', 5, NULL, NULL),
(5, 'Drip 510 Heat insulation', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 6.00, 'https://www.vapostore.com/2627-large_default/drip-510-heat-insulation.jpg', 5, NULL, NULL),
(6, 'Drip tip Teflon steel', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 5.00, 'https://www.vapostore.com/2636-large_default/drip-tip-teflon-steel.jpg', 5, NULL, NULL),
(7, 'Drip tip Tube plastique', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 4.00, 'https://www.vapostore.com/2636-large_default/drip-tip-teflon-steel.jpg', 5, NULL, NULL),
(8, 'Boite 2 Accus 18650 Transparent', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 0.95, 'https://www.vapostore.com/4525-large_default/boite-2-accus-18650-transparent.jpg', 5, NULL, NULL),
(17, 'Kit Puremax 2 Pod 35W 1300mAh 2ml SX Mini', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 33.90, 'https://www.vapostore.com/51049-home_default/kit-puremax-2-pod-35w-1300mah-4ml-sx-mini.jpg', 1, '2025-01-28 01:34:32', '2025-01-28 01:34:32'),
(18, 'Box Centaurus M200 200W Retro Gamer 10th', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 59.90, 'https://www.vapostore.com/51149-home_default/box-centaurus-m200-200w-retro-gamer-10th-anniversary-limited-edition-lost-vape.jpg', 1, '2025-01-28 01:34:32', '2025-01-28 01:34:32'),
(19, 'Kit Feelin AQ Pod 30W 1200mAh 3ml Nevoks', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 32.90, 'https://www.vapostore.com/51124-home_default/kit-feelin-aq-pod-30w-1200mah-3ml-nevoks.jpg', 1, '2025-01-28 01:34:32', '2025-01-28 01:34:32'),
(20, 'Pack de 2 Pods 2ml PX Pro 2 Puremax Pod SX', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 8.90, 'https://www.vapostore.com/51062-home_default/pack-de-2-pods-4ml-px-pro-2-puremax-pod-sx-mini.jpg', 1, '2025-01-28 01:34:32', '2025-01-28 01:34:32'),
(21, 'Pack de 2 Pods Switch 10mg 2ml Pulp', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 7.00, 'https://www.vapostore.com/51109-home_default/pack-de-2-pods-switch-2ml-20mg-pulp.jpg', 1, '2025-01-28 01:34:32', '2025-01-28 01:34:32'),
(22, 'Kit Apex Pod 30W 2000mAh 5ml Vaporesso', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 34.90, 'https://www.vapostore.com/51133-home_default/kit-apex-pod-30w-2000mah-5ml-vaporesso.jpg', 1, '2025-01-28 01:34:32', '2025-01-28 01:34:32'),
(23, 'Pack de 2 Pods 5ml Apex Vaporesso', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 7.90, 'https://www.vapostore.com/51140-home_default/pack-de-2-pods-5ml-apex-vaporesso.jpg', 1, '2025-01-28 01:34:32', '2025-01-28 01:34:32'),
(24, 'Pack de 2 Pods Elfa Pro 2ml 20mg Elfbar', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 8.90, 'https://www.vapostore.com/43794-home_default/pack-de-2-pods-elfa-pro-2ml-20mg-elfbar.jpg', 1, '2025-01-28 01:34:32', '2025-01-28 01:34:32'),
(25, 'Etna Flow Halo 50ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 16.50, 'https://www.vapostore.com/51055-home_default/etna-flow-halo-50ml.jpg', 2, '2025-01-28 01:37:42', '2025-01-28 01:37:42'),
(26, 'Ozigo 40/60 Signature 50ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 21.90, 'https://www.vapostore.com/51147-home_default/ozigo-4060-signature-50ml.jpg', 2, '2025-01-28 01:37:42', '2025-01-28 01:37:42'),
(27, 'Ghost Call of Vape 100ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 24.90, 'https://www.vapostore.com/51181-home_default/ghost-call-of-vape-100ml.jpg', 2, '2025-01-28 01:37:42', '2025-01-28 01:37:42'),
(28, 'Pack 40ml + 2x10ml Pêche Melon Glacés Pod', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 22.90, 'https://www.vapostore.com/51191-home_default/pack-40ml-2x10ml-peche-melon-glaces-pod-liquide-pulp-06mg.jpg', 2, '2025-01-28 01:37:42', '2025-01-28 01:37:42'),
(29, 'Sunset Sorbet T Juice 100ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 24.90, 'https://www.vapostore.com/51155-home_default/sunset-sorbet-t-juice-100ml.jpg', 2, '2025-01-28 01:37:42', '2025-01-28 01:37:42'),
(30, 'Sakura Dream T Juice 100ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 24.90, 'https://www.vapostore.com/51154-home_default/sakura-dream-t-juice-100ml.jpg', 2, '2025-01-28 01:37:42', '2025-01-28 01:37:42'),
(31, 'Pack 40ml + 2x10ml Barbe à Papa Pod', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 22.90, 'https://www.vapostore.com/51179-home_default/pack-40ml-2x10ml-pod-liquide-pulp.jpg', 2, '2025-01-28 01:37:42', '2025-01-28 01:37:42'),
(32, 'Pack 50ml + 10ml Pêche Melon Glacés Pod', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 22.90, 'https://www.vapostore.com/51201-home_default/pack-50ml-10ml-peche-melon-glaces-pod-liquide-pulp-03mg.jpg', 2, '2025-01-28 01:37:42', '2025-01-28 01:37:42'),
(33, 'Kit Puremax 2 Pod 35W 1300mAh 2ml SX Mini', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 33.90, 'https://www.vapostore.com/51049-home_default/kit-puremax-2-pod-35w-1300mah-4ml-sx-mini.jpg', 3, '2025-01-28 01:40:32', '2025-01-28 01:40:32'),
(34, 'Box Centaurus M200 200W Retro Gamer 10th', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 59.90, 'https://www.vapostore.com/51149-home_default/box-centaurus-m200-200w-retro-gamer-10th-anniversary-limited-edition-lost-vape.jpg', 3, '2025-01-28 01:40:32', '2025-01-28 01:40:32'),
(35, 'Kit Feelin AQ Pod 30W 1200mAh 3ml Nevoks', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 32.90, 'https://www.vapostore.com/51124-home_default/kit-feelin-aq-pod-30w-1200mah-3ml-nevoks.jpg', 3, '2025-01-28 01:40:32', '2025-01-28 01:40:32'),
(36, 'Pack de 2 Pods 2ml PX Pro 2 Puremax Pod SX', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 8.90, 'https://www.vapostore.com/51062-home_default/pack-de-2-pods-4ml-px-pro-2-puremax-pod-sx-mini.jpg', 3, '2025-01-28 01:40:32', '2025-01-28 01:40:32'),
(37, 'Pack de 2 Pods Switch 10mg 2ml Pulp', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 7.00, 'https://www.vapostore.com/51109-home_default/pack-de-2-pods-switch-2ml-20mg-pulp.jpg', 3, '2025-01-28 01:40:32', '2025-01-28 01:40:32'),
(38, 'Kit Apex Pod 30W 2000mAh 5ml Vaporesso', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 34.90, 'https://www.vapostore.com/51133-home_default/kit-apex-pod-30w-2000mah-5ml-vaporesso.jpg', 3, '2025-01-28 01:40:32', '2025-01-28 01:40:32'),
(39, 'Pack de 2 Pods 5ml Apex Vaporesso', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 7.90, 'https://www.vapostore.com/51140-home_default/pack-de-2-pods-5ml-apex-vaporesso.jpg', 3, '2025-01-28 01:40:32', '2025-01-28 01:40:32'),
(40, 'Pack de 2 Pods Elfa Pro 2ml 20mg Elfbar', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 8.90, 'https://www.vapostore.com/43794-home_default/pack-de-2-pods-elfa-pro-2ml-20mg-elfbar.jpg', 3, '2025-01-28 01:40:32', '2025-01-28 01:40:32'),
(41, 'Arctic Melon Concentré Halo 30ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 11.90, 'https://www.vapostore.com/51058-home_default/arctic-melon-concentre-halo-30ml.jpg', 4, '2025-01-28 01:42:31', '2025-01-28 01:42:31'),
(42, 'Etna Flow Concentré Halo 30ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 11.90, 'https://www.vapostore.com/51060-home_default/etna-flow-concentre-halo-30ml.jpg', 4, '2025-01-28 01:42:31', '2025-01-28 01:42:31'),
(43, 'Muffin Roll Concentré Halo 30ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 11.90, 'https://www.vapostore.com/51061-home_default/muffin-roll-concentre-halo-30ml.jpg', 4, '2025-01-28 01:42:31', '2025-01-28 01:42:31'),
(44, 'Mirage Concentré Sweet Dream Full Moon 30ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 13.90, 'https://www.vapostore.com/51212-home_default/mirage-concentre-sweet-dream-full-moon-30ml.jpg', 4, '2025-01-28 01:42:31', '2025-01-28 01:42:31'),
(45, 'Serenity Concentré Sweet Dream Full Moon 30ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 13.90, 'https://www.vapostore.com/51213-home_default/serenity-concentre-sweet-dream-full-moon-30ml.jpg', 4, '2025-01-28 01:42:31', '2025-01-28 01:42:31'),
(46, 'Spirit Concentré Sweet Dream Full Moon 30ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 13.90, 'https://www.vapostore.com/51214-home_default/spirit-concentre-sweet-dream-full-moon-30ml.jpg', 4, '2025-01-28 01:42:31', '2025-01-28 01:42:31'),
(47, 'Mirage Concentré Sweet Dream Full Moon 10ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 5.90, 'https://www.vapostore.com/51218-home_default/mirage-concentre-sweet-dream-full-moon-10ml.jpg', 4, '2025-01-28 01:42:31', '2025-01-28 01:42:31'),
(48, 'Serenity Concentré Sweet Dream Full Moon 10ml', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.', 5.90, 'https://www.vapostore.com/51219-home_default/serenity-concentre-sweet-dream-full-moon-10ml.jpg', 4, '2025-01-28 01:42:31', '2025-01-28 01:42:31');

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `type_products`
--

CREATE TABLE `type_products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `libelle` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `type_products`
--

INSERT INTO `type_products` (`id`, `libelle`, `created_at`, `updated_at`, `image`, `description`) VALUES
(1, 'Cigarette électronique', NULL, NULL, 'e-cigarette.jpg', 'Découvrez notre gamme de cigarettes électroniques, idéales pour débutants comme experts.'),
(2, 'E-liquides', NULL, NULL, 'e-liquide.png', 'Une sélection variée d\'e-liquides aux saveurs uniques pour satisfaire tous les goûts.'),
(3, 'Matériel', NULL, NULL, 'materiel.jpg', 'Retrouvez le matériel nécessaire pour une expérience de vape optimale.'),
(4, 'DIY', NULL, NULL, 'DIY.jpg', 'Créez vos propres e-liquides avec nos kits DIY et personnalisez votre expérience.'),
(5, 'Accessoires', NULL, NULL, 'accessoires.jpg', 'Tous les accessoires indispensables pour votre cigarette électronique à portée de main.');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `surname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `carts_user_id_foreign` (`user_id`);

--
-- Index pour la table `cart_products`
--
ALTER TABLE `cart_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_products_cart_id_foreign` (`cart_id`),
  ADD KEY `cart_products_product_id_foreign` (`product_id`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`),
  ADD KEY `orders_cart_id_foreign` (`cart_id`);

--
-- Index pour la table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_type_id_foreign` (`type_id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `type_products`
--
ALTER TABLE `type_products`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `cart_products`
--
ALTER TABLE `cart_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT pour la table `type_products`
--
ALTER TABLE `type_products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `cart_products`
--
ALTER TABLE `cart_products`
  ADD CONSTRAINT `cart_products_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_cart_id_foreign` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `type_products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
