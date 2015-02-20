-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Ven 20 Février 2015 à 11:04
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

-- --------------------------------------------------------

--
-- Structure de la table `playersbuildings`
--

CREATE TABLE IF NOT EXISTS `playersbuildings` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PlayerID` int(10) unsigned NOT NULL,
  `Type` int(10) unsigned NOT NULL,
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
  `ID` int(10) unsigned NOT NULL,
  `PlayerID` int(10) unsigned NOT NULL,
  `Genome` varchar(18) NOT NULL,
  `LifeTime` int(10) unsigned NOT NULL,
  `Attribute1` int(10) unsigned DEFAULT '0',
  `Attribute2` int(11) unsigned DEFAULT '0',
  `Attribute3` int(10) unsigned DEFAULT '0',
  `Bonus1` int(10) unsigned DEFAULT NULL,
  `Bonus2` int(10) unsigned DEFAULT NULL,
  `Bonus3` int(10) unsigned DEFAULT NULL,
  `Bonus4` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `playersseeds`
--

CREATE TABLE IF NOT EXISTS `playersseeds` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `PlayerID` int(10) unsigned NOT NULL,
  `Genome` varchar(18) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `typebuildings`
--

CREATE TABLE IF NOT EXISTS `typebuildings` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Name` (`Name`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Contenu de la table `typebuildings`
--

INSERT INTO `typebuildings` (`ID`, `Name`) VALUES
(7, 'anthill1'),
(8, 'anthill2'),
(9, 'anthill3'),
(1, 'Breaker'),
(10, 'butterflytree1'),
(11, 'butterflytree2'),
(12, 'butterflytree3'),
(4, 'hive1'),
(5, 'hive2'),
(6, 'hive3'),
(3, 'well'),
(2, 'workshop');

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
