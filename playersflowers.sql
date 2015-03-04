-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Mer 04 Mars 2015 à 23:26
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
-- Structure de la table `playersflowers`
--

CREATE TABLE IF NOT EXISTS `playersflowers` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PlayerID` int(10) unsigned NOT NULL,
  `X` int(11) NOT NULL,
  `Y` int(11) NOT NULL,
  `Genome` varchar(18) NOT NULL,
  `LastTimeStamp` bigint(10) unsigned NOT NULL,
  `stateIndex` int(10) unsigned NOT NULL,
  `Attribute1` int(10) unsigned DEFAULT '0',
  `Attribute2` int(11) unsigned DEFAULT '0',
  `Attribute3` int(10) unsigned DEFAULT '0',
  `Attribute4` int(10) unsigned NOT NULL,
  `Bonus1` int(10) unsigned DEFAULT NULL,
  `Bonus2` int(10) unsigned DEFAULT NULL,
  `Bonus3` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `playersflowers`
--

INSERT INTO `playersflowers` (`ID`, `PlayerID`, `X`, `Y`, `Genome`, `LastTimeStamp`, `stateIndex`, `Attribute1`, `Attribute2`, `Attribute3`, `Attribute4`, `Bonus1`, `Bonus2`, `Bonus3`) VALUES
(1, 2, 1, -1, 'ABB', 20150304232349, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 2, 1, -1, 'ABB', 20150304232510, 0, 0, 0, 0, 0, 0, 0, 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
