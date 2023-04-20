-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 31-03-2023 a las 17:59:21
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `tickbq`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `td_ticketdetalle`
--

CREATE TABLE `td_ticketdetalle` (
  `tickd_id` int(11) NOT NULL,
  `tick_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `tickd_descrip` mediumtext NOT NULL,
  `fech_crea` datetime NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `td_ticketdetalle`
--

INSERT INTO `td_ticketdetalle` (`tickd_id`, `tick_id`, `usu_id`, `tickd_descrip`, `fech_crea`, `est`) VALUES
(1, 1, 3, 'Te respondo', '2023-01-11 18:11:41', 1),
(2, 1, 1, 'Usuario respondiendo', '2023-01-11 11:12:17', 1),
(3, 1, 3, 'Resolución', '2023-01-11 18:12:44', 1),
(4, 1, 1, 'Gracias', '2023-01-11 18:13:11', 1),
(5, 1, 3, 'Favor de cerrar ticket', '2023-01-11 18:13:57', 1),
(6, 1, 3, 'Duplicado', '2023-01-11 18:13:57', 1),
(7, 1, 1, 'Duplicado', '2023-01-11 18:13:11', 1),
(8, 1, 1, 'Duplicado 2', '2023-01-11 18:13:11', 1),
(9, 2, 3, 'Hola', '2023-01-11 18:11:41', 1),
(10, 2, 1, 'Adios', '2023-01-11 18:13:11', 1),
(11, 1, 1, 'Test', '2023-03-01 18:51:17', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_categoria`
--

CREATE TABLE `tm_categoria` (
  `cat_id` int(11) NOT NULL,
  `cat_nom` varchar(150) NOT NULL,
  `est` int(11) NOT NULL,
  `resolutor` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_categoria`
--

INSERT INTO `tm_categoria` (`cat_id`, `cat_nom`, `est`, `resolutor`) VALUES
(1, 'Contrato', 1, 'Dulce Mendoza'),
(2, 'Dudas y Aclaraciones', 1, 'Katia Aguilar'),
(3, 'Cancelaciones', 1, 'Katia Aguilar Flores'),
(4, 'Convenios', 0, 'Katia Aguilar'),
(5, 'Recesion ', 0, 'Katia');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_subcategoria`
--

CREATE TABLE `tm_subcategoria` (
  `subcat_id` int(11) NOT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `subcat_nom` varchar(150) NOT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tm_subcategoria`
--

INSERT INTO `tm_subcategoria` (`subcat_id`, `cat_id`, `subcat_nom`, `est`) VALUES
(1, 1, 'Entregado al cliente', 1),
(2, 1, 'Firmado por RL', 1),
(3, 1, 'Entregado por Medio de Paquetería', 1),
(4, 2, 'Estado de cuenta', 1),
(5, 2, 'Recibos de pago', 1),
(6, 2, 'Facturas', 1),
(7, 2, 'Avances de Obra', 1),
(8, 2, 'Entregas', 1),
(9, 2, 'Otras', 1),
(10, 3, 'Sin contrato', 1),
(11, 3, 'Con contrato', 1),
(12, 4, 'Modificatorios (Error Nombre, Numero, sin cobro)', 0),
(13, 4, 'Traspasos', 0),
(14, 4, 'Cesión de Derechos – Restructuracion', 0),
(15, 4, 'Saldo Insolutos o Vencidos', 0),
(16, 4, 'restructuración de contrato', 0),
(17, 5, 'Dejar de Pagar Mensualidades', 0),
(18, 2, 'Recision de Contrato (Convenio de Terminación Anticipada)', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_ticket`
--

CREATE TABLE `tm_ticket` (
  `tick_id` int(11) NOT NULL,
  `usu_id` int(11) NOT NULL,
  `cat_id` int(11) NOT NULL,
  `subcat_id` int(11) NOT NULL,
  `tick_titulo` varchar(250) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `area` varchar(50) NOT NULL,
  `tick_descrip` varchar(9000) NOT NULL,
  `mesa` varchar(150) DEFAULT NULL,
  `tick_estado` varchar(15) DEFAULT NULL,
  `fech_crea` datetime DEFAULT NULL,
  `resolutor` varchar(50) DEFAULT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tm_usuario`
--

CREATE TABLE `tm_usuario` (
  `usu_id` int(11) NOT NULL,
  `usu_nom` varchar(150) DEFAULT NULL,
  `usu_ape` varchar(150) DEFAULT NULL,
  `usu_correo` varchar(150) NOT NULL,
  `usu_pass` varchar(29) NOT NULL,
  `rol_id` int(11) DEFAULT NULL,
  `fecha_crea` datetime DEFAULT NULL,
  `fecha_modi` datetime DEFAULT NULL,
  `fecha_eli` datetime DEFAULT NULL,
  `est` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci COMMENT='Tabla Mantenedor de Usuarios';

--
-- Volcado de datos para la tabla `tm_usuario`
--

INSERT INTO `tm_usuario` (`usu_id`, `usu_nom`, `usu_ape`, `usu_correo`, `usu_pass`, `rol_id`, `fecha_crea`, `fecha_modi`, `fecha_eli`, `est`) VALUES
(1, 'root', 'master', 'admin@clientes.com', '123456', 1, '2022-12-20 14:08:44', NULL, NULL, 1),
(2, 'root2', 'super', 'admi2@clientes.com', '123456', 2, '2022-12-20 14:08:44', NULL, NULL, 1),
(4, 'root3', 'promedio', 'usuario@cliente.com', '12345678', 3, '2023-03-22 08:44:39', NULL, NULL, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `td_ticketdetalle`
--
ALTER TABLE `td_ticketdetalle`
  ADD PRIMARY KEY (`tickd_id`);

--
-- Indices de la tabla `tm_categoria`
--
ALTER TABLE `tm_categoria`
  ADD PRIMARY KEY (`cat_id`);

--
-- Indices de la tabla `tm_subcategoria`
--
ALTER TABLE `tm_subcategoria`
  ADD PRIMARY KEY (`subcat_id`);

--
-- Indices de la tabla `tm_ticket`
--
ALTER TABLE `tm_ticket`
  ADD PRIMARY KEY (`tick_id`);

--
-- Indices de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  ADD PRIMARY KEY (`usu_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `td_ticketdetalle`
--
ALTER TABLE `td_ticketdetalle`
  MODIFY `tickd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `tm_categoria`
--
ALTER TABLE `tm_categoria`
  MODIFY `cat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `tm_subcategoria`
--
ALTER TABLE `tm_subcategoria`
  MODIFY `subcat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `tm_ticket`
--
ALTER TABLE `tm_ticket`
  MODIFY `tick_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tm_usuario`
--
ALTER TABLE `tm_usuario`
  MODIFY `usu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
