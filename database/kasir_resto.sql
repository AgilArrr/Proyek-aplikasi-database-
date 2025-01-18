-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 18, 2025 at 01:49 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kasir_resto`
--

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `ID_MENU` int NOT NULL,
  `NAME` varchar(50) NOT NULL,
  `CATEGORY` enum('makanan','minuman','lainnya') NOT NULL,
  `PRICE` decimal(10,2) NOT NULL,
  `CREATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`ID_MENU`, `NAME`, `CATEGORY`, `PRICE`, `CREATED_AT`) VALUES
(1, 'Nasi Goreng', 'makanan', '20000.00', '2025-01-18 01:45:52'),
(2, 'Ayam Bakar', 'makanan', '25000.00', '2025-01-18 01:45:52'),
(3, 'Es Teh Manis', 'minuman', '5000.00', '2025-01-18 01:45:52'),
(4, 'Es Jeruk', 'minuman', '7000.00', '2025-01-18 01:45:52'),
(5, 'Kerupuk', 'lainnya', '2000.00', '2025-01-18 01:45:52');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `ID_ORDER` int NOT NULL,
  `ID_USER` int NOT NULL,
  `ORDER_CODE` varchar(20) NOT NULL,
  `TOTAL_PRICE` decimal(10,2) NOT NULL,
  `PAYMENT_STATUS` enum('pending','paid') NOT NULL,
  `CREATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `ID` int NOT NULL,
  `ID_MENU` int NOT NULL,
  `ID_ORDER` int NOT NULL,
  `QUANTITY` int NOT NULL,
  `SUBTOTAL_PRICE` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID_USER` int NOT NULL,
  `USERNAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(255) NOT NULL,
  `ROLE` enum('admin','kasir') NOT NULL,
  `CREATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID_USER`, `USERNAME`, `PASSWORD`, `ROLE`, `CREATED_AT`) VALUES
(1, 'admin1', 'admin123', 'admin', '2025-01-18 01:46:12'),
(2, 'kasir1', 'kasir123', 'kasir', '2025-01-18 01:46:12'),
(3, 'kasir2', 'kasir456', 'kasir', '2025-01-18 01:46:12');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`ID_MENU`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`ID_ORDER`),
  ADD UNIQUE KEY `ORDER_CODE` (`ORDER_CODE`),
  ADD KEY `FK_ORDERS_USER` (`ID_USER`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_ORDER_ITEMS_ORDER` (`ID_ORDER`),
  ADD KEY `FK_ORDER_ITEMS_MENU` (`ID_MENU`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID_USER`),
  ADD UNIQUE KEY `USERNAME` (`USERNAME`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `ID_MENU` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `ID_ORDER` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `ID` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID_USER` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `FK_ORDERS_USER` FOREIGN KEY (`ID_USER`) REFERENCES `users` (`ID_USER`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `FK_ORDER_ITEMS_MENU` FOREIGN KEY (`ID_MENU`) REFERENCES `menu` (`ID_MENU`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `FK_ORDER_ITEMS_ORDER` FOREIGN KEY (`ID_ORDER`) REFERENCES `orders` (`ID_ORDER`) ON DELETE RESTRICT ON UPDATE RESTRICT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
