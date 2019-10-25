-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2019. Okt 25. 18:31
-- Kiszolgáló verziója: 10.4.6-MariaDB
-- PHP verzió: 7.1.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `hzufer`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `alapanyag`
--

CREATE TABLE `alapanyag` (
  `alapanyag_id` int(11) NOT NULL,
  `recept_id` int(11) NOT NULL,
  `allergia_id` int(11) DEFAULT NULL,
  `nev` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `kaloria` int(11) DEFAULT NULL COMMENT 'kcal / 100g'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `alapanyag`
--

INSERT INTO `alapanyag` (`alapanyag_id`, `recept_id`, `allergia_id`, `nev`, `kaloria`) VALUES
(1, 1, 4, 'liszt', 337),
(2, 1, 3, 'tojás', 143),
(3, 1, 1, 'tej 2,8%', 56),
(7, 1, NULL, 'szénsavas ásványvíz', NULL),
(8, 1, NULL, 'só', NULL),
(9, 1, NULL, 'Napraforgóolaj', 884);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `allergia`
--

CREATE TABLE `allergia` (
  `allergia_id` int(11) NOT NULL,
  `nev` varchar(50) COLLATE utf8_hungarian_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `allergia`
--

INSERT INTO `allergia` (`allergia_id`, `nev`) VALUES
(1, 'tejallergia'),
(2, 'földimogyoró allergia'),
(3, 'tojásallergia'),
(4, 'lisztérzékenység');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `mertekegyseg`
--

CREATE TABLE `mertekegyseg` (
  `mertekegyseg_id` int(11) NOT NULL,
  `recept_id` int(11) NOT NULL,
  `alapanyag_id` int(11) NOT NULL,
  `mennyi` double NOT NULL,
  `nev` varchar(25) COLLATE utf8_hungarian_ci NOT NULL COMMENT 'teás kanál, bögre stb..'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `mertekegyseg`
--

INSERT INTO `mertekegyseg` (`mertekegyseg_id`, `recept_id`, `alapanyag_id`, `mennyi`, `nev`) VALUES
(1, 1, 1, 20, 'dkg'),
(2, 1, 2, 2, 'db'),
(3, 1, 3, 3, 'dl'),
(4, 1, 7, 2, 'dl'),
(5, 1, 8, 1, 'csipet'),
(6, 1, 9, 3.5, 'dl');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `recept`
--

CREATE TABLE `recept` (
  `recept_id` int(11) NOT NULL,
  `nev` varchar(50) COLLATE utf8_hungarian_ci NOT NULL,
  `adag` int(15) NOT NULL COMMENT 'hány személyes',
  `ido_sutes` int(11) NOT NULL COMMENT 'sütési idő',
  `ido_elkeszit` int(11) NOT NULL COMMENT 'elkészítési idő',
  `leiras` text COLLATE utf8_hungarian_ci NOT NULL COMMENT 'pl elkészitése'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `recept`
--

INSERT INTO `recept` (`recept_id`, `nev`, `adag`, `ido_sutes`, `ido_elkeszit`, `leiras`) VALUES
(1, 'alap palacsintatészta', 4, 60, 90, 'Egyszerű elkészítés méghozzá olcsón ');

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `alapanyag`
--
ALTER TABLE `alapanyag`
  ADD PRIMARY KEY (`alapanyag_id`),
  ADD KEY `hozzavalo` (`recept_id`),
  ADD KEY `etelallergia` (`allergia_id`);

--
-- A tábla indexei `allergia`
--
ALTER TABLE `allergia`
  ADD PRIMARY KEY (`allergia_id`) USING BTREE;

--
-- A tábla indexei `mertekegyseg`
--
ALTER TABLE `mertekegyseg`
  ADD PRIMARY KEY (`mertekegyseg_id`),
  ADD KEY `tartalmaz` (`alapanyag_id`),
  ADD KEY `mennyiseg` (`recept_id`);

--
-- A tábla indexei `recept`
--
ALTER TABLE `recept`
  ADD PRIMARY KEY (`recept_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `alapanyag`
--
ALTER TABLE `alapanyag`
  MODIFY `alapanyag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT a táblához `allergia`
--
ALTER TABLE `allergia`
  MODIFY `allergia_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `mertekegyseg`
--
ALTER TABLE `mertekegyseg`
  MODIFY `mertekegyseg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `recept`
--
ALTER TABLE `recept`
  MODIFY `recept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `alapanyag`
--
ALTER TABLE `alapanyag`
  ADD CONSTRAINT `etelallergia` FOREIGN KEY (`allergia_id`) REFERENCES `allergia` (`allergia_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `hozzavalo` FOREIGN KEY (`recept_id`) REFERENCES `recept` (`recept_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Megkötések a táblához `mertekegyseg`
--
ALTER TABLE `mertekegyseg`
  ADD CONSTRAINT `mennyiseg` FOREIGN KEY (`recept_id`) REFERENCES `recept` (`recept_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tartalmaz` FOREIGN KEY (`alapanyag_id`) REFERENCES `alapanyag` (`alapanyag_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
