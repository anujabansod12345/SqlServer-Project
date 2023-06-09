USE [master]
GO
/****** Object:  Database [astoriaTraining8.0Bak]    Script Date: 28-02-2023 11:17:21 ******/
CREATE DATABASE [astoriaTraining8.0Bak]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'astoriaTraining8.0', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\astoriaTrainingHyderabad8.0.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'astoriaTraining8.0_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\astoriaTrainingHyderabad8.0_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [astoriaTraining8.0Bak].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET ARITHABORT OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET  DISABLE_BROKER 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET RECOVERY FULL 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET  MULTI_USER 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET DB_CHAINING OFF 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'astoriaTraining8.0Bak', N'ON'
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET QUERY_STORE = OFF
GO
USE [astoriaTraining8.0Bak]
GO
/****** Object:  Table [dbo].[EmployeeMaster]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeMaster](
	[EmployeeKey] [bigint] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [varchar](20) NOT NULL,
	[EmpFirstName] [varchar](100) NOT NULL,
	[EmpLastName] [varchar](100) NOT NULL,
	[EmpCompanyID] [int] NULL,
	[EmpDesignationID] [int] NULL,
	[EmpGender] [varchar](10) NOT NULL,
	[EmpJoiningDate] [datetime] NOT NULL,
	[EmpResignationDate] [datetime] NULL,
	[EmpHourlySalaryRate] [decimal](18, 3) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[ModificationDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ActiveEmployeeCount]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ActiveEmployeeCount]
AS
SELECT        COUNT(*) AS Active_employee_count
FROM            dbo.EmployeeMaster
WHERE        (EmpResignationDate IS NULL)
GO
/****** Object:  Table [dbo].[CompanyMaster]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CompanyMaster](
	[CompanyID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](100) NOT NULL,
	[CompanyDescription] [varchar](400) NULL,
	[CreationDate] [datetime] NOT NULL,
	[ModificationDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CompanyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ActiveEmployeeByCompanyName]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ActiveEmployeeByCompanyName]
AS
SELECT        COUNT(EM.EmployeeKey) AS ActiveEmployeeCount, CM.CompanyName
FROM            dbo.CompanyMaster AS CM INNER JOIN
                         dbo.EmployeeMaster AS EM ON CM.CompanyID = EM.EmpCompanyID
WHERE        (EM.EmpResignationDate IS NULL)
GROUP BY CM.CompanyName
GO
/****** Object:  Table [dbo].[EmployeeAttendance]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeAttendance](
	[EmployeeKey] [bigint] NOT NULL,
	[ClockDate] [date] NOT NULL,
	[Timein] [datetime] NOT NULL,
	[TimeOut] [datetime] NOT NULL,
	[Remarks] [varchar](400) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[ModificationDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeKey] ASC,
	[ClockDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_AbsentPresentEmployeeByCompany]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_AbsentPresentEmployeeByCompany]
AS
SELECT        COUNT(EM.EmployeeKey) AS PresentEmployee, CM.CompanyName,
                             (SELECT        (SELECT        COUNT(*) AS Expr1
                                                          FROM            dbo.EmployeeMaster) -
                                                             (SELECT        COUNT(*) AS Expr1
                                                               FROM            dbo.EmployeeAttendance
                                                               WHERE        (ClockDate = CAST(GETDATE() AS Date)) AND (ClockDate IS NOT NULL)) AS Expr1) AS AbsentEmployee
FROM            dbo.CompanyMaster AS CM INNER JOIN
                         dbo.EmployeeMaster AS EM ON CM.CompanyID = EM.EmpCompanyID INNER JOIN
                         dbo.EmployeeAttendance AS EA ON EM.EmployeeKey = EA.EmployeeKey
WHERE        (EA.ClockDate = CAST(GETDATE() AS Date)) AND (EM.EmpResignationDate IS NULL)
GROUP BY CM.CompanyName
GO
/****** Object:  View [dbo].[vw_PresentAndAbsentEmployee]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_PresentAndAbsentEmployee]
AS
SELECT        (SELECT        COUNT(*) AS Expr1
                          FROM            dbo.EmployeeAttendance
                          WHERE        (ClockDate = CAST(GETDATE() AS Date)) AND (Timein IS NOT NULL) AND (TimeOut IS NOT NULL) AND (Remarks IS NOT NULL)) AS Present,
                             (SELECT        (SELECT        COUNT(*) AS Expr1
                                                          FROM            dbo.EmployeeMaster
                                                          WHERE        (EmpResignationDate IS NULL)) -
                                                             (SELECT        COUNT(*) AS Expr1
                                                               FROM            dbo.EmployeeAttendance AS EmployeeAttendance_1
                                                               WHERE        (ClockDate = CAST(GETDATE() AS DATE)) AND (Timein IS NOT NULL) AND (TimeOut IS NOT NULL) AND (Remarks IS NOT NULL)) AS Present) AS Absent
GO
/****** Object:  Table [dbo].[AllowanceMaster]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AllowanceMaster](
	[AllowanceID] [int] IDENTITY(1,1) NOT NULL,
	[AllowanceName] [varchar](50) NOT NULL,
	[AllowanceDescription] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[AllowanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DesignationMaster]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DesignationMaster](
	[DesignationID] [int] IDENTITY(1,1) NOT NULL,
	[DesignationName] [varchar](100) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[ModificationDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DesignationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmployeeAllowanceDetail]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmployeeAllowanceDetail](
	[EmployeeKey] [bigint] NOT NULL,
	[AllowanceID] [int] NOT NULL,
	[ClockDate] [date] NOT NULL,
	[AllowanceAmount] [decimal](18, 2) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[ModificationDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeKey] ASC,
	[AllowanceID] ASC,
	[ClockDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserInfo]    Script Date: 28-02-2023 11:17:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserInfo](
	[ID] [int] NOT NULL,
	[FirstName] [varchar](255) NULL,
	[LastName] [varchar](255) NULL,
	[UserName] [varchar](255) NULL,
	[Email] [varchar](255) NULL,
	[Passwords] [varchar](255) NULL,
	[CreationDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AllowanceMaster] ON 

INSERT [dbo].[AllowanceMaster] ([AllowanceID], [AllowanceName], [AllowanceDescription]) VALUES (1, N'House Rent', N'Good')
INSERT [dbo].[AllowanceMaster] ([AllowanceID], [AllowanceName], [AllowanceDescription]) VALUES (2, N' Transport', N'Good')
INSERT [dbo].[AllowanceMaster] ([AllowanceID], [AllowanceName], [AllowanceDescription]) VALUES (3, N'Medical', N'Good')
INSERT [dbo].[AllowanceMaster] ([AllowanceID], [AllowanceName], [AllowanceDescription]) VALUES (4, N'Phone', N'Good')
INSERT [dbo].[AllowanceMaster] ([AllowanceID], [AllowanceName], [AllowanceDescription]) VALUES (5, N'Meal', N'Good')
SET IDENTITY_INSERT [dbo].[AllowanceMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[CompanyMaster] ON 

INSERT [dbo].[CompanyMaster] ([CompanyID], [CompanyName], [CompanyDescription], [CreationDate], [ModificationDate]) VALUES (4, N'Astoria Technologies', N'Good', CAST(N'2021-01-01T12:30:32.000' AS DateTime), CAST(N'2021-02-02T01:30:32.000' AS DateTime))
INSERT [dbo].[CompanyMaster] ([CompanyID], [CompanyName], [CompanyDescription], [CreationDate], [ModificationDate]) VALUES (5, N' Astoria Solutions', N'Very Good', CAST(N'2021-02-01T01:30:32.000' AS DateTime), CAST(N'2021-03-02T02:30:32.000' AS DateTime))
INSERT [dbo].[CompanyMaster] ([CompanyID], [CompanyName], [CompanyDescription], [CreationDate], [ModificationDate]) VALUES (6, N' Astoria Middle East', N'Excellent', CAST(N'2021-02-01T01:30:32.000' AS DateTime), CAST(N'2021-03-02T02:30:32.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[CompanyMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[DesignationMaster] ON 

INSERT [dbo].[DesignationMaster] ([DesignationID], [DesignationName], [CreationDate], [ModificationDate]) VALUES (1, N'Product Owner', CAST(N'2021-01-01T12:30:32.000' AS DateTime), CAST(N'2021-02-02T01:30:32.000' AS DateTime))
INSERT [dbo].[DesignationMaster] ([DesignationID], [DesignationName], [CreationDate], [ModificationDate]) VALUES (2, N'Lead Engineer', CAST(N'2021-02-01T01:30:32.000' AS DateTime), CAST(N'2021-03-02T02:30:32.000' AS DateTime))
INSERT [dbo].[DesignationMaster] ([DesignationID], [DesignationName], [CreationDate], [ModificationDate]) VALUES (3, N'Senior Engineer', CAST(N'2021-03-01T03:30:32.000' AS DateTime), CAST(N'2021-04-02T04:30:32.000' AS DateTime))
INSERT [dbo].[DesignationMaster] ([DesignationID], [DesignationName], [CreationDate], [ModificationDate]) VALUES (4, N'Software Engineer', CAST(N'2021-04-01T05:30:32.000' AS DateTime), CAST(N'2021-05-02T06:30:32.000' AS DateTime))
INSERT [dbo].[DesignationMaster] ([DesignationID], [DesignationName], [CreationDate], [ModificationDate]) VALUES (5, N'QA Engineer', CAST(N'2021-05-01T07:30:32.000' AS DateTime), CAST(N'2021-06-02T08:30:32.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[DesignationMaster] OFF
GO
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (12, 1, CAST(N'2022-12-21' AS Date), CAST(111.00 AS Decimal(18, 2)), CAST(N'2022-12-21T15:14:19.710' AS DateTime), CAST(N'2022-12-21T15:14:19.710' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (12, 1, CAST(N'2022-12-26' AS Date), CAST(111.00 AS Decimal(18, 2)), CAST(N'2022-12-26T18:20:43.180' AS DateTime), CAST(N'2022-12-26T18:20:43.180' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (12, 1, CAST(N'2022-12-27' AS Date), CAST(111.00 AS Decimal(18, 2)), CAST(N'2022-12-27T15:46:03.123' AS DateTime), CAST(N'2022-12-27T15:46:03.123' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (12, 2, CAST(N'2022-09-02' AS Date), CAST(50.00 AS Decimal(18, 2)), CAST(N'2022-08-23T00:00:00.000' AS DateTime), CAST(N'2022-12-09T16:01:55.397' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (19, 2, CAST(N'2022-12-13' AS Date), CAST(10.00 AS Decimal(18, 2)), CAST(N'2022-12-13T16:29:24.863' AS DateTime), CAST(N'2022-12-13T16:29:24.863' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (19, 2, CAST(N'2022-12-26' AS Date), CAST(2.00 AS Decimal(18, 2)), CAST(N'2022-12-26T12:30:14.907' AS DateTime), CAST(N'2022-12-26T12:42:51.833' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (19, 3, CAST(N'2022-12-13' AS Date), CAST(200.00 AS Decimal(18, 2)), CAST(N'2022-12-13T12:31:52.380' AS DateTime), CAST(N'2022-12-13T12:31:52.380' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (46, 2, CAST(N'2022-12-26' AS Date), CAST(9.00 AS Decimal(18, 2)), CAST(N'2022-12-26T12:42:32.710' AS DateTime), CAST(N'2022-12-26T12:42:51.853' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (46, 4, CAST(N'2022-12-26' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(N'2022-12-26T12:38:09.663' AS DateTime), CAST(N'2022-12-26T12:42:51.847' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (129, 1, CAST(N'2022-12-15' AS Date), CAST(5.00 AS Decimal(18, 2)), CAST(N'2022-12-15T00:53:30.750' AS DateTime), CAST(N'2022-12-15T00:53:30.750' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (129, 2, CAST(N'2022-09-02' AS Date), CAST(50.00 AS Decimal(18, 2)), CAST(N'2022-12-09T16:10:11.433' AS DateTime), CAST(N'2022-12-09T16:10:11.433' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (129, 3, CAST(N'2022-12-15' AS Date), CAST(1.00 AS Decimal(18, 2)), CAST(N'2022-12-15T14:51:22.977' AS DateTime), CAST(N'2022-12-15T14:51:22.977' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (129, 5, CAST(N'2022-12-26' AS Date), CAST(5.00 AS Decimal(18, 2)), CAST(N'2022-12-26T12:38:09.670' AS DateTime), CAST(N'2022-12-26T12:42:51.853' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (130, 1, CAST(N'2022-12-11' AS Date), CAST(120.00 AS Decimal(18, 2)), CAST(N'2022-12-11T15:42:33.480' AS DateTime), CAST(N'2022-12-11T15:42:33.480' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (130, 3, CAST(N'2022-12-11' AS Date), CAST(70.00 AS Decimal(18, 2)), CAST(N'2022-12-11T17:00:46.367' AS DateTime), CAST(N'2022-12-11T17:00:46.367' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (130, 3, CAST(N'2022-12-12' AS Date), CAST(60.00 AS Decimal(18, 2)), CAST(N'2022-12-12T12:54:41.583' AS DateTime), CAST(N'2022-12-12T17:39:43.637' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (130, 5, CAST(N'2022-12-11' AS Date), CAST(120.00 AS Decimal(18, 2)), CAST(N'2022-12-11T15:43:48.027' AS DateTime), CAST(N'2022-12-11T15:43:48.027' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10131, 5, CAST(N'2022-12-19' AS Date), CAST(23.00 AS Decimal(18, 2)), CAST(N'2022-12-19T13:41:31.100' AS DateTime), CAST(N'2022-12-21T13:19:49.513' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10132, 1, CAST(N'2022-12-11' AS Date), CAST(120.00 AS Decimal(18, 2)), CAST(N'2022-12-11T00:40:42.607' AS DateTime), CAST(N'2022-12-11T15:42:33.487' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10132, 3, CAST(N'2022-12-11' AS Date), CAST(100.00 AS Decimal(18, 2)), CAST(N'2022-12-11T15:34:10.250' AS DateTime), CAST(N'2022-12-11T15:34:10.250' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10132, 3, CAST(N'2022-12-12' AS Date), CAST(70.00 AS Decimal(18, 2)), CAST(N'2022-12-12T12:54:41.737' AS DateTime), CAST(N'2022-12-12T15:04:47.873' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10132, 5, CAST(N'2022-12-11' AS Date), CAST(120.00 AS Decimal(18, 2)), CAST(N'2022-12-11T15:43:48.033' AS DateTime), CAST(N'2022-12-11T15:43:48.033' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10133, 2, CAST(N'2022-12-16' AS Date), CAST(4.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:39:01.393' AS DateTime), CAST(N'2022-12-21T13:19:49.507' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10133, 4, CAST(N'2022-12-16' AS Date), CAST(3.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:33:17.093' AS DateTime), CAST(N'2022-12-19T12:21:04.977' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10133, 5, CAST(N'2022-12-16' AS Date), CAST(9.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:37:19.637' AS DateTime), CAST(N'2022-12-21T13:19:49.493' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10134, 1, CAST(N'2022-12-11' AS Date), CAST(120.00 AS Decimal(18, 2)), CAST(N'2022-12-11T15:42:33.493' AS DateTime), CAST(N'2022-12-11T15:42:33.493' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10134, 3, CAST(N'2022-12-12' AS Date), CAST(145.00 AS Decimal(18, 2)), CAST(N'2022-12-12T13:20:21.083' AS DateTime), CAST(N'2022-12-12T14:51:54.307' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10134, 5, CAST(N'2022-12-11' AS Date), CAST(120.00 AS Decimal(18, 2)), CAST(N'2022-12-11T15:43:48.050' AS DateTime), CAST(N'2022-12-11T15:43:48.050' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10135, 3, CAST(N'2022-12-19' AS Date), CAST(36.00 AS Decimal(18, 2)), CAST(N'2022-12-19T10:44:12.843' AS DateTime), CAST(N'2022-12-21T13:19:49.513' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10135, 4, CAST(N'2022-12-19' AS Date), CAST(10.00 AS Decimal(18, 2)), CAST(N'2022-12-19T10:33:20.920' AS DateTime), CAST(N'2022-12-21T13:19:49.510' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (10135, 5, CAST(N'2022-12-19' AS Date), CAST(23.00 AS Decimal(18, 2)), CAST(N'2022-12-19T13:41:31.113' AS DateTime), CAST(N'2022-12-21T13:19:49.513' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30134, 2, CAST(N'2022-12-16' AS Date), CAST(3.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:39:01.397' AS DateTime), CAST(N'2022-12-21T13:19:49.503' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30134, 3, CAST(N'2022-12-16' AS Date), CAST(9.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:33:16.867' AS DateTime), CAST(N'2022-12-19T10:40:22.310' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30134, 4, CAST(N'2022-12-16' AS Date), CAST(3.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:33:17.097' AS DateTime), CAST(N'2022-12-19T12:21:04.987' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30134, 5, CAST(N'2022-12-16' AS Date), CAST(9.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:37:19.640' AS DateTime), CAST(N'2022-12-21T13:19:49.493' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30135, 2, CAST(N'2022-12-16' AS Date), CAST(3.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:39:01.400' AS DateTime), CAST(N'2022-12-21T13:19:49.503' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30135, 3, CAST(N'2022-12-16' AS Date), CAST(9.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:33:17.090' AS DateTime), CAST(N'2022-12-19T10:44:12.797' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30135, 4, CAST(N'2022-12-16' AS Date), CAST(3.00 AS Decimal(18, 2)), CAST(N'2022-12-16T16:36:39.453' AS DateTime), CAST(N'2022-12-21T13:19:49.490' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30138, 3, CAST(N'2022-12-12' AS Date), CAST(80.00 AS Decimal(18, 2)), CAST(N'2022-12-12T13:20:21.360' AS DateTime), CAST(N'2022-12-12T13:24:10.763' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30139, 3, CAST(N'2022-12-19' AS Date), CAST(18.00 AS Decimal(18, 2)), CAST(N'2022-12-19T10:29:06.623' AS DateTime), CAST(N'2022-12-21T13:19:49.507' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30139, 4, CAST(N'2022-12-19' AS Date), CAST(19.00 AS Decimal(18, 2)), CAST(N'2022-12-19T10:30:45.567' AS DateTime), CAST(N'2022-12-21T13:19:49.510' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30139, 5, CAST(N'2022-12-19' AS Date), CAST(23.00 AS Decimal(18, 2)), CAST(N'2022-12-19T13:42:27.300' AS DateTime), CAST(N'2022-12-21T13:19:49.517' AS DateTime))
INSERT [dbo].[EmployeeAllowanceDetail] ([EmployeeKey], [AllowanceID], [ClockDate], [AllowanceAmount], [CreationDate], [ModificationDate]) VALUES (30141, 3, CAST(N'2022-12-12' AS Date), CAST(80.00 AS Decimal(18, 2)), CAST(N'2022-12-12T13:20:21.367' AS DateTime), CAST(N'2022-12-12T13:24:10.763' AS DateTime))
GO
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (12, CAST(N'2022-08-11' AS Date), CAST(N'2022-08-11T13:03:00.000' AS DateTime), CAST(N'2022-08-11T18:03:00.000' AS DateTime), N'p', CAST(N'2022-11-07T13:03:42.667' AS DateTime), CAST(N'2022-11-07T13:03:42.667' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (12, CAST(N'2022-12-25' AS Date), CAST(N'2022-12-25T13:08:26.090' AS DateTime), CAST(N'2022-12-25T13:08:26.090' AS DateTime), N'Present', CAST(N'2022-12-25T18:43:03.153' AS DateTime), CAST(N'2022-12-25T18:43:03.153' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (13, CAST(N'2022-12-25' AS Date), CAST(N'2022-12-25T13:08:34.090' AS DateTime), CAST(N'2022-12-25T13:08:26.090' AS DateTime), N'Present', CAST(N'2022-12-25T18:51:40.287' AS DateTime), CAST(N'2022-12-25T18:51:40.287' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (19, CAST(N'2022-12-13' AS Date), CAST(N'2022-12-13T09:03:00.000' AS DateTime), CAST(N'2022-12-13T15:03:00.000' AS DateTime), N'Present', CAST(N'2022-12-13T12:04:20.637' AS DateTime), CAST(N'2022-12-13T12:04:20.640' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (19, CAST(N'2022-12-26' AS Date), CAST(N'2022-12-26T02:36:00.000' AS DateTime), CAST(N'2022-12-26T05:36:00.000' AS DateTime), N'Present', CAST(N'2022-12-26T01:37:06.080' AS DateTime), CAST(N'2022-12-26T01:37:06.080' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (19, CAST(N'2022-12-29' AS Date), CAST(N'2022-12-29T09:14:00.000' AS DateTime), CAST(N'2022-12-29T18:14:00.000' AS DateTime), N'Present', CAST(N'2022-12-29T15:15:55.437' AS DateTime), CAST(N'2022-12-29T15:15:55.437' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (46, CAST(N'2022-11-02' AS Date), CAST(N'2022-11-02T12:28:00.000' AS DateTime), CAST(N'2022-11-02T14:28:00.000' AS DateTime), N'p', CAST(N'2022-11-07T12:28:30.287' AS DateTime), CAST(N'2022-11-07T12:28:30.287' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (46, CAST(N'2022-12-13' AS Date), CAST(N'2022-12-13T11:03:00.000' AS DateTime), CAST(N'2022-12-13T18:03:00.000' AS DateTime), N'Present', CAST(N'2022-12-13T12:04:21.017' AS DateTime), CAST(N'2022-12-13T12:04:21.017' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (46, CAST(N'2022-12-25' AS Date), CAST(N'2022-12-25T12:33:06.337' AS DateTime), CAST(N'2022-12-25T13:33:06.337' AS DateTime), N'string', CAST(N'2022-12-25T19:04:24.373' AS DateTime), CAST(N'2022-12-25T19:04:24.373' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (46, CAST(N'2022-12-26' AS Date), CAST(N'2022-12-26T09:36:00.000' AS DateTime), CAST(N'2022-12-26T16:36:00.000' AS DateTime), N'Present', CAST(N'2022-12-26T01:37:06.490' AS DateTime), CAST(N'2022-12-26T01:37:06.490' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (46, CAST(N'2022-12-29' AS Date), CAST(N'2022-12-29T10:14:00.000' AS DateTime), CAST(N'2022-12-29T18:15:00.000' AS DateTime), N'Present', CAST(N'2022-12-29T15:15:55.743' AS DateTime), CAST(N'2022-12-29T15:15:55.743' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-06-16' AS Date), CAST(N'2022-06-16T12:45:00.000' AS DateTime), CAST(N'2022-06-16T14:45:00.000' AS DateTime), N'P', CAST(N'2022-11-07T12:46:20.777' AS DateTime), CAST(N'2022-11-07T12:46:20.777' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-08-11' AS Date), CAST(N'2022-08-11T13:06:00.000' AS DateTime), CAST(N'2022-08-11T18:06:00.000' AS DateTime), N'p', CAST(N'2022-11-07T13:06:59.330' AS DateTime), CAST(N'2022-11-07T13:06:59.330' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-09-15' AS Date), CAST(N'2022-09-15T19:16:00.000' AS DateTime), CAST(N'2022-09-15T23:16:00.000' AS DateTime), N'Present', CAST(N'2022-11-04T19:16:48.173' AS DateTime), CAST(N'2022-11-04T19:16:48.173' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-11-01' AS Date), CAST(N'2022-11-01T12:00:00.000' AS DateTime), CAST(N'2022-11-01T14:01:00.000' AS DateTime), N'p', CAST(N'2022-11-07T12:01:13.743' AS DateTime), CAST(N'2022-11-07T12:01:13.743' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-11-03' AS Date), CAST(N'2022-11-03T13:14:00.000' AS DateTime), CAST(N'2022-11-03T15:14:00.000' AS DateTime), N'Present', CAST(N'2022-11-04T12:15:06.317' AS DateTime), CAST(N'2022-11-04T12:15:06.317' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-11-04' AS Date), CAST(N'2022-11-04T13:09:00.000' AS DateTime), CAST(N'2022-11-04T17:09:00.000' AS DateTime), N'P', CAST(N'2022-11-04T12:09:34.337' AS DateTime), CAST(N'2022-11-07T12:57:04.193' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-12-14' AS Date), CAST(N'2022-12-14T09:36:00.000' AS DateTime), CAST(N'2022-12-14T16:36:00.000' AS DateTime), N'Present', CAST(N'2022-12-14T10:37:03.017' AS DateTime), CAST(N'2022-12-14T10:37:03.017' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-12-15' AS Date), CAST(N'2022-12-15T06:50:00.000' AS DateTime), CAST(N'2022-12-15T12:50:00.000' AS DateTime), N'Present', CAST(N'2022-12-15T00:51:41.897' AS DateTime), CAST(N'2022-12-15T00:51:41.900' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-12-17' AS Date), CAST(N'2022-12-17T09:12:00.000' AS DateTime), CAST(N'2022-12-17T18:12:00.000' AS DateTime), N'Present', CAST(N'2022-12-17T01:13:57.277' AS DateTime), CAST(N'2022-12-17T01:13:57.277' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-12-20' AS Date), CAST(N'2022-12-20T09:29:00.000' AS DateTime), CAST(N'2022-12-20T17:29:00.000' AS DateTime), N'Present', CAST(N'2022-12-20T17:29:40.437' AS DateTime), CAST(N'2022-12-20T17:29:40.437' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-12-25' AS Date), CAST(N'2022-12-25T15:47:00.420' AS DateTime), CAST(N'2022-12-25T16:47:00.420' AS DateTime), N'Present', CAST(N'2022-12-25T22:18:29.130' AS DateTime), CAST(N'2022-12-25T22:18:29.130' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-12-26' AS Date), CAST(N'2022-12-25T03:04:18.510' AS DateTime), CAST(N'2022-12-25T05:04:18.510' AS DateTime), N'string', CAST(N'2022-12-26T10:36:29.970' AS DateTime), CAST(N'2022-12-26T10:36:30.990' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (129, CAST(N'2022-12-29' AS Date), CAST(N'2022-12-29T15:16:00.000' AS DateTime), CAST(N'2022-12-29T18:16:00.000' AS DateTime), N'Present', CAST(N'2022-12-29T15:17:14.577' AS DateTime), CAST(N'2022-12-29T15:17:14.577' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (130, CAST(N'2022-08-19' AS Date), CAST(N'2022-08-19T11:21:00.000' AS DateTime), CAST(N'2022-08-19T20:21:00.000' AS DateTime), N'Present', CAST(N'2022-11-03T17:21:59.600' AS DateTime), CAST(N'2022-11-03T17:21:59.600' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (130, CAST(N'2022-11-03' AS Date), CAST(N'2022-11-03T10:00:00.000' AS DateTime), CAST(N'2022-11-03T18:00:00.000' AS DateTime), N'Present', CAST(N'2022-11-03T15:01:11.227' AS DateTime), CAST(N'2022-11-03T16:27:11.953' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (130, CAST(N'2022-11-04' AS Date), CAST(N'2022-11-04T14:14:00.000' AS DateTime), CAST(N'2022-11-04T20:14:00.000' AS DateTime), N'Present', CAST(N'2022-11-04T11:14:42.633' AS DateTime), CAST(N'2022-11-07T12:58:39.937' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (130, CAST(N'2022-12-09' AS Date), CAST(N'2022-12-09T09:05:00.000' AS DateTime), CAST(N'2022-12-09T18:05:00.000' AS DateTime), N'Present', CAST(N'2022-12-09T13:06:08.503' AS DateTime), CAST(N'2022-12-09T15:05:14.423' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (130, CAST(N'2022-12-10' AS Date), CAST(N'2022-12-10T09:18:00.000' AS DateTime), CAST(N'2022-12-10T18:18:00.000' AS DateTime), N'Present', CAST(N'2022-12-10T21:19:28.943' AS DateTime), CAST(N'2022-12-10T21:19:28.947' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (130, CAST(N'2022-12-11' AS Date), CAST(N'2022-12-11T09:35:00.000' AS DateTime), CAST(N'2022-12-11T18:35:00.000' AS DateTime), N'Present', CAST(N'2022-12-11T15:36:19.370' AS DateTime), CAST(N'2022-12-11T15:36:19.370' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (130, CAST(N'2022-12-12' AS Date), CAST(N'2022-12-12T09:18:00.000' AS DateTime), CAST(N'2022-12-12T19:18:00.000' AS DateTime), N'Present', CAST(N'2022-12-12T11:19:45.803' AS DateTime), CAST(N'2022-12-12T11:19:45.807' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (130, CAST(N'2022-12-29' AS Date), CAST(N'2022-12-29T13:16:00.000' AS DateTime), CAST(N'2022-12-29T19:16:00.000' AS DateTime), N'Present', CAST(N'2022-12-29T15:16:22.457' AS DateTime), CAST(N'2022-12-29T15:16:22.457' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10131, CAST(N'2021-12-29' AS Date), CAST(N'2021-12-29T10:01:00.000' AS DateTime), CAST(N'2021-12-29T19:02:00.000' AS DateTime), N'Present', CAST(N'2022-11-03T17:02:23.000' AS DateTime), CAST(N'2022-11-03T17:02:23.000' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10131, CAST(N'2022-11-02' AS Date), CAST(N'2022-11-02T17:13:00.000' AS DateTime), CAST(N'2022-11-02T21:12:00.000' AS DateTime), N'p', CAST(N'2022-11-03T17:12:46.843' AS DateTime), CAST(N'2022-11-03T17:12:46.843' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10131, CAST(N'2022-11-03' AS Date), CAST(N'2022-11-03T09:36:00.000' AS DateTime), CAST(N'2022-11-03T17:36:00.000' AS DateTime), N'Present', CAST(N'2022-11-03T12:37:04.907' AS DateTime), CAST(N'2022-11-04T12:15:06.497' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10131, CAST(N'2022-12-14' AS Date), CAST(N'2022-12-14T11:36:00.000' AS DateTime), CAST(N'2022-12-14T15:36:00.000' AS DateTime), N'Present', CAST(N'2022-12-14T10:37:03.153' AS DateTime), CAST(N'2022-12-14T10:37:03.153' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10131, CAST(N'2022-12-15' AS Date), CAST(N'2022-12-15T09:50:00.000' AS DateTime), CAST(N'2022-12-15T16:50:00.000' AS DateTime), N'Present', CAST(N'2022-12-15T00:51:42.110' AS DateTime), CAST(N'2022-12-15T00:51:42.110' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10131, CAST(N'2022-12-17' AS Date), CAST(N'2022-12-17T10:13:00.000' AS DateTime), CAST(N'2022-12-17T19:13:00.000' AS DateTime), N'Present', CAST(N'2022-12-17T01:13:57.397' AS DateTime), CAST(N'2022-12-17T01:13:57.397' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10131, CAST(N'2022-12-19' AS Date), CAST(N'2022-12-19T11:19:00.000' AS DateTime), CAST(N'2022-12-19T17:19:00.000' AS DateTime), N'Present', CAST(N'2022-12-19T10:19:59.593' AS DateTime), CAST(N'2022-12-19T10:19:59.597' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10131, CAST(N'2022-12-20' AS Date), CAST(N'2022-12-20T10:29:00.000' AS DateTime), CAST(N'2022-12-20T19:29:00.000' AS DateTime), N'Present', CAST(N'2022-12-20T17:29:40.553' AS DateTime), CAST(N'2022-12-20T17:29:40.553' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10131, CAST(N'2022-12-29' AS Date), CAST(N'2022-12-29T09:16:00.000' AS DateTime), CAST(N'2022-12-29T16:16:00.000' AS DateTime), N'Present', CAST(N'2022-12-29T15:17:14.580' AS DateTime), CAST(N'2022-12-29T15:17:14.580' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10132, CAST(N'2022-11-03' AS Date), CAST(N'2022-11-03T09:06:00.000' AS DateTime), CAST(N'2022-11-03T18:06:00.000' AS DateTime), N'Present', CAST(N'2022-11-03T15:06:43.117' AS DateTime), CAST(N'2022-11-03T16:27:11.960' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10132, CAST(N'2022-12-09' AS Date), CAST(N'2022-12-09T09:04:00.000' AS DateTime), CAST(N'2022-12-09T17:05:00.000' AS DateTime), N'Present', CAST(N'2022-12-09T15:05:14.943' AS DateTime), CAST(N'2022-12-09T15:05:14.943' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10132, CAST(N'2022-12-10' AS Date), CAST(N'2022-12-10T10:19:00.000' AS DateTime), CAST(N'2022-12-10T18:19:00.000' AS DateTime), N'Present', CAST(N'2022-12-10T21:19:29.127' AS DateTime), CAST(N'2022-12-10T21:19:29.127' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10132, CAST(N'2022-12-11' AS Date), CAST(N'2022-12-11T01:14:00.000' AS DateTime), CAST(N'2022-12-11T06:14:00.000' AS DateTime), N'p', CAST(N'2022-12-11T00:14:25.117' AS DateTime), CAST(N'2022-12-11T15:36:19.390' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10132, CAST(N'2022-12-12' AS Date), CAST(N'2022-12-12T09:18:00.000' AS DateTime), CAST(N'2022-12-12T17:18:00.000' AS DateTime), N'Present', CAST(N'2022-12-12T11:19:46.207' AS DateTime), CAST(N'2022-12-12T11:19:46.207' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10133, CAST(N'2022-11-02' AS Date), CAST(N'2022-11-02T03:28:00.000' AS DateTime), CAST(N'2022-11-02T06:28:00.000' AS DateTime), N'p', CAST(N'2022-11-07T12:28:30.293' AS DateTime), CAST(N'2022-11-07T12:28:30.293' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10133, CAST(N'2022-12-13' AS Date), CAST(N'2022-12-13T10:04:00.000' AS DateTime), CAST(N'2022-12-13T17:04:00.000' AS DateTime), N'Present', CAST(N'2022-12-13T12:04:21.023' AS DateTime), CAST(N'2022-12-13T12:04:21.023' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10133, CAST(N'2022-12-16' AS Date), CAST(N'2022-12-16T11:23:00.000' AS DateTime), CAST(N'2022-12-16T18:23:00.000' AS DateTime), N'Present', CAST(N'2022-12-16T12:23:54.620' AS DateTime), CAST(N'2022-12-16T12:23:54.623' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10134, CAST(N'2022-12-11' AS Date), CAST(N'2022-12-11T09:35:00.000' AS DateTime), CAST(N'2022-12-11T18:36:00.000' AS DateTime), N'Present', CAST(N'2022-12-11T15:36:19.420' AS DateTime), CAST(N'2022-12-11T15:36:19.420' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10134, CAST(N'2022-12-12' AS Date), CAST(N'2022-12-12T09:18:00.000' AS DateTime), CAST(N'2022-12-12T16:18:00.000' AS DateTime), N'Present', CAST(N'2022-12-12T11:19:46.217' AS DateTime), CAST(N'2022-12-12T11:19:46.217' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10134, CAST(N'2022-12-21' AS Date), CAST(N'2022-12-21T02:56:00.000' AS DateTime), CAST(N'2022-12-21T08:56:00.000' AS DateTime), N'Present', CAST(N'2022-12-21T01:56:17.680' AS DateTime), CAST(N'2022-12-21T01:56:17.680' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10134, CAST(N'2022-12-25' AS Date), CAST(N'2022-12-25T16:19:40.967' AS DateTime), CAST(N'2022-12-25T16:20:40.967' AS DateTime), N'p', CAST(N'2022-12-25T21:55:57.520' AS DateTime), CAST(N'2022-12-25T21:55:57.520' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10135, CAST(N'2022-11-04' AS Date), CAST(N'2022-11-04T09:56:00.000' AS DateTime), CAST(N'2022-11-04T12:56:00.000' AS DateTime), N'p', CAST(N'2022-11-07T12:57:04.250' AS DateTime), CAST(N'2022-11-07T12:57:04.250' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10135, CAST(N'2022-12-14' AS Date), CAST(N'2022-12-14T12:36:00.000' AS DateTime), CAST(N'2022-12-14T16:36:00.000' AS DateTime), N'Present', CAST(N'2022-12-14T10:37:03.160' AS DateTime), CAST(N'2022-12-14T10:37:03.160' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10135, CAST(N'2022-12-15' AS Date), CAST(N'2022-12-15T10:51:00.000' AS DateTime), CAST(N'2022-12-15T14:51:00.000' AS DateTime), N'Present', CAST(N'2022-12-15T00:51:42.120' AS DateTime), CAST(N'2022-12-15T00:51:42.120' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10135, CAST(N'2022-12-17' AS Date), CAST(N'2022-12-17T08:13:00.000' AS DateTime), CAST(N'2022-12-17T18:13:00.000' AS DateTime), N'Present', CAST(N'2022-12-17T01:13:57.403' AS DateTime), CAST(N'2022-12-17T01:13:57.403' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10135, CAST(N'2022-12-19' AS Date), CAST(N'2022-12-19T08:19:00.000' AS DateTime), CAST(N'2022-12-19T15:19:00.000' AS DateTime), N'Present', CAST(N'2022-12-19T10:19:59.930' AS DateTime), CAST(N'2022-12-19T10:19:59.930' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (10135, CAST(N'2022-12-29' AS Date), CAST(N'2022-12-29T13:17:00.000' AS DateTime), CAST(N'2022-12-29T20:17:00.000' AS DateTime), N'Present', CAST(N'2022-12-29T15:17:14.587' AS DateTime), CAST(N'2022-12-29T15:17:14.587' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (30134, CAST(N'2022-12-16' AS Date), CAST(N'2022-12-16T10:23:00.000' AS DateTime), CAST(N'2022-12-16T17:23:00.000' AS DateTime), N'Present', CAST(N'2022-12-16T12:23:54.927' AS DateTime), CAST(N'2022-12-16T12:23:54.927' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (30135, CAST(N'2022-12-16' AS Date), CAST(N'2022-12-16T09:22:00.000' AS DateTime), CAST(N'2022-12-16T16:22:00.000' AS DateTime), N'present', CAST(N'2022-12-16T12:23:54.937' AS DateTime), CAST(N'2022-12-16T12:23:54.937' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (30138, CAST(N'2022-12-12' AS Date), CAST(N'2022-12-12T10:19:00.000' AS DateTime), CAST(N'2022-12-12T17:19:00.000' AS DateTime), N'Present', CAST(N'2022-12-12T11:19:46.220' AS DateTime), CAST(N'2022-12-12T11:19:46.220' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (30138, CAST(N'2022-12-21' AS Date), CAST(N'2022-12-21T01:55:00.000' AS DateTime), CAST(N'2022-12-21T07:55:00.000' AS DateTime), N'Present', CAST(N'2022-12-21T01:56:18.850' AS DateTime), CAST(N'2022-12-21T01:56:18.850' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (30139, CAST(N'2022-12-19' AS Date), CAST(N'2022-12-19T09:18:00.000' AS DateTime), CAST(N'2022-12-19T16:18:00.000' AS DateTime), N'Present', CAST(N'2022-12-19T10:19:59.940' AS DateTime), CAST(N'2022-12-19T10:19:59.940' AS DateTime))
INSERT [dbo].[EmployeeAttendance] ([EmployeeKey], [ClockDate], [Timein], [TimeOut], [Remarks], [CreationDate], [ModificationDate]) VALUES (30141, CAST(N'2022-12-12' AS Date), CAST(N'2022-12-12T11:19:00.000' AS DateTime), CAST(N'2022-12-12T18:19:00.000' AS DateTime), N'Present', CAST(N'2022-12-12T11:19:46.223' AS DateTime), CAST(N'2022-12-12T11:19:46.223' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[EmployeeMaster] ON 

INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (12, N'ATIL-102', N'Priya', N'Dehariyaa', 6, 4, N'F', CAST(N'2020-01-03T00:00:00.000' AS DateTime), CAST(N'2022-10-02T18:30:00.000' AS DateTime), CAST(25.500 AS Decimal(18, 3)), CAST(N'2021-05-02T05:30:32.000' AS DateTime), CAST(N'2022-11-16T13:00:44.657' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (13, N'ATIL-103', N'Renuka', N'Singare', 6, 3, N'F', CAST(N'2021-01-01T12:30:32.000' AS DateTime), CAST(N'2021-02-02T01:30:32.000' AS DateTime), CAST(26.500 AS Decimal(18, 3)), CAST(N'2021-06-02T07:30:32.000' AS DateTime), CAST(N'2021-07-02T08:30:32.000' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (14, N'ATIL-104', N'Jaishree', N'Malode', 4, 4, N'F', CAST(N'2021-01-01T12:30:32.000' AS DateTime), CAST(N'2021-02-02T01:30:32.000' AS DateTime), CAST(27.500 AS Decimal(18, 3)), CAST(N'2021-07-02T09:30:32.000' AS DateTime), CAST(N'2021-08-02T10:30:32.000' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (19, N'ATIL-609', N'Poojaaa', N'verma', 4, 4, N'F', CAST(N'2022-12-23T22:22:07.807' AS DateTime), NULL, CAST(27.500 AS Decimal(18, 3)), CAST(N'2022-12-23T22:22:07.807' AS DateTime), CAST(N'2022-12-23T22:22:07.807' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (46, N'ATIL-108', N'Prachi', N'Jatav', 4, 4, N'F', CAST(N'2022-09-30T00:00:00.000' AS DateTime), NULL, CAST(200.000 AS Decimal(18, 3)), CAST(N'2022-09-29T20:15:45.037' AS DateTime), CAST(N'2022-09-29T20:15:45.040' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (129, N'ATIL-401', N'Ajay ', N'Pal', 6, 1, N'M', CAST(N'2022-10-02T00:00:00.000' AS DateTime), NULL, CAST(300.000 AS Decimal(18, 3)), CAST(N'2022-10-11T12:36:28.713' AS DateTime), CAST(N'2022-10-11T12:36:28.713' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (130, N'ATIL-106', N'Keerti', N'Ahirwar', 5, 1, N'F', CAST(N'2022-10-10T00:00:00.000' AS DateTime), NULL, CAST(300.000 AS Decimal(18, 3)), CAST(N'2022-10-11T12:38:26.420' AS DateTime), CAST(N'2022-10-11T12:38:26.420' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (10131, N'ATIL-403', N'Nirmal', N'Ahirwar', 6, 1, N'F', CAST(N'2022-11-02T00:00:00.000' AS DateTime), NULL, CAST(600.000 AS Decimal(18, 3)), CAST(N'2022-11-02T14:26:54.703' AS DateTime), CAST(N'2022-11-02T14:26:54.703' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (10132, N'ATIL-404', N'Sanjay', N'Ahirwar', 5, 3, N'M', CAST(N'2022-11-02T00:00:00.000' AS DateTime), NULL, CAST(600.000 AS Decimal(18, 3)), CAST(N'2022-11-02T14:28:05.670' AS DateTime), CAST(N'2022-11-02T14:28:05.670' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (10133, N'ATIL-105', N'Jitendra', N'Ahirwar', 4, 1, N'M', CAST(N'2022-05-02T00:00:00.000' AS DateTime), NULL, CAST(500.000 AS Decimal(18, 3)), CAST(N'2022-11-06T15:07:02.487' AS DateTime), CAST(N'2022-11-06T15:07:02.487' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (10134, N'ATIL-101', N'Anuja', N'Bansod', 5, 2, N'F', CAST(N'2022-03-08T00:00:00.000' AS DateTime), NULL, CAST(400.000 AS Decimal(18, 3)), CAST(N'2022-11-06T15:08:19.987' AS DateTime), CAST(N'2022-11-06T15:08:19.987' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (10135, N'ATIL-109', N'Keshav', N'Ahirwar', 6, 3, N'M', CAST(N'2021-12-08T00:00:00.000' AS DateTime), NULL, CAST(300.000 AS Decimal(18, 3)), CAST(N'2022-11-06T15:11:46.477' AS DateTime), CAST(N'2022-11-06T15:11:46.477' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (30134, N'ATIL-110', N'Jaishree', N'Malode', 4, 4, N'F', CAST(N'2022-11-11T00:00:00.000' AS DateTime), NULL, CAST(27.500 AS Decimal(18, 3)), CAST(N'2022-11-11T11:44:03.853' AS DateTime), CAST(N'2022-11-11T11:44:03.853' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (30135, N'ATIL-111', N'Pooja', N'verma', 4, 4, N'F', CAST(N'2022-11-11T00:00:00.000' AS DateTime), NULL, CAST(27.500 AS Decimal(18, 3)), CAST(N'2022-11-11T11:44:04.033' AS DateTime), CAST(N'2022-11-11T11:44:04.033' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (30136, N'ATIL-114', N'sravan', N'Sir', 4, 4, N'M', CAST(N'2022-11-11T00:00:00.000' AS DateTime), CAST(N'2022-11-11T00:00:00.000' AS DateTime), CAST(27.500 AS Decimal(18, 3)), CAST(N'2022-11-11T12:53:52.637' AS DateTime), CAST(N'2022-11-11T12:53:52.637' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (30138, N'ATIL-116', N'Kavyance', N'Ahirwar', 5, 3, N'M', CAST(N'2022-11-11T00:00:00.000' AS DateTime), NULL, CAST(48.500 AS Decimal(18, 3)), CAST(N'2022-11-11T13:08:34.623' AS DateTime), CAST(N'2022-11-11T13:08:34.623' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (30139, N'ATIL-117', N'Lavanya', N'Yangala', 6, 3, N'F', CAST(N'2022-11-11T00:00:00.000' AS DateTime), NULL, CAST(48.500 AS Decimal(18, 3)), CAST(N'2022-11-11T13:20:04.227' AS DateTime), CAST(N'2022-11-11T13:20:04.227' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (30140, N'ATIL-200', N'Amol', N' ', 4, 4, N'F', CAST(N'2022-11-11T00:00:00.000' AS DateTime), NULL, CAST(27.500 AS Decimal(18, 3)), CAST(N'2022-11-11T13:22:13.480' AS DateTime), CAST(N'2022-11-11T13:22:13.480' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (30141, N'ATIL-118', N'Navya', N'Praneetha', 5, 4, N'F', CAST(N'2022-11-11T00:00:00.000' AS DateTime), NULL, CAST(50.500 AS Decimal(18, 3)), CAST(N'2022-11-11T14:48:52.847' AS DateTime), CAST(N'2022-11-11T14:48:52.847' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (30150, N'ATIL-204', N'Geeta', N'Ahirwar', 5, 4, N'F', CAST(N'2022-11-16T00:00:00.000' AS DateTime), NULL, CAST(51.500 AS Decimal(18, 3)), CAST(N'2022-11-16T13:17:15.783' AS DateTime), CAST(N'2022-11-16T13:17:15.783' AS DateTime))
INSERT [dbo].[EmployeeMaster] ([EmployeeKey], [EmployeeID], [EmpFirstName], [EmpLastName], [EmpCompanyID], [EmpDesignationID], [EmpGender], [EmpJoiningDate], [EmpResignationDate], [EmpHourlySalaryRate], [CreationDate], [ModificationDate]) VALUES (40146, N'ATIL-205', N'Geeta', N'Ahirwar', 5, 4, N'F', CAST(N'2022-11-17T00:00:00.000' AS DateTime), NULL, CAST(51.500 AS Decimal(18, 3)), CAST(N'2022-11-17T15:29:43.877' AS DateTime), CAST(N'2022-11-17T15:29:43.877' AS DateTime))
SET IDENTITY_INSERT [dbo].[EmployeeMaster] OFF
GO
INSERT [dbo].[UserInfo] ([ID], [FirstName], [LastName], [UserName], [Email], [Passwords], [CreationDate]) VALUES (401, N'Keerti', N'Ahirwar', N'KeertiAhirwar', N'meghaahirwar01@gmail.com', N'Keerti@123', CAST(N'2022-09-05T12:00:51.000' AS DateTime))
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Employee__7AD04FF06D4C5A92]    Script Date: 28-02-2023 11:17:22 ******/
ALTER TABLE [dbo].[EmployeeMaster] ADD UNIQUE NONCLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[EmployeeAllowanceDetail]  WITH CHECK ADD FOREIGN KEY([AllowanceID])
REFERENCES [dbo].[AllowanceMaster] ([AllowanceID])
GO
ALTER TABLE [dbo].[EmployeeAllowanceDetail]  WITH CHECK ADD FOREIGN KEY([EmployeeKey])
REFERENCES [dbo].[EmployeeMaster] ([EmployeeKey])
GO
ALTER TABLE [dbo].[EmployeeAttendance]  WITH CHECK ADD FOREIGN KEY([EmployeeKey])
REFERENCES [dbo].[EmployeeMaster] ([EmployeeKey])
GO
ALTER TABLE [dbo].[EmployeeMaster]  WITH CHECK ADD FOREIGN KEY([EmpCompanyID])
REFERENCES [dbo].[CompanyMaster] ([CompanyID])
GO
ALTER TABLE [dbo].[EmployeeMaster]  WITH CHECK ADD FOREIGN KEY([EmpDesignationID])
REFERENCES [dbo].[DesignationMaster] ([DesignationID])
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CM"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EA"
            Begin Extent = 
               Top = 6
               Left = 277
               Bottom = 136
               Right = 458
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EM"
            Begin Extent = 
               Top = 6
               Left = 496
               Bottom = 136
               Right = 699
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_AbsentPresentEmployeeByCompany'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_AbsentPresentEmployeeByCompany'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "CM"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 239
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "EM"
            Begin Extent = 
               Top = 6
               Left = 277
               Bottom = 136
               Right = 480
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ActiveEmployeeByCompanyName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ActiveEmployeeByCompanyName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "EmployeeMaster"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ActiveEmployeeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_ActiveEmployeeCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PresentAndAbsentEmployee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vw_PresentAndAbsentEmployee'
GO
USE [master]
GO
ALTER DATABASE [astoriaTraining8.0Bak] SET  READ_WRITE 
GO
