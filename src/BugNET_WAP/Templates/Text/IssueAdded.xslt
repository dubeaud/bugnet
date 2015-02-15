<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns="http://schemas.microsoft.com/intellisense/ie5"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:helpers="urn:xsl-helpers">

    <xsl:output omit-xml-declaration="yes" method="text" />
    <xsl:strip-space elements="*" />

    <xsl:template match="/root">
        <xsl:text>The following issue has been added to a project that you are monitoring.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Title: </xsl:text><xsl:value-of select="Issue/Title" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Project: </xsl:text><xsl:value-of select="Issue/ProjectName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Created By: </xsl:text> <xsl:value-of select="Issue/CreatorDisplayName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Milestone: </xsl:text><xsl:value-of select="Issue/MilestoneName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Category: </xsl:text><xsl:value-of select="Issue/CategoryName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Priority: </xsl:text> <xsl:value-of select="Issue/PriorityName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Type: </xsl:text><xsl:value-of select="Issue/IssueTypeName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Description: </xsl:text><xsl:value-of select="helpers:StripHTML2(Issue/Description)" />
        <xsl:text>&#10;</xsl:text>
		    <xsl:text>&#10;</xsl:text>
        <xsl:text> More information on this issue can be found at </xsl:text>
        <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        If you no longer wish to receive notifications, please visit <xsl:value-of select="HostSetting_DefaultUrl" />Account/UserProfile.aspx and change your notifications options.
    </xsl:template>
</xsl:stylesheet>
