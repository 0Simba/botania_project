-- phpMyAdmin SQL Dump
-- version 4.2.0
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Mer 25 Mars 2015 à 16:53
-- Version du serveur :  5.6.17
-- Version de PHP :  5.4.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `botania`
--

-- --------------------------------------------------------

--
-- Structure de la table `typebuildings`
--

CREATE TABLE IF NOT EXISTS `typebuildings` (
`ID` int(11) NOT NULL,
  `Name` varchar(255) NOT NULL,
  `texture` varchar(255) NOT NULL,
  `price` int(11) NOT NULL DEFAULT '20'
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `typebuildings`
--

INSERT INTO `typebuildings` (`ID`, `Name`, `texture`, `price`) VALUES
(1, 'Breaker', 'Concasseur_level_1', 0),
(2, 'workshop', 'workshop', 0),
(3, 'well', 'puits', 0),
(4, 'hive1', 'Cerana', 0),
(5, 'hive2', 'Dorsata', 0),
(6, 'hive3', 'workshop', 0),
(7, 'anthill1', 'anthill1', 0),
(8, 'anthill2', 'anthill2', 0),
(9, 'anthill3', 'anthill3', 0),
(10, 'butterflytree1', 'butterflyTree1', 0),
(11, 'butterflytree2', 'butterflyTree2', 0),
(12, 'butterflytree3', 'butterflyTree3', 0);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `typebuildings`
--
ALTER TABLE `typebuildings`
 ADD PRIMARY KEY (`ID`), ADD UNIQUE KEY `Name` (`Name`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `typebuildings`
--
ALTER TABLE `typebuildings`
MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
