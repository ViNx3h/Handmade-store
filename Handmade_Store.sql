USE [master]
GO
/****** Object:  Database [HandmadeStore_Project]    Script Date: 11/9/2023 10:00:40 AM ******/
CREATE DATABASE [HandmadeStore_Project]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HandmadeStore_Project', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\HandmadeStore_Project.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'HandmadeStore_Project_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\HandmadeStore_Project_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [HandmadeStore_Project] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HandmadeStore_Project].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HandmadeStore_Project] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET ARITHABORT OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HandmadeStore_Project] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HandmadeStore_Project] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HandmadeStore_Project] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HandmadeStore_Project] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET RECOVERY FULL 
GO
ALTER DATABASE [HandmadeStore_Project] SET  MULTI_USER 
GO
ALTER DATABASE [HandmadeStore_Project] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HandmadeStore_Project] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HandmadeStore_Project] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HandmadeStore_Project] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [HandmadeStore_Project] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [HandmadeStore_Project] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'HandmadeStore_Project', N'ON'
GO
ALTER DATABASE [HandmadeStore_Project] SET QUERY_STORE = ON
GO
ALTER DATABASE [HandmadeStore_Project] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [HandmadeStore_Project]
GO
/****** Object:  Table [dbo].[administrator]    Script Date: 11/9/2023 10:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[administrator](
	[username] [varchar](50) NOT NULL,
	[password] [varchar](32) NOT NULL,
	[fullname] [varchar](100) NOT NULL,
	[gender] [varchar](6) NOT NULL,
	[birthday] [date] NOT NULL,
	[phone_number] [varchar](20) NOT NULL,
	[address] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_administrator] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[bill]    Script Date: 11/9/2023 10:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[date] [date] NOT NULL,
	[total] [bigint] NOT NULL,
	[cus_us] [varchar](50) NOT NULL,
 CONSTRAINT [PK_bill] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer]    Script Date: 11/9/2023 10:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer](
	[username] [varchar](50) NOT NULL,
	[password] [varchar](32) NOT NULL,
	[fullname] [varchar](100) NOT NULL,
	[gender] [varchar](6) NOT NULL,
	[birthday] [date] NOT NULL,
	[phone_number] [varchar](20) NOT NULL,
	[address] [varchar](1000) NOT NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[order]    Script Date: 11/9/2023 10:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order](
	[bill_id] [int] NOT NULL,
	[pro_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 11/9/2023 10:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [bigint] NOT NULL,
	[picture] [varchar](500) NOT NULL,
	[description] [varchar](1000) NULL,
	[type_id] [int] NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[shopping_cart]    Script Date: 11/9/2023 10:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[shopping_cart](
	[cus_us] [varchar](50) NOT NULL,
	[pro_id] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[price] [bigint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[type]    Script Date: 11/9/2023 10:00:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[type](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Type] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[administrator] ([username], [password], [fullname], [gender], [birthday], [phone_number], [address]) VALUES (N'tamnguyen', N'3b340e7c1e269722340f024674356a3e', N'Huynh Pham Tam Nguyen', N'Female', CAST(N'2003-06-02' AS Date), N'0918668207', N'62/5C Tran Viet Chau')
GO
SET IDENTITY_INSERT [dbo].[bill] ON 

INSERT [dbo].[bill] ([id], [date], [total], [cus_us]) VALUES (28, CAST(N'2023-11-08' AS Date), 450000, N'tamnguyen')
INSERT [dbo].[bill] ([id], [date], [total], [cus_us]) VALUES (29, CAST(N'2023-11-09' AS Date), 480000, N'tamnguyen')
SET IDENTITY_INSERT [dbo].[bill] OFF
GO
INSERT [dbo].[customer] ([username], [password], [fullname], [gender], [birthday], [phone_number], [address]) VALUES (N'tamnguyen', N'3b340e7c1e269722340f024674356a3e', N'Huynh Pham Tam Nguyen', N'Female', CAST(N'2003-06-02' AS Date), N'0918668208', N'62/5C Tran Viet Chau, Ninh Kieu district')
GO
INSERT [dbo].[order] ([bill_id], [pro_id], [quantity], [price]) VALUES (29, 9, 1, 240000)
INSERT [dbo].[order] ([bill_id], [pro_id], [quantity], [price]) VALUES (29, 34, 1, 240000)
INSERT [dbo].[order] ([bill_id], [pro_id], [quantity], [price]) VALUES (28, 5, 3, 450000)
GO
SET IDENTITY_INSERT [dbo].[product] ON 

INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (1, N'Bernat super Value - Berry', 1000, 150000, N'Berry.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (4, N'Bernat super Value - Bright Teal', 1000, 150000, N'Bright Teal.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (5, N'Bernat super Value - Lilac', 994, 150000, N'Lilac.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (6, N'Bernat super Value - Hot blue', 1000, 150000, N'Hot blue.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (7, N'Bernat super Value - Cool blue', 999, 150000, N'Cool blue.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (8, N'Bernat super Value - Yellow', 1000, 150000, N'Yellow.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (9, N'Patons Beehive Baby Sport - Baby Grey', 998, 130000, N'Patons beehive baby sport-baby grey.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (11, N'Bernat Softee Baby - Lemon', 1000, 140000, N'bernat softee baby- lemon.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (12, N'Patons Canadiana - Cherished Blue', 1000, 130000, N'Patons Canadiana - cherished blue.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (13, N'Patons Canadiana - Teal Heather', 1000, 130000, N'Patons Canadiana - teal heather.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (14, N'Bernat Softee Baby - Blue Jeans', 1000, 140000, N'bernat softee baby-blue jeans.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (17, N'Bernat super Value - True grey', 1000, 150000, N'True grey.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (18, N'Bernat super Value - Forest Green', 1000, 150000, N'Forest Green.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (19, N'Bernat super Value - Honey', 1000, 150000, N'Honey.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (21, N'Bernat super Value - Natural', 1000, 150000, N'Natural.jpg', N'Stocking', 1)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (22, N'Wedding Flower', 998, 360000, N'Flower.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (23, N'Cute Crocodile', 999, 450000, N'Crocodile.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (24, N'Chrysanthemum Handbag', 997, 200000, N'Bag.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (26, N'Brocade Handbag', 1000, 150000, N'Bag 2.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (27, N'Baby''s clothes set - Penguin', 1000, 750000, N'Children''s clothes set - Penguin.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (28, N'Brocade Croptop', 1000, 240000, N'Croptop.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (29, N'Cute Rabbit', 997, 480000, N'Rabbit.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (30, N'Vintage Handbag', 1000, 200000, N'Bag 3.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (32, N'Chrysanthemum Handband', 1000, 200000, N'hairband.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (33, N'Sweater for Men', 998, 850000, N'sweater.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (34, N'Bear Handbag', 999, 240000, N'handbag 2.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (35, N'Lovely Raccoon', 1000, 350000, N'Raccoon.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (36, N'Backrest pillow - Rabbit', 1000, 420000, N'Backrest pillow.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (37, N'Baby cat sweater', 1000, 350000, N'baby sweater.jpg', N'Stocking', 2)
INSERT [dbo].[product] ([id], [name], [quantity], [price], [picture], [description], [type_id]) VALUES (38, N'Dairy cow', 1000, 230000, N'Cow.jpg', N'Stocking', 2)
SET IDENTITY_INSERT [dbo].[product] OFF
GO
SET IDENTITY_INSERT [dbo].[type] ON 

INSERT [dbo].[type] ([id], [name]) VALUES (1, N'Wool Yarn')
INSERT [dbo].[type] ([id], [name]) VALUES (2, N'Handmade Product')
SET IDENTITY_INSERT [dbo].[type] OFF
GO
ALTER TABLE [dbo].[bill] ADD  CONSTRAINT [DF_bill_total]  DEFAULT ((0)) FOR [total]
GO
ALTER TABLE [dbo].[order] ADD  CONSTRAINT [DF_order_price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[shopping_cart] ADD  CONSTRAINT [DF_shopping_cart_price]  DEFAULT ((0)) FOR [price]
GO
ALTER TABLE [dbo].[bill]  WITH CHECK ADD  CONSTRAINT [FK_bill_customer] FOREIGN KEY([cus_us])
REFERENCES [dbo].[customer] ([username])
GO
ALTER TABLE [dbo].[bill] CHECK CONSTRAINT [FK_bill_customer]
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_bill] FOREIGN KEY([bill_id])
REFERENCES [dbo].[bill] ([id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_bill]
GO
ALTER TABLE [dbo].[order]  WITH CHECK ADD  CONSTRAINT [FK_order_product] FOREIGN KEY([pro_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[order] CHECK CONSTRAINT [FK_order_product]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_product_type] FOREIGN KEY([type_id])
REFERENCES [dbo].[type] ([id])
GO
ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_product_type]
GO
ALTER TABLE [dbo].[shopping_cart]  WITH CHECK ADD  CONSTRAINT [FK_shopping_cart_customer] FOREIGN KEY([cus_us])
REFERENCES [dbo].[customer] ([username])
GO
ALTER TABLE [dbo].[shopping_cart] CHECK CONSTRAINT [FK_shopping_cart_customer]
GO
ALTER TABLE [dbo].[shopping_cart]  WITH CHECK ADD  CONSTRAINT [FK_shopping_cart_product] FOREIGN KEY([pro_id])
REFERENCES [dbo].[product] ([id])
GO
ALTER TABLE [dbo].[shopping_cart] CHECK CONSTRAINT [FK_shopping_cart_product]
GO
USE [master]
GO
ALTER DATABASE [HandmadeStore_Project] SET  READ_WRITE 
GO
