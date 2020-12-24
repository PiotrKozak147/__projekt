-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Czas generowania: 24 Gru 2020, 13:01
-- Wersja serwera: 10.4.17-MariaDB
-- Wersja PHP: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Baza danych: `mydb`
--

DELIMITER $$
--
-- Procedury
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `przecena` (IN `nazwa` VARCHAR(64))  UPDATE item

SET cena_produktu = cena_produktu*0.9

WHERE description = nazwa$$

--
-- Funkcje
--
CREATE DEFINER=`root`@`localhost` FUNCTION `data_rozpoczęcia` (`data` DATE) RETURNS CHAR(20) CHARSET utf8 RETURN YEAR(data)$$

CREATE DEFINER=`root`@`localhost` FUNCTION `fn_data` (`data` DATE) RETURNS CHAR(20) CHARSET utf8 RETURN YEAR(data)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `dystrybucja`
--

CREATE TABLE `dystrybucja` (
  `id_dystrybucji` int(11) NOT NULL,
  `data rozpoczęcia` date NOT NULL,
  `data zakończenia` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `dystrybucja`
--

INSERT INTO `dystrybucja` (`id_dystrybucji`, `data rozpoczęcia`, `data zakończenia`) VALUES
(8, '2020-12-17', '2020-12-18'),
(9, '2020-12-19', '2020-12-21'),
(10, '2020-12-17', '2020-12-18'),
(11, '2020-12-15', '2020-12-16'),
(12, '2020-12-05', '2020-12-07'),
(14, '2020-12-17', '2020-12-18');

--
-- Wyzwalacze `dystrybucja`
--
DELIMITER $$
CREATE TRIGGER `data_dodania` BEFORE INSERT ON `dystrybucja` FOR EACH ROW SET NEW.`data rozpoczęcia`= now()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `hala`
--

CREATE TABLE `hala` (
  `id_hali` int(11) NOT NULL,
  `nazwa` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `hala`
--

INSERT INTO `hala` (`id_hali`, `nazwa`) VALUES
(1, 'woda'),
(2, 'napoje');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pojazdy`
--

CREATE TABLE `pojazdy` (
  `id_pojazdy` int(11) NOT NULL,
  `marka` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `pojazdy`
--

INSERT INTO `pojazdy` (`id_pojazdy`, `marka`) VALUES
(1, 'audi'),
(2, 'ford'),
(3, 'bmw'),
(4, 'skoda');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `id_pracownika` int(11) NOT NULL,
  `imię` varchar(45) NOT NULL,
  `nazwisko` varchar(45) NOT NULL,
  `dystrybucja_id_dystrybucji` int(11) NOT NULL,
  `Hala_id_hali` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `pracownicy`
--

INSERT INTO `pracownicy` (`id_pracownika`, `imię`, `nazwisko`, `dystrybucja_id_dystrybucji`, `Hala_id_hali`) VALUES
(13, 'Jan', 'Kowalski', 8, 2),
(15, 'Piotr', 'Kozak', 8, 1),
(17, 'Adam', 'Małysz', 9, 1),
(18, 'Michał', 'Nowak', 10, 2),
(19, 'Jacek', 'Soplica', 11, 2),
(20, 'Paweł', 'Kowalski', 12, 2),
(21, 'Jan', 'Kowalski', 12, 2),
(22, 'Paweł', 'Brzegowski', 8, 1),
(23, 'Mateusz', 'Kętrzyński', 12, 1);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy_has_pojazdy`
--

CREATE TABLE `pracownicy_has_pojazdy` (
  `pracownicy_id_pracownika` int(11) NOT NULL,
  `Pojazdy_id_pojazdy` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `pracownicy_has_pojazdy`
--

INSERT INTO `pracownicy_has_pojazdy` (`pracownicy_id_pracownika`, `Pojazdy_id_pojazdy`) VALUES
(13, 1),
(15, 2),
(17, 3),
(18, 4);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `produkt`
--

CREATE TABLE `produkt` (
  `id_produkt` int(11) NOT NULL,
  `nazwa_produktu` varchar(45) NOT NULL,
  `dystrybucja_id_dystrybucji` int(11) NOT NULL,
  `rodzaj_produktu_id_rodzaj` int(11) NOT NULL,
  `cena_produktu` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `produkt`
--

INSERT INTO `produkt` (`id_produkt`, `nazwa_produktu`, `dystrybucja_id_dystrybucji`, `rodzaj_produktu_id_rodzaj`, `cena_produktu`) VALUES
(23, 'woda gazowana', 8, 2, 2),
(26, 'woda niegazowana', 8, 2, 2),
(27, 'woda niegazowana truskawkowa', 8, 3, 3),
(28, 'napój izotoniczny', 9, 3, 4),
(29, 'woda lekko gazowana', 10, 2, 2),
(30, 'woda gazowana truskawkowa', 11, 3, 3),
(31, 'woda gazowana cytrynowa', 12, 2, 3),
(32, 'woda niegazowana cyrtynowa', 14, 3, 3),
(33, 'woda niegazowana marakuja', 8, 3, 3),
(34, 'woda gazowana marakuja', 9, 3, 3),
(35, 'woda lekko gazowana', 10, 2, 2);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `rodzaj_produktu`
--

CREATE TABLE `rodzaj_produktu` (
  `id_rodzaj` int(11) NOT NULL,
  `rodzaj` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Zrzut danych tabeli `rodzaj_produktu`
--

INSERT INTO `rodzaj_produktu` (`id_rodzaj`, `rodzaj`) VALUES
(2, 'woda'),
(3, 'napój');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `dystrybucja`
--
ALTER TABLE `dystrybucja`
  ADD PRIMARY KEY (`id_dystrybucji`);

--
-- Indeksy dla tabeli `hala`
--
ALTER TABLE `hala`
  ADD PRIMARY KEY (`id_hali`);

--
-- Indeksy dla tabeli `pojazdy`
--
ALTER TABLE `pojazdy`
  ADD PRIMARY KEY (`id_pojazdy`);

--
-- Indeksy dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`id_pracownika`),
  ADD KEY `Hala_id_hali` (`Hala_id_hali`),
  ADD KEY `dystrybucja_id_dystrybucji` (`dystrybucja_id_dystrybucji`);

--
-- Indeksy dla tabeli `pracownicy_has_pojazdy`
--
ALTER TABLE `pracownicy_has_pojazdy`
  ADD PRIMARY KEY (`pracownicy_id_pracownika`,`Pojazdy_id_pojazdy`),
  ADD KEY `pracownicy_id_pracownika` (`pracownicy_id_pracownika`),
  ADD KEY `Pojazdy_id_pojazdy` (`Pojazdy_id_pojazdy`);

--
-- Indeksy dla tabeli `produkt`
--
ALTER TABLE `produkt`
  ADD PRIMARY KEY (`id_produkt`),
  ADD KEY `dystrybucja_id_dystrybucji` (`dystrybucja_id_dystrybucji`),
  ADD KEY `rodzaj_produktu_id_rodzaj` (`rodzaj_produktu_id_rodzaj`);

--
-- Indeksy dla tabeli `rodzaj_produktu`
--
ALTER TABLE `rodzaj_produktu`
  ADD PRIMARY KEY (`id_rodzaj`);

--
-- AUTO_INCREMENT dla zrzuconych tabel
--

--
-- AUTO_INCREMENT dla tabeli `dystrybucja`
--
ALTER TABLE `dystrybucja`
  MODIFY `id_dystrybucji` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT dla tabeli `hala`
--
ALTER TABLE `hala`
  MODIFY `id_hali` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT dla tabeli `pojazdy`
--
ALTER TABLE `pojazdy`
  MODIFY `id_pojazdy` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  MODIFY `id_pracownika` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT dla tabeli `produkt`
--
ALTER TABLE `produkt`
  MODIFY `id_produkt` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT dla tabeli `rodzaj_produktu`
--
ALTER TABLE `rodzaj_produktu`
  MODIFY `id_rodzaj` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ograniczenia dla zrzutów tabel
--

--
-- Ograniczenia dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD CONSTRAINT `pracownicy_ibfk_1` FOREIGN KEY (`Hala_id_hali`) REFERENCES `hala` (`id_hali`),
  ADD CONSTRAINT `pracownicy_ibfk_2` FOREIGN KEY (`dystrybucja_id_dystrybucji`) REFERENCES `dystrybucja` (`id_dystrybucji`);

--
-- Ograniczenia dla tabeli `pracownicy_has_pojazdy`
--
ALTER TABLE `pracownicy_has_pojazdy`
  ADD CONSTRAINT `pracownicy_has_pojazdy_ibfk_1` FOREIGN KEY (`Pojazdy_id_pojazdy`) REFERENCES `pojazdy` (`id_pojazdy`),
  ADD CONSTRAINT `pracownicy_has_pojazdy_ibfk_2` FOREIGN KEY (`pracownicy_id_pracownika`) REFERENCES `pracownicy` (`id_pracownika`);

--
-- Ograniczenia dla tabeli `produkt`
--
ALTER TABLE `produkt`
  ADD CONSTRAINT `produkt_ibfk_1` FOREIGN KEY (`dystrybucja_id_dystrybucji`) REFERENCES `dystrybucja` (`id_dystrybucji`),
  ADD CONSTRAINT `produkt_ibfk_2` FOREIGN KEY (`rodzaj_produktu_id_rodzaj`) REFERENCES `rodzaj_produktu` (`id_rodzaj`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
