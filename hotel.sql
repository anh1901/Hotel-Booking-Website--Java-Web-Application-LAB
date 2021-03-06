USE [master]
GO
/****** Object:  Database [Hotel]    Script Date: 11/3/2020 7:09:48 AM ******/
CREATE DATABASE [Hotel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Hotel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Hotel.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Hotel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Hotel_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Hotel] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Hotel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Hotel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Hotel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Hotel] SET ARITHABORT OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Hotel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Hotel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Hotel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Hotel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Hotel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Hotel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Hotel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Hotel] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Hotel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Hotel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Hotel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Hotel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Hotel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Hotel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Hotel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Hotel] SET RECOVERY FULL 
GO
ALTER DATABASE [Hotel] SET  MULTI_USER 
GO
ALTER DATABASE [Hotel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Hotel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Hotel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Hotel] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Hotel] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Hotel', N'ON'
GO
USE [Hotel]
GO
/****** Object:  Table [dbo].[category]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[city]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[city](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[city_name] [nvarchar](100) NOT NULL,
	[postal_code] [nvarchar](100) NOT NULL,
	[country_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[country]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[country](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[country_name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[discount]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[discount](
	[id] [nvarchar](10) NOT NULL,
	[discount] [decimal](5, 2) NOT NULL,
	[status] [nvarchar](100) NOT NULL,
	[expire_date] [date] NOT NULL,
	[coupon_name] [nvarchar](255) NULL,
	[create_date] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[extra_bed]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[extra_bed](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[no_of_bed] [int] NULL,
	[extra_cost] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[feedback]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feedback](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[feedback] [nvarchar](255) NULL,
	[rating] [int] NULL,
	[room_id] [int] NULL,
	[user_email] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[hotel]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[hotel](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[hotel_name] [nvarchar](255) NOT NULL,
	[description] [nvarchar](500) NULL,
	[city_id] [int] NULL,
	[category_id] [int] NULL,
	[status] [nvarchar](50) NOT NULL,
	[photo] [nvarchar](255) NOT NULL,
	[average_rating] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[reservation]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reservation](
	[id] [nvarchar](255) NOT NULL,
	[user_email] [nvarchar](255) NULL,
	[ts_created] [datetime] NOT NULL,
	[discount_percent_id] [nvarchar](10) NULL,
	[total_price] [decimal](10, 2) NOT NULL,
	[status] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[roles]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[roles](
	[roleID] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[room]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[room](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[room_name] [nvarchar](100) NOT NULL,
	[description] [nvarchar](1000) NULL,
	[hotel_id] [int] NULL,
	[room_type_id] [int] NULL,
	[price] [decimal](10, 2) NOT NULL,
	[photo] [nvarchar](255) NOT NULL,
	[available_room] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[room_reserved]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[room_reserved](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[reservation_id] [nvarchar](255) NULL,
	[room_id] [int] NULL,
	[quantity] [int] NOT NULL,
	[price] [decimal](10, 2) NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[extra_bed_id] [int] NULL,
	[isFeedback] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[room_type]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[room_type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[type_name] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 11/3/2020 7:09:48 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[email] [nvarchar](255) NOT NULL,
	[username] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[role] [int] NOT NULL,
	[status] [nvarchar](100) NULL,
	[create_date] [datetime] NULL DEFAULT (getdate()),
	[phone] [int] NULL,
	[address] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[category] ON 

INSERT [dbo].[category] ([id], [category_name]) VALUES (1, N'Cheap hotel')
INSERT [dbo].[category] ([id], [category_name]) VALUES (2, N'Suite hotel')
INSERT [dbo].[category] ([id], [category_name]) VALUES (3, N'Boutique hotel')
INSERT [dbo].[category] ([id], [category_name]) VALUES (4, N'Luxury hotel')
INSERT [dbo].[category] ([id], [category_name]) VALUES (5, N'Meeting Planning hotel')
INSERT [dbo].[category] ([id], [category_name]) VALUES (6, N'Resort')
INSERT [dbo].[category] ([id], [category_name]) VALUES (7, N'Corporate Hotel')
SET IDENTITY_INSERT [dbo].[category] OFF
SET IDENTITY_INSERT [dbo].[city] ON 

INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (1, N'Ho Chi Minh', N'123', 1)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (2, N'Da Nang', N'124', 1)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (3, N'Ca Mau', N'125', 1)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (4, N'Vung Tau', N'126', 1)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (5, N'Ha Noi', N'127', 1)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (6, N'Vientiane', N'201', 2)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (7, N'Savannakhet', N'202', 2)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (8, N'Luang Prabang', N'203', 2)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (9, N'Kampot', N'301', 3)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (10, N'Battambang', N'302', 3)
INSERT [dbo].[city] ([id], [city_name], [postal_code], [country_id]) VALUES (11, N'Kompong Cham', N'303', 3)
SET IDENTITY_INSERT [dbo].[city] OFF
SET IDENTITY_INSERT [dbo].[country] ON 

INSERT [dbo].[country] ([id], [country_name]) VALUES (1, N'Viet Nam')
INSERT [dbo].[country] ([id], [country_name]) VALUES (2, N'Lao')
INSERT [dbo].[country] ([id], [country_name]) VALUES (3, N'Campuchia')
SET IDENTITY_INSERT [dbo].[country] OFF
INSERT [dbo].[discount] ([id], [discount], [status], [expire_date], [coupon_name], [create_date]) VALUES (N'0', CAST(0.00 AS Decimal(5, 2)), N'Active', CAST(N'2099-12-30' AS Date), N'NOCOUPON', CAST(N'2000-01-01 00:00:00.000' AS DateTime))
INSERT [dbo].[discount] ([id], [discount], [status], [expire_date], [coupon_name], [create_date]) VALUES (N'34t5yu7u6', CAST(10.00 AS Decimal(5, 2)), N'Active', CAST(N'2020-12-30' AS Date), N'MAGIAMGIA2', CAST(N'2020-10-30 10:50:11.400' AS DateTime))
INSERT [dbo].[discount] ([id], [discount], [status], [expire_date], [coupon_name], [create_date]) VALUES (N'l4jg43g523', CAST(5.00 AS Decimal(5, 2)), N'Active', CAST(N'2020-12-30' AS Date), N'MAGIAMGIA', CAST(N'2020-10-30 10:50:11.400' AS DateTime))
INSERT [dbo].[discount] ([id], [discount], [status], [expire_date], [coupon_name], [create_date]) VALUES (N'MZi5cGaq', CAST(0.00 AS Decimal(5, 2)), N'Active', CAST(N'2020-11-17' AS Date), N'2020-11-17', CAST(N'2020-11-02 16:11:18.387' AS DateTime))
INSERT [dbo].[discount] ([id], [discount], [status], [expire_date], [coupon_name], [create_date]) VALUES (N'vVVvono9', CAST(0.00 AS Decimal(5, 2)), N'Active', CAST(N'2020-11-11' AS Date), N'Test', CAST(N'2020-11-02 16:12:27.750' AS DateTime))
INSERT [dbo].[discount] ([id], [discount], [status], [expire_date], [coupon_name], [create_date]) VALUES (N'yW2dlrzr', CAST(25.00 AS Decimal(5, 2)), N'Active', CAST(N'2020-11-28' AS Date), N'2020-11-28', NULL)
INSERT [dbo].[discount] ([id], [discount], [status], [expire_date], [coupon_name], [create_date]) VALUES (N'zQPrLi6p', CAST(18.00 AS Decimal(5, 2)), N'Active', CAST(N'2020-11-11' AS Date), N'2020-11-11', CAST(N'2020-11-02 15:59:30.777' AS DateTime))
SET IDENTITY_INSERT [dbo].[extra_bed] ON 

INSERT [dbo].[extra_bed] ([id], [no_of_bed], [extra_cost]) VALUES (1, 1, CAST(120000.00 AS Decimal(10, 2)))
INSERT [dbo].[extra_bed] ([id], [no_of_bed], [extra_cost]) VALUES (2, 2, CAST(200000.00 AS Decimal(10, 2)))
INSERT [dbo].[extra_bed] ([id], [no_of_bed], [extra_cost]) VALUES (3, 0, CAST(0.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[extra_bed] OFF
SET IDENTITY_INSERT [dbo].[feedback] ON 

INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (1, N'good', 9, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (2, N'good', 9, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (3, N'xasas', 8, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (4, N'good', 7, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (5, N'good', 7, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (6, N'good', 7, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (7, N'good', 8, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (8, N'good', 8, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (9, N'good', 8, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (10, N'good', 8, 5, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (11, N'good', 9, 6, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (12, N'good', 9, 6, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (13, N'worse', 5, 1, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (14, N'Hooho', 6, 2, N'anhmtuan@gmail.com')
INSERT [dbo].[feedback] ([id], [feedback], [rating], [room_id], [user_email]) VALUES (15, N'Hooho', 6, 2, N'anhmtuan@gmail.com')
SET IDENTITY_INSERT [dbo].[feedback] OFF
SET IDENTITY_INSERT [dbo].[hotel] ON 

INSERT [dbo].[hotel] ([id], [hotel_name], [description], [city_id], [category_id], [status], [photo], [average_rating]) VALUES (1, N'Winsuites Saigon', N'Winsuites Saigon has a restaurant, outdoor swimming pool, a fitness center and bar in Ho Chi Minh City. This 4-star hotel offers a concierge service and a tour desk. The property has a 24-hour front desk, airport transportation, room service and free WiFi throughout the property.', 1, 2, N'Active', N'212020916.jpg', 9)
INSERT [dbo].[hotel] ([id], [hotel_name], [description], [city_id], [category_id], [status], [photo], [average_rating]) VALUES (2, N'Quy Hung Hotel', N'The hotel is located just 200 m from the popular Ben Thanh Market and Fine Arts Museum, while Tao Dan Park is 701 m away. The nearest airport is Tan Son Nhat International Airport, located 4.3 mi away from the property.', 1, 1, N'Active', N'photo0jpg.jpg', 7)
INSERT [dbo].[hotel] ([id], [hotel_name], [description], [city_id], [category_id], [status], [photo], [average_rating]) VALUES (3, N'Ghost Hotel', N'No rooms.', 3, 7, N'Active', N'photo0jpg.jpg', 7)
SET IDENTITY_INSERT [dbo].[hotel] OFF
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'0bec68fb-009c-40b4-a787-b8b60f88bdf5', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:07:20.450' AS DateTime), N'0', CAST(11700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'12676543-6475-4481-b039-c8c6ce802cac', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:48:32.030' AS DateTime), N'0', CAST(8900000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'12b309fe-ea36-4b78-ac59-a7f8a0745296', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:33:53.243' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'1f2a7891-6cf6-4b1f-8538-4c3bf99bbc56', N'anhmtuan@gmail.com', CAST(N'2020-11-01 19:48:37.333' AS DateTime), N'0', CAST(19840000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'358ebf24-e89f-4a25-ac59-de4c93bab051', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:14:03.423' AS DateTime), N'0', CAST(11700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'4cee06fc-6af8-4200-91f5-013bdc28cece', N'anhmtuan@gmail.com', CAST(N'2020-11-02 07:14:38.150' AS DateTime), N'0', CAST(17880000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'4ed126b4-1d46-4447-b43e-31b2cd2fbfef', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:16:13.797' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'7216a136-b95d-436b-8457-50fe843127ec', N'anhmtuan@gmail.com', CAST(N'2020-11-01 10:57:10.813' AS DateTime), N'0', CAST(10520000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'73028e95-06e4-4e9c-994a-9aa38933588e', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:15:15.540' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'750f31b7-8c13-41ec-a2b7-4144229f8def', N'anhmtuan@gmail.com', CAST(N'2020-11-01 10:54:45.850' AS DateTime), N'0', CAST(10520000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'78ac1fb9-5d3e-4088-8cd6-fe1d10ddab22', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:18:26.897' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'9430c9fc-a2c8-487d-ad0c-ef37e1c51c98', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:19:41.560' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'9c36a286-5349-4940-819f-99a35893fbc2', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:06:57.730' AS DateTime), N'0', CAST(11700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'9eb2c867-680a-4e9a-b44a-465ae47dfe04', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:38:59.460' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'aa63eae3-2fa6-48b9-b285-234fd3c7d6cb', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:26:46.577' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'b7be2b0b-0eaa-495a-bc9e-94599ba4e13e', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:03:09.130' AS DateTime), N'0', CAST(11700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'c2a9f856-12eb-4c1b-ba9a-0a2644312e0a', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:30:15.503' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'd4dcc0a3-fe1c-4f75-a1bb-d0611d7ec2d9', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:13:58.603' AS DateTime), N'0', CAST(11700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'dc780378-6900-41af-afd5-dcfdd03ebb32', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:00:05.830' AS DateTime), N'0', CAST(10520000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'ebc26e43-1944-487a-aed2-78c19da31f17', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:21:47.670' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'erty6765435', N'anhmtuan@gmail.com', CAST(N'2020-11-01 10:50:55.147' AS DateTime), N'0', CAST(1000000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'f10576df-f999-489a-a397-ef06daa3afdb', N'anhmtuan@gmail.com', CAST(N'2020-11-01 11:17:18.897' AS DateTime), N'0', CAST(3700000.00 AS Decimal(10, 2)), N'Inactive')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'f3fb418b-7062-465a-b0da-b3bdd1d1c4d0', N'anhmtuan@gmail.com', CAST(N'2020-11-01 10:58:12.807' AS DateTime), N'0', CAST(10520000.00 AS Decimal(10, 2)), N'Active')
INSERT [dbo].[reservation] ([id], [user_email], [ts_created], [discount_percent_id], [total_price], [status]) VALUES (N'w2er4t55e2', N'anhmtuan@gmail.com', CAST(N'2020-10-30 14:07:42.853' AS DateTime), N'34t5yu7u6', CAST(1000000.00 AS Decimal(10, 2)), N'Inactive')
SET IDENTITY_INSERT [dbo].[roles] ON 

INSERT [dbo].[roles] ([roleID], [name]) VALUES (1, N'ADMIN')
INSERT [dbo].[roles] ([roleID], [name]) VALUES (2, N'USER')
SET IDENTITY_INSERT [dbo].[roles] OFF
SET IDENTITY_INSERT [dbo].[room] ON 

INSERT [dbo].[room] ([id], [room_name], [description], [hotel_id], [room_type_id], [price], [photo], [available_room]) VALUES (1, N'Win Suite', N'Prices are per suite per 3 nights
Included: 10 % VAT, 5 % Property service charge, Breakfast', 1, 8, CAST(8900000.00 AS Decimal(10, 2)), N'211635923.jpg', 10)
INSERT [dbo].[room] ([id], [room_name], [description], [hotel_id], [room_type_id], [price], [photo], [available_room]) VALUES (2, N'Win Suite 2', N'Prices are per suite per 3 nights
Included: 10 % VAT, 5 % Property service charge, Breakfast', 1, 1, CAST(2800000.00 AS Decimal(10, 2)), N'211635970.jpg', 10)
INSERT [dbo].[room] ([id], [room_name], [description], [hotel_id], [room_type_id], [price], [photo], [available_room]) VALUES (3, N'Win Suite 7', N'Prices are per suite per 3 nights
Included: 10 % VAT, 5 % Property service charge, Breakfast', 1, 2, CAST(3800000.00 AS Decimal(10, 2)), N'211635981.jpg', 10)
INSERT [dbo].[room] ([id], [room_name], [description], [hotel_id], [room_type_id], [price], [photo], [available_room]) VALUES (4, N'Room 001', N'Prices are per suite per 3 nights
Included: 10 % VAT, 5 % Property service charge, Breakfast', 2, 2, CAST(3600000.00 AS Decimal(10, 2)), N'266195939.jpg', 10)
INSERT [dbo].[room] ([id], [room_name], [description], [hotel_id], [room_type_id], [price], [photo], [available_room]) VALUES (5, N'Room 101', N'Prices are per suite per 3 nights
Included: 10 % VAT, 5 % Property service charge, Breakfast', 2, 6, CAST(7900000.00 AS Decimal(10, 2)), N'59906111.jpg', 10)
INSERT [dbo].[room] ([id], [room_name], [description], [hotel_id], [room_type_id], [price], [photo], [available_room]) VALUES (6, N'Room 201', N'Prices are per suite per 3 nights
Included: 10 % VAT, 5 % Property service charge, Breakfast', 2, 1, CAST(1900000.00 AS Decimal(10, 2)), N'59906127.jpg', 15)
INSERT [dbo].[room] ([id], [room_name], [description], [hotel_id], [room_type_id], [price], [photo], [available_room]) VALUES (7, N'Room 301', N'Prices are per suite per 3 nights
Included: 10 % VAT, 5 % Property service charge, Breakfast', 2, 4, CAST(900000.00 AS Decimal(10, 2)), N'59906127.jpg', 10)
SET IDENTITY_INSERT [dbo].[room] OFF
SET IDENTITY_INSERT [dbo].[room_reserved] ON 

INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (1, N'w2er4t55e2', 6, 1, CAST(1000000.00 AS Decimal(10, 2)), CAST(N'2020-11-15' AS Date), CAST(N'2020-11-16' AS Date), 1, 1)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (2, N'w2er4t55e2', 6, 1, CAST(1000000.00 AS Decimal(10, 2)), CAST(N'2020-11-18' AS Date), CAST(N'2020-11-19' AS Date), 1, 0)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (3, N'w2er4t55e2', 2, 1, CAST(50000.00 AS Decimal(10, 2)), CAST(N'2020-11-18' AS Date), CAST(N'2020-11-19' AS Date), 1, 0)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (4, N'750f31b7-8c13-41ec-a2b7-4144229f8def', 2, 1, CAST(2920000.00 AS Decimal(10, 2)), CAST(N'2020-11-25' AS Date), CAST(N'2020-11-26' AS Date), 1, 1)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (6, N'7216a136-b95d-436b-8457-50fe843127ec', 2, 1, CAST(2920000.00 AS Decimal(10, 2)), CAST(N'2020-11-25' AS Date), CAST(N'2020-11-26' AS Date), 1, 0)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (8, N'f3fb418b-7062-465a-b0da-b3bdd1d1c4d0', 2, 1, CAST(2920000.00 AS Decimal(10, 2)), CAST(N'2020-11-25' AS Date), CAST(N'2020-11-26' AS Date), 1, 0)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (10, N'dc780378-6900-41af-afd5-dcfdd03ebb32', 2, 1, CAST(2920000.00 AS Decimal(10, 2)), CAST(N'2020-11-25' AS Date), CAST(N'2020-11-26' AS Date), 1, 0)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (15, N'dc780378-6900-41af-afd5-dcfdd03ebb32', 3, 2, CAST(6700000.00 AS Decimal(10, 2)), CAST(N'2020-11-24' AS Date), CAST(N'2020-11-25' AS Date), 1, 0)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (28, N'9eb2c867-680a-4e9a-b44a-465ae47dfe04', 6, 1, CAST(1900000.00 AS Decimal(10, 2)), CAST(N'2020-11-08' AS Date), CAST(N'2020-11-09' AS Date), 3, 0)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (29, N'9eb2c867-680a-4e9a-b44a-465ae47dfe04', 7, 2, CAST(1800000.00 AS Decimal(10, 2)), CAST(N'2020-11-08' AS Date), CAST(N'2020-11-09' AS Date), 3, 0)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (30, N'12676543-6475-4481-b039-c8c6ce802cac', 1, 1, CAST(8900000.00 AS Decimal(10, 2)), CAST(N'2020-11-03' AS Date), CAST(N'2020-11-04' AS Date), 3, 1)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (31, N'1f2a7891-6cf6-4b1f-8538-4c3bf99bbc56', 5, 1, CAST(15800000.00 AS Decimal(10, 2)), CAST(N'2020-11-04' AS Date), CAST(N'2020-11-06' AS Date), 3, 1)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (32, N'1f2a7891-6cf6-4b1f-8538-4c3bf99bbc56', 6, 1, CAST(4040000.00 AS Decimal(10, 2)), CAST(N'2020-11-04' AS Date), CAST(N'2020-11-06' AS Date), 1, 1)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (33, N'4cee06fc-6af8-4200-91f5-013bdc28cece', 2, 1, CAST(5840000.00 AS Decimal(10, 2)), CAST(N'2020-11-18' AS Date), CAST(N'2020-11-20' AS Date), 1, 0)
INSERT [dbo].[room_reserved] ([id], [reservation_id], [room_id], [quantity], [price], [start_date], [end_date], [extra_bed_id], [isFeedback]) VALUES (34, N'4cee06fc-6af8-4200-91f5-013bdc28cece', 3, 1, CAST(8000000.00 AS Decimal(10, 2)), CAST(N'2020-11-18' AS Date), CAST(N'2020-11-20' AS Date), 2, 0)
SET IDENTITY_INSERT [dbo].[room_reserved] OFF
SET IDENTITY_INSERT [dbo].[room_type] ON 

INSERT [dbo].[room_type] ([id], [type_name]) VALUES (1, N'single')
INSERT [dbo].[room_type] ([id], [type_name]) VALUES (2, N'double')
INSERT [dbo].[room_type] ([id], [type_name]) VALUES (3, N'triple')
INSERT [dbo].[room_type] ([id], [type_name]) VALUES (4, N'quad')
INSERT [dbo].[room_type] ([id], [type_name]) VALUES (5, N'queen')
INSERT [dbo].[room_type] ([id], [type_name]) VALUES (6, N'king')
INSERT [dbo].[room_type] ([id], [type_name]) VALUES (7, N'Twin')
INSERT [dbo].[room_type] ([id], [type_name]) VALUES (8, N'Suite room')
SET IDENTITY_INSERT [dbo].[room_type] OFF
INSERT [dbo].[Users] ([email], [username], [password], [role], [status], [create_date], [phone], [address]) VALUES (N'anhmtuan@gmail.com', N'Wibu', N'49ab638866aef3ed2474277d020227ab7d5ea9fcf1b267f07d0a68d3db9fc2a0', 2, N'Active', CAST(N'2020-10-24 16:34:37.300' AS DateTime), 142252525, N'ABG')
INSERT [dbo].[Users] ([email], [username], [password], [role], [status], [create_date], [phone], [address]) VALUES (N'anhwtuan@gmail.com', N'Anh', N'49AB638866AEF3ED2474277D020227AB7D5EA9FCF1B267F07D0A68D3DB9FC2A0', 1, N'Active', CAST(N'2020-10-24 16:34:22.783' AS DateTime), 465665432, N'AVG')
INSERT [dbo].[Users] ([email], [username], [password], [role], [status], [create_date], [phone], [address]) VALUES (N'anhztuan@gmail.com', N'Em', N'49ab638866aef3ed2474277d020227ab7d5ea9fcf1b267f07d0a68d3db9fc2a0', 2, N'Active', CAST(N'2020-10-24 16:59:47.873' AS DateTime), 942458244, N'ACB')
ALTER TABLE [dbo].[city]  WITH CHECK ADD FOREIGN KEY([country_id])
REFERENCES [dbo].[country] ([id])
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD FOREIGN KEY([room_id])
REFERENCES [dbo].[room] ([id])
GO
ALTER TABLE [dbo].[feedback]  WITH CHECK ADD FOREIGN KEY([user_email])
REFERENCES [dbo].[Users] ([email])
GO
ALTER TABLE [dbo].[hotel]  WITH CHECK ADD FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([id])
GO
ALTER TABLE [dbo].[hotel]  WITH CHECK ADD FOREIGN KEY([city_id])
REFERENCES [dbo].[city] ([id])
GO
ALTER TABLE [dbo].[reservation]  WITH CHECK ADD FOREIGN KEY([discount_percent_id])
REFERENCES [dbo].[discount] ([id])
GO
ALTER TABLE [dbo].[reservation]  WITH CHECK ADD FOREIGN KEY([user_email])
REFERENCES [dbo].[Users] ([email])
GO
ALTER TABLE [dbo].[room]  WITH CHECK ADD FOREIGN KEY([hotel_id])
REFERENCES [dbo].[hotel] ([id])
GO
ALTER TABLE [dbo].[room]  WITH CHECK ADD FOREIGN KEY([room_type_id])
REFERENCES [dbo].[room_type] ([id])
GO
ALTER TABLE [dbo].[room_reserved]  WITH CHECK ADD FOREIGN KEY([extra_bed_id])
REFERENCES [dbo].[extra_bed] ([id])
GO
ALTER TABLE [dbo].[room_reserved]  WITH CHECK ADD FOREIGN KEY([reservation_id])
REFERENCES [dbo].[reservation] ([id])
GO
ALTER TABLE [dbo].[room_reserved]  WITH CHECK ADD FOREIGN KEY([room_id])
REFERENCES [dbo].[room] ([id])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([role])
REFERENCES [dbo].[roles] ([roleID])
GO
USE [master]
GO
ALTER DATABASE [Hotel] SET  READ_WRITE 
GO
