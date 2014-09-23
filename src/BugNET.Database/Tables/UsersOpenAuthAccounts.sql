CREATE TABLE [dbo].[UsersOpenAuthAccounts]
(
	[ApplicationName] [nvarchar](128) NOT NULL,
	[ProviderName] [nvarchar](128) NOT NULL,
	[ProviderUserId] [nvarchar](128) NOT NULL,
	[ProviderUserName] [nvarchar](max) NOT NULL,
	[MembershipUserName] [nvarchar](128) NOT NULL,
	[LastUsedUtc] [datetime] NULL,
	PRIMARY KEY CLUSTERED (
		[ApplicationName] ASC,
		[ProviderName] ASC,
		[ProviderUserId] ASC
	) WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF),
	CONSTRAINT [OpenAuthUserData_Accounts] FOREIGN KEY([ApplicationName], [MembershipUserName])
	REFERENCES [dbo].[UsersOpenAuthData] ([ApplicationName], [MembershipUserName])
	ON DELETE CASCADE
)
