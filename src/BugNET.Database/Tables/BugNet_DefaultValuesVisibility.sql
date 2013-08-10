CREATE TABLE [dbo].[BugNet_DefaultValuesVisibility] (
    [ProjectId]                   INT NOT NULL,
    [StatusVisibility]            BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_StatusVisibility] DEFAULT ((1)) NOT NULL,
    [OwnedByVisibility]           BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_OwnedByVisibility] DEFAULT ((1)) NOT NULL,
    [PriorityVisibility]          BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PriorityVisibility] DEFAULT ((1)) NOT NULL,
    [AssignedToVisibility]        BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AssignedToVisibility] DEFAULT ((1)) NOT NULL,
    [PrivateVisibility]           BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PrivateVisibility] DEFAULT ((1)) NOT NULL,
    [CategoryVisibility]          BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_CategoryVisibility] DEFAULT ((1)) NOT NULL,
    [DueDateVisibility]           BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_DueDateVisibility] DEFAULT ((1)) NOT NULL,
    [TypeVisibility]              BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_TypeVisibility] DEFAULT ((1)) NOT NULL,
    [PercentCompleteVisibility]   BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_PercentCompleteVisibility] DEFAULT ((1)) NOT NULL,
    [MilestoneVisibility]         BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_MilestoneVisibility] DEFAULT ((1)) NOT NULL,
    [EstimationVisibility]        BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_EstimationVisibility] DEFAULT ((1)) NOT NULL,
    [ResolutionVisibility]        BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_ResolutionVisibility] DEFAULT ((1)) NOT NULL,
    [AffectedMilestoneVisibility] BIT CONSTRAINT [DF_Bugnet_DefaultValuesVisibility_AffectedMilestoneVisivility] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_Bugnet_DefaultValuesVisibility] PRIMARY KEY CLUSTERED ([ProjectId] ASC)
);

