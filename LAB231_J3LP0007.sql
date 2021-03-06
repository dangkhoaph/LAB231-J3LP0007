USE [master]
GO
/****** Object:  Database [QuizOnline]    Script Date: 6/2/2020 10:28:19 PM ******/
CREATE DATABASE [QuizOnline]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'QuizOnline', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuizOnline.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'QuizOnline_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\QuizOnline_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [QuizOnline] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QuizOnline].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QuizOnline] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QuizOnline] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QuizOnline] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QuizOnline] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QuizOnline] SET ARITHABORT OFF 
GO
ALTER DATABASE [QuizOnline] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QuizOnline] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QuizOnline] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QuizOnline] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QuizOnline] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QuizOnline] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QuizOnline] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QuizOnline] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QuizOnline] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QuizOnline] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QuizOnline] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QuizOnline] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QuizOnline] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QuizOnline] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QuizOnline] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QuizOnline] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QuizOnline] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QuizOnline] SET RECOVERY FULL 
GO
ALTER DATABASE [QuizOnline] SET  MULTI_USER 
GO
ALTER DATABASE [QuizOnline] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QuizOnline] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QuizOnline] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QuizOnline] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [QuizOnline] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QuizOnline', N'ON'
GO
USE [QuizOnline]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 6/2/2020 10:28:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](64) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[RoleId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Answer]    Script Date: 6/2/2020 10:28:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Answer](
	[AnswerId] [int] IDENTITY(1,1) NOT NULL,
	[Symbol] [varchar](1) NOT NULL,
	[AnswerContent] [varchar](250) NOT NULL,
	[QuestionId] [int] NOT NULL,
 CONSTRAINT [PK_Answer] PRIMARY KEY CLUSTERED 
(
	[AnswerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Question]    Script Date: 6/2/2020 10:28:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Question](
	[QuestionId] [int] IDENTITY(1,1) NOT NULL,
	[QuestionContent] [varchar](250) NOT NULL,
	[CorrectAnswer] [varchar](1) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[SubjectId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
 CONSTRAINT [PK_Question] PRIMARY KEY CLUSTERED 
(
	[QuestionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Quiz]    Script Date: 6/2/2020 10:28:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Quiz](
	[QuizId] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[Score] [float] NOT NULL,
	[SubjectId] [int] NOT NULL,
	[Email] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Quiz] PRIMARY KEY CLUSTERED 
(
	[QuizId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuizDetail]    Script Date: 6/2/2020 10:28:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuizDetail](
	[QuizDetailId] [int] IDENTITY(1,1) NOT NULL,
	[QuizId] [int] NOT NULL,
	[QuestionId] [int] NOT NULL,
	[Answer] [varchar](1) NOT NULL,
 CONSTRAINT [PK_QuizDetail] PRIMARY KEY CLUSTERED 
(
	[QuizDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 6/2/2020 10:28:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Status]    Script Date: 6/2/2020 10:28:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Status](
	[StatusId] [int] IDENTITY(1,1) NOT NULL,
	[Status] [varchar](20) NOT NULL,
 CONSTRAINT [PK_Status] PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Subject]    Script Date: 6/2/2020 10:28:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Subject](
	[SubjectId] [int] IDENTITY(1,1) NOT NULL,
	[Code] [varchar](10) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[NumberOfQuestion] [int] NOT NULL,
	[Duration] [int] NOT NULL,
 CONSTRAINT [PK_Subject] PRIMARY KEY CLUSTERED 
(
	[SubjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Account] ([Email], [Password], [Name], [RoleId], [StatusId]) VALUES (N'abcdef@gmail.com', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'ABCD', 2, 2)
INSERT [dbo].[Account] ([Email], [Password], [Name], [RoleId], [StatusId]) VALUES (N'khoaphdse140609@fpt.edu.vn', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'Phan Huynh Dang Khoa', 1, 2)
INSERT [dbo].[Account] ([Email], [Password], [Name], [RoleId], [StatusId]) VALUES (N'test@yahoo.com.vn', N'dd130a849d7b29e5541b05d2f7f86a4acd4f1ec598c1c9438783f56bc4f0ff80', N'Test', 2, 1)
INSERT [dbo].[Account] ([Email], [Password], [Name], [RoleId], [StatusId]) VALUES (N'userstudent@gmail.com', N'bef57ec7f53a6d40beb640a780a639c83bc29ac8a9816f1fc6c5c6dcd93c4721', N'User Student', 2, 2)
SET IDENTITY_INSERT [dbo].[Answer] ON 

INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (1, N'A', N'at', 1)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (2, N'B', N'to', 1)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (3, N'C', N'in', 1)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (4, N'D', N'on', 1)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (5, N'A', N'at', 2)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (6, N'B', N'to', 2)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (7, N'C', N'in', 2)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (8, N'D', N'on', 2)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (9, N'A', N'By car', 3)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (10, N'B', N'In car', 3)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (11, N'C', N'By the car', 3)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (12, N'D', N'On car', 3)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (13, N'A', N'Yes, I likes', 4)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (14, N'B', N'Yes, I like', 4)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (15, N'C', N'Yes, I does', 4)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (16, N'D', N'Yes, I do', 4)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (17, N'A', N'is stand', 5)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (18, N'B', N'is standing', 5)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (19, N'C', N'stand', 5)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (20, N'D', N'standing', 5)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (21, N'A', N'I like', 6)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (22, N'B', N'I''d want', 6)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (23, N'C', N'I''d like', 6)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (24, N'D', N'I''m like', 6)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (25, N'A', N'had', 7)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (26, N'B', N'is', 7)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (27, N'C', N'was', 7)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (28, N'D', N'did', 7)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (29, N'A', N'as small', 8)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (30, N'B', N'smallest', 8)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (31, N'C', N'more small', 8)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (32, N'D', N'smaller', 8)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (33, N'A', N'most expensive', 9)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (34, N'B', N'more expensive', 9)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (35, N'C', N'expensivest', 9)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (36, N'D', N'as expensive', 9)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (37, N'A', N'easy', 10)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (38, N'B', N'easier', 10)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (39, N'C', N'good', 10)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (40, N'D', N'easily', 10)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (41, N'A', N'did', 11)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (42, N'B', N'was', 11)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (43, N'C', N'went', 11)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (44, N'D', N'have', 11)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (45, N'A', N'No, she didn''t', 12)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (46, N'B', N'No, she didn''t stay', 12)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (47, N'C', N'No, she didn''t stayed', 12)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (48, N'D', N'No, she stayed not', 12)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (49, N'A', N'gone', 13)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (50, N'B', N'was', 13)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (51, N'C', N'been', 13)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (52, N'D', N'went', 13)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (53, N'A', N'I''ll get', 14)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (54, N'B', N'I''m getting', 14)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (55, N'C', N'I get', 14)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (56, N'D', N'I''d get', 14)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (57, N'A', N'Did', 15)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (58, N'B', N'Do', 15)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (59, N'C', N'Were', 15)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (60, N'D', N'Have', 15)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (61, N'A', N'a bookstore', 16)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (62, N'B', N'a restaurant', 16)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (63, N'C', N'a dance club', 16)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (64, N'D', N'a drugstore', 16)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (65, N'A', N'a bee', 17)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (66, N'B', N'a spider', 17)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (67, N'C', N'a crocodile', 17)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (68, N'D', N'a fly', 17)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (69, N'A', N'litter', 18)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (70, N'B', N'scissors', 18)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (71, N'C', N'stocks', 18)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (72, N'D', N'sharpener', 18)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (73, N'A', N'a laundromat', 19)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (74, N'B', N'a theatre', 19)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (75, N'C', N'a library', 19)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (76, N'D', N'a gym', 19)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (77, N'A', N'find', 20)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (78, N'B', N'stop', 20)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (79, N'C', N'sell', 20)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (80, N'D', N'shout', 20)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (81, N'A', N'conditions', 21)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (82, N'B', N'disgusted', 21)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (83, N'C', N'content', 21)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (84, N'D', N'ambitious', 21)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (85, N'A', N'catches thieves', 22)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (86, N'B', N'paints pictures', 22)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (87, N'C', N'helps the police', 22)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (88, N'D', N'fights in a war', 22)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (89, N'A', N'fox', 23)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (90, N'B', N'bread', 23)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (91, N'C', N'wood', 23)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (92, N'D', N'flour', 23)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (93, N'A', N'play', 24)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (94, N'B', N'cry', 24)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (95, N'C', N'cut', 24)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (96, N'D', N'write', 24)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (97, N'A', N'father''s brother', 25)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (98, N'B', N'father''s grandson', 25)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (99, N'C', N'father''s sister', 25)
GO
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (100, N'D', N'mother''s brother', 25)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (101, N'A', N'Atlantic', 26)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (102, N'B', N'Sahara', 26)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (103, N'C', N'Everest', 26)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (104, N'D', N'Black Sea', 26)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (105, N'A', N'classroom objects', 27)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (106, N'B', N'names of cities', 27)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (107, N'C', N'uncountable nouns', 27)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (108, N'D', N'animals', 27)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (109, N'A', N'something which students eat', 28)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (110, N'B', N'something which is made of wood', 28)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (111, N'C', N'something which pollutes', 28)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (112, N'D', N'something which people like to play with', 28)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (113, N'A', N'near', 29)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (114, N'B', N'pear', 29)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (115, N'C', N'ear', 29)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (116, N'D', N'hair', 29)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (117, N'A', N'Will', 30)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (118, N'B', N'Have', 30)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (119, N'C', N'Shall', 30)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (120, N'D', N'Do', 30)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (121, N'A', N'are', 31)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (122, N'B', N'is', 31)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (123, N'C', N'in', 31)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (124, N'D', N'am', 31)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (125, N'A', N'make', 32)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (126, N'B', N'wash', 32)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (127, N'C', N'take', 32)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (128, N'D', N'do', 32)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (129, N'A', N'with your feet', 33)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (130, N'B', N'on foot', 33)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (131, N'C', N'by feet', 33)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (132, N'D', N'with walking', 33)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (133, N'A', N'is him', 34)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (134, N'B', N'does he', 34)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (135, N'C', N'he is', 34)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (136, N'D', N'is he', 34)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (137, N'A', N'is', 35)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (138, N'B', N'all', 35)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (139, N'C', N'are', 35)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (140, N'D', N'some', 35)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (141, N'A', N'thirsty', 36)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (142, N'B', N'hungry', 36)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (143, N'C', N'tired', 36)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (144, N'D', N'cold', 36)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (145, N'A', N'city', 37)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (146, N'B', N'town', 37)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (147, N'C', N'continent', 37)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (148, N'D', N'country', 37)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (149, N'A', N'more tall', 38)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (150, N'B', N'taller', 38)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (151, N'C', N'tallest', 38)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (152, N'D', N'most taller', 38)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (153, N'A', N'have', 39)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (154, N'B', N'has', 39)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (155, N'C', N'is', 39)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (156, N'D', N'-', 39)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (157, N'A', N'whether', 40)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (158, N'B', N'air', 40)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (159, N'C', N'weather', 40)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (160, N'D', N'temp', 40)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (161, N'A', N'do', 41)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (162, N'B', N'did', 41)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (163, N'C', N'are', 41)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (164, N'D', N'will', 41)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (165, N'A', N'big', 42)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (166, N'B', N'many', 42)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (167, N'C', N'much', 42)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (168, N'D', N'quantity', 42)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (169, N'A', N'with', 43)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (170, N'B', N'on', 43)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (171, N'C', N'in', 43)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (172, N'D', N'above', 43)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (173, N'A', N'am studying', 44)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (174, N'B', N'study', 44)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (175, N'C', N'studied', 44)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (176, N'D', N'studying', 44)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (177, N'A', N'Are', 45)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (178, N'B', N'Have', 45)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (179, N'C', N'Do', 45)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (180, N'D', N'Did', 45)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (181, N'A', N'With the addition of localized data, the same executable can run worldwide.', 46)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (182, N'B', N'Supporting for new languages does not require recompilation.', 46)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (183, N'C', N'Textual elements, such as status messages and the GUI component labels are not hard-code in the program. Instead they are stored outside the source code and retrieved dynamically.', 46)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (184, N'D', N'All of the others', 46)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (185, N'A', N'An integer value indicates the number of records that have been executed successfully', 47)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (186, N'B', N'The method returns void', 47)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (187, N'C', N'A Boolean value indicates if the specified query is executed successfully or not', 47)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (188, N'D', N'None of the others', 47)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (189, N'A', N'Type 1 and Type 2', 48)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (190, N'B', N'Type 2 only', 48)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (191, N'C', N'Type 3 and Type 4', 48)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (192, N'D', N'Type 1 and Type 4', 48)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (193, N'A', N'All of the others', 49)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (194, N'B', N'Data formats', 49)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (195, N'C', N'Number formats', 49)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (196, N'D', N'Currency formats', 49)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (197, N'A', N'Font font = new Font(fontName, fontStyle, fontSize);', 50)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (198, N'B', N'Font font = new Font(fontName, fontStyle);', 50)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (199, N'C', N'Font font = new Font(fontName, fontSize);', 50)
GO
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (200, N'D', N'Font font = new Font(fontName);', 50)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (201, N'A', N'None of the others', 51)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (202, N'B', N'Component.getGraphics()', 51)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (203, N'C', N'Component.referGraphics()', 51)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (204, N'D', N'Component.setGraphics()', 51)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (205, N'A', N' I am live in London.', 52)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (206, N'B', N'My live is London.', 52)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (207, N'C', N'I live in London.', 52)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (208, N'D', N'I lives in London.', 52)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (1121, N'A', N'1', 1031)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (1122, N'B', N'2', 1031)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (1123, N'C', N'3', 1031)
INSERT [dbo].[Answer] ([AnswerId], [Symbol], [AnswerContent], [QuestionId]) VALUES (1124, N'D', N'4', 1031)
SET IDENTITY_INSERT [dbo].[Answer] OFF
SET IDENTITY_INSERT [dbo].[Question] ON 

INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (1, N'She works _____ Saturday.', N'D', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (2, N'I stay at home _____ the morning.', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (3, N'How do you get to work? _____.', N'A', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (4, N'Do you like classical music? _____.', N'D', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (5, N'Where is Mary? She _____ over there.', N'B', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (6, N'I am hungry. _____ something to eat, please.', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (7, N'He _____ born in 1963 in America.', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (8, N'Switzerland is _____ than Britain.', N'D', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (9, N'Motor racing is the _____ sport in the world.', N'A', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (10, N'He passed his English exam very _____.', N'D', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (11, N'When _____ you go to the USA? Last year.', N'A', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (12, N'Did she stay with friends? _____.', N'A', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (13, N'She has never _____ to New York.', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (14, N'I haven''t got any money. Never mind. _____ some from the bank.', N'A', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (15, N'_____ you ever visited London?', N'D', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (16, N'_____ is a place where you buy medicine.', N'D', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (17, N'_____ is an insect which makes honey.', N'A', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (18, N'_____ are something which is used for cutting paper.', N'B', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (19, N'_____ is a place where you borrow books.', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (20, N'Which word means nearly the same as "scream"?', N'D', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (21, N'Which word means nearly the same as "happy"?', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (22, N'A soldier is a man who _____.', N'D', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (23, N'Which is countable?', N'A', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (24, N'Which verb''s past and present forms are the same?', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (25, N'Your aunt is your _____.', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (26, N'Which is a desert?', N'B', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (27, N'We don''t use "THE" before _____.', N'B', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (28, N'What is rubbish?', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (29, N'Which is not a noun?', N'A', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (30, N'_____ we go on holiday? Yes! That''s a great Idea.', N'C', CAST(N'2020-05-24 00:00:00.000' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (31, N'He _____ very tired, he is falling asleep.', N'B', CAST(N'2020-05-31 21:53:42.007' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (32, N'I am going to _____ a shower.', N'C', CAST(N'2020-05-31 21:58:17.337' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (33, N'I can''t believe you went to school _____.', N'B', CAST(N'2020-05-31 22:07:37.327' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (34, N'He is not a doctor, _____?', N'D', CAST(N'2020-05-31 22:12:30.093' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (35, N'What _____ those people doing?', N'C', CAST(N'2020-05-31 22:19:43.697' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (36, N'I am very _____, I can eat a cow.', N'B', CAST(N'2020-05-31 22:33:46.177' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (37, N'United States is a beautiful _____.', N'D', CAST(N'2020-05-31 22:35:00.967' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (38, N'I think Josh is a little bit _____ than you.', N'B', CAST(N'2020-05-31 22:35:39.513' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (39, N'He _____ got a nice house.', N'B', CAST(N'2020-05-31 23:21:53.267' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (40, N'The _____ is very bad today, it is raining cats and dogs', N'C', CAST(N'2020-05-31 23:22:18.647' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (41, N'When _____ you go on a vacation? Tomorrow.', N'D', CAST(N'2020-05-31 23:29:13.997' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (42, N'How _____ apples have you eaten? I have had three.', N'B', CAST(N'2020-05-31 23:55:16.637' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (43, N'Do you watch any movies _____ TV?', N'B', CAST(N'2020-06-01 00:03:16.447' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (44, N'Don''t disturb me, I _____ for an important exam.', N'A', CAST(N'2020-06-01 00:24:41.557' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (45, N'_____ you ever seen a castle?', N'B', CAST(N'2020-06-01 00:29:12.290' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (46, N'Select a correct statement about an internationalized program:', N'D', CAST(N'2020-06-01 07:27:45.910' AS DateTime), 2, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (47, N'In terms of JDBC API, what does the Statement.executeUpdate() method return?', N'A', CAST(N'2020-06-01 07:31:14.027' AS DateTime), 2, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (48, N'Which JDBC driver types can be used for communications over networks?', N'C', CAST(N'2020-06-01 10:59:53.397' AS DateTime), 2, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (49, N'Localization is the process of not only changing the language interaction, but also other as relevant changes such:', N'A', CAST(N'2020-06-01 15:48:39.870' AS DateTime), 2, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (50, N'Select a correct constructor form of the java.awt.Font class:', N'A', CAST(N'2020-06-01 18:58:26.473' AS DateTime), 2, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (51, N'Which method is used to get graphic object of a component?', N'B', CAST(N'2020-06-01 18:59:47.077' AS DateTime), 2, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (52, N'Where do you live?', N'C', CAST(N'2020-06-01 19:04:27.793' AS DateTime), 1, 2)
INSERT [dbo].[Question] ([QuestionId], [QuestionContent], [CorrectAnswer], [CreateDate], [SubjectId], [StatusId]) VALUES (1031, N'How many JDBC server types are there ?', N'D', CAST(N'2020-06-02 22:15:24.270' AS DateTime), 2, 2)
SET IDENTITY_INSERT [dbo].[Question] OFF
SET IDENTITY_INSERT [dbo].[Quiz] ON 

INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (1, CAST(N'2020-06-02 15:25:03.887' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (2, CAST(N'2020-06-02 15:28:13.687' AS DateTime), 7, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (3, CAST(N'2020-06-02 18:24:36.827' AS DateTime), 1, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (4, CAST(N'2020-06-02 18:27:26.933' AS DateTime), 10, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (5, CAST(N'2020-06-02 18:32:28.973' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (6, CAST(N'2020-06-02 18:35:11.207' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (7, CAST(N'2020-06-02 18:35:15.853' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (8, CAST(N'2020-06-02 18:36:00.313' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (9, CAST(N'2020-06-02 18:37:09.210' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (10, CAST(N'2020-06-02 18:41:11.777' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (11, CAST(N'2020-06-02 18:41:58.907' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (12, CAST(N'2020-06-02 18:44:23.830' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (13, CAST(N'2020-06-02 18:46:15.293' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (14, CAST(N'2020-06-02 18:46:24.337' AS DateTime), 8, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (15, CAST(N'2020-06-02 18:49:24.633' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (16, CAST(N'2020-06-02 18:51:31.560' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (17, CAST(N'2020-06-02 18:53:30.697' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (18, CAST(N'2020-06-02 18:54:12.137' AS DateTime), 1, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (19, CAST(N'2020-06-02 18:56:05.657' AS DateTime), 1, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (20, CAST(N'2020-06-02 19:06:03.840' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (21, CAST(N'2020-06-02 19:16:04.317' AS DateTime), 1, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (22, CAST(N'2020-06-02 19:19:16.427' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (23, CAST(N'2020-06-02 19:37:39.847' AS DateTime), 5, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (24, CAST(N'2020-06-02 19:42:39.207' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (25, CAST(N'2020-06-02 19:45:15.447' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (26, CAST(N'2020-06-02 19:45:56.997' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (27, CAST(N'2020-06-02 19:46:13.430' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (28, CAST(N'2020-06-02 19:47:05.370' AS DateTime), 10, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (29, CAST(N'2020-06-02 19:50:11.300' AS DateTime), 1, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (30, CAST(N'2020-06-02 20:23:24.643' AS DateTime), 5, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (31, CAST(N'2020-06-02 20:30:12.360' AS DateTime), 5, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (32, CAST(N'2020-06-02 20:39:41.530' AS DateTime), 0, 1, N'userstudent@gmail.com')
INSERT [dbo].[Quiz] ([QuizId], [CreateDate], [Score], [SubjectId], [Email]) VALUES (33, CAST(N'2020-06-02 22:12:18.320' AS DateTime), 8, 1, N'abcdef@gmail.com')
SET IDENTITY_INSERT [dbo].[Quiz] OFF
SET IDENTITY_INSERT [dbo].[QuizDetail] ON 

INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (1, 1, 10, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (2, 1, 40, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (3, 1, 38, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (4, 1, 13, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (5, 1, 44, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (6, 1, 20, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (7, 1, 26, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (8, 1, 12, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (9, 1, 30, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (10, 1, 43, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (11, 2, 15, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (12, 2, 21, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (13, 2, 4, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (14, 2, 31, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (15, 2, 18, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (16, 2, 27, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (17, 2, 22, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (18, 2, 17, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (19, 2, 29, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (20, 2, 43, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (21, 3, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (22, 3, 7, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (23, 3, 45, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (24, 3, 19, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (25, 3, 33, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (26, 3, 27, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (27, 3, 34, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (28, 3, 26, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (29, 3, 1, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (30, 3, 5, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (31, 4, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (32, 4, 18, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (33, 4, 16, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (34, 4, 41, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (35, 4, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (36, 4, 23, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (37, 4, 2, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (38, 4, 52, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (39, 4, 3, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (40, 4, 19, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (41, 5, 17, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (42, 5, 13, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (43, 5, 52, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (44, 5, 44, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (45, 5, 27, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (46, 5, 41, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (47, 5, 14, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (48, 5, 3, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (49, 5, 31, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (50, 5, 28, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (51, 6, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (52, 6, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (53, 6, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (54, 6, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (55, 6, 35, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (56, 6, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (57, 6, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (58, 6, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (59, 6, 21, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (60, 6, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (61, 7, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (62, 7, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (63, 7, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (64, 7, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (65, 7, 35, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (66, 7, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (67, 7, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (68, 7, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (69, 7, 21, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (70, 7, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (71, 8, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (72, 8, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (73, 8, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (74, 8, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (75, 8, 35, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (76, 8, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (77, 8, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (78, 8, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (79, 8, 21, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (80, 8, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (81, 9, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (82, 9, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (83, 9, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (84, 9, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (85, 9, 35, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (86, 9, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (87, 9, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (88, 9, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (89, 9, 21, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (90, 9, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (91, 10, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (92, 10, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (93, 10, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (94, 10, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (95, 10, 35, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (96, 10, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (97, 10, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (98, 10, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (99, 10, 21, N'C')
GO
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (100, 10, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (101, 11, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (102, 11, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (103, 11, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (104, 11, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (105, 11, 35, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (106, 11, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (107, 11, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (108, 11, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (109, 11, 21, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (110, 11, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (111, 12, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (112, 12, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (113, 12, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (114, 12, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (115, 12, 35, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (116, 12, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (117, 12, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (118, 12, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (119, 12, 21, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (120, 12, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (121, 13, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (122, 13, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (123, 13, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (124, 13, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (125, 13, 35, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (126, 13, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (127, 13, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (128, 13, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (129, 13, 21, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (130, 13, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (131, 14, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (132, 14, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (133, 14, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (134, 14, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (135, 14, 35, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (136, 14, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (137, 14, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (138, 14, 9, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (139, 14, 21, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (140, 14, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (141, 15, 41, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (142, 15, 13, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (143, 15, 15, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (144, 15, 21, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (145, 15, 16, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (146, 15, 33, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (147, 15, 18, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (148, 15, 25, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (149, 15, 38, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (150, 15, 7, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (151, 16, 24, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (152, 16, 3, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (153, 16, 43, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (154, 16, 32, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (155, 16, 31, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (156, 16, 39, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (157, 16, 7, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (158, 16, 28, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (159, 16, 4, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (160, 16, 6, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (161, 17, 24, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (162, 17, 3, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (163, 17, 43, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (164, 17, 32, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (165, 17, 31, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (166, 17, 39, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (167, 17, 7, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (168, 17, 28, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (169, 17, 4, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (170, 17, 6, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (171, 18, 34, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (172, 18, 20, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (173, 18, 43, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (174, 18, 22, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (175, 18, 40, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (176, 18, 42, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (177, 18, 26, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (178, 18, 41, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (179, 18, 29, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (180, 18, 18, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (181, 19, 52, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (182, 19, 31, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (183, 19, 22, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (184, 19, 8, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (185, 19, 23, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (186, 19, 28, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (187, 19, 7, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (188, 19, 27, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (189, 19, 16, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (190, 19, 1, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (191, 20, 45, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (192, 20, 2, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (193, 20, 40, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (194, 20, 5, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (195, 20, 28, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (196, 20, 43, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (197, 20, 44, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (198, 20, 20, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (199, 20, 37, N'A')
GO
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (200, 20, 10, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (201, 21, 28, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (202, 21, 45, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (203, 21, 41, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (204, 21, 6, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (205, 21, 34, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (206, 21, 13, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (207, 21, 36, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (208, 21, 19, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (209, 21, 14, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (210, 21, 27, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (211, 22, 15, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (212, 22, 25, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (213, 22, 32, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (214, 22, 22, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (215, 22, 12, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (216, 22, 39, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (217, 22, 2, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (218, 22, 43, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (219, 22, 27, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (220, 22, 20, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (221, 23, 41, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (222, 23, 43, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (223, 23, 45, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (224, 23, 1, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (225, 23, 6, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (226, 23, 7, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (227, 23, 34, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (228, 23, 28, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (229, 23, 19, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (230, 23, 11, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (231, 24, 18, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (232, 24, 10, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (233, 24, 22, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (234, 24, 34, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (235, 24, 30, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (236, 24, 33, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (237, 24, 6, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (238, 24, 11, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (239, 24, 38, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (240, 24, 21, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (241, 25, 13, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (242, 25, 42, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (243, 25, 39, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (244, 25, 19, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (245, 25, 38, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (246, 25, 1, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (247, 25, 40, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (248, 25, 8, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (249, 25, 26, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (250, 25, 2, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (251, 26, 21, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (252, 26, 18, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (253, 26, 40, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (254, 26, 26, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (255, 26, 10, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (256, 26, 8, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (257, 26, 28, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (258, 26, 37, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (259, 26, 27, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (260, 26, 20, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (261, 27, 23, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (262, 27, 12, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (263, 27, 9, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (264, 27, 40, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (265, 27, 22, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (266, 27, 8, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (267, 27, 16, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (268, 27, 15, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (269, 27, 18, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (270, 27, 38, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (271, 28, 8, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (272, 28, 3, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (273, 28, 37, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (274, 28, 28, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (275, 28, 7, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (276, 28, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (277, 28, 6, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (278, 28, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (279, 28, 10, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (280, 28, 1, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (281, 29, 43, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (282, 29, 17, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (283, 29, 20, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (284, 29, 6, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (285, 29, 23, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (286, 29, 13, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (287, 29, 29, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (288, 29, 30, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (289, 29, 22, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (290, 29, 14, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (291, 30, 25, N'C')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (292, 30, 27, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (293, 30, 4, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (294, 30, 41, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (295, 30, 43, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (296, 30, 2, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (297, 30, 3, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (298, 30, 10, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (299, 30, 38, N'B')
GO
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (300, 30, 26, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (301, 31, 23, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (302, 31, 45, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (303, 31, 44, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (304, 31, 2, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (305, 31, 1, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (306, 31, 33, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (307, 31, 14, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (308, 31, 15, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (309, 31, 12, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (310, 31, 10, N'A')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (311, 32, 12, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (312, 32, 11, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (313, 32, 20, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (314, 32, 35, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (315, 32, 3, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (316, 32, 14, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (317, 32, 1, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (318, 32, 2, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (319, 32, 28, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (320, 32, 34, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (321, 33, 1, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (322, 33, 20, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (323, 33, 15, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (324, 33, 27, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (325, 33, 8, N'D')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (326, 33, 4, N'')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (327, 33, 31, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (328, 33, 5, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (329, 33, 26, N'B')
INSERT [dbo].[QuizDetail] ([QuizDetailId], [QuizId], [QuestionId], [Answer]) VALUES (330, 33, 42, N'B')
SET IDENTITY_INSERT [dbo].[QuizDetail] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [Role]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([RoleId], [Role]) VALUES (2, N'Student')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Status] ON 

INSERT [dbo].[Status] ([StatusId], [Status]) VALUES (1, N'New')
INSERT [dbo].[Status] ([StatusId], [Status]) VALUES (2, N'Active')
INSERT [dbo].[Status] ([StatusId], [Status]) VALUES (3, N'Deactive')
SET IDENTITY_INSERT [dbo].[Status] OFF
SET IDENTITY_INSERT [dbo].[Subject] ON 

INSERT [dbo].[Subject] ([SubjectId], [Code], [Name], [NumberOfQuestion], [Duration]) VALUES (1, N'ENG101', N'English for Beginners', 10, 15)
INSERT [dbo].[Subject] ([SubjectId], [Code], [Name], [NumberOfQuestion], [Duration]) VALUES (2, N'PRJ311', N'Java Desktop Applications', 40, 60)
INSERT [dbo].[Subject] ([SubjectId], [Code], [Name], [NumberOfQuestion], [Duration]) VALUES (3, N'PRJ321', N'Java Web Application', 50, 80)
SET IDENTITY_INSERT [dbo].[Subject] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_QuestionSymbol]    Script Date: 6/2/2020 10:28:19 PM ******/
ALTER TABLE [dbo].[Answer] ADD  CONSTRAINT [UQ_QuestionSymbol] UNIQUE NONCLUSTERED 
(
	[QuestionId] ASC,
	[Symbol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ_IdCode]    Script Date: 6/2/2020 10:28:19 PM ******/
ALTER TABLE [dbo].[Subject] ADD  CONSTRAINT [UQ_IdCode] UNIQUE NONCLUSTERED 
(
	[SubjectId] ASC,
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Role]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD  CONSTRAINT [FK_Account_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Account] CHECK CONSTRAINT [FK_Account_Status]
GO
ALTER TABLE [dbo].[Answer]  WITH CHECK ADD  CONSTRAINT [FK_Answer_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[Answer] CHECK CONSTRAINT [FK_Answer_Question]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Status] FOREIGN KEY([StatusId])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Status]
GO
ALTER TABLE [dbo].[Question]  WITH CHECK ADD  CONSTRAINT [FK_Question_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subject] ([SubjectId])
GO
ALTER TABLE [dbo].[Question] CHECK CONSTRAINT [FK_Question_Subject]
GO
ALTER TABLE [dbo].[Quiz]  WITH CHECK ADD  CONSTRAINT [FK_Quiz_Account] FOREIGN KEY([Email])
REFERENCES [dbo].[Account] ([Email])
GO
ALTER TABLE [dbo].[Quiz] CHECK CONSTRAINT [FK_Quiz_Account]
GO
ALTER TABLE [dbo].[Quiz]  WITH CHECK ADD  CONSTRAINT [FK_Quiz_Subject] FOREIGN KEY([SubjectId])
REFERENCES [dbo].[Subject] ([SubjectId])
GO
ALTER TABLE [dbo].[Quiz] CHECK CONSTRAINT [FK_Quiz_Subject]
GO
ALTER TABLE [dbo].[QuizDetail]  WITH CHECK ADD  CONSTRAINT [FK_QuizDetail_Question] FOREIGN KEY([QuestionId])
REFERENCES [dbo].[Question] ([QuestionId])
GO
ALTER TABLE [dbo].[QuizDetail] CHECK CONSTRAINT [FK_QuizDetail_Question]
GO
ALTER TABLE [dbo].[QuizDetail]  WITH CHECK ADD  CONSTRAINT [FK_QuizDetail_Quiz] FOREIGN KEY([QuizId])
REFERENCES [dbo].[Quiz] ([QuizId])
GO
ALTER TABLE [dbo].[QuizDetail] CHECK CONSTRAINT [FK_QuizDetail_Quiz]
GO
USE [master]
GO
ALTER DATABASE [QuizOnline] SET  READ_WRITE 
GO
