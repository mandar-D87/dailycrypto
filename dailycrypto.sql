-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 18, 2020 at 09:54 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dailycrypto`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `srno` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`srno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(11, 'mandar', 'mdman2257@gmail.com', '9167949688', 'hi,\r\nneed advice', '2020-10-18 13:09:58'),
(12, 'siddhi', 'sid.des@mindg.com', '9191916767', 'hi,\r\nneed investment advice', '2020-10-18 13:11:10');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `srno` int(11) NOT NULL,
  `img` varchar(50) DEFAULT NULL,
  `title` text NOT NULL,
  `slug` varchar(1000) NOT NULL,
  `content` text DEFAULT NULL,
  `posted_by` text DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`srno`, `img`, `title`, `slug`, `content`, `posted_by`, `date`) VALUES
(151, NULL, 'Analytics Firm: 200,000 Bitcoin is Currently Locked Within OKEx’s Wallets', 'https://bitcoinist.com/analytics-firm-200000-bitcoin-is-currently-locked-within-okexs-wallets/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:38'),
(152, NULL, 'Macro Strength: Bitcoin’s Price Moves Higher Despite Plethora of Bad News', 'https://bitcoinist.com/macro-strength-bitcoins-price-moves-higher-despite-plethora-of-bad-news/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:38'),
(153, NULL, 'Google Finance Now Lists Bitcoin First Ahead Of Top Forex Currencies', 'https://bitcoinist.com/google-finance-now-lists-bitcoin-first-ahead-of-top-forex-currencies/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:38'),
(154, NULL, 'Bitcoin on Way for Weekly Loss on Fading Stimulus Hopes', 'https://bitcoinist.com/bitcoin-on-way-for-weekly-loss-on-fading-stimulus-hopes/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:39'),
(155, NULL, 'Here’s Why One Analyst Expects Bitcoin to Surge Towards $12,000', 'https://bitcoinist.com/heres-why-one-analyst-expects-bitcoin-to-surge-towards-12000/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:39'),
(156, NULL, 'Bitcoin is Hovering Above a Crucial Level; Here’s What to Watch For', 'https://bitcoinist.com/bitcoin-is-hovering-above-a-crucial-level-heres-what-to-watch-for/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:39'),
(157, NULL, 'This Ongoing Bitcoin Wallet Hack Has Stolen $22 Million In BTC', 'https://bitcoinist.com/this-ongoing-bitcoin-wallet-hack-has-stolen-22-million-in-btc/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:39'),
(158, NULL, 'Macro Investor Sees Bitcoin Supply Deficit as Grayscale Boosts Stockpiling', 'https://bitcoinist.com/macro-investor-sees-bitcoin-supply-deficit-as-grayscale-boosts-stockpiling/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:39'),
(159, NULL, 'Here’s How High Bitcoin May Rally Before Losing Steam', 'https://bitcoinist.com/heres-how-high-bitcoin-may-rally-before-losing-steam/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:39'),
(160, NULL, 'Bitcoin Will Move Like a “Bulldozer” Once It Gains Momentum, Claims Analyst', 'https://bitcoinist.com/bitcoin-will-move-like-a-bulldozer-once-it-gains-momentum-claims-analyst/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:39'),
(161, NULL, 'Supply Shock: Lost Or Held Bitcoin Are Now Outpacing New Circulating Coins', 'https://bitcoinist.com/supply-shock-lost-or-held-bitcoin-are-now-outpacing-new-circulating-coins/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:39'),
(162, NULL, 'Troubles for Bitcoin as Hedge Funds Bet Against Stock Market Winners', 'https://bitcoinist.com/troubles-for-bitcoin-as-hedge-funds-bet-against-stock-market-winners/', NULL, 'Bitcoinist_News', '2020-10-17 14:29:39'),
(164, NULL, 'Analyst: Bitcoin Would Rocket to $20k if It Were to Breakout Today', 'https://bitcoinist.com/analyst-bitcoin-would-rocket-to-20k-if-it-were-to-breakout-today/', NULL, 'Bitcoinist_News', '2020-10-19 00:59:37'),
(165, NULL, 'Bitcoin May Plunge in Q4 Due to a Tax-Induced Selling Frenzy', 'https://bitcoinist.com/bitcoin-may-plunge-in-q4-due-to-a-tax-induced-selling-frenzy/', NULL, 'Bitcoinist_News', '2020-10-19 00:59:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`srno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`srno`),
  ADD UNIQUE KEY `title` (`title`) USING HASH,
  ADD UNIQUE KEY `title_2` (`title`) USING HASH,
  ADD UNIQUE KEY `title_3` (`title`) USING HASH;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `srno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `srno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=168;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
