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
    <xsl:text>如下问题有新的评论.</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>标题: </xsl:text><xsl:value-of select="Issue/Title" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>项目: </xsl:text><xsl:value-of select="Issue/ProjectName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>创建者: </xsl:text><xsl:value-of select="IssueComment/CreatorDisplayName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>日期: </xsl:text><xsl:value-of select="helpers:FormatShortDateAnd12HTime(IssueComment/DateCreated)" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>评论: </xsl:text><xsl:value-of select="helpers:StripHTML2(IssueComment/Comment)" />
      <xsl:text>&#10;</xsl:text>
      <xsl:text>&#10;</xsl:text>
      <xsl:text> 访问如下链接以获得更多信息 </xsl:text>
      <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
      <xsl:text>&#10;</xsl:text>
      <xsl:text>&#10;</xsl:text>
      如果不想继续收到该邮件, 请访问 <xsl:value-of select="HostSetting_DefaultUrl" />Account/UserProfile.aspx 并更改“通知”选项.
  </xsl:template>
</xsl:stylesheet>
