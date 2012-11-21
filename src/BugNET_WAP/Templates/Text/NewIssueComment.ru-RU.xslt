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
    <xsl:text>В следующее задание был добавлен новый комментарий.</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Название: </xsl:text><xsl:value-of select="Issue/Title" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Проект: </xsl:text><xsl:value-of select="Issue/ProjectName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Автор: </xsl:text><xsl:value-of select="IssueComment/CreatorDisplayName" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Дата: </xsl:text><xsl:value-of select="helpers:FormatShortDateAnd12HTime(IssueComment/DateCreated)" />
    <xsl:text>&#10;</xsl:text>
    <xsl:text>Комментарий: </xsl:text><xsl:value-of select="helpers:StripHTML2(IssueComment/Comment)" />
      <xsl:text>&#10;</xsl:text>
      <xsl:text>&#10;</xsl:text>
      <xsl:text> Больше информации по данному заданию можно найти по ссылке </xsl:text>
      <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
      <xsl:text>&#10;</xsl:text>
      <xsl:text>&#10;</xsl:text>
      Если Вы больше не хотите получать уведомления, то пройдите по ссылке <xsl:value-of select="HostSetting_DefaultUrl" />Account/UserProfile.aspx и измените настройки уведомлений.
  </xsl:template>
</xsl:stylesheet>
