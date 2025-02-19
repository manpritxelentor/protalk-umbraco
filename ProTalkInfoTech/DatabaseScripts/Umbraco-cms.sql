USE [master]
GO
/****** Object:  Database [umbraco-cms]    Script Date: 9/21/2018 8:06:14 PM ******/
CREATE DATABASE [umbraco-cms]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'umbraco-cms', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\umbraco-cms.mdf' , SIZE = 6144KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'umbraco-cms_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\umbraco-cms_log.ldf' , SIZE = 1536KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [umbraco-cms] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [umbraco-cms].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [umbraco-cms] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [umbraco-cms] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [umbraco-cms] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [umbraco-cms] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [umbraco-cms] SET ARITHABORT OFF 
GO
ALTER DATABASE [umbraco-cms] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [umbraco-cms] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [umbraco-cms] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [umbraco-cms] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [umbraco-cms] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [umbraco-cms] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [umbraco-cms] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [umbraco-cms] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [umbraco-cms] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [umbraco-cms] SET  DISABLE_BROKER 
GO
ALTER DATABASE [umbraco-cms] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [umbraco-cms] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [umbraco-cms] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [umbraco-cms] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [umbraco-cms] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [umbraco-cms] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [umbraco-cms] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [umbraco-cms] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [umbraco-cms] SET  MULTI_USER 
GO
ALTER DATABASE [umbraco-cms] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [umbraco-cms] SET DB_CHAINING OFF 
GO
ALTER DATABASE [umbraco-cms] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [umbraco-cms] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [umbraco-cms] SET DELAYED_DURABILITY = DISABLED 
GO
USE [umbraco-cms]
GO
/****** Object:  Table [dbo].[cmsContent]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContent](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[contentType] [int] NOT NULL,
 CONSTRAINT [PK_cmsContent] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentType]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[alias] [nvarchar](255) NULL,
	[icon] [nvarchar](255) NULL,
	[thumbnail] [nvarchar](255) NOT NULL CONSTRAINT [DF_cmsContentType_thumbnail]  DEFAULT ('folder.png'),
	[description] [nvarchar](1500) NULL,
	[isContainer] [bit] NOT NULL CONSTRAINT [DF_cmsContentType_isContainer]  DEFAULT ('0'),
	[allowAtRoot] [bit] NOT NULL CONSTRAINT [DF_cmsContentType_allowAtRoot]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsContentType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentType2ContentType]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentType2ContentType](
	[parentContentTypeId] [int] NOT NULL,
	[childContentTypeId] [int] NOT NULL,
 CONSTRAINT [PK_cmsContentType2ContentType] PRIMARY KEY CLUSTERED 
(
	[parentContentTypeId] ASC,
	[childContentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentTypeAllowedContentType]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentTypeAllowedContentType](
	[Id] [int] NOT NULL,
	[AllowedId] [int] NOT NULL,
	[SortOrder] [int] NOT NULL CONSTRAINT [df_cmsContentTypeAllowedContentType_sortOrder]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsContentTypeAllowedContentType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC,
	[AllowedId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentVersion]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentVersion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ContentId] [int] NOT NULL,
	[VersionId] [uniqueidentifier] NOT NULL,
	[VersionDate] [datetime] NOT NULL CONSTRAINT [DF_cmsContentVersion_VersionDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_cmsContentVersion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsContentXml]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsContentXml](
	[nodeId] [int] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDataType]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDataType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[propertyEditorAlias] [nvarchar](255) NOT NULL,
	[dbType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_cmsDataType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDataTypePreValues]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDataTypePreValues](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[datatypeNodeId] [int] NOT NULL,
	[value] [ntext] NULL,
	[sortorder] [int] NOT NULL,
	[alias] [nvarchar](50) NULL,
 CONSTRAINT [PK_cmsDataTypePreValues] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDictionary]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDictionary](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[parent] [uniqueidentifier] NULL,
	[key] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_cmsDictionary] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDocument]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDocument](
	[nodeId] [int] NOT NULL,
	[published] [bit] NOT NULL,
	[documentUser] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[releaseDate] [datetime] NULL,
	[expireDate] [datetime] NULL,
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_cmsDocument_updateDate]  DEFAULT (getdate()),
	[templateId] [int] NULL,
	[newest] [bit] NOT NULL CONSTRAINT [DF_cmsDocument_newest]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsDocument] PRIMARY KEY CLUSTERED 
(
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsDocumentType]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsDocumentType](
	[contentTypeNodeId] [int] NOT NULL,
	[templateNodeId] [int] NOT NULL,
	[IsDefault] [bit] NOT NULL CONSTRAINT [DF_cmsDocumentType_IsDefault]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsDocumentType] PRIMARY KEY CLUSTERED 
(
	[contentTypeNodeId] ASC,
	[templateNodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsLanguageText]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsLanguageText](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[languageId] [int] NOT NULL,
	[UniqueId] [uniqueidentifier] NOT NULL,
	[value] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsLanguageText] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMacro]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMacro](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[uniqueId] [uniqueidentifier] NOT NULL,
	[macroUseInEditor] [bit] NOT NULL,
	[macroRefreshRate] [int] NOT NULL,
	[macroAlias] [nvarchar](255) NOT NULL,
	[macroName] [nvarchar](255) NULL,
	[macroScriptType] [nvarchar](255) NULL,
	[macroScriptAssembly] [nvarchar](255) NULL,
	[macroXSLT] [nvarchar](255) NULL,
	[macroCacheByPage] [bit] NOT NULL,
	[macroCachePersonalized] [bit] NOT NULL,
	[macroDontRender] [bit] NOT NULL,
	[macroPython] [nvarchar](255) NULL,
 CONSTRAINT [PK_cmsMacro] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMacroProperty]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMacroProperty](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[uniquePropertyId] [uniqueidentifier] NOT NULL,
	[editorAlias] [nvarchar](255) NOT NULL,
	[macro] [int] NOT NULL,
	[macroPropertySortOrder] [int] NOT NULL,
	[macroPropertyAlias] [nvarchar](50) NOT NULL,
	[macroPropertyName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cmsMacroProperty] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMedia]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMedia](
	[nodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[mediaPath] [nvarchar](255) NULL,
 CONSTRAINT [PK_cmsMedia] PRIMARY KEY CLUSTERED 
(
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMember]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMember](
	[nodeId] [int] NOT NULL,
	[Email] [nvarchar](1000) NOT NULL,
	[LoginName] [nvarchar](1000) NOT NULL,
	[Password] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_cmsMember] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMember2MemberGroup]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMember2MemberGroup](
	[Member] [int] NOT NULL,
	[MemberGroup] [int] NOT NULL,
 CONSTRAINT [PK_cmsMember2MemberGroup] PRIMARY KEY CLUSTERED 
(
	[Member] ASC,
	[MemberGroup] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsMemberType]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsMemberType](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[NodeId] [int] NOT NULL,
	[propertytypeId] [int] NOT NULL,
	[memberCanEdit] [bit] NOT NULL CONSTRAINT [DF_cmsMemberType_memberCanEdit]  DEFAULT ('0'),
	[viewOnProfile] [bit] NOT NULL CONSTRAINT [DF_cmsMemberType_viewOnProfile]  DEFAULT ('0'),
	[isSensitive] [bit] NOT NULL CONSTRAINT [DF_cmsMemberType_isSensitive]  DEFAULT ('0'),
 CONSTRAINT [PK_cmsMemberType] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPreviewXml]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPreviewXml](
	[nodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NOT NULL,
	[timestamp] [datetime] NOT NULL,
	[xml] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsContentPreviewXml] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyData]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyData](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contentNodeId] [int] NOT NULL,
	[versionId] [uniqueidentifier] NULL,
	[propertytypeid] [int] NOT NULL,
	[dataInt] [int] NULL,
	[dataDecimal] [decimal](38, 6) NULL,
	[dataDate] [datetime] NULL,
	[dataNvarchar] [nvarchar](500) NULL,
	[dataNtext] [ntext] NULL,
 CONSTRAINT [PK_cmsPropertyData] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyType]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dataTypeId] [int] NOT NULL,
	[contentTypeId] [int] NOT NULL,
	[propertyTypeGroupId] [int] NULL,
	[Alias] [nvarchar](255) NOT NULL,
	[Name] [nvarchar](255) NULL,
	[sortOrder] [int] NOT NULL CONSTRAINT [DF_cmsPropertyType_sortOrder]  DEFAULT ('0'),
	[mandatory] [bit] NOT NULL CONSTRAINT [DF_cmsPropertyType_mandatory]  DEFAULT ('0'),
	[validationRegExp] [nvarchar](255) NULL,
	[Description] [nvarchar](2000) NULL,
	[UniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_cmsPropertyType_UniqueID]  DEFAULT (newid()),
 CONSTRAINT [PK_cmsPropertyType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsPropertyTypeGroup]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsPropertyTypeGroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[contenttypeNodeId] [int] NOT NULL,
	[text] [nvarchar](255) NOT NULL,
	[sortorder] [int] NOT NULL,
	[uniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_cmsPropertyTypeGroup_uniqueID]  DEFAULT (newid()),
 CONSTRAINT [PK_cmsPropertyTypeGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTagRelationship]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTagRelationship](
	[nodeId] [int] NOT NULL,
	[tagId] [int] NOT NULL,
	[propertyTypeId] [int] NOT NULL,
 CONSTRAINT [PK_cmsTagRelationship] PRIMARY KEY CLUSTERED 
(
	[nodeId] ASC,
	[propertyTypeId] ASC,
	[tagId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTags]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTags](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tag] [nvarchar](200) NULL,
	[ParentId] [int] NULL,
	[group] [nvarchar](100) NULL,
 CONSTRAINT [PK_cmsTags] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTask]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTask](
	[closed] [bit] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[taskTypeId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[parentUserId] [int] NOT NULL,
	[userId] [int] NOT NULL,
	[DateTime] [datetime] NOT NULL,
	[Comment] [nvarchar](500) NULL,
 CONSTRAINT [PK_cmsTask] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTaskType]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTaskType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[alias] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_cmsTaskType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cmsTemplate]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cmsTemplate](
	[pk] [int] IDENTITY(1,1) NOT NULL,
	[nodeId] [int] NOT NULL,
	[alias] [nvarchar](100) NULL,
	[design] [ntext] NOT NULL,
 CONSTRAINT [PK_cmsTemplate] PRIMARY KEY CLUSTERED 
(
	[pk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoAccess]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoAccess](
	[id] [uniqueidentifier] NOT NULL,
	[nodeId] [int] NOT NULL,
	[loginNodeId] [int] NOT NULL,
	[noAccessNodeId] [int] NOT NULL,
	[createDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoAccess] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoAccessRule]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoAccessRule](
	[id] [uniqueidentifier] NOT NULL,
	[accessId] [uniqueidentifier] NOT NULL,
	[ruleValue] [nvarchar](255) NOT NULL,
	[ruleType] [nvarchar](255) NOT NULL,
	[createDate] [datetime] NOT NULL,
	[updateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoAccessRule] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoAudit]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoAudit](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[performingUserId] [int] NOT NULL,
	[performingDetails] [nvarchar](1024) NULL,
	[performingIp] [nvarchar](64) NULL,
	[eventDateUtc] [datetime] NOT NULL CONSTRAINT [DF_umbracoAudit_eventDateUtc]  DEFAULT (getdate()),
	[affectedUserId] [int] NOT NULL,
	[affectedDetails] [nvarchar](1024) NULL,
	[eventType] [nvarchar](256) NOT NULL,
	[eventDetails] [nvarchar](1024) NULL,
 CONSTRAINT [PK_umbracoAudit] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoCacheInstruction]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoCacheInstruction](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[utcStamp] [datetime] NOT NULL,
	[jsonInstruction] [ntext] NOT NULL,
	[originated] [nvarchar](500) NOT NULL,
	[instructionCount] [int] NOT NULL CONSTRAINT [DF_umbracoCacheInstruction_instructionCount]  DEFAULT ('1'),
 CONSTRAINT [PK_umbracoCacheInstruction] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoConsent]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoConsent](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[current] [bit] NOT NULL,
	[source] [nvarchar](512) NOT NULL,
	[context] [nvarchar](128) NOT NULL,
	[action] [nvarchar](512) NOT NULL,
	[createDate] [datetime] NOT NULL,
	[state] [int] NOT NULL,
	[comment] [nvarchar](255) NULL,
 CONSTRAINT [PK_umbracoConsent] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoDomains]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoDomains](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[domainDefaultLanguage] [int] NULL,
	[domainRootStructureID] [int] NULL,
	[domainName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_umbracoDomains] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoExternalLogin]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoExternalLogin](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[loginProvider] [nvarchar](4000) NOT NULL,
	[providerKey] [nvarchar](4000) NOT NULL,
	[createDate] [datetime] NOT NULL,
 CONSTRAINT [PK_umbracoExternalLogin] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLanguage]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLanguage](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[languageISOCode] [nvarchar](14) NULL,
	[languageCultureName] [nvarchar](100) NULL,
 CONSTRAINT [PK_umbracoLanguage] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLock]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLock](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[value] [int] NOT NULL,
	[name] [nvarchar](64) NOT NULL,
 CONSTRAINT [PK_umbracoLock] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoLog]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[NodeId] [int] NOT NULL,
	[Datestamp] [datetime] NOT NULL CONSTRAINT [DF_umbracoLog_Datestamp]  DEFAULT (getdate()),
	[logHeader] [nvarchar](50) NOT NULL,
	[logComment] [nvarchar](4000) NULL,
 CONSTRAINT [PK_umbracoLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoMigration]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoMigration](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoMigration_createDate]  DEFAULT (getdate()),
	[version] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_umbracoMigration] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoNode]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoNode](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[trashed] [bit] NOT NULL CONSTRAINT [DF_umbracoNode_trashed]  DEFAULT ('0'),
	[parentID] [int] NOT NULL,
	[nodeUser] [int] NULL,
	[level] [int] NOT NULL,
	[path] [nvarchar](150) NOT NULL,
	[sortOrder] [int] NOT NULL,
	[uniqueID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_umbracoNode_uniqueID]  DEFAULT (newid()),
	[text] [nvarchar](255) NULL,
	[nodeObjectType] [uniqueidentifier] NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoNode_createDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_structure] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRedirectUrl]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRedirectUrl](
	[id] [uniqueidentifier] NOT NULL,
	[contentKey] [uniqueidentifier] NOT NULL,
	[createDateUtc] [datetime] NOT NULL,
	[url] [nvarchar](255) NOT NULL,
	[urlHash] [nvarchar](40) NOT NULL,
 CONSTRAINT [PK_umbracoRedirectUrl] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRelation]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRelation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[parentId] [int] NOT NULL,
	[childId] [int] NOT NULL,
	[relType] [int] NOT NULL,
	[datetime] [datetime] NOT NULL,
	[comment] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_umbracoRelation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoRelationType]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoRelationType](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[typeUniqueId] [uniqueidentifier] NOT NULL,
	[dual] [bit] NOT NULL,
	[parentObjectType] [uniqueidentifier] NOT NULL,
	[childObjectType] [uniqueidentifier] NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[alias] [nvarchar](100) NULL,
 CONSTRAINT [PK_umbracoRelationType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoServer]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoServer](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[address] [nvarchar](500) NOT NULL,
	[computerName] [nvarchar](255) NOT NULL,
	[registeredDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoServer_registeredDate]  DEFAULT (getdate()),
	[lastNotifiedDate] [datetime] NOT NULL,
	[isActive] [bit] NOT NULL,
	[isMaster] [bit] NOT NULL,
 CONSTRAINT [PK_umbracoServer] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userDisabled] [bit] NOT NULL CONSTRAINT [DF_umbracoUser_userDisabled]  DEFAULT ('0'),
	[userNoConsole] [bit] NOT NULL CONSTRAINT [DF_umbracoUser_userNoConsole]  DEFAULT ('0'),
	[userName] [nvarchar](255) NOT NULL,
	[userLogin] [nvarchar](125) NOT NULL,
	[userPassword] [nvarchar](500) NOT NULL,
	[passwordConfig] [nvarchar](500) NULL,
	[userEmail] [nvarchar](255) NOT NULL,
	[userLanguage] [nvarchar](10) NULL,
	[securityStampToken] [nvarchar](255) NULL,
	[failedLoginAttempts] [int] NULL,
	[lastLockoutDate] [datetime] NULL,
	[lastPasswordChangeDate] [datetime] NULL,
	[lastLoginDate] [datetime] NULL,
	[emailConfirmedDate] [datetime] NULL,
	[invitedDate] [datetime] NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoUser_createDate]  DEFAULT (getdate()),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoUser_updateDate]  DEFAULT (getdate()),
	[avatar] [nvarchar](500) NULL,
	[tourData] [ntext] NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2NodeNotify]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2NodeNotify](
	[userId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[action] [nchar](1) NOT NULL,
 CONSTRAINT [PK_umbracoUser2NodeNotify] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[nodeId] ASC,
	[action] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUser2UserGroup]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUser2UserGroup](
	[userId] [int] NOT NULL,
	[userGroupId] [int] NOT NULL,
 CONSTRAINT [PK_user2userGroup] PRIMARY KEY CLUSTERED 
(
	[userId] ASC,
	[userGroupId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUserGroup]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUserGroup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userGroupAlias] [nvarchar](200) NOT NULL,
	[userGroupName] [nvarchar](200) NOT NULL,
	[userGroupDefaultPermissions] [nvarchar](50) NULL,
	[createDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoUserGroup_createDate]  DEFAULT (getdate()),
	[updateDate] [datetime] NOT NULL CONSTRAINT [DF_umbracoUserGroup_updateDate]  DEFAULT (getdate()),
	[icon] [nvarchar](255) NULL,
	[startContentId] [int] NULL,
	[startMediaId] [int] NULL,
 CONSTRAINT [PK_umbracoUserGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUserGroup2App]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUserGroup2App](
	[userGroupId] [int] NOT NULL,
	[app] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_userGroup2App] PRIMARY KEY CLUSTERED 
(
	[userGroupId] ASC,
	[app] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUserGroup2NodePermission]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUserGroup2NodePermission](
	[userGroupId] [int] NOT NULL,
	[nodeId] [int] NOT NULL,
	[permission] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_umbracoUserGroup2NodePermission] PRIMARY KEY CLUSTERED 
(
	[userGroupId] ASC,
	[nodeId] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUserLogin]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUserLogin](
	[sessionId] [uniqueidentifier] NOT NULL,
	[userId] [int] NOT NULL,
	[loggedInUtc] [datetime] NOT NULL,
	[lastValidatedUtc] [datetime] NOT NULL,
	[loggedOutUtc] [datetime] NULL,
	[ipAddress] [nvarchar](255) NULL,
 CONSTRAINT [PK_umbracoUserLogin] PRIMARY KEY CLUSTERED 
(
	[sessionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[umbracoUserStartNode]    Script Date: 9/21/2018 8:06:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[umbracoUserStartNode](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[userId] [int] NOT NULL,
	[startNode] [int] NOT NULL,
	[startNodeType] [int] NOT NULL,
 CONSTRAINT [PK_userStartNode] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[cmsContent] ON 

INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (1, 1053, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (2, 1054, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (3, 1055, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (4, 1056, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (5, 1057, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (6, 1058, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (7, 1059, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (8, 1060, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (9, 1061, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (10, 1062, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (11, 1063, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (12, 1064, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (13, 1065, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (14, 1066, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (15, 1067, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (16, 1068, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (17, 1069, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (18, 1070, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (19, 1071, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (20, 1072, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (21, 1073, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (22, 1074, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (23, 1075, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (24, 1076, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (25, 1077, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (26, 1078, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (27, 1079, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (28, 1080, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (29, 1081, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (30, 1082, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (31, 1083, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (32, 1084, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (33, 1085, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (34, 1086, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (35, 1087, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (36, 1088, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (37, 1089, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (38, 1090, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (39, 1091, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (40, 1092, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (41, 1093, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (42, 1094, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (43, 1095, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (44, 1096, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (45, 1097, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (46, 1098, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (47, 1099, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (48, 1100, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (49, 1101, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (50, 1102, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (51, 1103, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (52, 1104, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (53, 1105, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (54, 1106, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (55, 1107, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (56, 1108, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (57, 1109, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (58, 1110, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (59, 1111, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (60, 1112, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (61, 1113, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (62, 1114, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (63, 1115, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (64, 1116, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (65, 1117, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (66, 1118, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (67, 1119, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (68, 1120, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (69, 1121, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (70, 1122, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (71, 1123, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (72, 1124, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (73, 1125, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (74, 1126, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (75, 1127, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (76, 1128, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (77, 1129, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (78, 1130, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (79, 1131, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (80, 1132, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (81, 1133, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (82, 1134, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (83, 1135, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (84, 1136, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (85, 1137, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (86, 1138, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (87, 1139, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (88, 1140, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (89, 1141, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (90, 1142, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (91, 1143, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (92, 1144, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (93, 1145, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (94, 1146, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (95, 1147, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (96, 1148, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (97, 1149, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (98, 1150, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (99, 1151, 1032)
GO
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (100, 1152, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (101, 1153, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (102, 1154, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (103, 1155, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (104, 1156, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (105, 1157, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (106, 1158, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (107, 1159, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (108, 1160, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (109, 1161, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (110, 1162, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (111, 1163, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (112, 1164, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (113, 1165, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (114, 1166, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (115, 1167, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (116, 1168, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (117, 1169, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (118, 1170, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (119, 1171, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (120, 1172, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (121, 1173, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (122, 1174, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (123, 1175, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (124, 1176, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (125, 1177, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (126, 1178, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (127, 1179, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (128, 1180, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (129, 1181, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (130, 1182, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (131, 1183, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (132, 1184, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (133, 1185, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (134, 1186, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (135, 1187, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (136, 1188, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (137, 1189, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (138, 1190, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (139, 1191, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (140, 1192, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (141, 1193, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (142, 1194, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (143, 1195, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (144, 1196, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (145, 1197, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (146, 1198, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (147, 1199, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (148, 1200, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (149, 1201, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (150, 1202, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (151, 1203, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (152, 1204, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (153, 1205, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (154, 1206, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (155, 1207, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (156, 1208, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (157, 1209, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (158, 1210, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (159, 1211, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (160, 1212, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (161, 1213, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (162, 1214, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (163, 1215, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (164, 1216, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (165, 1217, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (166, 1218, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (167, 1219, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (168, 1220, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (169, 1221, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (170, 1222, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (171, 1223, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (172, 1224, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (173, 1225, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (174, 1226, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (175, 1227, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (176, 1228, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (177, 1229, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (178, 1230, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (179, 1231, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (180, 1232, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (181, 1233, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (182, 1234, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (183, 1235, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (184, 1236, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (185, 1237, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (186, 1238, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (187, 1239, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (188, 1240, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (189, 1241, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (190, 1242, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (191, 1243, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (192, 1244, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (193, 1245, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (194, 1246, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (195, 1247, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (196, 1248, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (197, 1249, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (198, 1250, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (199, 1251, 1032)
GO
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (200, 1252, 1031)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (201, 1253, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (202, 1254, 1032)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (205, 1271, 1270)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (206, 1278, 1277)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (207, 1279, 1277)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (208, 1280, 1277)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (210, 1295, 1288)
INSERT [dbo].[cmsContent] ([pk], [nodeId], [contentType]) VALUES (212, 1300, 1299)
SET IDENTITY_INSERT [dbo].[cmsContent] OFF
SET IDENTITY_INSERT [dbo].[cmsContentType] ON 

INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (531, 1044, N'Member', N'icon-user', N'icon-user', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (532, 1031, N'Folder', N'icon-folder', N'icon-folder', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (533, 1032, N'Image', N'icon-picture', N'icon-picture', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (534, 1033, N'File', N'icon-document', N'icon-document', NULL, 0, 1)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (540, 1270, N'home', N'icon-document', N'folder.png', NULL, 1, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (542, 1277, N'slide', N'icon-document', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (545, 1288, N'testimonial', N'icon-document', N'folder.png', NULL, 0, 0)
INSERT [dbo].[cmsContentType] ([pk], [nodeId], [alias], [icon], [thumbnail], [description], [isContainer], [allowAtRoot]) VALUES (547, 1299, N'homeService', N'icon-document', N'folder.png', NULL, 0, 0)
SET IDENTITY_INSERT [dbo].[cmsContentType] OFF
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1031, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1032, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1031, 1033, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1270, 1277, 0)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1270, 1288, 1)
INSERT [dbo].[cmsContentTypeAllowedContentType] ([Id], [AllowedId], [SortOrder]) VALUES (1270, 1299, 2)
SET IDENTITY_INSERT [dbo].[cmsContentVersion] ON 

INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (1, 1053, N'26594e32-d38d-4f07-bd8c-7df26546123f', CAST(N'2018-09-16 16:55:15.823' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (2, 1054, N'd60baa69-5f48-481a-bdf9-a72f1746f673', CAST(N'2018-09-16 16:09:17.060' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (3, 1055, N'ac154484-84b3-460b-aea2-906cf11bd839', CAST(N'2018-09-16 16:09:17.650' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (4, 1056, N'6c9487ac-d778-4de7-a283-2ec6886662e9', CAST(N'2018-09-16 16:09:17.950' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (5, 1057, N'92d55cc6-c718-410b-82d4-0b4af1c3f4e4', CAST(N'2018-09-16 16:09:18.190' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (6, 1058, N'c5632580-c8d0-438f-a338-22edfdc6b978', CAST(N'2018-09-16 16:09:18.357' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (7, 1059, N'054d97c2-989d-41de-af54-0d846ede6580', CAST(N'2018-09-16 16:09:18.513' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (8, 1060, N'3cb6b94f-7635-47ec-992d-e21ecdaee282', CAST(N'2018-09-16 16:09:18.660' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (9, 1061, N'2176049f-1054-440a-a47b-db81b81ba643', CAST(N'2018-09-16 16:09:18.797' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (10, 1062, N'c9a46361-24e6-4fef-be13-08455eca96c2', CAST(N'2018-09-16 16:09:18.967' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (11, 1063, N'110e107f-fe79-40e4-8cb7-240f006d3949', CAST(N'2018-09-16 16:09:19.133' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (12, 1064, N'bf2b6b88-ada8-4c88-ba04-54b12862082d', CAST(N'2018-09-16 16:09:19.283' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (13, 1065, N'19340365-d912-47f8-9035-ce0065d8daf7', CAST(N'2018-09-16 16:09:19.430' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (14, 1066, N'a9517379-d1e3-43b5-bb88-598ad1e08238', CAST(N'2018-09-16 16:09:19.577' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (15, 1067, N'c9cf1d27-30f6-473f-8c4d-77e4f1b67230', CAST(N'2018-09-16 16:09:19.767' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (16, 1068, N'c822de32-782d-491e-a25b-2ca10e741a00', CAST(N'2018-09-16 16:09:19.900' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (17, 1069, N'9195b7be-8277-4be5-a4eb-aaa89967fc83', CAST(N'2018-09-16 16:09:20.083' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (18, 1070, N'a22386fc-09d1-4fc8-9ed6-e760cc5c80bf', CAST(N'2018-09-16 16:09:20.217' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (19, 1071, N'82cf3193-e395-47aa-9fd5-8416babb5807', CAST(N'2018-09-16 16:09:20.350' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (20, 1072, N'2c4cd807-7982-4751-a704-25c7868a07dc', CAST(N'2018-09-16 16:09:20.563' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (21, 1073, N'81b12032-50b6-452c-adb5-561cf13b67e4', CAST(N'2018-09-16 16:09:20.677' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (22, 1074, N'81d0900c-c32f-4d68-aad6-20a9dd6315d0', CAST(N'2018-09-16 16:09:20.830' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (23, 1075, N'5395e7ad-5c38-433c-899b-ec9dcc60b832', CAST(N'2018-09-16 16:09:20.973' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (24, 1076, N'0e4cb31c-64a0-4e8b-8ed9-f92676dac8af', CAST(N'2018-09-16 16:09:21.113' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (25, 1077, N'c211e5f4-b789-4a76-8475-aeb2c827d821', CAST(N'2018-09-16 16:09:21.283' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (26, 1078, N'23f94c5f-0129-4752-a217-cc5d3ec51962', CAST(N'2018-09-16 16:09:21.590' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (27, 1079, N'205a8625-3d18-4419-a95f-bb9327b07e96', CAST(N'2018-09-16 16:09:21.707' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (28, 1080, N'6c5de08e-89d3-4994-86f4-685cad9e48da', CAST(N'2018-09-16 16:09:21.853' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (29, 1081, N'8e858f5b-3d5c-44cb-9d35-351396e335a6', CAST(N'2018-09-16 16:09:22.067' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (30, 1082, N'b50f2825-43aa-476a-878d-8c0d7478a358', CAST(N'2018-09-16 16:09:22.270' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (31, 1083, N'ce0ef4aa-4b33-45b0-bec7-51d21bc7eabc', CAST(N'2018-09-16 16:09:22.550' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (32, 1084, N'e4cd815e-ef9f-48ec-8c5d-40138a81fe73', CAST(N'2018-09-16 16:09:22.693' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (33, 1085, N'82ebddd9-ffba-4965-9209-46c39211800d', CAST(N'2018-09-16 16:09:22.877' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (34, 1086, N'99322637-8024-4050-a272-84258f6fa0a1', CAST(N'2018-09-16 16:09:23.130' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (35, 1087, N'd8edac73-8c7f-4f78-94e5-39a904b0ccbd', CAST(N'2018-09-16 16:09:23.307' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (36, 1088, N'b562578f-d187-4e31-b50b-c03f249c51de', CAST(N'2018-09-16 16:09:23.357' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (37, 1089, N'159a2119-afdd-440f-8ff1-ae913a69369c', CAST(N'2018-09-16 16:09:23.563' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (38, 1090, N'f5522789-69c9-4dfd-9b98-9a7b26aa2025', CAST(N'2018-09-16 16:09:23.750' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (39, 1091, N'acdcec44-17a1-487f-8e19-34f131a4cf85', CAST(N'2018-09-16 16:09:23.900' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (40, 1092, N'506951d3-28d5-4564-aab4-7cf682305278', CAST(N'2018-09-16 16:09:24.037' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (41, 1093, N'3cd3576c-d622-4fa4-80e9-6635219e7423', CAST(N'2018-09-16 16:09:24.260' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (42, 1094, N'57e83026-9ed2-4510-ad6f-f70362728c64', CAST(N'2018-09-16 16:09:24.443' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (43, 1095, N'1915c75d-0e3b-4c31-a747-2abee5f6efdc', CAST(N'2018-09-16 16:09:24.580' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (44, 1096, N'7852ef0e-8536-4dd0-9b99-9d9f3d83aa3c', CAST(N'2018-09-16 16:09:24.660' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (45, 1097, N'9adb313e-8acc-4bea-a820-7f8cd2c02a9e', CAST(N'2018-09-16 16:09:24.783' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (46, 1098, N'90fc6434-ad02-4dc0-bc18-810dbc124176', CAST(N'2018-09-16 16:09:24.870' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (47, 1099, N'e38ceedf-323a-404d-a866-dcfc66795cd1', CAST(N'2018-09-16 16:09:25.020' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (48, 1100, N'cddc6332-9dff-44c6-ba5e-788de6b474ba', CAST(N'2018-09-16 16:09:25.070' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (49, 1101, N'eb7a2faa-1815-4755-9f11-f7dc0e6c8188', CAST(N'2018-09-16 16:09:25.203' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (50, 1102, N'55886177-f090-4418-a4e9-1b0b119696d0', CAST(N'2018-09-16 16:09:25.380' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (51, 1103, N'd2460cdc-d8ec-47f3-867a-790a4f169fbe', CAST(N'2018-09-16 16:09:25.690' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (52, 1104, N'5db0a1dd-9564-4efa-b20e-d2b2b1b20ab9', CAST(N'2018-09-16 16:09:25.833' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (53, 1105, N'a3057356-c10e-4ba3-83c4-5e1462804437', CAST(N'2018-09-16 16:09:25.967' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (54, 1106, N'3c20340d-7c25-4003-8d96-49f21a4f392b', CAST(N'2018-09-16 16:09:26.107' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (55, 1107, N'f8a4fc47-e322-4a36-942d-e3cec553a3ee', CAST(N'2018-09-16 16:09:26.173' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (56, 1108, N'd5be2efb-30ee-4ac6-9f34-22317d5032ab', CAST(N'2018-09-16 16:09:26.393' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (57, 1109, N'8085aa49-3f5e-4f29-a401-cad4cfa42cba', CAST(N'2018-09-16 16:09:26.557' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (58, 1110, N'52fe26f2-8b48-4862-a4f4-925df3649a28', CAST(N'2018-09-16 16:09:26.670' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (59, 1111, N'fa47547b-ae5c-4d6e-9749-653b5fd8b36f', CAST(N'2018-09-16 16:09:26.803' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (60, 1112, N'c1a7446c-6cc6-4e5e-b2e7-ecb0adce2179', CAST(N'2018-09-16 16:09:26.947' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (61, 1113, N'0a4547dc-be60-4add-9383-e04b4a04d8ba', CAST(N'2018-09-16 16:09:27.113' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (62, 1114, N'623895ec-42bd-47a6-b275-df22936e66b3', CAST(N'2018-09-16 16:09:27.230' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (63, 1115, N'319214b9-e742-4074-bb01-4c66f641e5da', CAST(N'2018-09-16 16:09:27.363' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (64, 1116, N'6f2f35b5-5e95-45a0-a955-cce6fe262921', CAST(N'2018-09-16 16:09:27.480' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (65, 1117, N'44ca142f-9b54-4e48-81d8-4c91388d8fea', CAST(N'2018-09-16 16:09:27.597' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (66, 1118, N'42d0a23a-19a2-43eb-950e-4b2b5a8d0095', CAST(N'2018-09-16 16:09:27.703' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (67, 1119, N'fe95964b-bf31-4e56-b6c9-2217f502f135', CAST(N'2018-09-16 16:09:27.807' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (68, 1120, N'b8016f88-47ee-4504-b144-c200cc115aca', CAST(N'2018-09-16 16:09:27.910' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (69, 1121, N'856204ec-bb55-4619-bb61-6cfd35660b1e', CAST(N'2018-09-16 16:09:28.090' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (70, 1122, N'9c28e941-5887-4de2-9859-0e4cfa7407ab', CAST(N'2018-09-16 16:09:28.197' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (71, 1123, N'a6ea4c08-0e72-4178-8d35-f9007f729f64', CAST(N'2018-09-16 16:09:28.220' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (72, 1124, N'893e2c0d-f18c-43b1-b2b8-625afd8c230e', CAST(N'2018-09-16 16:09:28.343' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (73, 1125, N'f2f36cd0-3697-4baa-88e5-962667acfa7b', CAST(N'2018-09-16 16:09:28.463' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (74, 1126, N'a153cb18-347a-4b85-b351-ac0d60a00690', CAST(N'2018-09-16 16:09:28.600' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (75, 1127, N'96eabbe0-dc5f-48b1-a507-e181530238f4', CAST(N'2018-09-16 16:09:28.723' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (76, 1128, N'dbf60c29-53de-40de-b88d-f9e4bb8e22ee', CAST(N'2018-09-16 16:09:28.867' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (77, 1129, N'57e65cee-3c86-43dc-90ae-36f34d611c3b', CAST(N'2018-09-16 16:09:28.937' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (78, 1130, N'ca851d91-b23d-4336-a864-08049b374146', CAST(N'2018-09-16 16:09:29.237' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (79, 1131, N'74c77fcb-df27-485a-b476-4990cf3fba45', CAST(N'2018-09-16 16:09:30.130' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (80, 1132, N'f49bb6d1-91dc-4d05-bfd3-b24fbd4c2435', CAST(N'2018-09-16 16:09:30.837' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (81, 1133, N'43499b8c-f456-410a-8b7e-64ab037c0d8d', CAST(N'2018-09-16 16:09:30.867' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (82, 1134, N'f185dc89-e737-4857-8f5b-073047337f02', CAST(N'2018-09-16 16:09:31.537' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (83, 1135, N'bec81464-1d0a-4cae-825c-91903f3c8d46', CAST(N'2018-09-16 16:09:31.793' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (84, 1136, N'2b787eed-2509-463a-950d-fdaee2d2a9bc', CAST(N'2018-09-16 16:09:31.933' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (85, 1137, N'da789e58-8be2-4eda-9587-62d7e188918b', CAST(N'2018-09-16 16:09:32.597' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (86, 1138, N'1d6ae236-d943-4cd3-9600-9cf979100f35', CAST(N'2018-09-16 16:09:32.747' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (87, 1139, N'61c2e5ea-38f2-41ee-9b0d-42c8169fafe6', CAST(N'2018-09-16 16:09:32.863' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (88, 1140, N'8541f239-3909-45a3-92f3-7f525b54ad50', CAST(N'2018-09-16 16:09:33.463' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (89, 1141, N'00f22160-51b5-4097-8c92-65c747ec6b8b', CAST(N'2018-09-16 16:09:33.627' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (90, 1142, N'bc4cc61d-95ae-4748-b190-c08308b74bec', CAST(N'2018-09-16 16:09:34.283' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (91, 1143, N'2026df61-6ca9-438d-98dd-de87123dde2d', CAST(N'2018-09-16 16:09:34.437' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (92, 1144, N'95539d76-49a4-4c62-8e5e-4b3841f31491', CAST(N'2018-09-16 16:09:34.533' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (93, 1145, N'8cf2a3fd-094e-43a0-8a98-c48bbd9afc31', CAST(N'2018-09-16 16:09:34.670' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (94, 1146, N'7e6ccc0f-d6b8-4b05-b3ed-9691c21bb658', CAST(N'2018-09-16 16:09:34.777' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (95, 1147, N'116f2fb8-0b18-4ce6-a1ad-f5de584a6687', CAST(N'2018-09-16 16:09:34.877' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (96, 1148, N'7d08f76e-1ca2-419a-a21b-2ff6676bcba6', CAST(N'2018-09-16 16:09:34.967' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (97, 1149, N'ec122e97-ac76-498d-89fc-5eeeada961c4', CAST(N'2018-09-16 16:09:35.077' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (98, 1150, N'a35befe0-af0f-4475-9ed7-10a0f832f905', CAST(N'2018-09-16 16:09:35.213' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (99, 1151, N'426c66ac-7fd4-42df-91ba-53c5f195afbe', CAST(N'2018-09-16 16:09:35.253' AS DateTime))
GO
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (100, 1152, N'c63da573-dc88-4985-b848-74923efc48da', CAST(N'2018-09-16 16:09:35.367' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (101, 1153, N'be1185a4-dab2-4909-9fa1-d3d5e18ba588', CAST(N'2018-09-16 16:09:35.477' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (102, 1154, N'324102d5-ac20-4c8c-bcc4-4dba55697ef1', CAST(N'2018-09-16 16:09:35.503' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (103, 1155, N'ab871d36-44b2-427d-ae8f-6e4709c86530', CAST(N'2018-09-16 16:09:35.683' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (104, 1156, N'750ccfbe-728e-4c18-b48a-a8f11ed7a05f', CAST(N'2018-09-16 16:09:35.803' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (105, 1157, N'd4f9630c-1aea-4d0b-b08e-54abae55a72d', CAST(N'2018-09-16 16:09:35.927' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (106, 1158, N'0d8b6a0a-e4c8-47e4-89cf-38875bdb0a8a', CAST(N'2018-09-16 16:09:36.030' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (107, 1159, N'08d0d28a-629f-4c25-b798-320ee136f09d', CAST(N'2018-09-16 16:09:36.210' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (108, 1160, N'bcaab792-070c-4e47-b2bd-72efef6a3738', CAST(N'2018-09-16 16:09:36.333' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (109, 1161, N'62ebe452-e2e1-4ff2-9c2a-be1cbc2c54db', CAST(N'2018-09-16 16:09:36.457' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (110, 1162, N'e318522a-da70-42c9-9bef-e7b7f9929a39', CAST(N'2018-09-16 16:09:36.600' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (111, 1163, N'd905ede1-105b-4e5a-9698-b595b381954a', CAST(N'2018-09-16 16:09:36.830' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (112, 1164, N'0896544c-c8cc-4d96-8eb9-0d17066190e5', CAST(N'2018-09-16 16:09:36.953' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (113, 1165, N'c0c38d10-aaf5-464d-8ac9-9470f5656135', CAST(N'2018-09-16 16:09:37.110' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (114, 1166, N'a0bb59ab-f760-4ccf-bbac-effdf0d81a38', CAST(N'2018-09-16 16:09:37.273' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (115, 1167, N'857a6063-af42-4ac8-97ce-dc1ddf2f100b', CAST(N'2018-09-16 16:09:37.407' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (116, 1168, N'1335e95a-4f0e-4541-ad9d-da3935268c15', CAST(N'2018-09-16 16:09:37.547' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (117, 1169, N'4a4ff14c-15a8-45f1-986a-445bb8658e4e', CAST(N'2018-09-16 16:09:37.837' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (118, 1170, N'96ed0972-4b36-4529-86fc-9a14082d68f9', CAST(N'2018-09-16 16:09:37.997' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (119, 1171, N'821996ff-b0a0-48b3-a59d-508d90a26a3f', CAST(N'2018-09-16 16:09:38.187' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (120, 1172, N'434dc18e-a1be-4678-a015-7d3406098c63', CAST(N'2018-09-16 16:09:38.437' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (121, 1173, N'568ece08-48b1-4bb1-aded-151687a3fcd4', CAST(N'2018-09-16 16:09:38.727' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (122, 1174, N'ac1fc696-49da-4205-bd1d-5d45df3d6720', CAST(N'2018-09-16 16:09:38.887' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (123, 1175, N'8ca657ef-7d56-44a8-b780-b4a0b969b140', CAST(N'2018-09-16 16:09:38.990' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (124, 1176, N'83210281-b8ed-427a-acb4-9ecb66c70a74', CAST(N'2018-09-16 16:09:39.013' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (125, 1177, N'632c10fa-b22a-46d0-a381-1c3367f1a59e', CAST(N'2018-09-16 16:09:39.237' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (126, 1178, N'0f121470-d8a7-4fdf-ae52-b616136d17da', CAST(N'2018-09-16 16:09:39.373' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (127, 1179, N'593227ac-3da9-4631-984f-15accf413fef', CAST(N'2018-09-16 16:09:39.440' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (128, 1180, N'fa647386-2cd1-4bcc-a0a5-4b86dc04eef1', CAST(N'2018-09-16 16:09:39.550' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (129, 1181, N'cc64cf40-b629-4ad5-acc1-ff6daa2ce602', CAST(N'2018-09-16 16:09:39.673' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (130, 1182, N'facfdb4b-1ab4-4a83-a3a9-3a4b5577ee42', CAST(N'2018-09-16 16:09:39.793' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (131, 1183, N'16b3c4f8-5d29-4b35-b9bc-f941d0eda5d5', CAST(N'2018-09-16 16:09:39.897' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (132, 1184, N'b8f654a7-a26f-4c86-acfa-fa38c0a5328d', CAST(N'2018-09-16 16:09:40.077' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (133, 1185, N'27d8ac6b-8ae3-4725-8688-87a2a4558994', CAST(N'2018-09-16 16:09:40.187' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (134, 1186, N'da64f9c8-392e-4404-863a-a7d0433282e6', CAST(N'2018-09-16 16:09:40.220' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (135, 1187, N'ecf48e1d-0c6b-49ea-b69c-d305691024ab', CAST(N'2018-09-16 16:09:40.353' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (136, 1188, N'73275192-06d1-45b2-90c6-957ba8dd29bc', CAST(N'2018-09-16 16:09:40.480' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (137, 1189, N'f8fe6413-0327-4d49-9f23-07d07bdb41c4', CAST(N'2018-09-16 16:09:40.603' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (138, 1190, N'0dd39825-dc68-458e-8343-ced375287853', CAST(N'2018-09-16 16:09:40.627' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (139, 1191, N'47300941-2d6f-4291-aa7c-ae7f280cf3e0', CAST(N'2018-09-16 16:09:40.760' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (140, 1192, N'588e6dff-9660-4be7-b647-5a0bfa11a80b', CAST(N'2018-09-16 16:09:40.803' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (141, 1193, N'f3b60a16-ad74-49b7-a4a7-1e72bfb69c58', CAST(N'2018-09-16 16:09:40.947' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (142, 1194, N'322ea4bf-0f8d-437d-b983-9b983bacffbc', CAST(N'2018-09-16 16:09:41.043' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (143, 1195, N'4f841bc5-c1ce-4a66-9fb0-128adc068167', CAST(N'2018-09-16 16:09:41.070' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (144, 1196, N'c2745744-269e-4425-9dee-e30128c66ffe', CAST(N'2018-09-16 16:09:41.210' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (145, 1197, N'7005b81d-d45b-43e3-b04c-f3216ef2054f', CAST(N'2018-09-16 16:09:41.347' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (146, 1198, N'89a5508c-1226-4811-b44e-3b4df277073b', CAST(N'2018-09-16 16:09:41.460' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (147, 1199, N'241a2413-3dee-4765-ae15-741b2dfed4f0', CAST(N'2018-09-16 16:09:41.597' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (148, 1200, N'9cb1db9f-99eb-4272-bc5e-e5019041b4e4', CAST(N'2018-09-16 16:09:41.640' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (149, 1201, N'dcf33e69-6223-4dff-9d12-6a09b0f0eb79', CAST(N'2018-09-16 16:09:41.870' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (150, 1202, N'f1093abd-81f5-440b-b480-07c0a837ac49', CAST(N'2018-09-16 16:09:42.060' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (151, 1203, N'5fc9dbc7-b441-4f03-ab0b-e2cad2884d9c', CAST(N'2018-09-16 16:09:42.343' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (152, 1204, N'c9d9802e-3142-410c-8f64-3f28db001e37', CAST(N'2018-09-16 16:09:42.607' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (153, 1205, N'084b97da-e6ee-400f-9b47-2053d1a47898', CAST(N'2018-09-16 16:09:42.933' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (154, 1206, N'b3d5126f-4c19-4208-ae62-7323919212ff', CAST(N'2018-09-16 16:09:43.173' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (155, 1207, N'5a723c0f-decc-4af4-a475-1b207801eed5', CAST(N'2018-09-16 16:09:43.307' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (156, 1208, N'e3e8b00c-9f10-4dd1-8cf8-7d95b73b5fcf', CAST(N'2018-09-16 16:09:43.340' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (157, 1209, N'a56eff46-b4d2-4959-93ba-de3f016d4072', CAST(N'2018-09-16 16:09:43.363' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (158, 1210, N'20dc4b96-2fe5-4a37-b3dd-b07b85a4b758', CAST(N'2018-09-16 16:09:43.530' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (159, 1211, N'eb754c7b-db90-438c-b74f-bcc775a2e6da', CAST(N'2018-09-16 16:09:43.640' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (160, 1212, N'0353db66-d1e0-4230-9bff-23d4bbc100ef', CAST(N'2018-09-16 16:09:43.803' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (161, 1213, N'858e46ee-3316-4e44-897e-4e8a1038903f', CAST(N'2018-09-16 16:09:43.913' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (162, 1214, N'a5ca47af-d1b0-4db2-b2f0-51f35d392a8c', CAST(N'2018-09-16 16:09:44.057' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (163, 1215, N'e6c1c8ea-5501-44f0-a19a-5bf0ea7f84b6', CAST(N'2018-09-16 16:09:44.077' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (164, 1216, N'dcb1b2df-a077-481c-ac3f-e7d4abb183ec', CAST(N'2018-09-16 16:09:44.250' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (165, 1217, N'764ed384-84fa-4482-9e95-fc47198e25a2', CAST(N'2018-09-16 16:09:44.417' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (166, 1218, N'de3c142b-490b-43c5-977a-49edc1d1acc4', CAST(N'2018-09-16 16:09:44.547' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (167, 1219, N'9a0dd485-aa7c-48e7-831b-2caf46a9c153', CAST(N'2018-09-16 16:09:44.683' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (168, 1220, N'b73f209d-e0b6-4293-8594-597b906ffc04', CAST(N'2018-09-16 16:09:44.717' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (169, 1221, N'843f07e5-c86e-4d0c-881d-fcb34fe3acca', CAST(N'2018-09-16 16:09:44.857' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (170, 1222, N'8ce3d0c1-bc3d-4baf-9e52-faa78951e44c', CAST(N'2018-09-16 16:09:44.997' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (171, 1223, N'8aca3e8e-7655-45d1-9598-a715dd29f2a4', CAST(N'2018-09-16 16:09:45.147' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (172, 1224, N'5d790c2e-ccb2-4105-a036-cdeda14e893b', CAST(N'2018-09-16 16:09:45.303' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (173, 1225, N'7cf8d5ca-3df5-42ed-87f2-8f033e77c125', CAST(N'2018-09-16 16:09:45.430' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (174, 1226, N'67d3242b-b502-4ea7-b3c8-bb53a0f580aa', CAST(N'2018-09-16 16:09:45.580' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (175, 1227, N'666516ef-8157-4d55-b99d-244ec4635368', CAST(N'2018-09-16 16:09:45.773' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (176, 1228, N'2025338c-e384-483b-9a16-510ca7467e61', CAST(N'2018-09-16 16:09:45.797' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (177, 1229, N'e5eaf8f9-7328-4012-8a72-da61f100f9bf', CAST(N'2018-09-16 16:09:45.983' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (178, 1230, N'f201c1f9-e7a6-4a76-a025-fd3678f8efd4', CAST(N'2018-09-16 16:09:46.127' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (179, 1231, N'5eb7447a-ccd3-42ad-be8c-bf6491ce61c0', CAST(N'2018-09-16 16:09:46.300' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (180, 1232, N'6d7e1dd8-7762-4673-a9f7-8461e2409719', CAST(N'2018-09-16 16:09:46.437' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (181, 1233, N'66013f3e-f449-4c16-b4a4-d60db7c2c45d', CAST(N'2018-09-16 16:09:46.570' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (182, 1234, N'2c3ed6f2-f266-42cf-9815-a0b396c94079', CAST(N'2018-09-16 16:09:46.703' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (183, 1235, N'321a0e4e-43c7-4fbf-96b6-5efd2e365554', CAST(N'2018-09-16 16:09:46.853' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (184, 1236, N'cf3f0b58-f2f6-479e-9b79-dade4259a42b', CAST(N'2018-09-16 16:09:47.110' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (185, 1237, N'6f6fca52-0c52-43f1-9cf1-fa453b1af1d0', CAST(N'2018-09-16 16:09:47.347' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (186, 1238, N'16edb69d-e364-4cf7-9924-bae390cbe080', CAST(N'2018-09-16 16:09:47.377' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (187, 1239, N'583a5f3f-c79b-4327-ba53-caa8a0f06d32', CAST(N'2018-09-16 16:09:47.500' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (188, 1240, N'fe8a4f7d-aac3-4e2b-b7ca-239e1847ffd6', CAST(N'2018-09-16 16:09:47.650' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (189, 1241, N'5bfefc5a-8abf-4879-bb81-fcf03de339da', CAST(N'2018-09-16 16:09:47.797' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (190, 1242, N'7f13ab0c-0047-4b5f-b9ab-5085e0d969ad', CAST(N'2018-09-16 16:09:47.943' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (191, 1243, N'773182d2-44f0-465c-9bb6-9c88786b828b', CAST(N'2018-09-16 16:09:47.970' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (192, 1244, N'17b3c4ec-474f-41dc-b4ef-862c77d52a89', CAST(N'2018-09-16 16:09:48.130' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (193, 1245, N'7eef4147-a029-4450-8a67-d0e661f39a61', CAST(N'2018-09-16 16:09:48.297' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (194, 1246, N'b3b040e3-a086-44f1-b2f6-bfe9808182db', CAST(N'2018-09-16 16:09:48.727' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (195, 1247, N'40e020d3-3aa4-4e3d-a8de-a7afdb1393b4', CAST(N'2018-09-16 16:09:48.853' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (196, 1248, N'a719e6ae-e808-465b-b732-0aed15157f36', CAST(N'2018-09-16 16:09:49.330' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (197, 1249, N'ba4ad85d-5a04-4e61-ac23-6924e85b1c4e', CAST(N'2018-09-16 16:09:49.763' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (198, 1250, N'cdbae0ec-d24a-433e-8118-7b8e34d0e83f', CAST(N'2018-09-16 16:09:50.347' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (199, 1251, N'1ca89ca0-4ea1-4fee-bd03-a38cb3532347', CAST(N'2018-09-16 16:09:50.850' AS DateTime))
GO
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (200, 1252, N'98e02253-e25f-4f5d-8353-a8494a516cd5', CAST(N'2018-09-16 16:09:51.293' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (201, 1253, N'fdc52cbb-ecbe-4405-bfaa-ed3f65a9ad0e', CAST(N'2018-09-16 16:09:51.337' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (202, 1254, N'74baec66-46d6-4f8d-a4a0-8c7c0d5ca58a', CAST(N'2018-09-16 16:09:51.543' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (214, 1271, N'6f5a93a0-2d90-4565-8126-8fe03f3866f6', CAST(N'2018-09-17 04:13:02.140' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (215, 1278, N'7806311c-efef-4f70-a028-76bda3c433e6', CAST(N'2018-09-17 04:20:01.007' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (216, 1271, N'7c889c25-7b4f-41db-84d5-145faad2635d', CAST(N'2018-09-17 04:33:01.840' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (217, 1279, N'1f92fe87-e42d-46ad-b2c9-20e2ea9436c9', CAST(N'2018-09-20 00:43:31.247' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (218, 1278, N'46d73cc2-5e59-4135-b127-415f8fa16076', CAST(N'2018-09-20 00:43:31.113' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (219, 1280, N'1099e84a-f0a5-4f20-a1db-df95f4060b26', CAST(N'2018-09-20 00:43:31.483' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (220, 1271, N'ca9323aa-3a94-4682-946a-75a4a7ffc9de', CAST(N'2018-09-17 04:37:33.223' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (222, 1271, N'dd95cc3d-db46-447c-9f17-9c3c0b374ace', CAST(N'2018-09-20 00:30:05.010' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (223, 1295, N'68ae0f8b-8e47-46f6-b8b3-8ed6317030a6', CAST(N'2018-09-20 00:43:31.900' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (224, 1271, N'b92d1242-32c3-4410-af21-37db3cee9ee1', CAST(N'2018-09-20 00:45:22.907' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (226, 1271, N'677d5c85-c018-45a1-a5f7-5b611146c2b5', CAST(N'2018-09-20 00:46:38.400' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (228, 1271, N'93033755-bb77-49d1-94e5-fe6ab56ba6bf', CAST(N'2018-09-20 00:48:09.103' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (230, 1300, N'ba99b285-e7e6-45c7-a746-9b0c7d940644', CAST(N'2018-09-20 00:51:10.107' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (231, 1271, N'f55fe206-571f-47a1-97bf-c79a42eac73c', CAST(N'2018-09-20 00:51:16.900' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (232, 1271, N'e4693af8-f666-4d73-8512-cb89bd07f6b1', CAST(N'2018-09-20 00:59:24.073' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (233, 1300, N'52898928-7f44-4b26-b16a-f03155e14393', CAST(N'2018-09-20 00:59:01.763' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (234, 1271, N'79f36816-db96-44ad-8f06-1fe083c701e8', CAST(N'2018-09-20 01:04:55.437' AS DateTime))
INSERT [dbo].[cmsContentVersion] ([id], [ContentId], [VersionId], [VersionDate]) VALUES (235, 1271, N'090c7559-9ff6-4516-945d-5ecf2b95a224', CAST(N'2018-09-20 02:02:17.470' AS DateTime))
SET IDENTITY_INSERT [dbo].[cmsContentVersion] OFF
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1053, N'<Folder id="1053" key="40d633ed-6df4-45c2-bbe6-61df8e783431" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-16T16:08:47" updateDate="2018-09-16T16:55:15" nodeName="images" urlName="images" path="-1,1053" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="26594e32-d38d-4f07-bd8c-7df26546123f" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1054, N'<Folder id="1054" key="f21d2195-e76d-4272-b53d-73a9451fd633" parentID="1053" level="2" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:17" updateDate="2018-09-16T16:09:17" nodeName="pattern" urlName="pattern" path="-1,1053,1054" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="d60baa69-5f48-481a-bdf9-a72f1746f673" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1055, N'<Image id="1055" key="674f8163-32d7-4f79-9f9e-c5b038098cc7" parentID="1054" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:17" updateDate="2018-09-16T16:09:17" nodeName="project-bg-pattern.png" urlName="project-bg-patternpng" path="-1,1053,1054,1055" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="ac154484-84b3-460b-aea2-906cf11bd839" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1001/project-bg-pattern.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[700]]></umbracoHeight><umbracoBytes><![CDATA[218527]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1056, N'<Folder id="1056" key="e5bd698c-057a-4aca-91d1-3f99c9bc9e1d" parentID="1053" level="2" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:17" updateDate="2018-09-16T16:09:17" nodeName="projects" urlName="projects" path="-1,1053,1056" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="6c9487ac-d778-4de7-a283-2ec6886662e9" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1057, N'<Image id="1057" key="e3dc6399-9a04-4890-a4bf-85046f5692ab" parentID="1056" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:18" updateDate="2018-09-16T16:09:18" nodeName="lat-project-1.jpg" urlName="lat-project-1jpg" path="-1,1053,1056,1057" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="92d55cc6-c718-410b-82d4-0b4af1c3f4e4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1002/lat-project-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[119739]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1058, N'<Image id="1058" key="71b50ae2-ece7-4a82-aaed-237139423de2" parentID="1056" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:18" updateDate="2018-09-16T16:09:18" nodeName="lat-project-10.jpg" urlName="lat-project-10jpg" path="-1,1053,1056,1058" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c5632580-c8d0-438f-a338-22edfdc6b978" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1003/lat-project-10.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[130941]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1059, N'<Image id="1059" key="465a3074-d513-479c-9095-e8ef3ef9fe20" parentID="1056" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:18" updateDate="2018-09-16T16:09:18" nodeName="lat-project-2.jpg" urlName="lat-project-2jpg" path="-1,1053,1056,1059" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="054d97c2-989d-41de-af54-0d846ede6580" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1004/lat-project-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[93741]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1060, N'<Image id="1060" key="7f7309d7-5e7c-41e4-bb62-2d037a4d507f" parentID="1056" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:18" updateDate="2018-09-16T16:09:18" nodeName="lat-project-3.jpg" urlName="lat-project-3jpg" path="-1,1053,1056,1060" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="3cb6b94f-7635-47ec-992d-e21ecdaee282" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1005/lat-project-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[131716]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1061, N'<Image id="1061" key="bbe177b4-1b8f-4c53-b475-aaefd2db18cf" parentID="1056" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:18" updateDate="2018-09-16T16:09:18" nodeName="lat-project-4.jpg" urlName="lat-project-4jpg" path="-1,1053,1056,1061" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="2176049f-1054-440a-a47b-db81b81ba643" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1006/lat-project-4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[157359]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1062, N'<Image id="1062" key="5858ac14-9ff5-44b7-b551-328276750143" parentID="1056" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:18" updateDate="2018-09-16T16:09:18" nodeName="lat-project-5.jpg" urlName="lat-project-5jpg" path="-1,1053,1056,1062" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c9a46361-24e6-4fef-be13-08455eca96c2" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1007/lat-project-5.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[116119]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1063, N'<Image id="1063" key="3e246ed5-c48f-44df-b418-99e3157d3cc1" parentID="1056" level="3" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:19" updateDate="2018-09-16T16:09:19" nodeName="lat-project-6.jpg" urlName="lat-project-6jpg" path="-1,1053,1056,1063" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="110e107f-fe79-40e4-8cb7-240f006d3949" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1008/lat-project-6.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[128896]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1064, N'<Image id="1064" key="de4c2300-171b-4ae7-8473-9e5c626df48a" parentID="1056" level="3" creatorID="0" sortOrder="7" createDate="2018-09-16T16:09:19" updateDate="2018-09-16T16:09:19" nodeName="lat-project-7.jpg" urlName="lat-project-7jpg" path="-1,1053,1056,1064" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="bf2b6b88-ada8-4c88-ba04-54b12862082d" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1009/lat-project-7.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[138313]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1065, N'<Image id="1065" key="6ff8ccbf-8ed5-4363-8e59-85fe7e22490a" parentID="1056" level="3" creatorID="0" sortOrder="8" createDate="2018-09-16T16:09:19" updateDate="2018-09-16T16:09:19" nodeName="lat-project-8.jpg" urlName="lat-project-8jpg" path="-1,1053,1056,1065" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="19340365-d912-47f8-9035-ce0065d8daf7" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1010/lat-project-8.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[129088]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1066, N'<Image id="1066" key="b16d6d74-5a7d-48b3-8331-b0c5269847a6" parentID="1056" level="3" creatorID="0" sortOrder="9" createDate="2018-09-16T16:09:19" updateDate="2018-09-16T16:09:19" nodeName="lat-project-9.jpg" urlName="lat-project-9jpg" path="-1,1053,1056,1066" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="a9517379-d1e3-43b5-bb88-598ad1e08238" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1011/lat-project-9.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[384]]></umbracoWidth><umbracoHeight><![CDATA[400]]></umbracoHeight><umbracoBytes><![CDATA[117439]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1067, N'<Image id="1067" key="cbebb254-aa93-4b43-a7a9-fe55bb7b19dc" parentID="1056" level="3" creatorID="0" sortOrder="10" createDate="2018-09-16T16:09:19" updateDate="2018-09-16T16:09:19" nodeName="v1-1.jpg" urlName="v1-1jpg" path="-1,1053,1056,1067" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c9cf1d27-30f6-473f-8c4d-77e4f1b67230" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1012/v1-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[74444]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1068, N'<Image id="1068" key="949c6722-6ec0-4882-b535-ba18dde1feba" parentID="1056" level="3" creatorID="0" sortOrder="11" createDate="2018-09-16T16:09:19" updateDate="2018-09-16T16:09:19" nodeName="v1-2.jpg" urlName="v1-2jpg" path="-1,1053,1056,1068" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c822de32-782d-491e-a25b-2ca10e741a00" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1013/v1-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[80558]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1069, N'<Image id="1069" key="ed89807b-6a0b-481f-9fd9-990685065896" parentID="1056" level="3" creatorID="0" sortOrder="12" createDate="2018-09-16T16:09:20" updateDate="2018-09-16T16:09:20" nodeName="v1-3.jpg" urlName="v1-3jpg" path="-1,1053,1056,1069" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="9195b7be-8277-4be5-a4eb-aaa89967fc83" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1014/v1-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[62702]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1070, N'<Image id="1070" key="889efd71-083f-4f10-aa59-d748664cb399" parentID="1056" level="3" creatorID="0" sortOrder="13" createDate="2018-09-16T16:09:20" updateDate="2018-09-16T16:09:20" nodeName="v1-4.jpg" urlName="v1-4jpg" path="-1,1053,1056,1070" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="a22386fc-09d1-4fc8-9ed6-e760cc5c80bf" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1015/v1-4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[71572]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1071, N'<Image id="1071" key="1ffc9337-a198-4d85-a7c6-ee66a5c693ee" parentID="1056" level="3" creatorID="0" sortOrder="14" createDate="2018-09-16T16:09:20" updateDate="2018-09-16T16:09:20" nodeName="v1-5.jpg" urlName="v1-5jpg" path="-1,1053,1056,1071" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="82cf3193-e395-47aa-9fd5-8416babb5807" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1016/v1-5.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[74443]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1072, N'<Image id="1072" key="2988036c-b259-4425-bff9-55f16e561404" parentID="1056" level="3" creatorID="0" sortOrder="15" createDate="2018-09-16T16:09:20" updateDate="2018-09-16T16:09:20" nodeName="v1-6.jpg" urlName="v1-6jpg" path="-1,1053,1056,1072" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="2c4cd807-7982-4751-a704-25c7868a07dc" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1017/v1-6.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[86570]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1073, N'<Image id="1073" key="1e8a1123-b93d-43f9-8728-95b9e91da3bf" parentID="1056" level="3" creatorID="0" sortOrder="16" createDate="2018-09-16T16:09:20" updateDate="2018-09-16T16:09:20" nodeName="v1-7.jpg" urlName="v1-7jpg" path="-1,1053,1056,1073" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="81b12032-50b6-452c-adb5-561cf13b67e4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1018/v1-7.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[95239]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1074, N'<Image id="1074" key="9330c8d0-358c-446b-9bc3-d6619de3f38c" parentID="1056" level="3" creatorID="0" sortOrder="17" createDate="2018-09-16T16:09:20" updateDate="2018-09-16T16:09:20" nodeName="v1-8.jpg" urlName="v1-8jpg" path="-1,1053,1056,1074" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="81d0900c-c32f-4d68-aad6-20a9dd6315d0" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1019/v1-8.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[116370]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1075, N'<Image id="1075" key="816db59f-f3b6-4cf8-9a20-ce46f92ae0e6" parentID="1056" level="3" creatorID="0" sortOrder="18" createDate="2018-09-16T16:09:20" updateDate="2018-09-16T16:09:20" nodeName="v1-9.jpg" urlName="v1-9jpg" path="-1,1053,1056,1075" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="5395e7ad-5c38-433c-899b-ec9dcc60b832" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1020/v1-9.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[70033]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1076, N'<Image id="1076" key="1471991f-c31c-4036-8098-deb22fe17886" parentID="1056" level="3" creatorID="0" sortOrder="19" createDate="2018-09-16T16:09:21" updateDate="2018-09-16T16:09:21" nodeName="v2-1.jpg" urlName="v2-1jpg" path="-1,1053,1056,1076" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="0e4cb31c-64a0-4e8b-8ed9-f92676dac8af" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1021/v2-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[200]]></umbracoHeight><umbracoBytes><![CDATA[67721]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1077, N'<Image id="1077" key="94c2966b-7264-417a-ab08-37be7ece5263" parentID="1056" level="3" creatorID="0" sortOrder="20" createDate="2018-09-16T16:09:21" updateDate="2018-09-16T16:09:21" nodeName="v2-2.jpg" urlName="v2-2jpg" path="-1,1053,1056,1077" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c211e5f4-b789-4a76-8475-aeb2c827d821" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1022/v2-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[200]]></umbracoHeight><umbracoBytes><![CDATA[74401]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1078, N'<Image id="1078" key="57d474dd-5495-4ba8-87f4-a1d9f76363bb" parentID="1056" level="3" creatorID="0" sortOrder="21" createDate="2018-09-16T16:09:21" updateDate="2018-09-16T16:09:21" nodeName="v2-3.jpg" urlName="v2-3jpg" path="-1,1053,1056,1078" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="23f94c5f-0129-4752-a217-cc5d3ec51962" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1023/v2-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[200]]></umbracoHeight><umbracoBytes><![CDATA[57952]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1079, N'<Image id="1079" key="4b0713c1-0831-447e-b91d-cfc66ad3dc3c" parentID="1056" level="3" creatorID="0" sortOrder="22" createDate="2018-09-16T16:09:21" updateDate="2018-09-16T16:09:21" nodeName="v2-4.jpg" urlName="v2-4jpg" path="-1,1053,1056,1079" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="205a8625-3d18-4419-a95f-bb9327b07e96" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1024/v2-4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[200]]></umbracoHeight><umbracoBytes><![CDATA[87146]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1080, N'<Image id="1080" key="3693872c-3776-4289-a000-df1326c3d803" parentID="1056" level="3" creatorID="0" sortOrder="23" createDate="2018-09-16T16:09:21" updateDate="2018-09-16T16:09:21" nodeName="v2-5.jpg" urlName="v2-5jpg" path="-1,1053,1056,1080" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="6c5de08e-89d3-4994-86f4-685cad9e48da" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1025/v2-5.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[200]]></umbracoHeight><umbracoBytes><![CDATA[105854]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1081, N'<Image id="1081" key="eadb320c-f385-478d-a543-448708183abe" parentID="1056" level="3" creatorID="0" sortOrder="24" createDate="2018-09-16T16:09:22" updateDate="2018-09-16T16:09:22" nodeName="v2-6.jpg" urlName="v2-6jpg" path="-1,1053,1056,1081" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="8e858f5b-3d5c-44cb-9d35-351396e335a6" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1026/v2-6.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[200]]></umbracoHeight><umbracoBytes><![CDATA[64275]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1082, N'<Image id="1082" key="f8a7f18e-e0c3-4170-b85a-09dd2b3b2ead" parentID="1056" level="3" creatorID="0" sortOrder="25" createDate="2018-09-16T16:09:22" updateDate="2018-09-16T16:09:22" nodeName="v3-1.jpg" urlName="v3-1jpg" path="-1,1053,1056,1082" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="b50f2825-43aa-476a-878d-8c0d7478a358" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1027/v3-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[670]]></umbracoWidth><umbracoHeight><![CDATA[500]]></umbracoHeight><umbracoBytes><![CDATA[312869]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1083, N'<Image id="1083" key="c3b724ab-c5f1-40ee-8ebf-32905b970e39" parentID="1056" level="3" creatorID="0" sortOrder="26" createDate="2018-09-16T16:09:22" updateDate="2018-09-16T16:09:22" nodeName="v3-2.jpg" urlName="v3-2jpg" path="-1,1053,1056,1083" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="ce0ef4aa-4b33-45b0-bec7-51d21bc7eabc" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1028/v3-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[670]]></umbracoWidth><umbracoHeight><![CDATA[500]]></umbracoHeight><umbracoBytes><![CDATA[255995]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1084, N'<Image id="1084" key="e1605b42-7857-454c-855b-ad17402eb532" parentID="1056" level="3" creatorID="0" sortOrder="27" createDate="2018-09-16T16:09:22" updateDate="2018-09-16T16:09:22" nodeName="v3-3.jpg" urlName="v3-3jpg" path="-1,1053,1056,1084" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="e4cd815e-ef9f-48ec-8c5d-40138a81fe73" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1029/v3-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[670]]></umbracoWidth><umbracoHeight><![CDATA[500]]></umbracoHeight><umbracoBytes><![CDATA[196244]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1085, N'<Image id="1085" key="49c56b21-23c4-4691-980f-19ecb17840de" parentID="1056" level="3" creatorID="0" sortOrder="28" createDate="2018-09-16T16:09:22" updateDate="2018-09-16T16:09:22" nodeName="v3-4.jpg" urlName="v3-4jpg" path="-1,1053,1056,1085" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="82ebddd9-ffba-4965-9209-46c39211800d" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1030/v3-4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[670]]></umbracoWidth><umbracoHeight><![CDATA[500]]></umbracoHeight><umbracoBytes><![CDATA[218857]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1086, N'<Image id="1086" key="a826cb57-03cf-4da0-ae73-4ea170c520ac" parentID="1056" level="3" creatorID="0" sortOrder="29" createDate="2018-09-16T16:09:23" updateDate="2018-09-16T16:09:23" nodeName="v3-5.jpg" urlName="v3-5jpg" path="-1,1053,1056,1086" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="99322637-8024-4050-a272-84258f6fa0a1" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1031/v3-5.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[670]]></umbracoWidth><umbracoHeight><![CDATA[500]]></umbracoHeight><umbracoBytes><![CDATA[172755]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1087, N'<Folder id="1087" key="a019a9dc-4581-4c0d-8d76-88e16c291919" parentID="1053" level="2" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:23" updateDate="2018-09-16T16:09:23" nodeName="resources" urlName="resources" path="-1,1053,1087" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="d8edac73-8c7f-4f78-94e5-39a904b0ccbd" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1088, N'<Image id="1088" key="d28d5456-faff-431d-9c6e-40a09cac2bdb" parentID="1087" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:23" updateDate="2018-09-16T16:09:23" nodeName="appoinment-image.jpg" urlName="appoinment-imagejpg" path="-1,1053,1087,1088" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="b562578f-d187-4e31-b50b-c03f249c51de" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1032/appoinment-image.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[775]]></umbracoWidth><umbracoHeight><![CDATA[510]]></umbracoHeight><umbracoBytes><![CDATA[156621]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1089, N'<Image id="1089" key="569f55f3-075c-4536-9db9-30d492b29911" parentID="1087" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:23" updateDate="2018-09-16T16:09:23" nodeName="breadcrumb-bg-2.jpg" urlName="breadcrumb-bg-2jpg" path="-1,1053,1087,1089" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="159a2119-afdd-440f-8ff1-ae913a69369c" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1033/breadcrumb-bg-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[320]]></umbracoHeight><umbracoBytes><![CDATA[315684]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1090, N'<Image id="1090" key="e3a36f1f-d575-444e-82b8-1b05ab3fe3d3" parentID="1087" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:23" updateDate="2018-09-16T16:09:23" nodeName="breadcrumb-bg.jpg" urlName="breadcrumb-bgjpg" path="-1,1053,1087,1090" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="f5522789-69c9-4dfd-9b98-9a7b26aa2025" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1034/breadcrumb-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[320]]></umbracoHeight><umbracoBytes><![CDATA[236483]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1091, N'<Image id="1091" key="93ced985-0f74-49e1-a5a3-9d3859ddaf22" parentID="1087" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:23" updateDate="2018-09-16T16:09:23" nodeName="contact-1.jpg" urlName="contact-1jpg" path="-1,1053,1087,1091" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="acdcec44-17a1-487f-8e19-34f131a4cf85" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1035/contact-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[585]]></umbracoWidth><umbracoHeight><![CDATA[370]]></umbracoHeight><umbracoBytes><![CDATA[113123]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1092, N'<Image id="1092" key="fd1c0f6e-eeae-4a22-962a-8da6c9a204aa" parentID="1087" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:24" updateDate="2018-09-16T16:09:24" nodeName="industry-covered-1.jpg" urlName="industry-covered-1jpg" path="-1,1053,1087,1092" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="506951d3-28d5-4564-aab4-7cf682305278" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1036/industry-covered-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[66177]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1093, N'<Image id="1093" key="77e91be6-18b7-49d3-890c-0e0521b56e5e" parentID="1087" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:24" updateDate="2018-09-16T16:09:24" nodeName="industry-covered-2.jpg" urlName="industry-covered-2jpg" path="-1,1053,1087,1093" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="3cd3576c-d622-4fa4-80e9-6635219e7423" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1037/industry-covered-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[81027]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1094, N'<Image id="1094" key="229c3d10-a633-4d7b-bbe7-4cb9d9b76a45" parentID="1087" level="3" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:24" updateDate="2018-09-16T16:09:24" nodeName="industry-covered-3.jpg" urlName="industry-covered-3jpg" path="-1,1053,1087,1094" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="57e83026-9ed2-4510-ad6f-f70362728c64" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1038/industry-covered-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[82879]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1095, N'<Image id="1095" key="652adcf9-c40c-4aba-a0cc-4e7f3ca2ef66" parentID="1087" level="3" creatorID="0" sortOrder="7" createDate="2018-09-16T16:09:24" updateDate="2018-09-16T16:09:24" nodeName="industry-covered-4.jpg" urlName="industry-covered-4jpg" path="-1,1053,1087,1095" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="1915c75d-0e3b-4c31-a747-2abee5f6efdc" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1039/industry-covered-4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[73065]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1096, N'<Image id="1096" key="400a2ecf-3728-4cf2-84d5-fa1e02cb8714" parentID="1087" level="3" creatorID="0" sortOrder="8" createDate="2018-09-16T16:09:24" updateDate="2018-09-16T16:09:24" nodeName="logo.png" urlName="logopng" path="-1,1053,1087,1096" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="7852ef0e-8536-4dd0-9b99-9d9f3d83aa3c" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1040/logo.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[220]]></umbracoWidth><umbracoHeight><![CDATA[60]]></umbracoHeight><umbracoBytes><![CDATA[7709]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1097, N'<Image id="1097" key="1c52715b-c45e-48d3-aa2d-8e5a8ab59b62" parentID="1087" level="3" creatorID="0" sortOrder="9" createDate="2018-09-16T16:09:24" updateDate="2018-09-16T16:09:24" nodeName="map-marker.png" urlName="map-markerpng" path="-1,1053,1087,1097" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="9adb313e-8acc-4bea-a820-7f8cd2c02a9e" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1041/map-marker.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[70]]></umbracoWidth><umbracoHeight><![CDATA[80]]></umbracoHeight><umbracoBytes><![CDATA[3958]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1098, N'<Image id="1098" key="8196701d-db1d-4fd0-b29f-373be21069fc" parentID="1087" level="3" creatorID="0" sortOrder="10" createDate="2018-09-16T16:09:24" updateDate="2018-09-16T16:09:24" nodeName="our-logo.png" urlName="our-logopng" path="-1,1053,1087,1098" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="90fc6434-ad02-4dc0-bc18-810dbc124176" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1042/our-logo.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[65]]></umbracoWidth><umbracoHeight><![CDATA[65]]></umbracoHeight><umbracoBytes><![CDATA[4679]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1099, N'<Folder id="1099" key="45002333-aa2d-4204-b0d2-14b0a0fd5fdd" parentID="1053" level="2" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:25" updateDate="2018-09-16T16:09:25" nodeName="services" urlName="services" path="-1,1053,1099" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="e38ceedf-323a-404d-a866-dcfc66795cd1" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1100, N'<Image id="1100" key="a664fdbe-44ac-44ee-8f64-322727ec457b" parentID="1099" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:25" updateDate="2018-09-16T16:09:25" nodeName="1.jpg" urlName="1jpg" path="-1,1053,1099,1100" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="cddc6332-9dff-44c6-ba5e-788de6b474ba" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1043/1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[250]]></umbracoHeight><umbracoBytes><![CDATA[67447]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1101, N'<Image id="1101" key="c6ee1a81-aca8-445f-b589-74ec480c6bf4" parentID="1099" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:25" updateDate="2018-09-16T16:09:25" nodeName="2.jpg" urlName="2jpg" path="-1,1053,1099,1101" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="eb7a2faa-1815-4755-9f11-f7dc0e6c8188" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1044/2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[250]]></umbracoHeight><umbracoBytes><![CDATA[63714]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1102, N'<Image id="1102" key="bf1f68ae-dd05-4a41-ae46-1cc586b6f234" parentID="1099" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:25" updateDate="2018-09-16T16:09:25" nodeName="3.jpg" urlName="3jpg" path="-1,1053,1099,1102" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="55886177-f090-4418-a4e9-1b0b119696d0" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1045/3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[250]]></umbracoHeight><umbracoBytes><![CDATA[70536]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1103, N'<Image id="1103" key="95152c4a-e146-46bf-8570-ac1333509c16" parentID="1099" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:25" updateDate="2018-09-16T16:09:25" nodeName="4.jpg" urlName="4jpg" path="-1,1053,1099,1103" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="d2460cdc-d8ec-47f3-867a-790a4f169fbe" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1046/4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[250]]></umbracoHeight><umbracoBytes><![CDATA[76779]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1104, N'<Image id="1104" key="54ff97b5-bc79-4509-88d1-f5b8995fb8a2" parentID="1099" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:25" updateDate="2018-09-16T16:09:25" nodeName="5.jpg" urlName="5jpg" path="-1,1053,1099,1104" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="5db0a1dd-9564-4efa-b20e-d2b2b1b20ab9" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1047/5.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[250]]></umbracoHeight><umbracoBytes><![CDATA[73995]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1105, N'<Image id="1105" key="c62457c9-8498-4ca8-ba4f-3d70097d1758" parentID="1099" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:25" updateDate="2018-09-16T16:09:25" nodeName="6.jpg" urlName="6jpg" path="-1,1053,1099,1105" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="a3057356-c10e-4ba3-83c4-5e1462804437" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1048/6.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[250]]></umbracoHeight><umbracoBytes><![CDATA[65282]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1106, N'<Folder id="1106" key="2905d24c-ed39-47b9-acaf-757dd7c31763" parentID="1053" level="2" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:26" updateDate="2018-09-16T16:09:26" nodeName="shop" urlName="shop" path="-1,1053,1106" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="3c20340d-7c25-4003-8d96-49f21a4f392b" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1107, N'<Image id="1107" key="a99902e7-fdab-4a89-abcd-af9375d793cb" parentID="1106" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:26" updateDate="2018-09-16T16:09:26" nodeName="1.jpg" urlName="1jpg" path="-1,1053,1106,1107" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="f8a4fc47-e322-4a36-942d-e3cec553a3ee" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1049/1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[34731]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1108, N'<Image id="1108" key="eeb0d363-7c80-4f31-8557-53ad78c03efa" parentID="1106" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:26" updateDate="2018-09-16T16:09:26" nodeName="2.jpg" urlName="2jpg" path="-1,1053,1106,1108" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="d5be2efb-30ee-4ac6-9f34-22317d5032ab" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1050/2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[28716]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1109, N'<Image id="1109" key="f20b5655-0b28-4c12-bdc0-dee2132e57c2" parentID="1106" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:26" updateDate="2018-09-16T16:09:26" nodeName="3.jpg" urlName="3jpg" path="-1,1053,1106,1109" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="8085aa49-3f5e-4f29-a401-cad4cfa42cba" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1051/3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[29740]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1110, N'<Image id="1110" key="fc8ba554-2153-4655-9790-6b0b9ec09aac" parentID="1106" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:26" updateDate="2018-09-16T16:09:26" nodeName="4.jpg" urlName="4jpg" path="-1,1053,1106,1110" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="52fe26f2-8b48-4862-a4f4-925df3649a28" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1052/4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[29371]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1111, N'<Image id="1111" key="c8d3cd5d-faa4-425d-9129-13df984228e0" parentID="1106" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:26" updateDate="2018-09-16T16:09:26" nodeName="5.jpg" urlName="5jpg" path="-1,1053,1106,1111" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="fa47547b-ae5c-4d6e-9749-653b5fd8b36f" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1053/5.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[28019]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1112, N'<Image id="1112" key="2673a470-bfe1-4e79-b6ec-bd31769d5561" parentID="1106" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:26" updateDate="2018-09-16T16:09:26" nodeName="6.jpg" urlName="6jpg" path="-1,1053,1106,1112" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c1a7446c-6cc6-4e5e-b2e7-ecb0adce2179" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1054/6.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[23683]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1113, N'<Image id="1113" key="73409440-5ff2-47a4-8175-2af2aafd3499" parentID="1106" level="3" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:27" updateDate="2018-09-16T16:09:27" nodeName="7.jpg" urlName="7jpg" path="-1,1053,1106,1113" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="0a4547dc-be60-4add-9383-e04b4a04d8ba" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1055/7.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[29740]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1114, N'<Image id="1114" key="976a0ac3-18d5-424d-bc2c-d727e7f585ea" parentID="1106" level="3" creatorID="0" sortOrder="7" createDate="2018-09-16T16:09:27" updateDate="2018-09-16T16:09:27" nodeName="8.jpg" urlName="8jpg" path="-1,1053,1106,1114" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="623895ec-42bd-47a6-b275-df22936e66b3" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1056/8.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[24398]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1115, N'<Image id="1115" key="6a69d917-8b68-4841-9c1c-12c4fce40d63" parentID="1106" level="3" creatorID="0" sortOrder="8" createDate="2018-09-16T16:09:27" updateDate="2018-09-16T16:09:27" nodeName="9.jpg" urlName="9jpg" path="-1,1053,1106,1115" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="319214b9-e742-4074-bb01-4c66f641e5da" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1057/9.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[270]]></umbracoHeight><umbracoBytes><![CDATA[28716]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1116, N'<Image id="1116" key="f8fccc63-55ff-47aa-a70e-932c9c106bd1" parentID="1106" level="3" creatorID="0" sortOrder="9" createDate="2018-09-16T16:09:27" updateDate="2018-09-16T16:09:27" nodeName="product-thumb-1.jpg" urlName="product-thumb-1jpg" path="-1,1053,1106,1116" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="6f2f35b5-5e95-45a0-a955-cce6fe262921" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1058/product-thumb-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[70]]></umbracoWidth><umbracoHeight><![CDATA[70]]></umbracoHeight><umbracoBytes><![CDATA[4615]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1117, N'<Image id="1117" key="fd37dfeb-1065-496e-b24c-d31729696183" parentID="1106" level="3" creatorID="0" sortOrder="10" createDate="2018-09-16T16:09:27" updateDate="2018-09-16T16:09:27" nodeName="product-thumb-2.jpg" urlName="product-thumb-2jpg" path="-1,1053,1106,1117" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="44ca142f-9b54-4e48-81d8-4c91388d8fea" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1059/product-thumb-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[70]]></umbracoWidth><umbracoHeight><![CDATA[70]]></umbracoHeight><umbracoBytes><![CDATA[4788]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1118, N'<Image id="1118" key="dbf14f23-68e1-4514-8f7e-93a9abc3e85f" parentID="1106" level="3" creatorID="0" sortOrder="11" createDate="2018-09-16T16:09:27" updateDate="2018-09-16T16:09:27" nodeName="product-thumb-3.jpg" urlName="product-thumb-3jpg" path="-1,1053,1106,1118" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="42d0a23a-19a2-43eb-950e-4b2b5a8d0095" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1060/product-thumb-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[70]]></umbracoWidth><umbracoHeight><![CDATA[70]]></umbracoHeight><umbracoBytes><![CDATA[4242]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1119, N'<Image id="1119" key="7358d546-da92-4648-8865-56ba2a183d2e" parentID="1106" level="3" creatorID="0" sortOrder="12" createDate="2018-09-16T16:09:27" updateDate="2018-09-16T16:09:27" nodeName="review-1.jpg" urlName="review-1jpg" path="-1,1053,1106,1119" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="fe95964b-bf31-4e56-b6c9-2217f502f135" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1061/review-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[60]]></umbracoWidth><umbracoHeight><![CDATA[60]]></umbracoHeight><umbracoBytes><![CDATA[5433]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1120, N'<Image id="1120" key="9d9044db-a89d-4c34-a793-729c3605b9c1" parentID="1106" level="3" creatorID="0" sortOrder="13" createDate="2018-09-16T16:09:27" updateDate="2018-09-16T16:09:27" nodeName="review-2.jpg" urlName="review-2jpg" path="-1,1053,1106,1120" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="b8016f88-47ee-4504-b144-c200cc115aca" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1062/review-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[60]]></umbracoWidth><umbracoHeight><![CDATA[60]]></umbracoHeight><umbracoBytes><![CDATA[5547]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1121, N'<Image id="1121" key="cc63b707-80c8-477b-93fb-1f6480b245f1" parentID="1106" level="3" creatorID="0" sortOrder="14" createDate="2018-09-16T16:09:28" updateDate="2018-09-16T16:09:28" nodeName="single-product.jpg" urlName="single-productjpg" path="-1,1053,1106,1121" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="856204ec-bb55-4619-bb61-6cfd35660b1e" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1063/single-product.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[415]]></umbracoHeight><umbracoBytes><![CDATA[47450]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1122, N'<Folder id="1122" key="39b1b24d-2ec7-4231-afb9-01eb6fd2356a" parentID="1053" level="2" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:28" updateDate="2018-09-16T16:09:28" nodeName="sidebar" urlName="sidebar" path="-1,1053,1122" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="9c28e941-5887-4de2-9859-0e4cfa7407ab" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1123, N'<Image id="1123" key="89d6d352-79e9-45c6-bb58-6952fcf30c8d" parentID="1122" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:28" updateDate="2018-09-16T16:09:28" nodeName="comment-1.jpg" urlName="comment-1jpg" path="-1,1053,1122,1123" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="a6ea4c08-0e72-4178-8d35-f9007f729f64" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1064/comment-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[50]]></umbracoWidth><umbracoHeight><![CDATA[50]]></umbracoHeight><umbracoBytes><![CDATA[4252]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1124, N'<Image id="1124" key="bb8ffa12-4d5a-4e0d-8290-3ab8149de34e" parentID="1122" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:28" updateDate="2018-09-16T16:09:28" nodeName="comment-2.jpg" urlName="comment-2jpg" path="-1,1053,1122,1124" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="893e2c0d-f18c-43b1-b2b8-625afd8c230e" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1065/comment-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[50]]></umbracoWidth><umbracoHeight><![CDATA[50]]></umbracoHeight><umbracoBytes><![CDATA[4507]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1125, N'<Image id="1125" key="5bb66d61-0157-4ecc-89d0-16203665a370" parentID="1122" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:28" updateDate="2018-09-16T16:09:28" nodeName="popular-post-1.jpg" urlName="popular-post-1jpg" path="-1,1053,1122,1125" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="f2f36cd0-3697-4baa-88e5-962667acfa7b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1066/popular-post-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[90]]></umbracoWidth><umbracoHeight><![CDATA[90]]></umbracoHeight><umbracoBytes><![CDATA[13983]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1126, N'<Image id="1126" key="024dc2eb-22db-4b95-b2df-799cdc9da6a0" parentID="1122" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:28" updateDate="2018-09-16T16:09:28" nodeName="popular-post-2.jpg" urlName="popular-post-2jpg" path="-1,1053,1122,1126" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="a153cb18-347a-4b85-b351-ac0d60a00690" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1067/popular-post-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[90]]></umbracoWidth><umbracoHeight><![CDATA[90]]></umbracoHeight><umbracoBytes><![CDATA[11090]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1127, N'<Image id="1127" key="c5768ca8-dcca-4aa2-9729-69f9dd2455e8" parentID="1122" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:28" updateDate="2018-09-16T16:09:28" nodeName="popular-post-3.jpg" urlName="popular-post-3jpg" path="-1,1053,1122,1127" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="96eabbe0-dc5f-48b1-a507-e181530238f4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1068/popular-post-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[90]]></umbracoWidth><umbracoHeight><![CDATA[90]]></umbracoHeight><umbracoBytes><![CDATA[13994]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1128, N'<Folder id="1128" key="a84cbd7d-cfe4-4a03-ad21-0c8ea2b401bf" parentID="1053" level="2" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:28" updateDate="2018-09-16T16:09:28" nodeName="slides" urlName="slides" path="-1,1053,1128" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="dbf60c29-53de-40de-b88d-f9e4bb8e22ee" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1129, N'<Image id="1129" key="627ddaaf-c3fb-4073-b7b5-fb5e3cedc990" parentID="1128" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:28" updateDate="2018-09-16T16:09:28" nodeName="1.jpg" urlName="1jpg" path="-1,1053,1128,1129" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="57e65cee-3c86-43dc-90ae-36f34d611c3b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1069/1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[780]]></umbracoHeight><umbracoBytes><![CDATA[186336]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1130, N'<Image id="1130" key="a127a0aa-a19f-47e8-9648-3a0bfc93e5d5" parentID="1128" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:29" updateDate="2018-09-16T16:09:29" nodeName="2.jpg" urlName="2jpg" path="-1,1053,1128,1130" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="ca851d91-b23d-4336-a864-08049b374146" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1070/2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[780]]></umbracoHeight><umbracoBytes><![CDATA[410195]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1131, N'<Image id="1131" key="2109fcf6-c83d-4f30-9f3a-7f9ee2d23437" parentID="1128" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:30" updateDate="2018-09-16T16:09:30" nodeName="3.jpg" urlName="3jpg" path="-1,1053,1128,1131" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="74c77fcb-df27-485a-b476-4990cf3fba45" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1071/3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[780]]></umbracoHeight><umbracoBytes><![CDATA[278139]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1132, N'<Folder id="1132" key="d6337ee0-a9eb-436a-91de-91d1420d8b91" parentID="1053" level="2" creatorID="0" sortOrder="7" createDate="2018-09-16T16:09:30" updateDate="2018-09-16T16:09:30" nodeName="team" urlName="team" path="-1,1053,1132" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="f49bb6d1-91dc-4d05-bfd3-b24fbd4c2435" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1133, N'<Image id="1133" key="005440ec-1bc8-44bf-934f-8adc19ca99c6" parentID="1132" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:30" updateDate="2018-09-16T16:09:30" nodeName="1.jpg" urlName="1jpg" path="-1,1053,1132,1133" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="43499b8c-f456-410a-8b7e-64ab037c0d8d" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1072/1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[330]]></umbracoWidth><umbracoHeight><![CDATA[230]]></umbracoHeight><umbracoBytes><![CDATA[40188]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1134, N'<Image id="1134" key="0c7af131-0663-4707-95c7-be5aa703b3b7" parentID="1132" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:31" updateDate="2018-09-16T16:09:31" nodeName="2.jpg" urlName="2jpg" path="-1,1053,1132,1134" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="f185dc89-e737-4857-8f5b-073047337f02" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1073/2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[330]]></umbracoWidth><umbracoHeight><![CDATA[230]]></umbracoHeight><umbracoBytes><![CDATA[45798]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1135, N'<Image id="1135" key="908cfd92-f04c-4f81-b4db-670bf3ccb479" parentID="1132" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:31" updateDate="2018-09-16T16:09:31" nodeName="3.jpg" urlName="3jpg" path="-1,1053,1132,1135" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="bec81464-1d0a-4cae-825c-91903f3c8d46" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1074/3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[330]]></umbracoWidth><umbracoHeight><![CDATA[230]]></umbracoHeight><umbracoBytes><![CDATA[51276]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1136, N'<Image id="1136" key="41dff995-0ef9-437d-a84d-7dda4d51dc59" parentID="1132" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:31" updateDate="2018-09-16T16:09:31" nodeName="4.jpg" urlName="4jpg" path="-1,1053,1132,1136" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="2b787eed-2509-463a-950d-fdaee2d2a9bc" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1075/4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[330]]></umbracoWidth><umbracoHeight><![CDATA[230]]></umbracoHeight><umbracoBytes><![CDATA[37350]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1137, N'<Image id="1137" key="61513774-dc21-4ec6-b80a-796ac3fb8b0f" parentID="1132" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:32" updateDate="2018-09-16T16:09:32" nodeName="5.jpg" urlName="5jpg" path="-1,1053,1132,1137" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="da789e58-8be2-4eda-9587-62d7e188918b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1076/5.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[330]]></umbracoWidth><umbracoHeight><![CDATA[230]]></umbracoHeight><umbracoBytes><![CDATA[42653]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1138, N'<Image id="1138" key="dc0424a8-c5e4-49ec-aa7a-cfc4211629b9" parentID="1132" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:32" updateDate="2018-09-16T16:09:32" nodeName="6.jpg" urlName="6jpg" path="-1,1053,1132,1138" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="1d6ae236-d943-4cd3-9600-9cf979100f35" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1077/6.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[330]]></umbracoWidth><umbracoHeight><![CDATA[230]]></umbracoHeight><umbracoBytes><![CDATA[37918]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1139, N'<Folder id="1139" key="e9e41d4c-33ff-4cff-8870-0cac8e1aeef9" parentID="1053" level="2" creatorID="0" sortOrder="8" createDate="2018-09-16T16:09:32" updateDate="2018-09-16T16:09:32" nodeName="testimonial" urlName="testimonial" path="-1,1053,1139" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="61c2e5ea-38f2-41ee-9b0d-42c8169fafe6" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1140, N'<Image id="1140" key="7db98dc3-da55-4526-bb22-55d6e4b586c3" parentID="1139" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:33" updateDate="2018-09-16T16:09:33" nodeName="1.png" urlName="1png" path="-1,1053,1139,1140" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="8541f239-3909-45a3-92f3-7f525b54ad50" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1078/1.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[80]]></umbracoWidth><umbracoHeight><![CDATA[80]]></umbracoHeight><umbracoBytes><![CDATA[11380]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1141, N'<Image id="1141" key="b104fe14-5370-4910-bd79-42e3846a4956" parentID="1139" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:33" updateDate="2018-09-16T16:09:33" nodeName="2.png" urlName="2png" path="-1,1053,1139,1141" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="00f22160-51b5-4097-8c92-65c747ec6b8b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1079/2.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[80]]></umbracoWidth><umbracoHeight><![CDATA[80]]></umbracoHeight><umbracoBytes><![CDATA[11916]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1142, N'<Image id="1142" key="7d474c43-565e-459a-96b4-319834779b34" parentID="1139" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:34" updateDate="2018-09-16T16:09:34" nodeName="3.png" urlName="3png" path="-1,1053,1139,1142" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="bc4cc61d-95ae-4748-b190-c08308b74bec" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1080/3.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[80]]></umbracoWidth><umbracoHeight><![CDATA[80]]></umbracoHeight><umbracoBytes><![CDATA[13847]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1143, N'<Image id="1143" key="41811d32-94fe-47b8-bdec-2c8c02bb940e" parentID="1139" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:34" updateDate="2018-09-16T16:09:34" nodeName="4.png" urlName="4png" path="-1,1053,1139,1143" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="2026df61-6ca9-438d-98dd-de87123dde2d" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1081/4.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[80]]></umbracoWidth><umbracoHeight><![CDATA[80]]></umbracoHeight><umbracoBytes><![CDATA[12312]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1144, N'<Image id="1144" key="4b54eaa3-f260-4a73-ad85-114039789d8e" parentID="1139" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:34" updateDate="2018-09-16T16:09:34" nodeName="5.png" urlName="5png" path="-1,1053,1139,1144" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="95539d76-49a4-4c62-8e5e-4b3841f31491" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1082/5.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[80]]></umbracoWidth><umbracoHeight><![CDATA[80]]></umbracoHeight><umbracoBytes><![CDATA[10909]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1145, N'<Image id="1145" key="6a5d6260-4d29-464f-bbfc-7a5699ba33c2" parentID="1139" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:34" updateDate="2018-09-16T16:09:34" nodeName="6.png" urlName="6png" path="-1,1053,1139,1145" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="8cf2a3fd-094e-43a0-8a98-c48bbd9afc31" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1083/6.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[80]]></umbracoWidth><umbracoHeight><![CDATA[80]]></umbracoHeight><umbracoBytes><![CDATA[11396]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1146, N'<Image id="1146" key="2c4b5f3c-c8ae-4751-8323-2b48d12aa669" parentID="1139" level="3" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:34" updateDate="2018-09-16T16:09:34" nodeName="7.png" urlName="7png" path="-1,1053,1139,1146" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="7e6ccc0f-d6b8-4b05-b3ed-9691c21bb658" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1084/7.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[80]]></umbracoWidth><umbracoHeight><![CDATA[80]]></umbracoHeight><umbracoBytes><![CDATA[11733]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1147, N'<Image id="1147" key="c9571a22-9f9e-4a1f-8259-e9716d7a14c3" parentID="1139" level="3" creatorID="0" sortOrder="7" createDate="2018-09-16T16:09:34" updateDate="2018-09-16T16:09:34" nodeName="8.png" urlName="8png" path="-1,1053,1139,1147" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="116f2fb8-0b18-4ce6-a1ad-f5de584a6687" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1085/8.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[80]]></umbracoWidth><umbracoHeight><![CDATA[80]]></umbracoHeight><umbracoBytes><![CDATA[10651]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1148, N'<Image id="1148" key="9141b820-8ca5-4085-85bd-db86f6ffd763" parentID="1139" level="3" creatorID="0" sortOrder="8" createDate="2018-09-16T16:09:34" updateDate="2018-09-16T16:09:34" nodeName="sidebar-testi-1.png" urlName="sidebar-testi-1png" path="-1,1053,1139,1148" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="7d08f76e-1ca2-419a-a21b-2ff6676bcba6" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1086/sidebar-testi-1.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[55]]></umbracoWidth><umbracoHeight><![CDATA[55]]></umbracoHeight><umbracoBytes><![CDATA[6850]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1149, N'<Image id="1149" key="53379b98-de52-4ea2-80f1-bee846d4b169" parentID="1139" level="3" creatorID="0" sortOrder="9" createDate="2018-09-16T16:09:35" updateDate="2018-09-16T16:09:35" nodeName="sidebar-testi-2.png" urlName="sidebar-testi-2png" path="-1,1053,1139,1149" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="ec122e97-ac76-498d-89fc-5eeeada961c4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1087/sidebar-testi-2.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[55]]></umbracoWidth><umbracoHeight><![CDATA[55]]></umbracoHeight><umbracoBytes><![CDATA[7117]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1150, N'<Folder id="1150" key="d1c1a46e-4824-4e10-b670-61e79334b67f" parentID="1053" level="2" creatorID="0" sortOrder="9" createDate="2018-09-16T16:09:35" updateDate="2018-09-16T16:09:35" nodeName="about" urlName="about" path="-1,1053,1150" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="a35befe0-af0f-4475-9ed7-10a0f832f905" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1151, N'<Image id="1151" key="3bbf9a68-6f6f-4cd9-899f-63b16a7ad798" parentID="1150" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:35" updateDate="2018-09-16T16:09:35" nodeName="mission.jpg" urlName="missionjpg" path="-1,1053,1150,1151" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="426c66ac-7fd4-42df-91ba-53c5f195afbe" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1088/mission.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[300]]></umbracoHeight><umbracoBytes><![CDATA[75160]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1152, N'<Image id="1152" key="c997eea8-b444-494c-98f9-31e4d81110ad" parentID="1150" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:35" updateDate="2018-09-16T16:09:35" nodeName="vision.jpg" urlName="visionjpg" path="-1,1053,1150,1152" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c63da573-dc88-4985-b848-74923efc48da" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1089/vision.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[300]]></umbracoHeight><umbracoBytes><![CDATA[64300]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
GO
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1153, N'<Folder id="1153" key="b17739de-2ac5-49c5-9ef9-c68949741ffd" parentID="1053" level="2" creatorID="0" sortOrder="10" createDate="2018-09-16T16:09:35" updateDate="2018-09-16T16:09:35" nodeName="blog" urlName="blog" path="-1,1053,1153" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="be1185a4-dab2-4909-9fa1-d3d5e18ba588" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1154, N'<Image id="1154" key="7119cff9-3396-466c-abe3-a4b271cd700c" parentID="1153" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:35" updateDate="2018-09-16T16:09:35" nodeName="author.jpg" urlName="authorjpg" path="-1,1053,1153,1154" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="324102d5-ac20-4c8c-bcc4-4dba55697ef1" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1090/author.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[85]]></umbracoWidth><umbracoHeight><![CDATA[85]]></umbracoHeight><umbracoBytes><![CDATA[7754]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1155, N'<Image id="1155" key="bb5bfaf2-8c46-4266-8141-fb4aee314681" parentID="1153" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:35" updateDate="2018-09-16T16:09:35" nodeName="blog-single.jpg" urlName="blog-singlejpg" path="-1,1053,1153,1155" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="ab871d36-44b2-427d-ae8f-6e4709c86530" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1091/blog-single.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[770]]></umbracoWidth><umbracoHeight><![CDATA[370]]></umbracoHeight><umbracoBytes><![CDATA[184030]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1156, N'<Image id="1156" key="8609e8b1-5a26-4b3f-a67e-b2aa739b00dd" parentID="1153" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:35" updateDate="2018-09-16T16:09:35" nodeName="caption-img.jpg" urlName="caption-imgjpg" path="-1,1053,1153,1156" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="750ccfbe-728e-4c18-b48a-a8f11ed7a05f" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1092/caption-img.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[345]]></umbracoWidth><umbracoHeight><![CDATA[215]]></umbracoHeight><umbracoBytes><![CDATA[83937]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1157, N'<Image id="1157" key="c7e09603-9ae8-4f48-8adb-f7179bdc2ccd" parentID="1153" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:35" updateDate="2018-09-16T16:09:35" nodeName="comment-1.jpg" urlName="comment-1jpg" path="-1,1053,1153,1157" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="d4f9630c-1aea-4d0b-b08e-54abae55a72d" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1093/comment-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[60]]></umbracoWidth><umbracoHeight><![CDATA[60]]></umbracoHeight><umbracoBytes><![CDATA[5242]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1158, N'<Image id="1158" key="cc8631d8-af79-4733-aaf3-a24da95780f1" parentID="1153" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:36" updateDate="2018-09-16T16:09:36" nodeName="comment-2.jpg" urlName="comment-2jpg" path="-1,1053,1153,1158" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="0d8b6a0a-e4c8-47e4-89cf-38875bdb0a8a" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1094/comment-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[60]]></umbracoWidth><umbracoHeight><![CDATA[60]]></umbracoHeight><umbracoBytes><![CDATA[5391]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1159, N'<Image id="1159" key="3a8c48e2-c50d-459b-ab41-aebc1e9731a4" parentID="1153" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:36" updateDate="2018-09-16T16:09:36" nodeName="lat-blog-1.jpg" urlName="lat-blog-1jpg" path="-1,1053,1153,1159" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="08d0d28a-629f-4c25-b798-320ee136f09d" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1095/lat-blog-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[185]]></umbracoHeight><umbracoBytes><![CDATA[59559]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1160, N'<Image id="1160" key="ef8be11e-b6c3-415a-9168-4c1876fb4831" parentID="1153" level="3" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:36" updateDate="2018-09-16T16:09:36" nodeName="lat-blog-2.jpg" urlName="lat-blog-2jpg" path="-1,1053,1153,1160" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="bcaab792-070c-4e47-b2bd-72efef6a3738" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1096/lat-blog-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[270]]></umbracoWidth><umbracoHeight><![CDATA[185]]></umbracoHeight><umbracoBytes><![CDATA[46522]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1161, N'<Image id="1161" key="5f7239a9-f9ad-4516-9802-deb0156161f2" parentID="1153" level="3" creatorID="0" sortOrder="7" createDate="2018-09-16T16:09:36" updateDate="2018-09-16T16:09:36" nodeName="v1-1.jpg" urlName="v1-1jpg" path="-1,1053,1153,1161" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="62ebe452-e2e1-4ff2-9c2a-be1cbc2c54db" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1097/v1-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[300]]></umbracoHeight><umbracoBytes><![CDATA[72144]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1162, N'<Image id="1162" key="7e33164c-8529-427c-8274-99a36a2f6aa5" parentID="1153" level="3" creatorID="0" sortOrder="8" createDate="2018-09-16T16:09:36" updateDate="2018-09-16T16:09:36" nodeName="v1-2.jpg" urlName="v1-2jpg" path="-1,1053,1153,1162" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="e318522a-da70-42c9-9bef-e7b7f9929a39" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1098/v1-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[300]]></umbracoHeight><umbracoBytes><![CDATA[105557]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1163, N'<Image id="1163" key="389cc9b9-3571-49d8-ba51-b756a1d6ad75" parentID="1153" level="3" creatorID="0" sortOrder="9" createDate="2018-09-16T16:09:36" updateDate="2018-09-16T16:09:36" nodeName="v1-3.jpg" urlName="v1-3jpg" path="-1,1053,1153,1163" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="d905ede1-105b-4e5a-9698-b595b381954a" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1099/v1-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[300]]></umbracoHeight><umbracoBytes><![CDATA[119089]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1164, N'<Image id="1164" key="1f11c9d0-ce3f-4ac1-83ab-c1e9315908cf" parentID="1153" level="3" creatorID="0" sortOrder="10" createDate="2018-09-16T16:09:36" updateDate="2018-09-16T16:09:36" nodeName="v1-4.jpg" urlName="v1-4jpg" path="-1,1053,1153,1164" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="0896544c-c8cc-4d96-8eb9-0d17066190e5" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1100/v1-4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[300]]></umbracoHeight><umbracoBytes><![CDATA[93223]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1165, N'<Image id="1165" key="f9f22d02-4be4-4dbd-ae65-e3e180f4f4b1" parentID="1153" level="3" creatorID="0" sortOrder="11" createDate="2018-09-16T16:09:37" updateDate="2018-09-16T16:09:37" nodeName="v2-1.jpg" urlName="v2-1jpg" path="-1,1053,1153,1165" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c0c38d10-aaf5-464d-8ac9-9470f5656135" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1101/v2-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[58813]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1166, N'<Image id="1166" key="5127e556-f353-45a4-a2a7-197714304fa3" parentID="1153" level="3" creatorID="0" sortOrder="12" createDate="2018-09-16T16:09:37" updateDate="2018-09-16T16:09:37" nodeName="v2-2.jpg" urlName="v2-2jpg" path="-1,1053,1153,1166" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="a0bb59ab-f760-4ccf-bbac-effdf0d81a38" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1102/v2-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[87110]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1167, N'<Image id="1167" key="a4ddec46-1172-409a-aee5-a8ccb62ad443" parentID="1153" level="3" creatorID="0" sortOrder="13" createDate="2018-09-16T16:09:37" updateDate="2018-09-16T16:09:37" nodeName="v2-3.jpg" urlName="v2-3jpg" path="-1,1053,1153,1167" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="857a6063-af42-4ac8-97ce-dc1ddf2f100b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1103/v2-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[89224]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1168, N'<Image id="1168" key="9507fabf-86fd-40b7-b9b3-0ffe9b8756a0" parentID="1153" level="3" creatorID="0" sortOrder="14" createDate="2018-09-16T16:09:37" updateDate="2018-09-16T16:09:37" nodeName="v2-4.jpg" urlName="v2-4jpg" path="-1,1053,1153,1168" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="1335e95a-4f0e-4541-ad9d-da3935268c15" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1104/v2-4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[68669]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1169, N'<Image id="1169" key="27de21c1-faa5-4441-a37a-a6c6a904fe5a" parentID="1153" level="3" creatorID="0" sortOrder="15" createDate="2018-09-16T16:09:37" updateDate="2018-09-16T16:09:37" nodeName="v2-5.jpg" urlName="v2-5jpg" path="-1,1053,1153,1169" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="4a4ff14c-15a8-45f1-986a-445bb8658e4e" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1105/v2-5.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[138989]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1170, N'<Image id="1170" key="74b44ba8-29e4-4bcd-9f70-bf8495d4d6ad" parentID="1153" level="3" creatorID="0" sortOrder="16" createDate="2018-09-16T16:09:37" updateDate="2018-09-16T16:09:37" nodeName="v2-6.jpg" urlName="v2-6jpg" path="-1,1053,1153,1170" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="96ed0972-4b36-4529-86fc-9a14082d68f9" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1106/v2-6.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[220]]></umbracoHeight><umbracoBytes><![CDATA[95609]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1171, N'<Image id="1171" key="815668b8-e91f-4cea-9881-d075d7969ea0" parentID="1153" level="3" creatorID="0" sortOrder="17" createDate="2018-09-16T16:09:38" updateDate="2018-09-16T16:09:38" nodeName="v3-1.jpg" urlName="v3-1jpg" path="-1,1053,1153,1171" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="821996ff-b0a0-48b3-a59d-508d90a26a3f" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1107/v3-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[770]]></umbracoWidth><umbracoHeight><![CDATA[370]]></umbracoHeight><umbracoBytes><![CDATA[151446]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1172, N'<Image id="1172" key="7b3b12a6-d899-4b44-9649-2cf465bebf25" parentID="1153" level="3" creatorID="0" sortOrder="18" createDate="2018-09-16T16:09:38" updateDate="2018-09-16T16:09:38" nodeName="v3-2.jpg" urlName="v3-2jpg" path="-1,1053,1153,1172" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="434dc18e-a1be-4678-a015-7d3406098c63" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1108/v3-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[770]]></umbracoWidth><umbracoHeight><![CDATA[370]]></umbracoHeight><umbracoBytes><![CDATA[212832]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1173, N'<Image id="1173" key="1faad36d-9c81-49d5-9670-211f27268628" parentID="1153" level="3" creatorID="0" sortOrder="19" createDate="2018-09-16T16:09:38" updateDate="2018-09-16T16:09:38" nodeName="v3-3.jpg" urlName="v3-3jpg" path="-1,1053,1153,1173" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="568ece08-48b1-4bb1-aded-151687a3fcd4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1109/v3-3.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[770]]></umbracoWidth><umbracoHeight><![CDATA[370]]></umbracoHeight><umbracoBytes><![CDATA[249337]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1174, N'<Image id="1174" key="1889605a-1d85-4aec-8fb3-ff050828a5da" parentID="1153" level="3" creatorID="0" sortOrder="20" createDate="2018-09-16T16:09:38" updateDate="2018-09-16T16:09:38" nodeName="v3-4.jpg" urlName="v3-4jpg" path="-1,1053,1153,1174" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="ac1fc696-49da-4205-bd1d-5d45df3d6720" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1110/v3-4.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[770]]></umbracoWidth><umbracoHeight><![CDATA[370]]></umbracoHeight><umbracoBytes><![CDATA[187332]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1175, N'<Folder id="1175" key="0fb0e5e5-75e5-4d05-80b3-da9a8b6839cb" parentID="1053" level="2" creatorID="0" sortOrder="11" createDate="2018-09-16T16:09:38" updateDate="2018-09-16T16:09:38" nodeName="brand" urlName="brand" path="-1,1053,1175" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="8ca657ef-7d56-44a8-b780-b4a0b969b140" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1176, N'<Image id="1176" key="3987c6df-cceb-4ec8-b901-5757f77aa74a" parentID="1175" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:39" updateDate="2018-09-16T16:09:39" nodeName="1.png" urlName="1png" path="-1,1053,1175,1176" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="83210281-b8ed-427a-acb4-9ecb66c70a74" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1111/1.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[130]]></umbracoWidth><umbracoHeight><![CDATA[60]]></umbracoHeight><umbracoBytes><![CDATA[4260]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1177, N'<Image id="1177" key="ca055297-dc59-411a-97ce-eb6944282e9f" parentID="1175" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:39" updateDate="2018-09-16T16:09:39" nodeName="2.png" urlName="2png" path="-1,1053,1175,1177" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="632c10fa-b22a-46d0-a381-1c3367f1a59e" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1112/2.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[130]]></umbracoWidth><umbracoHeight><![CDATA[60]]></umbracoHeight><umbracoBytes><![CDATA[3543]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1178, N'<Folder id="1178" key="38c9d62d-a02a-40f6-97d4-5845e96ea06f" parentID="1053" level="2" creatorID="0" sortOrder="12" createDate="2018-09-16T16:09:39" updateDate="2018-09-16T16:09:39" nodeName="fancybox" urlName="fancybox" path="-1,1053,1178" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="0f121470-d8a7-4fdf-ae52-b616136d17da" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1179, N'<Image id="1179" key="eb8d5e72-81b4-4125-bd20-a5e05660b81b" parentID="1178" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:39" updateDate="2018-09-16T16:09:39" nodeName="blank.gif" urlName="blankgif" path="-1,1053,1178,1179" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="593227ac-3da9-4631-984f-15accf413fef" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1113/blank.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1]]></umbracoWidth><umbracoHeight><![CDATA[1]]></umbracoHeight><umbracoBytes><![CDATA[43]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1180, N'<Image id="1180" key="76c26402-d6ad-4cd1-9712-cf4edac35130" parentID="1178" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:39" updateDate="2018-09-16T16:09:39" nodeName="fancybox_loading.gif" urlName="fancybox_loadinggif" path="-1,1053,1178,1180" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="fa647386-2cd1-4bcc-a0a5-4b86dc04eef1" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1114/fancybox_loading.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[24]]></umbracoWidth><umbracoHeight><![CDATA[24]]></umbracoHeight><umbracoBytes><![CDATA[6567]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1181, N'<Image id="1181" key="a049bbd6-9831-4662-a66a-a8c529f3e8d7" parentID="1178" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:39" updateDate="2018-09-16T16:09:39" nodeName="fancybox_loading@2x.gif" urlName="fancybox_loading-2xgif" path="-1,1053,1178,1181" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="cc64cf40-b629-4ad5-acc1-ff6daa2ce602" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1115/fancybox_loading-2x.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[48]]></umbracoWidth><umbracoHeight><![CDATA[48]]></umbracoHeight><umbracoBytes><![CDATA[13984]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1182, N'<Image id="1182" key="6a4dc749-f7e2-4df5-85e1-d2823698f9a0" parentID="1178" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:39" updateDate="2018-09-16T16:09:39" nodeName="fancybox_overlay.png" urlName="fancybox_overlaypng" path="-1,1053,1178,1182" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="facfdb4b-1ab4-4a83-a3a9-3a4b5577ee42" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1116/fancybox_overlay.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[10]]></umbracoWidth><umbracoHeight><![CDATA[10]]></umbracoHeight><umbracoBytes><![CDATA[1003]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1183, N'<Image id="1183" key="35a797f7-2998-4fe0-96a0-a2344fad59d4" parentID="1178" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:39" updateDate="2018-09-16T16:09:39" nodeName="fancybox_sprite.png" urlName="fancybox_spritepng" path="-1,1053,1178,1183" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="16b3c4f8-5d29-4b35-b9bc-f941d0eda5d5" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1117/fancybox_sprite.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[44]]></umbracoWidth><umbracoHeight><![CDATA[152]]></umbracoHeight><umbracoBytes><![CDATA[1362]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1184, N'<Image id="1184" key="b390390c-c8cb-4156-94c2-bb11d391fcae" parentID="1178" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="fancybox_sprite@2x.png" urlName="fancybox_sprite-2xpng" path="-1,1053,1178,1184" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="b8f654a7-a26f-4c86-acfa-fa38c0a5328d" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1118/fancybox_sprite-2x.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[88]]></umbracoWidth><umbracoHeight><![CDATA[304]]></umbracoHeight><umbracoBytes><![CDATA[6553]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1185, N'<Folder id="1185" key="44e3c755-c3b8-49b8-8f0e-3b6403450c40" parentID="1053" level="2" creatorID="0" sortOrder="13" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="favicon" urlName="favicon" path="-1,1053,1185" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="27d8ac6b-8ae3-4725-8688-87a2a4558994" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1186, N'<Image id="1186" key="3216ffb0-b161-4409-ba11-a3e3ca02a277" parentID="1185" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="apple-touch-icon.png" urlName="apple-touch-iconpng" path="-1,1053,1185,1186" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="da64f9c8-392e-4404-863a-a7d0433282e6" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1119/apple-touch-icon.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[180]]></umbracoWidth><umbracoHeight><![CDATA[180]]></umbracoHeight><umbracoBytes><![CDATA[3896]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1187, N'<Image id="1187" key="e500c50a-9acf-4516-a7b5-788da13a3b7c" parentID="1185" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="favicon-16x16.png" urlName="favicon-16x16png" path="-1,1053,1185,1187" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="ecf48e1d-0c6b-49ea-b69c-d305691024ab" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1120/favicon-16x16.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[16]]></umbracoWidth><umbracoHeight><![CDATA[16]]></umbracoHeight><umbracoBytes><![CDATA[923]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1188, N'<Image id="1188" key="5e3925f8-24cf-44b0-b341-c2b86cc162d7" parentID="1185" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="favicon-32x32.png" urlName="favicon-32x32png" path="-1,1053,1185,1188" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="73275192-06d1-45b2-90c6-957ba8dd29bc" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1121/favicon-32x32.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[32]]></umbracoWidth><umbracoHeight><![CDATA[32]]></umbracoHeight><umbracoBytes><![CDATA[1328]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1189, N'<Folder id="1189" key="c0833148-c30e-4faa-9603-e1a9a9b3ee14" parentID="1053" level="2" creatorID="0" sortOrder="14" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="footer" urlName="footer" path="-1,1053,1189" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="f8fe6413-0327-4d49-9f23-07d07bdb41c4" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1190, N'<Image id="1190" key="5322585c-48e6-4b22-950f-b5b227565d0b" parentID="1189" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="footer-logo.png" urlName="footer-logopng" path="-1,1053,1189,1190" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="0dd39825-dc68-458e-8343-ced375287853" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1122/footer-logo.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[220]]></umbracoWidth><umbracoHeight><![CDATA[60]]></umbracoHeight><umbracoBytes><![CDATA[7630]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1191, N'<Folder id="1191" key="a513bc13-62f3-441c-9de3-8bc75516d564" parentID="1053" level="2" creatorID="0" sortOrder="15" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="history" urlName="history" path="-1,1053,1191" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="47300941-2d6f-4291-aa7c-ae7f280cf3e0" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1192, N'<Image id="1192" key="9f24ee30-1d22-4d65-b2d3-eea9640fe49f" parentID="1191" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="1.jpg" urlName="1jpg" path="-1,1053,1191,1192" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="588e6dff-9660-4be7-b647-5a0bfa11a80b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1123/1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[450]]></umbracoWidth><umbracoHeight><![CDATA[240]]></umbracoHeight><umbracoBytes><![CDATA[137967]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1193, N'<Image id="1193" key="51ba6c30-45dc-4dc0-9b7c-f810d0fb5dc7" parentID="1191" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:40" updateDate="2018-09-16T16:09:40" nodeName="2.jpg" urlName="2jpg" path="-1,1053,1191,1193" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="f3b60a16-ad74-49b7-a4a7-1e72bfb69c58" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1124/2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[450]]></umbracoWidth><umbracoHeight><![CDATA[240]]></umbracoHeight><umbracoBytes><![CDATA[75070]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1194, N'<Folder id="1194" key="c46d470e-95e7-4bfc-9a25-6160fbce5c66" parentID="1053" level="2" creatorID="0" sortOrder="16" createDate="2018-09-16T16:09:41" updateDate="2018-09-16T16:09:41" nodeName="icon" urlName="icon" path="-1,1053,1194" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="322ea4bf-0f8d-437d-b983-9b983bacffbc" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1195, N'<Image id="1195" key="9f54430f-e57a-48c3-b356-78cc7c4ec314" parentID="1194" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:41" updateDate="2018-09-16T16:09:41" nodeName="bx_loader.gif" urlName="bx_loadergif" path="-1,1053,1194,1195" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="4f841bc5-c1ce-4a66-9fb0-128adc068167" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1125/bx_loader.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[32]]></umbracoWidth><umbracoHeight><![CDATA[32]]></umbracoHeight><umbracoBytes><![CDATA[8581]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1196, N'<Image id="1196" key="35cae49f-3d39-4d10-9bca-0c2daa8a0c22" parentID="1194" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:41" updateDate="2018-09-16T16:09:41" nodeName="preloader.gif" urlName="preloadergif" path="-1,1053,1194,1196" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c2745744-269e-4425-9dee-e30128c66ffe" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1126/preloader.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[90]]></umbracoWidth><umbracoHeight><![CDATA[90]]></umbracoHeight><umbracoBytes><![CDATA[12494]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1197, N'<Image id="1197" key="fac4d855-32cd-406e-a855-618a1a485390" parentID="1194" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:41" updateDate="2018-09-16T16:09:41" nodeName="submenu-icon.png" urlName="submenu-iconpng" path="-1,1053,1194,1197" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="7005b81d-d45b-43e3-b04c-f3216ef2054f" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1127/submenu-icon.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[24]]></umbracoWidth><umbracoHeight><![CDATA[24]]></umbracoHeight><umbracoBytes><![CDATA[163]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1198, N'<Image id="1198" key="fdb908d6-b4ef-4d69-aaa7-44ccfe0c3cc8" parentID="1194" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:41" updateDate="2018-09-16T16:09:41" nodeName="tick.png" urlName="tickpng" path="-1,1053,1194,1198" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="89a5508c-1226-4811-b44e-3b4df277073b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1128/tick.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[20]]></umbracoWidth><umbracoHeight><![CDATA[20]]></umbracoHeight><umbracoBytes><![CDATA[15057]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1199, N'<Folder id="1199" key="0e3c1bc3-1521-457f-a08d-1e54ad99d795" parentID="1053" level="2" creatorID="0" sortOrder="17" createDate="2018-09-16T16:09:41" updateDate="2018-09-16T16:09:41" nodeName="parallax-background" urlName="parallax-background" path="-1,1053,1199" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="241a2413-3dee-4765-ae15-741b2dfed4f0" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1200, N'<Image id="1200" key="470bc052-b314-40f9-af2f-99f395e79cbe" parentID="1199" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:41" updateDate="2018-09-16T16:09:41" nodeName="choose-bg.jpg" urlName="choose-bgjpg" path="-1,1053,1199,1200" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="9cb1db9f-99eb-4272-bc5e-e5019041b4e4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1129/choose-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1170]]></umbracoWidth><umbracoHeight><![CDATA[290]]></umbracoHeight><umbracoBytes><![CDATA[177172]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1201, N'<Image id="1201" key="67d4a302-cd61-4f6a-bcb6-9d27251cbea5" parentID="1199" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:41" updateDate="2018-09-16T16:09:41" nodeName="consultation-bg.jpg" urlName="consultation-bgjpg" path="-1,1053,1199,1201" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="dcf33e69-6223-4dff-9d12-6a09b0f0eb79" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1130/consultation-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[335]]></umbracoHeight><umbracoBytes><![CDATA[284601]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1202, N'<Image id="1202" key="46c188f7-dc74-4076-8833-a3212a6c404f" parentID="1199" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:42" updateDate="2018-09-16T16:09:42" nodeName="contact-details-bg.jpg" urlName="contact-details-bgjpg" path="-1,1053,1199,1202" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="f1093abd-81f5-440b-b480-07c0a837ac49" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1131/contact-details-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[585]]></umbracoWidth><umbracoHeight><![CDATA[371]]></umbracoHeight><umbracoBytes><![CDATA[166377]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1203, N'<Image id="1203" key="9dc4f434-2be5-4dde-9b5b-49a40c86b0f2" parentID="1199" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:42" updateDate="2018-09-16T16:09:42" nodeName="covered-bg.jpg" urlName="covered-bgjpg" path="-1,1053,1199,1203" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="5fc9dbc7-b441-4f03-ab0b-e2cad2884d9c" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1132/covered-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[835]]></umbracoHeight><umbracoBytes><![CDATA[380436]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1204, N'<Image id="1204" key="60e1fb85-13b6-4aba-a9ac-1f01a04a5577" parentID="1199" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:42" updateDate="2018-09-16T16:09:42" nodeName="service-about-bg.jpg" urlName="service-about-bgjpg" path="-1,1053,1199,1204" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="c9d9802e-3142-410c-8f64-3f28db001e37" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1133/service-about-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[420]]></umbracoHeight><umbracoBytes><![CDATA[372256]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1205, N'<Image id="1205" key="7a0ef724-0dbc-4025-a365-05620250a44f" parentID="1199" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:42" updateDate="2018-09-16T16:09:42" nodeName="slogan-bg.jpg" urlName="slogan-bgjpg" path="-1,1053,1199,1205" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="084b97da-e6ee-400f-9b47-2053d1a47898" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1134/slogan-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[100]]></umbracoHeight><umbracoBytes><![CDATA[193044]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1206, N'<Image id="1206" key="f2381f26-8745-4163-9585-5a3752581ee6" parentID="1199" level="3" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:43" updateDate="2018-09-16T16:09:43" nodeName="testimonial-section-bg.jpg" urlName="testimonial-section-bgjpg" path="-1,1053,1199,1206" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="b3d5126f-4c19-4208-ae62-7323919212ff" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1135/testimonial-section-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[665]]></umbracoHeight><umbracoBytes><![CDATA[267974]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1207, N'<Folder id="1207" key="5b141e33-3046-4721-acd6-dc08c005a2c8" parentID="1053" level="2" creatorID="0" sortOrder="18" createDate="2018-09-16T16:09:43" updateDate="2018-09-16T16:09:43" nodeName="prettyPhoto" urlName="prettyphoto" path="-1,1053,1207" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="5a723c0f-decc-4af4-a475-1b207801eed5" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1208, N'<Folder id="1208" key="210815c1-602f-44ca-9be0-088872a09296" parentID="1207" level="3" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:43" updateDate="2018-09-16T16:09:43" nodeName="dark_rounded" urlName="dark_rounded" path="-1,1053,1207,1208" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="e3e8b00c-9f10-4dd1-8cf8-7d95b73b5fcf" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1209, N'<Image id="1209" key="f15fe131-2117-4821-b643-af188fe303cd" parentID="1208" level="4" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:43" updateDate="2018-09-16T16:09:43" nodeName="btnNext.png" urlName="btnnextpng" path="-1,1053,1207,1208,1209" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="a56eff46-b4d2-4959-93ba-de3f016d4072" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1136/btnnext.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[61]]></umbracoWidth><umbracoHeight><![CDATA[22]]></umbracoHeight><umbracoBytes><![CDATA[1411]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1210, N'<Image id="1210" key="1b767f40-d048-4581-ac13-6238943c6283" parentID="1208" level="4" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:43" updateDate="2018-09-16T16:09:43" nodeName="btnPrevious.png" urlName="btnpreviouspng" path="-1,1053,1207,1208,1210" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="20dc4b96-2fe5-4a37-b3dd-b07b85a4b758" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1137/btnprevious.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[61]]></umbracoWidth><umbracoHeight><![CDATA[22]]></umbracoHeight><umbracoBytes><![CDATA[1442]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1211, N'<Image id="1211" key="8a6253ef-5d47-48a6-a45d-9e1979671497" parentID="1208" level="4" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:43" updateDate="2018-09-16T16:09:43" nodeName="contentPattern.png" urlName="contentpatternpng" path="-1,1053,1207,1208,1211" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="eb754c7b-db90-438c-b74f-bcc775a2e6da" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1138/contentpattern.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[20]]></umbracoWidth><umbracoHeight><![CDATA[20]]></umbracoHeight><umbracoBytes><![CDATA[130]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1212, N'<Image id="1212" key="8558e140-6158-4548-ae9a-ff53dc2637c3" parentID="1208" level="4" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:43" updateDate="2018-09-16T16:09:43" nodeName="loader.gif" urlName="loadergif" path="-1,1053,1207,1208,1212" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="0353db66-d1e0-4230-9bff-23d4bbc100ef" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1139/loader.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[24]]></umbracoWidth><umbracoHeight><![CDATA[24]]></umbracoHeight><umbracoBytes><![CDATA[2545]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1213, N'<Image id="1213" key="adc6e5b4-b723-4f58-8eb8-6de7367d3f65" parentID="1208" level="4" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:43" updateDate="2018-09-16T16:09:43" nodeName="sprite.png" urlName="spritepng" path="-1,1053,1207,1208,1213" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="858e46ee-3316-4e44-897e-4e8a1038903f" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1140/sprite.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[130]]></umbracoWidth><umbracoHeight><![CDATA[119]]></umbracoHeight><umbracoBytes><![CDATA[4076]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1214, N'<Folder id="1214" key="3a81f9b8-07b8-4090-9123-0cc6fdc29370" parentID="1207" level="3" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:44" updateDate="2018-09-16T16:09:44" nodeName="dark_square" urlName="dark_square" path="-1,1053,1207,1214" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="a5ca47af-d1b0-4db2-b2f0-51f35d392a8c" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1215, N'<Image id="1215" key="fee4ce98-bff0-4d20-a0e3-634f5fca43e3" parentID="1214" level="4" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:44" updateDate="2018-09-16T16:09:44" nodeName="btnNext.png" urlName="btnnextpng" path="-1,1053,1207,1214,1215" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="e6c1c8ea-5501-44f0-a19a-5bf0ea7f84b6" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1141/btnnext.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[61]]></umbracoWidth><umbracoHeight><![CDATA[22]]></umbracoHeight><umbracoBytes><![CDATA[1411]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1216, N'<Image id="1216" key="d779b41d-7ad3-422f-a88d-42a3b71d1baa" parentID="1214" level="4" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:44" updateDate="2018-09-16T16:09:44" nodeName="btnPrevious.png" urlName="btnpreviouspng" path="-1,1053,1207,1214,1216" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="dcb1b2df-a077-481c-ac3f-e7d4abb183ec" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1142/btnprevious.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[61]]></umbracoWidth><umbracoHeight><![CDATA[22]]></umbracoHeight><umbracoBytes><![CDATA[1442]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1217, N'<Image id="1217" key="9e23a18a-1513-4772-84bd-b27b19e3f925" parentID="1214" level="4" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:44" updateDate="2018-09-16T16:09:44" nodeName="loader.gif" urlName="loadergif" path="-1,1053,1207,1214,1217" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="764ed384-84fa-4482-9e95-fc47198e25a2" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1143/loader.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[24]]></umbracoWidth><umbracoHeight><![CDATA[24]]></umbracoHeight><umbracoBytes><![CDATA[2545]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1218, N'<Image id="1218" key="76e77602-0b73-4cba-8f31-eecd8034d73e" parentID="1214" level="4" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:44" updateDate="2018-09-16T16:09:44" nodeName="sprite.png" urlName="spritepng" path="-1,1053,1207,1214,1218" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="de3c142b-490b-43c5-977a-49edc1d1acc4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1144/sprite.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[76]]></umbracoWidth><umbracoHeight><![CDATA[119]]></umbracoHeight><umbracoBytes><![CDATA[3507]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1219, N'<Folder id="1219" key="525b57ef-5526-43dc-9afe-d1466dcb905d" parentID="1207" level="3" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:44" updateDate="2018-09-16T16:09:44" nodeName="default" urlName="default" path="-1,1053,1207,1219" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="9a0dd485-aa7c-48e7-831b-2caf46a9c153" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1220, N'<Image id="1220" key="cdc99a5a-7888-45bb-8625-40aabfcf3793" parentID="1219" level="4" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:44" updateDate="2018-09-16T16:09:44" nodeName="default_thumb.png" urlName="default_thumbpng" path="-1,1053,1207,1219,1220" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="b73f209d-e0b6-4293-8594-597b906ffc04" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1145/default_thumb.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[50]]></umbracoWidth><umbracoHeight><![CDATA[33]]></umbracoHeight><umbracoBytes><![CDATA[1537]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1221, N'<Image id="1221" key="b7f2230f-59db-4622-bfe0-29fef4ff46c6" parentID="1219" level="4" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:44" updateDate="2018-09-16T16:09:44" nodeName="loader.gif" urlName="loadergif" path="-1,1053,1207,1219,1221" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="843f07e5-c86e-4d0c-881d-fcb34fe3acca" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1146/loader.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[20]]></umbracoWidth><umbracoHeight><![CDATA[20]]></umbracoHeight><umbracoBytes><![CDATA[6331]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1222, N'<Image id="1222" key="e31ebc82-8f00-4451-bf37-8718401d0787" parentID="1219" level="4" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:44" updateDate="2018-09-16T16:09:44" nodeName="sprite.png" urlName="spritepng" path="-1,1053,1207,1219,1222" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="8ce3d0c1-bc3d-4baf-9e52-faa78951e44c" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1147/sprite.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[130]]></umbracoWidth><umbracoHeight><![CDATA[147]]></umbracoHeight><umbracoBytes><![CDATA[6682]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1223, N'<Image id="1223" key="8bf0cac5-9672-4662-8854-ce129c12e27c" parentID="1219" level="4" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:45" updateDate="2018-09-16T16:09:45" nodeName="sprite_next.png" urlName="sprite_nextpng" path="-1,1053,1207,1219,1223" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="8aca3e8e-7655-45d1-9598-a715dd29f2a4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1148/sprite_next.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[28]]></umbracoWidth><umbracoHeight><![CDATA[30]]></umbracoHeight><umbracoBytes><![CDATA[1358]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1224, N'<Image id="1224" key="53dc1b8a-94e5-451c-aec0-884bc887edb4" parentID="1219" level="4" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:45" updateDate="2018-09-16T16:09:45" nodeName="sprite_prev.png" urlName="sprite_prevpng" path="-1,1053,1207,1219,1224" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="5d790c2e-ccb2-4105-a036-cdeda14e893b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1149/sprite_prev.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[27]]></umbracoWidth><umbracoHeight><![CDATA[30]]></umbracoHeight><umbracoBytes><![CDATA[1376]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1225, N'<Image id="1225" key="a7724e37-fa6e-453d-b1a9-c652ee49f961" parentID="1219" level="4" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:45" updateDate="2018-09-16T16:09:45" nodeName="sprite_x.png" urlName="sprite_xpng" path="-1,1053,1207,1219,1225" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="7cf8d5ca-3df5-42ed-87f2-8f033e77c125" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1150/sprite_x.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[130]]></umbracoWidth><umbracoHeight><![CDATA[47]]></umbracoHeight><umbracoBytes><![CDATA[1097]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1226, N'<Image id="1226" key="2764d3c8-5998-410e-b971-6f36dcc23fce" parentID="1219" level="4" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:45" updateDate="2018-09-16T16:09:45" nodeName="sprite_y.png" urlName="sprite_ypng" path="-1,1053,1207,1219,1226" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="67d3242b-b502-4ea7-b3c8-bb53a0f580aa" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1151/sprite_y.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[61]]></umbracoWidth><umbracoHeight><![CDATA[130]]></umbracoHeight><umbracoBytes><![CDATA[1162]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1227, N'<Folder id="1227" key="47fdd2d8-be5d-45e8-9063-16d8c3ade9fd" parentID="1207" level="3" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:45" updateDate="2018-09-16T16:09:45" nodeName="facebook" urlName="facebook" path="-1,1053,1207,1227" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="666516ef-8157-4d55-b99d-244ec4635368" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1228, N'<Image id="1228" key="304f9cfa-afbc-4f7c-8435-2c64644cd572" parentID="1227" level="4" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:45" updateDate="2018-09-16T16:09:45" nodeName="btnNext.png" urlName="btnnextpng" path="-1,1053,1207,1227,1228" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="2025338c-e384-483b-9a16-510ca7467e61" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1152/btnnext.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[57]]></umbracoWidth><umbracoHeight><![CDATA[47]]></umbracoHeight><umbracoBytes><![CDATA[845]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1229, N'<Image id="1229" key="29aaa6a6-81d5-47f4-949d-9231c83435e7" parentID="1227" level="4" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:45" updateDate="2018-09-16T16:09:45" nodeName="btnPrevious.png" urlName="btnpreviouspng" path="-1,1053,1207,1227,1229" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="e5eaf8f9-7328-4012-8a72-da61f100f9bf" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1153/btnprevious.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[57]]></umbracoWidth><umbracoHeight><![CDATA[47]]></umbracoHeight><umbracoBytes><![CDATA[828]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1230, N'<Image id="1230" key="03f9abdd-7cd0-46b5-b2a8-eb01408947f2" parentID="1227" level="4" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:46" updateDate="2018-09-16T16:09:46" nodeName="contentPatternBottom.png" urlName="contentpatternbottompng" path="-1,1053,1207,1227,1230" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="f201c1f9-e7a6-4a76-a025-fd3678f8efd4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1154/contentpatternbottom.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[20]]></umbracoWidth><umbracoHeight><![CDATA[20]]></umbracoHeight><umbracoBytes><![CDATA[142]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1231, N'<Image id="1231" key="b6f137c5-307f-418f-99f1-678e4e555c09" parentID="1227" level="4" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:46" updateDate="2018-09-16T16:09:46" nodeName="contentPatternLeft.png" urlName="contentpatternleftpng" path="-1,1053,1207,1227,1231" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="5eb7447a-ccd3-42ad-be8c-bf6491ce61c0" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1155/contentpatternleft.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[20]]></umbracoWidth><umbracoHeight><![CDATA[20]]></umbracoHeight><umbracoBytes><![CDATA[137]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1232, N'<Image id="1232" key="423b332d-e142-481c-8d71-ccb4591fc8e1" parentID="1227" level="4" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:46" updateDate="2018-09-16T16:09:46" nodeName="contentPatternRight.png" urlName="contentpatternrightpng" path="-1,1053,1207,1227,1232" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="6d7e1dd8-7762-4673-a9f7-8461e2409719" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1156/contentpatternright.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[20]]></umbracoWidth><umbracoHeight><![CDATA[20]]></umbracoHeight><umbracoBytes><![CDATA[136]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1233, N'<Image id="1233" key="b5690127-40ff-4076-a30c-964875c80794" parentID="1227" level="4" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:46" updateDate="2018-09-16T16:09:46" nodeName="contentPatternTop.png" urlName="contentpatterntoppng" path="-1,1053,1207,1227,1233" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="66013f3e-f449-4c16-b4a4-d60db7c2c45d" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1157/contentpatterntop.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[20]]></umbracoWidth><umbracoHeight><![CDATA[20]]></umbracoHeight><umbracoBytes><![CDATA[142]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1234, N'<Image id="1234" key="1dd9dd4e-91c1-498e-a780-67908933106a" parentID="1227" level="4" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:46" updateDate="2018-09-16T16:09:46" nodeName="default_thumbnail.gif" urlName="default_thumbnailgif" path="-1,1053,1207,1227,1234" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="2c3ed6f2-f266-42cf-9815-a0b396c94079" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1158/default_thumbnail.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[50]]></umbracoWidth><umbracoHeight><![CDATA[33]]></umbracoHeight><umbracoBytes><![CDATA[227]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1235, N'<Image id="1235" key="62446f41-63ac-403b-bd28-8b957fe6baab" parentID="1227" level="4" creatorID="0" sortOrder="7" createDate="2018-09-16T16:09:46" updateDate="2018-09-16T16:09:46" nodeName="loader.gif" urlName="loadergif" path="-1,1053,1207,1227,1235" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="321a0e4e-43c7-4fbf-96b6-5efd2e365554" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1159/loader.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[24]]></umbracoWidth><umbracoHeight><![CDATA[24]]></umbracoHeight><umbracoBytes><![CDATA[2545]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1236, N'<Image id="1236" key="78c9cb4b-7b59-48a7-beec-1b03417566ab" parentID="1227" level="4" creatorID="0" sortOrder="8" createDate="2018-09-16T16:09:47" updateDate="2018-09-16T16:09:47" nodeName="sprite.png" urlName="spritepng" path="-1,1053,1207,1227,1236" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="cf3f0b58-f2f6-479e-9b79-dade4259a42b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1160/sprite.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[130]]></umbracoWidth><umbracoHeight><![CDATA[147]]></umbracoHeight><umbracoBytes><![CDATA[4227]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1237, N'<Folder id="1237" key="1c617e69-055c-4510-a2f4-ff67a305cf43" parentID="1207" level="3" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:47" updateDate="2018-09-16T16:09:47" nodeName="light_rounded" urlName="light_rounded" path="-1,1053,1207,1237" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="6f6fca52-0c52-43f1-9cf1-fa453b1af1d0" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1238, N'<Image id="1238" key="d8509b5a-9c0c-4279-a8dc-ee6108f5120c" parentID="1237" level="4" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:47" updateDate="2018-09-16T16:09:47" nodeName="btnNext.png" urlName="btnnextpng" path="-1,1053,1207,1237,1238" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="16edb69d-e364-4cf7-9924-bae390cbe080" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1161/btnnext.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[61]]></umbracoWidth><umbracoHeight><![CDATA[22]]></umbracoHeight><umbracoBytes><![CDATA[1411]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1239, N'<Image id="1239" key="895a8375-87d3-46c7-b2c3-8c9a198bb9a1" parentID="1237" level="4" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:47" updateDate="2018-09-16T16:09:47" nodeName="btnPrevious.png" urlName="btnpreviouspng" path="-1,1053,1207,1237,1239" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="583a5f3f-c79b-4327-ba53-caa8a0f06d32" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1162/btnprevious.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[61]]></umbracoWidth><umbracoHeight><![CDATA[22]]></umbracoHeight><umbracoBytes><![CDATA[1442]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1240, N'<Image id="1240" key="3f44b913-6eec-4042-b490-70b610a3188b" parentID="1237" level="4" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:47" updateDate="2018-09-16T16:09:47" nodeName="loader.gif" urlName="loadergif" path="-1,1053,1207,1237,1240" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="fe8a4f7d-aac3-4e2b-b7ca-239e1847ffd6" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1163/loader.gif", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[24]]></umbracoWidth><umbracoHeight><![CDATA[24]]></umbracoHeight><umbracoBytes><![CDATA[2545]]></umbracoBytes><umbracoExtension><![CDATA[gif]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1241, N'<Image id="1241" key="892f673d-910b-4bea-838c-7b6f36c3476e" parentID="1237" level="4" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:47" updateDate="2018-09-16T16:09:47" nodeName="sprite.png" urlName="spritepng" path="-1,1053,1207,1237,1241" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="5bfefc5a-8abf-4879-bb81-fcf03de339da" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1164/sprite.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[130]]></umbracoWidth><umbracoHeight><![CDATA[119]]></umbracoHeight><umbracoBytes><![CDATA[4099]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1242, N'<Folder id="1242" key="bee20b7f-a310-46fa-9762-205cdccaf344" parentID="1207" level="3" creatorID="0" sortOrder="5" createDate="2018-09-16T16:09:47" updateDate="2018-09-16T16:09:47" nodeName="light_square" urlName="light_square" path="-1,1053,1207,1242" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="7f13ab0c-0047-4b5f-b9ab-5085e0d969ad" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1243, N'<Image id="1243" key="ea5dcff5-7c31-46a4-8a77-3b99f35eb34b" parentID="1242" level="4" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:47" updateDate="2018-09-16T16:09:47" nodeName="btnNext.png" urlName="btnnextpng" path="-1,1053,1207,1242,1243" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="773182d2-44f0-465c-9bb6-9c88786b828b" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1165/btnnext.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[61]]></umbracoWidth><umbracoHeight><![CDATA[22]]></umbracoHeight><umbracoBytes><![CDATA[1411]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1244, N'<Image id="1244" key="159a798d-64fd-4a9b-bea5-ae81771652d3" parentID="1242" level="4" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:48" updateDate="2018-09-16T16:09:48" nodeName="btnPrevious.png" urlName="btnpreviouspng" path="-1,1053,1207,1242,1244" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="17b3c4ec-474f-41dc-b4ef-862c77d52a89" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1166/btnprevious.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[61]]></umbracoWidth><umbracoHeight><![CDATA[22]]></umbracoHeight><umbracoBytes><![CDATA[1442]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1245, N'<Image id="1245" key="647d17ef-513b-435b-9462-0558d9927bf7" parentID="1242" level="4" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:48" updateDate="2018-09-16T16:09:48" nodeName="sprite.png" urlName="spritepng" path="-1,1053,1207,1242,1245" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="7eef4147-a029-4450-8a67-d0e661f39a61" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1167/sprite.png", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[76]]></umbracoWidth><umbracoHeight><![CDATA[119]]></umbracoHeight><umbracoBytes><![CDATA[3507]]></umbracoBytes><umbracoExtension><![CDATA[png]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1246, N'<Folder id="1246" key="d464d68f-be23-4063-91f3-f671248dc479" parentID="1056" level="3" creatorID="0" sortOrder="30" createDate="2018-09-16T16:09:48" updateDate="2018-09-16T16:09:48" nodeName="project-single" urlName="project-single" path="-1,1053,1056,1246" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="b3b040e3-a086-44f1-b2f6-bfe9808182db" template="0" nodeTypeAlias="Folder" />')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1247, N'<Image id="1247" key="02e318f8-84b7-44fb-8d41-d479217172c0" parentID="1246" level="4" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:48" updateDate="2018-09-16T16:09:48" nodeName="1.jpg" urlName="1jpg" path="-1,1053,1056,1246,1247" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="40e020d3-3aa4-4e3d-a8de-a7afdb1393b4" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1168/1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1170]]></umbracoWidth><umbracoHeight><![CDATA[500]]></umbracoHeight><umbracoBytes><![CDATA[367491]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1248, N'<Image id="1248" key="4f9977b8-34eb-4bf7-80e7-d15c7e5728ef" parentID="1246" level="4" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:49" updateDate="2018-09-16T16:09:49" nodeName="graph-1.jpg" urlName="graph-1jpg" path="-1,1053,1056,1246,1248" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="a719e6ae-e808-465b-b732-0aed15157f36" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1169/graph-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1170]]></umbracoWidth><umbracoHeight><![CDATA[525]]></umbracoHeight><umbracoBytes><![CDATA[132697]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1249, N'<Image id="1249" key="54f14b94-08d0-43db-98ec-f49cf5c4c269" parentID="1246" level="4" creatorID="0" sortOrder="2" createDate="2018-09-16T16:09:49" updateDate="2018-09-16T16:09:49" nodeName="graph-2.jpg" urlName="graph-2jpg" path="-1,1053,1056,1246,1249" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="ba4ad85d-5a04-4e61-ac23-6924e85b1c4e" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1170/graph-2.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1170]]></umbracoWidth><umbracoHeight><![CDATA[505]]></umbracoHeight><umbracoBytes><![CDATA[75203]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1250, N'<Image id="1250" key="e960822d-eb7a-437e-a7f2-dc687b79661f" parentID="1246" level="4" creatorID="0" sortOrder="3" createDate="2018-09-16T16:09:50" updateDate="2018-09-16T16:09:50" nodeName="project-analysis-bg.jpg" urlName="project-analysis-bgjpg" path="-1,1053,1056,1246,1250" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="cdbae0ec-d24a-433e-8118-7b8e34d0e83f" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1171/project-analysis-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[430]]></umbracoHeight><umbracoBytes><![CDATA[285293]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1251, N'<Image id="1251" key="7c317e38-e3e9-4d4f-b916-3d039ecafbe8" parentID="1246" level="4" creatorID="0" sortOrder="4" createDate="2018-09-16T16:09:50" updateDate="2018-09-16T16:09:50" nodeName="project-result-bg.jpg" urlName="project-result-bgjpg" path="-1,1053,1056,1246,1251" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="1ca89ca0-4ea1-4fee-bd03-a38cb3532347" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1172/project-result-bg.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[1920]]></umbracoWidth><umbracoHeight><![CDATA[405]]></umbracoHeight><umbracoBytes><![CDATA[221279]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1252, N'<Folder id="1252" key="81b873d8-60f0-4395-ae53-8a2fc33722d9" parentID="1099" level="3" creatorID="0" sortOrder="6" createDate="2018-09-16T16:09:51" updateDate="2018-09-16T16:09:51" nodeName="service-single" urlName="service-single" path="-1,1053,1099,1252" isDoc="" nodeType="1031" writerName="Ravi Patel" writerID="0" version="98e02253-e25f-4f5d-8353-a8494a516cd5" template="0" nodeTypeAlias="Folder" />')
GO
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1253, N'<Image id="1253" key="7581c6b8-eb69-4fd0-a931-b93f3e6c26ad" parentID="1252" level="4" creatorID="0" sortOrder="0" createDate="2018-09-16T16:09:51" updateDate="2018-09-16T16:09:51" nodeName="1.jpg" urlName="1jpg" path="-1,1053,1099,1252,1253" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="fdc52cbb-ecbe-4405-bfaa-ed3f65a9ad0e" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1173/1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[370]]></umbracoWidth><umbracoHeight><![CDATA[488]]></umbracoHeight><umbracoBytes><![CDATA[111251]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1254, N'<Image id="1254" key="2dfbe2ae-cd5e-418e-a84e-809615c310f8" parentID="1252" level="4" creatorID="0" sortOrder="1" createDate="2018-09-16T16:09:51" updateDate="2018-09-16T16:09:51" nodeName="graph-1.jpg" urlName="graph-1jpg" path="-1,1053,1099,1252,1254" isDoc="" nodeType="1032" writerName="Ravi Patel" writerID="0" version="74baec66-46d6-4f8d-a4a0-8c7c0d5ca58a" template="0" nodeTypeAlias="Image"><umbracoFile><![CDATA[{"src": "/media/1174/graph-1.jpg", "crops": []}]]></umbracoFile><umbracoWidth><![CDATA[371]]></umbracoWidth><umbracoHeight><![CDATA[362]]></umbracoHeight><umbracoBytes><![CDATA[61312]]></umbracoBytes><umbracoExtension><![CDATA[jpg]]></umbracoExtension></Image>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1271, N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-20T02:02:17" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="true"><aboutUsText><![CDATA[We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.]]></aboutUsText><featuredServices><![CDATA[umb://document/8f6629d8a58644f8a05e56e96a401f6b]]></featuredServices><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides><aboutUsHeader><![CDATA[About Our Company ]]></aboutUsHeader><featuredTestimonial><![CDATA[umb://document/247d941baded4737ad8aa99150b3556b]]></featuredTestimonial><aboutUsTitle><![CDATA[Since 2000, we provide best service for our valuable clients.]]></aboutUsTitle></home>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1278, N'<slide id="1278" key="12a24e4a-c515-4aef-923b-82e996cfedf2" parentID="1271" level="2" creatorID="0" sortOrder="0" createDate="2018-09-17T04:20:01" updateDate="2018-09-20T00:43:31" nodeName="Slide1" urlName="slide1" path="-1,1271,1278" isDoc="" nodeType="1277" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="slide" isPublished="true"><slideTitle><![CDATA[Ventures]]></slideTitle><slideText><![CDATA[Over 24 years experience and knowledge international standards,technologicaly changes and industrial systems.]]></slideText><slideImage><![CDATA[umb://media/627ddaafc3fb4073b7b5fb5e3cedc990]]></slideImage><slideHeader><![CDATA[Warm welcome to]]></slideHeader></slide>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1279, N'<slide id="1279" key="2eb3c6d7-8b16-45ce-a44b-30a3154514ab" parentID="1271" level="2" creatorID="0" sortOrder="1" createDate="2018-09-17T04:29:50" updateDate="2018-09-20T00:43:31" nodeName="Slide2" urlName="slide2" path="-1,1271,1279" isDoc="" nodeType="1277" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="slide" isPublished="true"><slideTitle><![CDATA[Success]]></slideTitle><slideText><![CDATA[Over 24 years experience knowledge international standards technologicaly changes and industrial systems.]]></slideText><slideImage><![CDATA[umb://media/a127a0aaa19f47e896483a0bfc93e5d5]]></slideImage><slideHeader><![CDATA[The fastest way to achive]]></slideHeader></slide>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1280, N'<slide id="1280" key="3eb698d7-6f8f-47ac-a04e-0e74aee564ee" parentID="1271" level="2" creatorID="0" sortOrder="2" createDate="2018-09-17T04:31:13" updateDate="2018-09-20T00:43:31" nodeName="Slide3" urlName="slide3" path="-1,1271,1280" isDoc="" nodeType="1277" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="slide" isPublished="true"><slideTitle><![CDATA[Investors]]></slideTitle><slideText><![CDATA[Over 24 years experience and knowledge international standards technologicaly changes and industrial systems.]]></slideText><slideImage><![CDATA[umb://media/2109fcf6c83d4f309f3a7f9ee2d23437]]></slideImage><slideHeader><![CDATA[Trading solution for ]]></slideHeader></slide>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1295, N'<testimonial id="1295" key="247d941b-aded-4737-ad8a-a99150b3556b" parentID="1271" level="2" creatorID="0" sortOrder="4" createDate="2018-09-20T00:35:57" updateDate="2018-09-20T00:43:31" nodeName="Testimonial1" urlName="testimonial1" path="-1,1271,1295" isDoc="" nodeType="1288" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="testimonial" isPublished="true"><customerName><![CDATA[Alen]]></customerName><customerCity><![CDATA[Newyork]]></customerCity><customerImage><![CDATA[umb://media/7db98dc3da554526bb2255d6e4b586c3]]></customerImage><testimonialText><![CDATA[These guys are just the coolest company ever! They were aware of our transported for road and tail and complex.performance on our project was extremely successful the great explorer of the truth, the master-builder  happiness avoids pleasure itself]]></testimonialText></testimonial>')
INSERT [dbo].[cmsContentXml] ([nodeId], [xml]) VALUES (1300, N'<homeService id="1300" key="8f6629d8-a586-44f8-a05e-56e96a401f6b" parentID="1271" level="2" creatorID="0" sortOrder="5" createDate="2018-09-20T00:51:10" updateDate="2018-09-20T00:59:01" nodeName="Service1" urlName="service1" path="-1,1271,1300" isDoc="" nodeType="1299" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="homeService" isPublished="true"><serviceText><![CDATA[How this mistaken  denouncing pleasure and praising pain was born & we will give complete account of system.]]></serviceText><serviceTitle><![CDATA[Trading solution for ]]></serviceTitle><serviceImage><![CDATA[umb://media/bf1f68aedd054a41ae461cc586b6f234]]></serviceImage></homeService>')
SET IDENTITY_INSERT [dbo].[cmsDataType] ON 

INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-28, -97, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-27, -96, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (-26, -95, N'Umbraco.ListView', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (1, -49, N'Umbraco.TrueFalse', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (2, -51, N'Umbraco.Integer', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (3, -87, N'Umbraco.TinyMCEv3', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (4, -88, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (5, -89, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (6, -90, N'Umbraco.UploadField', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (7, -92, N'Umbraco.NoEdit', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (8, -36, N'Umbraco.DateTime', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (9, -37, N'Umbraco.ColorPickerAlias', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (11, -39, N'Umbraco.DropDownMultiple', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (12, -40, N'Umbraco.RadioButtonList', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (13, -41, N'Umbraco.Date', N'Date')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (14, -42, N'Umbraco.DropDown', N'Integer')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (15, -43, N'Umbraco.CheckBoxList', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (22, 1041, N'Umbraco.Tags', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (24, 1043, N'Umbraco.ImageCropper', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (26, 1046, N'Umbraco.ContentPicker2', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (27, 1047, N'Umbraco.MemberPicker2', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (28, 1048, N'Umbraco.MediaPicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (29, 1049, N'Umbraco.MediaPicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (30, 1050, N'Umbraco.RelatedLinks2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (31, 1258, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (32, 1259, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (33, 1260, N'Umbraco.TextboxMultiple', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (34, 1261, N'Umbraco.MediaPicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (35, 1263, N'Umbraco.MultiNodeTreePicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (36, 1265, N'Umbraco.MultiNodeTreePicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (37, 1268, N'Umbraco.MultiNodeTreePicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (38, 1274, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (39, 1275, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (40, 1281, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (41, 1282, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (42, 1285, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (43, 1286, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (44, 1287, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (45, 1289, N'Umbraco.MultiNodeTreePicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (46, 1290, N'Umbraco.MultiNodeTreePicker2', N'Ntext')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (47, 1292, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (48, 1293, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (49, 1294, N'Umbraco.Textbox', N'Nvarchar')
INSERT [dbo].[cmsDataType] ([pk], [nodeId], [propertyEditorAlias], [dbType]) VALUES (50, 1298, N'Umbraco.Textbox', N'Nvarchar')
SET IDENTITY_INSERT [dbo].[cmsDataType] OFF
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] ON 

INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-9, -96, N'[{"alias":"updateDate","header":"Last edited","isSystem":1},{"alias":"owner","header":"Updated by","isSystem":1}]', 5, N'includeProperties')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-8, -96, N'[{"name": "Grid","path": "views/propertyeditors/listview/layouts/grid/grid.html", "icon": "icon-thumbnails-small", "isSystem": 1, "selected": true},{"name": "List","path": "views/propertyeditors/listview/layouts/list/list.html","icon": "icon-list", "isSystem": 1,"selected": true}]', 4, N'layouts')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-7, -96, N'desc', 3, N'orderDirection')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-6, -96, N'updateDate', 2, N'orderBy')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-5, -96, N'100', 1, N'pageSize')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-4, -97, N'[{"alias":"username","isSystem":1},{"alias":"email","isSystem":1},{"alias":"updateDate","header":"Last edited","isSystem":1}]', 4, N'includeProperties')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-3, -97, N'asc', 3, N'orderDirection')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-2, -97, N'username', 2, N'orderBy')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (-1, -97, N'10', 1, N'pageSize')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (3, -87, N',code,undo,redo,cut,copy,mcepasteword,stylepicker,bold,italic,bullist,numlist,outdent,indent,mcelink,unlink,mceinsertanchor,mceimage,umbracomacro,mceinserttable,umbracoembed,mcecharmap,|1|1,2,3,|0|500,400|1049,|true|', 0, N'')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (4, 1041, N'default', 0, N'group')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (5, 1041, N'Json', 0, N'storageType')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (6, 1049, N'1', 0, N'multiPicker')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (7, 1258, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (8, 1259, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (9, 1260, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (10, 1261, N'0', 1, N'multiPicker')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (11, 1261, N'1', 2, N'onlyImages')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (12, 1261, N'0', 3, N'disableFolderSelect')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (13, 1261, N'', 4, N'startNodeId')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (14, 1263, N'{
  "type": "content",
  "id": "umb://document/7a41ab331da04d9584e0a53729e0af8f"
}', 1, N'startNode')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (15, 1263, NULL, 2, N'filter')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (16, 1263, NULL, 3, N'minNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (17, 1263, NULL, 4, N'maxNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (18, 1263, N'0', 5, N'showOpenButton')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (19, 1265, N'{
  "type": "content",
  "id": "umb://document/7a41ab331da04d9584e0a53729e0af8f"
}', 1, N'startNode')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (20, 1265, NULL, 2, N'filter')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (21, 1265, N'1', 3, N'minNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (22, 1265, NULL, 4, N'maxNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (23, 1265, N'0', 5, N'showOpenButton')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (24, 1268, N'{
  "type": "content"
}', 1, N'startNode')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (25, 1268, NULL, 2, N'filter')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (26, 1268, NULL, 3, N'minNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (27, 1268, NULL, 4, N'maxNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (28, 1268, N'0', 5, N'showOpenButton')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (29, 1274, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (30, 1275, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (31, 1048, N'0', 1, N'multiPicker')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (32, 1048, N'1', 2, N'onlyImages')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (33, 1048, N'0', 3, N'disableFolderSelect')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (34, 1048, N'', 4, N'startNodeId')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (35, 1281, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (36, 1282, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (37, 1285, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (38, 1286, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (39, 1287, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (40, 1289, N'{
  "type": "content"
}', 1, N'startNode')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (41, 1289, NULL, 2, N'filter')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (42, 1289, NULL, 3, N'minNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (43, 1289, NULL, 4, N'maxNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (44, 1289, N'0', 5, N'showOpenButton')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (45, 1290, N'{
  "type": "content"
}', 1, N'startNode')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (46, 1290, NULL, 2, N'filter')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (47, 1290, NULL, 3, N'minNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (48, 1290, NULL, 4, N'maxNumber')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (49, 1290, N'0', 5, N'showOpenButton')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (50, 1292, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (51, 1293, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (52, 1294, NULL, 1, N'maxChars')
INSERT [dbo].[cmsDataTypePreValues] ([id], [datatypeNodeId], [value], [sortorder], [alias]) VALUES (53, 1298, NULL, 1, N'maxChars')
SET IDENTITY_INSERT [dbo].[cmsDataTypePreValues] OFF
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'7c889c25-7b4f-41db-84d5-145faad2635d', N'Home', NULL, NULL, CAST(N'2018-09-17 04:33:01.840' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'79f36816-db96-44ad-8f06-1fe083c701e8', N'Home', NULL, NULL, CAST(N'2018-09-20 01:04:55.437' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1279, 1, 0, N'1f92fe87-e42d-46ad-b2c9-20e2ea9436c9', N'Slide2', NULL, NULL, CAST(N'2018-09-20 00:43:31.247' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'b92d1242-32c3-4410-af21-37db3cee9ee1', N'Home', NULL, NULL, CAST(N'2018-09-20 00:45:22.907' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1278, 1, 0, N'46d73cc2-5e59-4135-b127-415f8fa16076', N'Slide1', NULL, NULL, CAST(N'2018-09-20 00:43:31.113' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'677d5c85-c018-45a1-a5f7-5b611146c2b5', N'Home', NULL, NULL, CAST(N'2018-09-20 00:46:38.400' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 1, 0, N'090c7559-9ff6-4516-945d-5ecf2b95a224', N'Home', NULL, NULL, CAST(N'2018-09-20 02:02:17.470' AS DateTime), 1269, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'ca9323aa-3a94-4682-946a-75a4a7ffc9de', N'Home', NULL, NULL, CAST(N'2018-09-17 04:37:33.223' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1278, 0, 0, N'7806311c-efef-4f70-a028-76bda3c433e6', N'Slide1', NULL, NULL, CAST(N'2018-09-17 04:20:01.007' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1295, 1, 0, N'68ae0f8b-8e47-46f6-b8b3-8ed6317030a6', N'Testimonial1', NULL, NULL, CAST(N'2018-09-20 00:43:31.900' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'6f5a93a0-2d90-4565-8126-8fe03f3866f6', N'Home', NULL, NULL, CAST(N'2018-09-17 04:13:02.140' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1300, 0, 0, N'ba99b285-e7e6-45c7-a746-9b0c7d940644', N'Service1', NULL, NULL, CAST(N'2018-09-20 00:51:10.107' AS DateTime), NULL, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'dd95cc3d-db46-447c-9f17-9c3c0b374ace', N'Home', NULL, NULL, CAST(N'2018-09-20 00:30:05.010' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'f55fe206-571f-47a1-97bf-c79a42eac73c', N'Home', NULL, NULL, CAST(N'2018-09-20 00:51:16.900' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'e4693af8-f666-4d73-8512-cb89bd07f6b1', N'Home', NULL, NULL, CAST(N'2018-09-20 00:59:24.073' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1280, 1, 0, N'1099e84a-f0a5-4f20-a1db-df95f4060b26', N'Slide3', NULL, NULL, CAST(N'2018-09-20 00:43:31.483' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1300, 1, 0, N'52898928-7f44-4b26-b16a-f03155e14393', N'Service1', NULL, NULL, CAST(N'2018-09-20 00:59:01.763' AS DateTime), NULL, 1)
INSERT [dbo].[cmsDocument] ([nodeId], [published], [documentUser], [versionId], [text], [releaseDate], [expireDate], [updateDate], [templateId], [newest]) VALUES (1271, 0, 0, N'93033755-bb77-49d1-94e5-fe6ab56ba6bf', N'Home', NULL, NULL, CAST(N'2018-09-20 00:48:09.103' AS DateTime), 1269, 0)
INSERT [dbo].[cmsDocumentType] ([contentTypeNodeId], [templateNodeId], [IsDefault]) VALUES (1270, 1269, 1)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1053, N'26594e32-d38d-4f07-bd8c-7df26546123f', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1054, N'd60baa69-5f48-481a-bdf9-a72f1746f673', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1055, N'ac154484-84b3-460b-aea2-906cf11bd839', N'/media/1001/project-bg-pattern.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1056, N'6c9487ac-d778-4de7-a283-2ec6886662e9', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1057, N'92d55cc6-c718-410b-82d4-0b4af1c3f4e4', N'/media/1002/lat-project-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1058, N'c5632580-c8d0-438f-a338-22edfdc6b978', N'/media/1003/lat-project-10.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1059, N'054d97c2-989d-41de-af54-0d846ede6580', N'/media/1004/lat-project-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1060, N'3cb6b94f-7635-47ec-992d-e21ecdaee282', N'/media/1005/lat-project-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1061, N'2176049f-1054-440a-a47b-db81b81ba643', N'/media/1006/lat-project-4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1062, N'c9a46361-24e6-4fef-be13-08455eca96c2', N'/media/1007/lat-project-5.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1063, N'110e107f-fe79-40e4-8cb7-240f006d3949', N'/media/1008/lat-project-6.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1064, N'bf2b6b88-ada8-4c88-ba04-54b12862082d', N'/media/1009/lat-project-7.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1065, N'19340365-d912-47f8-9035-ce0065d8daf7', N'/media/1010/lat-project-8.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1066, N'a9517379-d1e3-43b5-bb88-598ad1e08238', N'/media/1011/lat-project-9.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1067, N'c9cf1d27-30f6-473f-8c4d-77e4f1b67230', N'/media/1012/v1-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1068, N'c822de32-782d-491e-a25b-2ca10e741a00', N'/media/1013/v1-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1069, N'9195b7be-8277-4be5-a4eb-aaa89967fc83', N'/media/1014/v1-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1070, N'a22386fc-09d1-4fc8-9ed6-e760cc5c80bf', N'/media/1015/v1-4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1071, N'82cf3193-e395-47aa-9fd5-8416babb5807', N'/media/1016/v1-5.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1072, N'2c4cd807-7982-4751-a704-25c7868a07dc', N'/media/1017/v1-6.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1073, N'81b12032-50b6-452c-adb5-561cf13b67e4', N'/media/1018/v1-7.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1074, N'81d0900c-c32f-4d68-aad6-20a9dd6315d0', N'/media/1019/v1-8.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1075, N'5395e7ad-5c38-433c-899b-ec9dcc60b832', N'/media/1020/v1-9.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1076, N'0e4cb31c-64a0-4e8b-8ed9-f92676dac8af', N'/media/1021/v2-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1077, N'c211e5f4-b789-4a76-8475-aeb2c827d821', N'/media/1022/v2-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1078, N'23f94c5f-0129-4752-a217-cc5d3ec51962', N'/media/1023/v2-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1079, N'205a8625-3d18-4419-a95f-bb9327b07e96', N'/media/1024/v2-4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1080, N'6c5de08e-89d3-4994-86f4-685cad9e48da', N'/media/1025/v2-5.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1081, N'8e858f5b-3d5c-44cb-9d35-351396e335a6', N'/media/1026/v2-6.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1082, N'b50f2825-43aa-476a-878d-8c0d7478a358', N'/media/1027/v3-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1083, N'ce0ef4aa-4b33-45b0-bec7-51d21bc7eabc', N'/media/1028/v3-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1084, N'e4cd815e-ef9f-48ec-8c5d-40138a81fe73', N'/media/1029/v3-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1085, N'82ebddd9-ffba-4965-9209-46c39211800d', N'/media/1030/v3-4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1086, N'99322637-8024-4050-a272-84258f6fa0a1', N'/media/1031/v3-5.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1087, N'd8edac73-8c7f-4f78-94e5-39a904b0ccbd', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1088, N'b562578f-d187-4e31-b50b-c03f249c51de', N'/media/1032/appoinment-image.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1089, N'159a2119-afdd-440f-8ff1-ae913a69369c', N'/media/1033/breadcrumb-bg-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1090, N'f5522789-69c9-4dfd-9b98-9a7b26aa2025', N'/media/1034/breadcrumb-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1091, N'acdcec44-17a1-487f-8e19-34f131a4cf85', N'/media/1035/contact-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1092, N'506951d3-28d5-4564-aab4-7cf682305278', N'/media/1036/industry-covered-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1093, N'3cd3576c-d622-4fa4-80e9-6635219e7423', N'/media/1037/industry-covered-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1094, N'57e83026-9ed2-4510-ad6f-f70362728c64', N'/media/1038/industry-covered-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1095, N'1915c75d-0e3b-4c31-a747-2abee5f6efdc', N'/media/1039/industry-covered-4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1096, N'7852ef0e-8536-4dd0-9b99-9d9f3d83aa3c', N'/media/1040/logo.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1097, N'9adb313e-8acc-4bea-a820-7f8cd2c02a9e', N'/media/1041/map-marker.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1098, N'90fc6434-ad02-4dc0-bc18-810dbc124176', N'/media/1042/our-logo.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1099, N'e38ceedf-323a-404d-a866-dcfc66795cd1', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1100, N'cddc6332-9dff-44c6-ba5e-788de6b474ba', N'/media/1043/1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1101, N'eb7a2faa-1815-4755-9f11-f7dc0e6c8188', N'/media/1044/2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1102, N'55886177-f090-4418-a4e9-1b0b119696d0', N'/media/1045/3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1103, N'd2460cdc-d8ec-47f3-867a-790a4f169fbe', N'/media/1046/4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1104, N'5db0a1dd-9564-4efa-b20e-d2b2b1b20ab9', N'/media/1047/5.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1105, N'a3057356-c10e-4ba3-83c4-5e1462804437', N'/media/1048/6.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1106, N'3c20340d-7c25-4003-8d96-49f21a4f392b', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1107, N'f8a4fc47-e322-4a36-942d-e3cec553a3ee', N'/media/1049/1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1108, N'd5be2efb-30ee-4ac6-9f34-22317d5032ab', N'/media/1050/2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1109, N'8085aa49-3f5e-4f29-a401-cad4cfa42cba', N'/media/1051/3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1110, N'52fe26f2-8b48-4862-a4f4-925df3649a28', N'/media/1052/4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1111, N'fa47547b-ae5c-4d6e-9749-653b5fd8b36f', N'/media/1053/5.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1112, N'c1a7446c-6cc6-4e5e-b2e7-ecb0adce2179', N'/media/1054/6.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1113, N'0a4547dc-be60-4add-9383-e04b4a04d8ba', N'/media/1055/7.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1114, N'623895ec-42bd-47a6-b275-df22936e66b3', N'/media/1056/8.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1115, N'319214b9-e742-4074-bb01-4c66f641e5da', N'/media/1057/9.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1116, N'6f2f35b5-5e95-45a0-a955-cce6fe262921', N'/media/1058/product-thumb-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1117, N'44ca142f-9b54-4e48-81d8-4c91388d8fea', N'/media/1059/product-thumb-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1118, N'42d0a23a-19a2-43eb-950e-4b2b5a8d0095', N'/media/1060/product-thumb-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1119, N'fe95964b-bf31-4e56-b6c9-2217f502f135', N'/media/1061/review-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1120, N'b8016f88-47ee-4504-b144-c200cc115aca', N'/media/1062/review-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1121, N'856204ec-bb55-4619-bb61-6cfd35660b1e', N'/media/1063/single-product.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1122, N'9c28e941-5887-4de2-9859-0e4cfa7407ab', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1123, N'a6ea4c08-0e72-4178-8d35-f9007f729f64', N'/media/1064/comment-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1124, N'893e2c0d-f18c-43b1-b2b8-625afd8c230e', N'/media/1065/comment-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1125, N'f2f36cd0-3697-4baa-88e5-962667acfa7b', N'/media/1066/popular-post-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1126, N'a153cb18-347a-4b85-b351-ac0d60a00690', N'/media/1067/popular-post-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1127, N'96eabbe0-dc5f-48b1-a507-e181530238f4', N'/media/1068/popular-post-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1128, N'dbf60c29-53de-40de-b88d-f9e4bb8e22ee', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1129, N'57e65cee-3c86-43dc-90ae-36f34d611c3b', N'/media/1069/1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1130, N'ca851d91-b23d-4336-a864-08049b374146', N'/media/1070/2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1131, N'74c77fcb-df27-485a-b476-4990cf3fba45', N'/media/1071/3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1132, N'f49bb6d1-91dc-4d05-bfd3-b24fbd4c2435', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1133, N'43499b8c-f456-410a-8b7e-64ab037c0d8d', N'/media/1072/1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1134, N'f185dc89-e737-4857-8f5b-073047337f02', N'/media/1073/2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1135, N'bec81464-1d0a-4cae-825c-91903f3c8d46', N'/media/1074/3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1136, N'2b787eed-2509-463a-950d-fdaee2d2a9bc', N'/media/1075/4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1137, N'da789e58-8be2-4eda-9587-62d7e188918b', N'/media/1076/5.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1138, N'1d6ae236-d943-4cd3-9600-9cf979100f35', N'/media/1077/6.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1139, N'61c2e5ea-38f2-41ee-9b0d-42c8169fafe6', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1140, N'8541f239-3909-45a3-92f3-7f525b54ad50', N'/media/1078/1.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1141, N'00f22160-51b5-4097-8c92-65c747ec6b8b', N'/media/1079/2.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1142, N'bc4cc61d-95ae-4748-b190-c08308b74bec', N'/media/1080/3.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1143, N'2026df61-6ca9-438d-98dd-de87123dde2d', N'/media/1081/4.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1144, N'95539d76-49a4-4c62-8e5e-4b3841f31491', N'/media/1082/5.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1145, N'8cf2a3fd-094e-43a0-8a98-c48bbd9afc31', N'/media/1083/6.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1146, N'7e6ccc0f-d6b8-4b05-b3ed-9691c21bb658', N'/media/1084/7.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1147, N'116f2fb8-0b18-4ce6-a1ad-f5de584a6687', N'/media/1085/8.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1148, N'7d08f76e-1ca2-419a-a21b-2ff6676bcba6', N'/media/1086/sidebar-testi-1.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1149, N'ec122e97-ac76-498d-89fc-5eeeada961c4', N'/media/1087/sidebar-testi-2.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1150, N'a35befe0-af0f-4475-9ed7-10a0f832f905', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1151, N'426c66ac-7fd4-42df-91ba-53c5f195afbe', N'/media/1088/mission.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1152, N'c63da573-dc88-4985-b848-74923efc48da', N'/media/1089/vision.jpg')
GO
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1153, N'be1185a4-dab2-4909-9fa1-d3d5e18ba588', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1154, N'324102d5-ac20-4c8c-bcc4-4dba55697ef1', N'/media/1090/author.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1155, N'ab871d36-44b2-427d-ae8f-6e4709c86530', N'/media/1091/blog-single.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1156, N'750ccfbe-728e-4c18-b48a-a8f11ed7a05f', N'/media/1092/caption-img.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1157, N'd4f9630c-1aea-4d0b-b08e-54abae55a72d', N'/media/1093/comment-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1158, N'0d8b6a0a-e4c8-47e4-89cf-38875bdb0a8a', N'/media/1094/comment-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1159, N'08d0d28a-629f-4c25-b798-320ee136f09d', N'/media/1095/lat-blog-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1160, N'bcaab792-070c-4e47-b2bd-72efef6a3738', N'/media/1096/lat-blog-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1161, N'62ebe452-e2e1-4ff2-9c2a-be1cbc2c54db', N'/media/1097/v1-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1162, N'e318522a-da70-42c9-9bef-e7b7f9929a39', N'/media/1098/v1-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1163, N'd905ede1-105b-4e5a-9698-b595b381954a', N'/media/1099/v1-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1164, N'0896544c-c8cc-4d96-8eb9-0d17066190e5', N'/media/1100/v1-4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1165, N'c0c38d10-aaf5-464d-8ac9-9470f5656135', N'/media/1101/v2-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1166, N'a0bb59ab-f760-4ccf-bbac-effdf0d81a38', N'/media/1102/v2-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1167, N'857a6063-af42-4ac8-97ce-dc1ddf2f100b', N'/media/1103/v2-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1168, N'1335e95a-4f0e-4541-ad9d-da3935268c15', N'/media/1104/v2-4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1169, N'4a4ff14c-15a8-45f1-986a-445bb8658e4e', N'/media/1105/v2-5.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1170, N'96ed0972-4b36-4529-86fc-9a14082d68f9', N'/media/1106/v2-6.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1171, N'821996ff-b0a0-48b3-a59d-508d90a26a3f', N'/media/1107/v3-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1172, N'434dc18e-a1be-4678-a015-7d3406098c63', N'/media/1108/v3-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1173, N'568ece08-48b1-4bb1-aded-151687a3fcd4', N'/media/1109/v3-3.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1174, N'ac1fc696-49da-4205-bd1d-5d45df3d6720', N'/media/1110/v3-4.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1175, N'8ca657ef-7d56-44a8-b780-b4a0b969b140', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1176, N'83210281-b8ed-427a-acb4-9ecb66c70a74', N'/media/1111/1.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1177, N'632c10fa-b22a-46d0-a381-1c3367f1a59e', N'/media/1112/2.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1178, N'0f121470-d8a7-4fdf-ae52-b616136d17da', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1179, N'593227ac-3da9-4631-984f-15accf413fef', N'/media/1113/blank.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1180, N'fa647386-2cd1-4bcc-a0a5-4b86dc04eef1', N'/media/1114/fancybox_loading.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1181, N'cc64cf40-b629-4ad5-acc1-ff6daa2ce602', N'/media/1115/fancybox_loading-2x.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1182, N'facfdb4b-1ab4-4a83-a3a9-3a4b5577ee42', N'/media/1116/fancybox_overlay.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1183, N'16b3c4f8-5d29-4b35-b9bc-f941d0eda5d5', N'/media/1117/fancybox_sprite.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1184, N'b8f654a7-a26f-4c86-acfa-fa38c0a5328d', N'/media/1118/fancybox_sprite-2x.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1185, N'27d8ac6b-8ae3-4725-8688-87a2a4558994', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1186, N'da64f9c8-392e-4404-863a-a7d0433282e6', N'/media/1119/apple-touch-icon.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1187, N'ecf48e1d-0c6b-49ea-b69c-d305691024ab', N'/media/1120/favicon-16x16.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1188, N'73275192-06d1-45b2-90c6-957ba8dd29bc', N'/media/1121/favicon-32x32.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1189, N'f8fe6413-0327-4d49-9f23-07d07bdb41c4', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1190, N'0dd39825-dc68-458e-8343-ced375287853', N'/media/1122/footer-logo.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1191, N'47300941-2d6f-4291-aa7c-ae7f280cf3e0', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1192, N'588e6dff-9660-4be7-b647-5a0bfa11a80b', N'/media/1123/1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1193, N'f3b60a16-ad74-49b7-a4a7-1e72bfb69c58', N'/media/1124/2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1194, N'322ea4bf-0f8d-437d-b983-9b983bacffbc', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1195, N'4f841bc5-c1ce-4a66-9fb0-128adc068167', N'/media/1125/bx_loader.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1196, N'c2745744-269e-4425-9dee-e30128c66ffe', N'/media/1126/preloader.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1197, N'7005b81d-d45b-43e3-b04c-f3216ef2054f', N'/media/1127/submenu-icon.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1198, N'89a5508c-1226-4811-b44e-3b4df277073b', N'/media/1128/tick.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1199, N'241a2413-3dee-4765-ae15-741b2dfed4f0', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1200, N'9cb1db9f-99eb-4272-bc5e-e5019041b4e4', N'/media/1129/choose-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1201, N'dcf33e69-6223-4dff-9d12-6a09b0f0eb79', N'/media/1130/consultation-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1202, N'f1093abd-81f5-440b-b480-07c0a837ac49', N'/media/1131/contact-details-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1203, N'5fc9dbc7-b441-4f03-ab0b-e2cad2884d9c', N'/media/1132/covered-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1204, N'c9d9802e-3142-410c-8f64-3f28db001e37', N'/media/1133/service-about-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1205, N'084b97da-e6ee-400f-9b47-2053d1a47898', N'/media/1134/slogan-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1206, N'b3d5126f-4c19-4208-ae62-7323919212ff', N'/media/1135/testimonial-section-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1207, N'5a723c0f-decc-4af4-a475-1b207801eed5', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1208, N'e3e8b00c-9f10-4dd1-8cf8-7d95b73b5fcf', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1209, N'a56eff46-b4d2-4959-93ba-de3f016d4072', N'/media/1136/btnnext.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1210, N'20dc4b96-2fe5-4a37-b3dd-b07b85a4b758', N'/media/1137/btnprevious.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1211, N'eb754c7b-db90-438c-b74f-bcc775a2e6da', N'/media/1138/contentpattern.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1212, N'0353db66-d1e0-4230-9bff-23d4bbc100ef', N'/media/1139/loader.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1213, N'858e46ee-3316-4e44-897e-4e8a1038903f', N'/media/1140/sprite.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1214, N'a5ca47af-d1b0-4db2-b2f0-51f35d392a8c', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1215, N'e6c1c8ea-5501-44f0-a19a-5bf0ea7f84b6', N'/media/1141/btnnext.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1216, N'dcb1b2df-a077-481c-ac3f-e7d4abb183ec', N'/media/1142/btnprevious.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1217, N'764ed384-84fa-4482-9e95-fc47198e25a2', N'/media/1143/loader.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1218, N'de3c142b-490b-43c5-977a-49edc1d1acc4', N'/media/1144/sprite.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1219, N'9a0dd485-aa7c-48e7-831b-2caf46a9c153', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1220, N'b73f209d-e0b6-4293-8594-597b906ffc04', N'/media/1145/default_thumb.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1221, N'843f07e5-c86e-4d0c-881d-fcb34fe3acca', N'/media/1146/loader.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1222, N'8ce3d0c1-bc3d-4baf-9e52-faa78951e44c', N'/media/1147/sprite.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1223, N'8aca3e8e-7655-45d1-9598-a715dd29f2a4', N'/media/1148/sprite_next.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1224, N'5d790c2e-ccb2-4105-a036-cdeda14e893b', N'/media/1149/sprite_prev.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1225, N'7cf8d5ca-3df5-42ed-87f2-8f033e77c125', N'/media/1150/sprite_x.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1226, N'67d3242b-b502-4ea7-b3c8-bb53a0f580aa', N'/media/1151/sprite_y.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1227, N'666516ef-8157-4d55-b99d-244ec4635368', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1228, N'2025338c-e384-483b-9a16-510ca7467e61', N'/media/1152/btnnext.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1229, N'e5eaf8f9-7328-4012-8a72-da61f100f9bf', N'/media/1153/btnprevious.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1230, N'f201c1f9-e7a6-4a76-a025-fd3678f8efd4', N'/media/1154/contentpatternbottom.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1231, N'5eb7447a-ccd3-42ad-be8c-bf6491ce61c0', N'/media/1155/contentpatternleft.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1232, N'6d7e1dd8-7762-4673-a9f7-8461e2409719', N'/media/1156/contentpatternright.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1233, N'66013f3e-f449-4c16-b4a4-d60db7c2c45d', N'/media/1157/contentpatterntop.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1234, N'2c3ed6f2-f266-42cf-9815-a0b396c94079', N'/media/1158/default_thumbnail.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1235, N'321a0e4e-43c7-4fbf-96b6-5efd2e365554', N'/media/1159/loader.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1236, N'cf3f0b58-f2f6-479e-9b79-dade4259a42b', N'/media/1160/sprite.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1237, N'6f6fca52-0c52-43f1-9cf1-fa453b1af1d0', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1238, N'16edb69d-e364-4cf7-9924-bae390cbe080', N'/media/1161/btnnext.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1239, N'583a5f3f-c79b-4327-ba53-caa8a0f06d32', N'/media/1162/btnprevious.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1240, N'fe8a4f7d-aac3-4e2b-b7ca-239e1847ffd6', N'/media/1163/loader.gif')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1241, N'5bfefc5a-8abf-4879-bb81-fcf03de339da', N'/media/1164/sprite.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1242, N'7f13ab0c-0047-4b5f-b9ab-5085e0d969ad', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1243, N'773182d2-44f0-465c-9bb6-9c88786b828b', N'/media/1165/btnnext.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1244, N'17b3c4ec-474f-41dc-b4ef-862c77d52a89', N'/media/1166/btnprevious.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1245, N'7eef4147-a029-4450-8a67-d0e661f39a61', N'/media/1167/sprite.png')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1246, N'b3b040e3-a086-44f1-b2f6-bfe9808182db', NULL)
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1247, N'40e020d3-3aa4-4e3d-a8de-a7afdb1393b4', N'/media/1168/1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1248, N'a719e6ae-e808-465b-b732-0aed15157f36', N'/media/1169/graph-1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1249, N'ba4ad85d-5a04-4e61-ac23-6924e85b1c4e', N'/media/1170/graph-2.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1250, N'cdbae0ec-d24a-433e-8118-7b8e34d0e83f', N'/media/1171/project-analysis-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1251, N'1ca89ca0-4ea1-4fee-bd03-a38cb3532347', N'/media/1172/project-result-bg.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1252, N'98e02253-e25f-4f5d-8353-a8494a516cd5', NULL)
GO
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1253, N'fdc52cbb-ecbe-4405-bfaa-ed3f65a9ad0e', N'/media/1173/1.jpg')
INSERT [dbo].[cmsMedia] ([nodeId], [versionId], [mediaPath]) VALUES (1254, N'74baec66-46d6-4f8d-a4a0-8c7c0d5ca58a', N'/media/1174/graph-1.jpg')
SET IDENTITY_INSERT [dbo].[cmsMemberType] ON 

INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile], [isSensitive]) VALUES (1, 1044, 35, 0, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile], [isSensitive]) VALUES (2, 1044, 36, 0, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile], [isSensitive]) VALUES (3, 1044, 28, 0, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile], [isSensitive]) VALUES (4, 1044, 29, 0, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile], [isSensitive]) VALUES (5, 1044, 30, 0, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile], [isSensitive]) VALUES (6, 1044, 31, 0, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile], [isSensitive]) VALUES (7, 1044, 32, 0, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile], [isSensitive]) VALUES (8, 1044, 33, 0, 0, 0)
INSERT [dbo].[cmsMemberType] ([pk], [NodeId], [propertytypeId], [memberCanEdit], [viewOnProfile], [isSensitive]) VALUES (9, 1044, 34, 0, 0, 0)
SET IDENTITY_INSERT [dbo].[cmsMemberType] OFF
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'7c889c25-7b4f-41db-84d5-145faad2635d', CAST(N'2018-09-17 04:33:01.850' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-17T04:33:01" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="true"><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2]]></featuredSlides></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'79f36816-db96-44ad-8f06-1fe083c701e8', CAST(N'2018-09-20 01:04:57.000' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-20T01:04:55" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false"><aboutUsText><![CDATA[We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain ravi.]]></aboutUsText><featuredServices><![CDATA[umb://document/8f6629d8a58644f8a05e56e96a401f6b]]></featuredServices><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides><aboutUsHeader><![CDATA[About Our Company Ravi]]></aboutUsHeader><featuredTestimonial><![CDATA[umb://document/247d941baded4737ad8aa99150b3556b]]></featuredTestimonial><aboutUsTitle><![CDATA[Since 2000, we provide best service for our valuable clients Ravi.]]></aboutUsTitle></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'b92d1242-32c3-4410-af21-37db3cee9ee1', CAST(N'2018-09-20 00:45:24.567' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-20T00:45:22" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false"><aboutUsText><![CDATA[We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.]]></aboutUsText><featuredServices><![CDATA[umb://document/e53b83973a0d4d339bd3a3feb18e9515]]></featuredServices><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides><aboutUsHeader><![CDATA[About Our Company]]></aboutUsHeader><featuredTestimonial><![CDATA[umb://document/247d941baded4737ad8aa99150b3556b]]></featuredTestimonial><aboutUsTitle><![CDATA[Since 2000, we provide best service for our valuable clients.]]></aboutUsTitle></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'677d5c85-c018-45a1-a5f7-5b611146c2b5', CAST(N'2018-09-20 00:46:38.420' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-20T00:46:38" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false"><aboutUsText><![CDATA[We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.]]></aboutUsText><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides><aboutUsHeader><![CDATA[About Our Company]]></aboutUsHeader><featuredTestimonial><![CDATA[umb://document/247d941baded4737ad8aa99150b3556b]]></featuredTestimonial><aboutUsTitle><![CDATA[Since 2000, we provide best service for our valuable clients.]]></aboutUsTitle></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'090c7559-9ff6-4516-945d-5ecf2b95a224', CAST(N'2018-09-20 02:02:19.330' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-20T02:02:17" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false"><aboutUsText><![CDATA[We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.]]></aboutUsText><featuredServices><![CDATA[umb://document/8f6629d8a58644f8a05e56e96a401f6b]]></featuredServices><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides><aboutUsHeader><![CDATA[About Our Company ]]></aboutUsHeader><featuredTestimonial><![CDATA[umb://document/247d941baded4737ad8aa99150b3556b]]></featuredTestimonial><aboutUsTitle><![CDATA[Since 2000, we provide best service for our valuable clients.]]></aboutUsTitle></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'ca9323aa-3a94-4682-946a-75a4a7ffc9de', CAST(N'2018-09-17 04:37:35.250' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-17T04:37:33" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false"><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'6f5a93a0-2d90-4565-8126-8fe03f3866f6', CAST(N'2018-09-17 04:17:29.987' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-17T04:13:02" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false" />')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'dd95cc3d-db46-447c-9f17-9c3c0b374ace', CAST(N'2018-09-20 00:30:05.113' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-20T00:30:05" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false"><featuredServices><![CDATA[umb://document/e53b83973a0d4d339bd3a3feb18e9515]]></featuredServices><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'f55fe206-571f-47a1-97bf-c79a42eac73c', CAST(N'2018-09-20 00:51:16.957' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-20T00:51:16" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false"><aboutUsText><![CDATA[We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.]]></aboutUsText><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides><aboutUsHeader><![CDATA[About Our Company]]></aboutUsHeader><featuredTestimonial><![CDATA[umb://document/247d941baded4737ad8aa99150b3556b]]></featuredTestimonial><aboutUsTitle><![CDATA[Since 2000, we provide best service for our valuable clients.]]></aboutUsTitle></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'e4693af8-f666-4d73-8512-cb89bd07f6b1', CAST(N'2018-09-20 00:59:25.400' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-20T00:59:24" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false"><aboutUsText><![CDATA[We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.]]></aboutUsText><featuredServices><![CDATA[umb://document/8f6629d8a58644f8a05e56e96a401f6b]]></featuredServices><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides><aboutUsHeader><![CDATA[About Our Company]]></aboutUsHeader><featuredTestimonial><![CDATA[umb://document/247d941baded4737ad8aa99150b3556b]]></featuredTestimonial><aboutUsTitle><![CDATA[Since 2000, we provide best service for our valuable clients.]]></aboutUsTitle></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1271, N'93033755-bb77-49d1-94e5-fe6ab56ba6bf', CAST(N'2018-09-20 00:48:10.477' AS DateTime), N'<home id="1271" key="bc25b578-8c00-46a6-bf8e-f5ce6b885888" parentID="-1" level="1" creatorID="0" sortOrder="0" createDate="2018-09-17T03:32:49" updateDate="2018-09-20T00:48:09" nodeName="Home" urlName="home" path="-1,1271" isDoc="" nodeType="1270" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="1269" nodeTypeAlias="home" isPublished="false"><aboutUsText><![CDATA[We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.]]></aboutUsText><featuredServices><![CDATA[umb://document/074bfaeec907470ab0a11f600484c12d]]></featuredServices><featuredSlides><![CDATA[umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee]]></featuredSlides><aboutUsHeader><![CDATA[About Our Company]]></aboutUsHeader><featuredTestimonial><![CDATA[umb://document/247d941baded4737ad8aa99150b3556b]]></featuredTestimonial><aboutUsTitle><![CDATA[Since 2000, we provide best service for our valuable clients.]]></aboutUsTitle></home>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1278, N'46d73cc2-5e59-4135-b127-415f8fa16076', CAST(N'2018-09-20 00:43:31.140' AS DateTime), N'<slide id="1278" key="12a24e4a-c515-4aef-923b-82e996cfedf2" parentID="1271" level="2" creatorID="0" sortOrder="0" createDate="2018-09-17T04:20:01" updateDate="2018-09-20T00:43:31" nodeName="Slide1" urlName="slide1" path="-1,1271,1278" isDoc="" nodeType="1277" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="slide" isPublished="true"><slideTitle><![CDATA[Ventures]]></slideTitle><slideText><![CDATA[Over 24 years experience and knowledge international standards,technologicaly changes and industrial systems.]]></slideText><slideImage><![CDATA[umb://media/627ddaafc3fb4073b7b5fb5e3cedc990]]></slideImage><slideHeader><![CDATA[Warm welcome to]]></slideHeader></slide>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1278, N'7806311c-efef-4f70-a028-76bda3c433e6', CAST(N'2018-09-17 04:20:01.050' AS DateTime), N'<slide id="1278" key="12a24e4a-c515-4aef-923b-82e996cfedf2" parentID="1271" level="2" creatorID="0" sortOrder="0" createDate="2018-09-17T04:20:01" updateDate="2018-09-17T04:20:01" nodeName="Slide1" urlName="slide1" path="-1,1271,1278" isDoc="" nodeType="1277" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="slide" isPublished="true"><slideTitle><![CDATA[Ventures]]></slideTitle><slideText><![CDATA[Over 24 years experience and knowledge international standards,<br> technologicaly changes and industrial systems.]]></slideText><slideImage><![CDATA[umb://media/627ddaafc3fb4073b7b5fb5e3cedc990]]></slideImage><slideHeader><![CDATA[Warm welcome to]]></slideHeader></slide>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1279, N'1f92fe87-e42d-46ad-b2c9-20e2ea9436c9', CAST(N'2018-09-20 00:43:31.253' AS DateTime), N'<slide id="1279" key="2eb3c6d7-8b16-45ce-a44b-30a3154514ab" parentID="1271" level="2" creatorID="0" sortOrder="1" createDate="2018-09-17T04:29:50" updateDate="2018-09-20T00:43:31" nodeName="Slide2" urlName="slide2" path="-1,1271,1279" isDoc="" nodeType="1277" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="slide" isPublished="true"><slideTitle><![CDATA[Success]]></slideTitle><slideText><![CDATA[Over 24 years experience knowledge international standards technologicaly changes and industrial systems.]]></slideText><slideImage><![CDATA[umb://media/a127a0aaa19f47e896483a0bfc93e5d5]]></slideImage><slideHeader><![CDATA[The fastest way to achive]]></slideHeader></slide>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1280, N'1099e84a-f0a5-4f20-a1db-df95f4060b26', CAST(N'2018-09-20 00:43:31.510' AS DateTime), N'<slide id="1280" key="3eb698d7-6f8f-47ac-a04e-0e74aee564ee" parentID="1271" level="2" creatorID="0" sortOrder="2" createDate="2018-09-17T04:31:13" updateDate="2018-09-20T00:43:31" nodeName="Slide3" urlName="slide3" path="-1,1271,1280" isDoc="" nodeType="1277" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="slide" isPublished="true"><slideTitle><![CDATA[Investors]]></slideTitle><slideText><![CDATA[Over 24 years experience and knowledge international standards technologicaly changes and industrial systems.]]></slideText><slideImage><![CDATA[umb://media/2109fcf6c83d4f309f3a7f9ee2d23437]]></slideImage><slideHeader><![CDATA[Trading solution for ]]></slideHeader></slide>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1295, N'68ae0f8b-8e47-46f6-b8b3-8ed6317030a6', CAST(N'2018-09-20 02:00:30.117' AS DateTime), N'<testimonial id="1295" key="247d941b-aded-4737-ad8a-a99150b3556b" parentID="1271" level="2" creatorID="0" sortOrder="4" createDate="2018-09-20T00:35:57" updateDate="2018-09-20T00:43:31" nodeName="Testimonial1" urlName="testimonial1" path="-1,1271,1295" isDoc="" nodeType="1288" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="testimonial" isPublished="false"><customerName><![CDATA[Alen]]></customerName><customerCity><![CDATA[Newyork]]></customerCity><customerImage><![CDATA[umb://media/7db98dc3da554526bb2255d6e4b586c3]]></customerImage><testimonialText><![CDATA[These guys are just the coolest company ever! They were aware of our transported for road and tail and complex.performance on our project was extremely successful the great explorer of the truth, the master-builder  happiness avoids pleasure itself]]></testimonialText></testimonial>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1300, N'ba99b285-e7e6-45c7-a746-9b0c7d940644', CAST(N'2018-09-20 00:51:10.147' AS DateTime), N'<homeService id="1300" key="8f6629d8-a586-44f8-a05e-56e96a401f6b" parentID="1271" level="2" creatorID="0" sortOrder="5" createDate="2018-09-20T00:51:10" updateDate="2018-09-20T00:51:10" nodeName="Service1" urlName="service1" path="-1,1271,1300" isDoc="" nodeType="1299" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="homeService" isPublished="true"><serviceText><![CDATA[We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.]]></serviceText><serviceTitle><![CDATA[Trading solution for ]]></serviceTitle><serviceImage><![CDATA[umb://media/bf1f68aedd054a41ae461cc586b6f234]]></serviceImage></homeService>')
INSERT [dbo].[cmsPreviewXml] ([nodeId], [versionId], [timestamp], [xml]) VALUES (1300, N'52898928-7f44-4b26-b16a-f03155e14393', CAST(N'2018-09-20 00:59:01.893' AS DateTime), N'<homeService id="1300" key="8f6629d8-a586-44f8-a05e-56e96a401f6b" parentID="1271" level="2" creatorID="0" sortOrder="5" createDate="2018-09-20T00:51:10" updateDate="2018-09-20T00:59:01" nodeName="Service1" urlName="service1" path="-1,1271,1300" isDoc="" nodeType="1299" creatorName="Ravi Patel" writerName="Ravi Patel" writerID="0" template="0" nodeTypeAlias="homeService" isPublished="true"><serviceText><![CDATA[How this mistaken  denouncing pleasure and praising pain was born & we will give complete account of system.]]></serviceText><serviceTitle><![CDATA[Trading solution for ]]></serviceTitle><serviceImage><![CDATA[umb://media/bf1f68aedd054a41ae461cc586b6f234]]></serviceImage></homeService>')
SET IDENTITY_INSERT [dbo].[cmsPropertyData] ON 

INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1, 1053, N'26594e32-d38d-4f07-bd8c-7df26546123f', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (2, 1054, N'd60baa69-5f48-481a-bdf9-a72f1746f673', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (3, 1055, N'ac154484-84b3-460b-aea2-906cf11bd839', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1001/project-bg-pattern.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (4, 1055, N'ac154484-84b3-460b-aea2-906cf11bd839', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (5, 1055, N'ac154484-84b3-460b-aea2-906cf11bd839', 8, NULL, NULL, NULL, N'700', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (6, 1055, N'ac154484-84b3-460b-aea2-906cf11bd839', 9, NULL, NULL, NULL, N'218527', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (7, 1055, N'ac154484-84b3-460b-aea2-906cf11bd839', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (8, 1056, N'6c9487ac-d778-4de7-a283-2ec6886662e9', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (9, 1057, N'92d55cc6-c718-410b-82d4-0b4af1c3f4e4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1002/lat-project-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (10, 1057, N'92d55cc6-c718-410b-82d4-0b4af1c3f4e4', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (11, 1057, N'92d55cc6-c718-410b-82d4-0b4af1c3f4e4', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (12, 1057, N'92d55cc6-c718-410b-82d4-0b4af1c3f4e4', 9, NULL, NULL, NULL, N'119739', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (13, 1057, N'92d55cc6-c718-410b-82d4-0b4af1c3f4e4', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (14, 1058, N'c5632580-c8d0-438f-a338-22edfdc6b978', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1003/lat-project-10.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (15, 1058, N'c5632580-c8d0-438f-a338-22edfdc6b978', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (16, 1058, N'c5632580-c8d0-438f-a338-22edfdc6b978', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (17, 1058, N'c5632580-c8d0-438f-a338-22edfdc6b978', 9, NULL, NULL, NULL, N'130941', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (18, 1058, N'c5632580-c8d0-438f-a338-22edfdc6b978', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (19, 1059, N'054d97c2-989d-41de-af54-0d846ede6580', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1004/lat-project-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (20, 1059, N'054d97c2-989d-41de-af54-0d846ede6580', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (21, 1059, N'054d97c2-989d-41de-af54-0d846ede6580', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (22, 1059, N'054d97c2-989d-41de-af54-0d846ede6580', 9, NULL, NULL, NULL, N'93741', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (23, 1059, N'054d97c2-989d-41de-af54-0d846ede6580', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (24, 1060, N'3cb6b94f-7635-47ec-992d-e21ecdaee282', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1005/lat-project-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (25, 1060, N'3cb6b94f-7635-47ec-992d-e21ecdaee282', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (26, 1060, N'3cb6b94f-7635-47ec-992d-e21ecdaee282', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (27, 1060, N'3cb6b94f-7635-47ec-992d-e21ecdaee282', 9, NULL, NULL, NULL, N'131716', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (28, 1060, N'3cb6b94f-7635-47ec-992d-e21ecdaee282', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (29, 1061, N'2176049f-1054-440a-a47b-db81b81ba643', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1006/lat-project-4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (30, 1061, N'2176049f-1054-440a-a47b-db81b81ba643', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (31, 1061, N'2176049f-1054-440a-a47b-db81b81ba643', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (32, 1061, N'2176049f-1054-440a-a47b-db81b81ba643', 9, NULL, NULL, NULL, N'157359', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (33, 1061, N'2176049f-1054-440a-a47b-db81b81ba643', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (34, 1062, N'c9a46361-24e6-4fef-be13-08455eca96c2', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1007/lat-project-5.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (35, 1062, N'c9a46361-24e6-4fef-be13-08455eca96c2', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (36, 1062, N'c9a46361-24e6-4fef-be13-08455eca96c2', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (37, 1062, N'c9a46361-24e6-4fef-be13-08455eca96c2', 9, NULL, NULL, NULL, N'116119', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (38, 1062, N'c9a46361-24e6-4fef-be13-08455eca96c2', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (39, 1063, N'110e107f-fe79-40e4-8cb7-240f006d3949', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1008/lat-project-6.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (40, 1063, N'110e107f-fe79-40e4-8cb7-240f006d3949', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (41, 1063, N'110e107f-fe79-40e4-8cb7-240f006d3949', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (42, 1063, N'110e107f-fe79-40e4-8cb7-240f006d3949', 9, NULL, NULL, NULL, N'128896', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (43, 1063, N'110e107f-fe79-40e4-8cb7-240f006d3949', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (44, 1064, N'bf2b6b88-ada8-4c88-ba04-54b12862082d', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1009/lat-project-7.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (45, 1064, N'bf2b6b88-ada8-4c88-ba04-54b12862082d', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (46, 1064, N'bf2b6b88-ada8-4c88-ba04-54b12862082d', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (47, 1064, N'bf2b6b88-ada8-4c88-ba04-54b12862082d', 9, NULL, NULL, NULL, N'138313', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (48, 1064, N'bf2b6b88-ada8-4c88-ba04-54b12862082d', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (49, 1065, N'19340365-d912-47f8-9035-ce0065d8daf7', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1010/lat-project-8.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (50, 1065, N'19340365-d912-47f8-9035-ce0065d8daf7', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (51, 1065, N'19340365-d912-47f8-9035-ce0065d8daf7', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (52, 1065, N'19340365-d912-47f8-9035-ce0065d8daf7', 9, NULL, NULL, NULL, N'129088', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (53, 1065, N'19340365-d912-47f8-9035-ce0065d8daf7', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (54, 1066, N'a9517379-d1e3-43b5-bb88-598ad1e08238', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1011/lat-project-9.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (55, 1066, N'a9517379-d1e3-43b5-bb88-598ad1e08238', 7, NULL, NULL, NULL, N'384', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (56, 1066, N'a9517379-d1e3-43b5-bb88-598ad1e08238', 8, NULL, NULL, NULL, N'400', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (57, 1066, N'a9517379-d1e3-43b5-bb88-598ad1e08238', 9, NULL, NULL, NULL, N'117439', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (58, 1066, N'a9517379-d1e3-43b5-bb88-598ad1e08238', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (59, 1067, N'c9cf1d27-30f6-473f-8c4d-77e4f1b67230', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1012/v1-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (60, 1067, N'c9cf1d27-30f6-473f-8c4d-77e4f1b67230', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (61, 1067, N'c9cf1d27-30f6-473f-8c4d-77e4f1b67230', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (62, 1067, N'c9cf1d27-30f6-473f-8c4d-77e4f1b67230', 9, NULL, NULL, NULL, N'74444', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (63, 1067, N'c9cf1d27-30f6-473f-8c4d-77e4f1b67230', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (64, 1068, N'c822de32-782d-491e-a25b-2ca10e741a00', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1013/v1-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (65, 1068, N'c822de32-782d-491e-a25b-2ca10e741a00', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (66, 1068, N'c822de32-782d-491e-a25b-2ca10e741a00', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (67, 1068, N'c822de32-782d-491e-a25b-2ca10e741a00', 9, NULL, NULL, NULL, N'80558', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (68, 1068, N'c822de32-782d-491e-a25b-2ca10e741a00', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (69, 1069, N'9195b7be-8277-4be5-a4eb-aaa89967fc83', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1014/v1-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (70, 1069, N'9195b7be-8277-4be5-a4eb-aaa89967fc83', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (71, 1069, N'9195b7be-8277-4be5-a4eb-aaa89967fc83', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (72, 1069, N'9195b7be-8277-4be5-a4eb-aaa89967fc83', 9, NULL, NULL, NULL, N'62702', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (73, 1069, N'9195b7be-8277-4be5-a4eb-aaa89967fc83', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (74, 1070, N'a22386fc-09d1-4fc8-9ed6-e760cc5c80bf', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1015/v1-4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (75, 1070, N'a22386fc-09d1-4fc8-9ed6-e760cc5c80bf', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (76, 1070, N'a22386fc-09d1-4fc8-9ed6-e760cc5c80bf', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (77, 1070, N'a22386fc-09d1-4fc8-9ed6-e760cc5c80bf', 9, NULL, NULL, NULL, N'71572', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (78, 1070, N'a22386fc-09d1-4fc8-9ed6-e760cc5c80bf', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (79, 1071, N'82cf3193-e395-47aa-9fd5-8416babb5807', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1016/v1-5.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (80, 1071, N'82cf3193-e395-47aa-9fd5-8416babb5807', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (81, 1071, N'82cf3193-e395-47aa-9fd5-8416babb5807', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (82, 1071, N'82cf3193-e395-47aa-9fd5-8416babb5807', 9, NULL, NULL, NULL, N'74443', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (83, 1071, N'82cf3193-e395-47aa-9fd5-8416babb5807', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (84, 1072, N'2c4cd807-7982-4751-a704-25c7868a07dc', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1017/v1-6.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (85, 1072, N'2c4cd807-7982-4751-a704-25c7868a07dc', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (86, 1072, N'2c4cd807-7982-4751-a704-25c7868a07dc', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (87, 1072, N'2c4cd807-7982-4751-a704-25c7868a07dc', 9, NULL, NULL, NULL, N'86570', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (88, 1072, N'2c4cd807-7982-4751-a704-25c7868a07dc', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (89, 1073, N'81b12032-50b6-452c-adb5-561cf13b67e4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1018/v1-7.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (90, 1073, N'81b12032-50b6-452c-adb5-561cf13b67e4', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (91, 1073, N'81b12032-50b6-452c-adb5-561cf13b67e4', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (92, 1073, N'81b12032-50b6-452c-adb5-561cf13b67e4', 9, NULL, NULL, NULL, N'95239', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (93, 1073, N'81b12032-50b6-452c-adb5-561cf13b67e4', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (94, 1074, N'81d0900c-c32f-4d68-aad6-20a9dd6315d0', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1019/v1-8.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (95, 1074, N'81d0900c-c32f-4d68-aad6-20a9dd6315d0', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (96, 1074, N'81d0900c-c32f-4d68-aad6-20a9dd6315d0', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (97, 1074, N'81d0900c-c32f-4d68-aad6-20a9dd6315d0', 9, NULL, NULL, NULL, N'116370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (98, 1074, N'81d0900c-c32f-4d68-aad6-20a9dd6315d0', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (99, 1075, N'5395e7ad-5c38-433c-899b-ec9dcc60b832', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1020/v1-9.jpg", "crops": []}')
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (100, 1075, N'5395e7ad-5c38-433c-899b-ec9dcc60b832', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (101, 1075, N'5395e7ad-5c38-433c-899b-ec9dcc60b832', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (102, 1075, N'5395e7ad-5c38-433c-899b-ec9dcc60b832', 9, NULL, NULL, NULL, N'70033', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (103, 1075, N'5395e7ad-5c38-433c-899b-ec9dcc60b832', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (104, 1076, N'0e4cb31c-64a0-4e8b-8ed9-f92676dac8af', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1021/v2-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (105, 1076, N'0e4cb31c-64a0-4e8b-8ed9-f92676dac8af', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (106, 1076, N'0e4cb31c-64a0-4e8b-8ed9-f92676dac8af', 8, NULL, NULL, NULL, N'200', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (107, 1076, N'0e4cb31c-64a0-4e8b-8ed9-f92676dac8af', 9, NULL, NULL, NULL, N'67721', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (108, 1076, N'0e4cb31c-64a0-4e8b-8ed9-f92676dac8af', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (109, 1077, N'c211e5f4-b789-4a76-8475-aeb2c827d821', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1022/v2-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (110, 1077, N'c211e5f4-b789-4a76-8475-aeb2c827d821', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (111, 1077, N'c211e5f4-b789-4a76-8475-aeb2c827d821', 8, NULL, NULL, NULL, N'200', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (112, 1077, N'c211e5f4-b789-4a76-8475-aeb2c827d821', 9, NULL, NULL, NULL, N'74401', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (113, 1077, N'c211e5f4-b789-4a76-8475-aeb2c827d821', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (114, 1078, N'23f94c5f-0129-4752-a217-cc5d3ec51962', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1023/v2-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (115, 1078, N'23f94c5f-0129-4752-a217-cc5d3ec51962', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (116, 1078, N'23f94c5f-0129-4752-a217-cc5d3ec51962', 8, NULL, NULL, NULL, N'200', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (117, 1078, N'23f94c5f-0129-4752-a217-cc5d3ec51962', 9, NULL, NULL, NULL, N'57952', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (118, 1078, N'23f94c5f-0129-4752-a217-cc5d3ec51962', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (119, 1079, N'205a8625-3d18-4419-a95f-bb9327b07e96', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1024/v2-4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (120, 1079, N'205a8625-3d18-4419-a95f-bb9327b07e96', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (121, 1079, N'205a8625-3d18-4419-a95f-bb9327b07e96', 8, NULL, NULL, NULL, N'200', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (122, 1079, N'205a8625-3d18-4419-a95f-bb9327b07e96', 9, NULL, NULL, NULL, N'87146', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (123, 1079, N'205a8625-3d18-4419-a95f-bb9327b07e96', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (124, 1080, N'6c5de08e-89d3-4994-86f4-685cad9e48da', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1025/v2-5.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (125, 1080, N'6c5de08e-89d3-4994-86f4-685cad9e48da', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (126, 1080, N'6c5de08e-89d3-4994-86f4-685cad9e48da', 8, NULL, NULL, NULL, N'200', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (127, 1080, N'6c5de08e-89d3-4994-86f4-685cad9e48da', 9, NULL, NULL, NULL, N'105854', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (128, 1080, N'6c5de08e-89d3-4994-86f4-685cad9e48da', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (129, 1081, N'8e858f5b-3d5c-44cb-9d35-351396e335a6', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1026/v2-6.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (130, 1081, N'8e858f5b-3d5c-44cb-9d35-351396e335a6', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (131, 1081, N'8e858f5b-3d5c-44cb-9d35-351396e335a6', 8, NULL, NULL, NULL, N'200', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (132, 1081, N'8e858f5b-3d5c-44cb-9d35-351396e335a6', 9, NULL, NULL, NULL, N'64275', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (133, 1081, N'8e858f5b-3d5c-44cb-9d35-351396e335a6', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (134, 1082, N'b50f2825-43aa-476a-878d-8c0d7478a358', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1027/v3-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (135, 1082, N'b50f2825-43aa-476a-878d-8c0d7478a358', 7, NULL, NULL, NULL, N'670', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (136, 1082, N'b50f2825-43aa-476a-878d-8c0d7478a358', 8, NULL, NULL, NULL, N'500', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (137, 1082, N'b50f2825-43aa-476a-878d-8c0d7478a358', 9, NULL, NULL, NULL, N'312869', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (138, 1082, N'b50f2825-43aa-476a-878d-8c0d7478a358', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (139, 1083, N'ce0ef4aa-4b33-45b0-bec7-51d21bc7eabc', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1028/v3-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (140, 1083, N'ce0ef4aa-4b33-45b0-bec7-51d21bc7eabc', 7, NULL, NULL, NULL, N'670', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (141, 1083, N'ce0ef4aa-4b33-45b0-bec7-51d21bc7eabc', 8, NULL, NULL, NULL, N'500', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (142, 1083, N'ce0ef4aa-4b33-45b0-bec7-51d21bc7eabc', 9, NULL, NULL, NULL, N'255995', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (143, 1083, N'ce0ef4aa-4b33-45b0-bec7-51d21bc7eabc', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (144, 1084, N'e4cd815e-ef9f-48ec-8c5d-40138a81fe73', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1029/v3-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (145, 1084, N'e4cd815e-ef9f-48ec-8c5d-40138a81fe73', 7, NULL, NULL, NULL, N'670', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (146, 1084, N'e4cd815e-ef9f-48ec-8c5d-40138a81fe73', 8, NULL, NULL, NULL, N'500', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (147, 1084, N'e4cd815e-ef9f-48ec-8c5d-40138a81fe73', 9, NULL, NULL, NULL, N'196244', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (148, 1084, N'e4cd815e-ef9f-48ec-8c5d-40138a81fe73', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (149, 1085, N'82ebddd9-ffba-4965-9209-46c39211800d', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1030/v3-4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (150, 1085, N'82ebddd9-ffba-4965-9209-46c39211800d', 7, NULL, NULL, NULL, N'670', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (151, 1085, N'82ebddd9-ffba-4965-9209-46c39211800d', 8, NULL, NULL, NULL, N'500', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (152, 1085, N'82ebddd9-ffba-4965-9209-46c39211800d', 9, NULL, NULL, NULL, N'218857', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (153, 1085, N'82ebddd9-ffba-4965-9209-46c39211800d', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (154, 1086, N'99322637-8024-4050-a272-84258f6fa0a1', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1031/v3-5.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (155, 1086, N'99322637-8024-4050-a272-84258f6fa0a1', 7, NULL, NULL, NULL, N'670', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (156, 1086, N'99322637-8024-4050-a272-84258f6fa0a1', 8, NULL, NULL, NULL, N'500', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (157, 1086, N'99322637-8024-4050-a272-84258f6fa0a1', 9, NULL, NULL, NULL, N'172755', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (158, 1086, N'99322637-8024-4050-a272-84258f6fa0a1', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (159, 1087, N'd8edac73-8c7f-4f78-94e5-39a904b0ccbd', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (160, 1088, N'b562578f-d187-4e31-b50b-c03f249c51de', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1032/appoinment-image.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (161, 1088, N'b562578f-d187-4e31-b50b-c03f249c51de', 7, NULL, NULL, NULL, N'775', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (162, 1088, N'b562578f-d187-4e31-b50b-c03f249c51de', 8, NULL, NULL, NULL, N'510', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (163, 1088, N'b562578f-d187-4e31-b50b-c03f249c51de', 9, NULL, NULL, NULL, N'156621', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (164, 1088, N'b562578f-d187-4e31-b50b-c03f249c51de', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (165, 1089, N'159a2119-afdd-440f-8ff1-ae913a69369c', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1033/breadcrumb-bg-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (166, 1089, N'159a2119-afdd-440f-8ff1-ae913a69369c', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (167, 1089, N'159a2119-afdd-440f-8ff1-ae913a69369c', 8, NULL, NULL, NULL, N'320', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (168, 1089, N'159a2119-afdd-440f-8ff1-ae913a69369c', 9, NULL, NULL, NULL, N'315684', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (169, 1089, N'159a2119-afdd-440f-8ff1-ae913a69369c', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (170, 1090, N'f5522789-69c9-4dfd-9b98-9a7b26aa2025', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1034/breadcrumb-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (171, 1090, N'f5522789-69c9-4dfd-9b98-9a7b26aa2025', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (172, 1090, N'f5522789-69c9-4dfd-9b98-9a7b26aa2025', 8, NULL, NULL, NULL, N'320', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (173, 1090, N'f5522789-69c9-4dfd-9b98-9a7b26aa2025', 9, NULL, NULL, NULL, N'236483', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (174, 1090, N'f5522789-69c9-4dfd-9b98-9a7b26aa2025', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (175, 1091, N'acdcec44-17a1-487f-8e19-34f131a4cf85', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1035/contact-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (176, 1091, N'acdcec44-17a1-487f-8e19-34f131a4cf85', 7, NULL, NULL, NULL, N'585', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (177, 1091, N'acdcec44-17a1-487f-8e19-34f131a4cf85', 8, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (178, 1091, N'acdcec44-17a1-487f-8e19-34f131a4cf85', 9, NULL, NULL, NULL, N'113123', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (179, 1091, N'acdcec44-17a1-487f-8e19-34f131a4cf85', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (180, 1092, N'506951d3-28d5-4564-aab4-7cf682305278', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1036/industry-covered-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (181, 1092, N'506951d3-28d5-4564-aab4-7cf682305278', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (182, 1092, N'506951d3-28d5-4564-aab4-7cf682305278', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (183, 1092, N'506951d3-28d5-4564-aab4-7cf682305278', 9, NULL, NULL, NULL, N'66177', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (184, 1092, N'506951d3-28d5-4564-aab4-7cf682305278', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (185, 1093, N'3cd3576c-d622-4fa4-80e9-6635219e7423', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1037/industry-covered-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (186, 1093, N'3cd3576c-d622-4fa4-80e9-6635219e7423', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (187, 1093, N'3cd3576c-d622-4fa4-80e9-6635219e7423', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (188, 1093, N'3cd3576c-d622-4fa4-80e9-6635219e7423', 9, NULL, NULL, NULL, N'81027', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (189, 1093, N'3cd3576c-d622-4fa4-80e9-6635219e7423', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (190, 1094, N'57e83026-9ed2-4510-ad6f-f70362728c64', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1038/industry-covered-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (191, 1094, N'57e83026-9ed2-4510-ad6f-f70362728c64', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (192, 1094, N'57e83026-9ed2-4510-ad6f-f70362728c64', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (193, 1094, N'57e83026-9ed2-4510-ad6f-f70362728c64', 9, NULL, NULL, NULL, N'82879', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (194, 1094, N'57e83026-9ed2-4510-ad6f-f70362728c64', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (195, 1095, N'1915c75d-0e3b-4c31-a747-2abee5f6efdc', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1039/industry-covered-4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (196, 1095, N'1915c75d-0e3b-4c31-a747-2abee5f6efdc', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (197, 1095, N'1915c75d-0e3b-4c31-a747-2abee5f6efdc', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (198, 1095, N'1915c75d-0e3b-4c31-a747-2abee5f6efdc', 9, NULL, NULL, NULL, N'73065', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (199, 1095, N'1915c75d-0e3b-4c31-a747-2abee5f6efdc', 10, NULL, NULL, NULL, N'jpg', NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (200, 1096, N'7852ef0e-8536-4dd0-9b99-9d9f3d83aa3c', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1040/logo.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (201, 1096, N'7852ef0e-8536-4dd0-9b99-9d9f3d83aa3c', 7, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (202, 1096, N'7852ef0e-8536-4dd0-9b99-9d9f3d83aa3c', 8, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (203, 1096, N'7852ef0e-8536-4dd0-9b99-9d9f3d83aa3c', 9, NULL, NULL, NULL, N'7709', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (204, 1096, N'7852ef0e-8536-4dd0-9b99-9d9f3d83aa3c', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (205, 1097, N'9adb313e-8acc-4bea-a820-7f8cd2c02a9e', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1041/map-marker.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (206, 1097, N'9adb313e-8acc-4bea-a820-7f8cd2c02a9e', 7, NULL, NULL, NULL, N'70', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (207, 1097, N'9adb313e-8acc-4bea-a820-7f8cd2c02a9e', 8, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (208, 1097, N'9adb313e-8acc-4bea-a820-7f8cd2c02a9e', 9, NULL, NULL, NULL, N'3958', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (209, 1097, N'9adb313e-8acc-4bea-a820-7f8cd2c02a9e', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (210, 1098, N'90fc6434-ad02-4dc0-bc18-810dbc124176', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1042/our-logo.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (211, 1098, N'90fc6434-ad02-4dc0-bc18-810dbc124176', 7, NULL, NULL, NULL, N'65', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (212, 1098, N'90fc6434-ad02-4dc0-bc18-810dbc124176', 8, NULL, NULL, NULL, N'65', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (213, 1098, N'90fc6434-ad02-4dc0-bc18-810dbc124176', 9, NULL, NULL, NULL, N'4679', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (214, 1098, N'90fc6434-ad02-4dc0-bc18-810dbc124176', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (215, 1099, N'e38ceedf-323a-404d-a866-dcfc66795cd1', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (216, 1100, N'cddc6332-9dff-44c6-ba5e-788de6b474ba', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1043/1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (217, 1100, N'cddc6332-9dff-44c6-ba5e-788de6b474ba', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (218, 1100, N'cddc6332-9dff-44c6-ba5e-788de6b474ba', 8, NULL, NULL, NULL, N'250', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (219, 1100, N'cddc6332-9dff-44c6-ba5e-788de6b474ba', 9, NULL, NULL, NULL, N'67447', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (220, 1100, N'cddc6332-9dff-44c6-ba5e-788de6b474ba', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (221, 1101, N'eb7a2faa-1815-4755-9f11-f7dc0e6c8188', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1044/2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (222, 1101, N'eb7a2faa-1815-4755-9f11-f7dc0e6c8188', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (223, 1101, N'eb7a2faa-1815-4755-9f11-f7dc0e6c8188', 8, NULL, NULL, NULL, N'250', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (224, 1101, N'eb7a2faa-1815-4755-9f11-f7dc0e6c8188', 9, NULL, NULL, NULL, N'63714', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (225, 1101, N'eb7a2faa-1815-4755-9f11-f7dc0e6c8188', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (226, 1102, N'55886177-f090-4418-a4e9-1b0b119696d0', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1045/3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (227, 1102, N'55886177-f090-4418-a4e9-1b0b119696d0', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (228, 1102, N'55886177-f090-4418-a4e9-1b0b119696d0', 8, NULL, NULL, NULL, N'250', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (229, 1102, N'55886177-f090-4418-a4e9-1b0b119696d0', 9, NULL, NULL, NULL, N'70536', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (230, 1102, N'55886177-f090-4418-a4e9-1b0b119696d0', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (231, 1103, N'd2460cdc-d8ec-47f3-867a-790a4f169fbe', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1046/4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (232, 1103, N'd2460cdc-d8ec-47f3-867a-790a4f169fbe', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (233, 1103, N'd2460cdc-d8ec-47f3-867a-790a4f169fbe', 8, NULL, NULL, NULL, N'250', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (234, 1103, N'd2460cdc-d8ec-47f3-867a-790a4f169fbe', 9, NULL, NULL, NULL, N'76779', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (235, 1103, N'd2460cdc-d8ec-47f3-867a-790a4f169fbe', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (236, 1104, N'5db0a1dd-9564-4efa-b20e-d2b2b1b20ab9', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1047/5.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (237, 1104, N'5db0a1dd-9564-4efa-b20e-d2b2b1b20ab9', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (238, 1104, N'5db0a1dd-9564-4efa-b20e-d2b2b1b20ab9', 8, NULL, NULL, NULL, N'250', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (239, 1104, N'5db0a1dd-9564-4efa-b20e-d2b2b1b20ab9', 9, NULL, NULL, NULL, N'73995', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (240, 1104, N'5db0a1dd-9564-4efa-b20e-d2b2b1b20ab9', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (241, 1105, N'a3057356-c10e-4ba3-83c4-5e1462804437', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1048/6.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (242, 1105, N'a3057356-c10e-4ba3-83c4-5e1462804437', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (243, 1105, N'a3057356-c10e-4ba3-83c4-5e1462804437', 8, NULL, NULL, NULL, N'250', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (244, 1105, N'a3057356-c10e-4ba3-83c4-5e1462804437', 9, NULL, NULL, NULL, N'65282', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (245, 1105, N'a3057356-c10e-4ba3-83c4-5e1462804437', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (246, 1106, N'3c20340d-7c25-4003-8d96-49f21a4f392b', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (247, 1107, N'f8a4fc47-e322-4a36-942d-e3cec553a3ee', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1049/1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (248, 1107, N'f8a4fc47-e322-4a36-942d-e3cec553a3ee', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (249, 1107, N'f8a4fc47-e322-4a36-942d-e3cec553a3ee', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (250, 1107, N'f8a4fc47-e322-4a36-942d-e3cec553a3ee', 9, NULL, NULL, NULL, N'34731', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (251, 1107, N'f8a4fc47-e322-4a36-942d-e3cec553a3ee', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (252, 1108, N'd5be2efb-30ee-4ac6-9f34-22317d5032ab', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1050/2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (253, 1108, N'd5be2efb-30ee-4ac6-9f34-22317d5032ab', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (254, 1108, N'd5be2efb-30ee-4ac6-9f34-22317d5032ab', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (255, 1108, N'd5be2efb-30ee-4ac6-9f34-22317d5032ab', 9, NULL, NULL, NULL, N'28716', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (256, 1108, N'd5be2efb-30ee-4ac6-9f34-22317d5032ab', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (257, 1109, N'8085aa49-3f5e-4f29-a401-cad4cfa42cba', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1051/3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (258, 1109, N'8085aa49-3f5e-4f29-a401-cad4cfa42cba', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (259, 1109, N'8085aa49-3f5e-4f29-a401-cad4cfa42cba', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (260, 1109, N'8085aa49-3f5e-4f29-a401-cad4cfa42cba', 9, NULL, NULL, NULL, N'29740', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (261, 1109, N'8085aa49-3f5e-4f29-a401-cad4cfa42cba', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (262, 1110, N'52fe26f2-8b48-4862-a4f4-925df3649a28', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1052/4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (263, 1110, N'52fe26f2-8b48-4862-a4f4-925df3649a28', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (264, 1110, N'52fe26f2-8b48-4862-a4f4-925df3649a28', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (265, 1110, N'52fe26f2-8b48-4862-a4f4-925df3649a28', 9, NULL, NULL, NULL, N'29371', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (266, 1110, N'52fe26f2-8b48-4862-a4f4-925df3649a28', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (267, 1111, N'fa47547b-ae5c-4d6e-9749-653b5fd8b36f', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1053/5.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (268, 1111, N'fa47547b-ae5c-4d6e-9749-653b5fd8b36f', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (269, 1111, N'fa47547b-ae5c-4d6e-9749-653b5fd8b36f', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (270, 1111, N'fa47547b-ae5c-4d6e-9749-653b5fd8b36f', 9, NULL, NULL, NULL, N'28019', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (271, 1111, N'fa47547b-ae5c-4d6e-9749-653b5fd8b36f', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (272, 1112, N'c1a7446c-6cc6-4e5e-b2e7-ecb0adce2179', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1054/6.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (273, 1112, N'c1a7446c-6cc6-4e5e-b2e7-ecb0adce2179', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (274, 1112, N'c1a7446c-6cc6-4e5e-b2e7-ecb0adce2179', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (275, 1112, N'c1a7446c-6cc6-4e5e-b2e7-ecb0adce2179', 9, NULL, NULL, NULL, N'23683', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (276, 1112, N'c1a7446c-6cc6-4e5e-b2e7-ecb0adce2179', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (277, 1113, N'0a4547dc-be60-4add-9383-e04b4a04d8ba', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1055/7.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (278, 1113, N'0a4547dc-be60-4add-9383-e04b4a04d8ba', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (279, 1113, N'0a4547dc-be60-4add-9383-e04b4a04d8ba', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (280, 1113, N'0a4547dc-be60-4add-9383-e04b4a04d8ba', 9, NULL, NULL, NULL, N'29740', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (281, 1113, N'0a4547dc-be60-4add-9383-e04b4a04d8ba', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (282, 1114, N'623895ec-42bd-47a6-b275-df22936e66b3', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1056/8.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (283, 1114, N'623895ec-42bd-47a6-b275-df22936e66b3', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (284, 1114, N'623895ec-42bd-47a6-b275-df22936e66b3', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (285, 1114, N'623895ec-42bd-47a6-b275-df22936e66b3', 9, NULL, NULL, NULL, N'24398', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (286, 1114, N'623895ec-42bd-47a6-b275-df22936e66b3', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (287, 1115, N'319214b9-e742-4074-bb01-4c66f641e5da', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1057/9.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (288, 1115, N'319214b9-e742-4074-bb01-4c66f641e5da', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (289, 1115, N'319214b9-e742-4074-bb01-4c66f641e5da', 8, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (290, 1115, N'319214b9-e742-4074-bb01-4c66f641e5da', 9, NULL, NULL, NULL, N'28716', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (291, 1115, N'319214b9-e742-4074-bb01-4c66f641e5da', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (292, 1116, N'6f2f35b5-5e95-45a0-a955-cce6fe262921', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1058/product-thumb-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (293, 1116, N'6f2f35b5-5e95-45a0-a955-cce6fe262921', 7, NULL, NULL, NULL, N'70', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (294, 1116, N'6f2f35b5-5e95-45a0-a955-cce6fe262921', 8, NULL, NULL, NULL, N'70', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (295, 1116, N'6f2f35b5-5e95-45a0-a955-cce6fe262921', 9, NULL, NULL, NULL, N'4615', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (296, 1116, N'6f2f35b5-5e95-45a0-a955-cce6fe262921', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (297, 1117, N'44ca142f-9b54-4e48-81d8-4c91388d8fea', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1059/product-thumb-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (298, 1117, N'44ca142f-9b54-4e48-81d8-4c91388d8fea', 7, NULL, NULL, NULL, N'70', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (299, 1117, N'44ca142f-9b54-4e48-81d8-4c91388d8fea', 8, NULL, NULL, NULL, N'70', NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (300, 1117, N'44ca142f-9b54-4e48-81d8-4c91388d8fea', 9, NULL, NULL, NULL, N'4788', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (301, 1117, N'44ca142f-9b54-4e48-81d8-4c91388d8fea', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (302, 1118, N'42d0a23a-19a2-43eb-950e-4b2b5a8d0095', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1060/product-thumb-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (303, 1118, N'42d0a23a-19a2-43eb-950e-4b2b5a8d0095', 7, NULL, NULL, NULL, N'70', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (304, 1118, N'42d0a23a-19a2-43eb-950e-4b2b5a8d0095', 8, NULL, NULL, NULL, N'70', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (305, 1118, N'42d0a23a-19a2-43eb-950e-4b2b5a8d0095', 9, NULL, NULL, NULL, N'4242', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (306, 1118, N'42d0a23a-19a2-43eb-950e-4b2b5a8d0095', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (307, 1119, N'fe95964b-bf31-4e56-b6c9-2217f502f135', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1061/review-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (308, 1119, N'fe95964b-bf31-4e56-b6c9-2217f502f135', 7, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (309, 1119, N'fe95964b-bf31-4e56-b6c9-2217f502f135', 8, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (310, 1119, N'fe95964b-bf31-4e56-b6c9-2217f502f135', 9, NULL, NULL, NULL, N'5433', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (311, 1119, N'fe95964b-bf31-4e56-b6c9-2217f502f135', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (312, 1120, N'b8016f88-47ee-4504-b144-c200cc115aca', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1062/review-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (313, 1120, N'b8016f88-47ee-4504-b144-c200cc115aca', 7, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (314, 1120, N'b8016f88-47ee-4504-b144-c200cc115aca', 8, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (315, 1120, N'b8016f88-47ee-4504-b144-c200cc115aca', 9, NULL, NULL, NULL, N'5547', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (316, 1120, N'b8016f88-47ee-4504-b144-c200cc115aca', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (317, 1121, N'856204ec-bb55-4619-bb61-6cfd35660b1e', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1063/single-product.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (318, 1121, N'856204ec-bb55-4619-bb61-6cfd35660b1e', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (319, 1121, N'856204ec-bb55-4619-bb61-6cfd35660b1e', 8, NULL, NULL, NULL, N'415', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (320, 1121, N'856204ec-bb55-4619-bb61-6cfd35660b1e', 9, NULL, NULL, NULL, N'47450', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (321, 1121, N'856204ec-bb55-4619-bb61-6cfd35660b1e', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (322, 1122, N'9c28e941-5887-4de2-9859-0e4cfa7407ab', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (323, 1123, N'a6ea4c08-0e72-4178-8d35-f9007f729f64', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1064/comment-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (324, 1123, N'a6ea4c08-0e72-4178-8d35-f9007f729f64', 7, NULL, NULL, NULL, N'50', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (325, 1123, N'a6ea4c08-0e72-4178-8d35-f9007f729f64', 8, NULL, NULL, NULL, N'50', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (326, 1123, N'a6ea4c08-0e72-4178-8d35-f9007f729f64', 9, NULL, NULL, NULL, N'4252', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (327, 1123, N'a6ea4c08-0e72-4178-8d35-f9007f729f64', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (328, 1124, N'893e2c0d-f18c-43b1-b2b8-625afd8c230e', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1065/comment-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (329, 1124, N'893e2c0d-f18c-43b1-b2b8-625afd8c230e', 7, NULL, NULL, NULL, N'50', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (330, 1124, N'893e2c0d-f18c-43b1-b2b8-625afd8c230e', 8, NULL, NULL, NULL, N'50', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (331, 1124, N'893e2c0d-f18c-43b1-b2b8-625afd8c230e', 9, NULL, NULL, NULL, N'4507', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (332, 1124, N'893e2c0d-f18c-43b1-b2b8-625afd8c230e', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (333, 1125, N'f2f36cd0-3697-4baa-88e5-962667acfa7b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1066/popular-post-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (334, 1125, N'f2f36cd0-3697-4baa-88e5-962667acfa7b', 7, NULL, NULL, NULL, N'90', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (335, 1125, N'f2f36cd0-3697-4baa-88e5-962667acfa7b', 8, NULL, NULL, NULL, N'90', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (336, 1125, N'f2f36cd0-3697-4baa-88e5-962667acfa7b', 9, NULL, NULL, NULL, N'13983', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (337, 1125, N'f2f36cd0-3697-4baa-88e5-962667acfa7b', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (338, 1126, N'a153cb18-347a-4b85-b351-ac0d60a00690', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1067/popular-post-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (339, 1126, N'a153cb18-347a-4b85-b351-ac0d60a00690', 7, NULL, NULL, NULL, N'90', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (340, 1126, N'a153cb18-347a-4b85-b351-ac0d60a00690', 8, NULL, NULL, NULL, N'90', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (341, 1126, N'a153cb18-347a-4b85-b351-ac0d60a00690', 9, NULL, NULL, NULL, N'11090', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (342, 1126, N'a153cb18-347a-4b85-b351-ac0d60a00690', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (343, 1127, N'96eabbe0-dc5f-48b1-a507-e181530238f4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1068/popular-post-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (344, 1127, N'96eabbe0-dc5f-48b1-a507-e181530238f4', 7, NULL, NULL, NULL, N'90', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (345, 1127, N'96eabbe0-dc5f-48b1-a507-e181530238f4', 8, NULL, NULL, NULL, N'90', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (346, 1127, N'96eabbe0-dc5f-48b1-a507-e181530238f4', 9, NULL, NULL, NULL, N'13994', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (347, 1127, N'96eabbe0-dc5f-48b1-a507-e181530238f4', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (348, 1128, N'dbf60c29-53de-40de-b88d-f9e4bb8e22ee', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (349, 1129, N'57e65cee-3c86-43dc-90ae-36f34d611c3b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1069/1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (350, 1129, N'57e65cee-3c86-43dc-90ae-36f34d611c3b', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (351, 1129, N'57e65cee-3c86-43dc-90ae-36f34d611c3b', 8, NULL, NULL, NULL, N'780', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (352, 1129, N'57e65cee-3c86-43dc-90ae-36f34d611c3b', 9, NULL, NULL, NULL, N'186336', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (353, 1129, N'57e65cee-3c86-43dc-90ae-36f34d611c3b', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (354, 1130, N'ca851d91-b23d-4336-a864-08049b374146', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1070/2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (355, 1130, N'ca851d91-b23d-4336-a864-08049b374146', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (356, 1130, N'ca851d91-b23d-4336-a864-08049b374146', 8, NULL, NULL, NULL, N'780', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (357, 1130, N'ca851d91-b23d-4336-a864-08049b374146', 9, NULL, NULL, NULL, N'410195', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (358, 1130, N'ca851d91-b23d-4336-a864-08049b374146', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (359, 1131, N'74c77fcb-df27-485a-b476-4990cf3fba45', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1071/3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (360, 1131, N'74c77fcb-df27-485a-b476-4990cf3fba45', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (361, 1131, N'74c77fcb-df27-485a-b476-4990cf3fba45', 8, NULL, NULL, NULL, N'780', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (362, 1131, N'74c77fcb-df27-485a-b476-4990cf3fba45', 9, NULL, NULL, NULL, N'278139', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (363, 1131, N'74c77fcb-df27-485a-b476-4990cf3fba45', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (364, 1132, N'f49bb6d1-91dc-4d05-bfd3-b24fbd4c2435', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (365, 1133, N'43499b8c-f456-410a-8b7e-64ab037c0d8d', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1072/1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (366, 1133, N'43499b8c-f456-410a-8b7e-64ab037c0d8d', 7, NULL, NULL, NULL, N'330', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (367, 1133, N'43499b8c-f456-410a-8b7e-64ab037c0d8d', 8, NULL, NULL, NULL, N'230', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (368, 1133, N'43499b8c-f456-410a-8b7e-64ab037c0d8d', 9, NULL, NULL, NULL, N'40188', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (369, 1133, N'43499b8c-f456-410a-8b7e-64ab037c0d8d', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (370, 1134, N'f185dc89-e737-4857-8f5b-073047337f02', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1073/2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (371, 1134, N'f185dc89-e737-4857-8f5b-073047337f02', 7, NULL, NULL, NULL, N'330', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (372, 1134, N'f185dc89-e737-4857-8f5b-073047337f02', 8, NULL, NULL, NULL, N'230', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (373, 1134, N'f185dc89-e737-4857-8f5b-073047337f02', 9, NULL, NULL, NULL, N'45798', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (374, 1134, N'f185dc89-e737-4857-8f5b-073047337f02', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (375, 1135, N'bec81464-1d0a-4cae-825c-91903f3c8d46', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1074/3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (376, 1135, N'bec81464-1d0a-4cae-825c-91903f3c8d46', 7, NULL, NULL, NULL, N'330', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (377, 1135, N'bec81464-1d0a-4cae-825c-91903f3c8d46', 8, NULL, NULL, NULL, N'230', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (378, 1135, N'bec81464-1d0a-4cae-825c-91903f3c8d46', 9, NULL, NULL, NULL, N'51276', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (379, 1135, N'bec81464-1d0a-4cae-825c-91903f3c8d46', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (380, 1136, N'2b787eed-2509-463a-950d-fdaee2d2a9bc', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1075/4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (381, 1136, N'2b787eed-2509-463a-950d-fdaee2d2a9bc', 7, NULL, NULL, NULL, N'330', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (382, 1136, N'2b787eed-2509-463a-950d-fdaee2d2a9bc', 8, NULL, NULL, NULL, N'230', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (383, 1136, N'2b787eed-2509-463a-950d-fdaee2d2a9bc', 9, NULL, NULL, NULL, N'37350', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (384, 1136, N'2b787eed-2509-463a-950d-fdaee2d2a9bc', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (385, 1137, N'da789e58-8be2-4eda-9587-62d7e188918b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1076/5.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (386, 1137, N'da789e58-8be2-4eda-9587-62d7e188918b', 7, NULL, NULL, NULL, N'330', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (387, 1137, N'da789e58-8be2-4eda-9587-62d7e188918b', 8, NULL, NULL, NULL, N'230', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (388, 1137, N'da789e58-8be2-4eda-9587-62d7e188918b', 9, NULL, NULL, NULL, N'42653', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (389, 1137, N'da789e58-8be2-4eda-9587-62d7e188918b', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (390, 1138, N'1d6ae236-d943-4cd3-9600-9cf979100f35', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1077/6.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (391, 1138, N'1d6ae236-d943-4cd3-9600-9cf979100f35', 7, NULL, NULL, NULL, N'330', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (392, 1138, N'1d6ae236-d943-4cd3-9600-9cf979100f35', 8, NULL, NULL, NULL, N'230', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (393, 1138, N'1d6ae236-d943-4cd3-9600-9cf979100f35', 9, NULL, NULL, NULL, N'37918', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (394, 1138, N'1d6ae236-d943-4cd3-9600-9cf979100f35', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (395, 1139, N'61c2e5ea-38f2-41ee-9b0d-42c8169fafe6', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (396, 1140, N'8541f239-3909-45a3-92f3-7f525b54ad50', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1078/1.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (397, 1140, N'8541f239-3909-45a3-92f3-7f525b54ad50', 7, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (398, 1140, N'8541f239-3909-45a3-92f3-7f525b54ad50', 8, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (399, 1140, N'8541f239-3909-45a3-92f3-7f525b54ad50', 9, NULL, NULL, NULL, N'11380', NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (400, 1140, N'8541f239-3909-45a3-92f3-7f525b54ad50', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (401, 1141, N'00f22160-51b5-4097-8c92-65c747ec6b8b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1079/2.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (402, 1141, N'00f22160-51b5-4097-8c92-65c747ec6b8b', 7, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (403, 1141, N'00f22160-51b5-4097-8c92-65c747ec6b8b', 8, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (404, 1141, N'00f22160-51b5-4097-8c92-65c747ec6b8b', 9, NULL, NULL, NULL, N'11916', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (405, 1141, N'00f22160-51b5-4097-8c92-65c747ec6b8b', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (406, 1142, N'bc4cc61d-95ae-4748-b190-c08308b74bec', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1080/3.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (407, 1142, N'bc4cc61d-95ae-4748-b190-c08308b74bec', 7, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (408, 1142, N'bc4cc61d-95ae-4748-b190-c08308b74bec', 8, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (409, 1142, N'bc4cc61d-95ae-4748-b190-c08308b74bec', 9, NULL, NULL, NULL, N'13847', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (410, 1142, N'bc4cc61d-95ae-4748-b190-c08308b74bec', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (411, 1143, N'2026df61-6ca9-438d-98dd-de87123dde2d', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1081/4.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (412, 1143, N'2026df61-6ca9-438d-98dd-de87123dde2d', 7, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (413, 1143, N'2026df61-6ca9-438d-98dd-de87123dde2d', 8, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (414, 1143, N'2026df61-6ca9-438d-98dd-de87123dde2d', 9, NULL, NULL, NULL, N'12312', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (415, 1143, N'2026df61-6ca9-438d-98dd-de87123dde2d', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (416, 1144, N'95539d76-49a4-4c62-8e5e-4b3841f31491', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1082/5.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (417, 1144, N'95539d76-49a4-4c62-8e5e-4b3841f31491', 7, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (418, 1144, N'95539d76-49a4-4c62-8e5e-4b3841f31491', 8, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (419, 1144, N'95539d76-49a4-4c62-8e5e-4b3841f31491', 9, NULL, NULL, NULL, N'10909', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (420, 1144, N'95539d76-49a4-4c62-8e5e-4b3841f31491', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (421, 1145, N'8cf2a3fd-094e-43a0-8a98-c48bbd9afc31', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1083/6.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (422, 1145, N'8cf2a3fd-094e-43a0-8a98-c48bbd9afc31', 7, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (423, 1145, N'8cf2a3fd-094e-43a0-8a98-c48bbd9afc31', 8, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (424, 1145, N'8cf2a3fd-094e-43a0-8a98-c48bbd9afc31', 9, NULL, NULL, NULL, N'11396', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (425, 1145, N'8cf2a3fd-094e-43a0-8a98-c48bbd9afc31', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (426, 1146, N'7e6ccc0f-d6b8-4b05-b3ed-9691c21bb658', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1084/7.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (427, 1146, N'7e6ccc0f-d6b8-4b05-b3ed-9691c21bb658', 7, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (428, 1146, N'7e6ccc0f-d6b8-4b05-b3ed-9691c21bb658', 8, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (429, 1146, N'7e6ccc0f-d6b8-4b05-b3ed-9691c21bb658', 9, NULL, NULL, NULL, N'11733', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (430, 1146, N'7e6ccc0f-d6b8-4b05-b3ed-9691c21bb658', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (431, 1147, N'116f2fb8-0b18-4ce6-a1ad-f5de584a6687', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1085/8.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (432, 1147, N'116f2fb8-0b18-4ce6-a1ad-f5de584a6687', 7, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (433, 1147, N'116f2fb8-0b18-4ce6-a1ad-f5de584a6687', 8, NULL, NULL, NULL, N'80', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (434, 1147, N'116f2fb8-0b18-4ce6-a1ad-f5de584a6687', 9, NULL, NULL, NULL, N'10651', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (435, 1147, N'116f2fb8-0b18-4ce6-a1ad-f5de584a6687', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (436, 1148, N'7d08f76e-1ca2-419a-a21b-2ff6676bcba6', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1086/sidebar-testi-1.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (437, 1148, N'7d08f76e-1ca2-419a-a21b-2ff6676bcba6', 7, NULL, NULL, NULL, N'55', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (438, 1148, N'7d08f76e-1ca2-419a-a21b-2ff6676bcba6', 8, NULL, NULL, NULL, N'55', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (439, 1148, N'7d08f76e-1ca2-419a-a21b-2ff6676bcba6', 9, NULL, NULL, NULL, N'6850', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (440, 1148, N'7d08f76e-1ca2-419a-a21b-2ff6676bcba6', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (441, 1149, N'ec122e97-ac76-498d-89fc-5eeeada961c4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1087/sidebar-testi-2.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (442, 1149, N'ec122e97-ac76-498d-89fc-5eeeada961c4', 7, NULL, NULL, NULL, N'55', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (443, 1149, N'ec122e97-ac76-498d-89fc-5eeeada961c4', 8, NULL, NULL, NULL, N'55', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (444, 1149, N'ec122e97-ac76-498d-89fc-5eeeada961c4', 9, NULL, NULL, NULL, N'7117', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (445, 1149, N'ec122e97-ac76-498d-89fc-5eeeada961c4', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (446, 1150, N'a35befe0-af0f-4475-9ed7-10a0f832f905', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (447, 1151, N'426c66ac-7fd4-42df-91ba-53c5f195afbe', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1088/mission.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (448, 1151, N'426c66ac-7fd4-42df-91ba-53c5f195afbe', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (449, 1151, N'426c66ac-7fd4-42df-91ba-53c5f195afbe', 8, NULL, NULL, NULL, N'300', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (450, 1151, N'426c66ac-7fd4-42df-91ba-53c5f195afbe', 9, NULL, NULL, NULL, N'75160', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (451, 1151, N'426c66ac-7fd4-42df-91ba-53c5f195afbe', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (452, 1152, N'c63da573-dc88-4985-b848-74923efc48da', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1089/vision.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (453, 1152, N'c63da573-dc88-4985-b848-74923efc48da', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (454, 1152, N'c63da573-dc88-4985-b848-74923efc48da', 8, NULL, NULL, NULL, N'300', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (455, 1152, N'c63da573-dc88-4985-b848-74923efc48da', 9, NULL, NULL, NULL, N'64300', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (456, 1152, N'c63da573-dc88-4985-b848-74923efc48da', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (457, 1153, N'be1185a4-dab2-4909-9fa1-d3d5e18ba588', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (458, 1154, N'324102d5-ac20-4c8c-bcc4-4dba55697ef1', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1090/author.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (459, 1154, N'324102d5-ac20-4c8c-bcc4-4dba55697ef1', 7, NULL, NULL, NULL, N'85', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (460, 1154, N'324102d5-ac20-4c8c-bcc4-4dba55697ef1', 8, NULL, NULL, NULL, N'85', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (461, 1154, N'324102d5-ac20-4c8c-bcc4-4dba55697ef1', 9, NULL, NULL, NULL, N'7754', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (462, 1154, N'324102d5-ac20-4c8c-bcc4-4dba55697ef1', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (463, 1155, N'ab871d36-44b2-427d-ae8f-6e4709c86530', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1091/blog-single.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (464, 1155, N'ab871d36-44b2-427d-ae8f-6e4709c86530', 7, NULL, NULL, NULL, N'770', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (465, 1155, N'ab871d36-44b2-427d-ae8f-6e4709c86530', 8, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (466, 1155, N'ab871d36-44b2-427d-ae8f-6e4709c86530', 9, NULL, NULL, NULL, N'184030', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (467, 1155, N'ab871d36-44b2-427d-ae8f-6e4709c86530', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (468, 1156, N'750ccfbe-728e-4c18-b48a-a8f11ed7a05f', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1092/caption-img.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (469, 1156, N'750ccfbe-728e-4c18-b48a-a8f11ed7a05f', 7, NULL, NULL, NULL, N'345', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (470, 1156, N'750ccfbe-728e-4c18-b48a-a8f11ed7a05f', 8, NULL, NULL, NULL, N'215', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (471, 1156, N'750ccfbe-728e-4c18-b48a-a8f11ed7a05f', 9, NULL, NULL, NULL, N'83937', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (472, 1156, N'750ccfbe-728e-4c18-b48a-a8f11ed7a05f', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (473, 1157, N'd4f9630c-1aea-4d0b-b08e-54abae55a72d', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1093/comment-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (474, 1157, N'd4f9630c-1aea-4d0b-b08e-54abae55a72d', 7, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (475, 1157, N'd4f9630c-1aea-4d0b-b08e-54abae55a72d', 8, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (476, 1157, N'd4f9630c-1aea-4d0b-b08e-54abae55a72d', 9, NULL, NULL, NULL, N'5242', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (477, 1157, N'd4f9630c-1aea-4d0b-b08e-54abae55a72d', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (478, 1158, N'0d8b6a0a-e4c8-47e4-89cf-38875bdb0a8a', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1094/comment-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (479, 1158, N'0d8b6a0a-e4c8-47e4-89cf-38875bdb0a8a', 7, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (480, 1158, N'0d8b6a0a-e4c8-47e4-89cf-38875bdb0a8a', 8, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (481, 1158, N'0d8b6a0a-e4c8-47e4-89cf-38875bdb0a8a', 9, NULL, NULL, NULL, N'5391', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (482, 1158, N'0d8b6a0a-e4c8-47e4-89cf-38875bdb0a8a', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (483, 1159, N'08d0d28a-629f-4c25-b798-320ee136f09d', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1095/lat-blog-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (484, 1159, N'08d0d28a-629f-4c25-b798-320ee136f09d', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (485, 1159, N'08d0d28a-629f-4c25-b798-320ee136f09d', 8, NULL, NULL, NULL, N'185', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (486, 1159, N'08d0d28a-629f-4c25-b798-320ee136f09d', 9, NULL, NULL, NULL, N'59559', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (487, 1159, N'08d0d28a-629f-4c25-b798-320ee136f09d', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (488, 1160, N'bcaab792-070c-4e47-b2bd-72efef6a3738', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1096/lat-blog-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (489, 1160, N'bcaab792-070c-4e47-b2bd-72efef6a3738', 7, NULL, NULL, NULL, N'270', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (490, 1160, N'bcaab792-070c-4e47-b2bd-72efef6a3738', 8, NULL, NULL, NULL, N'185', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (491, 1160, N'bcaab792-070c-4e47-b2bd-72efef6a3738', 9, NULL, NULL, NULL, N'46522', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (492, 1160, N'bcaab792-070c-4e47-b2bd-72efef6a3738', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (493, 1161, N'62ebe452-e2e1-4ff2-9c2a-be1cbc2c54db', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1097/v1-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (494, 1161, N'62ebe452-e2e1-4ff2-9c2a-be1cbc2c54db', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (495, 1161, N'62ebe452-e2e1-4ff2-9c2a-be1cbc2c54db', 8, NULL, NULL, NULL, N'300', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (496, 1161, N'62ebe452-e2e1-4ff2-9c2a-be1cbc2c54db', 9, NULL, NULL, NULL, N'72144', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (497, 1161, N'62ebe452-e2e1-4ff2-9c2a-be1cbc2c54db', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (498, 1162, N'e318522a-da70-42c9-9bef-e7b7f9929a39', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1098/v1-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (499, 1162, N'e318522a-da70-42c9-9bef-e7b7f9929a39', 7, NULL, NULL, NULL, N'370', NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (500, 1162, N'e318522a-da70-42c9-9bef-e7b7f9929a39', 8, NULL, NULL, NULL, N'300', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (501, 1162, N'e318522a-da70-42c9-9bef-e7b7f9929a39', 9, NULL, NULL, NULL, N'105557', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (502, 1162, N'e318522a-da70-42c9-9bef-e7b7f9929a39', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (503, 1163, N'd905ede1-105b-4e5a-9698-b595b381954a', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1099/v1-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (504, 1163, N'd905ede1-105b-4e5a-9698-b595b381954a', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (505, 1163, N'd905ede1-105b-4e5a-9698-b595b381954a', 8, NULL, NULL, NULL, N'300', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (506, 1163, N'd905ede1-105b-4e5a-9698-b595b381954a', 9, NULL, NULL, NULL, N'119089', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (507, 1163, N'd905ede1-105b-4e5a-9698-b595b381954a', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (508, 1164, N'0896544c-c8cc-4d96-8eb9-0d17066190e5', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1100/v1-4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (509, 1164, N'0896544c-c8cc-4d96-8eb9-0d17066190e5', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (510, 1164, N'0896544c-c8cc-4d96-8eb9-0d17066190e5', 8, NULL, NULL, NULL, N'300', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (511, 1164, N'0896544c-c8cc-4d96-8eb9-0d17066190e5', 9, NULL, NULL, NULL, N'93223', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (512, 1164, N'0896544c-c8cc-4d96-8eb9-0d17066190e5', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (513, 1165, N'c0c38d10-aaf5-464d-8ac9-9470f5656135', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1101/v2-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (514, 1165, N'c0c38d10-aaf5-464d-8ac9-9470f5656135', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (515, 1165, N'c0c38d10-aaf5-464d-8ac9-9470f5656135', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (516, 1165, N'c0c38d10-aaf5-464d-8ac9-9470f5656135', 9, NULL, NULL, NULL, N'58813', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (517, 1165, N'c0c38d10-aaf5-464d-8ac9-9470f5656135', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (518, 1166, N'a0bb59ab-f760-4ccf-bbac-effdf0d81a38', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1102/v2-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (519, 1166, N'a0bb59ab-f760-4ccf-bbac-effdf0d81a38', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (520, 1166, N'a0bb59ab-f760-4ccf-bbac-effdf0d81a38', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (521, 1166, N'a0bb59ab-f760-4ccf-bbac-effdf0d81a38', 9, NULL, NULL, NULL, N'87110', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (522, 1166, N'a0bb59ab-f760-4ccf-bbac-effdf0d81a38', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (523, 1167, N'857a6063-af42-4ac8-97ce-dc1ddf2f100b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1103/v2-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (524, 1167, N'857a6063-af42-4ac8-97ce-dc1ddf2f100b', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (525, 1167, N'857a6063-af42-4ac8-97ce-dc1ddf2f100b', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (526, 1167, N'857a6063-af42-4ac8-97ce-dc1ddf2f100b', 9, NULL, NULL, NULL, N'89224', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (527, 1167, N'857a6063-af42-4ac8-97ce-dc1ddf2f100b', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (528, 1168, N'1335e95a-4f0e-4541-ad9d-da3935268c15', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1104/v2-4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (529, 1168, N'1335e95a-4f0e-4541-ad9d-da3935268c15', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (530, 1168, N'1335e95a-4f0e-4541-ad9d-da3935268c15', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (531, 1168, N'1335e95a-4f0e-4541-ad9d-da3935268c15', 9, NULL, NULL, NULL, N'68669', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (532, 1168, N'1335e95a-4f0e-4541-ad9d-da3935268c15', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (533, 1169, N'4a4ff14c-15a8-45f1-986a-445bb8658e4e', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1105/v2-5.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (534, 1169, N'4a4ff14c-15a8-45f1-986a-445bb8658e4e', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (535, 1169, N'4a4ff14c-15a8-45f1-986a-445bb8658e4e', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (536, 1169, N'4a4ff14c-15a8-45f1-986a-445bb8658e4e', 9, NULL, NULL, NULL, N'138989', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (537, 1169, N'4a4ff14c-15a8-45f1-986a-445bb8658e4e', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (538, 1170, N'96ed0972-4b36-4529-86fc-9a14082d68f9', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1106/v2-6.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (539, 1170, N'96ed0972-4b36-4529-86fc-9a14082d68f9', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (540, 1170, N'96ed0972-4b36-4529-86fc-9a14082d68f9', 8, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (541, 1170, N'96ed0972-4b36-4529-86fc-9a14082d68f9', 9, NULL, NULL, NULL, N'95609', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (542, 1170, N'96ed0972-4b36-4529-86fc-9a14082d68f9', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (543, 1171, N'821996ff-b0a0-48b3-a59d-508d90a26a3f', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1107/v3-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (544, 1171, N'821996ff-b0a0-48b3-a59d-508d90a26a3f', 7, NULL, NULL, NULL, N'770', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (545, 1171, N'821996ff-b0a0-48b3-a59d-508d90a26a3f', 8, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (546, 1171, N'821996ff-b0a0-48b3-a59d-508d90a26a3f', 9, NULL, NULL, NULL, N'151446', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (547, 1171, N'821996ff-b0a0-48b3-a59d-508d90a26a3f', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (548, 1172, N'434dc18e-a1be-4678-a015-7d3406098c63', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1108/v3-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (549, 1172, N'434dc18e-a1be-4678-a015-7d3406098c63', 7, NULL, NULL, NULL, N'770', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (550, 1172, N'434dc18e-a1be-4678-a015-7d3406098c63', 8, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (551, 1172, N'434dc18e-a1be-4678-a015-7d3406098c63', 9, NULL, NULL, NULL, N'212832', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (552, 1172, N'434dc18e-a1be-4678-a015-7d3406098c63', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (553, 1173, N'568ece08-48b1-4bb1-aded-151687a3fcd4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1109/v3-3.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (554, 1173, N'568ece08-48b1-4bb1-aded-151687a3fcd4', 7, NULL, NULL, NULL, N'770', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (555, 1173, N'568ece08-48b1-4bb1-aded-151687a3fcd4', 8, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (556, 1173, N'568ece08-48b1-4bb1-aded-151687a3fcd4', 9, NULL, NULL, NULL, N'249337', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (557, 1173, N'568ece08-48b1-4bb1-aded-151687a3fcd4', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (558, 1174, N'ac1fc696-49da-4205-bd1d-5d45df3d6720', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1110/v3-4.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (559, 1174, N'ac1fc696-49da-4205-bd1d-5d45df3d6720', 7, NULL, NULL, NULL, N'770', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (560, 1174, N'ac1fc696-49da-4205-bd1d-5d45df3d6720', 8, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (561, 1174, N'ac1fc696-49da-4205-bd1d-5d45df3d6720', 9, NULL, NULL, NULL, N'187332', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (562, 1174, N'ac1fc696-49da-4205-bd1d-5d45df3d6720', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (563, 1175, N'8ca657ef-7d56-44a8-b780-b4a0b969b140', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (564, 1176, N'83210281-b8ed-427a-acb4-9ecb66c70a74', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1111/1.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (565, 1176, N'83210281-b8ed-427a-acb4-9ecb66c70a74', 7, NULL, NULL, NULL, N'130', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (566, 1176, N'83210281-b8ed-427a-acb4-9ecb66c70a74', 8, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (567, 1176, N'83210281-b8ed-427a-acb4-9ecb66c70a74', 9, NULL, NULL, NULL, N'4260', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (568, 1176, N'83210281-b8ed-427a-acb4-9ecb66c70a74', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (569, 1177, N'632c10fa-b22a-46d0-a381-1c3367f1a59e', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1112/2.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (570, 1177, N'632c10fa-b22a-46d0-a381-1c3367f1a59e', 7, NULL, NULL, NULL, N'130', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (571, 1177, N'632c10fa-b22a-46d0-a381-1c3367f1a59e', 8, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (572, 1177, N'632c10fa-b22a-46d0-a381-1c3367f1a59e', 9, NULL, NULL, NULL, N'3543', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (573, 1177, N'632c10fa-b22a-46d0-a381-1c3367f1a59e', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (574, 1178, N'0f121470-d8a7-4fdf-ae52-b616136d17da', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (575, 1179, N'593227ac-3da9-4631-984f-15accf413fef', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1113/blank.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (576, 1179, N'593227ac-3da9-4631-984f-15accf413fef', 7, NULL, NULL, NULL, N'1', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (577, 1179, N'593227ac-3da9-4631-984f-15accf413fef', 8, NULL, NULL, NULL, N'1', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (578, 1179, N'593227ac-3da9-4631-984f-15accf413fef', 9, NULL, NULL, NULL, N'43', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (579, 1179, N'593227ac-3da9-4631-984f-15accf413fef', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (580, 1180, N'fa647386-2cd1-4bcc-a0a5-4b86dc04eef1', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1114/fancybox_loading.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (581, 1180, N'fa647386-2cd1-4bcc-a0a5-4b86dc04eef1', 7, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (582, 1180, N'fa647386-2cd1-4bcc-a0a5-4b86dc04eef1', 8, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (583, 1180, N'fa647386-2cd1-4bcc-a0a5-4b86dc04eef1', 9, NULL, NULL, NULL, N'6567', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (584, 1180, N'fa647386-2cd1-4bcc-a0a5-4b86dc04eef1', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (585, 1181, N'cc64cf40-b629-4ad5-acc1-ff6daa2ce602', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1115/fancybox_loading-2x.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (586, 1181, N'cc64cf40-b629-4ad5-acc1-ff6daa2ce602', 7, NULL, NULL, NULL, N'48', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (587, 1181, N'cc64cf40-b629-4ad5-acc1-ff6daa2ce602', 8, NULL, NULL, NULL, N'48', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (588, 1181, N'cc64cf40-b629-4ad5-acc1-ff6daa2ce602', 9, NULL, NULL, NULL, N'13984', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (589, 1181, N'cc64cf40-b629-4ad5-acc1-ff6daa2ce602', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (590, 1182, N'facfdb4b-1ab4-4a83-a3a9-3a4b5577ee42', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1116/fancybox_overlay.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (591, 1182, N'facfdb4b-1ab4-4a83-a3a9-3a4b5577ee42', 7, NULL, NULL, NULL, N'10', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (592, 1182, N'facfdb4b-1ab4-4a83-a3a9-3a4b5577ee42', 8, NULL, NULL, NULL, N'10', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (593, 1182, N'facfdb4b-1ab4-4a83-a3a9-3a4b5577ee42', 9, NULL, NULL, NULL, N'1003', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (594, 1182, N'facfdb4b-1ab4-4a83-a3a9-3a4b5577ee42', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (595, 1183, N'16b3c4f8-5d29-4b35-b9bc-f941d0eda5d5', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1117/fancybox_sprite.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (596, 1183, N'16b3c4f8-5d29-4b35-b9bc-f941d0eda5d5', 7, NULL, NULL, NULL, N'44', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (597, 1183, N'16b3c4f8-5d29-4b35-b9bc-f941d0eda5d5', 8, NULL, NULL, NULL, N'152', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (598, 1183, N'16b3c4f8-5d29-4b35-b9bc-f941d0eda5d5', 9, NULL, NULL, NULL, N'1362', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (599, 1183, N'16b3c4f8-5d29-4b35-b9bc-f941d0eda5d5', 10, NULL, NULL, NULL, N'png', NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (600, 1184, N'b8f654a7-a26f-4c86-acfa-fa38c0a5328d', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1118/fancybox_sprite-2x.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (601, 1184, N'b8f654a7-a26f-4c86-acfa-fa38c0a5328d', 7, NULL, NULL, NULL, N'88', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (602, 1184, N'b8f654a7-a26f-4c86-acfa-fa38c0a5328d', 8, NULL, NULL, NULL, N'304', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (603, 1184, N'b8f654a7-a26f-4c86-acfa-fa38c0a5328d', 9, NULL, NULL, NULL, N'6553', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (604, 1184, N'b8f654a7-a26f-4c86-acfa-fa38c0a5328d', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (605, 1185, N'27d8ac6b-8ae3-4725-8688-87a2a4558994', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (606, 1186, N'da64f9c8-392e-4404-863a-a7d0433282e6', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1119/apple-touch-icon.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (607, 1186, N'da64f9c8-392e-4404-863a-a7d0433282e6', 7, NULL, NULL, NULL, N'180', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (608, 1186, N'da64f9c8-392e-4404-863a-a7d0433282e6', 8, NULL, NULL, NULL, N'180', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (609, 1186, N'da64f9c8-392e-4404-863a-a7d0433282e6', 9, NULL, NULL, NULL, N'3896', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (610, 1186, N'da64f9c8-392e-4404-863a-a7d0433282e6', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (611, 1187, N'ecf48e1d-0c6b-49ea-b69c-d305691024ab', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1120/favicon-16x16.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (612, 1187, N'ecf48e1d-0c6b-49ea-b69c-d305691024ab', 7, NULL, NULL, NULL, N'16', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (613, 1187, N'ecf48e1d-0c6b-49ea-b69c-d305691024ab', 8, NULL, NULL, NULL, N'16', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (614, 1187, N'ecf48e1d-0c6b-49ea-b69c-d305691024ab', 9, NULL, NULL, NULL, N'923', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (615, 1187, N'ecf48e1d-0c6b-49ea-b69c-d305691024ab', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (616, 1188, N'73275192-06d1-45b2-90c6-957ba8dd29bc', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1121/favicon-32x32.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (617, 1188, N'73275192-06d1-45b2-90c6-957ba8dd29bc', 7, NULL, NULL, NULL, N'32', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (618, 1188, N'73275192-06d1-45b2-90c6-957ba8dd29bc', 8, NULL, NULL, NULL, N'32', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (619, 1188, N'73275192-06d1-45b2-90c6-957ba8dd29bc', 9, NULL, NULL, NULL, N'1328', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (620, 1188, N'73275192-06d1-45b2-90c6-957ba8dd29bc', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (621, 1189, N'f8fe6413-0327-4d49-9f23-07d07bdb41c4', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (622, 1190, N'0dd39825-dc68-458e-8343-ced375287853', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1122/footer-logo.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (623, 1190, N'0dd39825-dc68-458e-8343-ced375287853', 7, NULL, NULL, NULL, N'220', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (624, 1190, N'0dd39825-dc68-458e-8343-ced375287853', 8, NULL, NULL, NULL, N'60', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (625, 1190, N'0dd39825-dc68-458e-8343-ced375287853', 9, NULL, NULL, NULL, N'7630', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (626, 1190, N'0dd39825-dc68-458e-8343-ced375287853', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (627, 1191, N'47300941-2d6f-4291-aa7c-ae7f280cf3e0', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (628, 1192, N'588e6dff-9660-4be7-b647-5a0bfa11a80b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1123/1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (629, 1192, N'588e6dff-9660-4be7-b647-5a0bfa11a80b', 7, NULL, NULL, NULL, N'450', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (630, 1192, N'588e6dff-9660-4be7-b647-5a0bfa11a80b', 8, NULL, NULL, NULL, N'240', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (631, 1192, N'588e6dff-9660-4be7-b647-5a0bfa11a80b', 9, NULL, NULL, NULL, N'137967', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (632, 1192, N'588e6dff-9660-4be7-b647-5a0bfa11a80b', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (633, 1193, N'f3b60a16-ad74-49b7-a4a7-1e72bfb69c58', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1124/2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (634, 1193, N'f3b60a16-ad74-49b7-a4a7-1e72bfb69c58', 7, NULL, NULL, NULL, N'450', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (635, 1193, N'f3b60a16-ad74-49b7-a4a7-1e72bfb69c58', 8, NULL, NULL, NULL, N'240', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (636, 1193, N'f3b60a16-ad74-49b7-a4a7-1e72bfb69c58', 9, NULL, NULL, NULL, N'75070', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (637, 1193, N'f3b60a16-ad74-49b7-a4a7-1e72bfb69c58', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (638, 1194, N'322ea4bf-0f8d-437d-b983-9b983bacffbc', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (639, 1195, N'4f841bc5-c1ce-4a66-9fb0-128adc068167', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1125/bx_loader.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (640, 1195, N'4f841bc5-c1ce-4a66-9fb0-128adc068167', 7, NULL, NULL, NULL, N'32', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (641, 1195, N'4f841bc5-c1ce-4a66-9fb0-128adc068167', 8, NULL, NULL, NULL, N'32', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (642, 1195, N'4f841bc5-c1ce-4a66-9fb0-128adc068167', 9, NULL, NULL, NULL, N'8581', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (643, 1195, N'4f841bc5-c1ce-4a66-9fb0-128adc068167', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (644, 1196, N'c2745744-269e-4425-9dee-e30128c66ffe', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1126/preloader.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (645, 1196, N'c2745744-269e-4425-9dee-e30128c66ffe', 7, NULL, NULL, NULL, N'90', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (646, 1196, N'c2745744-269e-4425-9dee-e30128c66ffe', 8, NULL, NULL, NULL, N'90', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (647, 1196, N'c2745744-269e-4425-9dee-e30128c66ffe', 9, NULL, NULL, NULL, N'12494', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (648, 1196, N'c2745744-269e-4425-9dee-e30128c66ffe', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (649, 1197, N'7005b81d-d45b-43e3-b04c-f3216ef2054f', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1127/submenu-icon.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (650, 1197, N'7005b81d-d45b-43e3-b04c-f3216ef2054f', 7, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (651, 1197, N'7005b81d-d45b-43e3-b04c-f3216ef2054f', 8, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (652, 1197, N'7005b81d-d45b-43e3-b04c-f3216ef2054f', 9, NULL, NULL, NULL, N'163', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (653, 1197, N'7005b81d-d45b-43e3-b04c-f3216ef2054f', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (654, 1198, N'89a5508c-1226-4811-b44e-3b4df277073b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1128/tick.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (655, 1198, N'89a5508c-1226-4811-b44e-3b4df277073b', 7, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (656, 1198, N'89a5508c-1226-4811-b44e-3b4df277073b', 8, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (657, 1198, N'89a5508c-1226-4811-b44e-3b4df277073b', 9, NULL, NULL, NULL, N'15057', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (658, 1198, N'89a5508c-1226-4811-b44e-3b4df277073b', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (659, 1199, N'241a2413-3dee-4765-ae15-741b2dfed4f0', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (660, 1200, N'9cb1db9f-99eb-4272-bc5e-e5019041b4e4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1129/choose-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (661, 1200, N'9cb1db9f-99eb-4272-bc5e-e5019041b4e4', 7, NULL, NULL, NULL, N'1170', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (662, 1200, N'9cb1db9f-99eb-4272-bc5e-e5019041b4e4', 8, NULL, NULL, NULL, N'290', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (663, 1200, N'9cb1db9f-99eb-4272-bc5e-e5019041b4e4', 9, NULL, NULL, NULL, N'177172', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (664, 1200, N'9cb1db9f-99eb-4272-bc5e-e5019041b4e4', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (665, 1201, N'dcf33e69-6223-4dff-9d12-6a09b0f0eb79', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1130/consultation-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (666, 1201, N'dcf33e69-6223-4dff-9d12-6a09b0f0eb79', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (667, 1201, N'dcf33e69-6223-4dff-9d12-6a09b0f0eb79', 8, NULL, NULL, NULL, N'335', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (668, 1201, N'dcf33e69-6223-4dff-9d12-6a09b0f0eb79', 9, NULL, NULL, NULL, N'284601', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (669, 1201, N'dcf33e69-6223-4dff-9d12-6a09b0f0eb79', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (670, 1202, N'f1093abd-81f5-440b-b480-07c0a837ac49', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1131/contact-details-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (671, 1202, N'f1093abd-81f5-440b-b480-07c0a837ac49', 7, NULL, NULL, NULL, N'585', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (672, 1202, N'f1093abd-81f5-440b-b480-07c0a837ac49', 8, NULL, NULL, NULL, N'371', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (673, 1202, N'f1093abd-81f5-440b-b480-07c0a837ac49', 9, NULL, NULL, NULL, N'166377', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (674, 1202, N'f1093abd-81f5-440b-b480-07c0a837ac49', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (675, 1203, N'5fc9dbc7-b441-4f03-ab0b-e2cad2884d9c', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1132/covered-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (676, 1203, N'5fc9dbc7-b441-4f03-ab0b-e2cad2884d9c', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (677, 1203, N'5fc9dbc7-b441-4f03-ab0b-e2cad2884d9c', 8, NULL, NULL, NULL, N'835', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (678, 1203, N'5fc9dbc7-b441-4f03-ab0b-e2cad2884d9c', 9, NULL, NULL, NULL, N'380436', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (679, 1203, N'5fc9dbc7-b441-4f03-ab0b-e2cad2884d9c', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (680, 1204, N'c9d9802e-3142-410c-8f64-3f28db001e37', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1133/service-about-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (681, 1204, N'c9d9802e-3142-410c-8f64-3f28db001e37', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (682, 1204, N'c9d9802e-3142-410c-8f64-3f28db001e37', 8, NULL, NULL, NULL, N'420', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (683, 1204, N'c9d9802e-3142-410c-8f64-3f28db001e37', 9, NULL, NULL, NULL, N'372256', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (684, 1204, N'c9d9802e-3142-410c-8f64-3f28db001e37', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (685, 1205, N'084b97da-e6ee-400f-9b47-2053d1a47898', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1134/slogan-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (686, 1205, N'084b97da-e6ee-400f-9b47-2053d1a47898', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (687, 1205, N'084b97da-e6ee-400f-9b47-2053d1a47898', 8, NULL, NULL, NULL, N'100', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (688, 1205, N'084b97da-e6ee-400f-9b47-2053d1a47898', 9, NULL, NULL, NULL, N'193044', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (689, 1205, N'084b97da-e6ee-400f-9b47-2053d1a47898', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (690, 1206, N'b3d5126f-4c19-4208-ae62-7323919212ff', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1135/testimonial-section-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (691, 1206, N'b3d5126f-4c19-4208-ae62-7323919212ff', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (692, 1206, N'b3d5126f-4c19-4208-ae62-7323919212ff', 8, NULL, NULL, NULL, N'665', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (693, 1206, N'b3d5126f-4c19-4208-ae62-7323919212ff', 9, NULL, NULL, NULL, N'267974', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (694, 1206, N'b3d5126f-4c19-4208-ae62-7323919212ff', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (695, 1207, N'5a723c0f-decc-4af4-a475-1b207801eed5', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (696, 1208, N'e3e8b00c-9f10-4dd1-8cf8-7d95b73b5fcf', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (697, 1209, N'a56eff46-b4d2-4959-93ba-de3f016d4072', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1136/btnnext.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (698, 1209, N'a56eff46-b4d2-4959-93ba-de3f016d4072', 7, NULL, NULL, NULL, N'61', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (699, 1209, N'a56eff46-b4d2-4959-93ba-de3f016d4072', 8, NULL, NULL, NULL, N'22', NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (700, 1209, N'a56eff46-b4d2-4959-93ba-de3f016d4072', 9, NULL, NULL, NULL, N'1411', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (701, 1209, N'a56eff46-b4d2-4959-93ba-de3f016d4072', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (702, 1210, N'20dc4b96-2fe5-4a37-b3dd-b07b85a4b758', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1137/btnprevious.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (703, 1210, N'20dc4b96-2fe5-4a37-b3dd-b07b85a4b758', 7, NULL, NULL, NULL, N'61', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (704, 1210, N'20dc4b96-2fe5-4a37-b3dd-b07b85a4b758', 8, NULL, NULL, NULL, N'22', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (705, 1210, N'20dc4b96-2fe5-4a37-b3dd-b07b85a4b758', 9, NULL, NULL, NULL, N'1442', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (706, 1210, N'20dc4b96-2fe5-4a37-b3dd-b07b85a4b758', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (707, 1211, N'eb754c7b-db90-438c-b74f-bcc775a2e6da', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1138/contentpattern.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (708, 1211, N'eb754c7b-db90-438c-b74f-bcc775a2e6da', 7, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (709, 1211, N'eb754c7b-db90-438c-b74f-bcc775a2e6da', 8, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (710, 1211, N'eb754c7b-db90-438c-b74f-bcc775a2e6da', 9, NULL, NULL, NULL, N'130', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (711, 1211, N'eb754c7b-db90-438c-b74f-bcc775a2e6da', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (712, 1212, N'0353db66-d1e0-4230-9bff-23d4bbc100ef', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1139/loader.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (713, 1212, N'0353db66-d1e0-4230-9bff-23d4bbc100ef', 7, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (714, 1212, N'0353db66-d1e0-4230-9bff-23d4bbc100ef', 8, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (715, 1212, N'0353db66-d1e0-4230-9bff-23d4bbc100ef', 9, NULL, NULL, NULL, N'2545', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (716, 1212, N'0353db66-d1e0-4230-9bff-23d4bbc100ef', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (717, 1213, N'858e46ee-3316-4e44-897e-4e8a1038903f', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1140/sprite.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (718, 1213, N'858e46ee-3316-4e44-897e-4e8a1038903f', 7, NULL, NULL, NULL, N'130', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (719, 1213, N'858e46ee-3316-4e44-897e-4e8a1038903f', 8, NULL, NULL, NULL, N'119', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (720, 1213, N'858e46ee-3316-4e44-897e-4e8a1038903f', 9, NULL, NULL, NULL, N'4076', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (721, 1213, N'858e46ee-3316-4e44-897e-4e8a1038903f', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (722, 1214, N'a5ca47af-d1b0-4db2-b2f0-51f35d392a8c', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (723, 1215, N'e6c1c8ea-5501-44f0-a19a-5bf0ea7f84b6', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1141/btnnext.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (724, 1215, N'e6c1c8ea-5501-44f0-a19a-5bf0ea7f84b6', 7, NULL, NULL, NULL, N'61', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (725, 1215, N'e6c1c8ea-5501-44f0-a19a-5bf0ea7f84b6', 8, NULL, NULL, NULL, N'22', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (726, 1215, N'e6c1c8ea-5501-44f0-a19a-5bf0ea7f84b6', 9, NULL, NULL, NULL, N'1411', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (727, 1215, N'e6c1c8ea-5501-44f0-a19a-5bf0ea7f84b6', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (728, 1216, N'dcb1b2df-a077-481c-ac3f-e7d4abb183ec', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1142/btnprevious.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (729, 1216, N'dcb1b2df-a077-481c-ac3f-e7d4abb183ec', 7, NULL, NULL, NULL, N'61', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (730, 1216, N'dcb1b2df-a077-481c-ac3f-e7d4abb183ec', 8, NULL, NULL, NULL, N'22', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (731, 1216, N'dcb1b2df-a077-481c-ac3f-e7d4abb183ec', 9, NULL, NULL, NULL, N'1442', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (732, 1216, N'dcb1b2df-a077-481c-ac3f-e7d4abb183ec', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (733, 1217, N'764ed384-84fa-4482-9e95-fc47198e25a2', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1143/loader.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (734, 1217, N'764ed384-84fa-4482-9e95-fc47198e25a2', 7, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (735, 1217, N'764ed384-84fa-4482-9e95-fc47198e25a2', 8, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (736, 1217, N'764ed384-84fa-4482-9e95-fc47198e25a2', 9, NULL, NULL, NULL, N'2545', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (737, 1217, N'764ed384-84fa-4482-9e95-fc47198e25a2', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (738, 1218, N'de3c142b-490b-43c5-977a-49edc1d1acc4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1144/sprite.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (739, 1218, N'de3c142b-490b-43c5-977a-49edc1d1acc4', 7, NULL, NULL, NULL, N'76', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (740, 1218, N'de3c142b-490b-43c5-977a-49edc1d1acc4', 8, NULL, NULL, NULL, N'119', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (741, 1218, N'de3c142b-490b-43c5-977a-49edc1d1acc4', 9, NULL, NULL, NULL, N'3507', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (742, 1218, N'de3c142b-490b-43c5-977a-49edc1d1acc4', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (743, 1219, N'9a0dd485-aa7c-48e7-831b-2caf46a9c153', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (744, 1220, N'b73f209d-e0b6-4293-8594-597b906ffc04', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1145/default_thumb.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (745, 1220, N'b73f209d-e0b6-4293-8594-597b906ffc04', 7, NULL, NULL, NULL, N'50', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (746, 1220, N'b73f209d-e0b6-4293-8594-597b906ffc04', 8, NULL, NULL, NULL, N'33', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (747, 1220, N'b73f209d-e0b6-4293-8594-597b906ffc04', 9, NULL, NULL, NULL, N'1537', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (748, 1220, N'b73f209d-e0b6-4293-8594-597b906ffc04', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (749, 1221, N'843f07e5-c86e-4d0c-881d-fcb34fe3acca', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1146/loader.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (750, 1221, N'843f07e5-c86e-4d0c-881d-fcb34fe3acca', 7, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (751, 1221, N'843f07e5-c86e-4d0c-881d-fcb34fe3acca', 8, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (752, 1221, N'843f07e5-c86e-4d0c-881d-fcb34fe3acca', 9, NULL, NULL, NULL, N'6331', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (753, 1221, N'843f07e5-c86e-4d0c-881d-fcb34fe3acca', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (754, 1222, N'8ce3d0c1-bc3d-4baf-9e52-faa78951e44c', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1147/sprite.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (755, 1222, N'8ce3d0c1-bc3d-4baf-9e52-faa78951e44c', 7, NULL, NULL, NULL, N'130', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (756, 1222, N'8ce3d0c1-bc3d-4baf-9e52-faa78951e44c', 8, NULL, NULL, NULL, N'147', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (757, 1222, N'8ce3d0c1-bc3d-4baf-9e52-faa78951e44c', 9, NULL, NULL, NULL, N'6682', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (758, 1222, N'8ce3d0c1-bc3d-4baf-9e52-faa78951e44c', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (759, 1223, N'8aca3e8e-7655-45d1-9598-a715dd29f2a4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1148/sprite_next.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (760, 1223, N'8aca3e8e-7655-45d1-9598-a715dd29f2a4', 7, NULL, NULL, NULL, N'28', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (761, 1223, N'8aca3e8e-7655-45d1-9598-a715dd29f2a4', 8, NULL, NULL, NULL, N'30', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (762, 1223, N'8aca3e8e-7655-45d1-9598-a715dd29f2a4', 9, NULL, NULL, NULL, N'1358', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (763, 1223, N'8aca3e8e-7655-45d1-9598-a715dd29f2a4', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (764, 1224, N'5d790c2e-ccb2-4105-a036-cdeda14e893b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1149/sprite_prev.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (765, 1224, N'5d790c2e-ccb2-4105-a036-cdeda14e893b', 7, NULL, NULL, NULL, N'27', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (766, 1224, N'5d790c2e-ccb2-4105-a036-cdeda14e893b', 8, NULL, NULL, NULL, N'30', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (767, 1224, N'5d790c2e-ccb2-4105-a036-cdeda14e893b', 9, NULL, NULL, NULL, N'1376', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (768, 1224, N'5d790c2e-ccb2-4105-a036-cdeda14e893b', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (769, 1225, N'7cf8d5ca-3df5-42ed-87f2-8f033e77c125', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1150/sprite_x.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (770, 1225, N'7cf8d5ca-3df5-42ed-87f2-8f033e77c125', 7, NULL, NULL, NULL, N'130', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (771, 1225, N'7cf8d5ca-3df5-42ed-87f2-8f033e77c125', 8, NULL, NULL, NULL, N'47', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (772, 1225, N'7cf8d5ca-3df5-42ed-87f2-8f033e77c125', 9, NULL, NULL, NULL, N'1097', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (773, 1225, N'7cf8d5ca-3df5-42ed-87f2-8f033e77c125', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (774, 1226, N'67d3242b-b502-4ea7-b3c8-bb53a0f580aa', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1151/sprite_y.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (775, 1226, N'67d3242b-b502-4ea7-b3c8-bb53a0f580aa', 7, NULL, NULL, NULL, N'61', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (776, 1226, N'67d3242b-b502-4ea7-b3c8-bb53a0f580aa', 8, NULL, NULL, NULL, N'130', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (777, 1226, N'67d3242b-b502-4ea7-b3c8-bb53a0f580aa', 9, NULL, NULL, NULL, N'1162', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (778, 1226, N'67d3242b-b502-4ea7-b3c8-bb53a0f580aa', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (779, 1227, N'666516ef-8157-4d55-b99d-244ec4635368', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (780, 1228, N'2025338c-e384-483b-9a16-510ca7467e61', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1152/btnnext.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (781, 1228, N'2025338c-e384-483b-9a16-510ca7467e61', 7, NULL, NULL, NULL, N'57', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (782, 1228, N'2025338c-e384-483b-9a16-510ca7467e61', 8, NULL, NULL, NULL, N'47', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (783, 1228, N'2025338c-e384-483b-9a16-510ca7467e61', 9, NULL, NULL, NULL, N'845', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (784, 1228, N'2025338c-e384-483b-9a16-510ca7467e61', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (785, 1229, N'e5eaf8f9-7328-4012-8a72-da61f100f9bf', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1153/btnprevious.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (786, 1229, N'e5eaf8f9-7328-4012-8a72-da61f100f9bf', 7, NULL, NULL, NULL, N'57', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (787, 1229, N'e5eaf8f9-7328-4012-8a72-da61f100f9bf', 8, NULL, NULL, NULL, N'47', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (788, 1229, N'e5eaf8f9-7328-4012-8a72-da61f100f9bf', 9, NULL, NULL, NULL, N'828', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (789, 1229, N'e5eaf8f9-7328-4012-8a72-da61f100f9bf', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (790, 1230, N'f201c1f9-e7a6-4a76-a025-fd3678f8efd4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1154/contentpatternbottom.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (791, 1230, N'f201c1f9-e7a6-4a76-a025-fd3678f8efd4', 7, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (792, 1230, N'f201c1f9-e7a6-4a76-a025-fd3678f8efd4', 8, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (793, 1230, N'f201c1f9-e7a6-4a76-a025-fd3678f8efd4', 9, NULL, NULL, NULL, N'142', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (794, 1230, N'f201c1f9-e7a6-4a76-a025-fd3678f8efd4', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (795, 1231, N'5eb7447a-ccd3-42ad-be8c-bf6491ce61c0', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1155/contentpatternleft.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (796, 1231, N'5eb7447a-ccd3-42ad-be8c-bf6491ce61c0', 7, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (797, 1231, N'5eb7447a-ccd3-42ad-be8c-bf6491ce61c0', 8, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (798, 1231, N'5eb7447a-ccd3-42ad-be8c-bf6491ce61c0', 9, NULL, NULL, NULL, N'137', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (799, 1231, N'5eb7447a-ccd3-42ad-be8c-bf6491ce61c0', 10, NULL, NULL, NULL, N'png', NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (800, 1232, N'6d7e1dd8-7762-4673-a9f7-8461e2409719', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1156/contentpatternright.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (801, 1232, N'6d7e1dd8-7762-4673-a9f7-8461e2409719', 7, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (802, 1232, N'6d7e1dd8-7762-4673-a9f7-8461e2409719', 8, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (803, 1232, N'6d7e1dd8-7762-4673-a9f7-8461e2409719', 9, NULL, NULL, NULL, N'136', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (804, 1232, N'6d7e1dd8-7762-4673-a9f7-8461e2409719', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (805, 1233, N'66013f3e-f449-4c16-b4a4-d60db7c2c45d', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1157/contentpatterntop.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (806, 1233, N'66013f3e-f449-4c16-b4a4-d60db7c2c45d', 7, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (807, 1233, N'66013f3e-f449-4c16-b4a4-d60db7c2c45d', 8, NULL, NULL, NULL, N'20', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (808, 1233, N'66013f3e-f449-4c16-b4a4-d60db7c2c45d', 9, NULL, NULL, NULL, N'142', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (809, 1233, N'66013f3e-f449-4c16-b4a4-d60db7c2c45d', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (810, 1234, N'2c3ed6f2-f266-42cf-9815-a0b396c94079', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1158/default_thumbnail.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (811, 1234, N'2c3ed6f2-f266-42cf-9815-a0b396c94079', 7, NULL, NULL, NULL, N'50', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (812, 1234, N'2c3ed6f2-f266-42cf-9815-a0b396c94079', 8, NULL, NULL, NULL, N'33', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (813, 1234, N'2c3ed6f2-f266-42cf-9815-a0b396c94079', 9, NULL, NULL, NULL, N'227', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (814, 1234, N'2c3ed6f2-f266-42cf-9815-a0b396c94079', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (815, 1235, N'321a0e4e-43c7-4fbf-96b6-5efd2e365554', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1159/loader.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (816, 1235, N'321a0e4e-43c7-4fbf-96b6-5efd2e365554', 7, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (817, 1235, N'321a0e4e-43c7-4fbf-96b6-5efd2e365554', 8, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (818, 1235, N'321a0e4e-43c7-4fbf-96b6-5efd2e365554', 9, NULL, NULL, NULL, N'2545', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (819, 1235, N'321a0e4e-43c7-4fbf-96b6-5efd2e365554', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (820, 1236, N'cf3f0b58-f2f6-479e-9b79-dade4259a42b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1160/sprite.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (821, 1236, N'cf3f0b58-f2f6-479e-9b79-dade4259a42b', 7, NULL, NULL, NULL, N'130', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (822, 1236, N'cf3f0b58-f2f6-479e-9b79-dade4259a42b', 8, NULL, NULL, NULL, N'147', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (823, 1236, N'cf3f0b58-f2f6-479e-9b79-dade4259a42b', 9, NULL, NULL, NULL, N'4227', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (824, 1236, N'cf3f0b58-f2f6-479e-9b79-dade4259a42b', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (825, 1237, N'6f6fca52-0c52-43f1-9cf1-fa453b1af1d0', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (826, 1238, N'16edb69d-e364-4cf7-9924-bae390cbe080', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1161/btnnext.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (827, 1238, N'16edb69d-e364-4cf7-9924-bae390cbe080', 7, NULL, NULL, NULL, N'61', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (828, 1238, N'16edb69d-e364-4cf7-9924-bae390cbe080', 8, NULL, NULL, NULL, N'22', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (829, 1238, N'16edb69d-e364-4cf7-9924-bae390cbe080', 9, NULL, NULL, NULL, N'1411', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (830, 1238, N'16edb69d-e364-4cf7-9924-bae390cbe080', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (831, 1239, N'583a5f3f-c79b-4327-ba53-caa8a0f06d32', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1162/btnprevious.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (832, 1239, N'583a5f3f-c79b-4327-ba53-caa8a0f06d32', 7, NULL, NULL, NULL, N'61', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (833, 1239, N'583a5f3f-c79b-4327-ba53-caa8a0f06d32', 8, NULL, NULL, NULL, N'22', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (834, 1239, N'583a5f3f-c79b-4327-ba53-caa8a0f06d32', 9, NULL, NULL, NULL, N'1442', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (835, 1239, N'583a5f3f-c79b-4327-ba53-caa8a0f06d32', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (836, 1240, N'fe8a4f7d-aac3-4e2b-b7ca-239e1847ffd6', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1163/loader.gif", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (837, 1240, N'fe8a4f7d-aac3-4e2b-b7ca-239e1847ffd6', 7, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (838, 1240, N'fe8a4f7d-aac3-4e2b-b7ca-239e1847ffd6', 8, NULL, NULL, NULL, N'24', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (839, 1240, N'fe8a4f7d-aac3-4e2b-b7ca-239e1847ffd6', 9, NULL, NULL, NULL, N'2545', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (840, 1240, N'fe8a4f7d-aac3-4e2b-b7ca-239e1847ffd6', 10, NULL, NULL, NULL, N'gif', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (841, 1241, N'5bfefc5a-8abf-4879-bb81-fcf03de339da', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1164/sprite.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (842, 1241, N'5bfefc5a-8abf-4879-bb81-fcf03de339da', 7, NULL, NULL, NULL, N'130', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (843, 1241, N'5bfefc5a-8abf-4879-bb81-fcf03de339da', 8, NULL, NULL, NULL, N'119', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (844, 1241, N'5bfefc5a-8abf-4879-bb81-fcf03de339da', 9, NULL, NULL, NULL, N'4099', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (845, 1241, N'5bfefc5a-8abf-4879-bb81-fcf03de339da', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (846, 1242, N'7f13ab0c-0047-4b5f-b9ab-5085e0d969ad', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (847, 1243, N'773182d2-44f0-465c-9bb6-9c88786b828b', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1165/btnnext.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (848, 1243, N'773182d2-44f0-465c-9bb6-9c88786b828b', 7, NULL, NULL, NULL, N'61', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (849, 1243, N'773182d2-44f0-465c-9bb6-9c88786b828b', 8, NULL, NULL, NULL, N'22', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (850, 1243, N'773182d2-44f0-465c-9bb6-9c88786b828b', 9, NULL, NULL, NULL, N'1411', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (851, 1243, N'773182d2-44f0-465c-9bb6-9c88786b828b', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (852, 1244, N'17b3c4ec-474f-41dc-b4ef-862c77d52a89', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1166/btnprevious.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (853, 1244, N'17b3c4ec-474f-41dc-b4ef-862c77d52a89', 7, NULL, NULL, NULL, N'61', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (854, 1244, N'17b3c4ec-474f-41dc-b4ef-862c77d52a89', 8, NULL, NULL, NULL, N'22', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (855, 1244, N'17b3c4ec-474f-41dc-b4ef-862c77d52a89', 9, NULL, NULL, NULL, N'1442', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (856, 1244, N'17b3c4ec-474f-41dc-b4ef-862c77d52a89', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (857, 1245, N'7eef4147-a029-4450-8a67-d0e661f39a61', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1167/sprite.png", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (858, 1245, N'7eef4147-a029-4450-8a67-d0e661f39a61', 7, NULL, NULL, NULL, N'76', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (859, 1245, N'7eef4147-a029-4450-8a67-d0e661f39a61', 8, NULL, NULL, NULL, N'119', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (860, 1245, N'7eef4147-a029-4450-8a67-d0e661f39a61', 9, NULL, NULL, NULL, N'3507', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (861, 1245, N'7eef4147-a029-4450-8a67-d0e661f39a61', 10, NULL, NULL, NULL, N'png', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (862, 1246, N'b3b040e3-a086-44f1-b2f6-bfe9808182db', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (863, 1247, N'40e020d3-3aa4-4e3d-a8de-a7afdb1393b4', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1168/1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (864, 1247, N'40e020d3-3aa4-4e3d-a8de-a7afdb1393b4', 7, NULL, NULL, NULL, N'1170', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (865, 1247, N'40e020d3-3aa4-4e3d-a8de-a7afdb1393b4', 8, NULL, NULL, NULL, N'500', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (866, 1247, N'40e020d3-3aa4-4e3d-a8de-a7afdb1393b4', 9, NULL, NULL, NULL, N'367491', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (867, 1247, N'40e020d3-3aa4-4e3d-a8de-a7afdb1393b4', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (868, 1248, N'a719e6ae-e808-465b-b732-0aed15157f36', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1169/graph-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (869, 1248, N'a719e6ae-e808-465b-b732-0aed15157f36', 7, NULL, NULL, NULL, N'1170', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (870, 1248, N'a719e6ae-e808-465b-b732-0aed15157f36', 8, NULL, NULL, NULL, N'525', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (871, 1248, N'a719e6ae-e808-465b-b732-0aed15157f36', 9, NULL, NULL, NULL, N'132697', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (872, 1248, N'a719e6ae-e808-465b-b732-0aed15157f36', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (873, 1249, N'ba4ad85d-5a04-4e61-ac23-6924e85b1c4e', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1170/graph-2.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (874, 1249, N'ba4ad85d-5a04-4e61-ac23-6924e85b1c4e', 7, NULL, NULL, NULL, N'1170', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (875, 1249, N'ba4ad85d-5a04-4e61-ac23-6924e85b1c4e', 8, NULL, NULL, NULL, N'505', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (876, 1249, N'ba4ad85d-5a04-4e61-ac23-6924e85b1c4e', 9, NULL, NULL, NULL, N'75203', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (877, 1249, N'ba4ad85d-5a04-4e61-ac23-6924e85b1c4e', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (878, 1250, N'cdbae0ec-d24a-433e-8118-7b8e34d0e83f', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1171/project-analysis-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (879, 1250, N'cdbae0ec-d24a-433e-8118-7b8e34d0e83f', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (880, 1250, N'cdbae0ec-d24a-433e-8118-7b8e34d0e83f', 8, NULL, NULL, NULL, N'430', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (881, 1250, N'cdbae0ec-d24a-433e-8118-7b8e34d0e83f', 9, NULL, NULL, NULL, N'285293', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (882, 1250, N'cdbae0ec-d24a-433e-8118-7b8e34d0e83f', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (883, 1251, N'1ca89ca0-4ea1-4fee-bd03-a38cb3532347', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1172/project-result-bg.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (884, 1251, N'1ca89ca0-4ea1-4fee-bd03-a38cb3532347', 7, NULL, NULL, NULL, N'1920', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (885, 1251, N'1ca89ca0-4ea1-4fee-bd03-a38cb3532347', 8, NULL, NULL, NULL, N'405', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (886, 1251, N'1ca89ca0-4ea1-4fee-bd03-a38cb3532347', 9, NULL, NULL, NULL, N'221279', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (887, 1251, N'1ca89ca0-4ea1-4fee-bd03-a38cb3532347', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (888, 1252, N'98e02253-e25f-4f5d-8353-a8494a516cd5', 27, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (889, 1253, N'fdc52cbb-ecbe-4405-bfaa-ed3f65a9ad0e', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1173/1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (890, 1253, N'fdc52cbb-ecbe-4405-bfaa-ed3f65a9ad0e', 7, NULL, NULL, NULL, N'370', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (891, 1253, N'fdc52cbb-ecbe-4405-bfaa-ed3f65a9ad0e', 8, NULL, NULL, NULL, N'488', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (892, 1253, N'fdc52cbb-ecbe-4405-bfaa-ed3f65a9ad0e', 9, NULL, NULL, NULL, N'111251', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (893, 1253, N'fdc52cbb-ecbe-4405-bfaa-ed3f65a9ad0e', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (894, 1254, N'74baec66-46d6-4f8d-a4a0-8c7c0d5ca58a', 6, NULL, NULL, NULL, NULL, N'{"src": "/media/1174/graph-1.jpg", "crops": []}')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (895, 1254, N'74baec66-46d6-4f8d-a4a0-8c7c0d5ca58a', 7, NULL, NULL, NULL, N'371', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (896, 1254, N'74baec66-46d6-4f8d-a4a0-8c7c0d5ca58a', 8, NULL, NULL, NULL, N'362', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (897, 1254, N'74baec66-46d6-4f8d-a4a0-8c7c0d5ca58a', 9, NULL, NULL, NULL, N'61312', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (898, 1254, N'74baec66-46d6-4f8d-a4a0-8c7c0d5ca58a', 10, NULL, NULL, NULL, N'jpg', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (920, 1271, N'6f5a93a0-2d90-4565-8126-8fe03f3866f6', 47, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (921, 1278, N'7806311c-efef-4f70-a028-76bda3c433e6', 49, NULL, NULL, NULL, N'Ventures', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (922, 1278, N'7806311c-efef-4f70-a028-76bda3c433e6', 50, NULL, NULL, NULL, NULL, N'Over 24 years experience and knowledge international standards,<br> technologicaly changes and industrial systems.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (923, 1278, N'7806311c-efef-4f70-a028-76bda3c433e6', 51, NULL, NULL, NULL, NULL, N'umb://media/627ddaafc3fb4073b7b5fb5e3cedc990')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (924, 1278, N'7806311c-efef-4f70-a028-76bda3c433e6', 48, NULL, NULL, NULL, N'Warm welcome to', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (925, 1271, N'7c889c25-7b4f-41db-84d5-145faad2635d', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (926, 1279, N'1f92fe87-e42d-46ad-b2c9-20e2ea9436c9', 49, NULL, NULL, NULL, N'Success', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (927, 1279, N'1f92fe87-e42d-46ad-b2c9-20e2ea9436c9', 50, NULL, NULL, NULL, NULL, N'Over 24 years experience knowledge international standards technologicaly changes and industrial systems.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (928, 1279, N'1f92fe87-e42d-46ad-b2c9-20e2ea9436c9', 51, NULL, NULL, NULL, NULL, N'umb://media/a127a0aaa19f47e896483a0bfc93e5d5')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (929, 1279, N'1f92fe87-e42d-46ad-b2c9-20e2ea9436c9', 48, NULL, NULL, NULL, N'The fastest way to achive', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (930, 1278, N'46d73cc2-5e59-4135-b127-415f8fa16076', 49, NULL, NULL, NULL, N'Ventures', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (931, 1278, N'46d73cc2-5e59-4135-b127-415f8fa16076', 50, NULL, NULL, NULL, NULL, N'Over 24 years experience and knowledge international standards,technologicaly changes and industrial systems.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (932, 1278, N'46d73cc2-5e59-4135-b127-415f8fa16076', 51, NULL, NULL, NULL, NULL, N'umb://media/627ddaafc3fb4073b7b5fb5e3cedc990')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (933, 1278, N'46d73cc2-5e59-4135-b127-415f8fa16076', 48, NULL, NULL, NULL, N'Warm welcome to', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (934, 1280, N'1099e84a-f0a5-4f20-a1db-df95f4060b26', 49, NULL, NULL, NULL, N'Investors', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (935, 1280, N'1099e84a-f0a5-4f20-a1db-df95f4060b26', 50, NULL, NULL, NULL, NULL, N'Over 24 years experience and knowledge international standards technologicaly changes and industrial systems.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (936, 1280, N'1099e84a-f0a5-4f20-a1db-df95f4060b26', 51, NULL, NULL, NULL, NULL, N'umb://media/2109fcf6c83d4f309f3a7f9ee2d23437')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (937, 1280, N'1099e84a-f0a5-4f20-a1db-df95f4060b26', 48, NULL, NULL, NULL, N'Trading solution for ', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (938, 1271, N'ca9323aa-3a94-4682-946a-75a4a7ffc9de', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (942, 1271, N'dd95cc3d-db46-447c-9f17-9c3c0b374ace', 61, NULL, NULL, NULL, NULL, N'umb://document/e53b83973a0d4d339bd3a3feb18e9515')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (943, 1271, N'dd95cc3d-db46-447c-9f17-9c3c0b374ace', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (944, 1271, N'dd95cc3d-db46-447c-9f17-9c3c0b374ace', 62, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (945, 1295, N'68ae0f8b-8e47-46f6-b8b3-8ed6317030a6', 63, NULL, NULL, NULL, N'Alen', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (946, 1295, N'68ae0f8b-8e47-46f6-b8b3-8ed6317030a6', 60, NULL, NULL, NULL, N'Newyork', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (947, 1295, N'68ae0f8b-8e47-46f6-b8b3-8ed6317030a6', 59, NULL, NULL, NULL, NULL, N'umb://media/7db98dc3da554526bb2255d6e4b586c3')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (948, 1295, N'68ae0f8b-8e47-46f6-b8b3-8ed6317030a6', 58, NULL, NULL, NULL, NULL, N'These guys are just the coolest company ever! They were aware of our transported for road and tail and complex.performance on our project was extremely successful the great explorer of the truth, the master-builder  happiness avoids pleasure itself')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (949, 1271, N'b92d1242-32c3-4410-af21-37db3cee9ee1', 66, NULL, NULL, NULL, NULL, N'We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (950, 1271, N'b92d1242-32c3-4410-af21-37db3cee9ee1', 61, NULL, NULL, NULL, NULL, N'umb://document/e53b83973a0d4d339bd3a3feb18e9515')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (951, 1271, N'b92d1242-32c3-4410-af21-37db3cee9ee1', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (952, 1271, N'b92d1242-32c3-4410-af21-37db3cee9ee1', 64, NULL, NULL, NULL, N'About Our Company', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (953, 1271, N'b92d1242-32c3-4410-af21-37db3cee9ee1', 62, NULL, NULL, NULL, NULL, N'umb://document/247d941baded4737ad8aa99150b3556b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (954, 1271, N'b92d1242-32c3-4410-af21-37db3cee9ee1', 65, NULL, NULL, NULL, N'Since 2000, we provide best service for our valuable clients.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (958, 1271, N'677d5c85-c018-45a1-a5f7-5b611146c2b5', 66, NULL, NULL, NULL, NULL, N'We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (959, 1271, N'677d5c85-c018-45a1-a5f7-5b611146c2b5', 61, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (960, 1271, N'677d5c85-c018-45a1-a5f7-5b611146c2b5', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (961, 1271, N'677d5c85-c018-45a1-a5f7-5b611146c2b5', 64, NULL, NULL, NULL, N'About Our Company', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (962, 1271, N'677d5c85-c018-45a1-a5f7-5b611146c2b5', 62, NULL, NULL, NULL, NULL, N'umb://document/247d941baded4737ad8aa99150b3556b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (963, 1271, N'677d5c85-c018-45a1-a5f7-5b611146c2b5', 65, NULL, NULL, NULL, N'Since 2000, we provide best service for our valuable clients.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (967, 1271, N'93033755-bb77-49d1-94e5-fe6ab56ba6bf', 66, NULL, NULL, NULL, NULL, N'We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (968, 1271, N'93033755-bb77-49d1-94e5-fe6ab56ba6bf', 61, NULL, NULL, NULL, NULL, N'umb://document/074bfaeec907470ab0a11f600484c12d')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (969, 1271, N'93033755-bb77-49d1-94e5-fe6ab56ba6bf', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (970, 1271, N'93033755-bb77-49d1-94e5-fe6ab56ba6bf', 64, NULL, NULL, NULL, N'About Our Company', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (971, 1271, N'93033755-bb77-49d1-94e5-fe6ab56ba6bf', 62, NULL, NULL, NULL, NULL, N'umb://document/247d941baded4737ad8aa99150b3556b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (972, 1271, N'93033755-bb77-49d1-94e5-fe6ab56ba6bf', 65, NULL, NULL, NULL, N'Since 2000, we provide best service for our valuable clients.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (976, 1300, N'ba99b285-e7e6-45c7-a746-9b0c7d940644', 71, NULL, NULL, NULL, NULL, N'We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (977, 1300, N'ba99b285-e7e6-45c7-a746-9b0c7d940644', 70, NULL, NULL, NULL, N'Trading solution for ', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (978, 1300, N'ba99b285-e7e6-45c7-a746-9b0c7d940644', 72, NULL, NULL, NULL, NULL, N'umb://media/bf1f68aedd054a41ae461cc586b6f234')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (979, 1271, N'f55fe206-571f-47a1-97bf-c79a42eac73c', 66, NULL, NULL, NULL, NULL, N'We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (980, 1271, N'f55fe206-571f-47a1-97bf-c79a42eac73c', 61, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (981, 1271, N'f55fe206-571f-47a1-97bf-c79a42eac73c', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (982, 1271, N'f55fe206-571f-47a1-97bf-c79a42eac73c', 64, NULL, NULL, NULL, N'About Our Company', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (983, 1271, N'f55fe206-571f-47a1-97bf-c79a42eac73c', 62, NULL, NULL, NULL, NULL, N'umb://document/247d941baded4737ad8aa99150b3556b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (984, 1271, N'f55fe206-571f-47a1-97bf-c79a42eac73c', 65, NULL, NULL, NULL, N'Since 2000, we provide best service for our valuable clients.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (985, 1271, N'e4693af8-f666-4d73-8512-cb89bd07f6b1', 66, NULL, NULL, NULL, NULL, N'We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (986, 1271, N'e4693af8-f666-4d73-8512-cb89bd07f6b1', 61, NULL, NULL, NULL, NULL, N'umb://document/8f6629d8a58644f8a05e56e96a401f6b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (987, 1271, N'e4693af8-f666-4d73-8512-cb89bd07f6b1', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (988, 1271, N'e4693af8-f666-4d73-8512-cb89bd07f6b1', 64, NULL, NULL, NULL, N'About Our Company', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (989, 1271, N'e4693af8-f666-4d73-8512-cb89bd07f6b1', 62, NULL, NULL, NULL, NULL, N'umb://document/247d941baded4737ad8aa99150b3556b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (990, 1271, N'e4693af8-f666-4d73-8512-cb89bd07f6b1', 65, NULL, NULL, NULL, N'Since 2000, we provide best service for our valuable clients.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (991, 1300, N'52898928-7f44-4b26-b16a-f03155e14393', 71, NULL, NULL, NULL, NULL, N'How this mistaken  denouncing pleasure and praising pain was born & we will give complete account of system.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (992, 1300, N'52898928-7f44-4b26-b16a-f03155e14393', 70, NULL, NULL, NULL, N'Trading solution for ', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (993, 1300, N'52898928-7f44-4b26-b16a-f03155e14393', 72, NULL, NULL, NULL, NULL, N'umb://media/bf1f68aedd054a41ae461cc586b6f234')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (994, 1271, N'79f36816-db96-44ad-8f06-1fe083c701e8', 66, NULL, NULL, NULL, NULL, N'We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain ravi.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (995, 1271, N'79f36816-db96-44ad-8f06-1fe083c701e8', 61, NULL, NULL, NULL, NULL, N'umb://document/8f6629d8a58644f8a05e56e96a401f6b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (996, 1271, N'79f36816-db96-44ad-8f06-1fe083c701e8', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (997, 1271, N'79f36816-db96-44ad-8f06-1fe083c701e8', 64, NULL, NULL, NULL, N'About Our Company Ravi', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (998, 1271, N'79f36816-db96-44ad-8f06-1fe083c701e8', 62, NULL, NULL, NULL, NULL, N'umb://document/247d941baded4737ad8aa99150b3556b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (999, 1271, N'79f36816-db96-44ad-8f06-1fe083c701e8', 65, NULL, NULL, NULL, N'Since 2000, we provide best service for our valuable clients Ravi.', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1000, 1271, N'090c7559-9ff6-4516-945d-5ecf2b95a224', 66, NULL, NULL, NULL, NULL, N'We have built enviable reputation in consumer goods, heavy industry, high tech, manufacturing, medical, vehicle, transportation seds works sectors. multi disciplinary team of engineering & experts, who loves who pursues desires to obtains pains  itself explain.')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1001, 1271, N'090c7559-9ff6-4516-945d-5ecf2b95a224', 61, NULL, NULL, NULL, NULL, N'umb://document/8f6629d8a58644f8a05e56e96a401f6b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1002, 1271, N'090c7559-9ff6-4516-945d-5ecf2b95a224', 47, NULL, NULL, NULL, NULL, N'umb://document/12a24e4ac5154aef923b82e996cfedf2,umb://document/2eb3c6d78b1645cea44b30a3154514ab,umb://document/3eb698d76f8f47aca04e0e74aee564ee')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1003, 1271, N'090c7559-9ff6-4516-945d-5ecf2b95a224', 64, NULL, NULL, NULL, N'About Our Company ', NULL)
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1004, 1271, N'090c7559-9ff6-4516-945d-5ecf2b95a224', 62, NULL, NULL, NULL, NULL, N'umb://document/247d941baded4737ad8aa99150b3556b')
INSERT [dbo].[cmsPropertyData] ([id], [contentNodeId], [versionId], [propertytypeid], [dataInt], [dataDecimal], [dataDate], [dataNvarchar], [dataNtext]) VALUES (1005, 1271, N'090c7559-9ff6-4516-945d-5ecf2b95a224', 65, NULL, NULL, NULL, N'Since 2000, we provide best service for our valuable clients.', NULL)
SET IDENTITY_INSERT [dbo].[cmsPropertyData] OFF
SET IDENTITY_INSERT [dbo].[cmsPropertyType] ON 

INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (6, 1043, 1032, 3, N'umbracoFile', N'Upload image', 0, 0, NULL, NULL, N'00000006-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (7, -92, 1032, 3, N'umbracoWidth', N'Width', 0, 0, NULL, NULL, N'00000007-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (8, -92, 1032, 3, N'umbracoHeight', N'Height', 0, 0, NULL, NULL, N'00000008-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (9, -92, 1032, 3, N'umbracoBytes', N'Size', 0, 0, NULL, NULL, N'00000009-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (10, -92, 1032, 3, N'umbracoExtension', N'Type', 0, 0, NULL, NULL, N'0000000a-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (24, -90, 1033, 4, N'umbracoFile', N'Upload file', 0, 0, NULL, NULL, N'00000018-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (25, -92, 1033, 4, N'umbracoExtension', N'Type', 0, 0, NULL, NULL, N'00000019-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (26, -92, 1033, 4, N'umbracoBytes', N'Size', 0, 0, NULL, NULL, N'0000001a-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (27, -96, 1031, 5, N'contents', N'Contents:', 0, 0, NULL, NULL, N'0000001b-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (28, -89, 1044, 11, N'umbracoMemberComments', N'Comments', 0, 0, NULL, NULL, N'0000001c-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (29, -92, 1044, 11, N'umbracoMemberFailedPasswordAttempts', N'Failed Password Attempts', 1, 0, NULL, NULL, N'0000001d-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (30, -49, 1044, 11, N'umbracoMemberApproved', N'Is Approved', 2, 0, NULL, NULL, N'0000001e-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (31, -49, 1044, 11, N'umbracoMemberLockedOut', N'Is Locked Out', 3, 0, NULL, NULL, N'0000001f-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (32, -92, 1044, 11, N'umbracoMemberLastLockoutDate', N'Last Lockout Date', 4, 0, NULL, NULL, N'00000020-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (33, -92, 1044, 11, N'umbracoMemberLastLogin', N'Last Login Date', 5, 0, NULL, NULL, N'00000021-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (34, -92, 1044, 11, N'umbracoMemberLastPasswordChangeDate', N'Last Password Change Date', 6, 0, NULL, NULL, N'00000022-0000-0000-0000-000000000000')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (35, -92, 1044, NULL, N'umbracoMemberPasswordRetrievalAnswer', N'Password Answer', 0, 0, NULL, NULL, N'6770705b-e605-4699-bc3b-10e032982f5d')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (36, -92, 1044, NULL, N'umbracoMemberPasswordRetrievalQuestion', N'Password Question', 1, 0, NULL, NULL, N'864c415e-1928-403d-bc87-ae82b6852a41')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (47, 1268, 1270, 16, N'featuredSlides', N'FeaturedSlides', 0, 0, NULL, NULL, N'5f869a07-6566-45a0-bc69-2c6555e2108c')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (48, 1274, 1277, 17, N'slideHeader', N'SlideHeader', 0, 1, NULL, NULL, N'b937e1a7-d2dd-4f62-8e52-cf2eeae19f38')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (49, 1275, 1277, 17, N'slideTitle', N'SlideTitle', 1, 1, NULL, NULL, N'e1a94bec-844e-48fe-b6a1-5208febfe204')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (50, -89, 1277, 17, N'slideText', N'SlideText', 2, 1, NULL, NULL, N'66fc4bef-79aa-4efe-86ce-590022d9ee97')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (51, 1048, 1277, 17, N'slideImage', N'SlideImage', 3, 1, NULL, NULL, N'5ce2e17b-6de6-4f32-aa1e-893552120db0')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (58, -89, 1288, 20, N'testimonialText', N'TestimonialText', 0, 1, NULL, NULL, N'c5f2aa3e-6f7c-413a-ba4b-e10ed5a268e1')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (59, 1048, 1288, 20, N'customerImage', N'CustomerImage', 3, 1, NULL, NULL, N'6ebfe53b-2389-4794-bda3-d75bcd65c568')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (60, 1287, 1288, 20, N'customerCity', N'CustomerCity', 2, 1, NULL, NULL, N'd853ee44-6028-4181-ba5b-c3d46ea4c659')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (61, 1289, 1270, 16, N'featuredServices', N'FeaturedServices', 1, 1, NULL, NULL, N'13d1ce1b-8ee9-430f-89ab-0efc1842daf6')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (62, 1290, 1270, 16, N'featuredTestimonial', N'FeaturedTestimonial', 5, 1, NULL, NULL, N'91039d25-d6cf-487e-90c0-cf2c2508d2cb')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (63, 1292, 1288, 20, N'customerName', N'CustomerName', 1, 1, NULL, NULL, N'82d4f9bb-a8cc-4ef3-82de-95f8d960ca95')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (64, 1293, 1270, 16, N'aboutUsHeader', N'AboutUsHeader', 2, 1, NULL, NULL, N'05f92d0e-3b66-45a6-a2be-b82ccc3769bb')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (65, 1294, 1270, 16, N'aboutUsTitle', N'AboutUsTitle', 3, 1, NULL, NULL, N'5d699387-b07c-451b-b7af-ecf6446d8df6')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (66, -89, 1270, 16, N'aboutUsText', N'AboutUsText', 4, 1, NULL, NULL, N'0ffd8dd0-8e00-470f-acd6-04b269ce6177')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (70, 1298, 1299, 22, N'serviceTitle', N'ServiceTitle', 0, 1, NULL, NULL, N'2e18ba24-8ef2-4eae-9c6d-5d1afbe41b80')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (71, -89, 1299, 22, N'serviceText', N'ServiceText', 1, 1, NULL, NULL, N'a223dd8a-81bb-4f61-8c0f-2e48b362edc8')
INSERT [dbo].[cmsPropertyType] ([id], [dataTypeId], [contentTypeId], [propertyTypeGroupId], [Alias], [Name], [sortOrder], [mandatory], [validationRegExp], [Description], [UniqueID]) VALUES (72, 1048, 1299, 22, N'serviceImage', N'ServiceImage', 2, 1, NULL, NULL, N'd678b9a0-301c-4a41-b6c5-e020cb635a86')
SET IDENTITY_INSERT [dbo].[cmsPropertyType] OFF
SET IDENTITY_INSERT [dbo].[cmsPropertyTypeGroup] ON 

INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (3, 1032, N'Image', 1, N'79ed4d07-254a-42cf-8fa9-ebe1c116a596')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (4, 1033, N'File', 1, N'50899f9c-023a-4466-b623-aba9049885fe')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (5, 1031, N'Contents', 1, N'79995fa2-63ee-453c-a29b-2e66f324cdbe')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (11, 1044, N'Membership', 1, N'0756729d-d665-46e3-b84a-37aceaa614f8')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (16, 1270, N'Slider', 0, N'a8a4ce85-7909-49e0-be64-8ba96a23c9a8')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (17, 1277, N'Slide', 0, N'b2c671d9-6969-4480-b7a0-7b85c0a34d36')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (20, 1288, N'Testimonial', 0, N'2d198d1f-f51d-48f8-a30b-59acd721cd30')
INSERT [dbo].[cmsPropertyTypeGroup] ([id], [contenttypeNodeId], [text], [sortorder], [uniqueID]) VALUES (22, 1299, N'HomeService', 0, N'aaba3401-c07d-47e0-b690-b8e5582560d5')
SET IDENTITY_INSERT [dbo].[cmsPropertyTypeGroup] OFF
SET IDENTITY_INSERT [dbo].[cmsTaskType] ON 

INSERT [dbo].[cmsTaskType] ([id], [alias]) VALUES (1, N'toTranslate')
SET IDENTITY_INSERT [dbo].[cmsTaskType] OFF
SET IDENTITY_INSERT [dbo].[cmsTemplate] ON 

INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (1, 1051, N'Master', N'@inherits UmbracoTemplatePage
@{
    Layout = null;
}
<!DOCTYPE html>
<html lang="en">

<!-- Mirrored from steelthemes.com/demo/html/ventures-preview/ by HTTrack Website Copier/3.x [XR&CO''2014], Wed, 12 Sep 2018 18:02:14 GMT -->
<head>
    <meta charset="UTF-8">
    <title>Home || Ventures || Responsive HTML 5 Template</title>

    <!-- responsive meta -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- For IE -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <!-- master stylesheet -->
    <link rel="stylesheet" href="css/style.css">
    <!-- Responsive stylesheet -->
    <link rel="stylesheet" href="css/responsive.css">
    <!--Color Switcher Mockup-->
    <link rel="stylesheet" href="css/color-switcher-design.css">
    <!--Color Themes-->
    <link rel="stylesheet" href="css/color-themes/default-theme.css" id="theme-color-file">
    <!-- Favicon -->
    <link rel="apple-touch-icon" sizes="180x180" href="images/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" href="images/favicon/favicon-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="images/favicon/favicon-16x16.png" sizes="16x16">

    <!-- Fixing Internet Explorer-->
    <!--[if lt IE 9]>
        <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
        <script src="js/html5shiv.js"></script>
    <![endif]-->

</head>
<body>
    <div class="boxed_wrapper">

        <div class="preloader"></div>

        <!--Start Top bar area -->
        <section class="top-bar-area">
            <div class="container">
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12">
                        <div class="flex-box-three">
                            <div class="top-left">
                                <p>Welcome to world’s best consulting company!...</p>
                            </div>
                            <div class="state-box clearfix">
                                <div class="state-select-box float-left">
                                    <select class="selectmenu clearfix">
                                        <option value="1">California</option>
                                        <option value="2">Canada</option>
                                    </select>
                                    <div class="icon-holder">
                                        <span class="icon-globe"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--End Top bar area -->
        <!--Start header area-->
        <header class="header-area">
            <div class="container">
                <div class="row">
                    <div class="col-xl-12 col-lg-12 col-md-12">
                        <div class="inner-content clearfix">
                            <div class="header-left float-left">
                                <div class="logo">
                                    <a href="index-2.html">
                                        <img src="images/resources/logo.png" alt="Awesome Logo">
                                    </a>
                                </div>
                            </div>
                            <div class="header-right float-right">
                                <div class="header-social-info float-left">
                                    <div class="social-links-box">
                                        <p>Stay Connected:</p>
                                        <ul class="sociallinks-style-one">
                                            <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                            <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                            <li><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
                                            <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                            <li><a href="#"><i class="fa fa-skype" aria-hidden="true"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                                <ul class="header-contact-info float-left">
                                    <li class="single-info">
                                        <div class="icon-holder">
                                            <span class="icon-technology"></span>
                                        </div>
                                        <div class="text-holder">
                                            <span>+123-456-7890 & 23</span>
                                            <h4>Ventures@Supportyou.com</h4>
                                        </div>
                                    </li>
                                    <li class="single-info">
                                        <div class="icon-holder">
                                            <span class="icon-signs"></span>
                                        </div>
                                        <div class="text-holder">
                                            <span>13, Big Smart Street, 2nd Cross</span>
                                            <h4>Newyork, USA 1002</h4>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <!--End header area-->
        <!--Start mainmenu area-->
        <section class="mainmenu-area stricky">
            <div class="container">
                <div class="row">
                    <div class="col-xl-12">
                        <div class="innner-content clearfix">
                            <!--Start mainmenu-->
                            <nav class="main-menu clearfix float-left">
                                <div class="navbar-header clearfix">
                                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                        <span class="icon-bar"></span>
                                    </button>
                                </div>
                                <div class="navbar-collapse collapse clearfix">
                                    <ul class="navigation clearfix">
                                        <li class="current"><a href="index-2.html">Home</a></li>
                                        <li class="dropdown">
                                            <a href="about.html">About Us</a>
                                            <ul>
                                                <li><a href="about.html">About Company</a></li>
                                                <li><a href="team.html">Meet Our Team</a></li>
                                                <li><a href="faq.html">FAQ’s</a></li>
                                                <li><a href="testimonials.html">Testimonials</a></li>
                                                <li><a href="404.html">404 Page</a></li>
                                            </ul>
                                        </li>
                                        <li class="dropdown">
                                            <a href="services.html">Services</a>
                                            <ul>
                                                <li><a href="services.html">View All Services</a></li>
                                                <li><a href="service-single.html">Service Single</a></li>
                                            </ul>
                                        </li>
                                        <li class="dropdown">
                                            <a href="project.html">Cases</a>
                                            <ul>
                                                <li><a href="project.html">Case Default</a></li>
                                                <li><a href="project-v2.html">Cases With Text</a></li>
                                                <li><a href="project-v3.html">Cases Modern</a></li>
                                                <li><a href="project-single.html">Single Case</a></li>
                                            </ul>
                                        </li>
                                        <li class="dropdown">
                                            <a href="blog.html">Blog</a>
                                            <ul>
                                                <li><a href="blog.html">Blog Default</a></li>
                                                <li><a href="blog-grid.html">Blog Grid View</a></li>
                                                <li><a href="blog-large.html">Blog Large</a></li>
                                                <li><a href="blog-single.html">Blog Single Post</a></li>
                                            </ul>
                                        </li>
                                        <li class="dropdown">
                                            <a href="shop.html">Shop</a>
                                            <ul>
                                                <li><a href="shop.html">Shop Products</a></li>
                                                <li><a href="shop-single.html">Products Single</a></li>
                                                <li><a href="shopping-cart.html">Shopping Cart</a></li>
                                                <li><a href="checkout.html">Checkout</a></li>
                                                <li><a href="account.html">My Account</a></li>
                                            </ul>
                                        </li>
                                        <li><a href="contact.html">Contact</a></li>
                                    </ul>
                                </div>
                            </nav>
                            <!--End mainmenu-->
                            <!--Start mainmenu right box-->
                            <div class="mainmenu-right-box float-right">
                                <div class="button">
                                    <a href="#">Free Consultation</a>
                                </div>
                                <div class="outer-search-box">
                                    <div class="seach-toggle"><i class="fa fa-search"></i></div>
                                    <ul class="search-box">
                                        <li>
                                            <form method="post" action="http://steelthemes.com/demo/html/ventures-preview/index.html">
                                                <div class="form-group">
                                                    <input type="search" name="search" placeholder="Search Here" required="">
                                                    <button type="submit"><i class="fa fa-search"></i></button>
                                                </div>
                                            </form>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <!--End mainmenu right box-->
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--End mainmenu area-->
        @RenderBody()
        <!--Start footer area-->
        <footer class="footer-area">
            <div class="container inner-content">
                <div class="row">
                    <!--Start single footer widget-->
                    <div class="col-xl-4 col-lg-3 col-md-6 col-sm-12">
                        <div class="single-footer-widget">
                            <div class="our-info">
                                <div class="footer-logo">
                                    <a href="index-2.html">
                                        <img src="images/footer/footer-logo.png" alt="Awesome Logo">
                                    </a>
                                </div>
                                <div class="text">
                                    <p>Over 24 years experience and knowledge international standards, technologicaly changes and industrial systems, we are dedicated to provides seds the best and economical solutions to our valued customers.</p>
                                    <a href="#">read More</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End single footer widget-->
                    <!--Start single footer widget-->
                    <div class="col-xl-2 col-lg-3 col-md-6 col-sm-12">
                        <div class="single-footer-widget martop martop-50">
                            <div class="sec-title">
                                <h1 class="white-color">Usefull Links</h1>
                            </div>
                            <ul class="usefull-links">
                                <li><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>Financial Planning</a></li>
                                <li><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>Saving & Investing</a></li>
                                <li><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>Mortgage Advice</a></li>
                                <li><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>Retirement Plan</a></li>
                                <li><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>Market Research</a></li>
                                <li><a href="#"><i class="fa fa-angle-right" aria-hidden="true"></i>Debt & Borrowing</a></li>
                            </ul>
                        </div>
                    </div>
                    <!--End single footer widget-->
                    <!--Start single footer widget-->
                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                        <div class="single-footer-widget martop pdtop-50">
                            <div class="sec-title">
                                <h1 class="white-color">Latest News</h1>
                            </div>
                            <ul class="latest-post">
                                <li class="single-post">
                                    <div class="text-holder">
                                        <a class="post-title" href="#">A digital prescription for the<br> pharma industry.</a>
                                        <div class="post-info">
                                            <span>June 21, 2017</span>
                                        </div>
                                    </div>
                                </li>
                                <li class="single-post">
                                    <div class="text-holder">
                                        <a class="post-title" href="#">Retail banks wake up to digital<br> lending this year.</a>
                                        <div class="post-info">
                                            <span>April 14, 2017</span>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!--Start single footer widget-->
                    <!--Start single footer widget-->
                    <div class="col-xl-3 col-lg-3 col-md-6 col-sm-12">
                        <div class="single-footer-widget martop pdtop-50">
                            <div class="contact-info-box">
                                <div class="sec-title">
                                    <h1 class="white-color">Contact Details</h1>
                                </div>
                                <div class="contact-carousel">
                                    <!--Start single info box-->
                                    <div class="single-info-box">
                                        <div class="title-box">
                                            <h4>Head Quater</h4>
                                        </div>
                                        <ul>
                                            <li>
                                                <div class="text-holder">
                                                    <p><span>Add:</span> 13, Big Smart St, 2nd Cross, NY.</p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="text-holder">
                                                    <p><span>Ph:</span> +123-456-7890 & 4567 </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="text-holder">
                                                    <p><span>Email:</span> Ventures@Supportyou.com</p>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="social-icon-box">
                                            <ul class="social-icon">
                                                <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                                <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                                <li><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
                                                <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                                <li><a href="#"><i class="fa fa-skype" aria-hidden="true"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <!--Start single info box-->
                                    <!--Start single info box-->
                                    <div class="single-info-box">
                                        <div class="title-box">
                                            <h4>Head Quater</h4>
                                        </div>
                                        <ul>
                                            <li>
                                                <div class="text-holder">
                                                    <p><span>Add:</span> 13, Big Smart St, 2nd Cross, NY.</p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="text-holder">
                                                    <p><span>Ph:</span> +123-456-7890 & 4567 </p>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="text-holder">
                                                    <p><span>Email:</span> Ventures@Supportyou.com</p>
                                                </div>
                                            </li>
                                        </ul>
                                        <div class="social-icon-box">
                                            <ul class="social-icon">
                                                <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                                <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                                <li><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
                                                <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                                                <li><a href="#"><i class="fa fa-skype" aria-hidden="true"></i></a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <!--Start single info box-->
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End single footer widget-->

                </div>
            </div>
        </footer>
        <!--End footer area-->
        <!--Start footer bottom area-->
        <section class="footer-bottom-area">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <div class="footer-bottom">
                            <div class="footer-botton-left pull-left">
                                <p>
                                    <span class="icon-back"></span><b>Job Career?</b>
                                    <a href="mailto:someone@example.com?Subject=Hello%20again" target="_top">Ventures@Supportteam.com</a>
                                </p>
                            </div>
                            <div class="copyright-text pull-right">
                                <p>Copyrights © 2018 All Rights Reserved. Powered by <a href="#">Ventures.</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!--End footer bottom area-->
    </div>

    <!--Scroll to top-->
    <div class="scroll-to-top scroll-to-target" data-target="html"><span class="fa fa-angle-up"></span></div>
    <!-- Color Palate / Color Switcher -->
    <div class="color-palate">
        <div class="color-trigger">
            <i class="fa fa-gear"></i>
        </div>
        <div class="color-palate-head">
            <h6>Choose Your Color</h6>
        </div>
        <div class="various-color clearfix">
            <div class="colors-list">
                <span class="palate default-color active" data-theme-file="css/color-themes/default-theme.css"></span>
                <span class="palate teal-color" data-theme-file="css/color-themes/teal-theme.css"></span>
                <span class="palate navy-color" data-theme-file="css/color-themes/navy-theme.css"></span>
                <span class="palate yellow-color" data-theme-file="css/color-themes/yellow-theme.css"></span>
                <span class="palate blue-color" data-theme-file="css/color-themes/blue-theme.css"></span>
                <span class="palate purple-color" data-theme-file="css/color-themes/purple-theme.css"></span>
                <span class="palate olive-color" data-theme-file="css/color-themes/olive-theme.css"></span>
                <span class="palate red-color" data-theme-file="css/color-themes/red-theme.css"></span>
            </div>
        </div>

        <div class="palate-foo">
            <span>You can easily change and switch the colors.</span>
        </div>

    </div>
    <!-- /.End Of Color Palate -->
    <!-- main jQuery -->
    <script src="js/jquery.js"></script>
    <!-- Wow Script -->
    <script src="js/wow.min.js"></script>
    <!-- bootstrap -->
    <script src="js/bootstrap.min.js"></script>
    <!-- bx slider -->
    <script src="js/jquery.bxslider.min.js"></script>
    <!-- count to -->
    <script src="js/jquery.countTo.js"></script>
    <!-- owl carousel -->
    <script src="js/owl.js"></script>
    <script src="js/owl.carousel.min.js"></script>
    <!-- validate -->
    <script src="js/validation.js"></script>
    <!-- mixit up -->
    <script src="js/jquery.mixitup.min.js"></script>
    <!-- easing -->
    <script src="js/jquery.easing.min.js"></script>
    <!-- gmap helper -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAHzPSV2jshbjI8fqnC_C4L08ffnj5EN3A"></script>
    <!--gmap script-->
    <script src="js/gmaps.js"></script>
    <script src="js/map-helper.js"></script>
    <!-- video responsive script -->
    <script src="js/jquery.fitvids.js"></script>
    <!-- jQuery ui js -->
    <script src="assets/jquery-ui-1.11.4/jquery-ui.js"></script>
    <!-- Language Switche  -->
    <script src="assets/language-switcher/jquery.polyglot.language.switcher.js"></script>
    <!-- fancy box -->
    <script src="js/jquery.fancybox.pack.js"></script>
    <script src="js/jquery.appear.js"></script>
    <!-- isotope script-->
    <script src="js/isotope.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <!-- jQuery timepicker js -->
    <script src="assets/timepicker/timePicker.js"></script>
    <!-- Bootstrap select picker js -->
    <script src="assets/bootstrap-sl-1.12.1/bootstrap-select.js"></script>
    <script src="assets/html5lightbox/html5lightbox.js"></script>
    <!--Color Switcher-->
    <script src="js/color-settings.js"></script>

    <!-- revolution slider js -->
    <script src="assets/revolution/js/jquery.themepunch.tools.min.js"></script>
    <script src="assets/revolution/js/jquery.themepunch.revolution.min.js"></script>
    <script src="assets/revolution/js/extensions/revolution.extension.actions.min.js"></script>
    <script src="assets/revolution/js/extensions/revolution.extension.carousel.min.js"></script>
    <script src="assets/revolution/js/extensions/revolution.extension.kenburn.min.js"></script>
    <script src="assets/revolution/js/extensions/revolution.extension.layeranimation.min.js"></script>
    <script src="assets/revolution/js/extensions/revolution.extension.migration.min.js"></script>
    <script src="assets/revolution/js/extensions/revolution.extension.navigation.min.js"></script>
    <script src="assets/revolution/js/extensions/revolution.extension.parallax.min.js"></script>
    <script src="assets/revolution/js/extensions/revolution.extension.slideanims.min.js"></script>
    <script src="assets/revolution/js/extensions/revolution.extension.video.min.js"></script>


    <!-- thm custom script -->
    <script src="js/custom.js"></script>



</body>

<!-- Mirrored from steelthemes.com/demo/html/ventures-preview/ by HTTrack Website Copier/3.x [XR&CO''2014], Wed, 12 Sep 2018 18:05:41 GMT -->
</html>')
INSERT [dbo].[cmsTemplate] ([pk], [nodeId], [alias], [design]) VALUES (3, 1269, N'Home', N'@inherits Umbraco.Web.Mvc.UmbracoTemplatePage<ContentModels.Home>
@using ContentModels = Umbraco.Web.PublishedContentModels;
@{
    Layout = "Master.cshtml";
}

<!--Start rev slider wrapper-->
<section class="rev_slider_wrapper">
    <div id="slider1" class="rev_slider" data-version="5.0">
        <ul>
            @if (Model.Content.FeaturedSlides.Count() > 0)
            {
                foreach (Slide slide in Model.Content.FeaturedSlides)
                {
                    <li data-transition="fade">
                        <img src="@slide.SlideImage.Url" alt="" width="1920" height="780" data-bgposition="top center" data-bgfit="cover" data-bgrepeat="no-repeat" data-bgparallax="1">

                        <div class="tp-caption  tp-resizeme"
                             data-x="left" data-hoffset="0"
                             data-y="top" data-voffset="195"
                             data-transform_idle="o:1;"
                             data-transform_in="x:[-175%];y:0px;z:0;rX:0;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0.01;s:3000;e:Power3.easeOut;"
                             data-transform_out="s:1000;e:Power3.easeInOut;s:1000;e:Power3.easeInOut;"
                             data-mask_in="x:[100%];y:0;s:inherit;e:inherit;"
                             data-splitin="none"
                             data-splitout="none"
                             data-responsive_offset="on"
                             data-start="1500">
                            <div class="slide-content left-slide">
                                <h3>@slide.SlideHeader</h3>
                                <div class="big-title">@slide.SlideTitle</div>
                                <div class="text">@slide.SlideText</div>
                                <div class="btns-box">
                                    <a href="about.html" class="btn-one pdone">Read More</a>&ensp;
                                    <a href="contact.html" class="btn-two pdtwo">Contact Us</a>
                                </div>
                            </div>
                        </div>

                    </li>
                }
            }
            @*<li data-transition="fade">
                    <img src="~/Media/1070/2.jpg" alt="" width="1920" height="780" data-bgposition="top center" data-bgfit="cover" data-bgrepeat="no-repeat" data-bgparallax="1">

                    <div class="tp-caption  tp-resizeme"
                         data-x="right" data-hoffset="0"
                         data-y="top" data-voffset="195"
                         data-transform_idle="o:1;"
                         data-transform_in="x:[-175%];y:0px;z:0;rX:0;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0.01;s:3000;e:Power3.easeOut;"
                         data-transform_out="s:1000;e:Power3.easeInOut;s:1000;e:Power3.easeInOut;"
                         data-mask_in="x:[100%];y:0;s:inherit;e:inherit;"
                         data-splitin="none"
                         data-splitout="none"
                         data-responsive_offset="on"
                         data-start="1500">
                        <div class="slide-content right-slide">
                            <h3>The fastest way to achive</h3>
                            <div class="big-title">Success</div>
                            <div class="text">Over 24 years experience knowledge international standards<br> technologicaly changes and industrial systems.</div>
                            <div class="btns-box">
                                <a href="about.html" class="btn-one pdone">Read More</a>&ensp;
                                <a href="contact.html" class="btn-two pdtwo">Contact Us</a>
                            </div>
                        </div>
                    </div>
                </li>
                <li data-transition="fade">
                    <img src="~/Media/1071/3.jpg" alt="" width="1920" height="780" data-bgposition="top center" data-bgfit="cover" data-bgrepeat="no-repeat" data-bgparallax="1">

                    <div class="tp-caption  tp-resizeme"
                         data-x="left" data-hoffset="0"
                         data-y="top" data-voffset="195"
                         data-transform_idle="o:1;"
                         data-transform_in="x:[-175%];y:0px;z:0;rX:0;rY:0;rZ:0;sX:1;sY:1;skX:0;skY:0;opacity:0.01;s:3000;e:Power3.easeOut;"
                         data-transform_out="s:1000;e:Power3.easeInOut;s:1000;e:Power3.easeInOut;"
                         data-mask_in="x:[100%];y:0;s:inherit;e:inherit;"
                         data-splitin="none"
                         data-splitout="none"
                         data-responsive_offset="on"
                         data-start="1500">
                        <div class="slide-content left-slide">
                            <h3>Trading solution for</h3>
                            <div class="big-title">Investors</div>
                            <div class="text">Over 24 years experience and knowledge international standards<br> technologicaly changes and industrial systems.</div>
                            <div class="btns-box">
                                <a href="about.html" class="btn-one pdone">Read More</a>&ensp;
                                <a href="contact.html" class="btn-two pdtwo">Contact Us</a>
                            </div>
                        </div>
                    </div>

                </li>*@
        </ul>
    </div>
</section>
<!--End rev slider wrapper-->
<!--Start choose area-->
<section class="choose-area">
    <div class="container">
        <div class="row">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                <div class="inner-content parallax-bg-one" style="background-image:url(Media/1129/choose-bg.jpg);">
                    <div class="sec-title text-center">
                        <h1 class="white-color">Why Choose US</h1>
                        <div class="border center"></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xl-12">
                <div class="featured-item-box">
                    <div class="row">
                        <!--Start single box-->
                        <div class="col-xl-3 col-lg-6 col-md-6 col-sm-12">
                            <div class="single-box text-center">
                                <div class="icon-holder">
                                    <span class="icon-people"></span>
                                </div>
                                <h3>We are Professional</h3>
                                <span>Consultant</span>
                                <div class="overlay-content-box">
                                    <div class="icon-holder">
                                        <span class="icon-people"></span>
                                    </div>
                                    <h3>We are Professional</h3>
                                    <span>Consultant</span>
                                    <p>Expound the actual teachings truth the great explorer.</p>
                                    <div class="border"></div>
                                </div>
                            </div>
                        </div>
                        <!--End single box-->
                        <!--Start single box-->
                        <div class="col-xl-3 col-lg-6 col-md-6 col-sm-12">
                            <div class="single-box text-center">
                                <div class="icon-holder">
                                    <span class="icon-business"></span>
                                </div>
                                <h3>Licensed & Certified</h3>
                                <span>Company</span>
                                <div class="overlay-content-box">
                                    <div class="icon-holder">
                                        <span class="icon-business"></span>
                                    </div>
                                    <h3>Licensed & Certified</h3>
                                    <span>Company</span>
                                    <p>Expound the actual teachings truth the great explorer.</p>
                                    <div class="border"></div>
                                </div>
                            </div>
                        </div>
                        <!--End single box-->
                        <!--Start single box-->
                        <div class="col-xl-3 col-lg-6 col-md-6 col-sm-12">
                            <div class="single-box text-center">
                                <div class="icon-holder">
                                    <span class="icon-landscape"></span>
                                </div>
                                <h3>Number 1 Company</h3>
                                <span>In Region</span>
                                <div class="overlay-content-box">
                                    <div class="icon-holder">
                                        <span class="icon-landscape"></span>
                                    </div>
                                    <h3>Number 1 Company</h3>
                                    <span>In Region</span>
                                    <p>Expound the actual teachings truth the great explorer.</p>
                                    <div class="border"></div>
                                </div>
                            </div>
                        </div>
                        <!--End single box-->
                        <!--Start single box-->
                        <div class="col-xl-3 col-lg-6 col-md-6 col-sm-12">
                            <div class="single-box text-center">
                                <div class="icon-holder">
                                    <span class="icon-people-1"></span>
                                </div>
                                <h3>Leading Provider of</h3>
                                <span>Busi. Solutions</span>
                                <div class="overlay-content-box">
                                    <div class="icon-holder">
                                        <span class="icon-people-1"></span>
                                    </div>
                                    <h3>Leading Provider of</h3>
                                    <span>Busi. Solutions</span>
                                    <p>Expound the actual teachings truth the great explorer.</p>
                                    <div class="border"></div>
                                </div>
                            </div>
                        </div>
                        <!--End single box-->
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!--End choose area-->
<!--Start services area-->
<section class="services-area">
    <div class="container">
        <div class="sec-title text-center">
            <p>Actually What We Do</p>
            <h1>Our Main Services</h1>
            <div class="border center"></div>
            <span>We are experts in this industry with over 100 years experience. What that means is you are going to get<br> right solution. please find our services.</span>
        </div>
        <div class="row">
            <div class="col-xl-12">
                <div class="service-carousel">
                    <!--Start single service item-->
                    @if (Model.Content.FeaturedServices.Count() > 0)
                    {
                        foreach (HomeService service in Model.Content.FeaturedServices)
                        {
                            <div class="single-service-item">
                                <div class="img-holder">
                                    <img src="@service.ServiceImage.Url" alt="Awesome Image">
                                    <div class="icon-box">
                                        <span class="icon-suitcase"></span>
                                    </div>
                                    <div class="overlay-style-one">
                                        <div class="box">
                                            <div class="content">
                                                <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="text-holder">
                                    <h3 class="title"><a href="service-single.html">@service.ServiceTitle</a></h3>
                                    <p>@service.ServiceText</p>
                                    <a class="readmore" href="service-single.html">Read More</a>
                                </div>
                            </div>
                        }
                    }
                    <!--Start single service item-->
                    <!--Start single service item-->
                    <!--<div class="single-service-item">-->
                    <!--    <div class="img-holder">-->
                    <!--        <img src="~/Media/1044/2.jpg" alt="Awesome Image">-->
                    <!--        <div class="icon-box">-->
                    <!--            <span class="icon-money"></span>-->
                    <!--        </div>-->
                    <!--        <div class="overlay-style-one">-->
                    <!--            <div class="box">-->
                    <!--                <div class="content">-->
                    <!--                    <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>-->
                    <!--                </div>-->
                    <!--            </div>-->
                    <!--        </div>-->
                    <!--    </div>-->
                    <!--    <div class="text-holder">-->
                    <!--        <h3 class="title"><a href="service-single.html">Trades and Stocks</a></h3>-->
                    <!--        <p>How this mistaken  denouncing pleasure and praising pain was born & we will give complete account of system.</p>-->
                    <!--        <a class="readmore" href="service-single.html">Read More</a>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--Start single service item-->
                    <!--Start single service item-->
                    <!--<div class="single-service-item">-->
                    <!--    <div class="img-holder">-->
                    <!--        <img src="~/Media/1045/3.jpg" alt="Awesome Image">-->
                    <!--        <div class="icon-box">-->
                    <!--            <span class="icon-sheet"></span>-->
                    <!--        </div>-->
                    <!--        <div class="overlay-style-one">-->
                    <!--            <div class="box">-->
                    <!--                <div class="content">-->
                    <!--                    <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>-->
                    <!--                </div>-->
                    <!--            </div>-->
                    <!--        </div>-->
                    <!--    </div>-->
                    <!--    <div class="text-holder">-->
                    <!--        <h3 class="title"><a href="service-single.html">Bonds & Commodities</a></h3>-->
                    <!--        <p>Except to obtain some advantage from but who has any rights to find fault with a man who chooses to enjoy a pleasure.</p>-->
                    <!--        <a class="readmore" href="service-single.html">Read More</a>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--Start single service item-->
                    <!--Start single service item-->
                    <!--<div class="single-service-item">-->
                    <!--    <div class="img-holder">-->
                    <!--        <img src="~/Media/1043/1.jpg" alt="Awesome Image">-->
                    <!--        <div class="icon-box">-->
                    <!--            <span class="icon-suitcase"></span>-->
                    <!--        </div>-->
                    <!--        <div class="overlay-style-one">-->
                    <!--            <div class="box">-->
                    <!--                <div class="content">-->
                    <!--                    <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>-->
                    <!--                </div>-->
                    <!--            </div>-->
                    <!--        </div>-->
                    <!--    </div>-->
                    <!--    <div class="text-holder">-->
                    <!--        <h3 class="title"><a href="service-single.html">Turnaround Consulting</a></h3>-->
                    <!--        <p>There anyone who loves or pursues desires to obtain pain of itself, because it is pain occasionally circumstances occur.</p>-->
                    <!--        <a class="readmore" href="service-single.html">Read More</a>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--Start single service item-->
                    <!--Start single service item-->
                    <!--<div class="single-service-item">-->
                    <!--    <div class="img-holder">-->
                    <!--        <img src="~/Media/1044/2.jpg" alt="Awesome Image">-->
                    <!--        <div class="icon-box">-->
                    <!--            <span class="icon-money"></span>-->
                    <!--        </div>-->
                    <!--        <div class="overlay-style-one">-->
                    <!--            <div class="box">-->
                    <!--                <div class="content">-->
                    <!--                    <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>-->
                    <!--                </div>-->
                    <!--            </div>-->
                    <!--        </div>-->
                    <!--    </div>-->
                    <!--    <div class="text-holder">-->
                    <!--        <h3 class="title"><a href="service-single.html">Trades and Stocks</a></h3>-->
                    <!--        <p>How this mistaken  denouncing pleasure and praising pain was born & we will give complete account of system.</p>-->
                    <!--        <a class="readmore" href="service-single.html">Read More</a>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--Start single service item-->
                    <!--Start single service item-->
                    <!--<div class="single-service-item">-->
                    <!--    <div class="img-holder">-->
                    <!--        <img src="~/Media/1045/3.jpg" alt="Awesome Image">-->
                    <!--        <div class="icon-box">-->
                    <!--            <span class="icon-sheet"></span>-->
                    <!--        </div>-->
                    <!--        <div class="overlay-style-one">-->
                    <!--            <div class="box">-->
                    <!--                <div class="content">-->
                    <!--                    <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>-->
                    <!--                </div>-->
                    <!--            </div>-->
                    <!--        </div>-->
                    <!--    </div>-->
                    <!--    <div class="text-holder">-->
                    <!--        <h3 class="title"><a href="service-single.html">Bonds & Commodities</a></h3>-->
                    <!--        <p>Except to obtain some advantage from but who has any rights to find fault with a man who chooses to enjoy a pleasure.</p>-->
                    <!--        <a class="readmore" href="service-single.html">Read More</a>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--Start single service item-->
                    <!--Start single service item-->
                    <!--<div class="single-service-item">-->
                    <!--    <div class="img-holder">-->
                    <!--        <img src="~/Media/1043/1.jpg" alt="Awesome Image">-->
                    <!--        <div class="icon-box">-->
                    <!--            <span class="icon-suitcase"></span>-->
                    <!--        </div>-->
                    <!--        <div class="overlay-style-one">-->
                    <!--            <div class="box">-->
                    <!--                <div class="content">-->
                    <!--                    <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>-->
                    <!--                </div>-->
                    <!--            </div>-->
                    <!--        </div>-->
                    <!--    </div>-->
                    <!--    <div class="text-holder">-->
                    <!--        <h3 class="title"><a href="service-single.html">Turnaround Consulting</a></h3>-->
                    <!--        <p>There anyone who loves or pursues desires to obtain pain of itself, because it is pain occasionally circumstances occur.</p>-->
                    <!--        <a class="readmore" href="service-single.html">Read More</a>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--Start single service item-->
                    <!--Start single service item-->
                    <!--<div class="single-service-item">-->
                    <!--    <div class="img-holder">-->
                    <!--        <img src="~/Media/1044/2.jpg" alt="Awesome Image">-->
                    <!--        <div class="icon-box">-->
                    <!--            <span class="icon-money"></span>-->
                    <!--        </div>-->
                    <!--        <div class="overlay-style-one">-->
                    <!--            <div class="box">-->
                    <!--                <div class="content">-->
                    <!--                    <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>-->
                    <!--                </div>-->
                    <!--            </div>-->
                    <!--        </div>-->
                    <!--    </div>-->
                    <!--    <div class="text-holder">-->
                    <!--        <h3 class="title"><a href="service-single.html">Trades and Stocks</a></h3>-->
                    <!--        <p>How this mistaken  denouncing pleasure and praising pain was born & we will give complete account of system.</p>-->
                    <!--        <a class="readmore" href="service-single.html">Read More</a>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--Start single service item-->
                    <!--Start single service item-->
                    <!--<div class="single-service-item">-->
                    <!--    <div class="img-holder">-->
                    <!--        <img src="~/Media/1045/3.jpg" alt="Awesome Image">-->
                    <!--        <div class="icon-box">-->
                    <!--            <span class="icon-sheet"></span>-->
                    <!--        </div>-->
                    <!--        <div class="overlay-style-one">-->
                    <!--            <div class="box">-->
                    <!--                <div class="content">-->
                    <!--                    <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>-->
                    <!--                </div>-->
                    <!--            </div>-->
                    <!--        </div>-->
                    <!--    </div>-->
                    <!--    <div class="text-holder">-->
                    <!--        <h3 class="title"><a href="service-single.html">Bonds & Commodities</a></h3>-->
                    <!--        <p>Except to obtain some advantage from but who has any rights to find fault with a man who chooses to enjoy a pleasure.</p>-->
                    <!--        <a class="readmore" href="service-single.html">Read More</a>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--Start single service item-->

                </div>
            </div>
        </div>
    </div>

    <!--Start service about bg-->
    <div class="service-about-bg parallax-bg-one" style="background-image:url(Media/1133/service-about-bg.jpg);">
        <div class="container">
            <div class="row">
                <div class="col-xl-12">
                    <div class="inner-content">

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--End service about bg-->

</section>
<!--End services area-->
<!--Start about area-->
<section class="about-area">
    <div class="container">
        <div class="row">
            <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12">
                <div class="about-text-box">
                    <div class="sec-title">
                        <p>Who We Are</p>
                        <h1>@Model.Content.AboutUsHeader</h1>
                        <div class="border left"></div>
                    </div>
                    <div class="inner-content">
                        <h3>@Model.Content.AboutUsTitle</h3>
                        <div class="text">
                            <p>@Model.Content.AboutUsText</p>
                        </div>
                        <div class="bottom">
                            <div class="read-more-button">
                                <a href="#">read More</a>
                            </div>
                            <div class="our-logo">
                                <img src="~/Media/1042/our-logo.png" alt="" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xl-6 col-lg-6 col-md-12 col-sm-12">
                <div class="company-featured-box clearfix">
                    <ul>
                        <li class="bg-one">
                            <div class="single-box">
                                <div class="icon-holder">
                                    <span class="icon-pen"></span>
                                </div>
                                <div class="title-holder">
                                    <h3>Completed more than<br> 2000 projects.</h3>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="single-box">
                                <div class="icon-holder">
                                    <span class="icon-people-2"></span>
                                </div>
                                <div class="title-holder">
                                    <h3>400+ experts consultants<br> ready to help you.</h3>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="single-box">
                                <div class="icon-holder">
                                    <span class="icon-smile"></span>
                                </div>
                                <div class="title-holder">
                                    <h3>More than 1500 clients<br> satisfied with us.</h3>
                                </div>
                            </div>
                        </li>
                        <li class="blue-bg">
                            <div class="single-box">
                                <div class="icon-holder">
                                    <span class="icon-medal"></span>
                                </div>
                                <div class="title-holder">
                                    <h3>We won 172 awards for<br> best service.</h3>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

        </div>
    </div>
</section>
<!--End about area-->
<!--Start latest project area-->
<section class="latest-project-area">
    <div class="container">
        <div class="row">
            <div class="col-xl-12">
                <div class="sec-title float-left">
                    <p>Our Works</p>
                    <h1>Latest Projects</h1>
                    <div class="border left"></div>
                </div>
                <div class="filters float-right">
                    <ul class="post-filter clearfix">
                        <li class="active" data-filter=".filter-item"><span>View All</span></li>
                        <li data-filter=".consulting"><span>Consulting</span></li>
                        <li data-filter=".finance"><span>Finance</span></li>
                        <li data-filter=".marketing"><span>Marketing</span></li>
                        <li data-filter=".growth"><span>Growth</span></li>
                        <li data-filter=".technical"><span>Technical</span></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="project-content masonary-layout filter-layout clearfix">
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item consulting finance marketing">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1002/lat-project-1.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item consulting finance">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1004/lat-project-2.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item consulting technical">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1005/lat-project-3.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item technical marketing">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1006/lat-project-4.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item consulting technical finance">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1007/lat-project-5.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item consulting technical finance">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1008/lat-project-6.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item growth technical finance">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1009/lat-project-7.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item consulting technical finance">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1010/lat-project-8.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item consulting technical growth">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1011/lat-project-9.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->
        <!--Start single project item-->
        <div class="single-item span-width-5 filter-item growth technical finance">
            <div class="single-project-item">
                <div class="img-holder">
                    <img src="~/Media/1003/lat-project-10.jpg" alt="Awesome Image">
                    <div class="overlay-style-one">
                        <div class="box">
                            <div class="content">
                                <div class="inner-content">
                                    <span>Technical & Growth</span>
                                    <h3><a href="project-single.html">Leading consumer products<br>company.</a></h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--End single project item-->

    </div>
</section>
<!--End latest project area-->
<!--Start testimonial section-->
<section class="testimonial-section" style="background-image:url(Media/1135/testimonial-section-bg.jpg);">
    <div class="container">
        <div class="title text-center">
            <h1>We trusted by more than 10,000 clients</h1>
            <span>Here you know how our customers trusted our comapny & How our team provide a service.</span>
        </div>
        <div class="testimonial-outer">
            <div class="quote-icon text-center">
                <span class="icon-school"></span>
            </div>
            <!--Client Testimonial Carousel-->
            <div class="client-testimonial-carousel">
                @if (Model.Content.FeaturedTestimonial.Count() > 0)
                {
                    foreach (Testimonial testimonial in Model.Content.FeaturedTestimonial)
                    {
                        <div class="testimonial-block-one">
                            <div class="inner-box">
                                <div class="text">@testimonial.TestimonialText</div>
                            </div>
                        </div>
                    }
                }
                <!--<div class="testimonial-block-one">-->
                <!--    <div class="inner-box">-->
                <!--        <div class="text">“ These guys are just the coolest company ever! They were aware of our transported for road and tail and complex.performance on our project was extremely successful the great explorer of the truth, the master-builder  happiness avoids pleasure itself ”.</div>-->
                <!--    </div>-->
                <!--</div>-->
                <!--<div class="testimonial-block-one">-->
                <!--    <div class="inner-box">-->
                <!--        <div class="text">“ These guys are just the coolest company ever! They were aware of our transported for road and tail and complex.performance on our project was extremely successful the great explorer of the truth, the master-builder  happiness avoids pleasure itself ”.</div>-->
                <!--    </div>-->
                <!--</div>-->
                <!--<div class="testimonial-block-one">-->
                <!--    <div class="inner-box">-->
                <!--        <div class="text">“ These guys are just the coolest company ever! They were aware of our transported for road and tail and complex.performance on our project was extremely successful the great explorer of the truth, the master-builder  happiness avoids pleasure itself ”.</div>-->
                <!--    </div>-->
                <!--</div>-->
            </div>
            <!--Product Thumbs Carousel-->
            <div class="client-thumb-outer">
                <div class="client-thumbs-carousel owl-carousel owl-theme">
                    @if (Model.Content.FeaturedTestimonial.Count() > 0)
                    {
                        foreach (Testimonial customerInfo in Model.Content.FeaturedTestimonial)
                        {
                            <div class="thumb-item">
                                <figure class="thumb-box"><img src="@customerInfo.CustomerImage.Url" alt=""></figure>
                                <div class="thumb-content">
                                    <h3>@customerInfo.CustomerName</h3>
                                    <div class="designation">@customerInfo.CustomerCity</div>
                                </div>
                            </div>
                        }
                    }
                    <!--<div class="thumb-item">-->
                    <!--    <figure class="thumb-box"><img src="~/Media/1079/2.png" alt=""></figure>-->
                    <!--    <div class="thumb-content">-->
                    <!--        <h3>Jenifer Hearly</h3>-->
                    <!--        <div class="designation">Newyork</div>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--<div class="thumb-item">-->
                    <!--    <figure class="thumb-box"><img src="~/Media/1080/3.png" alt=""></figure>-->
                    <!--    <div class="thumb-content">-->
                    <!--        <h3>Jenifer Hearly</h3>-->
                    <!--        <div class="designation">Newyork</div>-->
                    <!--    </div>-->
                    <!--</div>-->
                    <!--<div class="thumb-item">-->
                    <!--    <figure class="thumb-box"><img src="~/Media/1081/4.png" alt=""></figure>-->
                    <!--    <div class="thumb-content">-->
                    <!--        <h3>Jenifer Hearly</h3>-->
                    <!--        <div class="designation">Newyork</div>-->
                    <!--    </div>-->
                    <!--</div>-->

                </div>
            </div>

        </div>
    </div>
</section>
<!--End testimonial section-->
<!--Start latest blog area-->
<section class="latest-blog-area sec-pding-two">
    <div class="container">
        <div class="sec-title text-center">
            <p>News & Press Release</p>
            <h1>Latest From Blog</h1>
            <div class="border center"></div>
        </div>
        <div class="row">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                <div class="blog-Carousel">
                    <!--Start single blog item-->
                    <div class="single-blog-post">
                        <div class="row">
                            <div class="col-xl-6 col-lg-12 col-md-6 col-sm-12">
                                <div class="img-holder">
                                    <img src="~/Media/1095/lat-blog-1.jpg" alt="Awesome Image">
                                    <div class="overlay-style-one">
                                        <div class="box">
                                            <div class="content">
                                                <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-12 col-md-6 col-sm-12">
                                <div class="text-holder">
                                    <div class="top clearfix">
                                        <div class="meta-box">
                                            <ul class="meta-info">
                                                <li><a href="#">By Fletcher</a></li>
                                                <li><a href="#">June 21, 2017</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="text">
                                        <h3><a class="blog-title" href="blog-single.html">We won best company award of the year 2015 & 16.</a></h3>
                                        <p>Rationally encounter consequences that are extremely painful for your...</p>
                                        <div class="readmore">
                                            <a href="blog-single.html">Read More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End single blog item-->
                    <!--Start single blog item-->
                    <div class="single-blog-post">
                        <div class="row">
                            <div class="col-xl-6 col-lg-12 col-md-6 col-sm-12">
                                <div class="img-holder">
                                    <img src="~/Media/1096/lat-blog-2.jpg" alt="Awesome Image">
                                    <div class="overlay-style-one">
                                        <div class="box">
                                            <div class="content">
                                                <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-12 col-md-6 col-sm-12">
                                <div class="text-holder">
                                    <div class="top clearfix">
                                        <div class="meta-box">
                                            <ul class="meta-info">
                                                <li><a href="#">By Fletcher</a></li>
                                                <li><a href="#">June 21, 2017</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="text">
                                        <h3><a class="blog-title" href="blog-single.html">Eight Pricing strategies for your digital product.</a></h3>
                                        <p>Pursues desires obtain pain itself it  pain, but because occasionally...</p>
                                        <div class="readmore">
                                            <a href="blog-single.html">Read More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End single blog item-->
                    <!--Start single blog item-->
                    <div class="single-blog-post">
                        <div class="row">
                            <div class="col-xl-6 col-lg-12 col-md-6 col-sm-12">
                                <div class="img-holder">
                                    <img src="~/Media/1095/lat-blog-1.jpg" alt="Awesome Image">
                                    <div class="overlay-style-one">
                                        <div class="box">
                                            <div class="content">
                                                <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-12 col-md-6 col-sm-12">
                                <div class="text-holder">
                                    <div class="top clearfix">
                                        <div class="meta-box">
                                            <ul class="meta-info">
                                                <li><a href="#">By Fletcher</a></li>
                                                <li><a href="#">June 21, 2017</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="text">
                                        <h3><a class="blog-title" href="blog-single.html">We won best company award of the year 2015 & 16.</a></h3>
                                        <p>Rationally encounter consequences that are extremely painful for your...</p>
                                        <div class="readmore">
                                            <a href="blog-single.html">Read More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End single blog item-->
                    <!--Start single blog item-->
                    <div class="single-blog-post">
                        <div class="row">
                            <div class="col-xl-6 col-lg-12 col-md-6 col-sm-12">
                                <div class="img-holder">
                                    <img src="~/Media/1096/lat-blog-2.jpg" alt="Awesome Image">
                                    <div class="overlay-style-one">
                                        <div class="box">
                                            <div class="content">
                                                <a href="blog-single.html"><i class="fa fa-link" aria-hidden="true"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-lg-12 col-md-6 col-sm-12">
                                <div class="text-holder">
                                    <div class="top clearfix">
                                        <div class="meta-box">
                                            <ul class="meta-info">
                                                <li><a href="#">By Fletcher</a></li>
                                                <li><a href="#">June 21, 2017</a></li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="text">
                                        <h3><a class="blog-title" href="blog-single.html">Eight Pricing strategies for your digital product.</a></h3>
                                        <p>Pursues desires obtain pain itself it  pain, but because occasionally...</p>
                                        <div class="readmore">
                                            <a href="blog-single.html">Read More</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--End single blog item-->

                </div>
            </div>

        </div>
    </div>
</section>
<!--End latest blog area-->
<!--Start Appointment Area-->
<section class="appointment-area">
    <div class="container">
        <div class="row">
            <div class="col-xl-4 col-lg-5 col-md-12 col-sm-12">
                <div class="appointment-img-holder clearfix">
                    <img src="~/Media/1032/appoinment-image.jpg" alt="">
                    <div class="subscribe-form-box">
                        <p>Sign up us today we will send you latest news, usefull tips at your mail address.</p>
                        <form class="newsletter-form" action="#">
                            <input placeholder="Enter Email..." type="text">
                            <button type="submit">Submit</button>
                        </form>
                        <span>* Your email id is very confidential</span>
                        <ul class="sociallinks-style-two">
                            <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                            <li><a href="#"><i class="fa fa-google-plus" aria-hidden="true"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin" aria-hidden="true"></i></a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-xl-8 col-lg-7 col-md-12 col-sm-12">
                <div class="text-holder">
                    <div class="sec-title text-center">
                        <p>For an Enquiry</p>
                        <h1>Make an Appointment</h1>
                        <div class="border center"></div>
                    </div>
                    <form class="appointment-form-box">
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" name="form_name" value="" placeholder="Your Name*" required="">
                            </div>
                            <div class="col-md-6">
                                <input type="email" name="form_email" value="" placeholder="Email address*" required="">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <input type="text" name="form_phone" value="" placeholder="Phone*">
                            </div>
                            <div class="col-md-6">
                                <select class="selectmenu">
                                    <option selected="selected">Select Service</option>
                                    <option>Business Growth</option>
                                    <option>Sustainability</option>
                                    <option>Performance</option>
                                    <option>Advanced Analytics</option>
                                    <option>Organization</option>
                                    <option>Customer Insights</option>
                                    <option>Marketing Plan</option>
                                    <option>Online Consulting</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <button class="btn-one" type="submit">Submit Now</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</section>
<!--End Appointment Area-->
<!--Start Brand area-->
<section class="brand-area">
    <div class="container">
        <div class="row">
            <div class="col-xl-4 col-lg-7 col-md-12">
                <div class="brand-text-box">
                    <div class="title">
                        <h3>We working with right<br> partners.</h3>
                    </div>
                    <div class="text">
                        <p>Must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born  complete account of the system.</p>
                        <a href="#">Join With Us</a>
                    </div>
                </div>
            </div>
            <div class="col-xl-8 col-lg-12 col-md-12">
                <ul class="brand">
                    <!--Start single item-->
                    <li class="single-item">
                        <a href="#"><img src="~/Media/1111/1.png" alt="Awesome Brand Image"></a>
                        <div class="text">
                            <p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.</p>
                            <a class="visit-site" href="#">Visit Website</a>
                        </div>
                    </li>
                    <!--End single item-->
                    <!--Start single item-->
                    <li class="single-item">
                        <a href="#"><img src="~/Media/1112/2.png" alt="Awesome Brand Image"></a>
                        <div class="text">
                            <p>The master-builder of human happiness one avoids pleasure itself, because it is pleasure, but because those who do not know pursue.</p>
                            <a class="visit-site" href="#">Visit Website</a>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</section>
<!--End Brand area-->
<!--Start slogan area-->
<section class="slogan-area" style="background-image:url(Media/1134/slogan-bg.jpg);">
    <div class="container">
        <div class="row">
            <div class="col-xl-12">
                <div class="inner-content">
                    <div class="title float-left">
                        <h3>If the plan doesn’t work, change the plan, but never the goal.</h3>
                    </div>
                    <div class="button float-right">
                        <a href="#">Get a Quote</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<!--End slogan area-->')
SET IDENTITY_INSERT [dbo].[cmsTemplate] OFF
SET IDENTITY_INSERT [dbo].[umbracoAudit] ON 

INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1, 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'::1', CAST(N'2018-09-14 21:10:46.533' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating TourData, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-15 18:22:54.067' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (3, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-15 18:22:54.380' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (4, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-15 19:48:48.533' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (5, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-15 19:48:49.350' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1004, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 08:07:35.320' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1005, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 08:07:35.880' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1006, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 08:47:32.297' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1007, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 08:47:32.310' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1008, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 10:19:17.933' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1009, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 10:19:18.113' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1010, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 11:07:41.150' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1011, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 11:07:41.273' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1012, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 11:20:22.377' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1013, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 11:20:22.460' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1014, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 17:22:08.067' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1015, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 17:22:08.167' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1016, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 17:29:57.293' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1017, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 17:29:57.367' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1018, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 17:57:12.627' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1019, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 17:57:12.633' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1020, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 18:09:23.397' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1021, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 18:09:23.430' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1022, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 18:15:20.680' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1023, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 18:15:20.713' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1024, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 18:25:45.137' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1025, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 18:25:45.170' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1026, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 18:46:49.700' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1027, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 18:46:49.743' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1028, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 19:05:42.713' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1029, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 19:05:43.050' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1030, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 19:58:31.003' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1031, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 19:58:31.090' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1032, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 21:53:01.280' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1033, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 21:53:01.373' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1034, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 22:35:00.233' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1035, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-16 22:35:00.520' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1036, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-17 18:37:37.630' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (1037, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-17 18:37:37.900' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2036, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-18 20:26:26.853' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2037, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-18 20:26:27.450' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2038, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-19 18:24:47.873' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2039, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-19 18:24:47.883' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2040, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-19 18:53:07.997' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2041, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-19 18:53:08.023' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2042, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-19 20:20:22.343' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2043, 0, N'User "SYSTEM" ', N'::1', CAST(N'2018-09-19 20:20:22.660' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2044, 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'::1', CAST(N'2018-09-19 20:20:52.493' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/save', N'updating LastLoginDate, UpdateDate')
INSERT [dbo].[umbracoAudit] ([id], [performingUserId], [performingDetails], [performingIp], [eventDateUtc], [affectedUserId], [affectedDetails], [eventType], [eventDetails]) VALUES (2045, 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'::1', CAST(N'2018-09-19 20:20:52.523' AS DateTime), 0, N'User "Ravi Patel" <ravipatel2423@gmail.com>', N'umbraco/user/sign-in/login', N'login success')
SET IDENTITY_INSERT [dbo].[umbracoAudit] OFF
SET IDENTITY_INSERT [dbo].[umbracoCacheInstruction] ON 

INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1279, CAST(N'2018-09-19 18:26:59.843' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"UniqueId\":\"56eeaa2f-a01f-45da-9765-e2bc25ccaad4\",\"Id\":1287}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1280, CAST(N'2018-09-19 18:27:27.230' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"testimonial\",\"Id\":1288,\"PropertyTypeIds\":[58,59,60],\"Type\":\"IContentType\",\"AliasChanged\":true,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":true}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1281, CAST(N'2018-09-19 18:27:49.440' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"home\",\"Id\":1270,\"PropertyTypeIds\":[47],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1282, CAST(N'2018-09-19 18:55:12.893' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"UniqueId\":\"a0554a21-3198-49ea-869d-49d4716f51eb\",\"Id\":1289}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1283, CAST(N'2018-09-19 18:56:16.427' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"UniqueId\":\"24b21041-b224-4f5b-afb0-de678c746100\",\"Id\":1290}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1284, CAST(N'2018-09-19 18:56:33.350' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"home\",\"Id\":1270,\"PropertyTypeIds\":[47,61,62],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1285, CAST(N'2018-09-19 18:59:33.777' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1291]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1286, CAST(N'2018-09-19 19:00:05.203' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1287, CAST(N'2018-09-19 19:01:59.320' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"UniqueId\":\"b4dd92c5-9bee-4f08-a13e-3a0e8dac49cb\",\"Id\":1292}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1288, CAST(N'2018-09-19 19:02:27.763' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"testimonial\",\"Id\":1288,\"PropertyTypeIds\":[58,63,60,59],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1289, CAST(N'2018-09-19 19:02:48.057' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"homeAboutUs\",\"Id\":1284,\"PropertyTypeIds\":[55,57,56],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":true,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1290, CAST(N'2018-09-19 19:03:15.483' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"UniqueId\":\"65dd8b49-619b-45f8-a4b0-39bbff5ecfc1\",\"Id\":1293}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1291, CAST(N'2018-09-19 19:03:47.280' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"UniqueId\":\"eb5aefe0-38f6-46ce-9073-6b513f384aef\",\"Id\":1294}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1292, CAST(N'2018-09-19 19:04:31.977' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"home\",\"Id\":1270,\"PropertyTypeIds\":[47,61,64,65,66,62],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1293, CAST(N'2018-09-19 19:05:57.960' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1295]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1294, CAST(N'2018-09-19 19:08:16.297' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1295, CAST(N'2018-09-19 19:13:13.630' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1269]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1296, CAST(N'2018-09-19 19:13:20.620' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1297, CAST(N'2018-09-19 19:13:25.170' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1298, CAST(N'2018-09-19 19:13:31.177' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1278]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1278]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1299, CAST(N'2018-09-19 19:13:31.293' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1279]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1279]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1300, CAST(N'2018-09-19 19:13:31.557' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1280]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1280]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1301, CAST(N'2018-09-19 19:13:31.813' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1291]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1291]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1302, CAST(N'2018-09-19 19:13:31.950' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1295]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1295]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1303, CAST(N'2018-09-19 19:14:18.287' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1269]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1304, CAST(N'2018-09-19 19:14:27.420' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1305, CAST(N'2018-09-19 19:15:15.190' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"service\",\"Id\":1283,\"PropertyTypeIds\":[52,53,54],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1306, CAST(N'2018-09-19 19:15:23.203' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1307, CAST(N'2018-09-19 19:15:24.660' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1308, CAST(N'2018-09-19 19:16:23.743' AS DateTime), N'[{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1291,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null},{"RefreshType":5,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1291,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null},{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"service\",\"Id\":1283,\"PropertyTypeIds\":[54,53,52],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":true,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 3)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1309, CAST(N'2018-09-19 19:16:31.783' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"service1\",\"Id\":1296,\"PropertyTypeIds\":[69,68,67],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1310, CAST(N'2018-09-19 19:16:38.550' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1311, CAST(N'2018-09-19 19:17:05.983' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"home\",\"Id\":1270,\"PropertyTypeIds\":[47,61,64,65,66,62],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1312, CAST(N'2018-09-19 19:17:48.067' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1297]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1313, CAST(N'2018-09-19 19:18:03.197' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1314, CAST(N'2018-09-19 19:18:09.200' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1315, CAST(N'2018-09-19 19:18:10.510' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1316, CAST(N'2018-09-19 19:18:53.313' AS DateTime), N'[{"RefreshType":5,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1297,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null},{"RefreshType":5,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":1297,"JsonIds":null,"JsonIdCount":1,"JsonPayload":null},{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"service1\",\"Id\":1296,\"PropertyTypeIds\":[69,68,67],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":true,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 3)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1317, CAST(N'2018-09-19 19:19:51.147' AS DateTime), N'[{"RefreshType":4,"RefresherId":"35b16c25-a17e-45d7-bc8f-edab1dcc28d2","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"UniqueId\":\"4d4e3dca-c128-413f-9666-171ca2712125\",\"Id\":1298}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1318, CAST(N'2018-09-19 19:20:26.887' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"homeService\",\"Id\":1299,\"PropertyTypeIds\":[70,71,72],\"Type\":\"IContentType\",\"AliasChanged\":true,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":true}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1319, CAST(N'2018-09-19 19:20:42.550' AS DateTime), N'[{"RefreshType":4,"RefresherId":"6902e22c-9c10-483c-91f3-66b7cae9e2f5","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":null,"JsonIdCount":1,"JsonPayload":"[{\"Alias\":\"home\",\"Id\":1270,\"PropertyTypeIds\":[47,61,64,65,66,62],\"Type\":\"IContentType\",\"AliasChanged\":false,\"PropertyRemoved\":false,\"PropertyTypeAliasChanged\":false,\"DescendantPayloads\":[],\"WasDeleted\":false,\"IsNew\":false}]"}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1320, CAST(N'2018-09-19 19:21:10.263' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1300]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1321, CAST(N'2018-09-19 19:21:17.050' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1322, CAST(N'2018-09-19 19:21:58.887' AS DateTime), N'[{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1323, CAST(N'2018-09-19 19:22:10.690' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1324, CAST(N'2018-09-19 19:22:18.283' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P972/D2] 12439B918A864F7B948C11EE79DB8C49', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1325, CAST(N'2018-09-19 19:29:02.253' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1300]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1300]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P3744/D2] 962EFE3E5AED44E39104EE194E27C171', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1326, CAST(N'2018-09-19 19:29:24.210' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P3744/D2] 962EFE3E5AED44E39104EE194E27C171', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1327, CAST(N'2018-09-19 19:29:25.633' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P3744/D2] 962EFE3E5AED44E39104EE194E27C171', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1328, CAST(N'2018-09-19 19:31:58.173' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1269]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P3744/D2] 962EFE3E5AED44E39104EE194E27C171', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1329, CAST(N'2018-09-19 19:32:32.400' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P3744/D2] 962EFE3E5AED44E39104EE194E27C171', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1330, CAST(N'2018-09-19 19:32:54.603' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P3744/D2] 962EFE3E5AED44E39104EE194E27C171', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1331, CAST(N'2018-09-19 19:34:55.830' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P2636/D2] 508209CDA8F546BBBAA83E0EF39A935A', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1332, CAST(N'2018-09-19 19:34:57.353' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P2636/D2] 508209CDA8F546BBBAA83E0EF39A935A', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1333, CAST(N'2018-09-19 19:35:44.543' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P2636/D2] 508209CDA8F546BBBAA83E0EF39A935A', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1334, CAST(N'2018-09-19 19:36:00.953' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P2636/D2] 508209CDA8F546BBBAA83E0EF39A935A', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1335, CAST(N'2018-09-19 19:36:54.430' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P2636/D2] 508209CDA8F546BBBAA83E0EF39A935A', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1336, CAST(N'2018-09-19 19:36:57.513' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P2636/D2] 508209CDA8F546BBBAA83E0EF39A935A', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1337, CAST(N'2018-09-19 20:25:10.483' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1269]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P9588/D2] 6E96970267D744A4A9074F695850A925', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1338, CAST(N'2018-09-19 20:25:22.747' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P9588/D2] 6E96970267D744A4A9074F695850A925', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1339, CAST(N'2018-09-19 20:25:26.547' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P9588/D2] 6E96970267D744A4A9074F695850A925', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1340, CAST(N'2018-09-19 20:30:30.780' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1295]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P10124/D2] 4C347A6B42604778B6951D9E1BD0E7FE', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1341, CAST(N'2018-09-19 20:30:40.827' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P10124/D2] 4C347A6B42604778B6951D9E1BD0E7FE', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1342, CAST(N'2018-09-19 20:31:44.103' AS DateTime), N'[{"RefreshType":3,"RefresherId":"dd12b6a0-14b9-46e8-8800-c154f74047c8","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1269]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P10124/D2] 4C347A6B42604778B6951D9E1BD0E7FE', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1343, CAST(N'2018-09-19 20:31:50.977' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P10124/D2] 4C347A6B42604778B6951D9E1BD0E7FE', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1344, CAST(N'2018-09-19 20:31:52.490' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P10124/D2] 4C347A6B42604778B6951D9E1BD0E7FE', 1)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1345, CAST(N'2018-09-19 20:32:17.647' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null},{"RefreshType":3,"RefresherId":"27ab3022-3dfa-47b6-9119-5945bc88fd66","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P10124/D2] 4C347A6B42604778B6951D9E1BD0E7FE', 2)
INSERT [dbo].[umbracoCacheInstruction] ([id], [utcStamp], [jsonInstruction], [originated], [instructionCount]) VALUES (1346, CAST(N'2018-09-19 20:32:19.390' AS DateTime), N'[{"RefreshType":3,"RefresherId":"55698352-dfc5-4dbe-96bd-a4a0f6f77145","GuidId":"00000000-0000-0000-0000-000000000000","IntId":0,"JsonIds":"[1271]","JsonIdCount":1,"JsonPayload":null}]', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT [P10124/D2] 4C347A6B42604778B6951D9E1BD0E7FE', 1)
SET IDENTITY_INSERT [dbo].[umbracoCacheInstruction] OFF
SET IDENTITY_INSERT [dbo].[umbracoLanguage] ON 

INSERT [dbo].[umbracoLanguage] ([id], [languageISOCode], [languageCultureName]) VALUES (1, N'en-US', N'en-US')
SET IDENTITY_INSERT [dbo].[umbracoLanguage] OFF
SET IDENTITY_INSERT [dbo].[umbracoLock] ON 

INSERT [dbo].[umbracoLock] ([id], [value], [name]) VALUES (-331, 1, N'Servers')
SET IDENTITY_INSERT [dbo].[umbracoLock] OFF
SET IDENTITY_INSERT [dbo].[umbracoLog] ON 

INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1, 0, 0, CAST(N'2018-09-16 13:43:31.600' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (2, 0, 1051, CAST(N'2018-09-16 13:46:33.813' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (3, 0, 0, CAST(N'2018-09-16 13:48:51.590' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (4, 0, 1052, CAST(N'2018-09-16 14:17:59.803' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (5, 0, 0, CAST(N'2018-09-16 16:06:32.317' AS DateTime), N'New', N'Media '''' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (6, 0, 0, CAST(N'2018-09-16 16:08:47.390' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (7, 0, 0, CAST(N'2018-09-16 16:09:17.053' AS DateTime), N'New', N'Media ''pattern'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (8, 0, 0, CAST(N'2018-09-16 16:09:17.170' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (9, 0, 0, CAST(N'2018-09-16 16:09:17.303' AS DateTime), N'New', N'Media ''project-bg-pattern.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (10, 0, 0, CAST(N'2018-09-16 16:09:17.687' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (11, 0, 0, CAST(N'2018-09-16 16:09:17.950' AS DateTime), N'New', N'Media ''projects'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (12, 0, 0, CAST(N'2018-09-16 16:09:17.957' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (13, 0, 0, CAST(N'2018-09-16 16:09:17.970' AS DateTime), N'New', N'Media ''lat-project-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (14, 0, 0, CAST(N'2018-09-16 16:09:18.200' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (15, 0, 0, CAST(N'2018-09-16 16:09:18.297' AS DateTime), N'New', N'Media ''lat-project-10.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (16, 0, 0, CAST(N'2018-09-16 16:09:18.380' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (17, 0, 0, CAST(N'2018-09-16 16:09:18.490' AS DateTime), N'New', N'Media ''lat-project-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (18, 0, 0, CAST(N'2018-09-16 16:09:18.517' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (19, 0, 0, CAST(N'2018-09-16 16:09:18.633' AS DateTime), N'New', N'Media ''lat-project-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (20, 0, 0, CAST(N'2018-09-16 16:09:18.673' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (21, 0, 0, CAST(N'2018-09-16 16:09:18.770' AS DateTime), N'New', N'Media ''lat-project-4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (22, 0, 0, CAST(N'2018-09-16 16:09:18.803' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (23, 0, 0, CAST(N'2018-09-16 16:09:18.930' AS DateTime), N'New', N'Media ''lat-project-5.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (24, 0, 0, CAST(N'2018-09-16 16:09:18.973' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (25, 0, 0, CAST(N'2018-09-16 16:09:19.100' AS DateTime), N'New', N'Media ''lat-project-6.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (26, 0, 0, CAST(N'2018-09-16 16:09:19.150' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (27, 0, 0, CAST(N'2018-09-16 16:09:19.260' AS DateTime), N'New', N'Media ''lat-project-7.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (28, 0, 0, CAST(N'2018-09-16 16:09:19.293' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (29, 0, 0, CAST(N'2018-09-16 16:09:19.400' AS DateTime), N'New', N'Media ''lat-project-8.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (30, 0, 0, CAST(N'2018-09-16 16:09:19.443' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (31, 0, 0, CAST(N'2018-09-16 16:09:19.553' AS DateTime), N'New', N'Media ''lat-project-9.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (32, 0, 0, CAST(N'2018-09-16 16:09:19.600' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (33, 0, 0, CAST(N'2018-09-16 16:09:19.740' AS DateTime), N'New', N'Media ''v1-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (34, 0, 0, CAST(N'2018-09-16 16:09:19.773' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (35, 0, 0, CAST(N'2018-09-16 16:09:19.873' AS DateTime), N'New', N'Media ''v1-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (36, 0, 0, CAST(N'2018-09-16 16:09:19.927' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (37, 0, 0, CAST(N'2018-09-16 16:09:20.057' AS DateTime), N'New', N'Media ''v1-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (38, 0, 0, CAST(N'2018-09-16 16:09:20.093' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (39, 0, 0, CAST(N'2018-09-16 16:09:20.197' AS DateTime), N'New', N'Media ''v1-4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (40, 0, 0, CAST(N'2018-09-16 16:09:20.223' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (41, 0, 0, CAST(N'2018-09-16 16:09:20.323' AS DateTime), N'New', N'Media ''v1-5.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (42, 0, 0, CAST(N'2018-09-16 16:09:20.357' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (43, 0, 0, CAST(N'2018-09-16 16:09:20.540' AS DateTime), N'New', N'Media ''v1-6.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (44, 0, 0, CAST(N'2018-09-16 16:09:20.570' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (45, 0, 0, CAST(N'2018-09-16 16:09:20.657' AS DateTime), N'New', N'Media ''v1-7.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (46, 0, 0, CAST(N'2018-09-16 16:09:20.683' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (47, 0, 0, CAST(N'2018-09-16 16:09:20.803' AS DateTime), N'New', N'Media ''v1-8.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (48, 0, 0, CAST(N'2018-09-16 16:09:20.837' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (49, 0, 0, CAST(N'2018-09-16 16:09:20.950' AS DateTime), N'New', N'Media ''v1-9.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (50, 0, 0, CAST(N'2018-09-16 16:09:20.990' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (51, 0, 0, CAST(N'2018-09-16 16:09:21.090' AS DateTime), N'New', N'Media ''v2-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (52, 0, 0, CAST(N'2018-09-16 16:09:21.120' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (53, 0, 0, CAST(N'2018-09-16 16:09:21.240' AS DateTime), N'New', N'Media ''v2-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (54, 0, 0, CAST(N'2018-09-16 16:09:21.307' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (55, 0, 0, CAST(N'2018-09-16 16:09:21.563' AS DateTime), N'New', N'Media ''v2-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (56, 0, 0, CAST(N'2018-09-16 16:09:21.597' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (57, 0, 0, CAST(N'2018-09-16 16:09:21.687' AS DateTime), N'New', N'Media ''v2-4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (58, 0, 0, CAST(N'2018-09-16 16:09:21.713' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (59, 0, 0, CAST(N'2018-09-16 16:09:21.830' AS DateTime), N'New', N'Media ''v2-5.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (60, 0, 0, CAST(N'2018-09-16 16:09:21.863' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (61, 0, 0, CAST(N'2018-09-16 16:09:22.043' AS DateTime), N'New', N'Media ''v2-6.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (62, 0, 0, CAST(N'2018-09-16 16:09:22.073' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (63, 0, 0, CAST(N'2018-09-16 16:09:22.220' AS DateTime), N'New', N'Media ''v3-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (64, 0, 0, CAST(N'2018-09-16 16:09:22.277' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (65, 0, 0, CAST(N'2018-09-16 16:09:22.500' AS DateTime), N'New', N'Media ''v3-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (66, 0, 0, CAST(N'2018-09-16 16:09:22.557' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (67, 0, 0, CAST(N'2018-09-16 16:09:22.650' AS DateTime), N'New', N'Media ''v3-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (68, 0, 0, CAST(N'2018-09-16 16:09:22.700' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (69, 0, 0, CAST(N'2018-09-16 16:09:22.837' AS DateTime), N'New', N'Media ''v3-4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (70, 0, 0, CAST(N'2018-09-16 16:09:22.883' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (71, 0, 0, CAST(N'2018-09-16 16:09:23.037' AS DateTime), N'New', N'Media ''v3-5.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (72, 0, 0, CAST(N'2018-09-16 16:09:23.150' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (73, 0, 0, CAST(N'2018-09-16 16:09:23.303' AS DateTime), N'New', N'Media ''resources'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (74, 0, 0, CAST(N'2018-09-16 16:09:23.310' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (75, 0, 0, CAST(N'2018-09-16 16:09:23.320' AS DateTime), N'New', N'Media ''appoinment-image.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (76, 0, 0, CAST(N'2018-09-16 16:09:23.367' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (77, 0, 0, CAST(N'2018-09-16 16:09:23.513' AS DateTime), N'New', N'Media ''breadcrumb-bg-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (78, 0, 0, CAST(N'2018-09-16 16:09:23.570' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (79, 0, 0, CAST(N'2018-09-16 16:09:23.710' AS DateTime), N'New', N'Media ''breadcrumb-bg.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (80, 0, 0, CAST(N'2018-09-16 16:09:23.760' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (81, 0, 0, CAST(N'2018-09-16 16:09:23.873' AS DateTime), N'New', N'Media ''contact-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (82, 0, 0, CAST(N'2018-09-16 16:09:23.910' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (83, 0, 0, CAST(N'2018-09-16 16:09:24.010' AS DateTime), N'New', N'Media ''industry-covered-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (84, 0, 0, CAST(N'2018-09-16 16:09:24.053' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (85, 0, 0, CAST(N'2018-09-16 16:09:24.237' AS DateTime), N'New', N'Media ''industry-covered-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (86, 0, 0, CAST(N'2018-09-16 16:09:24.273' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (87, 0, 0, CAST(N'2018-09-16 16:09:24.400' AS DateTime), N'New', N'Media ''industry-covered-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (88, 0, 0, CAST(N'2018-09-16 16:09:24.450' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (89, 0, 0, CAST(N'2018-09-16 16:09:24.560' AS DateTime), N'New', N'Media ''industry-covered-4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (90, 0, 0, CAST(N'2018-09-16 16:09:24.583' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (91, 0, 0, CAST(N'2018-09-16 16:09:24.650' AS DateTime), N'New', N'Media ''logo.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (92, 0, 0, CAST(N'2018-09-16 16:09:24.667' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (93, 0, 0, CAST(N'2018-09-16 16:09:24.777' AS DateTime), N'New', N'Media ''map-marker.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (94, 0, 0, CAST(N'2018-09-16 16:09:24.790' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (95, 0, 0, CAST(N'2018-09-16 16:09:24.863' AS DateTime), N'New', N'Media ''our-logo.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (96, 0, 0, CAST(N'2018-09-16 16:09:24.877' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (97, 0, 0, CAST(N'2018-09-16 16:09:25.020' AS DateTime), N'New', N'Media ''services'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (98, 0, 0, CAST(N'2018-09-16 16:09:25.027' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (99, 0, 0, CAST(N'2018-09-16 16:09:25.043' AS DateTime), N'New', N'Media ''1.jpg'' was created')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (100, 0, 0, CAST(N'2018-09-16 16:09:25.077' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (101, 0, 0, CAST(N'2018-09-16 16:09:25.187' AS DateTime), N'New', N'Media ''2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (102, 0, 0, CAST(N'2018-09-16 16:09:25.210' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (103, 0, 0, CAST(N'2018-09-16 16:09:25.347' AS DateTime), N'New', N'Media ''3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (104, 0, 0, CAST(N'2018-09-16 16:09:25.387' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (105, 0, 0, CAST(N'2018-09-16 16:09:25.660' AS DateTime), N'New', N'Media ''4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (106, 0, 0, CAST(N'2018-09-16 16:09:25.700' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (107, 0, 0, CAST(N'2018-09-16 16:09:25.800' AS DateTime), N'New', N'Media ''5.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (108, 0, 0, CAST(N'2018-09-16 16:09:25.843' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (109, 0, 0, CAST(N'2018-09-16 16:09:25.943' AS DateTime), N'New', N'Media ''6.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (110, 0, 0, CAST(N'2018-09-16 16:09:25.977' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (111, 0, 0, CAST(N'2018-09-16 16:09:26.103' AS DateTime), N'New', N'Media ''shop'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (112, 0, 0, CAST(N'2018-09-16 16:09:26.110' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (113, 0, 0, CAST(N'2018-09-16 16:09:26.153' AS DateTime), N'New', N'Media ''1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (114, 0, 0, CAST(N'2018-09-16 16:09:26.183' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (115, 0, 0, CAST(N'2018-09-16 16:09:26.377' AS DateTime), N'New', N'Media ''2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (116, 0, 0, CAST(N'2018-09-16 16:09:26.400' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (117, 0, 0, CAST(N'2018-09-16 16:09:26.527' AS DateTime), N'New', N'Media ''3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (118, 0, 0, CAST(N'2018-09-16 16:09:26.560' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (119, 0, 0, CAST(N'2018-09-16 16:09:26.647' AS DateTime), N'New', N'Media ''4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (120, 0, 0, CAST(N'2018-09-16 16:09:26.673' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (121, 0, 0, CAST(N'2018-09-16 16:09:26.780' AS DateTime), N'New', N'Media ''5.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (122, 0, 0, CAST(N'2018-09-16 16:09:26.810' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (123, 0, 0, CAST(N'2018-09-16 16:09:26.927' AS DateTime), N'New', N'Media ''6.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (124, 0, 0, CAST(N'2018-09-16 16:09:26.973' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (125, 0, 0, CAST(N'2018-09-16 16:09:27.100' AS DateTime), N'New', N'Media ''7.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (126, 0, 0, CAST(N'2018-09-16 16:09:27.123' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (127, 0, 0, CAST(N'2018-09-16 16:09:27.213' AS DateTime), N'New', N'Media ''8.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (128, 0, 0, CAST(N'2018-09-16 16:09:27.237' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (129, 0, 0, CAST(N'2018-09-16 16:09:27.347' AS DateTime), N'New', N'Media ''9.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (130, 0, 0, CAST(N'2018-09-16 16:09:27.370' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (131, 0, 0, CAST(N'2018-09-16 16:09:27.467' AS DateTime), N'New', N'Media ''product-thumb-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (132, 0, 0, CAST(N'2018-09-16 16:09:27.497' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (133, 0, 0, CAST(N'2018-09-16 16:09:27.590' AS DateTime), N'New', N'Media ''product-thumb-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (134, 0, 0, CAST(N'2018-09-16 16:09:27.603' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (135, 0, 0, CAST(N'2018-09-16 16:09:27.693' AS DateTime), N'New', N'Media ''product-thumb-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (136, 0, 0, CAST(N'2018-09-16 16:09:27.710' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (137, 0, 0, CAST(N'2018-09-16 16:09:27.797' AS DateTime), N'New', N'Media ''review-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (138, 0, 0, CAST(N'2018-09-16 16:09:27.813' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (139, 0, 0, CAST(N'2018-09-16 16:09:27.897' AS DateTime), N'New', N'Media ''review-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (140, 0, 0, CAST(N'2018-09-16 16:09:27.920' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (141, 0, 0, CAST(N'2018-09-16 16:09:28.063' AS DateTime), N'New', N'Media ''single-product.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (142, 0, 0, CAST(N'2018-09-16 16:09:28.100' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (143, 0, 0, CAST(N'2018-09-16 16:09:28.193' AS DateTime), N'New', N'Media ''sidebar'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (144, 0, 0, CAST(N'2018-09-16 16:09:28.200' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (145, 0, 0, CAST(N'2018-09-16 16:09:28.210' AS DateTime), N'New', N'Media ''comment-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (146, 0, 0, CAST(N'2018-09-16 16:09:28.227' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (147, 0, 0, CAST(N'2018-09-16 16:09:28.333' AS DateTime), N'New', N'Media ''comment-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (148, 0, 0, CAST(N'2018-09-16 16:09:28.347' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (149, 0, 0, CAST(N'2018-09-16 16:09:28.450' AS DateTime), N'New', N'Media ''popular-post-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (150, 0, 0, CAST(N'2018-09-16 16:09:28.470' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (151, 0, 0, CAST(N'2018-09-16 16:09:28.580' AS DateTime), N'New', N'Media ''popular-post-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (152, 0, 0, CAST(N'2018-09-16 16:09:28.610' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (153, 0, 0, CAST(N'2018-09-16 16:09:28.710' AS DateTime), N'New', N'Media ''popular-post-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (154, 0, 0, CAST(N'2018-09-16 16:09:28.730' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (155, 0, 0, CAST(N'2018-09-16 16:09:28.867' AS DateTime), N'New', N'Media ''slides'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (156, 0, 0, CAST(N'2018-09-16 16:09:28.873' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (157, 0, 0, CAST(N'2018-09-16 16:09:28.887' AS DateTime), N'New', N'Media ''1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (158, 0, 0, CAST(N'2018-09-16 16:09:28.943' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (159, 0, 0, CAST(N'2018-09-16 16:09:29.167' AS DateTime), N'New', N'Media ''2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (160, 0, 0, CAST(N'2018-09-16 16:09:29.247' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (161, 0, 0, CAST(N'2018-09-16 16:09:30.060' AS DateTime), N'New', N'Media ''3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (162, 0, 0, CAST(N'2018-09-16 16:09:30.137' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (163, 0, 0, CAST(N'2018-09-16 16:09:30.833' AS DateTime), N'New', N'Media ''team'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (164, 0, 0, CAST(N'2018-09-16 16:09:30.840' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (165, 0, 0, CAST(N'2018-09-16 16:09:30.850' AS DateTime), N'New', N'Media ''1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (166, 0, 0, CAST(N'2018-09-16 16:09:30.873' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (167, 0, 0, CAST(N'2018-09-16 16:09:31.517' AS DateTime), N'New', N'Media ''2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (168, 0, 0, CAST(N'2018-09-16 16:09:31.563' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (169, 0, 0, CAST(N'2018-09-16 16:09:31.690' AS DateTime), N'New', N'Media ''3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (170, 0, 0, CAST(N'2018-09-16 16:09:31.803' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (171, 0, 0, CAST(N'2018-09-16 16:09:31.913' AS DateTime), N'New', N'Media ''4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (172, 0, 0, CAST(N'2018-09-16 16:09:31.940' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (173, 0, 0, CAST(N'2018-09-16 16:09:32.217' AS DateTime), N'New', N'Media ''5.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (174, 0, 0, CAST(N'2018-09-16 16:09:32.603' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (175, 0, 0, CAST(N'2018-09-16 16:09:32.713' AS DateTime), N'New', N'Media ''6.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (176, 0, 0, CAST(N'2018-09-16 16:09:32.753' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (177, 0, 0, CAST(N'2018-09-16 16:09:32.840' AS DateTime), N'New', N'Media ''testimonial'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (178, 0, 0, CAST(N'2018-09-16 16:09:32.870' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (179, 0, 0, CAST(N'2018-09-16 16:09:32.903' AS DateTime), N'New', N'Media ''1.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (180, 0, 0, CAST(N'2018-09-16 16:09:33.470' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (181, 0, 0, CAST(N'2018-09-16 16:09:33.607' AS DateTime), N'New', N'Media ''2.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (182, 0, 0, CAST(N'2018-09-16 16:09:33.633' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (183, 0, 0, CAST(N'2018-09-16 16:09:34.253' AS DateTime), N'New', N'Media ''3.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (184, 0, 0, CAST(N'2018-09-16 16:09:34.293' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (185, 0, 0, CAST(N'2018-09-16 16:09:34.397' AS DateTime), N'New', N'Media ''4.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (186, 0, 0, CAST(N'2018-09-16 16:09:34.440' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (187, 0, 0, CAST(N'2018-09-16 16:09:34.520' AS DateTime), N'New', N'Media ''5.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (188, 0, 0, CAST(N'2018-09-16 16:09:34.540' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (189, 0, 0, CAST(N'2018-09-16 16:09:34.660' AS DateTime), N'New', N'Media ''6.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (190, 0, 0, CAST(N'2018-09-16 16:09:34.677' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (191, 0, 0, CAST(N'2018-09-16 16:09:34.770' AS DateTime), N'New', N'Media ''7.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (192, 0, 0, CAST(N'2018-09-16 16:09:34.783' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (193, 0, 0, CAST(N'2018-09-16 16:09:34.870' AS DateTime), N'New', N'Media ''8.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (194, 0, 0, CAST(N'2018-09-16 16:09:34.883' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (195, 0, 0, CAST(N'2018-09-16 16:09:34.960' AS DateTime), N'New', N'Media ''sidebar-testi-1.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (196, 0, 0, CAST(N'2018-09-16 16:09:34.973' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (197, 0, 0, CAST(N'2018-09-16 16:09:35.067' AS DateTime), N'New', N'Media ''sidebar-testi-2.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (198, 0, 0, CAST(N'2018-09-16 16:09:35.083' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (199, 0, 0, CAST(N'2018-09-16 16:09:35.210' AS DateTime), N'New', N'Media ''about'' was created')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (200, 0, 0, CAST(N'2018-09-16 16:09:35.217' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (201, 0, 0, CAST(N'2018-09-16 16:09:35.227' AS DateTime), N'New', N'Media ''mission.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (202, 0, 0, CAST(N'2018-09-16 16:09:35.260' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (203, 0, 0, CAST(N'2018-09-16 16:09:35.347' AS DateTime), N'New', N'Media ''vision.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (204, 0, 0, CAST(N'2018-09-16 16:09:35.373' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (205, 0, 0, CAST(N'2018-09-16 16:09:35.477' AS DateTime), N'New', N'Media ''blog'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (206, 0, 0, CAST(N'2018-09-16 16:09:35.480' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (207, 0, 0, CAST(N'2018-09-16 16:09:35.490' AS DateTime), N'New', N'Media ''author.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (208, 0, 0, CAST(N'2018-09-16 16:09:35.510' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (209, 0, 0, CAST(N'2018-09-16 16:09:35.653' AS DateTime), N'New', N'Media ''blog-single.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (210, 0, 0, CAST(N'2018-09-16 16:09:35.687' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (211, 0, 0, CAST(N'2018-09-16 16:09:35.783' AS DateTime), N'New', N'Media ''caption-img.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (212, 0, 0, CAST(N'2018-09-16 16:09:35.810' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (213, 0, 0, CAST(N'2018-09-16 16:09:35.913' AS DateTime), N'New', N'Media ''comment-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (214, 0, 0, CAST(N'2018-09-16 16:09:35.933' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (215, 0, 0, CAST(N'2018-09-16 16:09:36.023' AS DateTime), N'New', N'Media ''comment-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (216, 0, 0, CAST(N'2018-09-16 16:09:36.037' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (217, 0, 0, CAST(N'2018-09-16 16:09:36.187' AS DateTime), N'New', N'Media ''lat-blog-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (218, 0, 0, CAST(N'2018-09-16 16:09:36.217' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (219, 0, 0, CAST(N'2018-09-16 16:09:36.313' AS DateTime), N'New', N'Media ''lat-blog-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (220, 0, 0, CAST(N'2018-09-16 16:09:36.340' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (221, 0, 0, CAST(N'2018-09-16 16:09:36.440' AS DateTime), N'New', N'Media ''v1-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (222, 0, 0, CAST(N'2018-09-16 16:09:36.463' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (223, 0, 0, CAST(N'2018-09-16 16:09:36.577' AS DateTime), N'New', N'Media ''v1-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (224, 0, 0, CAST(N'2018-09-16 16:09:36.607' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (225, 0, 0, CAST(N'2018-09-16 16:09:36.803' AS DateTime), N'New', N'Media ''v1-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (226, 0, 0, CAST(N'2018-09-16 16:09:36.837' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (227, 0, 0, CAST(N'2018-09-16 16:09:36.930' AS DateTime), N'New', N'Media ''v1-4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (228, 0, 0, CAST(N'2018-09-16 16:09:36.973' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (229, 0, 0, CAST(N'2018-09-16 16:09:37.090' AS DateTime), N'New', N'Media ''v2-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (230, 0, 0, CAST(N'2018-09-16 16:09:37.113' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (231, 0, 0, CAST(N'2018-09-16 16:09:37.247' AS DateTime), N'New', N'Media ''v2-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (232, 0, 0, CAST(N'2018-09-16 16:09:37.283' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (233, 0, 0, CAST(N'2018-09-16 16:09:37.387' AS DateTime), N'New', N'Media ''v2-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (234, 0, 0, CAST(N'2018-09-16 16:09:37.413' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (235, 0, 0, CAST(N'2018-09-16 16:09:37.527' AS DateTime), N'New', N'Media ''v2-4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (236, 0, 0, CAST(N'2018-09-16 16:09:37.553' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (237, 0, 0, CAST(N'2018-09-16 16:09:37.697' AS DateTime), N'New', N'Media ''v2-5.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (238, 0, 0, CAST(N'2018-09-16 16:09:37.847' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (239, 0, 0, CAST(N'2018-09-16 16:09:37.970' AS DateTime), N'New', N'Media ''v2-6.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (240, 0, 0, CAST(N'2018-09-16 16:09:38.007' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (241, 0, 0, CAST(N'2018-09-16 16:09:38.137' AS DateTime), N'New', N'Media ''v3-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (242, 0, 0, CAST(N'2018-09-16 16:09:38.193' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (243, 0, 0, CAST(N'2018-09-16 16:09:38.390' AS DateTime), N'New', N'Media ''v3-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (244, 0, 0, CAST(N'2018-09-16 16:09:38.467' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (245, 0, 0, CAST(N'2018-09-16 16:09:38.690' AS DateTime), N'New', N'Media ''v3-3.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (246, 0, 0, CAST(N'2018-09-16 16:09:38.733' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (247, 0, 0, CAST(N'2018-09-16 16:09:38.850' AS DateTime), N'New', N'Media ''v3-4.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (248, 0, 0, CAST(N'2018-09-16 16:09:38.890' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (249, 0, 0, CAST(N'2018-09-16 16:09:38.990' AS DateTime), N'New', N'Media ''brand'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (250, 0, 0, CAST(N'2018-09-16 16:09:38.993' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (251, 0, 0, CAST(N'2018-09-16 16:09:39.003' AS DateTime), N'New', N'Media ''1.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (252, 0, 0, CAST(N'2018-09-16 16:09:39.020' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (253, 0, 0, CAST(N'2018-09-16 16:09:39.223' AS DateTime), N'New', N'Media ''2.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (254, 0, 0, CAST(N'2018-09-16 16:09:39.250' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (255, 0, 0, CAST(N'2018-09-16 16:09:39.373' AS DateTime), N'New', N'Media ''fancybox'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (256, 0, 0, CAST(N'2018-09-16 16:09:39.383' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (257, 0, 0, CAST(N'2018-09-16 16:09:39.397' AS DateTime), N'New', N'Media ''blank.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (258, 0, 0, CAST(N'2018-09-16 16:09:39.453' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (259, 0, 0, CAST(N'2018-09-16 16:09:39.540' AS DateTime), N'New', N'Media ''fancybox_loading.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (260, 0, 0, CAST(N'2018-09-16 16:09:39.557' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (261, 0, 0, CAST(N'2018-09-16 16:09:39.660' AS DateTime), N'New', N'Media ''fancybox_loading@2x.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (262, 0, 0, CAST(N'2018-09-16 16:09:39.680' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (263, 0, 0, CAST(N'2018-09-16 16:09:39.787' AS DateTime), N'New', N'Media ''fancybox_overlay.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (264, 0, 0, CAST(N'2018-09-16 16:09:39.803' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (265, 0, 0, CAST(N'2018-09-16 16:09:39.887' AS DateTime), N'New', N'Media ''fancybox_sprite.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (266, 0, 0, CAST(N'2018-09-16 16:09:39.903' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (267, 0, 0, CAST(N'2018-09-16 16:09:39.990' AS DateTime), N'New', N'Media ''fancybox_sprite@2x.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (268, 0, 0, CAST(N'2018-09-16 16:09:40.087' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (269, 0, 0, CAST(N'2018-09-16 16:09:40.187' AS DateTime), N'New', N'Media ''favicon'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (270, 0, 0, CAST(N'2018-09-16 16:09:40.193' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (271, 0, 0, CAST(N'2018-09-16 16:09:40.207' AS DateTime), N'New', N'Media ''apple-touch-icon.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (272, 0, 0, CAST(N'2018-09-16 16:09:40.233' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (273, 0, 0, CAST(N'2018-09-16 16:09:40.340' AS DateTime), N'New', N'Media ''favicon-16x16.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (274, 0, 0, CAST(N'2018-09-16 16:09:40.360' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (275, 0, 0, CAST(N'2018-09-16 16:09:40.463' AS DateTime), N'New', N'Media ''favicon-32x32.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (276, 0, 0, CAST(N'2018-09-16 16:09:40.487' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (277, 0, 0, CAST(N'2018-09-16 16:09:40.573' AS DateTime), N'New', N'Media ''footer'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (278, 0, 0, CAST(N'2018-09-16 16:09:40.607' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (279, 0, 0, CAST(N'2018-09-16 16:09:40.617' AS DateTime), N'New', N'Media ''footer-logo.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (280, 0, 0, CAST(N'2018-09-16 16:09:40.633' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (281, 0, 0, CAST(N'2018-09-16 16:09:40.760' AS DateTime), N'New', N'Media ''history'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (282, 0, 0, CAST(N'2018-09-16 16:09:40.767' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (283, 0, 0, CAST(N'2018-09-16 16:09:40.777' AS DateTime), N'New', N'Media ''1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (284, 0, 0, CAST(N'2018-09-16 16:09:40.810' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (285, 0, 0, CAST(N'2018-09-16 16:09:40.927' AS DateTime), N'New', N'Media ''2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (286, 0, 0, CAST(N'2018-09-16 16:09:40.957' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (287, 0, 0, CAST(N'2018-09-16 16:09:41.043' AS DateTime), N'New', N'Media ''icon'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (288, 0, 0, CAST(N'2018-09-16 16:09:41.047' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (289, 0, 0, CAST(N'2018-09-16 16:09:41.057' AS DateTime), N'New', N'Media ''bx_loader.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (290, 0, 0, CAST(N'2018-09-16 16:09:41.073' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (291, 0, 0, CAST(N'2018-09-16 16:09:41.193' AS DateTime), N'New', N'Media ''preloader.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (292, 0, 0, CAST(N'2018-09-16 16:09:41.230' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (293, 0, 0, CAST(N'2018-09-16 16:09:41.340' AS DateTime), N'New', N'Media ''submenu-icon.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (294, 0, 0, CAST(N'2018-09-16 16:09:41.353' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (295, 0, 0, CAST(N'2018-09-16 16:09:41.453' AS DateTime), N'New', N'Media ''tick.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (296, 0, 0, CAST(N'2018-09-16 16:09:41.467' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (297, 0, 0, CAST(N'2018-09-16 16:09:41.593' AS DateTime), N'New', N'Media ''parallax-background'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (298, 0, 0, CAST(N'2018-09-16 16:09:41.600' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (299, 0, 0, CAST(N'2018-09-16 16:09:41.610' AS DateTime), N'New', N'Media ''choose-bg.jpg'' was created')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (300, 0, 0, CAST(N'2018-09-16 16:09:41.643' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (301, 0, 0, CAST(N'2018-09-16 16:09:41.830' AS DateTime), N'New', N'Media ''consultation-bg.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (302, 0, 0, CAST(N'2018-09-16 16:09:41.873' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (303, 0, 0, CAST(N'2018-09-16 16:09:42.033' AS DateTime), N'New', N'Media ''contact-details-bg.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (304, 0, 0, CAST(N'2018-09-16 16:09:42.067' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (305, 0, 0, CAST(N'2018-09-16 16:09:42.260' AS DateTime), N'New', N'Media ''covered-bg.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (306, 0, 0, CAST(N'2018-09-16 16:09:42.353' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (307, 0, 0, CAST(N'2018-09-16 16:09:42.553' AS DateTime), N'New', N'Media ''service-about-bg.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (308, 0, 0, CAST(N'2018-09-16 16:09:42.613' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (309, 0, 0, CAST(N'2018-09-16 16:09:42.893' AS DateTime), N'New', N'Media ''slogan-bg.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (310, 0, 0, CAST(N'2018-09-16 16:09:42.943' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (311, 0, 0, CAST(N'2018-09-16 16:09:43.123' AS DateTime), N'New', N'Media ''testimonial-section-bg.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (312, 0, 0, CAST(N'2018-09-16 16:09:43.180' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (313, 0, 0, CAST(N'2018-09-16 16:09:43.297' AS DateTime), N'New', N'Media ''prettyPhoto'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (314, 0, 0, CAST(N'2018-09-16 16:09:43.320' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (315, 0, 0, CAST(N'2018-09-16 16:09:43.337' AS DateTime), N'New', N'Media ''dark_rounded'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (316, 0, 0, CAST(N'2018-09-16 16:09:43.343' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (317, 0, 0, CAST(N'2018-09-16 16:09:43.353' AS DateTime), N'New', N'Media ''btnNext.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (318, 0, 0, CAST(N'2018-09-16 16:09:43.370' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (319, 0, 0, CAST(N'2018-09-16 16:09:43.513' AS DateTime), N'New', N'Media ''btnPrevious.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (320, 0, 0, CAST(N'2018-09-16 16:09:43.537' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (321, 0, 0, CAST(N'2018-09-16 16:09:43.633' AS DateTime), N'New', N'Media ''contentPattern.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (322, 0, 0, CAST(N'2018-09-16 16:09:43.647' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (323, 0, 0, CAST(N'2018-09-16 16:09:43.787' AS DateTime), N'New', N'Media ''loader.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (324, 0, 0, CAST(N'2018-09-16 16:09:43.807' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (325, 0, 0, CAST(N'2018-09-16 16:09:43.903' AS DateTime), N'New', N'Media ''sprite.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (326, 0, 0, CAST(N'2018-09-16 16:09:43.920' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (327, 0, 0, CAST(N'2018-09-16 16:09:44.053' AS DateTime), N'New', N'Media ''dark_square'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (328, 0, 0, CAST(N'2018-09-16 16:09:44.060' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (329, 0, 0, CAST(N'2018-09-16 16:09:44.070' AS DateTime), N'New', N'Media ''btnNext.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (330, 0, 0, CAST(N'2018-09-16 16:09:44.087' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (331, 0, 0, CAST(N'2018-09-16 16:09:44.237' AS DateTime), N'New', N'Media ''btnPrevious.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (332, 0, 0, CAST(N'2018-09-16 16:09:44.257' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (333, 0, 0, CAST(N'2018-09-16 16:09:44.403' AS DateTime), N'New', N'Media ''loader.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (334, 0, 0, CAST(N'2018-09-16 16:09:44.423' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (335, 0, 0, CAST(N'2018-09-16 16:09:44.540' AS DateTime), N'New', N'Media ''sprite.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (336, 0, 0, CAST(N'2018-09-16 16:09:44.553' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (337, 0, 0, CAST(N'2018-09-16 16:09:44.680' AS DateTime), N'New', N'Media ''default'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (338, 0, 0, CAST(N'2018-09-16 16:09:44.690' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (339, 0, 0, CAST(N'2018-09-16 16:09:44.707' AS DateTime), N'New', N'Media ''default_thumb.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (340, 0, 0, CAST(N'2018-09-16 16:09:44.727' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (341, 0, 0, CAST(N'2018-09-16 16:09:44.843' AS DateTime), N'New', N'Media ''loader.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (342, 0, 0, CAST(N'2018-09-16 16:09:44.863' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (343, 0, 0, CAST(N'2018-09-16 16:09:44.987' AS DateTime), N'New', N'Media ''sprite.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (344, 0, 0, CAST(N'2018-09-16 16:09:45.003' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (345, 0, 0, CAST(N'2018-09-16 16:09:45.137' AS DateTime), N'New', N'Media ''sprite_next.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (346, 0, 0, CAST(N'2018-09-16 16:09:45.157' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (347, 0, 0, CAST(N'2018-09-16 16:09:45.293' AS DateTime), N'New', N'Media ''sprite_prev.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (348, 0, 0, CAST(N'2018-09-16 16:09:45.310' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (349, 0, 0, CAST(N'2018-09-16 16:09:45.420' AS DateTime), N'New', N'Media ''sprite_x.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (350, 0, 0, CAST(N'2018-09-16 16:09:45.440' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (351, 0, 0, CAST(N'2018-09-16 16:09:45.573' AS DateTime), N'New', N'Media ''sprite_y.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (352, 0, 0, CAST(N'2018-09-16 16:09:45.587' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (353, 0, 0, CAST(N'2018-09-16 16:09:45.770' AS DateTime), N'New', N'Media ''facebook'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (354, 0, 0, CAST(N'2018-09-16 16:09:45.777' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (355, 0, 0, CAST(N'2018-09-16 16:09:45.790' AS DateTime), N'New', N'Media ''btnNext.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (356, 0, 0, CAST(N'2018-09-16 16:09:45.803' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (357, 0, 0, CAST(N'2018-09-16 16:09:45.940' AS DateTime), N'New', N'Media ''btnPrevious.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (358, 0, 0, CAST(N'2018-09-16 16:09:45.990' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (359, 0, 0, CAST(N'2018-09-16 16:09:46.120' AS DateTime), N'New', N'Media ''contentPatternBottom.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (360, 0, 0, CAST(N'2018-09-16 16:09:46.137' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (361, 0, 0, CAST(N'2018-09-16 16:09:46.293' AS DateTime), N'New', N'Media ''contentPatternLeft.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (362, 0, 0, CAST(N'2018-09-16 16:09:46.307' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (363, 0, 0, CAST(N'2018-09-16 16:09:46.427' AS DateTime), N'New', N'Media ''contentPatternRight.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (364, 0, 0, CAST(N'2018-09-16 16:09:46.443' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (365, 0, 0, CAST(N'2018-09-16 16:09:46.563' AS DateTime), N'New', N'Media ''contentPatternTop.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (366, 0, 0, CAST(N'2018-09-16 16:09:46.577' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (367, 0, 0, CAST(N'2018-09-16 16:09:46.693' AS DateTime), N'New', N'Media ''default_thumbnail.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (368, 0, 0, CAST(N'2018-09-16 16:09:46.713' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (369, 0, 0, CAST(N'2018-09-16 16:09:46.843' AS DateTime), N'New', N'Media ''loader.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (370, 0, 0, CAST(N'2018-09-16 16:09:46.860' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (371, 0, 0, CAST(N'2018-09-16 16:09:47.080' AS DateTime), N'New', N'Media ''sprite.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (372, 0, 0, CAST(N'2018-09-16 16:09:47.173' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (373, 0, 0, CAST(N'2018-09-16 16:09:47.347' AS DateTime), N'New', N'Media ''light_rounded'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (374, 0, 0, CAST(N'2018-09-16 16:09:47.357' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (375, 0, 0, CAST(N'2018-09-16 16:09:47.370' AS DateTime), N'New', N'Media ''btnNext.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (376, 0, 0, CAST(N'2018-09-16 16:09:47.387' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (377, 0, 0, CAST(N'2018-09-16 16:09:47.493' AS DateTime), N'New', N'Media ''btnPrevious.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (378, 0, 0, CAST(N'2018-09-16 16:09:47.507' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (379, 0, 0, CAST(N'2018-09-16 16:09:47.640' AS DateTime), N'New', N'Media ''loader.gif'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (380, 0, 0, CAST(N'2018-09-16 16:09:47.657' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (381, 0, 0, CAST(N'2018-09-16 16:09:47.783' AS DateTime), N'New', N'Media ''sprite.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (382, 0, 0, CAST(N'2018-09-16 16:09:47.810' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (383, 0, 0, CAST(N'2018-09-16 16:09:47.940' AS DateTime), N'New', N'Media ''light_square'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (384, 0, 0, CAST(N'2018-09-16 16:09:47.947' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (385, 0, 0, CAST(N'2018-09-16 16:09:47.960' AS DateTime), N'New', N'Media ''btnNext.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (386, 0, 0, CAST(N'2018-09-16 16:09:47.973' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (387, 0, 0, CAST(N'2018-09-16 16:09:48.117' AS DateTime), N'New', N'Media ''btnPrevious.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (388, 0, 0, CAST(N'2018-09-16 16:09:48.140' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (389, 0, 0, CAST(N'2018-09-16 16:09:48.287' AS DateTime), N'New', N'Media ''sprite.png'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (390, 0, 0, CAST(N'2018-09-16 16:09:48.300' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (391, 0, 0, CAST(N'2018-09-16 16:09:48.727' AS DateTime), N'New', N'Media ''project-single'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (392, 0, 0, CAST(N'2018-09-16 16:09:48.730' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (393, 0, 0, CAST(N'2018-09-16 16:09:48.740' AS DateTime), N'New', N'Media ''1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (394, 0, 0, CAST(N'2018-09-16 16:09:48.860' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (395, 0, 0, CAST(N'2018-09-16 16:09:49.283' AS DateTime), N'New', N'Media ''graph-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (396, 0, 0, CAST(N'2018-09-16 16:09:49.333' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (397, 0, 0, CAST(N'2018-09-16 16:09:49.720' AS DateTime), N'New', N'Media ''graph-2.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (398, 0, 0, CAST(N'2018-09-16 16:09:49.773' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (399, 0, 0, CAST(N'2018-09-16 16:09:50.230' AS DateTime), N'New', N'Media ''project-analysis-bg.jpg'' was created')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (400, 0, 0, CAST(N'2018-09-16 16:09:50.353' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (401, 0, 0, CAST(N'2018-09-16 16:09:50.787' AS DateTime), N'New', N'Media ''project-result-bg.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (402, 0, 0, CAST(N'2018-09-16 16:09:50.857' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (403, 0, 0, CAST(N'2018-09-16 16:09:51.287' AS DateTime), N'New', N'Media ''service-single'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (404, 0, 0, CAST(N'2018-09-16 16:09:51.297' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (405, 0, 0, CAST(N'2018-09-16 16:09:51.307' AS DateTime), N'New', N'Media ''1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (406, 0, 0, CAST(N'2018-09-16 16:09:51.340' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (407, 0, 0, CAST(N'2018-09-16 16:09:51.523' AS DateTime), N'New', N'Media ''graph-1.jpg'' was created')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (408, 0, 0, CAST(N'2018-09-16 16:09:51.550' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (409, 0, 1255, CAST(N'2018-09-16 16:51:14.920' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (410, 0, 1052, CAST(N'2018-09-16 16:51:37.387' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (411, 0, 0, CAST(N'2018-09-16 16:52:04.440' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (412, 0, 1256, CAST(N'2018-09-16 16:52:16.757' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (413, 0, 1053, CAST(N'2018-09-16 16:55:15.977' AS DateTime), N'Save', N'Save Media performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (414, 0, 1257, CAST(N'2018-09-16 22:54:47.623' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (415, 0, 1255, CAST(N'2018-09-16 22:55:18.813' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (416, 0, 0, CAST(N'2018-09-16 23:01:37.197' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (417, 0, 0, CAST(N'2018-09-16 23:01:57.440' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (418, 0, 0, CAST(N'2018-09-16 23:02:36.303' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (419, 0, 0, CAST(N'2018-09-16 23:03:23.990' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (420, 0, 1257, CAST(N'2018-09-16 23:03:51.533' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (421, 0, 1257, CAST(N'2018-09-16 23:04:52.720' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (422, 0, -1, CAST(N'2018-09-16 23:33:53.607' AS DateTime), N'Delete', N'Delete Content of Types 1257 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (423, 0, 1257, CAST(N'2018-09-16 23:33:53.953' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (424, 0, 1262, CAST(N'2018-09-16 23:34:05.640' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (425, 0, 0, CAST(N'2018-09-16 23:49:34.463' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (426, 0, 1255, CAST(N'2018-09-16 23:50:12.537' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (427, 0, 1256, CAST(N'2018-09-16 23:56:04.413' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (428, 0, 1256, CAST(N'2018-09-16 23:56:04.437' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (429, 0, 1256, CAST(N'2018-09-16 23:56:04.663' AS DateTime), N'Delete', N'Trashed content with Id: 1256 related to original parent content with Id: -1')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (430, 0, 1255, CAST(N'2018-09-16 23:57:17.460' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (431, 0, 1255, CAST(N'2018-09-17 00:03:38.907' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (432, 0, 1255, CAST(N'2018-09-17 00:03:49.433' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (433, 0, 1256, CAST(N'2018-09-17 00:03:57.737' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (434, 0, 1256, CAST(N'2018-09-17 00:03:57.750' AS DateTime), N'Move', N'Move Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (435, 0, 0, CAST(N'2018-09-17 00:06:07.107' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (436, 0, 1264, CAST(N'2018-09-17 00:06:23.403' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (437, 0, 1264, CAST(N'2018-09-17 00:08:46.430' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (438, 0, 1255, CAST(N'2018-09-17 00:09:09.443' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (439, 0, 1255, CAST(N'2018-09-17 00:09:13.870' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (440, 0, 1256, CAST(N'2018-09-17 00:09:34.933' AS DateTime), N'Publish', N'Publish with Children performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (441, 0, 1256, CAST(N'2018-09-17 00:09:41.730' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (442, 0, 1256, CAST(N'2018-09-17 00:09:48.113' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (443, 0, 0, CAST(N'2018-09-17 00:17:22.540' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (444, 0, 1255, CAST(N'2018-09-17 00:17:28.277' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (445, 0, 1256, CAST(N'2018-09-17 00:17:46.023' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (446, 0, 1255, CAST(N'2018-09-17 00:23:01.643' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (447, 0, 1262, CAST(N'2018-09-17 00:24:12.860' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (448, 0, 1256, CAST(N'2018-09-17 00:37:35.590' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (449, 0, 1262, CAST(N'2018-09-17 00:41:51.110' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (450, 0, 1256, CAST(N'2018-09-17 00:42:08.323' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (451, 0, 1262, CAST(N'2018-09-17 00:52:54.957' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (452, 0, 1266, CAST(N'2018-09-17 01:36:03.510' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (453, 0, -1, CAST(N'2018-09-17 01:47:58.100' AS DateTime), N'Delete', N'Delete Content of Types 1266 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (454, 0, 1266, CAST(N'2018-09-17 01:47:58.303' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (455, 0, 1267, CAST(N'2018-09-17 01:48:19.403' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (456, 0, 1256, CAST(N'2018-09-17 01:48:29.353' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (457, 0, 1052, CAST(N'2018-09-17 03:24:31.003' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (458, 0, 1052, CAST(N'2018-09-17 03:24:54.733' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (459, 0, -1, CAST(N'2018-09-17 03:25:41.570' AS DateTime), N'Delete', N'Delete Content of Types 1267 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (460, 0, 1267, CAST(N'2018-09-17 03:25:41.787' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (461, 0, 1264, CAST(N'2018-09-17 03:27:05.577' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (462, 0, 1264, CAST(N'2018-09-17 03:27:05.593' AS DateTime), N'Move', N'Move Content to Recycle Bin performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (463, 0, 1256, CAST(N'2018-09-17 03:27:05.607' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (464, 0, 1256, CAST(N'2018-09-17 03:27:05.843' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (465, 0, -1, CAST(N'2018-09-17 03:27:05.843' AS DateTime), N'Delete', N'Delete Content of Types 1255 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (466, 0, 1255, CAST(N'2018-09-17 03:27:05.957' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (467, 0, 0, CAST(N'2018-09-17 03:28:05.167' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (468, 0, 0, CAST(N'2018-09-17 03:28:30.090' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (469, 0, 1270, CAST(N'2018-09-17 03:28:30.267' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (470, 0, 1269, CAST(N'2018-09-17 03:28:44.867' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (471, 0, 1269, CAST(N'2018-09-17 03:29:42.300' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (472, 0, 1264, CAST(N'2018-09-17 03:30:40.057' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (473, 0, 0, CAST(N'2018-09-17 03:32:49.580' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (474, 0, 1271, CAST(N'2018-09-17 03:43:12.353' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (475, 0, 1271, CAST(N'2018-09-17 04:05:34.020' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (476, 0, 1271, CAST(N'2018-09-17 04:05:56.430' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (477, 0, 0, CAST(N'2018-09-17 04:08:24.490' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (478, 0, 1273, CAST(N'2018-09-17 04:08:24.650' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (479, 0, -1, CAST(N'2018-09-17 04:10:32.217' AS DateTime), N'Delete', N'Delete Content of Types 1273 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (480, 0, 1273, CAST(N'2018-09-17 04:10:32.477' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (481, 0, 1262, CAST(N'2018-09-17 04:10:44.413' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (482, 0, -1, CAST(N'2018-09-17 04:12:41.230' AS DateTime), N'Delete', N'Delete Content of Types 1262 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (483, 0, 1262, CAST(N'2018-09-17 04:12:41.413' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (484, 0, 1271, CAST(N'2018-09-17 04:13:02.227' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (485, 0, 0, CAST(N'2018-09-17 04:14:00.597' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (486, 0, 0, CAST(N'2018-09-17 04:14:21.430' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (487, 0, 1048, CAST(N'2018-09-17 04:15:20.977' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (488, 0, 0, CAST(N'2018-09-17 04:15:27.933' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (489, 0, 1277, CAST(N'2018-09-17 04:15:28.157' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (490, 0, 1270, CAST(N'2018-09-17 04:15:43.293' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (491, 0, 1272, CAST(N'2018-09-17 04:15:57.517' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (492, 0, 1276, CAST(N'2018-09-17 04:16:22.893' AS DateTime), N'Delete', N'Delete Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (493, 0, 1269, CAST(N'2018-09-17 04:16:47.503' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (494, 0, 1271, CAST(N'2018-09-17 04:16:56.610' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (495, 0, 1269, CAST(N'2018-09-17 04:17:23.517' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (496, 0, 1271, CAST(N'2018-09-17 04:17:29.990' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (497, 0, 0, CAST(N'2018-09-17 04:20:01.067' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (498, 0, 1271, CAST(N'2018-09-17 04:20:21.933' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (499, 0, 1271, CAST(N'2018-09-17 04:20:26.347' AS DateTime), N'Save', N'Save Content performed by user')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (500, 0, 1269, CAST(N'2018-09-17 04:22:34.927' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (501, 0, 1271, CAST(N'2018-09-17 04:22:39.793' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (502, 0, 0, CAST(N'2018-09-17 04:29:50.323' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (503, 0, 1278, CAST(N'2018-09-17 04:30:04.290' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (504, 0, 0, CAST(N'2018-09-17 04:31:13.650' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (505, 0, 1278, CAST(N'2018-09-17 04:32:58.747' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (506, 0, 1279, CAST(N'2018-09-17 04:32:59.117' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (507, 0, 1280, CAST(N'2018-09-17 04:32:59.273' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (508, 0, 1271, CAST(N'2018-09-17 04:33:01.850' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (509, 0, 1271, CAST(N'2018-09-17 04:34:24.787' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (510, 0, 1278, CAST(N'2018-09-17 04:34:37.210' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (511, 0, 1278, CAST(N'2018-09-17 04:36:58.533' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (512, 0, 1279, CAST(N'2018-09-17 04:37:10.547' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (513, 0, 1271, CAST(N'2018-09-17 04:37:33.280' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (514, 0, 1271, CAST(N'2018-09-17 04:37:35.253' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (515, 0, 1269, CAST(N'2018-09-17 04:39:58.790' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (516, 0, 1269, CAST(N'2018-09-17 04:40:48.080' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1515, 0, 0, CAST(N'2018-09-19 02:06:27.887' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1516, 0, 0, CAST(N'2018-09-19 02:06:47.807' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1517, 0, 1283, CAST(N'2018-09-19 02:08:05.853' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1518, 0, 1283, CAST(N'2018-09-19 02:08:45.270' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1519, 0, 1284, CAST(N'2018-09-19 02:10:26.733' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1520, 0, 0, CAST(N'2018-09-19 02:11:30.443' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1521, 0, 0, CAST(N'2018-09-19 02:11:50.657' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1522, 0, 1284, CAST(N'2018-09-19 02:12:05.397' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1523, 0, 1283, CAST(N'2018-09-19 02:12:24.090' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1524, 0, 0, CAST(N'2018-09-19 23:56:59.833' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1525, 0, 1288, CAST(N'2018-09-19 23:57:27.200' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1526, 0, 1270, CAST(N'2018-09-19 23:57:49.417' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1527, 0, 0, CAST(N'2018-09-20 00:25:12.880' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1528, 0, 0, CAST(N'2018-09-20 00:26:16.417' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1529, 0, 1270, CAST(N'2018-09-20 00:26:33.320' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1530, 0, 0, CAST(N'2018-09-20 00:29:33.393' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1531, 0, 1271, CAST(N'2018-09-20 00:30:05.120' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1532, 0, 0, CAST(N'2018-09-20 00:31:59.280' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1533, 0, 1288, CAST(N'2018-09-20 00:32:27.743' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1534, 0, -1, CAST(N'2018-09-20 00:32:47.540' AS DateTime), N'Delete', N'Delete Content of Types 1284 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1535, 0, 1284, CAST(N'2018-09-20 00:32:47.867' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1536, 0, 0, CAST(N'2018-09-20 00:33:15.460' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1537, 0, 0, CAST(N'2018-09-20 00:33:47.267' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1538, 0, 1270, CAST(N'2018-09-20 00:34:31.953' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1539, 0, 0, CAST(N'2018-09-20 00:35:57.867' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1540, 0, 1271, CAST(N'2018-09-20 00:38:16.163' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1541, 0, 1269, CAST(N'2018-09-20 00:43:13.620' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1542, 0, 1271, CAST(N'2018-09-20 00:43:20.547' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1543, 0, 1271, CAST(N'2018-09-20 00:43:24.900' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1544, 0, 1278, CAST(N'2018-09-20 00:43:31.147' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1545, 0, 1279, CAST(N'2018-09-20 00:43:31.253' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1546, 0, 1280, CAST(N'2018-09-20 00:43:31.513' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1547, 0, 1291, CAST(N'2018-09-20 00:43:31.777' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1548, 0, 1295, CAST(N'2018-09-20 00:43:31.920' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1549, 0, 1269, CAST(N'2018-09-20 00:44:18.277' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1550, 0, 1271, CAST(N'2018-09-20 00:44:27.297' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1551, 0, 1283, CAST(N'2018-09-20 00:45:15.153' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1552, 0, 1271, CAST(N'2018-09-20 00:45:22.957' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1553, 0, 1271, CAST(N'2018-09-20 00:45:24.577' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1554, 0, 1291, CAST(N'2018-09-20 00:46:22.963' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1555, 0, 1291, CAST(N'2018-09-20 00:46:23.237' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1556, 0, -1, CAST(N'2018-09-20 00:46:23.237' AS DateTime), N'Delete', N'Delete Content of Types 1283 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1557, 0, 1283, CAST(N'2018-09-20 00:46:23.347' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1558, 0, 1296, CAST(N'2018-09-20 00:46:31.750' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1559, 0, 1271, CAST(N'2018-09-20 00:46:38.427' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1560, 0, 1270, CAST(N'2018-09-20 00:47:05.953' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1561, 0, 0, CAST(N'2018-09-20 00:47:47.980' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1562, 0, 1271, CAST(N'2018-09-20 00:48:03.143' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1563, 0, 1271, CAST(N'2018-09-20 00:48:09.143' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1564, 0, 1271, CAST(N'2018-09-20 00:48:10.480' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1565, 0, 1297, CAST(N'2018-09-20 00:48:52.820' AS DateTime), N'UnPublish', N'UnPublish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1566, 0, 1297, CAST(N'2018-09-20 00:48:52.947' AS DateTime), N'Delete', N'Delete Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1567, 0, -1, CAST(N'2018-09-20 00:48:52.947' AS DateTime), N'Delete', N'Delete Content of Types 1296 performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1568, 0, 1296, CAST(N'2018-09-20 00:48:53.083' AS DateTime), N'Delete', N'Delete ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1569, 0, 0, CAST(N'2018-09-20 00:49:51.123' AS DateTime), N'Save', N'Save DataTypeDefinition performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1570, 0, 1299, CAST(N'2018-09-20 00:50:26.857' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1571, 0, 1270, CAST(N'2018-09-20 00:50:42.540' AS DateTime), N'Save', N'Save ContentType performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1572, 0, 0, CAST(N'2018-09-20 00:51:10.163' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1573, 0, 1271, CAST(N'2018-09-20 00:51:16.960' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1574, 0, 1271, CAST(N'2018-09-20 00:51:58.803' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1575, 0, 1271, CAST(N'2018-09-20 00:52:10.600' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1576, 0, 1271, CAST(N'2018-09-20 00:52:18.210' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1577, 0, 1300, CAST(N'2018-09-20 00:59:01.923' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1578, 0, 1271, CAST(N'2018-09-20 00:59:24.100' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1579, 0, 1271, CAST(N'2018-09-20 00:59:25.400' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1580, 0, 1269, CAST(N'2018-09-20 01:01:58.143' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1581, 0, 1271, CAST(N'2018-09-20 01:02:32.277' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1582, 0, 1271, CAST(N'2018-09-20 01:02:54.367' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1583, 0, 1271, CAST(N'2018-09-20 01:04:55.557' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1584, 0, 1271, CAST(N'2018-09-20 01:04:57.160' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1585, 0, 1271, CAST(N'2018-09-20 01:05:44.387' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1586, 0, 1271, CAST(N'2018-09-20 01:06:00.730' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1587, 0, 1271, CAST(N'2018-09-20 01:06:54.313' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1588, 0, 1271, CAST(N'2018-09-20 01:06:57.380' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1589, 0, -1, CAST(N'2018-09-20 01:17:21.077' AS DateTime), N'Save', N'Save Script performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1590, 0, 1269, CAST(N'2018-09-20 01:55:10.387' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1591, 0, 1271, CAST(N'2018-09-20 01:55:22.477' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1592, 0, 1271, CAST(N'2018-09-20 01:55:26.460' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1593, 0, 1295, CAST(N'2018-09-20 02:00:30.330' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1594, 0, 1271, CAST(N'2018-09-20 02:00:40.747' AS DateTime), N'Save', N'Save Content performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1595, 0, 1269, CAST(N'2018-09-20 02:01:44.083' AS DateTime), N'Save', N'Save Template performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1596, 0, 1271, CAST(N'2018-09-20 02:01:50.793' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1597, 0, 1271, CAST(N'2018-09-20 02:01:52.443' AS DateTime), N'Save', N'Save Content performed by user')
GO
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1598, 0, 1271, CAST(N'2018-09-20 02:02:17.527' AS DateTime), N'Publish', N'Save and Publish performed by user')
INSERT [dbo].[umbracoLog] ([id], [userId], [NodeId], [Datestamp], [logHeader], [logComment]) VALUES (1599, 0, 1271, CAST(N'2018-09-20 02:02:19.333' AS DateTime), N'Save', N'Save Content performed by user')
SET IDENTITY_INSERT [dbo].[umbracoLog] OFF
SET IDENTITY_INSERT [dbo].[umbracoMigration] ON 

INSERT [dbo].[umbracoMigration] ([id], [name], [createDate], [version]) VALUES (1, N'Umbraco', CAST(N'2018-09-15 02:38:37.673' AS DateTime), N'7.12.2')
SET IDENTITY_INSERT [dbo].[umbracoMigration] OFF
SET IDENTITY_INSERT [dbo].[umbracoNode] ON 

INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-97, 0, -1, 0, 1, N'-1,-97', 2, N'aa2c52a0-ce87-4e65-a47c-7df09358585d', N'List View - Members', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.247' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-96, 0, -1, 0, 1, N'-1,-96', 2, N'3a0156c4-3b8c-4803-bdc1-6871faa83fff', N'List View - Media', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.243' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-95, 0, -1, 0, 1, N'-1,-95', 2, N'c0808dd3-8133-4e4b-8ce8-e2bea84a96a4', N'List View - Content', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.240' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-92, 0, -1, 0, 1, N'-1,-92', 35, N'f0bc4bfb-b499-40d6-ba86-058885a5178c', N'Label', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.217' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-90, 0, -1, 0, 1, N'-1,-90', 34, N'84c6b441-31df-4ffe-b67e-67d5bc3ae65a', N'Upload', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.220' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-89, 0, -1, 0, 1, N'-1,-89', 33, N'c6bac0dd-4ab9-45b1-8e30-e4b619ee5da3', N'Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.220' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-88, 0, -1, 0, 1, N'-1,-88', 32, N'0cc0eba1-9960-42c9-bf9b-60e150b429ae', N'Textstring', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.223' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-87, 0, -1, 0, 1, N'-1,-87', 4, N'ca90c950-0aff-4e72-b976-a30b1ac57dad', N'Richtext editor', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.223' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-51, 0, -1, 0, 1, N'-1,-51', 2, N'2e6d3631-066e-44b8-aec4-96f09099b2b5', N'Numeric', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.227' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-49, 0, -1, 0, 1, N'-1,-49', 2, N'92897bc6-a5f3-4ffe-ae27-f2e7e33dda49', N'Checkbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.227' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-43, 0, -1, 0, 1, N'-1,-43', 2, N'fbaf13a8-4036-41f2-93a3-974f678c312a', N'Checkbox list', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.230' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-42, 0, -1, 0, 1, N'-1,-42', 2, N'0b6a45e7-44ba-430d-9da5-4e46060b9e03', N'Dropdown', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.230' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-41, 0, -1, 0, 1, N'-1,-41', 2, N'5046194e-4237-453c-a547-15db3a07c4e1', N'Date Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.233' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-40, 0, -1, 0, 1, N'-1,-40', 2, N'bb5f57c9-ce2b-4bb9-b697-4caca783a805', N'Radiobox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.233' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-39, 0, -1, 0, 1, N'-1,-39', 2, N'f38f0ac7-1d27-439c-9f3f-089cd8825a53', N'Dropdown multiple', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.237' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-37, 0, -1, 0, 1, N'-1,-37', 2, N'0225af17-b302-49cb-9176-b9f35cab9c17', N'Approved Color', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.237' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-36, 0, -1, 0, 1, N'-1,-36', 2, N'e4d66c0f-b935-4200-81f0-025f7256b89a', N'Date Picker with time', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.240' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-21, 0, -1, 0, 0, N'-1,-21', 0, N'bf7c7cbc-952f-4518-97a2-69e9c7b33842', N'Recycle Bin', N'cf3d8e34-1c1c-41e9-ae56-878b57b32113', CAST(N'2018-09-15 02:38:34.213' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-20, 0, -1, 0, 0, N'-1,-20', 0, N'0f582a79-1e41-4cf0-bfa0-76340651891a', N'Recycle Bin', N'01bb7ff2-24dc-4c0c-95a2-c24ef72bbac8', CAST(N'2018-09-15 02:38:34.210' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (-1, 0, -1, 0, 0, N'-1', 0, N'916724a5-173d-4619-b97e-b9de133dd6f5', N'SYSTEM DATA: umbraco master root', N'ea7d8624-4cfe-4578-a871-24aa946bf34d', CAST(N'2018-09-15 02:38:34.177' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1031, 0, -1, 0, 1, N'-1,1031', 2, N'f38bd2d7-65d0-48e6-95dc-87ce06ec2d3d', N'Folder', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2018-09-15 02:38:34.247' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1032, 0, -1, 0, 1, N'-1,1032', 2, N'cc07b313-0843-4aa8-bbda-871c8da728c8', N'Image', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2018-09-15 02:38:34.253' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1033, 0, -1, 0, 1, N'-1,1033', 2, N'4c52d8ab-54e6-40cd-999c-7a5f24903e4d', N'File', N'4ea4382b-2f5a-4c2b-9587-ae9b3cf3602e', CAST(N'2018-09-15 02:38:34.253' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1041, 0, -1, 0, 1, N'-1,1041', 2, N'b6b73142-b9c1-4bf8-a16d-e1c23320b549', N'Tags', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.257' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1043, 0, -1, 0, 1, N'-1,1043', 2, N'1df9f033-e6d4-451f-b8d2-e0cbc50a836f', N'Image Cropper', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.260' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1044, 0, -1, 0, 1, N'-1,1044', 0, N'd59be02f-1df9-4228-aa1e-01917d806cda', N'Member', N'9b5416fb-e72f-45a9-a07b-5a9a2709ce43', CAST(N'2018-09-15 02:38:34.263' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1046, 0, -1, 0, 1, N'-1,1046', 2, N'fd1e0da5-5606-4862-b679-5d0cf3a52a59', N'Content Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.267' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1047, 0, -1, 0, 1, N'-1,1047', 2, N'1ea2e01f-ebd8-4ce1-8d71-6b1149e63548', N'Member Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.267' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1048, 0, -1, 0, 1, N'-1,1048', 2, N'135d60e0-64d9-49ed-ab08-893c9ba44ae5', N'Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.270' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1049, 0, -1, 0, 1, N'-1,1049', 2, N'9dbbcbbb-2327-434a-b355-af1b84e5010a', N'Multiple Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.273' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1050, 0, -1, 0, 1, N'-1,1050', 2, N'b4e3535a-1753-47e2-8568-602cf8cfee6f', N'Related Links', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-15 02:38:34.277' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1051, 0, -1, NULL, 1, N'-1,1051', 0, N'403434be-1a46-4b91-bd49-99e00861738c', N'Master', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2018-09-16 13:43:30.857' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1053, 0, -1, 0, 1, N'-1,1053', 0, N'40d633ed-6df4-45c2-bbe6-61df8e783431', N'images', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:08:47.150' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1054, 0, 1053, 0, 2, N'-1,1053,1054', 0, N'f21d2195-e76d-4272-b53d-73a9451fd633', N'pattern', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:17.060' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1055, 0, 1054, 0, 3, N'-1,1053,1054,1055', 0, N'674f8163-32d7-4f79-9f9e-c5b038098cc7', N'project-bg-pattern.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:17.650' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1056, 0, 1053, 0, 2, N'-1,1053,1056', 1, N'e5bd698c-057a-4aca-91d1-3f99c9bc9e1d', N'projects', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:17.950' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1057, 0, 1056, 0, 3, N'-1,1053,1056,1057', 0, N'e3dc6399-9a04-4890-a4bf-85046f5692ab', N'lat-project-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:18.190' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1058, 0, 1056, 0, 3, N'-1,1053,1056,1058', 1, N'71b50ae2-ece7-4a82-aaed-237139423de2', N'lat-project-10.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:18.357' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1059, 0, 1056, 0, 3, N'-1,1053,1056,1059', 2, N'465a3074-d513-479c-9095-e8ef3ef9fe20', N'lat-project-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:18.513' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1060, 0, 1056, 0, 3, N'-1,1053,1056,1060', 3, N'7f7309d7-5e7c-41e4-bb62-2d037a4d507f', N'lat-project-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:18.660' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1061, 0, 1056, 0, 3, N'-1,1053,1056,1061', 4, N'bbe177b4-1b8f-4c53-b475-aaefd2db18cf', N'lat-project-4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:18.797' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1062, 0, 1056, 0, 3, N'-1,1053,1056,1062', 5, N'5858ac14-9ff5-44b7-b551-328276750143', N'lat-project-5.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:18.967' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1063, 0, 1056, 0, 3, N'-1,1053,1056,1063', 6, N'3e246ed5-c48f-44df-b418-99e3157d3cc1', N'lat-project-6.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:19.133' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1064, 0, 1056, 0, 3, N'-1,1053,1056,1064', 7, N'de4c2300-171b-4ae7-8473-9e5c626df48a', N'lat-project-7.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:19.283' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1065, 0, 1056, 0, 3, N'-1,1053,1056,1065', 8, N'6ff8ccbf-8ed5-4363-8e59-85fe7e22490a', N'lat-project-8.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:19.430' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1066, 0, 1056, 0, 3, N'-1,1053,1056,1066', 9, N'b16d6d74-5a7d-48b3-8331-b0c5269847a6', N'lat-project-9.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:19.577' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1067, 0, 1056, 0, 3, N'-1,1053,1056,1067', 10, N'cbebb254-aa93-4b43-a7a9-fe55bb7b19dc', N'v1-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:19.767' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1068, 0, 1056, 0, 3, N'-1,1053,1056,1068', 11, N'949c6722-6ec0-4882-b535-ba18dde1feba', N'v1-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:19.900' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1069, 0, 1056, 0, 3, N'-1,1053,1056,1069', 12, N'ed89807b-6a0b-481f-9fd9-990685065896', N'v1-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:20.083' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1070, 0, 1056, 0, 3, N'-1,1053,1056,1070', 13, N'889efd71-083f-4f10-aa59-d748664cb399', N'v1-4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:20.217' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1071, 0, 1056, 0, 3, N'-1,1053,1056,1071', 14, N'1ffc9337-a198-4d85-a7c6-ee66a5c693ee', N'v1-5.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:20.350' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1072, 0, 1056, 0, 3, N'-1,1053,1056,1072', 15, N'2988036c-b259-4425-bff9-55f16e561404', N'v1-6.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:20.563' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1073, 0, 1056, 0, 3, N'-1,1053,1056,1073', 16, N'1e8a1123-b93d-43f9-8728-95b9e91da3bf', N'v1-7.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:20.677' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1074, 0, 1056, 0, 3, N'-1,1053,1056,1074', 17, N'9330c8d0-358c-446b-9bc3-d6619de3f38c', N'v1-8.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:20.830' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1075, 0, 1056, 0, 3, N'-1,1053,1056,1075', 18, N'816db59f-f3b6-4cf8-9a20-ce46f92ae0e6', N'v1-9.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:20.973' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1076, 0, 1056, 0, 3, N'-1,1053,1056,1076', 19, N'1471991f-c31c-4036-8098-deb22fe17886', N'v2-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:21.113' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1077, 0, 1056, 0, 3, N'-1,1053,1056,1077', 20, N'94c2966b-7264-417a-ab08-37be7ece5263', N'v2-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:21.283' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1078, 0, 1056, 0, 3, N'-1,1053,1056,1078', 21, N'57d474dd-5495-4ba8-87f4-a1d9f76363bb', N'v2-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:21.590' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1079, 0, 1056, 0, 3, N'-1,1053,1056,1079', 22, N'4b0713c1-0831-447e-b91d-cfc66ad3dc3c', N'v2-4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:21.707' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1080, 0, 1056, 0, 3, N'-1,1053,1056,1080', 23, N'3693872c-3776-4289-a000-df1326c3d803', N'v2-5.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:21.853' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1081, 0, 1056, 0, 3, N'-1,1053,1056,1081', 24, N'eadb320c-f385-478d-a543-448708183abe', N'v2-6.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:22.067' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1082, 0, 1056, 0, 3, N'-1,1053,1056,1082', 25, N'f8a7f18e-e0c3-4170-b85a-09dd2b3b2ead', N'v3-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:22.270' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1083, 0, 1056, 0, 3, N'-1,1053,1056,1083', 26, N'c3b724ab-c5f1-40ee-8ebf-32905b970e39', N'v3-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:22.550' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1084, 0, 1056, 0, 3, N'-1,1053,1056,1084', 27, N'e1605b42-7857-454c-855b-ad17402eb532', N'v3-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:22.693' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1085, 0, 1056, 0, 3, N'-1,1053,1056,1085', 28, N'49c56b21-23c4-4691-980f-19ecb17840de', N'v3-4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:22.877' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1086, 0, 1056, 0, 3, N'-1,1053,1056,1086', 29, N'a826cb57-03cf-4da0-ae73-4ea170c520ac', N'v3-5.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:23.130' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1087, 0, 1053, 0, 2, N'-1,1053,1087', 2, N'a019a9dc-4581-4c0d-8d76-88e16c291919', N'resources', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:23.307' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1088, 0, 1087, 0, 3, N'-1,1053,1087,1088', 0, N'd28d5456-faff-431d-9c6e-40a09cac2bdb', N'appoinment-image.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:23.357' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1089, 0, 1087, 0, 3, N'-1,1053,1087,1089', 1, N'569f55f3-075c-4536-9db9-30d492b29911', N'breadcrumb-bg-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:23.563' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1090, 0, 1087, 0, 3, N'-1,1053,1087,1090', 2, N'e3a36f1f-d575-444e-82b8-1b05ab3fe3d3', N'breadcrumb-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:23.750' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1091, 0, 1087, 0, 3, N'-1,1053,1087,1091', 3, N'93ced985-0f74-49e1-a5a3-9d3859ddaf22', N'contact-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:23.900' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1092, 0, 1087, 0, 3, N'-1,1053,1087,1092', 4, N'fd1c0f6e-eeae-4a22-962a-8da6c9a204aa', N'industry-covered-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:24.037' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1093, 0, 1087, 0, 3, N'-1,1053,1087,1093', 5, N'77e91be6-18b7-49d3-890c-0e0521b56e5e', N'industry-covered-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:24.260' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1094, 0, 1087, 0, 3, N'-1,1053,1087,1094', 6, N'229c3d10-a633-4d7b-bbe7-4cb9d9b76a45', N'industry-covered-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:24.443' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1095, 0, 1087, 0, 3, N'-1,1053,1087,1095', 7, N'652adcf9-c40c-4aba-a0cc-4e7f3ca2ef66', N'industry-covered-4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:24.580' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1096, 0, 1087, 0, 3, N'-1,1053,1087,1096', 8, N'400a2ecf-3728-4cf2-84d5-fa1e02cb8714', N'logo.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:24.660' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1097, 0, 1087, 0, 3, N'-1,1053,1087,1097', 9, N'1c52715b-c45e-48d3-aa2d-8e5a8ab59b62', N'map-marker.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:24.783' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1098, 0, 1087, 0, 3, N'-1,1053,1087,1098', 10, N'8196701d-db1d-4fd0-b29f-373be21069fc', N'our-logo.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:24.870' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1099, 0, 1053, 0, 2, N'-1,1053,1099', 3, N'45002333-aa2d-4204-b0d2-14b0a0fd5fdd', N'services', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:25.020' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1100, 0, 1099, 0, 3, N'-1,1053,1099,1100', 0, N'a664fdbe-44ac-44ee-8f64-322727ec457b', N'1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:25.070' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1101, 0, 1099, 0, 3, N'-1,1053,1099,1101', 1, N'c6ee1a81-aca8-445f-b589-74ec480c6bf4', N'2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:25.203' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1102, 0, 1099, 0, 3, N'-1,1053,1099,1102', 2, N'bf1f68ae-dd05-4a41-ae46-1cc586b6f234', N'3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:25.380' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1103, 0, 1099, 0, 3, N'-1,1053,1099,1103', 3, N'95152c4a-e146-46bf-8570-ac1333509c16', N'4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:25.690' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1104, 0, 1099, 0, 3, N'-1,1053,1099,1104', 4, N'54ff97b5-bc79-4509-88d1-f5b8995fb8a2', N'5.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:25.833' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1105, 0, 1099, 0, 3, N'-1,1053,1099,1105', 5, N'c62457c9-8498-4ca8-ba4f-3d70097d1758', N'6.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:25.967' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1106, 0, 1053, 0, 2, N'-1,1053,1106', 4, N'2905d24c-ed39-47b9-acaf-757dd7c31763', N'shop', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:26.107' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1107, 0, 1106, 0, 3, N'-1,1053,1106,1107', 0, N'a99902e7-fdab-4a89-abcd-af9375d793cb', N'1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:26.173' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1108, 0, 1106, 0, 3, N'-1,1053,1106,1108', 1, N'eeb0d363-7c80-4f31-8557-53ad78c03efa', N'2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:26.393' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1109, 0, 1106, 0, 3, N'-1,1053,1106,1109', 2, N'f20b5655-0b28-4c12-bdc0-dee2132e57c2', N'3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:26.557' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1110, 0, 1106, 0, 3, N'-1,1053,1106,1110', 3, N'fc8ba554-2153-4655-9790-6b0b9ec09aac', N'4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:26.670' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1111, 0, 1106, 0, 3, N'-1,1053,1106,1111', 4, N'c8d3cd5d-faa4-425d-9129-13df984228e0', N'5.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:26.803' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1112, 0, 1106, 0, 3, N'-1,1053,1106,1112', 5, N'2673a470-bfe1-4e79-b6ec-bd31769d5561', N'6.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:26.947' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1113, 0, 1106, 0, 3, N'-1,1053,1106,1113', 6, N'73409440-5ff2-47a4-8175-2af2aafd3499', N'7.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:27.113' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1114, 0, 1106, 0, 3, N'-1,1053,1106,1114', 7, N'976a0ac3-18d5-424d-bc2c-d727e7f585ea', N'8.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:27.230' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1115, 0, 1106, 0, 3, N'-1,1053,1106,1115', 8, N'6a69d917-8b68-4841-9c1c-12c4fce40d63', N'9.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:27.363' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1116, 0, 1106, 0, 3, N'-1,1053,1106,1116', 9, N'f8fccc63-55ff-47aa-a70e-932c9c106bd1', N'product-thumb-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:27.480' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1117, 0, 1106, 0, 3, N'-1,1053,1106,1117', 10, N'fd37dfeb-1065-496e-b24c-d31729696183', N'product-thumb-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:27.597' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1118, 0, 1106, 0, 3, N'-1,1053,1106,1118', 11, N'dbf14f23-68e1-4514-8f7e-93a9abc3e85f', N'product-thumb-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:27.703' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1119, 0, 1106, 0, 3, N'-1,1053,1106,1119', 12, N'7358d546-da92-4648-8865-56ba2a183d2e', N'review-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:27.807' AS DateTime))
GO
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1120, 0, 1106, 0, 3, N'-1,1053,1106,1120', 13, N'9d9044db-a89d-4c34-a793-729c3605b9c1', N'review-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:27.910' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1121, 0, 1106, 0, 3, N'-1,1053,1106,1121', 14, N'cc63b707-80c8-477b-93fb-1f6480b245f1', N'single-product.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:28.090' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1122, 0, 1053, 0, 2, N'-1,1053,1122', 5, N'39b1b24d-2ec7-4231-afb9-01eb6fd2356a', N'sidebar', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:28.197' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1123, 0, 1122, 0, 3, N'-1,1053,1122,1123', 0, N'89d6d352-79e9-45c6-bb58-6952fcf30c8d', N'comment-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:28.220' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1124, 0, 1122, 0, 3, N'-1,1053,1122,1124', 1, N'bb8ffa12-4d5a-4e0d-8290-3ab8149de34e', N'comment-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:28.343' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1125, 0, 1122, 0, 3, N'-1,1053,1122,1125', 2, N'5bb66d61-0157-4ecc-89d0-16203665a370', N'popular-post-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:28.463' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1126, 0, 1122, 0, 3, N'-1,1053,1122,1126', 3, N'024dc2eb-22db-4b95-b2df-799cdc9da6a0', N'popular-post-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:28.600' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1127, 0, 1122, 0, 3, N'-1,1053,1122,1127', 4, N'c5768ca8-dcca-4aa2-9729-69f9dd2455e8', N'popular-post-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:28.723' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1128, 0, 1053, 0, 2, N'-1,1053,1128', 6, N'a84cbd7d-cfe4-4a03-ad21-0c8ea2b401bf', N'slides', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:28.867' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1129, 0, 1128, 0, 3, N'-1,1053,1128,1129', 0, N'627ddaaf-c3fb-4073-b7b5-fb5e3cedc990', N'1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:28.937' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1130, 0, 1128, 0, 3, N'-1,1053,1128,1130', 1, N'a127a0aa-a19f-47e8-9648-3a0bfc93e5d5', N'2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:29.237' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1131, 0, 1128, 0, 3, N'-1,1053,1128,1131', 2, N'2109fcf6-c83d-4f30-9f3a-7f9ee2d23437', N'3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:30.130' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1132, 0, 1053, 0, 2, N'-1,1053,1132', 7, N'd6337ee0-a9eb-436a-91de-91d1420d8b91', N'team', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:30.837' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1133, 0, 1132, 0, 3, N'-1,1053,1132,1133', 0, N'005440ec-1bc8-44bf-934f-8adc19ca99c6', N'1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:30.867' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1134, 0, 1132, 0, 3, N'-1,1053,1132,1134', 1, N'0c7af131-0663-4707-95c7-be5aa703b3b7', N'2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:31.537' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1135, 0, 1132, 0, 3, N'-1,1053,1132,1135', 2, N'908cfd92-f04c-4f81-b4db-670bf3ccb479', N'3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:31.793' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1136, 0, 1132, 0, 3, N'-1,1053,1132,1136', 3, N'41dff995-0ef9-437d-a84d-7dda4d51dc59', N'4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:31.933' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1137, 0, 1132, 0, 3, N'-1,1053,1132,1137', 4, N'61513774-dc21-4ec6-b80a-796ac3fb8b0f', N'5.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:32.597' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1138, 0, 1132, 0, 3, N'-1,1053,1132,1138', 5, N'dc0424a8-c5e4-49ec-aa7a-cfc4211629b9', N'6.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:32.747' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1139, 0, 1053, 0, 2, N'-1,1053,1139', 8, N'e9e41d4c-33ff-4cff-8870-0cac8e1aeef9', N'testimonial', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:32.863' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1140, 0, 1139, 0, 3, N'-1,1053,1139,1140', 0, N'7db98dc3-da55-4526-bb22-55d6e4b586c3', N'1.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:33.463' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1141, 0, 1139, 0, 3, N'-1,1053,1139,1141', 1, N'b104fe14-5370-4910-bd79-42e3846a4956', N'2.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:33.627' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1142, 0, 1139, 0, 3, N'-1,1053,1139,1142', 2, N'7d474c43-565e-459a-96b4-319834779b34', N'3.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:34.283' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1143, 0, 1139, 0, 3, N'-1,1053,1139,1143', 3, N'41811d32-94fe-47b8-bdec-2c8c02bb940e', N'4.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:34.437' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1144, 0, 1139, 0, 3, N'-1,1053,1139,1144', 4, N'4b54eaa3-f260-4a73-ad85-114039789d8e', N'5.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:34.533' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1145, 0, 1139, 0, 3, N'-1,1053,1139,1145', 5, N'6a5d6260-4d29-464f-bbfc-7a5699ba33c2', N'6.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:34.670' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1146, 0, 1139, 0, 3, N'-1,1053,1139,1146', 6, N'2c4b5f3c-c8ae-4751-8323-2b48d12aa669', N'7.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:34.777' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1147, 0, 1139, 0, 3, N'-1,1053,1139,1147', 7, N'c9571a22-9f9e-4a1f-8259-e9716d7a14c3', N'8.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:34.877' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1148, 0, 1139, 0, 3, N'-1,1053,1139,1148', 8, N'9141b820-8ca5-4085-85bd-db86f6ffd763', N'sidebar-testi-1.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:34.967' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1149, 0, 1139, 0, 3, N'-1,1053,1139,1149', 9, N'53379b98-de52-4ea2-80f1-bee846d4b169', N'sidebar-testi-2.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:35.077' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1150, 0, 1053, 0, 2, N'-1,1053,1150', 9, N'd1c1a46e-4824-4e10-b670-61e79334b67f', N'about', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:35.213' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1151, 0, 1150, 0, 3, N'-1,1053,1150,1151', 0, N'3bbf9a68-6f6f-4cd9-899f-63b16a7ad798', N'mission.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:35.253' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1152, 0, 1150, 0, 3, N'-1,1053,1150,1152', 1, N'c997eea8-b444-494c-98f9-31e4d81110ad', N'vision.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:35.367' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1153, 0, 1053, 0, 2, N'-1,1053,1153', 10, N'b17739de-2ac5-49c5-9ef9-c68949741ffd', N'blog', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:35.477' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1154, 0, 1153, 0, 3, N'-1,1053,1153,1154', 0, N'7119cff9-3396-466c-abe3-a4b271cd700c', N'author.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:35.500' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1155, 0, 1153, 0, 3, N'-1,1053,1153,1155', 1, N'bb5bfaf2-8c46-4266-8141-fb4aee314681', N'blog-single.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:35.683' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1156, 0, 1153, 0, 3, N'-1,1053,1153,1156', 2, N'8609e8b1-5a26-4b3f-a67e-b2aa739b00dd', N'caption-img.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:35.803' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1157, 0, 1153, 0, 3, N'-1,1053,1153,1157', 3, N'c7e09603-9ae8-4f48-8adb-f7179bdc2ccd', N'comment-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:35.927' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1158, 0, 1153, 0, 3, N'-1,1053,1153,1158', 4, N'cc8631d8-af79-4733-aaf3-a24da95780f1', N'comment-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:36.030' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1159, 0, 1153, 0, 3, N'-1,1053,1153,1159', 5, N'3a8c48e2-c50d-459b-ab41-aebc1e9731a4', N'lat-blog-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:36.210' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1160, 0, 1153, 0, 3, N'-1,1053,1153,1160', 6, N'ef8be11e-b6c3-415a-9168-4c1876fb4831', N'lat-blog-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:36.333' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1161, 0, 1153, 0, 3, N'-1,1053,1153,1161', 7, N'5f7239a9-f9ad-4516-9802-deb0156161f2', N'v1-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:36.457' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1162, 0, 1153, 0, 3, N'-1,1053,1153,1162', 8, N'7e33164c-8529-427c-8274-99a36a2f6aa5', N'v1-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:36.600' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1163, 0, 1153, 0, 3, N'-1,1053,1153,1163', 9, N'389cc9b9-3571-49d8-ba51-b756a1d6ad75', N'v1-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:36.830' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1164, 0, 1153, 0, 3, N'-1,1053,1153,1164', 10, N'1f11c9d0-ce3f-4ac1-83ab-c1e9315908cf', N'v1-4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:36.953' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1165, 0, 1153, 0, 3, N'-1,1053,1153,1165', 11, N'f9f22d02-4be4-4dbd-ae65-e3e180f4f4b1', N'v2-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:37.110' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1166, 0, 1153, 0, 3, N'-1,1053,1153,1166', 12, N'5127e556-f353-45a4-a2a7-197714304fa3', N'v2-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:37.273' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1167, 0, 1153, 0, 3, N'-1,1053,1153,1167', 13, N'a4ddec46-1172-409a-aee5-a8ccb62ad443', N'v2-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:37.407' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1168, 0, 1153, 0, 3, N'-1,1053,1153,1168', 14, N'9507fabf-86fd-40b7-b9b3-0ffe9b8756a0', N'v2-4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:37.547' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1169, 0, 1153, 0, 3, N'-1,1053,1153,1169', 15, N'27de21c1-faa5-4441-a37a-a6c6a904fe5a', N'v2-5.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:37.837' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1170, 0, 1153, 0, 3, N'-1,1053,1153,1170', 16, N'74b44ba8-29e4-4bcd-9f70-bf8495d4d6ad', N'v2-6.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:37.997' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1171, 0, 1153, 0, 3, N'-1,1053,1153,1171', 17, N'815668b8-e91f-4cea-9881-d075d7969ea0', N'v3-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:38.187' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1172, 0, 1153, 0, 3, N'-1,1053,1153,1172', 18, N'7b3b12a6-d899-4b44-9649-2cf465bebf25', N'v3-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:38.437' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1173, 0, 1153, 0, 3, N'-1,1053,1153,1173', 19, N'1faad36d-9c81-49d5-9670-211f27268628', N'v3-3.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:38.727' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1174, 0, 1153, 0, 3, N'-1,1053,1153,1174', 20, N'1889605a-1d85-4aec-8fb3-ff050828a5da', N'v3-4.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:38.887' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1175, 0, 1053, 0, 2, N'-1,1053,1175', 11, N'0fb0e5e5-75e5-4d05-80b3-da9a8b6839cb', N'brand', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:38.990' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1176, 0, 1175, 0, 3, N'-1,1053,1175,1176', 0, N'3987c6df-cceb-4ec8-b901-5757f77aa74a', N'1.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:39.013' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1177, 0, 1175, 0, 3, N'-1,1053,1175,1177', 1, N'ca055297-dc59-411a-97ce-eb6944282e9f', N'2.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:39.237' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1178, 0, 1053, 0, 2, N'-1,1053,1178', 12, N'38c9d62d-a02a-40f6-97d4-5845e96ea06f', N'fancybox', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:39.373' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1179, 0, 1178, 0, 3, N'-1,1053,1178,1179', 0, N'eb8d5e72-81b4-4125-bd20-a5e05660b81b', N'blank.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:39.440' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1180, 0, 1178, 0, 3, N'-1,1053,1178,1180', 1, N'76c26402-d6ad-4cd1-9712-cf4edac35130', N'fancybox_loading.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:39.550' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1181, 0, 1178, 0, 3, N'-1,1053,1178,1181', 2, N'a049bbd6-9831-4662-a66a-a8c529f3e8d7', N'fancybox_loading@2x.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:39.673' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1182, 0, 1178, 0, 3, N'-1,1053,1178,1182', 3, N'6a4dc749-f7e2-4df5-85e1-d2823698f9a0', N'fancybox_overlay.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:39.793' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1183, 0, 1178, 0, 3, N'-1,1053,1178,1183', 4, N'35a797f7-2998-4fe0-96a0-a2344fad59d4', N'fancybox_sprite.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:39.897' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1184, 0, 1178, 0, 3, N'-1,1053,1178,1184', 5, N'b390390c-c8cb-4156-94c2-bb11d391fcae', N'fancybox_sprite@2x.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.077' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1185, 0, 1053, 0, 2, N'-1,1053,1185', 13, N'44e3c755-c3b8-49b8-8f0e-3b6403450c40', N'favicon', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.187' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1186, 0, 1185, 0, 3, N'-1,1053,1185,1186', 0, N'3216ffb0-b161-4409-ba11-a3e3ca02a277', N'apple-touch-icon.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.220' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1187, 0, 1185, 0, 3, N'-1,1053,1185,1187', 1, N'e500c50a-9acf-4516-a7b5-788da13a3b7c', N'favicon-16x16.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.353' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1188, 0, 1185, 0, 3, N'-1,1053,1185,1188', 2, N'5e3925f8-24cf-44b0-b341-c2b86cc162d7', N'favicon-32x32.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.480' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1189, 0, 1053, 0, 2, N'-1,1053,1189', 14, N'c0833148-c30e-4faa-9603-e1a9a9b3ee14', N'footer', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.603' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1190, 0, 1189, 0, 3, N'-1,1053,1189,1190', 0, N'5322585c-48e6-4b22-950f-b5b227565d0b', N'footer-logo.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.627' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1191, 0, 1053, 0, 2, N'-1,1053,1191', 15, N'a513bc13-62f3-441c-9de3-8bc75516d564', N'history', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.760' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1192, 0, 1191, 0, 3, N'-1,1053,1191,1192', 0, N'9f24ee30-1d22-4d65-b2d3-eea9640fe49f', N'1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.803' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1193, 0, 1191, 0, 3, N'-1,1053,1191,1193', 1, N'51ba6c30-45dc-4dc0-9b7c-f810d0fb5dc7', N'2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:40.947' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1194, 0, 1053, 0, 2, N'-1,1053,1194', 16, N'c46d470e-95e7-4bfc-9a25-6160fbce5c66', N'icon', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:41.043' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1195, 0, 1194, 0, 3, N'-1,1053,1194,1195', 0, N'9f54430f-e57a-48c3-b356-78cc7c4ec314', N'bx_loader.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:41.070' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1196, 0, 1194, 0, 3, N'-1,1053,1194,1196', 1, N'35cae49f-3d39-4d10-9bca-0c2daa8a0c22', N'preloader.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:41.210' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1197, 0, 1194, 0, 3, N'-1,1053,1194,1197', 2, N'fac4d855-32cd-406e-a855-618a1a485390', N'submenu-icon.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:41.347' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1198, 0, 1194, 0, 3, N'-1,1053,1194,1198', 3, N'fdb908d6-b4ef-4d69-aaa7-44ccfe0c3cc8', N'tick.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:41.460' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1199, 0, 1053, 0, 2, N'-1,1053,1199', 17, N'0e3c1bc3-1521-457f-a08d-1e54ad99d795', N'parallax-background', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:41.597' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1200, 0, 1199, 0, 3, N'-1,1053,1199,1200', 0, N'470bc052-b314-40f9-af2f-99f395e79cbe', N'choose-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:41.640' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1201, 0, 1199, 0, 3, N'-1,1053,1199,1201', 1, N'67d4a302-cd61-4f6a-bcb6-9d27251cbea5', N'consultation-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:41.870' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1202, 0, 1199, 0, 3, N'-1,1053,1199,1202', 2, N'46c188f7-dc74-4076-8833-a3212a6c404f', N'contact-details-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:42.060' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1203, 0, 1199, 0, 3, N'-1,1053,1199,1203', 3, N'9dc4f434-2be5-4dde-9b5b-49a40c86b0f2', N'covered-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:42.343' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1204, 0, 1199, 0, 3, N'-1,1053,1199,1204', 4, N'60e1fb85-13b6-4aba-a9ac-1f01a04a5577', N'service-about-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:42.607' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1205, 0, 1199, 0, 3, N'-1,1053,1199,1205', 5, N'7a0ef724-0dbc-4025-a365-05620250a44f', N'slogan-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:42.933' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1206, 0, 1199, 0, 3, N'-1,1053,1199,1206', 6, N'f2381f26-8745-4163-9585-5a3752581ee6', N'testimonial-section-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:43.173' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1207, 0, 1053, 0, 2, N'-1,1053,1207', 18, N'5b141e33-3046-4721-acd6-dc08c005a2c8', N'prettyPhoto', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:43.307' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1208, 0, 1207, 0, 3, N'-1,1053,1207,1208', 0, N'210815c1-602f-44ca-9be0-088872a09296', N'dark_rounded', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:43.340' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1209, 0, 1208, 0, 4, N'-1,1053,1207,1208,1209', 0, N'f15fe131-2117-4821-b643-af188fe303cd', N'btnNext.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:43.363' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1210, 0, 1208, 0, 4, N'-1,1053,1207,1208,1210', 1, N'1b767f40-d048-4581-ac13-6238943c6283', N'btnPrevious.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:43.530' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1211, 0, 1208, 0, 4, N'-1,1053,1207,1208,1211', 2, N'8a6253ef-5d47-48a6-a45d-9e1979671497', N'contentPattern.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:43.640' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1212, 0, 1208, 0, 4, N'-1,1053,1207,1208,1212', 3, N'8558e140-6158-4548-ae9a-ff53dc2637c3', N'loader.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:43.800' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1213, 0, 1208, 0, 4, N'-1,1053,1207,1208,1213', 4, N'adc6e5b4-b723-4f58-8eb8-6de7367d3f65', N'sprite.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:43.913' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1214, 0, 1207, 0, 3, N'-1,1053,1207,1214', 1, N'3a81f9b8-07b8-4090-9123-0cc6fdc29370', N'dark_square', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:44.057' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1215, 0, 1214, 0, 4, N'-1,1053,1207,1214,1215', 0, N'fee4ce98-bff0-4d20-a0e3-634f5fca43e3', N'btnNext.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:44.077' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1216, 0, 1214, 0, 4, N'-1,1053,1207,1214,1216', 1, N'd779b41d-7ad3-422f-a88d-42a3b71d1baa', N'btnPrevious.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:44.250' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1217, 0, 1214, 0, 4, N'-1,1053,1207,1214,1217', 2, N'9e23a18a-1513-4772-84bd-b27b19e3f925', N'loader.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:44.417' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1218, 0, 1214, 0, 4, N'-1,1053,1207,1214,1218', 3, N'76e77602-0b73-4cba-8f31-eecd8034d73e', N'sprite.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:44.547' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1219, 0, 1207, 0, 3, N'-1,1053,1207,1219', 2, N'525b57ef-5526-43dc-9afe-d1466dcb905d', N'default', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:44.683' AS DateTime))
GO
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1220, 0, 1219, 0, 4, N'-1,1053,1207,1219,1220', 0, N'cdc99a5a-7888-45bb-8625-40aabfcf3793', N'default_thumb.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:44.717' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1221, 0, 1219, 0, 4, N'-1,1053,1207,1219,1221', 1, N'b7f2230f-59db-4622-bfe0-29fef4ff46c6', N'loader.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:44.857' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1222, 0, 1219, 0, 4, N'-1,1053,1207,1219,1222', 2, N'e31ebc82-8f00-4451-bf37-8718401d0787', N'sprite.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:44.997' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1223, 0, 1219, 0, 4, N'-1,1053,1207,1219,1223', 3, N'8bf0cac5-9672-4662-8854-ce129c12e27c', N'sprite_next.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:45.147' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1224, 0, 1219, 0, 4, N'-1,1053,1207,1219,1224', 4, N'53dc1b8a-94e5-451c-aec0-884bc887edb4', N'sprite_prev.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:45.303' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1225, 0, 1219, 0, 4, N'-1,1053,1207,1219,1225', 5, N'a7724e37-fa6e-453d-b1a9-c652ee49f961', N'sprite_x.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:45.430' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1226, 0, 1219, 0, 4, N'-1,1053,1207,1219,1226', 6, N'2764d3c8-5998-410e-b971-6f36dcc23fce', N'sprite_y.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:45.580' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1227, 0, 1207, 0, 3, N'-1,1053,1207,1227', 3, N'47fdd2d8-be5d-45e8-9063-16d8c3ade9fd', N'facebook', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:45.773' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1228, 0, 1227, 0, 4, N'-1,1053,1207,1227,1228', 0, N'304f9cfa-afbc-4f7c-8435-2c64644cd572', N'btnNext.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:45.797' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1229, 0, 1227, 0, 4, N'-1,1053,1207,1227,1229', 1, N'29aaa6a6-81d5-47f4-949d-9231c83435e7', N'btnPrevious.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:45.983' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1230, 0, 1227, 0, 4, N'-1,1053,1207,1227,1230', 2, N'03f9abdd-7cd0-46b5-b2a8-eb01408947f2', N'contentPatternBottom.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:46.127' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1231, 0, 1227, 0, 4, N'-1,1053,1207,1227,1231', 3, N'b6f137c5-307f-418f-99f1-678e4e555c09', N'contentPatternLeft.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:46.300' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1232, 0, 1227, 0, 4, N'-1,1053,1207,1227,1232', 4, N'423b332d-e142-481c-8d71-ccb4591fc8e1', N'contentPatternRight.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:46.437' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1233, 0, 1227, 0, 4, N'-1,1053,1207,1227,1233', 5, N'b5690127-40ff-4076-a30c-964875c80794', N'contentPatternTop.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:46.570' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1234, 0, 1227, 0, 4, N'-1,1053,1207,1227,1234', 6, N'1dd9dd4e-91c1-498e-a780-67908933106a', N'default_thumbnail.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:46.703' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1235, 0, 1227, 0, 4, N'-1,1053,1207,1227,1235', 7, N'62446f41-63ac-403b-bd28-8b957fe6baab', N'loader.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:46.853' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1236, 0, 1227, 0, 4, N'-1,1053,1207,1227,1236', 8, N'78c9cb4b-7b59-48a7-beec-1b03417566ab', N'sprite.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:47.110' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1237, 0, 1207, 0, 3, N'-1,1053,1207,1237', 4, N'1c617e69-055c-4510-a2f4-ff67a305cf43', N'light_rounded', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:47.347' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1238, 0, 1237, 0, 4, N'-1,1053,1207,1237,1238', 0, N'd8509b5a-9c0c-4279-a8dc-ee6108f5120c', N'btnNext.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:47.377' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1239, 0, 1237, 0, 4, N'-1,1053,1207,1237,1239', 1, N'895a8375-87d3-46c7-b2c3-8c9a198bb9a1', N'btnPrevious.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:47.500' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1240, 0, 1237, 0, 4, N'-1,1053,1207,1237,1240', 2, N'3f44b913-6eec-4042-b490-70b610a3188b', N'loader.gif', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:47.650' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1241, 0, 1237, 0, 4, N'-1,1053,1207,1237,1241', 3, N'892f673d-910b-4bea-838c-7b6f36c3476e', N'sprite.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:47.797' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1242, 0, 1207, 0, 3, N'-1,1053,1207,1242', 5, N'bee20b7f-a310-46fa-9762-205cdccaf344', N'light_square', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:47.943' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1243, 0, 1242, 0, 4, N'-1,1053,1207,1242,1243', 0, N'ea5dcff5-7c31-46a4-8a77-3b99f35eb34b', N'btnNext.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:47.970' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1244, 0, 1242, 0, 4, N'-1,1053,1207,1242,1244', 1, N'159a798d-64fd-4a9b-bea5-ae81771652d3', N'btnPrevious.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:48.130' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1245, 0, 1242, 0, 4, N'-1,1053,1207,1242,1245', 2, N'647d17ef-513b-435b-9462-0558d9927bf7', N'sprite.png', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:48.297' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1246, 0, 1056, 0, 3, N'-1,1053,1056,1246', 30, N'd464d68f-be23-4063-91f3-f671248dc479', N'project-single', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:48.727' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1247, 0, 1246, 0, 4, N'-1,1053,1056,1246,1247', 0, N'02e318f8-84b7-44fb-8d41-d479217172c0', N'1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:48.853' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1248, 0, 1246, 0, 4, N'-1,1053,1056,1246,1248', 1, N'4f9977b8-34eb-4bf7-80e7-d15c7e5728ef', N'graph-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:49.330' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1249, 0, 1246, 0, 4, N'-1,1053,1056,1246,1249', 2, N'54f14b94-08d0-43db-98ec-f49cf5c4c269', N'graph-2.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:49.763' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1250, 0, 1246, 0, 4, N'-1,1053,1056,1246,1250', 3, N'e960822d-eb7a-437e-a7f2-dc687b79661f', N'project-analysis-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:50.347' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1251, 0, 1246, 0, 4, N'-1,1053,1056,1246,1251', 4, N'7c317e38-e3e9-4d4f-b916-3d039ecafbe8', N'project-result-bg.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:50.850' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1252, 0, 1099, 0, 3, N'-1,1053,1099,1252', 6, N'81b873d8-60f0-4395-ae53-8a2fc33722d9', N'service-single', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:51.293' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1253, 0, 1252, 0, 4, N'-1,1053,1099,1252,1253', 0, N'7581c6b8-eb69-4fd0-a931-b93f3e6c26ad', N'1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:51.337' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1254, 0, 1252, 0, 4, N'-1,1053,1099,1252,1254', 1, N'2dfbe2ae-cd5e-418e-a84e-809615c310f8', N'graph-1.jpg', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', CAST(N'2018-09-16 16:09:51.543' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1258, 0, -1, 0, 1, N'-1,1258', 24, N'3680b98a-caed-41cc-b4d0-c48497ce5a0e', N'Slider - Slider Header - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-16 23:01:37.107' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1259, 0, -1, 0, 1, N'-1,1259', 25, N'e69d162b-10e1-419d-b5de-7877c889adc9', N'Slider - Slider Title - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-16 23:01:57.427' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1260, 0, -1, 0, 1, N'-1,1260', 26, N'c65e4ab1-3dff-46e1-929a-01147849a7e8', N'Slider - Slider Text - Textarea', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-16 23:02:36.257' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1261, 0, -1, 0, 1, N'-1,1261', 27, N'b9eb01c9-a81d-4a4e-985b-5391068a8192', N'Slider - Slide Image - Media Picker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-16 23:03:23.837' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1263, 0, -1, 0, 1, N'-1,1263', 28, N'63867956-9aa4-4946-8cdb-cbb5f2ee970b', N'Home - SliderData - Multinode Treepicker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-16 23:49:34.427' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1265, 0, -1, 0, 1, N'-1,1265', 29, N'a4478156-eeac-44d0-9330-7480394206e4', N'Home - Slider - Multinode Treepicker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-17 00:17:22.430' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1268, 0, -1, 0, 1, N'-1,1268', 30, N'ee20dc39-dcd5-435d-9c94-48e6c2e4ec8f', N'FeaturedSlides - Multinode Treepicker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-17 03:28:05.100' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1269, 0, 1051, NULL, 1, N'-1,1051,1269', 0, N'f815571c-e024-405f-9248-4137ea940bc1', N'Home', N'6fbde604-4178-42ce-a10b-8a2600a2f07d', CAST(N'2018-09-17 03:28:30.063' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1270, 0, -1, 0, 1, N'-1,1270', 12, N'06954b8e-ca53-4636-9c9b-6caa9c4d82c6', N'Home', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2018-09-17 03:28:30.227' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1271, 0, -1, 0, 1, N'-1,1271', 0, N'bc25b578-8c00-46a6-bf8e-f5ce6b885888', N'Home', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2018-09-17 03:32:49.483' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1274, 0, -1, 0, 1, N'-1,1274', 31, N'c0814614-0eea-4d95-8557-f0a327e95386', N'Slide - SlideHeader - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-17 04:14:00.540' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1275, 0, -1, 0, 1, N'-1,1275', 32, N'374828c0-bdcb-4e48-83a3-5c402f4290d0', N'Slide - SlideTitle - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-17 04:14:21.427' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1277, 0, -1, 0, 1, N'-1,1277', 1, N'8163ae21-d016-4f3e-a9b2-a92582d0fb77', N'Slide', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2018-09-17 04:15:28.087' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1278, 0, 1271, 0, 2, N'-1,1271,1278', 0, N'12a24e4a-c515-4aef-923b-82e996cfedf2', N'Slide1', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2018-09-17 04:20:01.007' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1279, 0, 1271, 0, 2, N'-1,1271,1279', 1, N'2eb3c6d7-8b16-45ce-a44b-30a3154514ab', N'Slide2', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2018-09-17 04:29:50.223' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1280, 0, 1271, 0, 2, N'-1,1271,1280', 2, N'3eb698d7-6f8f-47ac-a04e-0e74aee564ee', N'Slide3', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2018-09-17 04:31:13.490' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1281, 0, -1, 0, 1, N'-1,1281', 33, N'de1cf285-9ab5-4245-8d17-ef186bcecf09', N'Service - ServiceTitle - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-19 02:06:27.623' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1282, 0, -1, 0, 1, N'-1,1282', 34, N'067a2d90-f2c6-4d14-ba27-a085b27534fa', N'Service - ServiceText - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-19 02:06:47.800' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1285, 0, -1, 0, 1, N'-1,1285', 35, N'9c9eea0c-9836-423e-b23c-189d3a2441d2', N'HomeAboutUs - AboutUsTitle - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-19 02:11:30.440' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1286, 0, -1, 0, 1, N'-1,1286', 36, N'0047cf69-4d2e-4650-ada2-473101518d07', N'HomeAboutUs - AboutUsHeader - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-19 02:11:50.653' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1287, 0, -1, 0, 1, N'-1,1287', 37, N'56eeaa2f-a01f-45da-9765-e2bc25ccaad4', N'Testimonial - CustomerCity - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-19 23:56:59.790' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1288, 0, -1, 0, 1, N'-1,1288', 8, N'f2cefb0d-2956-44b9-ba2e-dd8a986f2210', N'Testimonial', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2018-09-19 23:57:27.160' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1289, 0, -1, 0, 1, N'-1,1289', 38, N'a0554a21-3198-49ea-869d-49d4716f51eb', N'Home - FeaturedServices - Multinode Treepicker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-20 00:25:12.813' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1290, 0, -1, 0, 1, N'-1,1290', 39, N'24b21041-b224-4f5b-afb0-de678c746100', N'Home - FeaturedTestimonial - Multinode Treepicker', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-20 00:26:16.367' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1292, 0, -1, 0, 1, N'-1,1292', 40, N'b4dd92c5-9bee-4f08-a13e-3a0e8dac49cb', N'Testimonial - CustomerName - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-20 00:31:59.217' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1293, 0, -1, 0, 1, N'-1,1293', 41, N'65dd8b49-619b-45f8-a4b0-39bbff5ecfc1', N'Home - AboutUsHeader - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-20 00:33:15.440' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1294, 0, -1, 0, 1, N'-1,1294', 42, N'eb5aefe0-38f6-46ce-9073-6b513f384aef', N'Home - AboutUsTitle - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-20 00:33:47.227' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1295, 0, 1271, 0, 2, N'-1,1271,1295', 4, N'247d941b-aded-4737-ad8a-a99150b3556b', N'Testimonial1', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2018-09-20 00:35:57.793' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1298, 0, -1, 0, 1, N'-1,1298', 43, N'4d4e3dca-c128-413f-9666-171ca2712125', N'HomeService - ServiceTitle - Textbox', N'30a2a501-1978-4ddb-a57b-f7efed43ba3c', CAST(N'2018-09-20 00:49:51.087' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1299, 0, -1, 0, 1, N'-1,1299', 3, N'cdb728bd-ab94-4932-9dd7-115d9490028a', N'HomeService', N'a2cb7800-f571-4787-9638-bc48539a0efb', CAST(N'2018-09-20 00:50:26.830' AS DateTime))
INSERT [dbo].[umbracoNode] ([id], [trashed], [parentID], [nodeUser], [level], [path], [sortOrder], [uniqueID], [text], [nodeObjectType], [createDate]) VALUES (1300, 0, 1271, 0, 2, N'-1,1271,1300', 5, N'8f6629d8-a586-44f8-a05e-56e96a401f6b', N'Service1', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', CAST(N'2018-09-20 00:51:10.107' AS DateTime))
SET IDENTITY_INSERT [dbo].[umbracoNode] OFF
SET IDENTITY_INSERT [dbo].[umbracoRelationType] ON 

INSERT [dbo].[umbracoRelationType] ([id], [typeUniqueId], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (1, N'4cbeb612-e689-3563-b755-bf3ede295433', 1, N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'Relate Document On Copy', N'relateDocumentOnCopy')
INSERT [dbo].[umbracoRelationType] ([id], [typeUniqueId], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (2, N'0cc3507c-66ab-3091-8913-3d998148e423', 0, N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'c66ba18e-eaf3-4cff-8a22-41b16d66a972', N'Relate Parent Document On Delete', N'relateParentDocumentOnDelete')
INSERT [dbo].[umbracoRelationType] ([id], [typeUniqueId], [dual], [parentObjectType], [childObjectType], [name], [alias]) VALUES (3, N'8307994f-faf2-3844-bab9-72d34514edf2', 0, N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', N'b796f64c-1f99-4ffb-b886-4bf4bc011a9c', N'Relate Parent Media Folder On Delete', N'relateParentMediaFolderOnDelete')
SET IDENTITY_INSERT [dbo].[umbracoRelationType] OFF
SET IDENTITY_INSERT [dbo].[umbracoServer] ON 

INSERT [dbo].[umbracoServer] ([id], [address], [computerName], [registeredDate], [lastNotifiedDate], [isActive], [isMaster]) VALUES (1, N'http://localhost:49965/umbraco', N'DESKTOP-TPT38UD//LM/W3SVC/2/ROOT', CAST(N'2018-09-15 02:39:14.240' AS DateTime), CAST(N'2018-09-21 20:03:01.680' AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[umbracoServer] OFF
SET IDENTITY_INSERT [dbo].[umbracoUser] ON 

INSERT [dbo].[umbracoUser] ([id], [userDisabled], [userNoConsole], [userName], [userLogin], [userPassword], [passwordConfig], [userEmail], [userLanguage], [securityStampToken], [failedLoginAttempts], [lastLockoutDate], [lastPasswordChangeDate], [lastLoginDate], [emailConfirmedDate], [invitedDate], [createDate], [updateDate], [avatar], [tourData]) VALUES (0, 0, 0, N'Ravi Patel', N'ravipatel2423@gmail.com', N'XPo4VSFUF12+3klzjy9iAg==RbJh6vSSrsov/iGRwwbRwtzqhpFhrpbhuhVPHCB9jsA=', N'{"hashAlgorithm":"HMACSHA256"}', N'ravipatel2423@gmail.com', N'en-US', N'7681198a-87df-4c4a-8d3c-8fd5e8966f2e', NULL, NULL, CAST(N'2018-09-15 02:38:39.247' AS DateTime), CAST(N'2018-09-20 01:50:52.437' AS DateTime), NULL, NULL, CAST(N'2018-09-15 02:38:36.457' AS DateTime), CAST(N'2018-09-20 01:50:52.437' AS DateTime), NULL, N'[{"alias":"umbIntroIntroduction","completed":false,"disabled":true}]')
SET IDENTITY_INSERT [dbo].[umbracoUser] OFF
INSERT [dbo].[umbracoUser2UserGroup] ([userId], [userGroupId]) VALUES (0, 1)
INSERT [dbo].[umbracoUser2UserGroup] ([userId], [userGroupId]) VALUES (0, 5)
SET IDENTITY_INSERT [dbo].[umbracoUserGroup] ON 

INSERT [dbo].[umbracoUserGroup] ([id], [userGroupAlias], [userGroupName], [userGroupDefaultPermissions], [createDate], [updateDate], [icon], [startContentId], [startMediaId]) VALUES (1, N'admin', N'Administrators', N'CADMOSKTPIURZ:5F7ï', CAST(N'2018-09-15 02:38:37.893' AS DateTime), CAST(N'2018-09-15 02:38:37.893' AS DateTime), N'icon-medal', -1, -1)
INSERT [dbo].[umbracoUserGroup] ([id], [userGroupAlias], [userGroupName], [userGroupDefaultPermissions], [createDate], [updateDate], [icon], [startContentId], [startMediaId]) VALUES (2, N'writer', N'Writers', N'CAH:F', CAST(N'2018-09-15 02:38:37.897' AS DateTime), CAST(N'2018-09-15 02:38:37.897' AS DateTime), N'icon-edit', -1, -1)
INSERT [dbo].[umbracoUserGroup] ([id], [userGroupAlias], [userGroupName], [userGroupDefaultPermissions], [createDate], [updateDate], [icon], [startContentId], [startMediaId]) VALUES (3, N'editor', N'Editors', N'CADMOSKTPUZ:5Fï', CAST(N'2018-09-15 02:38:37.897' AS DateTime), CAST(N'2018-09-15 02:38:37.897' AS DateTime), N'icon-tools', -1, -1)
INSERT [dbo].[umbracoUserGroup] ([id], [userGroupAlias], [userGroupName], [userGroupDefaultPermissions], [createDate], [updateDate], [icon], [startContentId], [startMediaId]) VALUES (4, N'translator', N'Translators', N'AF', CAST(N'2018-09-15 02:38:37.900' AS DateTime), CAST(N'2018-09-15 02:38:37.900' AS DateTime), N'icon-globe', -1, -1)
INSERT [dbo].[umbracoUserGroup] ([id], [userGroupAlias], [userGroupName], [userGroupDefaultPermissions], [createDate], [updateDate], [icon], [startContentId], [startMediaId]) VALUES (5, N'sensitiveData', N'Sensitive data', N'', CAST(N'2018-09-15 02:38:37.900' AS DateTime), CAST(N'2018-09-15 02:38:37.900' AS DateTime), N'icon-lock', -1, -1)
SET IDENTITY_INSERT [dbo].[umbracoUserGroup] OFF
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (1, N'content')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (1, N'developer')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (1, N'forms')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (1, N'media')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (1, N'member')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (1, N'settings')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (1, N'users')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (2, N'content')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (3, N'content')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (3, N'forms')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (3, N'media')
INSERT [dbo].[umbracoUserGroup2App] ([userGroupId], [app]) VALUES (4, N'translation')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'351a572d-b4bf-4a9a-9550-088090c56b30', 0, CAST(N'2018-09-16 18:25:45.210' AS DateTime), CAST(N'2018-09-16 18:40:28.540' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'a3a35474-8bc1-4e24-8328-17167a989d83', 0, CAST(N'2018-09-16 08:47:32.410' AS DateTime), CAST(N'2018-09-16 08:47:32.410' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'640ac1c8-607c-4a3c-9790-321c37c8e498', 0, CAST(N'2018-09-15 18:22:55.823' AS DateTime), CAST(N'2018-09-15 18:33:46.180' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'fc3adb8d-20fd-4a73-be6c-3ea90c256bbd', 0, CAST(N'2018-09-19 18:24:47.903' AS DateTime), CAST(N'2018-09-19 18:28:07.813' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'96c5224c-d892-4e8a-a4fe-4cbbbd5530a9', 0, CAST(N'2018-09-16 21:53:01.673' AS DateTime), CAST(N'2018-09-16 22:12:55.410' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'da1bddca-0457-425a-8c5f-4cccb669e1ae', 0, CAST(N'2018-09-18 20:26:28.913' AS DateTime), CAST(N'2018-09-18 20:41:27.837' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'00ed3aac-5db6-4cc2-a20a-6937bb35f92e', 0, CAST(N'2018-09-16 10:19:22.763' AS DateTime), CAST(N'2018-09-16 10:39:47.230' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'bc57db9d-de1c-44d4-ad6b-6a288a4f1053', 0, CAST(N'2018-09-16 22:35:03.757' AS DateTime), CAST(N'2018-09-16 23:23:43.093' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'ca4ef85f-ccc9-4ec5-91ce-71e93e3d40ad', 0, CAST(N'2018-09-19 20:20:52.553' AS DateTime), CAST(N'2018-09-19 20:34:09.197' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'd46c1c0a-1d1b-475c-9566-73173cf1430a', 0, CAST(N'2018-09-16 18:15:20.793' AS DateTime), CAST(N'2018-09-16 18:19:34.387' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'b771ebc3-7cf3-463d-9aa4-8246ef895bdc', 0, CAST(N'2018-09-16 17:57:12.650' AS DateTime), CAST(N'2018-09-16 18:04:17.630' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'b3779979-6110-42ad-aa6a-8e1de91d4e4a', 0, CAST(N'2018-09-16 11:20:22.497' AS DateTime), CAST(N'2018-09-16 11:24:27.353' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'df38d397-c2e6-416f-a660-9f0299adf31d', 0, CAST(N'2018-09-16 18:46:49.770' AS DateTime), CAST(N'2018-09-16 18:53:57.297' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'7eb3ebe8-aece-4db1-9e92-a420a1d39461', 0, CAST(N'2018-09-15 19:48:50.430' AS DateTime), CAST(N'2018-09-15 19:48:50.563' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'84b608a8-267b-45ce-b324-a4c7da5d7d1b', 0, CAST(N'2018-09-16 17:22:09.817' AS DateTime), CAST(N'2018-09-16 17:28:41.713' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'ebb8bac2-ca8f-4760-9cc7-ac051b8af159', 0, CAST(N'2018-09-16 17:29:57.390' AS DateTime), CAST(N'2018-09-16 17:35:53.520' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'ded637a0-36c9-4546-acba-bbd1a36c6971', 0, CAST(N'2018-09-14 21:08:41.940' AS DateTime), CAST(N'2018-09-14 21:10:46.373' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'9b8fa3ad-cad3-4bfe-8a7e-bf953ca17c67', 0, CAST(N'2018-09-17 18:37:42.553' AS DateTime), CAST(N'2018-09-17 18:37:43.240' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'8a5bc291-53a6-4cb6-bff2-c170fed009eb', 0, CAST(N'2018-09-16 08:07:38.520' AS DateTime), CAST(N'2018-09-16 08:26:55.237' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'05a585b3-72cc-4696-80f0-ccc75bba49f8', 0, CAST(N'2018-09-19 20:20:32.970' AS DateTime), CAST(N'2018-09-19 20:20:33.040' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'98e2813e-385a-4308-8cfa-d45797d0f49a', 0, CAST(N'2018-09-16 11:07:42.833' AS DateTime), CAST(N'2018-09-16 11:09:03.390' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'fba9a55f-8dcd-4181-9a41-e01aca16a783', 0, CAST(N'2018-09-16 18:09:23.473' AS DateTime), CAST(N'2018-09-16 18:12:16.693' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'7f9f74a6-31b6-4f18-a181-e47e3081be31', 0, CAST(N'2018-09-16 19:05:44.490' AS DateTime), CAST(N'2018-09-16 19:35:36.513' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'33852a76-d916-4a27-9cc6-ec1709ba80a1', 0, CAST(N'2018-09-16 19:58:33.420' AS DateTime), CAST(N'2018-09-16 20:28:42.097' AS DateTime), NULL, N'::1')
INSERT [dbo].[umbracoUserLogin] ([sessionId], [userId], [loggedInUtc], [lastValidatedUtc], [loggedOutUtc], [ipAddress]) VALUES (N'406c74f3-872a-4a41-888d-eef125c3a621', 0, CAST(N'2018-09-19 18:53:08.060' AS DateTime), CAST(N'2018-09-19 19:48:37.253' AS DateTime), NULL, N'::1')
/****** Object:  Index [IX_cmsContent]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContent] ON [dbo].[cmsContent]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentType]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContentType] ON [dbo].[cmsContentType]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsContentType_icon]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsContentType_icon] ON [dbo].[cmsContentType]
(
	[icon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentVersion_ContentId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsContentVersion_ContentId] ON [dbo].[cmsContentVersion]
(
	[ContentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsContentVersion_VersionId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsContentVersion_VersionId] ON [dbo].[cmsContentVersion]
(
	[VersionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDataType_nodeId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDataType_nodeId] ON [dbo].[cmsDataType]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDictionary_id]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDictionary_id] ON [dbo].[cmsDictionary]
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsDictionary_key]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsDictionary_key] ON [dbo].[cmsDictionary]
(
	[key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsDocument] ON [dbo].[cmsDocument]
(
	[nodeId] ASC,
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument_newest]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsDocument_newest] ON [dbo].[cmsDocument]
(
	[newest] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsDocument_published]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsDocument_published] ON [dbo].[cmsDocument]
(
	[published] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsMacro_UniqueId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacro_UniqueId] ON [dbo].[cmsMacro]
(
	[uniqueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMacroPropertyAlias]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroPropertyAlias] ON [dbo].[cmsMacro]
(
	[macroAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMacroProperty_Alias]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroProperty_Alias] ON [dbo].[cmsMacroProperty]
(
	[macro] ASC,
	[macroPropertyAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsMacroProperty_UniquePropertyId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMacroProperty_UniquePropertyId] ON [dbo].[cmsMacroProperty]
(
	[uniquePropertyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMedia]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsMedia] ON [dbo].[cmsMedia]
(
	[nodeId] ASC,
	[versionId] ASC,
	[mediaPath] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsMember_LoginName]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsMember_LoginName] ON [dbo].[cmsMember]
(
	[LoginName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_1]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyData_1] ON [dbo].[cmsPropertyData]
(
	[contentNodeId] ASC,
	[versionId] ASC,
	[propertytypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_2]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_2] ON [dbo].[cmsPropertyData]
(
	[versionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyData_3]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyData_3] ON [dbo].[cmsPropertyData]
(
	[propertytypeid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsPropertyTypeAlias]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsPropertyTypeAlias] ON [dbo].[cmsPropertyType]
(
	[Alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyTypeUniqueID]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyTypeUniqueID] ON [dbo].[cmsPropertyType]
(
	[UniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsPropertyTypeGroupUniqueID]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsPropertyTypeGroupUniqueID] ON [dbo].[cmsPropertyTypeGroup]
(
	[uniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsTags]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsTags] ON [dbo].[cmsTags]
(
	[tag] ASC,
	[group] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_cmsTaskType_alias]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_cmsTaskType_alias] ON [dbo].[cmsTaskType]
(
	[alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_cmsTemplate_nodeId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_cmsTemplate_nodeId] ON [dbo].[cmsTemplate]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoAccess_nodeId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoAccess_nodeId] ON [dbo].[umbracoAccess]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoAccessRule]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoAccessRule] ON [dbo].[umbracoAccessRule]
(
	[ruleValue] ASC,
	[ruleType] ASC,
	[accessId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoLanguage_languageISOCode]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoLanguage_languageISOCode] ON [dbo].[umbracoLanguage]
(
	[languageISOCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoLog]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoLog] ON [dbo].[umbracoLog]
(
	[NodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoMigration]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoMigration] ON [dbo].[umbracoMigration]
(
	[name] ASC,
	[version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeObjectType]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeObjectType] ON [dbo].[umbracoNode]
(
	[nodeObjectType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeParentId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeParentId] ON [dbo].[umbracoNode]
(
	[parentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoNodePath]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodePath] ON [dbo].[umbracoNode]
(
	[path] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeTrashed]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoNodeTrashed] ON [dbo].[umbracoNode]
(
	[trashed] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoNodeUniqueID]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoNodeUniqueID] ON [dbo].[umbracoNode]
(
	[uniqueID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoRedirectUrl]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRedirectUrl] ON [dbo].[umbracoRedirectUrl]
(
	[urlHash] ASC,
	[contentKey] ASC,
	[createDateUtc] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoRelation_parentChildType]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRelation_parentChildType] ON [dbo].[umbracoRelation]
(
	[parentId] ASC,
	[childId] ASC,
	[relType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoRelationType_alias]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRelationType_alias] ON [dbo].[umbracoRelationType]
(
	[alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoRelationType_name]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRelationType_name] ON [dbo].[umbracoRelationType]
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoRelationType_UniqueId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoRelationType_UniqueId] ON [dbo].[umbracoRelationType]
(
	[typeUniqueId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_computerName]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_computerName] ON [dbo].[umbracoServer]
(
	[computerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoServer_isActive]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoServer_isActive] ON [dbo].[umbracoServer]
(
	[isActive] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoUser_userLogin]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoUser_userLogin] ON [dbo].[umbracoUser]
(
	[userLogin] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoUserGroup_userGroupAlias]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoUserGroup_userGroupAlias] ON [dbo].[umbracoUserGroup]
(
	[userGroupAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_umbracoUserGroup_userGroupName]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoUserGroup_userGroupName] ON [dbo].[umbracoUserGroup]
(
	[userGroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoUser2NodePermission_nodeId]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE NONCLUSTERED INDEX [IX_umbracoUser2NodePermission_nodeId] ON [dbo].[umbracoUserGroup2NodePermission]
(
	[nodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_umbracoUserStartNode_startNodeType]    Script Date: 9/21/2018 8:06:16 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_umbracoUserStartNode_startNodeType] ON [dbo].[umbracoUserStartNode]
(
	[startNodeType] ASC,
	[startNode] ASC,
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroUseInEditor]  DEFAULT ('0') FOR [macroUseInEditor]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroRefreshRate]  DEFAULT ('0') FOR [macroRefreshRate]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroCacheByPage]  DEFAULT ('1') FOR [macroCacheByPage]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroCachePersonalized]  DEFAULT ('0') FOR [macroCachePersonalized]
GO
ALTER TABLE [dbo].[cmsMacro] ADD  CONSTRAINT [DF_cmsMacro_macroDontRender]  DEFAULT ('0') FOR [macroDontRender]
GO
ALTER TABLE [dbo].[cmsMacroProperty] ADD  CONSTRAINT [DF_cmsMacroProperty_macroPropertySortOrder]  DEFAULT ('0') FOR [macroPropertySortOrder]
GO
ALTER TABLE [dbo].[cmsMember] ADD  CONSTRAINT [DF_cmsMember_Email]  DEFAULT ('''') FOR [Email]
GO
ALTER TABLE [dbo].[cmsMember] ADD  CONSTRAINT [DF_cmsMember_LoginName]  DEFAULT ('''') FOR [LoginName]
GO
ALTER TABLE [dbo].[cmsMember] ADD  CONSTRAINT [DF_cmsMember_Password]  DEFAULT ('''') FOR [Password]
GO
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF_cmsTask_closed]  DEFAULT ('0') FOR [closed]
GO
ALTER TABLE [dbo].[cmsTask] ADD  CONSTRAINT [DF_cmsTask_DateTime]  DEFAULT (getdate()) FOR [DateTime]
GO
ALTER TABLE [dbo].[umbracoAccess] ADD  CONSTRAINT [DF_umbracoAccess_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[umbracoAccess] ADD  CONSTRAINT [DF_umbracoAccess_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[umbracoAccessRule] ADD  CONSTRAINT [DF_umbracoAccessRule_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[umbracoAccessRule] ADD  CONSTRAINT [DF_umbracoAccessRule_updateDate]  DEFAULT (getdate()) FOR [updateDate]
GO
ALTER TABLE [dbo].[umbracoConsent] ADD  CONSTRAINT [DF_umbracoConsent_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[umbracoExternalLogin] ADD  CONSTRAINT [DF_umbracoExternalLogin_createDate]  DEFAULT (getdate()) FOR [createDate]
GO
ALTER TABLE [dbo].[umbracoRelation] ADD  CONSTRAINT [DF_umbracoRelation_datetime]  DEFAULT (getdate()) FOR [datetime]
GO
ALTER TABLE [dbo].[cmsContent]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_cmsContentType_nodeId] FOREIGN KEY([contentType])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContent] CHECK CONSTRAINT [FK_cmsContent_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsContent]  WITH CHECK ADD  CONSTRAINT [FK_cmsContent_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContent] CHECK CONSTRAINT [FK_cmsContent_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType] CHECK CONSTRAINT [FK_cmsContentType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsContentType2ContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_child] FOREIGN KEY([childContentTypeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType2ContentType] CHECK CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_child]
GO
ALTER TABLE [dbo].[cmsContentType2ContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_parent] FOREIGN KEY([parentContentTypeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsContentType2ContentType] CHECK CONSTRAINT [FK_cmsContentType2ContentType_umbracoNode_parent]
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType] FOREIGN KEY([Id])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType]
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1] FOREIGN KEY([AllowedId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentTypeAllowedContentType] CHECK CONSTRAINT [FK_cmsContentTypeAllowedContentType_cmsContentType1]
GO
ALTER TABLE [dbo].[cmsContentVersion]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId] FOREIGN KEY([ContentId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentVersion] CHECK CONSTRAINT [FK_cmsContentVersion_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsContentXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsContentXml] CHECK CONSTRAINT [FK_cmsContentXml_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsDataType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDataType_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDataType] CHECK CONSTRAINT [FK_cmsDataType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsDataTypePreValues]  WITH CHECK ADD  CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId] FOREIGN KEY([datatypeNodeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDataTypePreValues] CHECK CONSTRAINT [FK_cmsDataTypePreValues_cmsDataType_nodeId]
GO
ALTER TABLE [dbo].[cmsDictionary]  WITH CHECK ADD  CONSTRAINT [FK_cmsDictionary_cmsDictionary_id] FOREIGN KEY([parent])
REFERENCES [dbo].[cmsDictionary] ([id])
GO
ALTER TABLE [dbo].[cmsDictionary] CHECK CONSTRAINT [FK_cmsDictionary_cmsDictionary_id]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_cmsTemplate_nodeId] FOREIGN KEY([templateId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_cmsTemplate_nodeId]
GO
ALTER TABLE [dbo].[cmsDocument]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocument_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocument] CHECK CONSTRAINT [FK_cmsDocument_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsContentType_nodeId] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_cmsTemplate_nodeId] FOREIGN KEY([templateNodeId])
REFERENCES [dbo].[cmsTemplate] ([nodeId])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_cmsTemplate_nodeId]
GO
ALTER TABLE [dbo].[cmsDocumentType]  WITH CHECK ADD  CONSTRAINT [FK_cmsDocumentType_umbracoNode_id] FOREIGN KEY([contentTypeNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsDocumentType] CHECK CONSTRAINT [FK_cmsDocumentType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsLanguageText]  WITH CHECK ADD  CONSTRAINT [FK_cmsLanguageText_cmsDictionary_id] FOREIGN KEY([UniqueId])
REFERENCES [dbo].[cmsDictionary] ([id])
GO
ALTER TABLE [dbo].[cmsLanguageText] CHECK CONSTRAINT [FK_cmsLanguageText_cmsDictionary_id]
GO
ALTER TABLE [dbo].[cmsLanguageText]  WITH CHECK ADD  CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id] FOREIGN KEY([languageId])
REFERENCES [dbo].[umbracoLanguage] ([id])
GO
ALTER TABLE [dbo].[cmsLanguageText] CHECK CONSTRAINT [FK_cmsLanguageText_umbracoLanguage_id]
GO
ALTER TABLE [dbo].[cmsMacroProperty]  WITH CHECK ADD  CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id] FOREIGN KEY([macro])
REFERENCES [dbo].[cmsMacro] ([id])
GO
ALTER TABLE [dbo].[cmsMacroProperty] CHECK CONSTRAINT [FK_cmsMacroProperty_cmsMacro_id]
GO
ALTER TABLE [dbo].[cmsMedia]  WITH CHECK ADD  CONSTRAINT [FK_cmsMedia_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMedia] CHECK CONSTRAINT [FK_cmsMedia_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsMedia]  WITH CHECK ADD  CONSTRAINT [FK_cmsMedia_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMedia] CHECK CONSTRAINT [FK_cmsMedia_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsMember]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember] CHECK CONSTRAINT [FK_cmsMember_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId] FOREIGN KEY([Member])
REFERENCES [dbo].[cmsMember] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_cmsMember_nodeId]
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id] FOREIGN KEY([MemberGroup])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMember2MemberGroup] CHECK CONSTRAINT [FK_cmsMember2MemberGroup_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_cmsContentType_nodeId] FOREIGN KEY([NodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsMemberType]  WITH CHECK ADD  CONSTRAINT [FK_cmsMemberType_umbracoNode_id] FOREIGN KEY([NodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsMemberType] CHECK CONSTRAINT [FK_cmsMemberType_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContent_nodeId]
GO
ALTER TABLE [dbo].[cmsPreviewXml]  WITH CHECK ADD  CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId] FOREIGN KEY([versionId])
REFERENCES [dbo].[cmsContentVersion] ([VersionId])
GO
ALTER TABLE [dbo].[cmsPreviewXml] CHECK CONSTRAINT [FK_cmsPreviewXml_cmsContentVersion_VersionId]
GO
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id] FOREIGN KEY([propertytypeid])
REFERENCES [dbo].[cmsPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_cmsPropertyType_id]
GO
ALTER TABLE [dbo].[cmsPropertyData]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyData_umbracoNode_id] FOREIGN KEY([contentNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyData] CHECK CONSTRAINT [FK_cmsPropertyData_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsContentType_nodeId] FOREIGN KEY([contentTypeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsDataType_nodeId] FOREIGN KEY([dataTypeId])
REFERENCES [dbo].[cmsDataType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsDataType_nodeId]
GO
ALTER TABLE [dbo].[cmsPropertyType]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id] FOREIGN KEY([propertyTypeGroupId])
REFERENCES [dbo].[cmsPropertyTypeGroup] ([id])
GO
ALTER TABLE [dbo].[cmsPropertyType] CHECK CONSTRAINT [FK_cmsPropertyType_cmsPropertyTypeGroup_id]
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup]  WITH CHECK ADD  CONSTRAINT [FK_cmsPropertyTypeGroup_cmsContentType_nodeId] FOREIGN KEY([contenttypeNodeId])
REFERENCES [dbo].[cmsContentType] ([nodeId])
GO
ALTER TABLE [dbo].[cmsPropertyTypeGroup] CHECK CONSTRAINT [FK_cmsPropertyTypeGroup_cmsContentType_nodeId]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsContent] FOREIGN KEY([nodeId])
REFERENCES [dbo].[cmsContent] ([nodeId])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsContent]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType] FOREIGN KEY([propertyTypeId])
REFERENCES [dbo].[cmsPropertyType] ([id])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsPropertyType]
GO
ALTER TABLE [dbo].[cmsTagRelationship]  WITH CHECK ADD  CONSTRAINT [FK_cmsTagRelationship_cmsTags_id] FOREIGN KEY([tagId])
REFERENCES [dbo].[cmsTags] ([id])
GO
ALTER TABLE [dbo].[cmsTagRelationship] CHECK CONSTRAINT [FK_cmsTagRelationship_cmsTags_id]
GO
ALTER TABLE [dbo].[cmsTags]  WITH CHECK ADD  CONSTRAINT [FK_cmsTags_cmsTags] FOREIGN KEY([ParentId])
REFERENCES [dbo].[cmsTags] ([id])
GO
ALTER TABLE [dbo].[cmsTags] CHECK CONSTRAINT [FK_cmsTags_cmsTags]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_cmsTaskType_id] FOREIGN KEY([taskTypeId])
REFERENCES [dbo].[cmsTaskType] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_cmsTaskType_id]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoNode_id]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser] FOREIGN KEY([parentUserId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser]
GO
ALTER TABLE [dbo].[cmsTask]  WITH CHECK ADD  CONSTRAINT [FK_cmsTask_umbracoUser1] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[cmsTask] CHECK CONSTRAINT [FK_cmsTask_umbracoUser1]
GO
ALTER TABLE [dbo].[cmsTemplate]  WITH CHECK ADD  CONSTRAINT [FK_cmsTemplate_umbracoNode] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[cmsTemplate] CHECK CONSTRAINT [FK_cmsTemplate_umbracoNode]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id1] FOREIGN KEY([loginNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id1]
GO
ALTER TABLE [dbo].[umbracoAccess]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccess_umbracoNode_id2] FOREIGN KEY([noAccessNodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoAccess] CHECK CONSTRAINT [FK_umbracoAccess_umbracoNode_id2]
GO
ALTER TABLE [dbo].[umbracoAccessRule]  WITH CHECK ADD  CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id] FOREIGN KEY([accessId])
REFERENCES [dbo].[umbracoAccess] ([id])
GO
ALTER TABLE [dbo].[umbracoAccessRule] CHECK CONSTRAINT [FK_umbracoAccessRule_umbracoAccess_id]
GO
ALTER TABLE [dbo].[umbracoDomains]  WITH CHECK ADD  CONSTRAINT [FK_umbracoDomains_umbracoNode_id] FOREIGN KEY([domainRootStructureID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoDomains] CHECK CONSTRAINT [FK_umbracoDomains_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoNode]  WITH CHECK ADD  CONSTRAINT [FK_umbracoNode_umbracoNode_id] FOREIGN KEY([parentID])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoNode] CHECK CONSTRAINT [FK_umbracoNode_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoRedirectUrl]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRedirectUrl_umbracoNode_uniqueID] FOREIGN KEY([contentKey])
REFERENCES [dbo].[umbracoNode] ([uniqueID])
GO
ALTER TABLE [dbo].[umbracoRedirectUrl] CHECK CONSTRAINT [FK_umbracoRedirectUrl_umbracoNode_uniqueID]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode] FOREIGN KEY([parentId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoNode1] FOREIGN KEY([childId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoNode1]
GO
ALTER TABLE [dbo].[umbracoRelation]  WITH CHECK ADD  CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id] FOREIGN KEY([relType])
REFERENCES [dbo].[umbracoRelationType] ([id])
GO
ALTER TABLE [dbo].[umbracoRelation] CHECK CONSTRAINT [FK_umbracoRelation_umbracoRelationType_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2NodeNotify] CHECK CONSTRAINT [FK_umbracoUser2NodeNotify_umbracoUser_id]
GO
ALTER TABLE [dbo].[umbracoUser2UserGroup]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2UserGroup_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2UserGroup] CHECK CONSTRAINT [FK_umbracoUser2UserGroup_umbracoUser_id]
GO
ALTER TABLE [dbo].[umbracoUser2UserGroup]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUser2UserGroup_umbracoUserGroup_id] FOREIGN KEY([userGroupId])
REFERENCES [dbo].[umbracoUserGroup] ([id])
GO
ALTER TABLE [dbo].[umbracoUser2UserGroup] CHECK CONSTRAINT [FK_umbracoUser2UserGroup_umbracoUserGroup_id]
GO
ALTER TABLE [dbo].[umbracoUserGroup]  WITH CHECK ADD  CONSTRAINT [FK_startContentId_umbracoNode_id] FOREIGN KEY([startContentId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUserGroup] CHECK CONSTRAINT [FK_startContentId_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUserGroup]  WITH CHECK ADD  CONSTRAINT [FK_startMediaId_umbracoNode_id] FOREIGN KEY([startMediaId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUserGroup] CHECK CONSTRAINT [FK_startMediaId_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUserGroup2App]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUserGroup2App_umbracoUserGroup_id] FOREIGN KEY([userGroupId])
REFERENCES [dbo].[umbracoUserGroup] ([id])
GO
ALTER TABLE [dbo].[umbracoUserGroup2App] CHECK CONSTRAINT [FK_umbracoUserGroup2App_umbracoUserGroup_id]
GO
ALTER TABLE [dbo].[umbracoUserGroup2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUserGroup2NodePermission_umbracoNode_id] FOREIGN KEY([nodeId])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUserGroup2NodePermission] CHECK CONSTRAINT [FK_umbracoUserGroup2NodePermission_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUserGroup2NodePermission]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUserGroup2NodePermission_umbracoUserGroup_id] FOREIGN KEY([userGroupId])
REFERENCES [dbo].[umbracoUserGroup] ([id])
GO
ALTER TABLE [dbo].[umbracoUserGroup2NodePermission] CHECK CONSTRAINT [FK_umbracoUserGroup2NodePermission_umbracoUserGroup_id]
GO
ALTER TABLE [dbo].[umbracoUserLogin]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUserLogin_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUserLogin] CHECK CONSTRAINT [FK_umbracoUserLogin_umbracoUser_id]
GO
ALTER TABLE [dbo].[umbracoUserStartNode]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUserStartNode_umbracoNode_id] FOREIGN KEY([startNode])
REFERENCES [dbo].[umbracoNode] ([id])
GO
ALTER TABLE [dbo].[umbracoUserStartNode] CHECK CONSTRAINT [FK_umbracoUserStartNode_umbracoNode_id]
GO
ALTER TABLE [dbo].[umbracoUserStartNode]  WITH CHECK ADD  CONSTRAINT [FK_umbracoUserStartNode_umbracoUser_id] FOREIGN KEY([userId])
REFERENCES [dbo].[umbracoUser] ([id])
GO
ALTER TABLE [dbo].[umbracoUserStartNode] CHECK CONSTRAINT [FK_umbracoUserStartNode_umbracoUser_id]
GO
USE [master]
GO
ALTER DATABASE [umbraco-cms] SET  READ_WRITE 
GO
