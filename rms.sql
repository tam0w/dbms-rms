-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 17, 2023 at 05:22 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.0.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rms`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `passw` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `email`, `passw`) VALUES
(1, 'tammu1000@gmail.com', 'abcd'),
(3, 'nadheefahmed@gmail.com', 'test'),
(4, 'wtwtuw@gmail.com', 'abcd'),
(111, 'farvath@gmail.com', '1234'),
(230, 'fawazahmed@gmail.com', 'abcd'),
(241, 'sahil@gmail.com', 'test'),
(386, 'fawazahmedd@gmail.com', '1234'),
(631, 'fawazahmed@gmail.com', 'tata'),
(672, 'brihithshenoy@gmail.com', 'fortnite'),
(714, 'nima@gmail.com', 'abcd'),
(839, 'tammu1000@gmail.com', '3423');

-- --------------------------------------------------------

--
-- Table structure for table `agents`
--

CREATE TABLE `agents` (
  `A_ID` int(11) NOT NULL,
  `A_NAME` varchar(10) NOT NULL,
  `A_ADDRESS` varchar(20) DEFAULT NULL,
  `A_PHNO` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `agents`
--

INSERT INTO `agents` (`A_ID`, `A_NAME`, `A_ADDRESS`, `A_PHNO`) VALUES
(1, 'Tamim', 'Bkt', '93808'),
(3, 'Nadheef', 'gthgt', '565464'),
(111, 'Farvath Ad', 'Attavar', '9380890030'),
(230, 'Fawaz', 'Attavar', '9380890067'),
(714, 'nima', 'ghfht', '758765675');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `C_ID` int(10) NOT NULL,
  `C_NAME` varchar(20) NOT NULL,
  `C_ADDRESS` varchar(20) DEFAULT NULL,
  `C_AGE` int(11) NOT NULL,
  `C_PHNO` varchar(10) NOT NULL,
  `C_EMAIL` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`C_ID`, `C_NAME`, `C_ADDRESS`, `C_AGE`, `C_PHNO`, `C_EMAIL`) VALUES
(241, 'Sahil', 'Mangalore', 21, '4343567788', 'sahil@gmail.com'),
(386, 'Fawaz', 'Attavar', 45, '23', 'fawazahmedd@gmail.co'),
(631, 'Fawaz', 'Attavar', 32, '9380890023', 'fawazahmed@gmail.com'),
(672, 'Brihith', 'Balmatta', 20, '9380890023', 'brihithshenoy@gmail.'),
(839, 'TEST', 'Tamim', 23, '23', 'tammu1000@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `owner`
--

CREATE TABLE `owner` (
  `O_ID` int(11) NOT NULL,
  `O_NAME` varchar(20) NOT NULL,
  `O_PHNO` varchar(10) NOT NULL,
  `O_ADDRESS` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `owner`
--

INSERT INTO `owner` (`O_ID`, `O_NAME`, `O_PHNO`, `O_ADDRESS`) VALUES
(1, 'Tamim', '93808', 'Bikt'),
(3, 'Nadheef', '456464', 'BIKARNAATTE'),
(241, 'Sahil', '4343567788', 'Mangalore'),
(386, 'Fawaz', '23', 'Attavar'),
(631, 'Fawaz', '9380890023', 'Attavar'),
(672, 'Brihith', '9380890023', 'Balmatta'),
(839, 'TEST', '23', 'Tamim');

-- --------------------------------------------------------

--
-- Table structure for table `property`
--

CREATE TABLE `property` (
  `P_ID` int(11) NOT NULL,
  `P_NAME` varchar(10) NOT NULL,
  `P_TYPE` varchar(10) NOT NULL,
  `P_SQFT` int(11) NOT NULL,
  `P_BHK` int(11) NOT NULL,
  `P_LOC` varchar(10) NOT NULL,
  `O_ID` int(11) NOT NULL,
  `A_ID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `property`
--

INSERT INTO `property` (`P_ID`, `P_NAME`, `P_TYPE`, `P_SQFT`, `P_BHK`, `P_LOC`, `O_ID`, `A_ID`) VALUES
(50, 'Ivory Towe', 'Flat', 1400, 3, 'Attavar', 0, 1),
(51, 'Al Falah', 'Flat', 678, 34, 'tbf', 3, 1),
(82, 'Ivory Towe', 'Flat', 1400, 3, 'Attavar', 0, 1),
(233, 'ta', 'Flat', 3432, 5, 'ewrfew', 1, 1),
(250, 'Muadh', 'Villa', 3000, 2, 'Bikarnakat', 0, 0),
(504, 'Al Falah', 'Villa', 2500, 4, 'Bikarnakat', 0, 1),
(557, 'pROP1', 'Flat', 43, 3, 'RPO', 1, 1),
(616, 'Kodi', 'Villa', 4000, 5, 'Adyar', 3, 1),
(673, 'Al Falah', 'Flat', 5436, 5, 'gfeg', 3, 1),
(703, 'Al Falah', 'Flat', 3, 3, 'et', 1, 1),
(752, 'Al Falah', 'Flat', 678, 34, 'tbf', 3, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `agents`
--
ALTER TABLE `agents`
  ADD PRIMARY KEY (`A_ID`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`C_ID`);

--
-- Indexes for table `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`O_ID`);

--
-- Indexes for table `property`
--
ALTER TABLE `property`
  ADD PRIMARY KEY (`P_ID`),
  ADD KEY `A_ID` (`A_ID`),
  ADD KEY `O_ID` (`O_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=840;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `C_ID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=840;

--
-- AUTO_INCREMENT for table `property`
--
ALTER TABLE `property`
  MODIFY `P_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=963;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agents`
--
ALTER TABLE `agents`
  ADD CONSTRAINT `agents_ibfk_1` FOREIGN KEY (`A_ID`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `clients`
--
ALTER TABLE `clients`
  ADD CONSTRAINT `clients_ibfk_1` FOREIGN KEY (`C_ID`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `owner`
--
ALTER TABLE `owner`
  ADD CONSTRAINT `owner_ibfk_1` FOREIGN KEY (`O_ID`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `property`
--
ALTER TABLE `property`
  ADD CONSTRAINT `property_ibfk_1` FOREIGN KEY (`A_ID`) REFERENCES `agents` (`A_ID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `property_ibfk_2` FOREIGN KEY (`O_ID`) REFERENCES `owner` (`O_ID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
