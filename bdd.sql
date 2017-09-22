-- phpMyAdmin SQL Dump
-- version 4.6.6deb4
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Ven 22 Septembre 2017 à 08:29
-- Version du serveur :  10.1.26-MariaDB-0+deb9u1
-- Version de PHP :  7.0.19-1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `Absences`
--
CREATE DATABASE IF NOT EXISTS `TPAbsence` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `Absences`;

-- --------------------------------------------------------

--
-- Structure de la table `Absences`
--

CREATE TABLE `Absences` (
  `refVisiteur` int(11) NOT NULL,
  `dateDebut` date NOT NULL,
  `nbJours` int(11) NOT NULL,
  `refMotif` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `Absences`
--

INSERT INTO `Absences` (`refVisiteur`, `dateDebut`, `nbJours`, `refMotif`) VALUES
(2, '2017-09-10', 2, 'MA'),
(2, '2017-09-20', 1, 'MA'),
(3, '2017-09-01', 3, 'RV'),
(3, '2017-09-15', 5, 'IN'),
(3, '2017-10-30', 1, 'MA');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `CumulAbsences`
-- (Voir ci-dessous la vue réelle)
--
CREATE TABLE `CumulAbsences` (
`refVisiteur` int(11)
,`NJAV` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Structure de la table `Motif`
--

CREATE TABLE `Motif` (
  `idMotif` varchar(5) NOT NULL,
  `libelle` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `Motif`
--

INSERT INTO `Motif` (`idMotif`, `libelle`) VALUES
('IN', 'Inconnu'),
('MA', 'Maladie'),
('RV', 'Rendez-vous professionnel');

-- --------------------------------------------------------

--
-- Structure de la table `Visiteurs`
--

CREATE TABLE `Visiteurs` (
  `idVisiteur` int(11) NOT NULL,
  `nomVisiteur` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Contenu de la table `Visiteurs`
--

INSERT INTO `Visiteurs` (`idVisiteur`, `nomVisiteur`) VALUES
(1, 'Dupont'),
(2, 'Bertrand'),
(3, 'Martin'),
(4, 'Richard');

-- --------------------------------------------------------

--
-- Structure de la vue `CumulAbsences`
--
DROP TABLE IF EXISTS `CumulAbsences`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `CumulAbsences`  AS  select `refVisiteur` AS `refVisiteur`,sum(`nbJours`) AS `NJAV` from `Absences` group by `refVisiteur` ;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `Absences`
--
ALTER TABLE `Absences`
  ADD PRIMARY KEY (`refVisiteur`,`dateDebut`),
  ADD KEY `refMotif` (`refMotif`);

--
-- Index pour la table `Motif`
--
ALTER TABLE `Motif`
  ADD PRIMARY KEY (`idMotif`);

--
-- Index pour la table `Visiteurs`
--
ALTER TABLE `Visiteurs`
  ADD PRIMARY KEY (`idVisiteur`);

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `Absences`
--
ALTER TABLE `Absences`
  ADD CONSTRAINT `Absences_ibfk_1` FOREIGN KEY (`refVisiteur`) REFERENCES `Visiteurs` (`idVisiteur`),
  ADD CONSTRAINT `Absences_ibfk_2` FOREIGN KEY (`refMotif`) REFERENCES `Motif` (`idMotif`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
