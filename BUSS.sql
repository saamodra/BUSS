USE [master]
GO
/****** Object:  Database [BUSS]    Script Date: 1/18/2021 8:33:44 PM ******/
CREATE DATABASE [BUSS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'BUSS', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BUSS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'BUSS_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\BUSS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [BUSS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [BUSS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [BUSS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [BUSS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [BUSS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [BUSS] SET ARITHABORT OFF 
GO
ALTER DATABASE [BUSS] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [BUSS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [BUSS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [BUSS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [BUSS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [BUSS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [BUSS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [BUSS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [BUSS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [BUSS] SET  ENABLE_BROKER 
GO
ALTER DATABASE [BUSS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [BUSS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [BUSS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [BUSS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [BUSS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [BUSS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [BUSS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [BUSS] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [BUSS] SET  MULTI_USER 
GO
ALTER DATABASE [BUSS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [BUSS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [BUSS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [BUSS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [BUSS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [BUSS] SET QUERY_STORE = OFF
GO
USE [BUSS]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[NIK] [varchar](16) NOT NULL,
	[Nama] [varchar](255) NOT NULL,
	[Alamat] [varchar](255) NOT NULL,
	[No_HP] [varchar](15) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[NIK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Destinasi]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Destinasi](
	[ID_Destinasi] [int] IDENTITY(1,1) NOT NULL,
	[Nama_Destinasi] [varchar](50) NOT NULL,
	[Harga_Tiket] [money] NOT NULL,
	[ID_Kota] [int] NOT NULL,
	[Rating] [float] NOT NULL,
	[Jam_buka] [time](7) NOT NULL,
	[Jam_tutup] [time](7) NOT NULL,
	[Deskripsi] [varchar](255) NULL,
	[Status] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Destinasi] PRIMARY KEY CLUSTERED 
(
	[ID_Destinasi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detail_Foto]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail_Foto](
	[ID_Detail] [int] IDENTITY(1,1) NOT NULL,
	[ID_Destinasi] [int] NOT NULL,
	[Foto] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Detail_Foto] PRIMARY KEY CLUSTERED 
(
	[ID_Detail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detail_Kategori]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail_Kategori](
	[ID_KategoriWilayah] [int] NOT NULL,
	[ID_Kota] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Detail_Kategori] PRIMARY KEY CLUSTERED 
(
	[ID_KategoriWilayah] ASC,
	[ID_Kota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detail_Paket]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail_Paket](
	[ID_Paket] [int] NOT NULL,
	[ID_Destinasi] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Detail_Paket] PRIMARY KEY CLUSTERED 
(
	[ID_Paket] ASC,
	[ID_Destinasi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Detail_Rating_Destinasi]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail_Rating_Destinasi](
	[NIK] [varchar](16) NOT NULL,
	[ID_Destinasi] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Detail_Rating_Destinasi] PRIMARY KEY CLUSTERED 
(
	[NIK] ASC,
	[ID_Destinasi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[ID_Feedback] [int] IDENTITY(1,1) NOT NULL,
	[ID_Transaksi] [int] NOT NULL,
	[Rating] [int] NOT NULL,
	[Isi_Feedback] [text] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[ID_Feedback] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jenis_Kendaraan]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jenis_Kendaraan](
	[ID_Jenis] [int] IDENTITY(1,1) NOT NULL,
	[Nama_Jenis] [varchar](30) NOT NULL,
	[Jumlah_Kursi] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Jenis_Kendaraan] PRIMARY KEY CLUSTERED 
(
	[ID_Jenis] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kategori_Wilayah]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kategori_Wilayah](
	[ID_KategoriWilayah] [int] IDENTITY(1,1) NOT NULL,
	[Nama_Wilayah] [varchar](255) NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Kategori_Wilayah] PRIMARY KEY CLUSTERED 
(
	[ID_KategoriWilayah] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kendaraan]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kendaraan](
	[ID_Kendaraan] [int] IDENTITY(1,1) NOT NULL,
	[Nama_Kendaraan] [varchar](50) NOT NULL,
	[ID_Jenis] [int] NOT NULL,
	[No_Kendaraan] [varchar](10) NOT NULL,
	[Harga_kendaraan] [money] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Kendaraan] PRIMARY KEY CLUSTERED 
(
	[ID_Kendaraan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kota]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kota](
	[ID_Kota] [int] IDENTITY(1,1) NOT NULL,
	[Nama_Kota] [varchar](100) NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Kota] PRIMARY KEY CLUSTERED 
(
	[ID_Kota] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Paket]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Paket](
	[ID_Paket] [int] IDENTITY(1,1) NOT NULL,
	[Nama_Paket] [varchar](50) NOT NULL,
	[Harga] [money] NULL,
	[Konsumsi] [int] NOT NULL,
	[Lama_Perjalanan] [int] NULL,
	[Jenis_Paket] [int] NOT NULL,
	[Jadwal] [varchar](255) NULL,
	[Keterangan] [varchar](255) NULL,
	[Status] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedBy] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Paket] PRIMARY KEY CLUSTERED 
(
	[ID_Paket] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pegawai]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pegawai](
	[ID_Pegawai] [int] IDENTITY(1,1) NOT NULL,
	[Nama] [varchar](100) NOT NULL,
	[Alamat] [varchar](255) NOT NULL,
	[No_HP] [varchar](15) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](255) NOT NULL,
	[Role] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Pegawai] PRIMARY KEY CLUSTERED 
(
	[ID_Pegawai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaksi]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaksi](
	[ID_Transaksi] [int] IDENTITY(1,1) NOT NULL,
	[ID_Paket] [int] NOT NULL,
	[ID_Customer] [varchar](16) NOT NULL,
	[ID_Pegawai] [int] NULL,
	[Harga_total] [money] NOT NULL,
	[Jumlah_Penumpang] [int] NOT NULL,
	[Tanggal_Pesanan] [date] NOT NULL,
	[Bukti_DP] [varchar](255) NULL,
	[Bukti_Pelunasan] [varchar](255) NULL,
	[Status_Transaksi] [int] NOT NULL,
	[PaketLama_Perjalanan] [float] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Transaksi] PRIMARY KEY CLUSTERED 
(
	[ID_Transaksi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaksi_Kendaraan]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaksi_Kendaraan](
	[ID_Transaksi] [int] NOT NULL,
	[ID_Kendaraan] [int] NOT NULL,
 CONSTRAINT [PK_Transaksi_Kendaraan] PRIMARY KEY CLUSTERED 
(
	[ID_Transaksi] ASC,
	[ID_Kendaraan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123400', N'Tes', N'Surabaya', N'0817263123', N'test@gmail.com', N'test', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123450', N'Rifai', N'Tegal', N'089752435123', N'asdasd@gfmail.com', N'asd', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123451', N'U', N'sdf', N'131234', N'asdasd@gfmail.com', N'asd', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123452', N'Sukarno', N'Purwokerto', N'0867651254364', N'suk@gmail.com', N'suk', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123454', N'asdzxc', N'asdasd', N'08123561423', N'asdasd@asd.com', N'asdasd', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123456', N'Satria', N'Jakarta', N'131234124', N'asd@gmail.com', N'asd', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123458', N'qqwe', N'sdf', N'234', N'samodra28@gmail.com', N'asd', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123459', N'Yudi', N'asdasd', N'019236717239', N'yudi@gmail.com', N'yudi', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Destinasi] ON 

INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Kawah Putih', 50000.0000, 3, 0, CAST(N'09:14:00' AS Time), CAST(N'21:14:00' AS Time), N'asd', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T16:39:15.350' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Ancol', 50000.0000, 7, 0, CAST(N'21:20:00' AS Time), CAST(N'21:20:00' AS Time), N'asd', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T18:51:17.410' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Pantai Kelingking', 15000.0000, 3, 0, CAST(N'21:30:00' AS Time), CAST(N'21:30:00' AS Time), N'zxc', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Gunung Bromo', 40000.0000, 2, 0, CAST(N'06:40:00' AS Time), CAST(N'13:40:00' AS Time), N'Ok', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Candi Prambanan', 65000.0000, 2, 0, CAST(N'06:17:00' AS Time), CAST(N'14:17:00' AS Time), N'test', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T16:39:04.297' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Brumbun Tubing', 40000.0000, 5, 0, CAST(N'06:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T06:50:51.303' AS DateTime), 1, CAST(N'2021-01-18T06:50:51.303' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Tangkuban Perahu', 50000.0000, 5, 0, CAST(N'07:00:00' AS Time), CAST(N'08:48:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T07:48:45.383' AS DateTime), 1, CAST(N'2021-01-18T07:48:45.383' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Kampung Daun', 50000.0000, 5, 0, CAST(N'07:00:00' AS Time), CAST(N'22:00:00' AS Time), N'Mencicipi sajian wisata kuliner daun ', 1, 1, CAST(N'2021-01-18T16:31:34.223' AS DateTime), 1, CAST(N'2021-01-18T16:31:34.223' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Mutun Beach', 70000.0000, 17, 0, CAST(N'05:00:00' AS Time), CAST(N'19:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T19:02:10.590' AS DateTime), 1, CAST(N'2021-01-18T19:02:10.590' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, N'Pantai Tanjung Tinggi', 100000.0000, 8, 0, CAST(N'06:00:00' AS Time), CAST(N'19:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T19:04:08.650' AS DateTime), 1, CAST(N'2021-01-18T19:04:08.650' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'Mekarsari Fruit Garden', 100000.0000, 2, 0, CAST(N'08:00:00' AS Time), CAST(N'22:00:00' AS Time), N'Mekarsari Fruit Garden
', 1, 1, CAST(N'2021-01-18T19:05:37.720' AS DateTime), 1, CAST(N'2021-01-18T19:05:37.720' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'Bogor Botanical Garden', 50000.0000, 4, 0, CAST(N'09:00:00' AS Time), CAST(N'21:00:00' AS Time), N'Bogor Botanical Garden', 1, 1, CAST(N'2021-01-18T19:06:58.447' AS DateTime), 1, CAST(N'2021-01-18T19:06:58.447' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'Jendela Alam', 50000.0000, 21, 0, CAST(N'06:30:00' AS Time), CAST(N'19:30:00' AS Time), N'Rumah Jendela Alam', 1, 1, CAST(N'2021-01-18T19:53:09.020' AS DateTime), 1, CAST(N'2021-01-18T19:53:09.020' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'Kebun Binatang Ragunan', 10000.0000, 7, 0, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Kebun binatang ragunan', 1, 1, CAST(N'2021-01-18T19:54:47.667' AS DateTime), 1, CAST(N'2021-01-18T19:54:47.667' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'Candi Sojiwan', 25000.0000, 19, 0, CAST(N'06:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Candi Seribu', 1, 1, CAST(N'2021-01-18T19:56:43.400' AS DateTime), 1, CAST(N'2021-01-18T19:56:43.400' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'Telaga Sarangan', 50000.0000, 3, 0, CAST(N'06:00:00' AS Time), CAST(N'20:00:00' AS Time), N'Telaga Sarangan', 1, 1, CAST(N'2021-01-18T19:59:24.437' AS DateTime), 1, CAST(N'2021-01-18T19:59:24.437' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, N'Fort Rotterdam', 65000.0000, 10, 0, CAST(N'06:00:00' AS Time), CAST(N'20:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:00:24.070' AS DateTime), 1, CAST(N'2021-01-18T20:00:24.070' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'Jawa Timur Park 3', 150000.0000, 6, 0, CAST(N'06:01:00' AS Time), CAST(N'20:01:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:01:39.033' AS DateTime), 1, CAST(N'2021-01-18T20:01:39.033' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'Museum Ullen Sentalu', 45000.0000, 20, 0, CAST(N'08:02:00' AS Time), CAST(N'20:02:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:02:57.800' AS DateTime), 1, CAST(N'2021-01-18T20:02:57.800' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'Lawang Sewu', 25000.0000, 13, 0, CAST(N'12:03:00' AS Time), CAST(N'20:03:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:04:04.947' AS DateTime), 1, CAST(N'2021-01-18T20:04:04.947' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'Monumen Pahlawan', 25000.0000, 14, 0, CAST(N'08:00:00' AS Time), CAST(N'20:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:05:04.747' AS DateTime), 1, CAST(N'2021-01-18T20:05:04.747' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'Taman Wisata Karang Resik', 50000.0000, 16, 0, CAST(N'08:06:00' AS Time), CAST(N'18:06:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:06:52.803' AS DateTime), 1, CAST(N'2021-01-18T20:06:52.803' AS DateTime))
SET IDENTITY_INSERT [dbo].[Destinasi] OFF
GO
SET IDENTITY_INSERT [dbo].[Detail_Foto] ON 

INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (1, 1, N'202101092116530.png')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (2, 1, N'202101092116531.png')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (3, 1, N'202101092116532.png')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (5, 1, N'202101100952001.png')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (6, 4, N'202101131341350.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (8, 4, N'202101131341450.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (11, 6, N'202101180651300.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (12, 6, N'202101180651301.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (13, 2, N'202101180717210.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (14, 3, N'202101180718270.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (15, 7, N'202101180750020.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (16, 8, N'202101181632380.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (17, 9, N'202101181903260.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (18, 10, N'202101181904340.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (19, 11, N'202101181906020.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (20, 12, N'202101181907280.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (21, 13, N'202101181953470.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (22, 14, N'202101181955300.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (23, 15, N'202101181958170.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (24, 16, N'202101181959360.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (25, 17, N'202101182000320.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (26, 18, N'202101182001480.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (27, 19, N'202101182003060.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (28, 20, N'202101182004120.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (29, 21, N'202101182005490.png')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (30, 22, N'202101182007000.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (31, 5, N'202101182023240.jpg')
SET IDENTITY_INSERT [dbo].[Detail_Foto] OFF
GO
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (1, 2, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (1, 4, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (1, 7, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (2, 18, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (2, 19, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (2, 20, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (3, 12, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (3, 15, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (3, 17, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (4, 5, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (4, 16, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (4, 21, 0)
GO
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (1, 5, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (1, 15, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (2, 8, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (2, 16, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (2, 18, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (3, 19, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (3, 20, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (3, 21, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (7, 6, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (7, 11, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (7, 12, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (8, 4, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (8, 21, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (9, 10, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (9, 13, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (10, 7, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (10, 15, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (11, 9, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (11, 17, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (11, 22, 0)
GO
SET IDENTITY_INSERT [dbo].[Jenis_Kendaraan] ON 

INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Bus Besar', 45, 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T07:18:52.737' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Bus Kecil', 30, 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Ok', 4, 0, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Travel', 15, 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Test', 123, 0, 1, CAST(N'2021-01-18T07:19:23.583' AS DateTime), 1, CAST(N'2021-01-18T07:19:23.583' AS DateTime))
SET IDENTITY_INSERT [dbo].[Jenis_Kendaraan] OFF
GO
SET IDENTITY_INSERT [dbo].[Kategori_Wilayah] ON 

INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Jakarta dan sekitarnya', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Yogyakarta dan sekitarnya', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Lampung dan sekitarnya', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T07:16:50.563' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Bandung dan sekitarnya', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Kategori_Wilayah] OFF
GO
SET IDENTITY_INSERT [dbo].[Kendaraan] ON 

INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Sumber Kencana', 1, N'B 1098 AC', 238839.0000, 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Sumber Rejeki', 1, N'AE 1098 DA', 950000.0000, 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T07:19:36.320' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Panda', 4, N'AE 1058 DA', 150000.0000, 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Sugeng Rahayu', 1, N'D 8763 UJ', 750000.0000, 1, 1, CAST(N'2021-01-18T07:20:20.000' AS DateTime), 1, CAST(N'2021-01-18T07:20:26.563' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Agra Icon', 1, N'AD 7123 D', 750000.0000, 1, 1, CAST(N'2021-01-18T20:09:13.800' AS DateTime), 1, CAST(N'2021-01-18T20:09:13.800' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'BGS Trans', 1, N'DC 0981 OK', 500000.0000, 1, 1, CAST(N'2021-01-18T20:09:41.597' AS DateTime), 1, CAST(N'2021-01-18T20:09:41.597' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Express Eagle High', 4, N'AI 7369 RY', 400000.0000, 1, 1, CAST(N'2021-01-18T20:10:24.910' AS DateTime), 1, CAST(N'2021-01-18T20:10:24.910' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Indah Murni', 2, N'AE 6735 EO', 500000.0000, 1, 1, CAST(N'2021-01-18T20:10:48.227' AS DateTime), 1, CAST(N'2021-01-18T20:10:48.227' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Pusaka Wisata', 4, N'K 8972 I', 350000.0000, 1, 1, CAST(N'2021-01-18T20:11:19.190' AS DateTime), 1, CAST(N'2021-01-18T20:11:19.190' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, N'Suryaputra Trans', 4, N'E 8661 JK', 250000.0000, 1, 1, CAST(N'2021-01-18T20:12:06.020' AS DateTime), 1, CAST(N'2021-01-18T20:12:06.020' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'YM Transport', 2, N'T 9837 O', 500000.0000, 1, 1, CAST(N'2021-01-18T20:12:36.690' AS DateTime), 1, CAST(N'2021-01-18T20:12:36.690' AS DateTime))
SET IDENTITY_INSERT [dbo].[Kendaraan] OFF
GO
SET IDENTITY_INSERT [dbo].[Kota] ON 

INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Bekasi', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T17:47:42.260' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Magetan', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Bogor', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Bandung', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Malang', 1, 1, CAST(N'2021-01-18T07:14:45.000' AS DateTime), 1, CAST(N'2021-01-18T07:14:53.060' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Jakarta', 1, 1, CAST(N'2021-01-18T16:33:09.063' AS DateTime), 1, CAST(N'2021-01-18T16:33:09.063' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Bangka Belitung', 1, 1, CAST(N'2021-01-18T16:33:27.247' AS DateTime), 1, CAST(N'2021-01-18T16:33:27.247' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Lombok', 1, 1, CAST(N'2021-01-18T16:33:37.700' AS DateTime), 1, CAST(N'2021-01-18T16:33:37.700' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, N'Makassar', 1, 1, CAST(N'2021-01-18T16:33:42.433' AS DateTime), 1, CAST(N'2021-01-18T16:33:42.433' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'Medan', 1, 1, CAST(N'2021-01-18T16:33:52.850' AS DateTime), 1, CAST(N'2021-01-18T16:33:52.850' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'Palembang', 1, 1, CAST(N'2021-01-18T16:34:00.003' AS DateTime), 1, CAST(N'2021-01-18T16:34:00.003' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'Semarang', 1, 1, CAST(N'2021-01-18T16:34:05.847' AS DateTime), 1, CAST(N'2021-01-18T16:34:05.847' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'Surabaya', 1, 1, CAST(N'2021-01-18T16:34:20.393' AS DateTime), 1, CAST(N'2021-01-18T16:34:20.393' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'Padang', 1, 1, CAST(N'2021-01-18T16:35:10.887' AS DateTime), 1, CAST(N'2021-01-18T16:35:10.887' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'Tasikmalaya', 1, 1, CAST(N'2021-01-18T16:35:29.657' AS DateTime), 1, CAST(N'2021-01-18T16:35:29.657' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, N'Bandar Lampung', 1, 1, CAST(N'2021-01-18T16:36:25.387' AS DateTime), 1, CAST(N'2021-01-18T16:36:25.387' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'Yogyakarta', 1, 1, CAST(N'2021-01-18T16:36:55.220' AS DateTime), 1, CAST(N'2021-01-18T16:36:55.220' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'Klaten', 1, 1, CAST(N'2021-01-18T16:36:59.997' AS DateTime), 1, CAST(N'2021-01-18T16:36:59.997' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'Sleman', 1, 1, CAST(N'2021-01-18T16:37:05.593' AS DateTime), 1, CAST(N'2021-01-18T16:37:05.593' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'Cimahi', 1, 1, CAST(N'2021-01-18T16:38:32.600' AS DateTime), 1, CAST(N'2021-01-18T16:38:32.600' AS DateTime))
SET IDENTITY_INSERT [dbo].[Kota] OFF
GO
SET IDENTITY_INSERT [dbo].[Paket] ON 

INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Paket Candi', 240000.0000, 5, 2, 0, NULL, N'Tes', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Paket Wisata Jatim 1', 370000.0000, 4, 2, 0, NULL, N'Berisi daerah di sekitar Jawa Timur', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T20:14:11.867' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Paket Wisata Jateng 1', 215000.0000, 4, 2, 0, NULL, N'Merupakan paket wisata jawa tengah 1', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T20:14:58.183' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'asd', NULL, 2, 1, 0, NULL, N'asd', 0, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'asd', NULL, 4, 2, 0, NULL, NULL, 0, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Paket Baru 2', NULL, 4, 2, 0, NULL, N'asd', 0, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Two Day Lembang Tour', 310000.0000, 4, 2, 0, NULL, N'Tidak ada', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T20:16:49.603' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'One Day Surabaya Tour', 125000.0000, 2, 1, 0, NULL, NULL, 1, 1, CAST(N'2021-01-18T20:16:10.383' AS DateTime), 1, CAST(N'2021-01-18T20:16:10.383' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Paket Ciwidey', 270000.0000, 4, 2, 0, NULL, NULL, 1, 1, CAST(N'2021-01-18T20:17:55.773' AS DateTime), 1, CAST(N'2021-01-18T20:17:55.773' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, N'Jogjakarta Overland 2D', 195000.0000, 4, 2, 0, NULL, N'Jogjakarta Overland
', 1, 1, CAST(N'2021-01-18T20:21:06.023' AS DateTime), 1, CAST(N'2021-01-18T20:21:06.023' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'Pulau Pari 2D', 305000.0000, 4, 2, 0, NULL, NULL, 1, 1, CAST(N'2021-01-18T20:21:46.540' AS DateTime), 1, CAST(N'2021-01-18T20:21:46.540' AS DateTime))
SET IDENTITY_INSERT [dbo].[Paket] OFF
GO
SET IDENTITY_INSERT [dbo].[Pegawai] ON 

INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (1, N'Samodra', N'Ponorogo', N'0812371283', N'samodra28@gmail.com', N'asd', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (2, N'Shifa Habibah Anl', N'Cirebon', N'08123178264123', N'shifa@gmail.com', N'shifa', 2, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (3, N'test', N'asd', N'01723781623', N'asd@gmail.com', N'asd', 2, 0, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (4, N'Test2', N'test', N'086123561235', N'test123@gmail.com', N'test', 2, 0, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (7, N'Hardiansah', N'Jimbe', N'0876512365', N'ansahkaco@gmail.com', N'ansah', 2, 1, CAST(N'2021-01-18T07:14:33.027' AS DateTime), CAST(N'2021-01-18T07:14:33.027' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (12, N'Rudi Septian', N'Tangerang', N'08127368123', N'rudis@gmail.com', N'rudi', 3, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (14, N'Wahyu Hidayat', N'Pasuruan', N'01237897123', N'samodra41@gmail.com', N'5DQFDUZO', 1, 1, CAST(N'2021-01-18T09:52:50.267' AS DateTime), CAST(N'2021-01-18T09:52:50.267' AS DateTime))
SET IDENTITY_INSERT [dbo].[Pegawai] OFF
GO
ALTER TABLE [dbo].[Customer] ADD  CONSTRAINT [DF_Customer_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Destinasi] ADD  CONSTRAINT [DF_Destinasi_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Detail_Kategori] ADD  CONSTRAINT [DF_Detail_Kategori_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Detail_Paket] ADD  CONSTRAINT [DF_Detail_Paket_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Detail_Rating_Destinasi] ADD  CONSTRAINT [DF_Detail_Rating_Destinasi_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Jenis_Kendaraan] ADD  CONSTRAINT [DF_Jenis_Kendaraan_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Kategori_Wilayah] ADD  CONSTRAINT [DF_Kategori_Wilayah_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Kendaraan] ADD  CONSTRAINT [DF_Kendaraan_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Kota] ADD  CONSTRAINT [DF_Kota_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Paket] ADD  CONSTRAINT [DF_Paket_Harga]  DEFAULT ((0)) FOR [Harga]
GO
ALTER TABLE [dbo].[Paket] ADD  CONSTRAINT [DF_Paket_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Pegawai] ADD  CONSTRAINT [DF_Pegawai_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Destinasi]  WITH CHECK ADD  CONSTRAINT [FK_Destinasi_Kota] FOREIGN KEY([ID_Kota])
REFERENCES [dbo].[Kota] ([ID_Kota])
GO
ALTER TABLE [dbo].[Destinasi] CHECK CONSTRAINT [FK_Destinasi_Kota]
GO
ALTER TABLE [dbo].[Destinasi]  WITH CHECK ADD  CONSTRAINT [FK_Destinasi_Pegawai] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Destinasi] CHECK CONSTRAINT [FK_Destinasi_Pegawai]
GO
ALTER TABLE [dbo].[Destinasi]  WITH CHECK ADD  CONSTRAINT [FK_Destinasi_Pegawai1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Destinasi] CHECK CONSTRAINT [FK_Destinasi_Pegawai1]
GO
ALTER TABLE [dbo].[Detail_Foto]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Foto_Destinasi] FOREIGN KEY([ID_Destinasi])
REFERENCES [dbo].[Destinasi] ([ID_Destinasi])
GO
ALTER TABLE [dbo].[Detail_Foto] CHECK CONSTRAINT [FK_Detail_Foto_Destinasi]
GO
ALTER TABLE [dbo].[Detail_Kategori]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Kategori_Kategori_Wilayah] FOREIGN KEY([ID_KategoriWilayah])
REFERENCES [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah])
GO
ALTER TABLE [dbo].[Detail_Kategori] CHECK CONSTRAINT [FK_Detail_Kategori_Kategori_Wilayah]
GO
ALTER TABLE [dbo].[Detail_Kategori]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Kategori_Kota] FOREIGN KEY([ID_Kota])
REFERENCES [dbo].[Kota] ([ID_Kota])
GO
ALTER TABLE [dbo].[Detail_Kategori] CHECK CONSTRAINT [FK_Detail_Kategori_Kota]
GO
ALTER TABLE [dbo].[Detail_Paket]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Paket_Destinasi] FOREIGN KEY([ID_Destinasi])
REFERENCES [dbo].[Destinasi] ([ID_Destinasi])
GO
ALTER TABLE [dbo].[Detail_Paket] CHECK CONSTRAINT [FK_Detail_Paket_Destinasi]
GO
ALTER TABLE [dbo].[Detail_Paket]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Paket_Paket] FOREIGN KEY([ID_Paket])
REFERENCES [dbo].[Paket] ([ID_Paket])
GO
ALTER TABLE [dbo].[Detail_Paket] CHECK CONSTRAINT [FK_Detail_Paket_Paket]
GO
ALTER TABLE [dbo].[Detail_Rating_Destinasi]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Rating_Destinasi_Customer] FOREIGN KEY([NIK])
REFERENCES [dbo].[Customer] ([NIK])
GO
ALTER TABLE [dbo].[Detail_Rating_Destinasi] CHECK CONSTRAINT [FK_Detail_Rating_Destinasi_Customer]
GO
ALTER TABLE [dbo].[Detail_Rating_Destinasi]  WITH CHECK ADD  CONSTRAINT [FK_Detail_Rating_Destinasi_Destinasi] FOREIGN KEY([ID_Destinasi])
REFERENCES [dbo].[Destinasi] ([ID_Destinasi])
GO
ALTER TABLE [dbo].[Detail_Rating_Destinasi] CHECK CONSTRAINT [FK_Detail_Rating_Destinasi_Destinasi]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Transaksi] FOREIGN KEY([ID_Transaksi])
REFERENCES [dbo].[Transaksi] ([ID_Transaksi])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Transaksi]
GO
ALTER TABLE [dbo].[Jenis_Kendaraan]  WITH CHECK ADD  CONSTRAINT [FK_Jenis_Kendaraan_Pegawai] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Jenis_Kendaraan] CHECK CONSTRAINT [FK_Jenis_Kendaraan_Pegawai]
GO
ALTER TABLE [dbo].[Jenis_Kendaraan]  WITH CHECK ADD  CONSTRAINT [FK_Jenis_Kendaraan_Pegawai1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Jenis_Kendaraan] CHECK CONSTRAINT [FK_Jenis_Kendaraan_Pegawai1]
GO
ALTER TABLE [dbo].[Kategori_Wilayah]  WITH CHECK ADD  CONSTRAINT [FK_Kategori_Wilayah_Pegawai] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Kategori_Wilayah] CHECK CONSTRAINT [FK_Kategori_Wilayah_Pegawai]
GO
ALTER TABLE [dbo].[Kategori_Wilayah]  WITH CHECK ADD  CONSTRAINT [FK_Kategori_Wilayah_Pegawai1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Kategori_Wilayah] CHECK CONSTRAINT [FK_Kategori_Wilayah_Pegawai1]
GO
ALTER TABLE [dbo].[Kendaraan]  WITH CHECK ADD  CONSTRAINT [FK_Kendaraan_Jenis_Kendaraan] FOREIGN KEY([ID_Jenis])
REFERENCES [dbo].[Jenis_Kendaraan] ([ID_Jenis])
GO
ALTER TABLE [dbo].[Kendaraan] CHECK CONSTRAINT [FK_Kendaraan_Jenis_Kendaraan]
GO
ALTER TABLE [dbo].[Kendaraan]  WITH CHECK ADD  CONSTRAINT [FK_Kendaraan_Pegawai] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Kendaraan] CHECK CONSTRAINT [FK_Kendaraan_Pegawai]
GO
ALTER TABLE [dbo].[Kendaraan]  WITH CHECK ADD  CONSTRAINT [FK_Kendaraan_Pegawai1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Kendaraan] CHECK CONSTRAINT [FK_Kendaraan_Pegawai1]
GO
ALTER TABLE [dbo].[Kota]  WITH CHECK ADD  CONSTRAINT [FK_Kota_Pegawai] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Kota] CHECK CONSTRAINT [FK_Kota_Pegawai]
GO
ALTER TABLE [dbo].[Kota]  WITH CHECK ADD  CONSTRAINT [FK_Kota_Pegawai1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Kota] CHECK CONSTRAINT [FK_Kota_Pegawai1]
GO
ALTER TABLE [dbo].[Paket]  WITH CHECK ADD  CONSTRAINT [FK_Paket_Pegawai] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Paket] CHECK CONSTRAINT [FK_Paket_Pegawai]
GO
ALTER TABLE [dbo].[Paket]  WITH CHECK ADD  CONSTRAINT [FK_Paket_Pegawai1] FOREIGN KEY([ModifiedBy])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Paket] CHECK CONSTRAINT [FK_Paket_Pegawai1]
GO
ALTER TABLE [dbo].[Transaksi]  WITH CHECK ADD  CONSTRAINT [FK_Transaksi_Customer] FOREIGN KEY([ID_Customer])
REFERENCES [dbo].[Customer] ([NIK])
GO
ALTER TABLE [dbo].[Transaksi] CHECK CONSTRAINT [FK_Transaksi_Customer]
GO
ALTER TABLE [dbo].[Transaksi]  WITH CHECK ADD  CONSTRAINT [FK_Transaksi_Paket] FOREIGN KEY([ID_Paket])
REFERENCES [dbo].[Paket] ([ID_Paket])
GO
ALTER TABLE [dbo].[Transaksi] CHECK CONSTRAINT [FK_Transaksi_Paket]
GO
ALTER TABLE [dbo].[Transaksi]  WITH CHECK ADD  CONSTRAINT [FK_Transaksi_Pegawai] FOREIGN KEY([ID_Pegawai])
REFERENCES [dbo].[Pegawai] ([ID_Pegawai])
GO
ALTER TABLE [dbo].[Transaksi] CHECK CONSTRAINT [FK_Transaksi_Pegawai]
GO
ALTER TABLE [dbo].[Transaksi_Kendaraan]  WITH CHECK ADD  CONSTRAINT [FK_Transaksi_Kendaraan_Kendaraan] FOREIGN KEY([ID_Kendaraan])
REFERENCES [dbo].[Kendaraan] ([ID_Kendaraan])
GO
ALTER TABLE [dbo].[Transaksi_Kendaraan] CHECK CONSTRAINT [FK_Transaksi_Kendaraan_Kendaraan]
GO
ALTER TABLE [dbo].[Transaksi_Kendaraan]  WITH CHECK ADD  CONSTRAINT [FK_Transaksi_Kendaraan_Transaksi] FOREIGN KEY([ID_Transaksi])
REFERENCES [dbo].[Transaksi] ([ID_Transaksi])
GO
ALTER TABLE [dbo].[Transaksi_Kendaraan] CHECK CONSTRAINT [FK_Transaksi_Kendaraan_Transaksi]
GO
/****** Object:  Trigger [dbo].[Tr_DeleteDetailPaket]    Script Date: 1/18/2021 8:33:44 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Tr_DeleteDetailPaket]
	ON [dbo].[Detail_Paket]
	FOR DELETE
AS
BEGIN
	UPDATE Paket SET 
	Harga = (30000 * Konsumsi) + (SELECT SUM(d.Harga_Tiket) FROM 
	Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
	WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM deleted i))
	WHERE ID_Paket = (SELECT i.ID_Paket FROM deleted i)
END
GO
ALTER TABLE [dbo].[Detail_Paket] ENABLE TRIGGER [Tr_DeleteDetailPaket]
GO
/****** Object:  Trigger [dbo].[Tr_InsertDetailPaket]    Script Date: 1/18/2021 8:33:45 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Tr_InsertDetailPaket]
	ON [dbo].[Detail_Paket]
	FOR INSERT, DELETE
AS
BEGIN
	UPDATE Paket SET 
	Harga = (30000 * Konsumsi) + (SELECT SUM(d.Harga_Tiket) FROM 
	Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
	WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM inserted i))
	WHERE ID_Paket = (SELECT i.ID_Paket FROM inserted i)
END
GO
ALTER TABLE [dbo].[Detail_Paket] ENABLE TRIGGER [Tr_InsertDetailPaket]
GO
USE [master]
GO
ALTER DATABASE [BUSS] SET  READ_WRITE 
GO
