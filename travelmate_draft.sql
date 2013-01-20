
CREATE TABLE IF NOT EXISTS `countries` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` text NOT NULL,
  PRIMARY KEY (`ID`)
) DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO `countries` (`ID`, `Title`) VALUES
(1, 'Ukraine'),
(2, 'USA'),
(3, 'Canada'),
(4, 'France');

CREATE TABLE IF NOT EXISTS `steps` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` text NOT NULL,
  PRIMARY KEY (`ID`)
) DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

INSERT INTO `steps` (`ID`, `Title`) VALUES
(1, 'Plan'),
(2, 'Pack'),
(3, 'Go'),
(4, 'Keep');

CREATE TABLE IF NOT EXISTS `todos` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` text NOT NULL,
  `ID_Travel` int(11) NOT NULL,
  `ID_Parent` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `travels` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Title` text NOT NULL,
  `Subtitle` text NOT NULL,
  `Country_from` int(11) NOT NULL,
  `Country_to` int(11) NOT NULL,
  `Date_from` date NOT NULL,
  `Date_to` date NOT NULL,
  `ID_User` int(11) NOT NULL,
  `ID_Step` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
)  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

INSERT INTO `travels` (`ID`, `Title`, `Subtitle`, `Country_from`, `Country_to`, `Date_from`, `Date_to`, `ID_User`, `ID_Step`) VALUES
(1, 'Travel from DB 1', 'This travel retreived from DB', 1, 2, '2013-01-07', '2013-01-14', 0, 1);
