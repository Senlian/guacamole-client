/**
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

USE [guac]
GO
/****** Object:  Schema [guacamole]    Script Date: 8/14/2017 9:41:31 PM ******/
CREATE SCHEMA [guacamole]
GO
/****** Object:  Rule [permission_list]    Script Date: 8/14/2017 9:41:31 PM ******/
CREATE RULE [guacamole].[permission_list] 
AS
@list IN ('READ','UPDATE','DELETE','ADMINISTER')
GO
/****** Object:  Rule [system_permission_list]    Script Date: 8/14/2017 9:41:31 PM ******/
CREATE RULE [guacamole].[system_permission_list] 
AS
@list IN ('CREATE_CONNECTION', 'CREATE_CONNECTION_GROUP', 'CREATE_SHARING_PROFILE', 'CREATE_USER', 'ADMINISTER')
GO
/****** Object:  UserDefinedDataType [guacamole].[permission]    Script Date: 8/14/2017 9:41:31 PM ******/
CREATE TYPE [guacamole].[permission] FROM [nvarchar](10) NOT NULL
GO
/****** Object:  UserDefinedDataType [guacamole].[system_permission]    Script Date: 8/14/2017 9:41:31 PM ******/
CREATE TYPE [guacamole].[system_permission] FROM [nvarchar](32) NOT NULL
GO
/****** Object:  Table [guacamole].[connection]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[connection](
	[connection_id] [int] IDENTITY(1,1) NOT NULL,
	[connection_name] [nvarchar](128) NOT NULL,
	[parent_id] [int] NULL,
	[protocol] [nvarchar](32) NOT NULL,
	[proxy_port] [int] NULL,
	[proxy_hostname] [nvarchar](512) NULL,
	[proxy_encryption_method] [nvarchar](4) NULL,
	[max_connections] [int] NULL,
	[max_connections_per_user] [int] NULL,
	[connection_weight] [int] NULL,
	[failover_only] [int] NOT NULL,
 CONSTRAINT [PK_connection] PRIMARY KEY CLUSTERED 
(
	[connection_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[connection_group]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[connection_group](
	[connection_group_id] [int] IDENTITY(1,1) NOT NULL,
	[parent_id] [int] NULL,
	[connection_group_name] [nvarchar](128) NOT NULL,
	[type] [nvarchar](32) NOT NULL,
	[max_connections] [int] NULL,
	[max_connections_per_user] [int] NULL,
	[enable_session_affinity] [int] NOT NULL,
 CONSTRAINT [PK_connection_group] PRIMARY KEY CLUSTERED 
(
	[connection_group_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[connection_group_permission]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[connection_group_permission](
	[user_id] [int] NOT NULL,
	[connection_group_id] [int] NOT NULL,
	[permission] [guacamole].[permission] NOT NULL,
 CONSTRAINT [PK_connection_group_permission] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[connection_group_id] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[connection_history]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[connection_history](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NULL,
	[username] [nvarchar](128) NOT NULL,
	[remote_host] [nvarchar](256) NULL,
	[connection_id] [int] NULL,
	[connection_name] [nvarchar](128) NOT NULL,
	[sharing_profile_id] [int] NULL,
	[sharing_profile_name] [nvarchar](128) NOT NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NULL,
 CONSTRAINT [PK_connection_history] PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[connection_parameter]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[connection_parameter](
	[connection_id] [int] NOT NULL,
	[parameter_name] [nvarchar](128) NOT NULL,
	[parameter_value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_connection_parameter] PRIMARY KEY CLUSTERED 
(
	[connection_id] ASC,
	[parameter_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[connection_permission]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[connection_permission](
	[user_id] [int] NOT NULL,
	[connection_id] [int] NOT NULL,
	[permission] [guacamole].[permission] NOT NULL,
 CONSTRAINT [PK_connection_permission] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[connection_id] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[sharing_profile]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[sharing_profile](
	[sharing_profile_id] [int] IDENTITY(1,1) NOT NULL,
	[sharing_profile_name] [nvarchar](128) NOT NULL,
	[primary_connection_id] [int] NOT NULL,
 CONSTRAINT [PK_sharing_profile] PRIMARY KEY CLUSTERED 
(
	[sharing_profile_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[sharing_profile_parameter]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[sharing_profile_parameter](
	[sharing_profile_id] [int] NOT NULL,
	[parameter_name] [nvarchar](128) NOT NULL,
	[parameter_value] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_sharing_profile_parameter] PRIMARY KEY CLUSTERED 
(
	[sharing_profile_id] ASC,
	[parameter_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[sharing_profile_permission]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[sharing_profile_permission](
	[user_id] [int] NOT NULL,
	[sharing_profile_id] [int] NOT NULL,
	[permission] [guacamole].[permission] NOT NULL,
 CONSTRAINT [PK_sharing_profile_permission] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[sharing_profile_id] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[system_permission]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[system_permission](
	[user_id] [int] NOT NULL,
	[permission] [guacamole].[system_permission] NOT NULL,
 CONSTRAINT [PK_system_permission] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[user]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[user](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](128) NOT NULL,
	[password_hash] [binary](32) NOT NULL,
	[password_salt] [binary](32) NULL,
	[password_date] [datetime] NOT NULL,
	[disabled] [int] NOT NULL,
	[expired] [int] NOT NULL,
	[access_window_start] [time](7) NULL,
	[access_window_end] [time](7) NULL,
	[valid_from] [date] NULL,
	[valid_until] [date] NULL,
	[timezone] [nvarchar](64) NULL,
	[full_name] [nvarchar](256) NULL,
	[email_address] [nvarchar](256) NULL,
	[organization] [nvarchar](256) NULL,
	[organizational_role] [nvarchar](256) NULL,
 CONSTRAINT [PK_user] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[user_password_history]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[user_password_history](
	[password_history_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[password_hash] [binary](32) NOT NULL,
	[password_salt] [binary](32) NULL,
	[password_date] [datetime] NOT NULL,
 CONSTRAINT [PK_user_password_history] PRIMARY KEY CLUSTERED 
(
	[password_history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [guacamole].[user_permission]    Script Date: 8/14/2017 9:41:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [guacamole].[user_permission](
	[user_id] [int] NOT NULL,
	[affected_user_id] [int] NOT NULL,
	[permission] [guacamole].[permission] NOT NULL,
 CONSTRAINT [PK_user_permission] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[affected_user_id] ASC,
	[permission] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [guacamole].[connection] ADD  CONSTRAINT [DF_connection_failover_only]  DEFAULT ((0)) FOR [failover_only]
GO
ALTER TABLE [guacamole].[connection_group] ADD  CONSTRAINT [DF_connection_group_type]  DEFAULT (N'ORGANIZATIONAL') FOR [type]
GO
ALTER TABLE [guacamole].[connection_group] ADD  CONSTRAINT [DF_connection_group_enable_session_affinity]  DEFAULT ((0)) FOR [enable_session_affinity]
GO
ALTER TABLE [guacamole].[connection]  WITH CHECK ADD  CONSTRAINT [FK_connection_connection_group] FOREIGN KEY([parent_id])
REFERENCES [guacamole].[connection_group] ([connection_group_id])
GO
ALTER TABLE [guacamole].[connection] CHECK CONSTRAINT [FK_connection_connection_group]
GO
ALTER TABLE [guacamole].[connection_group]  WITH CHECK ADD  CONSTRAINT [FK_connection_group_connection_group] FOREIGN KEY([parent_id])
REFERENCES [guacamole].[connection_group] ([connection_group_id])
GO
ALTER TABLE [guacamole].[connection_group] CHECK CONSTRAINT [FK_connection_group_connection_group]
GO
ALTER TABLE [guacamole].[connection_group_permission]  WITH CHECK ADD  CONSTRAINT [FK_connection_group_permission_connection_group] FOREIGN KEY([connection_group_id])
REFERENCES [guacamole].[connection_group] ([connection_group_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[connection_group_permission] CHECK CONSTRAINT [FK_connection_group_permission_connection_group]
GO
ALTER TABLE [guacamole].[connection_group_permission]  WITH CHECK ADD  CONSTRAINT [FK_connection_group_permission_user] FOREIGN KEY([user_id])
REFERENCES [guacamole].[user] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[connection_group_permission] CHECK CONSTRAINT [FK_connection_group_permission_user]
GO
ALTER TABLE [guacamole].[connection_history]  WITH CHECK ADD  CONSTRAINT [FK_connection_history_connection] FOREIGN KEY([connection_id])
REFERENCES [guacamole].[connection] ([connection_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [guacamole].[connection_history] CHECK CONSTRAINT [FK_connection_history_connection]
GO
ALTER TABLE [guacamole].[connection_history]  WITH CHECK ADD  CONSTRAINT [FK_connection_history_sharing_profile] FOREIGN KEY([sharing_profile_id])
REFERENCES [guacamole].[sharing_profile] ([sharing_profile_id])
GO
ALTER TABLE [guacamole].[connection_history] CHECK CONSTRAINT [FK_connection_history_sharing_profile]
GO
ALTER TABLE [guacamole].[connection_history]  WITH CHECK ADD  CONSTRAINT [FK_connection_history_user] FOREIGN KEY([user_id])
REFERENCES [guacamole].[user] ([user_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [guacamole].[connection_history] CHECK CONSTRAINT [FK_connection_history_user]
GO
ALTER TABLE [guacamole].[connection_parameter]  WITH CHECK ADD  CONSTRAINT [FK_connection_parameter_connection] FOREIGN KEY([connection_id])
REFERENCES [guacamole].[connection] ([connection_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[connection_parameter] CHECK CONSTRAINT [FK_connection_parameter_connection]
GO
ALTER TABLE [guacamole].[connection_permission]  WITH CHECK ADD  CONSTRAINT [FK_connection_permission_connection1] FOREIGN KEY([connection_id])
REFERENCES [guacamole].[connection] ([connection_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[connection_permission] CHECK CONSTRAINT [FK_connection_permission_connection1]
GO
ALTER TABLE [guacamole].[connection_permission]  WITH CHECK ADD  CONSTRAINT [FK_connection_permission_user1] FOREIGN KEY([user_id])
REFERENCES [guacamole].[user] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[connection_permission] CHECK CONSTRAINT [FK_connection_permission_user1]
GO
ALTER TABLE [guacamole].[sharing_profile]  WITH CHECK ADD  CONSTRAINT [FK_sharing_profile_connection] FOREIGN KEY([primary_connection_id])
REFERENCES [guacamole].[connection] ([connection_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[sharing_profile] CHECK CONSTRAINT [FK_sharing_profile_connection]
GO
ALTER TABLE [guacamole].[sharing_profile_parameter]  WITH CHECK ADD  CONSTRAINT [FK_sharing_profile_parameter_sharing_profile] FOREIGN KEY([sharing_profile_id])
REFERENCES [guacamole].[sharing_profile] ([sharing_profile_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[sharing_profile_parameter] CHECK CONSTRAINT [FK_sharing_profile_parameter_sharing_profile]
GO
ALTER TABLE [guacamole].[sharing_profile_permission]  WITH CHECK ADD  CONSTRAINT [FK_sharing_profile_permission_sharing_profile] FOREIGN KEY([sharing_profile_id])
REFERENCES [guacamole].[sharing_profile] ([sharing_profile_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[sharing_profile_permission] CHECK CONSTRAINT [FK_sharing_profile_permission_sharing_profile]
GO
ALTER TABLE [guacamole].[sharing_profile_permission]  WITH CHECK ADD  CONSTRAINT [FK_sharing_profile_permission_user] FOREIGN KEY([user_id])
REFERENCES [guacamole].[user] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[sharing_profile_permission] CHECK CONSTRAINT [FK_sharing_profile_permission_user]
GO
ALTER TABLE [guacamole].[system_permission]  WITH CHECK ADD  CONSTRAINT [FK_system_permission_user] FOREIGN KEY([user_id])
REFERENCES [guacamole].[user] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[system_permission] CHECK CONSTRAINT [FK_system_permission_user]
GO
ALTER TABLE [guacamole].[user_password_history]  WITH CHECK ADD  CONSTRAINT [FK_user_password_history_user] FOREIGN KEY([user_id])
REFERENCES [guacamole].[user] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[user_password_history] CHECK CONSTRAINT [FK_user_password_history_user]
GO
ALTER TABLE [guacamole].[user_permission]  WITH CHECK ADD  CONSTRAINT [FK_user_permission_user] FOREIGN KEY([user_id])
REFERENCES [guacamole].[user] ([user_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [guacamole].[user_permission] CHECK CONSTRAINT [FK_user_permission_user]
GO
ALTER TABLE [guacamole].[user_permission]  WITH CHECK ADD  CONSTRAINT [FK_user_permission_user1] FOREIGN KEY([affected_user_id])
REFERENCES [guacamole].[user] ([user_id])
GO
ALTER TABLE [guacamole].[user_permission] CHECK CONSTRAINT [FK_user_permission_user1]
GO
ALTER TABLE [guacamole].[connection]  WITH CHECK ADD  CONSTRAINT [CK_proxy_encryption_method] CHECK  (([proxy_encryption_method]='SSL' OR [proxy_encryption_method]='NONE'))
GO
ALTER TABLE [guacamole].[connection] CHECK CONSTRAINT [CK_proxy_encryption_method]
GO
ALTER TABLE [guacamole].[connection_group]  WITH CHECK ADD  CONSTRAINT [CK_connection_group_type] CHECK  (([type]='BALANCING' OR [type]='ORGANIZATIONAL'))
GO
ALTER TABLE [guacamole].[connection_group] CHECK CONSTRAINT [CK_connection_group_type]
GO
