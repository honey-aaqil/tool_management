-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 01, 2026 at 06:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tool_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_email` varchar(255) DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `details` text DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `audit_logs`
--

INSERT INTO `audit_logs` (`id`, `user_id`, `user_email`, `action`, `details`, `ip_address`, `user_agent`, `created_at`) VALUES
(1, NULL, 'admin@example.com', 'login_attempt', '{\"email\":\"admin@example.com\",\"success\":false,\"reason\":\"Invalid password\"}', '::1', 'curl/8.18.0', '2026-04-21 14:15:24'),
(2, 1, 'admin@example.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 14:15:44'),
(3, 1, 'admin@example.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 14:16:13'),
(4, 1, 'admin@example.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 14:16:43'),
(5, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 14:19:45'),
(6, NULL, 'javid.j@vdartinc.com', 'login_attempt', '{\"email\":\"javid.j@vdartinc.com\",\"success\":false,\"reason\":\"Invalid password\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:21:40'),
(7, NULL, 'javid.j@vdartinc.com', 'login_attempt', '{\"email\":\"javid.j@vdartinc.com\",\"success\":false,\"reason\":\"Invalid password\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:21:48'),
(8, NULL, 'javid.j@vdartinc.com', 'login_attempt', '{\"email\":\"javid.j@vdartinc.com\",\"success\":false,\"reason\":\"Invalid password\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:21:54'),
(9, NULL, 'javid.j@vdartinc.com', 'login_attempt', '{\"email\":\"javid.j@vdartinc.com\",\"success\":false,\"reason\":\"Invalid password\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:21:56'),
(10, NULL, 'venghadakrishnan.t@vdartinc.com', 'login_attempt', '{\"email\":\"venghadakrishnan.t@vdartinc.com\",\"success\":false,\"reason\":\"Invalid password\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:23:24'),
(11, 6, 'venghadakrishnan.t@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:23:31'),
(12, 6, 'venghadakrishnan.t@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:25:46'),
(13, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:30:43'),
(14, 3, 'Javid J', 'tool_deleted', '{\"tool_id\":2,\"tool_name\":\"Indeed\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:31:42'),
(15, 3, 'javid.j@vdartinc.com', 'tool_restored', '{\"tool_id\":2,\"tool_name\":\"Indeed\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:31:48'),
(16, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 14:36:04'),
(17, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 14:38:43'),
(18, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 14:49:23'),
(19, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:18:02'),
(20, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:18:20'),
(21, 8, 'ashok.thirumalaisamy@vdartdigital.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:20:24'),
(22, 8, 'ashok.thirumalaisamy@vdartdigital.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:28:51'),
(23, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:30:11'),
(24, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:38:59'),
(25, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 15:39:59'),
(26, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 16:11:07'),
(27, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 16:11:27'),
(28, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 16:12:27'),
(29, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 16:12:40'),
(30, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":5,\"tool_name\":\"CareerBuilder\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 16:24:03'),
(31, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 16:31:19'),
(32, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 16:34:46'),
(33, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 16:36:01'),
(34, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 16:37:57'),
(35, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 16:38:04'),
(36, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 16:39:27'),
(37, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'curl/8.18.0', '2026-04-21 16:41:15'),
(38, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":7,\"tool_name\":\"Direct Test\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 16:48:33'),
(39, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":7,\"tool_name\":\"Direct Test\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 16:49:16'),
(40, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":7,\"tool_name\":\"linkedin\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 16:59:50'),
(41, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":6,\"tool_name\":\"Ceipal\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 17:03:27'),
(42, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":5,\"tool_name\":\"CareerBuilder\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 17:05:27'),
(43, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":4,\"tool_name\":\"ZipRecruiter\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 17:11:47'),
(44, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":6,\"tool_name\":\"indeed\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 17:12:40'),
(45, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":6,\"tool_name\":\"indeed\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 17:12:54'),
(46, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":6,\"tool_name\":\"Indeed\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 17:13:24'),
(47, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 17:15:40'),
(48, 8, 'ashok.thirumalaisamy@vdartdigital.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-21 17:16:17'),
(49, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 12:59:07'),
(50, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":5,\"tool_name\":\"CareerBuilder\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 13:15:39'),
(51, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":3,\"tool_name\":\"Monster\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 13:20:45'),
(52, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":2,\"tool_name\":\"Indeed\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 13:24:44'),
(53, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":3,\"tool_name\":\"Monster\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 13:25:48'),
(54, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":1,\"tool_name\":\"LinkedIn Recruiter\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 13:29:55'),
(55, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":1,\"tool_name\":\"LinkedIn Recruiter\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 13:31:40'),
(56, 3, 'javid.j@vdartinc.com', 'tool_updated', '{\"tool_id\":1,\"tool_name\":\"LinkedIn Recruiter\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 13:39:26'),
(57, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 14:30:52'),
(58, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 14:31:42'),
(59, 3, 'javid.j@vdartinc.com', 'password_reset_initiated', '{\"target_user_id\":5,\"target_user_email\":\"deepan.m@vdartinc.com\",\"initiated_by\":\"javid.j@vdartinc.com\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-27 16:04:53'),
(60, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 13:12:29'),
(61, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 14:24:59'),
(62, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 15:23:28'),
(63, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 15:23:38'),
(64, NULL, 'javid.j@vdartinc.com', 'login_attempt', '{\"email\":\"javid.j@vdartinc.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 15:23:49'),
(65, NULL, 'javid.j@vdartinc.com', 'login_attempt', '{\"email\":\"javid.j@vdartinc.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 15:24:22'),
(66, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 15:24:31'),
(67, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 15:54:35'),
(68, NULL, 'venghadakrishnan.t@vdartinc.com', 'login_attempt', '{\"email\":\"venghadakrishnan.t@vdartinc.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:03:41'),
(69, NULL, 'venghadakrishnan.t@vdartinc.com', 'login_attempt', '{\"email\":\"venghadakrishnan.t@vdartinc.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:03:44'),
(70, NULL, 'venghadakrishnan.t@vdartinc.com', 'login_attempt', '{\"email\":\"venghadakrishnan.t@vdartinc.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:03:56'),
(71, NULL, 'venghadakrishnan.t@vdartinc.com', 'login_attempt', '{\"email\":\"venghadakrishnan.t@vdartinc.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:03:58'),
(72, NULL, 'venghadakrishnan.t@vdartinc.com', 'login_attempt', '{\"email\":\"venghadakrishnan.t@vdartinc.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:04:10'),
(73, NULL, 'ashok.thirumalaisamy@vdartdigital.com', 'login_attempt', '{\"email\":\"ashok.thirumalaisamy@vdartdigital.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:06:40'),
(74, NULL, 'ashok.thirumalaisamy@vdartdigital.com', 'login_attempt', '{\"email\":\"ashok.thirumalaisamy@vdartdigital.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:06:44'),
(75, NULL, 'ashok.thirumalaisamy@vdartdigital.com', 'login_attempt', '{\"email\":\"ashok.thirumalaisamy@vdartdigital.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:06:49'),
(76, 9, 'guru.prasad@vdartdigital.com', 'user_signup', '{\"email\":\"guru.prasad@vdartdigital.com\",\"name\":\"Guruprasad\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:09:42'),
(77, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:20:30'),
(78, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:21:12'),
(79, 10, 'guru.prasad@vdartdigital.com', 'user_signup', '{\"email\":\"guru.prasad@vdartdigital.com\",\"name\":\"Guruprasad\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:49:50'),
(80, 11, 'guru.prasad@vdartdigital.com', 'user_signup', '{\"email\":\"guru.prasad@vdartdigital.com\",\"name\":\"Guruprasad\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:50:01'),
(81, 12, 'guru.prasad@vdartdigital.com', 'user_signup', '{\"email\":\"guru.prasad@vdartdigital.com\",\"name\":\"Guru\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-28 16:54:59'),
(82, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:37:04'),
(83, 3, 'javid.j@vdartinc.com', 'email_settings_updated', '{\"smtp_host\":\"smtp.gmail.com\",\"from_email\":\"javid.j@vdartinc.com\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:38:17'),
(84, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:38:23'),
(85, 13, 'adeeb.m@vdartinc.com', 'user_signup', '{\"email\":\"adeeb.m@vdartinc.com\",\"name\":\"Adeeb\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:39:09'),
(86, 14, 'adeeb.m@vdartinc.com', 'user_signup', '{\"email\":\"adeeb.m@vdartinc.com\",\"name\":\"Adeeb\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:39:21'),
(87, 15, 'adeeb.m@vdartinc.com', 'user_signup', '{\"email\":\"adeeb.m@vdartinc.com\",\"name\":\"Adeeb\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:40:45'),
(88, NULL, 'adeeb.m@vdartinc.com', 'login_attempt', '{\"email\":\"adeeb.m@vdartinc.com\",\"success\":false,\"reason\":\"Invalid credentials\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:45:07'),
(89, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:45:40'),
(90, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:54:11'),
(91, 16, 'adeeb.m@vdartinc.com', 'user_signup', '{\"email\":\"adeeb.m@vdartinc.com\",\"name\":\"adeeb\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 13:54:27'),
(92, 17, 'adeeb.m@vdartinc.com', 'user_signup', '{\"email\":\"adeeb.m@vdartinc.com\",\"name\":\"adeeb\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 14:19:49'),
(93, 17, 'adeeb.m@vdartinc.com', 'otp_verified', '{\"email\":\"adeeb.m@vdartinc.com\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 14:21:56'),
(94, 17, 'adeeb.m@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 14:23:13'),
(95, 17, 'adeeb.m@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 14:24:29'),
(96, 18, 'guru.prasad@vdartdigital.com', 'user_signup', '{\"email\":\"guru.prasad@vdartdigital.com\",\"name\":\"Guru\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 14:25:27'),
(97, 18, 'guru.prasad@vdartdigital.com', 'otp_verified', '{\"email\":\"guru.prasad@vdartdigital.com\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 14:26:03'),
(98, 18, 'guru.prasad@vdartdigital.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 14:27:25'),
(99, 18, 'guru.prasad@vdartdigital.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 15:13:52'),
(100, 19, 'saranraj.s@vdartinc.com', 'user_signup', '{\"email\":\"saranraj.s@vdartinc.com\",\"name\":\"Saran\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 15:26:05'),
(101, 19, 'saranraj.s@vdartinc.com', 'otp_verified', '{\"email\":\"saranraj.s@vdartinc.com\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 15:28:47'),
(102, 19, 'saranraj.s@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 15:29:23'),
(103, 19, 'saranraj.s@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-04-30 15:46:43'),
(104, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 13:21:40'),
(105, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 13:22:06'),
(106, 19, 'saranraj.s@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 13:22:33'),
(107, 19, 'saranraj.s@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 13:24:20'),
(108, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 13:24:29'),
(109, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 14:26:03'),
(110, 19, 'saranraj.s@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 14:26:21'),
(111, 19, 'saranraj.s@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 14:26:48'),
(112, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 14:29:29'),
(113, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 15:24:25'),
(114, 19, 'saranraj.s@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 15:24:40'),
(115, 19, 'saranraj.s@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 15:25:19'),
(116, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 15:25:29'),
(117, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 15:28:16'),
(118, 20, 'ahmadhu.a@vdartinc.com', 'user_signup', '{\"email\":\"ahmadhu.a@vdartinc.com\",\"name\":\"Aaqil\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 15:30:10'),
(119, 20, 'ahmadhu.a@vdartinc.com', 'otp_verified', '{\"email\":\"ahmadhu.a@vdartinc.com\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 15:31:12'),
(120, 3, 'javid.j@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 15:35:22'),
(121, 3, 'javid.j@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 16:27:34'),
(122, 21, 'deepan.m@vdartinc.com', 'user_signup', '{\"email\":\"deepan.m@vdartinc.com\",\"name\":\"Deepan\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 16:28:22'),
(123, 21, 'deepan.m@vdartinc.com', 'otp_verified', '{\"email\":\"deepan.m@vdartinc.com\"}', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 16:29:10'),
(124, 21, 'deepan.m@vdartinc.com', 'login_success', 'User logged in', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 16:30:31'),
(125, 21, 'deepan.m@vdartinc.com', 'logout', 'User logged out', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36', '2026-05-01 16:32:05');

-- --------------------------------------------------------

--
-- Table structure for table `delete_logs`
--

CREATE TABLE `delete_logs` (
  `id` int(11) NOT NULL,
  `tool_id` int(11) NOT NULL,
  `tool_name` varchar(255) NOT NULL,
  `action_type` enum('soft_delete','permanent_delete','restore') NOT NULL,
  `deleted_by_id` int(11) DEFAULT NULL,
  `deleted_by_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `previous_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`previous_data`))
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `delete_logs`
--

INSERT INTO `delete_logs` (`id`, `tool_id`, `tool_name`, `action_type`, `deleted_by_id`, `deleted_by_name`, `created_at`, `previous_data`) VALUES
(1, 2, 'Indeed', 'soft_delete', 3, 'Javid J', '2026-04-21 14:31:42', '{\"id\":2,\"tool_name\":\"Indeed\",\"type\":\"Job Portal\",\"cost\":\"5000.00\",\"revenue\":\"8000.00\",\"geography\":\"INDIA\",\"status\":\"Active\"}'),
(2, 2, 'Indeed', 'restore', 3, 'Javid J', '2026-04-21 14:31:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `email_settings`
--

CREATE TABLE `email_settings` (
  `id` int(11) NOT NULL,
  `smtp_host` varchar(255) DEFAULT NULL,
  `smtp_port` int(11) DEFAULT 587,
  `smtp_username` varchar(255) DEFAULT NULL,
  `smtp_password_encrypted` text DEFAULT NULL,
  `smtp_password` text DEFAULT NULL,
  `from_email` varchar(255) DEFAULT NULL,
  `from_name` varchar(255) DEFAULT NULL,
  `notification_email` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `email_settings`
--

INSERT INTO `email_settings` (`id`, `smtp_host`, `smtp_port`, `smtp_username`, `smtp_password_encrypted`, `smtp_password`, `from_email`, `from_name`, `notification_email`, `created_at`, `updated_at`) VALUES
(1, 'smtp.gmail.com', 587, 'javid.j@vdartinc.com', 'WW8F8MhqqiGZUZaRNlcBhvLnhEGQGrBj+b17JV2220tOeVw08c2gb9UVbVWpbkTP', NULL, 'javid.j@vdartinc.com', 'Tool Management System', 'javid.j@vdartinc.com', '2026-04-21 13:31:59', '2026-04-30 15:14:35');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `password_reset_tokens`
--

INSERT INTO `password_reset_tokens` (`id`, `user_id`, `token`, `expires_at`, `used_at`, `created_at`) VALUES
(1, 5, '$2y$10$nEUsJhZj/MQeeIPqzBUAVuXEgIpsohny/nPbPFWZy11jc1dKmtJO.', '2026-04-27 19:04:48', NULL, '2026-04-27 16:04:48');

-- --------------------------------------------------------

--
-- Table structure for table `tools`
--

CREATE TABLE `tools` (
  `id` int(11) NOT NULL,
  `year` int(11) DEFAULT 2026,
  `tool_name` varchar(255) NOT NULL,
  `type` varchar(100) DEFAULT 'NA',
  `no_of_license` int(11) DEFAULT 1,
  `resume_views` int(11) DEFAULT 0,
  `job_slots` int(11) DEFAULT 0,
  `bulk_mail` int(11) DEFAULT 0,
  `cost` decimal(12,2) DEFAULT 0.00,
  `revenue` decimal(12,2) DEFAULT 0.00,
  `monthly_cost` decimal(12,2) DEFAULT 0.00,
  `quarterly_cost` decimal(12,2) DEFAULT 0.00,
  `annual_cost` decimal(12,2) DEFAULT 0.00,
  `currency` varchar(10) DEFAULT 'USD',
  `geography` varchar(50) DEFAULT 'USA',
  `payment_frequency` varchar(50) DEFAULT 'Monthly',
  `last_renewal` date DEFAULT NULL,
  `next_renewal` date DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `spoc_1` varchar(255) DEFAULT NULL,
  `spoc_2` varchar(255) DEFAULT NULL,
  `contact_no` varchar(50) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `reason_for_using` text DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tools`
--

INSERT INTO `tools` (`id`, `year`, `tool_name`, `type`, `no_of_license`, `resume_views`, `job_slots`, `bulk_mail`, `cost`, `revenue`, `monthly_cost`, `quarterly_cost`, `annual_cost`, `currency`, `geography`, `payment_frequency`, `last_renewal`, `next_renewal`, `comments`, `spoc_1`, `spoc_2`, `contact_no`, `email_id`, `status`, `reason_for_using`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 2026, 'LinkedIn Recruiter', 'Job Portal', 10, 205, 97, 11, 13456.00, 0.00, 3456.00, 95677.00, 32456.00, 'AED', 'DUBAI', 'Annual', '2025-05-24', '2026-04-30', 'asdfghjkl;poiuytrewqazxcvb', 'Ram', 'Abishek', '660 825-8527', 'javid.j@vdartinc.com', 'Active', 'wertyuiopolkjhgfdsazxcvbnm', NULL, '2026-04-21 13:31:59', '2026-04-27 13:39:26'),
(2, 2026, 'Indeed', 'Job Portal', 5, 60, 38, 0, 8000.00, 0.00, 4345.00, 5646.00, 23456.00, 'MYR', 'MALAYSIA', 'Annual', '2025-01-04', '2026-02-04', 'sdfghjkhgfdjhgfjhgfdjkhgf', 'Mohan Kumar', 'Abishek', '9876-4565-2345', 'deepan.m@vdartinc.com', 'Active', 'sdfghjkljuytrewtyuiklnbvfdghjklkjhgfd', NULL, '2026-04-21 13:31:59', '2026-04-27 13:24:44'),
(3, 2026, 'Monster', 'Job Portal', 36, 80, 53, 0, 7000.00, 0.00, 5678.00, 4567.00, 16544.00, 'CAD', 'CANADA', 'Monthly', '2024-03-21', '2025-02-22', 'kjhgfdsafghjk', 'Javith', 'ABDUL', '650 765-4567', 'javid.j@vdartinc.com', 'Active', 'chbjnklkjhgfdsfghjk', NULL, '2026-04-21 13:31:59', '2026-04-27 13:25:48'),
(4, 2026, 'ZipRecruiter', 'Job Portal', 3, 19, 9, 0, 2000.00, 3500.00, 2345.00, 4567.00, 34564.01, 'USD', 'USA', 'Monthly', '2024-06-13', '2025-07-15', 'sxcvgbhnjmk', 'Mohan Kumar', 'vijay', '650 765-4567', 'daniel@vdartinc.com', 'Inactive', 'asdefrtyuiofghyj', NULL, '2026-04-21 13:31:59', '2026-04-21 17:11:47'),
(5, 2026, 'CareerBuilder', 'Job Portal', 4, 57, 46, 0, 5000.00, 0.00, 4575.00, 6789.00, 10877.00, 'USD', 'USA', 'Monthly', '2025-11-18', '2026-12-04', 'wedfghjkljhg', 'Jaison', 'Abishek', '650 265-7573', 'jaison.a@vdartinc.com', 'Active', 'sdzfghjkhgfds', NULL, '2026-04-21 13:31:59', '2026-04-27 13:15:39'),
(6, 2026, 'Indeed', 'Job Portal', 15, 65, 25, 0, 60000.00, 0.00, 15000.00, 32000.00, 89000.00, 'INR', 'INDIA', 'Monthly', '2024-01-22', '2025-02-24', 'awsdfghjklkjhgfdsa', 'JAVITH', 'abdul', '650 265-7573', 'javid.j@vdartinc.com', 'Active', 'ASDFGHJKLLKJHGTFRDESW', NULL, '2026-04-21 16:35:24', '2026-04-21 17:13:24'),
(7, 2026, 'linkedin', 'Testing', 1, 50, 10, 100, 1000.00, 2000.00, 2345.00, 3456.00, 23364.00, 'USD', 'USA', 'Monthly', '2025-05-23', '2026-05-24', 'sdrftgyhujikjhgfdsa', 'Jaison', 'Abishek', '1234567890', 'jaison.a@vdartinc.com', 'Active', 'asdfghjkldfghjk', NULL, '2026-04-21 16:37:23', '2026-04-21 16:59:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `admin_access` tinyint(1) DEFAULT 0,
  `is_verified` tinyint(1) DEFAULT 1,
  `status` enum('Active','Inactive') DEFAULT 'Active',
  `failed_login_attempts` int(11) DEFAULT 0,
  `locked_until` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `verification_otp` varchar(255) DEFAULT NULL,
  `otp_expiry` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role`, `admin_access`, `is_verified`, `status`, `failed_login_attempts`, `locked_until`, `last_login_at`, `created_at`, `verification_otp`, `otp_expiry`) VALUES
(1, 'Admin', 'admin@example.com', '$2y$12$xwLgMyszeNEawxauE3/.Yu/FT4KxymVa7EfyYvlSqAMi8ZFGX.BBC', 'user', 0, 1, 'Active', 0, NULL, '2026-04-21 10:16:43', '2026-04-21 13:31:59', NULL, NULL),
(2, 'Test User', 'test@test.com', '$2y$12$xwLgMyszeNEawxauE3/.Yu/FT4KxymVa7EfyYvlSqAMi8ZFGX.BBC', 'user', 0, 1, 'Inactive', 0, NULL, NULL, '2026-04-21 13:31:59', NULL, NULL),
(3, 'Javid J', 'javid.j@vdartinc.com', '$2y$12$xwLgMyszeNEawxauE3/.Yu/FT4KxymVa7EfyYvlSqAMi8ZFGX.BBC', 'admin', 1, 1, 'Active', 0, NULL, '2026-05-01 11:35:22', '2026-04-21 13:31:59', NULL, NULL),
(4, 'Akab', 'akab@vdartinc.com', '$2y$12$xwLgMyszeNEawxauE3/.Yu/FT4KxymVa7EfyYvlSqAMi8ZFGX.BBC', 'user', 0, 1, 'Active', 0, NULL, NULL, '2026-04-21 13:31:59', NULL, NULL),
(6, 'Venghadakrishnan T', 'venghadakrishnan.t@vdartinc.com', '$2y$12$xwLgMyszeNEawxauE3/.Yu/FT4KxymVa7EfyYvlSqAMi8ZFGX.BBC', 'user', 0, 1, 'Active', 5, '2026-04-28 18:04:40', '2026-04-21 10:23:31', '2026-04-21 13:31:59', NULL, NULL),
(7, 'Vetr', 'vetr@12gmail.com', '$2y$12$xwLgMyszeNEawxauE3/.Yu/FT4KxymVa7EfyYvlSqAMi8ZFGX.BBC', 'user', 0, 1, 'Active', 0, NULL, NULL, '2026-04-21 13:31:59', NULL, NULL),
(8, 'Ashok', 'ashok.thirumalaisamy@vdartdigital.com', '$2y$12$gGDp48Bk4jjJoPsNnSXVy.tNyI1nLwUVYLcpC4sw6Ev2bhl.OBHC6', 'user', 0, 1, 'Active', 3, NULL, '2026-04-21 13:16:17', '2026-04-21 15:19:07', NULL, NULL),
(17, 'adeeb', 'adeeb.m@vdartinc.com', '$2y$12$5gdDarKy7ziTx0UnWlP4duyoLn0gnfunhow3u/sXiFbMbcDSOCz3O', 'user', 0, 1, 'Active', 0, NULL, '2026-04-30 10:23:13', '2026-04-30 14:19:49', NULL, NULL),
(18, 'Guru', 'guru.prasad@vdartdigital.com', '$2y$12$i4FmIieMbr6e.rxuEuFkjO.JFXvSfQnfGup/tX9ea54L4XxMXySs2', 'user', 0, 1, 'Active', 0, NULL, '2026-04-30 10:27:25', '2026-04-30 14:25:27', NULL, NULL),
(19, 'Saran', 'saranraj.s@vdartinc.com', '$2y$12$xn2Ka61M4NWoOniH7nyA4edLFOG0khmfj2WJX6unS/oCZYccTSwCq', 'user', 0, 1, 'Active', 0, NULL, '2026-05-01 11:24:40', '2026-04-30 15:26:05', NULL, NULL),
(20, 'Aaqil', 'ahmadhu.a@vdartinc.com', '$2y$12$s89wA4Fop0XN9VDOCfI58uHohfuv4Y1P.vZwC4hjRkQzcCQ3mFIYa', 'user', 0, 1, 'Active', 0, NULL, NULL, '2026-05-01 15:30:10', NULL, NULL),
(21, 'Deepan', 'deepan.m@vdartinc.com', '$2y$12$CMTE/PQCVG6sB.5ghMfcv.9jNhY2sJ15dM8BDtTxX8sqtpYFyGZP.', 'user', 0, 1, 'Active', 0, NULL, '2026-05-01 12:30:31', '2026-05-01 16:28:21', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delete_logs`
--
ALTER TABLE `delete_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_settings`
--
ALTER TABLE `email_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tools`
--
ALTER TABLE `tools`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `delete_logs`
--
ALTER TABLE `delete_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `email_settings`
--
ALTER TABLE `email_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tools`
--
ALTER TABLE `tools`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
