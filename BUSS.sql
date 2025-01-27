USE [master]
GO
/****** Object:  Database [BUSS]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetFoto]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnGetFoto] (
	@ID_Paket int
  )
  RETURNS VARCHAR(255)
  BEGIN
	DECLARE @a VARCHAR(255);
	
	SET @a = (SELECT TOP 1 df.Foto FROM Detail_Paket dp JOIN Detail_Foto df ON df.ID_Destinasi = dp.ID_Destinasi WHERE dp.ID_Paket = @ID_Paket)
	RETURN @a
  END
GO
/****** Object:  Table [dbo].[Transaksi]    Script Date: 2/17/2021 8:39:15 PM ******/
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
	[biaya_tambahan] [money] NULL,
	[Status_Transaksi] [int] NOT NULL,
	[PaketLama_Perjalanan] [float] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Transaksi] PRIMARY KEY CLUSTERED 
(
	[ID_Transaksi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_DashboardCustomer]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_DashboardCustomer] AS
SELECT CONVERT(date, t.CreatedDate) as tgl, t.ID_Customer, COUNT(*) as jumlah FROM Transaksi t
GROUP BY CONVERT(date, t.CreatedDate), t.ID_Customer
GO
/****** Object:  Table [dbo].[Paket]    Script Date: 2/17/2021 8:39:15 PM ******/
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
	[Penginapan] [int] NOT NULL,
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
/****** Object:  View [dbo].[view_TransaksiCount]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_TransaksiCount] AS
SELECT p.ID_Paket, p.Nama_Paket, COUNT(*) as jumlah_dipesan
FROM Transaksi t JOIN Paket p ON t.ID_Paket = p.ID_Paket
GROUP BY p.Nama_Paket, p.ID_Paket
GO
/****** Object:  Table [dbo].[Destinasi]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  Table [dbo].[Kategori_Wilayah]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  Table [dbo].[Kota]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  Table [dbo].[Detail_Kategori]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  View [dbo].[view_JumlahDestinasiWilayah]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_JumlahDestinasiWilayah] AS
SELECT kw.ID_KategoriWilayah, kw.Nama_Wilayah, COUNT(*) as JumlahDestinasi
FROM Detail_Kategori dk JOIN Kategori_Wilayah kw ON dk.ID_KategoriWilayah = kw.ID_KategoriWilayah
JOIN Kota k ON k.ID_Kota = dk.ID_Kota JOIN Destinasi d ON d.ID_Kota = k.ID_Kota
GROUP BY kw.Nama_Wilayah, kw.ID_KategoriWilayah
GO
/****** Object:  Table [dbo].[Detail_Paket]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  View [dbo].[view_DestinasiTerlaris]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_DestinasiTerlaris] AS
SELECT dp.ID_Destinasi, Nama_Destinasi, COUNT(*) as JumlahDipesan
FROM Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi
GROUP BY dp.ID_Destinasi, Nama_Destinasi
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  View [dbo].[view_LaporanTransaksi]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_LaporanTransaksi] AS
SELECT t.*, p.Nama_Paket, p.Jadwal, p.Lama_Perjalanan, c.Nama, c.Alamat, c.No_HP, c.Email FROM Transaksi t
JOIN Paket p ON p.ID_Paket = t.ID_Paket
JOIN Customer c ON t.ID_Customer = c.NIK
GO
/****** Object:  View [dbo].[view_LaporanDestinasi]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_LaporanDestinasi] AS
SELECT d.*, k.Nama_Kota FROM Destinasi d
JOIN Kota k ON d.ID_Kota = k.ID_Kota
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[ID_Feedback] [int] IDENTITY(1,1) NOT NULL,
	[ID_Transaksi] [int] NOT NULL,
	[Rating] [float] NOT NULL,
	[Isi_Feedback] [text] NULL,
	[CreatedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Feedback] PRIMARY KEY CLUSTERED 
(
	[ID_Feedback] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_LaporanFeedback]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_LaporanFeedback] AS
SELECT f.*, p.Nama_Paket, p.Lama_Perjalanan, t.Tanggal_Pesanan, c.Nama, c.Alamat, c.Email FROM Feedback f
JOIN Transaksi t ON f.ID_Transaksi = t.ID_Transaksi
JOIN Paket p ON p.ID_Paket = t.ID_Paket
JOIN Customer c ON c.NIK = t.ID_Customer
GO
/****** Object:  View [dbo].[view_StatusTransCount]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[view_StatusTransCount] as
SELECT Status_Transaksi,
CASE
    WHEN Status_Transaksi = 0 THEN 'Menunggu Pembayaran DP'
    WHEN Status_Transaksi = 1 THEN 'Pembayaran DP diproses'
  WHEN Status_Transaksi = 2 THEN 'Menunggu Pelunasan'
    WHEN Status_Transaksi = 3 THEN 'Pelunasan diproses'
  WHEN Status_Transaksi = 4 THEN 'Lunas'
    WHEN Status_Transaksi = 5 THEN 'Selesai'
  WHEN Status_Transaksi = 6 THEN 'Feedback'
    ELSE 'Dibatalkan'
END AS StatusTrans, Count(*) as jumlah
from Transaksi group by Status_Transaksi
GO
/****** Object:  View [dbo].[view_PaketHome]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_PaketHome] AS
  SELECT p.ID_Paket, p.Nama_Paket, p.Harga, ISNULL(AVG(CAST(f.Rating as Float)), 0) 'Rating', COUNT(f.Rating) 'JumlahRate', ISNULL(dbo.fnGetFoto(p.ID_Paket), 'default.jpg') 'Foto', p.Status
  FROM Feedback f
  JOIN Transaksi t ON f.ID_Transaksi = t.ID_Transaksi RIGHT JOIN 
  Paket p ON t.ID_Paket = p.ID_Paket JOIN Detail_Paket dp ON p.ID_Paket = dp.ID_Paket
  WHERE Harga IS NOT NULL
  GROUP BY p.ID_Paket, p.Nama_Paket, p.Harga, p.Status
GO
/****** Object:  View [dbo].[view_TransaksiAdmin]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_TransaksiAdmin] AS
SELECT TOP (1000) [ID_Transaksi]
    ,[ID_Customer]
    ,[ID_Pegawai]
    ,[Harga_total]
    ,[Jumlah_Penumpang]
    ,[Tanggal_Pesanan]
    ,[Bukti_DP]
    ,[Bukti_Pelunasan]
    ,[biaya_tambahan]
    ,[Status_Transaksi]
    ,[PaketLama_Perjalanan]
    ,t.CreatedDate 'CreatedDateTr', p.*
FROM [BUSS].[dbo].[Transaksi] t
JOIN Paket p ON t.ID_Paket = p.ID_Paket
ORDER BY case when Status_Transaksi = 1 then 1
    when Status_Transaksi = 3 then 2
    when Status_Transaksi = 4 then 3
    else 4
end asc, Status_Transaksi asc
GO
/****** Object:  View [dbo].[view_TransaksiCustomer]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_TransaksiCustomer] AS
SELECT TOP (1000) [ID_Transaksi]
    ,[ID_Customer]
    ,[ID_Pegawai]
    ,[Harga_total]
    ,[Jumlah_Penumpang]
    ,[Tanggal_Pesanan]
    ,[Bukti_DP]
    ,[Bukti_Pelunasan]
    ,[biaya_tambahan]
    ,[Status_Transaksi]
    ,[PaketLama_Perjalanan]
    ,t.CreatedDate 'CreatedDateTr', p.*
FROM [BUSS].[dbo].[Transaksi] t
JOIN Paket p ON t.ID_Paket = p.ID_Paket
ORDER BY case when Status_Transaksi = 0 then 1
    when Status_Transaksi = 2 then 2
    when Status_Transaksi = 5 then 3
    else 4
end asc, Status_Transaksi asc
GO
/****** Object:  Table [dbo].[Detail_Foto]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  Table [dbo].[Detail_Rating_Destinasi]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Detail_Rating_Destinasi](
	[NIK] [varchar](16) NOT NULL,
	[ID_Destinasi] [int] NOT NULL,
	[Rating] [float] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Detail_Rating_Destinasi] PRIMARY KEY CLUSTERED 
(
	[NIK] ASC,
	[ID_Destinasi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jenis_Kendaraan]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  Table [dbo].[Kendaraan]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  Table [dbo].[Pegawai]    Script Date: 2/17/2021 8:39:15 PM ******/
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
/****** Object:  Table [dbo].[Transaksi_Kendaraan]    Script Date: 2/17/2021 8:39:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaksi_Kendaraan](
	[ID_Transaksi] [int] NOT NULL,
	[ID_Kendaraan] [int] NOT NULL,
	[Status] [int] NOT NULL,
 CONSTRAINT [PK_Transaksi_Kendaraan] PRIMARY KEY CLUSTERED 
(
	[ID_Transaksi] ASC,
	[ID_Kendaraan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'0812365231231231', N'Rika Dwi ', N'Madiun', N'081263517623', N'rika@gmail.com', N'asd', CAST(N'2021-02-12T15:20:38.770' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'0912830182390819', N'Oktavian', N'Balong', N'01923781723', N'okta@gmail.com', N'asdasd', CAST(N'2021-02-12T16:02:07.997' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123400', N'Tes', N'Surabaya', N'0817263123', N'test@gmail.com', N'test', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123450', N'Rifai', N'Tegal', N'089752435123', N'asdasd@gmail.com', N'asd', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123451', N'U', N'sdf', N'131234', N'asdasd@gfmail.com', N'asd', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123452', N'Sukarno', N'Purwokerto', N'0867651254364', N'suk@gmail.com', N'suk', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123454', N'asdzxc', N'asdasd', N'08123561423', N'asdasd@asd.com', N'asdasd', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123456', N'Satria', N'Jakarta', N'131234124', N'asd@gmail.com', N'asd', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123458', N'Andi Malarangeng', N'Jl. Andi no 89', N'08123867123', N'andi@gmail.com', N'andi', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1234567890123459', N'Yudi', N'asdasd', N'019236717239', N'yudi@gmail.com', N'yudi', CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1238712387192379', N'Teddy', N'Pemalang', N'01273891723', N'teddy@gmail.com', N'teddy', CAST(N'2021-02-08T13:34:55.250' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1283718723126366', N'Sunu Surya', N'Yogyakarta', N'0182378123123', N'sunu@gmail.com', N'asd', CAST(N'2021-02-08T15:12:33.593' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1623781623781623', N'Sulistyani', N'Ponorogo', N'0812376127363', N'sulistyani@gmail.com', N'Samodra', CAST(N'2021-02-06T06:54:25.607' AS DateTime))
INSERT [dbo].[Customer] ([NIK], [Nama], [Alamat], [No_HP], [Email], [Password], [CreatedDate]) VALUES (N'1892312739871231', N'testasd', N'testasd', N'081723567123', N'asd123@gmail.com', N'asd', CAST(N'2021-02-12T08:56:19.793' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Destinasi] ON 

INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Kawah Putih', 50000.0000, 3, 4.5, CAST(N'09:14:00' AS Time), CAST(N'21:14:00' AS Time), N'asd', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T16:39:15.350' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Ancol', 50000.0000, 7, 4, CAST(N'21:20:00' AS Time), CAST(N'21:20:00' AS Time), N'asd', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T18:51:17.410' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Pantai Kelingking', 15000.0000, 3, 3.5, CAST(N'21:30:00' AS Time), CAST(N'21:30:00' AS Time), N'zxc', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Gunung Bromo', 40000.0000, 2, 3.5, CAST(N'06:40:00' AS Time), CAST(N'13:40:00' AS Time), N'Ok', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Candi Prambanan', 65000.0000, 2, 4, CAST(N'06:17:00' AS Time), CAST(N'14:17:00' AS Time), N'test', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T16:39:04.297' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Brumbun Tubing', 40000.0000, 5, 4, CAST(N'06:00:00' AS Time), CAST(N'22:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T06:50:51.303' AS DateTime), 1, CAST(N'2021-01-18T06:50:51.303' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Tangkuban Perahu', 50000.0000, 5, 4.5, CAST(N'07:00:00' AS Time), CAST(N'08:48:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T07:48:45.383' AS DateTime), 1, CAST(N'2021-01-18T07:48:45.383' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Kampung Daun', 50000.0000, 5, 3, CAST(N'07:00:00' AS Time), CAST(N'22:00:00' AS Time), N'Mencicipi sajian wisata kuliner daun ', 1, 1, CAST(N'2021-01-18T16:31:34.223' AS DateTime), 1, CAST(N'2021-01-18T16:31:34.223' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Mutun Beach', 70000.0000, 17, 4, CAST(N'05:00:00' AS Time), CAST(N'19:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T19:02:10.590' AS DateTime), 1, CAST(N'2021-01-18T19:02:10.590' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, N'Pantai Tanjung Tinggi', 100000.0000, 8, 3, CAST(N'06:00:00' AS Time), CAST(N'19:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T19:04:08.650' AS DateTime), 1, CAST(N'2021-01-18T19:04:08.650' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'Mekarsari Fruit Garden', 100000.0000, 2, 4, CAST(N'08:00:00' AS Time), CAST(N'22:00:00' AS Time), N'Mekarsari Fruit Garden
', 1, 1, CAST(N'2021-01-18T19:05:37.720' AS DateTime), 1, CAST(N'2021-01-18T19:05:37.720' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'Bogor Botanical Garden', 50000.0000, 4, 3.5, CAST(N'09:00:00' AS Time), CAST(N'21:00:00' AS Time), N'Bogor Botanical Garden', 1, 1, CAST(N'2021-01-18T19:06:58.447' AS DateTime), 1, CAST(N'2021-01-18T19:06:58.447' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'Jendela Alam', 50000.0000, 21, 4, CAST(N'06:30:00' AS Time), CAST(N'19:30:00' AS Time), N'Rumah Jendela Alam', 1, 1, CAST(N'2021-01-18T19:53:09.020' AS DateTime), 1, CAST(N'2021-01-18T19:53:09.020' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'Kebun Binatang Ragunan', 10000.0000, 7, 4, CAST(N'09:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Kebun binatang ragunan', 1, 1, CAST(N'2021-01-18T19:54:47.667' AS DateTime), 1, CAST(N'2021-01-18T19:54:47.667' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'Candi Sojiwan', 25000.0000, 19, 4, CAST(N'06:00:00' AS Time), CAST(N'17:00:00' AS Time), N'Candi Seribu', 0, 1, CAST(N'2021-01-18T19:56:43.400' AS DateTime), 1, CAST(N'2021-01-18T19:56:43.400' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'Telaga Sarangan', 50000.0000, 3, 4, CAST(N'06:00:00' AS Time), CAST(N'20:00:00' AS Time), N'Telaga Sarangan', 1, 1, CAST(N'2021-01-18T19:59:24.437' AS DateTime), 1, CAST(N'2021-01-18T19:59:24.437' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, N'Fort Rotterdam', 65000.0000, 10, 4, CAST(N'06:00:00' AS Time), CAST(N'20:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:00:24.070' AS DateTime), 1, CAST(N'2021-01-18T20:00:24.070' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'Jawa Timur Park 3', 150000.0000, 6, 4, CAST(N'06:01:00' AS Time), CAST(N'20:01:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:01:39.033' AS DateTime), 1, CAST(N'2021-01-18T20:01:39.033' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'Museum Ullen Sentalu', 45000.0000, 20, 4, CAST(N'08:02:00' AS Time), CAST(N'20:02:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:02:57.800' AS DateTime), 1, CAST(N'2021-01-18T20:02:57.800' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'Lawang Sewu', 25000.0000, 13, 4, CAST(N'12:03:00' AS Time), CAST(N'20:03:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:04:04.947' AS DateTime), 1, CAST(N'2021-01-18T20:04:04.947' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'Monumen Pahlawan', 25000.0000, 14, 4, CAST(N'08:00:00' AS Time), CAST(N'20:00:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:05:04.747' AS DateTime), 1, CAST(N'2021-01-18T20:05:04.747' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'Taman Wisata Karang Resik', 50000.0000, 16, 4, CAST(N'08:06:00' AS Time), CAST(N'18:06:00' AS Time), NULL, 1, 1, CAST(N'2021-01-18T20:06:52.803' AS DateTime), 1, CAST(N'2021-01-18T20:06:52.803' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (23, N'Telaga Ngebel', 20000.0000, 23, 0, CAST(N'04:00:00' AS Time), CAST(N'18:00:00' AS Time), N'Ini merupakan telaga ngebel', 1, 1, CAST(N'2021-02-05T23:14:04.000' AS DateTime), 1, CAST(N'2021-02-05T23:15:30.860' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (24, N'Batu Raden', 20000.0000, 26, 0, CAST(N'10:00:00' AS Time), CAST(N'17:00:00' AS Time), N'-', 0, 20, CAST(N'2021-02-08T12:12:36.000' AS DateTime), 20, CAST(N'2021-02-08T12:14:44.307' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (25, N'Batu Kawah Selatan', 50000.0000, 5, 0, CAST(N'06:00:00' AS Time), CAST(N'17:00:00' AS Time), N'-', 0, 1, CAST(N'2021-02-08T15:02:30.000' AS DateTime), 1, CAST(N'2021-02-08T15:03:44.670' AS DateTime))
INSERT [dbo].[Destinasi] ([ID_Destinasi], [Nama_Destinasi], [Harga_Tiket], [ID_Kota], [Rating], [Jam_buka], [Jam_tutup], [Deskripsi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (26, N'Kawah Putih Bagian Utara', 85000.0000, 11, 0, CAST(N'06:30:00' AS Time), CAST(N'17:00:00' AS Time), N'Wisata Batu Raden', 0, 1, CAST(N'2021-02-12T15:11:25.000' AS DateTime), 1, CAST(N'2021-02-12T15:12:58.393' AS DateTime))
SET IDENTITY_INSERT [dbo].[Destinasi] OFF
GO
SET IDENTITY_INSERT [dbo].[Detail_Foto] ON 

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
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (32, 1, N'202101182202000.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (33, 23, N'202102052315030.jpeg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (35, 24, N'202102081213171.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (36, 25, N'202102081502570.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (38, 26, N'202102121511510.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (39, 26, N'202102121512020.jpg')
INSERT [dbo].[Detail_Foto] ([ID_Detail], [ID_Destinasi], [Foto]) VALUES (41, 2, N'202102121512350.jpg')
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
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (5, 3, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (5, 6, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (6, 8, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (7, 7, 0)
INSERT [dbo].[Detail_Kategori] ([ID_KategoriWilayah], [ID_Kota], [Status]) VALUES (8, 20, 0)
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
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (13, 2, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (14, 4, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (14, 5, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (14, 11, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (15, 4, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (15, 5, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (15, 11, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (16, 4, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (16, 5, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (17, 19, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (18, 23, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (19, 5, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (20, 11, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (21, 4, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (21, 5, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (22, 1, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (23, 4, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (23, 5, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (24, 4, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (24, 5, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (25, 6, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (25, 7, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (25, 8, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (26, 5, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (27, 4, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (27, 5, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (27, 11, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (28, 20, 0)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (29, 4, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (29, 5, 1)
INSERT [dbo].[Detail_Paket] ([ID_Paket], [ID_Destinasi], [Status]) VALUES (29, 11, 1)
GO
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123450', 1, 4, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123450', 2, 4, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123450', 4, 4, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123450', 6, 4, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123450', 7, 4, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123450', 8, 3, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123450', 10, 3, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123450', 12, 4, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123452', 4, 3, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123452', 12, 3, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123456', 2, 5, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123459', 1, 5, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123459', 2, 4, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123459', 3, 3, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123459', 5, 3, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1234567890123459', 6, 4, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1623781623781623', 3, 4, 0)
INSERT [dbo].[Detail_Rating_Destinasi] ([NIK], [ID_Destinasi], [Rating], [Status]) VALUES (N'1623781623781623', 7, 5, 0)
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (2, 7, 5, N'Pelayanan memuaskan', CAST(N'2021-01-21T16:10:22.967' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (3, 9, 5, N'Pelayanan Bagus', CAST(N'2021-01-22T13:32:21.263' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (4, 9, 3, N'Pelayanan Buruk', CAST(N'2021-01-22T13:33:13.323' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (5, 10, 4, N'Pelayanan Bagus', CAST(N'2021-01-22T13:48:12.000' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (6, 11, 4, N'Pelayanan Memuaskan', CAST(N'2021-01-25T14:24:02.660' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (8, 17, 4, N'Percobaan yang bagus', CAST(N'2021-02-06T07:23:58.270' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (9, 23, 4, N'asd', CAST(N'2021-02-08T14:26:28.267' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (10, 3, 5, N'asd', CAST(N'2021-02-08T14:26:42.917' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (11, 5, 4, N'Bagus', CAST(N'2021-02-08T15:20:15.253' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (12, 3, 5, N'Bagus', CAST(N'2021-02-12T11:20:45.507' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (13, 25, 5, N'Bagus hari ini tgl 12', CAST(N'2021-02-12T11:26:44.533' AS DateTime))
INSERT [dbo].[Feedback] ([ID_Feedback], [ID_Transaksi], [Rating], [Isi_Feedback], [CreatedDate]) VALUES (14, 5, 5, N'Pelayanan Memuaskan', CAST(N'2021-02-12T16:07:56.753' AS DateTime))
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[Jenis_Kendaraan] ON 

INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Bus Besar', 45, 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T07:18:52.737' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Bus Kecil', 30, 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Ok', 4, 0, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Travel', 15, 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Test', 123, 0, 1, CAST(N'2021-01-18T07:19:23.583' AS DateTime), 1, CAST(N'2021-01-18T07:19:23.583' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Bus A', 40, 0, 1, CAST(N'2021-02-05T23:16:13.000' AS DateTime), 1, CAST(N'2021-02-05T23:16:23.640' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Jet Bus (Bisnis)', 32, 0, 20, CAST(N'2021-02-08T12:17:25.000' AS DateTime), 20, CAST(N'2021-02-08T12:18:09.270' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Jetbus ', 35, 0, 1, CAST(N'2021-02-08T15:04:40.000' AS DateTime), 1, CAST(N'2021-02-08T15:05:04.413' AS DateTime))
INSERT [dbo].[Jenis_Kendaraan] ([ID_Jenis], [Nama_Jenis], [Jumlah_Kursi], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Jetbus Slow', 75, 0, 1, CAST(N'2021-02-12T15:14:29.000' AS DateTime), 1, CAST(N'2021-02-12T15:14:45.380' AS DateTime))
SET IDENTITY_INSERT [dbo].[Jenis_Kendaraan] OFF
GO
SET IDENTITY_INSERT [dbo].[Kategori_Wilayah] ON 

INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Jakarta dan sekitarnya', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Jogjakarta dan sekitarnya', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 20, CAST(N'2021-02-08T12:03:42.890' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Lampung dan sekitarnya', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T07:16:50.563' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Bandung dan sekitarnya', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Ponorogo dan sekitarnya', 1, 1, CAST(N'2021-02-05T23:11:29.000' AS DateTime), 1, CAST(N'2021-02-05T23:12:54.110' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Pulau Bangka', 1, 20, CAST(N'2021-02-08T12:02:40.780' AS DateTime), 20, CAST(N'2021-02-08T12:02:40.780' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Pulau Seratus', 0, 1, CAST(N'2021-02-08T14:59:20.000' AS DateTime), 1, CAST(N'2021-02-08T15:01:00.197' AS DateTime))
INSERT [dbo].[Kategori_Wilayah] ([ID_KategoriWilayah], [Nama_Wilayah], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'Nganjuk  dan Sekitarnya', 0, 1, CAST(N'2021-02-12T15:08:13.000' AS DateTime), 1, CAST(N'2021-02-12T15:09:15.030' AS DateTime))
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
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'YM Transport', 2, N'T 9837 O', 500000.0000, 0, 1, CAST(N'2021-01-18T20:12:36.690' AS DateTime), 1, CAST(N'2021-01-18T20:12:36.690' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (12, N'Alpha One', 2, N'AE 1058 DB', 950000.0000, 0, 1, CAST(N'2021-02-05T23:18:19.000' AS DateTime), 1, CAST(N'2021-02-05T23:18:25.717' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'Trans Bus', 1, N'BA 9823 EC', 500000.0000, 0, 1, CAST(N'2021-02-08T13:20:12.000' AS DateTime), 1, CAST(N'2021-02-08T13:20:56.877' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'Alpha Three', 4, N'AE 8723 EF', 500000.0000, 0, 1, CAST(N'2021-02-08T15:06:08.000' AS DateTime), 1, CAST(N'2021-02-08T15:06:28.317' AS DateTime))
INSERT [dbo].[Kendaraan] ([ID_Kendaraan], [Nama_Kendaraan], [ID_Jenis], [No_Kendaraan], [Harga_kendaraan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'Alpha Five', 1, N'AB 9863 EF', 750000.0000, 0, 1, CAST(N'2021-02-12T15:15:34.000' AS DateTime), 1, CAST(N'2021-02-12T15:15:53.003' AS DateTime))
SET IDENTITY_INSERT [dbo].[Kendaraan] OFF
GO
SET IDENTITY_INSERT [dbo].[Kota] ON 

INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Bekasi', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T17:47:42.260' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Magetan', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'Bogor', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'Bandung', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-02-05T23:11:00.247' AS DateTime))
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
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, N'Bandar Lampung', 0, 1, CAST(N'2021-01-18T16:36:25.387' AS DateTime), 1, CAST(N'2021-01-18T16:36:25.387' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'Yogyakarta', 1, 1, CAST(N'2021-01-18T16:36:55.000' AS DateTime), 20, CAST(N'2021-02-08T11:55:38.657' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'Klaten', 1, 1, CAST(N'2021-01-18T16:36:59.997' AS DateTime), 1, CAST(N'2021-01-18T16:36:59.997' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'Sleman', 1, 1, CAST(N'2021-01-18T16:37:05.593' AS DateTime), 1, CAST(N'2021-01-18T16:37:05.593' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'Cimahi', 1, 1, CAST(N'2021-01-18T16:38:32.600' AS DateTime), 1, CAST(N'2021-01-18T16:38:32.600' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'Nganjuk', 0, 1, CAST(N'2021-02-05T22:43:42.290' AS DateTime), 1, CAST(N'2021-02-05T22:43:42.290' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (23, N'Ponorogo', 1, 1, CAST(N'2021-02-05T23:13:22.430' AS DateTime), 1, CAST(N'2021-02-05T23:13:22.430' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (26, N'Purwakarta', 1, 20, CAST(N'2021-02-08T12:10:58.000' AS DateTime), 1, CAST(N'2021-02-08T14:58:17.353' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (27, N'Banyuwangi', 0, 1, CAST(N'2021-02-08T14:57:30.907' AS DateTime), 1, CAST(N'2021-02-08T14:57:30.907' AS DateTime))
INSERT [dbo].[Kota] ([ID_Kota], [Nama_Kota], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (28, N'Madura', 0, 1, CAST(N'2021-02-12T15:06:58.000' AS DateTime), 1, CAST(N'2021-02-12T15:07:19.377' AS DateTime))
SET IDENTITY_INSERT [dbo].[Kota] OFF
GO
SET IDENTITY_INSERT [dbo].[Paket] ON 

INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (1, N'Paket Candi', 240000.0000, 5, 2, 1, 0, N'20210125140924.xlsx', N'Tes', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (2, N'Paket Wisata Jatim 1', 420000.0000, 4, 2, 1, 0, N'20210208152143.pdf', N'Berisi daerah di sekitar Jawa Timur', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T20:14:11.867' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (3, N'Paket Wisata Jateng 1', 215000.0000, 4, 2, 1, 0, N'20210122112643.xlsx', N'Merupakan paket wisata jawa tengah 1', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T20:14:58.183' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (4, N'asd', NULL, 2, 1, 1, 0, NULL, N'asd', 0, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (5, N'asd', NULL, 4, 2, 1, 0, NULL, NULL, 0, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (6, N'Paket Baru 2', NULL, 4, 2, 1, 0, NULL, N'asd', 0, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (7, N'Two Day Lembang Tour', 360000.0000, 4, 2, 1, 0, N'20210208152236.pdf', N'Tidak ada', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), 1, CAST(N'2021-01-18T20:16:49.603' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (8, N'One Day Surabaya Tour', 125000.0000, 2, 1, 0, 0, N'20210212161236.xlsx', NULL, 1, 1, CAST(N'2021-01-18T20:16:10.383' AS DateTime), 1, CAST(N'2021-01-18T20:16:10.383' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (9, N'Paket Ciwidey', 270000.0000, 4, 2, 1, 0, NULL, NULL, 1, 1, CAST(N'2021-01-18T20:17:55.773' AS DateTime), 1, CAST(N'2021-01-18T20:17:55.773' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (10, N'Jogjakarta Overland 2D', 245000.0000, 4, 2, 1, 0, N'20210208142724.xlsx', N'Jogjakarta Overland
', 1, 1, CAST(N'2021-01-18T20:21:06.023' AS DateTime), 1, CAST(N'2021-01-18T20:21:06.023' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (11, N'Pulau Pari 2D', 305000.0000, 4, 2, 1, 0, NULL, NULL, 1, 1, CAST(N'2021-01-18T20:21:46.540' AS DateTime), 1, CAST(N'2021-01-18T20:21:46.540' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (13, N'2D Bekasi Tour', 220000.0000, 4, 2, 1, 0, NULL, NULL, 1, 2, CAST(N'2021-01-20T19:17:45.000' AS DateTime), 1, CAST(N'2021-02-08T08:29:22.073' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (14, N'Paket Panas', 325000.0000, 4, 2, 1, 1, N'20210122132923.xlsx', NULL, 1, 2, CAST(N'2021-01-22T13:21:54.873' AS DateTime), 2, CAST(N'2021-01-22T13:21:54.873' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (15, N'Paket Test', 325000.0000, 4, 2, 1, 1, N'20210122134423.xlsx', NULL, 1, 2, CAST(N'2021-01-22T13:40:55.517' AS DateTime), 2, CAST(N'2021-01-22T13:40:55.517' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (16, N'Two Day Lembang Tour', 225000.0000, 4, 2, 1, 1, NULL, NULL, 1, 2, CAST(N'2021-01-25T12:40:29.643' AS DateTime), 2, CAST(N'2021-01-25T12:40:29.643' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (17, N'Paket Jogjakarta', 215000.0000, 4, 2, 1, 0, NULL, NULL, 1, 2, CAST(N'2021-02-01T14:50:42.000' AS DateTime), 1, CAST(N'2021-02-08T13:26:50.973' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (18, N'One Day Ponorogo Tour', 80000.0000, 2, 1, 1, 0, NULL, NULL, 0, 1, CAST(N'2021-02-05T23:19:04.860' AS DateTime), 1, CAST(N'2021-02-05T23:19:04.860' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (19, N'Two Day Ponorogo Tour', 235000.0000, 4, 2, 1, 0, NULL, N'Ini merupakan paket wisata 2 hari di ponorogo', 1, 1, CAST(N'2021-02-07T21:33:10.217' AS DateTime), 1, CAST(N'2021-02-07T21:33:10.217' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (20, N'Paket Daebekasi', 220000.0000, 4, 2, 0, 1, NULL, NULL, 0, 2, CAST(N'2021-02-08T09:44:53.580' AS DateTime), 2, CAST(N'2021-02-08T09:44:53.580' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (21, N'Candi Bekasi Tour', 275000.0000, 4, 2, 1, 1, NULL, NULL, 1, 2, CAST(N'2021-02-08T09:52:57.157' AS DateTime), 2, CAST(N'2021-02-08T09:52:57.157' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (22, N'Keliling Bandung', 220000.0000, 4, 2, 1, 0, NULL, N'-', 0, 1, CAST(N'2021-02-08T13:24:46.190' AS DateTime), 1, CAST(N'2021-02-08T13:24:46.190' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (23, N'Paket Bekasi', 275000.0000, 4, 2, 1, 1, NULL, NULL, 1, 2, CAST(N'2021-02-08T13:55:20.783' AS DateTime), 2, CAST(N'2021-02-08T13:55:20.783' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (24, N'Paket 2 Day Bekasi', 275000.0000, 4, 2, 1, 1, NULL, NULL, 1, 2, CAST(N'2021-02-08T14:00:22.047' AS DateTime), 2, CAST(N'2021-02-08T14:00:22.047' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (25, N'Keliling Bandung 2', 310000.0000, 4, 2, 1, 1, NULL, NULL, 1, 2, CAST(N'2021-02-08T14:22:10.843' AS DateTime), 2, CAST(N'2021-02-08T14:22:10.843' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (26, N'Keliling Jakarta', 235000.0000, 4, 2, 1, 0, NULL, N'-', 0, 1, CAST(N'2021-02-08T15:07:41.000' AS DateTime), 1, CAST(N'2021-02-08T15:09:05.740' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (27, N'Paket Bekasi 3', 375000.0000, 4, 2, 1, 1, NULL, NULL, 1, 2, CAST(N'2021-02-08T15:38:27.877' AS DateTime), 2, CAST(N'2021-02-08T15:38:27.877' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (28, N'Paket Keliling Magetan', 195000.0000, 4, 2, 1, 0, NULL, N'Paket Keliling Magetan 2 hari', 1, 1, CAST(N'2021-02-12T15:17:14.647' AS DateTime), 1, CAST(N'2021-02-12T15:17:14.647' AS DateTime))
INSERT [dbo].[Paket] ([ID_Paket], [Nama_Paket], [Harga], [Konsumsi], [Lama_Perjalanan], [Penginapan], [Jenis_Paket], [Jadwal], [Keterangan], [Status], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate]) VALUES (29, N'Paket Bekasi 4', 375000.0000, 4, 2, 1, 1, N'20210212161211.xlsx', NULL, 1, 2, CAST(N'2021-02-12T16:09:57.733' AS DateTime), 2, CAST(N'2021-02-12T16:09:57.733' AS DateTime))
SET IDENTITY_INSERT [dbo].[Paket] OFF
GO
SET IDENTITY_INSERT [dbo].[Pegawai] ON 

INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (1, N'Samodra', N'Ponorogo', N'0861233', N'samodra28@gmail.com', N'asd', 1, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-02-12T15:19:17.753' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (2, N'Shifa Habibah Anl', N'Pemalang', N'08123178264123', N'shifa@gmail.com', N'shifa', 2, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-02-06T22:55:35.123' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (3, N'test', N'asd', N'01723781623', N'asd@gmail.com', N'asd', 2, 0, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (4, N'Test2', N'test', N'086123561235', N'test123@gmail.com', N'test', 2, 0, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-01-09T00:00:00.000' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (7, N'Hardiansah', N'Jimbe', N'0876512365', N'ansahkaco@gmail.com', N'ansah', 2, 0, CAST(N'2021-01-18T07:14:33.027' AS DateTime), CAST(N'2021-01-18T07:14:33.027' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (12, N'Rudi Ari Kiswanto', N'Tangerang', N'08127368123', N'rudis@gmail.com', N'rudi', 3, 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), CAST(N'2021-02-06T22:56:45.993' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (16, N'Sabrina', N'Madiun', N'081283761823', N'tomoyakuroha@gmail.com', N'OT9S308R', 2, 0, CAST(N'2021-01-22T13:02:17.740' AS DateTime), CAST(N'2021-01-22T13:02:17.740' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (18, N'Wahyu Firmansyah', N'Nganjuk', N'08123178264123', N'samodra30@gmail.com', N'MW4KS3LW', 1, 1, CAST(N'2021-02-05T22:40:41.000' AS DateTime), CAST(N'2021-02-08T11:52:58.073' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (19, N'Yongki Tri Ardiansyah', N'Magelang', N'081234331541', N'szsamodra@gmail.com', N'JJWYVE32', 1, 1, CAST(N'2021-02-05T22:49:36.000' AS DateTime), CAST(N'2021-02-05T23:02:46.273' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (20, N'Yeriana', N'Sunter Jakarta', N'082123452345', N'samodra41@gmail.com', N'IFQQCIS6', 1, 0, CAST(N'2021-02-08T11:50:40.923' AS DateTime), CAST(N'2021-02-08T11:50:40.923' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (21, N'Anl Shifa', N'Cirebon', N'081723671623', N'samodra41@gmail.com', N'ROT8KZ96', 1, 1, CAST(N'2021-02-08T14:54:52.000' AS DateTime), CAST(N'2021-02-08T14:55:59.503' AS DateTime))
INSERT [dbo].[Pegawai] ([ID_Pegawai], [Nama], [Alamat], [No_HP], [Email], [Password], [Role], [Status], [CreatedDate], [ModifiedDate]) VALUES (22, N'Yeriana Tri Susanti', N'Cirebon', N'081273661231', N'hijikatato23@gmail.com', N'L60F24QZ', 2, 0, CAST(N'2021-02-12T15:05:07.000' AS DateTime), CAST(N'2021-02-12T15:06:08.717' AS DateTime))
SET IDENTITY_INSERT [dbo].[Pegawai] OFF
GO
SET IDENTITY_INSERT [dbo].[Transaksi] ON 

INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (3, 3, N'1234567890123450', 1, 250000.0000, 50, CAST(N'2021-01-19' AS Date), NULL, NULL, 50000.0000, 6, 2, CAST(N'2021-01-19T00:00:00.000' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (5, 3, N'1234567890123450', NULL, 1865000.0000, 105, CAST(N'2021-01-20' AS Date), N'20210122130336.jpg', N'20210122130540.jpg', NULL, 6, 2, CAST(N'2021-01-20T12:06:39.550' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (6, 2, N'1234567890123450', NULL, 1270000.0000, 45, CAST(N'2021-01-20' AS Date), N'20210212155839.jpg', NULL, NULL, 1, 2, CAST(N'2021-01-20T12:10:31.193' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (7, 1, N'1234567890123450', NULL, 990000.0000, 45, CAST(N'2021-01-19' AS Date), N'20210212093321.jpg', NULL, NULL, 2, 2, CAST(N'2021-01-20T12:13:46.800' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (8, 13, N'1234567890123450', NULL, 1425000.0000, 60, CAST(N'2021-01-22' AS Date), N'20210212155831.jpg', NULL, NULL, 1, 2, CAST(N'2021-01-20T19:17:45.943' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (9, 14, N'1234567890123459', NULL, 963839.0000, 60, CAST(N'2021-01-25' AS Date), N'20210122132349.png', N'20210122132527.jpg', NULL, 5, 2, CAST(N'2021-01-22T13:21:55.417' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (10, 15, N'1234567890123459', NULL, 1313839.0000, 90, CAST(N'2021-01-24' AS Date), N'20210122134118.jpg', N'20210122134520.jpg', NULL, 5, 2, CAST(N'2021-01-22T13:40:56.090' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (11, 7, N'1234567890123452', NULL, 41200000.0000, 90, CAST(N'2021-01-30' AS Date), N'20210125121614.jpg', N'20210125141658.png', NULL, 5, 2, CAST(N'2021-01-25T12:13:10.980' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (12, 16, N'1234567890123452', NULL, 11925000.0000, 45, CAST(N'2021-01-29' AS Date), N'20210125124042.png', NULL, NULL, 1, 2, CAST(N'2021-01-25T12:40:30.423' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (13, 8, N'1234567890123459', NULL, 18350000.0000, 90, CAST(N'2021-02-10' AS Date), N'20210201144935.jpg', NULL, NULL, 1, 1, CAST(N'2021-01-27T14:49:26.830' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (14, 15, N'1234567890123459', NULL, 34852678.0000, 75, CAST(N'2021-02-10' AS Date), N'20210201145006.png', NULL, NULL, 1, 2, CAST(N'2021-01-28T14:50:00.893' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (15, 17, N'1234567890123459', NULL, 13800000.0000, 60, CAST(N'2021-02-26' AS Date), N'20210201145049.png', NULL, NULL, 1, 2, CAST(N'2021-01-30T14:50:43.420' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (16, 7, N'1623781623781623', NULL, 19827678.0000, 45, CAST(N'2021-02-11' AS Date), N'20210206071656.png', N'20210206071757.png', NULL, 3, 2, CAST(N'2021-02-06T07:02:06.660' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (17, 7, N'1623781623781623', NULL, 14000000.0000, 30, CAST(N'2021-02-11' AS Date), N'20210206071705.jpg', N'20210206071809.png', 0.0000, 6, 2, CAST(N'2021-02-06T07:08:36.607' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (18, 20, N'1623781623781623', NULL, 16075000.0000, 45, CAST(N'2021-02-24' AS Date), NULL, NULL, NULL, 0, 2, CAST(N'2021-02-08T09:44:54.267' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (19, 21, N'1623781623781623', NULL, 13875000.0000, 45, CAST(N'2021-02-17' AS Date), NULL, NULL, NULL, 0, 2, CAST(N'2021-02-08T09:52:57.173' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (20, 23, N'1234567890123450', NULL, 13375000.0000, 45, CAST(N'2021-02-15' AS Date), NULL, NULL, NULL, 0, 2, CAST(N'2021-02-08T13:55:20.980' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (21, 24, N'1234567890123450', NULL, 13875000.0000, 45, CAST(N'2021-02-16' AS Date), NULL, NULL, NULL, 0, 2, CAST(N'2021-02-08T14:01:31.177' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (22, 1, N'1234567890123450', NULL, 12300000.0000, 45, CAST(N'2021-02-19' AS Date), N'20210212093342.jpg', NULL, NULL, 1, 2, CAST(N'2021-02-08T14:15:42.517' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (23, 10, N'1234567890123450', NULL, 10675000.0000, 45, CAST(N'2021-02-17' AS Date), N'20210208142114.jpg', N'20210208142401.jpg', 0.0000, 6, 2, CAST(N'2021-02-08T14:20:24.900' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (24, 25, N'1234567890123450', NULL, 15450000.0000, 45, CAST(N'2021-02-26' AS Date), NULL, NULL, NULL, 0, 2, CAST(N'2021-02-08T14:22:10.960' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (25, 1, N'1234567890123450', NULL, 11800000.0000, 45, CAST(N'2021-02-21' AS Date), N'20210208151526.jpg', N'20210208151727.jpg', 0.0000, 6, 2, CAST(N'2021-02-08T15:15:04.880' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (26, 3, N'1234567890123450', NULL, 10675000.0000, 45, CAST(N'2021-02-18' AS Date), NULL, NULL, NULL, 0, 2, CAST(N'2021-02-08T15:33:10.500' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (27, 27, N'1234567890123450', NULL, 18375000.0000, 45, CAST(N'2021-02-25' AS Date), NULL, NULL, NULL, 0, 2, CAST(N'2021-02-08T15:38:27.953' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (28, 8, N'1234567890123450', NULL, 14400000.0000, 60, CAST(N'2021-02-18' AS Date), NULL, NULL, NULL, 0, 1, CAST(N'2021-02-08T20:45:28.460' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (29, 2, N'1892312739871231', NULL, 20400000.0000, 45, CAST(N'2021-02-26' AS Date), N'20210212085735.png', NULL, NULL, 1, 2, CAST(N'2021-02-12T08:57:23.127' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (30, 11, N'1234567890123450', NULL, 14725000.0000, 45, CAST(N'2021-02-26' AS Date), N'20210212152205.jpg', N'20210212152353.jpg', 0.0000, 5, 2, CAST(N'2021-02-12T15:21:41.577' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (31, 11, N'1234567890123450', NULL, 15225000.0000, 45, CAST(N'2021-02-23' AS Date), N'20210212160333.jpg', N'20210212160507.jpg', 0.0000, 5, 2, CAST(N'2021-02-12T16:03:03.717' AS DateTime))
INSERT [dbo].[Transaksi] ([ID_Transaksi], [ID_Paket], [ID_Customer], [ID_Pegawai], [Harga_total], [Jumlah_Penumpang], [Tanggal_Pesanan], [Bukti_DP], [Bukti_Pelunasan], [biaya_tambahan], [Status_Transaksi], [PaketLama_Perjalanan], [CreatedDate]) VALUES (32, 29, N'1234567890123450', NULL, 18375000.0000, 45, CAST(N'2021-02-25' AS Date), N'20210212161011.jpg', NULL, NULL, 2, 2, CAST(N'2021-02-12T16:09:57.887' AS DateTime))
SET IDENTITY_INSERT [dbo].[Transaksi] OFF
GO
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (3, 1, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (3, 2, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (5, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (5, 6, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (7, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (8, 2, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (8, 10, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (9, 1, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (9, 7, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (10, 1, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (10, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (11, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (11, 6, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (12, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (12, 6, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (12, 7, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (12, 8, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (13, 2, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (13, 4, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (14, 1, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (14, 11, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (15, 2, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (15, 10, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (16, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (17, 3, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (17, 7, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (18, 6, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (19, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (20, 6, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (21, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (22, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (23, 2, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (24, 4, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (25, 6, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (26, 6, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (27, 4, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (28, 3, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (28, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (29, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (30, 6, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (31, 5, 1)
INSERT [dbo].[Transaksi_Kendaraan] ([ID_Transaksi], [ID_Kendaraan], [Status]) VALUES (32, 5, 1)
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
ALTER TABLE [dbo].[Paket] ADD  CONSTRAINT [DF_Paket_Penginapan]  DEFAULT ((0)) FOR [Penginapan]
GO
ALTER TABLE [dbo].[Paket] ADD  CONSTRAINT [DF_Paket_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Pegawai] ADD  CONSTRAINT [DF_Pegawai_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Transaksi] ADD  CONSTRAINT [DF_Transaksi_biaya_tambahan]  DEFAULT ((0)) FOR [biaya_tambahan]
GO
ALTER TABLE [dbo].[Transaksi_Kendaraan] ADD  CONSTRAINT [DF_Transaksi_Kendaraan_Status]  DEFAULT ((0)) FOR [Status]
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
/****** Object:  Trigger [dbo].[Tr_DeleteDetailPaket]    Script Date: 2/17/2021 8:39:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Tr_DeleteDetailPaket]
	ON [dbo].[Detail_Paket]
	FOR DELETE
AS
BEGIN
	DECLARE @penginapan int
	DECLARE @sumharga money
	SET @penginapan = (SELECT Penginapan FROM Paket WHERE ID_Paket = (SELECT i.ID_Paket FROM deleted i))

	
	SET @sumharga = (SELECT SUM(d.Harga_Tiket) FROM 
	Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
	WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM deleted i))

	IF (@sumharga != 0)
	BEGIN
		IF(@penginapan = 1)
		BEGIN	
			UPDATE Paket SET 
			Harga = ((Lama_Perjalanan-1) * 50000) + (30000 * Konsumsi) + (SELECT SUM(d.Harga_Tiket) FROM 
			Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
			WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM deleted i))
			WHERE ID_Paket = (SELECT i.ID_Paket FROM deleted i)
		END
		ELSE 
		BEGIN
			UPDATE Paket SET 
			Harga = (30000 * Konsumsi) + (SELECT SUM(d.Harga_Tiket) FROM 
			Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
			WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM deleted i))
			WHERE ID_Paket = (SELECT i.ID_Paket FROM deleted i)
		END
	END
	ELSE
	BEGIN
		UPDATE Paket SET Harga = NULL WHERE ID_Paket = (SELECT i.ID_Paket FROM deleted i)
	END

END
GO
ALTER TABLE [dbo].[Detail_Paket] ENABLE TRIGGER [Tr_DeleteDetailPaket]
GO
/****** Object:  Trigger [dbo].[Tr_InsertDetailPaket]    Script Date: 2/17/2021 8:39:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Tr_InsertDetailPaket]
	ON [dbo].[Detail_Paket]
	FOR INSERT, DELETE
AS
BEGIN
	DECLARE @penginapan int
	DECLARE @sumharga money
	SET @penginapan = (SELECT Penginapan FROM Paket WHERE ID_Paket = (SELECT i.ID_Paket FROM inserted i))

	
	SET @sumharga = (SELECT SUM(d.Harga_Tiket) FROM 
	Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
	WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM inserted i))

	IF (@sumharga != 0)
	BEGIN
		IF(@penginapan = 1)
		BEGIN	
			UPDATE Paket SET 
			Harga = ((Lama_Perjalanan-1) * 50000) + (30000 * Konsumsi) + (SELECT SUM(d.Harga_Tiket) FROM 
			Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
			WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM inserted i))
			WHERE ID_Paket = (SELECT i.ID_Paket FROM inserted i)
		END
		ELSE 
		BEGIN
			UPDATE Paket SET 
			Harga = (30000 * Konsumsi) + (SELECT SUM(d.Harga_Tiket) FROM 
			Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
			WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM inserted i))
			WHERE ID_Paket = (SELECT i.ID_Paket FROM inserted i)
		END
	END
	ELSE
	BEGIN
		UPDATE Paket SET Harga = NULL WHERE ID_Paket = (SELECT i.ID_Paket FROM inserted i)
	END

END
GO
ALTER TABLE [dbo].[Detail_Paket] ENABLE TRIGGER [Tr_InsertDetailPaket]
GO
/****** Object:  Trigger [dbo].[Tr_InsertDetailRating]    Script Date: 2/17/2021 8:39:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Tr_InsertDetailRating]
	ON [dbo].[Detail_Rating_Destinasi]
	FOR INSERT, UPDATE
AS
BEGIN
	UPDATE Destinasi SET Rating = (SELECT AVG(dr.Rating) FROM Detail_Rating_Destinasi dr 
	WHERE dr.ID_Destinasi = (SELECT i.ID_Destinasi FROM inserted i)) 
	WHERE ID_Destinasi = (SELECT i.ID_Destinasi FROM inserted i)
END
GO
ALTER TABLE [dbo].[Detail_Rating_Destinasi] ENABLE TRIGGER [Tr_InsertDetailRating]
GO
/****** Object:  Trigger [dbo].[Tr_PaketUpdate]    Script Date: 2/17/2021 8:39:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[Tr_PaketUpdate]
	ON [dbo].[Paket]
	AFTER UPDATE
AS
BEGIN
	DECLARE @penginapan int
	DECLARE @sumharga money
	SET @penginapan = (SELECT Penginapan FROM Paket WHERE ID_Paket = (SELECT i.ID_Paket FROM inserted i))

	
	SET @sumharga = (SELECT SUM(d.Harga_Tiket) FROM 
	Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
	WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM inserted i))

	IF (@sumharga != 0)
	BEGIN
		IF(@penginapan = 1)
		BEGIN	
			UPDATE Paket SET 
			Harga = ((Lama_Perjalanan-1) * 50000) + (30000 * Konsumsi) + (SELECT SUM(d.Harga_Tiket) FROM 
			Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
			WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM inserted i))
			WHERE ID_Paket = (SELECT i.ID_Paket FROM inserted i)
		END
		ELSE 
		BEGIN
			UPDATE Paket SET 
			Harga = (30000 * Konsumsi) + (SELECT SUM(d.Harga_Tiket) FROM 
			Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi JOIN Paket t ON t.ID_Paket = dp.ID_Paket
			WHERE dp.ID_Paket = (SELECT i.ID_Paket FROM inserted i))
			WHERE ID_Paket = (SELECT i.ID_Paket FROM inserted i)
		END
	END
	ELSE
	BEGIN
		UPDATE Paket SET Harga = NULL WHERE ID_Paket = (SELECT i.ID_Paket FROM inserted i)
	END

END
GO
ALTER TABLE [dbo].[Paket] ENABLE TRIGGER [Tr_PaketUpdate]
GO
USE [master]
GO
ALTER DATABASE [BUSS] SET  READ_WRITE 
GO
