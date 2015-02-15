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
        <xsl:text>В проект добавлено новое задание.</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Заголовок: </xsl:text><xsl:value-of select="Issue/Title" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Проект: </xsl:text><xsl:value-of select="Issue/ProjectName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Создатель: </xsl:text> <xsl:value-of select="Issue/CreatorDisplayName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Этап: </xsl:text><xsl:value-of select="Issue/MilestoneName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Категория: </xsl:text><xsl:value-of select="Issue/CategoryName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Приоритет: </xsl:text> <xsl:value-of select="Issue/PriorityName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Тип: </xsl:text><xsl:value-of select="Issue/IssueTypeName" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Описание: </xsl:text><xsl:value-of select="helpers:StripHTML2(Issue/Description)" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text> Для получения более подробной информации об этом задании пройдите по ссылке </xsl:text>
        <xsl:value-of select="HostSetting_DefaultUrl" />Issues/IssueDetail.aspx?id=<xsl:value-of select="Issue/Id" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        Если Вы больше не хотите получать данные уведомления, то посетите страницу Вашего профиля <xsl:value-of select="HostSetting_DefaultUrl" />Account/UserProfile.aspx и измените настройки уведомлений.
    </xsl:template>
</xsl:stylesheet>
