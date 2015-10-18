USE [master]
GO
/****** Object:  Database [seeyourtravel]    Script Date: 10/18/2015 1:55:20 PM ******/
CREATE DATABASE [seeyourtravel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'seeyourtravel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\seeyourtravel.mdf' , SIZE = 3264KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'seeyourtravel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\seeyourtravel_log.ldf' , SIZE = 816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [seeyourtravel] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [seeyourtravel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [seeyourtravel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [seeyourtravel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [seeyourtravel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [seeyourtravel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [seeyourtravel] SET ARITHABORT OFF 
GO
ALTER DATABASE [seeyourtravel] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [seeyourtravel] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [seeyourtravel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [seeyourtravel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [seeyourtravel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [seeyourtravel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [seeyourtravel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [seeyourtravel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [seeyourtravel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [seeyourtravel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [seeyourtravel] SET  ENABLE_BROKER 
GO
ALTER DATABASE [seeyourtravel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [seeyourtravel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [seeyourtravel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [seeyourtravel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [seeyourtravel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [seeyourtravel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [seeyourtravel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [seeyourtravel] SET RECOVERY FULL 
GO
ALTER DATABASE [seeyourtravel] SET  MULTI_USER 
GO
ALTER DATABASE [seeyourtravel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [seeyourtravel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [seeyourtravel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [seeyourtravel] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'seeyourtravel', N'ON'
GO
USE [seeyourtravel]
GO
/****** Object:  User [SeeYourTravel]    Script Date: 10/18/2015 1:55:21 PM ******/
CREATE USER [SeeYourTravel] FOR LOGIN [SeeYourTravel] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [SeeYourTravel]
GO
ALTER ROLE [db_securityadmin] ADD MEMBER [SeeYourTravel]
GO
ALTER ROLE [db_ddladmin] ADD MEMBER [SeeYourTravel]
GO
ALTER ROLE [db_datareader] ADD MEMBER [SeeYourTravel]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [SeeYourTravel]
GO
/****** Object:  StoredProcedure [dbo].[GetFriendsLocations]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFriendsLocations] 
	@UserID uniqueidentifier 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select u.UserID, u.UserName, ul.Lat, ul.Lng, ul.[Time] from UserLocation ul
	inner join [User] u on ul.UserID = u.UserID
	where ul.Time = 
	(select max(ul2.[Time]) from UserLocation ul2 where ul2.UserID = ul.UserID )
END






GO
/****** Object:  Table [dbo].[Image]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ImageID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Image_ImageId]  DEFAULT (newid()),
	[FileName] [nvarchar](max) NOT NULL,
	[IsPublic] [bit] NOT NULL CONSTRAINT [DF_Image_IsPublic]  DEFAULT ((1)),
	[Lat] [float] NOT NULL,
	[Lng] [float] NOT NULL,
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Image_Description]  DEFAULT ('(EMPTY)'),
 CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImageUser]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageUser](
	[ImageUserID] [uniqueidentifier] NOT NULL,
	[ImageID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ImageUser] PRIMARY KEY CLUSTERED 
(
	[ImageUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Place]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Place](
	[PlaceID] [uniqueidentifier] NOT NULL,
	[Lat] [float] NOT NULL,
	[Lng] [float] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Vicinity] [nvarchar](max) NOT NULL,
	[Rating] [float] NOT NULL,
	[IsPublic] [bit] NOT NULL,
 CONSTRAINT [PK_Place] PRIMARY KEY CLUSTERED 
(
	[PlaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlaceImage]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaceImage](
	[PlaceImageID] [uniqueidentifier] NOT NULL,
	[PlaceID] [uniqueidentifier] NOT NULL,
	[ImageID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PlaceImage] PRIMARY KEY CLUSTERED 
(
	[PlaceImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlaceType]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaceType](
	[PlaceTypeID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_PlaceType_PlaceTypeID]  DEFAULT (newid()),
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_PlaceType] PRIMARY KEY CLUSTERED 
(
	[PlaceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlaceTypePlace]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaceTypePlace](
	[PlaceTypePlaceID] [uniqueidentifier] NOT NULL,
	[PlaceTypeID] [uniqueidentifier] NOT NULL,
	[PlaceID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PlaceTypePlace] PRIMARY KEY CLUSTERED 
(
	[PlaceTypePlaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PlaceUser]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaceUser](
	[PlaceUserID] [uniqueidentifier] NOT NULL,
	[PlaceID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PlaceUser] PRIMARY KEY CLUSTERED 
(
	[PlaceUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Role]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [uniqueidentifier] NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Track]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[TrackID] [uniqueidentifier] NOT NULL,
	[FileName] [nvarchar](max) NOT NULL,
	[IsPublic] [bit] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED 
(
	[TrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrackUser]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackUser](
	[TrackUserID] [uniqueidentifier] NOT NULL,
	[TrackID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_TrackUser] PRIMARY KEY CLUSTERED 
(
	[TrackUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_User_UserID]  DEFAULT (newid()),
	[UserName] [nvarchar](100) NOT NULL,
	[UserPassword] [nvarchar](100) NOT NULL,
	[FacebookId] [nvarchar](100) NULL,
	[Disabled] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserLocation]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLocation](
	[UserLocationID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_UserLocation_UserLocationID]  DEFAULT (newid()),
	[UserID] [uniqueidentifier] NOT NULL,
	[Lat] [float] NOT NULL,
	[Lng] [float] NOT NULL,
	[Time] [datetime] NOT NULL CONSTRAINT [DF_UserLocation_Time]  DEFAULT (getdate()),
 CONSTRAINT [PK_UserLocation] PRIMARY KEY CLUSTERED 
(
	[UserLocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserLogin]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogin](
	[UserLoginID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_UserLogin_UserLoginID]  DEFAULT (newid()),
	[UserID] [uniqueidentifier] NOT NULL,
	[Time] [datetime] NOT NULL,
	[LoginType] [nvarchar](50) NOT NULL,
	[CallerIp] [nvarchar](max) NULL,
	[CallerAgent] [nvarchar](max) NULL,
	[CalledUrl] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserLogin] PRIMARY KEY CLUSTERED 
(
	[UserLoginID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserRole]    Script Date: 10/18/2015 1:55:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserRoleID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[UserRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8e1491e0-ff35-413b-8cfc-00356f43d92f', N'79878940-87dc-405c-99ad-f45a6e312d80.JPG', 1, 42.49139, 44.56389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8811be5c-efda-4137-811e-004e3e8acc18', N'e9d79f64-8ca8-4e1b-a141-e82943f2c576.JPG', 1, 47.80181, 13.09469, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9a67740b-384f-4037-b70f-00777fc13b95', N'45be2bed-f178-469f-993d-f1d8cd8e2e0b.JPG', 1, 59.915, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f201bb20-b26c-4bae-a8f4-0089dda0f424', N'f4c00bff-b100-4234-bda4-a7b2128b7520.JPG', 1, 49.85519, 24.04025, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'71aa83eb-f2a8-4f66-8dd2-00ce2cd3612f', N'17c61bd5-cd56-4da8-aafd-1014fbc952fe.JPG', 1, 49.8518, 29.76553, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'cd2fb736-b7e2-41c0-8aae-010d56ed3e42', N'750f04b5-9066-4b21-b20f-78d18dbebe25.JPG', 1, 41.70692, 44.9415, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e506662c-a84e-41b5-9c4b-022562d63ffc', N'5b5c4152-297a-4eee-9fa5-43021f47b2a6.JPG', 1, 54.03389, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2b5363c7-0bb7-4a61-b84e-026cb09999b9', N'cf63b4f3-3066-468a-ae69-ab85f612e7c5.JPG', 1, 41.69963, 44.94617, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4e549ed0-5efa-4890-9926-02be68787d2b', N'35675acc-fd96-414d-9e56-443d8d336fe8.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0d69a271-d2ab-44b1-b95a-02d98cb17503', N'08024569-091d-406c-a4ac-4658e95a8678.JPG', 1, 60.86417, 6.563889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0b477d52-bd87-4824-b725-03a4725c568f', N'b08ac85b-5390-4e1b-8c7e-74dced910dbb.JPG', 1, 42.47258, 44.55767, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3c568235-9a04-4f11-a3e9-045571bea8c4', N'6697edb8-d8aa-40a1-94a2-665e275c82e8.JPG', 1, 41.70709, 44.94111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'591c220e-5a44-405f-8052-045952603a0f', N'2ad4a212-3ef9-465e-b39c-02f9783ce906.JPG', 1, 31.77944, 35.27222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bb989e9b-1208-478a-99a5-04d668b6b6c3', N'a235a07a-ae1d-49d5-a5fc-b62cfd574c98.JPG', 1, 31.77944, 35.27222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'db4b08fc-c2e2-41b5-b858-05769a58a6b3', N'94962613-b34c-4cd9-994d-4d7a4cf6833f.JPG', 1, 50.43835, 30.62903, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'03cbcefb-f210-4f25-829b-05a18f0cf2a2', N'c7725301-460c-4cab-9690-ea021950c3fc.JPG', 1, 49.85756, 24.07681, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9b9d4694-eebc-43e4-ab01-05c1639937c1', N'6e783633-0092-4e0f-8c03-9bd8033d7690.JPG', 1, 41.70675, 44.93605, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'57163b2b-23d5-4cbb-9d29-05ee7944d9e6', N'221fffbf-619b-4e8e-8d34-3923b12a8184.JPG', 1, 41.70472, 44.93022, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'23a49adf-5845-4a6d-b488-06a3db471710', N'63966557-3bf0-40a9-b906-a5f327b41dae.JPG', 1, 42.47241, 44.55942, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5661e922-e760-475a-ac56-0782c628df13', N'5ee02429-f1de-4ba2-8bf7-d142a33beeda.JPG', 1, 50.46089, 30.616, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3649bc52-d9fa-4eb5-9d5a-07e130122ca1', N'5d3da459-af47-4e39-8af2-2488bd472b5c.JPG', 1, 48.01169, 10.68406, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a1e5a6a7-00d9-429c-a2d3-086bdec05712', N'33dc5a20-7104-4643-b7ee-aacc316718a8.JPG', 1, 41.69947, 44.94111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'901e1428-3072-4389-9017-08dcea6f9914', N'70ef8561-6bfd-48db-a32e-796cbb135325.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ba247e56-4856-4bfe-ab2a-09162acc5720', N'ae3d75c1-8594-4d80-96a9-d7dfec749f47.JPG', 1, 49.98617, 25.04825, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ad81e5eb-9138-48f7-bed6-09a042e59de6', N'43bf2e38-43f5-4230-9079-aba7a2a102c0.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'22fda6e8-a0a6-45f0-a462-0a78fc30bddb', N'ea21beb3-653c-425e-b4e0-434358071ce7.JPG', 1, 47.43361, 9.435555, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f12cf689-0c2e-4d56-8026-0a880cf00b0e', N'fdb324d6-0dc6-45e1-adcc-9c49bed97401.JPG', 1, 60.44056, 9.35, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'be7f6766-5a46-40d1-82b1-0aafe9b3d70a', N'd9e5a006-dec3-4e37-ac9e-5ae5a213299e.JPG', 1, 60.77945, 8.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2310f118-62d2-41e9-b2b2-0ab10221154d', N'1796316d-fe67-483c-8cc1-37e9f5c1c3d1.JPG', 1, 50.75149, 25.37722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7d341fc6-6da2-4beb-9cb0-0ad20afa51b3', N'ce51d5f1-a0cc-4e07-89cb-a47b1b0a1324.JPG', 1, 13.76487, 100.5759, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'761eab59-101d-40ec-8d4f-0ad4c11adec3', N'07b67e7c-e691-4d0e-9931-19f38c63d610.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'58618f15-19eb-4c60-b29d-0b527b4c0012', N'b7b318b3-a6ec-4058-aeaf-b255abbeb20b.JPG', 1, 60.62695, 6.311111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'68a7e119-54ae-4663-b3e7-0b5b99042f04', N'16aae339-9548-45a3-8ae5-8f5e1aeae12a.JPG', 1, 49.8518, 24.02528, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1ecb11a8-2ea3-4fe8-ad2c-0c2b719b50fb', N'6d137ce9-30d7-43fc-9492-b866584edf92.JPG', 1, 41.70607, 44.94072, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'106029ac-09be-4954-882c-0c31b08e1157', N'af417ee9-6dca-4b31-bb62-c9cf500c5eb2.JPG', 1, 49.98464, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f9712231-0de2-4433-ba37-0c6d6749f414', N'a9f5abfb-47e2-4316-a6ba-065331604edc.JPG', 1, 60.62695, 6.35, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8f56a2fb-d628-455d-a7f2-0cbeefb79dba', N'453e7cec-2e72-4589-b86f-f65633c031b3.JPG', 1, 60.22028, 10.12778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'aae01440-7cc6-41eb-9a6c-0cc2babc58cb', N'95dea972-c52a-41fd-95ca-5593e5f94e0e.JPG', 1, 49.82418, 30.11492, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'972cb9cb-0299-45d0-9f9c-0cf76cefed47', N'2890336c-6255-438c-ac89-de427fa92216.JPG', 1, 49.9843, 25.05, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd08661c4-0590-46e5-82c6-0d1b6887df5b', N'fc962bf9-25cb-42d5-9996-ceb8ae9d590c.JPG', 1, 60.18639, 9.719444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bf27080c-66aa-47fe-be18-0dd02ce85290', N'b64c93e5-a3c9-4cb8-b7e9-e78ff2d71f5d.JPG', 1, 54.03389, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7d235f43-2dfb-40e0-b4dd-0dd4822d69a5', N'f00de786-fcd3-4c73-ae96-6cd0410cd6e7.JPG', 1, 47.49427, 11.20942, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bbc34876-805c-4016-93bf-0ecde24ddbc2', N'eaed9f46-ef1b-4bc5-96ee-df10a45be2c5.JPG', 1, 13.75335, 100.5932, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'039fa9f2-66f4-4c41-b512-0ed53d67f1e2', N'29630d9a-ac11-43a5-b33f-0eccafaf7ed3.JPG', 1, 48.14132, 11.66169, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a08ce13e-51f8-48fe-b222-114834676380', N'e5029eb6-1de2-4a36-8dde-4717ad628818.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'658caf42-a5e3-44a7-8880-1156a23215f3', N'08c65b5f-89be-41ce-9070-1ba2e672e4d8.JPG', 1, 60.23722, 10.08889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4f19f793-b332-49a7-8fbe-1172987af66f', N'5192e55e-cf58-4782-99e6-71f56eaae368.JPG', 1, 49.98481, 25.05058, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3c150391-eeba-401d-887e-1495e173274f', N'45761000-0e8a-4716-950b-6ad6865e8f67.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9650ac6c-9678-4b71-be16-15665b477ca8', N'09dcb711-9b20-4a9d-8fc0-6da115ef31a7.JPG', 1, 49.56916, 25.7002, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd153c60c-eb3f-4ec7-b545-1616b7126b45', N'08e2e6e1-ad83-4d99-ba9d-889bcc6fd55a.JPG', 1, 42.47445, 44.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ec7660e2-4193-4b6e-9d72-162f6687e424', N'f37ef24e-4812-4620-a615-94dd3ebe2085.JPG', 1, 49.84671, 24.01497, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a019ca74-9c74-4f2c-a065-1639945f99c6', N'8a4df82c-6c10-47b0-9226-45c7ae5c4ce6.JPG', 1, 49.98481, 25.05058, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2ee142f5-e2d7-46ea-bdf4-168d77ec2156', N'787657ee-5d89-4316-a5d7-917ac8771223.JPG', 1, 41.70591, 44.94072, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'08dab755-9df6-4348-883e-17243a9676d8', N'ad79b6a2-ce8e-404f-b779-b0e4a2db951b.JPG', 1, 60.18639, 9.719444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd5b6f3cc-3561-4b47-ac9b-173b0d7a7ba4', N'ba4992f4-b3cf-4063-a05e-ce18e2968fb4.JPG', 1, 42.49139, 44.56389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'879b1729-d0b9-4a75-936a-179af210344d', N'1e139582-f6d1-4cfb-a506-595863c3b3d8.JPG', 1, 25.25552, 55.42369, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9c7126fd-fd5f-4c63-a22c-182b7d3bd212', N'6400e4a1-d7ea-41bc-b2b6-ff53beec1225.JPG', 1, 41.70591, 44.94072, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'36c36d0c-e69d-49e8-a1f2-18af9f6fed53', N'd7850536-66f0-4b43-a991-791d4741464c.JPG', 1, 47.44056, 11.30314, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'fab44b97-14d9-447b-bd54-1a02497e5843', N'ee6ac49e-8bc1-402a-aa18-581fc7582b8f.JPG', 1, 41.70573, 44.94053, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'14ec17a7-511b-41c0-bb6c-1a4acb60fe1c', N'5c28154a-c881-4afd-baec-f2ac235f3490.JPG', 1, 50.42361, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5ef22f53-f502-4e41-ba36-1a9840fc2a92', N'ec16f100-a4d7-4712-a509-17901a4d9e4d.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3b5c63f8-9cba-4bb6-b0f9-1b094cb9e5e8', N'034a280b-9bed-4b33-a99a-b897a14c8e2a.JPG', 1, 60.54222, 6.291667, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e4e9b61a-9e2b-417c-a360-1b9e1b6eb380', N'72337fd9-7bb1-4b6a-bf92-fc95aa1745f8.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8fd32c41-bbfa-493d-9bca-1bbe009b120e', N'0139db85-080e-4567-b623-9f93af90448b.JPG', 1, 49.85875, 24.07195, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'15b8c733-9b47-4079-9e7c-1c712a9ae033', N'452f07cd-b57c-4613-a2ac-ad9151028dfc.JPG', 1, 50.4553, 30.60939, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0febdc22-336b-481d-a709-1dbf4c9c6c9c', N'a6e240fa-7f43-4a83-8834-8c8fa4fc26d4.JPG', 1, 47.80181, 13.09469, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'408a429f-6e32-495d-81c1-1e12a0fc90f7', N'c803324d-a05a-4f16-b09a-4c9bd007c041.JPG', 1, 48.00881, 10.70078, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'755e08d2-598b-46bb-9d0e-1ea58adaf205', N'ae383099-ccbc-4cff-9b6d-bada2b48a567.jpG', 1, 49.56916, 25.7002, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'50f11e83-e77a-41f0-a4dd-205de2f7ee7e', N'e7d22f79-78da-4006-a93a-3e8508d93d14.JPG', 1, 42.50545, 44.59344, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'de9279d7-5d9b-4bf1-8cea-2102961e7bdb', N'905bf6c1-bdc3-4c71-91ea-28b5adcfa810.JPG', 1, 54.05083, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'75a7cfbe-9980-4e75-852c-218127876b01', N'ae17e3f1-32e5-489a-be85-2d45cc5f96d1.JPG', 1, 31.77944, 35.19444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c7eac928-2cbe-4bec-9a60-21a5bd5b9235', N'f0544fef-e729-4ddd-b572-0669b7fde8c3.JPG', 1, 49.98464, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'225b2ab4-c02b-4031-8ecb-22789989cefa', N'35aaf449-974c-473c-b9a4-bf108c624556.JPG', 1, 41.70607, 44.94014, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'852291ac-8bd2-4d2f-92b7-23671012f8fd', N'fb544bdd-f28d-4e8e-bde2-7923d3b71d26.JPG', 1, 49.85197, 29.76553, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'28bd648d-1748-4333-8a46-23804857ddcd', N'8b59f852-acdf-4248-8cd9-92b22aa6c76d.JPG', 1, 47.80181, 13.09469, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9983f772-a1dd-4fe4-8048-238fdbb3c888', N'eac20919-d691-4a45-837e-2909cbc5c135.JPG', 1, 50.43971, 30.6088, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b1b78aa4-fd89-4758-b46c-23fead21f180', N'4381188b-7d0c-49d1-8e48-f89cba273bd1.JPG', 1, 31.79639, 35.23333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'455176a5-7da2-49b0-b420-24bcdd05f76c', N'eff93ab9-5174-4c4e-8f60-2dc1868cc89b.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5065fd28-4f7a-4ed4-83fa-24c9bb87bdf9', N'76a51428-83c5-41eb-a60a-22a4e1bf2829.JPG', 1, 49.98515, 25.04922, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2fd96ddb-ed7c-481d-a46b-24d1034c4372', N'2de7e025-0bf2-471f-8af4-f013da46f9ae.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'099412aa-f625-4dd9-a7fc-24e7f2809614', N'ac7a99ca-42f3-4922-a87b-f6ddf72dd5e0.JPG', 1, 42.26823, 42.78303, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'fe51dfbc-ea53-4fa0-9f4d-2523bf2fea07', N'468324e3-910e-4221-93bb-3b59f3abfc56.JPG', 1, 49.98481, 25.05058, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'16360e85-05af-4f69-9f09-254fcff8f786', N'4b9b0891-e40d-49d7-9886-8b1cb1ac74b9.JPG', 1, 13.75691, 100.5857, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2f371f6d-df10-4135-a09a-257e4ddb0db5', N'119bde79-34df-45ca-a5e7-27a75e37b8d8.JPG', 1, 31.77944, 35.27222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd0920b08-d123-4f28-b203-25affb11c5cb', N'01444936-a8ca-4350-9fc8-41c115cd8ec6.JPG', 1, 49.98464, 25.04942, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8e02d6c9-e85d-4593-9c5e-25def09f8af8', N'36c7fa49-9dfd-48cb-a0bb-90c6ba84ef24.JPG', 1, 60.38972, 9.680555, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'99eb0565-747f-4591-b923-2616e91bb1fd', N'ce901ef6-1243-4c8e-aae7-6cadfb2bd205.JPG', 1, 49.98007, 24.97164, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'fd81e45c-4c81-4b81-aa2c-2633a16a914f', N'90f97a7c-3c40-457e-bf75-937d365d1359.JPG', 1, 48.62661, 24.91097, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'97a91386-9c7e-4191-a8f1-263e57075d4d', N'9f6a82a1-109c-4dc8-ae40-951e917523f5.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8d1ec9be-7fd3-4e08-a42a-274612cdcf58', N'06ecd289-ebf4-46f2-8fc8-e1a620ccad24.JPG', 1, 49.81536, 24.05992, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'59295d4a-0e3c-44dc-85d1-27fc1c53dc66', N'fa515bd1-2e6e-4458-acbf-94c64a5bfc31.JPG', 1, 42.49783, 44.58178, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'cad54931-58b5-485c-b3b6-2813e984840b', N'791e4fe1-3697-402b-b88b-c09d4ab49546.JPG', 1, 41.70591, 44.94014, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6777df08-5446-4df2-a347-29fc35f896e1', N'a8f55201-7b92-4ff5-b318-0f12611bde28.JPG', 1, 9.459534, 100.0463, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'75bdc4b0-95f9-43ca-873b-2a16cd10ea22', N'eda90b78-e3bf-440d-9dbc-2171044b8a62.JPG', 1, 49.85756, 24.07545, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a80d0466-6ed6-4888-8774-2a629c2a59a0', N'cdeb67f7-a79b-45d1-9692-cf35c2a4c682.JPG', 1, 60.16945, 9.777778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ee402aa3-df57-4568-b6f0-2ac2811c64ce', N'c2e0383e-1838-4c4e-abdd-cc04e858502c.JPG', 1, 41.70675, 44.93975, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd7c5548e-5e3a-47bc-a03e-2b140c3241f4', N'9411bef9-c6a1-454f-a995-d9c19a25333b.JPG', 1, 49.98481, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'cde3a34a-1373-4ffb-8e13-2bd28cefaf31', N'f1e8042c-2128-4efc-b506-d7025ee47afc.JPG', 1, 48.00949, 10.69942, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'075e19aa-538d-48be-9674-2bdb0ca68dd8', N'd8b44064-a920-4557-8049-60580e1fbd38.JPG', 1, 60.4575, 5.505556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7e8e174b-232e-4f72-827e-2c15e456ca9e', N'8ea5c274-0284-43c9-a9cc-cb6859d7e2c8.JPG', 1, 49.98532, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6ed8e857-248e-4e12-8061-2c2297271c1f', N'12160030-f183-44d9-9d80-efc934ce8cf5.JPG', 1, 13.7708, 100.5827, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'190f7c93-6bd0-4650-bff8-2ca55b74d8ac', N'd71a5f47-04ff-4e74-aa31-fd30ba48806a.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e002d08f-c8bb-42ff-96ea-2cdc99820166', N'2137b0fc-61e2-4a30-8d02-1ea70f8af5f6.JPG', 1, 41.70658, 44.94014, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f590e808-eb68-4c7e-bb4e-2d002ce14724', N'32ce69fc-e224-4c84-a83e-f20229ae3b03.JPG', 1, 48.36702, 24.44839, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd424278c-9658-480e-b678-2d20fe000a7c', N'9c750c7a-fb19-4490-9c02-7f08cd65349f.JPG', 1, 60.81333, 6.913889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f9fa78a9-3e82-4413-bace-2e1fe0a34c2a', N'c7ab81df-8232-4536-9dba-ae1a4db5357b.JPG', 1, 59.94889, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f205e71f-b9ed-47c2-a782-2ee5e35b3aa8', N'4a322c9b-d663-402e-9a53-959a9d85f27d.JPG', 1, 50.4575, 30.60278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4c67aac9-9f90-411d-aca8-2f2804190c85', N'41973a10-caf9-4401-9450-c7f09c31c08d.JPG', 1, 48.00881, 10.70058, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5f77537c-5120-4d45-8e8a-2fa08988813b', N'8b11c1e7-98bf-4bc1-bd69-6bbdbdfc1565.JPG', 1, 47.80283, 13.09003, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'17a52668-c76d-4d7f-b5f0-30271eb8637d', N'33106797-2f18-45ce-b485-fb1db3f37163.JPG', 1, 50.42361, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'274fd624-36c2-4b7b-8fde-309305ccfcda', N'3affabbe-66dc-43fb-a708-144914cb70fa.JPG', 1, 45.43903, 11.15208, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'84dd4ccc-5f41-40d0-9b91-30bb6a97f5fd', N'4153549e-ff9a-4c56-b2aa-95d0ae2a9992.JPG', 1, 60.86417, 7.136111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c9962058-7e88-48c9-8b56-31f08341925a', N'10aa5822-e144-46f2-bce6-c68a77bf6be7.JPG', 1, 41.70675, 44.93995, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b5f65e92-2d93-4d07-998e-3202dc58bc32', N'7ed2f580-3e2d-4bfc-bb7b-c63d85a2058a.JPG', 1, 49.98515, 25.04922, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'78ee8165-429a-42ca-8c77-32ca02159b42', N'8b497e69-7466-4a3d-8cae-489a553ccf7d.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c095eb47-3c62-40b6-b66f-33242b3a4164', N'daf8b1ad-f51a-450c-9ba1-9f06ad82f70d.JPG', 1, 60.22028, 10.12778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'73aaa446-cea5-4d41-b234-3362e78bc42f', N'819dfb61-f6ea-46f6-851e-9cc2e5127afd.JPG', 1, 47.39497, 11.30683, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bba48611-3c5d-4995-bade-3370e4f9467a', N'6124abb2-2a0a-4523-936b-196cd004593e.JPG', 1, 49.84519, 24.01186, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7dfa2f16-ec7c-442c-90f9-33dbddc7da1a', N'9e86eb6e-1a9a-48dd-92a8-5618f284ee2e.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2dedcddf-b0cd-4797-b6f9-34b3c69c2b60', N'54b9eac3-04fe-448a-867e-e3ca03e0cc0b.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2194a923-b1a4-4490-a91d-34b96bb7b163', N'8939143e-99a8-4462-a214-f750b2b02666.JPG', 1, 46.74098, 36.94909, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5b916fae-f684-4a07-869f-34f4feebbd3d', N'143432f8-3c63-4d28-b9d3-59c9bacfa428.JPG', 1, 42.46953, 44.56486, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e325313e-363f-423e-a9b9-35de618d5a42', N'eecc6abd-3215-4742-a354-a09a486fd2bb.JPG', 1, 49.85129, 29.7667, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a6e53dfb-16cc-4539-a83b-374a09469cd6', N'f2a11e05-d3db-4fa5-beeb-a456c2145324.JPG', 1, 47.39481, 11.30625, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'951a9eaf-56ff-4bcf-a117-3756b4c2d5cb', N'99fed052-cc8c-4620-b4cd-501968e6f3d9.JPG', 1, 45.47224, 9.22225, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ed7cb585-7589-41d1-9dfb-375bbac07b58', N'd5509b18-0105-48db-a8ab-2811609b94a5.JPG', 1, 41.70675, 44.93625, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'13a2dde4-9309-4c61-bd3b-37615ebebc19', N'208458e6-83ec-49a4-becb-56fbcd64ebde.JPG', 1, 61.32195, 6.311111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4393c11b-08bd-4c87-8af1-379269fbdc8e', N'e0f14151-c84e-4240-a1f4-15317bcbd85d.JPG', 1, 49.98464, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bdaadad5-b3d6-4ce3-9647-379ad343aa11', N'b540bb66-9d31-463e-af1a-10b559c25ba5.JPG', 1, 42.49139, 44.56389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f3fcb821-b06b-4e31-91da-37b0ce62fc33', N'79dec898-a9a2-467c-b93e-a5c0ef9d4fc6.JPG', 1, 49.82418, 30.07311, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'826fbd63-ec8d-4912-abc6-37f663026aba', N'bd5f5466-0dc7-4cc7-b345-09ea0343da29.JPG', 1, 49.98532, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd899073f-0b55-40e4-8d1f-380e36abe258', N'd6750cce-77f8-47f3-aa3a-e5cf70f42b6e.JPG', 1, 49.85247, 29.76981, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'177f4c7c-449c-4e88-9e19-382eeff08de2', N'84925ebd-493e-4a66-b542-3612e5a5645e.JPG', 1, 9.621183, 100.0412, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'69203170-19d1-49ec-8c4b-383a86cbad38', N'f7a467a4-3762-4989-8965-3885114ed8ad.JPG', 1, 42.46817, 44.56506, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9c6ba6d7-2d48-45d7-9936-38f8a1cd62c9', N'63a57dc7-63c9-4396-afe5-06b051671a31.JPG', 1, 45.44496, 11.15889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c7e31a67-3093-49aa-bdd6-39579189d04c', N'd8840982-03d2-4fc2-96ae-c27d8c3ed850.JPG', 1, 47.44072, 9.450916, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ca740647-67ea-4219-8323-395b559b7aff', N'b94cbe14-b9c2-4eb1-b741-29e19c383acb.JPG', 1, 50.09641, 25.85322, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b32d8fc8-6190-4d17-baf5-39a701973087', N'6106c17f-4359-4793-a3da-a3883e908c35.JPG', 1, 42.47258, 44.55806, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'438fa66c-6a26-49bb-afed-39e8074ee370', N'6f9726b2-f7c5-4625-b64a-9ddce1f71d67.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9add8101-6846-4596-ac0d-3a478ae8ec21', N'37c75ba8-37ed-407a-9fe7-4385608434ea.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f65063dc-6a3b-483d-8f5d-3b113830296a', N'532ed932-f3b0-4dcd-ad28-3c280408cacf.JPG', 1, 46.13708, 30.61833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6fd1c9b7-d4c9-477a-98a5-3b5f43be7b93', N'a9ca00ac-3a43-4e1d-9450-092ba690008e.JPG', 1, 49.986, 25.04844, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f1cc18cc-5fe3-4459-9f8c-3bd2b8a691d2', N'd157eac5-261b-46b1-bd70-20fe34656e78.JPG', 1, 49.986, 25.04864, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5c19d223-d826-4485-9979-3cb4d61bed05', N'bad8f3cd-bda6-4b7d-a174-a495df47dde5.JPG', 1, 49.84468, 24.00447, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e4912581-4fdf-4eec-82a4-3d3e354b0d36', N'd4f09201-0287-4317-aff6-acdbaf92bc33.JPG', 1, 60.38972, 5.369444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'76716496-567a-4d93-97c1-3d6eb3f41cb9', N'9edf319b-9370-4d85-9c7f-9b32605ac718.JPG', 1, 50.53951, 26.10656, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a202ad1b-d9dd-41a7-a777-3da0a35efd7c', N'1b09fb29-8708-4596-a105-4128a4072b17.JPG', 1, 60.86417, 7.136111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ad4eadfd-b2a0-4a80-a08a-3de4efd139e8', N'a6776bef-613d-4a5b-9e14-2f0bde1fc3df.JPG', 1, 60.47445, 6.933333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5a2af782-a143-46b6-864e-3df4776a7a48', N'39f9d243-7912-4d8c-9415-1183c9443f3b.JPG', 1, 13.75877, 100.5754, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'dc6cc64b-bbf9-43b9-93c2-3e59a07bd996', N'912f5b2d-0600-4381-9123-8625219c0122.JPG', 1, 60.22028, 9.719444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2b2e6817-2cf8-4452-a0fd-3edc1eeb0a61', N'30a4279f-bd95-4df4-b9e0-2a334c053a9a.JPG', 1, 42.48919, 44.57614, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd903c6a4-d794-4238-97eb-3ee0e5653df8', N'74d5c56f-c8d2-42dd-aa0b-96715f9025c6.JPG', 1, 42.46817, 44.56506, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9a74b5e1-dc56-46f6-a1aa-3ee85830ed76', N'78218f27-9b4b-43f6-8ad9-a472d7fdc4a8.JPG', 1, 13.75877, 100.5752, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c5d0df85-c1f4-4c54-b4fe-3f5c521c4b14', N'ddc51ceb-47c8-4e5d-a011-748c40dc7b23.JPG', 1, 47.43327, 9.435166, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'661b5001-7619-4daf-b32c-3f69ea1024fe', N'763fb643-9995-43dd-8148-5f0abd93c540.JPG', 1, 48.00881, 10.70175, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'66fe8f40-0093-409b-898e-3f7d9e366972', N'442a925c-83a8-4278-98f1-7f5ebb480ae1.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd74c9f01-a705-4aa9-8abe-3fb37f59f3cc', N'ef47af97-9e64-462f-9c27-241509cba4a2.JPG', 1, 60.81333, 8.797222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8abf1d3b-06ba-4845-81bc-4012a0c768bd', N'c2fcae4d-469d-470a-8e29-ae049393d2f6.JPG', 1, 13.76436, 100.5761, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'33c7999e-d51d-44d3-8ae2-4021978c25da', N'8e2ab06f-0020-4faa-8f88-802779aa7a94.JPG', 1, 42.49139, 44.56389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'16e23f36-7b1a-4700-a3e4-4045603bbd98', N'f23c6474-8a76-4a22-8e37-befcf5828187.JPG', 1, 60.18639, 10.15556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'16fe16cc-8932-46c3-961a-409b28cf3b25', N'f0e706fb-3fc0-4f79-b641-a03c6e2c413e.JPG', 1, 49.56916, 25.7, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'022e4254-d810-466d-aad1-4127f7255600', N'4687ee33-8a00-494f-9e67-b1edf85936b9.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd271be92-0d7e-4991-a73d-4172848cbc51', N'0f878c45-0ac0-4b11-a510-a0dba79e4042.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'39b8f84b-a78e-42e6-b4f7-41885aaa884a', N'834d25d3-fb98-444c-bcb0-5cc53267684f.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'510b3053-5d24-48c5-a14c-4192ac400c3e', N'220737cd-d50a-4b5e-8168-5fc7c08e584d.JPG', 1, 42.47648, 44.56797, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2257b8d3-66eb-48f6-a893-41fefa96d2fd', N'fcde37bb-41c0-4ef8-bfbc-49b3b5566af6.JPG', 1, 60.79639, 8.855556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7c455e0a-6de2-4a17-9d5b-42adeb95dfab', N'85343fef-11b8-4ccf-a4d0-90581e89a009.JPG', 1, 48.00881, 10.7, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'185a1b97-6697-4b00-ae5b-4376a58a96c4', N'6c3023f6-29d7-482b-ba4e-90d1956556dd.JPG', 1, 53.99972, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'28a6616b-c74b-4cc4-8918-43a3e65bcea5', N'4826b0a1-6d2b-4c3f-99c8-d909f3e7bfd6.JPG', 1, 49.54222, 25.68056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b08e79d6-5ca1-4926-9960-448f4bdf4c3e', N'871e391d-4bb4-44a6-884a-417d29451711.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd26490db-191a-4f76-9733-44b7cc627a13', N'6ac37751-3024-4da7-9bbe-3c55337de010.JPG', 1, 48.14962, 11.67122, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'694abb5a-8a92-492f-b527-45649e26c26f', N'c86ff9bf-4940-4c11-ad2c-7985369bb7fc.JPG', 1, 45.44496, 11.15889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3201c48d-3bc1-4f04-826d-45675486d1bc', N'6c26b1eb-c492-4a56-8ef5-1f8cdd867c00.JPG', 1, 47.43293, 9.436722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0579ed90-bf4b-42f7-878c-45d24e202c35', N'9fcaed7c-3f77-4710-a27d-4442fb7e43e5.JPG', 1, 59.96583, 10.85556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd4aa3a3f-15f2-40fb-a934-46c97f017b82', N'33658ddd-226d-4874-81f5-9fab0b13f3b5.JPG', 1, 31.77944, 35.27222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'20e88cbe-0c1d-4190-a73c-46cabda93cb4', N'f49275e8-4dfa-4503-9bb9-4a9d5702115f.JPG', 1, 50.14775, 25.87733, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4e633a7c-4f33-4c3e-bfed-47464e7ab54b', N'653965ee-b4eb-4445-9314-790d9e7a1a52.JPG', 1, 50.4575, 30.60278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3dac8793-84d3-4eca-8277-4842e6c6f517', N'cbfe4b63-04da-41f7-aadd-9e6b1c556b08.JPG', 1, 41.70709, 44.94111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e4c0d40e-f04f-44ee-a3c2-4a09b4f408f8', N'7bb4074e-69ec-4361-86d1-77d12a5ccda3.JPG', 1, 42.47038, 44.5635, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e8b17ba1-3300-474b-a5e3-4af2f252e5b2', N'7480225c-83cb-4ff8-b6d9-964a5ef6acf5.JPG', 1, 50.49495, 30.58061, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b9b749cc-dd23-4cd9-91ff-4b57da1d3530', N'9ea6cd10-3f5b-4b0e-b2e2-a05ecd3f7ef6.JPG', 1, 49.52528, 25.79722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4389fd13-7533-4d15-be9b-4c7b7ad695f8', N'efa0c7f4-ca3b-43e7-869d-97894b12f4d4.JPG', 1, 49.98413, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1cc9bd1c-d31f-4ad5-ac0f-4c8c51357e67', N'4ad252fd-f0d5-46be-9b5e-5a1fd66fbece.JPG', 1, 48.00328, 10.21253, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bc54c248-d8a5-449f-adc7-4df980c3ad82', N'42895786-266a-4955-bdf2-bd876869194e.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a7c1b4c7-9e4d-40fc-a116-4e4837e72568', N'bd4e24d4-a7f5-45ff-b50a-738b7d837f79.JPG', 1, 41.7076, 44.93664, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2fa48aa5-9a21-4b04-b390-4ed3ac89b78a', N'07397f6f-0584-4dd6-a2e8-b12c9f68952b.JPG', 1, 50.09658, 25.85147, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b02f40c4-7919-4b13-b08e-4f1dcf96a159', N'c5e725b4-a7cc-43ac-a698-73b2cc86741a.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'63861339-562d-4a0c-8ef6-4fe8d428ede1', N'b5561e53-53f2-4c32-a564-9b2178948d17.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4069d44c-cc13-4654-8693-50f678166b20', N'0def8480-f897-4258-88cf-573470af49b1.JPG', 1, 42.47445, 44.56389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'25c6dfa4-95e6-42b1-941f-5147def7ac28', N'ee1f6a5a-f138-4608-9bf8-6a7e46d46a17.JPG', 1, 50.14775, 25.87753, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'44a50414-feb5-4b9f-b888-519962a63234', N'ada22058-ca27-4a6a-ab3e-b5e645a068b1.JPG', 1, 13.76436, 100.5761, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0f9704d3-0378-4540-be3e-51b72c05feda', N'4a1b90ba-d5d7-4208-bc7d-8eaf4d26d2d2.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b1feb63e-8ea1-49d1-a309-5235508d9a9d', N'3905200f-38f7-444d-afe0-d5606a23d500.JPG', 1, 25.24637, 55.42545, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'513bbedd-0618-46de-9377-52a2988a5320', N'd05f3254-6658-4217-a9bf-5787b753cb83.JPG', 1, 47.39227, 11.2975, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'39006d23-a536-4b53-88ef-52e2d9638b42', N'1e1ffac1-a25c-49a1-892b-ca559a4bac69.JPG', 1, 31.77944, 35.27222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e920ceb0-15d4-48dd-b1df-5315da2861d0', N'36990eb6-29ee-44a8-a7e0-fc83bb29be18.JPG', 1, 49.98532, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3c55adf0-6ca2-41d5-ac20-54e7cb46c437', N'10394ee6-1f73-4bb4-9fee-8640d9cafbd3.JPG', 1, 47.437, 11.30392, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'afda33ae-36d0-4e60-a6e9-56988324d6dc', N'c64779de-e720-4881-88c5-2cd6fe6dfc05.JPG', 1, 48.00616, 10.20981, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2bc1bb62-23ff-457d-ba48-56bee75dc414', N'f10d92e3-6ec1-4d80-bda9-a687933e9ad8.JPG', 1, 48.37413, 24.42933, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c36707cc-a418-4926-a34e-571b35346bb9', N'80aa2f04-2efa-422b-bdd5-f06250abd5a9.JPG', 1, 50.53714, 26.10111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'135a7771-2e59-43c1-918b-57a5b63d07b4', N'5cbd9478-8ded-4e43-9e1b-d16b2f88b3d3.JPG', 1, 47.49376, 11.20942, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd4d41a15-c83b-4bd5-b474-58c6e5654c72', N'715d6f95-2126-4473-81cb-533ac539b64a.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'148f3161-4d6d-445d-b9af-595798ffc8ef', N'4f3fc90a-7e44-433c-8005-48d51b2f4056.JPG', 1, 50.75081, 25.37528, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd3ede067-10da-4584-acee-59b42499dc37', N'6858c32f-d067-4454-b7ee-edb61c67fed5.JPG', 1, 49.98464, 25.05136, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'756e4ee2-f622-4623-ba2b-59d3c499028e', N'cd145359-6583-43e4-a47f-3804c2f6d709.JPG', 1, 47.49427, 9.085778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'88da0a11-9882-49dc-afbb-5a8a430febd7', N'872ac1e5-fb6d-40bb-86b6-00f2fa8e93c1.JPG', 1, 60.86417, 7.136111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'adc3b7c8-be15-4929-976e-5ab4bd7d60d4', N'2ccfbe2e-4f67-4f19-b6fb-6a0efe95cf7a.JPG', 1, 50.75149, 25.37742, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd057cd87-8d88-4624-b18b-5b67a7d53bf3', N'42cff385-0650-4e40-bd55-3dd54c110d99.JPG', 1, 49.85265, 29.76961, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'dc936d42-c56a-4d1c-aa71-5b9e4a201306', N'402939bd-18ff-454a-bf6b-3dd83e5c01ae.JPG', 1, 47.4004, 11.31092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'504c3b00-1adb-4483-907a-5ce2d327b6e8', N'997538df-0697-4f57-a951-9cbfe0fa4be3.JPG', 1, 53.93195, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8dd836ff-34a4-47e5-9f49-5d0aad23413c', N'b2fafab0-6036-4701-a087-d401b0ebb7cd.JPG', 1, 9.540697, 100.077, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5aed7c9c-861a-4049-a107-5d8165e21e44', N'9d36dc5c-b48d-4827-b804-75dc7e370e4e.JPG', 1, 48.01311, 10.69981, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a68f281c-9a8c-4d0e-b94d-5da4000428d0', N'fba40fb7-0124-4be5-b013-bc6af206f56e.JPG', 1, 49.84841, 24.16433, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4fbadc7d-65be-4c3e-85b3-5da62e58cd6e', N'a1532541-8733-4ec2-b931-70899dc1b5d0.JPG', 1, 53.54222, 10.12778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd70a9ddd-c613-424e-bbba-5dce8699b728', N'f11f944f-fa17-4bee-b656-5a86e8fba221.JPG', 1, 49.56916, 25.7002, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'432cc927-6990-4c9a-9445-5ef34706becd', N'ca56353d-e42c-4d9f-9360-bf38bae5eeec.JPG', 1, 47.05456, 8.608222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'274394ad-66e2-41ea-b549-5f3d26c6f4c5', N'2b212758-556f-4f8e-bd26-9f078a3319d6.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3dca8ec9-95ca-45fc-b47c-5f999280287a', N'97c5275e-939a-424a-b15d-1ac1103d4708.JPG', 1, 41.70726, 44.94092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5c67631d-364f-4419-9c49-5f9b7ea26daf', N'd50ff24f-4964-4486-975f-ab352767c07d.JPG', 1, 49.98007, 24.97086, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0e8f3418-04cd-45fd-948c-5fd2de347ae0', N'd1611351-4592-4acc-9120-890622cbcbf3.JPG', 1, 48.15013, 11.67103, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c4364e40-54a4-459e-9891-60290d572396', N'5621a4b3-de1a-4c69-b3f5-29b12c823d63.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7a9a571b-0862-4c82-be8c-6052ab77a07f', N'18d045a1-bff5-4596-b6b8-f16a4c2973e8.JPG', 1, 31.77944, 35.23333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'60dc80ba-0f48-41c9-ae96-6093858cb02e', N'29c504c8-18e6-49d6-9089-9f27df37cbfa.JPG', 1, 53.86417, 10.77778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'473df2a6-1cdf-40aa-a0df-612d8645184b', N'59e72d8f-e050-4632-bfa9-18bad2214da7.JPG', 1, 54.03389, 10.85556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4d7722d9-2440-4ea9-b154-61c39ddefc11', N'c34eccb8-d12d-4851-a36d-d5107980d312.JPG', 1, 53.23722, 12.21389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'95a638f3-c57f-4851-932d-620af6023b75', N'f3ad0093-98ff-454e-adfb-4182ae896d56.JPG', 1, 50.47105, 30.60492, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8a415567-43b7-4c5c-9b24-6289b92ba99b', N'2afc1e9c-92d6-48b8-9d3b-54074780e17f.JPG', 1, 49.98549, 25.04825, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'54422740-c876-4468-86ee-6317a2fe8af4', N'ff84b5cb-b887-44bc-87dc-de38395008d7.JPG', 1, 49.98464, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'106dd1a7-e3c1-4be6-87e4-6423217345be', N'9b5f9318-816b-44b1-a997-ac39cc9b9341.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e9d1469d-99c5-486c-aa75-642a3c8ae118', N'5480ee71-7513-432e-a861-8c8a3d436c55.JPG', 1, 48.00582, 10.21117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0e9d4480-b901-4ac3-8059-6441d635488a', N'0aeee374-e24a-4bab-b18d-305b661726b8.JPG', 1, 45.47495, 9.221861, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'54b1d5d9-6b56-4f11-b9dd-64429de96a8a', N'd8ff6043-2b72-4160-af48-118ce0fcc328.JPG', 1, 47.80181, 13.09469, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e6fc30c5-2d71-48d9-9c2d-6521f53f2508', N'8829bdce-54fb-46c8-813b-3ab5ee35d6e3.JPG', 1, 49.86603, 24.03908, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1e26ec9d-16ba-4254-9339-6527acfa9e05', N'e6c2cdf0-8fb7-442c-8d69-432d32ee917d.JPG', 1, 50.43852, 30.62844, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c50d2dc2-abf8-490a-85d8-65ed6cabeaa6', N'f5df2c28-5c17-4c34-815c-439f37246b77.JPG', 1, 50.14775, 25.87753, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6aa4c369-ec19-4460-992c-67f63fb9d43f', N'43a0b055-1607-4b2b-a41e-607729fdc253.JPG', 1, 49.85942, 24.08167, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ea163ab7-2da4-4a64-8fcc-6909af69f6b0', N'03431764-89cb-4e74-ae12-5f49fb7dbb52.JPG', 1, 47.80249, 13.07, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'655259de-bff5-418e-a96d-697bcdadafa2', N'b5baed34-8573-4191-bcc9-61928db5cd67.JPG', 1, 42.48698, 44.57069, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ee3d04a9-05c6-4891-9368-69b543fd31ba', N'63a7124d-5be3-40ff-bfaa-ec940f27ebb5.JPG', 1, 9.540019, 100.0776, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'415392da-af73-4e97-a78f-69ee8f3c29b8', N'c92a30a2-5985-40af-ac6c-fd0e22b153aa.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8970cb15-67ea-4d09-8f10-69ff93fc4853', N'aeda596f-5458-4e81-a2ad-f4d8cdb7935e.JPG', 1, 41.70625, 44.94092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6dadc195-d651-4ee9-b90b-6a775a3f84e6', N'fd7ca620-7887-4142-9352-5e18604fc480.JPG', 1, 60.38972, 5.369444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f0335345-79ff-41ed-a640-6ba6d92e1a4d', N'a6443819-c1b5-4316-8511-2f759909edfe.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'43c9ae3f-1f7d-48b2-bd2e-6bba841b52c1', N'c8a68ac0-13a6-4251-8ac2-bf38989468eb.JPG', 1, 42.49139, 44.56389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f9a2f9db-9cb7-4597-8934-6bfe53fadb13', N'd141661f-3dcf-46b1-b480-83c8eacbb663.JPG', 1, 60.44056, 9.35, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5e945983-10a0-43c7-8f66-6cc22316dcc7', N'46f3566c-b840-4962-9a42-2c86302724cc.JPG', 1, 50.45225, 30.52539, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'95a1d43e-1a12-416c-9777-6d65ce033637', N'f975ffab-f80e-4544-ada8-ccfa8d865417.JPG', 1, 49.82418, 30.07719, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6fbb1907-8d86-43b0-be0c-6d724660d635', N'f9a714e1-536c-497c-8657-59bf1c51c879.JPG', 1, 60.84722, 7.116667, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c96640db-8249-46fe-88ea-6e2b2eb5199d', N'3dd21c47-daee-4bd9-b0e9-143497a3a2fc.JPG', 1, 50.44056, 30.60278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2a484bef-0495-4ad8-80fe-6f63a10b0818', N'109d3a98-9576-4c0e-a5f2-42883a3c2fda.JPG', 1, 49.84451, 24.00408, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2e6b96fa-50eb-43d2-aab0-6fa656df9a45', N'9b9805dc-452f-4988-abea-615de686ed56.JPG', 1, 48.36702, 24.44839, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b584f795-6e21-43ad-92cc-6fc49e691e04', N'02ce4017-bdca-41f4-b804-6b1c17221b36.JPG', 1, 59.94889, 10.91389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ea2ec352-8593-4bb3-a71f-7170fa749a3f', N'ca735e7b-a653-48e1-8320-20927167b054.JPG', 1, 49.9843, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1143f939-f13e-4cda-98b8-718f92b77221', N'a6713ae5-8a87-4e90-9cae-69887f4c7bc7.JPG', 1, 59.94889, 10.91389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'701e6243-2aa2-45ac-ba13-71bdf6306c36', N'c30da250-dea2-4cf2-873e-1cc1c558e1f4.JPG', 1, 49.98413, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1d0d9a41-a672-437d-97d9-71d79e93a9f2', N'd879983f-31eb-4d52-9d11-bb4707d7ed6e.JPG', 1, 49.55917, 25.68056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8f134ceb-7096-425c-b2c4-720466b638ea', N'50c87ee5-1f70-496b-b003-464ad65a509d.JPG', 1, 49.86247, 24.04569, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f0140637-901a-47ab-8d2e-720f9a984322', N'4c1b670b-51b7-494e-9a21-e6e22dd60d37.JPG', 1, 42.47394, 44.56603, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'74638f86-4058-4e90-b819-74104f716875', N'574fd77d-63e1-4e62-ac4c-f7e0a5e2df94.JPG', 1, 54.03389, 10.85556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd6546468-c159-48c4-a046-7432569571d0', N'acf9d31b-c26a-48f2-b7f1-5c461c31f0f4.JPG', 1, 49.85959, 24.07545, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'45d2a1ba-33c3-4cc5-a7ea-7477f6d4f8f9', N'41199610-37cb-4f56-bfba-e777dfa2a30d.JPG', 1, 45.44479, 11.15656, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3b723bf5-a369-4d24-acb2-74a21bf9113d', N'66c92f77-a6a4-4db7-958b-e3cdb1e6f033.JPG', 1, 41.70573, 44.94033, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'04cd26a4-6ef1-4e15-86da-74fb9edff783', N'60137ee7-f523-4df6-a2c9-685f800d7ba4.JPG', 1, 50.09658, 25.85128, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'356f5c6d-2f27-4b0b-b4b0-7506e10da3be', N'b6a98a8e-3150-4d09-85ac-a0f11e8f2913.JPG', 1, 49.82604, 24.10347, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e57acb24-e1b7-4e88-a9c5-757c444886c1', N'62df93c1-b287-4cd4-a8ee-898898dda81f.JPG', 1, 41.70658, 44.94014, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'786139f9-97c8-4033-8163-75ed3e3175d0', N'f738b9ae-1a81-4268-baf6-b2166ed266f8.JPG', 1, 52.915, 12.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6e0a083a-5404-4463-b401-76d7ff0e4282', N'63a61e87-3792-4f54-a0dc-27f18c8ea293.JPG', 1, 59.915, 10.85556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'737dd5d4-fa08-4f58-8e89-7730640e6099', N'5c1532da-e256-4af5-9687-a9bbc47c98d6.JPG', 1, 61.33889, 6.213889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ffa68e4b-d8c3-4c13-acce-7775b6ca460c', N'cb556739-4f60-40bc-84aa-ce1eb4373816.JPG', 1, 47.81181, 13.05367, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2afcec90-8249-4204-8293-778dc63f5fdc', N'0fc5f33d-8c06-46cf-9831-e09f69bf78d0.JPG', 1, 13.70404, 100.8766, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2d360d20-66af-42bf-9457-77af6e37360a', N'21d6544f-af04-4bf1-afbf-8a5f59e958ed.JPG', 1, 47.42852, 9.422722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a958066c-7e41-420a-a30d-7866cee70b37', N'd50960c1-095b-46e3-a053-fae970d47f4c.JPG', 1, 42.46885, 44.56583, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'923ef507-250d-4e75-96cd-78689b0d7783', N'2f5e6ecc-1e27-4f9b-898b-4294d4479d86.JPG', 1, 61.32195, 6.311111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c72ee8cd-1be5-434c-92fb-78c54c0fb54e', N'e8f98c17-8f2a-4c82-8a1c-e56585e9f57e.JPG', 1, 41.70303, 44.94558, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1a8a78bd-c0d5-42df-b30e-78f7e31ab101', N'eaa596e7-36a5-4456-92ee-d70598ccbe71.JPG', 1, 47.48004, 11.29944, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bcc8e7ee-4281-4106-b4b1-7947f9228324', N'c9105128-3a31-4285-9fd3-0a66edcea10a.JPG', 1, 60.84722, 6.544445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'222812dc-a823-442b-b820-79beaea2eb52', N'e59d215e-b2fa-49ec-ad99-7da41e07e3cb.JPG', 1, 13.70218, 100.8709, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1a963084-9cf2-4490-b115-79da75072e90', N'4d42bb59-b0cc-41c7-ba41-8868f7d3194a.JPG', 1, 42.49359, 44.56914, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'325a0e51-4ec6-430e-8596-7a42c07f0b58', N'fdd6629f-f910-4225-bdfd-43cac5927ea9.JPG', 1, 31.35583, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'27186d1f-0a09-4f5c-916b-7a5f9b9edd59', N'c8c6d336-32d3-471a-bb73-11ae1ae54156.JPG', 1, 41.70625, 44.94092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3489356d-72b5-4abf-91ea-7d21b12607c3', N'5e94e9ac-315d-4d87-b1c1-d85d0eb11284.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'52a9008f-a337-4946-8acd-7d4eda92a294', N'bd1806de-6c45-4154-a378-d0938f30b23d.JPG', 1, 54.05083, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'822dc0a1-3034-479b-9e6d-7da2ef16b76d', N'd8ea9b94-0bcf-4608-acc5-f27a5be43d16.JPG', 1, 49.85366, 24.03519, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3b5ccd35-7ac2-463b-8df2-7e1604cb176f', N'd990f68a-504a-4905-a42d-62776ab36c9f.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e3333bb7-10e7-43b0-80da-7f0959ea0a6d', N'cfba4500-1e13-47d7-9684-6f7198c939e4.JPG', 1, 49.9843, 25.05, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'278ae70b-913f-4dcd-b778-7f90f095c238', N'6b944cb1-ff70-4dc9-b42a-948fc5abe44a.JPG', 1, 9.540359, 100.0725, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8b4f120f-1359-4dcb-bed2-7f9251b33d05', N'7d475c7d-9826-4024-bbca-fc20e82e4988.JPG', 1, 42.47139, 44.56661, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'132870fd-8b9a-4071-ac2b-807411990af7', N'd66853c9-998d-4715-a51c-1987a58ec36c.JPG', 1, 49.98413, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'21c186ca-1585-4b52-9d67-80d40124872e', N'e3827470-706c-4684-8997-07d7689fb363.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'900d3cc1-ac77-4896-9d0f-80d8a49df67d', N'929c29ec-6976-4262-8df4-ffb769044f8f.JPG', 1, 49.86213, 24.04356, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'24a31f9e-9186-4454-9869-819b3d34afa1', N'693f8b1d-c3f9-461c-9a4a-73547592121f.JPG', 1, 60.64389, 9.058333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'59cf3119-b67e-40ea-98b5-819e98a1364e', N'8c88cfd2-caf0-4da9-b976-254e7b4d1e71.JPG', 1, 49.85942, 24.08167, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'cc967e51-dd10-4583-8aa2-81b153e1700f', N'3ee6b951-0d06-490c-a0f9-78f33bc168f3.JPG', 1, 41.70777, 44.93722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9eb0b6f6-4faa-4dfa-a572-8201db2468dd', N'3da63524-bea9-42b4-af4e-c1ae4e96a5af.JPG', 1, 41.70658, 44.94014, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1eabdc59-863f-4e1c-ba16-822b6f657df9', N'8b41066d-ee45-4d3b-a682-f749537beaa4.JPG', 1, 50.09624, 25.85244, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'882ccc4c-8ad8-468c-b4d2-825f25b01cb4', N'093a2831-bc66-4b2e-97c5-31c213932b94.JPG', 1, 47.4331, 9.436722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'73616ed9-7300-4883-b524-828f4094010c', N'6243561e-8920-423d-b84a-2c0e9d98d789.JPG', 1, 41.70726, 44.94092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c8604c91-49ae-4226-ac58-840d8c5a5ded', N'f13f4386-69f6-4a83-bce5-e136d757c57b.JPG', 1, 13.76335, 100.5761, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'31937184-37b7-4c25-9e75-8466dfbaeaeb', N'cba46d31-7ea7-41f2-be63-a3c9bbe7e94a.JPG', 1, 49.85535, 24.03617, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd9345b93-8aa6-4be0-aa07-84c8a11c4d8c', N'4104dd7d-745e-4f8b-afc2-65d3edbd5fe7.JPG', 1, 42.49139, 44.56389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'dec22771-26b9-4367-8b25-8501256a4393', N'6a19429c-8c84-4f56-b485-2e3f604d8a4b.JPG', 1, 51.71167, 14.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'432ef651-5ddf-4fbd-b89e-85b794dd53fd', N'5acb3de2-abdc-4bab-a7a9-7206c79d11b0.JPG', 1, 41.70167, 44.945, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b0435c80-14d6-4dab-9bf7-8614f32d8152', N'4724a068-c61d-4456-8133-cafe921ea28d.JPG', 1, 60.28806, 9.777778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a28be876-519b-4d21-89c1-8632ba64fa2c', N'58b93d24-354e-44d7-907d-a89b9c1b58df.JPG', 1, 60.38972, 5.369444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2aca85c6-979d-461b-b018-8639109bae62', N'34f9a92f-36d1-4197-bbb0-8957365e9b45.JPG', 1, 13.75691, 100.5857, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9cc44fa7-7b93-4e88-8b9c-86c6a02588df', N'88f495dc-322e-4ce5-b8ab-522bd13fe3f0.JPG', 1, 42.47038, 44.5635, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5227ea13-8887-4dd1-8abf-86f1df4be520', N'2adc0ffb-f2ac-442b-9cb6-2481dc5edeec.JPG', 1, 50.46106, 30.61619, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f6ec6f61-8cf1-4da9-aa9b-87db4a9b1903', N'ed5a79cd-6ad6-44f3-ad1d-ae9cc34691af.JPG', 1, 47.39531, 11.308, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2e401abe-b9b4-4859-8e12-88fcdbc0da26', N'9c6d8f80-eca1-405a-be51-ad75a286e3dd.JPG', 1, 49.56916, 25.7002, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1fdcff12-7fd4-47bd-a35e-89a8532805f6', N'ab798613-ef35-4276-955a-93b65c5a159a.JPG', 1, 47.43784, 9.427, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'37f1efda-e9e9-4ffe-967d-89bc093a6754', N'c89e54f5-1921-4bc4-a720-40dd0328724c.JPG', 1, 49.98481, 25.04903, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'102964d6-3200-4acf-a5b9-8a4f7cf1d662', N'302dae6c-4884-4804-863c-5e13b00f0a52.JPG', 1, 60.86417, 7.136111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c43d16dc-e753-486f-afb3-8a80d11af1e6', N'bf252780-0b36-4cb1-a3a1-13c5af05ac13.JPG', 1, 41.70777, 44.93722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'67d6265e-8e7d-439a-93e1-8abfeba2a981', N'6a94c390-0d86-49ef-b6d1-c0b53a4dd378.JPG', 1, 48.0087, 10.23372, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f2eb3358-8512-4f63-b6f0-8ac88e64ce9d', N'22ec2def-5e0e-47e3-8291-6f3f2509a3a0.JPG', 1, 50.14775, 25.87733, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'774bd3ed-7931-4fdf-b047-8ad28f6b1d35', N'60490f75-3ff0-45be-926c-4ddfa6d5942f.JPG', 1, 42.49783, 44.58158, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5f43efce-5d74-4774-a4ec-8b949af91406', N'2b10efaf-7cf4-4510-9907-5d3f8cdadce6.JPG', 1, 42.49393, 44.5705, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd1756af7-8eac-47da-8954-8be7f626328a', N'82dce673-80e3-48a4-8b33-36ea950cd31f.JPG', 1, 9.531886, 100.0681, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'223b69c3-8707-4f9b-9173-8beaf4e3ed0d', N'fc75acef-1d74-424d-b340-774ae9f09649.JPG', 1, 60.18639, 11.11667, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3793af85-c2c6-4db1-96d3-8cf476445538', N'c96f5601-5597-4220-9f33-c01e01f47cfb.JPG', 1, 60.38972, 7.680555, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'51ace0f9-e4d4-411d-b6e0-8e078f6000b2', N'6cd097b9-d442-4a3a-b3b2-99178fa488fb.JPG', 1, 48.38515, 24.47795, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6fdd4b7b-7a02-4e6a-ad67-8f11ee3c99e4', N'f7e7abf0-fe29-46ca-a330-62a5d955af4b.JPG', 1, 50.4575, 30.60278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5b98a1aa-70c5-45c6-b7a3-8f15eb4b4acd', N'd1d8ec49-da13-4c24-aaa6-c7b394e3bb4e.JPG', 1, 60.20333, 10.01944, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'276ad812-0681-4497-8d6d-8f17291e7b6d', N'75a7c010-9094-4815-896e-121a8b2bd41e.JPG', 1, 60.86417, 6.563889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'49f2c15d-d29a-4e2a-bac9-8f39fd176def', N'3f0764ab-5cb7-4512-bcae-79f099835ad8.JPG', 1, 60.38972, 5.388889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'110cd174-3035-4356-a480-8fce6cf79eec', N'd9626f8d-6edc-41c7-a5d1-d18d94408993.JPG', 1, 48.37413, 24.42933, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'187238b8-9b45-489f-9eaa-9184aff4a5bb', N'1efe8d00-d27a-4e0c-8b11-3b138f6cbf45.JPG', 1, 41.70455, 44.94267, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'62eef2ae-493e-480b-ae6b-91bc7c9d5b44', N'b347cfe2-4409-4615-a2c4-7691255de4e1.JPG', 1, 42.47224, 44.55883, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c00e8e30-1dd8-418b-a871-91cd987123bc', N'e1ee7adb-bd6a-423f-95bd-00e09b71d140.JPG', 1, 49.84536, 24.01128, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'568739cf-6ac0-40e8-8c7b-921efb39ba1a', N'69428c5d-deb7-4ee8-91b2-da64c2709826.JPG', 1, 60.38972, 9.680555, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c692c8c4-f61c-47ab-83dc-926c782bd1d4', N'a50d0514-3580-4f58-b996-ff4e3b758e4c.JPG', 1, 31.77944, 35.27222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'793d481c-00a8-4927-be9b-9294cbe362ee', N'186cc516-fa94-4e15-aa38-a0227ed27d09.JPG', 1, 60.86417, 7.116667, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'221c79f1-337f-4b14-af4e-92d34134fe25', N'1f001224-30a8-4614-8762-1e2cb1cc0bb8.JPG', 1, 41.70625, 44.94014, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f6b41dcd-c361-4ebb-b2d6-93159f3a7f28', N'cb15be33-de38-4420-9245-c945337c7efd.JPG', 1, 47.49427, 11.20922, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'777c3750-d96d-48d4-bf4f-936d5b9a76e8', N'0ad6da98-174a-4265-afa5-6533bbfa0682.JPG', 1, 54.03389, 10.85556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'55e5fd2f-079e-46fc-bab5-9375f6754bb5', N'b4028dd4-ea7d-46d6-94c7-76853e6cc66a.JPG', 1, 49.56933, 25.70039, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f99dfd29-d1d9-4f81-b97d-93ed0f9f9a7a', N'1af13ed6-2d6e-461c-839a-c16a39278ebe.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'af2e6e7f-3127-4b94-9647-93f0e9a2255a', N'043f9205-5845-49a9-b561-e6845ff8b7a4.JPG', 1, 54.03389, 10.85556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'57f55c00-a414-411c-9db8-941fa9d5d1f0', N'21c5194f-a256-471e-9cd5-1195132089a7.JPG', 1, 50.44056, 30.68056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'51b58037-261f-4998-8e07-9472374881ef', N'3bdbf6c9-368a-4858-a015-dd8fea332ce9.JPG', 1, 50.43835, 30.62883, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'22b1da3e-a68e-42d0-b251-94f909dd750e', N'4d695daa-bb0d-4ad6-89ef-010cf102ee5f.JPG', 1, 50.09675, 25.85147, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'44c722ec-22a5-4f59-b948-950920bbc202', N'2ee635b2-3d5e-4e87-a9cb-275e9e5b3e67.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'88210502-d3ff-44a7-893b-952f60db9108', N'c9ae4f6e-96ec-48c2-8222-d66a50b25dd4.JPG', 1, 45.47478, 9.221472, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b4c40d8b-d9d0-4b7c-8fdf-96cd56c46e56', N'72d49857-c79c-4651-a73a-9cefff368a63.JPG', 1, 45.47495, 9.221861, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bec18c5a-861c-43c0-abf8-96fcda60aa5d', N'f3dc85fc-35e5-4dd8-8ba0-2f4e01671b6a.JPG', 1, 41.70726, 44.94092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0c84db36-bf6f-41ba-87e4-970f5efa2ef4', N'370bda2e-537c-498b-a71e-cc99e01dfd7a.JPG', 1, 49.84909, 24.02119, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2607fcd8-0025-42db-b405-974b14dea7e8', N'3582936d-b3cc-418e-8a85-83a1a029d76c.JPG', 1, 13.77097, 100.5826, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'eb6e70a1-5649-4956-a243-97e5b5d880fd', N'b8116311-76d7-4747-8e37-e3aa3ee7af57.JPG', 1, 48.00881, 10.70078, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4043e1d5-126d-4a7a-82e4-98deed080c3c', N'608bcb13-5d9d-4015-aba4-5500341d6446.JPG', 1, 13.75962, 100.5837, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a8779ab7-728a-47af-801a-990c746854fb', N'a0320689-f411-44e0-9226-78085acc6f5f.JPG', 1, 49.56916, 25.7, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7a7dbcea-4dad-45bb-860c-9a4ef13fbca1', N'7fc82704-7d1c-4898-8954-359e430559c5.JPG', 1, 41.70455, 44.94228, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f50cb9f1-38ba-45bd-aa99-9a4f93ccb832', N'a173b11f-4c8f-45aa-9288-42ffa836f17e.JPG', 1, 49.98481, 25.05058, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd616dd3f-cc54-49a2-beba-9b02d1cdae91', N'afaeaf98-595c-4522-b532-9c0c070438c1.JPG', 1, 45.47495, 9.221861, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'247bc8a9-0973-4cd8-bfb7-9b6790d89661', N'3bb7f186-ac39-4468-aa24-45ab5af1e643.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6a28bf3b-2215-4e53-b5bf-9c0db45d98e5', N'8ad303bf-00d6-4211-b58f-efa9ca4412d6.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'89d88563-d870-4220-a31d-9cac4d65ae57', N'7fc4f550-b630-48d2-b560-b420f497c690.JPG', 1, 60.38972, 5.369444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'13c7902a-c8a3-43e6-a2a7-9d70aa76315c', N'c9788a1f-9f93-4d9a-b8a4-1ee5f142ecef.JPG', 1, 41.70607, 44.94072, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'720c3cab-5169-41b0-aee6-9e7ec3aa052f', N'c944a4fc-c07a-4e12-a4c3-a0b692351d49.JPG', 1, 25.24637, 55.42545, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'52cb2b42-6096-496e-953f-9f1421e63ead', N'1a6e54a2-af78-4bab-9f09-08cfce515a49.JPG', 1, 41.70743, 44.94092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b5d9c77f-9865-4c09-8cd9-9f1f6ba9c6c7', N'766ac9c2-c09f-472d-9914-fc7885d14626.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b5e84db0-2299-4a6b-a68c-9fb637d9f96b', N'ff4f205f-4327-415e-b0ce-ec779c1b85f3.JPG', 1, 48.35702, 24.48319, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e81c11bf-96e1-4d67-aed1-a01ecc08e79f', N'66583949-fc67-4e51-8f33-b2a43068f119.JPG', 1, 50.4575, 30.60278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4a4c1cd2-2e1e-4259-87b6-a0872bd990bd', N'821aa09c-b916-49a7-a300-883ee4b7c874.JPG', 1, 47.48105, 11.29867, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0eb339b7-b136-4700-8b8f-a0e7a5568246', N'7fb0b537-818c-4f00-be25-af175fa707fc.JPG', 1, 50.76301, 26.05114, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b25ce390-b4ad-463e-ac30-a13a6a705c04', N'364c95e2-63c8-4c24-b1bd-32630435407b.JPG', 1, 49.98532, 25.04903, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8bb8efff-008c-4ede-8b8d-a161188db420', N'8919de72-7880-464a-8f9b-e1e0da8437f6.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b08c0e64-6fde-4029-9b2b-a194203e0770', N'7c55466b-8b58-48f0-9374-5ea493c093c3.JPG', 1, 42.47173, 44.55942, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'18c7e259-4c11-4bd1-b3c9-a22284b0eb6f', N'795b5b05-29af-44ae-9283-707e98917c12.JPG', 1, 50.44056, 30.60278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3c103672-094a-437a-a648-a24fde3a9ab9', N'3bede719-0c80-424b-8b7d-96db82c4af53.JPG', 1, 47.81215, 13.05639, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a5001b90-9a01-4c06-9d7a-a29b042a7eea', N'e83fb4f9-4301-4819-80dc-545b6efe25d1.JPG', 1, 42.47258, 44.55806, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b6f19386-ce30-4eb9-84d1-a2a10b199e8a', N'6a6bd2d1-ee0a-48b6-a13e-a4008c983107.JPG', 1, 52.88111, 12.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a211b542-673a-44e7-a013-a2b2a100d98d', N'7737308d-605e-4ffc-a1ed-26e7b612c05c.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ae0686e0-f9ce-4392-8599-a39f27ccc428', N'531280df-b9d2-4e43-b178-f3a80272f993.JPG', 1, 49.9843, 25.05078, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'875f2d6f-8860-493c-972f-a4b1364ace9b', N'aaf15719-b132-4bd2-a427-acc8c905c765.JPG', 1, 50.01531, 36.27339, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9ba1b324-569c-4330-8cab-a4bbf9c5dc19', N'd82d434f-e6f1-431c-81d6-dd3a07841c6f.JPG', 1, 60.38972, 5.369444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'37ee4514-7323-48be-905d-a600182fecaf', N'ca1024b2-139c-45b0-b2d9-6ebde3ef194b.JPG', 1, 49.85909, 24.07467, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7fb5e1bb-8e14-4f88-ac40-a6a31d1dc1b8', N'9136a999-c793-485b-b6e7-56562ad5ff71.JPG', 1, 48.37413, 24.42933, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd4690b5f-d95b-481b-b4be-a6d8510bd660', N'43fb51a5-37b7-4734-adce-4a07bfbf865b.JPG', 1, 42.48885, 44.57594, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a6a52a25-b71a-4f19-9cda-a75b60038a04', N'df743336-f33e-41ee-95ee-ba8c66b7b38c.JPG', 1, 32.50834, 35.05, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4497976c-0776-41b7-98f9-a79c7e4f1c2d', N'b0c1add7-9acb-4e61-885a-19ad47d69920.JPG', 1, 45.50342, 9.146028, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'47d67e6e-83aa-4f73-bfa9-a7b9d42904b4', N'07a28162-fc8b-4c34-b8c9-9d27d2cda82f.JPG', 1, 9.537986, 100.0717, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a6f205d6-dfa8-4382-880e-a7fe0338243e', N'b90b9eae-6853-404d-995d-f63452e2e213.JPG', 1, 49.98464, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'de619462-3bba-4674-8b05-a85dc9ad754e', N'31b1be80-202b-4055-9b8b-cbfb744b4b34.JPG', 1, 13.7647, 100.5759, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6c7b6ebb-072d-4307-a46c-a88c3ba64c1a', N'fea42699-43eb-446d-bec4-d1871e9425b1.JPG', 1, 9.540019, 100.0774, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0c4107ed-f959-46be-8774-aa05272a75fe', N'6701becf-c242-45bb-8144-510ad54f62c0.JPG', 1, 45.47478, 9.221472, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd4bd7c54-0c72-420d-914c-aa1459f55cbc', N'5b3aee08-dcc3-4344-99e8-f1f30879da61.JPG', 1, 42.47411, 44.56622, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1aa8a57a-46b3-4974-ad02-aa7b48695b3f', N'4b1ff94e-d262-4396-aba7-f0a188daecb3.JPG', 1, 60.38972, 5.388889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1897c15d-b2ce-4f88-b8ee-aa8108931a77', N'68e282cc-19c7-4707-9d73-898abc1e6446.JPG', 1, 9.540019, 100.0723, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e3db8d04-5950-481e-a12a-aa9f144a31e4', N'54746a13-bd01-4d83-a04f-5b9bfabbf232.JPG', 1, 54.05083, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'815693eb-85ea-4c5e-809a-aba1637182a7', N'0915b4e7-640a-4f1c-9ae7-8984f77e12c8.JPG', 1, 48.00881, 10.70019, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c9da4766-0c87-4c1f-b93c-abb7b9445787', N'b1ab9a64-ec38-4198-a7d7-555494a31cb2.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3da1c8cf-227a-4ee5-bcc6-ad787626465e', N'392921d6-c06c-4370-b145-ae97126f7569.JPG', 1, 60.22028, 10.12778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'be926835-37eb-4dc1-8e92-adb49fee7c39', N'b0370ebe-35da-4573-9373-97288bc902d8.JPG', 1, 54.03389, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a2811b43-f91e-4ccc-b372-adf1dc19d6ac', N'6b9c42f9-3b3b-4c26-909d-413ec5d5f422.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'595a397d-4c71-4b08-8b37-ae24b38f8a38', N'a2f308c3-96a3-4a53-98fb-4a45281172eb.JPG', 1, 47.43361, 9.435555, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0ddd314a-fc93-4113-9115-ae4c2c246c4d', N'3a12a038-b917-4a22-8218-ef108ddd5b4e.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'be7c0cc1-5f21-4c61-9eb5-aec74f88e152', N'961ee65c-39e7-461c-8b58-3a3f473306ba.JPG', 1, 48.01169, 10.68406, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2cf3caf4-8bb0-4604-9df8-af0e848ddaf3', N'17d03206-0d62-4d60-9d7d-8f7497d72536.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3b6e242e-2128-4377-a5a5-af6a360033c4', N'b7e70fe2-aba0-4267-86f1-a79e94e7f902.JPG', 1, 60.38972, 7.447222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'458afe3d-d744-48e9-9e89-af81d6e9b763', N'd5bde131-d331-45a0-954e-6b918c75cb22.JPG', 1, 60.23722, 10.06944, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'127d157a-0073-4758-830d-afbcc7ae17a4', N'1e9e92de-8cb5-4931-b1f5-d1b6a0fcd99e.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'20516b3e-1d5a-4c2f-a601-b0f5b963375a', N'20b531ca-64f7-4245-b660-0d6bec0b0559.JPG', 1, 47.40294, 11.31111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0a9334dd-7d20-4919-9a6a-b1d876ce415b', N'86d1a290-c5a9-4bf9-8ae4-bedb7eaf7695.JPG', 1, 50.76284, 26.04939, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bbd91bf6-66ac-4036-960c-b20c825f9391', N'b2eb6d72-e6ba-4b24-831f-a0511904fb29.JPG', 1, 41.70726, 44.94092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'dfdad0fd-7a79-4845-9319-b2462c35a1b7', N'76772256-30a2-44a9-8698-51780ff155d2.JPG', 1, 60.38972, 5.369444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ea4dfc6d-a373-4d59-99a7-b27623b71830', N'9c064fa2-b69f-48a4-8002-6004ebc0beca.JPG', 1, 47.44225, 9.461416, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c2a3f729-b83f-4248-816a-b3354d841280', N'be76b265-405b-48ac-ba31-b2dab18f012d.JPG', 1, 50.45157, 30.52519, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c6d30b44-53ce-445e-b8a6-b350b603ad11', N'9ef88f4f-a4fc-4ee0-acde-a0e308faa472.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a5aa1821-31c5-4a60-a986-b49206f435b0', N'd30e9558-4789-4568-83c3-e9292cf162b3.JPG', 1, 53.54222, 10.12778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2971d653-d7b3-451f-8983-b57f0395e3c0', N'eec00baf-049e-4850-82d3-23cd57f0fcd1.JPG', 1, 47.43462, 9.437305, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5359c76b-77ec-4e52-bde4-b5e10529448b', N'4d146a96-3fff-40c4-bdfe-400401da7bc8.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd96c500c-52de-4b59-b6e7-b6114c73a8ff', N'd232dcc5-58ba-494d-b8e6-b351568ee8cb.JPG', 1, 54.05083, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'67e966fd-dd5c-4470-97c4-b64c333f7722', N'797f02a8-70d2-4f36-915c-9027f2b35ec9.JPG', 1, 41.70269, 44.94986, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0d8a7e92-6e61-48ab-826d-b6506d4ccc66', N'61aec8a1-ae62-446c-9f5a-923210e0fb9e.JPG', 1, 48.14132, 11.66189, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c2708a55-29f8-4ac6-8536-b6ddbc5fb752', N'adff7f59-a144-4aef-8a99-e29296e0ea20.JPG', 1, 9.539172, 100.0721, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a5ad49a7-67ea-40ff-b9e7-b715f199e49d', N'd5a36ffe-c145-4402-a357-428f73b5df83.JPG', 1, 60.89806, 8.330556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3de51100-049e-4250-94f5-b722fb624018', N'71f3fc63-901d-4fcc-932b-62f6d4238fa5.JPG', 1, 13.75352, 100.5979, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0e3dce64-b7dd-45fc-975c-b82689f2fb5d', N'762ded12-8d08-4fba-806a-b5252c57946d.JPG', 1, 49.98464, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'90cd1859-fbaf-426e-a4cc-b8b05e42e878', N'23279685-a31a-4404-870a-8f2bc76d8864.JPG', 1, 49.84841, 24.16453, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c3d55590-805d-48ab-a0c4-b8e2f030c0a6', N'46552909-5a33-4ccf-8fdd-4907857c67fb.JPG', 1, 47.80249, 13.07, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c7bb2a4c-4dbe-4ced-9b2e-b93e373dbd07', N'67de39dd-ec7d-4c7d-8ec6-d851aa2106fe.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd6c3a422-8360-4bf0-a459-b9583f83d57d', N'57a9fac8-41c1-460c-b2cf-2396a5c044cd.JPG', 1, 47.80249, 13.06767, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3f41b70a-8d05-4dec-aea0-b9f8f437239d', N'a973603a-db24-47cd-ae5d-b8c7cfdd1142.JPG', 1, 31.77944, 35.27222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'48f25767-4b6e-4a4a-87ba-ba9c76d331fc', N'0e1c6c5e-6298-435d-bc5b-9756dd551551.JPG', 1, 41.70269, 44.94986, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'cdef05c1-dfa7-4920-ad5e-bab12d7fc6ea', N'003ddd02-565b-453b-b0c4-8164104a6659.JPG', 1, 50.75132, 25.37761, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b90110d7-b465-40d2-af39-baffd3d2cb8b', N'ca8d2205-da56-486a-9114-71234b4b8f90.JPG', 1, 41.70591, 44.94014, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c18dada4-3c59-43dd-b2e7-bb34bb863c37', N'd47a8a5a-ba2e-483b-abe7-103a0b3609d7.JPG', 1, 50.43971, 30.63447, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2a371050-cedc-4c05-9474-bbb7ed970ea5', N'4c0523a0-bc66-4f15-944b-511aaf457dd8.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'821d91eb-03ed-4b31-8826-bc6b45a64851', N'1eb8b2b0-8ee4-4182-afd0-d1ddae039073.JPG', 1, 50.44056, 30.60278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8543edc9-bc26-4378-a18c-bc8926e97c6b', N'6bfe9dcf-b301-4b3f-ad90-673882b4677e.JPG', 1, 49.98532, 25.04903, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f2420ba6-7a16-4386-a6a2-bce0c2577ac6', N'39c25f58-a988-4d7e-8461-db685cae0f6e.JPG', 1, 59.915, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f0415da5-0bd7-4621-bdf5-bd265693d8a8', N'0a3e0c3e-c410-4202-8d25-8c9ccfed8dd0.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'55fd9a51-afe8-4a8f-8c22-be5f9d68f984', N'0b136e66-9138-4a8a-a7af-4bd24e0ab4b9.JPG', 1, 60.16945, 9.777778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ded1521f-8f11-45d9-ae2e-be8dc1f114ac', N'573f649c-ed8c-47f5-8558-06107e51ca46.JPG', 1, 59.94889, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'09e15c79-73fe-4d6d-8681-bf8e72552e59', N'35cf9080-1c48-4339-92a4-4ed1f818ec5e.JPG', 1, 42.12793, 44.22925, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'14a91e12-f573-4b14-8cf4-bfb2a8b6e4e1', N'40dd92d1-e7bb-4efe-a186-131dd32763c6.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd9c683e9-7bee-4e46-8deb-bfccec21e84f', N'ea20698f-eb57-4586-809e-c042a3f3ed19.JPG', 1, 53.54222, 10.12778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4b210e4b-160b-4229-a1fa-bfd9b04bbbfc', N'ba1fbcb4-1e87-4349-89e3-512049413b8d.JPG', 1, 49.98617, 25.04825, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e4a50186-c77c-4722-b364-c03dd6f7bc58', N'deb11453-b99f-4815-af26-82839b682a23.JPG', 1, 59.915, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'32ef7204-e717-4a46-a484-c0a98c4959db', N'aa6085f2-8f9f-4944-ad5c-8a785ab51f3f.JPG', 1, 9.539511, 100.0714, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'50e94df6-d4af-4e3d-b12e-c13e117544cb', N'b6136841-deb4-4a36-9404-f63601314c93.JPG', 1, 49.85213, 24.02606, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a1dbe28e-c7b2-4d53-8961-c211c4956b1b', N'75ccbd35-881f-4d12-88a3-7913ccf7392b.JPG', 1, 50.44022, 30.63525, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c605238b-c29d-4dbd-8978-c28629a3467b', N'7163372a-76ca-4add-9c7a-7a1843e4ac4c.JPG', 1, 50.43971, 30.6088, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd7a38c48-604f-4aec-a288-c34c2c08749e', N'17fe28c6-10d3-4613-81ae-a1cb05f4904f.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'16d44b5d-e464-45b4-b3ee-c39a47331889', N'86308379-23b4-4e87-ad6f-e2a48bb23b7c.JPG', 1, 9.459534, 100.0463, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6d141412-0fc1-4ee6-9b04-c3e6af1a46e1', N'eef937f4-d800-427f-bdce-43d62b17ced6.JPG', 1, 49.9843, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'87217733-e79e-4697-9f3b-c4399e67be81', N'b4e89331-a641-4e1a-b050-8969d99bcf2a.JPG', 1, 50.76369, 26.03617, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'eb3b8c3f-66b3-4d2a-a237-c4751fa6d0ee', N'8db2b25b-35ac-45cc-a828-e84468d4a144.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'023c840f-0251-4faf-bbff-c4d6591c8b9b', N'8daf2add-0352-4b28-8962-6401c5af020f.JPG', 1, 49.98464, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd28950bb-dc30-4db4-b441-c5e4e5460799', N'425e23b0-7a95-4877-9533-fe28dded9a71.JPG', 1, 49.56916, 25.70039, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'dd4d56d9-62c5-457d-9ad1-c61e59d9593e', N'80d8fa90-70ea-451e-ac21-eeb2b7b046a1.JPG', 1, 50.43852, 30.62903, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6a328035-7bee-4511-89c4-c6301145a978', N'7ab97c07-9aa5-40bd-9998-ac17cb80aad3.JPG', 1, 42.51782, 44.58722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'be27e077-15f6-4566-8985-c6505f72b390', N'96d933a9-890a-47b0-95ed-13f037848dd2.JPG', 1, 49.56916, 25.7, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4713aa7b-d132-49ac-90bc-c6f892099ed7', N'e4862c7c-5972-4e2b-859d-7cf1c1e3a32b.JPG', 1, 45.44208, 11.155, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'97ea1356-c42f-491d-8084-c703e18fd9c0', N'04300786-c631-4cb0-9e00-e452d70faf4f.JPG', 1, 49.85756, 24.07545, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'638928ef-1513-44bf-9f8b-c75029240113', N'3d2da2b8-b27b-4700-8f18-587fa926ca2f.JPG', 1, 50.75098, 25.37644, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2c478f8b-f456-4f6a-befd-c8087df86fa1', N'16e3d3ab-8396-427d-aa60-c97284e9d6b4.JPG', 1, 49.98532, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'01a10a04-cf9a-4c81-b323-c875dd0df0e9', N'261c5786-b3d9-46c8-aaa5-1f9d8068a124.JPG', 1, 50.46275, 30.60764, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3a8d3b78-13e1-4e7f-be0e-c9a9e217bf19', N'abd02678-a68f-4873-be4f-8fb0467169d4.JPG', 1, 49.85332, 24.02236, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0c99ffb0-2096-476d-a3f6-c9b6787c48d8', N'23535a15-f26a-4792-a496-6ecfeab067ae.JPG', 1, 48.0405, 10.90825, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'fb99fc31-8783-4343-a7da-c9cbe8f639fa', N'ff65aa06-da61-4215-8206-982f077e2c40.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'045a5f08-5333-4769-b869-ca1c77990677', N'd52c56a1-a7b9-4da1-9df2-d3182184ffe8.JPG', 1, 50.43818, 30.62942, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd99b848b-6613-4ae6-943f-cacb323b0cdf', N'25863d70-ae5e-47d1-85e8-cf113ddcd78f.JPG', 1, 9.537817, 100.0704, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b8d26b2e-8007-4540-86b4-cb45c35909e6', N'a580c9e3-f584-431b-b476-7b2e99e84ae6.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8a7f1bad-852d-49fc-bfec-cb4d29b4e9e3', N'f270c834-13e2-4c82-906e-e99781a88cc4.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bffe2e88-65e3-429d-aedc-cc1f2c5c0f0f', N'3f4a1398-d31f-4987-8f1b-5a97ecc418d3.JPG', 1, 49.98481, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'575191d8-1cf3-4bae-8150-cc5e4ff3e4a0', N'9ac101cc-5245-40c9-b5e1-1bdbc9674415.JPG', 1, 54.03389, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ea30d56e-6c85-4c31-a3ee-ccaec96d21d2', N'7631aef9-efdd-4d4d-8888-116611ea64cb.JPG', 1, 9.540867, 100.0747, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a32849dd-33ae-417e-aa25-cda8cf46d563', N'037690d3-3bdd-473f-a637-3dd75b49d0f0.JPG', 1, 9.538156, 100.0706, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2c2e009a-e6fe-4013-aadd-cdb6ad148557', N'c6e55bb3-15b3-414b-a6af-313242080af7.JPG', 1, 47.80249, 13.06806, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1353414e-c366-4e83-a86d-ce040e02eca2', N'0ada2a48-d832-46f2-b813-5141acbab8d1.JPG', 1, 53.54222, 10.12778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'106a12e5-4b1d-49cb-bb8e-cea952a07981', N'c9b054a3-ecdc-41e1-8b33-b395903288be.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8b4519a5-d106-40d4-9d91-cee446feb5ea', N'6ee3e3b2-02eb-47e1-a936-35ecd3cba946.JPG', 1, 49.98532, 25.04903, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'40690b44-009c-4eb2-8713-cf4b7ad89d20', N'08580c43-a126-4bf7-9cfe-fd2bdbc5b9ca.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'35a826e9-7916-406b-8af5-cf52acfbce88', N'6dd10c35-bb55-4471-ac59-5ba01d82b002.JPG', 1, 48.00396, 10.21156, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'66fe6387-58ad-4e41-b9e0-d01d7ce97440', N'31c3f88d-8fc5-426d-afd8-c236161aeb24.JPG', 1, 47.80181, 13.09469, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3bc1f8e6-dcf5-4cd1-8598-d0e1133d780d', N'77a05f5d-959f-4136-b409-e5ac4cc4c868.JPG', 1, 13.70082, 100.8705, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'27e46192-c7c5-43ec-a44c-d12ead87a7b4', N'4cef6d72-cd88-4bae-9d52-555f2bed16f4.JPG', 1, 25.24637, 55.42545, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'94cf6d56-515a-49fe-8872-d23b7c2a1991', N'69dbc26c-277e-4010-b091-a1c3c119243b.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7fd70819-cc40-412a-af66-d24a080db224', N'dd390ccd-2031-4eb1-8a46-0533be0b7249.JPG', 1, 60.18639, 11.11667, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b770bad8-cfc6-459d-bc0d-d3c04b691c35', N'2ac01bcf-66e3-4a07-9f32-85b9888c4bbe.JPG', 1, 42.49376, 44.5705, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'69a3f5a1-a03c-404c-bcec-d4f3f71dc5e0', N'7537e8df-1804-48e8-bee0-165607d2b361.JPG', 1, 59.915, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9c216ce9-c28d-4774-934c-d51c59988115', N'f974fbca-8ca5-4010-a240-7d98ed2548e1.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'508fa73c-a7a3-40f8-97c4-d53e9c3af7d3', N'cee53831-1daa-4de7-9883-683d2d5d201a.JPG', 1, 45.50444, 9.146611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6a1b83af-88f5-4eec-a790-d5714ea911b5', N'a6fb9fa7-293a-4cb1-9d27-036a535c2446.JPG', 1, 53.98278, 10.81667, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'785e4090-f3ff-42cf-b01a-d6ccf24ced6b', N'700bb3d8-0447-4d76-aea8-a05b94be4036.JPG', 1, 48.00881, 10.70019, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4521e4e0-41ee-4245-8920-d752de6ea84c', N'bd7a1279-ec6c-456e-8f37-5028b99712e6.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'989fab2f-3bea-40ea-b100-d78c8a858aa1', N'3e773c79-6c29-4962-be43-2fc6e9177342.JPG', 1, 47.80249, 13.07, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'84c152e8-edd9-40e8-9c4f-d84cfde407f5', N'45eafce2-2e9c-47d2-b56d-2b4f3cbda5c9.JPG', 1, 49.98447, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e2bfe6b8-933c-4c44-b862-d875c3c27517', N'ca7a79c5-3144-4847-8edd-9cac3d213111.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8c7da8f1-4e42-4883-ba19-d88fe15ca00a', N'481f1f1c-6934-4cf8-af78-9ab4ec0e8dd5.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'debbf8d6-dcee-4f4b-8087-d9521fd685ad', N'4c05fddb-8e3e-4c91-9933-cc19e5bbf328.JPG', 1, 32.50834, 35.05, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e2cf764a-9d2c-44f5-bb14-d99f7280301f', N'4aa07495-29d9-4abc-abe4-53925e0732f3.JPG', 1, 60.4575, 5.816667, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c92ccf44-9cdf-4baa-a936-d9d2ab953be5', N'2ba291b8-b099-444c-b105-b44f2913ad71.JPG', 1, 47.05422, 8.609583, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1685489f-2df6-4c04-bc94-da53b34a17fb', N'c25248e4-a951-4c66-890c-e86408416feb.JPG', 1, 31.49139, 35.44722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8e755b2c-5c1f-4ace-a8a0-da71f7763a63', N'c2ed23a1-3905-4ee5-aced-f33732299607.JPG', 1, 49.98549, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4cc45ba0-f226-493a-b0c4-db459a0bc68a', N'219319b8-ad67-4fbd-8517-403df9ab1a56.JPG', 1, 41.70625, 44.94092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7855ef3d-ef1e-4c76-98c2-dc895e272e6f', N'14b1f34d-18e2-4713-9c6a-9d08fe91ba7e.JPG', 1, 9.540527, 100.0725, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9177587a-806a-4a55-8910-ddbd11b0f7f0', N'8e2d1256-204c-4525-bf1a-3edc18dc7a99.JPG', 1, 9.459534, 100.0461, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4abe9831-66fc-4d98-ad95-dddbe2e67d4c', N'9e6294e3-c112-48f1-bc1e-e4ea7ecb7a50.JPG', 1, 42.40531, 44.609, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'54c05557-786f-4d96-beb3-de62a9069e25', N'90f8168c-5604-4b3c-8833-b485b34c7d3d.JPG', 1, 50.4575, 30.60278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'20e065ff-aed0-4d40-b8ea-df4b9de75424', N'ba914adc-6d95-4f96-a7aa-94fd519667cd.JPG', 1, 59.93195, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd4475442-2f71-4ad3-9271-dfebbc39deaa', N'6ff735e5-a69e-4647-be2d-fc03867c2cf8.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'60dfc113-9357-43c1-bdf2-dffc8b52e24f', N'e96b94f2-b815-4982-98fb-b072b98602cd.JPG', 1, 49.56899, 25.7002, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1dcf1975-9f4e-46fe-8359-e0229154a881', N'fd627ffe-efab-44b7-94ea-7f270d9284ed.JPG', 1, 31.305, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'78514b11-97f2-4dec-a876-e0235dbb00d3', N'79b7cd7b-4d90-4206-9032-97d21e85c8d9.JPG', 1, 47.81215, 13.05561, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'08bcaacb-771b-47d9-b652-e069933cd381', N'b77741d5-072c-4d06-8508-1b8980112e0a.JPG', 1, 49.98549, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'cb38d26a-97d8-4606-b942-e175e4ef40d9', N'ceb97af7-cfc9-4aab-9d34-dc5b419830d7.JPG', 1, 60.28806, 9.777778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'eb8ca6a3-8101-411e-ace3-e19bdfab0128', N'4f879264-e806-41ac-b16f-48605db64642.JPG', 1, 54.03389, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'916b92cc-6f97-4c6b-9832-e1b6ecb77f78', N'5be316f2-28cd-43bc-9129-10f6d019b6ba.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c784e1ff-386b-43af-a6d0-e1dd025a55bb', N'e64da499-2885-450b-a80d-88e5186d90b9.JPG', 1, 49.84655, 24.01381, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f81310fe-d313-424f-8ca1-e1e1585f9081', N'c106417f-9ffb-490a-a818-4aff46dc2d67.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd5cacd0d-9ba8-4d42-9714-e2ca11b1a3d0', N'59cc8394-a2ae-4ceb-b644-328d68ef4cfe.JPG', 1, 42.51782, 44.58722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2aef4da3-c63a-45d1-9d73-e2f57d643d38', N'e9cfc43f-f0a9-4f67-a87f-d8c731cfc2bb.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1edcae74-0737-478f-9c69-e39dc8458cf3', N'a16e8a12-8b49-4cd4-b521-8cadfef33e48.JPG', 1, 60.47445, 7.952778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'887c4290-3cca-4846-bcdc-e3a9feffaabd', N'60b2830f-a0a8-411d-8c82-0ac540b1f97a.JPG', 1, 31.35583, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9c1134e9-0f74-40ac-b4ea-e3abcb27744e', N'b190b294-043e-4636-9fb9-03bcbb1fc01e.JPG', 1, 50.75098, 25.37644, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c909e602-b18c-4932-9eee-e4144cebff1c', N'3e86060f-5dd9-4f4b-ab3d-b45a2296e8d5.JPG', 1, 42.47207, 44.56661, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'055e4e31-c5ab-40ad-92b9-e416258f8e1f', N'ce5984e8-5dad-4c41-b2e7-7683035ccc3d.JPG', 1, 61.03389, 8.019444, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'59b64474-295e-4287-9fb6-e4458fadaac7', N'08989b8d-ca33-4ceb-bc1d-c68b1e4e0dec.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7c3ff6cd-3f57-46cb-83c9-e5a983a1c92b', N'e5083f12-80b3-4105-bf51-0ee8b021791a.JPG', 1, 49.54222, 25.68056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'844d8888-2bcb-4d91-8b6b-e5d4b4a81889', N'92f7fecf-bdcf-4aec-8b11-9484b82b7d2e.JPG', 1, 60.20333, 10.07778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6990dcdd-171d-4bd2-8da2-e618212cdde6', N'af0d88a9-96b5-4de5-82e8-c391af7a0005.JPG', 1, 32.03389, 34.85556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3f62019b-e0ce-4855-a29c-e6adecf4ce56', N'd699b1e2-f053-47ff-a6ee-0493a0b6747e.JPG', 1, 48.36702, 24.44839, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd56b28c0-2160-42d3-b3c2-e6bd02ea6162', N'84bb103d-903e-4907-b7ba-05ca4dccfffa.JPG', 1, 47.43852, 9.753667, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e2f3abd0-0ab0-4bb0-9666-e6e1511b8d44', N'742a494e-47af-4a3a-a72c-2da15f82570c.JPG', 1, 50.7503, 25.37353, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'70f7845f-1f6e-46b4-abdc-e74b3a20fa4e', N'e17a1d8f-a611-483d-882f-b8de7d378aee.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0a493c3d-3b05-4941-b87e-e8310a97e9b8', N'3f7a0263-abf0-4eee-a1b3-a4b4a7c71d27.JPG', 1, 41.70625, 44.94033, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'790e8c42-90c3-4c61-8105-e90fa8722ddf', N'069c5280-339a-4899-8575-0c79a4333b79.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9e207208-dfad-4a7c-89b3-e931a5365c7f', N'9a5f3d68-5f59-4d36-aa8c-5500021dba70.JPG', 1, 50.09658, 25.85128, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f30311d1-244e-4b00-b7c9-ea431aa47a66', N'4c5e14aa-ba52-4667-a5d7-c893d4dedb61.JPG', 1, 47.80181, 13.09469, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e16b9fd2-6103-43fd-90cc-ea6c4a218fab', N'bd4734b3-2b33-485f-b964-5bcdbeaa2302.JPG', 1, 48.00881, 10.70058, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'86381646-ab8e-416e-ab2a-eb54ac92ad9d', N'c91e4b32-7b80-46bc-b44d-170d52ba6a3f.JPG', 1, 41.70337, 44.95161, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd9c8ba54-18e1-413c-b6a2-ebc6e40aee40', N'882fc539-5e5c-4336-a756-416627d3dc35.JPG', 1, 47.49478, 11.20903, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'67ab6b08-3544-49aa-a593-ebcecd9ee288', N'a39b74f8-2b24-4d84-8d85-9ecb3c8d2126.JPG', 1, 50.43971, 30.63408, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e0092826-2ef3-4681-aeae-ed5d3c92a891', N'54d613c4-44fb-462d-91a8-e23766feeabf.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'50db4173-351f-4284-b6c6-ed78753154e6', N'f0618bbe-5b16-4300-aeda-94bd175d3eed.JPG', 1, 50.09658, 25.85361, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'114e1a27-4766-4d11-9d64-edb900b881dd', N'8af99c2d-5fb4-4f67-9ba1-c3d31176d066.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b23cc24f-7524-4da5-9ecf-ee3348a040d2', N'd3aa2760-97d6-403c-af7c-b025218af179.JPG', 1, 13.75352, 100.5999, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7c3b074b-828d-4b2d-9e8a-ef443485c9f1', N'896bf15d-e972-42cc-829d-e695fe118866.JPG', 1, 54.03389, 10.85556, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e736b0e3-d866-45ff-a4e8-ef5c289d01b9', N'ef901d3a-d676-434a-927d-483557c87e91.JPG', 1, 31.77944, 35.23333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7680c7ea-7435-4bdb-84ea-efbed9f30805', N'4dc56e50-2f36-4620-a9fe-915c3acbf350.JPG', 1, 41.70303, 44.94558, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a09ff2a9-2b35-4049-ab06-f049c1abbbcf', N'd31e5985-cb10-448b-b194-83fde83f4170.JPG', 1, 42.47445, 44.56389, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'068b4bdc-d2b7-4407-9775-f0db89e92ee9', N'33fcac38-c7f6-4412-bd39-1407da84a0e7.JPG', 1, 53.54222, 10.12778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'43bff57f-c754-4efe-810e-f0eb38d17634', N'28166a84-b5d8-490e-aac5-12a4af554ea9.JPG', 1, 48.0632, 10.99244, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bd822372-2610-4cb1-ad15-f1a011b4c0cf', N'6c322419-bb7b-4ee0-b4ad-be8bd2a3fab3.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e5cc9f47-4205-440c-a4b4-f2a1f13f2505', N'9c680ed0-d351-4eb7-bee2-fa446f46f751.JPG', 1, 54.05083, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6ec78908-56bb-47bb-b5e8-f2bdf88cb9c7', N'754da39a-7045-4392-a76e-b3cc5acb5adb.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b1737e4c-adc9-4883-865c-f2d13af93552', N'dfab0423-352e-4f40-9b4a-7809eb34395e.JPG', 1, 45.42514, 11.13244, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'91b527a1-2806-4df4-a40f-f2e007476dfa', N'0fd12467-b9c9-4405-8508-6dc778c97843.JPG', 1, 49.98617, 25.04825, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3d2c4012-f2e7-45fb-9cbe-f3b0a916808d', N'01cded85-4cd9-4c37-9e7c-a387ac1d96bf.JPG', 1, 50.44005, 30.63544, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0bb3cecb-e9b5-4b70-b44c-f47b6c9ecaee', N'0e77d4a5-dad7-4350-a4db-47299a3a8a81.JPG', 1, 42.50528, 44.59364, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9fcdd7c9-f104-40d9-afdf-f4824a32aafe', N'01bda149-6dc2-49ad-8981-d817b61c3241.JPG', 1, 49.98413, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5648542a-bbcb-4350-81e9-f488a4892a54', N'325d1a37-05ee-430a-98f7-231eabe83458.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'658c4481-734a-4ead-bd17-f51f78637756', N'46ed0bdf-7b6a-45c3-84b8-5b5a919eeff8.JPG', 1, 31.77944, 35.25278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f11c6665-de43-477c-b90b-f63fbf1dc518', N'74f70266-e652-4260-8bd9-01c3670fe5b7.JPG', 1, 46.13725, 30.61833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c389ba2a-c9a9-43b7-811e-f7b1e700b1eb', N'9a3b874f-002b-40ea-b16e-4836d426a30c.JPG', 1, 61.03389, 7.933333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f67a0344-3425-4ff8-90b0-f7cba6e0bd80', N'369eb450-dc16-4007-9460-60987cc706a2.JPG', 1, 42.50545, 44.59481, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e65ee31a-0b39-4b16-9457-f8db692c76ba', N'69494ae5-4f9d-4653-bb5a-0faef35aa7df.JPG', 1, 49.98481, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd1f69138-3600-417f-9d8c-f8dee7d2cd8d', N'6e971152-86d8-4da8-8159-36795417c454.JPG', 1, 41.70015, 44.94461, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f1d71cea-75f3-458d-9738-f93b7ef07b8b', N'3a472c41-535a-4c7a-a1a0-6e1aa064f8be.JPG', 1, 9.540189, 100.0774, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1ac65e12-60c1-45eb-a5ac-f99037b2ba88', N'e51f26e6-3636-49d6-9c4e-55f2da8b3ae5.JPG', 1, 49.98464, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'95b4cca0-041b-4773-bb9d-fa03d3c81ce5', N'e14730c4-57fc-415a-9317-9ec758325782.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e60471a2-fce7-40a0-aeeb-fa3e4fbe8c86', N'86b8dc78-2a29-457b-8191-dd339d465198.JPG', 1, 48.00898, 10.70058, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'830b0047-e744-401d-a527-fa69a38aae91', N'1419b8f6-895d-4878-a8bd-9848d6c4e5a7.JPG', 1, 47.0466, 8.675305, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'6b98f564-a1dd-45a7-80e7-fa723a45672f', N'bee5d305-b0a7-45c2-b197-96188dfa9f84.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'aadde9cf-eb9e-4a28-b7d2-fab0172105f7', N'1c5a4de7-06cc-4b84-8a08-2d65b4a9e28e.JPG', 1, 47.04626, 8.697278, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'cb3b8174-b804-4566-b6fd-faef9ba73767', N'8ea50c9f-54ac-4b88-86d7-fecff8e23ab5.JPG', 1, 49.98447, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'77d44adb-c8e1-41c5-bb78-fbc8e16e43d7', N'3a7e5107-10dd-4049-b8f0-bf3d02a50838.JPG', 1, 9.540359, 100.0725, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ed777baa-62ec-4e5f-bf5d-fc00a91f12f5', N'e9252203-c51b-4c69-8347-a92fead2e94e.JPG', 1, 50.61, 30.54445, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1a7fb58e-a869-4b3b-a46a-fd13547d5100', N'1736e9e4-e067-4dad-b849-d56fe6b73f85.JPG', 1, 41.91957, 44.75989, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ee5aedbd-26e9-4b2b-8656-fd269ac0ef5e', N'e25c66fd-d591-498a-a70d-358c5aef6c68.JPG', 1, 48.00813, 10.68231, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c5d50cce-4859-40f4-a14c-fd55412ebc0c', N'a4bfdb0d-6a3e-49cf-9832-6d1f1e199649.JPG', 1, 47.39023, 11.28894, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1694ec50-640b-4b2e-8614-fdca2a001290', N'8ed31a04-0c42-4d3c-9979-f1ccb5ce68bb.JPG', 1, 41.6993, 44.945, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'85b63be5-4426-447f-876b-fe322a8b635e', N'ea4e2233-3e89-4a4f-8abf-aa086379a4d2.JPG', 1, 41.70591, 44.94111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a0306a7e-9baa-4daa-afb6-fe468dfe6cc0', N'b49b5bf7-0bb1-4ac4-98f8-33f378514d7d.JPG', 1, 31.305, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'133665cd-dc2b-40db-9f12-fe6f0c5a5296', N'0a355ac1-cdd3-4b9c-b04e-4b0caf20c0a2.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'560a3507-041f-49bd-b13a-fea8dfbd9950', N'34e02fb0-51bb-47f4-aa10-eac46aa22ad1.JPG', 1, 42.47851, 44.56933, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'48bcb546-b15b-4d7c-88c6-ff4bbced50fb', N'59df518c-d407-4930-a0fc-e789a15beb10.JPG', 1, 50.76267, 26.04608, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2321f012-1b0a-4796-a65a-ff77daa08c86', N'8a0346e4-c12d-4c51-a302-cd3513009ced.JPG', 1, 13.76284, 100.5763, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'026b21dd-4397-448b-aede-ffe317b4c608', N'ef9a7849-6188-461a-b503-cc3ffefdbdcc.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'3cee69d8-6e34-48f4-8d0b-0009e2207943', N'museum')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'37acbd12-5048-4055-9b36-002834b628c3', N'police')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'c5b9d94c-b1c5-46d2-9b48-01fd8fa9fffb', N'grocery_or_supermarket')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'23a330ba-4dc8-4e22-9a11-0353c3f4bba7', N'casino')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'6b84348b-f604-4d5d-8d8a-09fbcfc52e8a', N'storage')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'741d1d56-bfa1-43ed-b6f3-0c4185277863', N'parking')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'631ec1c6-bc08-4894-939a-10e684446a0c', N'accounting')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'aa4bffd4-f361-401d-9cf7-11be3e202803', N'restaurant')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'ad46acde-b5ea-40a7-a2ae-1257804e0c47', N'food')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'b6cc1ce4-6a53-4233-9ad9-137bdf024f4f', N'campground')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'905868e4-5c18-4a8e-b339-159b3b55abe6', N'car_repair')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'fe4813ca-0913-4274-b82b-1a95ea9efa82', N'electronics_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'e80001c1-7737-4caa-88b2-1f45bcc8d45c', N'subway_station')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'373325ca-f871-4cc0-a724-20a318d5a0eb', N'book_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'04c85779-50c1-4fa3-8450-2453fb174c93', N'meal_takeaway')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'b0399124-91a6-4d81-b092-247767144a03', N'art_gallery')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'3bee74d2-e87f-445f-8f43-2a4c4015c878', N'travel_agency')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'8f9febb4-a317-4cff-b502-2b7936d07536', N'plumber')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'ceeb676f-e5e6-4bbb-a087-2cacb2485ab8', N'laundry')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'4318eef8-e79e-4bfb-a3d5-2ce3678fc13e', N'train_station')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'5fe242f1-65ac-4cdb-8bac-30ef04f7aef0', N'establishment')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'f43d8c94-9295-4b68-b454-310107a4d237', N'car_rental')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'601270f6-a725-4967-8272-3b7ce2af2fe2', N'physiotherapist')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'0008d2cd-0266-4fa4-b1ff-3da248da267e', N'home_goods_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'18a0a94b-e3ae-4cb7-8bfd-3df45af75e5f', N'stadium')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'5b07c99e-68f4-4e7f-a5ca-42d2bacfa021', N'pharmacy')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'26cc22e1-8b5d-4539-b2d0-43dfe180ac35', N'lodging')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'e3b7f72d-0a3d-47d2-916d-45b65d922ae8', N'amusement_park')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'c00042bc-d3a9-4c26-841e-4668161b3550', N'cafe')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'7fd2a340-64c9-4dc1-ba03-497d8f3aaeb8', N'pet_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'07e43564-fffb-44b0-998b-4ab243383f2a', N'general_contractor')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'2f3c9d35-af13-4cd8-a530-4b6a291cb815', N'florist')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'1b59e1dc-a551-47db-9ee1-4b86f19df4b1', N'post_office')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'dc844bac-d27f-40da-bbe8-4c0f1656fe28', N'car_dealer')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'237813d1-d407-4e9a-9883-4cbd17ae24c4', N'mosque')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'f0eab37e-e89e-4264-986f-4e93e5e7767e', N'lawyer')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'fbe36146-4587-4828-9529-4f57917882e0', N'health')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'1a411351-a937-482b-ab39-51b7768cadcc', N'park')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'76cde061-7323-4ae7-b141-52e9ca708877', N'church')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'ce9236ea-aa76-4755-b946-58fbad493390', N'rv_park')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'11c202cc-65a9-4703-863c-5e34bf40e624', N'furniture_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'220c5735-e8d4-4aaf-81e2-605ee56a34ee', N'zoo')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'e23457df-4a56-44a2-ad3e-60fdac551cc8', N'taxi_stand')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'360cd67d-1b8d-49d5-b51d-611db163798d', N'car_wash')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'3d274fc7-276d-40fd-9feb-65bab60929d0', N'bus_station')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'f7fe1efc-cda3-4d7f-8d49-66a97d9a24e0', N'bowling_alley')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'2a58a7d3-3a9e-4b18-b5bd-6ed477363de5', N'library')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'6c0bbbd6-640d-4a19-be63-705b7e3c44f6', N'veterinary_care')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'1925c6e0-f87f-4c65-8016-732d136f5921', N'finance')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'4f295f60-15b6-463f-b71f-7b080bbcec93', N'electrician')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'9b612cbc-e160-4d2a-bbfb-7bbab7d3dc27', N'meal_delivery')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'fe8a6135-8125-4b6e-b39d-7ffc9e522fba', N'store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'52c84466-d948-4c42-a483-837616292f64', N'airport')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'be3e4ead-584b-4dd9-a9b6-88eae98fb3fb', N'convenience_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'de395b64-5681-4045-941a-8ad05bb4d795', N'city_hall')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'a4afd7c3-e808-431a-8c98-8e60547958c5', N'shopping_mall')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'a0f1394d-7417-48f1-acfe-8fcec2f3be92', N'fire_station')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'e1460bac-d6a3-4ea2-8601-90e2812f8711', N'dentist')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'3be94d7d-3f48-41f1-8aa7-911b353ed56f', N'jewelry_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'cb1f7626-3089-43ea-9c78-947713339464', N'bank')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'd84f9b1b-73e7-45e8-88b9-95be4ea12a5d', N'local_government_office')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'931323a6-a233-4e17-805f-98420d42349b', N'moving_company')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'7a360fca-7a6a-43e7-b130-9df4b2db0472', N'hair_care')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'e52acc20-7000-4189-b100-a427bf76ee4c', N'school')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'fd60a497-4154-4c6b-a57b-aabd9bbd2371', N'spa')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'6dc4b745-7f44-461b-9101-aceffb2920a7', N'hospital')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'bee9135d-71ab-46c8-9b4e-adc861b07e7c', N'gas_station')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'4f6f457c-d2dc-4cc6-9804-af393053c829', N'bar')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'e65a6e33-f770-41ec-8625-af57a5d328f7', N'atm')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'568e764b-ddf4-43bc-bbaf-afbbfe0eb847', N'clothing_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'3dd940e1-57f5-4fb0-840d-b11f4447d2db', N'university')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'2cc5f51e-e584-4bfc-b199-bd74ac5b119a', N'beauty_salon')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'9aba704a-8c50-485b-9786-beb903c8df87', N'real_estate_agency')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'76835bc2-9515-4efa-ad92-c237911265f9', N'roofing_contractor')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'a59510ca-c5a1-4016-b042-c2e4e2b835cd', N'insurance_agency')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'2bee8e3b-adfe-408e-8dd8-caaad2f19bc1', N'painter')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'dbb90bf1-07c3-4a2b-9639-cb300eec431d', N'bicycle_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'785d8fa0-781e-40d1-aefe-cc6495efca63', N'doctor')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'fc0e530a-32ad-4cd2-8da8-cff6d8e04b49', N'night_club')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'0d974fbd-89dd-4694-ba93-d0c825a9e9ed', N'funeral_home')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'6924f037-39a3-4d10-bb23-d29740b86185', N'department_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'7fcefeba-79f5-442a-bde7-d3c191a5f178', N'cemetery')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'4b15b34c-2501-46d3-947e-d4293c1aef2e', N'shoe_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'75d40a78-c11b-4806-9ac4-d8ac977cce1c', N'gym')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'cea9864b-7a9c-462e-8f39-dc22da857848', N'hindu_temple')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'fe0f802e-919a-49f3-8994-df59b9351d31', N'movie_rental')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'329a8ab5-ead3-49c6-abfb-e389fad856bf', N'liquor_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'ca66b0f3-68f7-4fef-a058-e5735af4f3c5', N'synagogue')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'856d8247-5933-43bc-8576-e5d30972ad7b', N'locksmith')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'80d2e57c-8c39-4343-ab26-f17ee1e1302e', N'courthouse')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'ce5773d8-041e-43e5-a4e1-f2f028eb5548', N'place_of_worship')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'ac8e34c8-8b3b-4026-9ac6-f43fc8e69360', N'aquarium')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'447501bf-09ff-49c9-95ac-f442a4180353', N'hardware_store')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'01783e7c-812e-48cf-851f-f4f5850d7af2', N'movie_theater')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'a322b507-abfc-4b71-8a0e-f88c054fce8f', N'embassy')
GO
INSERT [dbo].[PlaceType] ([PlaceTypeID], [Name]) VALUES (N'4623a449-55e4-4e72-a5ab-fa22ae54d1ae', N'bakery')
GO
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [FacebookId], [Disabled]) VALUES (N'3d70c1c0-e191-4837-9fa7-3398c928efaf', N'Helen Tishchenko', N'2cdedf73-fac8-465e-ad18-68f8233a3a1b', N'889032304522286', 0)
GO
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [FacebookId], [Disabled]) VALUES (N'91097101-658d-44f9-a534-4484209c8179', N'b', N'b', NULL, 0)
GO
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [FacebookId], [Disabled]) VALUES (N'b057798c-6167-485c-b0c1-a40704faaad7', N'Oleksandr Turevskiy', N'5e91657c-1a5e-4719-b9fa-2e2f50176767', N'1152399981440766', 0)
GO
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [FacebookId], [Disabled]) VALUES (N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', N'admin', N'manisfree', NULL, 0)
GO
INSERT [dbo].[User] ([UserID], [UserName], [UserPassword], [FacebookId], [Disabled]) VALUES (N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', N'demo', N'demo', NULL, 0)
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e386d593-4dfb-4c45-927d-0016068763ea', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452672400000004, 30.591083800000003, CAST(N'2015-10-01 07:13:53.947' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'27c51ae8-836e-4f05-b591-001cfe8dc32f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452685599999995, 30.591214700000002, CAST(N'2015-10-01 14:03:56.013' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f1d0b94b-2253-43e1-9272-008c3c6e1f07', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.453763813438734, 30.594095129906826, CAST(N'2015-09-30 13:23:26.583' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0c8444e9-bccb-4d6b-bc31-0171871570c6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:12:55.120' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3082154a-85ef-4855-9658-01ac444ff34c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430942247780806, 30.539525227293471, CAST(N'2015-10-01 19:31:17.373' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd8970fca-7eef-4f08-84ab-0254d4e4d105', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526372, 30.5911194, CAST(N'2015-09-30 12:45:49.600' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'64434058-96c7-46b0-8342-025d442a5d2a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4526468, 30.590955100000002, CAST(N'2015-10-01 08:40:27.950' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e8abc2d9-ad31-42b3-8c66-02cf34d6f617', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:26:29.253' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'eed7672d-a013-4fbc-a842-033a2514da9b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526932, 30.591086200000003, CAST(N'2015-09-30 11:38:39.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'33aa09a7-c978-493a-9b28-03bf4cf03fbd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:00:39.577' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ea7ff943-0a42-4465-a737-043f46e4d91d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526999, 30.590975699999998, CAST(N'2015-09-30 07:06:24.000' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7d140ee6-95ba-495c-a772-04d2b3d4845a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452654100000004, 30.5911272, CAST(N'2015-09-30 13:42:28.790' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0d58e346-9de8-4bea-8710-0503c99bbda0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:43:07.010' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6cd48101-9e68-4dee-b505-051042b0f539', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4528013, 30.5911097, CAST(N'2015-10-01 08:33:55.483' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5d4639b8-b322-46ca-8401-051791d59602', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452756, 30.5910741, CAST(N'2015-10-01 08:46:10.323' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7e367357-67b2-4832-b0a7-051bb0c798ae', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527086, 30.591071999999993, CAST(N'2015-10-01 09:19:42.763' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'17cc641f-d07a-4364-837a-052e928e34d0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452623256915381, 30.59113352977106, CAST(N'2015-09-30 08:44:10.447' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'161db5f6-a556-4f8c-9857-0566790deb45', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452493955185275, 30.591222858985862, CAST(N'2015-09-30 09:17:59.300' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c1627fa5-0fec-49f4-b0f6-05cda783ae05', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452782567637463, 30.59136084283757, CAST(N'2015-09-30 09:23:00.423' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b6744f31-dadb-4b90-afd8-060c8122857e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4519945, 30.5919503, CAST(N'2015-09-30 10:05:47.877' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'363c2488-b4f5-44cd-af78-062d2e616465', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527327, 30.5911269, CAST(N'2015-09-30 14:17:49.920' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd0bd32ac-c5f9-436b-b517-06845aa98427', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:15:13.170' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'89e5297b-22a8-4a65-b993-0724c30ee1c0', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452476854244878, 30.591043210865557, CAST(N'2015-09-30 12:28:55.887' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1557097f-6fa7-48c8-87e9-07a710bbeb42', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45276863613234, 30.591056571585565, CAST(N'2015-09-30 09:28:16.967' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c75becfd-d598-41ae-ae1b-081092b3d249', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4307902, 30.539826200000004, CAST(N'2015-10-01 05:43:07.747' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bc74fc42-b72e-4eb9-ba98-08b8b13114d9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452322717427307, 30.591475018427715, CAST(N'2015-09-30 10:43:16.320' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4ccb519c-5756-434e-b85b-08ed06dc9107', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 11:51:58.277' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ac547c81-ebc5-4aa1-90c2-08f69eec400e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452817769453631, 30.591166010546083, CAST(N'2015-09-30 10:18:11.090' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'798826c5-0f68-4cba-96db-0910cfffe03a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452396790543993, 30.591903068153737, CAST(N'2015-09-30 12:58:59.887' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'97b3c08c-b9de-4941-a7f3-0967ac3e9e2b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452775610657831, 30.591120449854611, CAST(N'2015-10-01 09:09:12.340' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3655d20c-7945-4d6c-b048-0c421f624fa2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527, 30.5911135, CAST(N'2015-09-30 13:07:34.297' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1ce7932d-0927-4d2c-9fa4-0c6a28e201db', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525973, 30.5912944, CAST(N'2015-09-30 14:38:22.390' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4ec30c79-ddaa-4086-954e-0c9bd03f8f7f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:48:17.427' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2a3cb74e-5d35-4c41-aa68-0cad76307ee8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452749399999995, 30.591220699999997, CAST(N'2015-10-01 11:57:36.510' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e57e77e2-4a2b-4148-bc29-0d0d73f14cd6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 08:23:51.473' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'034a634e-0b76-4ad0-ad78-0d4acedcc4b4', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452641734800338, 30.591078769933564, CAST(N'2015-10-01 09:46:11.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd09a473e-647e-49fd-b0cb-0dbcc4206e75', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452623235869616, 30.591045281473203, CAST(N'2015-10-01 08:25:34.133' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6abd9682-23a8-48a6-b8dc-0e367cc5b36f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526932, 30.591086200000003, CAST(N'2015-09-30 11:39:27.657' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f8a742ef-2c12-4348-9339-0e84561d9eba', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.45267150742044, 30.59117954227197, CAST(N'2015-09-30 13:28:27.173' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'be4f2272-3278-4682-94c1-0ead9641e1f5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 09:29:48.000' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1aef5f94-bccb-427d-a94e-0edb89862ff1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526251, 30.591291199999997, CAST(N'2015-09-30 07:13:01.693' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'11fbda29-84b1-446c-b71b-0f9a3a6dec62', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526019, 30.5913018, CAST(N'2015-09-30 11:04:34.873' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5a71e5a7-3241-4c07-9399-0fc77fa3df56', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:42:36.513' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'403def5c-e63f-4d08-b733-104f105197fa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527003, 30.5910665, CAST(N'2015-10-01 12:08:03.933' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3ec58abb-fb8f-473e-916b-106f96dab89d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452234399999995, 30.591570999999995, CAST(N'2015-09-30 10:49:33.607' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9f996190-dbba-4a30-8fcf-107f79f8586c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527144, 30.5911506, CAST(N'2015-10-01 07:56:39.940' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9a169234-f633-4424-9947-11e24c10d907', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452775610657831, 30.591120449854611, CAST(N'2015-10-01 09:09:27.993' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'05ee3dea-3c42-49bc-93b0-121ae5a85f27', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:05:14.240' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f59ea100-da9c-4a29-beb1-12d2d9126b4d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527012, 30.591200299999997, CAST(N'2015-10-01 07:07:27.063' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'53d995a8-d723-4ff3-800e-1316c3edb1b1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:49:21.353' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'87179d7b-1f86-4476-a508-135b7c709db3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 13:50:02.527' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5a7746ec-ebff-472c-a50f-143364d190aa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452672400000004, 30.591083800000003, CAST(N'2015-10-01 07:13:53.863' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8da21cc1-7fa2-4697-a5c0-14377dcff299', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45266955786991, 30.59098742892191, CAST(N'2015-09-30 10:33:14.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'aa958a63-c71e-45c8-85ff-149bc9add4e3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452493955185275, 30.591222858985862, CAST(N'2015-09-30 09:17:59.187' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'080664a9-41d7-4969-90bd-14ae2646bfbf', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:58:37.353' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dd05b838-baee-4abb-a10d-153bccb254c0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45210392684718, 30.591506855590819, CAST(N'2015-09-30 09:38:03.140' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3bf81f38-6457-4ee3-958d-15c4a3cc87bc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.430817, 30.539838999999997, CAST(N'2015-10-01 06:00:23.147' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0352b340-d763-4de7-9294-160618af2466', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.430817, 30.539838999999997, CAST(N'2015-10-01 06:00:22.063' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9c57fb77-0c55-4691-944c-172fc566bd37', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:48:14.883' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e2385472-5e55-41aa-9d40-1781f0643200', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452653570299645, 30.591104596836967, CAST(N'2015-09-30 10:28:13.373' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f6472202-83e1-4ace-a1d9-178bd91fd822', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526885, 30.591048699999998, CAST(N'2015-10-01 13:25:02.630' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c94e3856-734a-49df-88aa-17a67e4535cf', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452690999999994, 30.591072299999993, CAST(N'2015-10-01 08:03:43.627' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'97c1de48-9b7b-43f2-93f8-17bde6a2b81e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452670439289051, 30.591085713909592, CAST(N'2015-09-30 09:00:42.457' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c98471ed-4622-4d7d-8b50-18a0e3d4af01', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526019, 30.5913018, CAST(N'2015-09-30 11:09:14.700' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'07bc096d-4b3d-49a9-a460-18bb1e93c430', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430933028043988, 30.539570706014214, CAST(N'2015-10-05 17:18:17.647' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'59f4d51a-95b7-4bf0-bdf2-194682c5aaa8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452685599999995, 30.591214700000002, CAST(N'2015-10-01 13:58:56.547' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'590cc56c-3431-4dc0-bce4-196e535bc2b8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:42:37.153' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'424f8f09-5aed-4735-b214-19a65d71f834', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527259, 30.5910893, CAST(N'2015-10-01 09:09:49.250' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'78ab6dbc-0320-4aa3-9553-19f15246de85', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:06:52.840' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ffac01f3-1c27-4e65-9d70-19f49c746d86', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453098579159615, 30.588428201502929, CAST(N'2015-10-01 08:12:01.587' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c8e3d8e2-1073-484f-95f9-1b3075b35cac', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:14:40.120' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'727be4d6-9563-4029-9ed6-1b9305707a00', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 12:33:17.037' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'011927b3-28b3-471b-9b33-1bc352726864', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452051, 30.591866399999997, CAST(N'2015-09-30 12:23:10.530' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'88b696a7-fdf8-4faf-adbe-1bfb47849c39', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452651300000007, 30.5910128, CAST(N'2015-10-01 08:30:08.503' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a7424b18-d921-48a0-8de2-1c5f2e6c5db6', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:58:27.187' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c5900c85-f787-4834-9fad-1c6003b9036e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527012, 30.591200299999997, CAST(N'2015-10-01 07:07:22.180' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ab2fbd70-8284-4499-bb56-1c71c013d0f4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 08:18:52.413' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7fa057eb-7af1-4a55-8d01-1c7deebf255f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:27.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'031ae3e7-c9a5-4ec9-91fd-1cddfa483ac5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452675400000004, 30.5910611, CAST(N'2015-10-01 13:12:00.797' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b164fd49-30eb-428c-bdf7-1d51b05f5448', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:50:39.460' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6eaf5f60-8c11-4e57-9874-1d5393cbdefc', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452626514613421, 30.591060312180304, CAST(N'2015-10-01 07:30:43.307' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a139a94f-dc54-40cf-adee-1d7e90090264', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:33:11.593' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5e9acfd5-7652-4520-a367-1d8d55a837b1', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452238820475877, 30.591637317009504, CAST(N'2015-09-30 12:23:56.927' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bd6ac8b8-7cbf-4d98-9745-1d996c97dde6', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452685599999995, 30.591214700000002, CAST(N'2015-10-01 14:03:56.140' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd40377a4-6647-453f-9f60-1d9c3aaed849', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452503109911234, 30.590994276831896, CAST(N'2015-09-30 09:43:06.733' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'23e525d3-15d6-44f8-98f2-1df6b6d55fb9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.451993099999996, 30.5919258, CAST(N'2015-09-30 12:08:08.873' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'32e06e2d-05e1-41b0-b5b8-1e1e5933cfd2', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430930465382552, 30.539515541968534, CAST(N'2015-10-05 17:03:17.410' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'91fb6793-fa6f-43d2-9416-1e3fca98b1f9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527035, 30.5911479, CAST(N'2015-10-01 09:04:43.463' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7b141607-5d5e-4cc6-b332-1e75479ccb9c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525973, 30.5912944, CAST(N'2015-09-30 14:38:03.807' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ec4ed08e-7545-467f-8790-1e9387eb2e17', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452254324976032, 30.591668708465786, CAST(N'2015-09-30 12:48:58.883' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dfe26e4d-094d-4a19-90ed-1e95197c0149', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:14:43.717' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9a0cfc53-f5a9-4337-b20f-1ee6dab4c3e7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452399691434053, 30.591502939354672, CAST(N'2015-09-30 09:58:08.807' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4650642a-60a8-4f76-bb35-1f717ee4e26b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.430858, 30.539765900000003, CAST(N'2015-10-01 06:05:45.550' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'73cbf511-8321-4c1b-8047-20930663c4b0', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452739199999996, 30.591275600000003, CAST(N'2015-10-01 10:27:07.007' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cd5ca1b4-5b9a-44a7-98b6-213c4dd3ea30', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 12:33:21.657' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b2961fe8-fe9c-4a98-9f85-214cfc78a583', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527397, 30.591091499999997, CAST(N'2015-10-01 08:25:52.243' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e12edbee-cbed-417d-b468-21845c4851f4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452397686143335, 30.591457706419959, CAST(N'2015-09-30 10:38:15.763' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'73749149-13d1-4267-a9f0-21b6d101569c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430972737384664, 30.539472785400616, CAST(N'2015-10-05 17:13:17.537' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1cbdc7b7-112c-4bfc-88a8-21ea42a0084b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526221, 30.591059, CAST(N'2015-09-30 14:02:30.230' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c359fc4e-a8b3-452f-9c8d-2235d1eeb0bf', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:17:52.977' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5158ade6-83e4-428c-87e4-225ae1c9a183', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453002131591042, 30.591354221134065, CAST(N'2015-09-30 10:23:12.080' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c97816a8-8334-4761-af51-22d0ff177016', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4307902, 30.539826200000004, CAST(N'2015-10-01 05:38:13.157' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3494c33a-d1e6-4f57-bfd5-238d4fcedcae', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452694199999996, 30.5910712, CAST(N'2015-10-01 10:43:08.587' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd5d8b979-ef79-4f69-82ba-23a1698bf3de', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525539, 30.5910324, CAST(N'2015-09-30 10:19:45.160' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'be8d7e0e-a63a-40ef-9992-24ddfbe00ccc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452638, 30.591248399999994, CAST(N'2015-09-30 10:28:41.173' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'944ec948-93f9-41a7-8b86-250f460c6194', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:16:15.930' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2addb176-a2e1-4437-8c0a-251e411803ea', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452782994608548, 30.591489680848685, CAST(N'2015-09-30 12:53:59.093' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c17597d9-6516-4ba9-ad9a-255619f87f4c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:06:30.483' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f8f523f1-3bd9-4990-955e-258155e92c7b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526964, 30.5911046, CAST(N'2015-10-01 08:51:07.200' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'70854e0f-7b04-453b-ab19-25a08ff9cc9b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452670399999995, 30.591127600000004, CAST(N'2015-09-30 14:07:39.747' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9d9eb6c5-2e2a-47ed-8fc1-25d1038a8482', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452670399999995, 30.591127600000004, CAST(N'2015-09-30 14:13:01.433' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'48bfdc58-893b-42c0-b9e7-25ed33ad6caa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452455545717989, 30.59098060401142, CAST(N'2015-09-30 09:33:02.353' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b7ecf96d-4ae9-4d75-870d-25f73fcda43c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:02:54.893' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8513fd05-3c17-4bff-a01a-25fa9770f058', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526999, 30.590975699999998, CAST(N'2015-09-30 07:06:34.790' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'67bf9c43-232c-4a7f-bcb5-2629fc09143f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:17:53.243' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fe19782b-aebc-49fb-86fa-26aebeb55e3d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4529871110254, 30.591019566048956, CAST(N'2015-09-30 13:43:30.010' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0794370c-8a1d-4109-8142-270eefe81811', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:48:48.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b0bd5e60-eac7-40d8-8799-2745e4e09743', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527115, 30.5910887, CAST(N'2015-09-30 07:28:01.637' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1ef4425a-f116-4c68-8bb7-2753209796a2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452675400000004, 30.5910611, CAST(N'2015-10-01 13:10:35.213' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e1f1e1a6-abd1-42b6-8cd2-27cbca0f3c68', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452651300000007, 30.5910128, CAST(N'2015-10-01 08:26:22.407' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e79c7f63-5347-4c23-ad2f-27d5b40a5c61', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526468, 30.590955100000002, CAST(N'2015-10-01 08:40:38.800' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'442be761-6700-4f79-a25a-2812006248dd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526744, 30.591122199999997, CAST(N'2015-09-30 11:22:57.530' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'01765b3e-e406-4f97-bbf0-28da670447ca', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430904834028809, 30.539640930398441, CAST(N'2015-10-05 17:08:15.647' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'04a2ca2d-c9c1-4cf4-805f-2a09f1f0bbf4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 12:38:16.757' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1b28f13c-b69c-4b0c-b56f-2a524b33a106', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 13:22:35.423' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'89cf4a45-e061-425e-ac5c-2a76bb979038', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452648599999996, 30.591032799999997, CAST(N'2015-10-01 08:58:53.320' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'97fe857f-4db0-4282-83a2-2acf5aba0d3e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527959, 30.591117299999993, CAST(N'2015-10-01 13:05:35.297' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0ff74157-2237-4b62-9235-2b399c322997', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 09:56:11.343' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'261fe88e-8a57-407e-b700-2b3d992ad3a9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4525464, 30.5910179, CAST(N'2015-10-01 09:54:46.203' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7de190ac-4408-4b5e-9bc7-2b7eac70095e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452670399999995, 30.591127600000004, CAST(N'2015-09-30 14:12:57.690' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dbbd32b8-a9d6-4c4c-8509-2ca375a22a38', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452675400000004, 30.5910611, CAST(N'2015-10-01 13:12:01.313' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'387dfb75-5d39-46ad-8ebc-2cd47df5280d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452868943149646, 30.591160766808866, CAST(N'2015-09-30 08:44:10.840' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ddc9a91d-d530-4456-a631-2d0a1bf8780e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:05:14.170' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fdfb6a3a-c0ea-4de1-b6d1-2d5e0f04567c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452651300000007, 30.5910128, CAST(N'2015-10-01 08:30:31.087' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'96786fc2-1bc3-4dac-a6a3-2dc9bc2af01e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527672, 30.5911656, CAST(N'2015-09-30 12:37:48.257' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5a698985-356f-4d40-a34d-2dd69264ec34', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527, 30.5911135, CAST(N'2015-09-30 13:12:29.720' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0f6be1f6-2048-40b8-b628-2df2f3733970', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430967897789145, 30.539528243421071, CAST(N'2015-10-01 19:41:18.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'474e57e3-19a5-4034-880f-2e0c9f5f137b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430991170529126, 30.53948296675825, CAST(N'2015-10-05 17:23:18.647' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f69a665d-4b10-41d5-99a5-2fed78c9dcdd', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.453325185737206, 30.592877320592439, CAST(N'2015-10-01 09:03:30.200' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5219e99d-d7b8-4b7a-8c37-30b31b5f32c5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527795, 30.591135799999996, CAST(N'2015-10-01 13:45:01.600' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e2d075be-c1b1-4117-a8ea-30b447342690', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527283, 30.591193299999997, CAST(N'2015-09-30 14:48:22.687' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'52f7e34c-77a6-45de-b517-30f740542cf1', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452648599999996, 30.591032799999997, CAST(N'2015-10-01 09:00:11.893' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c57d3e0c-f2eb-47fa-a894-31a1b495cab6', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452695299999995, 30.591120200000002, CAST(N'2015-10-01 13:53:58.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dbf5b8da-cfbc-47cf-9ecc-31bc9c04a848', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525636423518, 30.591200184440023, CAST(N'2015-09-30 09:48:05.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ddd3025c-bacb-47b8-961e-3230481ef6ad', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:50:21.380' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'70590d6f-c584-4731-a420-32be11d2211d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526468, 30.590955100000002, CAST(N'2015-10-01 08:40:38.120' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7aa019ae-4b7e-48ef-b514-330d3a4afabc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:16:17.343' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd6c97ac4-2a8a-4a14-bb0b-33261324f1d6', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.45263736876062, 30.591064319625978, CAST(N'2015-10-01 09:16:08.527' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd167e345-443d-4037-919e-33f136ee4d43', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526964, 30.5911046, CAST(N'2015-10-01 08:51:07.427' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'317cb701-b285-4823-b0f1-340ec2e25486', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 09:55:13.393' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9ceeda00-1743-4192-b279-34a981bdb584', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452623012078824, 30.591052959262456, CAST(N'2015-10-01 09:26:07.197' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c77eae9c-07e9-46fe-9ad7-34bd19d9c658', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:32:55.327' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3ccd8d51-878e-4e90-8f0d-34eff6add52b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.453421782577912, 30.59315901949569, CAST(N'2015-10-01 09:21:06.950' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4b8b020f-9d30-4a21-b945-35800dabe784', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:58.777' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a3d394c6-b7fc-4d91-86ab-35a71fa73a51', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452714799999995, 30.5912047, CAST(N'2015-09-30 13:52:28.747' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'896bb29d-a6b8-4791-910a-35ac67b8e855', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453754413596471, 30.59408514239577, CAST(N'2015-10-01 08:12:58.817' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bce94324-28e8-4461-a267-363a6f71a299', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526797, 30.5910609, CAST(N'2015-10-01 12:23:19.390' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'844bab46-be7a-45be-ba51-367253ce30d3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452579, 30.5910786, CAST(N'2015-09-30 07:27:00.400' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8b459b94-5627-49e4-b439-368d81349815', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452713599999996, 30.591092299999996, CAST(N'2015-10-01 07:48:58.807' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ed10ebc2-142d-490a-b65b-3771fe36ac97', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:48:09.007' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'eabeb2cd-7871-4f45-a9ac-37849a77b862', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526946, 30.591053499999997, CAST(N'2015-10-01 13:35:02.880' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9edef81b-900a-45a0-acd4-3837af843035', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452670399999995, 30.591127600000004, CAST(N'2015-09-30 14:07:39.543' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cb598a9c-1493-4c70-ba2b-389cd0e131c3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452848497069382, 30.5910544692573, CAST(N'2015-09-30 09:07:58.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bd0446d3-5b4b-4a1d-bf0d-38bd3ba0399d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:00:33.687' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'568f10a5-f87d-409d-aadc-38e1fa06e10f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525973, 30.5912944, CAST(N'2015-09-30 14:38:03.917' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5bd3df99-084b-439c-8136-3917eb5a8287', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452595099999996, 30.591306399999997, CAST(N'2015-09-30 08:12:56.537' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'42c0d68a-cba0-4767-abe0-3934cede60b0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525636423518, 30.591200184440023, CAST(N'2015-09-30 09:48:05.163' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'709d311b-092c-4133-8df5-39949c8c0cf5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430942247780806, 30.539525227293471, CAST(N'2015-10-01 19:36:18.363' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'10455a4c-4543-4a8e-af16-3a04770da754', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:56:10.587' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'30676038-9368-4efd-bba9-3ac399fffea0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526797, 30.5910609, CAST(N'2015-10-01 12:28:16.957' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'50535a2e-08b3-4041-adad-3ada3935e697', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527066, 30.5911103, CAST(N'2015-10-01 07:43:53.297' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'080cd2ee-2e27-40e2-88e5-3b03a5836b46', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527028557383, 30.591131597785829, CAST(N'2015-10-01 09:31:09.457' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'099347b5-3cc1-4f16-b024-3b8c7895d73a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527619, 30.5910993, CAST(N'2015-10-01 13:00:10.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'673de03c-2470-45b5-a139-3c0bf754cf75', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525845, 30.591199, CAST(N'2015-10-01 12:53:18.593' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7f5ec807-c3d5-4e7b-b7d1-3c19d47d208d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452739199999996, 30.591275600000003, CAST(N'2015-10-01 10:31:50.417' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1d26f4f2-4051-4704-b91e-3c5623d81b85', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452322717427307, 30.591475018427715, CAST(N'2015-09-30 10:43:17.007' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'03ceefc3-4fe9-4f67-a930-3cd01c346d41', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452723999999996, 30.591147999999997, CAST(N'2015-10-01 09:24:46.407' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c5033291-2256-47b5-8932-3df787704173', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452023999999994, 30.591892599999998, CAST(N'2015-09-30 08:56:24.657' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a8cb3d74-215d-4c87-bb68-3e20fd6472b9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452551799999995, 30.591058900000004, CAST(N'2015-09-30 07:35:30.727' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a64bbd71-7b05-4b9d-92b0-3e4597b6ebec', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452427582163658, 30.592887498639023, CAST(N'2015-10-01 08:47:43.950' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c5e0ab51-8d85-4c64-9aa9-3e5fa73e7b35', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452626514613421, 30.591060312180304, CAST(N'2015-10-01 07:30:43.680' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5e69416c-c47b-486f-a462-3e6eb20e55f0', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452770245409674, 30.590880656955083, CAST(N'2015-09-30 13:09:01.963' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'07bf9d31-0949-4961-86c6-3f06e549eefe', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4526639, 30.5911059, CAST(N'2015-10-01 09:44:42.707' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'40188bb3-0545-4b2b-8c42-3fd2b30a713c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.451996, 30.591947200000003, CAST(N'2015-09-30 10:33:04.577' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e29b2716-88e5-43a8-91a7-4106f558f123', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452330964726528, 30.591451032423759, CAST(N'2015-09-30 07:58:43.070' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5fa08fb6-a1de-459f-a5bb-414909252244', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 07:52:27.267' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0d5cccbb-f596-4868-8698-4185c2291c30', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:06:31.243' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0143bb93-4134-4c8d-af5d-4246ef231bf5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:21:30.737' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a59c47ba-209e-447e-9b99-42fe5b33dad1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:55:52.563' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'27f074df-ef8a-4453-9b7c-431355957476', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453616475243741, 30.593562268695695, CAST(N'2015-09-30 08:29:29.110' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'89ab9a04-a1b1-4637-ac46-43218402d7d3', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4526639, 30.5911059, CAST(N'2015-10-01 09:39:46.757' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'42e04343-fdb8-4de1-a26d-436bac6fb001', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:48:48.667' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0273755b-0d71-439f-9e29-436ffdca20c1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453754413596471, 30.59408514239577, CAST(N'2015-10-01 08:12:56.780' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f6ce1e9d-7d0f-4a33-83ac-438f1e6575de', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 14:32:37.940' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'24d8c1f6-b9a5-4004-801c-43bbc7062656', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4522744924552, 30.591553907676825, CAST(N'2015-09-30 07:50:18.147' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'371dd5ef-0abd-4a0c-b3c1-442687f9893c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:48:46.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c6ebdeeb-c0fa-4a48-ba93-4476a85bd046', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452330964726528, 30.591451032423759, CAST(N'2015-09-30 07:58:44.580' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e90c6493-5b87-4c4c-907a-4495a6492d7d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527028557383, 30.591131597785829, CAST(N'2015-10-01 09:31:09.070' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'338bffd2-3cc4-4356-acb4-450bed3085ec', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:48:08.043' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'18f68ac8-ab9d-4cbf-8c16-459ae4cb83d1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 13:50:03.013' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'de39d626-faaf-4766-87d7-45af3f9471ec', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4310034048043, 30.539508271925, CAST(N'2015-10-01 19:26:15.967' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'46dc8f47-a1d7-4fda-ab2b-45be693293c5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.451993099999996, 30.5919258, CAST(N'2015-09-30 12:03:11.880' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bd4bde34-22c3-44a1-988e-45eb70234982', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527115, 30.5910887, CAST(N'2015-09-30 07:23:04.180' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'113aebbc-e9d3-4a5c-9052-4607fc3bb670', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453754413596471, 30.59408514239577, CAST(N'2015-10-01 08:12:58.747' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'65aaf732-9e79-46b9-92ae-46666086a037', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452276980362257, 30.591562110555802, CAST(N'2015-09-30 07:52:33.600' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'65b35d94-35e2-4689-8fe9-467b1cff3d86', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452701499999996, 30.5911529, CAST(N'2015-10-01 12:48:14.857' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e33f3f95-c6c1-4ac7-968b-46a2fcd71e21', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452220999999994, 30.591734400000004, CAST(N'2015-09-30 12:50:51.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'118ec63c-1405-4e80-a9aa-46cfddffa92d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452654100000004, 30.5911272, CAST(N'2015-09-30 13:37:31.257' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'49080507-46f8-4f2d-a206-46e4e1b52f01', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452623012078824, 30.591052959262456, CAST(N'2015-10-01 09:21:07.190' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c6684013-8cf9-417c-a748-4705b3dee7eb', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452276980362257, 30.591562110555802, CAST(N'2015-09-30 07:52:37.587' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a4ed33d6-1a83-4f9d-8e54-47401280b15e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:28.280' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'79e0bd5f-6224-4708-85ad-477d3a6dad9a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:13:53.430' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8c38ea69-7d1e-4b0d-9b71-47f370cb742b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:56:36.170' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9d8536d2-e77e-4931-82e4-4805d42db022', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4528013, 30.5911097, CAST(N'2015-10-01 08:33:55.387' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f6f8cad0-0f28-407e-9296-48494fda55fa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526251, 30.591291199999997, CAST(N'2015-09-30 07:08:03.913' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ae6f0b45-e2c8-4e4d-8e99-4894c46c2e0b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527283, 30.591193299999997, CAST(N'2015-09-30 14:43:23.437' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'73ed0235-973e-4ddf-8301-48d36da270ed', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:43:25.610' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'19b061d0-d7b8-4d3f-8eed-48e93a756714', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452638, 30.591248399999994, CAST(N'2015-09-30 10:24:49.620' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7bf4374b-c442-49d8-b1f0-48f012e7c98f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452944770428424, 30.590775063554098, CAST(N'2015-09-30 13:04:00.967' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'143ff936-8193-4d83-b4ab-4913983a383f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452210674716426, 30.591623074101992, CAST(N'2015-09-30 08:55:40.707' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0d063f4b-c7fb-427c-9a60-4933766aa12c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452651300000007, 30.5910128, CAST(N'2015-10-01 08:29:18.890' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0690f18a-57e6-43d6-a3b5-4a445bd690af', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452234399999995, 30.591570999999995, CAST(N'2015-09-30 10:44:36.587' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b20a4c1c-2320-4b84-9a9e-4ab92d0f4aa5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452238820475877, 30.591637317009504, CAST(N'2015-09-30 12:23:54.940' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dcab6ea0-169b-4bca-bd74-4b1793480499', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:58:29.970' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3259f073-5daf-4c0b-9163-4b7bfc94f389', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452648599999996, 30.591032799999997, CAST(N'2015-10-01 08:59:16.033' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'50bb47e5-c76f-4634-aa6b-4b7e75100af3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 08:23:50.813' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'db7a74e9-7c87-400b-91d2-4c2aab4a934d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 09:29:47.880' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8efcfd66-726f-4fbd-8859-4c3b78e70657', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4307902, 30.539826200000004, CAST(N'2015-10-01 05:43:06.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0da1f841-c35a-4dc1-b944-4c815a41b289', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452455545717989, 30.59098060401142, CAST(N'2015-09-30 09:33:02.953' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4770ca41-05e3-44dd-8aa3-4ccec139b08d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:16:47.763' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7eaa5a6b-3128-4b0e-b7b3-4d0c8ced459e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 11:52:36.817' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ab1b1ee5-3ff4-4a88-8161-4e0ee67bbe6b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452739199999996, 30.591275600000003, CAST(N'2015-10-01 10:31:50.297' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'87d2eced-272e-4df8-a1f8-4eccbc5fc076', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526216, 30.5910807, CAST(N'2015-09-30 12:13:11.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bd0ceedf-91cf-418f-ae77-4ee378df1b97', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452690999999994, 30.591072299999993, CAST(N'2015-10-01 08:08:41.963' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'626e9d4e-e346-4f41-bd9d-4f193e9b1cf1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526744, 30.591122199999997, CAST(N'2015-09-30 11:27:53.403' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'13b64d32-c662-43b2-a7a4-4f4430806427', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 12:38:15.167' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'266836ee-2088-4adb-9624-4f65fd62c362', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4309677833285, 30.539557913656026, CAST(N'2015-10-06 19:04:58.827' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8eebf776-f5ea-4665-924c-4f6b97f9a7a2', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452276980362257, 30.591562110555802, CAST(N'2015-09-30 07:52:37.403' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b18ad54e-cf08-49ed-9291-4fc32500c0e7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452288846168749, 30.591555751978593, CAST(N'2015-09-30 10:08:10.643' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e6708529-8e3e-4f82-abfe-4fd6ee43d2e2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452334187489178, 30.591491124841248, CAST(N'2015-09-30 10:03:11.177' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ef5ee534-dfc5-46b4-82df-50e332d50ac8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:49:57.050' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'74ad2552-6d98-40b0-9e5b-51e803b88a30', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527085, 30.591070999999996, CAST(N'2015-10-01 13:30:02.147' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8c826d9f-1398-4fc0-848c-51fa97d79c1d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 07:57:24.013' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f352efca-7012-4475-87bf-527dbf7763c2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:43:07.467' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'373fc404-c6d3-49c8-9088-52c6052285d9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:15:21.093' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f53471aa-7fb2-4d3f-86d1-52dbdaf3a639', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526221, 30.591059, CAST(N'2015-09-30 14:02:38.430' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c5225fcb-19b0-48b5-8557-52e07133be88', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452694199999996, 30.5910712, CAST(N'2015-10-01 10:48:08.110' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'14d93517-4748-4f13-8022-5415059c4026', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452622695479185, 30.591043118824967, CAST(N'2015-10-01 08:17:58.787' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'03612e3f-550c-467f-b589-542400aeb585', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525845, 30.591199, CAST(N'2015-10-01 12:53:18.103' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'93664b57-1217-4c17-8cb5-5488e34b3124', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452595099999996, 30.591306399999997, CAST(N'2015-09-30 08:12:56.393' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e6fb490e-1c43-423e-8936-570188fba6ea', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:41.053' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'24c73996-ae2b-443d-91f4-5709bae1785b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-30 17:12:44.057' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'36011dad-d70f-408c-863b-571a65069601', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452427, 30.591490399999998, CAST(N'2015-09-30 11:54:29.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'aa28b53d-daab-4d3d-aabf-57556eb45102', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452718000000004, 30.5910408, CAST(N'2015-09-30 13:00:04.433' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fc297873-eade-4ff0-891e-57e2f86377f0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452252695888838, 30.591607795285935, CAST(N'2015-09-30 11:13:32.977' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'57286846-9a9d-4348-846b-57f18c23256f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:13:09.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5c819c90-274c-4323-a44b-57f7e7bff45f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526372, 30.5911194, CAST(N'2015-09-30 12:40:51.133' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f4986753-e121-4237-adf6-58813e12fb0c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452281600000006, 30.591283599999997, CAST(N'2015-09-30 10:59:33.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd4b3533f-a92c-463c-8029-58a1dba80ece', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452868607873519, 30.592093337355731, CAST(N'2015-09-30 13:14:02.130' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'79c0bac4-c8f9-4ecd-b8a8-58cff4dee9d6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.451996, 30.591947200000003, CAST(N'2015-09-30 10:33:02.027' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'997a557c-b177-4b7a-b878-590e9bee79a4', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:10:48.907' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'be70b7a1-39b4-4f7c-afeb-59d956455c68', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:58:31.287' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e5de8906-a350-4f47-b611-59ea8d882094', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:00:14.210' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'80bf0675-e872-4183-a719-5aac6713296a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430992301395506, 30.539520053791406, CAST(N'2015-10-05 17:33:16.833' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fe2e9e92-841c-420b-8caa-5b7c4df89e6a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430904834028809, 30.539640930398441, CAST(N'2015-10-05 17:08:16.567' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8940f3a2-7019-4eee-a80c-5c2a76906beb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527327, 30.5911269, CAST(N'2015-09-30 14:17:48.793' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1f978804-1355-4dd3-b9dd-5c468dcbaf44', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452817769453631, 30.591166010546083, CAST(N'2015-09-30 10:18:11.710' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c3e0d84e-878e-4b78-9aab-5c54fa6510cc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527474, 30.5911334, CAST(N'2015-09-30 08:41:13.773' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fbe09330-f993-44fb-891e-5c5f67230e2b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452276980362257, 30.591562110555802, CAST(N'2015-09-30 07:50:51.507' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'51550eea-098f-4c09-8d0c-5dbc74c7d53d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527012, 30.591200299999997, CAST(N'2015-10-01 07:08:53.717' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a8f28fe7-f062-404a-aa59-5dbedc79d781', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452880761633118, 30.590658774627922, CAST(N'2015-09-30 13:33:38.290' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd00a64ce-435c-4243-a250-5dd77401a956', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430943392059667, 30.53953199297419, CAST(N'2015-10-05 17:28:15.897' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3c1bdcde-ddd1-4b18-977a-5dea6c0cd4db', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:15:20.890' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e5e50e3e-0a2e-436a-9868-5e3ab54ed841', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527012, 30.591200299999997, CAST(N'2015-10-01 07:07:22.117' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'487df864-67e1-4fd9-8d40-5ed036ab409c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 07:52:28.037' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e9126c75-5826-4ed3-93ad-5ef7487529af', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:33:42.883' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ff5ffd45-4f0e-4269-86bb-5f406f72a22b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45276863613234, 30.591056571585565, CAST(N'2015-09-30 09:28:18.327' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd42612a2-22b0-42fd-aff7-5fa7a4f38729', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526885, 30.591048699999998, CAST(N'2015-10-01 13:21:00.980' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2f1a13b9-56fd-4083-a282-5fbbb95c96c9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452782994608548, 30.591489680848685, CAST(N'2015-09-30 12:53:58.010' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ae7f89ac-a706-4642-823d-600e054a57c8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452736500000007, 30.5912182, CAST(N'2015-10-01 07:38:53.387' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'26aba83f-e3eb-4963-9078-6073cedb44ed', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452624723509793, 30.591041421709548, CAST(N'2015-10-01 07:34:56.827' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'979c8f30-165a-4171-8cd3-616c72165f52', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452690999999994, 30.591072299999993, CAST(N'2015-10-01 08:03:41.157' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9a5f0d1e-d5f0-46d3-84e3-62203c8f3523', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452281600000006, 30.591283599999997, CAST(N'2015-09-30 10:54:34.207' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8e3cc84f-a7b7-41ca-84dd-62d1de0040cf', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4523758, 30.591455600000003, CAST(N'2015-09-30 13:32:29.930' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9b6692f6-89c3-4726-9ac0-63093a39337b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:12:11.920' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'88389d14-d2fc-4941-8f31-63f853b91ada', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4523635, 30.591345999999998, CAST(N'2015-09-30 09:08:13.127' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4b12c694-abdc-41aa-9d1b-6406d3efe9d1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527144, 30.5911506, CAST(N'2015-10-01 07:56:00.970' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'df713f03-5f78-4264-8c84-641a6ae20ee5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527672, 30.5911656, CAST(N'2015-09-30 12:34:16.707' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c9213d7c-8dde-4931-88ff-648d9fdfca50', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453682488891133, 30.594077124034936, CAST(N'2015-10-01 08:56:38.787' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b3d26fb6-29d4-47a8-acc5-64a5294e7020', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522583, 30.591568799999997, CAST(N'2015-09-30 13:17:30.130' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'76863858-a308-4649-9dd0-657978454c0a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527672, 30.5911656, CAST(N'2015-09-30 12:34:14.847' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f129ed2d-0c2e-416d-8ffc-664af53b5e68', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:57.410' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1d54006b-2472-473e-92a4-66ae54261675', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:53:46.720' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e3d8da0f-2b52-4c76-bd1f-67b28e13855a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527003, 30.5910665, CAST(N'2015-10-01 12:02:36.423' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fc179627-2979-4739-88d8-683362374908', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452399691434053, 30.591502939354672, CAST(N'2015-09-30 09:58:07.800' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'39da40db-d2f2-462f-91d1-6856e68a6785', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525539, 30.5910324, CAST(N'2015-09-30 10:24:39.707' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7afa9129-0f5c-4af3-83de-68775387f599', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452281600000006, 30.591283599999997, CAST(N'2015-09-30 10:54:34.390' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'311fb1c7-c3f6-4bfe-a5c4-6a2327950c4c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452427, 30.591490399999998, CAST(N'2015-09-30 11:54:29.693' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd832aea3-fc80-4b22-a333-6a84d7a7d1f5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452330964726528, 30.591451032423759, CAST(N'2015-09-30 07:58:44.623' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2c77ac3f-8730-4db9-84af-6c10b4eda258', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452023999999994, 30.591892599999998, CAST(N'2015-09-30 08:52:43.630' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6d9d2862-983f-4658-9b8d-6c9452ab1c80', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:39:25.290' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5f60c1a7-28c6-48cf-ad75-6daae98aa634', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 09:55:13.353' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e6476ff0-96b3-4b67-ba89-6dadb9c6aba7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453098579159615, 30.588428201502929, CAST(N'2015-10-01 08:07:48.523' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'21d18b65-47b2-427e-be62-6dd0db2f8622', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452621977252981, 30.5910565235111, CAST(N'2015-10-01 07:35:43.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9d2a1bab-a2a0-497c-8259-6dd3ae8b1850', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453295545564814, 30.593715726139941, CAST(N'2015-10-01 08:52:37.767' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c1238310-69cb-42d5-8cca-6f09a6addb6c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:49:25.400' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2d372f78-fa99-4c70-a837-6fae1d2d6e33', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452756, 30.5910741, CAST(N'2015-10-01 08:46:12.057' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2931b133-9dba-443c-b0bf-6fd76af6e24e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:54:33.957' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'385bd900-73f0-40a8-a3a6-7017a7ded8c8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452254324976032, 30.591668708465786, CAST(N'2015-09-30 12:48:58.033' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b83a413d-e9d8-4f0a-bb5a-70853741120f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:13:49.790' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'804e8030-035c-4232-957a-70a44d1b5628', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452614280386747, 30.590982803211475, CAST(N'2015-09-30 09:53:06.397' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ab6157c7-afca-4d89-acc2-70a6131fa00a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:56:42.743' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'529763e9-7fd3-4b3e-a265-7128ab9bfd5d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:04:27.720' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'14aefa1a-c3bd-4f8e-8eb9-7183c6f589b8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45252518754203, 30.591218167519575, CAST(N'2015-09-30 08:39:11.417' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fd41135f-3b6e-408a-928e-7199cd63727a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452736500000007, 30.5912182, CAST(N'2015-10-01 07:33:54.407' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'203d5b6d-70d2-4c9e-b7d9-71cf8178afb8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452051, 30.591866399999997, CAST(N'2015-09-30 12:28:09.443' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0d437ece-f5a4-48a9-b868-72b550b603c6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452775610657831, 30.591120449854611, CAST(N'2015-10-01 09:11:09.860' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c1813c3f-a9d5-4ca3-8dd8-72dcf06b0b1b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527672, 30.5911656, CAST(N'2015-09-30 12:36:11.017' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0fb0060d-8ae8-4424-8877-7307b66e2d5b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.453763813438734, 30.594095129906826, CAST(N'2015-09-30 13:23:26.547' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0d3628a4-34a4-4552-8ada-73203b01c5cc', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:58:12.337' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f77ffee8-a541-42d6-bb3d-73670d742192', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.453325185737206, 30.592877320592439, CAST(N'2015-10-01 09:03:30.140' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'91806ec7-9461-4e2a-9c65-73c0b7ebc59c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430951668502523, 30.539598067618456, CAST(N'2015-10-01 20:00:24.243' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6ad50768-5614-4ec6-afd3-73d1faecad86', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452775610657831, 30.591120449854611, CAST(N'2015-10-01 09:09:27.790' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9d53c196-7e06-4991-9da8-73ed9602e42b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452690999999994, 30.591072299999993, CAST(N'2015-10-01 08:00:09.807' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'213ea5f7-9257-4e4d-99aa-740f150e4072', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.430858, 30.539765900000003, CAST(N'2015-10-01 06:05:18.337' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'150a90b9-84a0-43c3-8c36-75071fa68bf5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527672, 30.5911656, CAST(N'2015-09-30 12:33:11.370' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4d9b8733-9b7c-4d2f-a5c7-75ac5fca0818', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452801000000008, 30.591070199999997, CAST(N'2015-10-01 12:43:16.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'27c65dbf-4830-4298-9ca5-7665aa387b53', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453002131591042, 30.591354221134065, CAST(N'2015-09-30 10:23:12.250' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0211801a-1d0d-4b42-9236-767587a222e0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452749399999995, 30.591220699999997, CAST(N'2015-10-01 11:57:36.733' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c6f48520-1a3e-4a98-8847-76adba1f7a8e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452638, 30.591248399999994, CAST(N'2015-09-30 10:28:40.280' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cc3112d4-cc4d-42d6-9e7e-76db8f5f9a94', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452695299999995, 30.591120200000002, CAST(N'2015-10-01 13:53:58.100' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ef97ad49-1d10-4907-8c10-7786b8538124', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:43:39.497' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'be8926ca-029b-4136-bdef-77ee9221f14d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525539, 30.5910324, CAST(N'2015-09-30 10:19:46.690' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd6179b01-db4e-4d17-b015-785911254610', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.431002411867318, 30.539506511015926, CAST(N'2015-10-07 18:17:24.190' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'096bc51e-8571-430f-ac93-78c85a18818f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527474, 30.5911334, CAST(N'2015-09-30 08:36:17.670' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ddb3e215-4f75-4233-a7e4-792319eed0f0', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452396790543993, 30.591903068153737, CAST(N'2015-09-30 12:58:59.020' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'33dba5b7-41b4-4197-b3bb-794cad22765f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:39:25.570' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0f1684d8-458c-4be7-8474-794f0a7c0b83', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452174235916473, 30.591659389938506, CAST(N'2015-09-30 08:49:10.797' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e0c72f15-6a5c-4218-a0c0-796814ab988c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.453325185737206, 30.592877320592439, CAST(N'2015-10-01 09:01:38.680' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'24c8f977-cdf8-4f86-818f-79a6acf9e2dd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 11:52:36.020' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9a4aae31-f50a-4ce0-8d58-79af175cfcf9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527397, 30.591091499999997, CAST(N'2015-10-01 08:21:11.537' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8ce2b4f0-d9f2-4962-abad-79ca3b6667c5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452626514613421, 30.591060312180304, CAST(N'2015-10-01 07:30:29.260' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd3e1d6ba-ddcc-4395-a953-7a2030098316', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:21:31.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0783e13f-9a44-402c-a0d1-7a83488026aa', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452084468260558, 30.591263230155217, CAST(N'2015-09-30 13:38:29.207' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'490d5824-f0dd-4860-9500-7aa7b7a62189', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526915, 30.591103900000004, CAST(N'2015-10-01 07:28:53.863' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'236a2e84-53e9-4086-ae03-7ba7723538bf', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:51:32.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e3d0eb44-f990-4ae3-9b0d-7bcee5551a0a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452701499999996, 30.5911529, CAST(N'2015-10-01 12:48:15.333' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f3836c1f-831c-4def-a11c-7c053a843995', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527619, 30.5910993, CAST(N'2015-10-01 13:00:10.257' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5db9aaf9-32b0-4094-b688-7ca02d907d49', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:40.457' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0c69956b-b16a-4136-83e9-7d0bd0b2ee40', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452675400000004, 30.5910611, CAST(N'2015-10-01 13:10:34.700' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd9cfdf4f-c073-46df-b15b-7e1f25eb8145', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:58.640' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c692c16a-8507-4014-b1f0-7e219295cce5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452276980362257, 30.591562110555802, CAST(N'2015-09-30 07:57:28.957' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'74bdb450-cb3c-44c4-a138-7e508afd02f2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526999, 30.590975699999998, CAST(N'2015-09-30 07:06:35.530' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'985c2c46-abc2-45da-8ee1-7e5e828b1382', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526932, 30.591086200000003, CAST(N'2015-09-30 11:39:25.977' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'20b7b79f-5341-4891-8af1-7e77590a379f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452822206155751, 30.591437410617715, CAST(N'2015-10-01 14:02:23.613' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'40c9844d-d699-4838-a095-7e88843f82f6', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452690999999994, 30.591072299999993, CAST(N'2015-10-01 08:08:41.833' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'27f865af-2b5b-491f-b4c8-7e91b5d2306f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.430858, 30.539765900000003, CAST(N'2015-10-01 06:05:18.283' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b3caaa87-852f-4209-a461-7f02f8e3c6ec', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522319, 30.591235299999997, CAST(N'2015-09-30 09:36:29.370' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b542706f-6072-4e13-a0e2-803959c7bdad', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527144, 30.5911506, CAST(N'2015-10-01 07:55:16.403' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a113cc3e-b464-4419-8ca5-8052d0c0b567', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527672, 30.5911656, CAST(N'2015-09-30 12:37:49.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b3cd8ff9-5574-486e-a8fa-809dd9aefefa', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452658674994694, 30.591170202019956, CAST(N'2015-09-30 08:28:49.367' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'efcfbe08-a9e7-4420-9f88-80db7813e00b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452717299999996, 30.591041500000003, CAST(N'2015-10-01 09:49:42.827' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd5aaaef1-b120-459d-959f-80e57b4bdc50', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:58:37.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ed1f4cb1-dca8-43be-a607-810712e7571f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526468, 30.590955100000002, CAST(N'2015-10-01 08:41:07.323' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'02f7e160-c2ef-48c7-9bb6-8168f9576e6d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:10:47.903' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'25841dcf-a292-4b1b-9000-82329c64b158', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452651300000007, 30.5910128, CAST(N'2015-10-01 08:26:02.700' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fb514b49-29ac-4de8-ad01-82c36bfb1bde', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527327, 30.5911269, CAST(N'2015-09-30 14:22:38.080' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bd66eb2e-fe91-41fa-8d37-83162c6956bb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452965588249711, 30.591909082234384, CAST(N'2015-09-30 08:34:30.387' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1dd2b791-1ab5-4069-850a-83290e47c201', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527335, 30.5910383, CAST(N'2015-10-01 07:18:54.540' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2fa4e42b-96c3-446f-ad04-83ddefaf7024', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527474, 30.5911334, CAST(N'2015-09-30 08:36:17.833' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ec2e3afc-2b89-4dd7-bdba-83fc567a6374', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526216, 30.5910807, CAST(N'2015-09-30 12:18:09.463' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'23c106d3-41bd-43c3-aeab-84e1c6213271', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:48:06.823' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b188f703-320b-48da-a49a-84f3eba32ec5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527, 30.5911135, CAST(N'2015-09-30 13:07:33.880' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3cb83318-3b16-4256-b183-8502a4eaf5e7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:37:42.277' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'41e6734a-268a-4668-919a-85f2d4ed8567', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 09:59:46.353' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b98b275e-bf71-4773-b13e-86193f13d1b7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526964, 30.5911046, CAST(N'2015-10-01 08:56:06.453' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b2655994-5e2f-4f7e-8b2a-86d799c67c27', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.43093773983734, 30.539682733538051, CAST(N'2015-10-07 18:28:14.500' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0a44cc35-a2d8-4e6e-855b-8705766fa7de', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452595099999996, 30.591306399999997, CAST(N'2015-09-30 08:13:51.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'96632ec2-c8d7-4e39-96a2-877416fd4666', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527115, 30.5910887, CAST(N'2015-09-30 07:23:04.240' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1c60cc75-2380-47c0-80ec-878dbd2b8255', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526436224764, 30.591101703013805, CAST(N'2015-09-30 10:13:10.120' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'48c7fb03-1560-4325-ae09-88230f8836da', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452624723509793, 30.591041421709548, CAST(N'2015-10-01 07:34:59.213' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8939080e-04bf-4503-8b6d-883a5f8adb9d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452474099999996, 30.591294200000004, CAST(N'2015-09-30 07:09:26.573' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b9470781-41f5-43f3-a270-8875882a3cfa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452848497069382, 30.5910544692573, CAST(N'2015-09-30 09:07:59.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'66143c13-9ebe-4bb6-bc7e-896598d2215c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:58:38.930' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'250a07db-656c-4ce7-ab7e-898ca9563be5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:44:27.857' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'922e89b5-5506-4056-9238-8991e892c896', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452651300000007, 30.5910128, CAST(N'2015-10-01 08:29:18.013' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5919ae15-0749-487c-adba-8a15b1b75140', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452623235869616, 30.591045281473203, CAST(N'2015-10-01 08:25:34.077' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'49106f8d-49ca-43f5-bce9-8a30f435bafd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 11:52:27.997' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fd5e7827-a704-4543-ad5d-8a350c61f93f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:05.263' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0ed8c18f-6348-4fe9-b3e5-8a91be496f6c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:55:52.630' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6ed0feb8-4410-4cdd-98de-8b208331f1fc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45266877855628, 30.591046472037871, CAST(N'2015-09-30 09:05:42.337' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1a963413-e580-43c5-a4d4-8b329de15f9a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452749399999995, 30.591220699999997, CAST(N'2015-10-01 12:02:35.957' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'62dc69d7-76d3-46a3-add8-8ba2748ba9b7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 14:27:39.173' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'df2f635e-1089-4c78-bf20-8ba7566d5cba', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452474099999996, 30.591294200000004, CAST(N'2015-09-30 07:09:33.140' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'aecd67fe-e33d-4afb-8780-8be8880a47a8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527086, 30.591071999999993, CAST(N'2015-10-01 09:14:48.880' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5db00223-64df-4b8d-a4db-8beeba360e4d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526251, 30.591291199999997, CAST(N'2015-09-30 07:08:03.873' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9c3a03b3-3da9-445b-adb6-8ca343d46f6a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526251, 30.591291199999997, CAST(N'2015-09-30 07:13:00.443' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2d51171e-24e0-4e1b-85c3-8d0aeb46f782', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452023999999994, 30.591892599999998, CAST(N'2015-09-30 08:56:25.470' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e978ed5b-39d0-4d2c-8ee4-8d79a9e5ba02', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527959, 30.591117299999993, CAST(N'2015-10-01 13:05:34.777' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'40e49118-79d4-43c9-934c-8df9a2c58163', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525845, 30.591199, CAST(N'2015-10-01 12:57:10.813' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6eb7b1f3-2c7c-45ce-8dec-8e0d31757e8a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526885, 30.591048699999998, CAST(N'2015-10-01 13:21:01.017' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'47c7c926-db5e-4651-88c9-8e37a403181c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45323964833608, 30.597011648598951, CAST(N'2015-09-30 09:12:58.503' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'23f04209-d11d-4745-82de-8e386bbfed3e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430911786135958, 30.539624870535043, CAST(N'2015-10-01 19:16:13.947' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9a0a68ed-fa6a-465d-a953-8e55047b3506', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452051, 30.591866399999997, CAST(N'2015-09-30 12:23:10.677' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0ff02ede-788c-4510-a233-8ead258c33d9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452675400000004, 30.5910611, CAST(N'2015-10-01 13:10:44.663' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7c53a985-4dd5-45fb-afa0-8ec951744f7b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452623012078824, 30.591052959262456, CAST(N'2015-10-01 09:26:08.140' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'682d0398-99a9-4572-9833-8f1781ee7969', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452654100000004, 30.5911272, CAST(N'2015-09-30 13:42:30.263' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b5975564-0f78-49ce-8d8c-8f63b753694d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527144, 30.5911506, CAST(N'2015-10-01 07:55:15.543' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9d03b20d-f457-4b3b-96e0-901a59c04bed', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4528013, 30.5911097, CAST(N'2015-10-01 08:35:28.560' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ba6a061a-ae5b-468e-a2ea-907085282986', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 17:12:55.347' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd46ef858-dd08-470c-ad62-90c3540a37c7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 09:56:13.723' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6328c92c-b459-4015-b318-90f9d6f23d62', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:15:26.967' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1df08b5e-595b-476a-a4f0-91441e62c71a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453754413596471, 30.59408514239577, CAST(N'2015-10-01 08:12:50.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'424ed108-21e1-4c2a-bcfd-91ac144018d8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452880761633118, 30.590658774627922, CAST(N'2015-09-30 13:33:28.937' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b13f3e2e-4194-4b20-954b-91c6302b29f3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 08:18:52.283' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b15235ae-bc6e-42cd-bfaf-91fc3b5f21ee', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452868607873519, 30.592093337355731, CAST(N'2015-09-30 13:14:02.877' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a79e215d-d464-45ab-be32-926c9d90c4c0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527283, 30.591193299999997, CAST(N'2015-09-30 14:43:23.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'653a918d-4556-4881-a3de-926ed87dc97f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527086, 30.591071999999993, CAST(N'2015-10-01 09:19:46.140' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'58cc358d-945a-4430-8dcb-927a888c04ad', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527003, 30.5910665, CAST(N'2015-10-01 12:08:09.797' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd281f3ba-1496-40a3-946e-92e82d45f483', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452503109911234, 30.590994276831896, CAST(N'2015-09-30 09:43:06.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e5f57200-32c4-4905-a24e-942d43ae136f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452718000000004, 30.5910408, CAST(N'2015-09-30 13:00:04.373' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3aabe849-b72c-458c-a09d-94a229e073f2', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-30 17:12:43.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b3b4d52e-2dde-46f2-a861-94bb716de3e1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525845, 30.591199, CAST(N'2015-10-01 12:57:09.840' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f11fc486-b7c9-4d15-aae0-9510d057b981', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:31.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7db26f33-529a-4e5f-8171-9546ae516815', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:12:55.050' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'09ed055e-2a4a-4b35-8914-9550ef4a3d3a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527283, 30.591193299999997, CAST(N'2015-09-30 14:48:22.117' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6596b8c3-a302-4204-8387-9563d54bb13a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452474099999996, 30.591294200000004, CAST(N'2015-09-30 07:09:35.720' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'27667b34-fcfa-4f99-917b-965e5fd23f70', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430932616823242, 30.53971705926585, CAST(N'2015-10-07 18:23:13.190' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f4f5a707-519b-4dae-9a7e-9796db84249d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452641734800338, 30.591078769933564, CAST(N'2015-10-01 09:46:12.137' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'971b53a4-52af-4e6d-92f3-97a7b813483b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4523635, 30.591345999999998, CAST(N'2015-09-30 09:13:10.227' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0ef716b5-4d28-42e3-b307-980e467e07f4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527619, 30.5910993, CAST(N'2015-10-01 13:05:09.633' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'57b8c3be-02d6-4514-92f2-984139a1ce14', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.431002411867318, 30.539506511015926, CAST(N'2015-10-07 18:18:18.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'66212796-89cb-4bed-99f7-98bbd7eeef3f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526999, 30.590975699999998, CAST(N'2015-09-30 07:06:23.083' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f5c2dcf2-efd1-45e3-ac06-9938c5eead4a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452648599999996, 30.591032799999997, CAST(N'2015-10-01 08:59:46.327' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f5526723-6a07-4267-be3a-9a23bba495b4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:33:44.500' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ebb98e79-22be-4eb4-ade2-9a46f5e3bfdb', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452084468260558, 30.591263230155217, CAST(N'2015-09-30 13:38:29.067' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'83e071e4-ba67-4fe1-a79a-9b376bb915c0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:33:21.077' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'008097f1-099d-48d7-94d3-9b4224077a92', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430982890769187, 30.539418041813757, CAST(N'2015-10-01 19:46:20.400' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f0e1189b-cccb-4844-a6a2-9c20091a2443', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430942247780806, 30.539525227293471, CAST(N'2015-10-01 19:36:18.863' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1a4663f7-cede-485f-add4-9ca0e42e986e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527672, 30.5911656, CAST(N'2015-09-30 12:36:10.717' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'05f17317-9d0c-4581-b6c1-9ce75a1f696c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452775610657831, 30.591120449854611, CAST(N'2015-10-01 09:11:11.160' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'88668a4b-975f-4dff-997b-9d0175566b58', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526946, 30.591053499999997, CAST(N'2015-10-01 13:40:02.823' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ae93a9cf-14bf-485d-bd7b-9d2e9e361931', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452621977252981, 30.5910565235111, CAST(N'2015-10-01 07:35:44.300' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0db24944-f63f-4f73-98f9-9d70a535fb6d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:12:12.077' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f087431d-73aa-4828-be8d-9eeb072a690e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522319, 30.591235299999997, CAST(N'2015-09-30 09:31:30.343' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9c7fd0a2-20f6-4517-b811-9f295ff4bc0f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527959, 30.591117299999993, CAST(N'2015-10-01 13:05:10.263' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'83ec4484-d7ea-4e73-9a1b-9f43f81ea2af', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452775610657831, 30.591120449854611, CAST(N'2015-10-01 09:11:11.080' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e6071539-8932-44ee-838a-9facbbbb62e7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452551799999995, 30.591058900000004, CAST(N'2015-09-30 07:35:30.773' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1696690a-e54e-4029-8ecd-9fe6e7fd24e9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452694199999996, 30.5910712, CAST(N'2015-10-01 10:43:08.787' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b34dfe27-b321-4da4-92fb-a06827604805', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:59:26.800' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'820ff86c-fa23-46ab-9cd1-a1013750c4b2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452648599999996, 30.591032799999997, CAST(N'2015-10-01 08:58:53.943' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b94f4ce2-8d62-465e-83d8-a131b9faec0f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:48:17.343' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2675c067-a6ab-48a8-b734-a1e92484e1bb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452782567637463, 30.59136084283757, CAST(N'2015-09-30 09:23:00.293' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a3c6f820-b134-45f4-b96f-a213cd739775', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452364372590445, 30.591092288605203, CAST(N'2015-10-01 14:00:24.197' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0a641bc2-f901-4a0f-97d1-a2919d5c5a49', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526812, 30.591028999999995, CAST(N'2015-09-30 13:57:29.853' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'775e5dc7-8f87-4230-9cc3-a29bdcb3aef3', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452690999999994, 30.591072299999993, CAST(N'2015-10-01 08:13:41.440' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b9a3c87b-c1c3-4ca1-b507-a2b4c4960182', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452770245409674, 30.590880656955083, CAST(N'2015-09-30 13:09:02.097' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd04f4b23-8452-4e01-8480-a36c803a4f37', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45210392684718, 30.591506855590819, CAST(N'2015-09-30 09:38:04.790' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0ee255a7-9f77-4af2-a82b-a3aafa77a56a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:49:21.313' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c10d0e1a-8465-4613-bb55-a42e28681eab', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453098579159615, 30.588428201502929, CAST(N'2015-10-01 08:12:01.670' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'acd64b08-8914-4ca1-8858-a5bd27baea1f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.45267150742044, 30.59117954227197, CAST(N'2015-09-30 13:28:26.883' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'342a575d-d57e-4eab-b212-a5cf032b5615', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:10:37.037' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7bcd9dcb-a3cd-4151-b1b3-a65d32c5ea5d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452579, 30.5910786, CAST(N'2015-09-30 07:27:00.337' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ffe8b66b-d513-4196-9281-a68ec0e402c4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452427582163658, 30.592887498639023, CAST(N'2015-10-01 08:52:36.703' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a041d79d-93e3-4d4a-ab96-a6ed9c686b92', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452364372590445, 30.591092288605203, CAST(N'2015-10-01 14:00:23.383' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'84ed8341-0a9b-4dd9-89b8-a70a2d4726f3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452736500000007, 30.5912182, CAST(N'2015-10-01 07:33:54.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c3bd99ed-4f27-4ea6-b56e-a7a0f7511101', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430972737384664, 30.539472785400616, CAST(N'2015-10-05 17:13:16.537' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'de759163-07bb-4da3-814e-a7c87dfa03fe', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452739199999996, 30.591275600000003, CAST(N'2015-10-01 10:27:06.983' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f89e2a2e-2259-44ac-abeb-a8361243359b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:34.170' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4ccb5c06-1bdd-4dc2-9ee3-a843f0d8cd53', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452330964726528, 30.591451032423759, CAST(N'2015-09-30 07:57:30.613' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'38608cf4-2900-4abb-8260-a865f72b9ca0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45252518754203, 30.591218167519575, CAST(N'2015-09-30 08:34:30.550' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd9c5c32c-6f5b-447a-a6e7-a881cde47029', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45252518754203, 30.591218167519575, CAST(N'2015-09-30 08:39:11.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f0f048f2-f0ec-4b4e-82e2-a8abf3a6bebc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453616475243741, 30.593562268695695, CAST(N'2015-09-30 08:29:30.463' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4135563f-6d74-47ab-bfbc-a8f752355f73', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430836302159548, 30.539518277533439, CAST(N'2015-10-06 18:59:59.873' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c337716a-e51f-48de-8f92-a97caedc7ed8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453682488891133, 30.594077124034936, CAST(N'2015-10-01 08:56:36.637' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'264a4f9f-1dc7-40f4-a942-a9c6686d7dba', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527672, 30.5911656, CAST(N'2015-09-30 12:33:11.493' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'82f14fe0-ebe3-4029-b4fb-a9d17ebaffc7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453682488891133, 30.594077124034936, CAST(N'2015-10-01 08:56:39.017' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c972a3b7-a32d-45c8-bcca-aa8b1c274de7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526812, 30.591028999999995, CAST(N'2015-09-30 13:57:28.643' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd32025a1-e158-498f-83c9-aa9d701d7faa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:43:26.043' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9922aadd-f3f6-4666-90f0-aad40091993b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430967897789145, 30.539528243421071, CAST(N'2015-10-01 19:41:19.847' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'42417754-6d21-4bd2-8db9-ab3222f82c78', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452276980362257, 30.591562110555802, CAST(N'2015-09-30 07:50:51.547' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'62e692b6-7690-42ae-bca5-ab65fed20a47', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452234399999995, 30.591570999999995, CAST(N'2015-09-30 10:44:36.290' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7034ab6f-2091-4f26-bc07-ab84cbc8a5ff', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 09:59:47.283' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b6225d1e-5273-42b9-a182-ab8dfc9c3dcc', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452944770428424, 30.590775063554098, CAST(N'2015-09-30 13:03:59.987' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd63d76db-1757-4711-b540-abcaf852ba4b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:49:47.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e4db8726-5c68-4289-b49e-abeddd654c2a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:58:38.460' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'77930b1f-511c-49dc-bf81-abf8e67274d0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 13:27:31.673' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2f809cd0-40dd-4ca1-9445-ac3f06b7b22f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452908920223116, 30.591414003082249, CAST(N'2015-10-01 09:36:13.197' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1a32e7ee-a7b9-44d0-bf1c-ac4657040b95', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:48:44.173' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'720509cb-f251-4cfa-ab61-ac7d36ae2ae1', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452717299999996, 30.591041500000003, CAST(N'2015-10-01 09:44:46.627' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd82ca10b-2206-4f90-a0b3-ac9ac7ee7c8d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:49:26.000' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'37a93568-2c4d-4ed0-a503-ad1811d04de7', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:41.743' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'df571d6a-87d0-4268-96f7-ad61ec54846c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:15:26.700' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ac251130-b05e-45be-9940-ada7fd0d50f1', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:58:45.417' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'040eb600-00ed-4cc5-8569-adafde39f9f1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:53:46.113' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2debb78b-38a3-497c-97c0-addf61fea928', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430932616823242, 30.53971705926585, CAST(N'2015-10-07 18:23:13.313' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4e1dc609-316c-4f7a-b877-adfab7be6fc1', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452655816122238, 30.591081115536614, CAST(N'2015-10-01 09:41:11.347' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cb31ea7e-b71c-4811-95e7-ae0584bd9890', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4523635, 30.591345999999998, CAST(N'2015-09-30 09:08:13.883' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c1c93073-9e51-4234-ad0f-ae11f66fa70a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526885, 30.591048699999998, CAST(N'2015-10-01 13:25:03.270' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6efe00b9-2a96-4a1a-980c-ae2393a4ec38', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452611399999995, 30.5909427, CAST(N'2015-10-01 08:13:47.167' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'87b16eed-6e6e-45fd-9eb4-aef1eb098d25', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430929494460052, 30.539637869509185, CAST(N'2015-10-01 19:51:20.407' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'aed69303-cffc-4edc-b13f-af098cb4ef95', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.45263736876062, 30.591064319625978, CAST(N'2015-10-01 09:16:07.107' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b58660d0-a9cc-4874-8621-afad3d61c92a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452579, 30.5910786, CAST(N'2015-09-30 07:31:57.017' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'90577d2b-5d3c-4704-a378-afb73655995c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452648599999996, 30.591032799999997, CAST(N'2015-10-01 08:56:07.773' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f8a8ad9b-a5f8-4a5d-bc3f-b10e461352c3', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:40.663' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f63ba275-1db3-40ec-bcde-b1974c054f8f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45252518754203, 30.591218167519575, CAST(N'2015-09-30 08:39:10.700' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ced6d400-b8ba-4af7-8a79-b1bac330fcd9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452775610657831, 30.591120449854611, CAST(N'2015-10-01 09:09:13.550' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6bc3511b-7c9a-4bc4-b010-b21686d93ccf', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:29.080' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c06d02a7-c19c-419b-8cff-b23d6778b026', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4523758, 30.591455600000003, CAST(N'2015-09-30 13:37:28.677' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ac0f0680-5af3-4800-b858-b2565820f187', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527012, 30.591200299999997, CAST(N'2015-10-01 07:07:27.923' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fa55d2bc-885b-4f50-9e2e-b2c154e25e28', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430836302159548, 30.539518277533439, CAST(N'2015-10-06 18:59:56.637' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4a9fec32-31d1-4a3d-879e-b30f63da63e4', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.431003815102805, 30.53950826867009, CAST(N'2015-10-01 19:21:14.377' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ae6534c5-9c19-4a0e-996f-b3143f325d66', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 13:45:02.960' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'591f7fbd-4dab-4d52-baeb-b3462af329d5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527259, 30.5910893, CAST(N'2015-10-01 09:14:42.690' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'841d8e51-81e9-4a2b-b464-b355fc28f66b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452234399999995, 30.591570999999995, CAST(N'2015-09-30 10:49:35.387' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ab4f1a05-74d8-4cfb-8a4f-b3f21ebedbf7', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430997699977276, 30.539459186204958, CAST(N'2015-10-07 18:13:16.157' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c750d5c7-0350-420a-89d2-b41d0fecec91', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452801000000008, 30.591070199999997, CAST(N'2015-10-01 12:43:16.153' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'baf0c153-760a-415b-b70c-b427df4b411c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526019, 30.5913018, CAST(N'2015-09-30 11:07:09.400' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e84ccc1f-1c8e-4360-a30d-b6264fb3095e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452908920223116, 30.591414003082249, CAST(N'2015-10-01 09:36:12.910' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c389ab1b-d1c9-456d-8565-b667ad07acf1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 49.839759, 24.0364057, CAST(N'2015-10-02 05:30:27.250' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'81332d4b-a56f-4d8c-b153-b69be5e5231a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526744, 30.591122199999997, CAST(N'2015-09-30 11:27:54.133' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a75cd8aa-ec48-4307-9dce-b6d5c41df374', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:58:13.283' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'eb8b1f7b-f7cf-4218-bd97-b7225cc93455', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452220999999994, 30.591734400000004, CAST(N'2015-09-30 12:50:52.197' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7db48aa5-c40b-4cae-8344-b7fb03eab0ec', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452690999999994, 30.591072299999993, CAST(N'2015-10-01 08:00:09.727' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'977d0ae9-68d6-4457-9a50-b8a9245366e1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452051, 30.591866399999997, CAST(N'2015-09-30 12:28:08.957' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6f52a879-3a1c-4f2e-ae2c-b8f364f98e60', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:37:42.367' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c2e84237-2300-48a1-bb4d-b91cba83513f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4525464, 30.5910179, CAST(N'2015-10-01 09:49:47.417' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2029103f-b1b3-4d48-888e-b9ab400f1e87', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453098579159615, 30.588428201502929, CAST(N'2015-10-01 08:12:43.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1fc92e31-e699-4899-9204-b9daa125a38d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526019, 30.5913018, CAST(N'2015-09-30 11:09:15.427' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bdb82460-81e8-4fd7-8bfb-ba59f5af2a0f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4528013, 30.5911097, CAST(N'2015-10-01 08:35:31.590' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7a92ba21-9a2b-4b24-86b9-ba7b303a42ba', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:49:13.423' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'17514f78-386f-42ed-807c-bb83d1fc7557', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452651300000007, 30.5910128, CAST(N'2015-10-01 08:30:29.443' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c8c5f322-a447-4f9f-97e0-bbf0efa48692', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452655816122238, 30.591081115536614, CAST(N'2015-10-01 09:41:10.427' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'de807829-21cb-4f80-a762-bc2a9e6ec205', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452763893201904, 30.59112053103382, CAST(N'2015-09-30 12:43:58.787' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'95e9be8d-5282-4ac0-b40f-bc95214ac890', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527, 30.5911135, CAST(N'2015-09-30 13:12:28.537' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4496b68f-0223-4cca-9c12-bd0818af482e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525539, 30.5910324, CAST(N'2015-09-30 10:24:39.037' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'043daa51-d90e-436d-9a79-bd23c0abec83', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4310034048043, 30.539508271925, CAST(N'2015-10-01 19:26:17.480' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a4ed6789-2998-42e5-887f-bd6a79e34c7b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:00:14.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'308a09b3-ef7a-436e-8c8e-bdb3787cd423', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452626514613421, 30.591060312180304, CAST(N'2015-10-01 07:30:43.810' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ef61bc85-d823-449e-a51f-bde29bb200f2', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452763893201904, 30.59112053103382, CAST(N'2015-09-30 12:43:58.640' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'188a7d1e-4bcd-47c8-9991-be826f900d3c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526019, 30.5913018, CAST(N'2015-09-30 11:07:10.230' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'61752c00-96d9-49cf-9377-beb4cc33eb7c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452670439289051, 30.591085713909592, CAST(N'2015-09-30 09:00:42.357' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'890c57cc-2820-468f-ab4d-bf21bb21684e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:51:23.420' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd2203701-d445-40c6-b63a-bf397ef92efe', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452775610657831, 30.591120449854611, CAST(N'2015-10-01 09:09:27.040' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'690cf2ed-b1d5-4e63-af37-bf852bdf4648', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452427, 30.591490399999998, CAST(N'2015-09-30 11:58:13.260' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'892a9dcc-73b2-4e79-b12f-c070efec5b41', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:02:54.380' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c688a3c4-a976-4329-b1cb-c0a95b3ad034', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452718000000004, 30.5910408, CAST(N'2015-09-30 13:03:05.717' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5ddf1f95-7e65-43bc-b6ca-c0bd7f2bfc48', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.453098579159615, 30.588428201502929, CAST(N'2015-10-01 08:07:48.603' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'57859de7-57ff-4081-936f-c1ccae4ff3c7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526915, 30.591103900000004, CAST(N'2015-10-01 07:28:54.003' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b7d4975c-16dd-43c5-be38-c1fb3641baa9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452672400000004, 30.591083800000003, CAST(N'2015-10-01 07:18:53.337' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'70af3274-5dac-4b7a-bf8c-c2085a18c32e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526372, 30.5911194, CAST(N'2015-09-30 12:40:51.077' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'495002f4-e469-4d9b-9583-c22fe57efc7a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:58:27.237' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'151d2c5e-554c-4c50-88df-c24e57f2d38b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522319, 30.591235299999997, CAST(N'2015-09-30 09:36:29.520' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9ac88a10-59a1-41d4-8fb6-c42896b80567', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45266955786991, 30.59098742892191, CAST(N'2015-09-30 10:33:14.187' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c07d91dd-9e32-4f4c-9051-c433303aadf8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452626514613421, 30.591060312180304, CAST(N'2015-10-01 07:30:30.673' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'74dd9652-8da4-4439-abd6-c44064c47939', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.43093773983734, 30.539682733538051, CAST(N'2015-10-07 18:28:14.173' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f5e74191-4cfe-4df7-ad1f-c4441b57afdd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4523635, 30.591345999999998, CAST(N'2015-09-30 09:13:10.583' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'69c21ca8-61b4-4948-b609-c46af7ca9225', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:16:30.633' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'81e95e78-0e84-4222-aa64-c4a759bee016', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452210674716426, 30.591623074101992, CAST(N'2015-09-30 08:55:40.630' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e02522f9-9ffb-47f8-b496-c62d9a32b827', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.43095695738495, 30.539572106884783, CAST(N'2015-10-01 20:00:24.777' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e0e96578-c13a-4947-89ba-c6716272efe9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527144, 30.5911506, CAST(N'2015-10-01 07:56:02.450' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'40438ed5-0d3c-4274-94a2-c69a7f7d0fa8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430982890769187, 30.539418041813757, CAST(N'2015-10-01 19:46:19.400' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'02cd2d90-3d0b-4b26-8306-c69fae875a0e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452624723509793, 30.591041421709548, CAST(N'2015-10-01 07:34:59.273' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ed2366b9-b60c-4cdf-b5dd-c70526a2fd9e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527066, 30.5911103, CAST(N'2015-10-01 07:43:53.707' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8778e644-52b3-43a9-8b7e-c75c3976a0e1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:32:55.820' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bbd7d05c-644c-40ed-9e67-c7a339ff6428', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452695299999995, 30.591120200000002, CAST(N'2015-10-01 13:58:55.837' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'65215aae-49aa-4d36-8c50-c7c4581ff239', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:49:46.627' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd3a243cb-edbb-428e-97c6-c7d49a6f79be', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:56:44.387' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'71fe0411-55c4-4661-98c3-c99f26911545', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4526639, 30.5911059, CAST(N'2015-10-01 09:39:43.957' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c07b0d50-bfa8-46da-90fc-c9db07a7c0c5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527144, 30.5911506, CAST(N'2015-10-01 07:53:54.873' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f7b2dcfd-cfa6-4c76-bb79-c9fa1ff0eca6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452651300000007, 30.5910128, CAST(N'2015-10-01 08:30:08.953' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b5b7ba40-38de-407e-8d1a-ca5de8ccd00f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527085, 30.591070999999996, CAST(N'2015-10-01 13:35:01.620' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'70a7c8b3-fbad-43cf-89d8-ca63f4c96307', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526216, 30.5910807, CAST(N'2015-09-30 12:13:10.687' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cb234f11-5fd3-4251-81aa-cb41bd79956a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4519945, 30.5919503, CAST(N'2015-09-30 10:10:30.207' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a72e7c78-0f0d-490c-8eec-cb64e57d2f1a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526744, 30.591122199999997, CAST(N'2015-09-30 11:22:57.150' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a0d0e07a-bf70-409a-8f75-cc32c55fe442', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452238820475877, 30.591637317009504, CAST(N'2015-09-30 12:23:56.803' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'186b6af3-58b7-41a6-a27d-cd34d7d0006a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452220999999994, 30.591734400000004, CAST(N'2015-09-30 12:55:49.550' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'020fbe44-efe1-47a4-bc22-cd6e6e635444', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527115, 30.5910887, CAST(N'2015-09-30 07:28:01.610' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4dfddad5-addd-4e53-a67c-cea81bd5e8ef', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4307902, 30.539826200000004, CAST(N'2015-10-01 05:38:12.167' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5593774c-bcdb-4e63-b205-cefde864b614', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:33:24.673' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'09e7772d-13aa-48cf-b34b-cf6d9e886fc7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:15:52.333' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'54b26cef-0657-4929-8e54-cfe8458d699c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430911786135958, 30.539624870535043, CAST(N'2015-10-01 19:16:13.373' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b566db1b-56fc-4306-ba0a-d044a37720ef', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452579, 30.5910786, CAST(N'2015-09-30 07:31:56.797' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a2b95b6c-e1ff-4f98-a56b-d076b3e889db', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 13:27:29.390' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'68ace438-621c-45ef-b101-d130b150b20e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430930465382552, 30.539515541968534, CAST(N'2015-10-05 17:03:22.053' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'036bd137-b7d5-4cdc-a0bb-d1d755e786b1', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.453325185737206, 30.592877320592439, CAST(N'2015-10-01 09:03:29.450' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5a102a46-52ae-4d8e-9921-d24fa0e6e8e0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452252695888838, 30.591607795285935, CAST(N'2015-09-30 11:13:33.063' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'08e2570a-ef59-4a8a-a98f-d2bf90a34749', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527035, 30.5911479, CAST(N'2015-10-01 09:09:43.940' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5718255b-689d-4f82-a847-d2c248b805a2', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:58:45.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'39c61be4-ae73-4edb-96b5-d2f872c5987d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452427, 30.591490399999998, CAST(N'2015-09-30 11:58:09.453' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5e6877fa-cd4c-4c79-807e-d30b3f043b6d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452628450488248, 30.591661276386759, CAST(N'2015-09-30 12:38:57.967' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'23796842-ca62-4309-b9a2-d37bb8c39f18', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527066, 30.5911103, CAST(N'2015-10-01 07:38:53.997' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1c85385a-2ace-4f8f-ba5e-d39a43441b54', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 11:51:57.977' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'59c5c68e-0d2a-46ab-9885-d510da25e57c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452713599999996, 30.591092299999996, CAST(N'2015-10-01 07:48:58.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fb335c26-8edc-42ad-ba65-d59ddb1444b9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452675400000004, 30.5910611, CAST(N'2015-10-01 13:10:45.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9457e11c-73f3-4b71-af82-d5f2e6baa4c4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527327, 30.5911269, CAST(N'2015-09-30 14:22:37.700' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9aab3ba4-3574-4cb2-873b-d62c93859d74', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452658674994694, 30.591170202019956, CAST(N'2015-09-30 08:28:49.473' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'360087bd-1773-4bd6-97a5-d640965f9c0c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45266877855628, 30.591046472037871, CAST(N'2015-09-30 09:05:42.240' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'90d54589-8c81-4efe-a8e3-d649dd2bb704', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4525973, 30.5912944, CAST(N'2015-09-30 14:38:24.100' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'42f9ee66-f686-4438-b5d9-d671e491db3e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430943392059667, 30.53953199297419, CAST(N'2015-10-05 17:28:14.943' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9fb32171-6374-4ab3-8921-d738a79d2bf0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 10:02:00.463' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c4598406-823b-4779-bec3-d7d645567ecd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522583, 30.591568799999997, CAST(N'2015-09-30 13:17:30.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2511e385-98fe-455c-a3d3-d7ef7ea27e24', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452723999999996, 30.591147999999997, CAST(N'2015-10-01 09:24:45.433' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4e263187-e795-43ea-8051-d89b5b6f4851', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452614280386747, 30.590982803211475, CAST(N'2015-09-30 09:53:06.207' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1e6c8069-b097-4e70-aba3-d90d8368fef8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527012, 30.591200299999997, CAST(N'2015-10-01 07:08:54.453' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3db1cdfb-7211-441b-959c-d9132cc8ba9e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 11:44:28.450' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'da9fd8b0-b378-4b91-80a6-da93d091a68b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452653570299645, 30.591104596836967, CAST(N'2015-09-30 10:28:13.457' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'64a574f7-1ae4-4a10-8b4f-da9d5f51d042', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4309677833285, 30.539557913656026, CAST(N'2015-10-06 19:04:57.230' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'11cf56d4-2fc6-451f-a526-db5c84a3aec3', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452598089869646, 30.591209781345224, CAST(N'2015-09-30 12:33:55.927' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'09b9be34-c5ca-4ff9-a84f-dbf45cc998c5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526468, 30.590955100000002, CAST(N'2015-10-01 08:41:08.743' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c62a405b-6b6a-45f4-a0e7-dc7c4b53ce38', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:58:02.513' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f039345d-6a8a-4638-ad71-dcd0f97784c5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 09:35:06.087' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd4601115-797f-4eb8-9db8-dce2192d8f47', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527795, 30.591135799999996, CAST(N'2015-10-01 13:40:04.250' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3fe61d5c-05f7-4ed3-bdc7-dce5fd9463de', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 10:02:00.443' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2e0e6326-1082-46fb-8d84-de12a286a5ab', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.431002411867318, 30.539506511015926, CAST(N'2015-10-07 18:18:16.517' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f789f0ac-cf97-4636-8372-de39802100bc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527085, 30.591070999999996, CAST(N'2015-10-01 13:30:02.547' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ea16f47b-779c-4948-af7d-df500c14372c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:04:26.717' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2d02cf44-03b2-4d31-b455-df83819af96c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452822206155751, 30.591437410617715, CAST(N'2015-10-01 14:02:22.937' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'77842c84-ae80-46b7-8704-dfb5e64a7d97', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 07:57:02.163' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fdfc9afd-aeb6-4f0f-86bf-e0e41116f0e6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452397686143335, 30.591457706419959, CAST(N'2015-09-30 10:38:15.593' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c59fd54e-c0ab-4883-a1a2-e1112e6dea8e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430997699977276, 30.539459186204958, CAST(N'2015-10-07 18:13:20.377' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ccd855c1-7809-409d-9fa0-e11e5c10da6d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526436224764, 30.591101703013805, CAST(N'2015-09-30 10:13:10.510' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bdff9a99-ce99-4673-93a6-e13484995538', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4525464, 30.5910179, CAST(N'2015-10-01 09:54:42.933' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3249823b-3006-45b0-b47c-e15d4e062e61', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452474099999996, 30.591294200000004, CAST(N'2015-09-30 07:09:26.627' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4c67d710-1252-4bca-bb89-e21a9d9675cd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452288846168749, 30.591555751978593, CAST(N'2015-09-30 10:08:09.137' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b953871c-018a-4765-9d02-e23dfd699b9b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526932, 30.591086200000003, CAST(N'2015-09-30 11:38:36.283' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f99aadec-45ec-44a2-82c8-e2ee8886ed8a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452281600000006, 30.591283599999997, CAST(N'2015-09-30 10:59:32.863' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e9b9f681-1bd7-4610-adea-e301764b6f69', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4522744924552, 30.591553907676825, CAST(N'2015-09-30 07:50:18.110' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a960b7c6-5526-43b9-bb50-e34dd4a11131', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526221, 30.591059, CAST(N'2015-09-30 14:02:38.030' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7fddd3b7-7a5d-4d44-861a-e3a7828535d6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4519945, 30.5919503, CAST(N'2015-09-30 10:05:46.837' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'648db7e8-d6fb-4dd5-a87b-e49b972e8ec7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452534253756006, 30.591318095131395, CAST(N'2015-10-01 08:17:58.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'40b618d2-0007-4ed2-9657-e4e6b5a7fc56', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526372, 30.5911194, CAST(N'2015-09-30 12:45:49.327' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'775c7338-d755-4848-8621-e5483bd33ff0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522319, 30.591235299999997, CAST(N'2015-09-30 09:31:30.423' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ad487322-2dcd-4a0a-a513-e58d601355ec', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:48:46.093' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a378e577-d4a2-4237-878c-e667f71bf7b9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526019, 30.5913018, CAST(N'2015-09-30 11:04:35.430' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9b10eb20-f4e8-43ee-878b-e6918481eb3f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.430858, 30.539765900000003, CAST(N'2015-10-01 06:05:45.107' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6f638a59-d777-4a09-ac02-e694202a1b39', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:06:47.567' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8c0f6794-33f5-4eac-acca-e71bce7c3ca1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527335, 30.5910383, CAST(N'2015-10-01 07:23:53.683' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'47ab901d-d3e2-4cf4-944f-e72839fe2f2d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4527335, 30.5910383, CAST(N'2015-10-01 07:23:53.273' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'79dfca20-d28b-4a37-b5b0-e832ce41bdc5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:26:28.933' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3af651b7-0138-4530-8c13-e85de312a443', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:33:11.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'19a2b657-f6ce-4c31-80b2-e8d01e7b5d06', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452491947061056, 30.591334445425126, CAST(N'2015-09-30 13:48:32.430' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'27997b42-258b-44f6-b1a3-e8e82c41290f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 12:28:18.200' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6c6d5aa9-a5a0-4f22-a63f-ea1b78a95c9c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452638, 30.591248399999994, CAST(N'2015-09-30 10:24:49.557' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'40545fe1-f0d3-47c9-991e-ea64018032f1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452714799999995, 30.5912047, CAST(N'2015-09-30 13:47:30.190' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9836d3d4-3f22-4055-ab49-eaebf3b58a2c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526797, 30.5910609, CAST(N'2015-10-01 12:23:20.767' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ed8568ec-bfb8-4888-a06e-eb2ae3073380', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.453682488891133, 30.594077124034936, CAST(N'2015-10-01 09:01:37.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'01f2594d-fbf6-428e-bb2d-ec47d6c067bd', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:48:08.297' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'886fc6b1-260d-48f3-badd-ec94eaae6242', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 10:13:20.500' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f7cd9fe6-25b5-4cfc-bdf4-ed1b2b9c9aaa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.451996, 30.591947200000003, CAST(N'2015-09-30 10:32:07.990' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'51e29954-a7fe-4ba5-87a9-ed85add0406c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526216, 30.5910807, CAST(N'2015-09-30 12:18:08.950' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6199844e-08c5-4576-9b4d-edadcf92a5f5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452628450488248, 30.591661276386759, CAST(N'2015-09-30 12:38:56.967' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2a7b075f-00ce-4d54-b6bc-edd8cf1a15c7', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430929494460052, 30.539637869509185, CAST(N'2015-10-01 19:51:20.333' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c6c82951-c9ec-4f4f-9a43-ee6378c730e3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:43:40.033' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'942a016a-e0f8-4608-a3c4-ee6bc90cde4c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:43:46.213' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6a5d057a-6b0e-4bdc-8cd2-eec9f4c1785a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 14:27:39.053' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bee4aa9b-29c8-40d0-b1d9-ef5ebb4c8ef2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4526812, 30.591028999999995, CAST(N'2015-09-30 13:52:31.937' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'46ecd212-a329-46a4-a1bf-f09f2b8c51ff', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:16:29.397' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'91b15b22-41ca-4806-8e72-f167ae0742f9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452595099999996, 30.591306399999997, CAST(N'2015-09-30 08:14:56.273' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e83b287b-de6a-44d7-8ba2-f1d5e4e3d249', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430942247780806, 30.539525227293471, CAST(N'2015-10-01 19:31:16.363' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'aa9b3054-b464-4383-b971-f1ec3d4b091e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:15:52.257' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6b5992bc-d155-4ff1-bf9c-f1f103a113df', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:58:03.013' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'338ee6be-56ef-4dd8-8175-f25fd92d325a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527035, 30.5911479, CAST(N'2015-10-01 09:04:46.440' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b2812e57-c828-43f1-b1ff-f38729afd540', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430991170529126, 30.53948296675825, CAST(N'2015-10-05 17:23:32.147' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'950e6d1b-b4d9-4cca-b43e-f3bf6a675b2e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4529871110254, 30.591019566048956, CAST(N'2015-09-30 13:43:29.850' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dd29e546-e173-4252-9278-f3e7dbe44298', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452718000000004, 30.5910408, CAST(N'2015-09-30 13:03:06.053' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9cf26ca3-a51e-4a32-b7e7-f400de9d61ee', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452598089869646, 30.591209781345224, CAST(N'2015-09-30 12:33:57.177' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'40cd1a82-b31b-4455-b939-f401b2e1366b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 09:56:12.143' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1a86be57-d583-40bb-8253-f4267db1f649', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430992301395506, 30.539520053791406, CAST(N'2015-10-05 17:33:15.943' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c769b898-81a5-404b-b4d5-f47a420d1235', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452713599999996, 30.591092299999996, CAST(N'2015-10-01 07:53:53.473' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'76595150-66e8-43aa-ac8b-f499ca003027', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 10:16:48.280' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3fd636aa-bd58-421d-a5f1-f5422dcf8917', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.451996, 30.591947200000003, CAST(N'2015-09-30 10:32:07.910' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'119c6179-0b8d-4481-bc62-f69ddca5e421', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452334187489178, 30.591491124841248, CAST(N'2015-09-30 10:03:08.087' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'22df84a4-2c08-4f23-9d03-f746f323b78e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4308255, 30.5398744, CAST(N'2015-09-27 17:05:10.957' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1d24d5ed-1c3a-4b09-ab70-f793321efe1d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.430933028043988, 30.539570706014214, CAST(N'2015-10-05 17:18:19.037' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c9b9931e-70a8-4492-9911-f83509885022', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.451993099999996, 30.5919258, CAST(N'2015-09-30 12:08:09.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'160ed051-aeab-4fb2-9908-f84174a2e743', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4526468, 30.590955100000002, CAST(N'2015-10-01 08:40:28.497' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8a6666e6-a660-4a82-8064-f862516c6b40', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4308255, 30.5398744, CAST(N'2015-09-27 17:10:05.757' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bc96ffd2-c733-42f7-a696-f8ed5ddb3cf7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-01 11:52:27.333' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'741dddc7-4ba4-44dc-8d2c-f95daced1aba', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452682454543989, 30.591025364227697, CAST(N'2015-10-01 07:49:47.533' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'52e6ba34-7139-495b-800a-f98a421d7422', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452648599999996, 30.591032799999997, CAST(N'2015-10-01 08:59:16.870' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd16799a1-a1b9-4520-9675-f9c0c0f4bd70', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527397, 30.591091499999997, CAST(N'2015-10-01 08:21:11.017' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b586ec10-5050-469c-b26f-fb59bd1f4087', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45270910778676, 30.591131647010013, CAST(N'2015-09-30 08:49:10.587' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6e9e3de8-b159-4618-96b0-fbdf34d3ca83', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452491947061056, 30.591334445425126, CAST(N'2015-09-30 13:48:31.247' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ecd17d27-73ac-402e-b847-fbf25e4e809b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4527144, 30.5911506, CAST(N'2015-10-01 07:56:37.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'96880d37-d292-4442-94d3-fc64cd0879fd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.45323964833608, 30.597011648598951, CAST(N'2015-09-30 09:12:58.433' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd3c9e49c-5283-4ce1-973f-fce17d8c51b5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:58:58.657' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'32beadb9-65a3-44df-81c3-fd2a79f2e9ce', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522583, 30.591568799999997, CAST(N'2015-09-30 13:22:29.520' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cd0877cf-f21e-4244-bf5a-fdd6421ab219', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 13:15:12.920' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'45392b6b-d78a-492f-a4f1-fdef0897aff5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4522566, 30.591535500000003, CAST(N'2015-09-30 09:43:47.073' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'76432730-0293-4c4e-be75-fe2bd11504c6', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.431003815102805, 30.53950826867009, CAST(N'2015-10-01 19:21:14.883' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'06f32983-fe4e-4696-b1d9-fe47fd49e390', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452427582163658, 30.592887498639023, CAST(N'2015-10-01 08:47:42.973' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1d88ff2d-7bb6-4ad8-8013-fecc90a4569b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.452476854244878, 30.591043210865557, CAST(N'2015-09-30 12:28:54.923' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd9d09a86-fbdd-4ff8-a539-ff354bf55aaf', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.452220999999994, 30.591734400000004, CAST(N'2015-09-30 12:55:49.363' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f0342ede-8315-4262-8010-ff5435ffc7a2', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.431002411867318, 30.539506511015926, CAST(N'2015-10-07 18:17:24.297' AS DateTime))
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'8b27f268-3f1e-43bd-bba5-2d622755b984', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-27 11:49:54.087' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'aee42328-4aa1-4ef2-ba2c-401b4548af43', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 05:38:00.927' AS DateTime), N'Forms', N'176.38.4.7', N'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'e2c85f88-c464-494f-be25-42601c2cf1ad', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 09:16:05.360' AS DateTime), N'Forms', N'37.73.211.71', N'Mozilla/5.0 (iPad; CPU OS 9_0_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/45.0.2454.89 Mobile/13A404 Safari/600.1.4', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'e4ebd425-5e12-4b45-892a-4516cc8aa922', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-09-30 08:26:20.207' AS DateTime), N'Forms', N'46.211.183.72', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Norway&trackname=2014-Norway')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'27070a7d-9f00-4746-96ea-4cd162b70753', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 14:00:16.983' AS DateTime), N'Forms', N'37.73.196.194', N'Mozilla/5.0 (iPad; CPU OS 9_0_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/45.0.2454.89 Mobile/13A404 Safari/600.1.4', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'f1435cd4-6cfd-43ea-8df1-54ca251b1301', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-27 13:02:53.047' AS DateTime), N'Forms', N'176.38.4.7', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'574ce05f-e667-4583-96fd-55b822e95f06', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 08:26:21.670' AS DateTime), N'Forms', N'37.73.211.71', N'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'b491b593-262f-45ee-a3ed-660992f66494', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 07:30:24.317' AS DateTime), N'Forms', N'37.73.211.71', N'Mozilla/5.0 (iPad; CPU OS 9_0_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/45.0.2454.89 Mobile/13A404 Safari/600.1.4', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'628e76f6-3df7-4b67-b9b7-6932d51dd0be', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-27 12:57:57.320' AS DateTime), N'Forms', N'176.38.4.7', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&trackname=2014-Germany')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'4b970ae1-f6e0-45fe-9a76-71fd95af747f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-30 12:23:54.220' AS DateTime), N'Forms', N'37.73.233.117', N'Mozilla/5.0 (iPad; CPU OS 9_0_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/45.0.2454.89 Mobile/13A404 Safari/600.1.4', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'0bbb74b5-0530-4f38-a737-734c111c5f29', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-09-30 07:06:21.007' AS DateTime), N'Forms', N'46.211.140.214', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&trackname=2014-Germany')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'54335f01-d500-4d52-9c25-802862cc008c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 06:00:20.277' AS DateTime), N'Forms', N'176.38.4.7', N'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3dUkraine-Ternopil&trackname=Ukraine-Ternopil')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'6ac7b60e-8bd2-4197-8208-847ba032111c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-09-30 17:12:54.967' AS DateTime), N'Forms', N'176.38.4.7', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'761a5551-eeb2-439a-a318-87d059edabe1', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-27 12:57:22.933' AS DateTime), N'Forms', N'80.255.6.50', N'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.99 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'7b67da73-2bf5-4b6b-ba74-8dd5049af4f2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 07:08:52.713' AS DateTime), N'Forms', N'37.73.211.71', N'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2015-CastlesLviv&trackname=2015-CastlesLviv')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'884e3b62-dabf-4273-acd7-99766dc40910', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-02 05:28:08.690' AS DateTime), N'Forms', N'194.44.139.126', N'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'9d86a862-99c4-451c-8b28-a1dce244a2b5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-27 17:05:03.800' AS DateTime), N'Forms', N'176.38.4.7', N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'332d4850-f830-472b-b5b5-b860bed55cee', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-27 12:57:22.147' AS DateTime), N'Forms', N'80.255.6.50', N'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.99 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2f')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'c9d02492-4ad2-44e0-ac07-bb79965b416e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 11:51:54.170' AS DateTime), N'Forms', N'37.73.196.194', N'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3dDeutschland-BadW%25C3%25B6rishofen-Hahntennjoch-%25C3%2596tz&trackname=Deutschland-BadWörishofen-Hahntennjoch-Ötz')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'4a46cce4-a58c-4e7a-87f8-dc4acc898676', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-27 13:11:36.833' AS DateTime), N'Forms', N'80.255.6.50', N'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.99 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'3e945f66-e8d3-4e30-aa85-e0d6fa2ebeb9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-27 14:00:30.323' AS DateTime), N'Forms', N'80.255.6.50', N'Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.99 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'9a74b7b3-04cf-46ef-bd6b-e18239d19ba2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 12:23:15.990' AS DateTime), N'Forms', N'37.73.196.194', N'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3dKoh%2520Samui&trackname=Koh+Samui')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'140e7671-23c0-4ce9-92b8-e59155bf3fdb', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 07:34:56.180' AS DateTime), N'Forms', N'37.73.211.71', N'Mozilla/5.0 (iPad; CPU OS 9_0_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/45.0.2454.89 Mobile/13A404 Safari/600.1.4', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'a1bc11e6-d313-4400-9251-e600f34576f9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 13:53:55.223' AS DateTime), N'Forms', N'37.73.196.194', N'Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Norway&trackname=2014-Norway')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'b46cd971-dabc-45d7-82c3-f2da256f60dc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-09-30 08:29:26.690' AS DateTime), N'Forms', N'46.211.183.72', N'Mozilla/5.0 (iPad; CPU OS 9_0_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/45.0.2454.89 Mobile/13A404 Safari/600.1.4', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2015-KopachivObukhiv&trackname=2015-KopachivObukhiv')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'a013e902-aff8-4a3c-a1ba-fe557f22ea70', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-30 07:49:31.587' AS DateTime), N'Forms', N'37.73.239.103', N'Mozilla/5.0 (iPad; CPU OS 9_0_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/45.0.2454.89 Mobile/13A404 Safari/600.1.4', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'97c7348f-17ee-4792-ad04-ff56f2af7b44', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 09:09:26.003' AS DateTime), N'Forms', N'37.73.211.71', N'Mozilla/5.0 (iPad; CPU OS 9_0_1 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) CriOS/45.0.2454.89 Mobile/13A404 Safari/600.1.4', N'http://x.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3dUkraine-Kharkov-Bohodukhiv-Poltava&trackname=Ukraine-Kharkov-Bohodukhiv-Poltava')
GO
ALTER TABLE [dbo].[ImageUser] ADD  CONSTRAINT [DF_ImageUser_ImageUserID]  DEFAULT (newid()) FOR [ImageUserID]
GO
ALTER TABLE [dbo].[Place] ADD  CONSTRAINT [DF_Place_PlaceID]  DEFAULT (newid()) FOR [PlaceID]
GO
ALTER TABLE [dbo].[Place] ADD  CONSTRAINT [DF_Place_Vicinity]  DEFAULT ('') FOR [Vicinity]
GO
ALTER TABLE [dbo].[Place] ADD  CONSTRAINT [DF_Place_Rating]  DEFAULT ((0)) FOR [Rating]
GO
ALTER TABLE [dbo].[Place] ADD  CONSTRAINT [DF_Place_IsPublic]  DEFAULT ((1)) FOR [IsPublic]
GO
ALTER TABLE [dbo].[PlaceImage] ADD  CONSTRAINT [DF_PlaceImage_PlaceImageID]  DEFAULT (newid()) FOR [PlaceImageID]
GO
ALTER TABLE [dbo].[PlaceTypePlace] ADD  CONSTRAINT [DF_PlaceTypePlace_PlaceTypePlaceID]  DEFAULT (newid()) FOR [PlaceTypePlaceID]
GO
ALTER TABLE [dbo].[PlaceUser] ADD  CONSTRAINT [DF_PlaceUser_PlaceUserID]  DEFAULT (newid()) FOR [PlaceUserID]
GO
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_Role_RoleID]  DEFAULT (newid()) FOR [RoleID]
GO
ALTER TABLE [dbo].[Track] ADD  CONSTRAINT [DF_Track_TrackID]  DEFAULT (newid()) FOR [TrackID]
GO
ALTER TABLE [dbo].[Track] ADD  CONSTRAINT [DF_Track_IsPublic]  DEFAULT ((1)) FOR [IsPublic]
GO
ALTER TABLE [dbo].[Track] ADD  CONSTRAINT [DF_Track_Description]  DEFAULT ('(EMPTY)') FOR [Description]
GO
ALTER TABLE [dbo].[TrackUser] ADD  CONSTRAINT [DF_TrackUser_TrackUserID]  DEFAULT (newid()) FOR [TrackUserID]
GO
ALTER TABLE [dbo].[UserRole] ADD  CONSTRAINT [DF_UserRole_UserRoleID]  DEFAULT (newid()) FOR [UserRoleID]
GO
ALTER TABLE [dbo].[ImageUser]  WITH CHECK ADD  CONSTRAINT [FK_ImageUser_Image] FOREIGN KEY([ImageID])
REFERENCES [dbo].[Image] ([ImageID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ImageUser] CHECK CONSTRAINT [FK_ImageUser_Image]
GO
ALTER TABLE [dbo].[ImageUser]  WITH CHECK ADD  CONSTRAINT [FK_ImageUser_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ImageUser] CHECK CONSTRAINT [FK_ImageUser_User]
GO
ALTER TABLE [dbo].[PlaceImage]  WITH CHECK ADD  CONSTRAINT [FK_PlaceImage_Image] FOREIGN KEY([ImageID])
REFERENCES [dbo].[Image] ([ImageID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlaceImage] CHECK CONSTRAINT [FK_PlaceImage_Image]
GO
ALTER TABLE [dbo].[PlaceImage]  WITH CHECK ADD  CONSTRAINT [FK_PlaceImage_Place] FOREIGN KEY([PlaceID])
REFERENCES [dbo].[Place] ([PlaceID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlaceImage] CHECK CONSTRAINT [FK_PlaceImage_Place]
GO
ALTER TABLE [dbo].[PlaceTypePlace]  WITH CHECK ADD  CONSTRAINT [FK_PlaceTypePlace_Place] FOREIGN KEY([PlaceID])
REFERENCES [dbo].[Place] ([PlaceID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlaceTypePlace] CHECK CONSTRAINT [FK_PlaceTypePlace_Place]
GO
ALTER TABLE [dbo].[PlaceTypePlace]  WITH CHECK ADD  CONSTRAINT [FK_PlaceTypePlace_PlaceType] FOREIGN KEY([PlaceTypeID])
REFERENCES [dbo].[PlaceType] ([PlaceTypeID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlaceTypePlace] CHECK CONSTRAINT [FK_PlaceTypePlace_PlaceType]
GO
ALTER TABLE [dbo].[PlaceUser]  WITH CHECK ADD  CONSTRAINT [FK_PlaceUser_Place] FOREIGN KEY([PlaceID])
REFERENCES [dbo].[Place] ([PlaceID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlaceUser] CHECK CONSTRAINT [FK_PlaceUser_Place]
GO
ALTER TABLE [dbo].[PlaceUser]  WITH CHECK ADD  CONSTRAINT [FK_PlaceUser_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlaceUser] CHECK CONSTRAINT [FK_PlaceUser_User]
GO
ALTER TABLE [dbo].[TrackUser]  WITH CHECK ADD  CONSTRAINT [FK_TrackUser_Track] FOREIGN KEY([TrackID])
REFERENCES [dbo].[Track] ([TrackID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TrackUser] CHECK CONSTRAINT [FK_TrackUser_Track]
GO
ALTER TABLE [dbo].[TrackUser]  WITH CHECK ADD  CONSTRAINT [FK_TrackUser_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TrackUser] CHECK CONSTRAINT [FK_TrackUser_User]
GO
ALTER TABLE [dbo].[UserLocation]  WITH CHECK ADD  CONSTRAINT [FK_UserLocation_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserLocation] CHECK CONSTRAINT [FK_UserLocation_User]
GO
ALTER TABLE [dbo].[UserLogin]  WITH CHECK ADD  CONSTRAINT [FK_UserLogin_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserLogin] CHECK CONSTRAINT [FK_UserLogin_User]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([RoleID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_Role]
GO
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[UserRole] CHECK CONSTRAINT [FK_UserRole_User]
GO
USE [master]
GO
ALTER DATABASE [seeyourtravel] SET  READ_WRITE 
GO
