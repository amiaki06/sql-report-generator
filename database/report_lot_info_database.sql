IF DB_ID('FormDesign') IS NOT NULL
BEGIN
    ALTER DATABASE [FormDesign] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [FormDesign];
END
GO

CREATE DATABASE [FormDesign]
GO

USE [FormDesign]
GO

CREATE SCHEMA [UserForm]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[PersianDate] (@date DATETIME)
RETURNS VARCHAR(24)
AS
BEGIN
    DECLARE @gy INT, @gm INT, @gd INT;
    DECLARE @jy INT, @jm INT, @jd INT;
    DECLARE @g_d_m INT;
    DECLARE @day_no INT;
    DECLARE @time VARCHAR(20) = '';

    IF (CAST(SQL_VARIANT_PROPERTY(@date, 'BaseType') AS VARCHAR(100)) <> 'date')
        SET @time = ' ' + CAST(CONVERT(TIME, @date) AS VARCHAR(12));

    SELECT @gy = YEAR(@date), @gm = MONTH(@date), @gd = DAY(@date);

    IF @gm > 2 
        SET @g_d_m = (275 * @gm) / 9 - ((@gm + 9) / 12) * (1 + ((@gy % 4 + 2) / 3)) + @gd - 30;
    ELSE
        SET @g_d_m = (275 * @gm) / 9 + @gd - 30;

    SET @day_no = 365 * (@gy - 1600) + (@gy - 1600) / 4 - (@gy - 1600) / 100 + (@gy - 1600) / 400 + @g_d_m - 79;
    SET @jy = 979 + (33 * (@day_no / 12053));
    SET @day_no = @day_no % 12053;
    SET @jy = @jy + 4 * (@day_no / 1461);
    SET @day_no = @day_no % 1461;

    IF @day_no >= 366
    BEGIN
        SET @jy = @jy + (@day_no - 1) / 365;
        SET @day_no = (@day_no - 1) % 365;
    END;

    IF @day_no < 186
    BEGIN
        SET @jm = 1 + @day_no / 31;
        SET @jd = 1 + @day_no % 31;
    END
    ELSE
    BEGIN
        SET @jm = 7 + (@day_no - 186) / 30;
        SET @jd = 1 + (@day_no - 186) % 30;
    END;

    RETURN FORMAT(@jy, '0000') + '-' + FORMAT(@jm, '00') + '-' + FORMAT(@jd, '00') + @time;
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_SubUserCreatedForm_29](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldTitleID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldRow] [int] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_26] [decimal](30, 0) NULL,
	[fldColumn_27] [decimal](30, 0) NULL,
	[fldColumn_4] [nvarchar](50) NULL,
	[fldColumn_25] [nvarchar](50) NULL,
	[fldColumn_12] [nvarchar](max) NULL,
	[fldColumn_10] [decimal](30, 2) NULL,
	[fldColumn_16] [nvarchar](1000) NULL,
	[fldColumn_15] [nvarchar](max) NULL,
	[fldColumn_8] [decimal](30, 2) NULL,
	[fldColumn_11] [nvarchar](max) NULL,
	[fldColumn_3] [nvarchar](50) NULL,
	[fldColumn_9] [decimal](30, 2) NULL,
	[fldColumn_14] [decimal](30, 2) NULL,
	[fldColumn_24] [nvarchar](50) NULL,
	[fldColumn_22] [nvarchar](50) NULL,
	[fldColumn_19] [nvarchar](50) NULL,
	[fldColumn_6] [nvarchar](50) NULL,
	[fldColumn_17] [decimal](30, 2) NULL,
	[fldColumn_13] [bit] NULL,
	[fldColumn_21] [nvarchar](50) NULL,
	[fldColumn_7] [nvarchar](50) NULL,
	[fldColumn_2] [nvarchar](max) NULL,
	[fldColumn_5] [nvarchar](50) NULL,
	[fldColumn_18] [nvarchar](50) NULL,
	[fldColumn_23] [nvarchar](50) NULL,
	[fldColumn_1] [nvarchar](50) NULL,
	[fldColumn_20] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
CREATE TABLE [UserForm].[tbl_UserCreatedForm_1](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_2] [nvarchar](1000) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_1] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_10](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_2] [nvarchar](100) NULL,
	[fldColumn_5] [nvarchar](250) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_4] [nvarchar](150) NULL,
	[fldColumn_3] [decimal](30, 0) NULL,
	[fldColumn_8] [nvarchar](100) NULL,
	[fldColumn_10] [nvarchar](100) NULL,
	[fldColumn_6] [nvarchar](550) NULL,
	[fldColumn_7] [nvarchar](100) NULL,
	[fldColumn_9] [nvarchar](200) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_10] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_11](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_5] [nvarchar](500) NULL,
	[fldColumn_6] [nvarchar](500) NULL,
	[fldColumn_2] [nvarchar](500) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [nvarchar](500) NULL,
	[fldColumn_4] [nvarchar](300) NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_11] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_12](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_6] [nvarchar](500) NULL,
	[fldColumn_5] [nvarchar](500) NULL,
	[fldColumn_4] [nvarchar](500) NULL,
	[fldColumn_8] [nvarchar](500) NULL,
	[fldColumn_7] [nvarchar](500) NULL,
	[fldColumn_9] [nvarchar](500) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_10] [nvarchar](500) NULL,
	[fldColumn_3] [nvarchar](500) NULL,
	[fldColumn_2] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_12] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_13](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_4] [nvarchar](500) NULL,
	[fldColumn_5] [nvarchar](500) NULL,
	[fldColumn_2] [nvarchar](500) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [nvarchar](500) NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_13] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_14](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [nvarchar](500) NULL,
	[fldColumn_4] [nvarchar](500) NULL,
	[fldColumn_2] [nvarchar](500) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_14] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_15](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_9] [nvarchar](500) NULL,
	[fldColumn_5] [nvarchar](500) NULL,
	[fldColumn_3] [nvarchar](500) NULL,
	[fldColumn_8] [decimal](30, 0) NULL,
	[fldColumn_10] [nvarchar](500) NULL,
	[fldColumn_4] [nvarchar](500) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](500) NULL,
	[fldColumn_7] [nvarchar](500) NULL,
	[fldColumn_6] [decimal](30, 0) NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_15] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_16](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_2] [nvarchar](300) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_16] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_17](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](300) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_17] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_18](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](300) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_18] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_19](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](250) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_19] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_2](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [nvarchar](500) NULL,
	[fldColumn_4] [nvarchar](300) NULL,
	[fldColumn_2] [nvarchar](1000) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_2] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_20](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](300) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_20] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_21](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_2] [nvarchar](350) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [decimal](30, 2) NULL,
	[fldColumn_4] [decimal](30, 2) NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_21] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_22](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [nvarchar](300) NULL,
	[fldColumn_2] [nvarchar](300) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_22] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_23](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_4] [nvarchar](200) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [nvarchar](250) NULL,
	[fldColumn_2] [nvarchar](350) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_23] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_24](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [nvarchar](200) NULL,
	[fldColumn_2] [nvarchar](200) NULL,
	[fldColumn_4] [nvarchar](150) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_24] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_25](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [nvarchar](250) NULL,
	[fldColumn_2] [nvarchar](350) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_25] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_26](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_3] [nvarchar](150) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](300) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_26] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_27](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](100) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_27] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_28](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_34] [nvarchar](50) NULL,
	[fldColumn_28] [nvarchar](500) NULL,
	[fldColumn_59] [nvarchar](50) NULL,
	[fldColumn_57] [nvarchar](50) NULL,
	[fldColumn_52] [nvarchar](100) NULL,
	[fldColumn_29] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](50) NULL,
	[fldColumn_9] [nvarchar](max) NULL,
	[fldColumn_60] [nvarchar](50) NULL,
	[fldColumn_32] [nvarchar](50) NULL,
	[fldColumn_6] [nvarchar](1000) NOT NULL,
	[fldColumn_41] [datetime] NULL,
	[fldColumn_16] [bit] NULL,
	[fldColumn_37] [nvarchar](500) NULL,
	[fldColumn_26] [nvarchar](50) NULL,
	[fldColumn_8] [nvarchar](max) NULL,
	[fldColumn_36] [datetime] NULL,
	[fldColumn_44] [datetime] NULL,
	[fldColumn_19] [decimal](30, 0) NULL,
	[fldColumn_38] [decimal](30, 0) NULL,
	[fldColumn_31] [decimal](30, 0) NULL,
	[fldColumn_64] [decimal](30, 0) NULL,
	[fldColumn_56] [nvarchar](50) NULL,
	[fldColumn_58] [decimal](30, 0) NULL,
	[fldColumn_13] [nvarchar](50) NULL,
	[fldColumn_53] [nvarchar](50) NULL,
	[fldColumn_11] [datetime] NULL,
	[fldColumn_14] [bit] NULL,
	[fldColumn_39] [bit] NULL,
	[fldColumn_23] [nvarchar](50) NULL,
	[fldColumn_40] [decimal](30, 0) NULL,
	[fldColumn_49] [decimal](30, 2) NULL,
	[fldColumn_62] [decimal](30, 0) NULL,
	[fldColumn_63] [decimal](30, 0) NULL,
	[fldColumn_43] [bit] NULL,
	[fldColumn_61] [nvarchar](500) NULL,
	[fldColumn_15] [bit] NULL,
	[fldColumn_5] [nvarchar](max) NULL,
	[fldColumn_3] [decimal](30, 0) NULL,
	[fldColumn_22] [nvarchar](50) NULL,
	[fldColumn_24] [nvarchar](50) NULL,
	[fldColumn_18] [datetime] NULL,
	[fldColumn_46] [nvarchar](500) NULL,
	[fldColumn_35] [nvarchar](500) NULL,
	[fldColumn_48] [decimal](30, 2) NULL,
	[fldColumn_54] [nvarchar](50) NULL,
	[fldColumn_30] [decimal](30, 0) NULL,
	[fldColumn_51] [nvarchar](100) NULL,
	[fldColumn_33] [decimal](30, 0) NULL,
	[fldColumn_50] [nvarchar](100) NULL,
	[fldColumn_21] [nvarchar](max) NULL,
	[fldColumn_55] [nvarchar](50) NULL,
	[fldColumn_27] [nvarchar](50) NULL,
	[fldColumn_1] [nvarchar](500) NOT NULL,
	[fldColumn_10] [bit] NULL,
	[fldColumn_4] [nvarchar](50) NULL,
	[fldColumn_12] [nvarchar](50) NULL,
	[fldColumn_17] [datetime] NULL,
	[fldColumn_25] [nvarchar](500) NULL,
	[fldColumn_45] [datetime] NULL,
	[fldColumn_42] [bit] NULL,
	[fldColumn_7] [decimal](30, 2) NULL,
	[fldColumn_20] [datetime] NULL,
	[fldColumn_47] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_28] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_29](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_19] [nvarchar](500) NULL,
	[fldColumn_6] [nvarchar](500) NULL,
	[fldColumn_3] [nvarchar](50) NOT NULL,
	[fldColumn_35] [nvarchar](3000) NULL,
	[fldColumn_34] [nvarchar](3000) NULL,
	[fldColumn_42] [nvarchar](500) NULL,
	[fldColumn_16] [nvarchar](500) NULL,
	[fldColumn_17] [nvarchar](500) NULL,
	[fldColumn_5] [nvarchar](500) NULL,
	[fldColumn_41] [nvarchar](100) NULL,
	[fldColumn_31] [nvarchar](500) NULL,
	[fldColumn_4] [decimal](30, 0) NULL,
	[fldColumn_37] [nvarchar](max) NULL,
	[fldColumn_7] [nvarchar](500) NULL,
	[fldColumn_25] [datetime] NULL,
	[fldColumn_29] [nvarchar](500) NULL,
	[fldColumn_24] [bit] NULL,
	[fldColumn_40] [nvarchar](100) NULL,
	[fldColumn_15] [nvarchar](500) NULL,
	[fldColumn_12] [bit] NULL,
	[fldColumn_10] [nvarchar](500) NULL,
	[fldColumn_28] [nvarchar](500) NULL,
	[fldColumn_9] [nvarchar](500) NULL,
	[fldColumn_20] [nvarchar](500) NULL,
	[fldColumn_2] [datetime] NULL,
	[fldColumn_23] [nvarchar](500) NULL,
	[fldColumn_32] [nvarchar](500) NULL,
	[fldColumn_43] [decimal](30, 0) NULL,
	[fldColumn_8] [nvarchar](500) NULL,
	[fldColumn_30] [nvarchar](500) NULL,
	[fldColumn_27] [datetime] NULL,
	[fldColumn_21] [bit] NULL,
	[fldColumn_14] [datetime] NULL,
	[fldColumn_38] [nvarchar](max) NULL,
	[fldColumn_1] [bit] NULL,
	[fldColumn_36] [nvarchar](3000) NULL,
	[fldColumn_33] [nvarchar](500) NULL,
	[fldColumn_13] [datetime] NULL,
	[fldColumn_26] [nvarchar](50) NULL,
	[fldColumn_18] [nvarchar](500) NULL,
	[fldColumn_22] [datetime] NULL,
	[fldColumn_11] [bit] NULL,
	[fldColumn_39] [nvarchar](max) NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_29] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_3](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](200) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_3] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_30](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_2] [nvarchar](175) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_30] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_31](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_4] [decimal](30, 0) NULL,
	[fldColumn_7] [nvarchar](100) NULL,
	[fldColumn_8] [nvarchar](200) NULL,
	[fldColumn_6] [nvarchar](100) NULL,
	[fldColumn_9] [nvarchar](100) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_3] [nvarchar](100) NULL,
	[fldColumn_5] [nvarchar](550) NULL,
	[fldColumn_2] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_31] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_32](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_32] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_33](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_7] [datetime] NULL,
	[fldColumn_29] [nvarchar](500) NULL,
	[fldColumn_13] [nvarchar](500) NULL,
	[fldColumn_11] [nvarchar](150) NULL,
	[fldColumn_25] [nvarchar](500) NULL,
	[fldColumn_22] [decimal](30, 2) NULL,
	[fldColumn_28] [decimal](30, 2) NULL,
	[fldColumn_35] [datetime] NULL,
	[fldColumn_36] [bit] NULL,
	[fldColumn_32] [nvarchar](1000) NULL,
	[fldColumn_12] [nvarchar](500) NULL,
	[fldColumn_8] [nvarchar](500) NULL,
	[fldColumn_20] [nvarchar](50) NULL,
	[fldColumn_19] [nvarchar](50) NULL,
	[fldColumn_3] [nvarchar](500) NULL,
	[fldColumn_16] [nvarchar](500) NULL,
	[fldColumn_34] [nvarchar](500) NULL,
	[fldColumn_24] [decimal](30, 0) NULL,
	[fldColumn_5] [nvarchar](500) NULL,
	[fldColumn_27] [nvarchar](50) NULL,
	[fldColumn_33] [bit] NULL,
	[fldColumn_9] [nvarchar](500) NULL,
	[fldColumn_15] [nvarchar](500) NULL,
	[fldColumn_31] [nvarchar](500) NULL,
	[fldColumn_26] [nvarchar](500) NULL,
	[fldColumn_21] [nvarchar](500) NULL,
	[fldColumn_4] [nvarchar](500) NULL,
	[fldColumn_23] [decimal](30, 0) NULL,
	[fldColumn_10] [nvarchar](50) NULL,
	[fldColumn_18] [nvarchar](500) NULL,
	[fldColumn_6] [nvarchar](500) NULL,
	[fldColumn_14] [nvarchar](500) NULL,
	[fldColumn_1] [nvarchar](100) NOT NULL,
	[fldColumn_17] [nvarchar](500) NULL,
	[fldColumn_30] [datetime] NULL,
	[fldColumn_2] [nvarchar](1000) NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_33] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_4](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](100) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_4] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_5](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_2] [nvarchar](50) NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_5] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_6](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](150) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_6] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_7](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [nvarchar](50) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_7] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_8](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_3] [bit] NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_2] [decimal](30, 0) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_8] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [UserForm].[tbl_UserCreatedForm_9](
	[fldID] [uniqueidentifier] NOT NULL,
	[fldUserID] [uniqueidentifier] NOT NULL,
	[fldActiveYearID] [uniqueidentifier] NOT NULL,
	[fldCompanyID] [uniqueidentifier] NOT NULL,
	[fldDate] [datetime] NOT NULL,
	[fldColumn_1] [decimal](30, 0) NULL,
	[fldColumn_6] [nvarchar](150) NULL,
	[fldColumn_5] [nvarchar](100) NULL,
	[fldColumn_3] [nvarchar](500) NULL,
	[fldColumn_4] [nvarchar](100) NULL,
	[fldColumn_2] [nvarchar](100) NULL,
	[fldSubkeyGroupReletionID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tbl_UserCreatedForm_9] PRIMARY KEY CLUSTERED 
(
	[fldID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [UserForm].[tbl_UserCreatedForm_1]  ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_10] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_14] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_16] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_17] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_18] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_19] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_2]  ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_20] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_22] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_23] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_24] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_25] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_26] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_27] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_3]  ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_30] ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_4]  ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_5]  ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_6]  ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_7]  ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_8]  ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
ALTER TABLE [UserForm].[tbl_UserCreatedForm_9]  ADD DEFAULT (CONVERT(UNIQUEIDENTIFIER, CONVERT(BINARY, (0)))) FOR [fldSubkeyGroupReletionID]
GO
