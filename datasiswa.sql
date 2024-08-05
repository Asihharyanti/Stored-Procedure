-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Agu 2024 pada 09.46
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `datasiswa`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSiswaByBorn` (IN `tempat_lahir_param` VARCHAR(255))   BEGIN
    SELECT *
    FROM datasiswa
    WHERE tempat_lahir = tempat_lahir_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `isiNilaiSiswa` (IN `p_nis` INT, IN `p_nilai_IPA` INT, IN `p_nilai_IPS` INT, IN `p_nilai_MATEMATIKA` INT)   BEGIN
    INSERT INTO nilaisiswa (nis, nilai_IPA, nilai_IPS, nilai_MATEMATIKA)
    VALUES (p_nis, p_nilai_IPA, p_nilai_IPS, p_nilai_MATEMATIKA);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `validSiswa` (IN `p_nis` INT, IN `p_nilai_IPA` INT, IN `p_nilai_IPS` INT, IN `p_nilai_MATEMATIKA` INT)   BEGIN
    DECLARE exit handler FOR SQLEXCEPTION
    BEGIN
        -- Jika terjadi kesalahan, rollback transaksi
        ROLLBACK;
    END;

    -- Mulai transaksi
    START TRANSACTION;

    -- Coba melakukan insert ke tabel nilaisiswa
    INSERT INTO nilaisiswa (nis, nilai_IPA, nilai_IPS, nilai_MATEMATIKA)
    VALUES (p_nis, p_nilai_IPA, p_nilai_IPS, p_nilai_MATEMATIKA);

    -- Jika tidak terjadi kesalahan, commit transaksi
    COMMIT;
END$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `getJmlByGender` (`gender_param` CHAR(1)) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE jumlah INT;
    
    SELECT COUNT(*) INTO jumlah
    FROM datasiswa
    WHERE gender = gender_param;
    
    RETURN jumlah;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `datasiswa`
--

CREATE TABLE `datasiswa` (
  `nis` int(255) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `tempat_lahir` varchar(255) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `gender` varchar(333) NOT NULL,
  `alamat` varchar(333) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `datasiswa`
--

INSERT INTO `datasiswa` (`nis`, `nama`, `tempat_lahir`, `tgl_lahir`, `gender`, `alamat`) VALUES
(89120, 'Fahmi', 'Asahan', '1983-07-12', 'L', 'Jl. Medan 17'),
(89121, 'Toni', 'Bogor', '1980-01-25', 'L', 'Jl. Medan 17Jl. Bogor 21'),
(89122, 'Mona', 'Jakarta', '1984-08-01', 'P', 'Jl. Danau Toba 34'),
(89123, 'Monika', 'Bandung', '1982-02-13', 'P', 'Jl.Samosir 39'),
(89124, 'Eno', 'Surabaya', '1984-04-01', 'L', 'Jl. Siantar 66'),
(89125, 'Fitri', 'Jakarta', '1983-08-01', 'P', 'Jl. Sei Rampah 45'),
(89126, 'Prima', 'Surabaya', '1985-06-12', 'P', 'Jl. Binjai 11'),
(89127, 'Hotdi', 'Bogor', '1983-09-01', 'L', 'Jl. Kartika 3'),
(89128, 'Yuni', 'Malang', '1984-10-18', 'P', 'Jl. Kisaran 56'),
(89129, 'Helni', 'Malang', '1985-11-21', 'P', 'Jl. Teladan 44');

--
-- Trigger `datasiswa`
--
DELIMITER $$
CREATE TRIGGER `sebelumHapusSiswa` BEFORE DELETE ON `datasiswa` FOR EACH ROW BEGIN
    INSERT INTO SiswaKeluar (nis, tgl_hapus)
    VALUES (OLD.nis, CURDATE());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `nilaisiswa`
--

CREATE TABLE `nilaisiswa` (
  `nis` int(255) NOT NULL,
  `nilai_IPA` int(210) NOT NULL,
  `nilai_IPS` int(210) NOT NULL,
  `nilai_MATEMATIKA` int(210) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `nilaisiswa`
--

INSERT INTO `nilaisiswa` (`nis`, `nilai_IPA`, `nilai_IPS`, `nilai_MATEMATIKA`) VALUES
(89129, 90, 100, 95),
(89122, 70, 60, 90),
(89123, 60, 60, 90),
(89124, 80, 50, 100),
(89125, 40, 60, 80),
(89126, 50, 65, 90),
(89127, 70, 80, 90),
(89128, 100, 60, 40),
(98123, 60, 60, 90),
(98123, 60, 60, 90),
(98123, 60, 60, 90),
(89130, 67, 55, 87),
(89131, 55, 80, 75),
(89131, 60, 55, 75);

-- --------------------------------------------------------

--
-- Struktur dari tabel `siswakeluar`
--

CREATE TABLE `siswakeluar` (
  `nis` int(11) NOT NULL,
  `tgl_hapus` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
