USE [seeyourtravel]
GO
/****** Object:  User [SeeYourTravel]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  StoredProcedure [dbo].[GetFriendsLocations]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  Table [dbo].[Image]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ImageID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Image_ImageId]  DEFAULT (newid()),
	[FileName] [nvarchar](max) NOT NULL,
	[IsPublic] [bit] NOT NULL CONSTRAINT [DF_Image_IsPublic]  DEFAULT ((1)),
	[Lat] [float] NULL,
	[Lng] [float] NULL,
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Image_Description]  DEFAULT ('(EMPTY)'),
 CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImageUser]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageUser](
	[ImageUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_ImageUser_ImageUserID]  DEFAULT (newid()),
	[ImageID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ImageUser] PRIMARY KEY CLUSTERED 
(
	[ImageUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Place]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  Table [dbo].[PlaceImage]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  Table [dbo].[PlaceType]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  Table [dbo].[PlaceTypePlace]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  Table [dbo].[PlaceUser]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Role_RoleID]  DEFAULT (newid()),
	[RoleName] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Track]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Track](
	[TrackID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_Track_TrackID]  DEFAULT (newid()),
	[FileName] [nvarchar](max) NOT NULL,
	[IsPublic] [bit] NOT NULL CONSTRAINT [DF_Track_IsPublic]  DEFAULT ((1)),
	[Description] [nvarchar](max) NOT NULL CONSTRAINT [DF_Track_Description]  DEFAULT ('(EMPTY)'),
	[Category] [nvarchar](max) NOT NULL CONSTRAINT [DF_Track_Category]  DEFAULT (''),
	[ImageUrl] [nvarchar](max) NOT NULL CONSTRAINT [DF_Track_ImageUrl]  DEFAULT (''),
 CONSTRAINT [PK_Track] PRIMARY KEY CLUSTERED 
(
	[TrackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TrackUser]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackUser](
	[TrackUserID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_TrackUser_TrackUserID]  DEFAULT (newid()),
	[TrackID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_TrackUser] PRIMARY KEY CLUSTERED 
(
	[TrackUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  Table [dbo].[UserLocation]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  Table [dbo].[UserLogin]    Script Date: 10/18/2015 1:41:28 PM ******/
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
/****** Object:  Table [dbo].[UserRole]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRole](
	[UserRoleID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_UserRole_UserRoleID]  DEFAULT (newid()),
	[UserID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[UserRoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  UserDefinedFunction [dbo].[GetAllTracks]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetAllTracks] 
(	
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT DISTINCT t.* from track t 
	left join TrackUser tu on t.TrackID = tu.TrackID 
	left join [User] u on tu.UserID = u.UserID
	left join [UserRole] ur on u.UserID = ur.UserID
	left join [Role] r on ur.RoleID = r.RoleID
)

GO
/****** Object:  UserDefinedFunction [dbo].[GetTrackForUserByIdOrName]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetTrackForUserByIdOrName] 
(	
	@UserID uniqueidentifier,
	@TrackId uniqueidentifier = NULL,
	@Name nvarchar(250) = NULL
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT TOP 1 t.* from track t 
	left join TrackUser tu on t.TrackID = tu.TrackID
	left join [User] u on tu.UserID = u.UserID
	left join [UserRole] ur on u.UserID = ur.UserID
	left join [Role] r on ur.RoleID = r.RoleID
	WHERE (t.TrackID = @TrackId or t.FileName = @Name) 
	AND 
	(( @UserID = 'c9f148f7-923a-46b0-8b7c-bd4b54d90886' OR EXISTS(SELECT UserRoleID from UserRole WHERE RoleID = '5195a2d5-0b51-44c4-b672-7383482bc77a' and UserID=@UserID))
		OR t.IsPublic = 1 OR tu.UserID = @UserID)
)

GO
/****** Object:  UserDefinedFunction [dbo].[GetUserandPublicTracks]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetUserandPublicTracks] 
(	
	@UserID uniqueidentifier 
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT DISTINCT t.TrackID, t.IsPublic, t.Category, t.Description, t.FileName, t.ImageUrl from track t 
	left join TrackUser tu on t.TrackID = tu.TrackID 
	left join [User] u on tu.UserID = u.UserID
	left join [UserRole] ur on u.UserID = ur.UserID
	left join [Role] r on ur.RoleID = r.RoleID
	WHERE t.IsPublic = 1 
	OR 
	(@UserID = 'c9f148f7-923a-46b0-8b7c-bd4b54d90886' OR EXISTS(SELECT UserRoleID from UserRole WHERE RoleID = '5195a2d5-0b51-44c4-b672-7383482bc77a' and UserID=@UserID))
	OR
	tu.UserID = @UserID
)

GO
/****** Object:  UserDefinedFunction [dbo].[GetUserImages]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetUserImages] 
(	
	@UserID uniqueidentifier 
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT t.ImageID, t.FileName, t.IsPublic, t.Description, t.Lat, t.Lng, u.UserID as UserID from Image t 
	left join ImageUser tu on t.ImageID = tu.ImageID 
	left join [User] u on tu.UserID = u.UserID
	left join [UserRole] ur on u.UserID = ur.UserID
	left join [Role] r on ur.RoleID = r.RoleID
	WHERE tu.UserID = @UserID OR (@UserID = 'c9f148f7-923a-46b0-8b7c-bd4b54d90886' OR EXISTS(SELECT UserRoleID from UserRole WHERE RoleID = '5195a2d5-0b51-44c4-b672-7383482bc77a' and UserID=@UserID))
)


GO
/****** Object:  UserDefinedFunction [dbo].[GetUserTracks]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[GetUserTracks] 
(	
	@UserID uniqueidentifier 
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT t.TrackID, t.FileName, t.IsPublic, t.Description, t.Category, u.UserID as UserID from track t 
	left join TrackUser tu on t.TrackID = tu.TrackID 
	left join [User] u on tu.UserID = u.UserID
	left join [UserRole] ur on u.UserID = ur.UserID
	left join [Role] r on ur.RoleID = r.RoleID
	WHERE tu.UserID = @UserID OR (@UserID = 'c9f148f7-923a-46b0-8b7c-bd4b54d90886' OR EXISTS(SELECT UserRoleID from UserRole WHERE RoleID = '5195a2d5-0b51-44c4-b672-7383482bc77a' and UserID=@UserID))
)

GO
/****** Object:  UserDefinedFunction [dbo].[IsAdmin]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[IsAdmin] 
(
	@UserID uniqueidentifier
)
RETURNS table
AS
RETURN
	SELECT 
IIF(@UserID = 'c9f148f7-923a-46b0-8b7c-bd4b54d90886' OR EXISTS(SELECT UserRoleID from UserRole WHERE RoleID = '5195a2d5-0b51-44c4-b672-7383482bc77a' and UserID=@UserID),1,0)
	AS Result

GO
/****** Object:  UserDefinedFunction [dbo].[IsGuest]    Script Date: 10/18/2015 1:41:28 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[IsGuest] 
(
	@UserID uniqueidentifier
)
RETURNS table
AS
RETURN
	SELECT 
IIF(@UserID IS NULL OR @UserID = '00000000-0000-0000-0000-000000000000' OR @UserID = '4324d1ff-b698-44b6-bc2a-d96f42d2300b',1,0)
	AS Result


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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f1230d75-308f-4dcf-8e1a-013953ca7735', N'f1230d75-308f-4dcf-8e1a-013953ca7735.JPG', 1, 48, 10.680555555555555, N'iPhone 535.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e506662c-a84e-41b5-9c4b-022562d63ffc', N'5b5c4152-297a-4eee-9fa5-43021f47b2a6.JPG', 1, 54.03389, 10.875, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'102442ab-77a9-4946-94e1-02466a05f893', N'102442ab-77a9-4946-94e1-02466a05f893.JPG', 1, 48.135555555555555, 11.622222222222222, N'iPhone 572.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4859ee78-66d3-4035-ba42-053ddc16d946', N'4859ee78-66d3-4035-ba42-053ddc16d946.JPG', 1, 48, 10.680555555555555, N'iPhone 527.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bdc72e6e-2d3d-4582-b421-185b569bf6dc', N'bdc72e6e-2d3d-4582-b421-185b569bf6dc.JPG', 1, 48.135555555555555, 11.622222222222222, N'iPhone 569.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'36c36d0c-e69d-49e8-a1f2-18af9f6fed53', N'd7850536-66f0-4b43-a991-791d4741464c.JPG', 1, 47.44056, 11.30314, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5680cd9b-d493-4644-883b-18ea87010da5', N'5680cd9b-d493-4644-883b-18ea87010da5.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 555.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ebbab3aa-6cf8-4c9c-80e2-1c97b422e45c', N'ebbab3aa-6cf8-4c9c-80e2-1c97b422e45c.JPG', 1, 47.626944444444447, 10.855555555555554, N'iPhone 540.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd3c9bf59-f22d-434e-8470-24aed8bfe960', N'd3c9bf59-f22d-434e-8470-24aed8bfe960.JPG', 1, 48.135555555555555, 11.622222222222222, N'iPhone 568.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'455176a5-7da2-49b0-b420-24bcdd05f76c', N'eff93ab9-5174-4c4e-8f60-2dc1868cc89b.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5065fd28-4f7a-4ed4-83fa-24c9bb87bdf9', N'76a51428-83c5-41eb-a60a-22a4e1bf2829.JPG', 1, 49.98515, 25.04922, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2fd96ddb-ed7c-481d-a46b-24d1034c4372', N'2de7e025-0bf2-471f-8af4-f013da46f9ae.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'07628dda-18bf-48c7-8164-24e72fd1f6d8', N'07628dda-18bf-48c7-8164-24e72fd1f6d8.JPG', 1, 47.999722222222225, 10.194444444444445, N'iPhone 521.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'099412aa-f625-4dd9-a7fc-24e7f2809614', N'ac7a99ca-42f3-4922-a87b-f6ddf72dd5e0.JPG', 1, 42.26823, 42.78303, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'fe51dfbc-ea53-4fa0-9f4d-2523bf2fea07', N'468324e3-910e-4221-93bb-3b59f3abfc56.JPG', 1, 49.98481, 25.05058, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5ac1d156-368e-4a6c-919e-25325a0f4459', N'5ac1d156-368e-4a6c-919e-25325a0f4459.JPG', 1, 47.93194444444444, 10.83611111111111, N'iPhone 525.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'57702e61-3047-47bd-8a00-25333666790c', N'57702e61-3047-47bd-8a00-25333666790c.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 557.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'755248e3-daf9-4704-9d95-28c5e135c4c2', N'755248e3-daf9-4704-9d95-28c5e135c4c2.JPG', 1, 48, 10.680555555555555, N'iPhone 536.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd5c772f0-09fa-4360-a7d3-2fef89172068', N'd5c772f0-09fa-4360-a7d3-2fef89172068.JPG', 1, 47.999722222222225, 10.194444444444445, N'iPhone 520.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'17a52668-c76d-4d7f-b5f0-30271eb8637d', N'33106797-2f18-45ce-b485-fb1db3f37163.JPG', 1, 50.42361, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'274fd624-36c2-4b7b-8fde-309305ccfcda', N'3affabbe-66dc-43fb-a708-144914cb70fa.JPG', 1, 45.43903, 11.15208, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'84dd4ccc-5f41-40d0-9b91-30bb6a97f5fd', N'4153549e-ff9a-4c56-b2aa-95d0ae2a9992.JPG', 1, 60.86417, 7.136111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5bd8971e-b9fa-49d9-982b-314d265ae9e4', N'5bd8971e-b9fa-49d9-982b-314d265ae9e4.JPG', 1, 48, 10.680555555555555, N'iPhone 528.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c9962058-7e88-48c9-8b56-31f08341925a', N'10aa5822-e144-46f2-bce6-c68a77bf6be7.JPG', 1, 41.70675, 44.93995, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b5f65e92-2d93-4d07-998e-3202dc58bc32', N'7ed2f580-3e2d-4bfc-bb7b-c63d85a2058a.JPG', 1, 49.98515, 25.04922, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'78ee8165-429a-42ca-8c77-32ca02159b42', N'8b497e69-7466-4a3d-8cae-489a553ccf7d.JPG', 1, 50.4575, 30.58333, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c3b8f9c6-4264-4bb1-85ed-32fe0b529d0a', N'c3b8f9c6-4264-4bb1-85ed-32fe0b529d0a.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 563.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'87c15afe-5a24-47e9-bfb0-4337f863b34e', N'87c15afe-5a24-47e9-bfb0-4337f863b34e.JPG', 1, 47.423611111111107, 11.108333333333333, N'iPhone 546.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'185a1b97-6697-4b00-ae5b-4376a58a96c4', N'6c3023f6-29d7-482b-ba4e-90d1956556dd.JPG', 1, 53.99972, 10.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'28a6616b-c74b-4cc4-8918-43a3e65bcea5', N'4826b0a1-6d2b-4c3f-99c8-d909f3e7bfd6.JPG', 1, 49.54222, 25.68056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5f0f58b9-4f26-489d-a02e-43ef51c9cff4', N'5f0f58b9-4f26-489d-a02e-43ef51c9cff4.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 566.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ea79f42c-bcfb-483b-a1d6-446d0202b0b6', N'ea79f42c-bcfb-483b-a1d6-446d0202b0b6.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 564.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b08e79d6-5ca1-4926-9960-448f4bdf4c3e', N'871e391d-4bb4-44a6-884a-417d29451711.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd26490db-191a-4f76-9733-44b7cc627a13', N'6ac37751-3024-4da7-9bbe-3c55337de010.JPG', 1, 48.14962, 11.67122, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'694abb5a-8a92-492f-b527-45649e26c26f', N'c86ff9bf-4940-4c11-ad2c-7985369bb7fc.JPG', 1, 45.44496, 11.15889, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0bcc30d0-4fbf-452d-8a38-45665ba31d09', N'0bcc30d0-4fbf-452d-8a38-45665ba31d09.JPG', 1, 47.999722222222225, 10.194444444444445, N'iPhone 521.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3201c48d-3bc1-4f04-826d-45675486d1bc', N'6c26b1eb-c492-4a56-8ef5-1f8cdd867c00.JPG', 1, 47.43293, 9.436722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd6b11afc-d554-460a-aaf1-4596d2b3caf0', N'd6b11afc-d554-460a-aaf1-4596d2b3caf0.JPG', 1, 48, 10.680555555555555, N'iPhone 531.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a796eedf-bc25-4c63-aa75-4a4db95e2562', N'a796eedf-bc25-4c63-aa75-4a4db95e2562.JPG', 1, 48.135555555555555, 11.622222222222222, N'iPhone 573.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e8b17ba1-3300-474b-a5e3-4af2f252e5b2', N'7480225c-83cb-4ff8-b6d9-964a5ef6acf5.JPG', 1, 50.49495, 30.58061, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b9b749cc-dd23-4cd9-91ff-4b57da1d3530', N'9ea6cd10-3f5b-4b0e-b2e2-a05ecd3f7ef6.JPG', 1, 49.52528, 25.79722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4389fd13-7533-4d15-be9b-4c7b7ad695f8', N'efa0c7f4-ca3b-43e7-869d-97894b12f4d4.JPG', 1, 49.98413, 25.05117, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1cc9bd1c-d31f-4ad5-ac0f-4c8c51357e67', N'4ad252fd-f0d5-46be-9b5e-5a1fd66fbece.JPG', 1, 48.00328, 10.21253, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd2601525-0160-467b-a140-4cabd3e19970', N'd2601525-0160-467b-a140-4cabd3e19970.JPG', 1, 47.93194444444444, 10.83611111111111, N'iPhone 524.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8d6a200d-51c1-4f03-9276-532fef853c38', N'8d6a200d-51c1-4f03-9276-532fef853c38.JPG', 1, 48, 10.680555555555555, N'iPhone 534.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3c55adf0-6ca2-41d5-ac20-54e7cb46c437', N'10394ee6-1f73-4bb4-9fee-8640d9cafbd3.JPG', 1, 47.437, 11.30392, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'afda33ae-36d0-4e60-a6e9-56988324d6dc', N'c64779de-e720-4881-88c5-2cd6fe6dfc05.JPG', 1, 48.00616, 10.20981, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'cf3c4dd8-a969-4ca2-89f0-5699567b0624', N'cf3c4dd8-a969-4ca2-89f0-5699567b0624.JPG', 1, 47.999722222222225, 10.194444444444445, N'iPhone 520.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2bc1bb62-23ff-457d-ba48-56bee75dc414', N'f10d92e3-6ec1-4d80-bda9-a687933e9ad8.JPG', 1, 48.37413, 24.42933, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c36707cc-a418-4926-a34e-571b35346bb9', N'80aa2f04-2efa-422b-bdd5-f06250abd5a9.JPG', 1, 50.53714, 26.10111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'135a7771-2e59-43c1-918b-57a5b63d07b4', N'5cbd9478-8ded-4e43-9e1b-d16b2f88b3d3.JPG', 1, 47.49376, 11.20942, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd4d41a15-c83b-4bd5-b474-58c6e5654c72', N'715d6f95-2126-4473-81cb-533ac539b64a.JPG', 1, 50.44056, 30.62222, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'59190f21-b70c-4d8f-91e0-58cd1830bb0e', N'59190f21-b70c-4d8f-91e0-58cd1830bb0e.JPG', 1, 47.999722222222225, 10.213888888888889, N'iPhone 519.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'148f3161-4d6d-445d-b9af-595798ffc8ef', N'4f3fc90a-7e44-433c-8005-48d51b2f4056.JPG', 1, 50.75081, 25.37528, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'710b6390-e8d3-4411-981b-59aae4a99985', N'710b6390-e8d3-4411-981b-59aae4a99985.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 565.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'944dd93e-a8ad-455d-b762-5cd50c2832d4', N'944dd93e-a8ad-455d-b762-5cd50c2832d4.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 558.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c7fb6cee-02c3-4ba7-b3f8-62ae04f736db', N'c7fb6cee-02c3-4ba7-b3f8-62ae04f736db.JPG', 1, 47.999722222222225, 10.194444444444445, N'iPhone 523.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9fdf097b-5120-41cd-b265-6689621341da', N'9fdf097b-5120-41cd-b265-6689621341da.JPG', 1, 47.61, 11.194444444444445, N'iPhone 550.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'265a6704-040a-448f-80b2-73fa8373cf7f', N'265a6704-040a-448f-80b2-73fa8373cf7f.JPG', 1, 48, 10.7, N'iPhone 539.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'4f7b2b0a-d12c-4a82-934a-750c1e86fb83', N'4f7b2b0a-d12c-4a82-934a-750c1e86fb83.JPG', 1, 48, 10.680555555555555, N'iPhone 529.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'e57acb24-e1b7-4e88-a9c5-757c444886c1', N'62df93c1-b287-4cd4-a8ee-898898dda81f.JPG', 1, 41.70658, 44.94014, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'786139f9-97c8-4033-8163-75ed3e3175d0', N'f738b9ae-1a81-4268-baf6-b2166ed266f8.JPG', 1, 52.915, 12.83611, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0adf671c-c03c-4c14-b873-766dd02b498f', N'0adf671c-c03c-4c14-b873-766dd02b498f.JPG', 1, 47.423611111111107, 11.088888888888889, N'iPhone 541.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2e4cb840-8bfd-4f5f-9ebe-81be8c5554bb', N'2e4cb840-8bfd-4f5f-9ebe-81be8c5554bb.JPG', 1, 48.135555555555555, 11.622222222222222, N'iPhone 567.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'656031cc-8d4a-4cfe-a930-81d54a724d35', N'656031cc-8d4a-4cfe-a930-81d54a724d35.JPG', 1, 48.135555555555555, 11.622222222222222, N'iPhone 571.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'9eb0b6f6-4faa-4dfa-a572-8201db2468dd', N'3da63524-bea9-42b4-af4e-c1ae4e96a5af.JPG', 1, 41.70658, 44.94014, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'1eabdc59-863f-4e1c-ba16-822b6f657df9', N'8b41066d-ee45-4d3b-a682-f749537beaa4.JPG', 1, 50.09624, 25.85244, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'882ccc4c-8ad8-468c-b4d2-825f25b01cb4', N'093a2831-bc66-4b2e-97c5-31c213932b94.JPG', 1, 47.4331, 9.436722, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'73616ed9-7300-4883-b524-828f4094010c', N'6243561e-8920-423d-b84a-2c0e9d98d789.JPG', 1, 41.70726, 44.94092, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'a5e656dd-bceb-4c57-9b5b-82c4e53b043f', N'a5e656dd-bceb-4c57-9b5b-82c4e53b043f.JPG', 1, 47.423611111111107, 11.147222222222222, N'iPhone 544.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'be72f79d-b0aa-4345-bb14-82d7c8a6a025', N'be72f79d-b0aa-4345-bb14-82d7c8a6a025.JPG', 1, 48.406666666666666, 10.147222222222222, N'iPhone 574.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'bea15345-bad2-494c-a3dd-83cbf0d50543', N'bea15345-bad2-494c-a3dd-83cbf0d50543.JPG', 1, 47.406666666666666, 11.069444444444445, N'iPhone 548.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'35c5e0ad-5525-49d7-a7a8-91cd1c6f6561', N'35c5e0ad-5525-49d7-a7a8-91cd1c6f6561.JPG', 1, 47.999722222222225, 10.194444444444445, N'iPhone 523.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'72e18c83-f926-432d-839f-9365d391d7a0', N'72e18c83-f926-432d-839f-9365d391d7a0.JPG', 1, 48, 10.680555555555555, N'iPhone 533.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ae1284a8-a3c6-4562-a808-a109d9c2ab8e', N'ae1284a8-a3c6-4562-a808-a109d9c2ab8e.JPG', 1, 47.999722222222225, 10.194444444444445, N'iPhone 522.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ef43aa11-03e3-4218-a204-a2672cea1e8c', N'ef43aa11-03e3-4218-a204-a2672cea1e8c.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 556.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f009593b-200d-4ad4-ad39-a6736a902a41', N'f009593b-200d-4ad4-ad39-a6736a902a41.JPG', 1, 48, 10.680555555555555, N'iPhone 537.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7fb5e1bb-8e14-4f88-ac40-a6a31d1dc1b8', N'9136a999-c793-485b-b6e7-56562ad5ff71.JPG', 1, 48.37413, 24.42933, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'201e01b6-89a1-463d-bd2b-a6c84d228486', N'201e01b6-89a1-463d-bd2b-a6c84d228486.JPG', 1, 48, 10.680555555555555, N'iPhone 532.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'7efd4386-0108-423f-bf96-a8e4c42690de', N'7efd4386-0108-423f-bf96-a8e4c42690de.JPG', 1, 47.61, 11.194444444444445, N'iPhone 549.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'06b91040-b1df-4351-b8db-ab1c4874f437', N'06b91040-b1df-4351-b8db-ab1c4874f437.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 562.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'050d2f07-9b51-42a5-ac0e-ab561ea3e64c', N'050d2f07-9b51-42a5-ac0e-ab561ea3e64c.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 559.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'815693eb-85ea-4c5e-809a-aba1637182a7', N'0915b4e7-640a-4f1c-9ae7-8984f77e12c8.JPG', 1, 48.00881, 10.70019, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'c9da4766-0c87-4c1f-b93c-abb7b9445787', N'b1ab9a64-ec38-4198-a7d7-555494a31cb2.JPG', 1, 32.50834, 35.03056, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'3da1c8cf-227a-4ee5-bcc6-ad787626465e', N'392921d6-c06c-4370-b145-ae97126f7569.JPG', 1, 60.22028, 10.12778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8e000113-3951-42da-9c1c-ad8637994947', N'8e000113-3951-42da-9c1c-ad8637994947.JPG', 1, 47.423611111111107, 11.147222222222222, N'iPhone 543.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'eb79e777-c017-47d3-a992-b0408b0fc6b5', N'eb79e777-c017-47d3-a992-b0408b0fc6b5.JPG', 1, 47.999722222222225, 10.194444444444445, N'iPhone 522.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'20516b3e-1d5a-4c2f-a601-b0f5b963375a', N'20b531ca-64f7-4245-b660-0d6bec0b0559.JPG', 1, 47.40294, 11.31111, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5a286e8b-6393-4027-ab4a-b110fb020f12', N'5a286e8b-6393-4027-ab4a-b110fb020f12.JPG', 1, 47.643888888888888, 11.369444444444444, N'iPhone 553.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'832c2bda-3ec0-4e66-b2aa-b438210c499f', N'832c2bda-3ec0-4e66-b2aa-b438210c499f.JPG', 1, 48.118611111111115, 11.622222222222222, N'iPhone 560.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd3341f6f-3ce2-4fb2-b5a7-b7596dce16bd', N'd3341f6f-3ce2-4fb2-b5a7-b7596dce16bd.JPG', 1, 47.999722222222225, 10.213888888888889, N'iPhone 519.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'8c09f6ac-041b-4fb7-b85f-bdadb9f852ab', N'8c09f6ac-041b-4fb7-b85f-bdadb9f852ab.JPG', 1, 48.135555555555555, 11.622222222222222, N'iPhone 570.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'55fd9a51-afe8-4a8f-8c22-be5f9d68f984', N'0b136e66-9138-4a8a-a7af-4bd24e0ab4b9.JPG', 1, 60.16945, 9.777778, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'd9eda145-aa9a-4352-aa9d-be7daa7c5fe7', N'd9eda145-aa9a-4352-aa9d-be7daa7c5fe7.JPG', 1, 47.423611111111107, 11.108333333333333, N'iPhone 547.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'5a738e57-f48b-48da-9dfd-c18a1ae539cc', N'5a738e57-f48b-48da-9dfd-c18a1ae539cc.JPG', 1, 47.643888888888888, 11.369444444444444, N'iPhone 554.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'b3026192-e423-4e3c-8c69-c854cb2b4ec1', N'b3026192-e423-4e3c-8c69-c854cb2b4ec1.JPG', 1, 47.61, 11.194444444444445, N'iPhone 551.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'36e284d6-fe74-44af-bf50-cf574018cc7b', N'36e284d6-fe74-44af-bf50-cf574018cc7b.JPG', 1, 47.93194444444444, 10.83611111111111, N'iPhone 524.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'fa4eadd3-386f-4c74-a9c0-d696c701ffc8', N'fa4eadd3-386f-4c74-a9c0-d696c701ffc8.JPG', 1, 47.423611111111107, 11.147222222222222, N'iPhone 545.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'0a87d71e-2172-4e8b-9b7d-df7484bfcd36', N'0a87d71e-2172-4e8b-9b7d-df7484bfcd36.JPG', 1, 48, 10.680555555555555, N'iPhone 530.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'52dc9d47-f4c9-4adb-bc85-e572f815b52c', N'52dc9d47-f4c9-4adb-bc85-e572f815b52c.JPG', 1, 47.999722222222225, 10.252777777777778, N'iPhone 518.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'767c82a9-bb88-423e-89bc-e8a1276a4737', N'767c82a9-bb88-423e-89bc-e8a1276a4737.JPG', 1, 47.643888888888888, 11.369444444444444, N'iPhone 552.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'236d5373-ba46-42be-8ee5-ee9c229c4572', N'236d5373-ba46-42be-8ee5-ee9c229c4572.JPG', 1, 47.423611111111107, 11.147222222222222, N'iPhone 542.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'ab726970-fd25-489f-9602-f3adcd64d524', N'ab726970-fd25-489f-9602-f3adcd64d524.JPG', 1, 48, 10.680555555555555, N'iPhone 526.JPG')
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
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'f2a48508-dd29-41b0-bcd4-ff6d2458d373', N'f2a48508-dd29-41b0-bcd4-ff6d2458d373.JPG', 1, 48, 10.680555555555555, N'iPhone 538.JPG')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'2321f012-1b0a-4796-a65a-ff77daa08c86', N'8a0346e4-c12d-4c51-a302-cd3513009ced.JPG', 1, 13.76284, 100.5763, N'(EMPTY)')
GO
INSERT [dbo].[Image] ([ImageID], [FileName], [IsPublic], [Lat], [Lng], [Description]) VALUES (N'026b21dd-4397-448b-aede-ffe317b4c608', N'ef9a7849-6188-461a-b503-cc3ffefdbdcc.JPG', 1, 31.32195, 35.40833, N'(EMPTY)')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'18beef8a-9a61-484a-9842-0f6aab943416', N'5f0f58b9-4f26-489d-a02e-43ef51c9cff4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'24a6ea87-0f28-44b1-8fad-1189793aa12b', N'72e18c83-f926-432d-839f-9365d391d7a0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'de812146-ff7c-4f3c-85d8-1a803d53a33e', N'59190f21-b70c-4d8f-91e0-58cd1830bb0e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'43e758c2-4d4f-452b-905a-1b3a6e2e3918', N'd6b11afc-d554-460a-aaf1-4596d2b3caf0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'a280b8fe-0cde-4ada-98a9-1b78361b41cc', N'fa4eadd3-386f-4c74-a9c0-d696c701ffc8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'baddf5d3-d326-45fb-8009-1bbae53c06ba', N'8c09f6ac-041b-4fb7-b85f-bdadb9f852ab', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'aa2f4418-e864-4d66-8eb8-219a49d06343', N'a796eedf-bc25-4c63-aa75-4a4db95e2562', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'ded5c9af-cb6a-4a6c-afe1-284d47a6232a', N'bdc72e6e-2d3d-4582-b421-185b569bf6dc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'22dc3a26-b1ea-4b04-8686-2cff2b141985', N'4f7b2b0a-d12c-4a82-934a-750c1e86fb83', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'29c05d80-6f98-4531-aecb-302d09a4add7', N'f009593b-200d-4ad4-ad39-a6736a902a41', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'da0ae352-b2d7-41e0-a6fb-38751c1c5ad3', N'0bcc30d0-4fbf-452d-8a38-45665ba31d09', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'8e1a86a7-a250-488f-8f1e-3fdfd526218f', N'eb79e777-c017-47d3-a992-b0408b0fc6b5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'd95efeca-3270-4148-be25-4240eadfb621', N'236d5373-ba46-42be-8ee5-ee9c229c4572', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'cc3b6c9e-2404-45f4-b3af-431e3aac179a', N'36e284d6-fe74-44af-bf50-cf574018cc7b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'af27c4cb-0230-4b27-9d3c-44d6e4599a88', N'ae1284a8-a3c6-4562-a808-a109d9c2ab8e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'7ac798a5-3e0b-429b-b927-48d1ce312394', N'755248e3-daf9-4704-9d95-28c5e135c4c2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'a9454f5d-d999-40a1-a741-496269a33e43', N'ea79f42c-bcfb-483b-a1d6-446d0202b0b6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'0d6ef510-f999-407a-9d33-4c9dfa5f362e', N'4859ee78-66d3-4035-ba42-053ddc16d946', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'90c604b2-c734-47b5-8819-4eef833480e9', N'87c15afe-5a24-47e9-bfb0-4337f863b34e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'6261d7e9-7bcd-4954-8298-5b0e7a269fcc', N'be72f79d-b0aa-4345-bb14-82d7c8a6a025', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'767a2070-8b4f-4dec-b3be-5b31c5d3b7b7', N'ab726970-fd25-489f-9602-f3adcd64d524', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'53794b9f-a775-4e23-be28-66268cee3ab2', N'9fdf097b-5120-41cd-b265-6689621341da', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'8034307a-4d22-45f0-b258-6b3772083c5b', N'7efd4386-0108-423f-bf96-a8e4c42690de', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'dfd387d4-6d50-4a8f-aaf3-6ee85c8c136b', N'5680cd9b-d493-4644-883b-18ea87010da5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'f08e7520-3844-46fc-a09e-7ebaef1cce02', N'a5e656dd-bceb-4c57-9b5b-82c4e53b043f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'9084e012-fd89-4646-8940-81de10780800', N'832c2bda-3ec0-4e66-b2aa-b438210c499f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'68ddad0b-41ac-4106-b771-8578de47f6ec', N'0a87d71e-2172-4e8b-9b7d-df7484bfcd36', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'a039c72f-d8c9-47c4-ac8f-8752207b7566', N'd3c9bf59-f22d-434e-8470-24aed8bfe960', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'0efa8986-392b-471d-b893-918d7a953b17', N'ebbab3aa-6cf8-4c9c-80e2-1c97b422e45c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'02506c3a-570f-4c06-82ff-93c6acf38f99', N'52dc9d47-f4c9-4adb-bc85-e572f815b52c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'4f903ef4-87cb-4b29-9613-94476b275a35', N'710b6390-e8d3-4411-981b-59aae4a99985', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'95b8c9c2-0d0d-4ad8-91b9-9a8f6b6a9dcf', N'07628dda-18bf-48c7-8164-24e72fd1f6d8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'554d478c-d9c6-4be3-8610-9f2bf1e42e9c', N'656031cc-8d4a-4cfe-a930-81d54a724d35', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'3ed50eb7-89cf-493f-9cd5-a0d82f35c337', N'767c82a9-bb88-423e-89bc-e8a1276a4737', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'be663346-1eb3-4320-8597-a2643a7b0de2', N'35c5e0ad-5525-49d7-a7a8-91cd1c6f6561', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'c2cc6013-2496-442f-a375-a390a789f79e', N'b3026192-e423-4e3c-8c69-c854cb2b4ec1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'9acc9a56-9006-4d65-80df-a59e21a15287', N'265a6704-040a-448f-80b2-73fa8373cf7f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'1dc0a38f-f692-4759-acc8-aa1a16503100', N'5bd8971e-b9fa-49d9-982b-314d265ae9e4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'ed136f6f-0fb7-4048-8228-b1778724201e', N'050d2f07-9b51-42a5-ac0e-ab561ea3e64c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'e66e9e85-d67b-4a7b-b67a-b7632cd29b16', N'ef43aa11-03e3-4218-a204-a2672cea1e8c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'c3a8dc8f-9468-46d2-b573-b9b2e2a9efb6', N'5a738e57-f48b-48da-9dfd-c18a1ae539cc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'cd52df18-cd55-4848-b289-ba10389e2bd1', N'8d6a200d-51c1-4f03-9276-532fef853c38', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'394b7f4b-9eb2-4034-85b9-c18d55c99cfa', N'57702e61-3047-47bd-8a00-25333666790c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'1cb7f728-fe1e-40b5-838f-c18f483e40f8', N'201e01b6-89a1-463d-bd2b-a6c84d228486', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'66c0875d-6215-465d-811d-c2385f5551d0', N'd9eda145-aa9a-4352-aa9d-be7daa7c5fe7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'e1399058-ffaa-448e-892c-c3da754ac43a', N'2e4cb840-8bfd-4f5f-9ebe-81be8c5554bb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'c82687bd-6c11-4c5e-86d3-c440bda2bbfc', N'c7fb6cee-02c3-4ba7-b3f8-62ae04f736db', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'a70d42d9-fcb9-4acd-b403-c737c258085c', N'06b91040-b1df-4351-b8db-ab1c4874f437', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'd9d1c401-934f-402e-846d-ccf7c0b8afa4', N'5a286e8b-6393-4027-ab4a-b110fb020f12', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'40035efb-ff19-405c-8172-cdb2ced16cea', N'5ac1d156-368e-4a6c-919e-25325a0f4459', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'5c14de34-ac00-4ddd-97a6-d13bcbc8521a', N'bea15345-bad2-494c-a3dd-83cbf0d50543', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'038011ec-3d98-4465-9dfd-de160ed586e6', N'd3341f6f-3ce2-4fb2-b5a7-b7596dce16bd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'a6c35464-8187-40db-a30c-e7f17a78aea8', N'102442ab-77a9-4946-94e1-02466a05f893', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'a5bee437-cb58-4142-a0cb-ea2cc28c780a', N'0adf671c-c03c-4c14-b873-766dd02b498f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'37845de1-de68-492e-a532-ed76d8f72d83', N'8e000113-3951-42da-9c1c-ad8637994947', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'6807d335-2517-496e-90d3-ed96cb1c99f7', N'cf3c4dd8-a969-4ca2-89f0-5699567b0624', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'605882a9-5132-4c3e-9df2-ee3d25bf363a', N'd5c772f0-09fa-4360-a7d3-2fef89172068', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'db57af66-b13d-4745-bc1d-f0f2b2402bb1', N'f2a48508-dd29-41b0-bcd4-ff6d2458d373', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'4cbc973b-eeea-4993-b070-f580db8fd5c5', N'c3b8f9c6-4264-4bb1-85ed-32fe0b529d0a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'aabd86d1-6398-409a-9ae2-f58e5416998c', N'944dd93e-a8ad-455d-b762-5cd50c2832d4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'658eb88d-4c3c-40ed-9f19-f615ffdb6979', N'f1230d75-308f-4dcf-8e1a-013953ca7735', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[ImageUser] ([ImageUserID], [ImageID], [UserID]) VALUES (N'aca68b8e-b44b-4ddc-809d-f6cba192cdc8', N'd2601525-0160-467b-a140-4cabd3e19970', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
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
INSERT [dbo].[Role] ([RoleID], [RoleName]) VALUES (N'5195a2d5-0b51-44c4-b672-7383482bc77a', N'admin')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'655464e2-cccc-40a5-b29b-01b462228e3a', N'Deutschland-BadWörishofen-Hahntennjoch-Ötz', 1, N'Deutschland-BadWörishofen-Hahntennjoch-Ötz', N'Germany', N'germany.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'5c964e2e-44a4-46b1-ba1e-0f4ec4487a17', N'2015-LvivKyiv', 1, N'2015-LvivKyiv', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'aba6c759-7eef-4ffc-b969-148efafdfd99', N'Dreilaenderpunkt-Fahrrad-2', 1, N'Dreilaenderpunkt-Fahrrad-2', N'Germany', N'germany.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'ba26597f-3e71-46dc-acc4-211452b9d64c', N'Koh Samui', 1, N'Koh Samui', N'Other', N'')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'9388eb79-a4fc-4e04-9c99-2e08a80c6d64', N'Yacht-Greece', 1, N'Yacht-Greece', N'Europe', N'')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'2f0c30e6-dd4e-47b6-8c9a-363a2a2407ea', N'Ukraine-Lutsk', 1, N'Ukraine-Lutsk', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'cb813687-cef4-4c22-a87c-36405542eb14', N'Ukraine-Ternopil', 1, N'Ukraine-Ternopil', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'126db8e9-ef8c-4344-a070-36b1fd77e586', N'Ukraine-Kyiv-Pyrohovo', 1, N'Ukraine-Kyiv-Pyrohovo', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'4686cfc5-6d49-429b-b295-3e705e96709e', N'Ukraine-Kyiv-Pechersk', 1, N'Ukraine-Kyiv-Pechersk', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'd1a28ad1-21ff-4c07-b1ff-507b32b0a258', N'Switzerland', 1, N'Switzerland', N'Europe', N'')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'3060850c-2ae1-4920-88b6-53953b7e7e0f', N'2015-KopachivObukhiv', 1, N'2015-KopachivObukhiv', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'55ab5290-6f35-4cfd-95a6-57b7862c36da', N'Georgia', 1, N'Georgia', N'Other', N'')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'3fc881c8-0929-40d2-b51d-6f6a87a7a0b8', N'Israel-ToDeadSea', 1, N'Israel-ToDeadSea', N'Other', N'')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'576185d1-2cbd-44ff-986a-70981f01c1a1', N'Aachen-To-Koeln', 1, N'Aachen-To-Koeln', N'Germany', N'germany.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'9e9d00d5-d8b8-43df-a4bf-719790a0797d', N'Croatia-Split', 1, N'Croatia-Split', N'Europe', N'')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'8ef62335-0313-4bed-9744-8b39f6a35578', N'Barcelona-Andorra', 1, N'Barcelona-Andorra', N'Europe', N'')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'575e1042-4029-4d2b-b9c7-91b71ce558d0', N'Italy-Pompei-Vesuvius', 1, N'Italy-Pompei-Vesuvius', N'Europe', N'italy.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'301c54d9-f8c4-4e36-99ad-96946e0678c5', N'2014-Germany-NoSound', 1, N'2014-Germany-NoSound', N'Germany', N'germany.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'857f4492-1b96-438a-8e49-9ea0d643866b', N'857f4492-1b96-438a-8e49-9ea0d643866b', 0, N'Oktoberfest', N'Germany', N'SYTLogo-grey.png')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'ca63dd3d-0792-44de-9058-a0f00cfebe70', N'2015-CastlesLviv', 1, N'2015-CastlesLviv', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'08db857e-2311-4eca-a846-a361ea2c8f1c', N'Kyiv Minsk', 1, N'Kyiv Minsk', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'ca68f995-af71-49a6-87d8-b6dc0a00357f', N'Ukraine-Bukovyna', 1, N'Ukraine-Bukovyna', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'15f5ad22-344a-492e-a90b-bb9a80f05723', N'Dreilaenderpunkt-Fahrrad-1', 1, N'Dreilaenderpunkt-Fahrrad-1', N'Germany', N'germany.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'53ff70b3-5e38-4073-9326-cb535fa640ac', N'2014-Norway', 1, N'2014-Norway', N'Europe', N'norway.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'a4386205-c337-4376-bdf0-d497f32a79cf', N'bd3a2870-6f87-11e5-9d70-feff819cdc9f', 0, N't', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'39574bc3-c43b-4736-b122-dd9d69e3d31a', N'2014-Germany', 1, N'2014-Germany', N'Germany', N'germany.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'c3072912-da21-4530-8856-e448b9352a07', N'c3072912-da21-4530-8856-e448b9352a07', 0, N'Chornobyl', N'Other', N'')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'68aef307-d56e-4fc8-aea0-eae970fac6d4', N'Iceland-Akureyri-To-Reykiavik', 1, N'Iceland-Akureyri-To-Reykiavik', N'Europe', N'')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'6cea8444-adb5-45ce-ab2f-f34ada6f6062', N'Ukraine-Kharkov-Bohodukhiv-Poltava', 1, N'Ukraine-Kharkov-Bohodukhiv-Poltava', N'Ukraine', N'ukraine.jpg')
GO
INSERT [dbo].[Track] ([TrackID], [FileName], [IsPublic], [Description], [Category], [ImageUrl]) VALUES (N'314ac66f-b01a-4758-839f-fe0f1eb20d2e', N'314ac66f-b01a-4758-839f-fe0f1eb20d2e', 0, N'2015-Germany', N'Germany', N'germany.jpg')
GO
INSERT [dbo].[TrackUser] ([TrackUserID], [TrackID], [UserID]) VALUES (N'f9398c9a-d638-44ad-81f6-5230812b7377', N'a4386205-c337-4376-bdf0-d497f32a79cf', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[TrackUser] ([TrackUserID], [TrackID], [UserID]) VALUES (N'0e6bc9d0-8d46-4a57-9e7d-80fe8625b1da', N'c3072912-da21-4530-8856-e448b9352a07', N'3d70c1c0-e191-4837-9fa7-3398c928efaf')
GO
INSERT [dbo].[TrackUser] ([TrackUserID], [TrackID], [UserID]) VALUES (N'3ad6dfc1-90e1-4f67-98eb-8b5690c73196', N'857f4492-1b96-438a-8e49-9ea0d643866b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
GO
INSERT [dbo].[TrackUser] ([TrackUserID], [TrackID], [UserID]) VALUES (N'e1ab1f61-61ac-4602-9013-e3a66de48b7c', N'314ac66f-b01a-4758-839f-fe0f1eb20d2e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886')
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
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'272fca6f-f785-4ce0-b9fe-0060753bef5e', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:01:19.720' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e8fa3880-a66c-4f1c-a0a2-00b222718c65', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:04:59.737' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f7cffa41-c5cf-4514-a3b8-00deed565d21', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:27:05.633' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'465556d9-6688-4042-a961-00f845c863d7', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:24:30.167' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2e82e773-57ac-4164-8fad-0110569ca874', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:21:57.933' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ce2aeaf6-f931-42bb-bf86-01348f80e8fe', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:20:26.150' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1fd33301-6b74-4746-99c5-01eb70dd5e2f', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 15:54:41.050' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1d6ff6d2-5547-4888-8b4a-01f255ab72df', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:54:00.200' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4dceb276-d903-428b-8010-02d302536af1', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:19:21.440' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'744cd557-edf5-4eab-ba9f-02fed22f2f1b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:41:48.730' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2d83caa7-f1f9-46c5-ad17-03f435c240d0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 15:17:24.287' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f0dee516-89dc-4660-89fd-042bc45606f2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:11:01.177' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'590a9c96-3f3c-44f7-8c30-0467c1583ec2', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:01:20.237' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5ffc282d-4de3-4f63-b054-04c9a1db5e37', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:29:20.783' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'af945d77-5d3c-4d19-88ff-0524e272f862', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:10:50.983' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c0d39217-9240-49ae-9712-057f80a26418', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:44:30.820' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6bd1e7f3-6aec-4392-83df-05e6df865aa3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:00:07.030' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'21170528-69d9-49a9-9c0b-05f2f26e1ff9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:36:48.323' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'df349688-ef11-4d73-8d1a-06297e8bdbb5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 16:43:25.740' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'84e93d0c-7791-4dcc-a71b-06750ef644f6', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 15:53:20.703' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6a143c62-6311-423d-a5d6-069e879eb985', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:56:54.527' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5d91cc1a-e73a-4e43-962b-06f40f3d0d39', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:54:27.383' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'48c2444f-165e-408f-b0b1-0709b9e070c5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:32:49.233' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'68617484-04c1-4d32-a6fb-0725334da48a', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:26:49.087' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4b15cad5-4e16-4942-8a7f-07e25dac773e', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:15:58.333' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cc383985-18a5-452d-99f7-080cb9e91109', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:09:38.297' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a6851dca-b095-488a-af46-089053c95f21', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:42:22.730' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fb7aba7d-110c-4a5e-9dd5-08a6326ceb73', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:12:41.237' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4bfd84b4-ad7a-4b64-bafc-09201b425c77', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:10:57.227' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'36038674-106c-4e9f-8e2f-09518dcd8467', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 15:11:42.043' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'42db35e0-f1e1-45e7-9bef-0a0ca7170cff', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:32:33.837' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c1470151-7608-4594-b688-0a17712bd0c9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:04:58.583' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'75844f2e-a8f4-49ac-8ec8-0a509009897f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:32:01.167' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'012a6396-a7b4-4116-aede-0a699f062172', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:25:19.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5881b19f-d30a-433b-a59d-0abbc1613ee0', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 05:05:24.800' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ff05fbc3-241e-45ed-b922-0ade986ebbdc', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:27.937' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b62f33d7-5997-4dd8-91ac-0b738931a140', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:00:56.723' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'633e7703-5b69-4f53-b597-0baa63619581', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:34:20.003' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'25894850-a5c6-4154-8731-0be925c2ca77', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:18:30.717' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd8d8cdd3-5f31-46f4-a850-0c87dccc7791', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:54:09.737' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'adc2bb3c-3926-4a62-9aaf-0cf70b0cbe36', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:30:57.780' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ff9ff20c-5806-40be-9590-0d0bdd50ff2f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:08:24.987' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8dc23a09-371a-4948-9c64-0d26d153e980', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 15:12:08.623' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'604954a9-7d96-4be7-9a0f-0dcee87eefea', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:26:55.733' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a23e7f2c-4199-4bf7-b923-0df3a9fb6617', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:20:50.583' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4e686503-ee60-4fde-ad68-0e0ceb6a3db8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:42:24.057' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7845d553-1a73-4735-b126-0f488f3d649b', N'91097101-658d-44f9-a534-4484209c8179', 50.4501, 30.5234, CAST(N'2015-10-12 19:49:21.083' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b7d50058-4550-44d1-ab81-0f7b247b5427', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:59:22.977' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd5943b00-7675-45b5-9729-103606cd82eb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:51:55.143' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0db00dca-314d-4ea7-afb0-109248febb2e', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 16:21:47.957' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'db433ba4-f8d4-49f8-84ab-113c42ea308d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:19:44.303' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'335ac94c-16c0-45ad-9e67-1140ca4356b8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:41:26.153' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'59e5e4a2-080b-4dfe-b892-1141b7e1009c', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:07:27.217' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'660aaf25-265a-4da5-b66b-11785af78e50', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:19:01.740' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1aa193dc-1247-40c7-81eb-12345b51140c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:24:18.083' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'35509351-e327-4482-b612-12b400ec2218', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:04:10.190' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd5acc370-8108-4d3c-8068-1317350be8da', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:00:33.917' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'92caa596-4031-4e6a-a99b-133d56417e4f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:13:56.623' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1c279d51-43ab-4de2-8089-143b76ae1968', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:26:35.063' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'080664a9-41d7-4969-90bd-14ae2646bfbf', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:58:37.353' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'86fbc77a-0b31-48b7-8324-1560f155f10b', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:03.533' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f3ee75b5-9fa8-485b-87ce-156893913d9f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:19:28.983' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'88206f04-7380-4c42-880f-16396c41ecb5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:07:18.267' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'de4e4b97-4f68-4f7c-adc7-165b4c94a961', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:38:49.657' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'17c1088a-809b-4017-bbc6-16bf34784477', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:02:16.210' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8b6dabe4-dbef-4c65-9aa8-174e20c24fb7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:10:28.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a970ed69-39f0-4496-94e1-1763eac92d2a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:12:32.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3b653372-b1d4-43b2-8930-17a96bcdae2b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:00:27.713' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1ac7dfcb-0dd0-4710-a9d5-17fb665feb6d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 15:12:08.800' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b2eb8479-19a9-4b31-8e62-1801d14f5686', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:24:19.997' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'82ab260c-c444-4767-98f7-1844a70234e6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:23:09.593' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e4262362-7240-4d23-a6f5-185fc572053c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:33:21.397' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7b285f99-b829-4805-8f7e-189ff97b1992', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:55:31.247' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a6a610b8-c69f-4729-8482-18c16be47e68', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:18:25.087' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7ec3aa3f-4b1b-4265-a676-18feb32ad172', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:08:16.380' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'22e0a795-dfa8-4988-b5f8-1930cd714967', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:41:08.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b1edf553-2455-4d55-9d4c-1a28d04bdbd1', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:28:02.583' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dcf0f5a3-631d-4e32-bfe9-1b697989a19d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:48:28.837' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f9d1f3cb-39aa-4d98-a509-1c3462c537a8', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:29:21.107' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f08379c6-4b01-422e-8aef-1c6a9ac85a4d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:38:25.503' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7fa057eb-7af1-4a55-8d01-1c7deebf255f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:27.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bd96f3a0-dde9-4489-aea6-1ce2733c36e9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:33:20.383' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b164fd49-30eb-428c-bdf7-1d51b05f5448', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:50:39.460' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4a87ab56-0404-42be-8216-1d72cc32e273', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:32:16.610' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a512de3a-54cb-4085-b1a8-1e0f29bc0396', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 15:20:27.747' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c8031a04-3c5d-4da8-862d-1e76cb5a0629', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:13:12.077' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'47c37779-3b9e-42fb-aab1-1f04894d9b5f', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:54:19.993' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1448bfea-9c05-4988-ae97-1f851f0e31e1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 18:46:33.097' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4599687b-2bc0-4b0f-9ba2-1f8cebc085ca', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:15:01.207' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'71e9041a-c074-4817-9161-1f9c0e00b60c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:56:42.470' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ebeca7d9-5814-4894-a01e-200fd665e9c8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:14:16.827' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ca3d8fab-5519-446c-aabf-20df5da644fb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:19:58.140' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'86e30104-c7e1-436d-9059-20ff22a33a66', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:27:09.650' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd8dda4a4-e13f-4f05-8cf3-21abfb39a033', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:25:57.723' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'efa360a0-6f6e-46df-906e-21dea1991e27', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:30:57.283' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'798b64c9-4e56-4a9b-9706-21df06d8f710', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:12:54.520' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'95053b1c-307a-4324-83f5-22159d6c4faf', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:11:00.670' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4097ae29-f58e-48e8-bff0-22838d329fb7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:00:43.973' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'826b335a-282e-4c0c-9f68-228afa24a22c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:32:33.057' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ad0382b5-a068-4764-8dcf-23e4bc0e67a2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:54:03.527' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'56ddc67b-b493-45e3-af3b-23fc5398b0b3', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:21:57.303' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c17cd397-2e08-440d-9d47-240276dd406e', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:18:30.800' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ef060c54-9ace-4534-b60b-24160c3b3b34', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 09:59:53.773' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4bdba6d6-4905-44b3-8e0e-2467b6545319', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:37:43.393' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'51519e35-ed12-4f25-bcd5-25a90541726c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:04:54.823' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'436dc14e-6322-4cc2-a2da-277d3820cb22', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:40:57.757' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e1a8ed1e-12d5-4095-9a95-27814fe851a4', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:15:00.937' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd81d0a93-906b-42a8-8a69-27f97d3ef0ff', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:29:22.463' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ff1d5ebc-cc29-4651-9d0f-281394bafafd', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:21:57.543' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'74d711ca-f43f-4a9c-9af2-284a1a14bf10', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:31:45.903' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3155651e-4d92-4412-b709-29fd57429204', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:10:51.170' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cbd55519-b15e-4aad-a848-2a43ff9460fc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:06:21.293' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7c06f54a-ce26-4377-a310-2b1c09427cca', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:34:16.877' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'694d8108-75b3-4a73-adb0-2bc61558ac99', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 15:25:27.817' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dc2373b7-a33d-4326-ae01-2ce7e63a996a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:15:09.947' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'656c6513-d5da-4f90-8fe8-2d08a2d0ce69', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:41:54.637' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'467a453e-3657-41db-b9da-2d1006564b74', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:00:39.003' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'81af726e-bda7-49e1-9a81-2d59d37cd460', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:28:35.877' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c9c30c60-c1ee-40ea-94b1-2e057669eae4', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:01:12.570' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e9081413-710f-42d8-b269-2e7549ad36c4', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:25:05.840' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e3358060-a1d1-4b91-845f-2e8c12145b26', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:44:36.677' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3ef20a54-afe8-45ff-b973-2eaebec0e749', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:28:45.403' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f3df379d-3490-4b7e-b872-2f2e03c5166d', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:20:57.263' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a089c15c-b65b-42c5-a6c6-2fc3e4e1c529', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:51.550' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c6f5255e-44b6-4180-b2bc-2fcf99436a93', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:56:43.623' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cb0a5e46-af2b-43c5-b468-30320dcc9b17', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:13:53.227' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'681b1d9e-cb3f-4b36-8325-3057897ba0e1', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:53:37.130' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7cd0d8af-9699-4440-abc7-306aba5f085c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:01:33.833' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd340aea8-85fe-4c3c-9848-3099d99ded44', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:41:25.570' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bd89a74f-2394-491a-8de7-30d6c17daf4d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:22:41.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8e22d45b-8509-465c-8161-30e5b975e857', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:32:47.667' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f9e82a9a-932b-42cc-9c43-31d78cddfbd7', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:24:29.640' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f57b5901-6cd6-497c-9481-31e8d8e8bbf7', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 05:00:24.830' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e5247060-69eb-4bd5-b116-321f852a095a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-16 17:57:56.123' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ddd3025c-bacb-47b8-961e-3230481ef6ad', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:50:21.380' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b94a6982-94d8-456d-b0d7-32c0b93f24cd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:08:25.303' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9a00133c-7ded-4986-a262-334b20180710', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:33:31.627' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b9bcb81d-3a88-4aa5-9106-33aa78bd2645', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:37:17.567' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0a60d725-65d1-4100-bac6-34a5cdf9b222', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:28:52.197' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2ce23abe-8d16-482e-acee-356533059efc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:43:24.987' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4b8b020f-9d30-4a21-b945-35800dabe784', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:58.777' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a8500703-79f0-4924-bfe0-3596792a1127', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:33:25.080' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4906afc3-5a46-4427-9dcb-36ab152439eb', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:53:28.900' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f4e198ba-0763-4315-858b-36c2041b7d29', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 19:26:14.747' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a9db7aeb-139f-44b1-a22a-3794cb26d792', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:22:41.510' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1d22e0c1-e84b-4df9-87b2-37b8d72537d4', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:06:59.117' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'63a865f4-4792-4a16-9979-3884385d56c2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:30:22.787' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'248edaa2-6b7b-4c58-94e4-38d5239b74bb', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:14:20.003' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'39478f45-39cd-45d9-a5f1-39624e0e653d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:55:28.497' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'da1f1b17-7cdf-4ed8-9e2e-3983f3fc9964', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:26:51.080' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'40cc3170-6f2a-4341-8fd0-39ac72d4bbaf', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 15:30:27.813' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5b9c933b-f802-4d47-8ebd-39c415a84feb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:00:36.543' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e521273e-a9da-4616-bfc3-3a320314b5eb', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 16:23:59.057' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f1c860e2-2fce-4137-af38-3af9371f6008', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:09:15.053' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7127b538-cf18-4412-801a-3b0c15cdd0f2', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:13:37.743' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'87d1d0be-4094-4018-8935-3b858bc76fc0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:11:43.217' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a949ad20-445e-45c6-a4f7-3c76021fcef8', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:00:56.797' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f7167821-28f7-4961-a46d-3ce125a69e6c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:31:23.130' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5c045d69-86f6-4e3c-8ea5-3d12cabf75b8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:15:05.117' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b12db2cc-98bd-40b1-a7f5-3d1f4be20e04', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:10:45.667' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6beca455-5455-44d6-9983-3d210e743596', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:37:55.400' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ac7107bf-0ae9-4bf9-860d-3d26f037f53d', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:44:20.447' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bd5f48ea-355d-4020-8bd5-3da328672388', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:59:22.750' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'79ca5fb1-a8a7-4a28-a065-3dc621aa3c75', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:33:20.477' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c0ee7950-9a02-418a-a225-3df49b787096', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:31:20.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f2106ee0-da57-4427-85b9-3fa0f0e2fa1a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:42:23.403' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'aaa311f5-eaad-4af4-b219-4026ecc91519', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:16:22.557' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e46846c7-3f8c-4164-8ea6-409c41f0560f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 17:45:00.767' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0f0012d5-3848-4acd-9b4b-40b8644d53b1', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:20:26.660' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7c4bf013-8ce8-47d8-9bbb-40be621f4c30', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:59:21.000' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'88267d00-dc0d-4c2c-872e-41a36326f81c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:36:40.013' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7aae1cc6-d3dd-4392-8ca9-41b8a405c465', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 16:58:25.313' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bee0c1cf-6267-496c-966f-4382680b67c7', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:25:19.627' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9cf00b51-fa50-48d4-a0dd-43b581fc8d7f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:36:48.193' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'529e2112-a998-4855-8047-444a86225553', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:11:04.177' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'541bbee5-c84f-4132-9cce-4476631ed643', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:23:38.107' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0ed48c9f-29c4-48fb-89f5-44903cbc3810', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:12:33.613' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'165a4267-736e-4463-8089-44fb5e2a9d1c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:23:37.920' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a753015a-a595-4e31-9891-44fc5e68af15', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 01:19:33.283' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0a81bc62-7cdd-4107-9be1-456262ad2f65', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:23:10.593' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0159b225-29e5-409f-884b-4668f5711125', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:15:40.070' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'51a24ebe-6a71-4295-a9dd-473f977a542d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:33:45.577' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a4ed33d6-1a83-4f9d-8e54-47401280b15e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:28.280' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b90c03a3-d1ba-4554-bae3-4747c5c7ce8c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:54:56.443' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1589473c-cc7e-4981-b594-476277006b2b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:03:24.983' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a7b87845-9ae7-41bc-ace2-4774f4f20c8d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:30:38.390' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4744b2a1-fd32-47ab-9bfb-47a863e62347', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:54:00.260' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd8753567-9073-4f1b-92c8-47c699f8312b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:50:48.257' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8c38ea69-7d1e-4b0d-9b71-47f370cb742b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:56:36.170' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd7639612-ada2-46d1-99d3-48354c4a8385', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:12:55.533' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c48dfbcc-8700-4496-bafe-493ae033e83d', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:27:52.827' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4b260b87-ac27-406f-8f20-494664f720ba', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:15:16.283' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dadae298-955e-40c8-9d09-4982b992a9ce', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:19:23.797' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'be850830-ff87-40e3-9ece-4a9ef590a4f3', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:14:21.017' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd9a40a48-0d11-4890-a424-4b0c4ce46129', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:00:26.770' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7b1e9cb6-4846-49bf-91f8-4b45a5c91155', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:41:48.730' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd574b0bb-2365-45e5-8ae2-4b5999607dac', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:36:03.297' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'25cbbb18-de45-43f6-961a-4b86e4c72157', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:44:19.060' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'30d11a87-fc3f-45d1-a670-4bb5a8c2e788', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:09:20.963' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'96c7f433-94a3-4b9f-b8f9-4bf4cc0c8d8f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:15:28.783' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'97295188-250f-4b4e-90bd-4c3962b82166', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:20:41.367' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'20d3c716-306e-4184-a0de-4c8820474733', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:09:37.787' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0a28fdb0-7a5d-4d23-b020-4cc87d2a0a8b', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:01:14.077' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c9c4d47a-e2ce-40da-921f-4daf15ef9d2e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:31:19.930' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5b5d0b7d-79a4-4a60-9b54-4daff2c93557', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:01:21.743' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'274b00ed-18b3-4285-80c0-4e7f4239767c', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:56.553' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'84789f7a-83d4-4d4a-9eb6-4f177a2f5d31', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-30 18:18:32.967' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fb80e8f3-d109-4bc5-9959-4f3595f5eb63', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:32:02.177' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b44e9882-886c-4580-8760-4f3ee012d928', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:51:19.587' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'62ba5645-8010-4316-a182-4fbc918c565d', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 05:10:25.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'21bbf94f-147c-427c-96c0-4fbeda7bbb4e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 18:55:34.143' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c458da13-8b57-4068-a788-50bb36fcc299', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:07:36.273' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0a0714ca-8c1f-47af-9011-50be4f8958a6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 16:58:25.070' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ef5ee534-dfc5-46b4-82df-50e332d50ac8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:49:57.050' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7d3bb812-4ff2-4073-8d47-521eb2316d24', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:13:24.987' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'245e3bee-0e66-46f8-831b-52be48b89fb4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:16:55.137' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8fac09f1-5cd6-423b-bac3-52c38e52f74b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:30:46.037' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'31dbb352-e929-498a-83d3-52c9d4df3aae', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:31:22.330' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5add3783-55a1-44f8-be92-53448a30fab4', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:55:13.063' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e550a26f-a207-4c99-91d2-541263b32f46', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:10:33.587' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'48aef93f-ac47-4e8c-9514-544ef4eb23f3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 18:57:06.740' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5d0f7556-01c5-4160-acc9-54b44805b85e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:31:55.530' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'79cc179d-947f-4d1a-886e-54ea582d8af4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:13:25.210' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'36911bbc-180e-46bb-9287-5540c4616edc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:12:44.703' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'99e46003-1f6c-493f-a656-55d6d48e8928', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:26:54.727' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'51103462-2fe4-4695-8131-56398fdabb37', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:38:25.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2f8053ae-c773-432c-8b62-5640cdf5d1e1', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:15:57.227' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7c3ff2a4-0e91-46de-b1d8-565ffc2a6a3c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:09:13.933' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'59bf7088-abe2-4852-8cd5-56e0f5795e6f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:31:33.143' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e6fb490e-1c43-423e-8936-570188fba6ea', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:41.053' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e0e8c197-e038-4e3e-a7ab-578602a2b14c', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:49:20.503' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c4cd496e-66ef-43f9-bf2d-57b70f9ced48', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:30:40.467' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'32a025b4-0a9c-48fa-9670-57f2f7c9d66c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:07:47.860' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'83c598e8-65c2-43b1-973a-58f12822ca9e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:13:37.827' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4eb9dfcc-84eb-40a6-a815-59de8163041a', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:59:20.000' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b80fba5a-6b80-482d-9e72-5b0122f7dc48', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:08:15.877' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'32ad09d4-7102-4757-be92-5b2202325efb', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 16:08:40.297' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1842fd45-185a-4476-89d4-5b635cfe9805', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:38:44.473' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1b91074c-92d6-4719-956c-5b9a1a61f440', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 16:53:25.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b141ea75-7288-4aea-aa12-5ba3cf3c66c9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:26:50.740' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3b852699-6ebe-4c7b-8b93-5c8c0651b184', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:21:55.180' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'23662b35-9fc4-43e6-b80c-5caf1584b7a7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:59:40.667' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9f755b1d-489c-4280-baab-5ccdd335c1b2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:06:21.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ec8dccac-886b-41f9-a63d-5dab15bdebc9', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:28:03.093' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dd860edc-c711-416b-be98-5e1899e3ae6f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:00:05.737' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a038894e-24ad-4495-8a87-5e5d71082805', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:39:19.970' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a94bf9c8-f4f2-4d64-af8e-5e70759fcc74', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:59:41.307' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c4cc79e8-81d5-43fa-b6c5-5e86a058403c', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:59.657' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bd3b34f1-d380-4c5d-ae03-5e8832dec852', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:38:09.700' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'54ddb8c5-aa89-40b6-bc3b-5ee2477019fc', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 16:04:17.993' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'27076b11-cdde-4ce3-be0c-5f7d9d77a297', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:56:42.313' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'65830768-28e2-4ef5-850b-5f863e13abb5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 18:48:56.307' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'48296106-d348-4723-8587-5fbbcc9ee8bc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:30:22.187' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0914bf99-f709-48e0-885f-5fe9625346af', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:51:27.517' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'48539615-5e50-4519-aeac-60f78aa1fd0f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:20:41.687' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8884d647-e163-448a-9047-61a2b2ebad29', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:46:55.643' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6beccccb-f8f5-4a22-aa03-61bb01ad0288', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:58:52.457' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e21e7a2f-5797-464e-b141-61f739910326', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:54:27.167' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'084069ce-1856-4678-9549-6220f32946da', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:33:15.513' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cac2fc0c-8161-4de9-9556-6230ab760197', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:54:48.673' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd4987a2d-b393-4f20-8adf-636ba6e1dbf7', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:55:13.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e7e3fa81-8615-4ddf-a68c-63d16f30f3f7', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:29:00.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd6c28f82-1045-4836-87d1-644ee4b79899', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:32:28.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'38fe3cf0-0ca5-4750-853b-648a7c4152e9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:36:54.523' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'57e3decb-dd21-4a8b-b87a-649fb3a83645', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:09:19.947' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'76063896-6e26-4e84-acd4-65364bfca32c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:56:35.673' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8c6586de-be7b-4c61-82f3-65bfdb7f8bc8', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:20:39.917' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ea5e6b46-b200-4f87-b21e-65db65a5f69f', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:06:41.343' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f129ed2d-0c2e-416d-8ffc-664af53b5e68', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:57.410' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'16eb77fa-b3c7-4005-92bb-667fb0ec440f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:55:28.687' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6d05b127-efae-499e-ac56-672a3a822f3a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:01:33.660' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9b40e99b-0fc7-42fd-abd1-6747358c63ad', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:04:19.933' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'25db3d49-220c-4f4d-a96c-67c40d078f43', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:11:40.857' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6d7c38bc-ec8a-4761-bc84-681560ca3e35', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:01:22.207' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9a205055-48f2-4bdc-9f85-68199af4acf2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:36:55.527' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'777d739a-b528-4463-96c6-687e1eef8744', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:19:19.937' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ef0fdd95-f240-4566-8170-691e811f3935', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:42:24.237' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'acac2b90-458a-4062-99c5-69368fe6784e', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:26:46.130' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd6bd6b52-f818-4104-bbd8-69edfafd3eea', N'91097101-658d-44f9-a534-4484209c8179', 50.4501, 30.5234, CAST(N'2015-10-12 19:46:05.713' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a6a971db-2e47-41d3-b7e7-69f6b53beda4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:42:24.563' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e2b6d5e0-9d0a-431e-9c72-6b0275ed31cd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:12:41.040' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'55e72d74-5838-4e8d-be1d-6b70827d5e1a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:00:27.767' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9670aa8a-4387-4353-822c-6c47f555af3a', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 15:35:28.773' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b049cc4c-1024-4913-b617-6cf3e27cb780', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:38:50.317' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b2c83214-5c1d-4a53-8a92-6eeb9d6e844f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:33:31.860' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'78b0e4f4-e6a4-45be-8605-6fd0d42e2e02', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:28:59.477' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ef7ff4fa-dfea-4712-b24c-6fd442de05fa', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:53:29.107' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2931b133-9dba-443c-b0bf-6fd76af6e24e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:54:33.957' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'86ead6ba-ffe0-48ac-8502-7048ea8614f0', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:44:18.437' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'98812716-1eef-468c-a6e9-705062dafd78', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 18:54:48.927' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6b702d36-b638-4e1b-b9af-70710c819e1f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:12:09.983' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ab6157c7-afca-4d89-acc2-70a6131fa00a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:56:42.743' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'529763e9-7fd3-4b3e-a265-7128ab9bfd5d', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:04:27.720' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'116afcd4-805f-4fae-af71-71a0d173cbc7', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 04:50:25.303' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8e757d15-20a5-4670-b77f-71b5d26f3ec0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 18:57:16.500' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f1e91bdc-062d-4d65-9668-73d3e50fe2c6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:35:26.877' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5531d9ad-3041-45f5-b7e1-73e3364e5a30', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:55:25.093' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e964d388-7f16-4714-b9c5-74d9dbac185f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:15:44.613' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fc18cfae-2e71-4699-a576-74fbc47720f1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:17:21.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8291ef06-bb95-463b-993a-75e011284f31', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:28:55.980' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6af8dae9-2da1-4acf-b6c9-7660811b2bc0', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:25:50.480' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e3d6acb7-7938-4647-b314-7665aea3d742', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 15:12:24.337' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c4f47a50-e7c1-4d17-bb8e-76f4ae5fc52a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:54:56.237' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ad3122ae-6102-4b08-b283-782c7bdea312', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:26:56.230' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'81473836-7b13-4cba-a2b2-782e58af18fa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:49:33.103' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'831cb116-e440-4907-8d0e-78591120f561', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:19:16.410' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1a4e5a69-3133-4325-af55-789885640906', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:35:41.397' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'77f61529-00a9-457f-a740-78b4b67d2849', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:49:19.530' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b696cbf2-817e-41f3-bd81-79043baf569e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:54:50.187' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e9ae5885-d189-476b-8f6b-790e50789019', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:35:56.217' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'acd6259d-a4d8-46f4-96f8-79b410482341', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:33:45.647' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'07032bf6-df9a-42a6-9d61-79ddaccae2a8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:18:56.107' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd8583013-9bb6-4ca6-906a-7a13941a832d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:15:28.740' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'af1de21d-0f0f-43cf-92d5-7a2bc675fae0', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 05:10:24.303' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'05c66142-56a6-438b-bd3d-7a2e643e7c4c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:04:10.100' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c123fa24-c13e-4074-9ac3-7ab069edda06', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:39:19.143' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a4ab394c-d27c-4fb9-8c23-7aeb7ae7e101', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:04:21.453' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'74749143-25bb-4f9a-855d-7b97d264bf30', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:11:41.863' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'236a2e84-53e9-4086-ae03-7ba7723538bf', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:51:32.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'702882db-fd80-4429-a0b6-7be39b3482bb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:04:30.163' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0e1fe927-93a5-4551-9cf5-7be663545711', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:37:43.477' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5db9aaf9-32b0-4094-b688-7ca02d907d49', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:40.457' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4f15ca1c-1d37-4940-ae7e-7d9ad94a70dd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:48:32.820' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5bfe0476-7d24-41dd-92ce-7dc8f30395ce', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:39:19.017' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b54540c5-ef98-4dee-9715-7df6737f2742', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:10:57.727' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0e4083ce-b8bd-49a0-a12f-7e108bf02665', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:12:21.510' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd9cfdf4f-c073-46df-b15b-7e1f25eb8145', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:58.640' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e89d492c-b814-41a4-bbf6-7e911ff63d80', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:29:20.697' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'46f49ae9-8d4d-48ec-9303-7eb0b036a8e1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:51:54.527' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b2d590e2-73f2-40a0-b5df-7ed8a08ff047', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:40:56.243' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd625e5f1-b4b3-4db6-b7d3-7fc867c8d804', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:34:19.700' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'32295901-ccd6-43f8-b65f-8069e9e69015', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:29:58.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd5aaaef1-b120-459d-959f-80e57b4bdc50', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:58:37.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'71902e13-cd37-42aa-a3b0-8135a6d1a88c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:28:45.193' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7c5b98d1-ae62-4e62-a4fb-8158244bc70b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:00:37.857' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a554f0b9-7909-4d9f-9489-8339a82ff0a2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:41:08.407' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'37ddd6c3-b888-44a4-82b7-83c76511ca11', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:20:40.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'06557e59-04fd-4997-983c-849259b5569d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:12:15.850' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'85b8f332-2986-49a8-828e-84dc2acb5ee3', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:55:31.127' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5a38d383-f14b-44f5-8e16-85489026f9a1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:58:52.737' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'be6b82bb-674d-4d5b-92b6-85dc35ae3858', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 16:43:25.110' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f812be7b-27d7-4528-bdc8-8611c663531e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:49:19.143' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'26ac5a21-2a56-4369-8762-883488ad1e22', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 18:56:42.310' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c8a36f03-61b6-4952-8318-88597557e328', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:14:00.120' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9f84b4d1-f135-4647-9450-885dca06efaa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:44:36.953' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'34f70bee-86ed-4b54-9a9a-88e191a5d6ce', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:00:35.947' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'85aad4d8-5431-4a97-9eb0-88e31be3522f', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:29:21.620' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fd5e7827-a704-4543-ad5d-8a350c61f93f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:05.263' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9d3cbbdc-4831-41d9-a5a1-8b02ea732c4d', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:28:34.867' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b03ad5c7-b956-43aa-bf79-8b11cabec2fd', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:20:41.370' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'beb63507-ce5b-4abc-88c6-8c7c0b1093a1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:28:25.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'40f5c91c-8876-4225-aa63-8c887c560bb7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:10:27.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6daf8210-a627-43c2-9722-8d084322e405', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:09:26.713' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9ddbc869-cd2d-4618-b219-8dbd225d83ca', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:25:06.063' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3303cdb3-1369-4d02-a249-8e35194729b2', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 05:00:24.313' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5413cb9a-8fb9-44fe-80dc-8eaf47d00108', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:00:27.430' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4599e1fe-b609-4170-8c0d-8f0e844f67db', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:30:54.247' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a2ce3b04-59a5-41bd-8046-8fa84b251e11', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:44:19.143' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'98633baa-e251-4fac-9796-9072e49afb51', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 15:40:28.727' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5e951952-68e2-44e8-9a00-90c6c90db174', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 17:30:10.403' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3ae68e0f-58b1-4a60-9e62-9222f31bc353', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:54:13.647' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fe021fe5-437c-4bb1-a99d-92850f84cabd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:28:27.590' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'71c071fb-f8ae-494f-b0a0-929f1c8707ca', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 01:14:42.853' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'707cd212-ee41-4683-ac0d-93a29758283f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:49:18.787' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b74e00cc-a077-4107-ab5d-946b7b966d16', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:00:05.347' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4f187b8b-1466-4b6b-bced-94b0bab83958', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:01:00.857' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f11fc486-b7c9-4d15-aae0-9510d057b981', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:31.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bbb87b4b-a26e-4eb3-990d-953ee3429a7a', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:05:56.740' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9ecdf661-9f7e-422b-a4a9-957a8c8afea7', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:35:56.720' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'807e287a-c7b6-42d2-ab50-960341790164', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:34:19.610' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2c750077-73b6-453c-85cf-963b17d383d0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:28:15.943' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'39a865f3-e100-4191-911d-964d1398300c', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:10:57.690' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'056e213d-3b86-4e98-9540-97f584d14e64', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:06:21.087' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0641206d-90a6-41c4-93da-98b048c5902a', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:28:59.477' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c50beb3d-8978-4284-9491-99abad3013a4', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:45:56.223' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd0195036-6c73-488b-8eca-9a35c8c661e0', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 16:04:17.833' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3278e1c0-98c7-4893-ba18-9aff89f95381', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:01:01.573' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c50672ad-9e83-4edb-a20b-9b1c6815d09d', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:30:56.207' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f7a1f8c8-8ab8-4202-a8bc-9b693d9e37ec', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:20:56.237' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bc5389cd-54fd-45dc-838b-9bdfa8c20743', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:28:18.127' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6d8142f4-9801-4cc8-a44f-9bedd4729b19', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:15:57.727' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0d318f48-b421-46d9-b555-9c0e7a46a369', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:15:30.737' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cd1e612e-82fd-4497-8252-9c3d0a2481ff', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:38:25.303' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'30f4f988-7813-4e00-aa1d-9e2594a10041', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:18:17.327' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'09bd625b-b474-4ddc-a888-9e9aa96e6091', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 16:53:25.303' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a226e38f-2e8a-4ffc-861f-9f87a1862c88', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-30 18:18:32.457' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b34dfe27-b321-4da4-92fb-a06827604805', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:59:26.800' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9b185154-1afa-4296-8176-a0bbeae71d97', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:15:57.330' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c7d472f4-e298-41b3-8cca-a100ec129a50', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:31:54.527' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4df57904-55ad-4e2d-b4de-a19019782447', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 04:55:25.307' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a71d45cf-8e80-4a43-9417-a211140e3dd3', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:29:19.887' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1b10f123-9f39-4a5d-b844-a22e83198d1d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 16:48:25.077' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'82956449-eb26-4bd5-8f48-a2b4a17da667', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:54:20.493' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'57a39571-5785-4d8e-9892-a2bbb337b127', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:28:58.223' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c2c984d6-ed3e-47c1-81b8-a3d24d732b88', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:36:03.007' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'122574a7-a597-4cc4-b257-a4270efd72f9', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:09:28.217' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a1695940-f068-49e5-bc52-a4ad32f3659a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:43:40.850' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'20bafe83-85ab-417d-b63e-a4e5494389d8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:32:50.787' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'277fd9d3-63d7-47df-8f60-a4faed2f1e62', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:40:23.107' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a684a768-9102-46dc-86f5-a78a42fbf287', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:30:56.273' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'07abaa94-89b6-4544-ac53-a7c81db402e4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:46:54.637' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f8cb972f-22d8-4562-aa7f-a81aee391233', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 18:31:45.793' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f89e2a2e-2259-44ac-abeb-a8361243359b', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:34.170' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd1ed8ee2-9bfb-46da-9b34-a9984ded71c4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:42:23.907' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c26ef471-9c91-46dd-9e91-ab704202c9ec', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 16:14:10.307' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7e7ba8b2-1fab-49fc-8d47-abe8ba094cc9', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:51.390' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'37a93568-2c4d-4ed0-a503-ad1811d04de7', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:41.743' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f308ae91-a54f-4230-93e3-ad603c6014a4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:48:18.613' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'346a7ca6-8b03-47ef-9d70-ae2e81c1fc79', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:33:12.950' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'606d8318-314f-4feb-a8dd-ae691928545d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:17:36.347' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'eebd20a7-1801-4532-b717-aede459ff423', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:31:56.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'051b187b-c620-4cbe-9d7a-af2d640669fa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:03:48.720' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3c672a43-2b44-46eb-9e7e-af2ea4d878aa', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:39:20.973' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b43c8f9e-4822-4d0a-bff2-afce3aed8ec4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:22:23.990' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'997af06c-3d81-467f-88b1-b045b50ad369', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:49:18.437' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ee918f9a-9f9a-46fd-bafe-b07286a74f14', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:34:21.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ec66dac8-c675-4d9a-a270-b10b5e7f38cc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:54:13.440' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f8a8ad9b-a5f8-4a5d-bc3f-b10e461352c3', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:53:40.663' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c22521f5-a7b9-43d1-8681-b19aee331925', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 15:08:53.770' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'47eeda97-abba-46f5-b3e5-b1e83db55f1c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:21:54.637' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6bc3511b-7c9a-4bc4-b010-b21686d93ccf', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:57:29.080' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'af2ac04f-8fdd-415a-a6a9-b469bdc6cf5b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:47:24.440' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'612acabe-f2cf-4cc1-8655-b47a54d3e555', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:35:27.033' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dc9750ea-861b-4b69-a821-b48322b0c14f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:28:56.070' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b419a2ee-8942-4142-a3a4-b5792620f6fa', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:16:42.960' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0acf3f02-0356-4588-a188-b61857bfdc70', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 04:55:25.807' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a998cc03-cc8b-42d5-ab47-b769ebd50171', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:28:17.623' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9127c309-bd3b-4517-9a13-b79b9fd0e6f3', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 04:50:24.803' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'59292b48-d09c-4439-b73b-b7c6010d4c2a', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:34:18.683' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'16821b74-e8da-44db-a327-b7fb85adda2a', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 04:40:28.413' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'89ac571b-5fb1-4d33-ba28-b9baaf9252eb', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:19:01.943' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'43a9dfeb-0281-4152-940c-b9c72a0affde', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 05:15:24.803' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b7acacdd-7fe4-46cf-86d8-b9d474b62cd4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:06:28.240' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'eb0179d6-6b1c-43fb-b5d5-ba1587c46fcf', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:30:57.220' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3c2c95ce-7d1f-477e-9ae8-ba210f119d8e', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 16:08:40.813' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e388aab9-7168-44f4-89ac-ba245d33a642', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:12:22.027' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'81f0575f-7376-4128-bf41-baeaaf25da74', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:43:25.307' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5840a955-b09f-459c-ad00-bb1ca638235b', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:10:58.193' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'164bbee4-97a8-4a12-a331-bb472d581334', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:30:28.980' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c24a600e-fec4-4c1b-b61e-bbe53db006db', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:36:40.090' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd20dad78-5258-4fae-9fc7-bc2f9761720b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 18:56:58.940' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'620674ab-0561-4fda-8ae3-bc9a6d234d7e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 15:12:24.253' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0e64f217-cd05-4910-8195-bd11c3e8d90d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:03:25.427' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'945916de-bf26-4902-a034-bd733983858d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:11:15.287' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'982feff6-3e66-4465-837e-bdbf27abf2ef', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 01:14:43.357' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'96021631-b8e3-4c00-a111-be5ff4f0a285', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:28:37.027' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'72f9d099-d31b-471f-8a2e-bee1f40ae680', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-18 10:39:32.407' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'890c57cc-2820-468f-ab4d-bf21bb21684e', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:51:23.420' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4e8e9ece-be5e-4b9f-8d79-bf82742f465c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 15:03:48.247' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e8ad02e7-bf0e-4c4a-9e5c-bf8730355463', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 15:45:28.313' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'06d1412c-7df0-41f8-8a88-bfce6001926e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:21:02.437' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dba61f02-6de6-4131-9910-bfe274a665cb', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:00:57.313' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b9679aab-b928-42f0-9c9b-c0022b517163', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:27:30.163' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'39cd4d73-5fcc-4d46-a373-c03916368c4c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:15:40.457' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ed701a6a-c0b8-4194-828c-c03aac52b3af', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:30:54.740' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ef7dcfaf-0a77-49d5-bafe-c05ff9daf8ab', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:33:15.280' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4b3d2860-8f0d-4d44-86ba-c1e9ed33e443', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:19:07.953' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3e8ae674-82d2-4900-9cdd-c2787696d3d8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:20:00.937' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4978d6ea-6a92-4244-b26e-c2d804c4694e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:34:17.123' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3fc1eb95-7174-4c81-bc3d-c3a930c91e75', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 05:15:25.303' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e76f1fd5-4b93-49e6-bf8a-c3b476e39efc', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:57.057' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7ed72542-256f-47d1-9ddd-c428e487ab4e', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:18:42.477' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0d8bac43-5a04-4777-b3a9-c537c885f622', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:08:01.960' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1df9e256-e7d0-490c-9fee-c5e487dcb59c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-16 17:22:42.433' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8e131d37-eafc-404c-bd17-c6cb119abc80', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 04:40:27.897' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7bf18447-1829-4b25-b207-c72c0ac7ebe1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:15:30.177' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0f9c71f1-2bf9-4d33-8f58-c7b5774f6510', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:38:09.777' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd3a243cb-edbb-428e-97c6-c7d49a6f79be', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:56:44.387' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'59bf9f14-3912-4e27-8342-c8a57e6de7ce', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:00:27.953' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ac887fd5-6ac0-4480-a7ac-c8c178f9c876', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:11:09.113' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'70c171b6-6770-4942-8b31-c9bee0e3db2c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:32:16.497' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4e79d4a7-81fa-435f-bbb0-ca68b35c9ca5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:00:41.877' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1f2f49cb-fc92-42e9-9480-ca6d3180a2d4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:56:55.527' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4f6a8c8b-e17c-4e91-817e-ca8ceccb4659', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:58:10.157' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd2c4e1fe-3b58-428e-9b30-cad316d6123b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:28:25.210' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'061d9f20-7f3f-465f-b616-cc8b3cdf9675', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:29:59.700' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ddf1e01d-2539-4ace-914f-cce5e735619b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:40:23.027' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'05751d1b-1891-4613-b3c8-ccfb6bab86e2', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:23:25.303' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'eaf1b524-2c2a-4c3c-bd4a-cd04b2cb8348', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:20:15.450' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f24e6473-e822-432f-a73a-cd353496fec8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:39:18.437' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1fee1722-4864-429f-bf74-cd941cdfa598', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:01:50.903' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8aa85b93-8ff6-4a84-98f7-cfc2e2cfa4ab', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:10:45.880' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5d4e6e70-cd65-4002-b1f8-cffdef482f2f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:33:25.720' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b2419fd3-1b87-468d-a6e0-d0183b0d21dc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 18:25:30.987' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fd841e2f-3e11-46df-8ee4-d06c917ec662', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:40:57.790' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0c37ce58-fcc3-4a95-a255-d07f0e070799', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:03:50.287' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5baa66ee-e970-422c-8110-d2be6b2b557d', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:44:21.447' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fe2633e8-b754-4923-b8e0-d3dda9d01e48', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 16:22:11.550' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'988671ec-7363-46d7-83b8-d4abac5bf0f4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:32:02.483' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f21b0d3d-825d-4224-9276-d4b2694ace34', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:41:49.757' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'80e54bcd-1a90-40f3-afd2-d54ccb512f03', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 18:57:12.760' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3b8e043c-991f-45ff-9f36-d5eb11947ece', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:31:32.767' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b5513c4a-ce5e-4ea6-b3f3-d624c6181957', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:45:57.237' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'022074f4-8061-47e9-8528-d678c6b3c360', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:13:52.723' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6195b209-6a4d-4f10-9d53-d6eb32e1cea1', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:14:56.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'adcc1043-a424-43cd-b876-d75195bdd4bf', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:18:25.210' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'214e6b64-8f5a-40be-9907-d7bdfb62b3c7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:37:17.477' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4cba5c70-ba59-4a00-bb30-d89bb78e4e91', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:02.027' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'aae50935-bbb9-4f0b-a5e5-d90805973344', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 01:19:32.277' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5ef5f4eb-54c9-46b2-8e72-d933be4eec96', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:40:56.777' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'42260d1f-785b-4a07-89be-d987e3b9e32b', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:24:20.500' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dbc2252e-6d61-4ae2-968d-da13bcc21c4c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:35:41.247' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f3b7b302-69f6-4e88-967e-dbb9f4b5e302', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 18:57:23.117' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7814f20f-ae07-4c5a-8f92-dc73743af93a', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:59.157' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'2a536367-50fa-4b74-995e-dcbb504f0e2c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:21:57.237' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1d5929b0-0733-4575-aaf3-dd1c0a6f7888', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:30:38.743' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f5a3db66-5156-437e-9ec8-def496873e93', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:18:17.850' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'33bdec9a-7b0d-48fe-91f1-df00b2480276', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:28:58.010' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b3361a52-dbbf-41c4-910b-df31f0df3320', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:06:40.827' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ea16f47b-779c-4948-af7d-df500c14372c', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:04:26.717' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a03dc908-01fb-4ca4-87ff-df7ab6ec01f1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 16:48:25.207' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0bb67aba-4d7a-4e63-b90a-e006dd954ea0', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 15:17:24.300' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dd28c337-dad6-496f-8148-e03507144382', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:18:42.477' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a709b6cb-9657-4ce9-8ca6-e17e8d08516f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 21:02:16.027' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4e58aaad-f0b4-4c94-a51b-e187abfe808f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:55:36.887' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'abe9bd73-e58e-4940-bbbd-e1c3ff026d55', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:31:46.163' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd1ad3c68-7500-4f52-b780-e1ff7305e688', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:28:52.707' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0e02a3b0-e9a8-4cb7-832d-e2fec2d6447f', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:20:58.257' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f9f226a0-2c18-44b4-b7b8-e37860ea3f45', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:41:55.640' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a48d5852-d256-4e52-b134-e3f76d7ad22c', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:25:48.160' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a8d9320a-7f7d-4ac1-adc7-e43830026c1f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:32:28.810' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6da205e6-ccbd-44c2-92a4-e49c4d3f2982', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:31:32.573' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'fda56d5f-dd4f-4c88-b2e7-e49d40475acb', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:44:18.753' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1de02ce7-d922-48a6-81b9-e4c031c089cc', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:10:33.363' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4e4ec3e4-c3e1-44d7-8f0b-e516c2e3201f', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 19:30:56.783' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4f06f8ce-cadc-403f-ba2f-e51cad8e5745', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:21:55.637' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8a0e3dbf-3c55-4783-a196-e53d3d9f2560', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:28:36.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'07d7ce26-0a47-41c3-9444-e53d663a9e57', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:15:43.607' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f2aef677-b559-4f01-b7fc-e6dd9b53a1cc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-18 10:01:21.707' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b38edf46-9f88-451f-883f-e7276052a117', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:32:48.670' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1baaee21-d048-4b9a-b260-e85a5d454a23', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:22:34.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'6a2b03d2-e458-424d-9462-e86f70d125cb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:33:21.490' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'aea72179-b5b8-4a9e-b2d3-e883ca34a679', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:56:44.137' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'22298730-38f2-4506-8e22-e8e959af84d7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:41:50.257' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4336a8e3-c53a-4155-82ba-e8f67e518c96', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:39:18.747' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bf127aab-b3fa-41ec-9776-ea0642391eb6', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 16:04:07.677' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b635c838-e304-4dda-8655-ec30af8b2aae', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:25:50.737' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3919e4c5-0ef8-4826-9661-ed06349c0163', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 20:34:21.007' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'35eefeb6-da59-401d-8ea7-edd0e4cfe6ff', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:49:19.990' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b2b5ff22-faec-4dae-82b6-ee3cc4d0264d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:48:52.770' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bb001743-3e94-4dae-b516-ee44ecf1bf27', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 19:25:59.207' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'743ad3b8-5f38-45d9-a254-ef5a96ed8a34', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:18:52.653' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'74075c54-16ec-4c65-86e7-ef70adb80671', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:19:23.280' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'ced0f1c5-5fe4-4e78-ab48-f003054b32d4', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-10-01 18:14:14.333' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c7d4db4b-52f4-4950-8d45-f0a4636e56c7', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:34:20.047' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'36d9f16f-1df3-4905-8390-f1a49d87bd92', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:20:39.917' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e40c5dcb-35de-4313-b941-f1b5538cb3fb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 16:42:41.670' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'a5c603f9-6ac9-4e10-ae4e-f33e0866be95', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-12 19:20:51.597' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'75751132-494d-4ed3-9024-f3ecd5bbb385', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:05:57.740' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'08e813f2-24a0-41ff-a40a-f401873b4cf6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:18:46.333' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f3529cc8-5733-4e79-941e-f44489e4b6b3', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 19:16:42.457' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c3123770-51af-4512-babc-f464407c95ad', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:38:44.567' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c6ef9713-64eb-4180-922a-f52a59a4a5cf', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:34:19.223' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'bdbdd9a3-6fe7-4711-8bb3-f55cb391eeea', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:44:56.217' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1e651141-7103-4590-96bb-f6490e9564a2', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:00:56.737' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'c30f6780-79d0-4027-bd4c-f6d95a192485', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:07:27.407' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'72caad92-79eb-4b4d-bdb1-f7674f9dfc17', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:13:12.083' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'582d6c26-40dc-47a0-945c-f802ca11eeec', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-11 17:23:25.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'cd28a2d4-66b8-4f7f-9d76-f80e7243c1ad', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-12 20:58:10.690' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'f40d459f-bfa1-436e-a5af-f9e4552b9b29', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:29:05.843' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'3a7cd9f0-e3a1-488d-8567-fa43bc2a028d', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:31:54.640' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'4333ee6b-be2b-454e-b886-fa66f3782d8a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-09-30 18:31:17.573' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1617d03b-4e79-42f5-9d7b-fb22cbd9d95c', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-11 19:29:20.393' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'dde35777-9c6e-4d0c-8a69-fc20ad657287', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 21:31:32.943' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7578a402-e29f-496e-9d7c-fc2c006c8337', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-12 05:05:24.300' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'e47b773c-401b-48ef-b770-fc89d9af35f1', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 19:29:05.410' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'1ca74951-2bfa-48a6-8c0a-fcba345ddf20', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:55:37.030' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd3c9e49c-5283-4ce1-973f-fce17d8c51b5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 11:58:58.657' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'0b558832-c80b-4f21-80e0-fd3184168caa', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 15:55:32.487' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5cef65c1-79f7-4f08-8c9d-fd4d2a6626ce', N'b057798c-6167-485c-b0c1-a40704faaad7', 50.4501, 30.5234, CAST(N'2015-10-11 19:00:27.790' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8a1ade00-5c07-407f-8f0c-fd53e54cdd83', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:56:35.483' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'8a938161-ced1-41c8-a96a-fd9733f085bc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:37:56.417' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'd702cd07-207f-457f-a7b1-fdd39bd756e3', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 20:25:56.723' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'9ad75091-0c35-46b0-bfed-fe814e9283de', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-10 20:53:43.183' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'45c0621c-bfc5-4625-9905-fe9f36ea9264', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', 50.4501, 30.5234, CAST(N'2015-09-27 12:53:37.040' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'7e64227e-2c4b-4366-9f95-febc041fe4f6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-15 04:16:54.637' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'21b7900b-e09a-4511-9235-ff18a2076fcb', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:47:27.847' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'b4a2a6ca-a7bd-4b5f-95e2-ff9e1154ff78', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', 50.4501, 30.5234, CAST(N'2015-10-14 14:33:13.610' AS DateTime))
GO
INSERT [dbo].[UserLocation] ([UserLocationID], [UserID], [Lat], [Lng], [Time]) VALUES (N'5e4a8d34-93d3-4ccd-95e4-fff8d0eba2f6', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', 50.4501, 30.5234, CAST(N'2015-10-13 21:20:57.250' AS DateTime))
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'5cc9fdc2-60e4-4813-ae35-019be31132ea', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', CAST(N'2015-10-11 19:26:45.153' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'560967d5-5d81-41d1-b45f-07faeede1342', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-11 16:42:41.430' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'3af7f902-859d-400c-b577-09eb3a6d12a4', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-18 09:59:52.340' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'7ef9c54f-549e-4686-b240-1285fce588f9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-15 17:30:10.080' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'be348448-ffc4-4cba-9999-1a2c0456016d', N'b057798c-6167-485c-b0c1-a40704faaad7', CAST(N'2015-10-11 16:21:47.410' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'65be76ab-68ce-47f1-af77-1b02cc71d0a5', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 18:14:58.670' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'5deaedee-7f78-4093-b98e-1f14c6d34b5f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-10 18:46:32.657' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'13b4dd24-07e1-4e88-821e-21a399078a3c', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-15 19:15:15.970' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'44d83665-75c2-42e3-b324-25079bbacae9', N'91097101-658d-44f9-a534-4484209c8179', CAST(N'2015-10-12 19:46:04.273' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'cb7d21e5-364f-44ab-b9cd-2b12f3aaf637', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 18:28:11.837' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'54486e6c-c5df-4a76-8bdf-2b1f7cc1eead', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-10 19:19:28.387' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'8b27f268-3f1e-43bd-bba5-2d622755b984', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-27 11:49:54.087' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.85 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'66138541-c880-4d99-9363-2de767e21684', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 18:31:32.040' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'791d52fb-7d20-4904-97fb-365352e5ca3e', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', CAST(N'2015-10-11 19:26:55.710' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'1b2c5ef2-3d33-4ca8-b396-3c85ed825d94', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-12 20:11:14.847' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'ab4fe565-6409-4213-bb20-3d11857d7e74', N'b057798c-6167-485c-b0c1-a40704faaad7', CAST(N'2015-10-11 15:20:27.217' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'59600018-ac29-4a19-b06e-3d861cc3a1f8', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-10 19:07:26.893' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'5f10d4c3-bb24-41c2-b0c8-497b6c5de47b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 18:28:12.333' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'66d7043a-b0ab-40ab-bd07-4fd0296b3f61', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 18:24:27.187' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'02a979cd-1c28-456c-a286-50058a736a3b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-16 17:22:41.697' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'a0388dc1-1b4f-4126-a53b-546c54c002f8', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 18:14:12.723' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'4d8f843a-8a8c-4a13-83bb-5b2b1bd16056', N'b057798c-6167-485c-b0c1-a40704faaad7', CAST(N'2015-10-18 10:39:31.783' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'2bec5430-06d6-45b9-942b-5c5d6aba983b', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-10 20:04:54.440' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'dab65dd6-0f84-443f-9f63-62615d0854d5', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 18:29:57.320' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'ed738c4f-e369-48ea-b37f-6759e65ac437', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-10 21:06:27.857' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'073909ff-382e-4705-8c2c-6c99ee657dd2', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 18:31:49.387' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'551b0d5d-10d8-49d9-8fd8-6f8181236753', N'b057798c-6167-485c-b0c1-a40704faaad7', CAST(N'2015-10-11 15:53:20.307' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'b9d6dfc1-cc8d-4971-8e15-752cc1395e20', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-10 19:28:27.077' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'72dca393-df76-464b-a907-812f11f5354d', N'b057798c-6167-485c-b0c1-a40704faaad7', CAST(N'2015-10-11 18:56:41.667' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'820c5d4f-580c-4724-ac6c-848b8c908a32', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', CAST(N'2015-10-11 19:26:39.617' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'8e0fcc0f-61f7-4df2-8563-8bbc54b2d11c', N'b057798c-6167-485c-b0c1-a40704faaad7', CAST(N'2015-10-12 18:39:28.970' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'd5618761-7cd2-46b7-9001-970501fd83a9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-15 18:57:22.883' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'cdbc1cb0-3b29-481a-881f-9b5fe118f560', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-09-30 18:18:46.063' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'37bb2ef9-fb4c-493d-b6ea-9effa8aa7295', N'b057798c-6167-485c-b0c1-a40704faaad7', CAST(N'2015-10-01 18:15:27.523' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'cc2f6036-89ba-44b9-9210-a0ea6f09009c', N'b057798c-6167-485c-b0c1-a40704faaad7', CAST(N'2015-10-11 15:55:32.150' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'9f81690e-3b46-4e17-aa0d-a41090b43c8f', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-10-01 18:28:14.547' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'0b2ed6e6-f616-4eca-9794-a9341729aa5e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-14 14:27:04.757' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'e35fa538-969a-466c-bc52-aa49ec2abcf7', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-09-30 18:32:53.997' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2feditor.aspx%3ftrackname%3dUkraine-Ternopil&trackname=Ukraine-Ternopil')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'7384929a-de1a-4a6d-8c18-aabf22113f2a', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 18:33:42.267' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'fe2db772-de78-4a9a-b3aa-af46c63c14a2', N'4324d1ff-b698-44b6-bc2a-d96f42d2300b', CAST(N'2015-09-30 18:18:28.270' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2findex.aspx%3ftrackname%3d2014-Germany&action=demo')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'bc16781e-f3b5-41eb-8f6f-b53b455edc96', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-12 20:07:35.440' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'50991f84-b73f-46b5-8569-b8aa4c17cde9', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-16 17:57:55.443' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'a646ae20-755f-47ba-b2b2-c0339b9d77df', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-10 19:48:28.637' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'f736b958-8784-4802-9379-ceea38dcc11e', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-09-30 18:27:36.527' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx?ReturnUrl=%2feditor.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'b99bec68-6449-4ab9-bd5a-d1d59eac2d53', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-18 10:27:29.717' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'cc7619fa-07bf-4b05-b4e5-d31cdb29ac46', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-15 17:45:00.087' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'2690f902-e381-4f07-bee9-e01c84f6a270', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-11 19:25:58.813' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'60c201c3-b20f-4cdc-95f1-e3960cf1a3fd', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-18 09:59:52.973' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.71 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'3856a336-09fd-49d4-ab4e-e5c8e6c52c6f', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-15 18:25:30.277' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'7143bb36-9e3c-4fbf-b249-e7d898982c89', N'b057798c-6167-485c-b0c1-a40704faaad7', CAST(N'2015-10-12 19:20:14.683' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'f01a8232-d067-473c-9f7b-e85e2f3b61da', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-10 21:27:08.983' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'921ca77d-c254-492e-b6a1-ead75e9fda33', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', CAST(N'2015-10-11 19:27:51.857' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'acd7d210-ae59-45e6-8551-ebd57465de8f', N'3d70c1c0-e191-4837-9fa7-3398c928efaf', CAST(N'2015-10-11 19:26:34.087' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:40.0) Gecko/20100101 Firefox/40.0', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'19fa9f42-5f51-4dc2-9038-f41688ca4596', N'91097101-658d-44f9-a534-4484209c8179', CAST(N'2015-10-12 19:46:05.317' AS DateTime), N'Facebook', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'b7fbca38-c80e-4c3c-b917-f8e8d26f1774', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-14 14:51:27.197' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'693ea32b-028b-4898-9ef5-fc48176725e6', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-01 18:32:48.660' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/Login.aspx')
GO
INSERT [dbo].[UserLogin] ([UserLoginID], [UserID], [Time], [LoginType], [CallerIp], [CallerAgent], [CalledUrl]) VALUES (N'389301db-9f57-4f2d-9a2f-fcede64b0c60', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', CAST(N'2015-10-12 20:43:40.377' AS DateTime), N'Forms', N'127.0.0.1', N'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/45.0.2454.101 Safari/537.36', N'http://local.seeyourtravel.com:80/login.aspx')
GO
INSERT [dbo].[UserRole] ([UserRoleID], [UserID], [RoleID]) VALUES (N'087a788e-7245-45c2-a369-2d8cf02ce5dc', N'c9f148f7-923a-46b0-8b7c-bd4b54d90886', N'5195a2d5-0b51-44c4-b672-7383482bc77a')
GO
INSERT [dbo].[UserRole] ([UserRoleID], [UserID], [RoleID]) VALUES (N'2c489995-fe50-452a-bf55-fa763a7fcd7a', N'b057798c-6167-485c-b0c1-a40704faaad7', N'5195a2d5-0b51-44c4-b672-7383482bc77a')
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
CREATE VIEW [dbo].[GetAllRoughUserLocations]
AS
SELECT        u.UserID AS userid, u.UserName AS username, ROUND(ul.Lat, 2, 0) AS lat, ROUND(ul.Lng, 2, 0) AS lng, MAX(ul.Time) AS Expr1
FROM            dbo.UserLocation AS ul INNER JOIN
                         dbo.[User] AS u ON ul.UserID = u.UserID
GROUP BY u.UserID, u.UserName, ROUND(ul.Lat, 2, 0), ROUND(ul.Lng, 2, 0)

GO