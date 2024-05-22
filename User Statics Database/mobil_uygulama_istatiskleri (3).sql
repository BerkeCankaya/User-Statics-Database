-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 29, 2023 at 07:25 PM
-- Server version: 5.7.24
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mobil_uygulama_istatiskleri`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `indirme cihazını girerek cihaza gore indirmesi tamamlanmiş kul.` (IN `indirme_cihazı` VARCHAR(255))   SELECT kullanıcılar.Kullanıcı_ID,kullanıcılar.Kullanıcı_Adı,
kullanıcılar.Kullanıcı_Soyadı,kullanıcılar.Kullanıcı_Ülke,
kullanıcılar.Kullanıcı_Cinsiyet,kullanıcılar.Kullanıcı_Yas,
indirme_istatiskleri.İndirme_cihazı,
indirme_istatiskleri.İndirme_durumu
FROM kullanıcılar,indirme_istatiskleri
WHERE kullanıcılar.Kullanıcı_ID=indirme_istatiskleri.Kullanıcı_ID AND
indirme_istatiskleri.İndirme_durumu="Tamamlandı" AND
indirme_istatiskleri.İndirme_cihazı= indirme_cihazı$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `indirme durumu tamamlandı olan uygulamalar ve kullanici bilgiler` ()   SELECT uygulamalar.Uygulama_Adı, uygulamalar.Uygulama_Geliştirici, indirme_istatiskleri.İndirme_durumu,
indirme_istatiskleri.Uygulama_ID,kullanıcılar.Kullanıcı_ID,kullanıcılar.Kullanıcı_Adı,kullanıcılar.Kullanıcı_Soyadı
FROM uygulamalar, indirme_istatiskleri,kullanıcılar
WHERE uygulamalar.Uygulama_ID = indirme_istatiskleri.Uygulama_ID AND
kullanıcılar.Kullanıcı_ID=indirme_istatiskleri.Kullanıcı_ID
AND indirme_istatiskleri.İndirme_durumu = 'Tamamlandı'$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `indirmesi tamamlanmamiş kişileri gosterir` ()   SELECT kullanıcılar.Kullanıcı_Adı,kullanıcılar.Kullanıcı_Soyadı,
kullanıcılar.Kullanıcı_Cinsiyet,indirme_istatiskleri.İndirme_cihazı,
indirme_istatiskleri.İndirme_durumu
FROM kullanıcılar,indirme_istatiskleri
WHERE kullanıcılar.Kullanıcı_ID=indirme_istatiskleri.Kullanıcı_ID AND
indirme_istatiskleri.İndirme_durumu="Tamamlanmadı"$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `isimleri e ile baslayan 20-30 yas arasındakileri gosterme` ()   SELECT * FROM kullanıcılar
WHERE Kullanıcı_Adı LIKE "E%" AND
Kullanıcı_Yas BETWEEN 20 AND 30$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Kadinlarin yaptiklari yorumlar ve puanlar` ()   SELECT geri_bildirim.Yorum,geri_bildirim.Verilen_Puan,
kullanıcılar.Kullanıcı_Adı,kullanıcılar.Kullanıcı_Soyadı,
kullanıcılar.Kullanıcı_Cinsiyet
FROM geri_bildirim,kullanıcılar
WHERE geri_bildirim.Kullanıcı_ID=kullanıcılar.Kullanıcı_ID AND
kullanıcılar.Kullanıcı_Cinsiyet="Kadın"$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kategori idyi girerek kategorideki uygulamaları gosterir` (IN `kategori_ıd` INT, IN `kategori_adı` VARCHAR(255))   SELECT uygulamalar.Uygulama_ID, uygulamalar.Uygulama_Adı, uygulamalar.Uygulama_Geliştirici,kategori_bilgileri.Kategori_Bilg_Adı
FROM uygulamalar,kategori_bilgileri,uyg_kategori
WHERE uyg_kategori.Kategori_Bilg_ID = kategori_bilgileri.Kategori_Bilg_ID AND
uygulamalar.Uygulama_ID=uyg_kategori.Uygulama_ID AND
kategori_bilgileri.Kategori_Bilg_ID = kategori_ıd AND
kategori_bilgileri.Kategori_Bilg_Adı = kategori_adı$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kullanici id adi ve soyadini girerek indirme istatisk ve uyg.` (IN `kullanıcı_ıd` INT, IN `kullanıcı_adı` VARCHAR(255), IN `kullanıcı_soyadı` VARCHAR(255))   SELECT kullanıcılar.Kullanıcı_ID,kullanıcılar.Kullanıcı_Adı,
kullanıcılar.Kullanıcı_Soyadı,kullanıcılar.Kullanıcı_Cinsiyet,
kullanıcılar.Kullanıcı_Ülke,kullanıcılar.Kullanıcı_Yas,
uygulamalar.Uygulama_Adı,uygulamalar.Uygulama_Geliştirici,
indirme_istatiskleri.İndirme_tarihi,indirme_istatiskleri.İndirme_cihazı,
indirme_istatiskleri.İndirme_durumu
FROM kullanıcılar,uygulamalar,indirme_istatiskleri
WHERE kullanıcılar.Kullanıcı_ID = indirme_istatiskleri.Kullanıcı_ID
AND uygulamalar.Uygulama_ID = indirme_istatiskleri.Uygulama_ID
AND kullanıcılar.Kullanıcı_ID = kullanıcı_ıd
AND kullanıcılar.Kullanıcı_Adı = kullanıcı_adı
AND kullanıcılar.Kullanıcı_Soyadı = kullanıcı_soyadı$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kullanici idsine gore kullanici adi ve soyadi , yaptigi yorumlar` (IN `kullanıcı_ıd` INT, IN `kullanıcı_adı` VARCHAR(255), IN `kullanıcı_soyadı` VARCHAR(255))   SELECT kullanıcılar.Kullanıcı_Adı, kullanıcılar.Kullanıcı_Soyadı, geri_bildirim.Yorum, geri_bildirim.Verilen_Puan, uygulamalar.Uygulama_Adı, uygulamalar.Uygulama_Geliştirici
FROM kullanıcılar,geri_bildirim,uygulamalar,uyg_geri_bild
WHERE kullanıcılar.Kullanıcı_ID=geri_bildirim.Kullanıcı_ID AND uyg_geri_bild.Geri_Bild_ID=geri_bildirim.Geri_Bild_ID AND uyg_geri_bild.Uygulama_ID=uygulamalar.Uygulama_ID
AND kullanıcılar.Kullanıcı_ID = kullanıcı_ıd AND kullanıcılar.Kullanıcı_Adı = kullanıcı_adı AND
kullanıcılar.Kullanıcı_Soyadı = kullanıcı_soyadı$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Kullanici ulkelerine gore kullanici sayisi` ()   SELECT Kullanıcı_Ülke, COUNT(Kullanıcı_ID) AS Kullanıcı_Sayısı
FROM kullanıcılar
GROUP BY Kullanıcı_Ülke$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Kullanici Ulkelerine göre ortalama yaslar` ()   SELECT Kullanıcı_Ülke, AVG(Kullanıcı_Yas) AS Ortalama_Yas
FROM kullanıcılar
GROUP BY Kullanıcı_Ülke
ORDER BY Ortalama_Yas DESC$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `degistirilen_tarih`
--

CREATE TABLE `degistirilen_tarih` (
  `İndirme_ID` int(11) NOT NULL,
  `İndirme_Tarihi` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `degistirilen_tarih`
--

INSERT INTO `degistirilen_tarih` (`İndirme_ID`, `İndirme_Tarihi`) VALUES
(1, '2020-03-01'),
(3, '2021-07-27'),
(7, '2022-11-20');

-- --------------------------------------------------------

--
-- Table structure for table `eklenen_uygulamalar`
--

CREATE TABLE `eklenen_uygulamalar` (
  `Eklenen_Uygulamalar` int(11) NOT NULL,
  `Uygulama_Adı` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Uygulama_Geliştiricisi` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `eklenen_uygulamalar`
--

INSERT INTO `eklenen_uygulamalar` (`Eklenen_Uygulamalar`, `Uygulama_Adı`, `Uygulama_Geliştiricisi`) VALUES
(1, 'Clash Of Clans', 'Supercell');

-- --------------------------------------------------------

--
-- Table structure for table `geri_bildirim`
--

CREATE TABLE `geri_bildirim` (
  `Geri_Bild_ID` int(11) NOT NULL,
  `Yorum` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Verilen_Puan` int(11) DEFAULT NULL,
  `Kullanıcı_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `geri_bildirim`
--

INSERT INTO `geri_bildirim` (`Geri_Bild_ID`, `Yorum`, `Verilen_Puan`, `Kullanıcı_ID`) VALUES
(1, 'Uygulama hızlı ve kullanıcı dostu, beğendim!', 5, 1),
(2, 'Arayüz çok karmaşık, daha anlaşılır olabilir.', 3, 2),
(3, 'Yeni güncelleme ile performans artışı sağlanmış, teşekkürler.', 4, 3),
(4, 'Bazı özellikler beklediğim gibi çalışmıyor, düzeltilmeli.', 2, 4),
(5, 'Tasarım harika, kolaylıkla kullanabiliyorum.', 4, 5),
(6, 'Çok fazla reklam var, rahatsız edici.', 2, 8),
(7, 'Yardım ve destek ekibi hızlı cevap veriyor, memnunum.', 4, 9),
(8, 'Güvenlik konusunda daha fazla önlem alınmalı.', 3, 7),
(9, 'Yeni özellikler eklenmeli, daha yenilikçi olabilir.', 3, 10),
(10, 'Uygulama stabil değil, sık sık çöküyor.', 1, 6),
(11, 'Harika bir uygulama,çok beğendim.', 5, 2),
(12, 'Uygulama çok yavaş,beğenmedim.', 1, 5),
(13, 'Çok güzel bir uygulama fakat fazla reklam veriyor', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `indirme_istatiskleri`
--

CREATE TABLE `indirme_istatiskleri` (
  `İndirme_ID` int(11) NOT NULL,
  `İndirme_tarihi` date DEFAULT NULL,
  `İndirme_cihazı` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `İndirme_durumu` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Uygulama_ID` int(11) DEFAULT NULL,
  `Kullanıcı_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `indirme_istatiskleri`
--

INSERT INTO `indirme_istatiskleri` (`İndirme_ID`, `İndirme_tarihi`, `İndirme_cihazı`, `İndirme_durumu`, `Uygulama_ID`, `Kullanıcı_ID`) VALUES
(1, '2019-05-11', 'İos', 'Tamamlandı', 1, 1),
(2, '2020-07-13', 'Android', 'Tamamlandı', 3, 2),
(3, '2020-05-17', 'İos', 'Tamamlanmadı', 2, 3),
(4, '2023-05-03', 'İos', 'Tamamlandı', 4, 6),
(5, '2021-01-01', 'Android', 'Tamamlandı', 5, 4),
(6, '2019-12-29', 'Android', 'Tamamlanmadı', 6, 5),
(7, '2021-11-10', 'İos', 'Tamamlanmadı', 7, 8),
(8, '2022-12-21', 'İos', 'Tamamlandı', 8, 7),
(9, '2021-06-17', 'Android', 'Tamamlandı', 9, 9),
(10, '2023-03-03', 'Windows', 'Tamamlandı', 10, 10),
(11, '2020-03-23', 'İos', 'Tamamlanmadı', 4, 1),
(12, '2021-05-20', 'Android', 'Tamamlandı', 1, 2),
(13, '2018-08-02', 'İos', 'Tamamlandı', 3, 3),
(14, '2017-09-13', 'İos', 'Tamamlandı', 2, 6),
(15, '2019-04-16', 'Andorid', 'Tamamlandı', 2, 4),
(16, '2021-05-10', 'Android', 'Tamamlandı', 5, 5),
(17, '2020-11-11', 'İos', 'Tamamlandı', 10, 8),
(18, '2020-05-22', 'İos', 'Tamamlanmadı', 4, 7),
(19, '2019-11-30', 'Andorid', 'Tamamlandı', 8, 9),
(20, '2018-01-14', 'Windows', 'Tamamlanmadı', 9, 10),
(21, '2017-09-04', 'Windows', 'Tamamlandı', 5, 3);

--
-- Triggers `indirme_istatiskleri`
--
DELIMITER $$
CREATE TRIGGER `Degistirilen_Tarih` AFTER UPDATE ON `indirme_istatiskleri` FOR EACH ROW INSERT INTO degistirilen_tarih(İndirme_ID,İndirme_Tarihi)
VALUES (OLD.İndirme_ID,OLD.İndirme_tarihi)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kategori_bilgileri`
--

CREATE TABLE `kategori_bilgileri` (
  `Kategori_Bilg_ID` int(11) NOT NULL,
  `Kategori_Bilg_Adı` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `kategori_bilgileri`
--

INSERT INTO `kategori_bilgileri` (`Kategori_Bilg_ID`, `Kategori_Bilg_Adı`) VALUES
(1, 'Sosyal Ağlar'),
(2, 'Yemek'),
(3, 'Spor'),
(4, 'Oyun'),
(5, 'Müzik'),
(6, 'Eğitim'),
(7, 'Yol ve Navigasyon'),
(8, 'Eğlence'),
(9, 'Seyehat Ve Gezi'),
(10, 'Hava Durumu');

-- --------------------------------------------------------

--
-- Table structure for table `kullanıcılar`
--

CREATE TABLE `kullanıcılar` (
  `Kullanıcı_ID` int(11) NOT NULL,
  `Kullanıcı_Adı` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Kullanıcı_Soyadı` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Kullanıcı_Ülke` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Kullanıcı_Cinsiyet` varchar(50) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Kullanıcı_Yas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `kullanıcılar`
--

INSERT INTO `kullanıcılar` (`Kullanıcı_ID`, `Kullanıcı_Adı`, `Kullanıcı_Soyadı`, `Kullanıcı_Ülke`, `Kullanıcı_Cinsiyet`, `Kullanıcı_Yas`) VALUES
(1, 'Berke', 'Çankaya', 'Türkiye', 'Erkek', 20),
(2, 'Efe', 'Yılmaz', 'Türkiye', 'Erkek', 25),
(3, 'Deniz', 'Kaya', 'Almanya', 'Erkek', 30),
(4, 'Selin', 'Aydın', 'Fransa', 'Kadın', 28),
(5, 'Mert', 'Çelik', 'İngiltere', 'Erkek', 22),
(6, 'Elif', 'Kurt', 'İtalya', 'Kadın', 26),
(7, 'Zeynep', 'Şahin', 'ABD', 'Kadın', 31),
(8, 'Kaan', 'Yıldız', 'Kanada', 'Erkek', 27),
(9, 'Aslı', 'Akgün', 'ABD', 'Kadın', 24),
(10, 'Arda', 'Demir', 'İspanya', 'Erkek', 29),
(11, 'Efe', 'Ercan', 'Türkiye', 'Erkek', 29),
(12, 'Emre', 'Haspolat', 'Türkiye', 'Erkek', 21),
(13, 'Yiğit ', 'Aldemir', 'Türkiye', 'Erkek', 32),
(14, 'Serhan', 'Demir', 'Türkiye', 'Erkek', 18),
(15, 'Aslı ', 'İlkan', 'İngiltere', 'Kadın', 25),
(16, 'Adnan', 'Alır', 'Türkiye', 'Erkek', 42),
(17, 'Azra', 'Bulut', 'İtalya', 'Kadın', 38);

--
-- Triggers `kullanıcılar`
--
DELIMITER $$
CREATE TRIGGER `Silinen_Kullanicilar` AFTER DELETE ON `kullanıcılar` FOR EACH ROW INSERT INTO silinen_kullanıcılar ( Kullanıcı_Adı, Kullanıcı_Soyadı, Kullanıcı_Ülke, Kullanıcı_Cinsiyet, Kullanıcı_Yas)
VALUES (OLD.Kullanıcı_Adı, OLD.Kullanıcı_Soyadı, OLD.Kullanıcı_Ülke, OLD.Kullanıcı_Cinsiyet, OLD.Kullanıcı_Yas)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kul_uyg`
--

CREATE TABLE `kul_uyg` (
  `Kul_Uyg_ID` int(11) NOT NULL,
  `Kullanıcı_ID` int(11) DEFAULT NULL,
  `Uygulama_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `kul_uyg`
--

INSERT INTO `kul_uyg` (`Kul_Uyg_ID`, `Kullanıcı_ID`, `Uygulama_ID`) VALUES
(1, 1, 1),
(2, 2, 4),
(3, 3, 2),
(4, 4, 5),
(5, 5, 3),
(6, 6, 6),
(7, 7, 10),
(8, 8, 8),
(9, 9, 7),
(10, 10, 9);

-- --------------------------------------------------------

--
-- Table structure for table `silinen_kullanıcılar`
--

CREATE TABLE `silinen_kullanıcılar` (
  `Silinen_Kullanıcılar_ID` int(11) NOT NULL,
  `Kullanıcı_Adı` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Kullanıcı_Soyadı` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Kullanıcı_Cinsiyet` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Kullanıcı_Ülke` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Kullanıcı_Yas` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `silinen_kullanıcılar`
--

INSERT INTO `silinen_kullanıcılar` (`Silinen_Kullanıcılar_ID`, `Kullanıcı_Adı`, `Kullanıcı_Soyadı`, `Kullanıcı_Cinsiyet`, `Kullanıcı_Ülke`, `Kullanıcı_Yas`) VALUES
(1, 'Mehptap', 'Eren', 'Kadın', 'İtalya', 32),
(2, 'Mert', 'Samet', 'Erkek', 'Türkiye', 20);

-- --------------------------------------------------------

--
-- Table structure for table `uygulamalar`
--

CREATE TABLE `uygulamalar` (
  `Uygulama_ID` int(11) NOT NULL,
  `Uygulama_Adı` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL,
  `Uygulama_Geliştirici` varchar(255) COLLATE utf8_turkish_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `uygulamalar`
--

INSERT INTO `uygulamalar` (`Uygulama_ID`, `Uygulama_Adı`, `Uygulama_Geliştirici`) VALUES
(1, 'Spotify', 'Spotify AB'),
(2, 'Twitter', 'Twitter Inc.'),
(3, 'İnstagram', 'Meta Platforms Inc.'),
(4, 'Youtube', 'Google LLC'),
(5, 'Nike Training Club', 'Nike Inc.'),
(6, 'TikTok', 'ByteDance'),
(7, 'Facebook', 'Meta Platforms Inc.'),
(8, 'Google Maps', 'Google LLC'),
(9, 'YemekSepeti', 'Delivery Hero SE'),
(10, 'Clash Royale', 'Supercell'),
(11, 'Clash Of Clans', 'Supercell');

--
-- Triggers `uygulamalar`
--
DELIMITER $$
CREATE TRIGGER `Eklenen_Uygulamalar` AFTER INSERT ON `uygulamalar` FOR EACH ROW INSERT INTO eklenen_uygulamalar(Uygulama_Adı,Uygulama_Geliştiricisi)
VALUES (NEW.Uygulama_Adı,NEW.Uygulama_Geliştirici)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `uyg_geri_bild`
--

CREATE TABLE `uyg_geri_bild` (
  `Uyg_Geri_Bild_ID` int(11) NOT NULL,
  `Geri_Bild_ID` int(11) DEFAULT NULL,
  `Uygulama_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `uyg_geri_bild`
--

INSERT INTO `uyg_geri_bild` (`Uyg_Geri_Bild_ID`, `Geri_Bild_ID`, `Uygulama_ID`) VALUES
(1, 1, 2),
(2, 2, 4),
(3, 3, 3),
(4, 4, 1),
(5, 5, 7),
(6, 6, 5),
(7, 7, 6),
(8, 8, 9),
(9, 9, 8),
(10, 10, 10),
(11, 11, 3),
(12, 12, 4),
(13, 13, 3);

-- --------------------------------------------------------

--
-- Table structure for table `uyg_kategori`
--

CREATE TABLE `uyg_kategori` (
  `Uyg_Kategori_ID` int(11) NOT NULL,
  `Uygulama_ID` int(11) DEFAULT NULL,
  `Kategori_Bilg_ID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_turkish_ci;

--
-- Dumping data for table `uyg_kategori`
--

INSERT INTO `uyg_kategori` (`Uyg_Kategori_ID`, `Uygulama_ID`, `Kategori_Bilg_ID`) VALUES
(1, 1, 5),
(2, 2, 1),
(3, 3, 1),
(4, 4, 8),
(5, 5, 3),
(6, 6, 8),
(7, 7, 1),
(8, 8, 7),
(9, 9, 2),
(10, 10, 4);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `degistirilen_tarih`
--
ALTER TABLE `degistirilen_tarih`
  ADD PRIMARY KEY (`İndirme_ID`);

--
-- Indexes for table `eklenen_uygulamalar`
--
ALTER TABLE `eklenen_uygulamalar`
  ADD PRIMARY KEY (`Eklenen_Uygulamalar`);

--
-- Indexes for table `geri_bildirim`
--
ALTER TABLE `geri_bildirim`
  ADD PRIMARY KEY (`Geri_Bild_ID`),
  ADD KEY `Kullanıcı_ID` (`Kullanıcı_ID`);

--
-- Indexes for table `indirme_istatiskleri`
--
ALTER TABLE `indirme_istatiskleri`
  ADD PRIMARY KEY (`İndirme_ID`),
  ADD KEY `Kullanıcı_ID` (`Kullanıcı_ID`),
  ADD KEY `Uygulama_ID` (`Uygulama_ID`);

--
-- Indexes for table `kategori_bilgileri`
--
ALTER TABLE `kategori_bilgileri`
  ADD PRIMARY KEY (`Kategori_Bilg_ID`);

--
-- Indexes for table `kullanıcılar`
--
ALTER TABLE `kullanıcılar`
  ADD PRIMARY KEY (`Kullanıcı_ID`);

--
-- Indexes for table `kul_uyg`
--
ALTER TABLE `kul_uyg`
  ADD PRIMARY KEY (`Kul_Uyg_ID`),
  ADD KEY `Kullanıcı_ID` (`Kullanıcı_ID`),
  ADD KEY `Uygulama_ID` (`Uygulama_ID`);

--
-- Indexes for table `silinen_kullanıcılar`
--
ALTER TABLE `silinen_kullanıcılar`
  ADD PRIMARY KEY (`Silinen_Kullanıcılar_ID`);

--
-- Indexes for table `uygulamalar`
--
ALTER TABLE `uygulamalar`
  ADD PRIMARY KEY (`Uygulama_ID`);

--
-- Indexes for table `uyg_geri_bild`
--
ALTER TABLE `uyg_geri_bild`
  ADD PRIMARY KEY (`Uyg_Geri_Bild_ID`),
  ADD KEY `Geri_Bild_ID` (`Geri_Bild_ID`),
  ADD KEY `Uygulama_ID` (`Uygulama_ID`);

--
-- Indexes for table `uyg_kategori`
--
ALTER TABLE `uyg_kategori`
  ADD PRIMARY KEY (`Uyg_Kategori_ID`),
  ADD KEY `Uygulama_ID` (`Uygulama_ID`),
  ADD KEY `Kategori_bilg_ID` (`Kategori_Bilg_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `degistirilen_tarih`
--
ALTER TABLE `degistirilen_tarih`
  MODIFY `İndirme_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `eklenen_uygulamalar`
--
ALTER TABLE `eklenen_uygulamalar`
  MODIFY `Eklenen_Uygulamalar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `geri_bildirim`
--
ALTER TABLE `geri_bildirim`
  MODIFY `Geri_Bild_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `indirme_istatiskleri`
--
ALTER TABLE `indirme_istatiskleri`
  MODIFY `İndirme_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `kategori_bilgileri`
--
ALTER TABLE `kategori_bilgileri`
  MODIFY `Kategori_Bilg_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `kullanıcılar`
--
ALTER TABLE `kullanıcılar`
  MODIFY `Kullanıcı_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `kul_uyg`
--
ALTER TABLE `kul_uyg`
  MODIFY `Kul_Uyg_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `silinen_kullanıcılar`
--
ALTER TABLE `silinen_kullanıcılar`
  MODIFY `Silinen_Kullanıcılar_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `uygulamalar`
--
ALTER TABLE `uygulamalar`
  MODIFY `Uygulama_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `uyg_geri_bild`
--
ALTER TABLE `uyg_geri_bild`
  MODIFY `Uyg_Geri_Bild_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `uyg_kategori`
--
ALTER TABLE `uyg_kategori`
  MODIFY `Uyg_Kategori_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `geri_bildirim`
--
ALTER TABLE `geri_bildirim`
  ADD CONSTRAINT `geri_bildirim_ibfk_1` FOREIGN KEY (`Kullanıcı_ID`) REFERENCES `kullanıcılar` (`Kullanıcı_ID`);

--
-- Constraints for table `indirme_istatiskleri`
--
ALTER TABLE `indirme_istatiskleri`
  ADD CONSTRAINT `indirme_istatiskleri_ibfk_1` FOREIGN KEY (`Kullanıcı_ID`) REFERENCES `kullanıcılar` (`Kullanıcı_ID`),
  ADD CONSTRAINT `indirme_istatiskleri_ibfk_2` FOREIGN KEY (`Uygulama_ID`) REFERENCES `uygulamalar` (`Uygulama_ID`);

--
-- Constraints for table `kul_uyg`
--
ALTER TABLE `kul_uyg`
  ADD CONSTRAINT `kul_uyg_ibfk_1` FOREIGN KEY (`Kullanıcı_ID`) REFERENCES `kullanıcılar` (`Kullanıcı_ID`),
  ADD CONSTRAINT `kul_uyg_ibfk_2` FOREIGN KEY (`Uygulama_ID`) REFERENCES `uygulamalar` (`Uygulama_ID`);

--
-- Constraints for table `uyg_geri_bild`
--
ALTER TABLE `uyg_geri_bild`
  ADD CONSTRAINT `uyg_geri_bild_ibfk_1` FOREIGN KEY (`Geri_Bild_ID`) REFERENCES `geri_bildirim` (`Geri_Bild_ID`),
  ADD CONSTRAINT `uyg_geri_bild_ibfk_2` FOREIGN KEY (`Uygulama_ID`) REFERENCES `uygulamalar` (`Uygulama_ID`);

--
-- Constraints for table `uyg_kategori`
--
ALTER TABLE `uyg_kategori`
  ADD CONSTRAINT `uyg_kategori_ibfk_1` FOREIGN KEY (`Uygulama_ID`) REFERENCES `uygulamalar` (`Uygulama_ID`),
  ADD CONSTRAINT `uyg_kategori_ibfk_2` FOREIGN KEY (`Kategori_Bilg_ID`) REFERENCES `kategori_bilgileri` (`Kategori_Bilg_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
