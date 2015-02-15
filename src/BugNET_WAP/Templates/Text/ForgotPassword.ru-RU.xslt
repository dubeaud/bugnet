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
        <xsl:text>Кто-то запросил сброс пароля для Вашей учетной записи в приложении </xsl:text><xsl:value-of select="HostSetting_ApplicationTitle" />&#160;. Для сброса Вашего пароля пройдите по следующей ссылке:
        <xsl:value-of select="HostSetting_DefaultUrl" />Account/PasswordReset.aspx?token=<xsl:value-of select="string" />
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Если Вы не запрашивали сброс пароля, то просто проигнорируйте данное письмо. </xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>Спасибо!</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:value-of select="HostSetting_ApplicationTitle" />
    </xsl:template>
</xsl:stylesheet>
