-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Dim 31 Mai 2015 à 20:13
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
  `IDFacebook` bigint(10) unsigned NOT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `playersbuildings`
--

CREATE TABLE IF NOT EXISTS `playersbuildings` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PlayerID` int(10) unsigned NOT NULL,
  `Type` text NOT NULL,
  `X` int(11) NOT NULL,
  `Y` int(11) NOT NULL,
  `Attribute1` int(10) unsigned NOT NULL,
  `Attribute2` int(10) unsigned NOT NULL,
  `Attribute3` int(10) unsigned NOT NULL,
  `Attribute1Lvl` int(10) unsigned NOT NULL,
  `Attribute2Lvl` int(10) unsigned NOT NULL,
  `Attribute3Lvl` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `playersflowers`
--

CREATE TABLE IF NOT EXISTS `playersflowers` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PlayerID` int(10) unsigned NOT NULL,
  `X` int(11) NOT NULL,
  `Y` int(11) NOT NULL,
  `Genome` varchar(34) NOT NULL,
  `LastTimeStamp` bigint(10) unsigned NOT NULL,
  `StateIndex` int(10) unsigned NOT NULL,
  `Attribute1` int(10) unsigned DEFAULT '0',
  `Attribute2` int(11) unsigned DEFAULT '0',
  `Attribute3` int(10) unsigned DEFAULT '0',
  `Attribute4` int(10) unsigned NOT NULL,
  `Bonus1` int(10) unsigned DEFAULT NULL,
  `Bonus2` int(10) unsigned DEFAULT NULL,
  `Bonus3` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `playersfruits`
--

CREATE TABLE IF NOT EXISTS `playersfruits` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PlayerID` int(10) unsigned NOT NULL,
  `Genome` text NOT NULL,
  `Quality` int(10) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `playersseeds`
--

CREATE TABLE IF NOT EXISTS `playersseeds` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PlayerID` int(10) unsigned NOT NULL,
  `Genome` varchar(30) NOT NULL,
  `Level` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `typebuildings`
--

CREATE TABLE IF NOT EXISTS `typebuildings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `texture` varchar(255) NOT NULL,
  `price` int(11) NOT NULL DEFAULT '20',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name` (`Name`)
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

-- --------------------------------------------------------

--
-- Structure de la table `typeflowersattributes`
--

CREATE TABLE IF NOT EXISTS `typeflowersattributes` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Contenu de la table `typeflowersattributes`
--

INSERT INTO `typeflowersattributes` (`ID`, `Name`) VALUES
(1, 'growthspeed'),
(2, 'photosynthesis'),
(3, 'fruitsQuality'),
(4, 'resistance');

-- --------------------------------------------------------

--
-- Structure de la table `typeflowersbonus`
--

CREATE TABLE IF NOT EXISTS `typeflowersbonus` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `typeflowersbonus`
--

INSERT INTO `typeflowersbonus` (`ID`, `Name`) VALUES
(1, 'aurasynthesis'),
(2, 'generous'),
(3, 'sweet');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
