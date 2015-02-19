-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Jeu 19 Février 2015 à 22:47
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

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
-- Structure de la table `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `IDFacebook` int(10) unsigned NOT NULL,
  `Sun` mediumint(8) unsigned NOT NULL,
  `Gold` mediumint(8) unsigned NOT NULL,
  `XP` int(10) unsigned NOT NULL,
  `Propolis` int(10) unsigned NOT NULL,
  `Honey` int(10) unsigned NOT NULL,
  `Sap` int(10) unsigned NOT NULL,
  `DarknessBiome` tinyint(1) NOT NULL,
  `WesternBiome` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IDFacebook` (`IDFacebook`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Contenu de la table `players`
--

INSERT INTO `players` (`ID`, `IDFacebook`, `Sun`, `Gold`, `XP`, `Propolis`, `Honey`, `Sap`, `DarknessBiome`, `WesternBiome`) VALUES
(1, 707, 0, 0, 0, 0, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
