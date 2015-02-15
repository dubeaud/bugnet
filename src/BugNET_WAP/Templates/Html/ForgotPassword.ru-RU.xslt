<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns="http://schemas.microsoft.com/intellisense/ie5"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:msxsl="urn:schemas-microsoft-com:xslt"
  xmlns:helpers="urn:xsl-helpers">
    <xsl:output omit-xml-declaration="yes" method="html" />
    <xsl:strip-space elements="*" />
    <xsl:template match="/root">
        <p>
            Кто-то запросил сброс пароля для Вашей учетной записи в приложении <xsl:value-of select="HostSetting_ApplicationTitle" />.  Для сброса Вашего пароля пройдите по следующей ссылке:
        </p>
        <a href="{HostSetting_DefaultUrl}Account/PasswordReset.aspx?token={string}" target="_blank">
            <xsl:value-of select="HostSetting_DefaultUrl" />Account/PasswordReset.aspx?token=<xsl:value-of select="string" />
        </a>
        <p>Если Вы не запрашивали сброс пароля, то просто проигнорируйте данное письмо.</p>
        <p>
            Спасибо!
            <br/>
            <xsl:value-of select="HostSetting_ApplicationTitle" />
        </p>
    </xsl:template>
</xsl:stylesheet>
