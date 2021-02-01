USE [master]
GO
/****** Object:  Database [BUSS]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Transaksi]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  View [dbo].[view_DashboardCustomer]    Script Date: 2/1/2021 10:13:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_DashboardCustomer] AS
SELECT CONVERT(date, t.CreatedDate) as tgl, t.ID_Customer, COUNT(*) as jumlah FROM Transaksi t
GROUP BY CONVERT(date, t.CreatedDate), t.ID_Customer
GO
/****** Object:  Table [dbo].[Paket]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  View [dbo].[view_TransaksiCount]    Script Date: 2/1/2021 10:13:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_TransaksiCount] AS
SELECT p.ID_Paket, p.Nama_Paket, COUNT(*) as jumlah_dipesan
FROM Transaksi t JOIN Paket p ON t.ID_Paket = p.ID_Paket
GROUP BY p.Nama_Paket, p.ID_Paket
GO
/****** Object:  Table [dbo].[Destinasi]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Kategori_Wilayah]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Kota]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Detail_Kategori]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  View [dbo].[view_JumlahDestinasiWilayah]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Detail_Paket]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  View [dbo].[view_DestinasiTerlaris]    Script Date: 2/1/2021 10:13:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_DestinasiTerlaris] AS
SELECT dp.ID_Destinasi, Nama_Destinasi, COUNT(*) as JumlahDipesan
FROM Detail_Paket dp JOIN Destinasi d ON d.ID_Destinasi = dp.ID_Destinasi
GROUP BY dp.ID_Destinasi, Nama_Destinasi
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Detail_Foto]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Detail_Rating_Destinasi]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Feedback]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Jenis_Kendaraan]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Kendaraan]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Pegawai]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Table [dbo].[Transaksi_Kendaraan]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Trigger [dbo].[Tr_DeleteDetailPaket]    Script Date: 2/1/2021 10:13:13 PM ******/
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
/****** Object:  Trigger [dbo].[Tr_InsertDetailPaket]    Script Date: 2/1/2021 10:13:14 PM ******/
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
/****** Object:  Trigger [dbo].[Tr_InsertDetailRating]    Script Date: 2/1/2021 10:13:14 PM ******/
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
USE [master]
GO
ALTER DATABASE [BUSS] SET  READ_WRITE 
GO
