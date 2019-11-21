-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2019. Nov 21. 18:54
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
-- Adatbázis: `recept`
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
  `mennyiseg` varchar(50) COLLATE utf8_hungarian_ci NOT NULL COMMENT 'pl.: 2 csipet, 3dl',
  `kaloria` int(11) DEFAULT NULL COMMENT 'kcal / 100g'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `alapanyag`
--

INSERT INTO `alapanyag` (`alapanyag_id`, `recept_id`, `allergia_id`, `nev`, `mennyiseg`, `kaloria`) VALUES
(1, 1, 4, 'liszt', '20 dkg', 337),
(2, 1, 3, 'tojás', '2 db', 143),
(3, 1, 1, 'tej 2,8%', '3 dl', 56),
(7, 1, NULL, 'szénsavas ásványvíz', '2 dl', NULL),
(8, 1, NULL, 'só', '1 csipet', NULL),
(9, 1, NULL, 'Napraforgóolaj', '3 és fél dl', 884);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
